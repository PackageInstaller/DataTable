return {
	Play1104701001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1104701001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1104701002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST05a"

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
				local var_4_5 = arg_1_1.bgs_.ST05a

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
					if iter_4_0 ~= "ST05a" then
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

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_143", "se_story_143_amb_club", "")
			end

			local var_4_28 = 1
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

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
			local var_4_35 = 0.625

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

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(1104701001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 25
				local var_4_41 = utf8.len(var_4_39)
				local var_4_42 = var_4_40 <= 0 and var_4_35 or var_4_35 * (var_4_41 / var_4_40)

				if var_4_42 > 0 and var_4_35 < var_4_42 then
					arg_1_1.talkMaxDuration = var_4_42
					var_4_34 = var_4_34 + 0.3

					if var_4_42 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_39
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_43 = var_4_34 + 0.3
			local var_4_44 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_43 <= arg_1_1.time_ and arg_1_1.time_ < var_4_43 + var_4_44 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_43) / var_4_44

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_43 + var_4_44 and arg_1_1.time_ < var_4_43 + var_4_44 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1104701002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1104701002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1104701003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.allBtn_.enabled = false
			end

			local var_11_1 = 0.3

			if arg_8_1.time_ >= var_11_0 + var_11_1 and arg_8_1.time_ < var_11_0 + var_11_1 + arg_11_0 then
				arg_8_1.allBtn_.enabled = true
			end

			local var_11_2 = 0.2
			local var_11_3 = 1

			if var_11_2 < arg_8_1.time_ and arg_8_1.time_ <= var_11_2 + arg_11_0 then
				local var_11_4 = "play"
				local var_11_5 = "effect"

				arg_8_1:AudioAction(var_11_4, var_11_5, "se_story_130", "se_story_130_paper", "")
			end

			local var_11_6 = 0
			local var_11_7 = 1.425

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_8 = arg_8_1:GetWordFromCfg(1104701002)
				local var_11_9 = arg_8_1:FormatText(var_11_8.content)

				arg_8_1.text_.text = var_11_9

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_10 = 57
				local var_11_11 = utf8.len(var_11_9)
				local var_11_12 = var_11_10 <= 0 and var_11_7 or var_11_7 * (var_11_11 / var_11_10)

				if var_11_12 > 0 and var_11_7 < var_11_12 then
					arg_8_1.talkMaxDuration = var_11_12

					if var_11_12 + var_11_6 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_12 + var_11_6
					end
				end

				arg_8_1.text_.text = var_11_9
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_13 = math.max(var_11_7, arg_8_1.talkMaxDuration)

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_13 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_6) / var_11_13

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_6 + var_11_13 and arg_8_1.time_ < var_11_6 + var_11_13 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play1104701003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1104701003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1104701004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			local var_15_1 = 0.3

			if arg_12_1.time_ >= var_15_0 + var_15_1 and arg_12_1.time_ < var_15_0 + var_15_1 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			local var_15_2 = 0
			local var_15_3 = 1.325

			if var_15_2 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_4 = arg_12_1:GetWordFromCfg(1104701003)
				local var_15_5 = arg_12_1:FormatText(var_15_4.content)

				arg_12_1.text_.text = var_15_5

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_6 = 53
				local var_15_7 = utf8.len(var_15_5)
				local var_15_8 = var_15_6 <= 0 and var_15_3 or var_15_3 * (var_15_7 / var_15_6)

				if var_15_8 > 0 and var_15_3 < var_15_8 then
					arg_12_1.talkMaxDuration = var_15_8

					if var_15_8 + var_15_2 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_2
					end
				end

				arg_12_1.text_.text = var_15_5
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_9 = math.max(var_15_3, arg_12_1.talkMaxDuration)

			if var_15_2 <= arg_12_1.time_ and arg_12_1.time_ < var_15_2 + var_15_9 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_2) / var_15_9

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_2 + var_15_9 and arg_12_1.time_ < var_15_2 + var_15_9 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play1104701004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1104701004
		arg_16_1.duration_ = 3.67

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1104701005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.allBtn_.enabled = false
			end

			local var_19_1 = 0.3

			if arg_16_1.time_ >= var_19_0 + var_19_1 and arg_16_1.time_ < var_19_0 + var_19_1 + arg_19_0 then
				arg_16_1.allBtn_.enabled = true
			end

			local var_19_2 = 0.1
			local var_19_3 = 1

			if var_19_2 < arg_16_1.time_ and arg_16_1.time_ <= var_19_2 + arg_19_0 then
				local var_19_4 = "play"
				local var_19_5 = "effect"

				arg_16_1:AudioAction(var_19_4, var_19_5, "se_story_side_128402", "se_story_side_128402_cup", "")
			end

			local var_19_6 = 0
			local var_19_7 = 0.55

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_8 = arg_16_1:FormatText(StoryNameCfg[331].name)

				arg_16_1.leftNameTxt_.text = var_19_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_9 = arg_16_1:GetWordFromCfg(1104701004)
				local var_19_10 = arg_16_1:FormatText(var_19_9.content)

				arg_16_1.text_.text = var_19_10

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_11 = 22
				local var_19_12 = utf8.len(var_19_10)
				local var_19_13 = var_19_11 <= 0 and var_19_7 or var_19_7 * (var_19_12 / var_19_11)

				if var_19_13 > 0 and var_19_7 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_6
					end
				end

				arg_16_1.text_.text = var_19_10
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701004", "story_v_side_new_1104701.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701004", "story_v_side_new_1104701.awb") / 1000

					if var_19_14 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_6
					end

					if var_19_9.prefab_name ~= "" and arg_16_1.actors_[var_19_9.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_9.prefab_name].transform, "story_v_side_new_1104701", "1104701004", "story_v_side_new_1104701.awb")

						arg_16_1:RecordAudio("1104701004", var_19_15)
						arg_16_1:RecordAudio("1104701004", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701004", "story_v_side_new_1104701.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701004", "story_v_side_new_1104701.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_16 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_16 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_16

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_16 and arg_16_1.time_ < var_19_6 + var_19_16 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play1104701005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1104701005
		arg_20_1.duration_ = 7.2

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play1104701006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			local var_23_1 = 0.3

			if arg_20_1.time_ >= var_23_0 + var_23_1 and arg_20_1.time_ < var_23_0 + var_23_1 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			local var_23_2 = 0
			local var_23_3 = 0.875

			if var_23_2 < arg_20_1.time_ and arg_20_1.time_ <= var_23_2 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_4 = arg_20_1:FormatText(StoryNameCfg[331].name)

				arg_20_1.leftNameTxt_.text = var_23_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_5 = arg_20_1:GetWordFromCfg(1104701005)
				local var_23_6 = arg_20_1:FormatText(var_23_5.content)

				arg_20_1.text_.text = var_23_6

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_7 = 35
				local var_23_8 = utf8.len(var_23_6)
				local var_23_9 = var_23_7 <= 0 and var_23_3 or var_23_3 * (var_23_8 / var_23_7)

				if var_23_9 > 0 and var_23_3 < var_23_9 then
					arg_20_1.talkMaxDuration = var_23_9

					if var_23_9 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_2
					end
				end

				arg_20_1.text_.text = var_23_6
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701005", "story_v_side_new_1104701.awb") ~= 0 then
					local var_23_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701005", "story_v_side_new_1104701.awb") / 1000

					if var_23_10 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_10 + var_23_2
					end

					if var_23_5.prefab_name ~= "" and arg_20_1.actors_[var_23_5.prefab_name] ~= nil then
						local var_23_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_5.prefab_name].transform, "story_v_side_new_1104701", "1104701005", "story_v_side_new_1104701.awb")

						arg_20_1:RecordAudio("1104701005", var_23_11)
						arg_20_1:RecordAudio("1104701005", var_23_11)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701005", "story_v_side_new_1104701.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701005", "story_v_side_new_1104701.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_12 = math.max(var_23_3, arg_20_1.talkMaxDuration)

			if var_23_2 <= arg_20_1.time_ and arg_20_1.time_ < var_23_2 + var_23_12 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_2) / var_23_12

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_2 + var_23_12 and arg_20_1.time_ < var_23_2 + var_23_12 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play1104701006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 1104701006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play1104701007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.allBtn_.enabled = false
			end

			local var_27_1 = 0.3

			if arg_24_1.time_ >= var_27_0 + var_27_1 and arg_24_1.time_ < var_27_0 + var_27_1 + arg_27_0 then
				arg_24_1.allBtn_.enabled = true
			end

			local var_27_2 = 0
			local var_27_3 = 0.05

			if var_27_2 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_4 = arg_24_1:FormatText(StoryNameCfg[7].name)

				arg_24_1.leftNameTxt_.text = var_27_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_5 = arg_24_1:GetWordFromCfg(1104701006)
				local var_27_6 = arg_24_1:FormatText(var_27_5.content)

				arg_24_1.text_.text = var_27_6

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_7 = 2
				local var_27_8 = utf8.len(var_27_6)
				local var_27_9 = var_27_7 <= 0 and var_27_3 or var_27_3 * (var_27_8 / var_27_7)

				if var_27_9 > 0 and var_27_3 < var_27_9 then
					arg_24_1.talkMaxDuration = var_27_9

					if var_27_9 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_2
					end
				end

				arg_24_1.text_.text = var_27_6
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_3, arg_24_1.talkMaxDuration)

			if var_27_2 <= arg_24_1.time_ and arg_24_1.time_ < var_27_2 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_2) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_2 + var_27_10 and arg_24_1.time_ < var_27_2 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play1104701007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 1104701007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play1104701008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.allBtn_.enabled = false
			end

			local var_31_1 = 0.3

			if arg_28_1.time_ >= var_31_0 + var_31_1 and arg_28_1.time_ < var_31_0 + var_31_1 + arg_31_0 then
				arg_28_1.allBtn_.enabled = true
			end

			local var_31_2 = 0
			local var_31_3 = 0.8

			if var_31_2 < arg_28_1.time_ and arg_28_1.time_ <= var_31_2 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_4 = arg_28_1:GetWordFromCfg(1104701007)
				local var_31_5 = arg_28_1:FormatText(var_31_4.content)

				arg_28_1.text_.text = var_31_5

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_6 = 32
				local var_31_7 = utf8.len(var_31_5)
				local var_31_8 = var_31_6 <= 0 and var_31_3 or var_31_3 * (var_31_7 / var_31_6)

				if var_31_8 > 0 and var_31_3 < var_31_8 then
					arg_28_1.talkMaxDuration = var_31_8

					if var_31_8 + var_31_2 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_2
					end
				end

				arg_28_1.text_.text = var_31_5
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_9 = math.max(var_31_3, arg_28_1.talkMaxDuration)

			if var_31_2 <= arg_28_1.time_ and arg_28_1.time_ < var_31_2 + var_31_9 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_2) / var_31_9

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_2 + var_31_9 and arg_28_1.time_ < var_31_2 + var_31_9 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play1104701008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 1104701008
		arg_32_1.duration_ = 1

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"

			SetActive(arg_32_1.choicesGo_, true)

			for iter_33_0, iter_33_1 in ipairs(arg_32_1.choices_) do
				local var_33_0 = iter_33_0 <= 2

				SetActive(iter_33_1.go, var_33_0)
			end

			arg_32_1.choices_[1].txt.text = arg_32_1:FormatText(StoryChoiceCfg[1649].name)
			arg_32_1.choices_[2].txt.text = arg_32_1:FormatText(StoryChoiceCfg[1650].name)
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play1104701009(arg_32_1)
			end

			if arg_34_0 == 2 then
				arg_32_0:Play1104701009(arg_32_1)
			end

			arg_32_1:RecordChoiceLog(1104701008, 1649, 1650)
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.allBtn_.enabled = false
			end

			local var_35_1 = 0.3

			if arg_32_1.time_ >= var_35_0 + var_35_1 and arg_32_1.time_ < var_35_0 + var_35_1 + arg_35_0 then
				arg_32_1.allBtn_.enabled = true
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play1104701009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1104701009
		arg_36_1.duration_ = 2.97

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play1104701010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = "1047ui_story"

			if arg_36_1.actors_[var_39_0] == nil then
				local var_39_1 = Asset.Load("Char/" .. "1047ui_story")

				if not isNil(var_39_1) then
					local var_39_2 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_36_1.stage_.transform)

					var_39_2.name = var_39_0
					var_39_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_36_1.actors_[var_39_0] = var_39_2

					local var_39_3 = var_39_2:GetComponentInChildren(typeof(CharacterEffect))

					var_39_3.enabled = true

					local var_39_4 = GameObjectTools.GetOrAddComponent(var_39_2, typeof(DynamicBoneHelper))

					if var_39_4 then
						var_39_4:EnableDynamicBone(false)
					end

					arg_36_1:ShowWeapon(var_39_3.transform, false)

					arg_36_1.var_[var_39_0 .. "Animator"] = var_39_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_36_1.var_[var_39_0 .. "Animator"].applyRootMotion = true
					arg_36_1.var_[var_39_0 .. "LipSync"] = var_39_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_39_5 = arg_36_1.actors_["1047ui_story"].transform
			local var_39_6 = 0

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.var_.moveOldPos1047ui_story = var_39_5.localPosition
			end

			local var_39_7 = 0.001

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_7 then
				local var_39_8 = (arg_36_1.time_ - var_39_6) / var_39_7
				local var_39_9 = Vector3.New(0, -1.13, -6.2)

				var_39_5.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1047ui_story, var_39_9, var_39_8)

				local var_39_10 = manager.ui.mainCamera.transform.position - var_39_5.position

				var_39_5.forward = Vector3.New(var_39_10.x, var_39_10.y, var_39_10.z)

				local var_39_11 = var_39_5.localEulerAngles

				var_39_11.z = 0
				var_39_11.x = 0
				var_39_5.localEulerAngles = var_39_11
			end

			if arg_36_1.time_ >= var_39_6 + var_39_7 and arg_36_1.time_ < var_39_6 + var_39_7 + arg_39_0 then
				var_39_5.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_39_12 = manager.ui.mainCamera.transform.position - var_39_5.position

				var_39_5.forward = Vector3.New(var_39_12.x, var_39_12.y, var_39_12.z)

				local var_39_13 = var_39_5.localEulerAngles

				var_39_13.z = 0
				var_39_13.x = 0
				var_39_5.localEulerAngles = var_39_13
			end

			local var_39_14 = arg_36_1.actors_["1047ui_story"]
			local var_39_15 = 0

			if var_39_15 < arg_36_1.time_ and arg_36_1.time_ <= var_39_15 + arg_39_0 and not isNil(var_39_14) and arg_36_1.var_.characterEffect1047ui_story == nil then
				arg_36_1.var_.characterEffect1047ui_story = var_39_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_16 = 0.200000002980232

			if var_39_15 <= arg_36_1.time_ and arg_36_1.time_ < var_39_15 + var_39_16 and not isNil(var_39_14) then
				local var_39_17 = (arg_36_1.time_ - var_39_15) / var_39_16

				if arg_36_1.var_.characterEffect1047ui_story and not isNil(var_39_14) then
					arg_36_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_15 + var_39_16 and arg_36_1.time_ < var_39_15 + var_39_16 + arg_39_0 and not isNil(var_39_14) and arg_36_1.var_.characterEffect1047ui_story then
				arg_36_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_39_18 = "1047ui_story"

			if arg_36_1.actors_[var_39_18] == nil then
				local var_39_19 = Asset.Load("Char/" .. "1047ui_story")

				if not isNil(var_39_19) then
					local var_39_20 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_36_1.stage_.transform)

					var_39_20.name = var_39_18
					var_39_20.transform.localPosition = Vector3.New(0, 100, 0)
					arg_36_1.actors_[var_39_18] = var_39_20

					local var_39_21 = var_39_20:GetComponentInChildren(typeof(CharacterEffect))

					var_39_21.enabled = true

					local var_39_22 = GameObjectTools.GetOrAddComponent(var_39_20, typeof(DynamicBoneHelper))

					if var_39_22 then
						var_39_22:EnableDynamicBone(false)
					end

					arg_36_1:ShowWeapon(var_39_21.transform, false)

					arg_36_1.var_[var_39_18 .. "Animator"] = var_39_21.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_36_1.var_[var_39_18 .. "Animator"].applyRootMotion = true
					arg_36_1.var_[var_39_18 .. "LipSync"] = var_39_21.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_39_23 = 0

			if var_39_23 < arg_36_1.time_ and arg_36_1.time_ <= var_39_23 + arg_39_0 then
				arg_36_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_39_24 = "1047ui_story"

			if arg_36_1.actors_[var_39_24] == nil then
				local var_39_25 = Asset.Load("Char/" .. "1047ui_story")

				if not isNil(var_39_25) then
					local var_39_26 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_36_1.stage_.transform)

					var_39_26.name = var_39_24
					var_39_26.transform.localPosition = Vector3.New(0, 100, 0)
					arg_36_1.actors_[var_39_24] = var_39_26

					local var_39_27 = var_39_26:GetComponentInChildren(typeof(CharacterEffect))

					var_39_27.enabled = true

					local var_39_28 = GameObjectTools.GetOrAddComponent(var_39_26, typeof(DynamicBoneHelper))

					if var_39_28 then
						var_39_28:EnableDynamicBone(false)
					end

					arg_36_1:ShowWeapon(var_39_27.transform, false)

					arg_36_1.var_[var_39_24 .. "Animator"] = var_39_27.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_36_1.var_[var_39_24 .. "Animator"].applyRootMotion = true
					arg_36_1.var_[var_39_24 .. "LipSync"] = var_39_27.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_39_29 = 0

			if var_39_29 < arg_36_1.time_ and arg_36_1.time_ <= var_39_29 + arg_39_0 then
				arg_36_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileD", "EmotionTimelineAnimator")
			end

			local var_39_30 = 0

			if var_39_30 < arg_36_1.time_ and arg_36_1.time_ <= var_39_30 + arg_39_0 then
				arg_36_1.allBtn_.enabled = false
			end

			local var_39_31 = 0.3

			if arg_36_1.time_ >= var_39_30 + var_39_31 and arg_36_1.time_ < var_39_30 + var_39_31 + arg_39_0 then
				arg_36_1.allBtn_.enabled = true
			end

			local var_39_32 = 0
			local var_39_33 = 0.425

			if var_39_32 < arg_36_1.time_ and arg_36_1.time_ <= var_39_32 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_34 = arg_36_1:FormatText(StoryNameCfg[1296].name)

				arg_36_1.leftNameTxt_.text = var_39_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_35 = arg_36_1:GetWordFromCfg(1104701009)
				local var_39_36 = arg_36_1:FormatText(var_39_35.content)

				arg_36_1.text_.text = var_39_36

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_37 = 17
				local var_39_38 = utf8.len(var_39_36)
				local var_39_39 = var_39_37 <= 0 and var_39_33 or var_39_33 * (var_39_38 / var_39_37)

				if var_39_39 > 0 and var_39_33 < var_39_39 then
					arg_36_1.talkMaxDuration = var_39_39

					if var_39_39 + var_39_32 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_39 + var_39_32
					end
				end

				arg_36_1.text_.text = var_39_36
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701009", "story_v_side_new_1104701.awb") ~= 0 then
					local var_39_40 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701009", "story_v_side_new_1104701.awb") / 1000

					if var_39_40 + var_39_32 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_40 + var_39_32
					end

					if var_39_35.prefab_name ~= "" and arg_36_1.actors_[var_39_35.prefab_name] ~= nil then
						local var_39_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_35.prefab_name].transform, "story_v_side_new_1104701", "1104701009", "story_v_side_new_1104701.awb")

						arg_36_1:RecordAudio("1104701009", var_39_41)
						arg_36_1:RecordAudio("1104701009", var_39_41)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701009", "story_v_side_new_1104701.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701009", "story_v_side_new_1104701.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_42 = math.max(var_39_33, arg_36_1.talkMaxDuration)

			if var_39_32 <= arg_36_1.time_ and arg_36_1.time_ < var_39_32 + var_39_42 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_32) / var_39_42

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_32 + var_39_42 and arg_36_1.time_ < var_39_32 + var_39_42 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play1104701010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1104701010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play1104701011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1047ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1047ui_story == nil then
				arg_40_1.var_.characterEffect1047ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1047ui_story and not isNil(var_43_0) then
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1047ui_story.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1047ui_story then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1047ui_story.fillRatio = var_43_5
			end

			local var_43_6 = arg_40_1.actors_["1047ui_story"].transform
			local var_43_7 = 0

			if var_43_7 < arg_40_1.time_ and arg_40_1.time_ <= var_43_7 + arg_43_0 then
				arg_40_1.var_.moveOldPos1047ui_story = var_43_6.localPosition
			end

			local var_43_8 = 0.001

			if var_43_7 <= arg_40_1.time_ and arg_40_1.time_ < var_43_7 + var_43_8 then
				local var_43_9 = (arg_40_1.time_ - var_43_7) / var_43_8
				local var_43_10 = Vector3.New(0, 100, 0)

				var_43_6.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1047ui_story, var_43_10, var_43_9)

				local var_43_11 = manager.ui.mainCamera.transform.position - var_43_6.position

				var_43_6.forward = Vector3.New(var_43_11.x, var_43_11.y, var_43_11.z)

				local var_43_12 = var_43_6.localEulerAngles

				var_43_12.z = 0
				var_43_12.x = 0
				var_43_6.localEulerAngles = var_43_12
			end

			if arg_40_1.time_ >= var_43_7 + var_43_8 and arg_40_1.time_ < var_43_7 + var_43_8 + arg_43_0 then
				var_43_6.localPosition = Vector3.New(0, 100, 0)

				local var_43_13 = manager.ui.mainCamera.transform.position - var_43_6.position

				var_43_6.forward = Vector3.New(var_43_13.x, var_43_13.y, var_43_13.z)

				local var_43_14 = var_43_6.localEulerAngles

				var_43_14.z = 0
				var_43_14.x = 0
				var_43_6.localEulerAngles = var_43_14
			end

			local var_43_15 = 0

			if var_43_15 < arg_40_1.time_ and arg_40_1.time_ <= var_43_15 + arg_43_0 then
				arg_40_1.allBtn_.enabled = false
			end

			local var_43_16 = 0.133333333333333

			if arg_40_1.time_ >= var_43_15 + var_43_16 and arg_40_1.time_ < var_43_15 + var_43_16 + arg_43_0 then
				arg_40_1.allBtn_.enabled = true
			end

			local var_43_17 = 0.1
			local var_43_18 = 1

			if var_43_17 < arg_40_1.time_ and arg_40_1.time_ <= var_43_17 + arg_43_0 then
				local var_43_19 = "play"
				local var_43_20 = "effect"

				arg_40_1:AudioAction(var_43_19, var_43_20, "se_story_140", "se_story_140_snap", "")
			end

			local var_43_21 = 0
			local var_43_22 = 1.35

			if var_43_21 < arg_40_1.time_ and arg_40_1.time_ <= var_43_21 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_23 = arg_40_1:GetWordFromCfg(1104701010)
				local var_43_24 = arg_40_1:FormatText(var_43_23.content)

				arg_40_1.text_.text = var_43_24

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_25 = 54
				local var_43_26 = utf8.len(var_43_24)
				local var_43_27 = var_43_25 <= 0 and var_43_22 or var_43_22 * (var_43_26 / var_43_25)

				if var_43_27 > 0 and var_43_22 < var_43_27 then
					arg_40_1.talkMaxDuration = var_43_27

					if var_43_27 + var_43_21 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_27 + var_43_21
					end
				end

				arg_40_1.text_.text = var_43_24
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_28 = math.max(var_43_22, arg_40_1.talkMaxDuration)

			if var_43_21 <= arg_40_1.time_ and arg_40_1.time_ < var_43_21 + var_43_28 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_21) / var_43_28

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_21 + var_43_28 and arg_40_1.time_ < var_43_21 + var_43_28 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play1104701011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 1104701011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play1104701012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.allBtn_.enabled = false
			end

			local var_47_1 = 0.3

			if arg_44_1.time_ >= var_47_0 + var_47_1 and arg_44_1.time_ < var_47_0 + var_47_1 + arg_47_0 then
				arg_44_1.allBtn_.enabled = true
			end

			local var_47_2 = 0
			local var_47_3 = 0.625

			if var_47_2 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_4 = arg_44_1:FormatText(StoryNameCfg[7].name)

				arg_44_1.leftNameTxt_.text = var_47_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_5 = arg_44_1:GetWordFromCfg(1104701011)
				local var_47_6 = arg_44_1:FormatText(var_47_5.content)

				arg_44_1.text_.text = var_47_6

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_7 = 25
				local var_47_8 = utf8.len(var_47_6)
				local var_47_9 = var_47_7 <= 0 and var_47_3 or var_47_3 * (var_47_8 / var_47_7)

				if var_47_9 > 0 and var_47_3 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_2
					end
				end

				arg_44_1.text_.text = var_47_6
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_3, arg_44_1.talkMaxDuration)

			if var_47_2 <= arg_44_1.time_ and arg_44_1.time_ < var_47_2 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_2) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_2 + var_47_10 and arg_44_1.time_ < var_47_2 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play1104701012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1104701012
		arg_48_1.duration_ = 8.27

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play1104701013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1047ui_story"].transform
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.var_.moveOldPos1047ui_story = var_51_0.localPosition
			end

			local var_51_2 = 0.001

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2
				local var_51_4 = Vector3.New(0, -1.13, -6.2)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1047ui_story, var_51_4, var_51_3)

				local var_51_5 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_5.x, var_51_5.y, var_51_5.z)

				local var_51_6 = var_51_0.localEulerAngles

				var_51_6.z = 0
				var_51_6.x = 0
				var_51_0.localEulerAngles = var_51_6
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 then
				var_51_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_51_7 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_7.x, var_51_7.y, var_51_7.z)

				local var_51_8 = var_51_0.localEulerAngles

				var_51_8.z = 0
				var_51_8.x = 0
				var_51_0.localEulerAngles = var_51_8
			end

			local var_51_9 = arg_48_1.actors_["1047ui_story"]
			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect1047ui_story == nil then
				arg_48_1.var_.characterEffect1047ui_story = var_51_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_11 = 0.200000002980232

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_11 and not isNil(var_51_9) then
				local var_51_12 = (arg_48_1.time_ - var_51_10) / var_51_11

				if arg_48_1.var_.characterEffect1047ui_story and not isNil(var_51_9) then
					arg_48_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_10 + var_51_11 and arg_48_1.time_ < var_51_10 + var_51_11 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect1047ui_story then
				arg_48_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_51_13 = 0

			if var_51_13 < arg_48_1.time_ and arg_48_1.time_ <= var_51_13 + arg_51_0 then
				arg_48_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			local var_51_14 = 0

			if var_51_14 < arg_48_1.time_ and arg_48_1.time_ <= var_51_14 + arg_51_0 then
				arg_48_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_51_15 = 0

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 then
				arg_48_1.allBtn_.enabled = false
			end

			local var_51_16 = 0.3

			if arg_48_1.time_ >= var_51_15 + var_51_16 and arg_48_1.time_ < var_51_15 + var_51_16 + arg_51_0 then
				arg_48_1.allBtn_.enabled = true
			end

			local var_51_17 = 0
			local var_51_18 = 0.875

			if var_51_17 < arg_48_1.time_ and arg_48_1.time_ <= var_51_17 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_19 = arg_48_1:FormatText(StoryNameCfg[1296].name)

				arg_48_1.leftNameTxt_.text = var_51_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_20 = arg_48_1:GetWordFromCfg(1104701012)
				local var_51_21 = arg_48_1:FormatText(var_51_20.content)

				arg_48_1.text_.text = var_51_21

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_22 = 35
				local var_51_23 = utf8.len(var_51_21)
				local var_51_24 = var_51_22 <= 0 and var_51_18 or var_51_18 * (var_51_23 / var_51_22)

				if var_51_24 > 0 and var_51_18 < var_51_24 then
					arg_48_1.talkMaxDuration = var_51_24

					if var_51_24 + var_51_17 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_24 + var_51_17
					end
				end

				arg_48_1.text_.text = var_51_21
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701012", "story_v_side_new_1104701.awb") ~= 0 then
					local var_51_25 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701012", "story_v_side_new_1104701.awb") / 1000

					if var_51_25 + var_51_17 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_25 + var_51_17
					end

					if var_51_20.prefab_name ~= "" and arg_48_1.actors_[var_51_20.prefab_name] ~= nil then
						local var_51_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_20.prefab_name].transform, "story_v_side_new_1104701", "1104701012", "story_v_side_new_1104701.awb")

						arg_48_1:RecordAudio("1104701012", var_51_26)
						arg_48_1:RecordAudio("1104701012", var_51_26)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701012", "story_v_side_new_1104701.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701012", "story_v_side_new_1104701.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_27 = math.max(var_51_18, arg_48_1.talkMaxDuration)

			if var_51_17 <= arg_48_1.time_ and arg_48_1.time_ < var_51_17 + var_51_27 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_17) / var_51_27

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_17 + var_51_27 and arg_48_1.time_ < var_51_17 + var_51_27 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play1104701013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1104701013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play1104701014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1047ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1047ui_story == nil then
				arg_52_1.var_.characterEffect1047ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1047ui_story and not isNil(var_55_0) then
					local var_55_4 = Mathf.Lerp(0, 0.5, var_55_3)

					arg_52_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1047ui_story.fillRatio = var_55_4
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1047ui_story then
				local var_55_5 = 0.5

				arg_52_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1047ui_story.fillRatio = var_55_5
			end

			local var_55_6 = 0

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.allBtn_.enabled = false
			end

			local var_55_7 = 0.3

			if arg_52_1.time_ >= var_55_6 + var_55_7 and arg_52_1.time_ < var_55_6 + var_55_7 + arg_55_0 then
				arg_52_1.allBtn_.enabled = true
			end

			local var_55_8 = 0
			local var_55_9 = 0.4

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

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_11 = arg_52_1:GetWordFromCfg(1104701013)
				local var_55_12 = arg_52_1:FormatText(var_55_11.content)

				arg_52_1.text_.text = var_55_12

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_13 = 16
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
	Play1104701014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 1104701014
		arg_56_1.duration_ = 6.53

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play1104701015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1047ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1047ui_story == nil then
				arg_56_1.var_.characterEffect1047ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1047ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1047ui_story then
				arg_56_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_59_4 = 0

			if var_59_4 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action434")
			end

			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 then
				arg_56_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_59_6 = 0

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.allBtn_.enabled = false
			end

			local var_59_7 = 0.3

			if arg_56_1.time_ >= var_59_6 + var_59_7 and arg_56_1.time_ < var_59_6 + var_59_7 + arg_59_0 then
				arg_56_1.allBtn_.enabled = true
			end

			local var_59_8 = 0
			local var_59_9 = 0.825

			if var_59_8 < arg_56_1.time_ and arg_56_1.time_ <= var_59_8 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_10 = arg_56_1:FormatText(StoryNameCfg[1296].name)

				arg_56_1.leftNameTxt_.text = var_59_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_11 = arg_56_1:GetWordFromCfg(1104701014)
				local var_59_12 = arg_56_1:FormatText(var_59_11.content)

				arg_56_1.text_.text = var_59_12

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_13 = 33
				local var_59_14 = utf8.len(var_59_12)
				local var_59_15 = var_59_13 <= 0 and var_59_9 or var_59_9 * (var_59_14 / var_59_13)

				if var_59_15 > 0 and var_59_9 < var_59_15 then
					arg_56_1.talkMaxDuration = var_59_15

					if var_59_15 + var_59_8 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_15 + var_59_8
					end
				end

				arg_56_1.text_.text = var_59_12
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701014", "story_v_side_new_1104701.awb") ~= 0 then
					local var_59_16 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701014", "story_v_side_new_1104701.awb") / 1000

					if var_59_16 + var_59_8 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_16 + var_59_8
					end

					if var_59_11.prefab_name ~= "" and arg_56_1.actors_[var_59_11.prefab_name] ~= nil then
						local var_59_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_11.prefab_name].transform, "story_v_side_new_1104701", "1104701014", "story_v_side_new_1104701.awb")

						arg_56_1:RecordAudio("1104701014", var_59_17)
						arg_56_1:RecordAudio("1104701014", var_59_17)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701014", "story_v_side_new_1104701.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701014", "story_v_side_new_1104701.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_18 = math.max(var_59_9, arg_56_1.talkMaxDuration)

			if var_59_8 <= arg_56_1.time_ and arg_56_1.time_ < var_59_8 + var_59_18 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_8) / var_59_18

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_8 + var_59_18 and arg_56_1.time_ < var_59_8 + var_59_18 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play1104701015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 1104701015
		arg_60_1.duration_ = 5.73

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play1104701016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_63_2 = 0

			if var_63_2 < arg_60_1.time_ and arg_60_1.time_ <= var_63_2 + arg_63_0 then
				arg_60_1.allBtn_.enabled = false
			end

			local var_63_3 = 0.3

			if arg_60_1.time_ >= var_63_2 + var_63_3 and arg_60_1.time_ < var_63_2 + var_63_3 + arg_63_0 then
				arg_60_1.allBtn_.enabled = true
			end

			local var_63_4 = 0
			local var_63_5 = 0.65

			if var_63_4 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_6 = arg_60_1:FormatText(StoryNameCfg[1296].name)

				arg_60_1.leftNameTxt_.text = var_63_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_7 = arg_60_1:GetWordFromCfg(1104701015)
				local var_63_8 = arg_60_1:FormatText(var_63_7.content)

				arg_60_1.text_.text = var_63_8

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 26
				local var_63_10 = utf8.len(var_63_8)
				local var_63_11 = var_63_9 <= 0 and var_63_5 or var_63_5 * (var_63_10 / var_63_9)

				if var_63_11 > 0 and var_63_5 < var_63_11 then
					arg_60_1.talkMaxDuration = var_63_11

					if var_63_11 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_11 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_8
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701015", "story_v_side_new_1104701.awb") ~= 0 then
					local var_63_12 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701015", "story_v_side_new_1104701.awb") / 1000

					if var_63_12 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_12 + var_63_4
					end

					if var_63_7.prefab_name ~= "" and arg_60_1.actors_[var_63_7.prefab_name] ~= nil then
						local var_63_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_7.prefab_name].transform, "story_v_side_new_1104701", "1104701015", "story_v_side_new_1104701.awb")

						arg_60_1:RecordAudio("1104701015", var_63_13)
						arg_60_1:RecordAudio("1104701015", var_63_13)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701015", "story_v_side_new_1104701.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701015", "story_v_side_new_1104701.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_14 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_14 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_14

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_14 and arg_60_1.time_ < var_63_4 + var_63_14 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play1104701016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 1104701016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play1104701017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1047ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1047ui_story == nil then
				arg_64_1.var_.characterEffect1047ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1047ui_story and not isNil(var_67_0) then
					local var_67_4 = Mathf.Lerp(0, 0.5, var_67_3)

					arg_64_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1047ui_story.fillRatio = var_67_4
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1047ui_story then
				local var_67_5 = 0.5

				arg_64_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1047ui_story.fillRatio = var_67_5
			end

			local var_67_6 = 0
			local var_67_7 = 0.45

			if var_67_6 < arg_64_1.time_ and arg_64_1.time_ <= var_67_6 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_8 = arg_64_1:FormatText(StoryNameCfg[7].name)

				arg_64_1.leftNameTxt_.text = var_67_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_9 = arg_64_1:GetWordFromCfg(1104701016)
				local var_67_10 = arg_64_1:FormatText(var_67_9.content)

				arg_64_1.text_.text = var_67_10

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_11 = 18
				local var_67_12 = utf8.len(var_67_10)
				local var_67_13 = var_67_11 <= 0 and var_67_7 or var_67_7 * (var_67_12 / var_67_11)

				if var_67_13 > 0 and var_67_7 < var_67_13 then
					arg_64_1.talkMaxDuration = var_67_13

					if var_67_13 + var_67_6 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_13 + var_67_6
					end
				end

				arg_64_1.text_.text = var_67_10
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_14 = math.max(var_67_7, arg_64_1.talkMaxDuration)

			if var_67_6 <= arg_64_1.time_ and arg_64_1.time_ < var_67_6 + var_67_14 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_6) / var_67_14

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_6 + var_67_14 and arg_64_1.time_ < var_67_6 + var_67_14 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play1104701017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 1104701017
		arg_68_1.duration_ = 3.6

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play1104701018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1047ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1047ui_story == nil then
				arg_68_1.var_.characterEffect1047ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.200000002980232

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect1047ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1047ui_story then
				arg_68_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_71_4 = 0

			if var_71_4 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 then
				arg_68_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_71_6 = 0
			local var_71_7 = 0.4

			if var_71_6 < arg_68_1.time_ and arg_68_1.time_ <= var_71_6 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_8 = arg_68_1:FormatText(StoryNameCfg[1296].name)

				arg_68_1.leftNameTxt_.text = var_71_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_9 = arg_68_1:GetWordFromCfg(1104701017)
				local var_71_10 = arg_68_1:FormatText(var_71_9.content)

				arg_68_1.text_.text = var_71_10

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_11 = 16
				local var_71_12 = utf8.len(var_71_10)
				local var_71_13 = var_71_11 <= 0 and var_71_7 or var_71_7 * (var_71_12 / var_71_11)

				if var_71_13 > 0 and var_71_7 < var_71_13 then
					arg_68_1.talkMaxDuration = var_71_13

					if var_71_13 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_13 + var_71_6
					end
				end

				arg_68_1.text_.text = var_71_10
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701017", "story_v_side_new_1104701.awb") ~= 0 then
					local var_71_14 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701017", "story_v_side_new_1104701.awb") / 1000

					if var_71_14 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_14 + var_71_6
					end

					if var_71_9.prefab_name ~= "" and arg_68_1.actors_[var_71_9.prefab_name] ~= nil then
						local var_71_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_9.prefab_name].transform, "story_v_side_new_1104701", "1104701017", "story_v_side_new_1104701.awb")

						arg_68_1:RecordAudio("1104701017", var_71_15)
						arg_68_1:RecordAudio("1104701017", var_71_15)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701017", "story_v_side_new_1104701.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701017", "story_v_side_new_1104701.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_16 = math.max(var_71_7, arg_68_1.talkMaxDuration)

			if var_71_6 <= arg_68_1.time_ and arg_68_1.time_ < var_71_6 + var_71_16 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_6) / var_71_16

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_6 + var_71_16 and arg_68_1.time_ < var_71_6 + var_71_16 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play1104701018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 1104701018
		arg_72_1.duration_ = 7.57

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play1104701019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_75_2 = 0
			local var_75_3 = 0.875

			if var_75_2 < arg_72_1.time_ and arg_72_1.time_ <= var_75_2 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_4 = arg_72_1:FormatText(StoryNameCfg[1296].name)

				arg_72_1.leftNameTxt_.text = var_75_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_5 = arg_72_1:GetWordFromCfg(1104701018)
				local var_75_6 = arg_72_1:FormatText(var_75_5.content)

				arg_72_1.text_.text = var_75_6

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_7 = 35
				local var_75_8 = utf8.len(var_75_6)
				local var_75_9 = var_75_7 <= 0 and var_75_3 or var_75_3 * (var_75_8 / var_75_7)

				if var_75_9 > 0 and var_75_3 < var_75_9 then
					arg_72_1.talkMaxDuration = var_75_9

					if var_75_9 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_9 + var_75_2
					end
				end

				arg_72_1.text_.text = var_75_6
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701018", "story_v_side_new_1104701.awb") ~= 0 then
					local var_75_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701018", "story_v_side_new_1104701.awb") / 1000

					if var_75_10 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_10 + var_75_2
					end

					if var_75_5.prefab_name ~= "" and arg_72_1.actors_[var_75_5.prefab_name] ~= nil then
						local var_75_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_5.prefab_name].transform, "story_v_side_new_1104701", "1104701018", "story_v_side_new_1104701.awb")

						arg_72_1:RecordAudio("1104701018", var_75_11)
						arg_72_1:RecordAudio("1104701018", var_75_11)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701018", "story_v_side_new_1104701.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701018", "story_v_side_new_1104701.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_12 = math.max(var_75_3, arg_72_1.talkMaxDuration)

			if var_75_2 <= arg_72_1.time_ and arg_72_1.time_ < var_75_2 + var_75_12 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_2) / var_75_12

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_2 + var_75_12 and arg_72_1.time_ < var_75_2 + var_75_12 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play1104701019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 1104701019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play1104701020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1047ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1047ui_story == nil then
				arg_76_1.var_.characterEffect1047ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect1047ui_story and not isNil(var_79_0) then
					local var_79_4 = Mathf.Lerp(0, 0.5, var_79_3)

					arg_76_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1047ui_story.fillRatio = var_79_4
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1047ui_story then
				local var_79_5 = 0.5

				arg_76_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1047ui_story.fillRatio = var_79_5
			end

			local var_79_6 = 0
			local var_79_7 = 0.625

			if var_79_6 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_8 = arg_76_1:FormatText(StoryNameCfg[7].name)

				arg_76_1.leftNameTxt_.text = var_79_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_9 = arg_76_1:GetWordFromCfg(1104701019)
				local var_79_10 = arg_76_1:FormatText(var_79_9.content)

				arg_76_1.text_.text = var_79_10

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 25
				local var_79_12 = utf8.len(var_79_10)
				local var_79_13 = var_79_11 <= 0 and var_79_7 or var_79_7 * (var_79_12 / var_79_11)

				if var_79_13 > 0 and var_79_7 < var_79_13 then
					arg_76_1.talkMaxDuration = var_79_13

					if var_79_13 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_13 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_10
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_14 = math.max(var_79_7, arg_76_1.talkMaxDuration)

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_14 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_6) / var_79_14

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_6 + var_79_14 and arg_76_1.time_ < var_79_6 + var_79_14 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play1104701020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 1104701020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play1104701021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1047ui_story"].transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos1047ui_story = var_83_0.localPosition
			end

			local var_83_2 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2
				local var_83_4 = Vector3.New(0, 100, 0)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1047ui_story, var_83_4, var_83_3)

				local var_83_5 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_5.x, var_83_5.y, var_83_5.z)

				local var_83_6 = var_83_0.localEulerAngles

				var_83_6.z = 0
				var_83_6.x = 0
				var_83_0.localEulerAngles = var_83_6
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(0, 100, 0)

				local var_83_7 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_7.x, var_83_7.y, var_83_7.z)

				local var_83_8 = var_83_0.localEulerAngles

				var_83_8.z = 0
				var_83_8.x = 0
				var_83_0.localEulerAngles = var_83_8
			end

			local var_83_9 = 0.2
			local var_83_10 = 1

			if var_83_9 < arg_80_1.time_ and arg_80_1.time_ <= var_83_9 + arg_83_0 then
				local var_83_11 = "play"
				local var_83_12 = "effect"

				arg_80_1:AudioAction(var_83_11, var_83_12, "se_story_140", "se_story_140_glasses", "")
			end

			local var_83_13 = 0
			local var_83_14 = 0.8

			if var_83_13 < arg_80_1.time_ and arg_80_1.time_ <= var_83_13 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_15 = arg_80_1:GetWordFromCfg(1104701020)
				local var_83_16 = arg_80_1:FormatText(var_83_15.content)

				arg_80_1.text_.text = var_83_16

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_17 = 32
				local var_83_18 = utf8.len(var_83_16)
				local var_83_19 = var_83_17 <= 0 and var_83_14 or var_83_14 * (var_83_18 / var_83_17)

				if var_83_19 > 0 and var_83_14 < var_83_19 then
					arg_80_1.talkMaxDuration = var_83_19

					if var_83_19 + var_83_13 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_19 + var_83_13
					end
				end

				arg_80_1.text_.text = var_83_16
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_20 = math.max(var_83_14, arg_80_1.talkMaxDuration)

			if var_83_13 <= arg_80_1.time_ and arg_80_1.time_ < var_83_13 + var_83_20 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_13) / var_83_20

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_13 + var_83_20 and arg_80_1.time_ < var_83_13 + var_83_20 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play1104701021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 1104701021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play1104701022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 0.8

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_2 = arg_84_1:GetWordFromCfg(1104701021)
				local var_87_3 = arg_84_1:FormatText(var_87_2.content)

				arg_84_1.text_.text = var_87_3

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_4 = 32
				local var_87_5 = utf8.len(var_87_3)
				local var_87_6 = var_87_4 <= 0 and var_87_1 or var_87_1 * (var_87_5 / var_87_4)

				if var_87_6 > 0 and var_87_1 < var_87_6 then
					arg_84_1.talkMaxDuration = var_87_6

					if var_87_6 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_6 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_3
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_7 and arg_84_1.time_ < var_87_0 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play1104701022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 1104701022
		arg_88_1.duration_ = 13.8

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play1104701023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1047ui_story"].transform
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.var_.moveOldPos1047ui_story = var_91_0.localPosition
			end

			local var_91_2 = 0.001

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2
				local var_91_4 = Vector3.New(0, -1.13, -6.2)

				var_91_0.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1047ui_story, var_91_4, var_91_3)

				local var_91_5 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_5.x, var_91_5.y, var_91_5.z)

				local var_91_6 = var_91_0.localEulerAngles

				var_91_6.z = 0
				var_91_6.x = 0
				var_91_0.localEulerAngles = var_91_6
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 then
				var_91_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_91_7 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_7.x, var_91_7.y, var_91_7.z)

				local var_91_8 = var_91_0.localEulerAngles

				var_91_8.z = 0
				var_91_8.x = 0
				var_91_0.localEulerAngles = var_91_8
			end

			local var_91_9 = arg_88_1.actors_["1047ui_story"]
			local var_91_10 = 0

			if var_91_10 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 and not isNil(var_91_9) and arg_88_1.var_.characterEffect1047ui_story == nil then
				arg_88_1.var_.characterEffect1047ui_story = var_91_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_11 = 0.200000002980232

			if var_91_10 <= arg_88_1.time_ and arg_88_1.time_ < var_91_10 + var_91_11 and not isNil(var_91_9) then
				local var_91_12 = (arg_88_1.time_ - var_91_10) / var_91_11

				if arg_88_1.var_.characterEffect1047ui_story and not isNil(var_91_9) then
					arg_88_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_10 + var_91_11 and arg_88_1.time_ < var_91_10 + var_91_11 + arg_91_0 and not isNil(var_91_9) and arg_88_1.var_.characterEffect1047ui_story then
				arg_88_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_91_13 = 0

			if var_91_13 < arg_88_1.time_ and arg_88_1.time_ <= var_91_13 + arg_91_0 then
				arg_88_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			local var_91_14 = 0

			if var_91_14 < arg_88_1.time_ and arg_88_1.time_ <= var_91_14 + arg_91_0 then
				arg_88_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_91_15 = 0
			local var_91_16 = 1.275

			if var_91_15 < arg_88_1.time_ and arg_88_1.time_ <= var_91_15 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_17 = arg_88_1:FormatText(StoryNameCfg[1296].name)

				arg_88_1.leftNameTxt_.text = var_91_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_18 = arg_88_1:GetWordFromCfg(1104701022)
				local var_91_19 = arg_88_1:FormatText(var_91_18.content)

				arg_88_1.text_.text = var_91_19

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_20 = 51
				local var_91_21 = utf8.len(var_91_19)
				local var_91_22 = var_91_20 <= 0 and var_91_16 or var_91_16 * (var_91_21 / var_91_20)

				if var_91_22 > 0 and var_91_16 < var_91_22 then
					arg_88_1.talkMaxDuration = var_91_22

					if var_91_22 + var_91_15 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_22 + var_91_15
					end
				end

				arg_88_1.text_.text = var_91_19
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701022", "story_v_side_new_1104701.awb") ~= 0 then
					local var_91_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701022", "story_v_side_new_1104701.awb") / 1000

					if var_91_23 + var_91_15 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_23 + var_91_15
					end

					if var_91_18.prefab_name ~= "" and arg_88_1.actors_[var_91_18.prefab_name] ~= nil then
						local var_91_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_18.prefab_name].transform, "story_v_side_new_1104701", "1104701022", "story_v_side_new_1104701.awb")

						arg_88_1:RecordAudio("1104701022", var_91_24)
						arg_88_1:RecordAudio("1104701022", var_91_24)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701022", "story_v_side_new_1104701.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701022", "story_v_side_new_1104701.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_25 = math.max(var_91_16, arg_88_1.talkMaxDuration)

			if var_91_15 <= arg_88_1.time_ and arg_88_1.time_ < var_91_15 + var_91_25 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_15) / var_91_25

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_15 + var_91_25 and arg_88_1.time_ < var_91_15 + var_91_25 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play1104701023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 1104701023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play1104701024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1047ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1047ui_story == nil then
				arg_92_1.var_.characterEffect1047ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1047ui_story and not isNil(var_95_0) then
					local var_95_4 = Mathf.Lerp(0, 0.5, var_95_3)

					arg_92_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1047ui_story.fillRatio = var_95_4
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1047ui_story then
				local var_95_5 = 0.5

				arg_92_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1047ui_story.fillRatio = var_95_5
			end

			local var_95_6 = 0
			local var_95_7 = 0.35

			if var_95_6 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_8 = arg_92_1:FormatText(StoryNameCfg[7].name)

				arg_92_1.leftNameTxt_.text = var_95_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_9 = arg_92_1:GetWordFromCfg(1104701023)
				local var_95_10 = arg_92_1:FormatText(var_95_9.content)

				arg_92_1.text_.text = var_95_10

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_11 = 14
				local var_95_12 = utf8.len(var_95_10)
				local var_95_13 = var_95_11 <= 0 and var_95_7 or var_95_7 * (var_95_12 / var_95_11)

				if var_95_13 > 0 and var_95_7 < var_95_13 then
					arg_92_1.talkMaxDuration = var_95_13

					if var_95_13 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_6
					end
				end

				arg_92_1.text_.text = var_95_10
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_14 = math.max(var_95_7, arg_92_1.talkMaxDuration)

			if var_95_6 <= arg_92_1.time_ and arg_92_1.time_ < var_95_6 + var_95_14 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_6) / var_95_14

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_6 + var_95_14 and arg_92_1.time_ < var_95_6 + var_95_14 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play1104701024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 1104701024
		arg_96_1.duration_ = 9.53

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play1104701025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1047ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1047ui_story == nil then
				arg_96_1.var_.characterEffect1047ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1047ui_story and not isNil(var_99_0) then
					arg_96_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1047ui_story then
				arg_96_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_99_4 = 0

			if var_99_4 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action469")
			end

			local var_99_5 = 0

			if var_99_5 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 then
				arg_96_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_99_6 = 0
			local var_99_7 = 0.975

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_8 = arg_96_1:FormatText(StoryNameCfg[1296].name)

				arg_96_1.leftNameTxt_.text = var_99_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_9 = arg_96_1:GetWordFromCfg(1104701024)
				local var_99_10 = arg_96_1:FormatText(var_99_9.content)

				arg_96_1.text_.text = var_99_10

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_11 = 39
				local var_99_12 = utf8.len(var_99_10)
				local var_99_13 = var_99_11 <= 0 and var_99_7 or var_99_7 * (var_99_12 / var_99_11)

				if var_99_13 > 0 and var_99_7 < var_99_13 then
					arg_96_1.talkMaxDuration = var_99_13

					if var_99_13 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_13 + var_99_6
					end
				end

				arg_96_1.text_.text = var_99_10
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701024", "story_v_side_new_1104701.awb") ~= 0 then
					local var_99_14 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701024", "story_v_side_new_1104701.awb") / 1000

					if var_99_14 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_14 + var_99_6
					end

					if var_99_9.prefab_name ~= "" and arg_96_1.actors_[var_99_9.prefab_name] ~= nil then
						local var_99_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_9.prefab_name].transform, "story_v_side_new_1104701", "1104701024", "story_v_side_new_1104701.awb")

						arg_96_1:RecordAudio("1104701024", var_99_15)
						arg_96_1:RecordAudio("1104701024", var_99_15)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701024", "story_v_side_new_1104701.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701024", "story_v_side_new_1104701.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_16 = math.max(var_99_7, arg_96_1.talkMaxDuration)

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_16 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_6) / var_99_16

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_6 + var_99_16 and arg_96_1.time_ < var_99_6 + var_99_16 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play1104701025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 1104701025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play1104701026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1047ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1047ui_story == nil then
				arg_100_1.var_.characterEffect1047ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1047ui_story and not isNil(var_103_0) then
					local var_103_4 = Mathf.Lerp(0, 0.5, var_103_3)

					arg_100_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1047ui_story.fillRatio = var_103_4
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1047ui_story then
				local var_103_5 = 0.5

				arg_100_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1047ui_story.fillRatio = var_103_5
			end

			local var_103_6 = arg_100_1.actors_["1047ui_story"].transform
			local var_103_7 = 0

			if var_103_7 < arg_100_1.time_ and arg_100_1.time_ <= var_103_7 + arg_103_0 then
				arg_100_1.var_.moveOldPos1047ui_story = var_103_6.localPosition
			end

			local var_103_8 = 0.001

			if var_103_7 <= arg_100_1.time_ and arg_100_1.time_ < var_103_7 + var_103_8 then
				local var_103_9 = (arg_100_1.time_ - var_103_7) / var_103_8
				local var_103_10 = Vector3.New(0, 100, 0)

				var_103_6.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1047ui_story, var_103_10, var_103_9)

				local var_103_11 = manager.ui.mainCamera.transform.position - var_103_6.position

				var_103_6.forward = Vector3.New(var_103_11.x, var_103_11.y, var_103_11.z)

				local var_103_12 = var_103_6.localEulerAngles

				var_103_12.z = 0
				var_103_12.x = 0
				var_103_6.localEulerAngles = var_103_12
			end

			if arg_100_1.time_ >= var_103_7 + var_103_8 and arg_100_1.time_ < var_103_7 + var_103_8 + arg_103_0 then
				var_103_6.localPosition = Vector3.New(0, 100, 0)

				local var_103_13 = manager.ui.mainCamera.transform.position - var_103_6.position

				var_103_6.forward = Vector3.New(var_103_13.x, var_103_13.y, var_103_13.z)

				local var_103_14 = var_103_6.localEulerAngles

				var_103_14.z = 0
				var_103_14.x = 0
				var_103_6.localEulerAngles = var_103_14
			end

			local var_103_15 = 0
			local var_103_16 = 0.675

			if var_103_15 < arg_100_1.time_ and arg_100_1.time_ <= var_103_15 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_17 = arg_100_1:GetWordFromCfg(1104701025)
				local var_103_18 = arg_100_1:FormatText(var_103_17.content)

				arg_100_1.text_.text = var_103_18

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_19 = 27
				local var_103_20 = utf8.len(var_103_18)
				local var_103_21 = var_103_19 <= 0 and var_103_16 or var_103_16 * (var_103_20 / var_103_19)

				if var_103_21 > 0 and var_103_16 < var_103_21 then
					arg_100_1.talkMaxDuration = var_103_21

					if var_103_21 + var_103_15 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_21 + var_103_15
					end
				end

				arg_100_1.text_.text = var_103_18
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_22 = math.max(var_103_16, arg_100_1.talkMaxDuration)

			if var_103_15 <= arg_100_1.time_ and arg_100_1.time_ < var_103_15 + var_103_22 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_15) / var_103_22

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_15 + var_103_22 and arg_100_1.time_ < var_103_15 + var_103_22 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play1104701026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 1104701026
		arg_104_1.duration_ = 9.6

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play1104701027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1047ui_story"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos1047ui_story = var_107_0.localPosition
			end

			local var_107_2 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2
				local var_107_4 = Vector3.New(0, -1.13, -6.2)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1047ui_story, var_107_4, var_107_3)

				local var_107_5 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_5.x, var_107_5.y, var_107_5.z)

				local var_107_6 = var_107_0.localEulerAngles

				var_107_6.z = 0
				var_107_6.x = 0
				var_107_0.localEulerAngles = var_107_6
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_107_7 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_7.x, var_107_7.y, var_107_7.z)

				local var_107_8 = var_107_0.localEulerAngles

				var_107_8.z = 0
				var_107_8.x = 0
				var_107_0.localEulerAngles = var_107_8
			end

			local var_107_9 = arg_104_1.actors_["1047ui_story"]
			local var_107_10 = 0

			if var_107_10 < arg_104_1.time_ and arg_104_1.time_ <= var_107_10 + arg_107_0 and not isNil(var_107_9) and arg_104_1.var_.characterEffect1047ui_story == nil then
				arg_104_1.var_.characterEffect1047ui_story = var_107_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_11 = 0.200000002980232

			if var_107_10 <= arg_104_1.time_ and arg_104_1.time_ < var_107_10 + var_107_11 and not isNil(var_107_9) then
				local var_107_12 = (arg_104_1.time_ - var_107_10) / var_107_11

				if arg_104_1.var_.characterEffect1047ui_story and not isNil(var_107_9) then
					arg_104_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_10 + var_107_11 and arg_104_1.time_ < var_107_10 + var_107_11 + arg_107_0 and not isNil(var_107_9) and arg_104_1.var_.characterEffect1047ui_story then
				arg_104_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_107_13 = 0

			if var_107_13 < arg_104_1.time_ and arg_104_1.time_ <= var_107_13 + arg_107_0 then
				arg_104_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_2")
			end

			local var_107_14 = 0

			if var_107_14 < arg_104_1.time_ and arg_104_1.time_ <= var_107_14 + arg_107_0 then
				arg_104_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_107_15 = 0
			local var_107_16 = 0.95

			if var_107_15 < arg_104_1.time_ and arg_104_1.time_ <= var_107_15 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_17 = arg_104_1:FormatText(StoryNameCfg[1296].name)

				arg_104_1.leftNameTxt_.text = var_107_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_18 = arg_104_1:GetWordFromCfg(1104701026)
				local var_107_19 = arg_104_1:FormatText(var_107_18.content)

				arg_104_1.text_.text = var_107_19

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_20 = 38
				local var_107_21 = utf8.len(var_107_19)
				local var_107_22 = var_107_20 <= 0 and var_107_16 or var_107_16 * (var_107_21 / var_107_20)

				if var_107_22 > 0 and var_107_16 < var_107_22 then
					arg_104_1.talkMaxDuration = var_107_22

					if var_107_22 + var_107_15 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_22 + var_107_15
					end
				end

				arg_104_1.text_.text = var_107_19
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701026", "story_v_side_new_1104701.awb") ~= 0 then
					local var_107_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701026", "story_v_side_new_1104701.awb") / 1000

					if var_107_23 + var_107_15 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_23 + var_107_15
					end

					if var_107_18.prefab_name ~= "" and arg_104_1.actors_[var_107_18.prefab_name] ~= nil then
						local var_107_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_18.prefab_name].transform, "story_v_side_new_1104701", "1104701026", "story_v_side_new_1104701.awb")

						arg_104_1:RecordAudio("1104701026", var_107_24)
						arg_104_1:RecordAudio("1104701026", var_107_24)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701026", "story_v_side_new_1104701.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701026", "story_v_side_new_1104701.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_25 = math.max(var_107_16, arg_104_1.talkMaxDuration)

			if var_107_15 <= arg_104_1.time_ and arg_104_1.time_ < var_107_15 + var_107_25 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_15) / var_107_25

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_15 + var_107_25 and arg_104_1.time_ < var_107_15 + var_107_25 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play1104701027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 1104701027
		arg_108_1.duration_ = 15.67

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play1104701028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1047ui_story"].transform
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.var_.moveOldPos1047ui_story = var_111_0.localPosition
			end

			local var_111_2 = 0.001

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2
				local var_111_4 = Vector3.New(0, -1.13, -6.2)

				var_111_0.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1047ui_story, var_111_4, var_111_3)

				local var_111_5 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_5.x, var_111_5.y, var_111_5.z)

				local var_111_6 = var_111_0.localEulerAngles

				var_111_6.z = 0
				var_111_6.x = 0
				var_111_0.localEulerAngles = var_111_6
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 then
				var_111_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_111_7 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_7.x, var_111_7.y, var_111_7.z)

				local var_111_8 = var_111_0.localEulerAngles

				var_111_8.z = 0
				var_111_8.x = 0
				var_111_0.localEulerAngles = var_111_8
			end

			local var_111_9 = 0

			if var_111_9 < arg_108_1.time_ and arg_108_1.time_ <= var_111_9 + arg_111_0 then
				arg_108_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			local var_111_10 = 0

			if var_111_10 < arg_108_1.time_ and arg_108_1.time_ <= var_111_10 + arg_111_0 then
				arg_108_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_111_11 = 0
			local var_111_12 = 1.65

			if var_111_11 < arg_108_1.time_ and arg_108_1.time_ <= var_111_11 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_13 = arg_108_1:FormatText(StoryNameCfg[1296].name)

				arg_108_1.leftNameTxt_.text = var_111_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_14 = arg_108_1:GetWordFromCfg(1104701027)
				local var_111_15 = arg_108_1:FormatText(var_111_14.content)

				arg_108_1.text_.text = var_111_15

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_16 = 66
				local var_111_17 = utf8.len(var_111_15)
				local var_111_18 = var_111_16 <= 0 and var_111_12 or var_111_12 * (var_111_17 / var_111_16)

				if var_111_18 > 0 and var_111_12 < var_111_18 then
					arg_108_1.talkMaxDuration = var_111_18

					if var_111_18 + var_111_11 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_18 + var_111_11
					end
				end

				arg_108_1.text_.text = var_111_15
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701027", "story_v_side_new_1104701.awb") ~= 0 then
					local var_111_19 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701027", "story_v_side_new_1104701.awb") / 1000

					if var_111_19 + var_111_11 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_19 + var_111_11
					end

					if var_111_14.prefab_name ~= "" and arg_108_1.actors_[var_111_14.prefab_name] ~= nil then
						local var_111_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_14.prefab_name].transform, "story_v_side_new_1104701", "1104701027", "story_v_side_new_1104701.awb")

						arg_108_1:RecordAudio("1104701027", var_111_20)
						arg_108_1:RecordAudio("1104701027", var_111_20)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701027", "story_v_side_new_1104701.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701027", "story_v_side_new_1104701.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_21 = math.max(var_111_12, arg_108_1.talkMaxDuration)

			if var_111_11 <= arg_108_1.time_ and arg_108_1.time_ < var_111_11 + var_111_21 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_11) / var_111_21

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_11 + var_111_21 and arg_108_1.time_ < var_111_11 + var_111_21 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play1104701028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 1104701028
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play1104701029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1047ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1047ui_story == nil then
				arg_112_1.var_.characterEffect1047ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect1047ui_story and not isNil(var_115_0) then
					local var_115_4 = Mathf.Lerp(0, 0.5, var_115_3)

					arg_112_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1047ui_story.fillRatio = var_115_4
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1047ui_story then
				local var_115_5 = 0.5

				arg_112_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1047ui_story.fillRatio = var_115_5
			end

			local var_115_6 = 0
			local var_115_7 = 0.05

			if var_115_6 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_8 = arg_112_1:FormatText(StoryNameCfg[7].name)

				arg_112_1.leftNameTxt_.text = var_115_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_9 = arg_112_1:GetWordFromCfg(1104701028)
				local var_115_10 = arg_112_1:FormatText(var_115_9.content)

				arg_112_1.text_.text = var_115_10

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_11 = 2
				local var_115_12 = utf8.len(var_115_10)
				local var_115_13 = var_115_11 <= 0 and var_115_7 or var_115_7 * (var_115_12 / var_115_11)

				if var_115_13 > 0 and var_115_7 < var_115_13 then
					arg_112_1.talkMaxDuration = var_115_13

					if var_115_13 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_13 + var_115_6
					end
				end

				arg_112_1.text_.text = var_115_10
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_14 = math.max(var_115_7, arg_112_1.talkMaxDuration)

			if var_115_6 <= arg_112_1.time_ and arg_112_1.time_ < var_115_6 + var_115_14 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_6) / var_115_14

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_6 + var_115_14 and arg_112_1.time_ < var_115_6 + var_115_14 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play1104701029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 1104701029
		arg_116_1.duration_ = 6.67

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play1104701030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1047ui_story"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos1047ui_story = var_119_0.localPosition
			end

			local var_119_2 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2
				local var_119_4 = Vector3.New(0, -1.13, -6.2)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1047ui_story, var_119_4, var_119_3)

				local var_119_5 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_5.x, var_119_5.y, var_119_5.z)

				local var_119_6 = var_119_0.localEulerAngles

				var_119_6.z = 0
				var_119_6.x = 0
				var_119_0.localEulerAngles = var_119_6
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_119_7 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_7.x, var_119_7.y, var_119_7.z)

				local var_119_8 = var_119_0.localEulerAngles

				var_119_8.z = 0
				var_119_8.x = 0
				var_119_0.localEulerAngles = var_119_8
			end

			local var_119_9 = arg_116_1.actors_["1047ui_story"]
			local var_119_10 = 0

			if var_119_10 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect1047ui_story == nil then
				arg_116_1.var_.characterEffect1047ui_story = var_119_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_11 = 0.200000002980232

			if var_119_10 <= arg_116_1.time_ and arg_116_1.time_ < var_119_10 + var_119_11 and not isNil(var_119_9) then
				local var_119_12 = (arg_116_1.time_ - var_119_10) / var_119_11

				if arg_116_1.var_.characterEffect1047ui_story and not isNil(var_119_9) then
					arg_116_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_10 + var_119_11 and arg_116_1.time_ < var_119_10 + var_119_11 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect1047ui_story then
				arg_116_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_119_13 = 0

			if var_119_13 < arg_116_1.time_ and arg_116_1.time_ <= var_119_13 + arg_119_0 then
				arg_116_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			local var_119_14 = 0

			if var_119_14 < arg_116_1.time_ and arg_116_1.time_ <= var_119_14 + arg_119_0 then
				arg_116_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_119_15 = 0
			local var_119_16 = 0.625

			if var_119_15 < arg_116_1.time_ and arg_116_1.time_ <= var_119_15 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_17 = arg_116_1:FormatText(StoryNameCfg[1296].name)

				arg_116_1.leftNameTxt_.text = var_119_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_18 = arg_116_1:GetWordFromCfg(1104701029)
				local var_119_19 = arg_116_1:FormatText(var_119_18.content)

				arg_116_1.text_.text = var_119_19

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_20 = 25
				local var_119_21 = utf8.len(var_119_19)
				local var_119_22 = var_119_20 <= 0 and var_119_16 or var_119_16 * (var_119_21 / var_119_20)

				if var_119_22 > 0 and var_119_16 < var_119_22 then
					arg_116_1.talkMaxDuration = var_119_22

					if var_119_22 + var_119_15 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_22 + var_119_15
					end
				end

				arg_116_1.text_.text = var_119_19
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701029", "story_v_side_new_1104701.awb") ~= 0 then
					local var_119_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701029", "story_v_side_new_1104701.awb") / 1000

					if var_119_23 + var_119_15 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_23 + var_119_15
					end

					if var_119_18.prefab_name ~= "" and arg_116_1.actors_[var_119_18.prefab_name] ~= nil then
						local var_119_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_18.prefab_name].transform, "story_v_side_new_1104701", "1104701029", "story_v_side_new_1104701.awb")

						arg_116_1:RecordAudio("1104701029", var_119_24)
						arg_116_1:RecordAudio("1104701029", var_119_24)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701029", "story_v_side_new_1104701.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701029", "story_v_side_new_1104701.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_25 = math.max(var_119_16, arg_116_1.talkMaxDuration)

			if var_119_15 <= arg_116_1.time_ and arg_116_1.time_ < var_119_15 + var_119_25 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_15) / var_119_25

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_15 + var_119_25 and arg_116_1.time_ < var_119_15 + var_119_25 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play1104701030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 1104701030
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play1104701031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1047ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1047ui_story == nil then
				arg_120_1.var_.characterEffect1047ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect1047ui_story and not isNil(var_123_0) then
					local var_123_4 = Mathf.Lerp(0, 0.5, var_123_3)

					arg_120_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1047ui_story.fillRatio = var_123_4
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1047ui_story then
				local var_123_5 = 0.5

				arg_120_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1047ui_story.fillRatio = var_123_5
			end

			local var_123_6 = 0
			local var_123_7 = 0.875

			if var_123_6 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_8 = arg_120_1:FormatText(StoryNameCfg[7].name)

				arg_120_1.leftNameTxt_.text = var_123_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_9 = arg_120_1:GetWordFromCfg(1104701030)
				local var_123_10 = arg_120_1:FormatText(var_123_9.content)

				arg_120_1.text_.text = var_123_10

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_11 = 35
				local var_123_12 = utf8.len(var_123_10)
				local var_123_13 = var_123_11 <= 0 and var_123_7 or var_123_7 * (var_123_12 / var_123_11)

				if var_123_13 > 0 and var_123_7 < var_123_13 then
					arg_120_1.talkMaxDuration = var_123_13

					if var_123_13 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_13 + var_123_6
					end
				end

				arg_120_1.text_.text = var_123_10
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_14 = math.max(var_123_7, arg_120_1.talkMaxDuration)

			if var_123_6 <= arg_120_1.time_ and arg_120_1.time_ < var_123_6 + var_123_14 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_6) / var_123_14

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_6 + var_123_14 and arg_120_1.time_ < var_123_6 + var_123_14 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play1104701031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 1104701031
		arg_124_1.duration_ = 8.3

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play1104701032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1047ui_story"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1047ui_story == nil then
				arg_124_1.var_.characterEffect1047ui_story = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.200000002980232

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.characterEffect1047ui_story and not isNil(var_127_0) then
					arg_124_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1047ui_story then
				arg_124_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_127_4 = 0

			if var_127_4 < arg_124_1.time_ and arg_124_1.time_ <= var_127_4 + arg_127_0 then
				arg_124_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_127_5 = 0

			if var_127_5 < arg_124_1.time_ and arg_124_1.time_ <= var_127_5 + arg_127_0 then
				arg_124_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_127_6 = 0
			local var_127_7 = 0.8

			if var_127_6 < arg_124_1.time_ and arg_124_1.time_ <= var_127_6 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_8 = arg_124_1:FormatText(StoryNameCfg[1296].name)

				arg_124_1.leftNameTxt_.text = var_127_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_9 = arg_124_1:GetWordFromCfg(1104701031)
				local var_127_10 = arg_124_1:FormatText(var_127_9.content)

				arg_124_1.text_.text = var_127_10

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_11 = 32
				local var_127_12 = utf8.len(var_127_10)
				local var_127_13 = var_127_11 <= 0 and var_127_7 or var_127_7 * (var_127_12 / var_127_11)

				if var_127_13 > 0 and var_127_7 < var_127_13 then
					arg_124_1.talkMaxDuration = var_127_13

					if var_127_13 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_13 + var_127_6
					end
				end

				arg_124_1.text_.text = var_127_10
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701031", "story_v_side_new_1104701.awb") ~= 0 then
					local var_127_14 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701031", "story_v_side_new_1104701.awb") / 1000

					if var_127_14 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_14 + var_127_6
					end

					if var_127_9.prefab_name ~= "" and arg_124_1.actors_[var_127_9.prefab_name] ~= nil then
						local var_127_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_9.prefab_name].transform, "story_v_side_new_1104701", "1104701031", "story_v_side_new_1104701.awb")

						arg_124_1:RecordAudio("1104701031", var_127_15)
						arg_124_1:RecordAudio("1104701031", var_127_15)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701031", "story_v_side_new_1104701.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701031", "story_v_side_new_1104701.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_16 = math.max(var_127_7, arg_124_1.talkMaxDuration)

			if var_127_6 <= arg_124_1.time_ and arg_124_1.time_ < var_127_6 + var_127_16 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_6) / var_127_16

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_6 + var_127_16 and arg_124_1.time_ < var_127_6 + var_127_16 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play1104701032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 1104701032
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play1104701033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1047ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1047ui_story == nil then
				arg_128_1.var_.characterEffect1047ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect1047ui_story and not isNil(var_131_0) then
					local var_131_4 = Mathf.Lerp(0, 0.5, var_131_3)

					arg_128_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1047ui_story.fillRatio = var_131_4
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1047ui_story then
				local var_131_5 = 0.5

				arg_128_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1047ui_story.fillRatio = var_131_5
			end

			local var_131_6 = arg_128_1.actors_["1047ui_story"].transform
			local var_131_7 = 0

			if var_131_7 < arg_128_1.time_ and arg_128_1.time_ <= var_131_7 + arg_131_0 then
				arg_128_1.var_.moveOldPos1047ui_story = var_131_6.localPosition
			end

			local var_131_8 = 0.001

			if var_131_7 <= arg_128_1.time_ and arg_128_1.time_ < var_131_7 + var_131_8 then
				local var_131_9 = (arg_128_1.time_ - var_131_7) / var_131_8
				local var_131_10 = Vector3.New(0, 100, 0)

				var_131_6.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1047ui_story, var_131_10, var_131_9)

				local var_131_11 = manager.ui.mainCamera.transform.position - var_131_6.position

				var_131_6.forward = Vector3.New(var_131_11.x, var_131_11.y, var_131_11.z)

				local var_131_12 = var_131_6.localEulerAngles

				var_131_12.z = 0
				var_131_12.x = 0
				var_131_6.localEulerAngles = var_131_12
			end

			if arg_128_1.time_ >= var_131_7 + var_131_8 and arg_128_1.time_ < var_131_7 + var_131_8 + arg_131_0 then
				var_131_6.localPosition = Vector3.New(0, 100, 0)

				local var_131_13 = manager.ui.mainCamera.transform.position - var_131_6.position

				var_131_6.forward = Vector3.New(var_131_13.x, var_131_13.y, var_131_13.z)

				local var_131_14 = var_131_6.localEulerAngles

				var_131_14.z = 0
				var_131_14.x = 0
				var_131_6.localEulerAngles = var_131_14
			end

			local var_131_15 = 0
			local var_131_16 = 0.925

			if var_131_15 < arg_128_1.time_ and arg_128_1.time_ <= var_131_15 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_17 = arg_128_1:GetWordFromCfg(1104701032)
				local var_131_18 = arg_128_1:FormatText(var_131_17.content)

				arg_128_1.text_.text = var_131_18

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_19 = 37
				local var_131_20 = utf8.len(var_131_18)
				local var_131_21 = var_131_19 <= 0 and var_131_16 or var_131_16 * (var_131_20 / var_131_19)

				if var_131_21 > 0 and var_131_16 < var_131_21 then
					arg_128_1.talkMaxDuration = var_131_21

					if var_131_21 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_21 + var_131_15
					end
				end

				arg_128_1.text_.text = var_131_18
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_22 = math.max(var_131_16, arg_128_1.talkMaxDuration)

			if var_131_15 <= arg_128_1.time_ and arg_128_1.time_ < var_131_15 + var_131_22 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_15) / var_131_22

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_15 + var_131_22 and arg_128_1.time_ < var_131_15 + var_131_22 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play1104701033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 1104701033
		arg_132_1.duration_ = 1.33

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play1104701034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0
			local var_135_1 = 0.15

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_2 = arg_132_1:FormatText(StoryNameCfg[331].name)

				arg_132_1.leftNameTxt_.text = var_135_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_3 = arg_132_1:GetWordFromCfg(1104701033)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 6
				local var_135_6 = utf8.len(var_135_4)
				local var_135_7 = var_135_5 <= 0 and var_135_1 or var_135_1 * (var_135_6 / var_135_5)

				if var_135_7 > 0 and var_135_1 < var_135_7 then
					arg_132_1.talkMaxDuration = var_135_7

					if var_135_7 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_0
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701033", "story_v_side_new_1104701.awb") ~= 0 then
					local var_135_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701033", "story_v_side_new_1104701.awb") / 1000

					if var_135_8 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_0
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_side_new_1104701", "1104701033", "story_v_side_new_1104701.awb")

						arg_132_1:RecordAudio("1104701033", var_135_9)
						arg_132_1:RecordAudio("1104701033", var_135_9)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701033", "story_v_side_new_1104701.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701033", "story_v_side_new_1104701.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_10 = math.max(var_135_1, arg_132_1.talkMaxDuration)

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_10 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_0) / var_135_10

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_0 + var_135_10 and arg_132_1.time_ < var_135_0 + var_135_10 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play1104701034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 1104701034
		arg_136_1.duration_ = 2.4

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play1104701035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1047ui_story"].transform
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.var_.moveOldPos1047ui_story = var_139_0.localPosition
			end

			local var_139_2 = 0.001

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2
				local var_139_4 = Vector3.New(0, -1.13, -6.2)

				var_139_0.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1047ui_story, var_139_4, var_139_3)

				local var_139_5 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_5.x, var_139_5.y, var_139_5.z)

				local var_139_6 = var_139_0.localEulerAngles

				var_139_6.z = 0
				var_139_6.x = 0
				var_139_0.localEulerAngles = var_139_6
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 then
				var_139_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_139_7 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_7.x, var_139_7.y, var_139_7.z)

				local var_139_8 = var_139_0.localEulerAngles

				var_139_8.z = 0
				var_139_8.x = 0
				var_139_0.localEulerAngles = var_139_8
			end

			local var_139_9 = arg_136_1.actors_["1047ui_story"]
			local var_139_10 = 0

			if var_139_10 < arg_136_1.time_ and arg_136_1.time_ <= var_139_10 + arg_139_0 and not isNil(var_139_9) and arg_136_1.var_.characterEffect1047ui_story == nil then
				arg_136_1.var_.characterEffect1047ui_story = var_139_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_11 = 0.200000002980232

			if var_139_10 <= arg_136_1.time_ and arg_136_1.time_ < var_139_10 + var_139_11 and not isNil(var_139_9) then
				local var_139_12 = (arg_136_1.time_ - var_139_10) / var_139_11

				if arg_136_1.var_.characterEffect1047ui_story and not isNil(var_139_9) then
					arg_136_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_10 + var_139_11 and arg_136_1.time_ < var_139_10 + var_139_11 + arg_139_0 and not isNil(var_139_9) and arg_136_1.var_.characterEffect1047ui_story then
				arg_136_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_139_13 = 0

			if var_139_13 < arg_136_1.time_ and arg_136_1.time_ <= var_139_13 + arg_139_0 then
				arg_136_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_139_14 = 0

			if var_139_14 < arg_136_1.time_ and arg_136_1.time_ <= var_139_14 + arg_139_0 then
				arg_136_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_139_15 = 0
			local var_139_16 = 0.125

			if var_139_15 < arg_136_1.time_ and arg_136_1.time_ <= var_139_15 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_17 = arg_136_1:FormatText(StoryNameCfg[1296].name)

				arg_136_1.leftNameTxt_.text = var_139_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_18 = arg_136_1:GetWordFromCfg(1104701034)
				local var_139_19 = arg_136_1:FormatText(var_139_18.content)

				arg_136_1.text_.text = var_139_19

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_20 = 5
				local var_139_21 = utf8.len(var_139_19)
				local var_139_22 = var_139_20 <= 0 and var_139_16 or var_139_16 * (var_139_21 / var_139_20)

				if var_139_22 > 0 and var_139_16 < var_139_22 then
					arg_136_1.talkMaxDuration = var_139_22

					if var_139_22 + var_139_15 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_22 + var_139_15
					end
				end

				arg_136_1.text_.text = var_139_19
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701034", "story_v_side_new_1104701.awb") ~= 0 then
					local var_139_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701034", "story_v_side_new_1104701.awb") / 1000

					if var_139_23 + var_139_15 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_23 + var_139_15
					end

					if var_139_18.prefab_name ~= "" and arg_136_1.actors_[var_139_18.prefab_name] ~= nil then
						local var_139_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_18.prefab_name].transform, "story_v_side_new_1104701", "1104701034", "story_v_side_new_1104701.awb")

						arg_136_1:RecordAudio("1104701034", var_139_24)
						arg_136_1:RecordAudio("1104701034", var_139_24)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701034", "story_v_side_new_1104701.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701034", "story_v_side_new_1104701.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_25 = math.max(var_139_16, arg_136_1.talkMaxDuration)

			if var_139_15 <= arg_136_1.time_ and arg_136_1.time_ < var_139_15 + var_139_25 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_15) / var_139_25

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_15 + var_139_25 and arg_136_1.time_ < var_139_15 + var_139_25 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play1104701035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 1104701035
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play1104701036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1047ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1047ui_story == nil then
				arg_140_1.var_.characterEffect1047ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect1047ui_story and not isNil(var_143_0) then
					local var_143_4 = Mathf.Lerp(0, 0.5, var_143_3)

					arg_140_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1047ui_story.fillRatio = var_143_4
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1047ui_story then
				local var_143_5 = 0.5

				arg_140_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1047ui_story.fillRatio = var_143_5
			end

			local var_143_6 = 0
			local var_143_7 = 0.375

			if var_143_6 < arg_140_1.time_ and arg_140_1.time_ <= var_143_6 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_8 = arg_140_1:FormatText(StoryNameCfg[7].name)

				arg_140_1.leftNameTxt_.text = var_143_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_9 = arg_140_1:GetWordFromCfg(1104701035)
				local var_143_10 = arg_140_1:FormatText(var_143_9.content)

				arg_140_1.text_.text = var_143_10

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_11 = 15
				local var_143_12 = utf8.len(var_143_10)
				local var_143_13 = var_143_11 <= 0 and var_143_7 or var_143_7 * (var_143_12 / var_143_11)

				if var_143_13 > 0 and var_143_7 < var_143_13 then
					arg_140_1.talkMaxDuration = var_143_13

					if var_143_13 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_13 + var_143_6
					end
				end

				arg_140_1.text_.text = var_143_10
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_14 = math.max(var_143_7, arg_140_1.talkMaxDuration)

			if var_143_6 <= arg_140_1.time_ and arg_140_1.time_ < var_143_6 + var_143_14 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_6) / var_143_14

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_6 + var_143_14 and arg_140_1.time_ < var_143_6 + var_143_14 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play1104701036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 1104701036
		arg_144_1.duration_ = 7.23

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play1104701037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1047ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1047ui_story == nil then
				arg_144_1.var_.characterEffect1047ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect1047ui_story and not isNil(var_147_0) then
					arg_144_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1047ui_story then
				arg_144_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_147_4 = 0

			if var_147_4 < arg_144_1.time_ and arg_144_1.time_ <= var_147_4 + arg_147_0 then
				arg_144_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_147_5 = 0

			if var_147_5 < arg_144_1.time_ and arg_144_1.time_ <= var_147_5 + arg_147_0 then
				arg_144_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_147_6 = 0
			local var_147_7 = 0.75

			if var_147_6 < arg_144_1.time_ and arg_144_1.time_ <= var_147_6 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_8 = arg_144_1:FormatText(StoryNameCfg[1296].name)

				arg_144_1.leftNameTxt_.text = var_147_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_9 = arg_144_1:GetWordFromCfg(1104701036)
				local var_147_10 = arg_144_1:FormatText(var_147_9.content)

				arg_144_1.text_.text = var_147_10

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_11 = 30
				local var_147_12 = utf8.len(var_147_10)
				local var_147_13 = var_147_11 <= 0 and var_147_7 or var_147_7 * (var_147_12 / var_147_11)

				if var_147_13 > 0 and var_147_7 < var_147_13 then
					arg_144_1.talkMaxDuration = var_147_13

					if var_147_13 + var_147_6 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_13 + var_147_6
					end
				end

				arg_144_1.text_.text = var_147_10
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701036", "story_v_side_new_1104701.awb") ~= 0 then
					local var_147_14 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701036", "story_v_side_new_1104701.awb") / 1000

					if var_147_14 + var_147_6 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_14 + var_147_6
					end

					if var_147_9.prefab_name ~= "" and arg_144_1.actors_[var_147_9.prefab_name] ~= nil then
						local var_147_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_9.prefab_name].transform, "story_v_side_new_1104701", "1104701036", "story_v_side_new_1104701.awb")

						arg_144_1:RecordAudio("1104701036", var_147_15)
						arg_144_1:RecordAudio("1104701036", var_147_15)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701036", "story_v_side_new_1104701.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701036", "story_v_side_new_1104701.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_16 = math.max(var_147_7, arg_144_1.talkMaxDuration)

			if var_147_6 <= arg_144_1.time_ and arg_144_1.time_ < var_147_6 + var_147_16 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_6) / var_147_16

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_6 + var_147_16 and arg_144_1.time_ < var_147_6 + var_147_16 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play1104701037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 1104701037
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play1104701038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1047ui_story"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1047ui_story == nil then
				arg_148_1.var_.characterEffect1047ui_story = var_151_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.200000002980232

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.characterEffect1047ui_story and not isNil(var_151_0) then
					local var_151_4 = Mathf.Lerp(0, 0.5, var_151_3)

					arg_148_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1047ui_story.fillRatio = var_151_4
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1047ui_story then
				local var_151_5 = 0.5

				arg_148_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1047ui_story.fillRatio = var_151_5
			end

			local var_151_6 = arg_148_1.actors_["1047ui_story"].transform
			local var_151_7 = 0

			if var_151_7 < arg_148_1.time_ and arg_148_1.time_ <= var_151_7 + arg_151_0 then
				arg_148_1.var_.moveOldPos1047ui_story = var_151_6.localPosition
			end

			local var_151_8 = 0.001

			if var_151_7 <= arg_148_1.time_ and arg_148_1.time_ < var_151_7 + var_151_8 then
				local var_151_9 = (arg_148_1.time_ - var_151_7) / var_151_8
				local var_151_10 = Vector3.New(0, 100, 0)

				var_151_6.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1047ui_story, var_151_10, var_151_9)

				local var_151_11 = manager.ui.mainCamera.transform.position - var_151_6.position

				var_151_6.forward = Vector3.New(var_151_11.x, var_151_11.y, var_151_11.z)

				local var_151_12 = var_151_6.localEulerAngles

				var_151_12.z = 0
				var_151_12.x = 0
				var_151_6.localEulerAngles = var_151_12
			end

			if arg_148_1.time_ >= var_151_7 + var_151_8 and arg_148_1.time_ < var_151_7 + var_151_8 + arg_151_0 then
				var_151_6.localPosition = Vector3.New(0, 100, 0)

				local var_151_13 = manager.ui.mainCamera.transform.position - var_151_6.position

				var_151_6.forward = Vector3.New(var_151_13.x, var_151_13.y, var_151_13.z)

				local var_151_14 = var_151_6.localEulerAngles

				var_151_14.z = 0
				var_151_14.x = 0
				var_151_6.localEulerAngles = var_151_14
			end

			local var_151_15 = 0
			local var_151_16 = 0.975

			if var_151_15 < arg_148_1.time_ and arg_148_1.time_ <= var_151_15 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_17 = arg_148_1:GetWordFromCfg(1104701037)
				local var_151_18 = arg_148_1:FormatText(var_151_17.content)

				arg_148_1.text_.text = var_151_18

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_19 = 39
				local var_151_20 = utf8.len(var_151_18)
				local var_151_21 = var_151_19 <= 0 and var_151_16 or var_151_16 * (var_151_20 / var_151_19)

				if var_151_21 > 0 and var_151_16 < var_151_21 then
					arg_148_1.talkMaxDuration = var_151_21

					if var_151_21 + var_151_15 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_21 + var_151_15
					end
				end

				arg_148_1.text_.text = var_151_18
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_22 = math.max(var_151_16, arg_148_1.talkMaxDuration)

			if var_151_15 <= arg_148_1.time_ and arg_148_1.time_ < var_151_15 + var_151_22 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_15) / var_151_22

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_15 + var_151_22 and arg_148_1.time_ < var_151_15 + var_151_22 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play1104701038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 1104701038
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play1104701039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0
			local var_155_1 = 0.975

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_2 = arg_152_1:FormatText(StoryNameCfg[7].name)

				arg_152_1.leftNameTxt_.text = var_155_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_3 = arg_152_1:GetWordFromCfg(1104701038)
				local var_155_4 = arg_152_1:FormatText(var_155_3.content)

				arg_152_1.text_.text = var_155_4

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 39
				local var_155_6 = utf8.len(var_155_4)
				local var_155_7 = var_155_5 <= 0 and var_155_1 or var_155_1 * (var_155_6 / var_155_5)

				if var_155_7 > 0 and var_155_1 < var_155_7 then
					arg_152_1.talkMaxDuration = var_155_7

					if var_155_7 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_0
					end
				end

				arg_152_1.text_.text = var_155_4
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_8 = math.max(var_155_1, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_8 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_0) / var_155_8

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_8 and arg_152_1.time_ < var_155_0 + var_155_8 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play1104701039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 1104701039
		arg_156_1.duration_ = 2.47

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play1104701040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1047ui_story"].transform
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.var_.moveOldPos1047ui_story = var_159_0.localPosition
			end

			local var_159_2 = 0.001

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2
				local var_159_4 = Vector3.New(0, -1.13, -6.2)

				var_159_0.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1047ui_story, var_159_4, var_159_3)

				local var_159_5 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_5.x, var_159_5.y, var_159_5.z)

				local var_159_6 = var_159_0.localEulerAngles

				var_159_6.z = 0
				var_159_6.x = 0
				var_159_0.localEulerAngles = var_159_6
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 then
				var_159_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_159_7 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_7.x, var_159_7.y, var_159_7.z)

				local var_159_8 = var_159_0.localEulerAngles

				var_159_8.z = 0
				var_159_8.x = 0
				var_159_0.localEulerAngles = var_159_8
			end

			local var_159_9 = arg_156_1.actors_["1047ui_story"]
			local var_159_10 = 0

			if var_159_10 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect1047ui_story == nil then
				arg_156_1.var_.characterEffect1047ui_story = var_159_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_11 = 0.200000002980232

			if var_159_10 <= arg_156_1.time_ and arg_156_1.time_ < var_159_10 + var_159_11 and not isNil(var_159_9) then
				local var_159_12 = (arg_156_1.time_ - var_159_10) / var_159_11

				if arg_156_1.var_.characterEffect1047ui_story and not isNil(var_159_9) then
					arg_156_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_10 + var_159_11 and arg_156_1.time_ < var_159_10 + var_159_11 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect1047ui_story then
				arg_156_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_159_13 = 0

			if var_159_13 < arg_156_1.time_ and arg_156_1.time_ <= var_159_13 + arg_159_0 then
				arg_156_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_159_14 = 0

			if var_159_14 < arg_156_1.time_ and arg_156_1.time_ <= var_159_14 + arg_159_0 then
				arg_156_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuA", "EmotionTimelineAnimator")
			end

			local var_159_15 = 0
			local var_159_16 = 0.3

			if var_159_15 < arg_156_1.time_ and arg_156_1.time_ <= var_159_15 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_17 = arg_156_1:FormatText(StoryNameCfg[1296].name)

				arg_156_1.leftNameTxt_.text = var_159_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_18 = arg_156_1:GetWordFromCfg(1104701039)
				local var_159_19 = arg_156_1:FormatText(var_159_18.content)

				arg_156_1.text_.text = var_159_19

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_20 = 12
				local var_159_21 = utf8.len(var_159_19)
				local var_159_22 = var_159_20 <= 0 and var_159_16 or var_159_16 * (var_159_21 / var_159_20)

				if var_159_22 > 0 and var_159_16 < var_159_22 then
					arg_156_1.talkMaxDuration = var_159_22

					if var_159_22 + var_159_15 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_22 + var_159_15
					end
				end

				arg_156_1.text_.text = var_159_19
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701039", "story_v_side_new_1104701.awb") ~= 0 then
					local var_159_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701039", "story_v_side_new_1104701.awb") / 1000

					if var_159_23 + var_159_15 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_23 + var_159_15
					end

					if var_159_18.prefab_name ~= "" and arg_156_1.actors_[var_159_18.prefab_name] ~= nil then
						local var_159_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_18.prefab_name].transform, "story_v_side_new_1104701", "1104701039", "story_v_side_new_1104701.awb")

						arg_156_1:RecordAudio("1104701039", var_159_24)
						arg_156_1:RecordAudio("1104701039", var_159_24)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701039", "story_v_side_new_1104701.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701039", "story_v_side_new_1104701.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_25 = math.max(var_159_16, arg_156_1.talkMaxDuration)

			if var_159_15 <= arg_156_1.time_ and arg_156_1.time_ < var_159_15 + var_159_25 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_15) / var_159_25

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_15 + var_159_25 and arg_156_1.time_ < var_159_15 + var_159_25 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play1104701040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 1104701040
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play1104701041(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1047ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1047ui_story == nil then
				arg_160_1.var_.characterEffect1047ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect1047ui_story and not isNil(var_163_0) then
					local var_163_4 = Mathf.Lerp(0, 0.5, var_163_3)

					arg_160_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1047ui_story.fillRatio = var_163_4
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1047ui_story then
				local var_163_5 = 0.5

				arg_160_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1047ui_story.fillRatio = var_163_5
			end

			local var_163_6 = arg_160_1.actors_["1047ui_story"].transform
			local var_163_7 = 0

			if var_163_7 < arg_160_1.time_ and arg_160_1.time_ <= var_163_7 + arg_163_0 then
				arg_160_1.var_.moveOldPos1047ui_story = var_163_6.localPosition
			end

			local var_163_8 = 0.001

			if var_163_7 <= arg_160_1.time_ and arg_160_1.time_ < var_163_7 + var_163_8 then
				local var_163_9 = (arg_160_1.time_ - var_163_7) / var_163_8
				local var_163_10 = Vector3.New(0, 100, 0)

				var_163_6.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1047ui_story, var_163_10, var_163_9)

				local var_163_11 = manager.ui.mainCamera.transform.position - var_163_6.position

				var_163_6.forward = Vector3.New(var_163_11.x, var_163_11.y, var_163_11.z)

				local var_163_12 = var_163_6.localEulerAngles

				var_163_12.z = 0
				var_163_12.x = 0
				var_163_6.localEulerAngles = var_163_12
			end

			if arg_160_1.time_ >= var_163_7 + var_163_8 and arg_160_1.time_ < var_163_7 + var_163_8 + arg_163_0 then
				var_163_6.localPosition = Vector3.New(0, 100, 0)

				local var_163_13 = manager.ui.mainCamera.transform.position - var_163_6.position

				var_163_6.forward = Vector3.New(var_163_13.x, var_163_13.y, var_163_13.z)

				local var_163_14 = var_163_6.localEulerAngles

				var_163_14.z = 0
				var_163_14.x = 0
				var_163_6.localEulerAngles = var_163_14
			end

			local var_163_15 = 0
			local var_163_16 = 0.475

			if var_163_15 < arg_160_1.time_ and arg_160_1.time_ <= var_163_15 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_17 = arg_160_1:GetWordFromCfg(1104701040)
				local var_163_18 = arg_160_1:FormatText(var_163_17.content)

				arg_160_1.text_.text = var_163_18

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_19 = 19
				local var_163_20 = utf8.len(var_163_18)
				local var_163_21 = var_163_19 <= 0 and var_163_16 or var_163_16 * (var_163_20 / var_163_19)

				if var_163_21 > 0 and var_163_16 < var_163_21 then
					arg_160_1.talkMaxDuration = var_163_21

					if var_163_21 + var_163_15 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_21 + var_163_15
					end
				end

				arg_160_1.text_.text = var_163_18
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_22 = math.max(var_163_16, arg_160_1.talkMaxDuration)

			if var_163_15 <= arg_160_1.time_ and arg_160_1.time_ < var_163_15 + var_163_22 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_15) / var_163_22

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_15 + var_163_22 and arg_160_1.time_ < var_163_15 + var_163_22 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play1104701041 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 1104701041
		arg_164_1.duration_ = 4.67

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play1104701042(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1047ui_story"].transform
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.var_.moveOldPos1047ui_story = var_167_0.localPosition
			end

			local var_167_2 = 0.001

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2
				local var_167_4 = Vector3.New(0, -1.13, -6.2)

				var_167_0.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1047ui_story, var_167_4, var_167_3)

				local var_167_5 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_5.x, var_167_5.y, var_167_5.z)

				local var_167_6 = var_167_0.localEulerAngles

				var_167_6.z = 0
				var_167_6.x = 0
				var_167_0.localEulerAngles = var_167_6
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 then
				var_167_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_167_7 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_7.x, var_167_7.y, var_167_7.z)

				local var_167_8 = var_167_0.localEulerAngles

				var_167_8.z = 0
				var_167_8.x = 0
				var_167_0.localEulerAngles = var_167_8
			end

			local var_167_9 = arg_164_1.actors_["1047ui_story"]
			local var_167_10 = 0

			if var_167_10 < arg_164_1.time_ and arg_164_1.time_ <= var_167_10 + arg_167_0 and not isNil(var_167_9) and arg_164_1.var_.characterEffect1047ui_story == nil then
				arg_164_1.var_.characterEffect1047ui_story = var_167_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_11 = 0.200000002980232

			if var_167_10 <= arg_164_1.time_ and arg_164_1.time_ < var_167_10 + var_167_11 and not isNil(var_167_9) then
				local var_167_12 = (arg_164_1.time_ - var_167_10) / var_167_11

				if arg_164_1.var_.characterEffect1047ui_story and not isNil(var_167_9) then
					arg_164_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_10 + var_167_11 and arg_164_1.time_ < var_167_10 + var_167_11 + arg_167_0 and not isNil(var_167_9) and arg_164_1.var_.characterEffect1047ui_story then
				arg_164_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_167_13 = 0

			if var_167_13 < arg_164_1.time_ and arg_164_1.time_ <= var_167_13 + arg_167_0 then
				arg_164_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_167_14 = 0

			if var_167_14 < arg_164_1.time_ and arg_164_1.time_ <= var_167_14 + arg_167_0 then
				arg_164_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_167_15 = 0
			local var_167_16 = 0.425

			if var_167_15 < arg_164_1.time_ and arg_164_1.time_ <= var_167_15 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_17 = arg_164_1:FormatText(StoryNameCfg[1296].name)

				arg_164_1.leftNameTxt_.text = var_167_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_18 = arg_164_1:GetWordFromCfg(1104701041)
				local var_167_19 = arg_164_1:FormatText(var_167_18.content)

				arg_164_1.text_.text = var_167_19

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_20 = 17
				local var_167_21 = utf8.len(var_167_19)
				local var_167_22 = var_167_20 <= 0 and var_167_16 or var_167_16 * (var_167_21 / var_167_20)

				if var_167_22 > 0 and var_167_16 < var_167_22 then
					arg_164_1.talkMaxDuration = var_167_22

					if var_167_22 + var_167_15 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_22 + var_167_15
					end
				end

				arg_164_1.text_.text = var_167_19
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701041", "story_v_side_new_1104701.awb") ~= 0 then
					local var_167_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701041", "story_v_side_new_1104701.awb") / 1000

					if var_167_23 + var_167_15 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_23 + var_167_15
					end

					if var_167_18.prefab_name ~= "" and arg_164_1.actors_[var_167_18.prefab_name] ~= nil then
						local var_167_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_18.prefab_name].transform, "story_v_side_new_1104701", "1104701041", "story_v_side_new_1104701.awb")

						arg_164_1:RecordAudio("1104701041", var_167_24)
						arg_164_1:RecordAudio("1104701041", var_167_24)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701041", "story_v_side_new_1104701.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701041", "story_v_side_new_1104701.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_25 = math.max(var_167_16, arg_164_1.talkMaxDuration)

			if var_167_15 <= arg_164_1.time_ and arg_164_1.time_ < var_167_15 + var_167_25 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_15) / var_167_25

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_15 + var_167_25 and arg_164_1.time_ < var_167_15 + var_167_25 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play1104701042 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 1104701042
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play1104701043(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1047ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1047ui_story == nil then
				arg_168_1.var_.characterEffect1047ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect1047ui_story and not isNil(var_171_0) then
					local var_171_4 = Mathf.Lerp(0, 0.5, var_171_3)

					arg_168_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_168_1.var_.characterEffect1047ui_story.fillRatio = var_171_4
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1047ui_story then
				local var_171_5 = 0.5

				arg_168_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_168_1.var_.characterEffect1047ui_story.fillRatio = var_171_5
			end

			local var_171_6 = 0
			local var_171_7 = 0.875

			if var_171_6 < arg_168_1.time_ and arg_168_1.time_ <= var_171_6 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_8 = arg_168_1:FormatText(StoryNameCfg[7].name)

				arg_168_1.leftNameTxt_.text = var_171_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_9 = arg_168_1:GetWordFromCfg(1104701042)
				local var_171_10 = arg_168_1:FormatText(var_171_9.content)

				arg_168_1.text_.text = var_171_10

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_11 = 35
				local var_171_12 = utf8.len(var_171_10)
				local var_171_13 = var_171_11 <= 0 and var_171_7 or var_171_7 * (var_171_12 / var_171_11)

				if var_171_13 > 0 and var_171_7 < var_171_13 then
					arg_168_1.talkMaxDuration = var_171_13

					if var_171_13 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_13 + var_171_6
					end
				end

				arg_168_1.text_.text = var_171_10
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_14 = math.max(var_171_7, arg_168_1.talkMaxDuration)

			if var_171_6 <= arg_168_1.time_ and arg_168_1.time_ < var_171_6 + var_171_14 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_6) / var_171_14

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_6 + var_171_14 and arg_168_1.time_ < var_171_6 + var_171_14 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play1104701043 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 1104701043
		arg_172_1.duration_ = 9

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play1104701044(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = "ST12"

			if arg_172_1.bgs_[var_175_0] == nil then
				local var_175_1 = Object.Instantiate(arg_172_1.paintGo_)

				var_175_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_175_0)
				var_175_1.name = var_175_0
				var_175_1.transform.parent = arg_172_1.stage_.transform
				var_175_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_172_1.bgs_[var_175_0] = var_175_1
			end

			local var_175_2 = 2

			if var_175_2 < arg_172_1.time_ and arg_172_1.time_ <= var_175_2 + arg_175_0 then
				local var_175_3 = manager.ui.mainCamera.transform.localPosition
				local var_175_4 = Vector3.New(0, 0, 10) + Vector3.New(var_175_3.x, var_175_3.y, 0)
				local var_175_5 = arg_172_1.bgs_.ST12

				var_175_5.transform.localPosition = var_175_4
				var_175_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_175_6 = var_175_5:GetComponent("SpriteRenderer")

				if var_175_6 and var_175_6.sprite then
					local var_175_7 = (var_175_5.transform.localPosition - var_175_3).z
					local var_175_8 = manager.ui.mainCameraCom_
					local var_175_9 = 2 * var_175_7 * Mathf.Tan(var_175_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_175_10 = var_175_9 * var_175_8.aspect
					local var_175_11 = var_175_6.sprite.bounds.size.x
					local var_175_12 = var_175_6.sprite.bounds.size.y
					local var_175_13 = var_175_10 / var_175_11
					local var_175_14 = var_175_9 / var_175_12
					local var_175_15 = var_175_14 < var_175_13 and var_175_13 or var_175_14

					var_175_5.transform.localScale = Vector3.New(var_175_15, var_175_15, 0)
				end

				for iter_175_0, iter_175_1 in pairs(arg_172_1.bgs_) do
					if iter_175_0 ~= "ST12" then
						iter_175_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_175_16 = 4

			if var_175_16 < arg_172_1.time_ and arg_172_1.time_ <= var_175_16 + arg_175_0 then
				arg_172_1.allBtn_.enabled = false
			end

			local var_175_17 = 0.3

			if arg_172_1.time_ >= var_175_16 + var_175_17 and arg_172_1.time_ < var_175_16 + var_175_17 + arg_175_0 then
				arg_172_1.allBtn_.enabled = true
			end

			local var_175_18 = 0

			if var_175_18 < arg_172_1.time_ and arg_172_1.time_ <= var_175_18 + arg_175_0 then
				arg_172_1.mask_.enabled = true
				arg_172_1.mask_.raycastTarget = true

				arg_172_1:SetGaussion(false)
			end

			local var_175_19 = 2

			if var_175_18 <= arg_172_1.time_ and arg_172_1.time_ < var_175_18 + var_175_19 then
				local var_175_20 = (arg_172_1.time_ - var_175_18) / var_175_19
				local var_175_21 = Color.New(0, 0, 0)

				var_175_21.a = Mathf.Lerp(0, 1, var_175_20)
				arg_172_1.mask_.color = var_175_21
			end

			if arg_172_1.time_ >= var_175_18 + var_175_19 and arg_172_1.time_ < var_175_18 + var_175_19 + arg_175_0 then
				local var_175_22 = Color.New(0, 0, 0)

				var_175_22.a = 1
				arg_172_1.mask_.color = var_175_22
			end

			local var_175_23 = 2

			if var_175_23 < arg_172_1.time_ and arg_172_1.time_ <= var_175_23 + arg_175_0 then
				arg_172_1.mask_.enabled = true
				arg_172_1.mask_.raycastTarget = true

				arg_172_1:SetGaussion(false)
			end

			local var_175_24 = 2

			if var_175_23 <= arg_172_1.time_ and arg_172_1.time_ < var_175_23 + var_175_24 then
				local var_175_25 = (arg_172_1.time_ - var_175_23) / var_175_24
				local var_175_26 = Color.New(0, 0, 0)

				var_175_26.a = Mathf.Lerp(1, 0, var_175_25)
				arg_172_1.mask_.color = var_175_26
			end

			if arg_172_1.time_ >= var_175_23 + var_175_24 and arg_172_1.time_ < var_175_23 + var_175_24 + arg_175_0 then
				local var_175_27 = Color.New(0, 0, 0)
				local var_175_28 = 0

				arg_172_1.mask_.enabled = false
				var_175_27.a = var_175_28
				arg_172_1.mask_.color = var_175_27
			end

			local var_175_29 = arg_172_1.actors_["1047ui_story"].transform
			local var_175_30 = 1.96599999815226

			if var_175_30 < arg_172_1.time_ and arg_172_1.time_ <= var_175_30 + arg_175_0 then
				arg_172_1.var_.moveOldPos1047ui_story = var_175_29.localPosition
			end

			local var_175_31 = 0.001

			if var_175_30 <= arg_172_1.time_ and arg_172_1.time_ < var_175_30 + var_175_31 then
				local var_175_32 = (arg_172_1.time_ - var_175_30) / var_175_31
				local var_175_33 = Vector3.New(0, 100, 0)

				var_175_29.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1047ui_story, var_175_33, var_175_32)

				local var_175_34 = manager.ui.mainCamera.transform.position - var_175_29.position

				var_175_29.forward = Vector3.New(var_175_34.x, var_175_34.y, var_175_34.z)

				local var_175_35 = var_175_29.localEulerAngles

				var_175_35.z = 0
				var_175_35.x = 0
				var_175_29.localEulerAngles = var_175_35
			end

			if arg_172_1.time_ >= var_175_30 + var_175_31 and arg_172_1.time_ < var_175_30 + var_175_31 + arg_175_0 then
				var_175_29.localPosition = Vector3.New(0, 100, 0)

				local var_175_36 = manager.ui.mainCamera.transform.position - var_175_29.position

				var_175_29.forward = Vector3.New(var_175_36.x, var_175_36.y, var_175_36.z)

				local var_175_37 = var_175_29.localEulerAngles

				var_175_37.z = 0
				var_175_37.x = 0
				var_175_29.localEulerAngles = var_175_37
			end

			local var_175_38 = 0.1
			local var_175_39 = 1

			if var_175_38 < arg_172_1.time_ and arg_172_1.time_ <= var_175_38 + arg_175_0 then
				local var_175_40 = "stop"
				local var_175_41 = "effect"

				arg_172_1:AudioAction(var_175_40, var_175_41, "se_story_143", "se_story_143_amb_club", "")
			end

			local var_175_42 = 1.2
			local var_175_43 = 1

			if var_175_42 < arg_172_1.time_ and arg_172_1.time_ <= var_175_42 + arg_175_0 then
				local var_175_44 = "play"
				local var_175_45 = "effect"

				arg_172_1:AudioAction(var_175_44, var_175_45, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_172_1.frameCnt_ <= 1 then
				arg_172_1.dialog_:SetActive(false)
			end

			local var_175_46 = 4
			local var_175_47 = 1.775

			if var_175_46 < arg_172_1.time_ and arg_172_1.time_ <= var_175_46 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0

				arg_172_1.dialog_:SetActive(true)

				arg_172_1.dialogCg_.alpha = 0

				local var_175_48 = LeanTween.value(arg_172_1.dialog_, 0, 1, 0.3)

				var_175_48:setOnUpdate(LuaHelper.FloatAction(function(arg_176_0)
					arg_172_1.dialogCg_.alpha = arg_176_0
				end))
				var_175_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_172_1.dialog_)
					var_175_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_172_1.duration_ = arg_172_1.duration_ + 0.3

				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_49 = arg_172_1:GetWordFromCfg(1104701043)
				local var_175_50 = arg_172_1:FormatText(var_175_49.content)

				arg_172_1.text_.text = var_175_50

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_51 = 71
				local var_175_52 = utf8.len(var_175_50)
				local var_175_53 = var_175_51 <= 0 and var_175_47 or var_175_47 * (var_175_52 / var_175_51)

				if var_175_53 > 0 and var_175_47 < var_175_53 then
					arg_172_1.talkMaxDuration = var_175_53
					var_175_46 = var_175_46 + 0.3

					if var_175_53 + var_175_46 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_53 + var_175_46
					end
				end

				arg_172_1.text_.text = var_175_50
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_54 = var_175_46 + 0.3
			local var_175_55 = math.max(var_175_47, arg_172_1.talkMaxDuration)

			if var_175_54 <= arg_172_1.time_ and arg_172_1.time_ < var_175_54 + var_175_55 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_54) / var_175_55

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_54 + var_175_55 and arg_172_1.time_ < var_175_54 + var_175_55 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play1104701044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 1104701044
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play1104701045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0
			local var_181_1 = 0.675

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_2 = arg_178_1:FormatText(StoryNameCfg[7].name)

				arg_178_1.leftNameTxt_.text = var_181_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_3 = arg_178_1:GetWordFromCfg(1104701044)
				local var_181_4 = arg_178_1:FormatText(var_181_3.content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 27
				local var_181_6 = utf8.len(var_181_4)
				local var_181_7 = var_181_5 <= 0 and var_181_1 or var_181_1 * (var_181_6 / var_181_5)

				if var_181_7 > 0 and var_181_1 < var_181_7 then
					arg_178_1.talkMaxDuration = var_181_7

					if var_181_7 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_7 + var_181_0
					end
				end

				arg_178_1.text_.text = var_181_4
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_8 = math.max(var_181_1, arg_178_1.talkMaxDuration)

			if var_181_0 <= arg_178_1.time_ and arg_178_1.time_ < var_181_0 + var_181_8 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_0) / var_181_8

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_0 + var_181_8 and arg_178_1.time_ < var_181_0 + var_181_8 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play1104701045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 1104701045
		arg_182_1.duration_ = 2.2

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play1104701046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1047ui_story"].transform
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 then
				arg_182_1.var_.moveOldPos1047ui_story = var_185_0.localPosition
			end

			local var_185_2 = 0.001

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2
				local var_185_4 = Vector3.New(0, -1.13, -6.2)

				var_185_0.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1047ui_story, var_185_4, var_185_3)

				local var_185_5 = manager.ui.mainCamera.transform.position - var_185_0.position

				var_185_0.forward = Vector3.New(var_185_5.x, var_185_5.y, var_185_5.z)

				local var_185_6 = var_185_0.localEulerAngles

				var_185_6.z = 0
				var_185_6.x = 0
				var_185_0.localEulerAngles = var_185_6
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 then
				var_185_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_185_7 = manager.ui.mainCamera.transform.position - var_185_0.position

				var_185_0.forward = Vector3.New(var_185_7.x, var_185_7.y, var_185_7.z)

				local var_185_8 = var_185_0.localEulerAngles

				var_185_8.z = 0
				var_185_8.x = 0
				var_185_0.localEulerAngles = var_185_8
			end

			local var_185_9 = arg_182_1.actors_["1047ui_story"]
			local var_185_10 = 0

			if var_185_10 < arg_182_1.time_ and arg_182_1.time_ <= var_185_10 + arg_185_0 and not isNil(var_185_9) and arg_182_1.var_.characterEffect1047ui_story == nil then
				arg_182_1.var_.characterEffect1047ui_story = var_185_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_11 = 0.200000002980232

			if var_185_10 <= arg_182_1.time_ and arg_182_1.time_ < var_185_10 + var_185_11 and not isNil(var_185_9) then
				local var_185_12 = (arg_182_1.time_ - var_185_10) / var_185_11

				if arg_182_1.var_.characterEffect1047ui_story and not isNil(var_185_9) then
					arg_182_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= var_185_10 + var_185_11 and arg_182_1.time_ < var_185_10 + var_185_11 + arg_185_0 and not isNil(var_185_9) and arg_182_1.var_.characterEffect1047ui_story then
				arg_182_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_185_13 = 0

			if var_185_13 < arg_182_1.time_ and arg_182_1.time_ <= var_185_13 + arg_185_0 then
				arg_182_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_185_14 = 0

			if var_185_14 < arg_182_1.time_ and arg_182_1.time_ <= var_185_14 + arg_185_0 then
				arg_182_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_185_15 = 0
			local var_185_16 = 0.2

			if var_185_15 < arg_182_1.time_ and arg_182_1.time_ <= var_185_15 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_17 = arg_182_1:FormatText(StoryNameCfg[1296].name)

				arg_182_1.leftNameTxt_.text = var_185_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_18 = arg_182_1:GetWordFromCfg(1104701045)
				local var_185_19 = arg_182_1:FormatText(var_185_18.content)

				arg_182_1.text_.text = var_185_19

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_20 = 8
				local var_185_21 = utf8.len(var_185_19)
				local var_185_22 = var_185_20 <= 0 and var_185_16 or var_185_16 * (var_185_21 / var_185_20)

				if var_185_22 > 0 and var_185_16 < var_185_22 then
					arg_182_1.talkMaxDuration = var_185_22

					if var_185_22 + var_185_15 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_22 + var_185_15
					end
				end

				arg_182_1.text_.text = var_185_19
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701045", "story_v_side_new_1104701.awb") ~= 0 then
					local var_185_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701045", "story_v_side_new_1104701.awb") / 1000

					if var_185_23 + var_185_15 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_23 + var_185_15
					end

					if var_185_18.prefab_name ~= "" and arg_182_1.actors_[var_185_18.prefab_name] ~= nil then
						local var_185_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_18.prefab_name].transform, "story_v_side_new_1104701", "1104701045", "story_v_side_new_1104701.awb")

						arg_182_1:RecordAudio("1104701045", var_185_24)
						arg_182_1:RecordAudio("1104701045", var_185_24)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701045", "story_v_side_new_1104701.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701045", "story_v_side_new_1104701.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_25 = math.max(var_185_16, arg_182_1.talkMaxDuration)

			if var_185_15 <= arg_182_1.time_ and arg_182_1.time_ < var_185_15 + var_185_25 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_15) / var_185_25

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_15 + var_185_25 and arg_182_1.time_ < var_185_15 + var_185_25 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play1104701046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 1104701046
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play1104701047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["1047ui_story"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1047ui_story == nil then
				arg_186_1.var_.characterEffect1047ui_story = var_189_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.200000002980232

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.characterEffect1047ui_story and not isNil(var_189_0) then
					local var_189_4 = Mathf.Lerp(0, 0.5, var_189_3)

					arg_186_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1047ui_story.fillRatio = var_189_4
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1047ui_story then
				local var_189_5 = 0.5

				arg_186_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1047ui_story.fillRatio = var_189_5
			end

			local var_189_6 = arg_186_1.actors_["1047ui_story"].transform
			local var_189_7 = 0

			if var_189_7 < arg_186_1.time_ and arg_186_1.time_ <= var_189_7 + arg_189_0 then
				arg_186_1.var_.moveOldPos1047ui_story = var_189_6.localPosition
			end

			local var_189_8 = 0.001

			if var_189_7 <= arg_186_1.time_ and arg_186_1.time_ < var_189_7 + var_189_8 then
				local var_189_9 = (arg_186_1.time_ - var_189_7) / var_189_8
				local var_189_10 = Vector3.New(0, 100, 0)

				var_189_6.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1047ui_story, var_189_10, var_189_9)

				local var_189_11 = manager.ui.mainCamera.transform.position - var_189_6.position

				var_189_6.forward = Vector3.New(var_189_11.x, var_189_11.y, var_189_11.z)

				local var_189_12 = var_189_6.localEulerAngles

				var_189_12.z = 0
				var_189_12.x = 0
				var_189_6.localEulerAngles = var_189_12
			end

			if arg_186_1.time_ >= var_189_7 + var_189_8 and arg_186_1.time_ < var_189_7 + var_189_8 + arg_189_0 then
				var_189_6.localPosition = Vector3.New(0, 100, 0)

				local var_189_13 = manager.ui.mainCamera.transform.position - var_189_6.position

				var_189_6.forward = Vector3.New(var_189_13.x, var_189_13.y, var_189_13.z)

				local var_189_14 = var_189_6.localEulerAngles

				var_189_14.z = 0
				var_189_14.x = 0
				var_189_6.localEulerAngles = var_189_14
			end

			local var_189_15 = 0.1
			local var_189_16 = 1

			if var_189_15 < arg_186_1.time_ and arg_186_1.time_ <= var_189_15 + arg_189_0 then
				local var_189_17 = "play"
				local var_189_18 = "effect"

				arg_186_1:AudioAction(var_189_17, var_189_18, "se_story_144", "se_story_144_door_open", "")
			end

			local var_189_19 = 0
			local var_189_20 = 1.175

			if var_189_19 < arg_186_1.time_ and arg_186_1.time_ <= var_189_19 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_21 = arg_186_1:GetWordFromCfg(1104701046)
				local var_189_22 = arg_186_1:FormatText(var_189_21.content)

				arg_186_1.text_.text = var_189_22

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_23 = 47
				local var_189_24 = utf8.len(var_189_22)
				local var_189_25 = var_189_23 <= 0 and var_189_20 or var_189_20 * (var_189_24 / var_189_23)

				if var_189_25 > 0 and var_189_20 < var_189_25 then
					arg_186_1.talkMaxDuration = var_189_25

					if var_189_25 + var_189_19 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_25 + var_189_19
					end
				end

				arg_186_1.text_.text = var_189_22
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_26 = math.max(var_189_20, arg_186_1.talkMaxDuration)

			if var_189_19 <= arg_186_1.time_ and arg_186_1.time_ < var_189_19 + var_189_26 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_19) / var_189_26

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_19 + var_189_26 and arg_186_1.time_ < var_189_19 + var_189_26 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play1104701047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 1104701047
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play1104701048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0
			local var_193_1 = 0.725

			if var_193_0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_2 = arg_190_1:FormatText(StoryNameCfg[7].name)

				arg_190_1.leftNameTxt_.text = var_193_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_3 = arg_190_1:GetWordFromCfg(1104701047)
				local var_193_4 = arg_190_1:FormatText(var_193_3.content)

				arg_190_1.text_.text = var_193_4

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 29
				local var_193_6 = utf8.len(var_193_4)
				local var_193_7 = var_193_5 <= 0 and var_193_1 or var_193_1 * (var_193_6 / var_193_5)

				if var_193_7 > 0 and var_193_1 < var_193_7 then
					arg_190_1.talkMaxDuration = var_193_7

					if var_193_7 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_7 + var_193_0
					end
				end

				arg_190_1.text_.text = var_193_4
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_8 = math.max(var_193_1, arg_190_1.talkMaxDuration)

			if var_193_0 <= arg_190_1.time_ and arg_190_1.time_ < var_193_0 + var_193_8 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_0) / var_193_8

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_0 + var_193_8 and arg_190_1.time_ < var_193_0 + var_193_8 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play1104701048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 1104701048
		arg_194_1.duration_ = 8.4

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play1104701049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1047ui_story"].transform
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 then
				arg_194_1.var_.moveOldPos1047ui_story = var_197_0.localPosition
			end

			local var_197_2 = 0.001

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2
				local var_197_4 = Vector3.New(0, -1.13, -6.2)

				var_197_0.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1047ui_story, var_197_4, var_197_3)

				local var_197_5 = manager.ui.mainCamera.transform.position - var_197_0.position

				var_197_0.forward = Vector3.New(var_197_5.x, var_197_5.y, var_197_5.z)

				local var_197_6 = var_197_0.localEulerAngles

				var_197_6.z = 0
				var_197_6.x = 0
				var_197_0.localEulerAngles = var_197_6
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 then
				var_197_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_197_7 = manager.ui.mainCamera.transform.position - var_197_0.position

				var_197_0.forward = Vector3.New(var_197_7.x, var_197_7.y, var_197_7.z)

				local var_197_8 = var_197_0.localEulerAngles

				var_197_8.z = 0
				var_197_8.x = 0
				var_197_0.localEulerAngles = var_197_8
			end

			local var_197_9 = arg_194_1.actors_["1047ui_story"]
			local var_197_10 = 0

			if var_197_10 < arg_194_1.time_ and arg_194_1.time_ <= var_197_10 + arg_197_0 and not isNil(var_197_9) and arg_194_1.var_.characterEffect1047ui_story == nil then
				arg_194_1.var_.characterEffect1047ui_story = var_197_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_11 = 0.200000002980232

			if var_197_10 <= arg_194_1.time_ and arg_194_1.time_ < var_197_10 + var_197_11 and not isNil(var_197_9) then
				local var_197_12 = (arg_194_1.time_ - var_197_10) / var_197_11

				if arg_194_1.var_.characterEffect1047ui_story and not isNil(var_197_9) then
					arg_194_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= var_197_10 + var_197_11 and arg_194_1.time_ < var_197_10 + var_197_11 + arg_197_0 and not isNil(var_197_9) and arg_194_1.var_.characterEffect1047ui_story then
				arg_194_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_197_13 = 0

			if var_197_13 < arg_194_1.time_ and arg_194_1.time_ <= var_197_13 + arg_197_0 then
				arg_194_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_1")
			end

			local var_197_14 = 0

			if var_197_14 < arg_194_1.time_ and arg_194_1.time_ <= var_197_14 + arg_197_0 then
				arg_194_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_197_15 = 0
			local var_197_16 = 0.875

			if var_197_15 < arg_194_1.time_ and arg_194_1.time_ <= var_197_15 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_17 = arg_194_1:FormatText(StoryNameCfg[1296].name)

				arg_194_1.leftNameTxt_.text = var_197_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_18 = arg_194_1:GetWordFromCfg(1104701048)
				local var_197_19 = arg_194_1:FormatText(var_197_18.content)

				arg_194_1.text_.text = var_197_19

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_20 = 35
				local var_197_21 = utf8.len(var_197_19)
				local var_197_22 = var_197_20 <= 0 and var_197_16 or var_197_16 * (var_197_21 / var_197_20)

				if var_197_22 > 0 and var_197_16 < var_197_22 then
					arg_194_1.talkMaxDuration = var_197_22

					if var_197_22 + var_197_15 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_22 + var_197_15
					end
				end

				arg_194_1.text_.text = var_197_19
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701048", "story_v_side_new_1104701.awb") ~= 0 then
					local var_197_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701048", "story_v_side_new_1104701.awb") / 1000

					if var_197_23 + var_197_15 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_23 + var_197_15
					end

					if var_197_18.prefab_name ~= "" and arg_194_1.actors_[var_197_18.prefab_name] ~= nil then
						local var_197_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_18.prefab_name].transform, "story_v_side_new_1104701", "1104701048", "story_v_side_new_1104701.awb")

						arg_194_1:RecordAudio("1104701048", var_197_24)
						arg_194_1:RecordAudio("1104701048", var_197_24)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701048", "story_v_side_new_1104701.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701048", "story_v_side_new_1104701.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_25 = math.max(var_197_16, arg_194_1.talkMaxDuration)

			if var_197_15 <= arg_194_1.time_ and arg_194_1.time_ < var_197_15 + var_197_25 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_15) / var_197_25

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_15 + var_197_25 and arg_194_1.time_ < var_197_15 + var_197_25 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play1104701049 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 1104701049
		arg_198_1.duration_ = 6.57

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play1104701050(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1047ui_story"].transform
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.var_.moveOldPos1047ui_story = var_201_0.localPosition
			end

			local var_201_2 = 0.001

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2
				local var_201_4 = Vector3.New(0, -1.13, -6.2)

				var_201_0.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1047ui_story, var_201_4, var_201_3)

				local var_201_5 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_5.x, var_201_5.y, var_201_5.z)

				local var_201_6 = var_201_0.localEulerAngles

				var_201_6.z = 0
				var_201_6.x = 0
				var_201_0.localEulerAngles = var_201_6
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 then
				var_201_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_201_7 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_7.x, var_201_7.y, var_201_7.z)

				local var_201_8 = var_201_0.localEulerAngles

				var_201_8.z = 0
				var_201_8.x = 0
				var_201_0.localEulerAngles = var_201_8
			end

			local var_201_9 = 0

			if var_201_9 < arg_198_1.time_ and arg_198_1.time_ <= var_201_9 + arg_201_0 then
				arg_198_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_2")
			end

			local var_201_10 = 0

			if var_201_10 < arg_198_1.time_ and arg_198_1.time_ <= var_201_10 + arg_201_0 then
				arg_198_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_201_11 = 0
			local var_201_12 = 0.725

			if var_201_11 < arg_198_1.time_ and arg_198_1.time_ <= var_201_11 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_13 = arg_198_1:FormatText(StoryNameCfg[1296].name)

				arg_198_1.leftNameTxt_.text = var_201_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_14 = arg_198_1:GetWordFromCfg(1104701049)
				local var_201_15 = arg_198_1:FormatText(var_201_14.content)

				arg_198_1.text_.text = var_201_15

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_16 = 29
				local var_201_17 = utf8.len(var_201_15)
				local var_201_18 = var_201_16 <= 0 and var_201_12 or var_201_12 * (var_201_17 / var_201_16)

				if var_201_18 > 0 and var_201_12 < var_201_18 then
					arg_198_1.talkMaxDuration = var_201_18

					if var_201_18 + var_201_11 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_18 + var_201_11
					end
				end

				arg_198_1.text_.text = var_201_15
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701049", "story_v_side_new_1104701.awb") ~= 0 then
					local var_201_19 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701049", "story_v_side_new_1104701.awb") / 1000

					if var_201_19 + var_201_11 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_19 + var_201_11
					end

					if var_201_14.prefab_name ~= "" and arg_198_1.actors_[var_201_14.prefab_name] ~= nil then
						local var_201_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_14.prefab_name].transform, "story_v_side_new_1104701", "1104701049", "story_v_side_new_1104701.awb")

						arg_198_1:RecordAudio("1104701049", var_201_20)
						arg_198_1:RecordAudio("1104701049", var_201_20)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701049", "story_v_side_new_1104701.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701049", "story_v_side_new_1104701.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_21 = math.max(var_201_12, arg_198_1.talkMaxDuration)

			if var_201_11 <= arg_198_1.time_ and arg_198_1.time_ < var_201_11 + var_201_21 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_11) / var_201_21

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_11 + var_201_21 and arg_198_1.time_ < var_201_11 + var_201_21 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play1104701050 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 1104701050
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play1104701051(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["1047ui_story"]
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1047ui_story == nil then
				arg_202_1.var_.characterEffect1047ui_story = var_205_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.200000002980232

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 and not isNil(var_205_0) then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2

				if arg_202_1.var_.characterEffect1047ui_story and not isNil(var_205_0) then
					local var_205_4 = Mathf.Lerp(0, 0.5, var_205_3)

					arg_202_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1047ui_story.fillRatio = var_205_4
				end
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1047ui_story then
				local var_205_5 = 0.5

				arg_202_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1047ui_story.fillRatio = var_205_5
			end

			local var_205_6 = arg_202_1.actors_["1047ui_story"].transform
			local var_205_7 = 0

			if var_205_7 < arg_202_1.time_ and arg_202_1.time_ <= var_205_7 + arg_205_0 then
				arg_202_1.var_.moveOldPos1047ui_story = var_205_6.localPosition
			end

			local var_205_8 = 0.001

			if var_205_7 <= arg_202_1.time_ and arg_202_1.time_ < var_205_7 + var_205_8 then
				local var_205_9 = (arg_202_1.time_ - var_205_7) / var_205_8
				local var_205_10 = Vector3.New(0, 100, 0)

				var_205_6.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1047ui_story, var_205_10, var_205_9)

				local var_205_11 = manager.ui.mainCamera.transform.position - var_205_6.position

				var_205_6.forward = Vector3.New(var_205_11.x, var_205_11.y, var_205_11.z)

				local var_205_12 = var_205_6.localEulerAngles

				var_205_12.z = 0
				var_205_12.x = 0
				var_205_6.localEulerAngles = var_205_12
			end

			if arg_202_1.time_ >= var_205_7 + var_205_8 and arg_202_1.time_ < var_205_7 + var_205_8 + arg_205_0 then
				var_205_6.localPosition = Vector3.New(0, 100, 0)

				local var_205_13 = manager.ui.mainCamera.transform.position - var_205_6.position

				var_205_6.forward = Vector3.New(var_205_13.x, var_205_13.y, var_205_13.z)

				local var_205_14 = var_205_6.localEulerAngles

				var_205_14.z = 0
				var_205_14.x = 0
				var_205_6.localEulerAngles = var_205_14
			end

			local var_205_15 = 0
			local var_205_16 = 0.4

			if var_205_15 < arg_202_1.time_ and arg_202_1.time_ <= var_205_15 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_17 = arg_202_1:FormatText(StoryNameCfg[7].name)

				arg_202_1.leftNameTxt_.text = var_205_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_18 = arg_202_1:GetWordFromCfg(1104701050)
				local var_205_19 = arg_202_1:FormatText(var_205_18.content)

				arg_202_1.text_.text = var_205_19

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_20 = 16
				local var_205_21 = utf8.len(var_205_19)
				local var_205_22 = var_205_20 <= 0 and var_205_16 or var_205_16 * (var_205_21 / var_205_20)

				if var_205_22 > 0 and var_205_16 < var_205_22 then
					arg_202_1.talkMaxDuration = var_205_22

					if var_205_22 + var_205_15 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_22 + var_205_15
					end
				end

				arg_202_1.text_.text = var_205_19
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_23 = math.max(var_205_16, arg_202_1.talkMaxDuration)

			if var_205_15 <= arg_202_1.time_ and arg_202_1.time_ < var_205_15 + var_205_23 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_15) / var_205_23

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_15 + var_205_23 and arg_202_1.time_ < var_205_15 + var_205_23 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play1104701051 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 1104701051
		arg_206_1.duration_ = 10.03

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play1104701052(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["1047ui_story"].transform
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.var_.moveOldPos1047ui_story = var_209_0.localPosition
			end

			local var_209_2 = 0.001

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2
				local var_209_4 = Vector3.New(0, -1.13, -6.2)

				var_209_0.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1047ui_story, var_209_4, var_209_3)

				local var_209_5 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_5.x, var_209_5.y, var_209_5.z)

				local var_209_6 = var_209_0.localEulerAngles

				var_209_6.z = 0
				var_209_6.x = 0
				var_209_0.localEulerAngles = var_209_6
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 then
				var_209_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_209_7 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_7.x, var_209_7.y, var_209_7.z)

				local var_209_8 = var_209_0.localEulerAngles

				var_209_8.z = 0
				var_209_8.x = 0
				var_209_0.localEulerAngles = var_209_8
			end

			local var_209_9 = arg_206_1.actors_["1047ui_story"]
			local var_209_10 = 0

			if var_209_10 < arg_206_1.time_ and arg_206_1.time_ <= var_209_10 + arg_209_0 and not isNil(var_209_9) and arg_206_1.var_.characterEffect1047ui_story == nil then
				arg_206_1.var_.characterEffect1047ui_story = var_209_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_11 = 0.200000002980232

			if var_209_10 <= arg_206_1.time_ and arg_206_1.time_ < var_209_10 + var_209_11 and not isNil(var_209_9) then
				local var_209_12 = (arg_206_1.time_ - var_209_10) / var_209_11

				if arg_206_1.var_.characterEffect1047ui_story and not isNil(var_209_9) then
					arg_206_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= var_209_10 + var_209_11 and arg_206_1.time_ < var_209_10 + var_209_11 + arg_209_0 and not isNil(var_209_9) and arg_206_1.var_.characterEffect1047ui_story then
				arg_206_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_209_13 = 0

			if var_209_13 < arg_206_1.time_ and arg_206_1.time_ <= var_209_13 + arg_209_0 then
				arg_206_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action5_1")
			end

			local var_209_14 = 0

			if var_209_14 < arg_206_1.time_ and arg_206_1.time_ <= var_209_14 + arg_209_0 then
				arg_206_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_209_15 = 0
			local var_209_16 = 0.9

			if var_209_15 < arg_206_1.time_ and arg_206_1.time_ <= var_209_15 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_17 = arg_206_1:FormatText(StoryNameCfg[1296].name)

				arg_206_1.leftNameTxt_.text = var_209_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_18 = arg_206_1:GetWordFromCfg(1104701051)
				local var_209_19 = arg_206_1:FormatText(var_209_18.content)

				arg_206_1.text_.text = var_209_19

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_20 = 36
				local var_209_21 = utf8.len(var_209_19)
				local var_209_22 = var_209_20 <= 0 and var_209_16 or var_209_16 * (var_209_21 / var_209_20)

				if var_209_22 > 0 and var_209_16 < var_209_22 then
					arg_206_1.talkMaxDuration = var_209_22

					if var_209_22 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_22 + var_209_15
					end
				end

				arg_206_1.text_.text = var_209_19
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701051", "story_v_side_new_1104701.awb") ~= 0 then
					local var_209_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701051", "story_v_side_new_1104701.awb") / 1000

					if var_209_23 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_23 + var_209_15
					end

					if var_209_18.prefab_name ~= "" and arg_206_1.actors_[var_209_18.prefab_name] ~= nil then
						local var_209_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_18.prefab_name].transform, "story_v_side_new_1104701", "1104701051", "story_v_side_new_1104701.awb")

						arg_206_1:RecordAudio("1104701051", var_209_24)
						arg_206_1:RecordAudio("1104701051", var_209_24)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701051", "story_v_side_new_1104701.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701051", "story_v_side_new_1104701.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_25 = math.max(var_209_16, arg_206_1.talkMaxDuration)

			if var_209_15 <= arg_206_1.time_ and arg_206_1.time_ < var_209_15 + var_209_25 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_15) / var_209_25

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_15 + var_209_25 and arg_206_1.time_ < var_209_15 + var_209_25 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play1104701052 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 1104701052
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play1104701053(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["1047ui_story"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1047ui_story == nil then
				arg_210_1.var_.characterEffect1047ui_story = var_213_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.200000002980232

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.characterEffect1047ui_story and not isNil(var_213_0) then
					local var_213_4 = Mathf.Lerp(0, 0.5, var_213_3)

					arg_210_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1047ui_story.fillRatio = var_213_4
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1047ui_story then
				local var_213_5 = 0.5

				arg_210_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1047ui_story.fillRatio = var_213_5
			end

			local var_213_6 = arg_210_1.actors_["1047ui_story"].transform
			local var_213_7 = 0

			if var_213_7 < arg_210_1.time_ and arg_210_1.time_ <= var_213_7 + arg_213_0 then
				arg_210_1.var_.moveOldPos1047ui_story = var_213_6.localPosition
			end

			local var_213_8 = 0.001

			if var_213_7 <= arg_210_1.time_ and arg_210_1.time_ < var_213_7 + var_213_8 then
				local var_213_9 = (arg_210_1.time_ - var_213_7) / var_213_8
				local var_213_10 = Vector3.New(0, 100, 0)

				var_213_6.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1047ui_story, var_213_10, var_213_9)

				local var_213_11 = manager.ui.mainCamera.transform.position - var_213_6.position

				var_213_6.forward = Vector3.New(var_213_11.x, var_213_11.y, var_213_11.z)

				local var_213_12 = var_213_6.localEulerAngles

				var_213_12.z = 0
				var_213_12.x = 0
				var_213_6.localEulerAngles = var_213_12
			end

			if arg_210_1.time_ >= var_213_7 + var_213_8 and arg_210_1.time_ < var_213_7 + var_213_8 + arg_213_0 then
				var_213_6.localPosition = Vector3.New(0, 100, 0)

				local var_213_13 = manager.ui.mainCamera.transform.position - var_213_6.position

				var_213_6.forward = Vector3.New(var_213_13.x, var_213_13.y, var_213_13.z)

				local var_213_14 = var_213_6.localEulerAngles

				var_213_14.z = 0
				var_213_14.x = 0
				var_213_6.localEulerAngles = var_213_14
			end

			local var_213_15 = 0
			local var_213_16 = 0.8

			if var_213_15 < arg_210_1.time_ and arg_210_1.time_ <= var_213_15 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_17 = arg_210_1:GetWordFromCfg(1104701052)
				local var_213_18 = arg_210_1:FormatText(var_213_17.content)

				arg_210_1.text_.text = var_213_18

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_19 = 32
				local var_213_20 = utf8.len(var_213_18)
				local var_213_21 = var_213_19 <= 0 and var_213_16 or var_213_16 * (var_213_20 / var_213_19)

				if var_213_21 > 0 and var_213_16 < var_213_21 then
					arg_210_1.talkMaxDuration = var_213_21

					if var_213_21 + var_213_15 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_21 + var_213_15
					end
				end

				arg_210_1.text_.text = var_213_18
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_22 = math.max(var_213_16, arg_210_1.talkMaxDuration)

			if var_213_15 <= arg_210_1.time_ and arg_210_1.time_ < var_213_15 + var_213_22 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_15) / var_213_22

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_15 + var_213_22 and arg_210_1.time_ < var_213_15 + var_213_22 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play1104701053 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 1104701053
		arg_214_1.duration_ = 9.07

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play1104701054(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["1047ui_story"].transform
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.var_.moveOldPos1047ui_story = var_217_0.localPosition
			end

			local var_217_2 = 0.001

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2
				local var_217_4 = Vector3.New(0, -1.13, -6.2)

				var_217_0.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1047ui_story, var_217_4, var_217_3)

				local var_217_5 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_5.x, var_217_5.y, var_217_5.z)

				local var_217_6 = var_217_0.localEulerAngles

				var_217_6.z = 0
				var_217_6.x = 0
				var_217_0.localEulerAngles = var_217_6
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 then
				var_217_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_217_7 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_7.x, var_217_7.y, var_217_7.z)

				local var_217_8 = var_217_0.localEulerAngles

				var_217_8.z = 0
				var_217_8.x = 0
				var_217_0.localEulerAngles = var_217_8
			end

			local var_217_9 = arg_214_1.actors_["1047ui_story"]
			local var_217_10 = 0

			if var_217_10 < arg_214_1.time_ and arg_214_1.time_ <= var_217_10 + arg_217_0 and not isNil(var_217_9) and arg_214_1.var_.characterEffect1047ui_story == nil then
				arg_214_1.var_.characterEffect1047ui_story = var_217_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_11 = 0.200000002980232

			if var_217_10 <= arg_214_1.time_ and arg_214_1.time_ < var_217_10 + var_217_11 and not isNil(var_217_9) then
				local var_217_12 = (arg_214_1.time_ - var_217_10) / var_217_11

				if arg_214_1.var_.characterEffect1047ui_story and not isNil(var_217_9) then
					arg_214_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= var_217_10 + var_217_11 and arg_214_1.time_ < var_217_10 + var_217_11 + arg_217_0 and not isNil(var_217_9) and arg_214_1.var_.characterEffect1047ui_story then
				arg_214_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_217_13 = 0

			if var_217_13 < arg_214_1.time_ and arg_214_1.time_ <= var_217_13 + arg_217_0 then
				arg_214_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action453")
			end

			local var_217_14 = 0

			if var_217_14 < arg_214_1.time_ and arg_214_1.time_ <= var_217_14 + arg_217_0 then
				arg_214_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_217_15 = 0
			local var_217_16 = 1

			if var_217_15 < arg_214_1.time_ and arg_214_1.time_ <= var_217_15 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_17 = arg_214_1:FormatText(StoryNameCfg[1296].name)

				arg_214_1.leftNameTxt_.text = var_217_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_18 = arg_214_1:GetWordFromCfg(1104701053)
				local var_217_19 = arg_214_1:FormatText(var_217_18.content)

				arg_214_1.text_.text = var_217_19

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_20 = 40
				local var_217_21 = utf8.len(var_217_19)
				local var_217_22 = var_217_20 <= 0 and var_217_16 or var_217_16 * (var_217_21 / var_217_20)

				if var_217_22 > 0 and var_217_16 < var_217_22 then
					arg_214_1.talkMaxDuration = var_217_22

					if var_217_22 + var_217_15 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_22 + var_217_15
					end
				end

				arg_214_1.text_.text = var_217_19
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701053", "story_v_side_new_1104701.awb") ~= 0 then
					local var_217_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701053", "story_v_side_new_1104701.awb") / 1000

					if var_217_23 + var_217_15 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_23 + var_217_15
					end

					if var_217_18.prefab_name ~= "" and arg_214_1.actors_[var_217_18.prefab_name] ~= nil then
						local var_217_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_18.prefab_name].transform, "story_v_side_new_1104701", "1104701053", "story_v_side_new_1104701.awb")

						arg_214_1:RecordAudio("1104701053", var_217_24)
						arg_214_1:RecordAudio("1104701053", var_217_24)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701053", "story_v_side_new_1104701.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701053", "story_v_side_new_1104701.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_25 = math.max(var_217_16, arg_214_1.talkMaxDuration)

			if var_217_15 <= arg_214_1.time_ and arg_214_1.time_ < var_217_15 + var_217_25 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_15) / var_217_25

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_15 + var_217_25 and arg_214_1.time_ < var_217_15 + var_217_25 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play1104701054 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 1104701054
		arg_218_1.duration_ = 6.57

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play1104701055(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["1047ui_story"].transform
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.var_.moveOldPos1047ui_story = var_221_0.localPosition
			end

			local var_221_2 = 0.001

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2
				local var_221_4 = Vector3.New(0, -1.13, -6.2)

				var_221_0.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1047ui_story, var_221_4, var_221_3)

				local var_221_5 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_5.x, var_221_5.y, var_221_5.z)

				local var_221_6 = var_221_0.localEulerAngles

				var_221_6.z = 0
				var_221_6.x = 0
				var_221_0.localEulerAngles = var_221_6
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 then
				var_221_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_221_7 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_7.x, var_221_7.y, var_221_7.z)

				local var_221_8 = var_221_0.localEulerAngles

				var_221_8.z = 0
				var_221_8.x = 0
				var_221_0.localEulerAngles = var_221_8
			end

			local var_221_9 = 0

			if var_221_9 < arg_218_1.time_ and arg_218_1.time_ <= var_221_9 + arg_221_0 then
				arg_218_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_2")
			end

			local var_221_10 = 0

			if var_221_10 < arg_218_1.time_ and arg_218_1.time_ <= var_221_10 + arg_221_0 then
				arg_218_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_221_11 = arg_218_1.actors_["1047ui_story"]
			local var_221_12 = 0

			if var_221_12 < arg_218_1.time_ and arg_218_1.time_ <= var_221_12 + arg_221_0 and not isNil(var_221_11) and arg_218_1.var_.characterEffect1047ui_story == nil then
				arg_218_1.var_.characterEffect1047ui_story = var_221_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_13 = 0.200000002980232

			if var_221_12 <= arg_218_1.time_ and arg_218_1.time_ < var_221_12 + var_221_13 and not isNil(var_221_11) then
				local var_221_14 = (arg_218_1.time_ - var_221_12) / var_221_13

				if arg_218_1.var_.characterEffect1047ui_story and not isNil(var_221_11) then
					arg_218_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= var_221_12 + var_221_13 and arg_218_1.time_ < var_221_12 + var_221_13 + arg_221_0 and not isNil(var_221_11) and arg_218_1.var_.characterEffect1047ui_story then
				arg_218_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_221_15 = 0
			local var_221_16 = 0.775

			if var_221_15 < arg_218_1.time_ and arg_218_1.time_ <= var_221_15 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_17 = arg_218_1:FormatText(StoryNameCfg[1296].name)

				arg_218_1.leftNameTxt_.text = var_221_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_18 = arg_218_1:GetWordFromCfg(1104701054)
				local var_221_19 = arg_218_1:FormatText(var_221_18.content)

				arg_218_1.text_.text = var_221_19

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_20 = 31
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701054", "story_v_side_new_1104701.awb") ~= 0 then
					local var_221_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701054", "story_v_side_new_1104701.awb") / 1000

					if var_221_23 + var_221_15 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_23 + var_221_15
					end

					if var_221_18.prefab_name ~= "" and arg_218_1.actors_[var_221_18.prefab_name] ~= nil then
						local var_221_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_18.prefab_name].transform, "story_v_side_new_1104701", "1104701054", "story_v_side_new_1104701.awb")

						arg_218_1:RecordAudio("1104701054", var_221_24)
						arg_218_1:RecordAudio("1104701054", var_221_24)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701054", "story_v_side_new_1104701.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701054", "story_v_side_new_1104701.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_25 = math.max(var_221_16, arg_218_1.talkMaxDuration)

			if var_221_15 <= arg_218_1.time_ and arg_218_1.time_ < var_221_15 + var_221_25 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_15) / var_221_25

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_15 + var_221_25 and arg_218_1.time_ < var_221_15 + var_221_25 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play1104701055 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1104701055
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1104701056(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["1047ui_story"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect1047ui_story == nil then
				arg_222_1.var_.characterEffect1047ui_story = var_225_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.200000002980232

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.characterEffect1047ui_story and not isNil(var_225_0) then
					local var_225_4 = Mathf.Lerp(0, 0.5, var_225_3)

					arg_222_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1047ui_story.fillRatio = var_225_4
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect1047ui_story then
				local var_225_5 = 0.5

				arg_222_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1047ui_story.fillRatio = var_225_5
			end

			local var_225_6 = 0
			local var_225_7 = 0.65

			if var_225_6 < arg_222_1.time_ and arg_222_1.time_ <= var_225_6 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_8 = arg_222_1:GetWordFromCfg(1104701055)
				local var_225_9 = arg_222_1:FormatText(var_225_8.content)

				arg_222_1.text_.text = var_225_9

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_10 = 26
				local var_225_11 = utf8.len(var_225_9)
				local var_225_12 = var_225_10 <= 0 and var_225_7 or var_225_7 * (var_225_11 / var_225_10)

				if var_225_12 > 0 and var_225_7 < var_225_12 then
					arg_222_1.talkMaxDuration = var_225_12

					if var_225_12 + var_225_6 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_12 + var_225_6
					end
				end

				arg_222_1.text_.text = var_225_9
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_13 = math.max(var_225_7, arg_222_1.talkMaxDuration)

			if var_225_6 <= arg_222_1.time_ and arg_222_1.time_ < var_225_6 + var_225_13 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_6) / var_225_13

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_6 + var_225_13 and arg_222_1.time_ < var_225_6 + var_225_13 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play1104701056 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 1104701056
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play1104701057(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0
			local var_229_1 = 0.475

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

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_3 = arg_226_1:GetWordFromCfg(1104701056)
				local var_229_4 = arg_226_1:FormatText(var_229_3.content)

				arg_226_1.text_.text = var_229_4

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 19
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
	Play1104701057 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 1104701057
		arg_230_1.duration_ = 8.33

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play1104701058(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["1047ui_story"]
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect1047ui_story == nil then
				arg_230_1.var_.characterEffect1047ui_story = var_233_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_2 = 0.200000002980232

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 and not isNil(var_233_0) then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2

				if arg_230_1.var_.characterEffect1047ui_story and not isNil(var_233_0) then
					arg_230_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect1047ui_story then
				arg_230_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_233_4 = 0

			if var_233_4 < arg_230_1.time_ and arg_230_1.time_ <= var_233_4 + arg_233_0 then
				arg_230_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_233_5 = 0

			if var_233_5 < arg_230_1.time_ and arg_230_1.time_ <= var_233_5 + arg_233_0 then
				arg_230_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_233_6 = 0
			local var_233_7 = 0.9

			if var_233_6 < arg_230_1.time_ and arg_230_1.time_ <= var_233_6 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_8 = arg_230_1:FormatText(StoryNameCfg[1296].name)

				arg_230_1.leftNameTxt_.text = var_233_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_9 = arg_230_1:GetWordFromCfg(1104701057)
				local var_233_10 = arg_230_1:FormatText(var_233_9.content)

				arg_230_1.text_.text = var_233_10

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_11 = 36
				local var_233_12 = utf8.len(var_233_10)
				local var_233_13 = var_233_11 <= 0 and var_233_7 or var_233_7 * (var_233_12 / var_233_11)

				if var_233_13 > 0 and var_233_7 < var_233_13 then
					arg_230_1.talkMaxDuration = var_233_13

					if var_233_13 + var_233_6 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_13 + var_233_6
					end
				end

				arg_230_1.text_.text = var_233_10
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701057", "story_v_side_new_1104701.awb") ~= 0 then
					local var_233_14 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701057", "story_v_side_new_1104701.awb") / 1000

					if var_233_14 + var_233_6 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_14 + var_233_6
					end

					if var_233_9.prefab_name ~= "" and arg_230_1.actors_[var_233_9.prefab_name] ~= nil then
						local var_233_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_9.prefab_name].transform, "story_v_side_new_1104701", "1104701057", "story_v_side_new_1104701.awb")

						arg_230_1:RecordAudio("1104701057", var_233_15)
						arg_230_1:RecordAudio("1104701057", var_233_15)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701057", "story_v_side_new_1104701.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701057", "story_v_side_new_1104701.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_16 = math.max(var_233_7, arg_230_1.talkMaxDuration)

			if var_233_6 <= arg_230_1.time_ and arg_230_1.time_ < var_233_6 + var_233_16 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_6) / var_233_16

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_6 + var_233_16 and arg_230_1.time_ < var_233_6 + var_233_16 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play1104701058 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 1104701058
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play1104701059(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["1047ui_story"]
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1047ui_story == nil then
				arg_234_1.var_.characterEffect1047ui_story = var_237_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.200000002980232

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 and not isNil(var_237_0) then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2

				if arg_234_1.var_.characterEffect1047ui_story and not isNil(var_237_0) then
					local var_237_4 = Mathf.Lerp(0, 0.5, var_237_3)

					arg_234_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_234_1.var_.characterEffect1047ui_story.fillRatio = var_237_4
				end
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1047ui_story then
				local var_237_5 = 0.5

				arg_234_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_234_1.var_.characterEffect1047ui_story.fillRatio = var_237_5
			end

			local var_237_6 = 0
			local var_237_7 = 0.425

			if var_237_6 < arg_234_1.time_ and arg_234_1.time_ <= var_237_6 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_8 = arg_234_1:FormatText(StoryNameCfg[7].name)

				arg_234_1.leftNameTxt_.text = var_237_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_9 = arg_234_1:GetWordFromCfg(1104701058)
				local var_237_10 = arg_234_1:FormatText(var_237_9.content)

				arg_234_1.text_.text = var_237_10

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_11 = 17
				local var_237_12 = utf8.len(var_237_10)
				local var_237_13 = var_237_11 <= 0 and var_237_7 or var_237_7 * (var_237_12 / var_237_11)

				if var_237_13 > 0 and var_237_7 < var_237_13 then
					arg_234_1.talkMaxDuration = var_237_13

					if var_237_13 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_13 + var_237_6
					end
				end

				arg_234_1.text_.text = var_237_10
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_14 = math.max(var_237_7, arg_234_1.talkMaxDuration)

			if var_237_6 <= arg_234_1.time_ and arg_234_1.time_ < var_237_6 + var_237_14 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_6) / var_237_14

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_6 + var_237_14 and arg_234_1.time_ < var_237_6 + var_237_14 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play1104701059 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1104701059
		arg_238_1.duration_ = 6.53

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1104701060(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["1047ui_story"].transform
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.var_.moveOldPos1047ui_story = var_241_0.localPosition
			end

			local var_241_2 = 0.001

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2
				local var_241_4 = Vector3.New(0, -1.13, -6.2)

				var_241_0.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1047ui_story, var_241_4, var_241_3)

				local var_241_5 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_5.x, var_241_5.y, var_241_5.z)

				local var_241_6 = var_241_0.localEulerAngles

				var_241_6.z = 0
				var_241_6.x = 0
				var_241_0.localEulerAngles = var_241_6
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 then
				var_241_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_241_7 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_7.x, var_241_7.y, var_241_7.z)

				local var_241_8 = var_241_0.localEulerAngles

				var_241_8.z = 0
				var_241_8.x = 0
				var_241_0.localEulerAngles = var_241_8
			end

			local var_241_9 = arg_238_1.actors_["1047ui_story"]
			local var_241_10 = 0

			if var_241_10 < arg_238_1.time_ and arg_238_1.time_ <= var_241_10 + arg_241_0 and not isNil(var_241_9) and arg_238_1.var_.characterEffect1047ui_story == nil then
				arg_238_1.var_.characterEffect1047ui_story = var_241_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_11 = 0.200000002980232

			if var_241_10 <= arg_238_1.time_ and arg_238_1.time_ < var_241_10 + var_241_11 and not isNil(var_241_9) then
				local var_241_12 = (arg_238_1.time_ - var_241_10) / var_241_11

				if arg_238_1.var_.characterEffect1047ui_story and not isNil(var_241_9) then
					arg_238_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= var_241_10 + var_241_11 and arg_238_1.time_ < var_241_10 + var_241_11 + arg_241_0 and not isNil(var_241_9) and arg_238_1.var_.characterEffect1047ui_story then
				arg_238_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_241_13 = 0

			if var_241_13 < arg_238_1.time_ and arg_238_1.time_ <= var_241_13 + arg_241_0 then
				arg_238_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			local var_241_14 = 0

			if var_241_14 < arg_238_1.time_ and arg_238_1.time_ <= var_241_14 + arg_241_0 then
				arg_238_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_241_15 = 0
			local var_241_16 = 0.725

			if var_241_15 < arg_238_1.time_ and arg_238_1.time_ <= var_241_15 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_17 = arg_238_1:FormatText(StoryNameCfg[1296].name)

				arg_238_1.leftNameTxt_.text = var_241_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_18 = arg_238_1:GetWordFromCfg(1104701059)
				local var_241_19 = arg_238_1:FormatText(var_241_18.content)

				arg_238_1.text_.text = var_241_19

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_20 = 29
				local var_241_21 = utf8.len(var_241_19)
				local var_241_22 = var_241_20 <= 0 and var_241_16 or var_241_16 * (var_241_21 / var_241_20)

				if var_241_22 > 0 and var_241_16 < var_241_22 then
					arg_238_1.talkMaxDuration = var_241_22

					if var_241_22 + var_241_15 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_22 + var_241_15
					end
				end

				arg_238_1.text_.text = var_241_19
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701059", "story_v_side_new_1104701.awb") ~= 0 then
					local var_241_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701059", "story_v_side_new_1104701.awb") / 1000

					if var_241_23 + var_241_15 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_23 + var_241_15
					end

					if var_241_18.prefab_name ~= "" and arg_238_1.actors_[var_241_18.prefab_name] ~= nil then
						local var_241_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_18.prefab_name].transform, "story_v_side_new_1104701", "1104701059", "story_v_side_new_1104701.awb")

						arg_238_1:RecordAudio("1104701059", var_241_24)
						arg_238_1:RecordAudio("1104701059", var_241_24)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701059", "story_v_side_new_1104701.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701059", "story_v_side_new_1104701.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_25 = math.max(var_241_16, arg_238_1.talkMaxDuration)

			if var_241_15 <= arg_238_1.time_ and arg_238_1.time_ < var_241_15 + var_241_25 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_15) / var_241_25

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_15 + var_241_25 and arg_238_1.time_ < var_241_15 + var_241_25 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play1104701060 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 1104701060
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play1104701061(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["1047ui_story"]
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1047ui_story == nil then
				arg_242_1.var_.characterEffect1047ui_story = var_245_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.200000002980232

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 and not isNil(var_245_0) then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2

				if arg_242_1.var_.characterEffect1047ui_story and not isNil(var_245_0) then
					local var_245_4 = Mathf.Lerp(0, 0.5, var_245_3)

					arg_242_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_242_1.var_.characterEffect1047ui_story.fillRatio = var_245_4
				end
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1047ui_story then
				local var_245_5 = 0.5

				arg_242_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_242_1.var_.characterEffect1047ui_story.fillRatio = var_245_5
			end

			local var_245_6 = arg_242_1.actors_["1047ui_story"].transform
			local var_245_7 = 0

			if var_245_7 < arg_242_1.time_ and arg_242_1.time_ <= var_245_7 + arg_245_0 then
				arg_242_1.var_.moveOldPos1047ui_story = var_245_6.localPosition
			end

			local var_245_8 = 0.001

			if var_245_7 <= arg_242_1.time_ and arg_242_1.time_ < var_245_7 + var_245_8 then
				local var_245_9 = (arg_242_1.time_ - var_245_7) / var_245_8
				local var_245_10 = Vector3.New(0, 100, 0)

				var_245_6.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1047ui_story, var_245_10, var_245_9)

				local var_245_11 = manager.ui.mainCamera.transform.position - var_245_6.position

				var_245_6.forward = Vector3.New(var_245_11.x, var_245_11.y, var_245_11.z)

				local var_245_12 = var_245_6.localEulerAngles

				var_245_12.z = 0
				var_245_12.x = 0
				var_245_6.localEulerAngles = var_245_12
			end

			if arg_242_1.time_ >= var_245_7 + var_245_8 and arg_242_1.time_ < var_245_7 + var_245_8 + arg_245_0 then
				var_245_6.localPosition = Vector3.New(0, 100, 0)

				local var_245_13 = manager.ui.mainCamera.transform.position - var_245_6.position

				var_245_6.forward = Vector3.New(var_245_13.x, var_245_13.y, var_245_13.z)

				local var_245_14 = var_245_6.localEulerAngles

				var_245_14.z = 0
				var_245_14.x = 0
				var_245_6.localEulerAngles = var_245_14
			end

			local var_245_15 = 0.1
			local var_245_16 = 1

			if var_245_15 < arg_242_1.time_ and arg_242_1.time_ <= var_245_15 + arg_245_0 then
				local var_245_17 = "play"
				local var_245_18 = "effect"

				arg_242_1:AudioAction(var_245_17, var_245_18, "se_story_side_1148", "se_story_1148_vibrate", "")
			end

			local var_245_19 = 0
			local var_245_20 = 0.9

			if var_245_19 < arg_242_1.time_ and arg_242_1.time_ <= var_245_19 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_21 = arg_242_1:GetWordFromCfg(1104701060)
				local var_245_22 = arg_242_1:FormatText(var_245_21.content)

				arg_242_1.text_.text = var_245_22

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_23 = 36
				local var_245_24 = utf8.len(var_245_22)
				local var_245_25 = var_245_23 <= 0 and var_245_20 or var_245_20 * (var_245_24 / var_245_23)

				if var_245_25 > 0 and var_245_20 < var_245_25 then
					arg_242_1.talkMaxDuration = var_245_25

					if var_245_25 + var_245_19 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_25 + var_245_19
					end
				end

				arg_242_1.text_.text = var_245_22
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_26 = math.max(var_245_20, arg_242_1.talkMaxDuration)

			if var_245_19 <= arg_242_1.time_ and arg_242_1.time_ < var_245_19 + var_245_26 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_19) / var_245_26

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_19 + var_245_26 and arg_242_1.time_ < var_245_19 + var_245_26 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play1104701061 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 1104701061
		arg_246_1.duration_ = 11.3

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play1104701062(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["1047ui_story"].transform
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.var_.moveOldPos1047ui_story = var_249_0.localPosition
			end

			local var_249_2 = 0.001

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2
				local var_249_4 = Vector3.New(0, -1.13, -6.2)

				var_249_0.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1047ui_story, var_249_4, var_249_3)

				local var_249_5 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_5.x, var_249_5.y, var_249_5.z)

				local var_249_6 = var_249_0.localEulerAngles

				var_249_6.z = 0
				var_249_6.x = 0
				var_249_0.localEulerAngles = var_249_6
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 then
				var_249_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_249_7 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_7.x, var_249_7.y, var_249_7.z)

				local var_249_8 = var_249_0.localEulerAngles

				var_249_8.z = 0
				var_249_8.x = 0
				var_249_0.localEulerAngles = var_249_8
			end

			local var_249_9 = arg_246_1.actors_["1047ui_story"]
			local var_249_10 = 0

			if var_249_10 < arg_246_1.time_ and arg_246_1.time_ <= var_249_10 + arg_249_0 and not isNil(var_249_9) and arg_246_1.var_.characterEffect1047ui_story == nil then
				arg_246_1.var_.characterEffect1047ui_story = var_249_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_11 = 0.200000002980232

			if var_249_10 <= arg_246_1.time_ and arg_246_1.time_ < var_249_10 + var_249_11 and not isNil(var_249_9) then
				local var_249_12 = (arg_246_1.time_ - var_249_10) / var_249_11

				if arg_246_1.var_.characterEffect1047ui_story and not isNil(var_249_9) then
					arg_246_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= var_249_10 + var_249_11 and arg_246_1.time_ < var_249_10 + var_249_11 + arg_249_0 and not isNil(var_249_9) and arg_246_1.var_.characterEffect1047ui_story then
				arg_246_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_249_13 = 0

			if var_249_13 < arg_246_1.time_ and arg_246_1.time_ <= var_249_13 + arg_249_0 then
				arg_246_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_249_14 = 0

			if var_249_14 < arg_246_1.time_ and arg_246_1.time_ <= var_249_14 + arg_249_0 then
				arg_246_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_249_15 = 0
			local var_249_16 = 1.375

			if var_249_15 < arg_246_1.time_ and arg_246_1.time_ <= var_249_15 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_17 = arg_246_1:FormatText(StoryNameCfg[1296].name)

				arg_246_1.leftNameTxt_.text = var_249_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_18 = arg_246_1:GetWordFromCfg(1104701061)
				local var_249_19 = arg_246_1:FormatText(var_249_18.content)

				arg_246_1.text_.text = var_249_19

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_20 = 55
				local var_249_21 = utf8.len(var_249_19)
				local var_249_22 = var_249_20 <= 0 and var_249_16 or var_249_16 * (var_249_21 / var_249_20)

				if var_249_22 > 0 and var_249_16 < var_249_22 then
					arg_246_1.talkMaxDuration = var_249_22

					if var_249_22 + var_249_15 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_22 + var_249_15
					end
				end

				arg_246_1.text_.text = var_249_19
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701061", "story_v_side_new_1104701.awb") ~= 0 then
					local var_249_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701061", "story_v_side_new_1104701.awb") / 1000

					if var_249_23 + var_249_15 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_23 + var_249_15
					end

					if var_249_18.prefab_name ~= "" and arg_246_1.actors_[var_249_18.prefab_name] ~= nil then
						local var_249_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_18.prefab_name].transform, "story_v_side_new_1104701", "1104701061", "story_v_side_new_1104701.awb")

						arg_246_1:RecordAudio("1104701061", var_249_24)
						arg_246_1:RecordAudio("1104701061", var_249_24)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701061", "story_v_side_new_1104701.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701061", "story_v_side_new_1104701.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_25 = math.max(var_249_16, arg_246_1.talkMaxDuration)

			if var_249_15 <= arg_246_1.time_ and arg_246_1.time_ < var_249_15 + var_249_25 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_15) / var_249_25

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_15 + var_249_25 and arg_246_1.time_ < var_249_15 + var_249_25 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play1104701062 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1104701062
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1104701063(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["1047ui_story"]
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect1047ui_story == nil then
				arg_250_1.var_.characterEffect1047ui_story = var_253_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_2 = 0.200000002980232

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 and not isNil(var_253_0) then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2

				if arg_250_1.var_.characterEffect1047ui_story and not isNil(var_253_0) then
					local var_253_4 = Mathf.Lerp(0, 0.5, var_253_3)

					arg_250_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_250_1.var_.characterEffect1047ui_story.fillRatio = var_253_4
				end
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect1047ui_story then
				local var_253_5 = 0.5

				arg_250_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_250_1.var_.characterEffect1047ui_story.fillRatio = var_253_5
			end

			local var_253_6 = 0
			local var_253_7 = 0.6

			if var_253_6 < arg_250_1.time_ and arg_250_1.time_ <= var_253_6 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_8 = arg_250_1:FormatText(StoryNameCfg[7].name)

				arg_250_1.leftNameTxt_.text = var_253_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_9 = arg_250_1:GetWordFromCfg(1104701062)
				local var_253_10 = arg_250_1:FormatText(var_253_9.content)

				arg_250_1.text_.text = var_253_10

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_11 = 24
				local var_253_12 = utf8.len(var_253_10)
				local var_253_13 = var_253_11 <= 0 and var_253_7 or var_253_7 * (var_253_12 / var_253_11)

				if var_253_13 > 0 and var_253_7 < var_253_13 then
					arg_250_1.talkMaxDuration = var_253_13

					if var_253_13 + var_253_6 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_13 + var_253_6
					end
				end

				arg_250_1.text_.text = var_253_10
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_14 = math.max(var_253_7, arg_250_1.talkMaxDuration)

			if var_253_6 <= arg_250_1.time_ and arg_250_1.time_ < var_253_6 + var_253_14 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_6) / var_253_14

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_6 + var_253_14 and arg_250_1.time_ < var_253_6 + var_253_14 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play1104701063 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 1104701063
		arg_254_1.duration_ = 13.6

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play1104701064(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1047ui_story"].transform
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 then
				arg_254_1.var_.moveOldPos1047ui_story = var_257_0.localPosition
			end

			local var_257_2 = 0.001

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2
				local var_257_4 = Vector3.New(0, -1.13, -6.2)

				var_257_0.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1047ui_story, var_257_4, var_257_3)

				local var_257_5 = manager.ui.mainCamera.transform.position - var_257_0.position

				var_257_0.forward = Vector3.New(var_257_5.x, var_257_5.y, var_257_5.z)

				local var_257_6 = var_257_0.localEulerAngles

				var_257_6.z = 0
				var_257_6.x = 0
				var_257_0.localEulerAngles = var_257_6
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 then
				var_257_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_257_7 = manager.ui.mainCamera.transform.position - var_257_0.position

				var_257_0.forward = Vector3.New(var_257_7.x, var_257_7.y, var_257_7.z)

				local var_257_8 = var_257_0.localEulerAngles

				var_257_8.z = 0
				var_257_8.x = 0
				var_257_0.localEulerAngles = var_257_8
			end

			local var_257_9 = arg_254_1.actors_["1047ui_story"]
			local var_257_10 = 0

			if var_257_10 < arg_254_1.time_ and arg_254_1.time_ <= var_257_10 + arg_257_0 and not isNil(var_257_9) and arg_254_1.var_.characterEffect1047ui_story == nil then
				arg_254_1.var_.characterEffect1047ui_story = var_257_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_11 = 0.200000002980232

			if var_257_10 <= arg_254_1.time_ and arg_254_1.time_ < var_257_10 + var_257_11 and not isNil(var_257_9) then
				local var_257_12 = (arg_254_1.time_ - var_257_10) / var_257_11

				if arg_254_1.var_.characterEffect1047ui_story and not isNil(var_257_9) then
					arg_254_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= var_257_10 + var_257_11 and arg_254_1.time_ < var_257_10 + var_257_11 + arg_257_0 and not isNil(var_257_9) and arg_254_1.var_.characterEffect1047ui_story then
				arg_254_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_257_13 = 0

			if var_257_13 < arg_254_1.time_ and arg_254_1.time_ <= var_257_13 + arg_257_0 then
				arg_254_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			local var_257_14 = 0

			if var_257_14 < arg_254_1.time_ and arg_254_1.time_ <= var_257_14 + arg_257_0 then
				arg_254_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_257_15 = 0
			local var_257_16 = 1.35

			if var_257_15 < arg_254_1.time_ and arg_254_1.time_ <= var_257_15 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_17 = arg_254_1:FormatText(StoryNameCfg[1296].name)

				arg_254_1.leftNameTxt_.text = var_257_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_18 = arg_254_1:GetWordFromCfg(1104701063)
				local var_257_19 = arg_254_1:FormatText(var_257_18.content)

				arg_254_1.text_.text = var_257_19

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_20 = 54
				local var_257_21 = utf8.len(var_257_19)
				local var_257_22 = var_257_20 <= 0 and var_257_16 or var_257_16 * (var_257_21 / var_257_20)

				if var_257_22 > 0 and var_257_16 < var_257_22 then
					arg_254_1.talkMaxDuration = var_257_22

					if var_257_22 + var_257_15 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_22 + var_257_15
					end
				end

				arg_254_1.text_.text = var_257_19
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701063", "story_v_side_new_1104701.awb") ~= 0 then
					local var_257_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701063", "story_v_side_new_1104701.awb") / 1000

					if var_257_23 + var_257_15 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_23 + var_257_15
					end

					if var_257_18.prefab_name ~= "" and arg_254_1.actors_[var_257_18.prefab_name] ~= nil then
						local var_257_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_18.prefab_name].transform, "story_v_side_new_1104701", "1104701063", "story_v_side_new_1104701.awb")

						arg_254_1:RecordAudio("1104701063", var_257_24)
						arg_254_1:RecordAudio("1104701063", var_257_24)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701063", "story_v_side_new_1104701.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701063", "story_v_side_new_1104701.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_25 = math.max(var_257_16, arg_254_1.talkMaxDuration)

			if var_257_15 <= arg_254_1.time_ and arg_254_1.time_ < var_257_15 + var_257_25 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_15) / var_257_25

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_15 + var_257_25 and arg_254_1.time_ < var_257_15 + var_257_25 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play1104701064 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 1104701064
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play1104701065(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["1047ui_story"]
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect1047ui_story == nil then
				arg_258_1.var_.characterEffect1047ui_story = var_261_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.200000002980232

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 and not isNil(var_261_0) then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2

				if arg_258_1.var_.characterEffect1047ui_story and not isNil(var_261_0) then
					local var_261_4 = Mathf.Lerp(0, 0.5, var_261_3)

					arg_258_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_258_1.var_.characterEffect1047ui_story.fillRatio = var_261_4
				end
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect1047ui_story then
				local var_261_5 = 0.5

				arg_258_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_258_1.var_.characterEffect1047ui_story.fillRatio = var_261_5
			end

			local var_261_6 = arg_258_1.actors_["1047ui_story"].transform
			local var_261_7 = 0

			if var_261_7 < arg_258_1.time_ and arg_258_1.time_ <= var_261_7 + arg_261_0 then
				arg_258_1.var_.moveOldPos1047ui_story = var_261_6.localPosition
			end

			local var_261_8 = 0.001

			if var_261_7 <= arg_258_1.time_ and arg_258_1.time_ < var_261_7 + var_261_8 then
				local var_261_9 = (arg_258_1.time_ - var_261_7) / var_261_8
				local var_261_10 = Vector3.New(0, 100, 0)

				var_261_6.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1047ui_story, var_261_10, var_261_9)

				local var_261_11 = manager.ui.mainCamera.transform.position - var_261_6.position

				var_261_6.forward = Vector3.New(var_261_11.x, var_261_11.y, var_261_11.z)

				local var_261_12 = var_261_6.localEulerAngles

				var_261_12.z = 0
				var_261_12.x = 0
				var_261_6.localEulerAngles = var_261_12
			end

			if arg_258_1.time_ >= var_261_7 + var_261_8 and arg_258_1.time_ < var_261_7 + var_261_8 + arg_261_0 then
				var_261_6.localPosition = Vector3.New(0, 100, 0)

				local var_261_13 = manager.ui.mainCamera.transform.position - var_261_6.position

				var_261_6.forward = Vector3.New(var_261_13.x, var_261_13.y, var_261_13.z)

				local var_261_14 = var_261_6.localEulerAngles

				var_261_14.z = 0
				var_261_14.x = 0
				var_261_6.localEulerAngles = var_261_14
			end

			local var_261_15 = 0
			local var_261_16 = 0.95

			if var_261_15 < arg_258_1.time_ and arg_258_1.time_ <= var_261_15 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_17 = arg_258_1:GetWordFromCfg(1104701064)
				local var_261_18 = arg_258_1:FormatText(var_261_17.content)

				arg_258_1.text_.text = var_261_18

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_19 = 38
				local var_261_20 = utf8.len(var_261_18)
				local var_261_21 = var_261_19 <= 0 and var_261_16 or var_261_16 * (var_261_20 / var_261_19)

				if var_261_21 > 0 and var_261_16 < var_261_21 then
					arg_258_1.talkMaxDuration = var_261_21

					if var_261_21 + var_261_15 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_21 + var_261_15
					end
				end

				arg_258_1.text_.text = var_261_18
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_22 = math.max(var_261_16, arg_258_1.talkMaxDuration)

			if var_261_15 <= arg_258_1.time_ and arg_258_1.time_ < var_261_15 + var_261_22 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_15) / var_261_22

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_15 + var_261_22 and arg_258_1.time_ < var_261_15 + var_261_22 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play1104701065 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 1104701065
		arg_262_1.duration_ = 4.33

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play1104701066(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["1047ui_story"].transform
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.var_.moveOldPos1047ui_story = var_265_0.localPosition
			end

			local var_265_2 = 0.001

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2
				local var_265_4 = Vector3.New(0, -1.13, -6.2)

				var_265_0.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1047ui_story, var_265_4, var_265_3)

				local var_265_5 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_5.x, var_265_5.y, var_265_5.z)

				local var_265_6 = var_265_0.localEulerAngles

				var_265_6.z = 0
				var_265_6.x = 0
				var_265_0.localEulerAngles = var_265_6
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 then
				var_265_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_265_7 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_7.x, var_265_7.y, var_265_7.z)

				local var_265_8 = var_265_0.localEulerAngles

				var_265_8.z = 0
				var_265_8.x = 0
				var_265_0.localEulerAngles = var_265_8
			end

			local var_265_9 = arg_262_1.actors_["1047ui_story"]
			local var_265_10 = 0

			if var_265_10 < arg_262_1.time_ and arg_262_1.time_ <= var_265_10 + arg_265_0 and not isNil(var_265_9) and arg_262_1.var_.characterEffect1047ui_story == nil then
				arg_262_1.var_.characterEffect1047ui_story = var_265_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_11 = 0.200000002980232

			if var_265_10 <= arg_262_1.time_ and arg_262_1.time_ < var_265_10 + var_265_11 and not isNil(var_265_9) then
				local var_265_12 = (arg_262_1.time_ - var_265_10) / var_265_11

				if arg_262_1.var_.characterEffect1047ui_story and not isNil(var_265_9) then
					arg_262_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= var_265_10 + var_265_11 and arg_262_1.time_ < var_265_10 + var_265_11 + arg_265_0 and not isNil(var_265_9) and arg_262_1.var_.characterEffect1047ui_story then
				arg_262_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_265_13 = 0

			if var_265_13 < arg_262_1.time_ and arg_262_1.time_ <= var_265_13 + arg_265_0 then
				arg_262_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			local var_265_14 = 0

			if var_265_14 < arg_262_1.time_ and arg_262_1.time_ <= var_265_14 + arg_265_0 then
				arg_262_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_265_15 = 0.1
			local var_265_16 = 1

			if var_265_15 < arg_262_1.time_ and arg_262_1.time_ <= var_265_15 + arg_265_0 then
				local var_265_17 = "play"
				local var_265_18 = "effect"

				arg_262_1:AudioAction(var_265_17, var_265_18, "se_story_side_1039", "se_story_1039_paper", "")
			end

			local var_265_19 = 0
			local var_265_20 = 0.5

			if var_265_19 < arg_262_1.time_ and arg_262_1.time_ <= var_265_19 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_21 = arg_262_1:FormatText(StoryNameCfg[1296].name)

				arg_262_1.leftNameTxt_.text = var_265_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_22 = arg_262_1:GetWordFromCfg(1104701065)
				local var_265_23 = arg_262_1:FormatText(var_265_22.content)

				arg_262_1.text_.text = var_265_23

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_24 = 20
				local var_265_25 = utf8.len(var_265_23)
				local var_265_26 = var_265_24 <= 0 and var_265_20 or var_265_20 * (var_265_25 / var_265_24)

				if var_265_26 > 0 and var_265_20 < var_265_26 then
					arg_262_1.talkMaxDuration = var_265_26

					if var_265_26 + var_265_19 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_26 + var_265_19
					end
				end

				arg_262_1.text_.text = var_265_23
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701065", "story_v_side_new_1104701.awb") ~= 0 then
					local var_265_27 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701065", "story_v_side_new_1104701.awb") / 1000

					if var_265_27 + var_265_19 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_27 + var_265_19
					end

					if var_265_22.prefab_name ~= "" and arg_262_1.actors_[var_265_22.prefab_name] ~= nil then
						local var_265_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_22.prefab_name].transform, "story_v_side_new_1104701", "1104701065", "story_v_side_new_1104701.awb")

						arg_262_1:RecordAudio("1104701065", var_265_28)
						arg_262_1:RecordAudio("1104701065", var_265_28)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701065", "story_v_side_new_1104701.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701065", "story_v_side_new_1104701.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_29 = math.max(var_265_20, arg_262_1.talkMaxDuration)

			if var_265_19 <= arg_262_1.time_ and arg_262_1.time_ < var_265_19 + var_265_29 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_19) / var_265_29

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_19 + var_265_29 and arg_262_1.time_ < var_265_19 + var_265_29 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play1104701066 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 1104701066
		arg_266_1.duration_ = 4.3

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play1104701067(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = "STblack"

			if arg_266_1.bgs_[var_269_0] == nil then
				local var_269_1 = Object.Instantiate(arg_266_1.paintGo_)

				var_269_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_269_0)
				var_269_1.name = var_269_0
				var_269_1.transform.parent = arg_266_1.stage_.transform
				var_269_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_266_1.bgs_[var_269_0] = var_269_1
			end

			local var_269_2 = 2

			if var_269_2 < arg_266_1.time_ and arg_266_1.time_ <= var_269_2 + arg_269_0 then
				local var_269_3 = manager.ui.mainCamera.transform.localPosition
				local var_269_4 = Vector3.New(0, 0, 10) + Vector3.New(var_269_3.x, var_269_3.y, 0)
				local var_269_5 = arg_266_1.bgs_.STblack

				var_269_5.transform.localPosition = var_269_4
				var_269_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_269_6 = var_269_5:GetComponent("SpriteRenderer")

				if var_269_6 and var_269_6.sprite then
					local var_269_7 = (var_269_5.transform.localPosition - var_269_3).z
					local var_269_8 = manager.ui.mainCameraCom_
					local var_269_9 = 2 * var_269_7 * Mathf.Tan(var_269_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_269_10 = var_269_9 * var_269_8.aspect
					local var_269_11 = var_269_6.sprite.bounds.size.x
					local var_269_12 = var_269_6.sprite.bounds.size.y
					local var_269_13 = var_269_10 / var_269_11
					local var_269_14 = var_269_9 / var_269_12
					local var_269_15 = var_269_14 < var_269_13 and var_269_13 or var_269_14

					var_269_5.transform.localScale = Vector3.New(var_269_15, var_269_15, 0)
				end

				for iter_269_0, iter_269_1 in pairs(arg_266_1.bgs_) do
					if iter_269_0 ~= "STblack" then
						iter_269_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_269_16 = 4

			if var_269_16 < arg_266_1.time_ and arg_266_1.time_ <= var_269_16 + arg_269_0 then
				arg_266_1.allBtn_.enabled = false
			end

			local var_269_17 = 0.3

			if arg_266_1.time_ >= var_269_16 + var_269_17 and arg_266_1.time_ < var_269_16 + var_269_17 + arg_269_0 then
				arg_266_1.allBtn_.enabled = true
			end

			local var_269_18 = 0

			if var_269_18 < arg_266_1.time_ and arg_266_1.time_ <= var_269_18 + arg_269_0 then
				arg_266_1.mask_.enabled = true
				arg_266_1.mask_.raycastTarget = true

				arg_266_1:SetGaussion(false)
			end

			local var_269_19 = 2

			if var_269_18 <= arg_266_1.time_ and arg_266_1.time_ < var_269_18 + var_269_19 then
				local var_269_20 = (arg_266_1.time_ - var_269_18) / var_269_19
				local var_269_21 = Color.New(0, 0, 0)

				var_269_21.a = Mathf.Lerp(0, 1, var_269_20)
				arg_266_1.mask_.color = var_269_21
			end

			if arg_266_1.time_ >= var_269_18 + var_269_19 and arg_266_1.time_ < var_269_18 + var_269_19 + arg_269_0 then
				local var_269_22 = Color.New(0, 0, 0)

				var_269_22.a = 1
				arg_266_1.mask_.color = var_269_22
			end

			local var_269_23 = 2

			if var_269_23 < arg_266_1.time_ and arg_266_1.time_ <= var_269_23 + arg_269_0 then
				arg_266_1.mask_.enabled = true
				arg_266_1.mask_.raycastTarget = true

				arg_266_1:SetGaussion(false)
			end

			local var_269_24 = 2

			if var_269_23 <= arg_266_1.time_ and arg_266_1.time_ < var_269_23 + var_269_24 then
				local var_269_25 = (arg_266_1.time_ - var_269_23) / var_269_24
				local var_269_26 = Color.New(0, 0, 0)

				var_269_26.a = Mathf.Lerp(1, 0, var_269_25)
				arg_266_1.mask_.color = var_269_26
			end

			if arg_266_1.time_ >= var_269_23 + var_269_24 and arg_266_1.time_ < var_269_23 + var_269_24 + arg_269_0 then
				local var_269_27 = Color.New(0, 0, 0)
				local var_269_28 = 0

				arg_266_1.mask_.enabled = false
				var_269_27.a = var_269_28
				arg_266_1.mask_.color = var_269_27
			end

			local var_269_29 = arg_266_1.actors_["1047ui_story"]
			local var_269_30 = 1.96599999815226

			if var_269_30 < arg_266_1.time_ and arg_266_1.time_ <= var_269_30 + arg_269_0 and not isNil(var_269_29) and arg_266_1.var_.characterEffect1047ui_story == nil then
				arg_266_1.var_.characterEffect1047ui_story = var_269_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_31 = 0.034000001847744

			if var_269_30 <= arg_266_1.time_ and arg_266_1.time_ < var_269_30 + var_269_31 and not isNil(var_269_29) then
				local var_269_32 = (arg_266_1.time_ - var_269_30) / var_269_31

				if arg_266_1.var_.characterEffect1047ui_story and not isNil(var_269_29) then
					local var_269_33 = Mathf.Lerp(0, 0.5, var_269_32)

					arg_266_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_266_1.var_.characterEffect1047ui_story.fillRatio = var_269_33
				end
			end

			if arg_266_1.time_ >= var_269_30 + var_269_31 and arg_266_1.time_ < var_269_30 + var_269_31 + arg_269_0 and not isNil(var_269_29) and arg_266_1.var_.characterEffect1047ui_story then
				local var_269_34 = 0.5

				arg_266_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_266_1.var_.characterEffect1047ui_story.fillRatio = var_269_34
			end

			local var_269_35 = arg_266_1.actors_["1047ui_story"].transform
			local var_269_36 = 1.96599999815226

			if var_269_36 < arg_266_1.time_ and arg_266_1.time_ <= var_269_36 + arg_269_0 then
				arg_266_1.var_.moveOldPos1047ui_story = var_269_35.localPosition
			end

			local var_269_37 = 0.001

			if var_269_36 <= arg_266_1.time_ and arg_266_1.time_ < var_269_36 + var_269_37 then
				local var_269_38 = (arg_266_1.time_ - var_269_36) / var_269_37
				local var_269_39 = Vector3.New(0, 100, 0)

				var_269_35.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1047ui_story, var_269_39, var_269_38)

				local var_269_40 = manager.ui.mainCamera.transform.position - var_269_35.position

				var_269_35.forward = Vector3.New(var_269_40.x, var_269_40.y, var_269_40.z)

				local var_269_41 = var_269_35.localEulerAngles

				var_269_41.z = 0
				var_269_41.x = 0
				var_269_35.localEulerAngles = var_269_41
			end

			if arg_266_1.time_ >= var_269_36 + var_269_37 and arg_266_1.time_ < var_269_36 + var_269_37 + arg_269_0 then
				var_269_35.localPosition = Vector3.New(0, 100, 0)

				local var_269_42 = manager.ui.mainCamera.transform.position - var_269_35.position

				var_269_35.forward = Vector3.New(var_269_42.x, var_269_42.y, var_269_42.z)

				local var_269_43 = var_269_35.localEulerAngles

				var_269_43.z = 0
				var_269_43.x = 0
				var_269_35.localEulerAngles = var_269_43
			end

			local var_269_44 = 0

			if var_269_44 < arg_266_1.time_ and arg_266_1.time_ <= var_269_44 + arg_269_0 then
				arg_266_1.fswbg_:SetActive(false)
				arg_266_1.dialog_:SetActive(false)
				SetActive(arg_266_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_266_1:ShowNextGo(false)
			end

			local var_269_45 = 0.1
			local var_269_46 = 1

			if var_269_45 < arg_266_1.time_ and arg_266_1.time_ <= var_269_45 + arg_269_0 then
				local var_269_47 = "stop"
				local var_269_48 = "effect"

				arg_266_1:AudioAction(var_269_47, var_269_48, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			local var_269_49 = 0
			local var_269_50 = 1

			if var_269_49 < arg_266_1.time_ and arg_266_1.time_ <= var_269_49 + arg_269_0 then
				local var_269_51 = "play"
				local var_269_52 = "effect"

				arg_266_1:AudioAction(var_269_51, var_269_52, "ui_battle", "ui_battle_stopbgm", "")
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 1104701066,
				charCount = 4,
				enableLayoutChange = true,
				duration = 0.266666666666667,
				groupID = "yizhouhouzhuanchang",
				startTime = 2.9,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play1104701067 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 1104701067
		arg_270_1.duration_ = 4.9

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play1104701068(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = "B13b"

			if arg_270_1.bgs_[var_273_0] == nil then
				local var_273_1 = Object.Instantiate(arg_270_1.paintGo_)

				var_273_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_273_0)
				var_273_1.name = var_273_0
				var_273_1.transform.parent = arg_270_1.stage_.transform
				var_273_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_270_1.bgs_[var_273_0] = var_273_1
			end

			local var_273_2 = 0

			if var_273_2 < arg_270_1.time_ and arg_270_1.time_ <= var_273_2 + arg_273_0 then
				local var_273_3 = manager.ui.mainCamera.transform.localPosition
				local var_273_4 = Vector3.New(0, 0, 10) + Vector3.New(var_273_3.x, var_273_3.y, 0)
				local var_273_5 = arg_270_1.bgs_.B13b

				var_273_5.transform.localPosition = var_273_4
				var_273_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_273_6 = var_273_5:GetComponent("SpriteRenderer")

				if var_273_6 and var_273_6.sprite then
					local var_273_7 = (var_273_5.transform.localPosition - var_273_3).z
					local var_273_8 = manager.ui.mainCameraCom_
					local var_273_9 = 2 * var_273_7 * Mathf.Tan(var_273_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_273_10 = var_273_9 * var_273_8.aspect
					local var_273_11 = var_273_6.sprite.bounds.size.x
					local var_273_12 = var_273_6.sprite.bounds.size.y
					local var_273_13 = var_273_10 / var_273_11
					local var_273_14 = var_273_9 / var_273_12
					local var_273_15 = var_273_14 < var_273_13 and var_273_13 or var_273_14

					var_273_5.transform.localScale = Vector3.New(var_273_15, var_273_15, 0)
				end

				for iter_273_0, iter_273_1 in pairs(arg_270_1.bgs_) do
					if iter_273_0 ~= "B13b" then
						iter_273_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_273_16 = 2

			if var_273_16 < arg_270_1.time_ and arg_270_1.time_ <= var_273_16 + arg_273_0 then
				arg_270_1.allBtn_.enabled = false
			end

			local var_273_17 = 0.3

			if arg_270_1.time_ >= var_273_16 + var_273_17 and arg_270_1.time_ < var_273_16 + var_273_17 + arg_273_0 then
				arg_270_1.allBtn_.enabled = true
			end

			local var_273_18 = 0

			if var_273_18 < arg_270_1.time_ and arg_270_1.time_ <= var_273_18 + arg_273_0 then
				arg_270_1.mask_.enabled = true
				arg_270_1.mask_.raycastTarget = true

				arg_270_1:SetGaussion(false)
			end

			local var_273_19 = 2

			if var_273_18 <= arg_270_1.time_ and arg_270_1.time_ < var_273_18 + var_273_19 then
				local var_273_20 = (arg_270_1.time_ - var_273_18) / var_273_19
				local var_273_21 = Color.New(0, 0, 0)

				var_273_21.a = Mathf.Lerp(1, 0, var_273_20)
				arg_270_1.mask_.color = var_273_21
			end

			if arg_270_1.time_ >= var_273_18 + var_273_19 and arg_270_1.time_ < var_273_18 + var_273_19 + arg_273_0 then
				local var_273_22 = Color.New(0, 0, 0)
				local var_273_23 = 0

				arg_270_1.mask_.enabled = false
				var_273_22.a = var_273_23
				arg_270_1.mask_.color = var_273_22
			end

			local var_273_24 = 0

			if var_273_24 < arg_270_1.time_ and arg_270_1.time_ <= var_273_24 + arg_273_0 then
				arg_270_1.fswbg_:SetActive(false)
				arg_270_1.dialog_:SetActive(false)
				SetActive(arg_270_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_270_1:ShowNextGo(false)
			end

			local var_273_25 = 0.1
			local var_273_26 = 1

			if var_273_25 < arg_270_1.time_ and arg_270_1.time_ <= var_273_25 + arg_273_0 then
				local var_273_27 = "play"
				local var_273_28 = "effect"

				arg_270_1:AudioAction(var_273_27, var_273_28, "se_story_147", "se_story_147_amb_rooftop", "")
			end

			local var_273_29 = 1
			local var_273_30 = 1

			if var_273_29 < arg_270_1.time_ and arg_270_1.time_ <= var_273_29 + arg_273_0 then
				local var_273_31 = "play"
				local var_273_32 = "music"

				arg_270_1:AudioAction(var_273_31, var_273_32, "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_273_33 = ""
				local var_273_34 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

				if var_273_34 ~= "" then
					if arg_270_1.bgmTxt_.text ~= var_273_34 and arg_270_1.bgmTxt_.text ~= "" then
						if arg_270_1.bgmTxt2_.text ~= "" then
							arg_270_1.bgmTxt_.text = arg_270_1.bgmTxt2_.text
						end

						arg_270_1.bgmTxt2_.text = var_273_34

						arg_270_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_270_1.bgmTxt_.text = var_273_34
						arg_270_1.bgmTxt2_.text = var_273_34
					end

					if arg_270_1.bgmTimer then
						arg_270_1.bgmTimer:Stop()

						arg_270_1.bgmTimer = nil
					end

					if arg_270_1.settingData.show_music_name == 1 then
						arg_270_1.musicController:SetSelectedState("show")
						arg_270_1.musicAnimator_:Play("open", 0, 0)

						if arg_270_1.settingData.music_time ~= 0 then
							arg_270_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_270_1.settingData.music_time), function()
								if arg_270_1 == nil or isNil(arg_270_1.bgmTxt_) then
									return
								end

								arg_270_1.musicController:SetSelectedState("hide")
								arg_270_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_270_1.frameCnt_ <= 1 then
				arg_270_1.dialog_:SetActive(false)
			end

			local var_273_35 = 2
			local var_273_36 = 0.275

			if var_273_35 < arg_270_1.time_ and arg_270_1.time_ <= var_273_35 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0

				arg_270_1.dialog_:SetActive(true)

				arg_270_1.dialogCg_.alpha = 0

				local var_273_37 = LeanTween.value(arg_270_1.dialog_, 0, 1, 0.3)

				var_273_37:setOnUpdate(LuaHelper.FloatAction(function(arg_275_0)
					arg_270_1.dialogCg_.alpha = arg_275_0
				end))
				var_273_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_270_1.dialog_)
					var_273_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_270_1.duration_ = arg_270_1.duration_ + 0.3

				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_38 = arg_270_1:FormatText(StoryNameCfg[1516].name)

				arg_270_1.leftNameTxt_.text = var_273_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_39 = arg_270_1:GetWordFromCfg(1104701067)
				local var_273_40 = arg_270_1:FormatText(var_273_39.content)

				arg_270_1.text_.text = var_273_40

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_41 = 11
				local var_273_42 = utf8.len(var_273_40)
				local var_273_43 = var_273_41 <= 0 and var_273_36 or var_273_36 * (var_273_42 / var_273_41)

				if var_273_43 > 0 and var_273_36 < var_273_43 then
					arg_270_1.talkMaxDuration = var_273_43
					var_273_35 = var_273_35 + 0.3

					if var_273_43 + var_273_35 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_43 + var_273_35
					end
				end

				arg_270_1.text_.text = var_273_40
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701067", "story_v_side_new_1104701.awb") ~= 0 then
					local var_273_44 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701067", "story_v_side_new_1104701.awb") / 1000

					if var_273_44 + var_273_35 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_44 + var_273_35
					end

					if var_273_39.prefab_name ~= "" and arg_270_1.actors_[var_273_39.prefab_name] ~= nil then
						local var_273_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_39.prefab_name].transform, "story_v_side_new_1104701", "1104701067", "story_v_side_new_1104701.awb")

						arg_270_1:RecordAudio("1104701067", var_273_45)
						arg_270_1:RecordAudio("1104701067", var_273_45)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701067", "story_v_side_new_1104701.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701067", "story_v_side_new_1104701.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_46 = var_273_35 + 0.3
			local var_273_47 = math.max(var_273_36, arg_270_1.talkMaxDuration)

			if var_273_46 <= arg_270_1.time_ and arg_270_1.time_ < var_273_46 + var_273_47 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_46) / var_273_47

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_46 + var_273_47 and arg_270_1.time_ < var_273_46 + var_273_47 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				groupID = "yizhouhouzhuanchang",
				duration = 0.266666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play1104701068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1104701068
		arg_277_1.duration_ = 4.27

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1104701069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.525

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_2 = arg_277_1:FormatText(StoryNameCfg[1517].name)

				arg_277_1.leftNameTxt_.text = var_280_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_3 = arg_277_1:GetWordFromCfg(1104701068)
				local var_280_4 = arg_277_1:FormatText(var_280_3.content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 21
				local var_280_6 = utf8.len(var_280_4)
				local var_280_7 = var_280_5 <= 0 and var_280_1 or var_280_1 * (var_280_6 / var_280_5)

				if var_280_7 > 0 and var_280_1 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_4
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701068", "story_v_side_new_1104701.awb") ~= 0 then
					local var_280_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701068", "story_v_side_new_1104701.awb") / 1000

					if var_280_8 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_8 + var_280_0
					end

					if var_280_3.prefab_name ~= "" and arg_277_1.actors_[var_280_3.prefab_name] ~= nil then
						local var_280_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_3.prefab_name].transform, "story_v_side_new_1104701", "1104701068", "story_v_side_new_1104701.awb")

						arg_277_1:RecordAudio("1104701068", var_280_9)
						arg_277_1:RecordAudio("1104701068", var_280_9)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701068", "story_v_side_new_1104701.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701068", "story_v_side_new_1104701.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_10 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_10 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_10

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_10 and arg_277_1.time_ < var_280_0 + var_280_10 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1104701069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1104701069
		arg_281_1.duration_ = 8.93

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1104701070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 1.1

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_2 = arg_281_1:FormatText(StoryNameCfg[1516].name)

				arg_281_1.leftNameTxt_.text = var_284_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_3 = arg_281_1:GetWordFromCfg(1104701069)
				local var_284_4 = arg_281_1:FormatText(var_284_3.content)

				arg_281_1.text_.text = var_284_4

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 44
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701069", "story_v_side_new_1104701.awb") ~= 0 then
					local var_284_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701069", "story_v_side_new_1104701.awb") / 1000

					if var_284_8 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_8 + var_284_0
					end

					if var_284_3.prefab_name ~= "" and arg_281_1.actors_[var_284_3.prefab_name] ~= nil then
						local var_284_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_3.prefab_name].transform, "story_v_side_new_1104701", "1104701069", "story_v_side_new_1104701.awb")

						arg_281_1:RecordAudio("1104701069", var_284_9)
						arg_281_1:RecordAudio("1104701069", var_284_9)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701069", "story_v_side_new_1104701.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701069", "story_v_side_new_1104701.awb")
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
	Play1104701070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1104701070
		arg_285_1.duration_ = 8.3

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1104701071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1047ui_story"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos1047ui_story = var_288_0.localPosition
			end

			local var_288_2 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2
				local var_288_4 = Vector3.New(0, -1.13, -6.2)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1047ui_story, var_288_4, var_288_3)

				local var_288_5 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_5.x, var_288_5.y, var_288_5.z)

				local var_288_6 = var_288_0.localEulerAngles

				var_288_6.z = 0
				var_288_6.x = 0
				var_288_0.localEulerAngles = var_288_6
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_288_7 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_7.x, var_288_7.y, var_288_7.z)

				local var_288_8 = var_288_0.localEulerAngles

				var_288_8.z = 0
				var_288_8.x = 0
				var_288_0.localEulerAngles = var_288_8
			end

			local var_288_9 = arg_285_1.actors_["1047ui_story"]
			local var_288_10 = 0

			if var_288_10 < arg_285_1.time_ and arg_285_1.time_ <= var_288_10 + arg_288_0 and not isNil(var_288_9) and arg_285_1.var_.characterEffect1047ui_story == nil then
				arg_285_1.var_.characterEffect1047ui_story = var_288_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_11 = 0.200000002980232

			if var_288_10 <= arg_285_1.time_ and arg_285_1.time_ < var_288_10 + var_288_11 and not isNil(var_288_9) then
				local var_288_12 = (arg_285_1.time_ - var_288_10) / var_288_11

				if arg_285_1.var_.characterEffect1047ui_story and not isNil(var_288_9) then
					arg_285_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_10 + var_288_11 and arg_285_1.time_ < var_288_10 + var_288_11 + arg_288_0 and not isNil(var_288_9) and arg_285_1.var_.characterEffect1047ui_story then
				arg_285_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_288_13 = 0

			if var_288_13 < arg_285_1.time_ and arg_285_1.time_ <= var_288_13 + arg_288_0 then
				arg_285_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_288_14 = 0

			if var_288_14 < arg_285_1.time_ and arg_285_1.time_ <= var_288_14 + arg_288_0 then
				arg_285_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_288_15 = 0
			local var_288_16 = 1.05

			if var_288_15 < arg_285_1.time_ and arg_285_1.time_ <= var_288_15 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_17 = arg_285_1:FormatText(StoryNameCfg[1296].name)

				arg_285_1.leftNameTxt_.text = var_288_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_18 = arg_285_1:GetWordFromCfg(1104701070)
				local var_288_19 = arg_285_1:FormatText(var_288_18.content)

				arg_285_1.text_.text = var_288_19

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_20 = 42
				local var_288_21 = utf8.len(var_288_19)
				local var_288_22 = var_288_20 <= 0 and var_288_16 or var_288_16 * (var_288_21 / var_288_20)

				if var_288_22 > 0 and var_288_16 < var_288_22 then
					arg_285_1.talkMaxDuration = var_288_22

					if var_288_22 + var_288_15 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_22 + var_288_15
					end
				end

				arg_285_1.text_.text = var_288_19
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701070", "story_v_side_new_1104701.awb") ~= 0 then
					local var_288_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701070", "story_v_side_new_1104701.awb") / 1000

					if var_288_23 + var_288_15 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_23 + var_288_15
					end

					if var_288_18.prefab_name ~= "" and arg_285_1.actors_[var_288_18.prefab_name] ~= nil then
						local var_288_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_18.prefab_name].transform, "story_v_side_new_1104701", "1104701070", "story_v_side_new_1104701.awb")

						arg_285_1:RecordAudio("1104701070", var_288_24)
						arg_285_1:RecordAudio("1104701070", var_288_24)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701070", "story_v_side_new_1104701.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701070", "story_v_side_new_1104701.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_25 = math.max(var_288_16, arg_285_1.talkMaxDuration)

			if var_288_15 <= arg_285_1.time_ and arg_285_1.time_ < var_288_15 + var_288_25 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_15) / var_288_25

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_15 + var_288_25 and arg_285_1.time_ < var_288_15 + var_288_25 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play1104701071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1104701071
		arg_289_1.duration_ = 4.07

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1104701072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1047ui_story"].transform
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos1047ui_story = var_292_0.localPosition
			end

			local var_292_2 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2
				local var_292_4 = Vector3.New(0, -1.13, -6.2)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1047ui_story, var_292_4, var_292_3)

				local var_292_5 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_5.x, var_292_5.y, var_292_5.z)

				local var_292_6 = var_292_0.localEulerAngles

				var_292_6.z = 0
				var_292_6.x = 0
				var_292_0.localEulerAngles = var_292_6
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_292_7 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_7.x, var_292_7.y, var_292_7.z)

				local var_292_8 = var_292_0.localEulerAngles

				var_292_8.z = 0
				var_292_8.x = 0
				var_292_0.localEulerAngles = var_292_8
			end

			local var_292_9 = 0

			if var_292_9 < arg_289_1.time_ and arg_289_1.time_ <= var_292_9 + arg_292_0 then
				arg_289_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			local var_292_10 = 0

			if var_292_10 < arg_289_1.time_ and arg_289_1.time_ <= var_292_10 + arg_292_0 then
				arg_289_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_292_11 = 0
			local var_292_12 = 0.475

			if var_292_11 < arg_289_1.time_ and arg_289_1.time_ <= var_292_11 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_13 = arg_289_1:FormatText(StoryNameCfg[1296].name)

				arg_289_1.leftNameTxt_.text = var_292_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_14 = arg_289_1:GetWordFromCfg(1104701071)
				local var_292_15 = arg_289_1:FormatText(var_292_14.content)

				arg_289_1.text_.text = var_292_15

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_16 = 19
				local var_292_17 = utf8.len(var_292_15)
				local var_292_18 = var_292_16 <= 0 and var_292_12 or var_292_12 * (var_292_17 / var_292_16)

				if var_292_18 > 0 and var_292_12 < var_292_18 then
					arg_289_1.talkMaxDuration = var_292_18

					if var_292_18 + var_292_11 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_18 + var_292_11
					end
				end

				arg_289_1.text_.text = var_292_15
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701071", "story_v_side_new_1104701.awb") ~= 0 then
					local var_292_19 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701071", "story_v_side_new_1104701.awb") / 1000

					if var_292_19 + var_292_11 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_19 + var_292_11
					end

					if var_292_14.prefab_name ~= "" and arg_289_1.actors_[var_292_14.prefab_name] ~= nil then
						local var_292_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_14.prefab_name].transform, "story_v_side_new_1104701", "1104701071", "story_v_side_new_1104701.awb")

						arg_289_1:RecordAudio("1104701071", var_292_20)
						arg_289_1:RecordAudio("1104701071", var_292_20)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701071", "story_v_side_new_1104701.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701071", "story_v_side_new_1104701.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_21 = math.max(var_292_12, arg_289_1.talkMaxDuration)

			if var_292_11 <= arg_289_1.time_ and arg_289_1.time_ < var_292_11 + var_292_21 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_11) / var_292_21

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_11 + var_292_21 and arg_289_1.time_ < var_292_11 + var_292_21 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play1104701072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1104701072
		arg_293_1.duration_ = 6.23

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1104701073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1047ui_story"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1047ui_story == nil then
				arg_293_1.var_.characterEffect1047ui_story = var_296_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.characterEffect1047ui_story and not isNil(var_296_0) then
					local var_296_4 = Mathf.Lerp(0, 0.5, var_296_3)

					arg_293_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1047ui_story.fillRatio = var_296_4
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1047ui_story then
				local var_296_5 = 0.5

				arg_293_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1047ui_story.fillRatio = var_296_5
			end

			local var_296_6 = 0
			local var_296_7 = 0.5

			if var_296_6 < arg_293_1.time_ and arg_293_1.time_ <= var_296_6 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_8 = arg_293_1:FormatText(StoryNameCfg[1516].name)

				arg_293_1.leftNameTxt_.text = var_296_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_9 = arg_293_1:GetWordFromCfg(1104701072)
				local var_296_10 = arg_293_1:FormatText(var_296_9.content)

				arg_293_1.text_.text = var_296_10

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_11 = 20
				local var_296_12 = utf8.len(var_296_10)
				local var_296_13 = var_296_11 <= 0 and var_296_7 or var_296_7 * (var_296_12 / var_296_11)

				if var_296_13 > 0 and var_296_7 < var_296_13 then
					arg_293_1.talkMaxDuration = var_296_13

					if var_296_13 + var_296_6 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_13 + var_296_6
					end
				end

				arg_293_1.text_.text = var_296_10
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701072", "story_v_side_new_1104701.awb") ~= 0 then
					local var_296_14 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701072", "story_v_side_new_1104701.awb") / 1000

					if var_296_14 + var_296_6 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_14 + var_296_6
					end

					if var_296_9.prefab_name ~= "" and arg_293_1.actors_[var_296_9.prefab_name] ~= nil then
						local var_296_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_9.prefab_name].transform, "story_v_side_new_1104701", "1104701072", "story_v_side_new_1104701.awb")

						arg_293_1:RecordAudio("1104701072", var_296_15)
						arg_293_1:RecordAudio("1104701072", var_296_15)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701072", "story_v_side_new_1104701.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701072", "story_v_side_new_1104701.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_16 = math.max(var_296_7, arg_293_1.talkMaxDuration)

			if var_296_6 <= arg_293_1.time_ and arg_293_1.time_ < var_296_6 + var_296_16 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_6) / var_296_16

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_6 + var_296_16 and arg_293_1.time_ < var_296_6 + var_296_16 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play1104701073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1104701073
		arg_297_1.duration_ = 6.93

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1104701074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1047ui_story"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1047ui_story == nil then
				arg_297_1.var_.characterEffect1047ui_story = var_300_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.200000002980232

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.characterEffect1047ui_story and not isNil(var_300_0) then
					arg_297_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1047ui_story then
				arg_297_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_300_4 = 0

			if var_300_4 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			local var_300_5 = 0

			if var_300_5 < arg_297_1.time_ and arg_297_1.time_ <= var_300_5 + arg_300_0 then
				arg_297_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_300_6 = 0
			local var_300_7 = 0.75

			if var_300_6 < arg_297_1.time_ and arg_297_1.time_ <= var_300_6 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_8 = arg_297_1:FormatText(StoryNameCfg[1296].name)

				arg_297_1.leftNameTxt_.text = var_300_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_9 = arg_297_1:GetWordFromCfg(1104701073)
				local var_300_10 = arg_297_1:FormatText(var_300_9.content)

				arg_297_1.text_.text = var_300_10

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_11 = 30
				local var_300_12 = utf8.len(var_300_10)
				local var_300_13 = var_300_11 <= 0 and var_300_7 or var_300_7 * (var_300_12 / var_300_11)

				if var_300_13 > 0 and var_300_7 < var_300_13 then
					arg_297_1.talkMaxDuration = var_300_13

					if var_300_13 + var_300_6 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_13 + var_300_6
					end
				end

				arg_297_1.text_.text = var_300_10
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701073", "story_v_side_new_1104701.awb") ~= 0 then
					local var_300_14 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701073", "story_v_side_new_1104701.awb") / 1000

					if var_300_14 + var_300_6 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_14 + var_300_6
					end

					if var_300_9.prefab_name ~= "" and arg_297_1.actors_[var_300_9.prefab_name] ~= nil then
						local var_300_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_9.prefab_name].transform, "story_v_side_new_1104701", "1104701073", "story_v_side_new_1104701.awb")

						arg_297_1:RecordAudio("1104701073", var_300_15)
						arg_297_1:RecordAudio("1104701073", var_300_15)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701073", "story_v_side_new_1104701.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701073", "story_v_side_new_1104701.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_16 = math.max(var_300_7, arg_297_1.talkMaxDuration)

			if var_300_6 <= arg_297_1.time_ and arg_297_1.time_ < var_300_6 + var_300_16 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_6) / var_300_16

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_6 + var_300_16 and arg_297_1.time_ < var_300_6 + var_300_16 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1104701074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1104701074
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1104701075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1047ui_story"]
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1047ui_story == nil then
				arg_301_1.var_.characterEffect1047ui_story = var_304_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 and not isNil(var_304_0) then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2

				if arg_301_1.var_.characterEffect1047ui_story and not isNil(var_304_0) then
					local var_304_4 = Mathf.Lerp(0, 0.5, var_304_3)

					arg_301_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1047ui_story.fillRatio = var_304_4
				end
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1047ui_story then
				local var_304_5 = 0.5

				arg_301_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1047ui_story.fillRatio = var_304_5
			end

			local var_304_6 = arg_301_1.actors_["1047ui_story"].transform
			local var_304_7 = 0

			if var_304_7 < arg_301_1.time_ and arg_301_1.time_ <= var_304_7 + arg_304_0 then
				arg_301_1.var_.moveOldPos1047ui_story = var_304_6.localPosition
			end

			local var_304_8 = 0.001

			if var_304_7 <= arg_301_1.time_ and arg_301_1.time_ < var_304_7 + var_304_8 then
				local var_304_9 = (arg_301_1.time_ - var_304_7) / var_304_8
				local var_304_10 = Vector3.New(0, 100, 0)

				var_304_6.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1047ui_story, var_304_10, var_304_9)

				local var_304_11 = manager.ui.mainCamera.transform.position - var_304_6.position

				var_304_6.forward = Vector3.New(var_304_11.x, var_304_11.y, var_304_11.z)

				local var_304_12 = var_304_6.localEulerAngles

				var_304_12.z = 0
				var_304_12.x = 0
				var_304_6.localEulerAngles = var_304_12
			end

			if arg_301_1.time_ >= var_304_7 + var_304_8 and arg_301_1.time_ < var_304_7 + var_304_8 + arg_304_0 then
				var_304_6.localPosition = Vector3.New(0, 100, 0)

				local var_304_13 = manager.ui.mainCamera.transform.position - var_304_6.position

				var_304_6.forward = Vector3.New(var_304_13.x, var_304_13.y, var_304_13.z)

				local var_304_14 = var_304_6.localEulerAngles

				var_304_14.z = 0
				var_304_14.x = 0
				var_304_6.localEulerAngles = var_304_14
			end

			local var_304_15 = 0
			local var_304_16 = 0.95

			if var_304_15 < arg_301_1.time_ and arg_301_1.time_ <= var_304_15 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_17 = arg_301_1:GetWordFromCfg(1104701074)
				local var_304_18 = arg_301_1:FormatText(var_304_17.content)

				arg_301_1.text_.text = var_304_18

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_19 = 38
				local var_304_20 = utf8.len(var_304_18)
				local var_304_21 = var_304_19 <= 0 and var_304_16 or var_304_16 * (var_304_20 / var_304_19)

				if var_304_21 > 0 and var_304_16 < var_304_21 then
					arg_301_1.talkMaxDuration = var_304_21

					if var_304_21 + var_304_15 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_21 + var_304_15
					end
				end

				arg_301_1.text_.text = var_304_18
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_22 = math.max(var_304_16, arg_301_1.talkMaxDuration)

			if var_304_15 <= arg_301_1.time_ and arg_301_1.time_ < var_304_15 + var_304_22 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_15) / var_304_22

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_15 + var_304_22 and arg_301_1.time_ < var_304_15 + var_304_22 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play1104701075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1104701075
		arg_305_1.duration_ = 6.27

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1104701076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.55

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_2 = arg_305_1:FormatText(StoryNameCfg[1518].name)

				arg_305_1.leftNameTxt_.text = var_308_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:GetWordFromCfg(1104701075)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 22
				local var_308_6 = utf8.len(var_308_4)
				local var_308_7 = var_308_5 <= 0 and var_308_1 or var_308_1 * (var_308_6 / var_308_5)

				if var_308_7 > 0 and var_308_1 < var_308_7 then
					arg_305_1.talkMaxDuration = var_308_7

					if var_308_7 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_4
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701075", "story_v_side_new_1104701.awb") ~= 0 then
					local var_308_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701075", "story_v_side_new_1104701.awb") / 1000

					if var_308_8 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_8 + var_308_0
					end

					if var_308_3.prefab_name ~= "" and arg_305_1.actors_[var_308_3.prefab_name] ~= nil then
						local var_308_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_3.prefab_name].transform, "story_v_side_new_1104701", "1104701075", "story_v_side_new_1104701.awb")

						arg_305_1:RecordAudio("1104701075", var_308_9)
						arg_305_1:RecordAudio("1104701075", var_308_9)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701075", "story_v_side_new_1104701.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701075", "story_v_side_new_1104701.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_10 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_10 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_10

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_10 and arg_305_1.time_ < var_308_0 + var_308_10 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1104701076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1104701076
		arg_309_1.duration_ = 4

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1104701077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1047ui_story"].transform
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.var_.moveOldPos1047ui_story = var_312_0.localPosition
			end

			local var_312_2 = 0.001

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2
				local var_312_4 = Vector3.New(0, -1.13, -6.2)

				var_312_0.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1047ui_story, var_312_4, var_312_3)

				local var_312_5 = manager.ui.mainCamera.transform.position - var_312_0.position

				var_312_0.forward = Vector3.New(var_312_5.x, var_312_5.y, var_312_5.z)

				local var_312_6 = var_312_0.localEulerAngles

				var_312_6.z = 0
				var_312_6.x = 0
				var_312_0.localEulerAngles = var_312_6
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 then
				var_312_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_312_7 = manager.ui.mainCamera.transform.position - var_312_0.position

				var_312_0.forward = Vector3.New(var_312_7.x, var_312_7.y, var_312_7.z)

				local var_312_8 = var_312_0.localEulerAngles

				var_312_8.z = 0
				var_312_8.x = 0
				var_312_0.localEulerAngles = var_312_8
			end

			local var_312_9 = arg_309_1.actors_["1047ui_story"]
			local var_312_10 = 0

			if var_312_10 < arg_309_1.time_ and arg_309_1.time_ <= var_312_10 + arg_312_0 and not isNil(var_312_9) and arg_309_1.var_.characterEffect1047ui_story == nil then
				arg_309_1.var_.characterEffect1047ui_story = var_312_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_11 = 0.200000002980232

			if var_312_10 <= arg_309_1.time_ and arg_309_1.time_ < var_312_10 + var_312_11 and not isNil(var_312_9) then
				local var_312_12 = (arg_309_1.time_ - var_312_10) / var_312_11

				if arg_309_1.var_.characterEffect1047ui_story and not isNil(var_312_9) then
					arg_309_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= var_312_10 + var_312_11 and arg_309_1.time_ < var_312_10 + var_312_11 + arg_312_0 and not isNil(var_312_9) and arg_309_1.var_.characterEffect1047ui_story then
				arg_309_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_312_13 = 0

			if var_312_13 < arg_309_1.time_ and arg_309_1.time_ <= var_312_13 + arg_312_0 then
				arg_309_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			local var_312_14 = 0

			if var_312_14 < arg_309_1.time_ and arg_309_1.time_ <= var_312_14 + arg_312_0 then
				arg_309_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_312_15 = 0
			local var_312_16 = 0.425

			if var_312_15 < arg_309_1.time_ and arg_309_1.time_ <= var_312_15 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_17 = arg_309_1:FormatText(StoryNameCfg[1296].name)

				arg_309_1.leftNameTxt_.text = var_312_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_18 = arg_309_1:GetWordFromCfg(1104701076)
				local var_312_19 = arg_309_1:FormatText(var_312_18.content)

				arg_309_1.text_.text = var_312_19

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_20 = 17
				local var_312_21 = utf8.len(var_312_19)
				local var_312_22 = var_312_20 <= 0 and var_312_16 or var_312_16 * (var_312_21 / var_312_20)

				if var_312_22 > 0 and var_312_16 < var_312_22 then
					arg_309_1.talkMaxDuration = var_312_22

					if var_312_22 + var_312_15 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_22 + var_312_15
					end
				end

				arg_309_1.text_.text = var_312_19
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701076", "story_v_side_new_1104701.awb") ~= 0 then
					local var_312_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701076", "story_v_side_new_1104701.awb") / 1000

					if var_312_23 + var_312_15 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_23 + var_312_15
					end

					if var_312_18.prefab_name ~= "" and arg_309_1.actors_[var_312_18.prefab_name] ~= nil then
						local var_312_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_18.prefab_name].transform, "story_v_side_new_1104701", "1104701076", "story_v_side_new_1104701.awb")

						arg_309_1:RecordAudio("1104701076", var_312_24)
						arg_309_1:RecordAudio("1104701076", var_312_24)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701076", "story_v_side_new_1104701.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701076", "story_v_side_new_1104701.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_25 = math.max(var_312_16, arg_309_1.talkMaxDuration)

			if var_312_15 <= arg_309_1.time_ and arg_309_1.time_ < var_312_15 + var_312_25 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_15) / var_312_25

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_15 + var_312_25 and arg_309_1.time_ < var_312_15 + var_312_25 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play1104701077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1104701077
		arg_313_1.duration_ = 6.53

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1104701078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1047ui_story"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1047ui_story == nil then
				arg_313_1.var_.characterEffect1047ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.characterEffect1047ui_story and not isNil(var_316_0) then
					local var_316_4 = Mathf.Lerp(0, 0.5, var_316_3)

					arg_313_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1047ui_story.fillRatio = var_316_4
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1047ui_story then
				local var_316_5 = 0.5

				arg_313_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1047ui_story.fillRatio = var_316_5
			end

			local var_316_6 = 0
			local var_316_7 = 0.625

			if var_316_6 < arg_313_1.time_ and arg_313_1.time_ <= var_316_6 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_8 = arg_313_1:FormatText(StoryNameCfg[1518].name)

				arg_313_1.leftNameTxt_.text = var_316_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_9 = arg_313_1:GetWordFromCfg(1104701077)
				local var_316_10 = arg_313_1:FormatText(var_316_9.content)

				arg_313_1.text_.text = var_316_10

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_11 = 25
				local var_316_12 = utf8.len(var_316_10)
				local var_316_13 = var_316_11 <= 0 and var_316_7 or var_316_7 * (var_316_12 / var_316_11)

				if var_316_13 > 0 and var_316_7 < var_316_13 then
					arg_313_1.talkMaxDuration = var_316_13

					if var_316_13 + var_316_6 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_13 + var_316_6
					end
				end

				arg_313_1.text_.text = var_316_10
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701077", "story_v_side_new_1104701.awb") ~= 0 then
					local var_316_14 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701077", "story_v_side_new_1104701.awb") / 1000

					if var_316_14 + var_316_6 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_14 + var_316_6
					end

					if var_316_9.prefab_name ~= "" and arg_313_1.actors_[var_316_9.prefab_name] ~= nil then
						local var_316_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_9.prefab_name].transform, "story_v_side_new_1104701", "1104701077", "story_v_side_new_1104701.awb")

						arg_313_1:RecordAudio("1104701077", var_316_15)
						arg_313_1:RecordAudio("1104701077", var_316_15)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701077", "story_v_side_new_1104701.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701077", "story_v_side_new_1104701.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_16 = math.max(var_316_7, arg_313_1.talkMaxDuration)

			if var_316_6 <= arg_313_1.time_ and arg_313_1.time_ < var_316_6 + var_316_16 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_6) / var_316_16

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_6 + var_316_16 and arg_313_1.time_ < var_316_6 + var_316_16 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play1104701078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1104701078
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1104701079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 0.65

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_2 = arg_317_1:FormatText(StoryNameCfg[7].name)

				arg_317_1.leftNameTxt_.text = var_320_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_3 = arg_317_1:GetWordFromCfg(1104701078)
				local var_320_4 = arg_317_1:FormatText(var_320_3.content)

				arg_317_1.text_.text = var_320_4

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 26
				local var_320_6 = utf8.len(var_320_4)
				local var_320_7 = var_320_5 <= 0 and var_320_1 or var_320_1 * (var_320_6 / var_320_5)

				if var_320_7 > 0 and var_320_1 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_4
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_8 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_8 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_8

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_8 and arg_317_1.time_ < var_320_0 + var_320_8 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play1104701079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1104701079
		arg_321_1.duration_ = 3.43

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1104701080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0
			local var_324_1 = 0.35

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_2 = arg_321_1:FormatText(StoryNameCfg[1518].name)

				arg_321_1.leftNameTxt_.text = var_324_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_3 = arg_321_1:GetWordFromCfg(1104701079)
				local var_324_4 = arg_321_1:FormatText(var_324_3.content)

				arg_321_1.text_.text = var_324_4

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 14
				local var_324_6 = utf8.len(var_324_4)
				local var_324_7 = var_324_5 <= 0 and var_324_1 or var_324_1 * (var_324_6 / var_324_5)

				if var_324_7 > 0 and var_324_1 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_0
					end
				end

				arg_321_1.text_.text = var_324_4
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701079", "story_v_side_new_1104701.awb") ~= 0 then
					local var_324_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701079", "story_v_side_new_1104701.awb") / 1000

					if var_324_8 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_8 + var_324_0
					end

					if var_324_3.prefab_name ~= "" and arg_321_1.actors_[var_324_3.prefab_name] ~= nil then
						local var_324_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_3.prefab_name].transform, "story_v_side_new_1104701", "1104701079", "story_v_side_new_1104701.awb")

						arg_321_1:RecordAudio("1104701079", var_324_9)
						arg_321_1:RecordAudio("1104701079", var_324_9)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701079", "story_v_side_new_1104701.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701079", "story_v_side_new_1104701.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_10 = math.max(var_324_1, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_10 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_0) / var_324_10

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_10 and arg_321_1.time_ < var_324_0 + var_324_10 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play1104701080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1104701080
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play1104701081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0
			local var_328_1 = 0.775

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_2 = arg_325_1:GetWordFromCfg(1104701080)
				local var_328_3 = arg_325_1:FormatText(var_328_2.content)

				arg_325_1.text_.text = var_328_3

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_4 = 31
				local var_328_5 = utf8.len(var_328_3)
				local var_328_6 = var_328_4 <= 0 and var_328_1 or var_328_1 * (var_328_5 / var_328_4)

				if var_328_6 > 0 and var_328_1 < var_328_6 then
					arg_325_1.talkMaxDuration = var_328_6

					if var_328_6 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_6 + var_328_0
					end
				end

				arg_325_1.text_.text = var_328_3
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_1, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_0) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_7 and arg_325_1.time_ < var_328_0 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play1104701081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1104701081
		arg_329_1.duration_ = 8.17

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1104701082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0
			local var_332_1 = 0.925

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_2 = arg_329_1:FormatText(StoryNameCfg[1516].name)

				arg_329_1.leftNameTxt_.text = var_332_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_3 = arg_329_1:GetWordFromCfg(1104701081)
				local var_332_4 = arg_329_1:FormatText(var_332_3.content)

				arg_329_1.text_.text = var_332_4

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 37
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701081", "story_v_side_new_1104701.awb") ~= 0 then
					local var_332_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701081", "story_v_side_new_1104701.awb") / 1000

					if var_332_8 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_8 + var_332_0
					end

					if var_332_3.prefab_name ~= "" and arg_329_1.actors_[var_332_3.prefab_name] ~= nil then
						local var_332_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_3.prefab_name].transform, "story_v_side_new_1104701", "1104701081", "story_v_side_new_1104701.awb")

						arg_329_1:RecordAudio("1104701081", var_332_9)
						arg_329_1:RecordAudio("1104701081", var_332_9)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701081", "story_v_side_new_1104701.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701081", "story_v_side_new_1104701.awb")
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
	Play1104701082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1104701082
		arg_333_1.duration_ = 8.67

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1104701083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0
			local var_336_1 = 1.1

			if var_336_0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_2 = arg_333_1:FormatText(StoryNameCfg[1517].name)

				arg_333_1.leftNameTxt_.text = var_336_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_3 = arg_333_1:GetWordFromCfg(1104701082)
				local var_336_4 = arg_333_1:FormatText(var_336_3.content)

				arg_333_1.text_.text = var_336_4

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 44
				local var_336_6 = utf8.len(var_336_4)
				local var_336_7 = var_336_5 <= 0 and var_336_1 or var_336_1 * (var_336_6 / var_336_5)

				if var_336_7 > 0 and var_336_1 < var_336_7 then
					arg_333_1.talkMaxDuration = var_336_7

					if var_336_7 + var_336_0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_7 + var_336_0
					end
				end

				arg_333_1.text_.text = var_336_4
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701082", "story_v_side_new_1104701.awb") ~= 0 then
					local var_336_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701082", "story_v_side_new_1104701.awb") / 1000

					if var_336_8 + var_336_0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_8 + var_336_0
					end

					if var_336_3.prefab_name ~= "" and arg_333_1.actors_[var_336_3.prefab_name] ~= nil then
						local var_336_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_3.prefab_name].transform, "story_v_side_new_1104701", "1104701082", "story_v_side_new_1104701.awb")

						arg_333_1:RecordAudio("1104701082", var_336_9)
						arg_333_1:RecordAudio("1104701082", var_336_9)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701082", "story_v_side_new_1104701.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701082", "story_v_side_new_1104701.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_10 = math.max(var_336_1, arg_333_1.talkMaxDuration)

			if var_336_0 <= arg_333_1.time_ and arg_333_1.time_ < var_336_0 + var_336_10 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_0) / var_336_10

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_0 + var_336_10 and arg_333_1.time_ < var_336_0 + var_336_10 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play1104701083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1104701083
		arg_337_1.duration_ = 4.93

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1104701084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0
			local var_340_1 = 0.525

			if var_340_0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_2 = arg_337_1:FormatText(StoryNameCfg[1516].name)

				arg_337_1.leftNameTxt_.text = var_340_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_3 = arg_337_1:GetWordFromCfg(1104701083)
				local var_340_4 = arg_337_1:FormatText(var_340_3.content)

				arg_337_1.text_.text = var_340_4

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 21
				local var_340_6 = utf8.len(var_340_4)
				local var_340_7 = var_340_5 <= 0 and var_340_1 or var_340_1 * (var_340_6 / var_340_5)

				if var_340_7 > 0 and var_340_1 < var_340_7 then
					arg_337_1.talkMaxDuration = var_340_7

					if var_340_7 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_7 + var_340_0
					end
				end

				arg_337_1.text_.text = var_340_4
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701083", "story_v_side_new_1104701.awb") ~= 0 then
					local var_340_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701083", "story_v_side_new_1104701.awb") / 1000

					if var_340_8 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_0
					end

					if var_340_3.prefab_name ~= "" and arg_337_1.actors_[var_340_3.prefab_name] ~= nil then
						local var_340_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_3.prefab_name].transform, "story_v_side_new_1104701", "1104701083", "story_v_side_new_1104701.awb")

						arg_337_1:RecordAudio("1104701083", var_340_9)
						arg_337_1:RecordAudio("1104701083", var_340_9)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701083", "story_v_side_new_1104701.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701083", "story_v_side_new_1104701.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_10 = math.max(var_340_1, arg_337_1.talkMaxDuration)

			if var_340_0 <= arg_337_1.time_ and arg_337_1.time_ < var_340_0 + var_340_10 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_0) / var_340_10

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_0 + var_340_10 and arg_337_1.time_ < var_340_0 + var_340_10 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play1104701084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1104701084
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1104701085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0
			local var_344_1 = 1.525

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_2 = arg_341_1:GetWordFromCfg(1104701084)
				local var_344_3 = arg_341_1:FormatText(var_344_2.content)

				arg_341_1.text_.text = var_344_3

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_4 = 61
				local var_344_5 = utf8.len(var_344_3)
				local var_344_6 = var_344_4 <= 0 and var_344_1 or var_344_1 * (var_344_5 / var_344_4)

				if var_344_6 > 0 and var_344_1 < var_344_6 then
					arg_341_1.talkMaxDuration = var_344_6

					if var_344_6 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_6 + var_344_0
					end
				end

				arg_341_1.text_.text = var_344_3
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_7 = math.max(var_344_1, arg_341_1.talkMaxDuration)

			if var_344_0 <= arg_341_1.time_ and arg_341_1.time_ < var_344_0 + var_344_7 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_0) / var_344_7

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_0 + var_344_7 and arg_341_1.time_ < var_344_0 + var_344_7 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play1104701085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1104701085
		arg_345_1.duration_ = 10.87

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1104701086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["1047ui_story"].transform
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1.var_.moveOldPos1047ui_story = var_348_0.localPosition
			end

			local var_348_2 = 0.001

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2
				local var_348_4 = Vector3.New(0, -1.13, -6.2)

				var_348_0.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1047ui_story, var_348_4, var_348_3)

				local var_348_5 = manager.ui.mainCamera.transform.position - var_348_0.position

				var_348_0.forward = Vector3.New(var_348_5.x, var_348_5.y, var_348_5.z)

				local var_348_6 = var_348_0.localEulerAngles

				var_348_6.z = 0
				var_348_6.x = 0
				var_348_0.localEulerAngles = var_348_6
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 then
				var_348_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_348_7 = manager.ui.mainCamera.transform.position - var_348_0.position

				var_348_0.forward = Vector3.New(var_348_7.x, var_348_7.y, var_348_7.z)

				local var_348_8 = var_348_0.localEulerAngles

				var_348_8.z = 0
				var_348_8.x = 0
				var_348_0.localEulerAngles = var_348_8
			end

			local var_348_9 = arg_345_1.actors_["1047ui_story"]
			local var_348_10 = 0

			if var_348_10 < arg_345_1.time_ and arg_345_1.time_ <= var_348_10 + arg_348_0 and not isNil(var_348_9) and arg_345_1.var_.characterEffect1047ui_story == nil then
				arg_345_1.var_.characterEffect1047ui_story = var_348_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_11 = 0.200000002980232

			if var_348_10 <= arg_345_1.time_ and arg_345_1.time_ < var_348_10 + var_348_11 and not isNil(var_348_9) then
				local var_348_12 = (arg_345_1.time_ - var_348_10) / var_348_11

				if arg_345_1.var_.characterEffect1047ui_story and not isNil(var_348_9) then
					arg_345_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= var_348_10 + var_348_11 and arg_345_1.time_ < var_348_10 + var_348_11 + arg_348_0 and not isNil(var_348_9) and arg_345_1.var_.characterEffect1047ui_story then
				arg_345_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_348_13 = 0

			if var_348_13 < arg_345_1.time_ and arg_345_1.time_ <= var_348_13 + arg_348_0 then
				arg_345_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action464")
			end

			local var_348_14 = 0

			if var_348_14 < arg_345_1.time_ and arg_345_1.time_ <= var_348_14 + arg_348_0 then
				arg_345_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_348_15 = 0
			local var_348_16 = 1.05

			if var_348_15 < arg_345_1.time_ and arg_345_1.time_ <= var_348_15 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_17 = arg_345_1:FormatText(StoryNameCfg[1296].name)

				arg_345_1.leftNameTxt_.text = var_348_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_18 = arg_345_1:GetWordFromCfg(1104701085)
				local var_348_19 = arg_345_1:FormatText(var_348_18.content)

				arg_345_1.text_.text = var_348_19

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_20 = 42
				local var_348_21 = utf8.len(var_348_19)
				local var_348_22 = var_348_20 <= 0 and var_348_16 or var_348_16 * (var_348_21 / var_348_20)

				if var_348_22 > 0 and var_348_16 < var_348_22 then
					arg_345_1.talkMaxDuration = var_348_22

					if var_348_22 + var_348_15 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_22 + var_348_15
					end
				end

				arg_345_1.text_.text = var_348_19
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701085", "story_v_side_new_1104701.awb") ~= 0 then
					local var_348_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701085", "story_v_side_new_1104701.awb") / 1000

					if var_348_23 + var_348_15 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_23 + var_348_15
					end

					if var_348_18.prefab_name ~= "" and arg_345_1.actors_[var_348_18.prefab_name] ~= nil then
						local var_348_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_18.prefab_name].transform, "story_v_side_new_1104701", "1104701085", "story_v_side_new_1104701.awb")

						arg_345_1:RecordAudio("1104701085", var_348_24)
						arg_345_1:RecordAudio("1104701085", var_348_24)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701085", "story_v_side_new_1104701.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701085", "story_v_side_new_1104701.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_25 = math.max(var_348_16, arg_345_1.talkMaxDuration)

			if var_348_15 <= arg_345_1.time_ and arg_345_1.time_ < var_348_15 + var_348_25 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_15) / var_348_25

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_15 + var_348_25 and arg_345_1.time_ < var_348_15 + var_348_25 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play1104701086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1104701086
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1104701087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["1047ui_story"]
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1047ui_story == nil then
				arg_349_1.var_.characterEffect1047ui_story = var_352_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 and not isNil(var_352_0) then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2

				if arg_349_1.var_.characterEffect1047ui_story and not isNil(var_352_0) then
					local var_352_4 = Mathf.Lerp(0, 0.5, var_352_3)

					arg_349_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1047ui_story.fillRatio = var_352_4
				end
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1047ui_story then
				local var_352_5 = 0.5

				arg_349_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1047ui_story.fillRatio = var_352_5
			end

			local var_352_6 = arg_349_1.actors_["1047ui_story"].transform
			local var_352_7 = 0

			if var_352_7 < arg_349_1.time_ and arg_349_1.time_ <= var_352_7 + arg_352_0 then
				arg_349_1.var_.moveOldPos1047ui_story = var_352_6.localPosition
			end

			local var_352_8 = 0.001

			if var_352_7 <= arg_349_1.time_ and arg_349_1.time_ < var_352_7 + var_352_8 then
				local var_352_9 = (arg_349_1.time_ - var_352_7) / var_352_8
				local var_352_10 = Vector3.New(0, 100, 0)

				var_352_6.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1047ui_story, var_352_10, var_352_9)

				local var_352_11 = manager.ui.mainCamera.transform.position - var_352_6.position

				var_352_6.forward = Vector3.New(var_352_11.x, var_352_11.y, var_352_11.z)

				local var_352_12 = var_352_6.localEulerAngles

				var_352_12.z = 0
				var_352_12.x = 0
				var_352_6.localEulerAngles = var_352_12
			end

			if arg_349_1.time_ >= var_352_7 + var_352_8 and arg_349_1.time_ < var_352_7 + var_352_8 + arg_352_0 then
				var_352_6.localPosition = Vector3.New(0, 100, 0)

				local var_352_13 = manager.ui.mainCamera.transform.position - var_352_6.position

				var_352_6.forward = Vector3.New(var_352_13.x, var_352_13.y, var_352_13.z)

				local var_352_14 = var_352_6.localEulerAngles

				var_352_14.z = 0
				var_352_14.x = 0
				var_352_6.localEulerAngles = var_352_14
			end

			local var_352_15 = 0
			local var_352_16 = 0.55

			if var_352_15 < arg_349_1.time_ and arg_349_1.time_ <= var_352_15 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_17 = arg_349_1:GetWordFromCfg(1104701086)
				local var_352_18 = arg_349_1:FormatText(var_352_17.content)

				arg_349_1.text_.text = var_352_18

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_19 = 22
				local var_352_20 = utf8.len(var_352_18)
				local var_352_21 = var_352_19 <= 0 and var_352_16 or var_352_16 * (var_352_20 / var_352_19)

				if var_352_21 > 0 and var_352_16 < var_352_21 then
					arg_349_1.talkMaxDuration = var_352_21

					if var_352_21 + var_352_15 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_21 + var_352_15
					end
				end

				arg_349_1.text_.text = var_352_18
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_22 = math.max(var_352_16, arg_349_1.talkMaxDuration)

			if var_352_15 <= arg_349_1.time_ and arg_349_1.time_ < var_352_15 + var_352_22 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_15) / var_352_22

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_15 + var_352_22 and arg_349_1.time_ < var_352_15 + var_352_22 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play1104701087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1104701087
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1104701088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0
			local var_356_1 = 0.9

			if var_356_0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_2 = arg_353_1:FormatText(StoryNameCfg[7].name)

				arg_353_1.leftNameTxt_.text = var_356_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_3 = arg_353_1:GetWordFromCfg(1104701087)
				local var_356_4 = arg_353_1:FormatText(var_356_3.content)

				arg_353_1.text_.text = var_356_4

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_5 = 36
				local var_356_6 = utf8.len(var_356_4)
				local var_356_7 = var_356_5 <= 0 and var_356_1 or var_356_1 * (var_356_6 / var_356_5)

				if var_356_7 > 0 and var_356_1 < var_356_7 then
					arg_353_1.talkMaxDuration = var_356_7

					if var_356_7 + var_356_0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_7 + var_356_0
					end
				end

				arg_353_1.text_.text = var_356_4
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_8 = math.max(var_356_1, arg_353_1.talkMaxDuration)

			if var_356_0 <= arg_353_1.time_ and arg_353_1.time_ < var_356_0 + var_356_8 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_0) / var_356_8

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_0 + var_356_8 and arg_353_1.time_ < var_356_0 + var_356_8 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play1104701088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1104701088
		arg_357_1.duration_ = 3.03

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play1104701089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1047ui_story"].transform
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 then
				arg_357_1.var_.moveOldPos1047ui_story = var_360_0.localPosition
			end

			local var_360_2 = 0.001

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2
				local var_360_4 = Vector3.New(0, -1.13, -6.2)

				var_360_0.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1047ui_story, var_360_4, var_360_3)

				local var_360_5 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_5.x, var_360_5.y, var_360_5.z)

				local var_360_6 = var_360_0.localEulerAngles

				var_360_6.z = 0
				var_360_6.x = 0
				var_360_0.localEulerAngles = var_360_6
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 then
				var_360_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_360_7 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_7.x, var_360_7.y, var_360_7.z)

				local var_360_8 = var_360_0.localEulerAngles

				var_360_8.z = 0
				var_360_8.x = 0
				var_360_0.localEulerAngles = var_360_8
			end

			local var_360_9 = arg_357_1.actors_["1047ui_story"]
			local var_360_10 = 0

			if var_360_10 < arg_357_1.time_ and arg_357_1.time_ <= var_360_10 + arg_360_0 and not isNil(var_360_9) and arg_357_1.var_.characterEffect1047ui_story == nil then
				arg_357_1.var_.characterEffect1047ui_story = var_360_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_11 = 0.200000002980232

			if var_360_10 <= arg_357_1.time_ and arg_357_1.time_ < var_360_10 + var_360_11 and not isNil(var_360_9) then
				local var_360_12 = (arg_357_1.time_ - var_360_10) / var_360_11

				if arg_357_1.var_.characterEffect1047ui_story and not isNil(var_360_9) then
					arg_357_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= var_360_10 + var_360_11 and arg_357_1.time_ < var_360_10 + var_360_11 + arg_360_0 and not isNil(var_360_9) and arg_357_1.var_.characterEffect1047ui_story then
				arg_357_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_360_13 = 0

			if var_360_13 < arg_357_1.time_ and arg_357_1.time_ <= var_360_13 + arg_360_0 then
				arg_357_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_360_14 = 0

			if var_360_14 < arg_357_1.time_ and arg_357_1.time_ <= var_360_14 + arg_360_0 then
				arg_357_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_360_15 = 0
			local var_360_16 = 0.225

			if var_360_15 < arg_357_1.time_ and arg_357_1.time_ <= var_360_15 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_17 = arg_357_1:FormatText(StoryNameCfg[1296].name)

				arg_357_1.leftNameTxt_.text = var_360_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_18 = arg_357_1:GetWordFromCfg(1104701088)
				local var_360_19 = arg_357_1:FormatText(var_360_18.content)

				arg_357_1.text_.text = var_360_19

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_20 = 9
				local var_360_21 = utf8.len(var_360_19)
				local var_360_22 = var_360_20 <= 0 and var_360_16 or var_360_16 * (var_360_21 / var_360_20)

				if var_360_22 > 0 and var_360_16 < var_360_22 then
					arg_357_1.talkMaxDuration = var_360_22

					if var_360_22 + var_360_15 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_22 + var_360_15
					end
				end

				arg_357_1.text_.text = var_360_19
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701088", "story_v_side_new_1104701.awb") ~= 0 then
					local var_360_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701088", "story_v_side_new_1104701.awb") / 1000

					if var_360_23 + var_360_15 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_23 + var_360_15
					end

					if var_360_18.prefab_name ~= "" and arg_357_1.actors_[var_360_18.prefab_name] ~= nil then
						local var_360_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_18.prefab_name].transform, "story_v_side_new_1104701", "1104701088", "story_v_side_new_1104701.awb")

						arg_357_1:RecordAudio("1104701088", var_360_24)
						arg_357_1:RecordAudio("1104701088", var_360_24)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701088", "story_v_side_new_1104701.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701088", "story_v_side_new_1104701.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_25 = math.max(var_360_16, arg_357_1.talkMaxDuration)

			if var_360_15 <= arg_357_1.time_ and arg_357_1.time_ < var_360_15 + var_360_25 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_15) / var_360_25

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_15 + var_360_25 and arg_357_1.time_ < var_360_15 + var_360_25 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play1104701089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1104701089
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play1104701090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["1047ui_story"]
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect1047ui_story == nil then
				arg_361_1.var_.characterEffect1047ui_story = var_364_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_2 = 0.200000002980232

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_2 and not isNil(var_364_0) then
				local var_364_3 = (arg_361_1.time_ - var_364_1) / var_364_2

				if arg_361_1.var_.characterEffect1047ui_story and not isNil(var_364_0) then
					local var_364_4 = Mathf.Lerp(0, 0.5, var_364_3)

					arg_361_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1047ui_story.fillRatio = var_364_4
				end
			end

			if arg_361_1.time_ >= var_364_1 + var_364_2 and arg_361_1.time_ < var_364_1 + var_364_2 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect1047ui_story then
				local var_364_5 = 0.5

				arg_361_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1047ui_story.fillRatio = var_364_5
			end

			local var_364_6 = arg_361_1.actors_["1047ui_story"].transform
			local var_364_7 = 0

			if var_364_7 < arg_361_1.time_ and arg_361_1.time_ <= var_364_7 + arg_364_0 then
				arg_361_1.var_.moveOldPos1047ui_story = var_364_6.localPosition
			end

			local var_364_8 = 0.001

			if var_364_7 <= arg_361_1.time_ and arg_361_1.time_ < var_364_7 + var_364_8 then
				local var_364_9 = (arg_361_1.time_ - var_364_7) / var_364_8
				local var_364_10 = Vector3.New(0, 100, 0)

				var_364_6.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1047ui_story, var_364_10, var_364_9)

				local var_364_11 = manager.ui.mainCamera.transform.position - var_364_6.position

				var_364_6.forward = Vector3.New(var_364_11.x, var_364_11.y, var_364_11.z)

				local var_364_12 = var_364_6.localEulerAngles

				var_364_12.z = 0
				var_364_12.x = 0
				var_364_6.localEulerAngles = var_364_12
			end

			if arg_361_1.time_ >= var_364_7 + var_364_8 and arg_361_1.time_ < var_364_7 + var_364_8 + arg_364_0 then
				var_364_6.localPosition = Vector3.New(0, 100, 0)

				local var_364_13 = manager.ui.mainCamera.transform.position - var_364_6.position

				var_364_6.forward = Vector3.New(var_364_13.x, var_364_13.y, var_364_13.z)

				local var_364_14 = var_364_6.localEulerAngles

				var_364_14.z = 0
				var_364_14.x = 0
				var_364_6.localEulerAngles = var_364_14
			end

			local var_364_15 = 0
			local var_364_16 = 0.95

			if var_364_15 < arg_361_1.time_ and arg_361_1.time_ <= var_364_15 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_17 = arg_361_1:GetWordFromCfg(1104701089)
				local var_364_18 = arg_361_1:FormatText(var_364_17.content)

				arg_361_1.text_.text = var_364_18

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_19 = 38
				local var_364_20 = utf8.len(var_364_18)
				local var_364_21 = var_364_19 <= 0 and var_364_16 or var_364_16 * (var_364_20 / var_364_19)

				if var_364_21 > 0 and var_364_16 < var_364_21 then
					arg_361_1.talkMaxDuration = var_364_21

					if var_364_21 + var_364_15 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_21 + var_364_15
					end
				end

				arg_361_1.text_.text = var_364_18
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_22 = math.max(var_364_16, arg_361_1.talkMaxDuration)

			if var_364_15 <= arg_361_1.time_ and arg_361_1.time_ < var_364_15 + var_364_22 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_15) / var_364_22

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_15 + var_364_22 and arg_361_1.time_ < var_364_15 + var_364_22 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_361_1:InitPlayNodeList()
	end,
	Play1104701090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 1104701090
		arg_365_1.duration_ = 3.97

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play1104701091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["1047ui_story"].transform
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 then
				arg_365_1.var_.moveOldPos1047ui_story = var_368_0.localPosition
			end

			local var_368_2 = 0.001

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_2 then
				local var_368_3 = (arg_365_1.time_ - var_368_1) / var_368_2
				local var_368_4 = Vector3.New(0, -1.13, -6.2)

				var_368_0.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1047ui_story, var_368_4, var_368_3)

				local var_368_5 = manager.ui.mainCamera.transform.position - var_368_0.position

				var_368_0.forward = Vector3.New(var_368_5.x, var_368_5.y, var_368_5.z)

				local var_368_6 = var_368_0.localEulerAngles

				var_368_6.z = 0
				var_368_6.x = 0
				var_368_0.localEulerAngles = var_368_6
			end

			if arg_365_1.time_ >= var_368_1 + var_368_2 and arg_365_1.time_ < var_368_1 + var_368_2 + arg_368_0 then
				var_368_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_368_7 = manager.ui.mainCamera.transform.position - var_368_0.position

				var_368_0.forward = Vector3.New(var_368_7.x, var_368_7.y, var_368_7.z)

				local var_368_8 = var_368_0.localEulerAngles

				var_368_8.z = 0
				var_368_8.x = 0
				var_368_0.localEulerAngles = var_368_8
			end

			local var_368_9 = arg_365_1.actors_["1047ui_story"]
			local var_368_10 = 0

			if var_368_10 < arg_365_1.time_ and arg_365_1.time_ <= var_368_10 + arg_368_0 and not isNil(var_368_9) and arg_365_1.var_.characterEffect1047ui_story == nil then
				arg_365_1.var_.characterEffect1047ui_story = var_368_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_11 = 0.200000002980232

			if var_368_10 <= arg_365_1.time_ and arg_365_1.time_ < var_368_10 + var_368_11 and not isNil(var_368_9) then
				local var_368_12 = (arg_365_1.time_ - var_368_10) / var_368_11

				if arg_365_1.var_.characterEffect1047ui_story and not isNil(var_368_9) then
					arg_365_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= var_368_10 + var_368_11 and arg_365_1.time_ < var_368_10 + var_368_11 + arg_368_0 and not isNil(var_368_9) and arg_365_1.var_.characterEffect1047ui_story then
				arg_365_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_368_13 = 0

			if var_368_13 < arg_365_1.time_ and arg_365_1.time_ <= var_368_13 + arg_368_0 then
				arg_365_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_368_14 = 0

			if var_368_14 < arg_365_1.time_ and arg_365_1.time_ <= var_368_14 + arg_368_0 then
				arg_365_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_368_15 = 0
			local var_368_16 = 0.45

			if var_368_15 < arg_365_1.time_ and arg_365_1.time_ <= var_368_15 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_17 = arg_365_1:FormatText(StoryNameCfg[1296].name)

				arg_365_1.leftNameTxt_.text = var_368_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_18 = arg_365_1:GetWordFromCfg(1104701090)
				local var_368_19 = arg_365_1:FormatText(var_368_18.content)

				arg_365_1.text_.text = var_368_19

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_20 = 18
				local var_368_21 = utf8.len(var_368_19)
				local var_368_22 = var_368_20 <= 0 and var_368_16 or var_368_16 * (var_368_21 / var_368_20)

				if var_368_22 > 0 and var_368_16 < var_368_22 then
					arg_365_1.talkMaxDuration = var_368_22

					if var_368_22 + var_368_15 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_22 + var_368_15
					end
				end

				arg_365_1.text_.text = var_368_19
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701090", "story_v_side_new_1104701.awb") ~= 0 then
					local var_368_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701090", "story_v_side_new_1104701.awb") / 1000

					if var_368_23 + var_368_15 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_23 + var_368_15
					end

					if var_368_18.prefab_name ~= "" and arg_365_1.actors_[var_368_18.prefab_name] ~= nil then
						local var_368_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_18.prefab_name].transform, "story_v_side_new_1104701", "1104701090", "story_v_side_new_1104701.awb")

						arg_365_1:RecordAudio("1104701090", var_368_24)
						arg_365_1:RecordAudio("1104701090", var_368_24)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701090", "story_v_side_new_1104701.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701090", "story_v_side_new_1104701.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_25 = math.max(var_368_16, arg_365_1.talkMaxDuration)

			if var_368_15 <= arg_365_1.time_ and arg_365_1.time_ < var_368_15 + var_368_25 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_15) / var_368_25

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_15 + var_368_25 and arg_365_1.time_ < var_368_15 + var_368_25 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_365_1:InitPlayNodeList()
	end,
	Play1104701091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 1104701091
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play1104701092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["1047ui_story"]
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect1047ui_story == nil then
				arg_369_1.var_.characterEffect1047ui_story = var_372_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_2 = 0.200000002980232

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 and not isNil(var_372_0) then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2

				if arg_369_1.var_.characterEffect1047ui_story and not isNil(var_372_0) then
					local var_372_4 = Mathf.Lerp(0, 0.5, var_372_3)

					arg_369_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1047ui_story.fillRatio = var_372_4
				end
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect1047ui_story then
				local var_372_5 = 0.5

				arg_369_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1047ui_story.fillRatio = var_372_5
			end

			local var_372_6 = 0
			local var_372_7 = 0.175

			if var_372_6 < arg_369_1.time_ and arg_369_1.time_ <= var_372_6 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_8 = arg_369_1:FormatText(StoryNameCfg[7].name)

				arg_369_1.leftNameTxt_.text = var_372_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_9 = arg_369_1:GetWordFromCfg(1104701091)
				local var_372_10 = arg_369_1:FormatText(var_372_9.content)

				arg_369_1.text_.text = var_372_10

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_11 = 7
				local var_372_12 = utf8.len(var_372_10)
				local var_372_13 = var_372_11 <= 0 and var_372_7 or var_372_7 * (var_372_12 / var_372_11)

				if var_372_13 > 0 and var_372_7 < var_372_13 then
					arg_369_1.talkMaxDuration = var_372_13

					if var_372_13 + var_372_6 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_13 + var_372_6
					end
				end

				arg_369_1.text_.text = var_372_10
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_14 = math.max(var_372_7, arg_369_1.talkMaxDuration)

			if var_372_6 <= arg_369_1.time_ and arg_369_1.time_ < var_372_6 + var_372_14 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_6) / var_372_14

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_6 + var_372_14 and arg_369_1.time_ < var_372_6 + var_372_14 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play1104701092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 1104701092
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play1104701093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["1047ui_story"].transform
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.var_.moveOldPos1047ui_story = var_376_0.localPosition
			end

			local var_376_2 = 0.001

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 then
				local var_376_3 = (arg_373_1.time_ - var_376_1) / var_376_2
				local var_376_4 = Vector3.New(0, 100, 0)

				var_376_0.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1047ui_story, var_376_4, var_376_3)

				local var_376_5 = manager.ui.mainCamera.transform.position - var_376_0.position

				var_376_0.forward = Vector3.New(var_376_5.x, var_376_5.y, var_376_5.z)

				local var_376_6 = var_376_0.localEulerAngles

				var_376_6.z = 0
				var_376_6.x = 0
				var_376_0.localEulerAngles = var_376_6
			end

			if arg_373_1.time_ >= var_376_1 + var_376_2 and arg_373_1.time_ < var_376_1 + var_376_2 + arg_376_0 then
				var_376_0.localPosition = Vector3.New(0, 100, 0)

				local var_376_7 = manager.ui.mainCamera.transform.position - var_376_0.position

				var_376_0.forward = Vector3.New(var_376_7.x, var_376_7.y, var_376_7.z)

				local var_376_8 = var_376_0.localEulerAngles

				var_376_8.z = 0
				var_376_8.x = 0
				var_376_0.localEulerAngles = var_376_8
			end

			local var_376_9 = 0
			local var_376_10 = 0.9

			if var_376_9 < arg_373_1.time_ and arg_373_1.time_ <= var_376_9 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_11 = arg_373_1:GetWordFromCfg(1104701092)
				local var_376_12 = arg_373_1:FormatText(var_376_11.content)

				arg_373_1.text_.text = var_376_12

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_13 = 36
				local var_376_14 = utf8.len(var_376_12)
				local var_376_15 = var_376_13 <= 0 and var_376_10 or var_376_10 * (var_376_14 / var_376_13)

				if var_376_15 > 0 and var_376_10 < var_376_15 then
					arg_373_1.talkMaxDuration = var_376_15

					if var_376_15 + var_376_9 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_15 + var_376_9
					end
				end

				arg_373_1.text_.text = var_376_12
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_16 = math.max(var_376_10, arg_373_1.talkMaxDuration)

			if var_376_9 <= arg_373_1.time_ and arg_373_1.time_ < var_376_9 + var_376_16 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_9) / var_376_16

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_9 + var_376_16 and arg_373_1.time_ < var_376_9 + var_376_16 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play1104701093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 1104701093
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play1104701094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0
			local var_380_1 = 0.35

			if var_380_0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_2 = arg_377_1:FormatText(StoryNameCfg[7].name)

				arg_377_1.leftNameTxt_.text = var_380_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_3 = arg_377_1:GetWordFromCfg(1104701093)
				local var_380_4 = arg_377_1:FormatText(var_380_3.content)

				arg_377_1.text_.text = var_380_4

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_5 = 14
				local var_380_6 = utf8.len(var_380_4)
				local var_380_7 = var_380_5 <= 0 and var_380_1 or var_380_1 * (var_380_6 / var_380_5)

				if var_380_7 > 0 and var_380_1 < var_380_7 then
					arg_377_1.talkMaxDuration = var_380_7

					if var_380_7 + var_380_0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_7 + var_380_0
					end
				end

				arg_377_1.text_.text = var_380_4
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_8 = math.max(var_380_1, arg_377_1.talkMaxDuration)

			if var_380_0 <= arg_377_1.time_ and arg_377_1.time_ < var_380_0 + var_380_8 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_0) / var_380_8

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_0 + var_380_8 and arg_377_1.time_ < var_380_0 + var_380_8 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play1104701094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 1104701094
		arg_381_1.duration_ = 7.53

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play1104701095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["1047ui_story"].transform
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 then
				arg_381_1.var_.moveOldPos1047ui_story = var_384_0.localPosition
			end

			local var_384_2 = 0.001

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_2 then
				local var_384_3 = (arg_381_1.time_ - var_384_1) / var_384_2
				local var_384_4 = Vector3.New(0, -1.13, -6.2)

				var_384_0.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1047ui_story, var_384_4, var_384_3)

				local var_384_5 = manager.ui.mainCamera.transform.position - var_384_0.position

				var_384_0.forward = Vector3.New(var_384_5.x, var_384_5.y, var_384_5.z)

				local var_384_6 = var_384_0.localEulerAngles

				var_384_6.z = 0
				var_384_6.x = 0
				var_384_0.localEulerAngles = var_384_6
			end

			if arg_381_1.time_ >= var_384_1 + var_384_2 and arg_381_1.time_ < var_384_1 + var_384_2 + arg_384_0 then
				var_384_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_384_7 = manager.ui.mainCamera.transform.position - var_384_0.position

				var_384_0.forward = Vector3.New(var_384_7.x, var_384_7.y, var_384_7.z)

				local var_384_8 = var_384_0.localEulerAngles

				var_384_8.z = 0
				var_384_8.x = 0
				var_384_0.localEulerAngles = var_384_8
			end

			local var_384_9 = arg_381_1.actors_["1047ui_story"]
			local var_384_10 = 0

			if var_384_10 < arg_381_1.time_ and arg_381_1.time_ <= var_384_10 + arg_384_0 and not isNil(var_384_9) and arg_381_1.var_.characterEffect1047ui_story == nil then
				arg_381_1.var_.characterEffect1047ui_story = var_384_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_11 = 0.200000002980232

			if var_384_10 <= arg_381_1.time_ and arg_381_1.time_ < var_384_10 + var_384_11 and not isNil(var_384_9) then
				local var_384_12 = (arg_381_1.time_ - var_384_10) / var_384_11

				if arg_381_1.var_.characterEffect1047ui_story and not isNil(var_384_9) then
					arg_381_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= var_384_10 + var_384_11 and arg_381_1.time_ < var_384_10 + var_384_11 + arg_384_0 and not isNil(var_384_9) and arg_381_1.var_.characterEffect1047ui_story then
				arg_381_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_384_13 = 0

			if var_384_13 < arg_381_1.time_ and arg_381_1.time_ <= var_384_13 + arg_384_0 then
				arg_381_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			local var_384_14 = 0

			if var_384_14 < arg_381_1.time_ and arg_381_1.time_ <= var_384_14 + arg_384_0 then
				arg_381_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_384_15 = 0
			local var_384_16 = 0.6

			if var_384_15 < arg_381_1.time_ and arg_381_1.time_ <= var_384_15 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_17 = arg_381_1:FormatText(StoryNameCfg[1296].name)

				arg_381_1.leftNameTxt_.text = var_384_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_18 = arg_381_1:GetWordFromCfg(1104701094)
				local var_384_19 = arg_381_1:FormatText(var_384_18.content)

				arg_381_1.text_.text = var_384_19

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_20 = 24
				local var_384_21 = utf8.len(var_384_19)
				local var_384_22 = var_384_20 <= 0 and var_384_16 or var_384_16 * (var_384_21 / var_384_20)

				if var_384_22 > 0 and var_384_16 < var_384_22 then
					arg_381_1.talkMaxDuration = var_384_22

					if var_384_22 + var_384_15 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_22 + var_384_15
					end
				end

				arg_381_1.text_.text = var_384_19
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701094", "story_v_side_new_1104701.awb") ~= 0 then
					local var_384_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701094", "story_v_side_new_1104701.awb") / 1000

					if var_384_23 + var_384_15 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_23 + var_384_15
					end

					if var_384_18.prefab_name ~= "" and arg_381_1.actors_[var_384_18.prefab_name] ~= nil then
						local var_384_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_18.prefab_name].transform, "story_v_side_new_1104701", "1104701094", "story_v_side_new_1104701.awb")

						arg_381_1:RecordAudio("1104701094", var_384_24)
						arg_381_1:RecordAudio("1104701094", var_384_24)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701094", "story_v_side_new_1104701.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701094", "story_v_side_new_1104701.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_25 = math.max(var_384_16, arg_381_1.talkMaxDuration)

			if var_384_15 <= arg_381_1.time_ and arg_381_1.time_ < var_384_15 + var_384_25 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_15) / var_384_25

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_15 + var_384_25 and arg_381_1.time_ < var_384_15 + var_384_25 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_381_1:InitPlayNodeList()
	end,
	Play1104701095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 1104701095
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play1104701096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["1047ui_story"]
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect1047ui_story == nil then
				arg_385_1.var_.characterEffect1047ui_story = var_388_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.200000002980232

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 and not isNil(var_388_0) then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2

				if arg_385_1.var_.characterEffect1047ui_story and not isNil(var_388_0) then
					local var_388_4 = Mathf.Lerp(0, 0.5, var_388_3)

					arg_385_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1047ui_story.fillRatio = var_388_4
				end
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect1047ui_story then
				local var_388_5 = 0.5

				arg_385_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1047ui_story.fillRatio = var_388_5
			end

			local var_388_6 = 0
			local var_388_7 = 0.175

			if var_388_6 < arg_385_1.time_ and arg_385_1.time_ <= var_388_6 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_8 = arg_385_1:FormatText(StoryNameCfg[7].name)

				arg_385_1.leftNameTxt_.text = var_388_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, true)
				arg_385_1.iconController_:SetSelectedState("hero")

				arg_385_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_385_1.callingController_:SetSelectedState("normal")

				arg_385_1.keyicon_.color = Color.New(1, 1, 1)
				arg_385_1.icon_.color = Color.New(1, 1, 1)

				local var_388_9 = arg_385_1:GetWordFromCfg(1104701095)
				local var_388_10 = arg_385_1:FormatText(var_388_9.content)

				arg_385_1.text_.text = var_388_10

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_11 = 7
				local var_388_12 = utf8.len(var_388_10)
				local var_388_13 = var_388_11 <= 0 and var_388_7 or var_388_7 * (var_388_12 / var_388_11)

				if var_388_13 > 0 and var_388_7 < var_388_13 then
					arg_385_1.talkMaxDuration = var_388_13

					if var_388_13 + var_388_6 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_13 + var_388_6
					end
				end

				arg_385_1.text_.text = var_388_10
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_14 = math.max(var_388_7, arg_385_1.talkMaxDuration)

			if var_388_6 <= arg_385_1.time_ and arg_385_1.time_ < var_388_6 + var_388_14 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_6) / var_388_14

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_6 + var_388_14 and arg_385_1.time_ < var_388_6 + var_388_14 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play1104701096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 1104701096
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play1104701097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["1047ui_story"].transform
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
				arg_389_1.var_.moveOldPos1047ui_story = var_392_0.localPosition
			end

			local var_392_2 = 0.001

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_2 then
				local var_392_3 = (arg_389_1.time_ - var_392_1) / var_392_2
				local var_392_4 = Vector3.New(0, 100, 0)

				var_392_0.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1047ui_story, var_392_4, var_392_3)

				local var_392_5 = manager.ui.mainCamera.transform.position - var_392_0.position

				var_392_0.forward = Vector3.New(var_392_5.x, var_392_5.y, var_392_5.z)

				local var_392_6 = var_392_0.localEulerAngles

				var_392_6.z = 0
				var_392_6.x = 0
				var_392_0.localEulerAngles = var_392_6
			end

			if arg_389_1.time_ >= var_392_1 + var_392_2 and arg_389_1.time_ < var_392_1 + var_392_2 + arg_392_0 then
				var_392_0.localPosition = Vector3.New(0, 100, 0)

				local var_392_7 = manager.ui.mainCamera.transform.position - var_392_0.position

				var_392_0.forward = Vector3.New(var_392_7.x, var_392_7.y, var_392_7.z)

				local var_392_8 = var_392_0.localEulerAngles

				var_392_8.z = 0
				var_392_8.x = 0
				var_392_0.localEulerAngles = var_392_8
			end

			local var_392_9 = 0
			local var_392_10 = 0.925

			if var_392_9 < arg_389_1.time_ and arg_389_1.time_ <= var_392_9 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_11 = arg_389_1:GetWordFromCfg(1104701096)
				local var_392_12 = arg_389_1:FormatText(var_392_11.content)

				arg_389_1.text_.text = var_392_12

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_13 = 37
				local var_392_14 = utf8.len(var_392_12)
				local var_392_15 = var_392_13 <= 0 and var_392_10 or var_392_10 * (var_392_14 / var_392_13)

				if var_392_15 > 0 and var_392_10 < var_392_15 then
					arg_389_1.talkMaxDuration = var_392_15

					if var_392_15 + var_392_9 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_15 + var_392_9
					end
				end

				arg_389_1.text_.text = var_392_12
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_16 = math.max(var_392_10, arg_389_1.talkMaxDuration)

			if var_392_9 <= arg_389_1.time_ and arg_389_1.time_ < var_392_9 + var_392_16 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_9) / var_392_16

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_9 + var_392_16 and arg_389_1.time_ < var_392_9 + var_392_16 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_389_1:InitPlayNodeList()
	end,
	Play1104701097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 1104701097
		arg_393_1.duration_ = 11.47

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play1104701098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1047ui_story"].transform
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1.var_.moveOldPos1047ui_story = var_396_0.localPosition
			end

			local var_396_2 = 0.001

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_2 then
				local var_396_3 = (arg_393_1.time_ - var_396_1) / var_396_2
				local var_396_4 = Vector3.New(0, -1.13, -6.2)

				var_396_0.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1047ui_story, var_396_4, var_396_3)

				local var_396_5 = manager.ui.mainCamera.transform.position - var_396_0.position

				var_396_0.forward = Vector3.New(var_396_5.x, var_396_5.y, var_396_5.z)

				local var_396_6 = var_396_0.localEulerAngles

				var_396_6.z = 0
				var_396_6.x = 0
				var_396_0.localEulerAngles = var_396_6
			end

			if arg_393_1.time_ >= var_396_1 + var_396_2 and arg_393_1.time_ < var_396_1 + var_396_2 + arg_396_0 then
				var_396_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_396_7 = manager.ui.mainCamera.transform.position - var_396_0.position

				var_396_0.forward = Vector3.New(var_396_7.x, var_396_7.y, var_396_7.z)

				local var_396_8 = var_396_0.localEulerAngles

				var_396_8.z = 0
				var_396_8.x = 0
				var_396_0.localEulerAngles = var_396_8
			end

			local var_396_9 = arg_393_1.actors_["1047ui_story"]
			local var_396_10 = 0

			if var_396_10 < arg_393_1.time_ and arg_393_1.time_ <= var_396_10 + arg_396_0 and not isNil(var_396_9) and arg_393_1.var_.characterEffect1047ui_story == nil then
				arg_393_1.var_.characterEffect1047ui_story = var_396_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_11 = 0.200000002980232

			if var_396_10 <= arg_393_1.time_ and arg_393_1.time_ < var_396_10 + var_396_11 and not isNil(var_396_9) then
				local var_396_12 = (arg_393_1.time_ - var_396_10) / var_396_11

				if arg_393_1.var_.characterEffect1047ui_story and not isNil(var_396_9) then
					arg_393_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_393_1.time_ >= var_396_10 + var_396_11 and arg_393_1.time_ < var_396_10 + var_396_11 + arg_396_0 and not isNil(var_396_9) and arg_393_1.var_.characterEffect1047ui_story then
				arg_393_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_396_13 = 0

			if var_396_13 < arg_393_1.time_ and arg_393_1.time_ <= var_396_13 + arg_396_0 then
				arg_393_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_396_14 = 0

			if var_396_14 < arg_393_1.time_ and arg_393_1.time_ <= var_396_14 + arg_396_0 then
				arg_393_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_396_15 = 0
			local var_396_16 = 1.2

			if var_396_15 < arg_393_1.time_ and arg_393_1.time_ <= var_396_15 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_17 = arg_393_1:FormatText(StoryNameCfg[1296].name)

				arg_393_1.leftNameTxt_.text = var_396_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_18 = arg_393_1:GetWordFromCfg(1104701097)
				local var_396_19 = arg_393_1:FormatText(var_396_18.content)

				arg_393_1.text_.text = var_396_19

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_20 = 48
				local var_396_21 = utf8.len(var_396_19)
				local var_396_22 = var_396_20 <= 0 and var_396_16 or var_396_16 * (var_396_21 / var_396_20)

				if var_396_22 > 0 and var_396_16 < var_396_22 then
					arg_393_1.talkMaxDuration = var_396_22

					if var_396_22 + var_396_15 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_22 + var_396_15
					end
				end

				arg_393_1.text_.text = var_396_19
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701097", "story_v_side_new_1104701.awb") ~= 0 then
					local var_396_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701097", "story_v_side_new_1104701.awb") / 1000

					if var_396_23 + var_396_15 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_23 + var_396_15
					end

					if var_396_18.prefab_name ~= "" and arg_393_1.actors_[var_396_18.prefab_name] ~= nil then
						local var_396_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_18.prefab_name].transform, "story_v_side_new_1104701", "1104701097", "story_v_side_new_1104701.awb")

						arg_393_1:RecordAudio("1104701097", var_396_24)
						arg_393_1:RecordAudio("1104701097", var_396_24)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701097", "story_v_side_new_1104701.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701097", "story_v_side_new_1104701.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_25 = math.max(var_396_16, arg_393_1.talkMaxDuration)

			if var_396_15 <= arg_393_1.time_ and arg_393_1.time_ < var_396_15 + var_396_25 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_15) / var_396_25

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_15 + var_396_25 and arg_393_1.time_ < var_396_15 + var_396_25 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play1104701098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1104701098
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play1104701099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["1047ui_story"]
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1047ui_story == nil then
				arg_397_1.var_.characterEffect1047ui_story = var_400_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_2 = 0.200000002980232

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 and not isNil(var_400_0) then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2

				if arg_397_1.var_.characterEffect1047ui_story and not isNil(var_400_0) then
					local var_400_4 = Mathf.Lerp(0, 0.5, var_400_3)

					arg_397_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_397_1.var_.characterEffect1047ui_story.fillRatio = var_400_4
				end
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1047ui_story then
				local var_400_5 = 0.5

				arg_397_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_397_1.var_.characterEffect1047ui_story.fillRatio = var_400_5
			end

			local var_400_6 = arg_397_1.actors_["1047ui_story"].transform
			local var_400_7 = 0

			if var_400_7 < arg_397_1.time_ and arg_397_1.time_ <= var_400_7 + arg_400_0 then
				arg_397_1.var_.moveOldPos1047ui_story = var_400_6.localPosition
			end

			local var_400_8 = 0.001

			if var_400_7 <= arg_397_1.time_ and arg_397_1.time_ < var_400_7 + var_400_8 then
				local var_400_9 = (arg_397_1.time_ - var_400_7) / var_400_8
				local var_400_10 = Vector3.New(0, 100, 0)

				var_400_6.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos1047ui_story, var_400_10, var_400_9)

				local var_400_11 = manager.ui.mainCamera.transform.position - var_400_6.position

				var_400_6.forward = Vector3.New(var_400_11.x, var_400_11.y, var_400_11.z)

				local var_400_12 = var_400_6.localEulerAngles

				var_400_12.z = 0
				var_400_12.x = 0
				var_400_6.localEulerAngles = var_400_12
			end

			if arg_397_1.time_ >= var_400_7 + var_400_8 and arg_397_1.time_ < var_400_7 + var_400_8 + arg_400_0 then
				var_400_6.localPosition = Vector3.New(0, 100, 0)

				local var_400_13 = manager.ui.mainCamera.transform.position - var_400_6.position

				var_400_6.forward = Vector3.New(var_400_13.x, var_400_13.y, var_400_13.z)

				local var_400_14 = var_400_6.localEulerAngles

				var_400_14.z = 0
				var_400_14.x = 0
				var_400_6.localEulerAngles = var_400_14
			end

			local var_400_15 = 0
			local var_400_16 = 0.4

			if var_400_15 < arg_397_1.time_ and arg_397_1.time_ <= var_400_15 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_17 = arg_397_1:FormatText(StoryNameCfg[7].name)

				arg_397_1.leftNameTxt_.text = var_400_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_18 = arg_397_1:GetWordFromCfg(1104701098)
				local var_400_19 = arg_397_1:FormatText(var_400_18.content)

				arg_397_1.text_.text = var_400_19

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_20 = 16
				local var_400_21 = utf8.len(var_400_19)
				local var_400_22 = var_400_20 <= 0 and var_400_16 or var_400_16 * (var_400_21 / var_400_20)

				if var_400_22 > 0 and var_400_16 < var_400_22 then
					arg_397_1.talkMaxDuration = var_400_22

					if var_400_22 + var_400_15 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_22 + var_400_15
					end
				end

				arg_397_1.text_.text = var_400_19
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_23 = math.max(var_400_16, arg_397_1.talkMaxDuration)

			if var_400_15 <= arg_397_1.time_ and arg_397_1.time_ < var_400_15 + var_400_23 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_15) / var_400_23

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_15 + var_400_23 and arg_397_1.time_ < var_400_15 + var_400_23 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_397_1:InitPlayNodeList()
	end,
	Play1104701099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1104701099
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1104701100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0
			local var_404_1 = 1

			if var_404_0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_0 + arg_404_0 then
				local var_404_2 = "play"
				local var_404_3 = "effect"

				arg_401_1:AudioAction(var_404_2, var_404_3, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_404_4 = 0
			local var_404_5 = 0.725

			if var_404_4 < arg_401_1.time_ and arg_401_1.time_ <= var_404_4 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_6 = arg_401_1:GetWordFromCfg(1104701099)
				local var_404_7 = arg_401_1:FormatText(var_404_6.content)

				arg_401_1.text_.text = var_404_7

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_8 = 29
				local var_404_9 = utf8.len(var_404_7)
				local var_404_10 = var_404_8 <= 0 and var_404_5 or var_404_5 * (var_404_9 / var_404_8)

				if var_404_10 > 0 and var_404_5 < var_404_10 then
					arg_401_1.talkMaxDuration = var_404_10

					if var_404_10 + var_404_4 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_10 + var_404_4
					end
				end

				arg_401_1.text_.text = var_404_7
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_11 = math.max(var_404_5, arg_401_1.talkMaxDuration)

			if var_404_4 <= arg_401_1.time_ and arg_401_1.time_ < var_404_4 + var_404_11 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_4) / var_404_11

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_4 + var_404_11 and arg_401_1.time_ < var_404_4 + var_404_11 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play1104701100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1104701100
		arg_405_1.duration_ = 9

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1104701101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = "ST22"

			if arg_405_1.bgs_[var_408_0] == nil then
				local var_408_1 = Object.Instantiate(arg_405_1.paintGo_)

				var_408_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_408_0)
				var_408_1.name = var_408_0
				var_408_1.transform.parent = arg_405_1.stage_.transform
				var_408_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_405_1.bgs_[var_408_0] = var_408_1
			end

			local var_408_2 = 2

			if var_408_2 < arg_405_1.time_ and arg_405_1.time_ <= var_408_2 + arg_408_0 then
				local var_408_3 = manager.ui.mainCamera.transform.localPosition
				local var_408_4 = Vector3.New(0, 0, 10) + Vector3.New(var_408_3.x, var_408_3.y, 0)
				local var_408_5 = arg_405_1.bgs_.ST22

				var_408_5.transform.localPosition = var_408_4
				var_408_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_408_6 = var_408_5:GetComponent("SpriteRenderer")

				if var_408_6 and var_408_6.sprite then
					local var_408_7 = (var_408_5.transform.localPosition - var_408_3).z
					local var_408_8 = manager.ui.mainCameraCom_
					local var_408_9 = 2 * var_408_7 * Mathf.Tan(var_408_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_408_10 = var_408_9 * var_408_8.aspect
					local var_408_11 = var_408_6.sprite.bounds.size.x
					local var_408_12 = var_408_6.sprite.bounds.size.y
					local var_408_13 = var_408_10 / var_408_11
					local var_408_14 = var_408_9 / var_408_12
					local var_408_15 = var_408_14 < var_408_13 and var_408_13 or var_408_14

					var_408_5.transform.localScale = Vector3.New(var_408_15, var_408_15, 0)
				end

				for iter_408_0, iter_408_1 in pairs(arg_405_1.bgs_) do
					if iter_408_0 ~= "ST22" then
						iter_408_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_408_16 = 4

			if var_408_16 < arg_405_1.time_ and arg_405_1.time_ <= var_408_16 + arg_408_0 then
				arg_405_1.allBtn_.enabled = false
			end

			local var_408_17 = 0.3

			if arg_405_1.time_ >= var_408_16 + var_408_17 and arg_405_1.time_ < var_408_16 + var_408_17 + arg_408_0 then
				arg_405_1.allBtn_.enabled = true
			end

			local var_408_18 = 0

			if var_408_18 < arg_405_1.time_ and arg_405_1.time_ <= var_408_18 + arg_408_0 then
				arg_405_1.mask_.enabled = true
				arg_405_1.mask_.raycastTarget = true

				arg_405_1:SetGaussion(false)
			end

			local var_408_19 = 2

			if var_408_18 <= arg_405_1.time_ and arg_405_1.time_ < var_408_18 + var_408_19 then
				local var_408_20 = (arg_405_1.time_ - var_408_18) / var_408_19
				local var_408_21 = Color.New(0, 0, 0)

				var_408_21.a = Mathf.Lerp(0, 1, var_408_20)
				arg_405_1.mask_.color = var_408_21
			end

			if arg_405_1.time_ >= var_408_18 + var_408_19 and arg_405_1.time_ < var_408_18 + var_408_19 + arg_408_0 then
				local var_408_22 = Color.New(0, 0, 0)

				var_408_22.a = 1
				arg_405_1.mask_.color = var_408_22
			end

			local var_408_23 = 2

			if var_408_23 < arg_405_1.time_ and arg_405_1.time_ <= var_408_23 + arg_408_0 then
				arg_405_1.mask_.enabled = true
				arg_405_1.mask_.raycastTarget = true

				arg_405_1:SetGaussion(false)
			end

			local var_408_24 = 2

			if var_408_23 <= arg_405_1.time_ and arg_405_1.time_ < var_408_23 + var_408_24 then
				local var_408_25 = (arg_405_1.time_ - var_408_23) / var_408_24
				local var_408_26 = Color.New(0, 0, 0)

				var_408_26.a = Mathf.Lerp(1, 0, var_408_25)
				arg_405_1.mask_.color = var_408_26
			end

			if arg_405_1.time_ >= var_408_23 + var_408_24 and arg_405_1.time_ < var_408_23 + var_408_24 + arg_408_0 then
				local var_408_27 = Color.New(0, 0, 0)
				local var_408_28 = 0

				arg_405_1.mask_.enabled = false
				var_408_27.a = var_408_28
				arg_405_1.mask_.color = var_408_27
			end

			local var_408_29 = 1.2
			local var_408_30 = 1

			if var_408_29 < arg_405_1.time_ and arg_405_1.time_ <= var_408_29 + arg_408_0 then
				local var_408_31 = "stop"
				local var_408_32 = "effect"

				arg_405_1:AudioAction(var_408_31, var_408_32, "se_story_147", "se_story_147_amb_rooftop", "")
			end

			local var_408_33 = 0.1
			local var_408_34 = 1

			if var_408_33 < arg_405_1.time_ and arg_405_1.time_ <= var_408_33 + arg_408_0 then
				local var_408_35 = "play"
				local var_408_36 = "effect"

				arg_405_1:AudioAction(var_408_35, var_408_36, "se_story_140", "se_story_140_amb_street01", "")
			end

			local var_408_37 = 1
			local var_408_38 = 1

			if var_408_37 < arg_405_1.time_ and arg_405_1.time_ <= var_408_37 + arg_408_0 then
				local var_408_39 = "play"
				local var_408_40 = "music"

				arg_405_1:AudioAction(var_408_39, var_408_40, "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor.awb")

				local var_408_41 = ""
				local var_408_42 = manager.audio:GetAudioName("bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor")

				if var_408_42 ~= "" then
					if arg_405_1.bgmTxt_.text ~= var_408_42 and arg_405_1.bgmTxt_.text ~= "" then
						if arg_405_1.bgmTxt2_.text ~= "" then
							arg_405_1.bgmTxt_.text = arg_405_1.bgmTxt2_.text
						end

						arg_405_1.bgmTxt2_.text = var_408_42

						arg_405_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_405_1.bgmTxt_.text = var_408_42
						arg_405_1.bgmTxt2_.text = var_408_42
					end

					if arg_405_1.bgmTimer then
						arg_405_1.bgmTimer:Stop()

						arg_405_1.bgmTimer = nil
					end

					if arg_405_1.settingData.show_music_name == 1 then
						arg_405_1.musicController:SetSelectedState("show")
						arg_405_1.musicAnimator_:Play("open", 0, 0)

						if arg_405_1.settingData.music_time ~= 0 then
							arg_405_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_405_1.settingData.music_time), function()
								if arg_405_1 == nil or isNil(arg_405_1.bgmTxt_) then
									return
								end

								arg_405_1.musicController:SetSelectedState("hide")
								arg_405_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_405_1.frameCnt_ <= 1 then
				arg_405_1.dialog_:SetActive(false)
			end

			local var_408_43 = 4
			local var_408_44 = 1.2

			if var_408_43 < arg_405_1.time_ and arg_405_1.time_ <= var_408_43 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0

				arg_405_1.dialog_:SetActive(true)

				arg_405_1.dialogCg_.alpha = 0

				local var_408_45 = LeanTween.value(arg_405_1.dialog_, 0, 1, 0.3)

				var_408_45:setOnUpdate(LuaHelper.FloatAction(function(arg_410_0)
					arg_405_1.dialogCg_.alpha = arg_410_0
				end))
				var_408_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_405_1.dialog_)
					var_408_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_405_1.duration_ = arg_405_1.duration_ + 0.3

				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_46 = arg_405_1:GetWordFromCfg(1104701100)
				local var_408_47 = arg_405_1:FormatText(var_408_46.content)

				arg_405_1.text_.text = var_408_47

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_48 = 48
				local var_408_49 = utf8.len(var_408_47)
				local var_408_50 = var_408_48 <= 0 and var_408_44 or var_408_44 * (var_408_49 / var_408_48)

				if var_408_50 > 0 and var_408_44 < var_408_50 then
					arg_405_1.talkMaxDuration = var_408_50
					var_408_43 = var_408_43 + 0.3

					if var_408_50 + var_408_43 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_50 + var_408_43
					end
				end

				arg_405_1.text_.text = var_408_47
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_51 = var_408_43 + 0.3
			local var_408_52 = math.max(var_408_44, arg_405_1.talkMaxDuration)

			if var_408_51 <= arg_405_1.time_ and arg_405_1.time_ < var_408_51 + var_408_52 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_51) / var_408_52

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_51 + var_408_52 and arg_405_1.time_ < var_408_51 + var_408_52 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play1104701101 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 1104701101
		arg_412_1.duration_ = 6.53

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play1104701102(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0
			local var_415_1 = 0.75

			if var_415_0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_2 = arg_412_1:FormatText(StoryNameCfg[1516].name)

				arg_412_1.leftNameTxt_.text = var_415_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_412_1.callingController_:SetSelectedState("normal")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_3 = arg_412_1:GetWordFromCfg(1104701101)
				local var_415_4 = arg_412_1:FormatText(var_415_3.content)

				arg_412_1.text_.text = var_415_4

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_5 = 30
				local var_415_6 = utf8.len(var_415_4)
				local var_415_7 = var_415_5 <= 0 and var_415_1 or var_415_1 * (var_415_6 / var_415_5)

				if var_415_7 > 0 and var_415_1 < var_415_7 then
					arg_412_1.talkMaxDuration = var_415_7

					if var_415_7 + var_415_0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_7 + var_415_0
					end
				end

				arg_412_1.text_.text = var_415_4
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701101", "story_v_side_new_1104701.awb") ~= 0 then
					local var_415_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701101", "story_v_side_new_1104701.awb") / 1000

					if var_415_8 + var_415_0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_8 + var_415_0
					end

					if var_415_3.prefab_name ~= "" and arg_412_1.actors_[var_415_3.prefab_name] ~= nil then
						local var_415_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_3.prefab_name].transform, "story_v_side_new_1104701", "1104701101", "story_v_side_new_1104701.awb")

						arg_412_1:RecordAudio("1104701101", var_415_9)
						arg_412_1:RecordAudio("1104701101", var_415_9)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701101", "story_v_side_new_1104701.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701101", "story_v_side_new_1104701.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_10 = math.max(var_415_1, arg_412_1.talkMaxDuration)

			if var_415_0 <= arg_412_1.time_ and arg_412_1.time_ < var_415_0 + var_415_10 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_0) / var_415_10

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_0 + var_415_10 and arg_412_1.time_ < var_415_0 + var_415_10 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play1104701102 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 1104701102
		arg_416_1.duration_ = 7.27

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play1104701103(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0
			local var_419_1 = 0.525

			if var_419_0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_2 = arg_416_1:FormatText(StoryNameCfg[1518].name)

				arg_416_1.leftNameTxt_.text = var_419_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_3 = arg_416_1:GetWordFromCfg(1104701102)
				local var_419_4 = arg_416_1:FormatText(var_419_3.content)

				arg_416_1.text_.text = var_419_4

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_5 = 21
				local var_419_6 = utf8.len(var_419_4)
				local var_419_7 = var_419_5 <= 0 and var_419_1 or var_419_1 * (var_419_6 / var_419_5)

				if var_419_7 > 0 and var_419_1 < var_419_7 then
					arg_416_1.talkMaxDuration = var_419_7

					if var_419_7 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_7 + var_419_0
					end
				end

				arg_416_1.text_.text = var_419_4
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701102", "story_v_side_new_1104701.awb") ~= 0 then
					local var_419_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701102", "story_v_side_new_1104701.awb") / 1000

					if var_419_8 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_8 + var_419_0
					end

					if var_419_3.prefab_name ~= "" and arg_416_1.actors_[var_419_3.prefab_name] ~= nil then
						local var_419_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_3.prefab_name].transform, "story_v_side_new_1104701", "1104701102", "story_v_side_new_1104701.awb")

						arg_416_1:RecordAudio("1104701102", var_419_9)
						arg_416_1:RecordAudio("1104701102", var_419_9)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701102", "story_v_side_new_1104701.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701102", "story_v_side_new_1104701.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_10 = math.max(var_419_1, arg_416_1.talkMaxDuration)

			if var_419_0 <= arg_416_1.time_ and arg_416_1.time_ < var_419_0 + var_419_10 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_0) / var_419_10

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_0 + var_419_10 and arg_416_1.time_ < var_419_0 + var_419_10 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play1104701103 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 1104701103
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play1104701104(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 0
			local var_423_1 = 1.2

			if var_423_0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_0 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, false)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_2 = arg_420_1:GetWordFromCfg(1104701103)
				local var_423_3 = arg_420_1:FormatText(var_423_2.content)

				arg_420_1.text_.text = var_423_3

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_4 = 48
				local var_423_5 = utf8.len(var_423_3)
				local var_423_6 = var_423_4 <= 0 and var_423_1 or var_423_1 * (var_423_5 / var_423_4)

				if var_423_6 > 0 and var_423_1 < var_423_6 then
					arg_420_1.talkMaxDuration = var_423_6

					if var_423_6 + var_423_0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_6 + var_423_0
					end
				end

				arg_420_1.text_.text = var_423_3
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_7 = math.max(var_423_1, arg_420_1.talkMaxDuration)

			if var_423_0 <= arg_420_1.time_ and arg_420_1.time_ < var_423_0 + var_423_7 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_0) / var_423_7

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_0 + var_423_7 and arg_420_1.time_ < var_423_0 + var_423_7 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play1104701104 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 1104701104
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play1104701105(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 0
			local var_427_1 = 1.075

			if var_427_0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_0 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, false)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_2 = arg_424_1:GetWordFromCfg(1104701104)
				local var_427_3 = arg_424_1:FormatText(var_427_2.content)

				arg_424_1.text_.text = var_427_3

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_4 = 43
				local var_427_5 = utf8.len(var_427_3)
				local var_427_6 = var_427_4 <= 0 and var_427_1 or var_427_1 * (var_427_5 / var_427_4)

				if var_427_6 > 0 and var_427_1 < var_427_6 then
					arg_424_1.talkMaxDuration = var_427_6

					if var_427_6 + var_427_0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_6 + var_427_0
					end
				end

				arg_424_1.text_.text = var_427_3
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_7 = math.max(var_427_1, arg_424_1.talkMaxDuration)

			if var_427_0 <= arg_424_1.time_ and arg_424_1.time_ < var_427_0 + var_427_7 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_0) / var_427_7

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_0 + var_427_7 and arg_424_1.time_ < var_427_0 + var_427_7 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play1104701105 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 1104701105
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play1104701106(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 0
			local var_431_1 = 0.175

			if var_431_0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_0 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_2 = arg_428_1:FormatText(StoryNameCfg[7].name)

				arg_428_1.leftNameTxt_.text = var_431_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_3 = arg_428_1:GetWordFromCfg(1104701105)
				local var_431_4 = arg_428_1:FormatText(var_431_3.content)

				arg_428_1.text_.text = var_431_4

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_5 = 7
				local var_431_6 = utf8.len(var_431_4)
				local var_431_7 = var_431_5 <= 0 and var_431_1 or var_431_1 * (var_431_6 / var_431_5)

				if var_431_7 > 0 and var_431_1 < var_431_7 then
					arg_428_1.talkMaxDuration = var_431_7

					if var_431_7 + var_431_0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_7 + var_431_0
					end
				end

				arg_428_1.text_.text = var_431_4
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_8 = math.max(var_431_1, arg_428_1.talkMaxDuration)

			if var_431_0 <= arg_428_1.time_ and arg_428_1.time_ < var_431_0 + var_431_8 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_0) / var_431_8

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_0 + var_431_8 and arg_428_1.time_ < var_431_0 + var_431_8 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play1104701106 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 1104701106
		arg_432_1.duration_ = 6.47

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play1104701107(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0
			local var_435_1 = 0.5

			if var_435_0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_2 = arg_432_1:FormatText(StoryNameCfg[1518].name)

				arg_432_1.leftNameTxt_.text = var_435_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, true)
				arg_432_1.iconController_:SetSelectedState("hero")

				arg_432_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_432_1.callingController_:SetSelectedState("normal")

				arg_432_1.keyicon_.color = Color.New(1, 1, 1)
				arg_432_1.icon_.color = Color.New(1, 1, 1)

				local var_435_3 = arg_432_1:GetWordFromCfg(1104701106)
				local var_435_4 = arg_432_1:FormatText(var_435_3.content)

				arg_432_1.text_.text = var_435_4

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_5 = 20
				local var_435_6 = utf8.len(var_435_4)
				local var_435_7 = var_435_5 <= 0 and var_435_1 or var_435_1 * (var_435_6 / var_435_5)

				if var_435_7 > 0 and var_435_1 < var_435_7 then
					arg_432_1.talkMaxDuration = var_435_7

					if var_435_7 + var_435_0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_7 + var_435_0
					end
				end

				arg_432_1.text_.text = var_435_4
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701106", "story_v_side_new_1104701.awb") ~= 0 then
					local var_435_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701106", "story_v_side_new_1104701.awb") / 1000

					if var_435_8 + var_435_0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_8 + var_435_0
					end

					if var_435_3.prefab_name ~= "" and arg_432_1.actors_[var_435_3.prefab_name] ~= nil then
						local var_435_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_3.prefab_name].transform, "story_v_side_new_1104701", "1104701106", "story_v_side_new_1104701.awb")

						arg_432_1:RecordAudio("1104701106", var_435_9)
						arg_432_1:RecordAudio("1104701106", var_435_9)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701106", "story_v_side_new_1104701.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701106", "story_v_side_new_1104701.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_10 = math.max(var_435_1, arg_432_1.talkMaxDuration)

			if var_435_0 <= arg_432_1.time_ and arg_432_1.time_ < var_435_0 + var_435_10 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_0) / var_435_10

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_0 + var_435_10 and arg_432_1.time_ < var_435_0 + var_435_10 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play1104701107 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 1104701107
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play1104701108(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = 0
			local var_439_1 = 1.025

			if var_439_0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_0 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, false)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_2 = arg_436_1:GetWordFromCfg(1104701107)
				local var_439_3 = arg_436_1:FormatText(var_439_2.content)

				arg_436_1.text_.text = var_439_3

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_4 = 41
				local var_439_5 = utf8.len(var_439_3)
				local var_439_6 = var_439_4 <= 0 and var_439_1 or var_439_1 * (var_439_5 / var_439_4)

				if var_439_6 > 0 and var_439_1 < var_439_6 then
					arg_436_1.talkMaxDuration = var_439_6

					if var_439_6 + var_439_0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_6 + var_439_0
					end
				end

				arg_436_1.text_.text = var_439_3
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_7 = math.max(var_439_1, arg_436_1.talkMaxDuration)

			if var_439_0 <= arg_436_1.time_ and arg_436_1.time_ < var_439_0 + var_439_7 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_0) / var_439_7

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_0 + var_439_7 and arg_436_1.time_ < var_439_0 + var_439_7 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play1104701108 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 1104701108
		arg_440_1.duration_ = 6.8

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play1104701109(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = arg_440_1.actors_["1047ui_story"].transform
			local var_443_1 = 0

			if var_443_1 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 then
				arg_440_1.var_.moveOldPos1047ui_story = var_443_0.localPosition
			end

			local var_443_2 = 0.001

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_2 then
				local var_443_3 = (arg_440_1.time_ - var_443_1) / var_443_2
				local var_443_4 = Vector3.New(0, -1.13, -6.2)

				var_443_0.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos1047ui_story, var_443_4, var_443_3)

				local var_443_5 = manager.ui.mainCamera.transform.position - var_443_0.position

				var_443_0.forward = Vector3.New(var_443_5.x, var_443_5.y, var_443_5.z)

				local var_443_6 = var_443_0.localEulerAngles

				var_443_6.z = 0
				var_443_6.x = 0
				var_443_0.localEulerAngles = var_443_6
			end

			if arg_440_1.time_ >= var_443_1 + var_443_2 and arg_440_1.time_ < var_443_1 + var_443_2 + arg_443_0 then
				var_443_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_443_7 = manager.ui.mainCamera.transform.position - var_443_0.position

				var_443_0.forward = Vector3.New(var_443_7.x, var_443_7.y, var_443_7.z)

				local var_443_8 = var_443_0.localEulerAngles

				var_443_8.z = 0
				var_443_8.x = 0
				var_443_0.localEulerAngles = var_443_8
			end

			local var_443_9 = arg_440_1.actors_["1047ui_story"]
			local var_443_10 = 0

			if var_443_10 < arg_440_1.time_ and arg_440_1.time_ <= var_443_10 + arg_443_0 and not isNil(var_443_9) and arg_440_1.var_.characterEffect1047ui_story == nil then
				arg_440_1.var_.characterEffect1047ui_story = var_443_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_11 = 0.200000002980232

			if var_443_10 <= arg_440_1.time_ and arg_440_1.time_ < var_443_10 + var_443_11 and not isNil(var_443_9) then
				local var_443_12 = (arg_440_1.time_ - var_443_10) / var_443_11

				if arg_440_1.var_.characterEffect1047ui_story and not isNil(var_443_9) then
					arg_440_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_440_1.time_ >= var_443_10 + var_443_11 and arg_440_1.time_ < var_443_10 + var_443_11 + arg_443_0 and not isNil(var_443_9) and arg_440_1.var_.characterEffect1047ui_story then
				arg_440_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_443_13 = 0

			if var_443_13 < arg_440_1.time_ and arg_440_1.time_ <= var_443_13 + arg_443_0 then
				arg_440_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_443_14 = 0

			if var_443_14 < arg_440_1.time_ and arg_440_1.time_ <= var_443_14 + arg_443_0 then
				arg_440_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_443_15 = 0
			local var_443_16 = 0.775

			if var_443_15 < arg_440_1.time_ and arg_440_1.time_ <= var_443_15 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_17 = arg_440_1:FormatText(StoryNameCfg[1296].name)

				arg_440_1.leftNameTxt_.text = var_443_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_18 = arg_440_1:GetWordFromCfg(1104701108)
				local var_443_19 = arg_440_1:FormatText(var_443_18.content)

				arg_440_1.text_.text = var_443_19

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_20 = 31
				local var_443_21 = utf8.len(var_443_19)
				local var_443_22 = var_443_20 <= 0 and var_443_16 or var_443_16 * (var_443_21 / var_443_20)

				if var_443_22 > 0 and var_443_16 < var_443_22 then
					arg_440_1.talkMaxDuration = var_443_22

					if var_443_22 + var_443_15 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_22 + var_443_15
					end
				end

				arg_440_1.text_.text = var_443_19
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701108", "story_v_side_new_1104701.awb") ~= 0 then
					local var_443_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701108", "story_v_side_new_1104701.awb") / 1000

					if var_443_23 + var_443_15 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_23 + var_443_15
					end

					if var_443_18.prefab_name ~= "" and arg_440_1.actors_[var_443_18.prefab_name] ~= nil then
						local var_443_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_18.prefab_name].transform, "story_v_side_new_1104701", "1104701108", "story_v_side_new_1104701.awb")

						arg_440_1:RecordAudio("1104701108", var_443_24)
						arg_440_1:RecordAudio("1104701108", var_443_24)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701108", "story_v_side_new_1104701.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701108", "story_v_side_new_1104701.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_25 = math.max(var_443_16, arg_440_1.talkMaxDuration)

			if var_443_15 <= arg_440_1.time_ and arg_440_1.time_ < var_443_15 + var_443_25 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_15) / var_443_25

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_15 + var_443_25 and arg_440_1.time_ < var_443_15 + var_443_25 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_440_1:InitPlayNodeList()
	end,
	Play1104701109 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 1104701109
		arg_444_1.duration_ = 2.83

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play1104701110(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = arg_444_1.actors_["1047ui_story"].transform
			local var_447_1 = 0

			if var_447_1 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 then
				arg_444_1.var_.moveOldPos1047ui_story = var_447_0.localPosition
			end

			local var_447_2 = 0.001

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_2 then
				local var_447_3 = (arg_444_1.time_ - var_447_1) / var_447_2
				local var_447_4 = Vector3.New(0, -1.13, -6.2)

				var_447_0.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos1047ui_story, var_447_4, var_447_3)

				local var_447_5 = manager.ui.mainCamera.transform.position - var_447_0.position

				var_447_0.forward = Vector3.New(var_447_5.x, var_447_5.y, var_447_5.z)

				local var_447_6 = var_447_0.localEulerAngles

				var_447_6.z = 0
				var_447_6.x = 0
				var_447_0.localEulerAngles = var_447_6
			end

			if arg_444_1.time_ >= var_447_1 + var_447_2 and arg_444_1.time_ < var_447_1 + var_447_2 + arg_447_0 then
				var_447_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_447_7 = manager.ui.mainCamera.transform.position - var_447_0.position

				var_447_0.forward = Vector3.New(var_447_7.x, var_447_7.y, var_447_7.z)

				local var_447_8 = var_447_0.localEulerAngles

				var_447_8.z = 0
				var_447_8.x = 0
				var_447_0.localEulerAngles = var_447_8
			end

			local var_447_9 = 0

			if var_447_9 < arg_444_1.time_ and arg_444_1.time_ <= var_447_9 + arg_447_0 then
				arg_444_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_1")
			end

			local var_447_10 = 0

			if var_447_10 < arg_444_1.time_ and arg_444_1.time_ <= var_447_10 + arg_447_0 then
				arg_444_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_447_11 = 0
			local var_447_12 = 0.225

			if var_447_11 < arg_444_1.time_ and arg_444_1.time_ <= var_447_11 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_13 = arg_444_1:FormatText(StoryNameCfg[1296].name)

				arg_444_1.leftNameTxt_.text = var_447_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_14 = arg_444_1:GetWordFromCfg(1104701109)
				local var_447_15 = arg_444_1:FormatText(var_447_14.content)

				arg_444_1.text_.text = var_447_15

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_16 = 9
				local var_447_17 = utf8.len(var_447_15)
				local var_447_18 = var_447_16 <= 0 and var_447_12 or var_447_12 * (var_447_17 / var_447_16)

				if var_447_18 > 0 and var_447_12 < var_447_18 then
					arg_444_1.talkMaxDuration = var_447_18

					if var_447_18 + var_447_11 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_18 + var_447_11
					end
				end

				arg_444_1.text_.text = var_447_15
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701109", "story_v_side_new_1104701.awb") ~= 0 then
					local var_447_19 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701109", "story_v_side_new_1104701.awb") / 1000

					if var_447_19 + var_447_11 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_19 + var_447_11
					end

					if var_447_14.prefab_name ~= "" and arg_444_1.actors_[var_447_14.prefab_name] ~= nil then
						local var_447_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_14.prefab_name].transform, "story_v_side_new_1104701", "1104701109", "story_v_side_new_1104701.awb")

						arg_444_1:RecordAudio("1104701109", var_447_20)
						arg_444_1:RecordAudio("1104701109", var_447_20)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701109", "story_v_side_new_1104701.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701109", "story_v_side_new_1104701.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_21 = math.max(var_447_12, arg_444_1.talkMaxDuration)

			if var_447_11 <= arg_444_1.time_ and arg_444_1.time_ < var_447_11 + var_447_21 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_11) / var_447_21

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_11 + var_447_21 and arg_444_1.time_ < var_447_11 + var_447_21 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_444_1:InitPlayNodeList()
	end,
	Play1104701110 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 1104701110
		arg_448_1.duration_ = 2.22

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play1104701111(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = arg_448_1.actors_["1047ui_story"]
			local var_451_1 = 0

			if var_451_1 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.characterEffect1047ui_story == nil then
				arg_448_1.var_.characterEffect1047ui_story = var_451_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_2 = 0.200000002980232

			if var_451_1 <= arg_448_1.time_ and arg_448_1.time_ < var_451_1 + var_451_2 and not isNil(var_451_0) then
				local var_451_3 = (arg_448_1.time_ - var_451_1) / var_451_2

				if arg_448_1.var_.characterEffect1047ui_story and not isNil(var_451_0) then
					local var_451_4 = Mathf.Lerp(0, 0.5, var_451_3)

					arg_448_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_448_1.var_.characterEffect1047ui_story.fillRatio = var_451_4
				end
			end

			if arg_448_1.time_ >= var_451_1 + var_451_2 and arg_448_1.time_ < var_451_1 + var_451_2 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.characterEffect1047ui_story then
				local var_451_5 = 0.5

				arg_448_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_448_1.var_.characterEffect1047ui_story.fillRatio = var_451_5
			end

			local var_451_6 = arg_448_1.actors_["1047ui_story"].transform
			local var_451_7 = 0

			if var_451_7 < arg_448_1.time_ and arg_448_1.time_ <= var_451_7 + arg_451_0 then
				arg_448_1.var_.moveOldPos1047ui_story = var_451_6.localPosition
			end

			local var_451_8 = 0.001

			if var_451_7 <= arg_448_1.time_ and arg_448_1.time_ < var_451_7 + var_451_8 then
				local var_451_9 = (arg_448_1.time_ - var_451_7) / var_451_8
				local var_451_10 = Vector3.New(0, 100, 0)

				var_451_6.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos1047ui_story, var_451_10, var_451_9)

				local var_451_11 = manager.ui.mainCamera.transform.position - var_451_6.position

				var_451_6.forward = Vector3.New(var_451_11.x, var_451_11.y, var_451_11.z)

				local var_451_12 = var_451_6.localEulerAngles

				var_451_12.z = 0
				var_451_12.x = 0
				var_451_6.localEulerAngles = var_451_12
			end

			if arg_448_1.time_ >= var_451_7 + var_451_8 and arg_448_1.time_ < var_451_7 + var_451_8 + arg_451_0 then
				var_451_6.localPosition = Vector3.New(0, 100, 0)

				local var_451_13 = manager.ui.mainCamera.transform.position - var_451_6.position

				var_451_6.forward = Vector3.New(var_451_13.x, var_451_13.y, var_451_13.z)

				local var_451_14 = var_451_6.localEulerAngles

				var_451_14.z = 0
				var_451_14.x = 0
				var_451_6.localEulerAngles = var_451_14
			end

			local var_451_15 = 0

			if var_451_15 < arg_448_1.time_ and arg_448_1.time_ <= var_451_15 + arg_451_0 then
				arg_448_1.mask_.enabled = true
				arg_448_1.mask_.raycastTarget = true

				arg_448_1:SetGaussion(false)
			end

			local var_451_16 = 0.125

			if var_451_15 <= arg_448_1.time_ and arg_448_1.time_ < var_451_15 + var_451_16 then
				local var_451_17 = (arg_448_1.time_ - var_451_15) / var_451_16
				local var_451_18 = Color.New(1, 1, 1)

				var_451_18.a = Mathf.Lerp(0, 1, var_451_17)
				arg_448_1.mask_.color = var_451_18
			end

			if arg_448_1.time_ >= var_451_15 + var_451_16 and arg_448_1.time_ < var_451_15 + var_451_16 + arg_451_0 then
				local var_451_19 = Color.New(1, 1, 1)

				var_451_19.a = 1
				arg_448_1.mask_.color = var_451_19
			end

			local var_451_20 = 0.125

			if var_451_20 < arg_448_1.time_ and arg_448_1.time_ <= var_451_20 + arg_451_0 then
				arg_448_1.mask_.enabled = true
				arg_448_1.mask_.raycastTarget = true

				arg_448_1:SetGaussion(false)
			end

			local var_451_21 = 0.0750000029802322

			if var_451_20 <= arg_448_1.time_ and arg_448_1.time_ < var_451_20 + var_451_21 then
				local var_451_22 = (arg_448_1.time_ - var_451_20) / var_451_21
				local var_451_23 = Color.New(1, 1, 1)

				var_451_23.a = Mathf.Lerp(1, 0, var_451_22)
				arg_448_1.mask_.color = var_451_23
			end

			if arg_448_1.time_ >= var_451_20 + var_451_21 and arg_448_1.time_ < var_451_20 + var_451_21 + arg_451_0 then
				local var_451_24 = Color.New(1, 1, 1)
				local var_451_25 = 0

				arg_448_1.mask_.enabled = false
				var_451_24.a = var_451_25
				arg_448_1.mask_.color = var_451_24
			end

			local var_451_26 = 0.291666666666667

			if var_451_26 < arg_448_1.time_ and arg_448_1.time_ <= var_451_26 + arg_451_0 then
				arg_448_1.mask_.enabled = true
				arg_448_1.mask_.raycastTarget = true

				arg_448_1:SetGaussion(false)
			end

			local var_451_27 = 0.0750000000000001

			if var_451_26 <= arg_448_1.time_ and arg_448_1.time_ < var_451_26 + var_451_27 then
				local var_451_28 = (arg_448_1.time_ - var_451_26) / var_451_27
				local var_451_29 = Color.New(1, 1, 1)

				var_451_29.a = Mathf.Lerp(1, 0, var_451_28)
				arg_448_1.mask_.color = var_451_29
			end

			if arg_448_1.time_ >= var_451_26 + var_451_27 and arg_448_1.time_ < var_451_26 + var_451_27 + arg_451_0 then
				local var_451_30 = Color.New(1, 1, 1)
				local var_451_31 = 0

				arg_448_1.mask_.enabled = false
				var_451_30.a = var_451_31
				arg_448_1.mask_.color = var_451_30
			end

			local var_451_32 = 0

			if var_451_32 < arg_448_1.time_ and arg_448_1.time_ <= var_451_32 + arg_451_0 then
				arg_448_1.allBtn_.enabled = false
			end

			local var_451_33 = 0.366666666666667

			if arg_448_1.time_ >= var_451_32 + var_451_33 and arg_448_1.time_ < var_451_32 + var_451_33 + arg_451_0 then
				arg_448_1.allBtn_.enabled = true
			end

			if arg_448_1.frameCnt_ <= 1 then
				arg_448_1.dialog_:SetActive(false)
			end

			local var_451_34 = 0.316666666666667
			local var_451_35 = 0.125

			if var_451_34 < arg_448_1.time_ and arg_448_1.time_ <= var_451_34 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0

				arg_448_1.dialog_:SetActive(true)

				arg_448_1.dialogCg_.alpha = 0

				local var_451_36 = LeanTween.value(arg_448_1.dialog_, 0, 1, 0.3)

				var_451_36:setOnUpdate(LuaHelper.FloatAction(function(arg_452_0)
					arg_448_1.dialogCg_.alpha = arg_452_0
				end))
				var_451_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_448_1.dialog_)
					var_451_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_448_1.duration_ = arg_448_1.duration_ + 0.3

				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_37 = arg_448_1:FormatText(StoryNameCfg[1516].name)

				arg_448_1.leftNameTxt_.text = var_451_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, true)
				arg_448_1.iconController_:SetSelectedState("hero")

				arg_448_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_448_1.callingController_:SetSelectedState("normal")

				arg_448_1.keyicon_.color = Color.New(1, 1, 1)
				arg_448_1.icon_.color = Color.New(1, 1, 1)

				local var_451_38 = arg_448_1:GetWordFromCfg(1104701110)
				local var_451_39 = arg_448_1:FormatText(var_451_38.content)

				arg_448_1.text_.text = var_451_39

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_40 = 5
				local var_451_41 = utf8.len(var_451_39)
				local var_451_42 = var_451_40 <= 0 and var_451_35 or var_451_35 * (var_451_41 / var_451_40)

				if var_451_42 > 0 and var_451_35 < var_451_42 then
					arg_448_1.talkMaxDuration = var_451_42
					var_451_34 = var_451_34 + 0.3

					if var_451_42 + var_451_34 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_42 + var_451_34
					end
				end

				arg_448_1.text_.text = var_451_39
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701110", "story_v_side_new_1104701.awb") ~= 0 then
					local var_451_43 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701110", "story_v_side_new_1104701.awb") / 1000

					if var_451_43 + var_451_34 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_43 + var_451_34
					end

					if var_451_38.prefab_name ~= "" and arg_448_1.actors_[var_451_38.prefab_name] ~= nil then
						local var_451_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_38.prefab_name].transform, "story_v_side_new_1104701", "1104701110", "story_v_side_new_1104701.awb")

						arg_448_1:RecordAudio("1104701110", var_451_44)
						arg_448_1:RecordAudio("1104701110", var_451_44)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701110", "story_v_side_new_1104701.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701110", "story_v_side_new_1104701.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_45 = var_451_34 + 0.3
			local var_451_46 = math.max(var_451_35, arg_448_1.talkMaxDuration)

			if var_451_45 <= arg_448_1.time_ and arg_448_1.time_ < var_451_45 + var_451_46 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_45) / var_451_46

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_45 + var_451_46 and arg_448_1.time_ < var_451_45 + var_451_46 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_448_1:InitPlayNodeList()
	end,
	Play1104701111 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 1104701111
		arg_454_1.duration_ = 4.73

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play1104701112(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 0
			local var_457_1 = 0.675

			if var_457_0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_0 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_2 = arg_454_1:FormatText(StoryNameCfg[1516].name)

				arg_454_1.leftNameTxt_.text = var_457_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_3 = arg_454_1:GetWordFromCfg(1104701111)
				local var_457_4 = arg_454_1:FormatText(var_457_3.content)

				arg_454_1.text_.text = var_457_4

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_5 = 27
				local var_457_6 = utf8.len(var_457_4)
				local var_457_7 = var_457_5 <= 0 and var_457_1 or var_457_1 * (var_457_6 / var_457_5)

				if var_457_7 > 0 and var_457_1 < var_457_7 then
					arg_454_1.talkMaxDuration = var_457_7

					if var_457_7 + var_457_0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_7 + var_457_0
					end
				end

				arg_454_1.text_.text = var_457_4
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701111", "story_v_side_new_1104701.awb") ~= 0 then
					local var_457_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701111", "story_v_side_new_1104701.awb") / 1000

					if var_457_8 + var_457_0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_8 + var_457_0
					end

					if var_457_3.prefab_name ~= "" and arg_454_1.actors_[var_457_3.prefab_name] ~= nil then
						local var_457_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_3.prefab_name].transform, "story_v_side_new_1104701", "1104701111", "story_v_side_new_1104701.awb")

						arg_454_1:RecordAudio("1104701111", var_457_9)
						arg_454_1:RecordAudio("1104701111", var_457_9)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701111", "story_v_side_new_1104701.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701111", "story_v_side_new_1104701.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_10 = math.max(var_457_1, arg_454_1.talkMaxDuration)

			if var_457_0 <= arg_454_1.time_ and arg_454_1.time_ < var_457_0 + var_457_10 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_0) / var_457_10

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_0 + var_457_10 and arg_454_1.time_ < var_457_0 + var_457_10 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play1104701112 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 1104701112
		arg_458_1.duration_ = 2.67

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play1104701113(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = arg_458_1.actors_["1047ui_story"].transform
			local var_461_1 = 0

			if var_461_1 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 then
				arg_458_1.var_.moveOldPos1047ui_story = var_461_0.localPosition
			end

			local var_461_2 = 0.001

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_2 then
				local var_461_3 = (arg_458_1.time_ - var_461_1) / var_461_2
				local var_461_4 = Vector3.New(0, -1.13, -6.2)

				var_461_0.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos1047ui_story, var_461_4, var_461_3)

				local var_461_5 = manager.ui.mainCamera.transform.position - var_461_0.position

				var_461_0.forward = Vector3.New(var_461_5.x, var_461_5.y, var_461_5.z)

				local var_461_6 = var_461_0.localEulerAngles

				var_461_6.z = 0
				var_461_6.x = 0
				var_461_0.localEulerAngles = var_461_6
			end

			if arg_458_1.time_ >= var_461_1 + var_461_2 and arg_458_1.time_ < var_461_1 + var_461_2 + arg_461_0 then
				var_461_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_461_7 = manager.ui.mainCamera.transform.position - var_461_0.position

				var_461_0.forward = Vector3.New(var_461_7.x, var_461_7.y, var_461_7.z)

				local var_461_8 = var_461_0.localEulerAngles

				var_461_8.z = 0
				var_461_8.x = 0
				var_461_0.localEulerAngles = var_461_8
			end

			local var_461_9 = arg_458_1.actors_["1047ui_story"]
			local var_461_10 = 0

			if var_461_10 < arg_458_1.time_ and arg_458_1.time_ <= var_461_10 + arg_461_0 and not isNil(var_461_9) and arg_458_1.var_.characterEffect1047ui_story == nil then
				arg_458_1.var_.characterEffect1047ui_story = var_461_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_11 = 0.200000002980232

			if var_461_10 <= arg_458_1.time_ and arg_458_1.time_ < var_461_10 + var_461_11 and not isNil(var_461_9) then
				local var_461_12 = (arg_458_1.time_ - var_461_10) / var_461_11

				if arg_458_1.var_.characterEffect1047ui_story and not isNil(var_461_9) then
					arg_458_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_458_1.time_ >= var_461_10 + var_461_11 and arg_458_1.time_ < var_461_10 + var_461_11 + arg_461_0 and not isNil(var_461_9) and arg_458_1.var_.characterEffect1047ui_story then
				arg_458_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_461_13 = 0

			if var_461_13 < arg_458_1.time_ and arg_458_1.time_ <= var_461_13 + arg_461_0 then
				arg_458_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_461_14 = 0

			if var_461_14 < arg_458_1.time_ and arg_458_1.time_ <= var_461_14 + arg_461_0 then
				arg_458_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_461_15 = 0
			local var_461_16 = 0.175

			if var_461_15 < arg_458_1.time_ and arg_458_1.time_ <= var_461_15 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				local var_461_17 = arg_458_1:FormatText(StoryNameCfg[1296].name)

				arg_458_1.leftNameTxt_.text = var_461_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_18 = arg_458_1:GetWordFromCfg(1104701112)
				local var_461_19 = arg_458_1:FormatText(var_461_18.content)

				arg_458_1.text_.text = var_461_19

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_20 = 7
				local var_461_21 = utf8.len(var_461_19)
				local var_461_22 = var_461_20 <= 0 and var_461_16 or var_461_16 * (var_461_21 / var_461_20)

				if var_461_22 > 0 and var_461_16 < var_461_22 then
					arg_458_1.talkMaxDuration = var_461_22

					if var_461_22 + var_461_15 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_22 + var_461_15
					end
				end

				arg_458_1.text_.text = var_461_19
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701112", "story_v_side_new_1104701.awb") ~= 0 then
					local var_461_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701112", "story_v_side_new_1104701.awb") / 1000

					if var_461_23 + var_461_15 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_23 + var_461_15
					end

					if var_461_18.prefab_name ~= "" and arg_458_1.actors_[var_461_18.prefab_name] ~= nil then
						local var_461_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_18.prefab_name].transform, "story_v_side_new_1104701", "1104701112", "story_v_side_new_1104701.awb")

						arg_458_1:RecordAudio("1104701112", var_461_24)
						arg_458_1:RecordAudio("1104701112", var_461_24)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701112", "story_v_side_new_1104701.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701112", "story_v_side_new_1104701.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_25 = math.max(var_461_16, arg_458_1.talkMaxDuration)

			if var_461_15 <= arg_458_1.time_ and arg_458_1.time_ < var_461_15 + var_461_25 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_15) / var_461_25

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_15 + var_461_25 and arg_458_1.time_ < var_461_15 + var_461_25 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_458_1:InitPlayNodeList()
	end,
	Play1104701113 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 1104701113
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play1104701114(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = arg_462_1.actors_["1047ui_story"]
			local var_465_1 = 0

			if var_465_1 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.characterEffect1047ui_story == nil then
				arg_462_1.var_.characterEffect1047ui_story = var_465_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_2 = 0.200000002980232

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_2 and not isNil(var_465_0) then
				local var_465_3 = (arg_462_1.time_ - var_465_1) / var_465_2

				if arg_462_1.var_.characterEffect1047ui_story and not isNil(var_465_0) then
					local var_465_4 = Mathf.Lerp(0, 0.5, var_465_3)

					arg_462_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_462_1.var_.characterEffect1047ui_story.fillRatio = var_465_4
				end
			end

			if arg_462_1.time_ >= var_465_1 + var_465_2 and arg_462_1.time_ < var_465_1 + var_465_2 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.characterEffect1047ui_story then
				local var_465_5 = 0.5

				arg_462_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_462_1.var_.characterEffect1047ui_story.fillRatio = var_465_5
			end

			local var_465_6 = arg_462_1.actors_["1047ui_story"].transform
			local var_465_7 = 0

			if var_465_7 < arg_462_1.time_ and arg_462_1.time_ <= var_465_7 + arg_465_0 then
				arg_462_1.var_.moveOldPos1047ui_story = var_465_6.localPosition
			end

			local var_465_8 = 0.001

			if var_465_7 <= arg_462_1.time_ and arg_462_1.time_ < var_465_7 + var_465_8 then
				local var_465_9 = (arg_462_1.time_ - var_465_7) / var_465_8
				local var_465_10 = Vector3.New(0, 100, 0)

				var_465_6.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos1047ui_story, var_465_10, var_465_9)

				local var_465_11 = manager.ui.mainCamera.transform.position - var_465_6.position

				var_465_6.forward = Vector3.New(var_465_11.x, var_465_11.y, var_465_11.z)

				local var_465_12 = var_465_6.localEulerAngles

				var_465_12.z = 0
				var_465_12.x = 0
				var_465_6.localEulerAngles = var_465_12
			end

			if arg_462_1.time_ >= var_465_7 + var_465_8 and arg_462_1.time_ < var_465_7 + var_465_8 + arg_465_0 then
				var_465_6.localPosition = Vector3.New(0, 100, 0)

				local var_465_13 = manager.ui.mainCamera.transform.position - var_465_6.position

				var_465_6.forward = Vector3.New(var_465_13.x, var_465_13.y, var_465_13.z)

				local var_465_14 = var_465_6.localEulerAngles

				var_465_14.z = 0
				var_465_14.x = 0
				var_465_6.localEulerAngles = var_465_14
			end

			local var_465_15 = 0.1
			local var_465_16 = 1

			if var_465_15 < arg_462_1.time_ and arg_462_1.time_ <= var_465_15 + arg_465_0 then
				local var_465_17 = "play"
				local var_465_18 = "effect"

				arg_462_1:AudioAction(var_465_17, var_465_18, "se_story_1310", "se_story_1310_clap", "")
			end

			local var_465_19 = 0
			local var_465_20 = 0.925

			if var_465_19 < arg_462_1.time_ and arg_462_1.time_ <= var_465_19 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, false)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_21 = arg_462_1:GetWordFromCfg(1104701113)
				local var_465_22 = arg_462_1:FormatText(var_465_21.content)

				arg_462_1.text_.text = var_465_22

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_23 = 37
				local var_465_24 = utf8.len(var_465_22)
				local var_465_25 = var_465_23 <= 0 and var_465_20 or var_465_20 * (var_465_24 / var_465_23)

				if var_465_25 > 0 and var_465_20 < var_465_25 then
					arg_462_1.talkMaxDuration = var_465_25

					if var_465_25 + var_465_19 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_25 + var_465_19
					end
				end

				arg_462_1.text_.text = var_465_22
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_26 = math.max(var_465_20, arg_462_1.talkMaxDuration)

			if var_465_19 <= arg_462_1.time_ and arg_462_1.time_ < var_465_19 + var_465_26 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_19) / var_465_26

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_19 + var_465_26 and arg_462_1.time_ < var_465_19 + var_465_26 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_462_1:InitPlayNodeList()
	end,
	Play1104701114 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 1104701114
		arg_466_1.duration_ = 5.63

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play1104701115(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = 0
			local var_469_1 = 0.575

			if var_469_0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_0 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_2 = arg_466_1:FormatText(StoryNameCfg[1516].name)

				arg_466_1.leftNameTxt_.text = var_469_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, true)
				arg_466_1.iconController_:SetSelectedState("hero")

				arg_466_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_466_1.callingController_:SetSelectedState("normal")

				arg_466_1.keyicon_.color = Color.New(1, 1, 1)
				arg_466_1.icon_.color = Color.New(1, 1, 1)

				local var_469_3 = arg_466_1:GetWordFromCfg(1104701114)
				local var_469_4 = arg_466_1:FormatText(var_469_3.content)

				arg_466_1.text_.text = var_469_4

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_5 = 23
				local var_469_6 = utf8.len(var_469_4)
				local var_469_7 = var_469_5 <= 0 and var_469_1 or var_469_1 * (var_469_6 / var_469_5)

				if var_469_7 > 0 and var_469_1 < var_469_7 then
					arg_466_1.talkMaxDuration = var_469_7

					if var_469_7 + var_469_0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_7 + var_469_0
					end
				end

				arg_466_1.text_.text = var_469_4
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701114", "story_v_side_new_1104701.awb") ~= 0 then
					local var_469_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701114", "story_v_side_new_1104701.awb") / 1000

					if var_469_8 + var_469_0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_8 + var_469_0
					end

					if var_469_3.prefab_name ~= "" and arg_466_1.actors_[var_469_3.prefab_name] ~= nil then
						local var_469_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_3.prefab_name].transform, "story_v_side_new_1104701", "1104701114", "story_v_side_new_1104701.awb")

						arg_466_1:RecordAudio("1104701114", var_469_9)
						arg_466_1:RecordAudio("1104701114", var_469_9)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701114", "story_v_side_new_1104701.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701114", "story_v_side_new_1104701.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_10 = math.max(var_469_1, arg_466_1.talkMaxDuration)

			if var_469_0 <= arg_466_1.time_ and arg_466_1.time_ < var_469_0 + var_469_10 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_0) / var_469_10

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_0 + var_469_10 and arg_466_1.time_ < var_469_0 + var_469_10 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play1104701115 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 1104701115
		arg_470_1.duration_ = 14.43

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play1104701116(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = arg_470_1.actors_["1047ui_story"].transform
			local var_473_1 = 0

			if var_473_1 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 then
				arg_470_1.var_.moveOldPos1047ui_story = var_473_0.localPosition
			end

			local var_473_2 = 0.001

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_2 then
				local var_473_3 = (arg_470_1.time_ - var_473_1) / var_473_2
				local var_473_4 = Vector3.New(0, -1.13, -6.2)

				var_473_0.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos1047ui_story, var_473_4, var_473_3)

				local var_473_5 = manager.ui.mainCamera.transform.position - var_473_0.position

				var_473_0.forward = Vector3.New(var_473_5.x, var_473_5.y, var_473_5.z)

				local var_473_6 = var_473_0.localEulerAngles

				var_473_6.z = 0
				var_473_6.x = 0
				var_473_0.localEulerAngles = var_473_6
			end

			if arg_470_1.time_ >= var_473_1 + var_473_2 and arg_470_1.time_ < var_473_1 + var_473_2 + arg_473_0 then
				var_473_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_473_7 = manager.ui.mainCamera.transform.position - var_473_0.position

				var_473_0.forward = Vector3.New(var_473_7.x, var_473_7.y, var_473_7.z)

				local var_473_8 = var_473_0.localEulerAngles

				var_473_8.z = 0
				var_473_8.x = 0
				var_473_0.localEulerAngles = var_473_8
			end

			local var_473_9 = arg_470_1.actors_["1047ui_story"]
			local var_473_10 = 0

			if var_473_10 < arg_470_1.time_ and arg_470_1.time_ <= var_473_10 + arg_473_0 and not isNil(var_473_9) and arg_470_1.var_.characterEffect1047ui_story == nil then
				arg_470_1.var_.characterEffect1047ui_story = var_473_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_11 = 0.200000002980232

			if var_473_10 <= arg_470_1.time_ and arg_470_1.time_ < var_473_10 + var_473_11 and not isNil(var_473_9) then
				local var_473_12 = (arg_470_1.time_ - var_473_10) / var_473_11

				if arg_470_1.var_.characterEffect1047ui_story and not isNil(var_473_9) then
					arg_470_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_470_1.time_ >= var_473_10 + var_473_11 and arg_470_1.time_ < var_473_10 + var_473_11 + arg_473_0 and not isNil(var_473_9) and arg_470_1.var_.characterEffect1047ui_story then
				arg_470_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_473_13 = 0

			if var_473_13 < arg_470_1.time_ and arg_470_1.time_ <= var_473_13 + arg_473_0 then
				arg_470_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_473_14 = 0

			if var_473_14 < arg_470_1.time_ and arg_470_1.time_ <= var_473_14 + arg_473_0 then
				arg_470_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_473_15 = 0
			local var_473_16 = 1.65

			if var_473_15 < arg_470_1.time_ and arg_470_1.time_ <= var_473_15 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				local var_473_17 = arg_470_1:FormatText(StoryNameCfg[1296].name)

				arg_470_1.leftNameTxt_.text = var_473_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_18 = arg_470_1:GetWordFromCfg(1104701115)
				local var_473_19 = arg_470_1:FormatText(var_473_18.content)

				arg_470_1.text_.text = var_473_19

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_20 = 66
				local var_473_21 = utf8.len(var_473_19)
				local var_473_22 = var_473_20 <= 0 and var_473_16 or var_473_16 * (var_473_21 / var_473_20)

				if var_473_22 > 0 and var_473_16 < var_473_22 then
					arg_470_1.talkMaxDuration = var_473_22

					if var_473_22 + var_473_15 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_22 + var_473_15
					end
				end

				arg_470_1.text_.text = var_473_19
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701115", "story_v_side_new_1104701.awb") ~= 0 then
					local var_473_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701115", "story_v_side_new_1104701.awb") / 1000

					if var_473_23 + var_473_15 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_23 + var_473_15
					end

					if var_473_18.prefab_name ~= "" and arg_470_1.actors_[var_473_18.prefab_name] ~= nil then
						local var_473_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_18.prefab_name].transform, "story_v_side_new_1104701", "1104701115", "story_v_side_new_1104701.awb")

						arg_470_1:RecordAudio("1104701115", var_473_24)
						arg_470_1:RecordAudio("1104701115", var_473_24)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701115", "story_v_side_new_1104701.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701115", "story_v_side_new_1104701.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_25 = math.max(var_473_16, arg_470_1.talkMaxDuration)

			if var_473_15 <= arg_470_1.time_ and arg_470_1.time_ < var_473_15 + var_473_25 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_15) / var_473_25

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_15 + var_473_25 and arg_470_1.time_ < var_473_15 + var_473_25 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_470_1:InitPlayNodeList()
	end,
	Play1104701116 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 1104701116
		arg_474_1.duration_ = 6.27

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play1104701117(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = arg_474_1.actors_["1047ui_story"].transform
			local var_477_1 = 0

			if var_477_1 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 then
				arg_474_1.var_.moveOldPos1047ui_story = var_477_0.localPosition
			end

			local var_477_2 = 0.001

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_2 then
				local var_477_3 = (arg_474_1.time_ - var_477_1) / var_477_2
				local var_477_4 = Vector3.New(0, -1.13, -6.2)

				var_477_0.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos1047ui_story, var_477_4, var_477_3)

				local var_477_5 = manager.ui.mainCamera.transform.position - var_477_0.position

				var_477_0.forward = Vector3.New(var_477_5.x, var_477_5.y, var_477_5.z)

				local var_477_6 = var_477_0.localEulerAngles

				var_477_6.z = 0
				var_477_6.x = 0
				var_477_0.localEulerAngles = var_477_6
			end

			if arg_474_1.time_ >= var_477_1 + var_477_2 and arg_474_1.time_ < var_477_1 + var_477_2 + arg_477_0 then
				var_477_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_477_7 = manager.ui.mainCamera.transform.position - var_477_0.position

				var_477_0.forward = Vector3.New(var_477_7.x, var_477_7.y, var_477_7.z)

				local var_477_8 = var_477_0.localEulerAngles

				var_477_8.z = 0
				var_477_8.x = 0
				var_477_0.localEulerAngles = var_477_8
			end

			local var_477_9 = 0

			if var_477_9 < arg_474_1.time_ and arg_474_1.time_ <= var_477_9 + arg_477_0 then
				arg_474_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_477_10 = 0

			if var_477_10 < arg_474_1.time_ and arg_474_1.time_ <= var_477_10 + arg_477_0 then
				arg_474_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_477_11 = 0
			local var_477_12 = 0.875

			if var_477_11 < arg_474_1.time_ and arg_474_1.time_ <= var_477_11 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				local var_477_13 = arg_474_1:FormatText(StoryNameCfg[1296].name)

				arg_474_1.leftNameTxt_.text = var_477_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_14 = arg_474_1:GetWordFromCfg(1104701116)
				local var_477_15 = arg_474_1:FormatText(var_477_14.content)

				arg_474_1.text_.text = var_477_15

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_16 = 35
				local var_477_17 = utf8.len(var_477_15)
				local var_477_18 = var_477_16 <= 0 and var_477_12 or var_477_12 * (var_477_17 / var_477_16)

				if var_477_18 > 0 and var_477_12 < var_477_18 then
					arg_474_1.talkMaxDuration = var_477_18

					if var_477_18 + var_477_11 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_18 + var_477_11
					end
				end

				arg_474_1.text_.text = var_477_15
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701116", "story_v_side_new_1104701.awb") ~= 0 then
					local var_477_19 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701116", "story_v_side_new_1104701.awb") / 1000

					if var_477_19 + var_477_11 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_19 + var_477_11
					end

					if var_477_14.prefab_name ~= "" and arg_474_1.actors_[var_477_14.prefab_name] ~= nil then
						local var_477_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_14.prefab_name].transform, "story_v_side_new_1104701", "1104701116", "story_v_side_new_1104701.awb")

						arg_474_1:RecordAudio("1104701116", var_477_20)
						arg_474_1:RecordAudio("1104701116", var_477_20)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701116", "story_v_side_new_1104701.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701116", "story_v_side_new_1104701.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_21 = math.max(var_477_12, arg_474_1.talkMaxDuration)

			if var_477_11 <= arg_474_1.time_ and arg_474_1.time_ < var_477_11 + var_477_21 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_11) / var_477_21

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_11 + var_477_21 and arg_474_1.time_ < var_477_11 + var_477_21 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_474_1:InitPlayNodeList()
	end,
	Play1104701117 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 1104701117
		arg_478_1.duration_ = 5.37

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play1104701118(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = arg_478_1.actors_["1047ui_story"]
			local var_481_1 = 0

			if var_481_1 < arg_478_1.time_ and arg_478_1.time_ <= var_481_1 + arg_481_0 and not isNil(var_481_0) and arg_478_1.var_.characterEffect1047ui_story == nil then
				arg_478_1.var_.characterEffect1047ui_story = var_481_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_2 = 0.200000002980232

			if var_481_1 <= arg_478_1.time_ and arg_478_1.time_ < var_481_1 + var_481_2 and not isNil(var_481_0) then
				local var_481_3 = (arg_478_1.time_ - var_481_1) / var_481_2

				if arg_478_1.var_.characterEffect1047ui_story and not isNil(var_481_0) then
					local var_481_4 = Mathf.Lerp(0, 0.5, var_481_3)

					arg_478_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_478_1.var_.characterEffect1047ui_story.fillRatio = var_481_4
				end
			end

			if arg_478_1.time_ >= var_481_1 + var_481_2 and arg_478_1.time_ < var_481_1 + var_481_2 + arg_481_0 and not isNil(var_481_0) and arg_478_1.var_.characterEffect1047ui_story then
				local var_481_5 = 0.5

				arg_478_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_478_1.var_.characterEffect1047ui_story.fillRatio = var_481_5
			end

			local var_481_6 = arg_478_1.actors_["1047ui_story"].transform
			local var_481_7 = 0

			if var_481_7 < arg_478_1.time_ and arg_478_1.time_ <= var_481_7 + arg_481_0 then
				arg_478_1.var_.moveOldPos1047ui_story = var_481_6.localPosition
			end

			local var_481_8 = 0.001

			if var_481_7 <= arg_478_1.time_ and arg_478_1.time_ < var_481_7 + var_481_8 then
				local var_481_9 = (arg_478_1.time_ - var_481_7) / var_481_8
				local var_481_10 = Vector3.New(0, 100, 0)

				var_481_6.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPos1047ui_story, var_481_10, var_481_9)

				local var_481_11 = manager.ui.mainCamera.transform.position - var_481_6.position

				var_481_6.forward = Vector3.New(var_481_11.x, var_481_11.y, var_481_11.z)

				local var_481_12 = var_481_6.localEulerAngles

				var_481_12.z = 0
				var_481_12.x = 0
				var_481_6.localEulerAngles = var_481_12
			end

			if arg_478_1.time_ >= var_481_7 + var_481_8 and arg_478_1.time_ < var_481_7 + var_481_8 + arg_481_0 then
				var_481_6.localPosition = Vector3.New(0, 100, 0)

				local var_481_13 = manager.ui.mainCamera.transform.position - var_481_6.position

				var_481_6.forward = Vector3.New(var_481_13.x, var_481_13.y, var_481_13.z)

				local var_481_14 = var_481_6.localEulerAngles

				var_481_14.z = 0
				var_481_14.x = 0
				var_481_6.localEulerAngles = var_481_14
			end

			local var_481_15 = 0
			local var_481_16 = 0.575

			if var_481_15 < arg_478_1.time_ and arg_478_1.time_ <= var_481_15 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				local var_481_17 = arg_478_1:FormatText(StoryNameCfg[1518].name)

				arg_478_1.leftNameTxt_.text = var_481_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, true)
				arg_478_1.iconController_:SetSelectedState("hero")

				arg_478_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_478_1.callingController_:SetSelectedState("normal")

				arg_478_1.keyicon_.color = Color.New(1, 1, 1)
				arg_478_1.icon_.color = Color.New(1, 1, 1)

				local var_481_18 = arg_478_1:GetWordFromCfg(1104701117)
				local var_481_19 = arg_478_1:FormatText(var_481_18.content)

				arg_478_1.text_.text = var_481_19

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_20 = 23
				local var_481_21 = utf8.len(var_481_19)
				local var_481_22 = var_481_20 <= 0 and var_481_16 or var_481_16 * (var_481_21 / var_481_20)

				if var_481_22 > 0 and var_481_16 < var_481_22 then
					arg_478_1.talkMaxDuration = var_481_22

					if var_481_22 + var_481_15 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_22 + var_481_15
					end
				end

				arg_478_1.text_.text = var_481_19
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701117", "story_v_side_new_1104701.awb") ~= 0 then
					local var_481_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701117", "story_v_side_new_1104701.awb") / 1000

					if var_481_23 + var_481_15 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_23 + var_481_15
					end

					if var_481_18.prefab_name ~= "" and arg_478_1.actors_[var_481_18.prefab_name] ~= nil then
						local var_481_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_18.prefab_name].transform, "story_v_side_new_1104701", "1104701117", "story_v_side_new_1104701.awb")

						arg_478_1:RecordAudio("1104701117", var_481_24)
						arg_478_1:RecordAudio("1104701117", var_481_24)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701117", "story_v_side_new_1104701.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701117", "story_v_side_new_1104701.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_25 = math.max(var_481_16, arg_478_1.talkMaxDuration)

			if var_481_15 <= arg_478_1.time_ and arg_478_1.time_ < var_481_15 + var_481_25 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_15) / var_481_25

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_15 + var_481_25 and arg_478_1.time_ < var_481_15 + var_481_25 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_478_1:InitPlayNodeList()
	end,
	Play1104701118 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 1104701118
		arg_482_1.duration_ = 5.7

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play1104701119(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0
			local var_485_1 = 0.625

			if var_485_0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_2 = arg_482_1:FormatText(StoryNameCfg[1516].name)

				arg_482_1.leftNameTxt_.text = var_485_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, true)
				arg_482_1.iconController_:SetSelectedState("hero")

				arg_482_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_482_1.callingController_:SetSelectedState("normal")

				arg_482_1.keyicon_.color = Color.New(1, 1, 1)
				arg_482_1.icon_.color = Color.New(1, 1, 1)

				local var_485_3 = arg_482_1:GetWordFromCfg(1104701118)
				local var_485_4 = arg_482_1:FormatText(var_485_3.content)

				arg_482_1.text_.text = var_485_4

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_5 = 25
				local var_485_6 = utf8.len(var_485_4)
				local var_485_7 = var_485_5 <= 0 and var_485_1 or var_485_1 * (var_485_6 / var_485_5)

				if var_485_7 > 0 and var_485_1 < var_485_7 then
					arg_482_1.talkMaxDuration = var_485_7

					if var_485_7 + var_485_0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_7 + var_485_0
					end
				end

				arg_482_1.text_.text = var_485_4
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701118", "story_v_side_new_1104701.awb") ~= 0 then
					local var_485_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701118", "story_v_side_new_1104701.awb") / 1000

					if var_485_8 + var_485_0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_8 + var_485_0
					end

					if var_485_3.prefab_name ~= "" and arg_482_1.actors_[var_485_3.prefab_name] ~= nil then
						local var_485_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_3.prefab_name].transform, "story_v_side_new_1104701", "1104701118", "story_v_side_new_1104701.awb")

						arg_482_1:RecordAudio("1104701118", var_485_9)
						arg_482_1:RecordAudio("1104701118", var_485_9)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701118", "story_v_side_new_1104701.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701118", "story_v_side_new_1104701.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_10 = math.max(var_485_1, arg_482_1.talkMaxDuration)

			if var_485_0 <= arg_482_1.time_ and arg_482_1.time_ < var_485_0 + var_485_10 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_0) / var_485_10

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_0 + var_485_10 and arg_482_1.time_ < var_485_0 + var_485_10 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play1104701119 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 1104701119
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play1104701120(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = 0
			local var_489_1 = 1.45

			if var_489_0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_0 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, false)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_2 = arg_486_1:GetWordFromCfg(1104701119)
				local var_489_3 = arg_486_1:FormatText(var_489_2.content)

				arg_486_1.text_.text = var_489_3

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_4 = 58
				local var_489_5 = utf8.len(var_489_3)
				local var_489_6 = var_489_4 <= 0 and var_489_1 or var_489_1 * (var_489_5 / var_489_4)

				if var_489_6 > 0 and var_489_1 < var_489_6 then
					arg_486_1.talkMaxDuration = var_489_6

					if var_489_6 + var_489_0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_6 + var_489_0
					end
				end

				arg_486_1.text_.text = var_489_3
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_7 = math.max(var_489_1, arg_486_1.talkMaxDuration)

			if var_489_0 <= arg_486_1.time_ and arg_486_1.time_ < var_489_0 + var_489_7 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_0) / var_489_7

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_0 + var_489_7 and arg_486_1.time_ < var_489_0 + var_489_7 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play1104701120 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 1104701120
		arg_490_1.duration_ = 8.97

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play1104701121(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = arg_490_1.actors_["1047ui_story"].transform
			local var_493_1 = 0

			if var_493_1 < arg_490_1.time_ and arg_490_1.time_ <= var_493_1 + arg_493_0 then
				arg_490_1.var_.moveOldPos1047ui_story = var_493_0.localPosition
			end

			local var_493_2 = 0.001

			if var_493_1 <= arg_490_1.time_ and arg_490_1.time_ < var_493_1 + var_493_2 then
				local var_493_3 = (arg_490_1.time_ - var_493_1) / var_493_2
				local var_493_4 = Vector3.New(0, -1.13, -6.2)

				var_493_0.localPosition = Vector3.Lerp(arg_490_1.var_.moveOldPos1047ui_story, var_493_4, var_493_3)

				local var_493_5 = manager.ui.mainCamera.transform.position - var_493_0.position

				var_493_0.forward = Vector3.New(var_493_5.x, var_493_5.y, var_493_5.z)

				local var_493_6 = var_493_0.localEulerAngles

				var_493_6.z = 0
				var_493_6.x = 0
				var_493_0.localEulerAngles = var_493_6
			end

			if arg_490_1.time_ >= var_493_1 + var_493_2 and arg_490_1.time_ < var_493_1 + var_493_2 + arg_493_0 then
				var_493_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_493_7 = manager.ui.mainCamera.transform.position - var_493_0.position

				var_493_0.forward = Vector3.New(var_493_7.x, var_493_7.y, var_493_7.z)

				local var_493_8 = var_493_0.localEulerAngles

				var_493_8.z = 0
				var_493_8.x = 0
				var_493_0.localEulerAngles = var_493_8
			end

			local var_493_9 = arg_490_1.actors_["1047ui_story"]
			local var_493_10 = 0

			if var_493_10 < arg_490_1.time_ and arg_490_1.time_ <= var_493_10 + arg_493_0 and not isNil(var_493_9) and arg_490_1.var_.characterEffect1047ui_story == nil then
				arg_490_1.var_.characterEffect1047ui_story = var_493_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_11 = 0.200000002980232

			if var_493_10 <= arg_490_1.time_ and arg_490_1.time_ < var_493_10 + var_493_11 and not isNil(var_493_9) then
				local var_493_12 = (arg_490_1.time_ - var_493_10) / var_493_11

				if arg_490_1.var_.characterEffect1047ui_story and not isNil(var_493_9) then
					arg_490_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_490_1.time_ >= var_493_10 + var_493_11 and arg_490_1.time_ < var_493_10 + var_493_11 + arg_493_0 and not isNil(var_493_9) and arg_490_1.var_.characterEffect1047ui_story then
				arg_490_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_493_13 = 0

			if var_493_13 < arg_490_1.time_ and arg_490_1.time_ <= var_493_13 + arg_493_0 then
				arg_490_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			local var_493_14 = 0

			if var_493_14 < arg_490_1.time_ and arg_490_1.time_ <= var_493_14 + arg_493_0 then
				arg_490_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_493_15 = 0
			local var_493_16 = 0.975

			if var_493_15 < arg_490_1.time_ and arg_490_1.time_ <= var_493_15 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				local var_493_17 = arg_490_1:FormatText(StoryNameCfg[1296].name)

				arg_490_1.leftNameTxt_.text = var_493_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_18 = arg_490_1:GetWordFromCfg(1104701120)
				local var_493_19 = arg_490_1:FormatText(var_493_18.content)

				arg_490_1.text_.text = var_493_19

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_20 = 39
				local var_493_21 = utf8.len(var_493_19)
				local var_493_22 = var_493_20 <= 0 and var_493_16 or var_493_16 * (var_493_21 / var_493_20)

				if var_493_22 > 0 and var_493_16 < var_493_22 then
					arg_490_1.talkMaxDuration = var_493_22

					if var_493_22 + var_493_15 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_22 + var_493_15
					end
				end

				arg_490_1.text_.text = var_493_19
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701120", "story_v_side_new_1104701.awb") ~= 0 then
					local var_493_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701120", "story_v_side_new_1104701.awb") / 1000

					if var_493_23 + var_493_15 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_23 + var_493_15
					end

					if var_493_18.prefab_name ~= "" and arg_490_1.actors_[var_493_18.prefab_name] ~= nil then
						local var_493_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_18.prefab_name].transform, "story_v_side_new_1104701", "1104701120", "story_v_side_new_1104701.awb")

						arg_490_1:RecordAudio("1104701120", var_493_24)
						arg_490_1:RecordAudio("1104701120", var_493_24)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701120", "story_v_side_new_1104701.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701120", "story_v_side_new_1104701.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_25 = math.max(var_493_16, arg_490_1.talkMaxDuration)

			if var_493_15 <= arg_490_1.time_ and arg_490_1.time_ < var_493_15 + var_493_25 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_15) / var_493_25

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_15 + var_493_25 and arg_490_1.time_ < var_493_15 + var_493_25 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_490_1:InitPlayNodeList()
	end,
	Play1104701121 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 1104701121
		arg_494_1.duration_ = 5

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play1104701122(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = arg_494_1.actors_["1047ui_story"]
			local var_497_1 = 0

			if var_497_1 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 and not isNil(var_497_0) and arg_494_1.var_.characterEffect1047ui_story == nil then
				arg_494_1.var_.characterEffect1047ui_story = var_497_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_2 = 0.200000002980232

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_2 and not isNil(var_497_0) then
				local var_497_3 = (arg_494_1.time_ - var_497_1) / var_497_2

				if arg_494_1.var_.characterEffect1047ui_story and not isNil(var_497_0) then
					local var_497_4 = Mathf.Lerp(0, 0.5, var_497_3)

					arg_494_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_494_1.var_.characterEffect1047ui_story.fillRatio = var_497_4
				end
			end

			if arg_494_1.time_ >= var_497_1 + var_497_2 and arg_494_1.time_ < var_497_1 + var_497_2 + arg_497_0 and not isNil(var_497_0) and arg_494_1.var_.characterEffect1047ui_story then
				local var_497_5 = 0.5

				arg_494_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_494_1.var_.characterEffect1047ui_story.fillRatio = var_497_5
			end

			local var_497_6 = 0
			local var_497_7 = 0.4

			if var_497_6 < arg_494_1.time_ and arg_494_1.time_ <= var_497_6 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				local var_497_8 = arg_494_1:FormatText(StoryNameCfg[7].name)

				arg_494_1.leftNameTxt_.text = var_497_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, true)
				arg_494_1.iconController_:SetSelectedState("hero")

				arg_494_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_494_1.callingController_:SetSelectedState("normal")

				arg_494_1.keyicon_.color = Color.New(1, 1, 1)
				arg_494_1.icon_.color = Color.New(1, 1, 1)

				local var_497_9 = arg_494_1:GetWordFromCfg(1104701121)
				local var_497_10 = arg_494_1:FormatText(var_497_9.content)

				arg_494_1.text_.text = var_497_10

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_11 = 16
				local var_497_12 = utf8.len(var_497_10)
				local var_497_13 = var_497_11 <= 0 and var_497_7 or var_497_7 * (var_497_12 / var_497_11)

				if var_497_13 > 0 and var_497_7 < var_497_13 then
					arg_494_1.talkMaxDuration = var_497_13

					if var_497_13 + var_497_6 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_13 + var_497_6
					end
				end

				arg_494_1.text_.text = var_497_10
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_14 = math.max(var_497_7, arg_494_1.talkMaxDuration)

			if var_497_6 <= arg_494_1.time_ and arg_494_1.time_ < var_497_6 + var_497_14 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_6) / var_497_14

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_6 + var_497_14 and arg_494_1.time_ < var_497_6 + var_497_14 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play1104701122 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 1104701122
		arg_498_1.duration_ = 10.4

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play1104701123(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = arg_498_1.actors_["1047ui_story"].transform
			local var_501_1 = 0

			if var_501_1 < arg_498_1.time_ and arg_498_1.time_ <= var_501_1 + arg_501_0 then
				arg_498_1.var_.moveOldPos1047ui_story = var_501_0.localPosition
			end

			local var_501_2 = 0.001

			if var_501_1 <= arg_498_1.time_ and arg_498_1.time_ < var_501_1 + var_501_2 then
				local var_501_3 = (arg_498_1.time_ - var_501_1) / var_501_2
				local var_501_4 = Vector3.New(0, -1.13, -6.2)

				var_501_0.localPosition = Vector3.Lerp(arg_498_1.var_.moveOldPos1047ui_story, var_501_4, var_501_3)

				local var_501_5 = manager.ui.mainCamera.transform.position - var_501_0.position

				var_501_0.forward = Vector3.New(var_501_5.x, var_501_5.y, var_501_5.z)

				local var_501_6 = var_501_0.localEulerAngles

				var_501_6.z = 0
				var_501_6.x = 0
				var_501_0.localEulerAngles = var_501_6
			end

			if arg_498_1.time_ >= var_501_1 + var_501_2 and arg_498_1.time_ < var_501_1 + var_501_2 + arg_501_0 then
				var_501_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_501_7 = manager.ui.mainCamera.transform.position - var_501_0.position

				var_501_0.forward = Vector3.New(var_501_7.x, var_501_7.y, var_501_7.z)

				local var_501_8 = var_501_0.localEulerAngles

				var_501_8.z = 0
				var_501_8.x = 0
				var_501_0.localEulerAngles = var_501_8
			end

			local var_501_9 = arg_498_1.actors_["1047ui_story"]
			local var_501_10 = 0

			if var_501_10 < arg_498_1.time_ and arg_498_1.time_ <= var_501_10 + arg_501_0 and not isNil(var_501_9) and arg_498_1.var_.characterEffect1047ui_story == nil then
				arg_498_1.var_.characterEffect1047ui_story = var_501_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_11 = 0.200000002980232

			if var_501_10 <= arg_498_1.time_ and arg_498_1.time_ < var_501_10 + var_501_11 and not isNil(var_501_9) then
				local var_501_12 = (arg_498_1.time_ - var_501_10) / var_501_11

				if arg_498_1.var_.characterEffect1047ui_story and not isNil(var_501_9) then
					arg_498_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_498_1.time_ >= var_501_10 + var_501_11 and arg_498_1.time_ < var_501_10 + var_501_11 + arg_501_0 and not isNil(var_501_9) and arg_498_1.var_.characterEffect1047ui_story then
				arg_498_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_501_13 = 0

			if var_501_13 < arg_498_1.time_ and arg_498_1.time_ <= var_501_13 + arg_501_0 then
				arg_498_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			local var_501_14 = 0

			if var_501_14 < arg_498_1.time_ and arg_498_1.time_ <= var_501_14 + arg_501_0 then
				arg_498_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_501_15 = 0
			local var_501_16 = 1.05

			if var_501_15 < arg_498_1.time_ and arg_498_1.time_ <= var_501_15 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				local var_501_17 = arg_498_1:FormatText(StoryNameCfg[1296].name)

				arg_498_1.leftNameTxt_.text = var_501_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_18 = arg_498_1:GetWordFromCfg(1104701122)
				local var_501_19 = arg_498_1:FormatText(var_501_18.content)

				arg_498_1.text_.text = var_501_19

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_20 = 42
				local var_501_21 = utf8.len(var_501_19)
				local var_501_22 = var_501_20 <= 0 and var_501_16 or var_501_16 * (var_501_21 / var_501_20)

				if var_501_22 > 0 and var_501_16 < var_501_22 then
					arg_498_1.talkMaxDuration = var_501_22

					if var_501_22 + var_501_15 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_22 + var_501_15
					end
				end

				arg_498_1.text_.text = var_501_19
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701122", "story_v_side_new_1104701.awb") ~= 0 then
					local var_501_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701122", "story_v_side_new_1104701.awb") / 1000

					if var_501_23 + var_501_15 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_23 + var_501_15
					end

					if var_501_18.prefab_name ~= "" and arg_498_1.actors_[var_501_18.prefab_name] ~= nil then
						local var_501_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_18.prefab_name].transform, "story_v_side_new_1104701", "1104701122", "story_v_side_new_1104701.awb")

						arg_498_1:RecordAudio("1104701122", var_501_24)
						arg_498_1:RecordAudio("1104701122", var_501_24)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701122", "story_v_side_new_1104701.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701122", "story_v_side_new_1104701.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_25 = math.max(var_501_16, arg_498_1.talkMaxDuration)

			if var_501_15 <= arg_498_1.time_ and arg_498_1.time_ < var_501_15 + var_501_25 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_15) / var_501_25

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_15 + var_501_25 and arg_498_1.time_ < var_501_15 + var_501_25 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_498_1:InitPlayNodeList()
	end,
	Play1104701123 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 1104701123
		arg_502_1.duration_ = 5

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play1104701124(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = arg_502_1.actors_["1047ui_story"]
			local var_505_1 = 0

			if var_505_1 < arg_502_1.time_ and arg_502_1.time_ <= var_505_1 + arg_505_0 and not isNil(var_505_0) and arg_502_1.var_.characterEffect1047ui_story == nil then
				arg_502_1.var_.characterEffect1047ui_story = var_505_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_2 = 0.200000002980232

			if var_505_1 <= arg_502_1.time_ and arg_502_1.time_ < var_505_1 + var_505_2 and not isNil(var_505_0) then
				local var_505_3 = (arg_502_1.time_ - var_505_1) / var_505_2

				if arg_502_1.var_.characterEffect1047ui_story and not isNil(var_505_0) then
					local var_505_4 = Mathf.Lerp(0, 0.5, var_505_3)

					arg_502_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_502_1.var_.characterEffect1047ui_story.fillRatio = var_505_4
				end
			end

			if arg_502_1.time_ >= var_505_1 + var_505_2 and arg_502_1.time_ < var_505_1 + var_505_2 + arg_505_0 and not isNil(var_505_0) and arg_502_1.var_.characterEffect1047ui_story then
				local var_505_5 = 0.5

				arg_502_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_502_1.var_.characterEffect1047ui_story.fillRatio = var_505_5
			end

			local var_505_6 = 0
			local var_505_7 = 0.575

			if var_505_6 < arg_502_1.time_ and arg_502_1.time_ <= var_505_6 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				local var_505_8 = arg_502_1:FormatText(StoryNameCfg[7].name)

				arg_502_1.leftNameTxt_.text = var_505_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, true)
				arg_502_1.iconController_:SetSelectedState("hero")

				arg_502_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_502_1.callingController_:SetSelectedState("normal")

				arg_502_1.keyicon_.color = Color.New(1, 1, 1)
				arg_502_1.icon_.color = Color.New(1, 1, 1)

				local var_505_9 = arg_502_1:GetWordFromCfg(1104701123)
				local var_505_10 = arg_502_1:FormatText(var_505_9.content)

				arg_502_1.text_.text = var_505_10

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_11 = 23
				local var_505_12 = utf8.len(var_505_10)
				local var_505_13 = var_505_11 <= 0 and var_505_7 or var_505_7 * (var_505_12 / var_505_11)

				if var_505_13 > 0 and var_505_7 < var_505_13 then
					arg_502_1.talkMaxDuration = var_505_13

					if var_505_13 + var_505_6 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_13 + var_505_6
					end
				end

				arg_502_1.text_.text = var_505_10
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)
				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_14 = math.max(var_505_7, arg_502_1.talkMaxDuration)

			if var_505_6 <= arg_502_1.time_ and arg_502_1.time_ < var_505_6 + var_505_14 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_6) / var_505_14

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_6 + var_505_14 and arg_502_1.time_ < var_505_6 + var_505_14 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play1104701124 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 1104701124
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play1104701125(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = 0
			local var_509_1 = 0.95

			if var_509_0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_0 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				local var_509_2 = arg_506_1:FormatText(StoryNameCfg[7].name)

				arg_506_1.leftNameTxt_.text = var_509_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, true)
				arg_506_1.iconController_:SetSelectedState("hero")

				arg_506_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_506_1.callingController_:SetSelectedState("normal")

				arg_506_1.keyicon_.color = Color.New(1, 1, 1)
				arg_506_1.icon_.color = Color.New(1, 1, 1)

				local var_509_3 = arg_506_1:GetWordFromCfg(1104701124)
				local var_509_4 = arg_506_1:FormatText(var_509_3.content)

				arg_506_1.text_.text = var_509_4

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_5 = 38
				local var_509_6 = utf8.len(var_509_4)
				local var_509_7 = var_509_5 <= 0 and var_509_1 or var_509_1 * (var_509_6 / var_509_5)

				if var_509_7 > 0 and var_509_1 < var_509_7 then
					arg_506_1.talkMaxDuration = var_509_7

					if var_509_7 + var_509_0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_7 + var_509_0
					end
				end

				arg_506_1.text_.text = var_509_4
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_8 = math.max(var_509_1, arg_506_1.talkMaxDuration)

			if var_509_0 <= arg_506_1.time_ and arg_506_1.time_ < var_509_0 + var_509_8 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_0) / var_509_8

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_0 + var_509_8 and arg_506_1.time_ < var_509_0 + var_509_8 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play1104701125 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 1104701125
		arg_510_1.duration_ = 4.83

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play1104701126(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = arg_510_1.actors_["1047ui_story"].transform
			local var_513_1 = 0

			if var_513_1 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 then
				arg_510_1.var_.moveOldPos1047ui_story = var_513_0.localPosition
			end

			local var_513_2 = 0.001

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_2 then
				local var_513_3 = (arg_510_1.time_ - var_513_1) / var_513_2
				local var_513_4 = Vector3.New(0, -1.13, -6.2)

				var_513_0.localPosition = Vector3.Lerp(arg_510_1.var_.moveOldPos1047ui_story, var_513_4, var_513_3)

				local var_513_5 = manager.ui.mainCamera.transform.position - var_513_0.position

				var_513_0.forward = Vector3.New(var_513_5.x, var_513_5.y, var_513_5.z)

				local var_513_6 = var_513_0.localEulerAngles

				var_513_6.z = 0
				var_513_6.x = 0
				var_513_0.localEulerAngles = var_513_6
			end

			if arg_510_1.time_ >= var_513_1 + var_513_2 and arg_510_1.time_ < var_513_1 + var_513_2 + arg_513_0 then
				var_513_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_513_7 = manager.ui.mainCamera.transform.position - var_513_0.position

				var_513_0.forward = Vector3.New(var_513_7.x, var_513_7.y, var_513_7.z)

				local var_513_8 = var_513_0.localEulerAngles

				var_513_8.z = 0
				var_513_8.x = 0
				var_513_0.localEulerAngles = var_513_8
			end

			local var_513_9 = arg_510_1.actors_["1047ui_story"]
			local var_513_10 = 0

			if var_513_10 < arg_510_1.time_ and arg_510_1.time_ <= var_513_10 + arg_513_0 and not isNil(var_513_9) and arg_510_1.var_.characterEffect1047ui_story == nil then
				arg_510_1.var_.characterEffect1047ui_story = var_513_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_11 = 0.200000002980232

			if var_513_10 <= arg_510_1.time_ and arg_510_1.time_ < var_513_10 + var_513_11 and not isNil(var_513_9) then
				local var_513_12 = (arg_510_1.time_ - var_513_10) / var_513_11

				if arg_510_1.var_.characterEffect1047ui_story and not isNil(var_513_9) then
					arg_510_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_510_1.time_ >= var_513_10 + var_513_11 and arg_510_1.time_ < var_513_10 + var_513_11 + arg_513_0 and not isNil(var_513_9) and arg_510_1.var_.characterEffect1047ui_story then
				arg_510_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_513_13 = 0

			if var_513_13 < arg_510_1.time_ and arg_510_1.time_ <= var_513_13 + arg_513_0 then
				arg_510_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action5_1")
			end

			local var_513_14 = 0

			if var_513_14 < arg_510_1.time_ and arg_510_1.time_ <= var_513_14 + arg_513_0 then
				arg_510_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_513_15 = 0
			local var_513_16 = 0.425

			if var_513_15 < arg_510_1.time_ and arg_510_1.time_ <= var_513_15 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				local var_513_17 = arg_510_1:FormatText(StoryNameCfg[1296].name)

				arg_510_1.leftNameTxt_.text = var_513_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_18 = arg_510_1:GetWordFromCfg(1104701125)
				local var_513_19 = arg_510_1:FormatText(var_513_18.content)

				arg_510_1.text_.text = var_513_19

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_20 = 17
				local var_513_21 = utf8.len(var_513_19)
				local var_513_22 = var_513_20 <= 0 and var_513_16 or var_513_16 * (var_513_21 / var_513_20)

				if var_513_22 > 0 and var_513_16 < var_513_22 then
					arg_510_1.talkMaxDuration = var_513_22

					if var_513_22 + var_513_15 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_22 + var_513_15
					end
				end

				arg_510_1.text_.text = var_513_19
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701125", "story_v_side_new_1104701.awb") ~= 0 then
					local var_513_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701125", "story_v_side_new_1104701.awb") / 1000

					if var_513_23 + var_513_15 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_23 + var_513_15
					end

					if var_513_18.prefab_name ~= "" and arg_510_1.actors_[var_513_18.prefab_name] ~= nil then
						local var_513_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_510_1.actors_[var_513_18.prefab_name].transform, "story_v_side_new_1104701", "1104701125", "story_v_side_new_1104701.awb")

						arg_510_1:RecordAudio("1104701125", var_513_24)
						arg_510_1:RecordAudio("1104701125", var_513_24)
					else
						arg_510_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701125", "story_v_side_new_1104701.awb")
					end

					arg_510_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701125", "story_v_side_new_1104701.awb")
				end

				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_25 = math.max(var_513_16, arg_510_1.talkMaxDuration)

			if var_513_15 <= arg_510_1.time_ and arg_510_1.time_ < var_513_15 + var_513_25 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_15) / var_513_25

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_15 + var_513_25 and arg_510_1.time_ < var_513_15 + var_513_25 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_510_1:InitPlayNodeList()
	end,
	Play1104701126 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 1104701126
		arg_514_1.duration_ = 5

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play1104701127(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = arg_514_1.actors_["1047ui_story"]
			local var_517_1 = 0

			if var_517_1 < arg_514_1.time_ and arg_514_1.time_ <= var_517_1 + arg_517_0 and not isNil(var_517_0) and arg_514_1.var_.characterEffect1047ui_story == nil then
				arg_514_1.var_.characterEffect1047ui_story = var_517_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_2 = 0.200000002980232

			if var_517_1 <= arg_514_1.time_ and arg_514_1.time_ < var_517_1 + var_517_2 and not isNil(var_517_0) then
				local var_517_3 = (arg_514_1.time_ - var_517_1) / var_517_2

				if arg_514_1.var_.characterEffect1047ui_story and not isNil(var_517_0) then
					local var_517_4 = Mathf.Lerp(0, 0.5, var_517_3)

					arg_514_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_514_1.var_.characterEffect1047ui_story.fillRatio = var_517_4
				end
			end

			if arg_514_1.time_ >= var_517_1 + var_517_2 and arg_514_1.time_ < var_517_1 + var_517_2 + arg_517_0 and not isNil(var_517_0) and arg_514_1.var_.characterEffect1047ui_story then
				local var_517_5 = 0.5

				arg_514_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_514_1.var_.characterEffect1047ui_story.fillRatio = var_517_5
			end

			local var_517_6 = 0

			if var_517_6 < arg_514_1.time_ and arg_514_1.time_ <= var_517_6 + arg_517_0 then
				arg_514_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action5_2")
			end

			local var_517_7 = 0
			local var_517_8 = 0.25

			if var_517_7 < arg_514_1.time_ and arg_514_1.time_ <= var_517_7 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				local var_517_9 = arg_514_1:FormatText(StoryNameCfg[7].name)

				arg_514_1.leftNameTxt_.text = var_517_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, true)
				arg_514_1.iconController_:SetSelectedState("hero")

				arg_514_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_514_1.callingController_:SetSelectedState("normal")

				arg_514_1.keyicon_.color = Color.New(1, 1, 1)
				arg_514_1.icon_.color = Color.New(1, 1, 1)

				local var_517_10 = arg_514_1:GetWordFromCfg(1104701126)
				local var_517_11 = arg_514_1:FormatText(var_517_10.content)

				arg_514_1.text_.text = var_517_11

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_12 = 10
				local var_517_13 = utf8.len(var_517_11)
				local var_517_14 = var_517_12 <= 0 and var_517_8 or var_517_8 * (var_517_13 / var_517_12)

				if var_517_14 > 0 and var_517_8 < var_517_14 then
					arg_514_1.talkMaxDuration = var_517_14

					if var_517_14 + var_517_7 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_14 + var_517_7
					end
				end

				arg_514_1.text_.text = var_517_11
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)
				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_15 = math.max(var_517_8, arg_514_1.talkMaxDuration)

			if var_517_7 <= arg_514_1.time_ and arg_514_1.time_ < var_517_7 + var_517_15 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_7) / var_517_15

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_7 + var_517_15 and arg_514_1.time_ < var_517_7 + var_517_15 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play1104701127 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 1104701127
		arg_518_1.duration_ = 2.77

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play1104701128(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = arg_518_1.actors_["1047ui_story"].transform
			local var_521_1 = 0

			if var_521_1 < arg_518_1.time_ and arg_518_1.time_ <= var_521_1 + arg_521_0 then
				arg_518_1.var_.moveOldPos1047ui_story = var_521_0.localPosition
			end

			local var_521_2 = 0.001

			if var_521_1 <= arg_518_1.time_ and arg_518_1.time_ < var_521_1 + var_521_2 then
				local var_521_3 = (arg_518_1.time_ - var_521_1) / var_521_2
				local var_521_4 = Vector3.New(0, -1.13, -6.2)

				var_521_0.localPosition = Vector3.Lerp(arg_518_1.var_.moveOldPos1047ui_story, var_521_4, var_521_3)

				local var_521_5 = manager.ui.mainCamera.transform.position - var_521_0.position

				var_521_0.forward = Vector3.New(var_521_5.x, var_521_5.y, var_521_5.z)

				local var_521_6 = var_521_0.localEulerAngles

				var_521_6.z = 0
				var_521_6.x = 0
				var_521_0.localEulerAngles = var_521_6
			end

			if arg_518_1.time_ >= var_521_1 + var_521_2 and arg_518_1.time_ < var_521_1 + var_521_2 + arg_521_0 then
				var_521_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_521_7 = manager.ui.mainCamera.transform.position - var_521_0.position

				var_521_0.forward = Vector3.New(var_521_7.x, var_521_7.y, var_521_7.z)

				local var_521_8 = var_521_0.localEulerAngles

				var_521_8.z = 0
				var_521_8.x = 0
				var_521_0.localEulerAngles = var_521_8
			end

			local var_521_9 = arg_518_1.actors_["1047ui_story"]
			local var_521_10 = 0

			if var_521_10 < arg_518_1.time_ and arg_518_1.time_ <= var_521_10 + arg_521_0 and not isNil(var_521_9) and arg_518_1.var_.characterEffect1047ui_story == nil then
				arg_518_1.var_.characterEffect1047ui_story = var_521_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_11 = 0.200000002980232

			if var_521_10 <= arg_518_1.time_ and arg_518_1.time_ < var_521_10 + var_521_11 and not isNil(var_521_9) then
				local var_521_12 = (arg_518_1.time_ - var_521_10) / var_521_11

				if arg_518_1.var_.characterEffect1047ui_story and not isNil(var_521_9) then
					arg_518_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_518_1.time_ >= var_521_10 + var_521_11 and arg_518_1.time_ < var_521_10 + var_521_11 + arg_521_0 and not isNil(var_521_9) and arg_518_1.var_.characterEffect1047ui_story then
				arg_518_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_521_13 = 0

			if var_521_13 < arg_518_1.time_ and arg_518_1.time_ <= var_521_13 + arg_521_0 then
				arg_518_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_521_14 = 0

			if var_521_14 < arg_518_1.time_ and arg_518_1.time_ <= var_521_14 + arg_521_0 then
				arg_518_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_521_15 = 0
			local var_521_16 = 0.275

			if var_521_15 < arg_518_1.time_ and arg_518_1.time_ <= var_521_15 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				local var_521_17 = arg_518_1:FormatText(StoryNameCfg[1296].name)

				arg_518_1.leftNameTxt_.text = var_521_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_18 = arg_518_1:GetWordFromCfg(1104701127)
				local var_521_19 = arg_518_1:FormatText(var_521_18.content)

				arg_518_1.text_.text = var_521_19

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_20 = 11
				local var_521_21 = utf8.len(var_521_19)
				local var_521_22 = var_521_20 <= 0 and var_521_16 or var_521_16 * (var_521_21 / var_521_20)

				if var_521_22 > 0 and var_521_16 < var_521_22 then
					arg_518_1.talkMaxDuration = var_521_22

					if var_521_22 + var_521_15 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_22 + var_521_15
					end
				end

				arg_518_1.text_.text = var_521_19
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701127", "story_v_side_new_1104701.awb") ~= 0 then
					local var_521_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701127", "story_v_side_new_1104701.awb") / 1000

					if var_521_23 + var_521_15 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_23 + var_521_15
					end

					if var_521_18.prefab_name ~= "" and arg_518_1.actors_[var_521_18.prefab_name] ~= nil then
						local var_521_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_18.prefab_name].transform, "story_v_side_new_1104701", "1104701127", "story_v_side_new_1104701.awb")

						arg_518_1:RecordAudio("1104701127", var_521_24)
						arg_518_1:RecordAudio("1104701127", var_521_24)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701127", "story_v_side_new_1104701.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701127", "story_v_side_new_1104701.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_25 = math.max(var_521_16, arg_518_1.talkMaxDuration)

			if var_521_15 <= arg_518_1.time_ and arg_518_1.time_ < var_521_15 + var_521_25 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_15) / var_521_25

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_15 + var_521_25 and arg_518_1.time_ < var_521_15 + var_521_25 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_518_1:InitPlayNodeList()
	end,
	Play1104701128 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 1104701128
		arg_522_1.duration_ = 5

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play1104701129(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = arg_522_1.actors_["1047ui_story"]
			local var_525_1 = 0

			if var_525_1 < arg_522_1.time_ and arg_522_1.time_ <= var_525_1 + arg_525_0 and not isNil(var_525_0) and arg_522_1.var_.characterEffect1047ui_story == nil then
				arg_522_1.var_.characterEffect1047ui_story = var_525_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_2 = 0.200000002980232

			if var_525_1 <= arg_522_1.time_ and arg_522_1.time_ < var_525_1 + var_525_2 and not isNil(var_525_0) then
				local var_525_3 = (arg_522_1.time_ - var_525_1) / var_525_2

				if arg_522_1.var_.characterEffect1047ui_story and not isNil(var_525_0) then
					local var_525_4 = Mathf.Lerp(0, 0.5, var_525_3)

					arg_522_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_522_1.var_.characterEffect1047ui_story.fillRatio = var_525_4
				end
			end

			if arg_522_1.time_ >= var_525_1 + var_525_2 and arg_522_1.time_ < var_525_1 + var_525_2 + arg_525_0 and not isNil(var_525_0) and arg_522_1.var_.characterEffect1047ui_story then
				local var_525_5 = 0.5

				arg_522_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_522_1.var_.characterEffect1047ui_story.fillRatio = var_525_5
			end

			local var_525_6 = 0
			local var_525_7 = 0.95

			if var_525_6 < arg_522_1.time_ and arg_522_1.time_ <= var_525_6 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				local var_525_8 = arg_522_1:FormatText(StoryNameCfg[7].name)

				arg_522_1.leftNameTxt_.text = var_525_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, true)
				arg_522_1.iconController_:SetSelectedState("hero")

				arg_522_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_522_1.callingController_:SetSelectedState("normal")

				arg_522_1.keyicon_.color = Color.New(1, 1, 1)
				arg_522_1.icon_.color = Color.New(1, 1, 1)

				local var_525_9 = arg_522_1:GetWordFromCfg(1104701128)
				local var_525_10 = arg_522_1:FormatText(var_525_9.content)

				arg_522_1.text_.text = var_525_10

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_11 = 38
				local var_525_12 = utf8.len(var_525_10)
				local var_525_13 = var_525_11 <= 0 and var_525_7 or var_525_7 * (var_525_12 / var_525_11)

				if var_525_13 > 0 and var_525_7 < var_525_13 then
					arg_522_1.talkMaxDuration = var_525_13

					if var_525_13 + var_525_6 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_13 + var_525_6
					end
				end

				arg_522_1.text_.text = var_525_10
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)
				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_14 = math.max(var_525_7, arg_522_1.talkMaxDuration)

			if var_525_6 <= arg_522_1.time_ and arg_522_1.time_ < var_525_6 + var_525_14 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_6) / var_525_14

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_6 + var_525_14 and arg_522_1.time_ < var_525_6 + var_525_14 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play1104701129 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 1104701129
		arg_526_1.duration_ = 6.2

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play1104701130(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = arg_526_1.actors_["1047ui_story"].transform
			local var_529_1 = 0

			if var_529_1 < arg_526_1.time_ and arg_526_1.time_ <= var_529_1 + arg_529_0 then
				arg_526_1.var_.moveOldPos1047ui_story = var_529_0.localPosition
			end

			local var_529_2 = 0.001

			if var_529_1 <= arg_526_1.time_ and arg_526_1.time_ < var_529_1 + var_529_2 then
				local var_529_3 = (arg_526_1.time_ - var_529_1) / var_529_2
				local var_529_4 = Vector3.New(0, -1.13, -6.2)

				var_529_0.localPosition = Vector3.Lerp(arg_526_1.var_.moveOldPos1047ui_story, var_529_4, var_529_3)

				local var_529_5 = manager.ui.mainCamera.transform.position - var_529_0.position

				var_529_0.forward = Vector3.New(var_529_5.x, var_529_5.y, var_529_5.z)

				local var_529_6 = var_529_0.localEulerAngles

				var_529_6.z = 0
				var_529_6.x = 0
				var_529_0.localEulerAngles = var_529_6
			end

			if arg_526_1.time_ >= var_529_1 + var_529_2 and arg_526_1.time_ < var_529_1 + var_529_2 + arg_529_0 then
				var_529_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_529_7 = manager.ui.mainCamera.transform.position - var_529_0.position

				var_529_0.forward = Vector3.New(var_529_7.x, var_529_7.y, var_529_7.z)

				local var_529_8 = var_529_0.localEulerAngles

				var_529_8.z = 0
				var_529_8.x = 0
				var_529_0.localEulerAngles = var_529_8
			end

			local var_529_9 = arg_526_1.actors_["1047ui_story"]
			local var_529_10 = 0

			if var_529_10 < arg_526_1.time_ and arg_526_1.time_ <= var_529_10 + arg_529_0 and not isNil(var_529_9) and arg_526_1.var_.characterEffect1047ui_story == nil then
				arg_526_1.var_.characterEffect1047ui_story = var_529_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_11 = 0.200000002980232

			if var_529_10 <= arg_526_1.time_ and arg_526_1.time_ < var_529_10 + var_529_11 and not isNil(var_529_9) then
				local var_529_12 = (arg_526_1.time_ - var_529_10) / var_529_11

				if arg_526_1.var_.characterEffect1047ui_story and not isNil(var_529_9) then
					arg_526_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_526_1.time_ >= var_529_10 + var_529_11 and arg_526_1.time_ < var_529_10 + var_529_11 + arg_529_0 and not isNil(var_529_9) and arg_526_1.var_.characterEffect1047ui_story then
				arg_526_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_529_13 = 0

			if var_529_13 < arg_526_1.time_ and arg_526_1.time_ <= var_529_13 + arg_529_0 then
				arg_526_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			local var_529_14 = 0

			if var_529_14 < arg_526_1.time_ and arg_526_1.time_ <= var_529_14 + arg_529_0 then
				arg_526_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_529_15 = 0
			local var_529_16 = 0.725

			if var_529_15 < arg_526_1.time_ and arg_526_1.time_ <= var_529_15 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				local var_529_17 = arg_526_1:FormatText(StoryNameCfg[1296].name)

				arg_526_1.leftNameTxt_.text = var_529_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_18 = arg_526_1:GetWordFromCfg(1104701129)
				local var_529_19 = arg_526_1:FormatText(var_529_18.content)

				arg_526_1.text_.text = var_529_19

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_20 = 28
				local var_529_21 = utf8.len(var_529_19)
				local var_529_22 = var_529_20 <= 0 and var_529_16 or var_529_16 * (var_529_21 / var_529_20)

				if var_529_22 > 0 and var_529_16 < var_529_22 then
					arg_526_1.talkMaxDuration = var_529_22

					if var_529_22 + var_529_15 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_22 + var_529_15
					end
				end

				arg_526_1.text_.text = var_529_19
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701129", "story_v_side_new_1104701.awb") ~= 0 then
					local var_529_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701129", "story_v_side_new_1104701.awb") / 1000

					if var_529_23 + var_529_15 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_23 + var_529_15
					end

					if var_529_18.prefab_name ~= "" and arg_526_1.actors_[var_529_18.prefab_name] ~= nil then
						local var_529_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_526_1.actors_[var_529_18.prefab_name].transform, "story_v_side_new_1104701", "1104701129", "story_v_side_new_1104701.awb")

						arg_526_1:RecordAudio("1104701129", var_529_24)
						arg_526_1:RecordAudio("1104701129", var_529_24)
					else
						arg_526_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701129", "story_v_side_new_1104701.awb")
					end

					arg_526_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701129", "story_v_side_new_1104701.awb")
				end

				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_25 = math.max(var_529_16, arg_526_1.talkMaxDuration)

			if var_529_15 <= arg_526_1.time_ and arg_526_1.time_ < var_529_15 + var_529_25 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_15) / var_529_25

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_15 + var_529_25 and arg_526_1.time_ < var_529_15 + var_529_25 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_526_1:InitPlayNodeList()
	end,
	Play1104701130 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 1104701130
		arg_530_1.duration_ = 9.6

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play1104701131(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = arg_530_1.actors_["1047ui_story"].transform
			local var_533_1 = 0

			if var_533_1 < arg_530_1.time_ and arg_530_1.time_ <= var_533_1 + arg_533_0 then
				arg_530_1.var_.moveOldPos1047ui_story = var_533_0.localPosition
			end

			local var_533_2 = 0.001

			if var_533_1 <= arg_530_1.time_ and arg_530_1.time_ < var_533_1 + var_533_2 then
				local var_533_3 = (arg_530_1.time_ - var_533_1) / var_533_2
				local var_533_4 = Vector3.New(0, -1.13, -6.2)

				var_533_0.localPosition = Vector3.Lerp(arg_530_1.var_.moveOldPos1047ui_story, var_533_4, var_533_3)

				local var_533_5 = manager.ui.mainCamera.transform.position - var_533_0.position

				var_533_0.forward = Vector3.New(var_533_5.x, var_533_5.y, var_533_5.z)

				local var_533_6 = var_533_0.localEulerAngles

				var_533_6.z = 0
				var_533_6.x = 0
				var_533_0.localEulerAngles = var_533_6
			end

			if arg_530_1.time_ >= var_533_1 + var_533_2 and arg_530_1.time_ < var_533_1 + var_533_2 + arg_533_0 then
				var_533_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_533_7 = manager.ui.mainCamera.transform.position - var_533_0.position

				var_533_0.forward = Vector3.New(var_533_7.x, var_533_7.y, var_533_7.z)

				local var_533_8 = var_533_0.localEulerAngles

				var_533_8.z = 0
				var_533_8.x = 0
				var_533_0.localEulerAngles = var_533_8
			end

			local var_533_9 = 0

			if var_533_9 < arg_530_1.time_ and arg_530_1.time_ <= var_533_9 + arg_533_0 then
				arg_530_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			local var_533_10 = 0

			if var_533_10 < arg_530_1.time_ and arg_530_1.time_ <= var_533_10 + arg_533_0 then
				arg_530_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_533_11 = 0
			local var_533_12 = 0.95

			if var_533_11 < arg_530_1.time_ and arg_530_1.time_ <= var_533_11 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				local var_533_13 = arg_530_1:FormatText(StoryNameCfg[1296].name)

				arg_530_1.leftNameTxt_.text = var_533_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_14 = arg_530_1:GetWordFromCfg(1104701130)
				local var_533_15 = arg_530_1:FormatText(var_533_14.content)

				arg_530_1.text_.text = var_533_15

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_16 = 38
				local var_533_17 = utf8.len(var_533_15)
				local var_533_18 = var_533_16 <= 0 and var_533_12 or var_533_12 * (var_533_17 / var_533_16)

				if var_533_18 > 0 and var_533_12 < var_533_18 then
					arg_530_1.talkMaxDuration = var_533_18

					if var_533_18 + var_533_11 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_18 + var_533_11
					end
				end

				arg_530_1.text_.text = var_533_15
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701130", "story_v_side_new_1104701.awb") ~= 0 then
					local var_533_19 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701130", "story_v_side_new_1104701.awb") / 1000

					if var_533_19 + var_533_11 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_19 + var_533_11
					end

					if var_533_14.prefab_name ~= "" and arg_530_1.actors_[var_533_14.prefab_name] ~= nil then
						local var_533_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_14.prefab_name].transform, "story_v_side_new_1104701", "1104701130", "story_v_side_new_1104701.awb")

						arg_530_1:RecordAudio("1104701130", var_533_20)
						arg_530_1:RecordAudio("1104701130", var_533_20)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701130", "story_v_side_new_1104701.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701130", "story_v_side_new_1104701.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_21 = math.max(var_533_12, arg_530_1.talkMaxDuration)

			if var_533_11 <= arg_530_1.time_ and arg_530_1.time_ < var_533_11 + var_533_21 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_11) / var_533_21

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_11 + var_533_21 and arg_530_1.time_ < var_533_11 + var_533_21 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_530_1:InitPlayNodeList()
	end,
	Play1104701131 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 1104701131
		arg_534_1.duration_ = 1

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"

			SetActive(arg_534_1.choicesGo_, true)

			for iter_535_0, iter_535_1 in ipairs(arg_534_1.choices_) do
				local var_535_0 = iter_535_0 <= 2

				SetActive(iter_535_1.go, var_535_0)
			end

			arg_534_1.choices_[1].txt.text = arg_534_1:FormatText(StoryChoiceCfg[1651].name)
			arg_534_1.choices_[2].txt.text = arg_534_1:FormatText(StoryChoiceCfg[1652].name)
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play1104701132(arg_534_1)
			end

			if arg_536_0 == 2 then
				arg_534_0:Play1104701133(arg_534_1)
			end

			arg_534_1:RecordChoiceLog(1104701131, 1651, 1652)
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = arg_534_1.actors_["1047ui_story"]
			local var_537_1 = 0

			if var_537_1 < arg_534_1.time_ and arg_534_1.time_ <= var_537_1 + arg_537_0 and not isNil(var_537_0) and arg_534_1.var_.characterEffect1047ui_story == nil then
				arg_534_1.var_.characterEffect1047ui_story = var_537_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_537_2 = 0.200000002980232

			if var_537_1 <= arg_534_1.time_ and arg_534_1.time_ < var_537_1 + var_537_2 and not isNil(var_537_0) then
				local var_537_3 = (arg_534_1.time_ - var_537_1) / var_537_2

				if arg_534_1.var_.characterEffect1047ui_story and not isNil(var_537_0) then
					local var_537_4 = Mathf.Lerp(0, 0.5, var_537_3)

					arg_534_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_534_1.var_.characterEffect1047ui_story.fillRatio = var_537_4
				end
			end

			if arg_534_1.time_ >= var_537_1 + var_537_2 and arg_534_1.time_ < var_537_1 + var_537_2 + arg_537_0 and not isNil(var_537_0) and arg_534_1.var_.characterEffect1047ui_story then
				local var_537_5 = 0.5

				arg_534_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_534_1.var_.characterEffect1047ui_story.fillRatio = var_537_5
			end
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	Play1104701132 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 1104701132
		arg_538_1.duration_ = 4.9

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play1104701134(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			local var_541_0 = arg_538_1.actors_["1047ui_story"].transform
			local var_541_1 = 0

			if var_541_1 < arg_538_1.time_ and arg_538_1.time_ <= var_541_1 + arg_541_0 then
				arg_538_1.var_.moveOldPos1047ui_story = var_541_0.localPosition
			end

			local var_541_2 = 0.001

			if var_541_1 <= arg_538_1.time_ and arg_538_1.time_ < var_541_1 + var_541_2 then
				local var_541_3 = (arg_538_1.time_ - var_541_1) / var_541_2
				local var_541_4 = Vector3.New(0, -1.13, -6.2)

				var_541_0.localPosition = Vector3.Lerp(arg_538_1.var_.moveOldPos1047ui_story, var_541_4, var_541_3)

				local var_541_5 = manager.ui.mainCamera.transform.position - var_541_0.position

				var_541_0.forward = Vector3.New(var_541_5.x, var_541_5.y, var_541_5.z)

				local var_541_6 = var_541_0.localEulerAngles

				var_541_6.z = 0
				var_541_6.x = 0
				var_541_0.localEulerAngles = var_541_6
			end

			if arg_538_1.time_ >= var_541_1 + var_541_2 and arg_538_1.time_ < var_541_1 + var_541_2 + arg_541_0 then
				var_541_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_541_7 = manager.ui.mainCamera.transform.position - var_541_0.position

				var_541_0.forward = Vector3.New(var_541_7.x, var_541_7.y, var_541_7.z)

				local var_541_8 = var_541_0.localEulerAngles

				var_541_8.z = 0
				var_541_8.x = 0
				var_541_0.localEulerAngles = var_541_8
			end

			local var_541_9 = arg_538_1.actors_["1047ui_story"]
			local var_541_10 = 0

			if var_541_10 < arg_538_1.time_ and arg_538_1.time_ <= var_541_10 + arg_541_0 and not isNil(var_541_9) and arg_538_1.var_.characterEffect1047ui_story == nil then
				arg_538_1.var_.characterEffect1047ui_story = var_541_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_541_11 = 0.200000002980232

			if var_541_10 <= arg_538_1.time_ and arg_538_1.time_ < var_541_10 + var_541_11 and not isNil(var_541_9) then
				local var_541_12 = (arg_538_1.time_ - var_541_10) / var_541_11

				if arg_538_1.var_.characterEffect1047ui_story and not isNil(var_541_9) then
					arg_538_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_538_1.time_ >= var_541_10 + var_541_11 and arg_538_1.time_ < var_541_10 + var_541_11 + arg_541_0 and not isNil(var_541_9) and arg_538_1.var_.characterEffect1047ui_story then
				arg_538_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_541_13 = 0

			if var_541_13 < arg_538_1.time_ and arg_538_1.time_ <= var_541_13 + arg_541_0 then
				arg_538_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			local var_541_14 = 0

			if var_541_14 < arg_538_1.time_ and arg_538_1.time_ <= var_541_14 + arg_541_0 then
				arg_538_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_541_15 = 0
			local var_541_16 = 0.4

			if var_541_15 < arg_538_1.time_ and arg_538_1.time_ <= var_541_15 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				local var_541_17 = arg_538_1:FormatText(StoryNameCfg[1296].name)

				arg_538_1.leftNameTxt_.text = var_541_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_18 = arg_538_1:GetWordFromCfg(1104701132)
				local var_541_19 = arg_538_1:FormatText(var_541_18.content)

				arg_538_1.text_.text = var_541_19

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_20 = 16
				local var_541_21 = utf8.len(var_541_19)
				local var_541_22 = var_541_20 <= 0 and var_541_16 or var_541_16 * (var_541_21 / var_541_20)

				if var_541_22 > 0 and var_541_16 < var_541_22 then
					arg_538_1.talkMaxDuration = var_541_22

					if var_541_22 + var_541_15 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_22 + var_541_15
					end
				end

				arg_538_1.text_.text = var_541_19
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701132", "story_v_side_new_1104701.awb") ~= 0 then
					local var_541_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701132", "story_v_side_new_1104701.awb") / 1000

					if var_541_23 + var_541_15 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_23 + var_541_15
					end

					if var_541_18.prefab_name ~= "" and arg_538_1.actors_[var_541_18.prefab_name] ~= nil then
						local var_541_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_18.prefab_name].transform, "story_v_side_new_1104701", "1104701132", "story_v_side_new_1104701.awb")

						arg_538_1:RecordAudio("1104701132", var_541_24)
						arg_538_1:RecordAudio("1104701132", var_541_24)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701132", "story_v_side_new_1104701.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701132", "story_v_side_new_1104701.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_25 = math.max(var_541_16, arg_538_1.talkMaxDuration)

			if var_541_15 <= arg_538_1.time_ and arg_538_1.time_ < var_541_15 + var_541_25 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_15) / var_541_25

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_15 + var_541_25 and arg_538_1.time_ < var_541_15 + var_541_25 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_538_1:InitPlayNodeList()
	end,
	Play1104701134 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 1104701134
		arg_542_1.duration_ = 5

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play1104701135(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = arg_542_1.actors_["1047ui_story"]
			local var_545_1 = 0

			if var_545_1 < arg_542_1.time_ and arg_542_1.time_ <= var_545_1 + arg_545_0 and not isNil(var_545_0) and arg_542_1.var_.characterEffect1047ui_story == nil then
				arg_542_1.var_.characterEffect1047ui_story = var_545_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_545_2 = 0.200000002980232

			if var_545_1 <= arg_542_1.time_ and arg_542_1.time_ < var_545_1 + var_545_2 and not isNil(var_545_0) then
				local var_545_3 = (arg_542_1.time_ - var_545_1) / var_545_2

				if arg_542_1.var_.characterEffect1047ui_story and not isNil(var_545_0) then
					local var_545_4 = Mathf.Lerp(0, 0.5, var_545_3)

					arg_542_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_542_1.var_.characterEffect1047ui_story.fillRatio = var_545_4
				end
			end

			if arg_542_1.time_ >= var_545_1 + var_545_2 and arg_542_1.time_ < var_545_1 + var_545_2 + arg_545_0 and not isNil(var_545_0) and arg_542_1.var_.characterEffect1047ui_story then
				local var_545_5 = 0.5

				arg_542_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_542_1.var_.characterEffect1047ui_story.fillRatio = var_545_5
			end

			local var_545_6 = arg_542_1.actors_["1047ui_story"].transform
			local var_545_7 = 0

			if var_545_7 < arg_542_1.time_ and arg_542_1.time_ <= var_545_7 + arg_545_0 then
				arg_542_1.var_.moveOldPos1047ui_story = var_545_6.localPosition
			end

			local var_545_8 = 0.001

			if var_545_7 <= arg_542_1.time_ and arg_542_1.time_ < var_545_7 + var_545_8 then
				local var_545_9 = (arg_542_1.time_ - var_545_7) / var_545_8
				local var_545_10 = Vector3.New(0, 100, 0)

				var_545_6.localPosition = Vector3.Lerp(arg_542_1.var_.moveOldPos1047ui_story, var_545_10, var_545_9)

				local var_545_11 = manager.ui.mainCamera.transform.position - var_545_6.position

				var_545_6.forward = Vector3.New(var_545_11.x, var_545_11.y, var_545_11.z)

				local var_545_12 = var_545_6.localEulerAngles

				var_545_12.z = 0
				var_545_12.x = 0
				var_545_6.localEulerAngles = var_545_12
			end

			if arg_542_1.time_ >= var_545_7 + var_545_8 and arg_542_1.time_ < var_545_7 + var_545_8 + arg_545_0 then
				var_545_6.localPosition = Vector3.New(0, 100, 0)

				local var_545_13 = manager.ui.mainCamera.transform.position - var_545_6.position

				var_545_6.forward = Vector3.New(var_545_13.x, var_545_13.y, var_545_13.z)

				local var_545_14 = var_545_6.localEulerAngles

				var_545_14.z = 0
				var_545_14.x = 0
				var_545_6.localEulerAngles = var_545_14
			end

			local var_545_15 = 0
			local var_545_16 = 0.8

			if var_545_15 < arg_542_1.time_ and arg_542_1.time_ <= var_545_15 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, false)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_17 = arg_542_1:GetWordFromCfg(1104701134)
				local var_545_18 = arg_542_1:FormatText(var_545_17.content)

				arg_542_1.text_.text = var_545_18

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_19 = 32
				local var_545_20 = utf8.len(var_545_18)
				local var_545_21 = var_545_19 <= 0 and var_545_16 or var_545_16 * (var_545_20 / var_545_19)

				if var_545_21 > 0 and var_545_16 < var_545_21 then
					arg_542_1.talkMaxDuration = var_545_21

					if var_545_21 + var_545_15 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_21 + var_545_15
					end
				end

				arg_542_1.text_.text = var_545_18
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)
				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_22 = math.max(var_545_16, arg_542_1.talkMaxDuration)

			if var_545_15 <= arg_542_1.time_ and arg_542_1.time_ < var_545_15 + var_545_22 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_15) / var_545_22

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_15 + var_545_22 and arg_542_1.time_ < var_545_15 + var_545_22 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_542_1:InitPlayNodeList()
	end,
	Play1104701135 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 1104701135
		arg_546_1.duration_ = 2.2

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play1104701136(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = 0
			local var_549_1 = 0.225

			if var_549_0 < arg_546_1.time_ and arg_546_1.time_ <= var_549_0 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				local var_549_2 = arg_546_1:FormatText(StoryNameCfg[1517].name)

				arg_546_1.leftNameTxt_.text = var_549_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, true)
				arg_546_1.iconController_:SetSelectedState("hero")

				arg_546_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_546_1.callingController_:SetSelectedState("normal")

				arg_546_1.keyicon_.color = Color.New(1, 1, 1)
				arg_546_1.icon_.color = Color.New(1, 1, 1)

				local var_549_3 = arg_546_1:GetWordFromCfg(1104701135)
				local var_549_4 = arg_546_1:FormatText(var_549_3.content)

				arg_546_1.text_.text = var_549_4

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_5 = 9
				local var_549_6 = utf8.len(var_549_4)
				local var_549_7 = var_549_5 <= 0 and var_549_1 or var_549_1 * (var_549_6 / var_549_5)

				if var_549_7 > 0 and var_549_1 < var_549_7 then
					arg_546_1.talkMaxDuration = var_549_7

					if var_549_7 + var_549_0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_7 + var_549_0
					end
				end

				arg_546_1.text_.text = var_549_4
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701135", "story_v_side_new_1104701.awb") ~= 0 then
					local var_549_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701135", "story_v_side_new_1104701.awb") / 1000

					if var_549_8 + var_549_0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_8 + var_549_0
					end

					if var_549_3.prefab_name ~= "" and arg_546_1.actors_[var_549_3.prefab_name] ~= nil then
						local var_549_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_546_1.actors_[var_549_3.prefab_name].transform, "story_v_side_new_1104701", "1104701135", "story_v_side_new_1104701.awb")

						arg_546_1:RecordAudio("1104701135", var_549_9)
						arg_546_1:RecordAudio("1104701135", var_549_9)
					else
						arg_546_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701135", "story_v_side_new_1104701.awb")
					end

					arg_546_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701135", "story_v_side_new_1104701.awb")
				end

				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_10 = math.max(var_549_1, arg_546_1.talkMaxDuration)

			if var_549_0 <= arg_546_1.time_ and arg_546_1.time_ < var_549_0 + var_549_10 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_0) / var_549_10

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_0 + var_549_10 and arg_546_1.time_ < var_549_0 + var_549_10 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play1104701136 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 1104701136
		arg_550_1.duration_ = 5

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play1104701137(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = 0
			local var_553_1 = 0.75

			if var_553_0 < arg_550_1.time_ and arg_550_1.time_ <= var_553_0 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, false)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_550_1.iconTrs_.gameObject, false)
				arg_550_1.callingController_:SetSelectedState("normal")

				local var_553_2 = arg_550_1:GetWordFromCfg(1104701136)
				local var_553_3 = arg_550_1:FormatText(var_553_2.content)

				arg_550_1.text_.text = var_553_3

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_4 = 30
				local var_553_5 = utf8.len(var_553_3)
				local var_553_6 = var_553_4 <= 0 and var_553_1 or var_553_1 * (var_553_5 / var_553_4)

				if var_553_6 > 0 and var_553_1 < var_553_6 then
					arg_550_1.talkMaxDuration = var_553_6

					if var_553_6 + var_553_0 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_6 + var_553_0
					end
				end

				arg_550_1.text_.text = var_553_3
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)
				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_7 = math.max(var_553_1, arg_550_1.talkMaxDuration)

			if var_553_0 <= arg_550_1.time_ and arg_550_1.time_ < var_553_0 + var_553_7 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - var_553_0) / var_553_7

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= var_553_0 + var_553_7 and arg_550_1.time_ < var_553_0 + var_553_7 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play1104701137 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 1104701137
		arg_554_1.duration_ = 4.43

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play1104701138(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = arg_554_1.actors_["1047ui_story"].transform
			local var_557_1 = 0

			if var_557_1 < arg_554_1.time_ and arg_554_1.time_ <= var_557_1 + arg_557_0 then
				arg_554_1.var_.moveOldPos1047ui_story = var_557_0.localPosition
			end

			local var_557_2 = 0.001

			if var_557_1 <= arg_554_1.time_ and arg_554_1.time_ < var_557_1 + var_557_2 then
				local var_557_3 = (arg_554_1.time_ - var_557_1) / var_557_2
				local var_557_4 = Vector3.New(0, -1.13, -6.2)

				var_557_0.localPosition = Vector3.Lerp(arg_554_1.var_.moveOldPos1047ui_story, var_557_4, var_557_3)

				local var_557_5 = manager.ui.mainCamera.transform.position - var_557_0.position

				var_557_0.forward = Vector3.New(var_557_5.x, var_557_5.y, var_557_5.z)

				local var_557_6 = var_557_0.localEulerAngles

				var_557_6.z = 0
				var_557_6.x = 0
				var_557_0.localEulerAngles = var_557_6
			end

			if arg_554_1.time_ >= var_557_1 + var_557_2 and arg_554_1.time_ < var_557_1 + var_557_2 + arg_557_0 then
				var_557_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_557_7 = manager.ui.mainCamera.transform.position - var_557_0.position

				var_557_0.forward = Vector3.New(var_557_7.x, var_557_7.y, var_557_7.z)

				local var_557_8 = var_557_0.localEulerAngles

				var_557_8.z = 0
				var_557_8.x = 0
				var_557_0.localEulerAngles = var_557_8
			end

			local var_557_9 = arg_554_1.actors_["1047ui_story"]
			local var_557_10 = 0

			if var_557_10 < arg_554_1.time_ and arg_554_1.time_ <= var_557_10 + arg_557_0 and not isNil(var_557_9) and arg_554_1.var_.characterEffect1047ui_story == nil then
				arg_554_1.var_.characterEffect1047ui_story = var_557_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_557_11 = 0.200000002980232

			if var_557_10 <= arg_554_1.time_ and arg_554_1.time_ < var_557_10 + var_557_11 and not isNil(var_557_9) then
				local var_557_12 = (arg_554_1.time_ - var_557_10) / var_557_11

				if arg_554_1.var_.characterEffect1047ui_story and not isNil(var_557_9) then
					arg_554_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_554_1.time_ >= var_557_10 + var_557_11 and arg_554_1.time_ < var_557_10 + var_557_11 + arg_557_0 and not isNil(var_557_9) and arg_554_1.var_.characterEffect1047ui_story then
				arg_554_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_557_13 = 0

			if var_557_13 < arg_554_1.time_ and arg_554_1.time_ <= var_557_13 + arg_557_0 then
				arg_554_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_557_14 = 0

			if var_557_14 < arg_554_1.time_ and arg_554_1.time_ <= var_557_14 + arg_557_0 then
				arg_554_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_557_15 = 0
			local var_557_16 = 0.525

			if var_557_15 < arg_554_1.time_ and arg_554_1.time_ <= var_557_15 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				local var_557_17 = arg_554_1:FormatText(StoryNameCfg[1296].name)

				arg_554_1.leftNameTxt_.text = var_557_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_18 = arg_554_1:GetWordFromCfg(1104701137)
				local var_557_19 = arg_554_1:FormatText(var_557_18.content)

				arg_554_1.text_.text = var_557_19

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_20 = 21
				local var_557_21 = utf8.len(var_557_19)
				local var_557_22 = var_557_20 <= 0 and var_557_16 or var_557_16 * (var_557_21 / var_557_20)

				if var_557_22 > 0 and var_557_16 < var_557_22 then
					arg_554_1.talkMaxDuration = var_557_22

					if var_557_22 + var_557_15 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_22 + var_557_15
					end
				end

				arg_554_1.text_.text = var_557_19
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701137", "story_v_side_new_1104701.awb") ~= 0 then
					local var_557_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701137", "story_v_side_new_1104701.awb") / 1000

					if var_557_23 + var_557_15 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_23 + var_557_15
					end

					if var_557_18.prefab_name ~= "" and arg_554_1.actors_[var_557_18.prefab_name] ~= nil then
						local var_557_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_18.prefab_name].transform, "story_v_side_new_1104701", "1104701137", "story_v_side_new_1104701.awb")

						arg_554_1:RecordAudio("1104701137", var_557_24)
						arg_554_1:RecordAudio("1104701137", var_557_24)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701137", "story_v_side_new_1104701.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701137", "story_v_side_new_1104701.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_25 = math.max(var_557_16, arg_554_1.talkMaxDuration)

			if var_557_15 <= arg_554_1.time_ and arg_554_1.time_ < var_557_15 + var_557_25 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_15) / var_557_25

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_15 + var_557_25 and arg_554_1.time_ < var_557_15 + var_557_25 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_554_1:InitPlayNodeList()
	end,
	Play1104701138 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 1104701138
		arg_558_1.duration_ = 8.37

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play1104701139(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = arg_558_1.actors_["1047ui_story"]
			local var_561_1 = 0

			if var_561_1 < arg_558_1.time_ and arg_558_1.time_ <= var_561_1 + arg_561_0 and not isNil(var_561_0) and arg_558_1.var_.characterEffect1047ui_story == nil then
				arg_558_1.var_.characterEffect1047ui_story = var_561_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_561_2 = 0.200000002980232

			if var_561_1 <= arg_558_1.time_ and arg_558_1.time_ < var_561_1 + var_561_2 and not isNil(var_561_0) then
				local var_561_3 = (arg_558_1.time_ - var_561_1) / var_561_2

				if arg_558_1.var_.characterEffect1047ui_story and not isNil(var_561_0) then
					local var_561_4 = Mathf.Lerp(0, 0.5, var_561_3)

					arg_558_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_558_1.var_.characterEffect1047ui_story.fillRatio = var_561_4
				end
			end

			if arg_558_1.time_ >= var_561_1 + var_561_2 and arg_558_1.time_ < var_561_1 + var_561_2 + arg_561_0 and not isNil(var_561_0) and arg_558_1.var_.characterEffect1047ui_story then
				local var_561_5 = 0.5

				arg_558_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_558_1.var_.characterEffect1047ui_story.fillRatio = var_561_5
			end

			local var_561_6 = 0
			local var_561_7 = 1.025

			if var_561_6 < arg_558_1.time_ and arg_558_1.time_ <= var_561_6 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				local var_561_8 = arg_558_1:FormatText(StoryNameCfg[1517].name)

				arg_558_1.leftNameTxt_.text = var_561_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, true)
				arg_558_1.iconController_:SetSelectedState("hero")

				arg_558_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_558_1.callingController_:SetSelectedState("normal")

				arg_558_1.keyicon_.color = Color.New(1, 1, 1)
				arg_558_1.icon_.color = Color.New(1, 1, 1)

				local var_561_9 = arg_558_1:GetWordFromCfg(1104701138)
				local var_561_10 = arg_558_1:FormatText(var_561_9.content)

				arg_558_1.text_.text = var_561_10

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_11 = 41
				local var_561_12 = utf8.len(var_561_10)
				local var_561_13 = var_561_11 <= 0 and var_561_7 or var_561_7 * (var_561_12 / var_561_11)

				if var_561_13 > 0 and var_561_7 < var_561_13 then
					arg_558_1.talkMaxDuration = var_561_13

					if var_561_13 + var_561_6 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_13 + var_561_6
					end
				end

				arg_558_1.text_.text = var_561_10
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701138", "story_v_side_new_1104701.awb") ~= 0 then
					local var_561_14 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701138", "story_v_side_new_1104701.awb") / 1000

					if var_561_14 + var_561_6 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_14 + var_561_6
					end

					if var_561_9.prefab_name ~= "" and arg_558_1.actors_[var_561_9.prefab_name] ~= nil then
						local var_561_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_558_1.actors_[var_561_9.prefab_name].transform, "story_v_side_new_1104701", "1104701138", "story_v_side_new_1104701.awb")

						arg_558_1:RecordAudio("1104701138", var_561_15)
						arg_558_1:RecordAudio("1104701138", var_561_15)
					else
						arg_558_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701138", "story_v_side_new_1104701.awb")
					end

					arg_558_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701138", "story_v_side_new_1104701.awb")
				end

				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_16 = math.max(var_561_7, arg_558_1.talkMaxDuration)

			if var_561_6 <= arg_558_1.time_ and arg_558_1.time_ < var_561_6 + var_561_16 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_6) / var_561_16

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_6 + var_561_16 and arg_558_1.time_ < var_561_6 + var_561_16 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play1104701139 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 1104701139
		arg_562_1.duration_ = 5

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play1104701140(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = arg_562_1.actors_["1047ui_story"].transform
			local var_565_1 = 0

			if var_565_1 < arg_562_1.time_ and arg_562_1.time_ <= var_565_1 + arg_565_0 then
				arg_562_1.var_.moveOldPos1047ui_story = var_565_0.localPosition
			end

			local var_565_2 = 0.001

			if var_565_1 <= arg_562_1.time_ and arg_562_1.time_ < var_565_1 + var_565_2 then
				local var_565_3 = (arg_562_1.time_ - var_565_1) / var_565_2
				local var_565_4 = Vector3.New(0, 100, 0)

				var_565_0.localPosition = Vector3.Lerp(arg_562_1.var_.moveOldPos1047ui_story, var_565_4, var_565_3)

				local var_565_5 = manager.ui.mainCamera.transform.position - var_565_0.position

				var_565_0.forward = Vector3.New(var_565_5.x, var_565_5.y, var_565_5.z)

				local var_565_6 = var_565_0.localEulerAngles

				var_565_6.z = 0
				var_565_6.x = 0
				var_565_0.localEulerAngles = var_565_6
			end

			if arg_562_1.time_ >= var_565_1 + var_565_2 and arg_562_1.time_ < var_565_1 + var_565_2 + arg_565_0 then
				var_565_0.localPosition = Vector3.New(0, 100, 0)

				local var_565_7 = manager.ui.mainCamera.transform.position - var_565_0.position

				var_565_0.forward = Vector3.New(var_565_7.x, var_565_7.y, var_565_7.z)

				local var_565_8 = var_565_0.localEulerAngles

				var_565_8.z = 0
				var_565_8.x = 0
				var_565_0.localEulerAngles = var_565_8
			end

			local var_565_9 = 0
			local var_565_10 = 1.4

			if var_565_9 < arg_562_1.time_ and arg_562_1.time_ <= var_565_9 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, false)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_11 = arg_562_1:GetWordFromCfg(1104701139)
				local var_565_12 = arg_562_1:FormatText(var_565_11.content)

				arg_562_1.text_.text = var_565_12

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_13 = 56
				local var_565_14 = utf8.len(var_565_12)
				local var_565_15 = var_565_13 <= 0 and var_565_10 or var_565_10 * (var_565_14 / var_565_13)

				if var_565_15 > 0 and var_565_10 < var_565_15 then
					arg_562_1.talkMaxDuration = var_565_15

					if var_565_15 + var_565_9 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_15 + var_565_9
					end
				end

				arg_562_1.text_.text = var_565_12
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)
				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_16 = math.max(var_565_10, arg_562_1.talkMaxDuration)

			if var_565_9 <= arg_562_1.time_ and arg_562_1.time_ < var_565_9 + var_565_16 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_9) / var_565_16

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_9 + var_565_16 and arg_562_1.time_ < var_565_9 + var_565_16 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_562_1:InitPlayNodeList()
	end,
	Play1104701140 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 1104701140
		arg_566_1.duration_ = 12.9

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play1104701141(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			local var_569_0 = arg_566_1.actors_["1047ui_story"].transform
			local var_569_1 = 0

			if var_569_1 < arg_566_1.time_ and arg_566_1.time_ <= var_569_1 + arg_569_0 then
				arg_566_1.var_.moveOldPos1047ui_story = var_569_0.localPosition
			end

			local var_569_2 = 0.001

			if var_569_1 <= arg_566_1.time_ and arg_566_1.time_ < var_569_1 + var_569_2 then
				local var_569_3 = (arg_566_1.time_ - var_569_1) / var_569_2
				local var_569_4 = Vector3.New(0, -1.13, -6.2)

				var_569_0.localPosition = Vector3.Lerp(arg_566_1.var_.moveOldPos1047ui_story, var_569_4, var_569_3)

				local var_569_5 = manager.ui.mainCamera.transform.position - var_569_0.position

				var_569_0.forward = Vector3.New(var_569_5.x, var_569_5.y, var_569_5.z)

				local var_569_6 = var_569_0.localEulerAngles

				var_569_6.z = 0
				var_569_6.x = 0
				var_569_0.localEulerAngles = var_569_6
			end

			if arg_566_1.time_ >= var_569_1 + var_569_2 and arg_566_1.time_ < var_569_1 + var_569_2 + arg_569_0 then
				var_569_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_569_7 = manager.ui.mainCamera.transform.position - var_569_0.position

				var_569_0.forward = Vector3.New(var_569_7.x, var_569_7.y, var_569_7.z)

				local var_569_8 = var_569_0.localEulerAngles

				var_569_8.z = 0
				var_569_8.x = 0
				var_569_0.localEulerAngles = var_569_8
			end

			local var_569_9 = arg_566_1.actors_["1047ui_story"]
			local var_569_10 = 0

			if var_569_10 < arg_566_1.time_ and arg_566_1.time_ <= var_569_10 + arg_569_0 and not isNil(var_569_9) and arg_566_1.var_.characterEffect1047ui_story == nil then
				arg_566_1.var_.characterEffect1047ui_story = var_569_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_569_11 = 0.200000002980232

			if var_569_10 <= arg_566_1.time_ and arg_566_1.time_ < var_569_10 + var_569_11 and not isNil(var_569_9) then
				local var_569_12 = (arg_566_1.time_ - var_569_10) / var_569_11

				if arg_566_1.var_.characterEffect1047ui_story and not isNil(var_569_9) then
					arg_566_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_566_1.time_ >= var_569_10 + var_569_11 and arg_566_1.time_ < var_569_10 + var_569_11 + arg_569_0 and not isNil(var_569_9) and arg_566_1.var_.characterEffect1047ui_story then
				arg_566_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_569_13 = 0

			if var_569_13 < arg_566_1.time_ and arg_566_1.time_ <= var_569_13 + arg_569_0 then
				arg_566_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_569_14 = 0

			if var_569_14 < arg_566_1.time_ and arg_566_1.time_ <= var_569_14 + arg_569_0 then
				arg_566_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_569_15 = 0
			local var_569_16 = 1.35

			if var_569_15 < arg_566_1.time_ and arg_566_1.time_ <= var_569_15 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				local var_569_17 = arg_566_1:FormatText(StoryNameCfg[1296].name)

				arg_566_1.leftNameTxt_.text = var_569_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_18 = arg_566_1:GetWordFromCfg(1104701140)
				local var_569_19 = arg_566_1:FormatText(var_569_18.content)

				arg_566_1.text_.text = var_569_19

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_20 = 54
				local var_569_21 = utf8.len(var_569_19)
				local var_569_22 = var_569_20 <= 0 and var_569_16 or var_569_16 * (var_569_21 / var_569_20)

				if var_569_22 > 0 and var_569_16 < var_569_22 then
					arg_566_1.talkMaxDuration = var_569_22

					if var_569_22 + var_569_15 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_22 + var_569_15
					end
				end

				arg_566_1.text_.text = var_569_19
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701140", "story_v_side_new_1104701.awb") ~= 0 then
					local var_569_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701140", "story_v_side_new_1104701.awb") / 1000

					if var_569_23 + var_569_15 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_23 + var_569_15
					end

					if var_569_18.prefab_name ~= "" and arg_566_1.actors_[var_569_18.prefab_name] ~= nil then
						local var_569_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_18.prefab_name].transform, "story_v_side_new_1104701", "1104701140", "story_v_side_new_1104701.awb")

						arg_566_1:RecordAudio("1104701140", var_569_24)
						arg_566_1:RecordAudio("1104701140", var_569_24)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701140", "story_v_side_new_1104701.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701140", "story_v_side_new_1104701.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_25 = math.max(var_569_16, arg_566_1.talkMaxDuration)

			if var_569_15 <= arg_566_1.time_ and arg_566_1.time_ < var_569_15 + var_569_25 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_15) / var_569_25

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_15 + var_569_25 and arg_566_1.time_ < var_569_15 + var_569_25 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_566_1:InitPlayNodeList()
	end,
	Play1104701141 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 1104701141
		arg_570_1.duration_ = 9.7

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play1104701142(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			local var_573_0 = arg_570_1.actors_["1047ui_story"].transform
			local var_573_1 = 0

			if var_573_1 < arg_570_1.time_ and arg_570_1.time_ <= var_573_1 + arg_573_0 then
				arg_570_1.var_.moveOldPos1047ui_story = var_573_0.localPosition
			end

			local var_573_2 = 0.001

			if var_573_1 <= arg_570_1.time_ and arg_570_1.time_ < var_573_1 + var_573_2 then
				local var_573_3 = (arg_570_1.time_ - var_573_1) / var_573_2
				local var_573_4 = Vector3.New(0, -1.13, -6.2)

				var_573_0.localPosition = Vector3.Lerp(arg_570_1.var_.moveOldPos1047ui_story, var_573_4, var_573_3)

				local var_573_5 = manager.ui.mainCamera.transform.position - var_573_0.position

				var_573_0.forward = Vector3.New(var_573_5.x, var_573_5.y, var_573_5.z)

				local var_573_6 = var_573_0.localEulerAngles

				var_573_6.z = 0
				var_573_6.x = 0
				var_573_0.localEulerAngles = var_573_6
			end

			if arg_570_1.time_ >= var_573_1 + var_573_2 and arg_570_1.time_ < var_573_1 + var_573_2 + arg_573_0 then
				var_573_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_573_7 = manager.ui.mainCamera.transform.position - var_573_0.position

				var_573_0.forward = Vector3.New(var_573_7.x, var_573_7.y, var_573_7.z)

				local var_573_8 = var_573_0.localEulerAngles

				var_573_8.z = 0
				var_573_8.x = 0
				var_573_0.localEulerAngles = var_573_8
			end

			local var_573_9 = 0

			if var_573_9 < arg_570_1.time_ and arg_570_1.time_ <= var_573_9 + arg_573_0 then
				arg_570_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_573_10 = 0

			if var_573_10 < arg_570_1.time_ and arg_570_1.time_ <= var_573_10 + arg_573_0 then
				arg_570_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_573_11 = 0
			local var_573_12 = 1.225

			if var_573_11 < arg_570_1.time_ and arg_570_1.time_ <= var_573_11 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				local var_573_13 = arg_570_1:FormatText(StoryNameCfg[1296].name)

				arg_570_1.leftNameTxt_.text = var_573_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_14 = arg_570_1:GetWordFromCfg(1104701141)
				local var_573_15 = arg_570_1:FormatText(var_573_14.content)

				arg_570_1.text_.text = var_573_15

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_16 = 49
				local var_573_17 = utf8.len(var_573_15)
				local var_573_18 = var_573_16 <= 0 and var_573_12 or var_573_12 * (var_573_17 / var_573_16)

				if var_573_18 > 0 and var_573_12 < var_573_18 then
					arg_570_1.talkMaxDuration = var_573_18

					if var_573_18 + var_573_11 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_18 + var_573_11
					end
				end

				arg_570_1.text_.text = var_573_15
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701141", "story_v_side_new_1104701.awb") ~= 0 then
					local var_573_19 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701141", "story_v_side_new_1104701.awb") / 1000

					if var_573_19 + var_573_11 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_19 + var_573_11
					end

					if var_573_14.prefab_name ~= "" and arg_570_1.actors_[var_573_14.prefab_name] ~= nil then
						local var_573_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_570_1.actors_[var_573_14.prefab_name].transform, "story_v_side_new_1104701", "1104701141", "story_v_side_new_1104701.awb")

						arg_570_1:RecordAudio("1104701141", var_573_20)
						arg_570_1:RecordAudio("1104701141", var_573_20)
					else
						arg_570_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701141", "story_v_side_new_1104701.awb")
					end

					arg_570_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701141", "story_v_side_new_1104701.awb")
				end

				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_21 = math.max(var_573_12, arg_570_1.talkMaxDuration)

			if var_573_11 <= arg_570_1.time_ and arg_570_1.time_ < var_573_11 + var_573_21 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_11) / var_573_21

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_11 + var_573_21 and arg_570_1.time_ < var_573_11 + var_573_21 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_570_1:InitPlayNodeList()
	end,
	Play1104701142 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 1104701142
		arg_574_1.duration_ = 5

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play1104701143(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			local var_577_0 = arg_574_1.actors_["1047ui_story"]
			local var_577_1 = 0

			if var_577_1 < arg_574_1.time_ and arg_574_1.time_ <= var_577_1 + arg_577_0 and not isNil(var_577_0) and arg_574_1.var_.characterEffect1047ui_story == nil then
				arg_574_1.var_.characterEffect1047ui_story = var_577_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_577_2 = 0.200000002980232

			if var_577_1 <= arg_574_1.time_ and arg_574_1.time_ < var_577_1 + var_577_2 and not isNil(var_577_0) then
				local var_577_3 = (arg_574_1.time_ - var_577_1) / var_577_2

				if arg_574_1.var_.characterEffect1047ui_story and not isNil(var_577_0) then
					local var_577_4 = Mathf.Lerp(0, 0.5, var_577_3)

					arg_574_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_574_1.var_.characterEffect1047ui_story.fillRatio = var_577_4
				end
			end

			if arg_574_1.time_ >= var_577_1 + var_577_2 and arg_574_1.time_ < var_577_1 + var_577_2 + arg_577_0 and not isNil(var_577_0) and arg_574_1.var_.characterEffect1047ui_story then
				local var_577_5 = 0.5

				arg_574_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_574_1.var_.characterEffect1047ui_story.fillRatio = var_577_5
			end

			local var_577_6 = arg_574_1.actors_["1047ui_story"].transform
			local var_577_7 = 0

			if var_577_7 < arg_574_1.time_ and arg_574_1.time_ <= var_577_7 + arg_577_0 then
				arg_574_1.var_.moveOldPos1047ui_story = var_577_6.localPosition
			end

			local var_577_8 = 0.001

			if var_577_7 <= arg_574_1.time_ and arg_574_1.time_ < var_577_7 + var_577_8 then
				local var_577_9 = (arg_574_1.time_ - var_577_7) / var_577_8
				local var_577_10 = Vector3.New(0, 100, 0)

				var_577_6.localPosition = Vector3.Lerp(arg_574_1.var_.moveOldPos1047ui_story, var_577_10, var_577_9)

				local var_577_11 = manager.ui.mainCamera.transform.position - var_577_6.position

				var_577_6.forward = Vector3.New(var_577_11.x, var_577_11.y, var_577_11.z)

				local var_577_12 = var_577_6.localEulerAngles

				var_577_12.z = 0
				var_577_12.x = 0
				var_577_6.localEulerAngles = var_577_12
			end

			if arg_574_1.time_ >= var_577_7 + var_577_8 and arg_574_1.time_ < var_577_7 + var_577_8 + arg_577_0 then
				var_577_6.localPosition = Vector3.New(0, 100, 0)

				local var_577_13 = manager.ui.mainCamera.transform.position - var_577_6.position

				var_577_6.forward = Vector3.New(var_577_13.x, var_577_13.y, var_577_13.z)

				local var_577_14 = var_577_6.localEulerAngles

				var_577_14.z = 0
				var_577_14.x = 0
				var_577_6.localEulerAngles = var_577_14
			end

			local var_577_15 = 0
			local var_577_16 = 0.425

			if var_577_15 < arg_574_1.time_ and arg_574_1.time_ <= var_577_15 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, false)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_574_1.iconTrs_.gameObject, false)
				arg_574_1.callingController_:SetSelectedState("normal")

				local var_577_17 = arg_574_1:GetWordFromCfg(1104701142)
				local var_577_18 = arg_574_1:FormatText(var_577_17.content)

				arg_574_1.text_.text = var_577_18

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_19 = 17
				local var_577_20 = utf8.len(var_577_18)
				local var_577_21 = var_577_19 <= 0 and var_577_16 or var_577_16 * (var_577_20 / var_577_19)

				if var_577_21 > 0 and var_577_16 < var_577_21 then
					arg_574_1.talkMaxDuration = var_577_21

					if var_577_21 + var_577_15 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_21 + var_577_15
					end
				end

				arg_574_1.text_.text = var_577_18
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)
				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_22 = math.max(var_577_16, arg_574_1.talkMaxDuration)

			if var_577_15 <= arg_574_1.time_ and arg_574_1.time_ < var_577_15 + var_577_22 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_15) / var_577_22

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_15 + var_577_22 and arg_574_1.time_ < var_577_15 + var_577_22 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_574_1:InitPlayNodeList()
	end,
	Play1104701143 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 1104701143
		arg_578_1.duration_ = 5

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play1104701144(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			local var_581_0 = 0
			local var_581_1 = 0.975

			if var_581_0 < arg_578_1.time_ and arg_578_1.time_ <= var_581_0 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, true)

				local var_581_2 = arg_578_1:FormatText(StoryNameCfg[7].name)

				arg_578_1.leftNameTxt_.text = var_581_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, true)
				arg_578_1.iconController_:SetSelectedState("hero")

				arg_578_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_578_1.callingController_:SetSelectedState("normal")

				arg_578_1.keyicon_.color = Color.New(1, 1, 1)
				arg_578_1.icon_.color = Color.New(1, 1, 1)

				local var_581_3 = arg_578_1:GetWordFromCfg(1104701143)
				local var_581_4 = arg_578_1:FormatText(var_581_3.content)

				arg_578_1.text_.text = var_581_4

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_5 = 39
				local var_581_6 = utf8.len(var_581_4)
				local var_581_7 = var_581_5 <= 0 and var_581_1 or var_581_1 * (var_581_6 / var_581_5)

				if var_581_7 > 0 and var_581_1 < var_581_7 then
					arg_578_1.talkMaxDuration = var_581_7

					if var_581_7 + var_581_0 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_7 + var_581_0
					end
				end

				arg_578_1.text_.text = var_581_4
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)
				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_8 = math.max(var_581_1, arg_578_1.talkMaxDuration)

			if var_581_0 <= arg_578_1.time_ and arg_578_1.time_ < var_581_0 + var_581_8 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_0) / var_581_8

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_0 + var_581_8 and arg_578_1.time_ < var_581_0 + var_581_8 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {}

		arg_578_1:InitPlayNodeList()
	end,
	Play1104701144 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 1104701144
		arg_582_1.duration_ = 7.83

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play1104701145(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			local var_585_0 = arg_582_1.actors_["1047ui_story"].transform
			local var_585_1 = 0

			if var_585_1 < arg_582_1.time_ and arg_582_1.time_ <= var_585_1 + arg_585_0 then
				arg_582_1.var_.moveOldPos1047ui_story = var_585_0.localPosition
			end

			local var_585_2 = 0.001

			if var_585_1 <= arg_582_1.time_ and arg_582_1.time_ < var_585_1 + var_585_2 then
				local var_585_3 = (arg_582_1.time_ - var_585_1) / var_585_2
				local var_585_4 = Vector3.New(0, -1.13, -6.2)

				var_585_0.localPosition = Vector3.Lerp(arg_582_1.var_.moveOldPos1047ui_story, var_585_4, var_585_3)

				local var_585_5 = manager.ui.mainCamera.transform.position - var_585_0.position

				var_585_0.forward = Vector3.New(var_585_5.x, var_585_5.y, var_585_5.z)

				local var_585_6 = var_585_0.localEulerAngles

				var_585_6.z = 0
				var_585_6.x = 0
				var_585_0.localEulerAngles = var_585_6
			end

			if arg_582_1.time_ >= var_585_1 + var_585_2 and arg_582_1.time_ < var_585_1 + var_585_2 + arg_585_0 then
				var_585_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_585_7 = manager.ui.mainCamera.transform.position - var_585_0.position

				var_585_0.forward = Vector3.New(var_585_7.x, var_585_7.y, var_585_7.z)

				local var_585_8 = var_585_0.localEulerAngles

				var_585_8.z = 0
				var_585_8.x = 0
				var_585_0.localEulerAngles = var_585_8
			end

			local var_585_9 = arg_582_1.actors_["1047ui_story"]
			local var_585_10 = 0

			if var_585_10 < arg_582_1.time_ and arg_582_1.time_ <= var_585_10 + arg_585_0 and not isNil(var_585_9) and arg_582_1.var_.characterEffect1047ui_story == nil then
				arg_582_1.var_.characterEffect1047ui_story = var_585_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_585_11 = 0.200000002980232

			if var_585_10 <= arg_582_1.time_ and arg_582_1.time_ < var_585_10 + var_585_11 and not isNil(var_585_9) then
				local var_585_12 = (arg_582_1.time_ - var_585_10) / var_585_11

				if arg_582_1.var_.characterEffect1047ui_story and not isNil(var_585_9) then
					arg_582_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_582_1.time_ >= var_585_10 + var_585_11 and arg_582_1.time_ < var_585_10 + var_585_11 + arg_585_0 and not isNil(var_585_9) and arg_582_1.var_.characterEffect1047ui_story then
				arg_582_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_585_13 = 0

			if var_585_13 < arg_582_1.time_ and arg_582_1.time_ <= var_585_13 + arg_585_0 then
				arg_582_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action5_1")
			end

			local var_585_14 = 0

			if var_585_14 < arg_582_1.time_ and arg_582_1.time_ <= var_585_14 + arg_585_0 then
				arg_582_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_585_15 = 1.999999999998

			if var_585_15 < arg_582_1.time_ and arg_582_1.time_ <= var_585_15 + arg_585_0 then
				arg_582_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action5_2")
			end

			local var_585_16 = 0
			local var_585_17 = 0.85

			if var_585_16 < arg_582_1.time_ and arg_582_1.time_ <= var_585_16 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, true)

				local var_585_18 = arg_582_1:FormatText(StoryNameCfg[1296].name)

				arg_582_1.leftNameTxt_.text = var_585_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_582_1.leftNameTxt_.transform)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1.leftNameTxt_.text)
				SetActive(arg_582_1.iconTrs_.gameObject, false)
				arg_582_1.callingController_:SetSelectedState("normal")

				local var_585_19 = arg_582_1:GetWordFromCfg(1104701144)
				local var_585_20 = arg_582_1:FormatText(var_585_19.content)

				arg_582_1.text_.text = var_585_20

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_21 = 34
				local var_585_22 = utf8.len(var_585_20)
				local var_585_23 = var_585_21 <= 0 and var_585_17 or var_585_17 * (var_585_22 / var_585_21)

				if var_585_23 > 0 and var_585_17 < var_585_23 then
					arg_582_1.talkMaxDuration = var_585_23

					if var_585_23 + var_585_16 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_23 + var_585_16
					end
				end

				arg_582_1.text_.text = var_585_20
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701144", "story_v_side_new_1104701.awb") ~= 0 then
					local var_585_24 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701144", "story_v_side_new_1104701.awb") / 1000

					if var_585_24 + var_585_16 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_24 + var_585_16
					end

					if var_585_19.prefab_name ~= "" and arg_582_1.actors_[var_585_19.prefab_name] ~= nil then
						local var_585_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_582_1.actors_[var_585_19.prefab_name].transform, "story_v_side_new_1104701", "1104701144", "story_v_side_new_1104701.awb")

						arg_582_1:RecordAudio("1104701144", var_585_25)
						arg_582_1:RecordAudio("1104701144", var_585_25)
					else
						arg_582_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701144", "story_v_side_new_1104701.awb")
					end

					arg_582_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701144", "story_v_side_new_1104701.awb")
				end

				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_26 = math.max(var_585_17, arg_582_1.talkMaxDuration)

			if var_585_16 <= arg_582_1.time_ and arg_582_1.time_ < var_585_16 + var_585_26 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_16) / var_585_26

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_16 + var_585_26 and arg_582_1.time_ < var_585_16 + var_585_26 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_582_1:InitPlayNodeList()
	end,
	Play1104701145 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 1104701145
		arg_586_1.duration_ = 5

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
		end

		function arg_586_1.playNext_(arg_588_0)
			if arg_588_0 == 1 then
				arg_586_0:Play1104701146(arg_586_1)
			end
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			local var_589_0 = arg_586_1.actors_["1047ui_story"]
			local var_589_1 = 0

			if var_589_1 < arg_586_1.time_ and arg_586_1.time_ <= var_589_1 + arg_589_0 and not isNil(var_589_0) and arg_586_1.var_.characterEffect1047ui_story == nil then
				arg_586_1.var_.characterEffect1047ui_story = var_589_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_589_2 = 0.200000002980232

			if var_589_1 <= arg_586_1.time_ and arg_586_1.time_ < var_589_1 + var_589_2 and not isNil(var_589_0) then
				local var_589_3 = (arg_586_1.time_ - var_589_1) / var_589_2

				if arg_586_1.var_.characterEffect1047ui_story and not isNil(var_589_0) then
					local var_589_4 = Mathf.Lerp(0, 0.5, var_589_3)

					arg_586_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_586_1.var_.characterEffect1047ui_story.fillRatio = var_589_4
				end
			end

			if arg_586_1.time_ >= var_589_1 + var_589_2 and arg_586_1.time_ < var_589_1 + var_589_2 + arg_589_0 and not isNil(var_589_0) and arg_586_1.var_.characterEffect1047ui_story then
				local var_589_5 = 0.5

				arg_586_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_586_1.var_.characterEffect1047ui_story.fillRatio = var_589_5
			end

			local var_589_6 = arg_586_1.actors_["1047ui_story"].transform
			local var_589_7 = 0

			if var_589_7 < arg_586_1.time_ and arg_586_1.time_ <= var_589_7 + arg_589_0 then
				arg_586_1.var_.moveOldPos1047ui_story = var_589_6.localPosition
			end

			local var_589_8 = 0.001

			if var_589_7 <= arg_586_1.time_ and arg_586_1.time_ < var_589_7 + var_589_8 then
				local var_589_9 = (arg_586_1.time_ - var_589_7) / var_589_8
				local var_589_10 = Vector3.New(0, 100, 0)

				var_589_6.localPosition = Vector3.Lerp(arg_586_1.var_.moveOldPos1047ui_story, var_589_10, var_589_9)

				local var_589_11 = manager.ui.mainCamera.transform.position - var_589_6.position

				var_589_6.forward = Vector3.New(var_589_11.x, var_589_11.y, var_589_11.z)

				local var_589_12 = var_589_6.localEulerAngles

				var_589_12.z = 0
				var_589_12.x = 0
				var_589_6.localEulerAngles = var_589_12
			end

			if arg_586_1.time_ >= var_589_7 + var_589_8 and arg_586_1.time_ < var_589_7 + var_589_8 + arg_589_0 then
				var_589_6.localPosition = Vector3.New(0, 100, 0)

				local var_589_13 = manager.ui.mainCamera.transform.position - var_589_6.position

				var_589_6.forward = Vector3.New(var_589_13.x, var_589_13.y, var_589_13.z)

				local var_589_14 = var_589_6.localEulerAngles

				var_589_14.z = 0
				var_589_14.x = 0
				var_589_6.localEulerAngles = var_589_14
			end

			local var_589_15 = 0
			local var_589_16 = 0.55

			if var_589_15 < arg_586_1.time_ and arg_586_1.time_ <= var_589_15 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, true)

				local var_589_17 = arg_586_1:FormatText(StoryNameCfg[7].name)

				arg_586_1.leftNameTxt_.text = var_589_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_586_1.leftNameTxt_.transform)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1.leftNameTxt_.text)
				SetActive(arg_586_1.iconTrs_.gameObject, true)
				arg_586_1.iconController_:SetSelectedState("hero")

				arg_586_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_586_1.callingController_:SetSelectedState("normal")

				arg_586_1.keyicon_.color = Color.New(1, 1, 1)
				arg_586_1.icon_.color = Color.New(1, 1, 1)

				local var_589_18 = arg_586_1:GetWordFromCfg(1104701145)
				local var_589_19 = arg_586_1:FormatText(var_589_18.content)

				arg_586_1.text_.text = var_589_19

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_20 = 22
				local var_589_21 = utf8.len(var_589_19)
				local var_589_22 = var_589_20 <= 0 and var_589_16 or var_589_16 * (var_589_21 / var_589_20)

				if var_589_22 > 0 and var_589_16 < var_589_22 then
					arg_586_1.talkMaxDuration = var_589_22

					if var_589_22 + var_589_15 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_22 + var_589_15
					end
				end

				arg_586_1.text_.text = var_589_19
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)
				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_23 = math.max(var_589_16, arg_586_1.talkMaxDuration)

			if var_589_15 <= arg_586_1.time_ and arg_586_1.time_ < var_589_15 + var_589_23 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - var_589_15) / var_589_23

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= var_589_15 + var_589_23 and arg_586_1.time_ < var_589_15 + var_589_23 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_586_1:InitPlayNodeList()
	end,
	Play1104701146 = function(arg_590_0, arg_590_1)
		arg_590_1.time_ = 0
		arg_590_1.frameCnt_ = 0
		arg_590_1.state_ = "playing"
		arg_590_1.curTalkId_ = 1104701146
		arg_590_1.duration_ = 5

		SetActive(arg_590_1.tipsGo_, false)

		function arg_590_1.onSingleLineFinish_()
			arg_590_1.onSingleLineUpdate_ = nil
			arg_590_1.onSingleLineFinish_ = nil
			arg_590_1.state_ = "waiting"
		end

		function arg_590_1.playNext_(arg_592_0)
			if arg_592_0 == 1 then
				arg_590_0:Play1104701147(arg_590_1)
			end
		end

		function arg_590_1.onSingleLineUpdate_(arg_593_0)
			local var_593_0 = 0
			local var_593_1 = 1.525

			if var_593_0 < arg_590_1.time_ and arg_590_1.time_ <= var_593_0 + arg_593_0 then
				arg_590_1.talkMaxDuration = 0
				arg_590_1.dialogCg_.alpha = 1

				arg_590_1.dialog_:SetActive(true)
				SetActive(arg_590_1.leftNameGo_, false)

				arg_590_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_590_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_590_1:RecordName(arg_590_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_590_1.iconTrs_.gameObject, false)
				arg_590_1.callingController_:SetSelectedState("normal")

				local var_593_2 = arg_590_1:GetWordFromCfg(1104701146)
				local var_593_3 = arg_590_1:FormatText(var_593_2.content)

				arg_590_1.text_.text = var_593_3

				LuaForUtil.ClearLinePrefixSymbol(arg_590_1.text_)

				local var_593_4 = 61
				local var_593_5 = utf8.len(var_593_3)
				local var_593_6 = var_593_4 <= 0 and var_593_1 or var_593_1 * (var_593_5 / var_593_4)

				if var_593_6 > 0 and var_593_1 < var_593_6 then
					arg_590_1.talkMaxDuration = var_593_6

					if var_593_6 + var_593_0 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_6 + var_593_0
					end
				end

				arg_590_1.text_.text = var_593_3
				arg_590_1.typewritter.percent = 0

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(false)
				arg_590_1:RecordContent(arg_590_1.text_.text)
			end

			local var_593_7 = math.max(var_593_1, arg_590_1.talkMaxDuration)

			if var_593_0 <= arg_590_1.time_ and arg_590_1.time_ < var_593_0 + var_593_7 then
				arg_590_1.typewritter.percent = (arg_590_1.time_ - var_593_0) / var_593_7

				arg_590_1.typewritter:SetDirty()
			end

			if arg_590_1.time_ >= var_593_0 + var_593_7 and arg_590_1.time_ < var_593_0 + var_593_7 + arg_593_0 then
				arg_590_1.typewritter.percent = 1

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(true)
			end
		end

		arg_590_1.nodeConfigList_ = {}

		arg_590_1:InitPlayNodeList()
	end,
	Play1104701147 = function(arg_594_0, arg_594_1)
		arg_594_1.time_ = 0
		arg_594_1.frameCnt_ = 0
		arg_594_1.state_ = "playing"
		arg_594_1.curTalkId_ = 1104701147
		arg_594_1.duration_ = 1

		SetActive(arg_594_1.tipsGo_, false)

		function arg_594_1.onSingleLineFinish_()
			arg_594_1.onSingleLineUpdate_ = nil
			arg_594_1.onSingleLineFinish_ = nil
			arg_594_1.state_ = "waiting"
		end

		function arg_594_1.playNext_(arg_596_0)
			if arg_596_0 == 1 then
				arg_594_0:Play1104701148(arg_594_1)
			end
		end

		function arg_594_1.onSingleLineUpdate_(arg_597_0)
			local var_597_0 = 0
			local var_597_1 = 0.05

			if var_597_0 < arg_594_1.time_ and arg_594_1.time_ <= var_597_0 + arg_597_0 then
				arg_594_1.talkMaxDuration = 0
				arg_594_1.dialogCg_.alpha = 1

				arg_594_1.dialog_:SetActive(true)
				SetActive(arg_594_1.leftNameGo_, true)

				local var_597_2 = arg_594_1:FormatText(StoryNameCfg[1517].name)

				arg_594_1.leftNameTxt_.text = var_597_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_594_1.leftNameTxt_.transform)

				arg_594_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_594_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_594_1:RecordName(arg_594_1.leftNameTxt_.text)
				SetActive(arg_594_1.iconTrs_.gameObject, true)
				arg_594_1.iconController_:SetSelectedState("hero")

				arg_594_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_594_1.callingController_:SetSelectedState("normal")

				arg_594_1.keyicon_.color = Color.New(1, 1, 1)
				arg_594_1.icon_.color = Color.New(1, 1, 1)

				local var_597_3 = arg_594_1:GetWordFromCfg(1104701147)
				local var_597_4 = arg_594_1:FormatText(var_597_3.content)

				arg_594_1.text_.text = var_597_4

				LuaForUtil.ClearLinePrefixSymbol(arg_594_1.text_)

				local var_597_5 = 2
				local var_597_6 = utf8.len(var_597_4)
				local var_597_7 = var_597_5 <= 0 and var_597_1 or var_597_1 * (var_597_6 / var_597_5)

				if var_597_7 > 0 and var_597_1 < var_597_7 then
					arg_594_1.talkMaxDuration = var_597_7

					if var_597_7 + var_597_0 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_7 + var_597_0
					end
				end

				arg_594_1.text_.text = var_597_4
				arg_594_1.typewritter.percent = 0

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701147", "story_v_side_new_1104701.awb") ~= 0 then
					local var_597_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701147", "story_v_side_new_1104701.awb") / 1000

					if var_597_8 + var_597_0 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_8 + var_597_0
					end

					if var_597_3.prefab_name ~= "" and arg_594_1.actors_[var_597_3.prefab_name] ~= nil then
						local var_597_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_594_1.actors_[var_597_3.prefab_name].transform, "story_v_side_new_1104701", "1104701147", "story_v_side_new_1104701.awb")

						arg_594_1:RecordAudio("1104701147", var_597_9)
						arg_594_1:RecordAudio("1104701147", var_597_9)
					else
						arg_594_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701147", "story_v_side_new_1104701.awb")
					end

					arg_594_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701147", "story_v_side_new_1104701.awb")
				end

				arg_594_1:RecordContent(arg_594_1.text_.text)
			end

			local var_597_10 = math.max(var_597_1, arg_594_1.talkMaxDuration)

			if var_597_0 <= arg_594_1.time_ and arg_594_1.time_ < var_597_0 + var_597_10 then
				arg_594_1.typewritter.percent = (arg_594_1.time_ - var_597_0) / var_597_10

				arg_594_1.typewritter:SetDirty()
			end

			if arg_594_1.time_ >= var_597_0 + var_597_10 and arg_594_1.time_ < var_597_0 + var_597_10 + arg_597_0 then
				arg_594_1.typewritter.percent = 1

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(true)
			end
		end

		arg_594_1.nodeConfigList_ = {}

		arg_594_1:InitPlayNodeList()
	end,
	Play1104701148 = function(arg_598_0, arg_598_1)
		arg_598_1.time_ = 0
		arg_598_1.frameCnt_ = 0
		arg_598_1.state_ = "playing"
		arg_598_1.curTalkId_ = 1104701148
		arg_598_1.duration_ = 10.77

		SetActive(arg_598_1.tipsGo_, false)

		function arg_598_1.onSingleLineFinish_()
			arg_598_1.onSingleLineUpdate_ = nil
			arg_598_1.onSingleLineFinish_ = nil
			arg_598_1.state_ = "waiting"
		end

		function arg_598_1.playNext_(arg_600_0)
			if arg_600_0 == 1 then
				arg_598_0:Play1104701149(arg_598_1)
			end
		end

		function arg_598_1.onSingleLineUpdate_(arg_601_0)
			local var_601_0 = arg_598_1.actors_["1047ui_story"].transform
			local var_601_1 = 0

			if var_601_1 < arg_598_1.time_ and arg_598_1.time_ <= var_601_1 + arg_601_0 then
				arg_598_1.var_.moveOldPos1047ui_story = var_601_0.localPosition
			end

			local var_601_2 = 0.001

			if var_601_1 <= arg_598_1.time_ and arg_598_1.time_ < var_601_1 + var_601_2 then
				local var_601_3 = (arg_598_1.time_ - var_601_1) / var_601_2
				local var_601_4 = Vector3.New(0, -1.13, -6.2)

				var_601_0.localPosition = Vector3.Lerp(arg_598_1.var_.moveOldPos1047ui_story, var_601_4, var_601_3)

				local var_601_5 = manager.ui.mainCamera.transform.position - var_601_0.position

				var_601_0.forward = Vector3.New(var_601_5.x, var_601_5.y, var_601_5.z)

				local var_601_6 = var_601_0.localEulerAngles

				var_601_6.z = 0
				var_601_6.x = 0
				var_601_0.localEulerAngles = var_601_6
			end

			if arg_598_1.time_ >= var_601_1 + var_601_2 and arg_598_1.time_ < var_601_1 + var_601_2 + arg_601_0 then
				var_601_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_601_7 = manager.ui.mainCamera.transform.position - var_601_0.position

				var_601_0.forward = Vector3.New(var_601_7.x, var_601_7.y, var_601_7.z)

				local var_601_8 = var_601_0.localEulerAngles

				var_601_8.z = 0
				var_601_8.x = 0
				var_601_0.localEulerAngles = var_601_8
			end

			local var_601_9 = arg_598_1.actors_["1047ui_story"]
			local var_601_10 = 0

			if var_601_10 < arg_598_1.time_ and arg_598_1.time_ <= var_601_10 + arg_601_0 and not isNil(var_601_9) and arg_598_1.var_.characterEffect1047ui_story == nil then
				arg_598_1.var_.characterEffect1047ui_story = var_601_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_601_11 = 0.200000002980232

			if var_601_10 <= arg_598_1.time_ and arg_598_1.time_ < var_601_10 + var_601_11 and not isNil(var_601_9) then
				local var_601_12 = (arg_598_1.time_ - var_601_10) / var_601_11

				if arg_598_1.var_.characterEffect1047ui_story and not isNil(var_601_9) then
					arg_598_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_598_1.time_ >= var_601_10 + var_601_11 and arg_598_1.time_ < var_601_10 + var_601_11 + arg_601_0 and not isNil(var_601_9) and arg_598_1.var_.characterEffect1047ui_story then
				arg_598_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_601_13 = 0

			if var_601_13 < arg_598_1.time_ and arg_598_1.time_ <= var_601_13 + arg_601_0 then
				arg_598_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_601_14 = 0

			if var_601_14 < arg_598_1.time_ and arg_598_1.time_ <= var_601_14 + arg_601_0 then
				arg_598_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_601_15 = 0
			local var_601_16 = 1.225

			if var_601_15 < arg_598_1.time_ and arg_598_1.time_ <= var_601_15 + arg_601_0 then
				arg_598_1.talkMaxDuration = 0
				arg_598_1.dialogCg_.alpha = 1

				arg_598_1.dialog_:SetActive(true)
				SetActive(arg_598_1.leftNameGo_, true)

				local var_601_17 = arg_598_1:FormatText(StoryNameCfg[1296].name)

				arg_598_1.leftNameTxt_.text = var_601_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_598_1.leftNameTxt_.transform)

				arg_598_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_598_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_598_1:RecordName(arg_598_1.leftNameTxt_.text)
				SetActive(arg_598_1.iconTrs_.gameObject, false)
				arg_598_1.callingController_:SetSelectedState("normal")

				local var_601_18 = arg_598_1:GetWordFromCfg(1104701148)
				local var_601_19 = arg_598_1:FormatText(var_601_18.content)

				arg_598_1.text_.text = var_601_19

				LuaForUtil.ClearLinePrefixSymbol(arg_598_1.text_)

				local var_601_20 = 49
				local var_601_21 = utf8.len(var_601_19)
				local var_601_22 = var_601_20 <= 0 and var_601_16 or var_601_16 * (var_601_21 / var_601_20)

				if var_601_22 > 0 and var_601_16 < var_601_22 then
					arg_598_1.talkMaxDuration = var_601_22

					if var_601_22 + var_601_15 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_22 + var_601_15
					end
				end

				arg_598_1.text_.text = var_601_19
				arg_598_1.typewritter.percent = 0

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701148", "story_v_side_new_1104701.awb") ~= 0 then
					local var_601_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701148", "story_v_side_new_1104701.awb") / 1000

					if var_601_23 + var_601_15 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_23 + var_601_15
					end

					if var_601_18.prefab_name ~= "" and arg_598_1.actors_[var_601_18.prefab_name] ~= nil then
						local var_601_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_598_1.actors_[var_601_18.prefab_name].transform, "story_v_side_new_1104701", "1104701148", "story_v_side_new_1104701.awb")

						arg_598_1:RecordAudio("1104701148", var_601_24)
						arg_598_1:RecordAudio("1104701148", var_601_24)
					else
						arg_598_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701148", "story_v_side_new_1104701.awb")
					end

					arg_598_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701148", "story_v_side_new_1104701.awb")
				end

				arg_598_1:RecordContent(arg_598_1.text_.text)
			end

			local var_601_25 = math.max(var_601_16, arg_598_1.talkMaxDuration)

			if var_601_15 <= arg_598_1.time_ and arg_598_1.time_ < var_601_15 + var_601_25 then
				arg_598_1.typewritter.percent = (arg_598_1.time_ - var_601_15) / var_601_25

				arg_598_1.typewritter:SetDirty()
			end

			if arg_598_1.time_ >= var_601_15 + var_601_25 and arg_598_1.time_ < var_601_15 + var_601_25 + arg_601_0 then
				arg_598_1.typewritter.percent = 1

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(true)
			end
		end

		arg_598_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_598_1:InitPlayNodeList()
	end,
	Play1104701149 = function(arg_602_0, arg_602_1)
		arg_602_1.time_ = 0
		arg_602_1.frameCnt_ = 0
		arg_602_1.state_ = "playing"
		arg_602_1.curTalkId_ = 1104701149
		arg_602_1.duration_ = 8.1

		SetActive(arg_602_1.tipsGo_, false)

		function arg_602_1.onSingleLineFinish_()
			arg_602_1.onSingleLineUpdate_ = nil
			arg_602_1.onSingleLineFinish_ = nil
			arg_602_1.state_ = "waiting"
		end

		function arg_602_1.playNext_(arg_604_0)
			if arg_604_0 == 1 then
				arg_602_0:Play1104701150(arg_602_1)
			end
		end

		function arg_602_1.onSingleLineUpdate_(arg_605_0)
			local var_605_0 = arg_602_1.actors_["1047ui_story"].transform
			local var_605_1 = 0

			if var_605_1 < arg_602_1.time_ and arg_602_1.time_ <= var_605_1 + arg_605_0 then
				arg_602_1.var_.moveOldPos1047ui_story = var_605_0.localPosition
			end

			local var_605_2 = 0.001

			if var_605_1 <= arg_602_1.time_ and arg_602_1.time_ < var_605_1 + var_605_2 then
				local var_605_3 = (arg_602_1.time_ - var_605_1) / var_605_2
				local var_605_4 = Vector3.New(0, -1.13, -6.2)

				var_605_0.localPosition = Vector3.Lerp(arg_602_1.var_.moveOldPos1047ui_story, var_605_4, var_605_3)

				local var_605_5 = manager.ui.mainCamera.transform.position - var_605_0.position

				var_605_0.forward = Vector3.New(var_605_5.x, var_605_5.y, var_605_5.z)

				local var_605_6 = var_605_0.localEulerAngles

				var_605_6.z = 0
				var_605_6.x = 0
				var_605_0.localEulerAngles = var_605_6
			end

			if arg_602_1.time_ >= var_605_1 + var_605_2 and arg_602_1.time_ < var_605_1 + var_605_2 + arg_605_0 then
				var_605_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_605_7 = manager.ui.mainCamera.transform.position - var_605_0.position

				var_605_0.forward = Vector3.New(var_605_7.x, var_605_7.y, var_605_7.z)

				local var_605_8 = var_605_0.localEulerAngles

				var_605_8.z = 0
				var_605_8.x = 0
				var_605_0.localEulerAngles = var_605_8
			end

			local var_605_9 = 0

			if var_605_9 < arg_602_1.time_ and arg_602_1.time_ <= var_605_9 + arg_605_0 then
				arg_602_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			local var_605_10 = 0

			if var_605_10 < arg_602_1.time_ and arg_602_1.time_ <= var_605_10 + arg_605_0 then
				arg_602_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_605_11 = 0
			local var_605_12 = 0.825

			if var_605_11 < arg_602_1.time_ and arg_602_1.time_ <= var_605_11 + arg_605_0 then
				arg_602_1.talkMaxDuration = 0
				arg_602_1.dialogCg_.alpha = 1

				arg_602_1.dialog_:SetActive(true)
				SetActive(arg_602_1.leftNameGo_, true)

				local var_605_13 = arg_602_1:FormatText(StoryNameCfg[1296].name)

				arg_602_1.leftNameTxt_.text = var_605_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_602_1.leftNameTxt_.transform)

				arg_602_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_602_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_602_1:RecordName(arg_602_1.leftNameTxt_.text)
				SetActive(arg_602_1.iconTrs_.gameObject, false)
				arg_602_1.callingController_:SetSelectedState("normal")

				local var_605_14 = arg_602_1:GetWordFromCfg(1104701149)
				local var_605_15 = arg_602_1:FormatText(var_605_14.content)

				arg_602_1.text_.text = var_605_15

				LuaForUtil.ClearLinePrefixSymbol(arg_602_1.text_)

				local var_605_16 = 33
				local var_605_17 = utf8.len(var_605_15)
				local var_605_18 = var_605_16 <= 0 and var_605_12 or var_605_12 * (var_605_17 / var_605_16)

				if var_605_18 > 0 and var_605_12 < var_605_18 then
					arg_602_1.talkMaxDuration = var_605_18

					if var_605_18 + var_605_11 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_18 + var_605_11
					end
				end

				arg_602_1.text_.text = var_605_15
				arg_602_1.typewritter.percent = 0

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701149", "story_v_side_new_1104701.awb") ~= 0 then
					local var_605_19 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701149", "story_v_side_new_1104701.awb") / 1000

					if var_605_19 + var_605_11 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_19 + var_605_11
					end

					if var_605_14.prefab_name ~= "" and arg_602_1.actors_[var_605_14.prefab_name] ~= nil then
						local var_605_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_602_1.actors_[var_605_14.prefab_name].transform, "story_v_side_new_1104701", "1104701149", "story_v_side_new_1104701.awb")

						arg_602_1:RecordAudio("1104701149", var_605_20)
						arg_602_1:RecordAudio("1104701149", var_605_20)
					else
						arg_602_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701149", "story_v_side_new_1104701.awb")
					end

					arg_602_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701149", "story_v_side_new_1104701.awb")
				end

				arg_602_1:RecordContent(arg_602_1.text_.text)
			end

			local var_605_21 = math.max(var_605_12, arg_602_1.talkMaxDuration)

			if var_605_11 <= arg_602_1.time_ and arg_602_1.time_ < var_605_11 + var_605_21 then
				arg_602_1.typewritter.percent = (arg_602_1.time_ - var_605_11) / var_605_21

				arg_602_1.typewritter:SetDirty()
			end

			if arg_602_1.time_ >= var_605_11 + var_605_21 and arg_602_1.time_ < var_605_11 + var_605_21 + arg_605_0 then
				arg_602_1.typewritter.percent = 1

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(true)
			end
		end

		arg_602_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_602_1:InitPlayNodeList()
	end,
	Play1104701150 = function(arg_606_0, arg_606_1)
		arg_606_1.time_ = 0
		arg_606_1.frameCnt_ = 0
		arg_606_1.state_ = "playing"
		arg_606_1.curTalkId_ = 1104701150
		arg_606_1.duration_ = 2.37

		SetActive(arg_606_1.tipsGo_, false)

		function arg_606_1.onSingleLineFinish_()
			arg_606_1.onSingleLineUpdate_ = nil
			arg_606_1.onSingleLineFinish_ = nil
			arg_606_1.state_ = "waiting"
		end

		function arg_606_1.playNext_(arg_608_0)
			if arg_608_0 == 1 then
				arg_606_0:Play1104701151(arg_606_1)
			end
		end

		function arg_606_1.onSingleLineUpdate_(arg_609_0)
			local var_609_0 = arg_606_1.actors_["1047ui_story"]
			local var_609_1 = 0

			if var_609_1 < arg_606_1.time_ and arg_606_1.time_ <= var_609_1 + arg_609_0 and not isNil(var_609_0) and arg_606_1.var_.characterEffect1047ui_story == nil then
				arg_606_1.var_.characterEffect1047ui_story = var_609_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_609_2 = 0.200000002980232

			if var_609_1 <= arg_606_1.time_ and arg_606_1.time_ < var_609_1 + var_609_2 and not isNil(var_609_0) then
				local var_609_3 = (arg_606_1.time_ - var_609_1) / var_609_2

				if arg_606_1.var_.characterEffect1047ui_story and not isNil(var_609_0) then
					local var_609_4 = Mathf.Lerp(0, 0.5, var_609_3)

					arg_606_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_606_1.var_.characterEffect1047ui_story.fillRatio = var_609_4
				end
			end

			if arg_606_1.time_ >= var_609_1 + var_609_2 and arg_606_1.time_ < var_609_1 + var_609_2 + arg_609_0 and not isNil(var_609_0) and arg_606_1.var_.characterEffect1047ui_story then
				local var_609_5 = 0.5

				arg_606_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_606_1.var_.characterEffect1047ui_story.fillRatio = var_609_5
			end

			local var_609_6 = arg_606_1.actors_["1047ui_story"].transform
			local var_609_7 = 0

			if var_609_7 < arg_606_1.time_ and arg_606_1.time_ <= var_609_7 + arg_609_0 then
				arg_606_1.var_.moveOldPos1047ui_story = var_609_6.localPosition
			end

			local var_609_8 = 0.001

			if var_609_7 <= arg_606_1.time_ and arg_606_1.time_ < var_609_7 + var_609_8 then
				local var_609_9 = (arg_606_1.time_ - var_609_7) / var_609_8
				local var_609_10 = Vector3.New(0, 100, 0)

				var_609_6.localPosition = Vector3.Lerp(arg_606_1.var_.moveOldPos1047ui_story, var_609_10, var_609_9)

				local var_609_11 = manager.ui.mainCamera.transform.position - var_609_6.position

				var_609_6.forward = Vector3.New(var_609_11.x, var_609_11.y, var_609_11.z)

				local var_609_12 = var_609_6.localEulerAngles

				var_609_12.z = 0
				var_609_12.x = 0
				var_609_6.localEulerAngles = var_609_12
			end

			if arg_606_1.time_ >= var_609_7 + var_609_8 and arg_606_1.time_ < var_609_7 + var_609_8 + arg_609_0 then
				var_609_6.localPosition = Vector3.New(0, 100, 0)

				local var_609_13 = manager.ui.mainCamera.transform.position - var_609_6.position

				var_609_6.forward = Vector3.New(var_609_13.x, var_609_13.y, var_609_13.z)

				local var_609_14 = var_609_6.localEulerAngles

				var_609_14.z = 0
				var_609_14.x = 0
				var_609_6.localEulerAngles = var_609_14
			end

			local var_609_15 = 0
			local var_609_16 = 0.25

			if var_609_15 < arg_606_1.time_ and arg_606_1.time_ <= var_609_15 + arg_609_0 then
				arg_606_1.talkMaxDuration = 0
				arg_606_1.dialogCg_.alpha = 1

				arg_606_1.dialog_:SetActive(true)
				SetActive(arg_606_1.leftNameGo_, true)

				local var_609_17 = arg_606_1:FormatText(StoryNameCfg[1517].name)

				arg_606_1.leftNameTxt_.text = var_609_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_606_1.leftNameTxt_.transform)

				arg_606_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_606_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_606_1:RecordName(arg_606_1.leftNameTxt_.text)
				SetActive(arg_606_1.iconTrs_.gameObject, true)
				arg_606_1.iconController_:SetSelectedState("hero")

				arg_606_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_606_1.callingController_:SetSelectedState("normal")

				arg_606_1.keyicon_.color = Color.New(1, 1, 1)
				arg_606_1.icon_.color = Color.New(1, 1, 1)

				local var_609_18 = arg_606_1:GetWordFromCfg(1104701150)
				local var_609_19 = arg_606_1:FormatText(var_609_18.content)

				arg_606_1.text_.text = var_609_19

				LuaForUtil.ClearLinePrefixSymbol(arg_606_1.text_)

				local var_609_20 = 10
				local var_609_21 = utf8.len(var_609_19)
				local var_609_22 = var_609_20 <= 0 and var_609_16 or var_609_16 * (var_609_21 / var_609_20)

				if var_609_22 > 0 and var_609_16 < var_609_22 then
					arg_606_1.talkMaxDuration = var_609_22

					if var_609_22 + var_609_15 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_22 + var_609_15
					end
				end

				arg_606_1.text_.text = var_609_19
				arg_606_1.typewritter.percent = 0

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701150", "story_v_side_new_1104701.awb") ~= 0 then
					local var_609_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701150", "story_v_side_new_1104701.awb") / 1000

					if var_609_23 + var_609_15 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_23 + var_609_15
					end

					if var_609_18.prefab_name ~= "" and arg_606_1.actors_[var_609_18.prefab_name] ~= nil then
						local var_609_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_606_1.actors_[var_609_18.prefab_name].transform, "story_v_side_new_1104701", "1104701150", "story_v_side_new_1104701.awb")

						arg_606_1:RecordAudio("1104701150", var_609_24)
						arg_606_1:RecordAudio("1104701150", var_609_24)
					else
						arg_606_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701150", "story_v_side_new_1104701.awb")
					end

					arg_606_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701150", "story_v_side_new_1104701.awb")
				end

				arg_606_1:RecordContent(arg_606_1.text_.text)
			end

			local var_609_25 = math.max(var_609_16, arg_606_1.talkMaxDuration)

			if var_609_15 <= arg_606_1.time_ and arg_606_1.time_ < var_609_15 + var_609_25 then
				arg_606_1.typewritter.percent = (arg_606_1.time_ - var_609_15) / var_609_25

				arg_606_1.typewritter:SetDirty()
			end

			if arg_606_1.time_ >= var_609_15 + var_609_25 and arg_606_1.time_ < var_609_15 + var_609_25 + arg_609_0 then
				arg_606_1.typewritter.percent = 1

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(true)
			end
		end

		arg_606_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_606_1:InitPlayNodeList()
	end,
	Play1104701151 = function(arg_610_0, arg_610_1)
		arg_610_1.time_ = 0
		arg_610_1.frameCnt_ = 0
		arg_610_1.state_ = "playing"
		arg_610_1.curTalkId_ = 1104701151
		arg_610_1.duration_ = 5

		SetActive(arg_610_1.tipsGo_, false)

		function arg_610_1.onSingleLineFinish_()
			arg_610_1.onSingleLineUpdate_ = nil
			arg_610_1.onSingleLineFinish_ = nil
			arg_610_1.state_ = "waiting"
		end

		function arg_610_1.playNext_(arg_612_0)
			if arg_612_0 == 1 then
				arg_610_0:Play1104701152(arg_610_1)
			end
		end

		function arg_610_1.onSingleLineUpdate_(arg_613_0)
			local var_613_0 = 0
			local var_613_1 = 0.625

			if var_613_0 < arg_610_1.time_ and arg_610_1.time_ <= var_613_0 + arg_613_0 then
				arg_610_1.talkMaxDuration = 0
				arg_610_1.dialogCg_.alpha = 1

				arg_610_1.dialog_:SetActive(true)
				SetActive(arg_610_1.leftNameGo_, false)

				arg_610_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_610_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_610_1:RecordName(arg_610_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_610_1.iconTrs_.gameObject, false)
				arg_610_1.callingController_:SetSelectedState("normal")

				local var_613_2 = arg_610_1:GetWordFromCfg(1104701151)
				local var_613_3 = arg_610_1:FormatText(var_613_2.content)

				arg_610_1.text_.text = var_613_3

				LuaForUtil.ClearLinePrefixSymbol(arg_610_1.text_)

				local var_613_4 = 25
				local var_613_5 = utf8.len(var_613_3)
				local var_613_6 = var_613_4 <= 0 and var_613_1 or var_613_1 * (var_613_5 / var_613_4)

				if var_613_6 > 0 and var_613_1 < var_613_6 then
					arg_610_1.talkMaxDuration = var_613_6

					if var_613_6 + var_613_0 > arg_610_1.duration_ then
						arg_610_1.duration_ = var_613_6 + var_613_0
					end
				end

				arg_610_1.text_.text = var_613_3
				arg_610_1.typewritter.percent = 0

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(false)
				arg_610_1:RecordContent(arg_610_1.text_.text)
			end

			local var_613_7 = math.max(var_613_1, arg_610_1.talkMaxDuration)

			if var_613_0 <= arg_610_1.time_ and arg_610_1.time_ < var_613_0 + var_613_7 then
				arg_610_1.typewritter.percent = (arg_610_1.time_ - var_613_0) / var_613_7

				arg_610_1.typewritter:SetDirty()
			end

			if arg_610_1.time_ >= var_613_0 + var_613_7 and arg_610_1.time_ < var_613_0 + var_613_7 + arg_613_0 then
				arg_610_1.typewritter.percent = 1

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(true)
			end
		end

		arg_610_1.nodeConfigList_ = {}

		arg_610_1:InitPlayNodeList()
	end,
	Play1104701152 = function(arg_614_0, arg_614_1)
		arg_614_1.time_ = 0
		arg_614_1.frameCnt_ = 0
		arg_614_1.state_ = "playing"
		arg_614_1.curTalkId_ = 1104701152
		arg_614_1.duration_ = 3.03

		SetActive(arg_614_1.tipsGo_, false)

		function arg_614_1.onSingleLineFinish_()
			arg_614_1.onSingleLineUpdate_ = nil
			arg_614_1.onSingleLineFinish_ = nil
			arg_614_1.state_ = "waiting"
		end

		function arg_614_1.playNext_(arg_616_0)
			if arg_616_0 == 1 then
				arg_614_0:Play1104701153(arg_614_1)
			end
		end

		function arg_614_1.onSingleLineUpdate_(arg_617_0)
			local var_617_0 = 0
			local var_617_1 = 0.35

			if var_617_0 < arg_614_1.time_ and arg_614_1.time_ <= var_617_0 + arg_617_0 then
				arg_614_1.talkMaxDuration = 0
				arg_614_1.dialogCg_.alpha = 1

				arg_614_1.dialog_:SetActive(true)
				SetActive(arg_614_1.leftNameGo_, true)

				local var_617_2 = arg_614_1:FormatText(StoryNameCfg[1517].name)

				arg_614_1.leftNameTxt_.text = var_617_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_614_1.leftNameTxt_.transform)

				arg_614_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_614_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_614_1:RecordName(arg_614_1.leftNameTxt_.text)
				SetActive(arg_614_1.iconTrs_.gameObject, true)
				arg_614_1.iconController_:SetSelectedState("hero")

				arg_614_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_614_1.callingController_:SetSelectedState("normal")

				arg_614_1.keyicon_.color = Color.New(1, 1, 1)
				arg_614_1.icon_.color = Color.New(1, 1, 1)

				local var_617_3 = arg_614_1:GetWordFromCfg(1104701152)
				local var_617_4 = arg_614_1:FormatText(var_617_3.content)

				arg_614_1.text_.text = var_617_4

				LuaForUtil.ClearLinePrefixSymbol(arg_614_1.text_)

				local var_617_5 = 14
				local var_617_6 = utf8.len(var_617_4)
				local var_617_7 = var_617_5 <= 0 and var_617_1 or var_617_1 * (var_617_6 / var_617_5)

				if var_617_7 > 0 and var_617_1 < var_617_7 then
					arg_614_1.talkMaxDuration = var_617_7

					if var_617_7 + var_617_0 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_7 + var_617_0
					end
				end

				arg_614_1.text_.text = var_617_4
				arg_614_1.typewritter.percent = 0

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701152", "story_v_side_new_1104701.awb") ~= 0 then
					local var_617_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701152", "story_v_side_new_1104701.awb") / 1000

					if var_617_8 + var_617_0 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_8 + var_617_0
					end

					if var_617_3.prefab_name ~= "" and arg_614_1.actors_[var_617_3.prefab_name] ~= nil then
						local var_617_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_614_1.actors_[var_617_3.prefab_name].transform, "story_v_side_new_1104701", "1104701152", "story_v_side_new_1104701.awb")

						arg_614_1:RecordAudio("1104701152", var_617_9)
						arg_614_1:RecordAudio("1104701152", var_617_9)
					else
						arg_614_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701152", "story_v_side_new_1104701.awb")
					end

					arg_614_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701152", "story_v_side_new_1104701.awb")
				end

				arg_614_1:RecordContent(arg_614_1.text_.text)
			end

			local var_617_10 = math.max(var_617_1, arg_614_1.talkMaxDuration)

			if var_617_0 <= arg_614_1.time_ and arg_614_1.time_ < var_617_0 + var_617_10 then
				arg_614_1.typewritter.percent = (arg_614_1.time_ - var_617_0) / var_617_10

				arg_614_1.typewritter:SetDirty()
			end

			if arg_614_1.time_ >= var_617_0 + var_617_10 and arg_614_1.time_ < var_617_0 + var_617_10 + arg_617_0 then
				arg_614_1.typewritter.percent = 1

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(true)
			end
		end

		arg_614_1.nodeConfigList_ = {}

		arg_614_1:InitPlayNodeList()
	end,
	Play1104701153 = function(arg_618_0, arg_618_1)
		arg_618_1.time_ = 0
		arg_618_1.frameCnt_ = 0
		arg_618_1.state_ = "playing"
		arg_618_1.curTalkId_ = 1104701153
		arg_618_1.duration_ = 6.07

		SetActive(arg_618_1.tipsGo_, false)

		function arg_618_1.onSingleLineFinish_()
			arg_618_1.onSingleLineUpdate_ = nil
			arg_618_1.onSingleLineFinish_ = nil
			arg_618_1.state_ = "waiting"
		end

		function arg_618_1.playNext_(arg_620_0)
			if arg_620_0 == 1 then
				arg_618_0:Play1104701154(arg_618_1)
			end
		end

		function arg_618_1.onSingleLineUpdate_(arg_621_0)
			local var_621_0 = arg_618_1.actors_["1047ui_story"].transform
			local var_621_1 = 0

			if var_621_1 < arg_618_1.time_ and arg_618_1.time_ <= var_621_1 + arg_621_0 then
				arg_618_1.var_.moveOldPos1047ui_story = var_621_0.localPosition
			end

			local var_621_2 = 0.001

			if var_621_1 <= arg_618_1.time_ and arg_618_1.time_ < var_621_1 + var_621_2 then
				local var_621_3 = (arg_618_1.time_ - var_621_1) / var_621_2
				local var_621_4 = Vector3.New(0, -1.13, -6.2)

				var_621_0.localPosition = Vector3.Lerp(arg_618_1.var_.moveOldPos1047ui_story, var_621_4, var_621_3)

				local var_621_5 = manager.ui.mainCamera.transform.position - var_621_0.position

				var_621_0.forward = Vector3.New(var_621_5.x, var_621_5.y, var_621_5.z)

				local var_621_6 = var_621_0.localEulerAngles

				var_621_6.z = 0
				var_621_6.x = 0
				var_621_0.localEulerAngles = var_621_6
			end

			if arg_618_1.time_ >= var_621_1 + var_621_2 and arg_618_1.time_ < var_621_1 + var_621_2 + arg_621_0 then
				var_621_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_621_7 = manager.ui.mainCamera.transform.position - var_621_0.position

				var_621_0.forward = Vector3.New(var_621_7.x, var_621_7.y, var_621_7.z)

				local var_621_8 = var_621_0.localEulerAngles

				var_621_8.z = 0
				var_621_8.x = 0
				var_621_0.localEulerAngles = var_621_8
			end

			local var_621_9 = arg_618_1.actors_["1047ui_story"]
			local var_621_10 = 0

			if var_621_10 < arg_618_1.time_ and arg_618_1.time_ <= var_621_10 + arg_621_0 and not isNil(var_621_9) and arg_618_1.var_.characterEffect1047ui_story == nil then
				arg_618_1.var_.characterEffect1047ui_story = var_621_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_621_11 = 0.200000002980232

			if var_621_10 <= arg_618_1.time_ and arg_618_1.time_ < var_621_10 + var_621_11 and not isNil(var_621_9) then
				local var_621_12 = (arg_618_1.time_ - var_621_10) / var_621_11

				if arg_618_1.var_.characterEffect1047ui_story and not isNil(var_621_9) then
					arg_618_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_618_1.time_ >= var_621_10 + var_621_11 and arg_618_1.time_ < var_621_10 + var_621_11 + arg_621_0 and not isNil(var_621_9) and arg_618_1.var_.characterEffect1047ui_story then
				arg_618_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_621_13 = 0

			if var_621_13 < arg_618_1.time_ and arg_618_1.time_ <= var_621_13 + arg_621_0 then
				arg_618_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			local var_621_14 = 0

			if var_621_14 < arg_618_1.time_ and arg_618_1.time_ <= var_621_14 + arg_621_0 then
				arg_618_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_621_15 = 0
			local var_621_16 = 0.725

			if var_621_15 < arg_618_1.time_ and arg_618_1.time_ <= var_621_15 + arg_621_0 then
				arg_618_1.talkMaxDuration = 0
				arg_618_1.dialogCg_.alpha = 1

				arg_618_1.dialog_:SetActive(true)
				SetActive(arg_618_1.leftNameGo_, true)

				local var_621_17 = arg_618_1:FormatText(StoryNameCfg[1296].name)

				arg_618_1.leftNameTxt_.text = var_621_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_618_1.leftNameTxt_.transform)

				arg_618_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_618_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_618_1:RecordName(arg_618_1.leftNameTxt_.text)
				SetActive(arg_618_1.iconTrs_.gameObject, false)
				arg_618_1.callingController_:SetSelectedState("normal")

				local var_621_18 = arg_618_1:GetWordFromCfg(1104701153)
				local var_621_19 = arg_618_1:FormatText(var_621_18.content)

				arg_618_1.text_.text = var_621_19

				LuaForUtil.ClearLinePrefixSymbol(arg_618_1.text_)

				local var_621_20 = 29
				local var_621_21 = utf8.len(var_621_19)
				local var_621_22 = var_621_20 <= 0 and var_621_16 or var_621_16 * (var_621_21 / var_621_20)

				if var_621_22 > 0 and var_621_16 < var_621_22 then
					arg_618_1.talkMaxDuration = var_621_22

					if var_621_22 + var_621_15 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_22 + var_621_15
					end
				end

				arg_618_1.text_.text = var_621_19
				arg_618_1.typewritter.percent = 0

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701153", "story_v_side_new_1104701.awb") ~= 0 then
					local var_621_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701153", "story_v_side_new_1104701.awb") / 1000

					if var_621_23 + var_621_15 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_23 + var_621_15
					end

					if var_621_18.prefab_name ~= "" and arg_618_1.actors_[var_621_18.prefab_name] ~= nil then
						local var_621_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_618_1.actors_[var_621_18.prefab_name].transform, "story_v_side_new_1104701", "1104701153", "story_v_side_new_1104701.awb")

						arg_618_1:RecordAudio("1104701153", var_621_24)
						arg_618_1:RecordAudio("1104701153", var_621_24)
					else
						arg_618_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701153", "story_v_side_new_1104701.awb")
					end

					arg_618_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701153", "story_v_side_new_1104701.awb")
				end

				arg_618_1:RecordContent(arg_618_1.text_.text)
			end

			local var_621_25 = math.max(var_621_16, arg_618_1.talkMaxDuration)

			if var_621_15 <= arg_618_1.time_ and arg_618_1.time_ < var_621_15 + var_621_25 then
				arg_618_1.typewritter.percent = (arg_618_1.time_ - var_621_15) / var_621_25

				arg_618_1.typewritter:SetDirty()
			end

			if arg_618_1.time_ >= var_621_15 + var_621_25 and arg_618_1.time_ < var_621_15 + var_621_25 + arg_621_0 then
				arg_618_1.typewritter.percent = 1

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(true)
			end
		end

		arg_618_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_618_1:InitPlayNodeList()
	end,
	Play1104701154 = function(arg_622_0, arg_622_1)
		arg_622_1.time_ = 0
		arg_622_1.frameCnt_ = 0
		arg_622_1.state_ = "playing"
		arg_622_1.curTalkId_ = 1104701154
		arg_622_1.duration_ = 1

		SetActive(arg_622_1.tipsGo_, false)

		function arg_622_1.onSingleLineFinish_()
			arg_622_1.onSingleLineUpdate_ = nil
			arg_622_1.onSingleLineFinish_ = nil
			arg_622_1.state_ = "waiting"
		end

		function arg_622_1.playNext_(arg_624_0)
			if arg_624_0 == 1 then
				arg_622_0:Play1104701155(arg_622_1)
			end
		end

		function arg_622_1.onSingleLineUpdate_(arg_625_0)
			local var_625_0 = arg_622_1.actors_["1047ui_story"]
			local var_625_1 = 0

			if var_625_1 < arg_622_1.time_ and arg_622_1.time_ <= var_625_1 + arg_625_0 and not isNil(var_625_0) and arg_622_1.var_.characterEffect1047ui_story == nil then
				arg_622_1.var_.characterEffect1047ui_story = var_625_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_625_2 = 0.200000002980232

			if var_625_1 <= arg_622_1.time_ and arg_622_1.time_ < var_625_1 + var_625_2 and not isNil(var_625_0) then
				local var_625_3 = (arg_622_1.time_ - var_625_1) / var_625_2

				if arg_622_1.var_.characterEffect1047ui_story and not isNil(var_625_0) then
					local var_625_4 = Mathf.Lerp(0, 0.5, var_625_3)

					arg_622_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_622_1.var_.characterEffect1047ui_story.fillRatio = var_625_4
				end
			end

			if arg_622_1.time_ >= var_625_1 + var_625_2 and arg_622_1.time_ < var_625_1 + var_625_2 + arg_625_0 and not isNil(var_625_0) and arg_622_1.var_.characterEffect1047ui_story then
				local var_625_5 = 0.5

				arg_622_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_622_1.var_.characterEffect1047ui_story.fillRatio = var_625_5
			end

			local var_625_6 = arg_622_1.actors_["1047ui_story"].transform
			local var_625_7 = 0

			if var_625_7 < arg_622_1.time_ and arg_622_1.time_ <= var_625_7 + arg_625_0 then
				arg_622_1.var_.moveOldPos1047ui_story = var_625_6.localPosition
			end

			local var_625_8 = 0.001

			if var_625_7 <= arg_622_1.time_ and arg_622_1.time_ < var_625_7 + var_625_8 then
				local var_625_9 = (arg_622_1.time_ - var_625_7) / var_625_8
				local var_625_10 = Vector3.New(0, 100, 0)

				var_625_6.localPosition = Vector3.Lerp(arg_622_1.var_.moveOldPos1047ui_story, var_625_10, var_625_9)

				local var_625_11 = manager.ui.mainCamera.transform.position - var_625_6.position

				var_625_6.forward = Vector3.New(var_625_11.x, var_625_11.y, var_625_11.z)

				local var_625_12 = var_625_6.localEulerAngles

				var_625_12.z = 0
				var_625_12.x = 0
				var_625_6.localEulerAngles = var_625_12
			end

			if arg_622_1.time_ >= var_625_7 + var_625_8 and arg_622_1.time_ < var_625_7 + var_625_8 + arg_625_0 then
				var_625_6.localPosition = Vector3.New(0, 100, 0)

				local var_625_13 = manager.ui.mainCamera.transform.position - var_625_6.position

				var_625_6.forward = Vector3.New(var_625_13.x, var_625_13.y, var_625_13.z)

				local var_625_14 = var_625_6.localEulerAngles

				var_625_14.z = 0
				var_625_14.x = 0
				var_625_6.localEulerAngles = var_625_14
			end

			local var_625_15 = 0
			local var_625_16 = 0.05

			if var_625_15 < arg_622_1.time_ and arg_622_1.time_ <= var_625_15 + arg_625_0 then
				arg_622_1.talkMaxDuration = 0
				arg_622_1.dialogCg_.alpha = 1

				arg_622_1.dialog_:SetActive(true)
				SetActive(arg_622_1.leftNameGo_, true)

				local var_625_17 = arg_622_1:FormatText(StoryNameCfg[1517].name)

				arg_622_1.leftNameTxt_.text = var_625_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_622_1.leftNameTxt_.transform)

				arg_622_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_622_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_622_1:RecordName(arg_622_1.leftNameTxt_.text)
				SetActive(arg_622_1.iconTrs_.gameObject, true)
				arg_622_1.iconController_:SetSelectedState("hero")

				arg_622_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_622_1.callingController_:SetSelectedState("normal")

				arg_622_1.keyicon_.color = Color.New(1, 1, 1)
				arg_622_1.icon_.color = Color.New(1, 1, 1)

				local var_625_18 = arg_622_1:GetWordFromCfg(1104701154)
				local var_625_19 = arg_622_1:FormatText(var_625_18.content)

				arg_622_1.text_.text = var_625_19

				LuaForUtil.ClearLinePrefixSymbol(arg_622_1.text_)

				local var_625_20 = 2
				local var_625_21 = utf8.len(var_625_19)
				local var_625_22 = var_625_20 <= 0 and var_625_16 or var_625_16 * (var_625_21 / var_625_20)

				if var_625_22 > 0 and var_625_16 < var_625_22 then
					arg_622_1.talkMaxDuration = var_625_22

					if var_625_22 + var_625_15 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_22 + var_625_15
					end
				end

				arg_622_1.text_.text = var_625_19
				arg_622_1.typewritter.percent = 0

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701154", "story_v_side_new_1104701.awb") ~= 0 then
					local var_625_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701154", "story_v_side_new_1104701.awb") / 1000

					if var_625_23 + var_625_15 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_23 + var_625_15
					end

					if var_625_18.prefab_name ~= "" and arg_622_1.actors_[var_625_18.prefab_name] ~= nil then
						local var_625_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_622_1.actors_[var_625_18.prefab_name].transform, "story_v_side_new_1104701", "1104701154", "story_v_side_new_1104701.awb")

						arg_622_1:RecordAudio("1104701154", var_625_24)
						arg_622_1:RecordAudio("1104701154", var_625_24)
					else
						arg_622_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701154", "story_v_side_new_1104701.awb")
					end

					arg_622_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701154", "story_v_side_new_1104701.awb")
				end

				arg_622_1:RecordContent(arg_622_1.text_.text)
			end

			local var_625_25 = math.max(var_625_16, arg_622_1.talkMaxDuration)

			if var_625_15 <= arg_622_1.time_ and arg_622_1.time_ < var_625_15 + var_625_25 then
				arg_622_1.typewritter.percent = (arg_622_1.time_ - var_625_15) / var_625_25

				arg_622_1.typewritter:SetDirty()
			end

			if arg_622_1.time_ >= var_625_15 + var_625_25 and arg_622_1.time_ < var_625_15 + var_625_25 + arg_625_0 then
				arg_622_1.typewritter.percent = 1

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(true)
			end
		end

		arg_622_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_622_1:InitPlayNodeList()
	end,
	Play1104701155 = function(arg_626_0, arg_626_1)
		arg_626_1.time_ = 0
		arg_626_1.frameCnt_ = 0
		arg_626_1.state_ = "playing"
		arg_626_1.curTalkId_ = 1104701155
		arg_626_1.duration_ = 5

		SetActive(arg_626_1.tipsGo_, false)

		function arg_626_1.onSingleLineFinish_()
			arg_626_1.onSingleLineUpdate_ = nil
			arg_626_1.onSingleLineFinish_ = nil
			arg_626_1.state_ = "waiting"
		end

		function arg_626_1.playNext_(arg_628_0)
			if arg_628_0 == 1 then
				arg_626_0:Play1104701156(arg_626_1)
			end
		end

		function arg_626_1.onSingleLineUpdate_(arg_629_0)
			local var_629_0 = 0
			local var_629_1 = 0.65

			if var_629_0 < arg_626_1.time_ and arg_626_1.time_ <= var_629_0 + arg_629_0 then
				arg_626_1.talkMaxDuration = 0
				arg_626_1.dialogCg_.alpha = 1

				arg_626_1.dialog_:SetActive(true)
				SetActive(arg_626_1.leftNameGo_, false)

				arg_626_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_626_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_626_1:RecordName(arg_626_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_626_1.iconTrs_.gameObject, false)
				arg_626_1.callingController_:SetSelectedState("normal")

				local var_629_2 = arg_626_1:GetWordFromCfg(1104701155)
				local var_629_3 = arg_626_1:FormatText(var_629_2.content)

				arg_626_1.text_.text = var_629_3

				LuaForUtil.ClearLinePrefixSymbol(arg_626_1.text_)

				local var_629_4 = 26
				local var_629_5 = utf8.len(var_629_3)
				local var_629_6 = var_629_4 <= 0 and var_629_1 or var_629_1 * (var_629_5 / var_629_4)

				if var_629_6 > 0 and var_629_1 < var_629_6 then
					arg_626_1.talkMaxDuration = var_629_6

					if var_629_6 + var_629_0 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_6 + var_629_0
					end
				end

				arg_626_1.text_.text = var_629_3
				arg_626_1.typewritter.percent = 0

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(false)
				arg_626_1:RecordContent(arg_626_1.text_.text)
			end

			local var_629_7 = math.max(var_629_1, arg_626_1.talkMaxDuration)

			if var_629_0 <= arg_626_1.time_ and arg_626_1.time_ < var_629_0 + var_629_7 then
				arg_626_1.typewritter.percent = (arg_626_1.time_ - var_629_0) / var_629_7

				arg_626_1.typewritter:SetDirty()
			end

			if arg_626_1.time_ >= var_629_0 + var_629_7 and arg_626_1.time_ < var_629_0 + var_629_7 + arg_629_0 then
				arg_626_1.typewritter.percent = 1

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(true)
			end
		end

		arg_626_1.nodeConfigList_ = {}

		arg_626_1:InitPlayNodeList()
	end,
	Play1104701156 = function(arg_630_0, arg_630_1)
		arg_630_1.time_ = 0
		arg_630_1.frameCnt_ = 0
		arg_630_1.state_ = "playing"
		arg_630_1.curTalkId_ = 1104701156
		arg_630_1.duration_ = 6.03

		SetActive(arg_630_1.tipsGo_, false)

		function arg_630_1.onSingleLineFinish_()
			arg_630_1.onSingleLineUpdate_ = nil
			arg_630_1.onSingleLineFinish_ = nil
			arg_630_1.state_ = "waiting"
		end

		function arg_630_1.playNext_(arg_632_0)
			if arg_632_0 == 1 then
				arg_630_0:Play1104701157(arg_630_1)
			end
		end

		function arg_630_1.onSingleLineUpdate_(arg_633_0)
			local var_633_0 = arg_630_1.actors_["1047ui_story"].transform
			local var_633_1 = 0

			if var_633_1 < arg_630_1.time_ and arg_630_1.time_ <= var_633_1 + arg_633_0 then
				arg_630_1.var_.moveOldPos1047ui_story = var_633_0.localPosition
			end

			local var_633_2 = 0.001

			if var_633_1 <= arg_630_1.time_ and arg_630_1.time_ < var_633_1 + var_633_2 then
				local var_633_3 = (arg_630_1.time_ - var_633_1) / var_633_2
				local var_633_4 = Vector3.New(0, -1.13, -6.2)

				var_633_0.localPosition = Vector3.Lerp(arg_630_1.var_.moveOldPos1047ui_story, var_633_4, var_633_3)

				local var_633_5 = manager.ui.mainCamera.transform.position - var_633_0.position

				var_633_0.forward = Vector3.New(var_633_5.x, var_633_5.y, var_633_5.z)

				local var_633_6 = var_633_0.localEulerAngles

				var_633_6.z = 0
				var_633_6.x = 0
				var_633_0.localEulerAngles = var_633_6
			end

			if arg_630_1.time_ >= var_633_1 + var_633_2 and arg_630_1.time_ < var_633_1 + var_633_2 + arg_633_0 then
				var_633_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_633_7 = manager.ui.mainCamera.transform.position - var_633_0.position

				var_633_0.forward = Vector3.New(var_633_7.x, var_633_7.y, var_633_7.z)

				local var_633_8 = var_633_0.localEulerAngles

				var_633_8.z = 0
				var_633_8.x = 0
				var_633_0.localEulerAngles = var_633_8
			end

			local var_633_9 = arg_630_1.actors_["1047ui_story"]
			local var_633_10 = 0

			if var_633_10 < arg_630_1.time_ and arg_630_1.time_ <= var_633_10 + arg_633_0 and not isNil(var_633_9) and arg_630_1.var_.characterEffect1047ui_story == nil then
				arg_630_1.var_.characterEffect1047ui_story = var_633_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_633_11 = 0.200000002980232

			if var_633_10 <= arg_630_1.time_ and arg_630_1.time_ < var_633_10 + var_633_11 and not isNil(var_633_9) then
				local var_633_12 = (arg_630_1.time_ - var_633_10) / var_633_11

				if arg_630_1.var_.characterEffect1047ui_story and not isNil(var_633_9) then
					arg_630_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_630_1.time_ >= var_633_10 + var_633_11 and arg_630_1.time_ < var_633_10 + var_633_11 + arg_633_0 and not isNil(var_633_9) and arg_630_1.var_.characterEffect1047ui_story then
				arg_630_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_633_13 = 0

			if var_633_13 < arg_630_1.time_ and arg_630_1.time_ <= var_633_13 + arg_633_0 then
				arg_630_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_633_14 = 0

			if var_633_14 < arg_630_1.time_ and arg_630_1.time_ <= var_633_14 + arg_633_0 then
				arg_630_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_633_15 = 0
			local var_633_16 = 0.7

			if var_633_15 < arg_630_1.time_ and arg_630_1.time_ <= var_633_15 + arg_633_0 then
				arg_630_1.talkMaxDuration = 0
				arg_630_1.dialogCg_.alpha = 1

				arg_630_1.dialog_:SetActive(true)
				SetActive(arg_630_1.leftNameGo_, true)

				local var_633_17 = arg_630_1:FormatText(StoryNameCfg[1296].name)

				arg_630_1.leftNameTxt_.text = var_633_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_630_1.leftNameTxt_.transform)

				arg_630_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_630_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_630_1:RecordName(arg_630_1.leftNameTxt_.text)
				SetActive(arg_630_1.iconTrs_.gameObject, false)
				arg_630_1.callingController_:SetSelectedState("normal")

				local var_633_18 = arg_630_1:GetWordFromCfg(1104701156)
				local var_633_19 = arg_630_1:FormatText(var_633_18.content)

				arg_630_1.text_.text = var_633_19

				LuaForUtil.ClearLinePrefixSymbol(arg_630_1.text_)

				local var_633_20 = 28
				local var_633_21 = utf8.len(var_633_19)
				local var_633_22 = var_633_20 <= 0 and var_633_16 or var_633_16 * (var_633_21 / var_633_20)

				if var_633_22 > 0 and var_633_16 < var_633_22 then
					arg_630_1.talkMaxDuration = var_633_22

					if var_633_22 + var_633_15 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_22 + var_633_15
					end
				end

				arg_630_1.text_.text = var_633_19
				arg_630_1.typewritter.percent = 0

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701156", "story_v_side_new_1104701.awb") ~= 0 then
					local var_633_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701156", "story_v_side_new_1104701.awb") / 1000

					if var_633_23 + var_633_15 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_23 + var_633_15
					end

					if var_633_18.prefab_name ~= "" and arg_630_1.actors_[var_633_18.prefab_name] ~= nil then
						local var_633_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_630_1.actors_[var_633_18.prefab_name].transform, "story_v_side_new_1104701", "1104701156", "story_v_side_new_1104701.awb")

						arg_630_1:RecordAudio("1104701156", var_633_24)
						arg_630_1:RecordAudio("1104701156", var_633_24)
					else
						arg_630_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701156", "story_v_side_new_1104701.awb")
					end

					arg_630_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701156", "story_v_side_new_1104701.awb")
				end

				arg_630_1:RecordContent(arg_630_1.text_.text)
			end

			local var_633_25 = math.max(var_633_16, arg_630_1.talkMaxDuration)

			if var_633_15 <= arg_630_1.time_ and arg_630_1.time_ < var_633_15 + var_633_25 then
				arg_630_1.typewritter.percent = (arg_630_1.time_ - var_633_15) / var_633_25

				arg_630_1.typewritter:SetDirty()
			end

			if arg_630_1.time_ >= var_633_15 + var_633_25 and arg_630_1.time_ < var_633_15 + var_633_25 + arg_633_0 then
				arg_630_1.typewritter.percent = 1

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(true)
			end
		end

		arg_630_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_630_1:InitPlayNodeList()
	end,
	Play1104701157 = function(arg_634_0, arg_634_1)
		arg_634_1.time_ = 0
		arg_634_1.frameCnt_ = 0
		arg_634_1.state_ = "playing"
		arg_634_1.curTalkId_ = 1104701157
		arg_634_1.duration_ = 5

		SetActive(arg_634_1.tipsGo_, false)

		function arg_634_1.onSingleLineFinish_()
			arg_634_1.onSingleLineUpdate_ = nil
			arg_634_1.onSingleLineFinish_ = nil
			arg_634_1.state_ = "waiting"
		end

		function arg_634_1.playNext_(arg_636_0)
			if arg_636_0 == 1 then
				arg_634_0:Play1104701158(arg_634_1)
			end
		end

		function arg_634_1.onSingleLineUpdate_(arg_637_0)
			local var_637_0 = arg_634_1.actors_["1047ui_story"]
			local var_637_1 = 0

			if var_637_1 < arg_634_1.time_ and arg_634_1.time_ <= var_637_1 + arg_637_0 and not isNil(var_637_0) and arg_634_1.var_.characterEffect1047ui_story == nil then
				arg_634_1.var_.characterEffect1047ui_story = var_637_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_637_2 = 0.200000002980232

			if var_637_1 <= arg_634_1.time_ and arg_634_1.time_ < var_637_1 + var_637_2 and not isNil(var_637_0) then
				local var_637_3 = (arg_634_1.time_ - var_637_1) / var_637_2

				if arg_634_1.var_.characterEffect1047ui_story and not isNil(var_637_0) then
					local var_637_4 = Mathf.Lerp(0, 0.5, var_637_3)

					arg_634_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_634_1.var_.characterEffect1047ui_story.fillRatio = var_637_4
				end
			end

			if arg_634_1.time_ >= var_637_1 + var_637_2 and arg_634_1.time_ < var_637_1 + var_637_2 + arg_637_0 and not isNil(var_637_0) and arg_634_1.var_.characterEffect1047ui_story then
				local var_637_5 = 0.5

				arg_634_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_634_1.var_.characterEffect1047ui_story.fillRatio = var_637_5
			end

			local var_637_6 = 0
			local var_637_7 = 0.25

			if var_637_6 < arg_634_1.time_ and arg_634_1.time_ <= var_637_6 + arg_637_0 then
				arg_634_1.talkMaxDuration = 0
				arg_634_1.dialogCg_.alpha = 1

				arg_634_1.dialog_:SetActive(true)
				SetActive(arg_634_1.leftNameGo_, true)

				local var_637_8 = arg_634_1:FormatText(StoryNameCfg[7].name)

				arg_634_1.leftNameTxt_.text = var_637_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_634_1.leftNameTxt_.transform)

				arg_634_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_634_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_634_1:RecordName(arg_634_1.leftNameTxt_.text)
				SetActive(arg_634_1.iconTrs_.gameObject, true)
				arg_634_1.iconController_:SetSelectedState("hero")

				arg_634_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_634_1.callingController_:SetSelectedState("normal")

				arg_634_1.keyicon_.color = Color.New(1, 1, 1)
				arg_634_1.icon_.color = Color.New(1, 1, 1)

				local var_637_9 = arg_634_1:GetWordFromCfg(1104701157)
				local var_637_10 = arg_634_1:FormatText(var_637_9.content)

				arg_634_1.text_.text = var_637_10

				LuaForUtil.ClearLinePrefixSymbol(arg_634_1.text_)

				local var_637_11 = 10
				local var_637_12 = utf8.len(var_637_10)
				local var_637_13 = var_637_11 <= 0 and var_637_7 or var_637_7 * (var_637_12 / var_637_11)

				if var_637_13 > 0 and var_637_7 < var_637_13 then
					arg_634_1.talkMaxDuration = var_637_13

					if var_637_13 + var_637_6 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_13 + var_637_6
					end
				end

				arg_634_1.text_.text = var_637_10
				arg_634_1.typewritter.percent = 0

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(false)
				arg_634_1:RecordContent(arg_634_1.text_.text)
			end

			local var_637_14 = math.max(var_637_7, arg_634_1.talkMaxDuration)

			if var_637_6 <= arg_634_1.time_ and arg_634_1.time_ < var_637_6 + var_637_14 then
				arg_634_1.typewritter.percent = (arg_634_1.time_ - var_637_6) / var_637_14

				arg_634_1.typewritter:SetDirty()
			end

			if arg_634_1.time_ >= var_637_6 + var_637_14 and arg_634_1.time_ < var_637_6 + var_637_14 + arg_637_0 then
				arg_634_1.typewritter.percent = 1

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(true)
			end
		end

		arg_634_1.nodeConfigList_ = {}

		arg_634_1:InitPlayNodeList()
	end,
	Play1104701158 = function(arg_638_0, arg_638_1)
		arg_638_1.time_ = 0
		arg_638_1.frameCnt_ = 0
		arg_638_1.state_ = "playing"
		arg_638_1.curTalkId_ = 1104701158
		arg_638_1.duration_ = 6.53

		SetActive(arg_638_1.tipsGo_, false)

		function arg_638_1.onSingleLineFinish_()
			arg_638_1.onSingleLineUpdate_ = nil
			arg_638_1.onSingleLineFinish_ = nil
			arg_638_1.state_ = "waiting"
		end

		function arg_638_1.playNext_(arg_640_0)
			if arg_640_0 == 1 then
				arg_638_0:Play1104701159(arg_638_1)
			end
		end

		function arg_638_1.onSingleLineUpdate_(arg_641_0)
			local var_641_0 = arg_638_1.actors_["1047ui_story"].transform
			local var_641_1 = 0

			if var_641_1 < arg_638_1.time_ and arg_638_1.time_ <= var_641_1 + arg_641_0 then
				arg_638_1.var_.moveOldPos1047ui_story = var_641_0.localPosition
			end

			local var_641_2 = 0.001

			if var_641_1 <= arg_638_1.time_ and arg_638_1.time_ < var_641_1 + var_641_2 then
				local var_641_3 = (arg_638_1.time_ - var_641_1) / var_641_2
				local var_641_4 = Vector3.New(0, -1.13, -6.2)

				var_641_0.localPosition = Vector3.Lerp(arg_638_1.var_.moveOldPos1047ui_story, var_641_4, var_641_3)

				local var_641_5 = manager.ui.mainCamera.transform.position - var_641_0.position

				var_641_0.forward = Vector3.New(var_641_5.x, var_641_5.y, var_641_5.z)

				local var_641_6 = var_641_0.localEulerAngles

				var_641_6.z = 0
				var_641_6.x = 0
				var_641_0.localEulerAngles = var_641_6
			end

			if arg_638_1.time_ >= var_641_1 + var_641_2 and arg_638_1.time_ < var_641_1 + var_641_2 + arg_641_0 then
				var_641_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_641_7 = manager.ui.mainCamera.transform.position - var_641_0.position

				var_641_0.forward = Vector3.New(var_641_7.x, var_641_7.y, var_641_7.z)

				local var_641_8 = var_641_0.localEulerAngles

				var_641_8.z = 0
				var_641_8.x = 0
				var_641_0.localEulerAngles = var_641_8
			end

			local var_641_9 = arg_638_1.actors_["1047ui_story"]
			local var_641_10 = 0

			if var_641_10 < arg_638_1.time_ and arg_638_1.time_ <= var_641_10 + arg_641_0 and not isNil(var_641_9) and arg_638_1.var_.characterEffect1047ui_story == nil then
				arg_638_1.var_.characterEffect1047ui_story = var_641_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_641_11 = 0.200000002980232

			if var_641_10 <= arg_638_1.time_ and arg_638_1.time_ < var_641_10 + var_641_11 and not isNil(var_641_9) then
				local var_641_12 = (arg_638_1.time_ - var_641_10) / var_641_11

				if arg_638_1.var_.characterEffect1047ui_story and not isNil(var_641_9) then
					arg_638_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_638_1.time_ >= var_641_10 + var_641_11 and arg_638_1.time_ < var_641_10 + var_641_11 + arg_641_0 and not isNil(var_641_9) and arg_638_1.var_.characterEffect1047ui_story then
				arg_638_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_641_13 = 0

			if var_641_13 < arg_638_1.time_ and arg_638_1.time_ <= var_641_13 + arg_641_0 then
				arg_638_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			local var_641_14 = 0

			if var_641_14 < arg_638_1.time_ and arg_638_1.time_ <= var_641_14 + arg_641_0 then
				arg_638_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_641_15 = 0
			local var_641_16 = 0.7

			if var_641_15 < arg_638_1.time_ and arg_638_1.time_ <= var_641_15 + arg_641_0 then
				arg_638_1.talkMaxDuration = 0
				arg_638_1.dialogCg_.alpha = 1

				arg_638_1.dialog_:SetActive(true)
				SetActive(arg_638_1.leftNameGo_, true)

				local var_641_17 = arg_638_1:FormatText(StoryNameCfg[1296].name)

				arg_638_1.leftNameTxt_.text = var_641_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_638_1.leftNameTxt_.transform)

				arg_638_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_638_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_638_1:RecordName(arg_638_1.leftNameTxt_.text)
				SetActive(arg_638_1.iconTrs_.gameObject, false)
				arg_638_1.callingController_:SetSelectedState("normal")

				local var_641_18 = arg_638_1:GetWordFromCfg(1104701158)
				local var_641_19 = arg_638_1:FormatText(var_641_18.content)

				arg_638_1.text_.text = var_641_19

				LuaForUtil.ClearLinePrefixSymbol(arg_638_1.text_)

				local var_641_20 = 28
				local var_641_21 = utf8.len(var_641_19)
				local var_641_22 = var_641_20 <= 0 and var_641_16 or var_641_16 * (var_641_21 / var_641_20)

				if var_641_22 > 0 and var_641_16 < var_641_22 then
					arg_638_1.talkMaxDuration = var_641_22

					if var_641_22 + var_641_15 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_22 + var_641_15
					end
				end

				arg_638_1.text_.text = var_641_19
				arg_638_1.typewritter.percent = 0

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701158", "story_v_side_new_1104701.awb") ~= 0 then
					local var_641_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701158", "story_v_side_new_1104701.awb") / 1000

					if var_641_23 + var_641_15 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_23 + var_641_15
					end

					if var_641_18.prefab_name ~= "" and arg_638_1.actors_[var_641_18.prefab_name] ~= nil then
						local var_641_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_638_1.actors_[var_641_18.prefab_name].transform, "story_v_side_new_1104701", "1104701158", "story_v_side_new_1104701.awb")

						arg_638_1:RecordAudio("1104701158", var_641_24)
						arg_638_1:RecordAudio("1104701158", var_641_24)
					else
						arg_638_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701158", "story_v_side_new_1104701.awb")
					end

					arg_638_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701158", "story_v_side_new_1104701.awb")
				end

				arg_638_1:RecordContent(arg_638_1.text_.text)
			end

			local var_641_25 = math.max(var_641_16, arg_638_1.talkMaxDuration)

			if var_641_15 <= arg_638_1.time_ and arg_638_1.time_ < var_641_15 + var_641_25 then
				arg_638_1.typewritter.percent = (arg_638_1.time_ - var_641_15) / var_641_25

				arg_638_1.typewritter:SetDirty()
			end

			if arg_638_1.time_ >= var_641_15 + var_641_25 and arg_638_1.time_ < var_641_15 + var_641_25 + arg_641_0 then
				arg_638_1.typewritter.percent = 1

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(true)
			end
		end

		arg_638_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_638_1:InitPlayNodeList()
	end,
	Play1104701159 = function(arg_642_0, arg_642_1)
		arg_642_1.time_ = 0
		arg_642_1.frameCnt_ = 0
		arg_642_1.state_ = "playing"
		arg_642_1.curTalkId_ = 1104701159
		arg_642_1.duration_ = 5

		SetActive(arg_642_1.tipsGo_, false)

		function arg_642_1.onSingleLineFinish_()
			arg_642_1.onSingleLineUpdate_ = nil
			arg_642_1.onSingleLineFinish_ = nil
			arg_642_1.state_ = "waiting"
		end

		function arg_642_1.playNext_(arg_644_0)
			if arg_644_0 == 1 then
				arg_642_0:Play1104701160(arg_642_1)
			end
		end

		function arg_642_1.onSingleLineUpdate_(arg_645_0)
			local var_645_0 = arg_642_1.actors_["1047ui_story"]
			local var_645_1 = 0

			if var_645_1 < arg_642_1.time_ and arg_642_1.time_ <= var_645_1 + arg_645_0 and not isNil(var_645_0) and arg_642_1.var_.characterEffect1047ui_story == nil then
				arg_642_1.var_.characterEffect1047ui_story = var_645_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_645_2 = 0.200000002980232

			if var_645_1 <= arg_642_1.time_ and arg_642_1.time_ < var_645_1 + var_645_2 and not isNil(var_645_0) then
				local var_645_3 = (arg_642_1.time_ - var_645_1) / var_645_2

				if arg_642_1.var_.characterEffect1047ui_story and not isNil(var_645_0) then
					local var_645_4 = Mathf.Lerp(0, 0.5, var_645_3)

					arg_642_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_642_1.var_.characterEffect1047ui_story.fillRatio = var_645_4
				end
			end

			if arg_642_1.time_ >= var_645_1 + var_645_2 and arg_642_1.time_ < var_645_1 + var_645_2 + arg_645_0 and not isNil(var_645_0) and arg_642_1.var_.characterEffect1047ui_story then
				local var_645_5 = 0.5

				arg_642_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_642_1.var_.characterEffect1047ui_story.fillRatio = var_645_5
			end

			local var_645_6 = 0
			local var_645_7 = 0.4

			if var_645_6 < arg_642_1.time_ and arg_642_1.time_ <= var_645_6 + arg_645_0 then
				arg_642_1.talkMaxDuration = 0
				arg_642_1.dialogCg_.alpha = 1

				arg_642_1.dialog_:SetActive(true)
				SetActive(arg_642_1.leftNameGo_, true)

				local var_645_8 = arg_642_1:FormatText(StoryNameCfg[7].name)

				arg_642_1.leftNameTxt_.text = var_645_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_642_1.leftNameTxt_.transform)

				arg_642_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_642_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_642_1:RecordName(arg_642_1.leftNameTxt_.text)
				SetActive(arg_642_1.iconTrs_.gameObject, true)
				arg_642_1.iconController_:SetSelectedState("hero")

				arg_642_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_642_1.callingController_:SetSelectedState("normal")

				arg_642_1.keyicon_.color = Color.New(1, 1, 1)
				arg_642_1.icon_.color = Color.New(1, 1, 1)

				local var_645_9 = arg_642_1:GetWordFromCfg(1104701159)
				local var_645_10 = arg_642_1:FormatText(var_645_9.content)

				arg_642_1.text_.text = var_645_10

				LuaForUtil.ClearLinePrefixSymbol(arg_642_1.text_)

				local var_645_11 = 16
				local var_645_12 = utf8.len(var_645_10)
				local var_645_13 = var_645_11 <= 0 and var_645_7 or var_645_7 * (var_645_12 / var_645_11)

				if var_645_13 > 0 and var_645_7 < var_645_13 then
					arg_642_1.talkMaxDuration = var_645_13

					if var_645_13 + var_645_6 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_13 + var_645_6
					end
				end

				arg_642_1.text_.text = var_645_10
				arg_642_1.typewritter.percent = 0

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(false)
				arg_642_1:RecordContent(arg_642_1.text_.text)
			end

			local var_645_14 = math.max(var_645_7, arg_642_1.talkMaxDuration)

			if var_645_6 <= arg_642_1.time_ and arg_642_1.time_ < var_645_6 + var_645_14 then
				arg_642_1.typewritter.percent = (arg_642_1.time_ - var_645_6) / var_645_14

				arg_642_1.typewritter:SetDirty()
			end

			if arg_642_1.time_ >= var_645_6 + var_645_14 and arg_642_1.time_ < var_645_6 + var_645_14 + arg_645_0 then
				arg_642_1.typewritter.percent = 1

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(true)
			end
		end

		arg_642_1.nodeConfigList_ = {}

		arg_642_1:InitPlayNodeList()
	end,
	Play1104701160 = function(arg_646_0, arg_646_1)
		arg_646_1.time_ = 0
		arg_646_1.frameCnt_ = 0
		arg_646_1.state_ = "playing"
		arg_646_1.curTalkId_ = 1104701160
		arg_646_1.duration_ = 5

		SetActive(arg_646_1.tipsGo_, false)

		function arg_646_1.onSingleLineFinish_()
			arg_646_1.onSingleLineUpdate_ = nil
			arg_646_1.onSingleLineFinish_ = nil
			arg_646_1.state_ = "waiting"
		end

		function arg_646_1.playNext_(arg_648_0)
			if arg_648_0 == 1 then
				arg_646_0:Play1104701161(arg_646_1)
			end
		end

		function arg_646_1.onSingleLineUpdate_(arg_649_0)
			local var_649_0 = arg_646_1.actors_["1047ui_story"].transform
			local var_649_1 = 0

			if var_649_1 < arg_646_1.time_ and arg_646_1.time_ <= var_649_1 + arg_649_0 then
				arg_646_1.var_.moveOldPos1047ui_story = var_649_0.localPosition
			end

			local var_649_2 = 0.001

			if var_649_1 <= arg_646_1.time_ and arg_646_1.time_ < var_649_1 + var_649_2 then
				local var_649_3 = (arg_646_1.time_ - var_649_1) / var_649_2
				local var_649_4 = Vector3.New(0, 100, 0)

				var_649_0.localPosition = Vector3.Lerp(arg_646_1.var_.moveOldPos1047ui_story, var_649_4, var_649_3)

				local var_649_5 = manager.ui.mainCamera.transform.position - var_649_0.position

				var_649_0.forward = Vector3.New(var_649_5.x, var_649_5.y, var_649_5.z)

				local var_649_6 = var_649_0.localEulerAngles

				var_649_6.z = 0
				var_649_6.x = 0
				var_649_0.localEulerAngles = var_649_6
			end

			if arg_646_1.time_ >= var_649_1 + var_649_2 and arg_646_1.time_ < var_649_1 + var_649_2 + arg_649_0 then
				var_649_0.localPosition = Vector3.New(0, 100, 0)

				local var_649_7 = manager.ui.mainCamera.transform.position - var_649_0.position

				var_649_0.forward = Vector3.New(var_649_7.x, var_649_7.y, var_649_7.z)

				local var_649_8 = var_649_0.localEulerAngles

				var_649_8.z = 0
				var_649_8.x = 0
				var_649_0.localEulerAngles = var_649_8
			end

			local var_649_9 = 0
			local var_649_10 = 0.35

			if var_649_9 < arg_646_1.time_ and arg_646_1.time_ <= var_649_9 + arg_649_0 then
				arg_646_1.talkMaxDuration = 0
				arg_646_1.dialogCg_.alpha = 1

				arg_646_1.dialog_:SetActive(true)
				SetActive(arg_646_1.leftNameGo_, false)

				arg_646_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_646_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_646_1:RecordName(arg_646_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_646_1.iconTrs_.gameObject, false)
				arg_646_1.callingController_:SetSelectedState("normal")

				local var_649_11 = arg_646_1:GetWordFromCfg(1104701160)
				local var_649_12 = arg_646_1:FormatText(var_649_11.content)

				arg_646_1.text_.text = var_649_12

				LuaForUtil.ClearLinePrefixSymbol(arg_646_1.text_)

				local var_649_13 = 14
				local var_649_14 = utf8.len(var_649_12)
				local var_649_15 = var_649_13 <= 0 and var_649_10 or var_649_10 * (var_649_14 / var_649_13)

				if var_649_15 > 0 and var_649_10 < var_649_15 then
					arg_646_1.talkMaxDuration = var_649_15

					if var_649_15 + var_649_9 > arg_646_1.duration_ then
						arg_646_1.duration_ = var_649_15 + var_649_9
					end
				end

				arg_646_1.text_.text = var_649_12
				arg_646_1.typewritter.percent = 0

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(false)
				arg_646_1:RecordContent(arg_646_1.text_.text)
			end

			local var_649_16 = math.max(var_649_10, arg_646_1.talkMaxDuration)

			if var_649_9 <= arg_646_1.time_ and arg_646_1.time_ < var_649_9 + var_649_16 then
				arg_646_1.typewritter.percent = (arg_646_1.time_ - var_649_9) / var_649_16

				arg_646_1.typewritter:SetDirty()
			end

			if arg_646_1.time_ >= var_649_9 + var_649_16 and arg_646_1.time_ < var_649_9 + var_649_16 + arg_649_0 then
				arg_646_1.typewritter.percent = 1

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(true)
			end
		end

		arg_646_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_646_1:InitPlayNodeList()
	end,
	Play1104701161 = function(arg_650_0, arg_650_1)
		arg_650_1.time_ = 0
		arg_650_1.frameCnt_ = 0
		arg_650_1.state_ = "playing"
		arg_650_1.curTalkId_ = 1104701161
		arg_650_1.duration_ = 9.03

		SetActive(arg_650_1.tipsGo_, false)

		function arg_650_1.onSingleLineFinish_()
			arg_650_1.onSingleLineUpdate_ = nil
			arg_650_1.onSingleLineFinish_ = nil
			arg_650_1.state_ = "waiting"
		end

		function arg_650_1.playNext_(arg_652_0)
			if arg_652_0 == 1 then
				arg_650_0:Play1104701162(arg_650_1)
			end
		end

		function arg_650_1.onSingleLineUpdate_(arg_653_0)
			local var_653_0 = arg_650_1.actors_["1047ui_story"].transform
			local var_653_1 = 0

			if var_653_1 < arg_650_1.time_ and arg_650_1.time_ <= var_653_1 + arg_653_0 then
				arg_650_1.var_.moveOldPos1047ui_story = var_653_0.localPosition
			end

			local var_653_2 = 0.001

			if var_653_1 <= arg_650_1.time_ and arg_650_1.time_ < var_653_1 + var_653_2 then
				local var_653_3 = (arg_650_1.time_ - var_653_1) / var_653_2
				local var_653_4 = Vector3.New(0, -1.13, -6.2)

				var_653_0.localPosition = Vector3.Lerp(arg_650_1.var_.moveOldPos1047ui_story, var_653_4, var_653_3)

				local var_653_5 = manager.ui.mainCamera.transform.position - var_653_0.position

				var_653_0.forward = Vector3.New(var_653_5.x, var_653_5.y, var_653_5.z)

				local var_653_6 = var_653_0.localEulerAngles

				var_653_6.z = 0
				var_653_6.x = 0
				var_653_0.localEulerAngles = var_653_6
			end

			if arg_650_1.time_ >= var_653_1 + var_653_2 and arg_650_1.time_ < var_653_1 + var_653_2 + arg_653_0 then
				var_653_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_653_7 = manager.ui.mainCamera.transform.position - var_653_0.position

				var_653_0.forward = Vector3.New(var_653_7.x, var_653_7.y, var_653_7.z)

				local var_653_8 = var_653_0.localEulerAngles

				var_653_8.z = 0
				var_653_8.x = 0
				var_653_0.localEulerAngles = var_653_8
			end

			local var_653_9 = arg_650_1.actors_["1047ui_story"]
			local var_653_10 = 0

			if var_653_10 < arg_650_1.time_ and arg_650_1.time_ <= var_653_10 + arg_653_0 and not isNil(var_653_9) and arg_650_1.var_.characterEffect1047ui_story == nil then
				arg_650_1.var_.characterEffect1047ui_story = var_653_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_653_11 = 0.200000002980232

			if var_653_10 <= arg_650_1.time_ and arg_650_1.time_ < var_653_10 + var_653_11 and not isNil(var_653_9) then
				local var_653_12 = (arg_650_1.time_ - var_653_10) / var_653_11

				if arg_650_1.var_.characterEffect1047ui_story and not isNil(var_653_9) then
					arg_650_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_650_1.time_ >= var_653_10 + var_653_11 and arg_650_1.time_ < var_653_10 + var_653_11 + arg_653_0 and not isNil(var_653_9) and arg_650_1.var_.characterEffect1047ui_story then
				arg_650_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_653_13 = 0

			if var_653_13 < arg_650_1.time_ and arg_650_1.time_ <= var_653_13 + arg_653_0 then
				arg_650_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action476")
			end

			local var_653_14 = 0

			if var_653_14 < arg_650_1.time_ and arg_650_1.time_ <= var_653_14 + arg_653_0 then
				arg_650_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_653_15 = 0
			local var_653_16 = 0.8

			if var_653_15 < arg_650_1.time_ and arg_650_1.time_ <= var_653_15 + arg_653_0 then
				arg_650_1.talkMaxDuration = 0
				arg_650_1.dialogCg_.alpha = 1

				arg_650_1.dialog_:SetActive(true)
				SetActive(arg_650_1.leftNameGo_, true)

				local var_653_17 = arg_650_1:FormatText(StoryNameCfg[1296].name)

				arg_650_1.leftNameTxt_.text = var_653_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_650_1.leftNameTxt_.transform)

				arg_650_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_650_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_650_1:RecordName(arg_650_1.leftNameTxt_.text)
				SetActive(arg_650_1.iconTrs_.gameObject, false)
				arg_650_1.callingController_:SetSelectedState("normal")

				local var_653_18 = arg_650_1:GetWordFromCfg(1104701161)
				local var_653_19 = arg_650_1:FormatText(var_653_18.content)

				arg_650_1.text_.text = var_653_19

				LuaForUtil.ClearLinePrefixSymbol(arg_650_1.text_)

				local var_653_20 = 32
				local var_653_21 = utf8.len(var_653_19)
				local var_653_22 = var_653_20 <= 0 and var_653_16 or var_653_16 * (var_653_21 / var_653_20)

				if var_653_22 > 0 and var_653_16 < var_653_22 then
					arg_650_1.talkMaxDuration = var_653_22

					if var_653_22 + var_653_15 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_22 + var_653_15
					end
				end

				arg_650_1.text_.text = var_653_19
				arg_650_1.typewritter.percent = 0

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701161", "story_v_side_new_1104701.awb") ~= 0 then
					local var_653_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701161", "story_v_side_new_1104701.awb") / 1000

					if var_653_23 + var_653_15 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_23 + var_653_15
					end

					if var_653_18.prefab_name ~= "" and arg_650_1.actors_[var_653_18.prefab_name] ~= nil then
						local var_653_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_650_1.actors_[var_653_18.prefab_name].transform, "story_v_side_new_1104701", "1104701161", "story_v_side_new_1104701.awb")

						arg_650_1:RecordAudio("1104701161", var_653_24)
						arg_650_1:RecordAudio("1104701161", var_653_24)
					else
						arg_650_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701161", "story_v_side_new_1104701.awb")
					end

					arg_650_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701161", "story_v_side_new_1104701.awb")
				end

				arg_650_1:RecordContent(arg_650_1.text_.text)
			end

			local var_653_25 = math.max(var_653_16, arg_650_1.talkMaxDuration)

			if var_653_15 <= arg_650_1.time_ and arg_650_1.time_ < var_653_15 + var_653_25 then
				arg_650_1.typewritter.percent = (arg_650_1.time_ - var_653_15) / var_653_25

				arg_650_1.typewritter:SetDirty()
			end

			if arg_650_1.time_ >= var_653_15 + var_653_25 and arg_650_1.time_ < var_653_15 + var_653_25 + arg_653_0 then
				arg_650_1.typewritter.percent = 1

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(true)
			end
		end

		arg_650_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_650_1:InitPlayNodeList()
	end,
	Play1104701162 = function(arg_654_0, arg_654_1)
		arg_654_1.time_ = 0
		arg_654_1.frameCnt_ = 0
		arg_654_1.state_ = "playing"
		arg_654_1.curTalkId_ = 1104701162
		arg_654_1.duration_ = 5

		SetActive(arg_654_1.tipsGo_, false)

		function arg_654_1.onSingleLineFinish_()
			arg_654_1.onSingleLineUpdate_ = nil
			arg_654_1.onSingleLineFinish_ = nil
			arg_654_1.state_ = "waiting"
		end

		function arg_654_1.playNext_(arg_656_0)
			if arg_656_0 == 1 then
				arg_654_0:Play1104701163(arg_654_1)
			end
		end

		function arg_654_1.onSingleLineUpdate_(arg_657_0)
			local var_657_0 = arg_654_1.actors_["1047ui_story"]
			local var_657_1 = 0

			if var_657_1 < arg_654_1.time_ and arg_654_1.time_ <= var_657_1 + arg_657_0 and not isNil(var_657_0) and arg_654_1.var_.characterEffect1047ui_story == nil then
				arg_654_1.var_.characterEffect1047ui_story = var_657_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_657_2 = 0.200000002980232

			if var_657_1 <= arg_654_1.time_ and arg_654_1.time_ < var_657_1 + var_657_2 and not isNil(var_657_0) then
				local var_657_3 = (arg_654_1.time_ - var_657_1) / var_657_2

				if arg_654_1.var_.characterEffect1047ui_story and not isNil(var_657_0) then
					local var_657_4 = Mathf.Lerp(0, 0.5, var_657_3)

					arg_654_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_654_1.var_.characterEffect1047ui_story.fillRatio = var_657_4
				end
			end

			if arg_654_1.time_ >= var_657_1 + var_657_2 and arg_654_1.time_ < var_657_1 + var_657_2 + arg_657_0 and not isNil(var_657_0) and arg_654_1.var_.characterEffect1047ui_story then
				local var_657_5 = 0.5

				arg_654_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_654_1.var_.characterEffect1047ui_story.fillRatio = var_657_5
			end

			local var_657_6 = 0
			local var_657_7 = 0.75

			if var_657_6 < arg_654_1.time_ and arg_654_1.time_ <= var_657_6 + arg_657_0 then
				arg_654_1.talkMaxDuration = 0
				arg_654_1.dialogCg_.alpha = 1

				arg_654_1.dialog_:SetActive(true)
				SetActive(arg_654_1.leftNameGo_, true)

				local var_657_8 = arg_654_1:FormatText(StoryNameCfg[7].name)

				arg_654_1.leftNameTxt_.text = var_657_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_654_1.leftNameTxt_.transform)

				arg_654_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_654_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_654_1:RecordName(arg_654_1.leftNameTxt_.text)
				SetActive(arg_654_1.iconTrs_.gameObject, true)
				arg_654_1.iconController_:SetSelectedState("hero")

				arg_654_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_654_1.callingController_:SetSelectedState("normal")

				arg_654_1.keyicon_.color = Color.New(1, 1, 1)
				arg_654_1.icon_.color = Color.New(1, 1, 1)

				local var_657_9 = arg_654_1:GetWordFromCfg(1104701162)
				local var_657_10 = arg_654_1:FormatText(var_657_9.content)

				arg_654_1.text_.text = var_657_10

				LuaForUtil.ClearLinePrefixSymbol(arg_654_1.text_)

				local var_657_11 = 30
				local var_657_12 = utf8.len(var_657_10)
				local var_657_13 = var_657_11 <= 0 and var_657_7 or var_657_7 * (var_657_12 / var_657_11)

				if var_657_13 > 0 and var_657_7 < var_657_13 then
					arg_654_1.talkMaxDuration = var_657_13

					if var_657_13 + var_657_6 > arg_654_1.duration_ then
						arg_654_1.duration_ = var_657_13 + var_657_6
					end
				end

				arg_654_1.text_.text = var_657_10
				arg_654_1.typewritter.percent = 0

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(false)
				arg_654_1:RecordContent(arg_654_1.text_.text)
			end

			local var_657_14 = math.max(var_657_7, arg_654_1.talkMaxDuration)

			if var_657_6 <= arg_654_1.time_ and arg_654_1.time_ < var_657_6 + var_657_14 then
				arg_654_1.typewritter.percent = (arg_654_1.time_ - var_657_6) / var_657_14

				arg_654_1.typewritter:SetDirty()
			end

			if arg_654_1.time_ >= var_657_6 + var_657_14 and arg_654_1.time_ < var_657_6 + var_657_14 + arg_657_0 then
				arg_654_1.typewritter.percent = 1

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(true)
			end
		end

		arg_654_1.nodeConfigList_ = {}

		arg_654_1:InitPlayNodeList()
	end,
	Play1104701163 = function(arg_658_0, arg_658_1)
		arg_658_1.time_ = 0
		arg_658_1.frameCnt_ = 0
		arg_658_1.state_ = "playing"
		arg_658_1.curTalkId_ = 1104701163
		arg_658_1.duration_ = 4.43

		SetActive(arg_658_1.tipsGo_, false)

		function arg_658_1.onSingleLineFinish_()
			arg_658_1.onSingleLineUpdate_ = nil
			arg_658_1.onSingleLineFinish_ = nil
			arg_658_1.state_ = "waiting"
		end

		function arg_658_1.playNext_(arg_660_0)
			if arg_660_0 == 1 then
				arg_658_0:Play1104701164(arg_658_1)
			end
		end

		function arg_658_1.onSingleLineUpdate_(arg_661_0)
			local var_661_0 = arg_658_1.actors_["1047ui_story"]
			local var_661_1 = 0

			if var_661_1 < arg_658_1.time_ and arg_658_1.time_ <= var_661_1 + arg_661_0 and not isNil(var_661_0) and arg_658_1.var_.characterEffect1047ui_story == nil then
				arg_658_1.var_.characterEffect1047ui_story = var_661_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_661_2 = 0.200000002980232

			if var_661_1 <= arg_658_1.time_ and arg_658_1.time_ < var_661_1 + var_661_2 and not isNil(var_661_0) then
				local var_661_3 = (arg_658_1.time_ - var_661_1) / var_661_2

				if arg_658_1.var_.characterEffect1047ui_story and not isNil(var_661_0) then
					arg_658_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_658_1.time_ >= var_661_1 + var_661_2 and arg_658_1.time_ < var_661_1 + var_661_2 + arg_661_0 and not isNil(var_661_0) and arg_658_1.var_.characterEffect1047ui_story then
				arg_658_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_661_4 = 0

			if var_661_4 < arg_658_1.time_ and arg_658_1.time_ <= var_661_4 + arg_661_0 then
				arg_658_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			local var_661_5 = 0

			if var_661_5 < arg_658_1.time_ and arg_658_1.time_ <= var_661_5 + arg_661_0 then
				arg_658_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_661_6 = 0
			local var_661_7 = 0.45

			if var_661_6 < arg_658_1.time_ and arg_658_1.time_ <= var_661_6 + arg_661_0 then
				arg_658_1.talkMaxDuration = 0
				arg_658_1.dialogCg_.alpha = 1

				arg_658_1.dialog_:SetActive(true)
				SetActive(arg_658_1.leftNameGo_, true)

				local var_661_8 = arg_658_1:FormatText(StoryNameCfg[1296].name)

				arg_658_1.leftNameTxt_.text = var_661_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_658_1.leftNameTxt_.transform)

				arg_658_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_658_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_658_1:RecordName(arg_658_1.leftNameTxt_.text)
				SetActive(arg_658_1.iconTrs_.gameObject, false)
				arg_658_1.callingController_:SetSelectedState("normal")

				local var_661_9 = arg_658_1:GetWordFromCfg(1104701163)
				local var_661_10 = arg_658_1:FormatText(var_661_9.content)

				arg_658_1.text_.text = var_661_10

				LuaForUtil.ClearLinePrefixSymbol(arg_658_1.text_)

				local var_661_11 = 18
				local var_661_12 = utf8.len(var_661_10)
				local var_661_13 = var_661_11 <= 0 and var_661_7 or var_661_7 * (var_661_12 / var_661_11)

				if var_661_13 > 0 and var_661_7 < var_661_13 then
					arg_658_1.talkMaxDuration = var_661_13

					if var_661_13 + var_661_6 > arg_658_1.duration_ then
						arg_658_1.duration_ = var_661_13 + var_661_6
					end
				end

				arg_658_1.text_.text = var_661_10
				arg_658_1.typewritter.percent = 0

				arg_658_1.typewritter:SetDirty()
				arg_658_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701163", "story_v_side_new_1104701.awb") ~= 0 then
					local var_661_14 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701163", "story_v_side_new_1104701.awb") / 1000

					if var_661_14 + var_661_6 > arg_658_1.duration_ then
						arg_658_1.duration_ = var_661_14 + var_661_6
					end

					if var_661_9.prefab_name ~= "" and arg_658_1.actors_[var_661_9.prefab_name] ~= nil then
						local var_661_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_658_1.actors_[var_661_9.prefab_name].transform, "story_v_side_new_1104701", "1104701163", "story_v_side_new_1104701.awb")

						arg_658_1:RecordAudio("1104701163", var_661_15)
						arg_658_1:RecordAudio("1104701163", var_661_15)
					else
						arg_658_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701163", "story_v_side_new_1104701.awb")
					end

					arg_658_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701163", "story_v_side_new_1104701.awb")
				end

				arg_658_1:RecordContent(arg_658_1.text_.text)
			end

			local var_661_16 = math.max(var_661_7, arg_658_1.talkMaxDuration)

			if var_661_6 <= arg_658_1.time_ and arg_658_1.time_ < var_661_6 + var_661_16 then
				arg_658_1.typewritter.percent = (arg_658_1.time_ - var_661_6) / var_661_16

				arg_658_1.typewritter:SetDirty()
			end

			if arg_658_1.time_ >= var_661_6 + var_661_16 and arg_658_1.time_ < var_661_6 + var_661_16 + arg_661_0 then
				arg_658_1.typewritter.percent = 1

				arg_658_1.typewritter:SetDirty()
				arg_658_1:ShowNextGo(true)
			end
		end

		arg_658_1.nodeConfigList_ = {}

		arg_658_1:InitPlayNodeList()
	end,
	Play1104701164 = function(arg_662_0, arg_662_1)
		arg_662_1.time_ = 0
		arg_662_1.frameCnt_ = 0
		arg_662_1.state_ = "playing"
		arg_662_1.curTalkId_ = 1104701164
		arg_662_1.duration_ = 5.23

		SetActive(arg_662_1.tipsGo_, false)

		function arg_662_1.onSingleLineFinish_()
			arg_662_1.onSingleLineUpdate_ = nil
			arg_662_1.onSingleLineFinish_ = nil
			arg_662_1.state_ = "waiting"
		end

		function arg_662_1.playNext_(arg_664_0)
			if arg_664_0 == 1 then
				arg_662_0:Play1104701165(arg_662_1)
			end
		end

		function arg_662_1.onSingleLineUpdate_(arg_665_0)
			local var_665_0 = 0
			local var_665_1 = 0.55

			if var_665_0 < arg_662_1.time_ and arg_662_1.time_ <= var_665_0 + arg_665_0 then
				arg_662_1.talkMaxDuration = 0
				arg_662_1.dialogCg_.alpha = 1

				arg_662_1.dialog_:SetActive(true)
				SetActive(arg_662_1.leftNameGo_, true)

				local var_665_2 = arg_662_1:FormatText(StoryNameCfg[1296].name)

				arg_662_1.leftNameTxt_.text = var_665_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_662_1.leftNameTxt_.transform)

				arg_662_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_662_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_662_1:RecordName(arg_662_1.leftNameTxt_.text)
				SetActive(arg_662_1.iconTrs_.gameObject, false)
				arg_662_1.callingController_:SetSelectedState("normal")

				local var_665_3 = arg_662_1:GetWordFromCfg(1104701164)
				local var_665_4 = arg_662_1:FormatText(var_665_3.content)

				arg_662_1.text_.text = var_665_4

				LuaForUtil.ClearLinePrefixSymbol(arg_662_1.text_)

				local var_665_5 = 22
				local var_665_6 = utf8.len(var_665_4)
				local var_665_7 = var_665_5 <= 0 and var_665_1 or var_665_1 * (var_665_6 / var_665_5)

				if var_665_7 > 0 and var_665_1 < var_665_7 then
					arg_662_1.talkMaxDuration = var_665_7

					if var_665_7 + var_665_0 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_7 + var_665_0
					end
				end

				arg_662_1.text_.text = var_665_4
				arg_662_1.typewritter.percent = 0

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701164", "story_v_side_new_1104701.awb") ~= 0 then
					local var_665_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701164", "story_v_side_new_1104701.awb") / 1000

					if var_665_8 + var_665_0 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_8 + var_665_0
					end

					if var_665_3.prefab_name ~= "" and arg_662_1.actors_[var_665_3.prefab_name] ~= nil then
						local var_665_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_662_1.actors_[var_665_3.prefab_name].transform, "story_v_side_new_1104701", "1104701164", "story_v_side_new_1104701.awb")

						arg_662_1:RecordAudio("1104701164", var_665_9)
						arg_662_1:RecordAudio("1104701164", var_665_9)
					else
						arg_662_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701164", "story_v_side_new_1104701.awb")
					end

					arg_662_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701164", "story_v_side_new_1104701.awb")
				end

				arg_662_1:RecordContent(arg_662_1.text_.text)
			end

			local var_665_10 = math.max(var_665_1, arg_662_1.talkMaxDuration)

			if var_665_0 <= arg_662_1.time_ and arg_662_1.time_ < var_665_0 + var_665_10 then
				arg_662_1.typewritter.percent = (arg_662_1.time_ - var_665_0) / var_665_10

				arg_662_1.typewritter:SetDirty()
			end

			if arg_662_1.time_ >= var_665_0 + var_665_10 and arg_662_1.time_ < var_665_0 + var_665_10 + arg_665_0 then
				arg_662_1.typewritter.percent = 1

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(true)
			end
		end

		arg_662_1.nodeConfigList_ = {}

		arg_662_1:InitPlayNodeList()
	end,
	Play1104701165 = function(arg_666_0, arg_666_1)
		arg_666_1.time_ = 0
		arg_666_1.frameCnt_ = 0
		arg_666_1.state_ = "playing"
		arg_666_1.curTalkId_ = 1104701165
		arg_666_1.duration_ = 5

		SetActive(arg_666_1.tipsGo_, false)

		function arg_666_1.onSingleLineFinish_()
			arg_666_1.onSingleLineUpdate_ = nil
			arg_666_1.onSingleLineFinish_ = nil
			arg_666_1.state_ = "waiting"
		end

		function arg_666_1.playNext_(arg_668_0)
			if arg_668_0 == 1 then
				arg_666_0:Play1104701166(arg_666_1)
			end
		end

		function arg_666_1.onSingleLineUpdate_(arg_669_0)
			local var_669_0 = arg_666_1.actors_["1047ui_story"]
			local var_669_1 = 0

			if var_669_1 < arg_666_1.time_ and arg_666_1.time_ <= var_669_1 + arg_669_0 and not isNil(var_669_0) and arg_666_1.var_.characterEffect1047ui_story == nil then
				arg_666_1.var_.characterEffect1047ui_story = var_669_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_669_2 = 0.200000002980232

			if var_669_1 <= arg_666_1.time_ and arg_666_1.time_ < var_669_1 + var_669_2 and not isNil(var_669_0) then
				local var_669_3 = (arg_666_1.time_ - var_669_1) / var_669_2

				if arg_666_1.var_.characterEffect1047ui_story and not isNil(var_669_0) then
					local var_669_4 = Mathf.Lerp(0, 0.5, var_669_3)

					arg_666_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_666_1.var_.characterEffect1047ui_story.fillRatio = var_669_4
				end
			end

			if arg_666_1.time_ >= var_669_1 + var_669_2 and arg_666_1.time_ < var_669_1 + var_669_2 + arg_669_0 and not isNil(var_669_0) and arg_666_1.var_.characterEffect1047ui_story then
				local var_669_5 = 0.5

				arg_666_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_666_1.var_.characterEffect1047ui_story.fillRatio = var_669_5
			end

			local var_669_6 = arg_666_1.actors_["1047ui_story"].transform
			local var_669_7 = 0

			if var_669_7 < arg_666_1.time_ and arg_666_1.time_ <= var_669_7 + arg_669_0 then
				arg_666_1.var_.moveOldPos1047ui_story = var_669_6.localPosition
			end

			local var_669_8 = 0.001

			if var_669_7 <= arg_666_1.time_ and arg_666_1.time_ < var_669_7 + var_669_8 then
				local var_669_9 = (arg_666_1.time_ - var_669_7) / var_669_8
				local var_669_10 = Vector3.New(0, 100, 0)

				var_669_6.localPosition = Vector3.Lerp(arg_666_1.var_.moveOldPos1047ui_story, var_669_10, var_669_9)

				local var_669_11 = manager.ui.mainCamera.transform.position - var_669_6.position

				var_669_6.forward = Vector3.New(var_669_11.x, var_669_11.y, var_669_11.z)

				local var_669_12 = var_669_6.localEulerAngles

				var_669_12.z = 0
				var_669_12.x = 0
				var_669_6.localEulerAngles = var_669_12
			end

			if arg_666_1.time_ >= var_669_7 + var_669_8 and arg_666_1.time_ < var_669_7 + var_669_8 + arg_669_0 then
				var_669_6.localPosition = Vector3.New(0, 100, 0)

				local var_669_13 = manager.ui.mainCamera.transform.position - var_669_6.position

				var_669_6.forward = Vector3.New(var_669_13.x, var_669_13.y, var_669_13.z)

				local var_669_14 = var_669_6.localEulerAngles

				var_669_14.z = 0
				var_669_14.x = 0
				var_669_6.localEulerAngles = var_669_14
			end

			local var_669_15 = 0
			local var_669_16 = 1.35

			if var_669_15 < arg_666_1.time_ and arg_666_1.time_ <= var_669_15 + arg_669_0 then
				arg_666_1.talkMaxDuration = 0
				arg_666_1.dialogCg_.alpha = 1

				arg_666_1.dialog_:SetActive(true)
				SetActive(arg_666_1.leftNameGo_, false)

				arg_666_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_666_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_666_1:RecordName(arg_666_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_666_1.iconTrs_.gameObject, false)
				arg_666_1.callingController_:SetSelectedState("normal")

				local var_669_17 = arg_666_1:GetWordFromCfg(1104701165)
				local var_669_18 = arg_666_1:FormatText(var_669_17.content)

				arg_666_1.text_.text = var_669_18

				LuaForUtil.ClearLinePrefixSymbol(arg_666_1.text_)

				local var_669_19 = 54
				local var_669_20 = utf8.len(var_669_18)
				local var_669_21 = var_669_19 <= 0 and var_669_16 or var_669_16 * (var_669_20 / var_669_19)

				if var_669_21 > 0 and var_669_16 < var_669_21 then
					arg_666_1.talkMaxDuration = var_669_21

					if var_669_21 + var_669_15 > arg_666_1.duration_ then
						arg_666_1.duration_ = var_669_21 + var_669_15
					end
				end

				arg_666_1.text_.text = var_669_18
				arg_666_1.typewritter.percent = 0

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(false)
				arg_666_1:RecordContent(arg_666_1.text_.text)
			end

			local var_669_22 = math.max(var_669_16, arg_666_1.talkMaxDuration)

			if var_669_15 <= arg_666_1.time_ and arg_666_1.time_ < var_669_15 + var_669_22 then
				arg_666_1.typewritter.percent = (arg_666_1.time_ - var_669_15) / var_669_22

				arg_666_1.typewritter:SetDirty()
			end

			if arg_666_1.time_ >= var_669_15 + var_669_22 and arg_666_1.time_ < var_669_15 + var_669_22 + arg_669_0 then
				arg_666_1.typewritter.percent = 1

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(true)
			end
		end

		arg_666_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_666_1:InitPlayNodeList()
	end,
	Play1104701166 = function(arg_670_0, arg_670_1)
		arg_670_1.time_ = 0
		arg_670_1.frameCnt_ = 0
		arg_670_1.state_ = "playing"
		arg_670_1.curTalkId_ = 1104701166
		arg_670_1.duration_ = 5

		SetActive(arg_670_1.tipsGo_, false)

		function arg_670_1.onSingleLineFinish_()
			arg_670_1.onSingleLineUpdate_ = nil
			arg_670_1.onSingleLineFinish_ = nil
			arg_670_1.state_ = "waiting"
		end

		function arg_670_1.playNext_(arg_672_0)
			if arg_672_0 == 1 then
				arg_670_0:Play1104701167(arg_670_1)
			end
		end

		function arg_670_1.onSingleLineUpdate_(arg_673_0)
			local var_673_0 = 0
			local var_673_1 = 0.35

			if var_673_0 < arg_670_1.time_ and arg_670_1.time_ <= var_673_0 + arg_673_0 then
				arg_670_1.talkMaxDuration = 0
				arg_670_1.dialogCg_.alpha = 1

				arg_670_1.dialog_:SetActive(true)
				SetActive(arg_670_1.leftNameGo_, false)

				arg_670_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_670_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_670_1:RecordName(arg_670_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_670_1.iconTrs_.gameObject, false)
				arg_670_1.callingController_:SetSelectedState("normal")

				local var_673_2 = arg_670_1:GetWordFromCfg(1104701166)
				local var_673_3 = arg_670_1:FormatText(var_673_2.content)

				arg_670_1.text_.text = var_673_3

				LuaForUtil.ClearLinePrefixSymbol(arg_670_1.text_)

				local var_673_4 = 14
				local var_673_5 = utf8.len(var_673_3)
				local var_673_6 = var_673_4 <= 0 and var_673_1 or var_673_1 * (var_673_5 / var_673_4)

				if var_673_6 > 0 and var_673_1 < var_673_6 then
					arg_670_1.talkMaxDuration = var_673_6

					if var_673_6 + var_673_0 > arg_670_1.duration_ then
						arg_670_1.duration_ = var_673_6 + var_673_0
					end
				end

				arg_670_1.text_.text = var_673_3
				arg_670_1.typewritter.percent = 0

				arg_670_1.typewritter:SetDirty()
				arg_670_1:ShowNextGo(false)
				arg_670_1:RecordContent(arg_670_1.text_.text)
			end

			local var_673_7 = math.max(var_673_1, arg_670_1.talkMaxDuration)

			if var_673_0 <= arg_670_1.time_ and arg_670_1.time_ < var_673_0 + var_673_7 then
				arg_670_1.typewritter.percent = (arg_670_1.time_ - var_673_0) / var_673_7

				arg_670_1.typewritter:SetDirty()
			end

			if arg_670_1.time_ >= var_673_0 + var_673_7 and arg_670_1.time_ < var_673_0 + var_673_7 + arg_673_0 then
				arg_670_1.typewritter.percent = 1

				arg_670_1.typewritter:SetDirty()
				arg_670_1:ShowNextGo(true)
			end
		end

		arg_670_1.nodeConfigList_ = {}

		arg_670_1:InitPlayNodeList()
	end,
	Play1104701167 = function(arg_674_0, arg_674_1)
		arg_674_1.time_ = 0
		arg_674_1.frameCnt_ = 0
		arg_674_1.state_ = "playing"
		arg_674_1.curTalkId_ = 1104701167
		arg_674_1.duration_ = 2.67

		SetActive(arg_674_1.tipsGo_, false)

		function arg_674_1.onSingleLineFinish_()
			arg_674_1.onSingleLineUpdate_ = nil
			arg_674_1.onSingleLineFinish_ = nil
			arg_674_1.state_ = "waiting"
			arg_674_1.auto_ = false
		end

		function arg_674_1.playNext_(arg_676_0)
			arg_674_1.onStoryFinished_()
		end

		function arg_674_1.onSingleLineUpdate_(arg_677_0)
			local var_677_0 = arg_674_1.actors_["1047ui_story"].transform
			local var_677_1 = 0

			if var_677_1 < arg_674_1.time_ and arg_674_1.time_ <= var_677_1 + arg_677_0 then
				arg_674_1.var_.moveOldPos1047ui_story = var_677_0.localPosition
			end

			local var_677_2 = 0.001

			if var_677_1 <= arg_674_1.time_ and arg_674_1.time_ < var_677_1 + var_677_2 then
				local var_677_3 = (arg_674_1.time_ - var_677_1) / var_677_2
				local var_677_4 = Vector3.New(0, -1.13, -6.2)

				var_677_0.localPosition = Vector3.Lerp(arg_674_1.var_.moveOldPos1047ui_story, var_677_4, var_677_3)

				local var_677_5 = manager.ui.mainCamera.transform.position - var_677_0.position

				var_677_0.forward = Vector3.New(var_677_5.x, var_677_5.y, var_677_5.z)

				local var_677_6 = var_677_0.localEulerAngles

				var_677_6.z = 0
				var_677_6.x = 0
				var_677_0.localEulerAngles = var_677_6
			end

			if arg_674_1.time_ >= var_677_1 + var_677_2 and arg_674_1.time_ < var_677_1 + var_677_2 + arg_677_0 then
				var_677_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_677_7 = manager.ui.mainCamera.transform.position - var_677_0.position

				var_677_0.forward = Vector3.New(var_677_7.x, var_677_7.y, var_677_7.z)

				local var_677_8 = var_677_0.localEulerAngles

				var_677_8.z = 0
				var_677_8.x = 0
				var_677_0.localEulerAngles = var_677_8
			end

			local var_677_9 = arg_674_1.actors_["1047ui_story"]
			local var_677_10 = 0

			if var_677_10 < arg_674_1.time_ and arg_674_1.time_ <= var_677_10 + arg_677_0 and not isNil(var_677_9) and arg_674_1.var_.characterEffect1047ui_story == nil then
				arg_674_1.var_.characterEffect1047ui_story = var_677_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_677_11 = 0.200000002980232

			if var_677_10 <= arg_674_1.time_ and arg_674_1.time_ < var_677_10 + var_677_11 and not isNil(var_677_9) then
				local var_677_12 = (arg_674_1.time_ - var_677_10) / var_677_11

				if arg_674_1.var_.characterEffect1047ui_story and not isNil(var_677_9) then
					arg_674_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_674_1.time_ >= var_677_10 + var_677_11 and arg_674_1.time_ < var_677_10 + var_677_11 + arg_677_0 and not isNil(var_677_9) and arg_674_1.var_.characterEffect1047ui_story then
				arg_674_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_677_13 = 0

			if var_677_13 < arg_674_1.time_ and arg_674_1.time_ <= var_677_13 + arg_677_0 then
				arg_674_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_677_14 = 0

			if var_677_14 < arg_674_1.time_ and arg_674_1.time_ <= var_677_14 + arg_677_0 then
				arg_674_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_677_15 = 0
			local var_677_16 = 1

			if var_677_15 < arg_674_1.time_ and arg_674_1.time_ <= var_677_15 + arg_677_0 then
				local var_677_17 = "play"
				local var_677_18 = "effect"

				arg_674_1:AudioAction(var_677_17, var_677_18, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_677_19 = 0
			local var_677_20 = 0.475

			if var_677_19 < arg_674_1.time_ and arg_674_1.time_ <= var_677_19 + arg_677_0 then
				arg_674_1.talkMaxDuration = 0
				arg_674_1.dialogCg_.alpha = 1

				arg_674_1.dialog_:SetActive(true)
				SetActive(arg_674_1.leftNameGo_, true)

				local var_677_21 = arg_674_1:FormatText(StoryNameCfg[1296].name)

				arg_674_1.leftNameTxt_.text = var_677_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_674_1.leftNameTxt_.transform)

				arg_674_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_674_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_674_1:RecordName(arg_674_1.leftNameTxt_.text)
				SetActive(arg_674_1.iconTrs_.gameObject, false)
				arg_674_1.callingController_:SetSelectedState("normal")

				local var_677_22 = arg_674_1:GetWordFromCfg(1104701167)
				local var_677_23 = arg_674_1:FormatText(var_677_22.content)

				arg_674_1.text_.text = var_677_23

				LuaForUtil.ClearLinePrefixSymbol(arg_674_1.text_)

				local var_677_24 = 19
				local var_677_25 = utf8.len(var_677_23)
				local var_677_26 = var_677_24 <= 0 and var_677_20 or var_677_20 * (var_677_25 / var_677_24)

				if var_677_26 > 0 and var_677_20 < var_677_26 then
					arg_674_1.talkMaxDuration = var_677_26

					if var_677_26 + var_677_19 > arg_674_1.duration_ then
						arg_674_1.duration_ = var_677_26 + var_677_19
					end
				end

				arg_674_1.text_.text = var_677_23
				arg_674_1.typewritter.percent = 0

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701167", "story_v_side_new_1104701.awb") ~= 0 then
					local var_677_27 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701167", "story_v_side_new_1104701.awb") / 1000

					if var_677_27 + var_677_19 > arg_674_1.duration_ then
						arg_674_1.duration_ = var_677_27 + var_677_19
					end

					if var_677_22.prefab_name ~= "" and arg_674_1.actors_[var_677_22.prefab_name] ~= nil then
						local var_677_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_674_1.actors_[var_677_22.prefab_name].transform, "story_v_side_new_1104701", "1104701167", "story_v_side_new_1104701.awb")

						arg_674_1:RecordAudio("1104701167", var_677_28)
						arg_674_1:RecordAudio("1104701167", var_677_28)
					else
						arg_674_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701167", "story_v_side_new_1104701.awb")
					end

					arg_674_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701167", "story_v_side_new_1104701.awb")
				end

				arg_674_1:RecordContent(arg_674_1.text_.text)
			end

			local var_677_29 = math.max(var_677_20, arg_674_1.talkMaxDuration)

			if var_677_19 <= arg_674_1.time_ and arg_674_1.time_ < var_677_19 + var_677_29 then
				arg_674_1.typewritter.percent = (arg_674_1.time_ - var_677_19) / var_677_29

				arg_674_1.typewritter:SetDirty()
			end

			if arg_674_1.time_ >= var_677_19 + var_677_29 and arg_674_1.time_ < var_677_19 + var_677_29 + arg_677_0 then
				arg_674_1.typewritter.percent = 1

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(true)
			end
		end

		arg_674_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_674_1:InitPlayNodeList()
	end,
	Play1104701133 = function(arg_678_0, arg_678_1)
		arg_678_1.time_ = 0
		arg_678_1.frameCnt_ = 0
		arg_678_1.state_ = "playing"
		arg_678_1.curTalkId_ = 1104701133
		arg_678_1.duration_ = 6.93

		SetActive(arg_678_1.tipsGo_, false)

		function arg_678_1.onSingleLineFinish_()
			arg_678_1.onSingleLineUpdate_ = nil
			arg_678_1.onSingleLineFinish_ = nil
			arg_678_1.state_ = "waiting"
		end

		function arg_678_1.playNext_(arg_680_0)
			if arg_680_0 == 1 then
				arg_678_0:Play1104701134(arg_678_1)
			end
		end

		function arg_678_1.onSingleLineUpdate_(arg_681_0)
			local var_681_0 = arg_678_1.actors_["1047ui_story"].transform
			local var_681_1 = 0

			if var_681_1 < arg_678_1.time_ and arg_678_1.time_ <= var_681_1 + arg_681_0 then
				arg_678_1.var_.moveOldPos1047ui_story = var_681_0.localPosition
			end

			local var_681_2 = 0.001

			if var_681_1 <= arg_678_1.time_ and arg_678_1.time_ < var_681_1 + var_681_2 then
				local var_681_3 = (arg_678_1.time_ - var_681_1) / var_681_2
				local var_681_4 = Vector3.New(0, -1.13, -6.2)

				var_681_0.localPosition = Vector3.Lerp(arg_678_1.var_.moveOldPos1047ui_story, var_681_4, var_681_3)

				local var_681_5 = manager.ui.mainCamera.transform.position - var_681_0.position

				var_681_0.forward = Vector3.New(var_681_5.x, var_681_5.y, var_681_5.z)

				local var_681_6 = var_681_0.localEulerAngles

				var_681_6.z = 0
				var_681_6.x = 0
				var_681_0.localEulerAngles = var_681_6
			end

			if arg_678_1.time_ >= var_681_1 + var_681_2 and arg_678_1.time_ < var_681_1 + var_681_2 + arg_681_0 then
				var_681_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_681_7 = manager.ui.mainCamera.transform.position - var_681_0.position

				var_681_0.forward = Vector3.New(var_681_7.x, var_681_7.y, var_681_7.z)

				local var_681_8 = var_681_0.localEulerAngles

				var_681_8.z = 0
				var_681_8.x = 0
				var_681_0.localEulerAngles = var_681_8
			end

			local var_681_9 = "1047ui_story"

			if arg_678_1.actors_[var_681_9] == nil then
				local var_681_10 = Asset.Load("Char/" .. "1047ui_story")

				if not isNil(var_681_10) then
					local var_681_11 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_678_1.stage_.transform)

					var_681_11.name = var_681_9
					var_681_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_678_1.actors_[var_681_9] = var_681_11

					local var_681_12 = var_681_11:GetComponentInChildren(typeof(CharacterEffect))

					var_681_12.enabled = true

					local var_681_13 = GameObjectTools.GetOrAddComponent(var_681_11, typeof(DynamicBoneHelper))

					if var_681_13 then
						var_681_13:EnableDynamicBone(false)
					end

					arg_678_1:ShowWeapon(var_681_12.transform, false)

					arg_678_1.var_[var_681_9 .. "Animator"] = var_681_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_678_1.var_[var_681_9 .. "Animator"].applyRootMotion = true
					arg_678_1.var_[var_681_9 .. "LipSync"] = var_681_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_681_14 = 0

			if var_681_14 < arg_678_1.time_ and arg_678_1.time_ <= var_681_14 + arg_681_0 then
				arg_678_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			local var_681_15 = "1047ui_story"

			if arg_678_1.actors_[var_681_15] == nil then
				local var_681_16 = Asset.Load("Char/" .. "1047ui_story")

				if not isNil(var_681_16) then
					local var_681_17 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_678_1.stage_.transform)

					var_681_17.name = var_681_15
					var_681_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_678_1.actors_[var_681_15] = var_681_17

					local var_681_18 = var_681_17:GetComponentInChildren(typeof(CharacterEffect))

					var_681_18.enabled = true

					local var_681_19 = GameObjectTools.GetOrAddComponent(var_681_17, typeof(DynamicBoneHelper))

					if var_681_19 then
						var_681_19:EnableDynamicBone(false)
					end

					arg_678_1:ShowWeapon(var_681_18.transform, false)

					arg_678_1.var_[var_681_15 .. "Animator"] = var_681_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_678_1.var_[var_681_15 .. "Animator"].applyRootMotion = true
					arg_678_1.var_[var_681_15 .. "LipSync"] = var_681_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_681_20 = 0

			if var_681_20 < arg_678_1.time_ and arg_678_1.time_ <= var_681_20 + arg_681_0 then
				arg_678_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_681_21 = arg_678_1.actors_["1047ui_story"]
			local var_681_22 = 0

			if var_681_22 < arg_678_1.time_ and arg_678_1.time_ <= var_681_22 + arg_681_0 and not isNil(var_681_21) and arg_678_1.var_.characterEffect1047ui_story == nil then
				arg_678_1.var_.characterEffect1047ui_story = var_681_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_681_23 = 0.200000002980232

			if var_681_22 <= arg_678_1.time_ and arg_678_1.time_ < var_681_22 + var_681_23 and not isNil(var_681_21) then
				local var_681_24 = (arg_678_1.time_ - var_681_22) / var_681_23

				if arg_678_1.var_.characterEffect1047ui_story and not isNil(var_681_21) then
					arg_678_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_678_1.time_ >= var_681_22 + var_681_23 and arg_678_1.time_ < var_681_22 + var_681_23 + arg_681_0 and not isNil(var_681_21) and arg_678_1.var_.characterEffect1047ui_story then
				arg_678_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_681_25 = 0
			local var_681_26 = 0.65

			if var_681_25 < arg_678_1.time_ and arg_678_1.time_ <= var_681_25 + arg_681_0 then
				arg_678_1.talkMaxDuration = 0
				arg_678_1.dialogCg_.alpha = 1

				arg_678_1.dialog_:SetActive(true)
				SetActive(arg_678_1.leftNameGo_, true)

				local var_681_27 = arg_678_1:FormatText(StoryNameCfg[1296].name)

				arg_678_1.leftNameTxt_.text = var_681_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_678_1.leftNameTxt_.transform)

				arg_678_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_678_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_678_1:RecordName(arg_678_1.leftNameTxt_.text)
				SetActive(arg_678_1.iconTrs_.gameObject, false)
				arg_678_1.callingController_:SetSelectedState("normal")

				local var_681_28 = arg_678_1:GetWordFromCfg(1104701133)
				local var_681_29 = arg_678_1:FormatText(var_681_28.content)

				arg_678_1.text_.text = var_681_29

				LuaForUtil.ClearLinePrefixSymbol(arg_678_1.text_)

				local var_681_30 = 26
				local var_681_31 = utf8.len(var_681_29)
				local var_681_32 = var_681_30 <= 0 and var_681_26 or var_681_26 * (var_681_31 / var_681_30)

				if var_681_32 > 0 and var_681_26 < var_681_32 then
					arg_678_1.talkMaxDuration = var_681_32

					if var_681_32 + var_681_25 > arg_678_1.duration_ then
						arg_678_1.duration_ = var_681_32 + var_681_25
					end
				end

				arg_678_1.text_.text = var_681_29
				arg_678_1.typewritter.percent = 0

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701133", "story_v_side_new_1104701.awb") ~= 0 then
					local var_681_33 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701133", "story_v_side_new_1104701.awb") / 1000

					if var_681_33 + var_681_25 > arg_678_1.duration_ then
						arg_678_1.duration_ = var_681_33 + var_681_25
					end

					if var_681_28.prefab_name ~= "" and arg_678_1.actors_[var_681_28.prefab_name] ~= nil then
						local var_681_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_678_1.actors_[var_681_28.prefab_name].transform, "story_v_side_new_1104701", "1104701133", "story_v_side_new_1104701.awb")

						arg_678_1:RecordAudio("1104701133", var_681_34)
						arg_678_1:RecordAudio("1104701133", var_681_34)
					else
						arg_678_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701133", "story_v_side_new_1104701.awb")
					end

					arg_678_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701133", "story_v_side_new_1104701.awb")
				end

				arg_678_1:RecordContent(arg_678_1.text_.text)
			end

			local var_681_35 = math.max(var_681_26, arg_678_1.talkMaxDuration)

			if var_681_25 <= arg_678_1.time_ and arg_678_1.time_ < var_681_25 + var_681_35 then
				arg_678_1.typewritter.percent = (arg_678_1.time_ - var_681_25) / var_681_35

				arg_678_1.typewritter:SetDirty()
			end

			if arg_678_1.time_ >= var_681_25 + var_681_35 and arg_678_1.time_ < var_681_25 + var_681_35 + arg_681_0 then
				arg_678_1.typewritter.percent = 1

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(true)
			end
		end

		arg_678_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_678_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST05a",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/B13b",
		"TextureConfig/Background/ST22"
	},
	voices = {
		"story_v_side_new_1104701.awb"
	}
}
