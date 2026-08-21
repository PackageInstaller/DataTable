return {
	Play116161001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116161001
		arg_1_1.duration_ = 4.83

		local var_1_0 = {
			zh = 4.833,
			ja = 3.633333333332
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
				arg_1_0:Play116161002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "SK0103"

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
				local var_4_5 = arg_1_1.bgs_.SK0103

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
					if iter_4_0 ~= "SK0103" then
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
			local var_4_23 = 0.566666666666667

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

			local var_4_28 = arg_1_1.bgs_.SK0103.transform
			local var_4_29 = 0

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.var_.moveOldPosSK0103 = var_4_28.localPosition
			end

			local var_4_30 = 3

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30
				local var_4_32 = Vector3.New(0, 1, 9.5)

				var_4_28.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosSK0103, var_4_32, var_4_31)
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 then
				var_4_28.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_4_33 = 2

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_34 = 1

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_35 = 2
			local var_4_36 = 0.2

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_37 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_37:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_38 = arg_1_1:FormatText(StoryNameCfg[328].name)

				arg_1_1.leftNameTxt_.text = var_4_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_39 = arg_1_1:GetWordFromCfg(116161001)
				local var_4_40 = arg_1_1:FormatText(var_4_39.content)

				arg_1_1.text_.text = var_4_40

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_41 = 8
				local var_4_42 = utf8.len(var_4_40)
				local var_4_43 = var_4_41 <= 0 and var_4_36 or var_4_36 * (var_4_42 / var_4_41)

				if var_4_43 > 0 and var_4_36 < var_4_43 then
					arg_1_1.talkMaxDuration = var_4_43
					var_4_35 = var_4_35 + 0.3

					if var_4_43 + var_4_35 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_35
					end
				end

				arg_1_1.text_.text = var_4_40
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161001", "story_v_out_116161.awb") ~= 0 then
					local var_4_44 = manager.audio:GetVoiceLength("story_v_out_116161", "116161001", "story_v_out_116161.awb") / 1000

					if var_4_44 + var_4_35 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_35
					end

					if var_4_39.prefab_name ~= "" and arg_1_1.actors_[var_4_39.prefab_name] ~= nil then
						local var_4_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_39.prefab_name].transform, "story_v_out_116161", "116161001", "story_v_out_116161.awb")

						arg_1_1:RecordAudio("116161001", var_4_45)
						arg_1_1:RecordAudio("116161001", var_4_45)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_116161", "116161001", "story_v_out_116161.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_116161", "116161001", "story_v_out_116161.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_46 = var_4_35 + 0.3
			local var_4_47 = math.max(var_4_36, arg_1_1.talkMaxDuration)

			if var_4_46 <= arg_1_1.time_ and arg_1_1.time_ < var_4_46 + var_4_47 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_46) / var_4_47

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_46 + var_4_47 and arg_1_1.time_ < var_4_46 + var_4_47 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play116161002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 116161002
		arg_8_1.duration_ = 8.33

		local var_8_0 = {
			zh = 8.333,
			ja = 5.666
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play116161003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "SK0112"

			if arg_8_1.bgs_[var_11_0] == nil then
				local var_11_1 = Object.Instantiate(arg_8_1.paintGo_)

				var_11_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_11_0)
				var_11_1.name = var_11_0
				var_11_1.transform.parent = arg_8_1.stage_.transform
				var_11_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.bgs_[var_11_0] = var_11_1
			end

			local var_11_2 = 2

			if var_11_2 < arg_8_1.time_ and arg_8_1.time_ <= var_11_2 + arg_11_0 then
				local var_11_3 = manager.ui.mainCamera.transform.localPosition
				local var_11_4 = Vector3.New(0, 0, 10) + Vector3.New(var_11_3.x, var_11_3.y, 0)
				local var_11_5 = arg_8_1.bgs_.SK0112

				var_11_5.transform.localPosition = var_11_4
				var_11_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_11_6 = var_11_5:GetComponent("SpriteRenderer")

				if var_11_6 and var_11_6.sprite then
					local var_11_7 = (var_11_5.transform.localPosition - var_11_3).z
					local var_11_8 = manager.ui.mainCameraCom_
					local var_11_9 = 2 * var_11_7 * Mathf.Tan(var_11_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_11_10 = var_11_9 * var_11_8.aspect
					local var_11_11 = var_11_6.sprite.bounds.size.x
					local var_11_12 = var_11_6.sprite.bounds.size.y
					local var_11_13 = var_11_10 / var_11_11
					local var_11_14 = var_11_9 / var_11_12
					local var_11_15 = var_11_14 < var_11_13 and var_11_13 or var_11_14

					var_11_5.transform.localScale = Vector3.New(var_11_15, var_11_15, 0)
				end

				for iter_11_0, iter_11_1 in pairs(arg_8_1.bgs_) do
					if iter_11_0 ~= "SK0112" then
						iter_11_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_11_16 = 0

			if var_11_16 < arg_8_1.time_ and arg_8_1.time_ <= var_11_16 + arg_11_0 then
				arg_8_1.mask_.enabled = true
				arg_8_1.mask_.raycastTarget = true

				arg_8_1:SetGaussion(false)
			end

			local var_11_17 = 2

			if var_11_16 <= arg_8_1.time_ and arg_8_1.time_ < var_11_16 + var_11_17 then
				local var_11_18 = (arg_8_1.time_ - var_11_16) / var_11_17
				local var_11_19 = Color.New(0, 0, 0)

				var_11_19.a = Mathf.Lerp(0, 1, var_11_18)
				arg_8_1.mask_.color = var_11_19
			end

			if arg_8_1.time_ >= var_11_16 + var_11_17 and arg_8_1.time_ < var_11_16 + var_11_17 + arg_11_0 then
				local var_11_20 = Color.New(0, 0, 0)

				var_11_20.a = 1
				arg_8_1.mask_.color = var_11_20
			end

			local var_11_21 = 2

			if var_11_21 < arg_8_1.time_ and arg_8_1.time_ <= var_11_21 + arg_11_0 then
				arg_8_1.mask_.enabled = true
				arg_8_1.mask_.raycastTarget = true

				arg_8_1:SetGaussion(false)
			end

			local var_11_22 = 2

			if var_11_21 <= arg_8_1.time_ and arg_8_1.time_ < var_11_21 + var_11_22 then
				local var_11_23 = (arg_8_1.time_ - var_11_21) / var_11_22
				local var_11_24 = Color.New(0, 0, 0)

				var_11_24.a = Mathf.Lerp(1, 0, var_11_23)
				arg_8_1.mask_.color = var_11_24
			end

			if arg_8_1.time_ >= var_11_21 + var_11_22 and arg_8_1.time_ < var_11_21 + var_11_22 + arg_11_0 then
				local var_11_25 = Color.New(0, 0, 0)
				local var_11_26 = 0

				arg_8_1.mask_.enabled = false
				var_11_25.a = var_11_26
				arg_8_1.mask_.color = var_11_25
			end

			local var_11_27 = arg_8_1.bgs_.SK0112.transform
			local var_11_28 = 2

			if var_11_28 < arg_8_1.time_ and arg_8_1.time_ <= var_11_28 + arg_11_0 then
				arg_8_1.var_.moveOldPosSK0112 = var_11_27.localPosition
			end

			local var_11_29 = 3

			if var_11_28 <= arg_8_1.time_ and arg_8_1.time_ < var_11_28 + var_11_29 then
				local var_11_30 = (arg_8_1.time_ - var_11_28) / var_11_29
				local var_11_31 = Vector3.New(0, 1, 9.5)

				var_11_27.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPosSK0112, var_11_31, var_11_30)
			end

			if arg_8_1.time_ >= var_11_28 + var_11_29 and arg_8_1.time_ < var_11_28 + var_11_29 + arg_11_0 then
				var_11_27.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_11_32 = 4

			if var_11_32 < arg_8_1.time_ and arg_8_1.time_ <= var_11_32 + arg_11_0 then
				arg_8_1.allBtn_.enabled = false
			end

			local var_11_33 = 1

			if arg_8_1.time_ >= var_11_32 + var_11_33 and arg_8_1.time_ < var_11_32 + var_11_33 + arg_11_0 then
				arg_8_1.allBtn_.enabled = true
			end

			if arg_8_1.frameCnt_ <= 1 then
				arg_8_1.dialog_:SetActive(false)
			end

			local var_11_34 = 4
			local var_11_35 = 0.375

			if var_11_34 < arg_8_1.time_ and arg_8_1.time_ <= var_11_34 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0

				arg_8_1.dialog_:SetActive(true)

				arg_8_1.dialogCg_.alpha = 0

				local var_11_36 = LeanTween.value(arg_8_1.dialog_, 0, 1, 0.3)

				var_11_36:setOnUpdate(LuaHelper.FloatAction(function(arg_12_0)
					arg_8_1.dialogCg_.alpha = arg_12_0
				end))
				var_11_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_8_1.dialog_)
					var_11_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_8_1.duration_ = arg_8_1.duration_ + 0.3

				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_37 = arg_8_1:FormatText(StoryNameCfg[328].name)

				arg_8_1.leftNameTxt_.text = var_11_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_38 = arg_8_1:GetWordFromCfg(116161002)
				local var_11_39 = arg_8_1:FormatText(var_11_38.content)

				arg_8_1.text_.text = var_11_39

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_40 = 15
				local var_11_41 = utf8.len(var_11_39)
				local var_11_42 = var_11_40 <= 0 and var_11_35 or var_11_35 * (var_11_41 / var_11_40)

				if var_11_42 > 0 and var_11_35 < var_11_42 then
					arg_8_1.talkMaxDuration = var_11_42
					var_11_34 = var_11_34 + 0.3

					if var_11_42 + var_11_34 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_42 + var_11_34
					end
				end

				arg_8_1.text_.text = var_11_39
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161002", "story_v_out_116161.awb") ~= 0 then
					local var_11_43 = manager.audio:GetVoiceLength("story_v_out_116161", "116161002", "story_v_out_116161.awb") / 1000

					if var_11_43 + var_11_34 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_43 + var_11_34
					end

					if var_11_38.prefab_name ~= "" and arg_8_1.actors_[var_11_38.prefab_name] ~= nil then
						local var_11_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_38.prefab_name].transform, "story_v_out_116161", "116161002", "story_v_out_116161.awb")

						arg_8_1:RecordAudio("116161002", var_11_44)
						arg_8_1:RecordAudio("116161002", var_11_44)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_116161", "116161002", "story_v_out_116161.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_116161", "116161002", "story_v_out_116161.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_45 = var_11_34 + 0.3
			local var_11_46 = math.max(var_11_35, arg_8_1.talkMaxDuration)

			if var_11_45 <= arg_8_1.time_ and arg_8_1.time_ < var_11_45 + var_11_46 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_45) / var_11_46

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_45 + var_11_46 and arg_8_1.time_ < var_11_45 + var_11_46 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0112",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play116161003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 116161003
		arg_14_1.duration_ = 7.2

		local var_14_0 = {
			zh = 6.86666666666667,
			ja = 7.19966666666667
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play116161004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = "SK0107"

			if arg_14_1.bgs_[var_17_0] == nil then
				local var_17_1 = Object.Instantiate(arg_14_1.paintGo_)

				var_17_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_17_0)
				var_17_1.name = var_17_0
				var_17_1.transform.parent = arg_14_1.stage_.transform
				var_17_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_14_1.bgs_[var_17_0] = var_17_1
			end

			local var_17_2 = 2

			if var_17_2 < arg_14_1.time_ and arg_14_1.time_ <= var_17_2 + arg_17_0 then
				local var_17_3 = manager.ui.mainCamera.transform.localPosition
				local var_17_4 = Vector3.New(0, 0, 10) + Vector3.New(var_17_3.x, var_17_3.y, 0)
				local var_17_5 = arg_14_1.bgs_.SK0107

				var_17_5.transform.localPosition = var_17_4
				var_17_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_17_6 = var_17_5:GetComponent("SpriteRenderer")

				if var_17_6 and var_17_6.sprite then
					local var_17_7 = (var_17_5.transform.localPosition - var_17_3).z
					local var_17_8 = manager.ui.mainCameraCom_
					local var_17_9 = 2 * var_17_7 * Mathf.Tan(var_17_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_17_10 = var_17_9 * var_17_8.aspect
					local var_17_11 = var_17_6.sprite.bounds.size.x
					local var_17_12 = var_17_6.sprite.bounds.size.y
					local var_17_13 = var_17_10 / var_17_11
					local var_17_14 = var_17_9 / var_17_12
					local var_17_15 = var_17_14 < var_17_13 and var_17_13 or var_17_14

					var_17_5.transform.localScale = Vector3.New(var_17_15, var_17_15, 0)
				end

				for iter_17_0, iter_17_1 in pairs(arg_14_1.bgs_) do
					if iter_17_0 ~= "SK0107" then
						iter_17_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_17_16 = 0

			if var_17_16 < arg_14_1.time_ and arg_14_1.time_ <= var_17_16 + arg_17_0 then
				arg_14_1.mask_.enabled = true
				arg_14_1.mask_.raycastTarget = true

				arg_14_1:SetGaussion(false)
			end

			local var_17_17 = 2

			if var_17_16 <= arg_14_1.time_ and arg_14_1.time_ < var_17_16 + var_17_17 then
				local var_17_18 = (arg_14_1.time_ - var_17_16) / var_17_17
				local var_17_19 = Color.New(0, 0, 0)

				var_17_19.a = Mathf.Lerp(0, 1, var_17_18)
				arg_14_1.mask_.color = var_17_19
			end

			if arg_14_1.time_ >= var_17_16 + var_17_17 and arg_14_1.time_ < var_17_16 + var_17_17 + arg_17_0 then
				local var_17_20 = Color.New(0, 0, 0)

				var_17_20.a = 1
				arg_14_1.mask_.color = var_17_20
			end

			local var_17_21 = 2

			if var_17_21 < arg_14_1.time_ and arg_14_1.time_ <= var_17_21 + arg_17_0 then
				arg_14_1.mask_.enabled = true
				arg_14_1.mask_.raycastTarget = true

				arg_14_1:SetGaussion(false)
			end

			local var_17_22 = 2

			if var_17_21 <= arg_14_1.time_ and arg_14_1.time_ < var_17_21 + var_17_22 then
				local var_17_23 = (arg_14_1.time_ - var_17_21) / var_17_22
				local var_17_24 = Color.New(0, 0, 0)

				var_17_24.a = Mathf.Lerp(1, 0, var_17_23)
				arg_14_1.mask_.color = var_17_24
			end

			if arg_14_1.time_ >= var_17_21 + var_17_22 and arg_14_1.time_ < var_17_21 + var_17_22 + arg_17_0 then
				local var_17_25 = Color.New(0, 0, 0)
				local var_17_26 = 0

				arg_14_1.mask_.enabled = false
				var_17_25.a = var_17_26
				arg_14_1.mask_.color = var_17_25
			end

			local var_17_27 = arg_14_1.bgs_.SK0107.transform
			local var_17_28 = 2

			if var_17_28 < arg_14_1.time_ and arg_14_1.time_ <= var_17_28 + arg_17_0 then
				arg_14_1.var_.moveOldPosSK0107 = var_17_27.localPosition
			end

			local var_17_29 = 3

			if var_17_28 <= arg_14_1.time_ and arg_14_1.time_ < var_17_28 + var_17_29 then
				local var_17_30 = (arg_14_1.time_ - var_17_28) / var_17_29
				local var_17_31 = Vector3.New(0, 1, 9.5)

				var_17_27.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPosSK0107, var_17_31, var_17_30)
			end

			if arg_14_1.time_ >= var_17_28 + var_17_29 and arg_14_1.time_ < var_17_28 + var_17_29 + arg_17_0 then
				var_17_27.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_17_32 = 4

			if var_17_32 < arg_14_1.time_ and arg_14_1.time_ <= var_17_32 + arg_17_0 then
				arg_14_1.allBtn_.enabled = false
			end

			local var_17_33 = 1

			if arg_14_1.time_ >= var_17_32 + var_17_33 and arg_14_1.time_ < var_17_32 + var_17_33 + arg_17_0 then
				arg_14_1.allBtn_.enabled = true
			end

			if arg_14_1.frameCnt_ <= 1 then
				arg_14_1.dialog_:SetActive(false)
			end

			local var_17_34 = 3.96666666666667
			local var_17_35 = 0.175

			if var_17_34 < arg_14_1.time_ and arg_14_1.time_ <= var_17_34 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				arg_14_1.dialog_:SetActive(true)

				arg_14_1.dialogCg_.alpha = 0

				local var_17_36 = LeanTween.value(arg_14_1.dialog_, 0, 1, 0.3)

				var_17_36:setOnUpdate(LuaHelper.FloatAction(function(arg_18_0)
					arg_14_1.dialogCg_.alpha = arg_18_0
				end))
				var_17_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_14_1.dialog_)
					var_17_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_14_1.duration_ = arg_14_1.duration_ + 0.3

				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_37 = arg_14_1:FormatText(StoryNameCfg[328].name)

				arg_14_1.leftNameTxt_.text = var_17_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_38 = arg_14_1:GetWordFromCfg(116161003)
				local var_17_39 = arg_14_1:FormatText(var_17_38.content)

				arg_14_1.text_.text = var_17_39

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_40 = 7
				local var_17_41 = utf8.len(var_17_39)
				local var_17_42 = var_17_40 <= 0 and var_17_35 or var_17_35 * (var_17_41 / var_17_40)

				if var_17_42 > 0 and var_17_35 < var_17_42 then
					arg_14_1.talkMaxDuration = var_17_42
					var_17_34 = var_17_34 + 0.3

					if var_17_42 + var_17_34 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_42 + var_17_34
					end
				end

				arg_14_1.text_.text = var_17_39
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161003", "story_v_out_116161.awb") ~= 0 then
					local var_17_43 = manager.audio:GetVoiceLength("story_v_out_116161", "116161003", "story_v_out_116161.awb") / 1000

					if var_17_43 + var_17_34 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_43 + var_17_34
					end

					if var_17_38.prefab_name ~= "" and arg_14_1.actors_[var_17_38.prefab_name] ~= nil then
						local var_17_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_38.prefab_name].transform, "story_v_out_116161", "116161003", "story_v_out_116161.awb")

						arg_14_1:RecordAudio("116161003", var_17_44)
						arg_14_1:RecordAudio("116161003", var_17_44)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_116161", "116161003", "story_v_out_116161.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_116161", "116161003", "story_v_out_116161.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_45 = var_17_34 + 0.3
			local var_17_46 = math.max(var_17_35, arg_14_1.talkMaxDuration)

			if var_17_45 <= arg_14_1.time_ and arg_14_1.time_ < var_17_45 + var_17_46 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_45) / var_17_46

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_45 + var_17_46 and arg_14_1.time_ < var_17_45 + var_17_46 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0107",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play116161004 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 116161004
		arg_20_1.duration_ = 8.7

		local var_20_0 = {
			zh = 8.566,
			ja = 8.7
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
				arg_20_0:Play116161005(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "SK0106"

			if arg_20_1.bgs_[var_23_0] == nil then
				local var_23_1 = Object.Instantiate(arg_20_1.paintGo_)

				var_23_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_23_0)
				var_23_1.name = var_23_0
				var_23_1.transform.parent = arg_20_1.stage_.transform
				var_23_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.bgs_[var_23_0] = var_23_1
			end

			local var_23_2 = 2

			if var_23_2 < arg_20_1.time_ and arg_20_1.time_ <= var_23_2 + arg_23_0 then
				if arg_20_0.sceneSettingEffect_ then
					arg_20_1.sceneSettingEffect_.enabled = false
				end

				arg_20_1.sceneSettingGo_:SetActive(true)

				local var_23_3 = manager.ui.mainCamera.transform.localPosition
				local var_23_4 = Vector3.New(0, 0, 10) + Vector3.New(var_23_3.x, var_23_3.y, 0)
				local var_23_5 = arg_20_1.bgs_.SK0106

				var_23_5.transform.localPosition = var_23_4
				var_23_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_23_6 = var_23_5:GetComponent("SpriteRenderer")

				if var_23_6 and var_23_6.sprite then
					local var_23_7 = (var_23_5.transform.localPosition - var_23_3).z
					local var_23_8 = manager.ui.mainCameraCom_
					local var_23_9 = 2 * var_23_7 * Mathf.Tan(var_23_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_23_10 = var_23_9 * var_23_8.aspect
					local var_23_11 = var_23_6.sprite.bounds.size.x
					local var_23_12 = var_23_6.sprite.bounds.size.y
					local var_23_13 = var_23_10 / var_23_11
					local var_23_14 = var_23_9 / var_23_12
					local var_23_15 = var_23_14 < var_23_13 and var_23_13 or var_23_14

					var_23_5.transform.localScale = Vector3.New(var_23_15, var_23_15, 0)
				end

				for iter_23_0, iter_23_1 in pairs(arg_20_1.bgs_) do
					if iter_23_0 ~= "SK0106" then
						iter_23_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_23_16 = 0

			if var_23_16 < arg_20_1.time_ and arg_20_1.time_ <= var_23_16 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_17 = 2

			if var_23_16 <= arg_20_1.time_ and arg_20_1.time_ < var_23_16 + var_23_17 then
				local var_23_18 = (arg_20_1.time_ - var_23_16) / var_23_17
				local var_23_19 = Color.New(0, 0, 0)

				var_23_19.a = Mathf.Lerp(0, 1, var_23_18)
				arg_20_1.mask_.color = var_23_19
			end

			if arg_20_1.time_ >= var_23_16 + var_23_17 and arg_20_1.time_ < var_23_16 + var_23_17 + arg_23_0 then
				local var_23_20 = Color.New(0, 0, 0)

				var_23_20.a = 1
				arg_20_1.mask_.color = var_23_20
			end

			local var_23_21 = 2

			if var_23_21 < arg_20_1.time_ and arg_20_1.time_ <= var_23_21 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_22 = 2

			if var_23_21 <= arg_20_1.time_ and arg_20_1.time_ < var_23_21 + var_23_22 then
				local var_23_23 = (arg_20_1.time_ - var_23_21) / var_23_22
				local var_23_24 = Color.New(0, 0, 0)

				var_23_24.a = Mathf.Lerp(1, 0, var_23_23)
				arg_20_1.mask_.color = var_23_24
			end

			if arg_20_1.time_ >= var_23_21 + var_23_22 and arg_20_1.time_ < var_23_21 + var_23_22 + arg_23_0 then
				local var_23_25 = Color.New(0, 0, 0)
				local var_23_26 = 0

				arg_20_1.mask_.enabled = false
				var_23_25.a = var_23_26
				arg_20_1.mask_.color = var_23_25
			end

			local var_23_27 = arg_20_1.bgs_.SK0106.transform
			local var_23_28 = 2

			if var_23_28 < arg_20_1.time_ and arg_20_1.time_ <= var_23_28 + arg_23_0 then
				arg_20_1.var_.moveOldPosSK0106 = var_23_27.localPosition
			end

			local var_23_29 = 3

			if var_23_28 <= arg_20_1.time_ and arg_20_1.time_ < var_23_28 + var_23_29 then
				local var_23_30 = (arg_20_1.time_ - var_23_28) / var_23_29
				local var_23_31 = Vector3.New(0, 1, 9.5)

				var_23_27.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPosSK0106, var_23_31, var_23_30)
			end

			if arg_20_1.time_ >= var_23_28 + var_23_29 and arg_20_1.time_ < var_23_28 + var_23_29 + arg_23_0 then
				var_23_27.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_23_32 = 4

			if var_23_32 < arg_20_1.time_ and arg_20_1.time_ <= var_23_32 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			local var_23_33 = 1

			if arg_20_1.time_ >= var_23_32 + var_23_33 and arg_20_1.time_ < var_23_32 + var_23_33 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_34 = 4
			local var_23_35 = 0.366666666666666

			if var_23_34 < arg_20_1.time_ and arg_20_1.time_ <= var_23_34 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				arg_20_1.dialog_:SetActive(true)

				arg_20_1.dialogCg_.alpha = 0

				local var_23_36 = LeanTween.value(arg_20_1.dialog_, 0, 1, 0.3)

				var_23_36:setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
					arg_20_1.dialogCg_.alpha = arg_24_0
				end))
				var_23_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_20_1.dialog_)
					var_23_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_20_1.duration_ = arg_20_1.duration_ + 0.3

				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_37 = arg_20_1:FormatText(StoryNameCfg[328].name)

				arg_20_1.leftNameTxt_.text = var_23_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_38 = arg_20_1:GetWordFromCfg(116161004)
				local var_23_39 = arg_20_1:FormatText(var_23_38.content)

				arg_20_1.text_.text = var_23_39

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_40 = 17
				local var_23_41 = utf8.len(var_23_39)
				local var_23_42 = var_23_40 <= 0 and var_23_35 or var_23_35 * (var_23_41 / var_23_40)

				if var_23_42 > 0 and var_23_35 < var_23_42 then
					arg_20_1.talkMaxDuration = var_23_42
					var_23_34 = var_23_34 + 0.3

					if var_23_42 + var_23_34 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_42 + var_23_34
					end
				end

				arg_20_1.text_.text = var_23_39
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161004", "story_v_out_116161.awb") ~= 0 then
					local var_23_43 = manager.audio:GetVoiceLength("story_v_out_116161", "116161004", "story_v_out_116161.awb") / 1000

					if var_23_43 + var_23_34 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_43 + var_23_34
					end

					if var_23_38.prefab_name ~= "" and arg_20_1.actors_[var_23_38.prefab_name] ~= nil then
						local var_23_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_38.prefab_name].transform, "story_v_out_116161", "116161004", "story_v_out_116161.awb")

						arg_20_1:RecordAudio("116161004", var_23_44)
						arg_20_1:RecordAudio("116161004", var_23_44)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_116161", "116161004", "story_v_out_116161.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_116161", "116161004", "story_v_out_116161.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_45 = var_23_34 + 0.3
			local var_23_46 = math.max(var_23_35, arg_20_1.talkMaxDuration)

			if var_23_45 <= arg_20_1.time_ and arg_20_1.time_ < var_23_45 + var_23_46 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_45) / var_23_46

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_45 + var_23_46 and arg_20_1.time_ < var_23_45 + var_23_46 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0106",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play116161005 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 116161005
		arg_26_1.duration_ = 12.28

		local var_26_0 = {
			zh = 5.71666666666667,
			ja = 12.2826666666667
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play116161006(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = "STblack"

			if arg_26_1.bgs_[var_29_0] == nil then
				local var_29_1 = Object.Instantiate(arg_26_1.paintGo_)

				var_29_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_29_0)
				var_29_1.name = var_29_0
				var_29_1.transform.parent = arg_26_1.stage_.transform
				var_29_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_26_1.bgs_[var_29_0] = var_29_1
			end

			local var_29_2 = 2

			if var_29_2 < arg_26_1.time_ and arg_26_1.time_ <= var_29_2 + arg_29_0 then
				local var_29_3 = manager.ui.mainCamera.transform.localPosition
				local var_29_4 = Vector3.New(0, 0, 10) + Vector3.New(var_29_3.x, var_29_3.y, 0)
				local var_29_5 = arg_26_1.bgs_.STblack

				var_29_5.transform.localPosition = var_29_4
				var_29_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_29_6 = var_29_5:GetComponent("SpriteRenderer")

				if var_29_6 and var_29_6.sprite then
					local var_29_7 = (var_29_5.transform.localPosition - var_29_3).z
					local var_29_8 = manager.ui.mainCameraCom_
					local var_29_9 = 2 * var_29_7 * Mathf.Tan(var_29_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_29_10 = var_29_9 * var_29_8.aspect
					local var_29_11 = var_29_6.sprite.bounds.size.x
					local var_29_12 = var_29_6.sprite.bounds.size.y
					local var_29_13 = var_29_10 / var_29_11
					local var_29_14 = var_29_9 / var_29_12
					local var_29_15 = var_29_14 < var_29_13 and var_29_13 or var_29_14

					var_29_5.transform.localScale = Vector3.New(var_29_15, var_29_15, 0)
				end

				for iter_29_0, iter_29_1 in pairs(arg_26_1.bgs_) do
					if iter_29_0 ~= "STblack" then
						iter_29_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_29_16 = 0

			if var_29_16 < arg_26_1.time_ and arg_26_1.time_ <= var_29_16 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = true

				arg_26_1:SetGaussion(false)
			end

			local var_29_17 = 2

			if var_29_16 <= arg_26_1.time_ and arg_26_1.time_ < var_29_16 + var_29_17 then
				local var_29_18 = (arg_26_1.time_ - var_29_16) / var_29_17
				local var_29_19 = Color.New(0, 0, 0)

				var_29_19.a = Mathf.Lerp(0, 1, var_29_18)
				arg_26_1.mask_.color = var_29_19
			end

			if arg_26_1.time_ >= var_29_16 + var_29_17 and arg_26_1.time_ < var_29_16 + var_29_17 + arg_29_0 then
				local var_29_20 = Color.New(0, 0, 0)

				var_29_20.a = 1
				arg_26_1.mask_.color = var_29_20
			end

			local var_29_21 = 2

			if var_29_21 < arg_26_1.time_ and arg_26_1.time_ <= var_29_21 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = true

				arg_26_1:SetGaussion(false)
			end

			local var_29_22 = 0.0166666666666667

			if var_29_21 <= arg_26_1.time_ and arg_26_1.time_ < var_29_21 + var_29_22 then
				local var_29_23 = (arg_26_1.time_ - var_29_21) / var_29_22
				local var_29_24 = Color.New(0, 0, 0)

				var_29_24.a = Mathf.Lerp(1, 0, var_29_23)
				arg_26_1.mask_.color = var_29_24
			end

			if arg_26_1.time_ >= var_29_21 + var_29_22 and arg_26_1.time_ < var_29_21 + var_29_22 + arg_29_0 then
				local var_29_25 = Color.New(0, 0, 0)
				local var_29_26 = 0

				arg_26_1.mask_.enabled = false
				var_29_25.a = var_29_26
				arg_26_1.mask_.color = var_29_25
			end

			if arg_26_1.frameCnt_ <= 1 then
				arg_26_1.dialog_:SetActive(false)
			end

			local var_29_27 = 2.01666666666667
			local var_29_28 = 0.325

			if var_29_27 < arg_26_1.time_ and arg_26_1.time_ <= var_29_27 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0

				arg_26_1.dialog_:SetActive(true)

				arg_26_1.dialogCg_.alpha = 0

				local var_29_29 = LeanTween.value(arg_26_1.dialog_, 0, 1, 0.3)

				var_29_29:setOnUpdate(LuaHelper.FloatAction(function(arg_30_0)
					arg_26_1.dialogCg_.alpha = arg_30_0
				end))
				var_29_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_26_1.dialog_)
					var_29_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_26_1.duration_ = arg_26_1.duration_ + 0.3

				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_30 = arg_26_1:FormatText(StoryNameCfg[328].name)

				arg_26_1.leftNameTxt_.text = var_29_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_31 = arg_26_1:GetWordFromCfg(116161005)
				local var_29_32 = arg_26_1:FormatText(var_29_31.content)

				arg_26_1.text_.text = var_29_32

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_33 = 13
				local var_29_34 = utf8.len(var_29_32)
				local var_29_35 = var_29_33 <= 0 and var_29_28 or var_29_28 * (var_29_34 / var_29_33)

				if var_29_35 > 0 and var_29_28 < var_29_35 then
					arg_26_1.talkMaxDuration = var_29_35
					var_29_27 = var_29_27 + 0.3

					if var_29_35 + var_29_27 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_35 + var_29_27
					end
				end

				arg_26_1.text_.text = var_29_32
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161005", "story_v_out_116161.awb") ~= 0 then
					local var_29_36 = manager.audio:GetVoiceLength("story_v_out_116161", "116161005", "story_v_out_116161.awb") / 1000

					if var_29_36 + var_29_27 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_36 + var_29_27
					end

					if var_29_31.prefab_name ~= "" and arg_26_1.actors_[var_29_31.prefab_name] ~= nil then
						local var_29_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_31.prefab_name].transform, "story_v_out_116161", "116161005", "story_v_out_116161.awb")

						arg_26_1:RecordAudio("116161005", var_29_37)
						arg_26_1:RecordAudio("116161005", var_29_37)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_116161", "116161005", "story_v_out_116161.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_116161", "116161005", "story_v_out_116161.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_38 = var_29_27 + 0.3
			local var_29_39 = math.max(var_29_28, arg_26_1.talkMaxDuration)

			if var_29_38 <= arg_26_1.time_ and arg_26_1.time_ < var_29_38 + var_29_39 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_38) / var_29_39

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_38 + var_29_39 and arg_26_1.time_ < var_29_38 + var_29_39 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play116161006 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 116161006
		arg_32_1.duration_ = 7

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play116161007(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = "ST01"

			if arg_32_1.bgs_[var_35_0] == nil then
				local var_35_1 = Object.Instantiate(arg_32_1.paintGo_)

				var_35_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_35_0)
				var_35_1.name = var_35_0
				var_35_1.transform.parent = arg_32_1.stage_.transform
				var_35_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.bgs_[var_35_0] = var_35_1
			end

			local var_35_2 = 0

			if var_35_2 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 then
				local var_35_3 = manager.ui.mainCamera.transform.localPosition
				local var_35_4 = Vector3.New(0, 0, 10) + Vector3.New(var_35_3.x, var_35_3.y, 0)
				local var_35_5 = arg_32_1.bgs_.ST01

				var_35_5.transform.localPosition = var_35_4
				var_35_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_35_6 = var_35_5:GetComponent("SpriteRenderer")

				if var_35_6 and var_35_6.sprite then
					local var_35_7 = (var_35_5.transform.localPosition - var_35_3).z
					local var_35_8 = manager.ui.mainCameraCom_
					local var_35_9 = 2 * var_35_7 * Mathf.Tan(var_35_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_35_10 = var_35_9 * var_35_8.aspect
					local var_35_11 = var_35_6.sprite.bounds.size.x
					local var_35_12 = var_35_6.sprite.bounds.size.y
					local var_35_13 = var_35_10 / var_35_11
					local var_35_14 = var_35_9 / var_35_12
					local var_35_15 = var_35_14 < var_35_13 and var_35_13 or var_35_14

					var_35_5.transform.localScale = Vector3.New(var_35_15, var_35_15, 0)
				end

				for iter_35_0, iter_35_1 in pairs(arg_32_1.bgs_) do
					if iter_35_0 ~= "ST01" then
						iter_35_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_35_16 = 0

			if var_35_16 < arg_32_1.time_ and arg_32_1.time_ <= var_35_16 + arg_35_0 then
				arg_32_1.mask_.enabled = true
				arg_32_1.mask_.raycastTarget = true

				arg_32_1:SetGaussion(false)
			end

			local var_35_17 = 2

			if var_35_16 <= arg_32_1.time_ and arg_32_1.time_ < var_35_16 + var_35_17 then
				local var_35_18 = (arg_32_1.time_ - var_35_16) / var_35_17
				local var_35_19 = Color.New(0, 0, 0)

				var_35_19.a = Mathf.Lerp(1, 0, var_35_18)
				arg_32_1.mask_.color = var_35_19
			end

			if arg_32_1.time_ >= var_35_16 + var_35_17 and arg_32_1.time_ < var_35_16 + var_35_17 + arg_35_0 then
				local var_35_20 = Color.New(0, 0, 0)
				local var_35_21 = 0

				arg_32_1.mask_.enabled = false
				var_35_20.a = var_35_21
				arg_32_1.mask_.color = var_35_20
			end

			if arg_32_1.frameCnt_ <= 1 then
				arg_32_1.dialog_:SetActive(false)
			end

			local var_35_22 = 2
			local var_35_23 = 0.725

			if var_35_22 < arg_32_1.time_ and arg_32_1.time_ <= var_35_22 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				arg_32_1.dialog_:SetActive(true)

				arg_32_1.dialogCg_.alpha = 0

				local var_35_24 = LeanTween.value(arg_32_1.dialog_, 0, 1, 0.3)

				var_35_24:setOnUpdate(LuaHelper.FloatAction(function(arg_36_0)
					arg_32_1.dialogCg_.alpha = arg_36_0
				end))
				var_35_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_32_1.dialog_)
					var_35_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_32_1.duration_ = arg_32_1.duration_ + 0.3

				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_25 = arg_32_1:GetWordFromCfg(116161006)
				local var_35_26 = arg_32_1:FormatText(var_35_25.content)

				arg_32_1.text_.text = var_35_26

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_27 = 29
				local var_35_28 = utf8.len(var_35_26)
				local var_35_29 = var_35_27 <= 0 and var_35_23 or var_35_23 * (var_35_28 / var_35_27)

				if var_35_29 > 0 and var_35_23 < var_35_29 then
					arg_32_1.talkMaxDuration = var_35_29
					var_35_22 = var_35_22 + 0.3

					if var_35_29 + var_35_22 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_29 + var_35_22
					end
				end

				arg_32_1.text_.text = var_35_26
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_30 = var_35_22 + 0.3
			local var_35_31 = math.max(var_35_23, arg_32_1.talkMaxDuration)

			if var_35_30 <= arg_32_1.time_ and arg_32_1.time_ < var_35_30 + var_35_31 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_30) / var_35_31

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_30 + var_35_31 and arg_32_1.time_ < var_35_30 + var_35_31 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play116161007 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 116161007
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play116161008(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0
			local var_41_1 = 0.525

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_2 = arg_38_1:GetWordFromCfg(116161007)
				local var_41_3 = arg_38_1:FormatText(var_41_2.content)

				arg_38_1.text_.text = var_41_3

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_4 = 21
				local var_41_5 = utf8.len(var_41_3)
				local var_41_6 = var_41_4 <= 0 and var_41_1 or var_41_1 * (var_41_5 / var_41_4)

				if var_41_6 > 0 and var_41_1 < var_41_6 then
					arg_38_1.talkMaxDuration = var_41_6

					if var_41_6 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_6 + var_41_0
					end
				end

				arg_38_1.text_.text = var_41_3
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_7 = math.max(var_41_1, arg_38_1.talkMaxDuration)

			if var_41_0 <= arg_38_1.time_ and arg_38_1.time_ < var_41_0 + var_41_7 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_0) / var_41_7

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_0 + var_41_7 and arg_38_1.time_ < var_41_0 + var_41_7 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play116161008 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 116161008
		arg_42_1.duration_ = 9.17

		local var_42_0 = {
			zh = 7.566,
			ja = 9.166
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play116161009(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = manager.ui.mainCamera.transform
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.var_.shakeOldPos = var_45_0.localPosition
			end

			local var_45_2 = 0.6

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / 0.066
				local var_45_4, var_45_5 = math.modf(var_45_3)

				var_45_0.localPosition = Vector3.New(var_45_5 * 0.13, var_45_5 * 0.13, var_45_5 * 0.13) + arg_42_1.var_.shakeOldPos
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 then
				var_45_0.localPosition = arg_42_1.var_.shakeOldPos
			end

			local var_45_6 = 0

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 then
				arg_42_1.allBtn_.enabled = false
			end

			local var_45_7 = 0.6

			if arg_42_1.time_ >= var_45_6 + var_45_7 and arg_42_1.time_ < var_45_6 + var_45_7 + arg_45_0 then
				arg_42_1.allBtn_.enabled = true
			end

			local var_45_8 = 0
			local var_45_9 = 0.266666666666667

			if var_45_8 < arg_42_1.time_ and arg_42_1.time_ <= var_45_8 + arg_45_0 then
				local var_45_10 = "play"
				local var_45_11 = "music"

				arg_42_1:AudioAction(var_45_10, var_45_11, "ui_battle", "ui_battle_stopbgm", "")

				local var_45_12 = ""
				local var_45_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_45_13 ~= "" then
					if arg_42_1.bgmTxt_.text ~= var_45_13 and arg_42_1.bgmTxt_.text ~= "" then
						if arg_42_1.bgmTxt2_.text ~= "" then
							arg_42_1.bgmTxt_.text = arg_42_1.bgmTxt2_.text
						end

						arg_42_1.bgmTxt2_.text = var_45_13

						arg_42_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_42_1.bgmTxt_.text = var_45_13
						arg_42_1.bgmTxt2_.text = var_45_13
					end

					if arg_42_1.bgmTimer then
						arg_42_1.bgmTimer:Stop()

						arg_42_1.bgmTimer = nil
					end

					if arg_42_1.settingData.show_music_name == 1 then
						arg_42_1.musicController:SetSelectedState("show")
						arg_42_1.musicAnimator_:Play("open", 0, 0)

						if arg_42_1.settingData.music_time ~= 0 then
							arg_42_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_42_1.settingData.music_time), function()
								if arg_42_1 == nil or isNil(arg_42_1.bgmTxt_) then
									return
								end

								arg_42_1.musicController:SetSelectedState("hide")
								arg_42_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_45_14 = 0.4
			local var_45_15 = 0.6

			if var_45_14 < arg_42_1.time_ and arg_42_1.time_ <= var_45_14 + arg_45_0 then
				local var_45_16 = "play"
				local var_45_17 = "music"

				arg_42_1:AudioAction(var_45_16, var_45_17, "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story.awb")

				local var_45_18 = ""

				if var_45_18 ~= "" then
					if arg_42_1.bgmTxt_.text ~= var_45_18 and arg_42_1.bgmTxt_.text ~= "" then
						if arg_42_1.bgmTxt2_.text ~= "" then
							arg_42_1.bgmTxt_.text = arg_42_1.bgmTxt2_.text
						end

						arg_42_1.bgmTxt2_.text = var_45_18

						arg_42_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_42_1.bgmTxt_.text = var_45_18
						arg_42_1.bgmTxt2_.text = var_45_18
					end

					if arg_42_1.bgmTimer then
						arg_42_1.bgmTimer:Stop()

						arg_42_1.bgmTimer = nil
					end

					if arg_42_1.settingData.show_music_name == 1 then
						arg_42_1.musicController:SetSelectedState("show")
						arg_42_1.musicAnimator_:Play("open", 0, 0)

						if arg_42_1.settingData.music_time ~= 0 then
							arg_42_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_42_1.settingData.music_time), function()
								if arg_42_1 == nil or isNil(arg_42_1.bgmTxt_) then
									return
								end

								arg_42_1.musicController:SetSelectedState("hide")
								arg_42_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_45_19 = 0.575
			local var_45_20 = 0.425

			if var_45_19 < arg_42_1.time_ and arg_42_1.time_ <= var_45_19 + arg_45_0 then
				local var_45_21 = "play"
				local var_45_22 = "music"

				arg_42_1:AudioAction(var_45_21, var_45_22, "bgm_activity_1_6_story_story", "dialog", "bgm_activity_1_6_story_story.awb")

				local var_45_23 = ""
				local var_45_24 = MusicRecordCfg[95].musicName

				if var_45_24 ~= "" then
					if arg_42_1.bgmTxt_.text ~= var_45_24 and arg_42_1.bgmTxt_.text ~= "" then
						if arg_42_1.bgmTxt2_.text ~= "" then
							arg_42_1.bgmTxt_.text = arg_42_1.bgmTxt2_.text
						end

						arg_42_1.bgmTxt2_.text = var_45_24

						arg_42_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_42_1.bgmTxt_.text = var_45_24
						arg_42_1.bgmTxt2_.text = var_45_24
					end

					if arg_42_1.bgmTimer then
						arg_42_1.bgmTimer:Stop()

						arg_42_1.bgmTimer = nil
					end

					if arg_42_1.settingData.show_music_name == 1 then
						arg_42_1.musicController:SetSelectedState("show")
						arg_42_1.musicAnimator_:Play("open", 0, 0)

						if arg_42_1.settingData.music_time ~= 0 then
							arg_42_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_42_1.settingData.music_time), function()
								if arg_42_1 == nil or isNil(arg_42_1.bgmTxt_) then
									return
								end

								arg_42_1.musicController:SetSelectedState("hide")
								arg_42_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_45_25 = 0
			local var_45_26 = 0.575

			if var_45_25 < arg_42_1.time_ and arg_42_1.time_ <= var_45_25 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_27 = arg_42_1:FormatText(StoryNameCfg[328].name)

				arg_42_1.leftNameTxt_.text = var_45_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_28 = arg_42_1:GetWordFromCfg(116161008)
				local var_45_29 = arg_42_1:FormatText(var_45_28.content)

				arg_42_1.text_.text = var_45_29

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_30 = 23
				local var_45_31 = utf8.len(var_45_29)
				local var_45_32 = var_45_30 <= 0 and var_45_26 or var_45_26 * (var_45_31 / var_45_30)

				if var_45_32 > 0 and var_45_26 < var_45_32 then
					arg_42_1.talkMaxDuration = var_45_32

					if var_45_32 + var_45_25 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_32 + var_45_25
					end
				end

				arg_42_1.text_.text = var_45_29
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161008", "story_v_out_116161.awb") ~= 0 then
					local var_45_33 = manager.audio:GetVoiceLength("story_v_out_116161", "116161008", "story_v_out_116161.awb") / 1000

					if var_45_33 + var_45_25 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_33 + var_45_25
					end

					if var_45_28.prefab_name ~= "" and arg_42_1.actors_[var_45_28.prefab_name] ~= nil then
						local var_45_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_28.prefab_name].transform, "story_v_out_116161", "116161008", "story_v_out_116161.awb")

						arg_42_1:RecordAudio("116161008", var_45_34)
						arg_42_1:RecordAudio("116161008", var_45_34)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_116161", "116161008", "story_v_out_116161.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_116161", "116161008", "story_v_out_116161.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_35 = math.max(var_45_26, arg_42_1.talkMaxDuration)

			if var_45_25 <= arg_42_1.time_ and arg_42_1.time_ < var_45_25 + var_45_35 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_25) / var_45_35

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_25 + var_45_35 and arg_42_1.time_ < var_45_25 + var_45_35 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play116161009 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 116161009
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play116161010(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.875

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_2 = arg_49_1:GetWordFromCfg(116161009)
				local var_52_3 = arg_49_1:FormatText(var_52_2.content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 35
				local var_52_5 = utf8.len(var_52_3)
				local var_52_6 = var_52_4 <= 0 and var_52_1 or var_52_1 * (var_52_5 / var_52_4)

				if var_52_6 > 0 and var_52_1 < var_52_6 then
					arg_49_1.talkMaxDuration = var_52_6

					if var_52_6 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_7 and arg_49_1.time_ < var_52_0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play116161010 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 116161010
		arg_53_1.duration_ = 6

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play116161011(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_1 = 1

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_1 then
				local var_56_2 = (arg_53_1.time_ - var_56_0) / var_56_1
				local var_56_3 = Color.New(0, 0, 0)

				var_56_3.a = Mathf.Lerp(0, 1, var_56_2)
				arg_53_1.mask_.color = var_56_3
			end

			if arg_53_1.time_ >= var_56_0 + var_56_1 and arg_53_1.time_ < var_56_0 + var_56_1 + arg_56_0 then
				local var_56_4 = Color.New(0, 0, 0)

				var_56_4.a = 1
				arg_53_1.mask_.color = var_56_4
			end

			local var_56_5 = 1

			if var_56_5 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_6 = 1

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_6 then
				local var_56_7 = (arg_53_1.time_ - var_56_5) / var_56_6
				local var_56_8 = Color.New(0, 0, 0)

				var_56_8.a = Mathf.Lerp(1, 0, var_56_7)
				arg_53_1.mask_.color = var_56_8
			end

			if arg_53_1.time_ >= var_56_5 + var_56_6 and arg_53_1.time_ < var_56_5 + var_56_6 + arg_56_0 then
				local var_56_9 = Color.New(0, 0, 0)
				local var_56_10 = 0

				arg_53_1.mask_.enabled = false
				var_56_9.a = var_56_10
				arg_53_1.mask_.color = var_56_9
			end

			local var_56_11 = 0
			local var_56_12 = 1

			if var_56_11 < arg_53_1.time_ and arg_53_1.time_ <= var_56_11 + arg_56_0 then
				local var_56_13 = "play"
				local var_56_14 = "effect"

				arg_53_1:AudioAction(var_56_13, var_56_14, "se_story_16", "se_story_16_door05", "")
			end

			local var_56_15 = "10025ui_story"

			if arg_53_1.actors_[var_56_15] == nil then
				local var_56_16 = Asset.Load("Char/" .. "10025ui_story")

				if not isNil(var_56_16) then
					local var_56_17 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_53_1.stage_.transform)

					var_56_17.name = var_56_15
					var_56_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_53_1.actors_[var_56_15] = var_56_17

					local var_56_18 = var_56_17:GetComponentInChildren(typeof(CharacterEffect))

					var_56_18.enabled = true

					local var_56_19 = GameObjectTools.GetOrAddComponent(var_56_17, typeof(DynamicBoneHelper))

					if var_56_19 then
						var_56_19:EnableDynamicBone(false)
					end

					arg_53_1:ShowWeapon(var_56_18.transform, false)

					arg_53_1.var_[var_56_15 .. "Animator"] = var_56_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_53_1.var_[var_56_15 .. "Animator"].applyRootMotion = true
					arg_53_1.var_[var_56_15 .. "LipSync"] = var_56_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_56_20 = arg_53_1.actors_["10025ui_story"].transform
			local var_56_21 = 1

			if var_56_21 < arg_53_1.time_ and arg_53_1.time_ <= var_56_21 + arg_56_0 then
				arg_53_1.var_.moveOldPos10025ui_story = var_56_20.localPosition
			end

			local var_56_22 = 0.001

			if var_56_21 <= arg_53_1.time_ and arg_53_1.time_ < var_56_21 + var_56_22 then
				local var_56_23 = (arg_53_1.time_ - var_56_21) / var_56_22
				local var_56_24 = Vector3.New(0, -1.1, -5.9)

				var_56_20.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10025ui_story, var_56_24, var_56_23)

				local var_56_25 = manager.ui.mainCamera.transform.position - var_56_20.position

				var_56_20.forward = Vector3.New(var_56_25.x, var_56_25.y, var_56_25.z)

				local var_56_26 = var_56_20.localEulerAngles

				var_56_26.z = 0
				var_56_26.x = 0
				var_56_20.localEulerAngles = var_56_26
			end

			if arg_53_1.time_ >= var_56_21 + var_56_22 and arg_53_1.time_ < var_56_21 + var_56_22 + arg_56_0 then
				var_56_20.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_56_27 = manager.ui.mainCamera.transform.position - var_56_20.position

				var_56_20.forward = Vector3.New(var_56_27.x, var_56_27.y, var_56_27.z)

				local var_56_28 = var_56_20.localEulerAngles

				var_56_28.z = 0
				var_56_28.x = 0
				var_56_20.localEulerAngles = var_56_28
			end

			local var_56_29 = 1

			if var_56_29 < arg_53_1.time_ and arg_53_1.time_ <= var_56_29 + arg_56_0 then
				arg_53_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action1_1")
			end

			local var_56_30 = 1

			if var_56_30 < arg_53_1.time_ and arg_53_1.time_ <= var_56_30 + arg_56_0 then
				arg_53_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_56_31 = arg_53_1.actors_["10025ui_story"]
			local var_56_32 = 1

			if var_56_32 < arg_53_1.time_ and arg_53_1.time_ <= var_56_32 + arg_56_0 and not isNil(var_56_31) and arg_53_1.var_.characterEffect10025ui_story == nil then
				arg_53_1.var_.characterEffect10025ui_story = var_56_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_33 = 0.2

			if var_56_32 <= arg_53_1.time_ and arg_53_1.time_ < var_56_32 + var_56_33 and not isNil(var_56_31) then
				local var_56_34 = (arg_53_1.time_ - var_56_32) / var_56_33

				if arg_53_1.var_.characterEffect10025ui_story and not isNil(var_56_31) then
					local var_56_35 = Mathf.Lerp(0, 0.5, var_56_34)

					arg_53_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10025ui_story.fillRatio = var_56_35
				end
			end

			if arg_53_1.time_ >= var_56_32 + var_56_33 and arg_53_1.time_ < var_56_32 + var_56_33 + arg_56_0 and not isNil(var_56_31) and arg_53_1.var_.characterEffect10025ui_story then
				local var_56_36 = 0.5

				arg_53_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10025ui_story.fillRatio = var_56_36
			end

			if arg_53_1.frameCnt_ <= 1 then
				arg_53_1.dialog_:SetActive(false)
			end

			local var_56_37 = 1
			local var_56_38 = 0.1

			if var_56_37 < arg_53_1.time_ and arg_53_1.time_ <= var_56_37 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_39 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_39:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_53_1.dialogCg_.alpha = arg_57_0
				end))
				var_56_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_40 = arg_53_1:FormatText(StoryNameCfg[7].name)

				arg_53_1.leftNameTxt_.text = var_56_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_41 = arg_53_1:GetWordFromCfg(116161010)
				local var_56_42 = arg_53_1:FormatText(var_56_41.content)

				arg_53_1.text_.text = var_56_42

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_43 = 4
				local var_56_44 = utf8.len(var_56_42)
				local var_56_45 = var_56_43 <= 0 and var_56_38 or var_56_38 * (var_56_44 / var_56_43)

				if var_56_45 > 0 and var_56_38 < var_56_45 then
					arg_53_1.talkMaxDuration = var_56_45
					var_56_37 = var_56_37 + 0.3

					if var_56_45 + var_56_37 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_45 + var_56_37
					end
				end

				arg_53_1.text_.text = var_56_42
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_46 = var_56_37 + 0.3
			local var_56_47 = math.max(var_56_38, arg_53_1.talkMaxDuration)

			if var_56_46 <= arg_53_1.time_ and arg_53_1.time_ < var_56_46 + var_56_47 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_46) / var_56_47

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_46 + var_56_47 and arg_53_1.time_ < var_56_46 + var_56_47 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play116161011 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 116161011
		arg_59_1.duration_ = 2.9

		local var_59_0 = {
			zh = 2.8,
			ja = 2.9
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
				arg_59_0:Play116161012(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["10025ui_story"].transform
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.var_.moveOldPos10025ui_story = var_62_0.localPosition
			end

			local var_62_2 = 0.001

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2
				local var_62_4 = Vector3.New(0, -1.1, -5.9)

				var_62_0.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10025ui_story, var_62_4, var_62_3)

				local var_62_5 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_5.x, var_62_5.y, var_62_5.z)

				local var_62_6 = var_62_0.localEulerAngles

				var_62_6.z = 0
				var_62_6.x = 0
				var_62_0.localEulerAngles = var_62_6
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 then
				var_62_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_62_7 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_7.x, var_62_7.y, var_62_7.z)

				local var_62_8 = var_62_0.localEulerAngles

				var_62_8.z = 0
				var_62_8.x = 0
				var_62_0.localEulerAngles = var_62_8
			end

			local var_62_9 = arg_59_1.actors_["10025ui_story"]
			local var_62_10 = 0

			if var_62_10 < arg_59_1.time_ and arg_59_1.time_ <= var_62_10 + arg_62_0 and not isNil(var_62_9) and arg_59_1.var_.characterEffect10025ui_story == nil then
				arg_59_1.var_.characterEffect10025ui_story = var_62_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_11 = 0.2

			if var_62_10 <= arg_59_1.time_ and arg_59_1.time_ < var_62_10 + var_62_11 and not isNil(var_62_9) then
				local var_62_12 = (arg_59_1.time_ - var_62_10) / var_62_11

				if arg_59_1.var_.characterEffect10025ui_story and not isNil(var_62_9) then
					arg_59_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_10 + var_62_11 and arg_59_1.time_ < var_62_10 + var_62_11 + arg_62_0 and not isNil(var_62_9) and arg_59_1.var_.characterEffect10025ui_story then
				arg_59_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_62_13 = 0

			if var_62_13 < arg_59_1.time_ and arg_59_1.time_ <= var_62_13 + arg_62_0 then
				arg_59_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action2_1")
			end

			local var_62_14 = 0

			if var_62_14 < arg_59_1.time_ and arg_59_1.time_ <= var_62_14 + arg_62_0 then
				arg_59_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_62_15 = 0
			local var_62_16 = 0.15

			if var_62_15 < arg_59_1.time_ and arg_59_1.time_ <= var_62_15 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_17 = arg_59_1:FormatText(StoryNameCfg[328].name)

				arg_59_1.leftNameTxt_.text = var_62_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_18 = arg_59_1:GetWordFromCfg(116161011)
				local var_62_19 = arg_59_1:FormatText(var_62_18.content)

				arg_59_1.text_.text = var_62_19

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_20 = 6
				local var_62_21 = utf8.len(var_62_19)
				local var_62_22 = var_62_20 <= 0 and var_62_16 or var_62_16 * (var_62_21 / var_62_20)

				if var_62_22 > 0 and var_62_16 < var_62_22 then
					arg_59_1.talkMaxDuration = var_62_22

					if var_62_22 + var_62_15 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_22 + var_62_15
					end
				end

				arg_59_1.text_.text = var_62_19
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161011", "story_v_out_116161.awb") ~= 0 then
					local var_62_23 = manager.audio:GetVoiceLength("story_v_out_116161", "116161011", "story_v_out_116161.awb") / 1000

					if var_62_23 + var_62_15 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_23 + var_62_15
					end

					if var_62_18.prefab_name ~= "" and arg_59_1.actors_[var_62_18.prefab_name] ~= nil then
						local var_62_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_18.prefab_name].transform, "story_v_out_116161", "116161011", "story_v_out_116161.awb")

						arg_59_1:RecordAudio("116161011", var_62_24)
						arg_59_1:RecordAudio("116161011", var_62_24)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_116161", "116161011", "story_v_out_116161.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_116161", "116161011", "story_v_out_116161.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_25 = math.max(var_62_16, arg_59_1.talkMaxDuration)

			if var_62_15 <= arg_59_1.time_ and arg_59_1.time_ < var_62_15 + var_62_25 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_15) / var_62_25

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_15 + var_62_25 and arg_59_1.time_ < var_62_15 + var_62_25 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play116161012 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 116161012
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play116161013(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["10025ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect10025ui_story == nil then
				arg_63_1.var_.characterEffect10025ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.2

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect10025ui_story and not isNil(var_66_0) then
					local var_66_4 = Mathf.Lerp(0, 0.5, var_66_3)

					arg_63_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_63_1.var_.characterEffect10025ui_story.fillRatio = var_66_4
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect10025ui_story then
				local var_66_5 = 0.5

				arg_63_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_63_1.var_.characterEffect10025ui_story.fillRatio = var_66_5
			end

			local var_66_6 = 0
			local var_66_7 = 0.5

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_8 = arg_63_1:GetWordFromCfg(116161012)
				local var_66_9 = arg_63_1:FormatText(var_66_8.content)

				arg_63_1.text_.text = var_66_9

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_10 = 20
				local var_66_11 = utf8.len(var_66_9)
				local var_66_12 = var_66_10 <= 0 and var_66_7 or var_66_7 * (var_66_11 / var_66_10)

				if var_66_12 > 0 and var_66_7 < var_66_12 then
					arg_63_1.talkMaxDuration = var_66_12

					if var_66_12 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_12 + var_66_6
					end
				end

				arg_63_1.text_.text = var_66_9
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_13 = math.max(var_66_7, arg_63_1.talkMaxDuration)

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_13 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_6) / var_66_13

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_6 + var_66_13 and arg_63_1.time_ < var_66_6 + var_66_13 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play116161013 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 116161013
		arg_67_1.duration_ = 9.53

		local var_67_0 = {
			zh = 5.233,
			ja = 9.533
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
				arg_67_0:Play116161014(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["10025ui_story"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect10025ui_story == nil then
				arg_67_1.var_.characterEffect10025ui_story = var_70_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.2

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.characterEffect10025ui_story and not isNil(var_70_0) then
					arg_67_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect10025ui_story then
				arg_67_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_70_4 = 0

			if var_70_4 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action428")
			end

			local var_70_5 = 0

			if var_70_5 < arg_67_1.time_ and arg_67_1.time_ <= var_70_5 + arg_70_0 then
				arg_67_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_70_6 = 0
			local var_70_7 = 0.425

			if var_70_6 < arg_67_1.time_ and arg_67_1.time_ <= var_70_6 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_8 = arg_67_1:FormatText(StoryNameCfg[328].name)

				arg_67_1.leftNameTxt_.text = var_70_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_9 = arg_67_1:GetWordFromCfg(116161013)
				local var_70_10 = arg_67_1:FormatText(var_70_9.content)

				arg_67_1.text_.text = var_70_10

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_11 = 17
				local var_70_12 = utf8.len(var_70_10)
				local var_70_13 = var_70_11 <= 0 and var_70_7 or var_70_7 * (var_70_12 / var_70_11)

				if var_70_13 > 0 and var_70_7 < var_70_13 then
					arg_67_1.talkMaxDuration = var_70_13

					if var_70_13 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_13 + var_70_6
					end
				end

				arg_67_1.text_.text = var_70_10
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161013", "story_v_out_116161.awb") ~= 0 then
					local var_70_14 = manager.audio:GetVoiceLength("story_v_out_116161", "116161013", "story_v_out_116161.awb") / 1000

					if var_70_14 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_14 + var_70_6
					end

					if var_70_9.prefab_name ~= "" and arg_67_1.actors_[var_70_9.prefab_name] ~= nil then
						local var_70_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_9.prefab_name].transform, "story_v_out_116161", "116161013", "story_v_out_116161.awb")

						arg_67_1:RecordAudio("116161013", var_70_15)
						arg_67_1:RecordAudio("116161013", var_70_15)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_116161", "116161013", "story_v_out_116161.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_116161", "116161013", "story_v_out_116161.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_16 = math.max(var_70_7, arg_67_1.talkMaxDuration)

			if var_70_6 <= arg_67_1.time_ and arg_67_1.time_ < var_70_6 + var_70_16 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_6) / var_70_16

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_6 + var_70_16 and arg_67_1.time_ < var_70_6 + var_70_16 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play116161014 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 116161014
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play116161015(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["10025ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect10025ui_story == nil then
				arg_71_1.var_.characterEffect10025ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.2

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect10025ui_story and not isNil(var_74_0) then
					local var_74_4 = Mathf.Lerp(0, 0.5, var_74_3)

					arg_71_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_71_1.var_.characterEffect10025ui_story.fillRatio = var_74_4
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect10025ui_story then
				local var_74_5 = 0.5

				arg_71_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_71_1.var_.characterEffect10025ui_story.fillRatio = var_74_5
			end

			local var_74_6 = 0
			local var_74_7 = 0.225

			if var_74_6 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_8 = arg_71_1:FormatText(StoryNameCfg[7].name)

				arg_71_1.leftNameTxt_.text = var_74_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_9 = arg_71_1:GetWordFromCfg(116161014)
				local var_74_10 = arg_71_1:FormatText(var_74_9.content)

				arg_71_1.text_.text = var_74_10

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_11 = 9
				local var_74_12 = utf8.len(var_74_10)
				local var_74_13 = var_74_11 <= 0 and var_74_7 or var_74_7 * (var_74_12 / var_74_11)

				if var_74_13 > 0 and var_74_7 < var_74_13 then
					arg_71_1.talkMaxDuration = var_74_13

					if var_74_13 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_13 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_10
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_14 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_14 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_14

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_14 and arg_71_1.time_ < var_74_6 + var_74_14 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play116161015 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 116161015
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play116161016(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 0.85

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_2 = arg_75_1:GetWordFromCfg(116161015)
				local var_78_3 = arg_75_1:FormatText(var_78_2.content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 34
				local var_78_5 = utf8.len(var_78_3)
				local var_78_6 = var_78_4 <= 0 and var_78_1 or var_78_1 * (var_78_5 / var_78_4)

				if var_78_6 > 0 and var_78_1 < var_78_6 then
					arg_75_1.talkMaxDuration = var_78_6

					if var_78_6 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_6 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_7 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_7 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_7

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_7 and arg_75_1.time_ < var_78_0 + var_78_7 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play116161016 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 116161016
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play116161017(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 0.375

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_2 = arg_79_1:FormatText(StoryNameCfg[7].name)

				arg_79_1.leftNameTxt_.text = var_82_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_3 = arg_79_1:GetWordFromCfg(116161016)
				local var_82_4 = arg_79_1:FormatText(var_82_3.content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 15
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
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_8 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_8 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_8

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_8 and arg_79_1.time_ < var_82_0 + var_82_8 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play116161017 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 116161017
		arg_83_1.duration_ = 6.37

		local var_83_0 = {
			zh = 3.433,
			ja = 6.366
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
				arg_83_0:Play116161018(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["10025ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect10025ui_story == nil then
				arg_83_1.var_.characterEffect10025ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.2

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect10025ui_story and not isNil(var_86_0) then
					arg_83_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect10025ui_story then
				arg_83_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_86_4 = 0

			if var_86_4 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action487")
			end

			local var_86_5 = 0

			if var_86_5 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 then
				arg_83_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_86_6 = 0
			local var_86_7 = 0.25

			if var_86_6 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_8 = arg_83_1:FormatText(StoryNameCfg[328].name)

				arg_83_1.leftNameTxt_.text = var_86_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_9 = arg_83_1:GetWordFromCfg(116161017)
				local var_86_10 = arg_83_1:FormatText(var_86_9.content)

				arg_83_1.text_.text = var_86_10

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_11 = 10
				local var_86_12 = utf8.len(var_86_10)
				local var_86_13 = var_86_11 <= 0 and var_86_7 or var_86_7 * (var_86_12 / var_86_11)

				if var_86_13 > 0 and var_86_7 < var_86_13 then
					arg_83_1.talkMaxDuration = var_86_13

					if var_86_13 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_13 + var_86_6
					end
				end

				arg_83_1.text_.text = var_86_10
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161017", "story_v_out_116161.awb") ~= 0 then
					local var_86_14 = manager.audio:GetVoiceLength("story_v_out_116161", "116161017", "story_v_out_116161.awb") / 1000

					if var_86_14 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_14 + var_86_6
					end

					if var_86_9.prefab_name ~= "" and arg_83_1.actors_[var_86_9.prefab_name] ~= nil then
						local var_86_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_9.prefab_name].transform, "story_v_out_116161", "116161017", "story_v_out_116161.awb")

						arg_83_1:RecordAudio("116161017", var_86_15)
						arg_83_1:RecordAudio("116161017", var_86_15)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_116161", "116161017", "story_v_out_116161.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_116161", "116161017", "story_v_out_116161.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_16 = math.max(var_86_7, arg_83_1.talkMaxDuration)

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_16 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_6) / var_86_16

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_6 + var_86_16 and arg_83_1.time_ < var_86_6 + var_86_16 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play116161018 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 116161018
		arg_87_1.duration_ = 0.2

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"

			SetActive(arg_87_1.choicesGo_, true)

			for iter_88_0, iter_88_1 in ipairs(arg_87_1.choices_) do
				local var_88_0 = iter_88_0 <= 1

				SetActive(iter_88_1.go, var_88_0)
			end

			arg_87_1.choices_[1].txt.text = arg_87_1:FormatText(StoryChoiceCfg[252].name)
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play116161019(arg_87_1)
			end

			arg_87_1:RecordChoiceLog(116161018, 252)
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["10025ui_story"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect10025ui_story == nil then
				arg_87_1.var_.characterEffect10025ui_story = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.2

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.characterEffect10025ui_story and not isNil(var_90_0) then
					local var_90_4 = Mathf.Lerp(0, 0.5, var_90_3)

					arg_87_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_87_1.var_.characterEffect10025ui_story.fillRatio = var_90_4
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect10025ui_story then
				local var_90_5 = 0.5

				arg_87_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_87_1.var_.characterEffect10025ui_story.fillRatio = var_90_5
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play116161019 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 116161019
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play116161020(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 0.65

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[7].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_3 = arg_91_1:GetWordFromCfg(116161019)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 26
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
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_8 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_8 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_8

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_8 and arg_91_1.time_ < var_94_0 + var_94_8 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play116161020 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 116161020
		arg_95_1.duration_ = 2.97

		local var_95_0 = {
			zh = 2.966,
			ja = 2.4
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
				arg_95_0:Play116161021(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["10025ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect10025ui_story == nil then
				arg_95_1.var_.characterEffect10025ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.2

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect10025ui_story and not isNil(var_98_0) then
					arg_95_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect10025ui_story then
				arg_95_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_98_4 = 0

			if var_98_4 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action478")
			end

			local var_98_5 = 0

			if var_98_5 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 then
				arg_95_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_98_6 = 0
			local var_98_7 = 0.225

			if var_98_6 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_8 = arg_95_1:FormatText(StoryNameCfg[328].name)

				arg_95_1.leftNameTxt_.text = var_98_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_9 = arg_95_1:GetWordFromCfg(116161020)
				local var_98_10 = arg_95_1:FormatText(var_98_9.content)

				arg_95_1.text_.text = var_98_10

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_11 = 9
				local var_98_12 = utf8.len(var_98_10)
				local var_98_13 = var_98_11 <= 0 and var_98_7 or var_98_7 * (var_98_12 / var_98_11)

				if var_98_13 > 0 and var_98_7 < var_98_13 then
					arg_95_1.talkMaxDuration = var_98_13

					if var_98_13 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_13 + var_98_6
					end
				end

				arg_95_1.text_.text = var_98_10
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161020", "story_v_out_116161.awb") ~= 0 then
					local var_98_14 = manager.audio:GetVoiceLength("story_v_out_116161", "116161020", "story_v_out_116161.awb") / 1000

					if var_98_14 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_14 + var_98_6
					end

					if var_98_9.prefab_name ~= "" and arg_95_1.actors_[var_98_9.prefab_name] ~= nil then
						local var_98_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_9.prefab_name].transform, "story_v_out_116161", "116161020", "story_v_out_116161.awb")

						arg_95_1:RecordAudio("116161020", var_98_15)
						arg_95_1:RecordAudio("116161020", var_98_15)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_116161", "116161020", "story_v_out_116161.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_116161", "116161020", "story_v_out_116161.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_16 = math.max(var_98_7, arg_95_1.talkMaxDuration)

			if var_98_6 <= arg_95_1.time_ and arg_95_1.time_ < var_98_6 + var_98_16 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_6) / var_98_16

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_6 + var_98_16 and arg_95_1.time_ < var_98_6 + var_98_16 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play116161021 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 116161021
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play116161022(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["10025ui_story"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos10025ui_story = var_102_0.localPosition
			end

			local var_102_2 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2
				local var_102_4 = Vector3.New(0, 100, 0)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10025ui_story, var_102_4, var_102_3)

				local var_102_5 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_5.x, var_102_5.y, var_102_5.z)

				local var_102_6 = var_102_0.localEulerAngles

				var_102_6.z = 0
				var_102_6.x = 0
				var_102_0.localEulerAngles = var_102_6
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(0, 100, 0)

				local var_102_7 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_7.x, var_102_7.y, var_102_7.z)

				local var_102_8 = var_102_0.localEulerAngles

				var_102_8.z = 0
				var_102_8.x = 0
				var_102_0.localEulerAngles = var_102_8
			end

			local var_102_9 = 0
			local var_102_10 = 1

			if var_102_9 < arg_99_1.time_ and arg_99_1.time_ <= var_102_9 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_11 = arg_99_1:GetWordFromCfg(116161021)
				local var_102_12 = arg_99_1:FormatText(var_102_11.content)

				arg_99_1.text_.text = var_102_12

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_13 = 40
				local var_102_14 = utf8.len(var_102_12)
				local var_102_15 = var_102_13 <= 0 and var_102_10 or var_102_10 * (var_102_14 / var_102_13)

				if var_102_15 > 0 and var_102_10 < var_102_15 then
					arg_99_1.talkMaxDuration = var_102_15

					if var_102_15 + var_102_9 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_15 + var_102_9
					end
				end

				arg_99_1.text_.text = var_102_12
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_16 = math.max(var_102_10, arg_99_1.talkMaxDuration)

			if var_102_9 <= arg_99_1.time_ and arg_99_1.time_ < var_102_9 + var_102_16 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_9) / var_102_16

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_9 + var_102_16 and arg_99_1.time_ < var_102_9 + var_102_16 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play116161022 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 116161022
		arg_103_1.duration_ = 7.13

		local var_103_0 = {
			zh = 6.466666666666,
			ja = 7.133
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play116161023(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = "I03"

			if arg_103_1.bgs_[var_106_0] == nil then
				local var_106_1 = Object.Instantiate(arg_103_1.paintGo_)

				var_106_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_106_0)
				var_106_1.name = var_106_0
				var_106_1.transform.parent = arg_103_1.stage_.transform
				var_106_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_103_1.bgs_[var_106_0] = var_106_1
			end

			local var_106_2 = 2

			if var_106_2 < arg_103_1.time_ and arg_103_1.time_ <= var_106_2 + arg_106_0 then
				local var_106_3 = manager.ui.mainCamera.transform.localPosition
				local var_106_4 = Vector3.New(0, 0, 10) + Vector3.New(var_106_3.x, var_106_3.y, 0)
				local var_106_5 = arg_103_1.bgs_.I03

				var_106_5.transform.localPosition = var_106_4
				var_106_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_106_6 = var_106_5:GetComponent("SpriteRenderer")

				if var_106_6 and var_106_6.sprite then
					local var_106_7 = (var_106_5.transform.localPosition - var_106_3).z
					local var_106_8 = manager.ui.mainCameraCom_
					local var_106_9 = 2 * var_106_7 * Mathf.Tan(var_106_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_106_10 = var_106_9 * var_106_8.aspect
					local var_106_11 = var_106_6.sprite.bounds.size.x
					local var_106_12 = var_106_6.sprite.bounds.size.y
					local var_106_13 = var_106_10 / var_106_11
					local var_106_14 = var_106_9 / var_106_12
					local var_106_15 = var_106_14 < var_106_13 and var_106_13 or var_106_14

					var_106_5.transform.localScale = Vector3.New(var_106_15, var_106_15, 0)
				end

				for iter_106_0, iter_106_1 in pairs(arg_103_1.bgs_) do
					if iter_106_0 ~= "I03" then
						iter_106_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_106_16 = 0

			if var_106_16 < arg_103_1.time_ and arg_103_1.time_ <= var_106_16 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_17 = 2

			if var_106_16 <= arg_103_1.time_ and arg_103_1.time_ < var_106_16 + var_106_17 then
				local var_106_18 = (arg_103_1.time_ - var_106_16) / var_106_17
				local var_106_19 = Color.New(0, 0, 0)

				var_106_19.a = Mathf.Lerp(0, 1, var_106_18)
				arg_103_1.mask_.color = var_106_19
			end

			if arg_103_1.time_ >= var_106_16 + var_106_17 and arg_103_1.time_ < var_106_16 + var_106_17 + arg_106_0 then
				local var_106_20 = Color.New(0, 0, 0)

				var_106_20.a = 1
				arg_103_1.mask_.color = var_106_20
			end

			local var_106_21 = 2

			if var_106_21 < arg_103_1.time_ and arg_103_1.time_ <= var_106_21 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_22 = 2

			if var_106_21 <= arg_103_1.time_ and arg_103_1.time_ < var_106_21 + var_106_22 then
				local var_106_23 = (arg_103_1.time_ - var_106_21) / var_106_22
				local var_106_24 = Color.New(0, 0, 0)

				var_106_24.a = Mathf.Lerp(1, 0, var_106_23)
				arg_103_1.mask_.color = var_106_24
			end

			if arg_103_1.time_ >= var_106_21 + var_106_22 and arg_103_1.time_ < var_106_21 + var_106_22 + arg_106_0 then
				local var_106_25 = Color.New(0, 0, 0)
				local var_106_26 = 0

				arg_103_1.mask_.enabled = false
				var_106_25.a = var_106_26
				arg_103_1.mask_.color = var_106_25
			end

			local var_106_27 = "1084ui_story"

			if arg_103_1.actors_[var_106_27] == nil then
				local var_106_28 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_106_28) then
					local var_106_29 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_103_1.stage_.transform)

					var_106_29.name = var_106_27
					var_106_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_103_1.actors_[var_106_27] = var_106_29

					local var_106_30 = var_106_29:GetComponentInChildren(typeof(CharacterEffect))

					var_106_30.enabled = true

					local var_106_31 = GameObjectTools.GetOrAddComponent(var_106_29, typeof(DynamicBoneHelper))

					if var_106_31 then
						var_106_31:EnableDynamicBone(false)
					end

					arg_103_1:ShowWeapon(var_106_30.transform, false)

					arg_103_1.var_[var_106_27 .. "Animator"] = var_106_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_103_1.var_[var_106_27 .. "Animator"].applyRootMotion = true
					arg_103_1.var_[var_106_27 .. "LipSync"] = var_106_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_106_32 = arg_103_1.actors_["1084ui_story"].transform
			local var_106_33 = 3.8

			if var_106_33 < arg_103_1.time_ and arg_103_1.time_ <= var_106_33 + arg_106_0 then
				arg_103_1.var_.moveOldPos1084ui_story = var_106_32.localPosition
			end

			local var_106_34 = 0.001

			if var_106_33 <= arg_103_1.time_ and arg_103_1.time_ < var_106_33 + var_106_34 then
				local var_106_35 = (arg_103_1.time_ - var_106_33) / var_106_34
				local var_106_36 = Vector3.New(-0.7, -0.97, -6)

				var_106_32.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1084ui_story, var_106_36, var_106_35)

				local var_106_37 = manager.ui.mainCamera.transform.position - var_106_32.position

				var_106_32.forward = Vector3.New(var_106_37.x, var_106_37.y, var_106_37.z)

				local var_106_38 = var_106_32.localEulerAngles

				var_106_38.z = 0
				var_106_38.x = 0
				var_106_32.localEulerAngles = var_106_38
			end

			if arg_103_1.time_ >= var_106_33 + var_106_34 and arg_103_1.time_ < var_106_33 + var_106_34 + arg_106_0 then
				var_106_32.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_106_39 = manager.ui.mainCamera.transform.position - var_106_32.position

				var_106_32.forward = Vector3.New(var_106_39.x, var_106_39.y, var_106_39.z)

				local var_106_40 = var_106_32.localEulerAngles

				var_106_40.z = 0
				var_106_40.x = 0
				var_106_32.localEulerAngles = var_106_40
			end

			local var_106_41 = arg_103_1.actors_["1084ui_story"]
			local var_106_42 = 3.8

			if var_106_42 < arg_103_1.time_ and arg_103_1.time_ <= var_106_42 + arg_106_0 and not isNil(var_106_41) and arg_103_1.var_.characterEffect1084ui_story == nil then
				arg_103_1.var_.characterEffect1084ui_story = var_106_41:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_43 = 0.2

			if var_106_42 <= arg_103_1.time_ and arg_103_1.time_ < var_106_42 + var_106_43 and not isNil(var_106_41) then
				local var_106_44 = (arg_103_1.time_ - var_106_42) / var_106_43

				if arg_103_1.var_.characterEffect1084ui_story and not isNil(var_106_41) then
					arg_103_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_42 + var_106_43 and arg_103_1.time_ < var_106_42 + var_106_43 + arg_106_0 and not isNil(var_106_41) and arg_103_1.var_.characterEffect1084ui_story then
				arg_103_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_106_45 = 3.8

			if var_106_45 < arg_103_1.time_ and arg_103_1.time_ <= var_106_45 + arg_106_0 then
				arg_103_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_106_46 = 3.8

			if var_106_46 < arg_103_1.time_ and arg_103_1.time_ <= var_106_46 + arg_106_0 then
				arg_103_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_106_47 = "1011ui_story"

			if arg_103_1.actors_[var_106_47] == nil then
				local var_106_48 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_106_48) then
					local var_106_49 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_103_1.stage_.transform)

					var_106_49.name = var_106_47
					var_106_49.transform.localPosition = Vector3.New(0, 100, 0)
					arg_103_1.actors_[var_106_47] = var_106_49

					local var_106_50 = var_106_49:GetComponentInChildren(typeof(CharacterEffect))

					var_106_50.enabled = true

					local var_106_51 = GameObjectTools.GetOrAddComponent(var_106_49, typeof(DynamicBoneHelper))

					if var_106_51 then
						var_106_51:EnableDynamicBone(false)
					end

					arg_103_1:ShowWeapon(var_106_50.transform, false)

					arg_103_1.var_[var_106_47 .. "Animator"] = var_106_50.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_103_1.var_[var_106_47 .. "Animator"].applyRootMotion = true
					arg_103_1.var_[var_106_47 .. "LipSync"] = var_106_50.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_106_52 = arg_103_1.actors_["1011ui_story"].transform
			local var_106_53 = 3.8

			if var_106_53 < arg_103_1.time_ and arg_103_1.time_ <= var_106_53 + arg_106_0 then
				arg_103_1.var_.moveOldPos1011ui_story = var_106_52.localPosition
			end

			local var_106_54 = 0.001

			if var_106_53 <= arg_103_1.time_ and arg_103_1.time_ < var_106_53 + var_106_54 then
				local var_106_55 = (arg_103_1.time_ - var_106_53) / var_106_54
				local var_106_56 = Vector3.New(0.7, -0.71, -6)

				var_106_52.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1011ui_story, var_106_56, var_106_55)

				local var_106_57 = manager.ui.mainCamera.transform.position - var_106_52.position

				var_106_52.forward = Vector3.New(var_106_57.x, var_106_57.y, var_106_57.z)

				local var_106_58 = var_106_52.localEulerAngles

				var_106_58.z = 0
				var_106_58.x = 0
				var_106_52.localEulerAngles = var_106_58
			end

			if arg_103_1.time_ >= var_106_53 + var_106_54 and arg_103_1.time_ < var_106_53 + var_106_54 + arg_106_0 then
				var_106_52.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_106_59 = manager.ui.mainCamera.transform.position - var_106_52.position

				var_106_52.forward = Vector3.New(var_106_59.x, var_106_59.y, var_106_59.z)

				local var_106_60 = var_106_52.localEulerAngles

				var_106_60.z = 0
				var_106_60.x = 0
				var_106_52.localEulerAngles = var_106_60
			end

			local var_106_61 = 3.8

			if var_106_61 < arg_103_1.time_ and arg_103_1.time_ <= var_106_61 + arg_106_0 then
				arg_103_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			local var_106_62 = arg_103_1.actors_["1011ui_story"]
			local var_106_63 = 3.8

			if var_106_63 < arg_103_1.time_ and arg_103_1.time_ <= var_106_63 + arg_106_0 and not isNil(var_106_62) and arg_103_1.var_.characterEffect1011ui_story == nil then
				arg_103_1.var_.characterEffect1011ui_story = var_106_62:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_64 = 0.2

			if var_106_63 <= arg_103_1.time_ and arg_103_1.time_ < var_106_63 + var_106_64 and not isNil(var_106_62) then
				local var_106_65 = (arg_103_1.time_ - var_106_63) / var_106_64

				if arg_103_1.var_.characterEffect1011ui_story and not isNil(var_106_62) then
					local var_106_66 = Mathf.Lerp(0, 0.5, var_106_65)

					arg_103_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1011ui_story.fillRatio = var_106_66
				end
			end

			if arg_103_1.time_ >= var_106_63 + var_106_64 and arg_103_1.time_ < var_106_63 + var_106_64 + arg_106_0 and not isNil(var_106_62) and arg_103_1.var_.characterEffect1011ui_story then
				local var_106_67 = 0.5

				arg_103_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1011ui_story.fillRatio = var_106_67
			end

			local var_106_68 = 0
			local var_106_69 = 1

			if var_106_68 < arg_103_1.time_ and arg_103_1.time_ <= var_106_68 + arg_106_0 then
				local var_106_70 = "play"
				local var_106_71 = "music"

				arg_103_1:AudioAction(var_106_70, var_106_71, "ui_battle", "ui_battle_stopbgm", "")

				local var_106_72 = ""
				local var_106_73 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_106_73 ~= "" then
					if arg_103_1.bgmTxt_.text ~= var_106_73 and arg_103_1.bgmTxt_.text ~= "" then
						if arg_103_1.bgmTxt2_.text ~= "" then
							arg_103_1.bgmTxt_.text = arg_103_1.bgmTxt2_.text
						end

						arg_103_1.bgmTxt2_.text = var_106_73

						arg_103_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_103_1.bgmTxt_.text = var_106_73
						arg_103_1.bgmTxt2_.text = var_106_73
					end

					if arg_103_1.bgmTimer then
						arg_103_1.bgmTimer:Stop()

						arg_103_1.bgmTimer = nil
					end

					if arg_103_1.settingData.show_music_name == 1 then
						arg_103_1.musicController:SetSelectedState("show")
						arg_103_1.musicAnimator_:Play("open", 0, 0)

						if arg_103_1.settingData.music_time ~= 0 then
							arg_103_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_103_1.settingData.music_time), function()
								if arg_103_1 == nil or isNil(arg_103_1.bgmTxt_) then
									return
								end

								arg_103_1.musicController:SetSelectedState("hide")
								arg_103_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_106_74 = 1.4
			local var_106_75 = 2.6

			if var_106_74 < arg_103_1.time_ and arg_103_1.time_ <= var_106_74 + arg_106_0 then
				local var_106_76 = "play"
				local var_106_77 = "music"

				arg_103_1:AudioAction(var_106_76, var_106_77, "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_106_78 = ""
				local var_106_79 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if var_106_79 ~= "" then
					if arg_103_1.bgmTxt_.text ~= var_106_79 and arg_103_1.bgmTxt_.text ~= "" then
						if arg_103_1.bgmTxt2_.text ~= "" then
							arg_103_1.bgmTxt_.text = arg_103_1.bgmTxt2_.text
						end

						arg_103_1.bgmTxt2_.text = var_106_79

						arg_103_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_103_1.bgmTxt_.text = var_106_79
						arg_103_1.bgmTxt2_.text = var_106_79
					end

					if arg_103_1.bgmTimer then
						arg_103_1.bgmTimer:Stop()

						arg_103_1.bgmTimer = nil
					end

					if arg_103_1.settingData.show_music_name == 1 then
						arg_103_1.musicController:SetSelectedState("show")
						arg_103_1.musicAnimator_:Play("open", 0, 0)

						if arg_103_1.settingData.music_time ~= 0 then
							arg_103_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_103_1.settingData.music_time), function()
								if arg_103_1 == nil or isNil(arg_103_1.bgmTxt_) then
									return
								end

								arg_103_1.musicController:SetSelectedState("hide")
								arg_103_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_103_1.frameCnt_ <= 1 then
				arg_103_1.dialog_:SetActive(false)
			end

			local var_106_80 = 4
			local var_106_81 = 0.2

			if var_106_80 < arg_103_1.time_ and arg_103_1.time_ <= var_106_80 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				arg_103_1.dialog_:SetActive(true)

				arg_103_1.dialogCg_.alpha = 0

				local var_106_82 = LeanTween.value(arg_103_1.dialog_, 0, 1, 0.3)

				var_106_82:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_103_1.dialogCg_.alpha = arg_109_0
				end))
				var_106_82:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_103_1.dialog_)
					var_106_82:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_103_1.duration_ = arg_103_1.duration_ + 0.3

				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_83 = arg_103_1:FormatText(StoryNameCfg[6].name)

				arg_103_1.leftNameTxt_.text = var_106_83

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_84 = arg_103_1:GetWordFromCfg(116161022)
				local var_106_85 = arg_103_1:FormatText(var_106_84.content)

				arg_103_1.text_.text = var_106_85

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_86 = 8
				local var_106_87 = utf8.len(var_106_85)
				local var_106_88 = var_106_86 <= 0 and var_106_81 or var_106_81 * (var_106_87 / var_106_86)

				if var_106_88 > 0 and var_106_81 < var_106_88 then
					arg_103_1.talkMaxDuration = var_106_88
					var_106_80 = var_106_80 + 0.3

					if var_106_88 + var_106_80 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_88 + var_106_80
					end
				end

				arg_103_1.text_.text = var_106_85
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161022", "story_v_out_116161.awb") ~= 0 then
					local var_106_89 = manager.audio:GetVoiceLength("story_v_out_116161", "116161022", "story_v_out_116161.awb") / 1000

					if var_106_89 + var_106_80 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_89 + var_106_80
					end

					if var_106_84.prefab_name ~= "" and arg_103_1.actors_[var_106_84.prefab_name] ~= nil then
						local var_106_90 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_84.prefab_name].transform, "story_v_out_116161", "116161022", "story_v_out_116161.awb")

						arg_103_1:RecordAudio("116161022", var_106_90)
						arg_103_1:RecordAudio("116161022", var_106_90)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_116161", "116161022", "story_v_out_116161.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_116161", "116161022", "story_v_out_116161.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_91 = var_106_80 + 0.3
			local var_106_92 = math.max(var_106_81, arg_103_1.talkMaxDuration)

			if var_106_91 <= arg_103_1.time_ and arg_103_1.time_ < var_106_91 + var_106_92 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_91) / var_106_92

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_91 + var_106_92 and arg_103_1.time_ < var_106_91 + var_106_92 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play116161023 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 116161023
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play116161024(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1084ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1084ui_story == nil then
				arg_111_1.var_.characterEffect1084ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.2

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect1084ui_story and not isNil(var_114_0) then
					local var_114_4 = Mathf.Lerp(0, 0.5, var_114_3)

					arg_111_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1084ui_story.fillRatio = var_114_4
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1084ui_story then
				local var_114_5 = 0.5

				arg_111_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1084ui_story.fillRatio = var_114_5
			end

			local var_114_6 = 0
			local var_114_7 = 0.25

			if var_114_6 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_8 = arg_111_1:FormatText(StoryNameCfg[7].name)

				arg_111_1.leftNameTxt_.text = var_114_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_9 = arg_111_1:GetWordFromCfg(116161023)
				local var_114_10 = arg_111_1:FormatText(var_114_9.content)

				arg_111_1.text_.text = var_114_10

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_11 = 10
				local var_114_12 = utf8.len(var_114_10)
				local var_114_13 = var_114_11 <= 0 and var_114_7 or var_114_7 * (var_114_12 / var_114_11)

				if var_114_13 > 0 and var_114_7 < var_114_13 then
					arg_111_1.talkMaxDuration = var_114_13

					if var_114_13 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_13 + var_114_6
					end
				end

				arg_111_1.text_.text = var_114_10
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_14 = math.max(var_114_7, arg_111_1.talkMaxDuration)

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_14 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_6) / var_114_14

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_6 + var_114_14 and arg_111_1.time_ < var_114_6 + var_114_14 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play116161024 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 116161024
		arg_115_1.duration_ = 4.97

		local var_115_0 = {
			zh = 4.966,
			ja = 3.333
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
				arg_115_0:Play116161025(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_118_1 = arg_115_1.actors_["1084ui_story"]
			local var_118_2 = 0

			if var_118_2 < arg_115_1.time_ and arg_115_1.time_ <= var_118_2 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1084ui_story == nil then
				arg_115_1.var_.characterEffect1084ui_story = var_118_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_3 = 0.2

			if var_118_2 <= arg_115_1.time_ and arg_115_1.time_ < var_118_2 + var_118_3 and not isNil(var_118_1) then
				local var_118_4 = (arg_115_1.time_ - var_118_2) / var_118_3

				if arg_115_1.var_.characterEffect1084ui_story and not isNil(var_118_1) then
					arg_115_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_2 + var_118_3 and arg_115_1.time_ < var_118_2 + var_118_3 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1084ui_story then
				arg_115_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_118_5 = 0
			local var_118_6 = 0.625

			if var_118_5 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_7 = arg_115_1:FormatText(StoryNameCfg[6].name)

				arg_115_1.leftNameTxt_.text = var_118_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_8 = arg_115_1:GetWordFromCfg(116161024)
				local var_118_9 = arg_115_1:FormatText(var_118_8.content)

				arg_115_1.text_.text = var_118_9

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_10 = 25
				local var_118_11 = utf8.len(var_118_9)
				local var_118_12 = var_118_10 <= 0 and var_118_6 or var_118_6 * (var_118_11 / var_118_10)

				if var_118_12 > 0 and var_118_6 < var_118_12 then
					arg_115_1.talkMaxDuration = var_118_12

					if var_118_12 + var_118_5 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_12 + var_118_5
					end
				end

				arg_115_1.text_.text = var_118_9
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161024", "story_v_out_116161.awb") ~= 0 then
					local var_118_13 = manager.audio:GetVoiceLength("story_v_out_116161", "116161024", "story_v_out_116161.awb") / 1000

					if var_118_13 + var_118_5 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_13 + var_118_5
					end

					if var_118_8.prefab_name ~= "" and arg_115_1.actors_[var_118_8.prefab_name] ~= nil then
						local var_118_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_8.prefab_name].transform, "story_v_out_116161", "116161024", "story_v_out_116161.awb")

						arg_115_1:RecordAudio("116161024", var_118_14)
						arg_115_1:RecordAudio("116161024", var_118_14)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_116161", "116161024", "story_v_out_116161.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_116161", "116161024", "story_v_out_116161.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_15 = math.max(var_118_6, arg_115_1.talkMaxDuration)

			if var_118_5 <= arg_115_1.time_ and arg_115_1.time_ < var_118_5 + var_118_15 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_5) / var_118_15

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_5 + var_118_15 and arg_115_1.time_ < var_118_5 + var_118_15 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play116161025 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 116161025
		arg_119_1.duration_ = 7.4

		local var_119_0 = {
			zh = 7.4,
			ja = 6.766
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
				arg_119_0:Play116161026(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1084ui_story"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos1084ui_story = var_122_0.localPosition
			end

			local var_122_2 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2
				local var_122_4 = Vector3.New(-0.7, -0.97, -6)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1084ui_story, var_122_4, var_122_3)

				local var_122_5 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_5.x, var_122_5.y, var_122_5.z)

				local var_122_6 = var_122_0.localEulerAngles

				var_122_6.z = 0
				var_122_6.x = 0
				var_122_0.localEulerAngles = var_122_6
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_122_7 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_7.x, var_122_7.y, var_122_7.z)

				local var_122_8 = var_122_0.localEulerAngles

				var_122_8.z = 0
				var_122_8.x = 0
				var_122_0.localEulerAngles = var_122_8
			end

			local var_122_9 = arg_119_1.actors_["1011ui_story"].transform
			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 then
				arg_119_1.var_.moveOldPos1011ui_story = var_122_9.localPosition
			end

			local var_122_11 = 0.001

			if var_122_10 <= arg_119_1.time_ and arg_119_1.time_ < var_122_10 + var_122_11 then
				local var_122_12 = (arg_119_1.time_ - var_122_10) / var_122_11
				local var_122_13 = Vector3.New(0.7, -0.71, -6)

				var_122_9.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1011ui_story, var_122_13, var_122_12)

				local var_122_14 = manager.ui.mainCamera.transform.position - var_122_9.position

				var_122_9.forward = Vector3.New(var_122_14.x, var_122_14.y, var_122_14.z)

				local var_122_15 = var_122_9.localEulerAngles

				var_122_15.z = 0
				var_122_15.x = 0
				var_122_9.localEulerAngles = var_122_15
			end

			if arg_119_1.time_ >= var_122_10 + var_122_11 and arg_119_1.time_ < var_122_10 + var_122_11 + arg_122_0 then
				var_122_9.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_122_16 = manager.ui.mainCamera.transform.position - var_122_9.position

				var_122_9.forward = Vector3.New(var_122_16.x, var_122_16.y, var_122_16.z)

				local var_122_17 = var_122_9.localEulerAngles

				var_122_17.z = 0
				var_122_17.x = 0
				var_122_9.localEulerAngles = var_122_17
			end

			local var_122_18 = arg_119_1.actors_["1011ui_story"]
			local var_122_19 = 0

			if var_122_19 < arg_119_1.time_ and arg_119_1.time_ <= var_122_19 + arg_122_0 and not isNil(var_122_18) and arg_119_1.var_.characterEffect1011ui_story == nil then
				arg_119_1.var_.characterEffect1011ui_story = var_122_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_20 = 0.2

			if var_122_19 <= arg_119_1.time_ and arg_119_1.time_ < var_122_19 + var_122_20 and not isNil(var_122_18) then
				local var_122_21 = (arg_119_1.time_ - var_122_19) / var_122_20

				if arg_119_1.var_.characterEffect1011ui_story and not isNil(var_122_18) then
					arg_119_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_19 + var_122_20 and arg_119_1.time_ < var_122_19 + var_122_20 + arg_122_0 and not isNil(var_122_18) and arg_119_1.var_.characterEffect1011ui_story then
				arg_119_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_122_22 = arg_119_1.actors_["1084ui_story"]
			local var_122_23 = 0

			if var_122_23 < arg_119_1.time_ and arg_119_1.time_ <= var_122_23 + arg_122_0 and not isNil(var_122_22) and arg_119_1.var_.characterEffect1084ui_story == nil then
				arg_119_1.var_.characterEffect1084ui_story = var_122_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_24 = 0.2

			if var_122_23 <= arg_119_1.time_ and arg_119_1.time_ < var_122_23 + var_122_24 and not isNil(var_122_22) then
				local var_122_25 = (arg_119_1.time_ - var_122_23) / var_122_24

				if arg_119_1.var_.characterEffect1084ui_story and not isNil(var_122_22) then
					local var_122_26 = Mathf.Lerp(0, 0.5, var_122_25)

					arg_119_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1084ui_story.fillRatio = var_122_26
				end
			end

			if arg_119_1.time_ >= var_122_23 + var_122_24 and arg_119_1.time_ < var_122_23 + var_122_24 + arg_122_0 and not isNil(var_122_22) and arg_119_1.var_.characterEffect1084ui_story then
				local var_122_27 = 0.5

				arg_119_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1084ui_story.fillRatio = var_122_27
			end

			local var_122_28 = 0

			if var_122_28 < arg_119_1.time_ and arg_119_1.time_ <= var_122_28 + arg_122_0 then
				arg_119_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_122_29 = 0

			if var_122_29 < arg_119_1.time_ and arg_119_1.time_ <= var_122_29 + arg_122_0 then
				arg_119_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_122_30 = 0
			local var_122_31 = 0.8

			if var_122_30 < arg_119_1.time_ and arg_119_1.time_ <= var_122_30 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_32 = arg_119_1:FormatText(StoryNameCfg[37].name)

				arg_119_1.leftNameTxt_.text = var_122_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_33 = arg_119_1:GetWordFromCfg(116161025)
				local var_122_34 = arg_119_1:FormatText(var_122_33.content)

				arg_119_1.text_.text = var_122_34

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_35 = 32
				local var_122_36 = utf8.len(var_122_34)
				local var_122_37 = var_122_35 <= 0 and var_122_31 or var_122_31 * (var_122_36 / var_122_35)

				if var_122_37 > 0 and var_122_31 < var_122_37 then
					arg_119_1.talkMaxDuration = var_122_37

					if var_122_37 + var_122_30 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_37 + var_122_30
					end
				end

				arg_119_1.text_.text = var_122_34
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161025", "story_v_out_116161.awb") ~= 0 then
					local var_122_38 = manager.audio:GetVoiceLength("story_v_out_116161", "116161025", "story_v_out_116161.awb") / 1000

					if var_122_38 + var_122_30 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_38 + var_122_30
					end

					if var_122_33.prefab_name ~= "" and arg_119_1.actors_[var_122_33.prefab_name] ~= nil then
						local var_122_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_33.prefab_name].transform, "story_v_out_116161", "116161025", "story_v_out_116161.awb")

						arg_119_1:RecordAudio("116161025", var_122_39)
						arg_119_1:RecordAudio("116161025", var_122_39)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_116161", "116161025", "story_v_out_116161.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_116161", "116161025", "story_v_out_116161.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_40 = math.max(var_122_31, arg_119_1.talkMaxDuration)

			if var_122_30 <= arg_119_1.time_ and arg_119_1.time_ < var_122_30 + var_122_40 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_30) / var_122_40

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_30 + var_122_40 and arg_119_1.time_ < var_122_30 + var_122_40 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play116161026 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 116161026
		arg_123_1.duration_ = 12.73

		local var_123_0 = {
			zh = 8.333,
			ja = 12.733
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
				arg_123_0:Play116161027(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1084ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1084ui_story == nil then
				arg_123_1.var_.characterEffect1084ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.2

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect1084ui_story and not isNil(var_126_0) then
					arg_123_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1084ui_story then
				arg_123_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_126_4 = arg_123_1.actors_["1011ui_story"]
			local var_126_5 = 0

			if var_126_5 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 and not isNil(var_126_4) and arg_123_1.var_.characterEffect1011ui_story == nil then
				arg_123_1.var_.characterEffect1011ui_story = var_126_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_6 = 0.2

			if var_126_5 <= arg_123_1.time_ and arg_123_1.time_ < var_126_5 + var_126_6 and not isNil(var_126_4) then
				local var_126_7 = (arg_123_1.time_ - var_126_5) / var_126_6

				if arg_123_1.var_.characterEffect1011ui_story and not isNil(var_126_4) then
					local var_126_8 = Mathf.Lerp(0, 0.5, var_126_7)

					arg_123_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1011ui_story.fillRatio = var_126_8
				end
			end

			if arg_123_1.time_ >= var_126_5 + var_126_6 and arg_123_1.time_ < var_126_5 + var_126_6 + arg_126_0 and not isNil(var_126_4) and arg_123_1.var_.characterEffect1011ui_story then
				local var_126_9 = 0.5

				arg_123_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1011ui_story.fillRatio = var_126_9
			end

			local var_126_10 = 0

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 then
				arg_123_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_126_11 = 0

			if var_126_11 < arg_123_1.time_ and arg_123_1.time_ <= var_126_11 + arg_126_0 then
				arg_123_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_126_12 = 0
			local var_126_13 = 0.9

			if var_126_12 < arg_123_1.time_ and arg_123_1.time_ <= var_126_12 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_14 = arg_123_1:FormatText(StoryNameCfg[6].name)

				arg_123_1.leftNameTxt_.text = var_126_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_15 = arg_123_1:GetWordFromCfg(116161026)
				local var_126_16 = arg_123_1:FormatText(var_126_15.content)

				arg_123_1.text_.text = var_126_16

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_17 = 36
				local var_126_18 = utf8.len(var_126_16)
				local var_126_19 = var_126_17 <= 0 and var_126_13 or var_126_13 * (var_126_18 / var_126_17)

				if var_126_19 > 0 and var_126_13 < var_126_19 then
					arg_123_1.talkMaxDuration = var_126_19

					if var_126_19 + var_126_12 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_19 + var_126_12
					end
				end

				arg_123_1.text_.text = var_126_16
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161026", "story_v_out_116161.awb") ~= 0 then
					local var_126_20 = manager.audio:GetVoiceLength("story_v_out_116161", "116161026", "story_v_out_116161.awb") / 1000

					if var_126_20 + var_126_12 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_20 + var_126_12
					end

					if var_126_15.prefab_name ~= "" and arg_123_1.actors_[var_126_15.prefab_name] ~= nil then
						local var_126_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_15.prefab_name].transform, "story_v_out_116161", "116161026", "story_v_out_116161.awb")

						arg_123_1:RecordAudio("116161026", var_126_21)
						arg_123_1:RecordAudio("116161026", var_126_21)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_116161", "116161026", "story_v_out_116161.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_116161", "116161026", "story_v_out_116161.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_22 = math.max(var_126_13, arg_123_1.talkMaxDuration)

			if var_126_12 <= arg_123_1.time_ and arg_123_1.time_ < var_126_12 + var_126_22 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_12) / var_126_22

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_12 + var_126_22 and arg_123_1.time_ < var_126_12 + var_126_22 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play116161027 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 116161027
		arg_127_1.duration_ = 8.2

		local var_127_0 = {
			zh = 5.3,
			ja = 8.2
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
				arg_127_0:Play116161028(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1084ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1084ui_story == nil then
				arg_127_1.var_.characterEffect1084ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.2

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect1084ui_story and not isNil(var_130_0) then
					local var_130_4 = Mathf.Lerp(0, 0.5, var_130_3)

					arg_127_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1084ui_story.fillRatio = var_130_4
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1084ui_story then
				local var_130_5 = 0.5

				arg_127_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1084ui_story.fillRatio = var_130_5
			end

			local var_130_6 = arg_127_1.actors_["1011ui_story"]
			local var_130_7 = 0

			if var_130_7 < arg_127_1.time_ and arg_127_1.time_ <= var_130_7 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect1011ui_story == nil then
				arg_127_1.var_.characterEffect1011ui_story = var_130_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_8 = 0.2

			if var_130_7 <= arg_127_1.time_ and arg_127_1.time_ < var_130_7 + var_130_8 and not isNil(var_130_6) then
				local var_130_9 = (arg_127_1.time_ - var_130_7) / var_130_8

				if arg_127_1.var_.characterEffect1011ui_story and not isNil(var_130_6) then
					arg_127_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_7 + var_130_8 and arg_127_1.time_ < var_130_7 + var_130_8 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect1011ui_story then
				arg_127_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_130_10 = 0

			if var_130_10 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 then
				arg_127_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_130_11 = 0
			local var_130_12 = 0.375

			if var_130_11 < arg_127_1.time_ and arg_127_1.time_ <= var_130_11 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_13 = arg_127_1:FormatText(StoryNameCfg[37].name)

				arg_127_1.leftNameTxt_.text = var_130_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_14 = arg_127_1:GetWordFromCfg(116161027)
				local var_130_15 = arg_127_1:FormatText(var_130_14.content)

				arg_127_1.text_.text = var_130_15

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_16 = 15
				local var_130_17 = utf8.len(var_130_15)
				local var_130_18 = var_130_16 <= 0 and var_130_12 or var_130_12 * (var_130_17 / var_130_16)

				if var_130_18 > 0 and var_130_12 < var_130_18 then
					arg_127_1.talkMaxDuration = var_130_18

					if var_130_18 + var_130_11 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_18 + var_130_11
					end
				end

				arg_127_1.text_.text = var_130_15
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161027", "story_v_out_116161.awb") ~= 0 then
					local var_130_19 = manager.audio:GetVoiceLength("story_v_out_116161", "116161027", "story_v_out_116161.awb") / 1000

					if var_130_19 + var_130_11 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_19 + var_130_11
					end

					if var_130_14.prefab_name ~= "" and arg_127_1.actors_[var_130_14.prefab_name] ~= nil then
						local var_130_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_14.prefab_name].transform, "story_v_out_116161", "116161027", "story_v_out_116161.awb")

						arg_127_1:RecordAudio("116161027", var_130_20)
						arg_127_1:RecordAudio("116161027", var_130_20)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_116161", "116161027", "story_v_out_116161.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_116161", "116161027", "story_v_out_116161.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_21 = math.max(var_130_12, arg_127_1.talkMaxDuration)

			if var_130_11 <= arg_127_1.time_ and arg_127_1.time_ < var_130_11 + var_130_21 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_11) / var_130_21

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_11 + var_130_21 and arg_127_1.time_ < var_130_11 + var_130_21 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play116161028 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 116161028
		arg_131_1.duration_ = 8.83

		local var_131_0 = {
			zh = 7.433,
			ja = 8.833
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
				arg_131_0:Play116161029(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1084ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1084ui_story == nil then
				arg_131_1.var_.characterEffect1084ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.2

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect1084ui_story and not isNil(var_134_0) then
					arg_131_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1084ui_story then
				arg_131_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_134_4 = arg_131_1.actors_["1011ui_story"]
			local var_134_5 = 0

			if var_134_5 < arg_131_1.time_ and arg_131_1.time_ <= var_134_5 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect1011ui_story == nil then
				arg_131_1.var_.characterEffect1011ui_story = var_134_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_6 = 0.2

			if var_134_5 <= arg_131_1.time_ and arg_131_1.time_ < var_134_5 + var_134_6 and not isNil(var_134_4) then
				local var_134_7 = (arg_131_1.time_ - var_134_5) / var_134_6

				if arg_131_1.var_.characterEffect1011ui_story and not isNil(var_134_4) then
					local var_134_8 = Mathf.Lerp(0, 0.5, var_134_7)

					arg_131_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1011ui_story.fillRatio = var_134_8
				end
			end

			if arg_131_1.time_ >= var_134_5 + var_134_6 and arg_131_1.time_ < var_134_5 + var_134_6 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect1011ui_story then
				local var_134_9 = 0.5

				arg_131_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1011ui_story.fillRatio = var_134_9
			end

			local var_134_10 = 0

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 then
				arg_131_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			local var_134_11 = 0

			if var_134_11 < arg_131_1.time_ and arg_131_1.time_ <= var_134_11 + arg_134_0 then
				arg_131_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_134_12 = 0
			local var_134_13 = 0.925

			if var_134_12 < arg_131_1.time_ and arg_131_1.time_ <= var_134_12 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_14 = arg_131_1:FormatText(StoryNameCfg[6].name)

				arg_131_1.leftNameTxt_.text = var_134_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_15 = arg_131_1:GetWordFromCfg(116161028)
				local var_134_16 = arg_131_1:FormatText(var_134_15.content)

				arg_131_1.text_.text = var_134_16

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_17 = 37
				local var_134_18 = utf8.len(var_134_16)
				local var_134_19 = var_134_17 <= 0 and var_134_13 or var_134_13 * (var_134_18 / var_134_17)

				if var_134_19 > 0 and var_134_13 < var_134_19 then
					arg_131_1.talkMaxDuration = var_134_19

					if var_134_19 + var_134_12 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_19 + var_134_12
					end
				end

				arg_131_1.text_.text = var_134_16
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161028", "story_v_out_116161.awb") ~= 0 then
					local var_134_20 = manager.audio:GetVoiceLength("story_v_out_116161", "116161028", "story_v_out_116161.awb") / 1000

					if var_134_20 + var_134_12 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_20 + var_134_12
					end

					if var_134_15.prefab_name ~= "" and arg_131_1.actors_[var_134_15.prefab_name] ~= nil then
						local var_134_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_15.prefab_name].transform, "story_v_out_116161", "116161028", "story_v_out_116161.awb")

						arg_131_1:RecordAudio("116161028", var_134_21)
						arg_131_1:RecordAudio("116161028", var_134_21)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_116161", "116161028", "story_v_out_116161.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_116161", "116161028", "story_v_out_116161.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_22 = math.max(var_134_13, arg_131_1.talkMaxDuration)

			if var_134_12 <= arg_131_1.time_ and arg_131_1.time_ < var_134_12 + var_134_22 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_12) / var_134_22

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_12 + var_134_22 and arg_131_1.time_ < var_134_12 + var_134_22 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play116161029 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 116161029
		arg_135_1.duration_ = 4.3

		local var_135_0 = {
			zh = 3.466,
			ja = 4.3
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
				arg_135_0:Play116161030(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1084ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1084ui_story == nil then
				arg_135_1.var_.characterEffect1084ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.2

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect1084ui_story and not isNil(var_138_0) then
					local var_138_4 = Mathf.Lerp(0, 0.5, var_138_3)

					arg_135_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1084ui_story.fillRatio = var_138_4
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1084ui_story then
				local var_138_5 = 0.5

				arg_135_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1084ui_story.fillRatio = var_138_5
			end

			local var_138_6 = arg_135_1.actors_["1011ui_story"]
			local var_138_7 = 0

			if var_138_7 < arg_135_1.time_ and arg_135_1.time_ <= var_138_7 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect1011ui_story == nil then
				arg_135_1.var_.characterEffect1011ui_story = var_138_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_8 = 0.2

			if var_138_7 <= arg_135_1.time_ and arg_135_1.time_ < var_138_7 + var_138_8 and not isNil(var_138_6) then
				local var_138_9 = (arg_135_1.time_ - var_138_7) / var_138_8

				if arg_135_1.var_.characterEffect1011ui_story and not isNil(var_138_6) then
					arg_135_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_7 + var_138_8 and arg_135_1.time_ < var_138_7 + var_138_8 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect1011ui_story then
				arg_135_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_138_10 = 0

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_2")
			end

			local var_138_11 = 0

			if var_138_11 < arg_135_1.time_ and arg_135_1.time_ <= var_138_11 + arg_138_0 then
				arg_135_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_138_12 = 0
			local var_138_13 = 0.2

			if var_138_12 < arg_135_1.time_ and arg_135_1.time_ <= var_138_12 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_14 = arg_135_1:FormatText(StoryNameCfg[37].name)

				arg_135_1.leftNameTxt_.text = var_138_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_15 = arg_135_1:GetWordFromCfg(116161029)
				local var_138_16 = arg_135_1:FormatText(var_138_15.content)

				arg_135_1.text_.text = var_138_16

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_17 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161029", "story_v_out_116161.awb") ~= 0 then
					local var_138_20 = manager.audio:GetVoiceLength("story_v_out_116161", "116161029", "story_v_out_116161.awb") / 1000

					if var_138_20 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_20 + var_138_12
					end

					if var_138_15.prefab_name ~= "" and arg_135_1.actors_[var_138_15.prefab_name] ~= nil then
						local var_138_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_15.prefab_name].transform, "story_v_out_116161", "116161029", "story_v_out_116161.awb")

						arg_135_1:RecordAudio("116161029", var_138_21)
						arg_135_1:RecordAudio("116161029", var_138_21)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_116161", "116161029", "story_v_out_116161.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_116161", "116161029", "story_v_out_116161.awb")
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
	Play116161030 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 116161030
		arg_139_1.duration_ = 9

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play116161031(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = "I06"

			if arg_139_1.bgs_[var_142_0] == nil then
				local var_142_1 = Object.Instantiate(arg_139_1.paintGo_)

				var_142_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_142_0)
				var_142_1.name = var_142_0
				var_142_1.transform.parent = arg_139_1.stage_.transform
				var_142_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_139_1.bgs_[var_142_0] = var_142_1
			end

			local var_142_2 = 2

			if var_142_2 < arg_139_1.time_ and arg_139_1.time_ <= var_142_2 + arg_142_0 then
				local var_142_3 = manager.ui.mainCamera.transform.localPosition
				local var_142_4 = Vector3.New(0, 0, 10) + Vector3.New(var_142_3.x, var_142_3.y, 0)
				local var_142_5 = arg_139_1.bgs_.I06

				var_142_5.transform.localPosition = var_142_4
				var_142_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_142_6 = var_142_5:GetComponent("SpriteRenderer")

				if var_142_6 and var_142_6.sprite then
					local var_142_7 = (var_142_5.transform.localPosition - var_142_3).z
					local var_142_8 = manager.ui.mainCameraCom_
					local var_142_9 = 2 * var_142_7 * Mathf.Tan(var_142_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_142_10 = var_142_9 * var_142_8.aspect
					local var_142_11 = var_142_6.sprite.bounds.size.x
					local var_142_12 = var_142_6.sprite.bounds.size.y
					local var_142_13 = var_142_10 / var_142_11
					local var_142_14 = var_142_9 / var_142_12
					local var_142_15 = var_142_14 < var_142_13 and var_142_13 or var_142_14

					var_142_5.transform.localScale = Vector3.New(var_142_15, var_142_15, 0)
				end

				for iter_142_0, iter_142_1 in pairs(arg_139_1.bgs_) do
					if iter_142_0 ~= "I06" then
						iter_142_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_142_16 = 0

			if var_142_16 < arg_139_1.time_ and arg_139_1.time_ <= var_142_16 + arg_142_0 then
				arg_139_1.mask_.enabled = true
				arg_139_1.mask_.raycastTarget = true

				arg_139_1:SetGaussion(false)
			end

			local var_142_17 = 2

			if var_142_16 <= arg_139_1.time_ and arg_139_1.time_ < var_142_16 + var_142_17 then
				local var_142_18 = (arg_139_1.time_ - var_142_16) / var_142_17
				local var_142_19 = Color.New(0, 0, 0)

				var_142_19.a = Mathf.Lerp(0, 1, var_142_18)
				arg_139_1.mask_.color = var_142_19
			end

			if arg_139_1.time_ >= var_142_16 + var_142_17 and arg_139_1.time_ < var_142_16 + var_142_17 + arg_142_0 then
				local var_142_20 = Color.New(0, 0, 0)

				var_142_20.a = 1
				arg_139_1.mask_.color = var_142_20
			end

			local var_142_21 = 2

			if var_142_21 < arg_139_1.time_ and arg_139_1.time_ <= var_142_21 + arg_142_0 then
				arg_139_1.mask_.enabled = true
				arg_139_1.mask_.raycastTarget = true

				arg_139_1:SetGaussion(false)
			end

			local var_142_22 = 2

			if var_142_21 <= arg_139_1.time_ and arg_139_1.time_ < var_142_21 + var_142_22 then
				local var_142_23 = (arg_139_1.time_ - var_142_21) / var_142_22
				local var_142_24 = Color.New(0, 0, 0)

				var_142_24.a = Mathf.Lerp(1, 0, var_142_23)
				arg_139_1.mask_.color = var_142_24
			end

			if arg_139_1.time_ >= var_142_21 + var_142_22 and arg_139_1.time_ < var_142_21 + var_142_22 + arg_142_0 then
				local var_142_25 = Color.New(0, 0, 0)
				local var_142_26 = 0

				arg_139_1.mask_.enabled = false
				var_142_25.a = var_142_26
				arg_139_1.mask_.color = var_142_25
			end

			local var_142_27 = arg_139_1.actors_["1084ui_story"].transform
			local var_142_28 = 1.966

			if var_142_28 < arg_139_1.time_ and arg_139_1.time_ <= var_142_28 + arg_142_0 then
				arg_139_1.var_.moveOldPos1084ui_story = var_142_27.localPosition
			end

			local var_142_29 = 0.001

			if var_142_28 <= arg_139_1.time_ and arg_139_1.time_ < var_142_28 + var_142_29 then
				local var_142_30 = (arg_139_1.time_ - var_142_28) / var_142_29
				local var_142_31 = Vector3.New(0, 100, 0)

				var_142_27.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1084ui_story, var_142_31, var_142_30)

				local var_142_32 = manager.ui.mainCamera.transform.position - var_142_27.position

				var_142_27.forward = Vector3.New(var_142_32.x, var_142_32.y, var_142_32.z)

				local var_142_33 = var_142_27.localEulerAngles

				var_142_33.z = 0
				var_142_33.x = 0
				var_142_27.localEulerAngles = var_142_33
			end

			if arg_139_1.time_ >= var_142_28 + var_142_29 and arg_139_1.time_ < var_142_28 + var_142_29 + arg_142_0 then
				var_142_27.localPosition = Vector3.New(0, 100, 0)

				local var_142_34 = manager.ui.mainCamera.transform.position - var_142_27.position

				var_142_27.forward = Vector3.New(var_142_34.x, var_142_34.y, var_142_34.z)

				local var_142_35 = var_142_27.localEulerAngles

				var_142_35.z = 0
				var_142_35.x = 0
				var_142_27.localEulerAngles = var_142_35
			end

			local var_142_36 = arg_139_1.actors_["1011ui_story"].transform
			local var_142_37 = 1.966

			if var_142_37 < arg_139_1.time_ and arg_139_1.time_ <= var_142_37 + arg_142_0 then
				arg_139_1.var_.moveOldPos1011ui_story = var_142_36.localPosition
			end

			local var_142_38 = 0.001

			if var_142_37 <= arg_139_1.time_ and arg_139_1.time_ < var_142_37 + var_142_38 then
				local var_142_39 = (arg_139_1.time_ - var_142_37) / var_142_38
				local var_142_40 = Vector3.New(0, 100, 0)

				var_142_36.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1011ui_story, var_142_40, var_142_39)

				local var_142_41 = manager.ui.mainCamera.transform.position - var_142_36.position

				var_142_36.forward = Vector3.New(var_142_41.x, var_142_41.y, var_142_41.z)

				local var_142_42 = var_142_36.localEulerAngles

				var_142_42.z = 0
				var_142_42.x = 0
				var_142_36.localEulerAngles = var_142_42
			end

			if arg_139_1.time_ >= var_142_37 + var_142_38 and arg_139_1.time_ < var_142_37 + var_142_38 + arg_142_0 then
				var_142_36.localPosition = Vector3.New(0, 100, 0)

				local var_142_43 = manager.ui.mainCamera.transform.position - var_142_36.position

				var_142_36.forward = Vector3.New(var_142_43.x, var_142_43.y, var_142_43.z)

				local var_142_44 = var_142_36.localEulerAngles

				var_142_44.z = 0
				var_142_44.x = 0
				var_142_36.localEulerAngles = var_142_44
			end

			local var_142_45 = 0
			local var_142_46 = 1

			if var_142_45 < arg_139_1.time_ and arg_139_1.time_ <= var_142_45 + arg_142_0 then
				local var_142_47 = "play"
				local var_142_48 = "music"

				arg_139_1:AudioAction(var_142_47, var_142_48, "ui_battle", "ui_battle_stopbgm", "")

				local var_142_49 = ""
				local var_142_50 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_142_50 ~= "" then
					if arg_139_1.bgmTxt_.text ~= var_142_50 and arg_139_1.bgmTxt_.text ~= "" then
						if arg_139_1.bgmTxt2_.text ~= "" then
							arg_139_1.bgmTxt_.text = arg_139_1.bgmTxt2_.text
						end

						arg_139_1.bgmTxt2_.text = var_142_50

						arg_139_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_139_1.bgmTxt_.text = var_142_50
						arg_139_1.bgmTxt2_.text = var_142_50
					end

					if arg_139_1.bgmTimer then
						arg_139_1.bgmTimer:Stop()

						arg_139_1.bgmTimer = nil
					end

					if arg_139_1.settingData.show_music_name == 1 then
						arg_139_1.musicController:SetSelectedState("show")
						arg_139_1.musicAnimator_:Play("open", 0, 0)

						if arg_139_1.settingData.music_time ~= 0 then
							arg_139_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_139_1.settingData.music_time), function()
								if arg_139_1 == nil or isNil(arg_139_1.bgmTxt_) then
									return
								end

								arg_139_1.musicController:SetSelectedState("hide")
								arg_139_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_139_1.frameCnt_ <= 1 then
				arg_139_1.dialog_:SetActive(false)
			end

			local var_142_51 = 4
			local var_142_52 = 0.75

			if var_142_51 < arg_139_1.time_ and arg_139_1.time_ <= var_142_51 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0

				arg_139_1.dialog_:SetActive(true)

				arg_139_1.dialogCg_.alpha = 0

				local var_142_53 = LeanTween.value(arg_139_1.dialog_, 0, 1, 0.3)

				var_142_53:setOnUpdate(LuaHelper.FloatAction(function(arg_144_0)
					arg_139_1.dialogCg_.alpha = arg_144_0
				end))
				var_142_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_139_1.dialog_)
					var_142_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_139_1.duration_ = arg_139_1.duration_ + 0.3

				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_54 = arg_139_1:GetWordFromCfg(116161030)
				local var_142_55 = arg_139_1:FormatText(var_142_54.content)

				arg_139_1.text_.text = var_142_55

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_56 = 30
				local var_142_57 = utf8.len(var_142_55)
				local var_142_58 = var_142_56 <= 0 and var_142_52 or var_142_52 * (var_142_57 / var_142_56)

				if var_142_58 > 0 and var_142_52 < var_142_58 then
					arg_139_1.talkMaxDuration = var_142_58
					var_142_51 = var_142_51 + 0.3

					if var_142_58 + var_142_51 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_58 + var_142_51
					end
				end

				arg_139_1.text_.text = var_142_55
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_59 = var_142_51 + 0.3
			local var_142_60 = math.max(var_142_52, arg_139_1.talkMaxDuration)

			if var_142_59 <= arg_139_1.time_ and arg_139_1.time_ < var_142_59 + var_142_60 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_59) / var_142_60

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_59 + var_142_60 and arg_139_1.time_ < var_142_59 + var_142_60 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play116161031 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 116161031
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play116161032(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0
			local var_149_1 = 0.266666666666667

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				local var_149_2 = "play"
				local var_149_3 = "music"

				arg_146_1:AudioAction(var_149_2, var_149_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_149_4 = ""
				local var_149_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_149_5 ~= "" then
					if arg_146_1.bgmTxt_.text ~= var_149_5 and arg_146_1.bgmTxt_.text ~= "" then
						if arg_146_1.bgmTxt2_.text ~= "" then
							arg_146_1.bgmTxt_.text = arg_146_1.bgmTxt2_.text
						end

						arg_146_1.bgmTxt2_.text = var_149_5

						arg_146_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_146_1.bgmTxt_.text = var_149_5
						arg_146_1.bgmTxt2_.text = var_149_5
					end

					if arg_146_1.bgmTimer then
						arg_146_1.bgmTimer:Stop()

						arg_146_1.bgmTimer = nil
					end

					if arg_146_1.settingData.show_music_name == 1 then
						arg_146_1.musicController:SetSelectedState("show")
						arg_146_1.musicAnimator_:Play("open", 0, 0)

						if arg_146_1.settingData.music_time ~= 0 then
							arg_146_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_146_1.settingData.music_time), function()
								if arg_146_1 == nil or isNil(arg_146_1.bgmTxt_) then
									return
								end

								arg_146_1.musicController:SetSelectedState("hide")
								arg_146_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_149_6 = 0.4
			local var_149_7 = 0.6

			if var_149_6 < arg_146_1.time_ and arg_146_1.time_ <= var_149_6 + arg_149_0 then
				local var_149_8 = "play"
				local var_149_9 = "music"

				arg_146_1:AudioAction(var_149_8, var_149_9, "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_149_10 = ""
				local var_149_11 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if var_149_11 ~= "" then
					if arg_146_1.bgmTxt_.text ~= var_149_11 and arg_146_1.bgmTxt_.text ~= "" then
						if arg_146_1.bgmTxt2_.text ~= "" then
							arg_146_1.bgmTxt_.text = arg_146_1.bgmTxt2_.text
						end

						arg_146_1.bgmTxt2_.text = var_149_11

						arg_146_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_146_1.bgmTxt_.text = var_149_11
						arg_146_1.bgmTxt2_.text = var_149_11
					end

					if arg_146_1.bgmTimer then
						arg_146_1.bgmTimer:Stop()

						arg_146_1.bgmTimer = nil
					end

					if arg_146_1.settingData.show_music_name == 1 then
						arg_146_1.musicController:SetSelectedState("show")
						arg_146_1.musicAnimator_:Play("open", 0, 0)

						if arg_146_1.settingData.music_time ~= 0 then
							arg_146_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_146_1.settingData.music_time), function()
								if arg_146_1 == nil or isNil(arg_146_1.bgmTxt_) then
									return
								end

								arg_146_1.musicController:SetSelectedState("hide")
								arg_146_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_149_12 = 0
			local var_149_13 = 1.075

			if var_149_12 < arg_146_1.time_ and arg_146_1.time_ <= var_149_12 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_14 = arg_146_1:GetWordFromCfg(116161031)
				local var_149_15 = arg_146_1:FormatText(var_149_14.content)

				arg_146_1.text_.text = var_149_15

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_16 = 43
				local var_149_17 = utf8.len(var_149_15)
				local var_149_18 = var_149_16 <= 0 and var_149_13 or var_149_13 * (var_149_17 / var_149_16)

				if var_149_18 > 0 and var_149_13 < var_149_18 then
					arg_146_1.talkMaxDuration = var_149_18

					if var_149_18 + var_149_12 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_18 + var_149_12
					end
				end

				arg_146_1.text_.text = var_149_15
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_19 = math.max(var_149_13, arg_146_1.talkMaxDuration)

			if var_149_12 <= arg_146_1.time_ and arg_146_1.time_ < var_149_12 + var_149_19 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_12) / var_149_19

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_12 + var_149_19 and arg_146_1.time_ < var_149_12 + var_149_19 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play116161032 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 116161032
		arg_152_1.duration_ = 5.7

		local var_152_0 = {
			zh = 5.7,
			ja = 2.133
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play116161033(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["10025ui_story"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect10025ui_story == nil then
				arg_152_1.var_.characterEffect10025ui_story = var_155_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.2

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.characterEffect10025ui_story and not isNil(var_155_0) then
					arg_152_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect10025ui_story then
				arg_152_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_155_4 = 0

			if var_155_4 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_155_5 = 0

			if var_155_5 < arg_152_1.time_ and arg_152_1.time_ <= var_155_5 + arg_155_0 then
				arg_152_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_155_6 = arg_152_1.actors_["10025ui_story"].transform
			local var_155_7 = 0

			if var_155_7 < arg_152_1.time_ and arg_152_1.time_ <= var_155_7 + arg_155_0 then
				arg_152_1.var_.moveOldPos10025ui_story = var_155_6.localPosition
			end

			local var_155_8 = 0.001

			if var_155_7 <= arg_152_1.time_ and arg_152_1.time_ < var_155_7 + var_155_8 then
				local var_155_9 = (arg_152_1.time_ - var_155_7) / var_155_8
				local var_155_10 = Vector3.New(0, -1.1, -5.9)

				var_155_6.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos10025ui_story, var_155_10, var_155_9)

				local var_155_11 = manager.ui.mainCamera.transform.position - var_155_6.position

				var_155_6.forward = Vector3.New(var_155_11.x, var_155_11.y, var_155_11.z)

				local var_155_12 = var_155_6.localEulerAngles

				var_155_12.z = 0
				var_155_12.x = 0
				var_155_6.localEulerAngles = var_155_12
			end

			if arg_152_1.time_ >= var_155_7 + var_155_8 and arg_152_1.time_ < var_155_7 + var_155_8 + arg_155_0 then
				var_155_6.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_155_13 = manager.ui.mainCamera.transform.position - var_155_6.position

				var_155_6.forward = Vector3.New(var_155_13.x, var_155_13.y, var_155_13.z)

				local var_155_14 = var_155_6.localEulerAngles

				var_155_14.z = 0
				var_155_14.x = 0
				var_155_6.localEulerAngles = var_155_14
			end

			local var_155_15 = 0
			local var_155_16 = 0.1

			if var_155_15 < arg_152_1.time_ and arg_152_1.time_ <= var_155_15 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_17 = arg_152_1:FormatText(StoryNameCfg[328].name)

				arg_152_1.leftNameTxt_.text = var_155_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_18 = arg_152_1:GetWordFromCfg(116161032)
				local var_155_19 = arg_152_1:FormatText(var_155_18.content)

				arg_152_1.text_.text = var_155_19

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_20 = 4
				local var_155_21 = utf8.len(var_155_19)
				local var_155_22 = var_155_20 <= 0 and var_155_16 or var_155_16 * (var_155_21 / var_155_20)

				if var_155_22 > 0 and var_155_16 < var_155_22 then
					arg_152_1.talkMaxDuration = var_155_22

					if var_155_22 + var_155_15 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_22 + var_155_15
					end
				end

				arg_152_1.text_.text = var_155_19
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161032", "story_v_out_116161.awb") ~= 0 then
					local var_155_23 = manager.audio:GetVoiceLength("story_v_out_116161", "116161032", "story_v_out_116161.awb") / 1000

					if var_155_23 + var_155_15 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_23 + var_155_15
					end

					if var_155_18.prefab_name ~= "" and arg_152_1.actors_[var_155_18.prefab_name] ~= nil then
						local var_155_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_18.prefab_name].transform, "story_v_out_116161", "116161032", "story_v_out_116161.awb")

						arg_152_1:RecordAudio("116161032", var_155_24)
						arg_152_1:RecordAudio("116161032", var_155_24)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_116161", "116161032", "story_v_out_116161.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_116161", "116161032", "story_v_out_116161.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_25 = math.max(var_155_16, arg_152_1.talkMaxDuration)

			if var_155_15 <= arg_152_1.time_ and arg_152_1.time_ < var_155_15 + var_155_25 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_15) / var_155_25

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_15 + var_155_25 and arg_152_1.time_ < var_155_15 + var_155_25 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play116161033 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 116161033
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play116161034(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["10025ui_story"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect10025ui_story == nil then
				arg_156_1.var_.characterEffect10025ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.2

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect10025ui_story and not isNil(var_159_0) then
					local var_159_4 = Mathf.Lerp(0, 0.5, var_159_3)

					arg_156_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_156_1.var_.characterEffect10025ui_story.fillRatio = var_159_4
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect10025ui_story then
				local var_159_5 = 0.5

				arg_156_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_156_1.var_.characterEffect10025ui_story.fillRatio = var_159_5
			end

			local var_159_6 = 0
			local var_159_7 = 0.775

			if var_159_6 < arg_156_1.time_ and arg_156_1.time_ <= var_159_6 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_8 = arg_156_1:GetWordFromCfg(116161033)
				local var_159_9 = arg_156_1:FormatText(var_159_8.content)

				arg_156_1.text_.text = var_159_9

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_10 = 31
				local var_159_11 = utf8.len(var_159_9)
				local var_159_12 = var_159_10 <= 0 and var_159_7 or var_159_7 * (var_159_11 / var_159_10)

				if var_159_12 > 0 and var_159_7 < var_159_12 then
					arg_156_1.talkMaxDuration = var_159_12

					if var_159_12 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_12 + var_159_6
					end
				end

				arg_156_1.text_.text = var_159_9
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_13 = math.max(var_159_7, arg_156_1.talkMaxDuration)

			if var_159_6 <= arg_156_1.time_ and arg_156_1.time_ < var_159_6 + var_159_13 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_6) / var_159_13

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_6 + var_159_13 and arg_156_1.time_ < var_159_6 + var_159_13 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play116161034 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 116161034
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play116161035(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0
			local var_163_1 = 0.2

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_2 = arg_160_1:FormatText(StoryNameCfg[7].name)

				arg_160_1.leftNameTxt_.text = var_163_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_3 = arg_160_1:GetWordFromCfg(116161034)
				local var_163_4 = arg_160_1:FormatText(var_163_3.content)

				arg_160_1.text_.text = var_163_4

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_5 = 8
				local var_163_6 = utf8.len(var_163_4)
				local var_163_7 = var_163_5 <= 0 and var_163_1 or var_163_1 * (var_163_6 / var_163_5)

				if var_163_7 > 0 and var_163_1 < var_163_7 then
					arg_160_1.talkMaxDuration = var_163_7

					if var_163_7 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_0
					end
				end

				arg_160_1.text_.text = var_163_4
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_8 = math.max(var_163_1, arg_160_1.talkMaxDuration)

			if var_163_0 <= arg_160_1.time_ and arg_160_1.time_ < var_163_0 + var_163_8 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_0) / var_163_8

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_0 + var_163_8 and arg_160_1.time_ < var_163_0 + var_163_8 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play116161035 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 116161035
		arg_164_1.duration_ = 7.27

		local var_164_0 = {
			zh = 5.466,
			ja = 7.266
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play116161036(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["10025ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect10025ui_story == nil then
				arg_164_1.var_.characterEffect10025ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.2

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect10025ui_story and not isNil(var_167_0) then
					arg_164_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect10025ui_story then
				arg_164_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_167_4 = 0

			if var_167_4 < arg_164_1.time_ and arg_164_1.time_ <= var_167_4 + arg_167_0 then
				arg_164_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_2")
			end

			local var_167_5 = 0

			if var_167_5 < arg_164_1.time_ and arg_164_1.time_ <= var_167_5 + arg_167_0 then
				arg_164_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_167_6 = 0
			local var_167_7 = 0.375

			if var_167_6 < arg_164_1.time_ and arg_164_1.time_ <= var_167_6 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_8 = arg_164_1:FormatText(StoryNameCfg[328].name)

				arg_164_1.leftNameTxt_.text = var_167_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_9 = arg_164_1:GetWordFromCfg(116161035)
				local var_167_10 = arg_164_1:FormatText(var_167_9.content)

				arg_164_1.text_.text = var_167_10

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_11 = 15
				local var_167_12 = utf8.len(var_167_10)
				local var_167_13 = var_167_11 <= 0 and var_167_7 or var_167_7 * (var_167_12 / var_167_11)

				if var_167_13 > 0 and var_167_7 < var_167_13 then
					arg_164_1.talkMaxDuration = var_167_13

					if var_167_13 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_13 + var_167_6
					end
				end

				arg_164_1.text_.text = var_167_10
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161035", "story_v_out_116161.awb") ~= 0 then
					local var_167_14 = manager.audio:GetVoiceLength("story_v_out_116161", "116161035", "story_v_out_116161.awb") / 1000

					if var_167_14 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_14 + var_167_6
					end

					if var_167_9.prefab_name ~= "" and arg_164_1.actors_[var_167_9.prefab_name] ~= nil then
						local var_167_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_9.prefab_name].transform, "story_v_out_116161", "116161035", "story_v_out_116161.awb")

						arg_164_1:RecordAudio("116161035", var_167_15)
						arg_164_1:RecordAudio("116161035", var_167_15)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_116161", "116161035", "story_v_out_116161.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_116161", "116161035", "story_v_out_116161.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_16 = math.max(var_167_7, arg_164_1.talkMaxDuration)

			if var_167_6 <= arg_164_1.time_ and arg_164_1.time_ < var_167_6 + var_167_16 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_6) / var_167_16

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_6 + var_167_16 and arg_164_1.time_ < var_167_6 + var_167_16 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play116161036 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 116161036
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play116161037(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["10025ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect10025ui_story == nil then
				arg_168_1.var_.characterEffect10025ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.2

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect10025ui_story and not isNil(var_171_0) then
					local var_171_4 = Mathf.Lerp(0, 0.5, var_171_3)

					arg_168_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_168_1.var_.characterEffect10025ui_story.fillRatio = var_171_4
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect10025ui_story then
				local var_171_5 = 0.5

				arg_168_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_168_1.var_.characterEffect10025ui_story.fillRatio = var_171_5
			end

			local var_171_6 = 0
			local var_171_7 = 0.525

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

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_9 = arg_168_1:GetWordFromCfg(116161036)
				local var_171_10 = arg_168_1:FormatText(var_171_9.content)

				arg_168_1.text_.text = var_171_10

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_11 = 21
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
	Play116161037 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 116161037
		arg_172_1.duration_ = 8.53

		local var_172_0 = {
			zh = 8.533,
			ja = 4.833
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play116161038(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["10025ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect10025ui_story == nil then
				arg_172_1.var_.characterEffect10025ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.2

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect10025ui_story and not isNil(var_175_0) then
					arg_172_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect10025ui_story then
				arg_172_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_175_4 = 0

			if var_175_4 < arg_172_1.time_ and arg_172_1.time_ <= var_175_4 + arg_175_0 then
				arg_172_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action3_1")
			end

			local var_175_5 = 0

			if var_175_5 < arg_172_1.time_ and arg_172_1.time_ <= var_175_5 + arg_175_0 then
				arg_172_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_175_6 = 0
			local var_175_7 = 0.625

			if var_175_6 < arg_172_1.time_ and arg_172_1.time_ <= var_175_6 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_8 = arg_172_1:FormatText(StoryNameCfg[328].name)

				arg_172_1.leftNameTxt_.text = var_175_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_9 = arg_172_1:GetWordFromCfg(116161037)
				local var_175_10 = arg_172_1:FormatText(var_175_9.content)

				arg_172_1.text_.text = var_175_10

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_11 = 25
				local var_175_12 = utf8.len(var_175_10)
				local var_175_13 = var_175_11 <= 0 and var_175_7 or var_175_7 * (var_175_12 / var_175_11)

				if var_175_13 > 0 and var_175_7 < var_175_13 then
					arg_172_1.talkMaxDuration = var_175_13

					if var_175_13 + var_175_6 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_13 + var_175_6
					end
				end

				arg_172_1.text_.text = var_175_10
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161037", "story_v_out_116161.awb") ~= 0 then
					local var_175_14 = manager.audio:GetVoiceLength("story_v_out_116161", "116161037", "story_v_out_116161.awb") / 1000

					if var_175_14 + var_175_6 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_14 + var_175_6
					end

					if var_175_9.prefab_name ~= "" and arg_172_1.actors_[var_175_9.prefab_name] ~= nil then
						local var_175_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_9.prefab_name].transform, "story_v_out_116161", "116161037", "story_v_out_116161.awb")

						arg_172_1:RecordAudio("116161037", var_175_15)
						arg_172_1:RecordAudio("116161037", var_175_15)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_116161", "116161037", "story_v_out_116161.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_116161", "116161037", "story_v_out_116161.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_16 = math.max(var_175_7, arg_172_1.talkMaxDuration)

			if var_175_6 <= arg_172_1.time_ and arg_172_1.time_ < var_175_6 + var_175_16 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_6) / var_175_16

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_6 + var_175_16 and arg_172_1.time_ < var_175_6 + var_175_16 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play116161038 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 116161038
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play116161039(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["10025ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect10025ui_story == nil then
				arg_176_1.var_.characterEffect10025ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.2

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect10025ui_story and not isNil(var_179_0) then
					local var_179_4 = Mathf.Lerp(0, 0.5, var_179_3)

					arg_176_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_176_1.var_.characterEffect10025ui_story.fillRatio = var_179_4
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect10025ui_story then
				local var_179_5 = 0.5

				arg_176_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_176_1.var_.characterEffect10025ui_story.fillRatio = var_179_5
			end

			local var_179_6 = 0
			local var_179_7 = 0.95

			if var_179_6 < arg_176_1.time_ and arg_176_1.time_ <= var_179_6 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_8 = arg_176_1:FormatText(StoryNameCfg[7].name)

				arg_176_1.leftNameTxt_.text = var_179_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, true)
				arg_176_1.iconController_:SetSelectedState("hero")

				arg_176_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_176_1.callingController_:SetSelectedState("normal")

				arg_176_1.keyicon_.color = Color.New(1, 1, 1)
				arg_176_1.icon_.color = Color.New(1, 1, 1)

				local var_179_9 = arg_176_1:GetWordFromCfg(116161038)
				local var_179_10 = arg_176_1:FormatText(var_179_9.content)

				arg_176_1.text_.text = var_179_10

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_11 = 38
				local var_179_12 = utf8.len(var_179_10)
				local var_179_13 = var_179_11 <= 0 and var_179_7 or var_179_7 * (var_179_12 / var_179_11)

				if var_179_13 > 0 and var_179_7 < var_179_13 then
					arg_176_1.talkMaxDuration = var_179_13

					if var_179_13 + var_179_6 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_13 + var_179_6
					end
				end

				arg_176_1.text_.text = var_179_10
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_14 = math.max(var_179_7, arg_176_1.talkMaxDuration)

			if var_179_6 <= arg_176_1.time_ and arg_176_1.time_ < var_179_6 + var_179_14 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_6) / var_179_14

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_6 + var_179_14 and arg_176_1.time_ < var_179_6 + var_179_14 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play116161039 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 116161039
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play116161040(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0

			if var_183_0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action3_2")
			end

			local var_183_1 = 0
			local var_183_2 = 1.125

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_3 = arg_180_1:GetWordFromCfg(116161039)
				local var_183_4 = arg_180_1:FormatText(var_183_3.content)

				arg_180_1.text_.text = var_183_4

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_5 = 45
				local var_183_6 = utf8.len(var_183_4)
				local var_183_7 = var_183_5 <= 0 and var_183_2 or var_183_2 * (var_183_6 / var_183_5)

				if var_183_7 > 0 and var_183_2 < var_183_7 then
					arg_180_1.talkMaxDuration = var_183_7

					if var_183_7 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_7 + var_183_1
					end
				end

				arg_180_1.text_.text = var_183_4
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_8 = math.max(var_183_2, arg_180_1.talkMaxDuration)

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_8 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_1) / var_183_8

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_1 + var_183_8 and arg_180_1.time_ < var_183_1 + var_183_8 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play116161040 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 116161040
		arg_184_1.duration_ = 6.53

		local var_184_0 = {
			zh = 4.866,
			ja = 6.533
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play116161041(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10025ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect10025ui_story == nil then
				arg_184_1.var_.characterEffect10025ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.2

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect10025ui_story and not isNil(var_187_0) then
					arg_184_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect10025ui_story then
				arg_184_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_187_4 = 0

			if var_187_4 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			local var_187_5 = 0

			if var_187_5 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 then
				arg_184_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_187_6 = 0
			local var_187_7 = 0.325

			if var_187_6 < arg_184_1.time_ and arg_184_1.time_ <= var_187_6 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_8 = arg_184_1:FormatText(StoryNameCfg[328].name)

				arg_184_1.leftNameTxt_.text = var_187_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_9 = arg_184_1:GetWordFromCfg(116161040)
				local var_187_10 = arg_184_1:FormatText(var_187_9.content)

				arg_184_1.text_.text = var_187_10

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_11 = 13
				local var_187_12 = utf8.len(var_187_10)
				local var_187_13 = var_187_11 <= 0 and var_187_7 or var_187_7 * (var_187_12 / var_187_11)

				if var_187_13 > 0 and var_187_7 < var_187_13 then
					arg_184_1.talkMaxDuration = var_187_13

					if var_187_13 + var_187_6 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_13 + var_187_6
					end
				end

				arg_184_1.text_.text = var_187_10
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161040", "story_v_out_116161.awb") ~= 0 then
					local var_187_14 = manager.audio:GetVoiceLength("story_v_out_116161", "116161040", "story_v_out_116161.awb") / 1000

					if var_187_14 + var_187_6 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_14 + var_187_6
					end

					if var_187_9.prefab_name ~= "" and arg_184_1.actors_[var_187_9.prefab_name] ~= nil then
						local var_187_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_9.prefab_name].transform, "story_v_out_116161", "116161040", "story_v_out_116161.awb")

						arg_184_1:RecordAudio("116161040", var_187_15)
						arg_184_1:RecordAudio("116161040", var_187_15)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_116161", "116161040", "story_v_out_116161.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_116161", "116161040", "story_v_out_116161.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_16 = math.max(var_187_7, arg_184_1.talkMaxDuration)

			if var_187_6 <= arg_184_1.time_ and arg_184_1.time_ < var_187_6 + var_187_16 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_6) / var_187_16

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_6 + var_187_16 and arg_184_1.time_ < var_187_6 + var_187_16 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play116161041 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 116161041
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play116161042(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["10025ui_story"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect10025ui_story == nil then
				arg_188_1.var_.characterEffect10025ui_story = var_191_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.2

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.characterEffect10025ui_story and not isNil(var_191_0) then
					local var_191_4 = Mathf.Lerp(0, 0.5, var_191_3)

					arg_188_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_188_1.var_.characterEffect10025ui_story.fillRatio = var_191_4
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect10025ui_story then
				local var_191_5 = 0.5

				arg_188_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_188_1.var_.characterEffect10025ui_story.fillRatio = var_191_5
			end

			local var_191_6 = 0
			local var_191_7 = 0.4

			if var_191_6 < arg_188_1.time_ and arg_188_1.time_ <= var_191_6 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_8 = arg_188_1:FormatText(StoryNameCfg[7].name)

				arg_188_1.leftNameTxt_.text = var_191_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_9 = arg_188_1:GetWordFromCfg(116161041)
				local var_191_10 = arg_188_1:FormatText(var_191_9.content)

				arg_188_1.text_.text = var_191_10

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_11 = 16
				local var_191_12 = utf8.len(var_191_10)
				local var_191_13 = var_191_11 <= 0 and var_191_7 or var_191_7 * (var_191_12 / var_191_11)

				if var_191_13 > 0 and var_191_7 < var_191_13 then
					arg_188_1.talkMaxDuration = var_191_13

					if var_191_13 + var_191_6 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_13 + var_191_6
					end
				end

				arg_188_1.text_.text = var_191_10
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_14 = math.max(var_191_7, arg_188_1.talkMaxDuration)

			if var_191_6 <= arg_188_1.time_ and arg_188_1.time_ < var_191_6 + var_191_14 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_6) / var_191_14

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_6 + var_191_14 and arg_188_1.time_ < var_191_6 + var_191_14 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play116161042 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 116161042
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play116161043(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0
			local var_195_1 = 1.075

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_2 = arg_192_1:FormatText(StoryNameCfg[7].name)

				arg_192_1.leftNameTxt_.text = var_195_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_3 = arg_192_1:GetWordFromCfg(116161042)
				local var_195_4 = arg_192_1:FormatText(var_195_3.content)

				arg_192_1.text_.text = var_195_4

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 43
				local var_195_6 = utf8.len(var_195_4)
				local var_195_7 = var_195_5 <= 0 and var_195_1 or var_195_1 * (var_195_6 / var_195_5)

				if var_195_7 > 0 and var_195_1 < var_195_7 then
					arg_192_1.talkMaxDuration = var_195_7

					if var_195_7 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_7 + var_195_0
					end
				end

				arg_192_1.text_.text = var_195_4
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_8 = math.max(var_195_1, arg_192_1.talkMaxDuration)

			if var_195_0 <= arg_192_1.time_ and arg_192_1.time_ < var_195_0 + var_195_8 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_0) / var_195_8

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_0 + var_195_8 and arg_192_1.time_ < var_195_0 + var_195_8 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play116161043 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 116161043
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play116161044(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0
			local var_199_1 = 0.55

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_2 = arg_196_1:FormatText(StoryNameCfg[7].name)

				arg_196_1.leftNameTxt_.text = var_199_2

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

				local var_199_3 = arg_196_1:GetWordFromCfg(116161043)
				local var_199_4 = arg_196_1:FormatText(var_199_3.content)

				arg_196_1.text_.text = var_199_4

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_5 = 22
				local var_199_6 = utf8.len(var_199_4)
				local var_199_7 = var_199_5 <= 0 and var_199_1 or var_199_1 * (var_199_6 / var_199_5)

				if var_199_7 > 0 and var_199_1 < var_199_7 then
					arg_196_1.talkMaxDuration = var_199_7

					if var_199_7 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_7 + var_199_0
					end
				end

				arg_196_1.text_.text = var_199_4
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_8 = math.max(var_199_1, arg_196_1.talkMaxDuration)

			if var_199_0 <= arg_196_1.time_ and arg_196_1.time_ < var_199_0 + var_199_8 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_0) / var_199_8

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_0 + var_199_8 and arg_196_1.time_ < var_199_0 + var_199_8 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play116161044 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 116161044
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play116161045(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0
			local var_203_1 = 0.7

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_2 = arg_200_1:GetWordFromCfg(116161044)
				local var_203_3 = arg_200_1:FormatText(var_203_2.content)

				arg_200_1.text_.text = var_203_3

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_4 = 28
				local var_203_5 = utf8.len(var_203_3)
				local var_203_6 = var_203_4 <= 0 and var_203_1 or var_203_1 * (var_203_5 / var_203_4)

				if var_203_6 > 0 and var_203_1 < var_203_6 then
					arg_200_1.talkMaxDuration = var_203_6

					if var_203_6 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_6 + var_203_0
					end
				end

				arg_200_1.text_.text = var_203_3
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_7 = math.max(var_203_1, arg_200_1.talkMaxDuration)

			if var_203_0 <= arg_200_1.time_ and arg_200_1.time_ < var_203_0 + var_203_7 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_0) / var_203_7

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_0 + var_203_7 and arg_200_1.time_ < var_203_0 + var_203_7 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play116161045 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 116161045
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play116161046(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action453")
			end

			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 then
				arg_204_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_207_2 = 0
			local var_207_3 = 1.25

			if var_207_2 < arg_204_1.time_ and arg_204_1.time_ <= var_207_2 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_4 = arg_204_1:GetWordFromCfg(116161045)
				local var_207_5 = arg_204_1:FormatText(var_207_4.content)

				arg_204_1.text_.text = var_207_5

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_6 = 50
				local var_207_7 = utf8.len(var_207_5)
				local var_207_8 = var_207_6 <= 0 and var_207_3 or var_207_3 * (var_207_7 / var_207_6)

				if var_207_8 > 0 and var_207_3 < var_207_8 then
					arg_204_1.talkMaxDuration = var_207_8

					if var_207_8 + var_207_2 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_8 + var_207_2
					end
				end

				arg_204_1.text_.text = var_207_5
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_9 = math.max(var_207_3, arg_204_1.talkMaxDuration)

			if var_207_2 <= arg_204_1.time_ and arg_204_1.time_ < var_207_2 + var_207_9 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_2) / var_207_9

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_2 + var_207_9 and arg_204_1.time_ < var_207_2 + var_207_9 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play116161046 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 116161046
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play116161047(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0
			local var_211_1 = 1.025

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_2 = arg_208_1:FormatText(StoryNameCfg[7].name)

				arg_208_1.leftNameTxt_.text = var_211_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_3 = arg_208_1:GetWordFromCfg(116161046)
				local var_211_4 = arg_208_1:FormatText(var_211_3.content)

				arg_208_1.text_.text = var_211_4

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_5 = 41
				local var_211_6 = utf8.len(var_211_4)
				local var_211_7 = var_211_5 <= 0 and var_211_1 or var_211_1 * (var_211_6 / var_211_5)

				if var_211_7 > 0 and var_211_1 < var_211_7 then
					arg_208_1.talkMaxDuration = var_211_7

					if var_211_7 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_7 + var_211_0
					end
				end

				arg_208_1.text_.text = var_211_4
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_8 = math.max(var_211_1, arg_208_1.talkMaxDuration)

			if var_211_0 <= arg_208_1.time_ and arg_208_1.time_ < var_211_0 + var_211_8 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_0) / var_211_8

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_0 + var_211_8 and arg_208_1.time_ < var_211_0 + var_211_8 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play116161047 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 116161047
		arg_212_1.duration_ = 3.37

		local var_212_0 = {
			zh = 2.866,
			ja = 3.366
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play116161048(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["10025ui_story"]
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect10025ui_story == nil then
				arg_212_1.var_.characterEffect10025ui_story = var_215_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_2 = 0.2

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 and not isNil(var_215_0) then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2

				if arg_212_1.var_.characterEffect10025ui_story and not isNil(var_215_0) then
					arg_212_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect10025ui_story then
				arg_212_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_215_4 = 0

			if var_215_4 < arg_212_1.time_ and arg_212_1.time_ <= var_215_4 + arg_215_0 then
				arg_212_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action3_2")
			end

			local var_215_5 = 0

			if var_215_5 < arg_212_1.time_ and arg_212_1.time_ <= var_215_5 + arg_215_0 then
				arg_212_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_215_6 = 0
			local var_215_7 = 0.175

			if var_215_6 < arg_212_1.time_ and arg_212_1.time_ <= var_215_6 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_8 = arg_212_1:FormatText(StoryNameCfg[328].name)

				arg_212_1.leftNameTxt_.text = var_215_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_9 = arg_212_1:GetWordFromCfg(116161047)
				local var_215_10 = arg_212_1:FormatText(var_215_9.content)

				arg_212_1.text_.text = var_215_10

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_11 = 7
				local var_215_12 = utf8.len(var_215_10)
				local var_215_13 = var_215_11 <= 0 and var_215_7 or var_215_7 * (var_215_12 / var_215_11)

				if var_215_13 > 0 and var_215_7 < var_215_13 then
					arg_212_1.talkMaxDuration = var_215_13

					if var_215_13 + var_215_6 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_13 + var_215_6
					end
				end

				arg_212_1.text_.text = var_215_10
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161047", "story_v_out_116161.awb") ~= 0 then
					local var_215_14 = manager.audio:GetVoiceLength("story_v_out_116161", "116161047", "story_v_out_116161.awb") / 1000

					if var_215_14 + var_215_6 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_14 + var_215_6
					end

					if var_215_9.prefab_name ~= "" and arg_212_1.actors_[var_215_9.prefab_name] ~= nil then
						local var_215_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_9.prefab_name].transform, "story_v_out_116161", "116161047", "story_v_out_116161.awb")

						arg_212_1:RecordAudio("116161047", var_215_15)
						arg_212_1:RecordAudio("116161047", var_215_15)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_116161", "116161047", "story_v_out_116161.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_116161", "116161047", "story_v_out_116161.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_16 = math.max(var_215_7, arg_212_1.talkMaxDuration)

			if var_215_6 <= arg_212_1.time_ and arg_212_1.time_ < var_215_6 + var_215_16 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_6) / var_215_16

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_6 + var_215_16 and arg_212_1.time_ < var_215_6 + var_215_16 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play116161048 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 116161048
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play116161049(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["10025ui_story"].transform
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.var_.moveOldPos10025ui_story = var_219_0.localPosition
			end

			local var_219_2 = 0.001

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2
				local var_219_4 = Vector3.New(0, 100, 0)

				var_219_0.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10025ui_story, var_219_4, var_219_3)

				local var_219_5 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_5.x, var_219_5.y, var_219_5.z)

				local var_219_6 = var_219_0.localEulerAngles

				var_219_6.z = 0
				var_219_6.x = 0
				var_219_0.localEulerAngles = var_219_6
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 then
				var_219_0.localPosition = Vector3.New(0, 100, 0)

				local var_219_7 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_7.x, var_219_7.y, var_219_7.z)

				local var_219_8 = var_219_0.localEulerAngles

				var_219_8.z = 0
				var_219_8.x = 0
				var_219_0.localEulerAngles = var_219_8
			end

			local var_219_9 = 0
			local var_219_10 = 0.825

			if var_219_9 < arg_216_1.time_ and arg_216_1.time_ <= var_219_9 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_11 = arg_216_1:GetWordFromCfg(116161048)
				local var_219_12 = arg_216_1:FormatText(var_219_11.content)

				arg_216_1.text_.text = var_219_12

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_13 = 33
				local var_219_14 = utf8.len(var_219_12)
				local var_219_15 = var_219_13 <= 0 and var_219_10 or var_219_10 * (var_219_14 / var_219_13)

				if var_219_15 > 0 and var_219_10 < var_219_15 then
					arg_216_1.talkMaxDuration = var_219_15

					if var_219_15 + var_219_9 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_15 + var_219_9
					end
				end

				arg_216_1.text_.text = var_219_12
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_16 = math.max(var_219_10, arg_216_1.talkMaxDuration)

			if var_219_9 <= arg_216_1.time_ and arg_216_1.time_ < var_219_9 + var_219_16 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_9) / var_219_16

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_9 + var_219_16 and arg_216_1.time_ < var_219_9 + var_219_16 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play116161049 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 116161049
		arg_220_1.duration_ = 2.47

		local var_220_0 = {
			zh = 2.466,
			ja = 1.2
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play116161050(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 0
			local var_223_1 = 0.175

			if var_223_0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_2 = arg_220_1:FormatText(StoryNameCfg[328].name)

				arg_220_1.leftNameTxt_.text = var_223_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_3 = arg_220_1:GetWordFromCfg(116161049)
				local var_223_4 = arg_220_1:FormatText(var_223_3.content)

				arg_220_1.text_.text = var_223_4

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_5 = 7
				local var_223_6 = utf8.len(var_223_4)
				local var_223_7 = var_223_5 <= 0 and var_223_1 or var_223_1 * (var_223_6 / var_223_5)

				if var_223_7 > 0 and var_223_1 < var_223_7 then
					arg_220_1.talkMaxDuration = var_223_7

					if var_223_7 + var_223_0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_7 + var_223_0
					end
				end

				arg_220_1.text_.text = var_223_4
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161049", "story_v_out_116161.awb") ~= 0 then
					local var_223_8 = manager.audio:GetVoiceLength("story_v_out_116161", "116161049", "story_v_out_116161.awb") / 1000

					if var_223_8 + var_223_0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_8 + var_223_0
					end

					if var_223_3.prefab_name ~= "" and arg_220_1.actors_[var_223_3.prefab_name] ~= nil then
						local var_223_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_3.prefab_name].transform, "story_v_out_116161", "116161049", "story_v_out_116161.awb")

						arg_220_1:RecordAudio("116161049", var_223_9)
						arg_220_1:RecordAudio("116161049", var_223_9)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_116161", "116161049", "story_v_out_116161.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_116161", "116161049", "story_v_out_116161.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_10 = math.max(var_223_1, arg_220_1.talkMaxDuration)

			if var_223_0 <= arg_220_1.time_ and arg_220_1.time_ < var_223_0 + var_223_10 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_0) / var_223_10

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_0 + var_223_10 and arg_220_1.time_ < var_223_0 + var_223_10 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play116161050 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 116161050
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play116161051(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["10025ui_story"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect10025ui_story == nil then
				arg_224_1.var_.characterEffect10025ui_story = var_227_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.2

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 and not isNil(var_227_0) then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2

				if arg_224_1.var_.characterEffect10025ui_story and not isNil(var_227_0) then
					local var_227_4 = Mathf.Lerp(0, 0.5, var_227_3)

					arg_224_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_224_1.var_.characterEffect10025ui_story.fillRatio = var_227_4
				end
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect10025ui_story then
				local var_227_5 = 0.5

				arg_224_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_224_1.var_.characterEffect10025ui_story.fillRatio = var_227_5
			end

			local var_227_6 = 0
			local var_227_7 = 0.225

			if var_227_6 < arg_224_1.time_ and arg_224_1.time_ <= var_227_6 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_8 = arg_224_1:FormatText(StoryNameCfg[7].name)

				arg_224_1.leftNameTxt_.text = var_227_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, true)
				arg_224_1.iconController_:SetSelectedState("hero")

				arg_224_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_224_1.callingController_:SetSelectedState("normal")

				arg_224_1.keyicon_.color = Color.New(1, 1, 1)
				arg_224_1.icon_.color = Color.New(1, 1, 1)

				local var_227_9 = arg_224_1:GetWordFromCfg(116161050)
				local var_227_10 = arg_224_1:FormatText(var_227_9.content)

				arg_224_1.text_.text = var_227_10

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_11 = 9
				local var_227_12 = utf8.len(var_227_10)
				local var_227_13 = var_227_11 <= 0 and var_227_7 or var_227_7 * (var_227_12 / var_227_11)

				if var_227_13 > 0 and var_227_7 < var_227_13 then
					arg_224_1.talkMaxDuration = var_227_13

					if var_227_13 + var_227_6 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_13 + var_227_6
					end
				end

				arg_224_1.text_.text = var_227_10
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_14 = math.max(var_227_7, arg_224_1.talkMaxDuration)

			if var_227_6 <= arg_224_1.time_ and arg_224_1.time_ < var_227_6 + var_227_14 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_6) / var_227_14

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_6 + var_227_14 and arg_224_1.time_ < var_227_6 + var_227_14 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play116161051 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 116161051
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play116161052(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["10025ui_story"].transform
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 then
				arg_228_1.var_.moveOldPos10025ui_story = var_231_0.localPosition
			end

			local var_231_2 = 0.001

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2
				local var_231_4 = Vector3.New(0, 100, 0)

				var_231_0.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10025ui_story, var_231_4, var_231_3)

				local var_231_5 = manager.ui.mainCamera.transform.position - var_231_0.position

				var_231_0.forward = Vector3.New(var_231_5.x, var_231_5.y, var_231_5.z)

				local var_231_6 = var_231_0.localEulerAngles

				var_231_6.z = 0
				var_231_6.x = 0
				var_231_0.localEulerAngles = var_231_6
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 then
				var_231_0.localPosition = Vector3.New(0, 100, 0)

				local var_231_7 = manager.ui.mainCamera.transform.position - var_231_0.position

				var_231_0.forward = Vector3.New(var_231_7.x, var_231_7.y, var_231_7.z)

				local var_231_8 = var_231_0.localEulerAngles

				var_231_8.z = 0
				var_231_8.x = 0
				var_231_0.localEulerAngles = var_231_8
			end

			local var_231_9 = 0
			local var_231_10 = 1.125

			if var_231_9 < arg_228_1.time_ and arg_228_1.time_ <= var_231_9 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, false)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_11 = arg_228_1:GetWordFromCfg(116161051)
				local var_231_12 = arg_228_1:FormatText(var_231_11.content)

				arg_228_1.text_.text = var_231_12

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_13 = 45
				local var_231_14 = utf8.len(var_231_12)
				local var_231_15 = var_231_13 <= 0 and var_231_10 or var_231_10 * (var_231_14 / var_231_13)

				if var_231_15 > 0 and var_231_10 < var_231_15 then
					arg_228_1.talkMaxDuration = var_231_15

					if var_231_15 + var_231_9 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_15 + var_231_9
					end
				end

				arg_228_1.text_.text = var_231_12
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_16 = math.max(var_231_10, arg_228_1.talkMaxDuration)

			if var_231_9 <= arg_228_1.time_ and arg_228_1.time_ < var_231_9 + var_231_16 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_9) / var_231_16

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_9 + var_231_16 and arg_228_1.time_ < var_231_9 + var_231_16 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play116161052 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 116161052
		arg_232_1.duration_ = 5.77

		local var_232_0 = {
			zh = 5.766,
			ja = 4.833
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play116161053(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["10025ui_story"]
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect10025ui_story == nil then
				arg_232_1.var_.characterEffect10025ui_story = var_235_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_2 = 0.2

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 and not isNil(var_235_0) then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2

				if arg_232_1.var_.characterEffect10025ui_story and not isNil(var_235_0) then
					arg_232_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect10025ui_story then
				arg_232_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_235_4 = 0

			if var_235_4 < arg_232_1.time_ and arg_232_1.time_ <= var_235_4 + arg_235_0 then
				arg_232_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			local var_235_5 = 0

			if var_235_5 < arg_232_1.time_ and arg_232_1.time_ <= var_235_5 + arg_235_0 then
				arg_232_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_235_6 = arg_232_1.actors_["10025ui_story"].transform
			local var_235_7 = 0

			if var_235_7 < arg_232_1.time_ and arg_232_1.time_ <= var_235_7 + arg_235_0 then
				arg_232_1.var_.moveOldPos10025ui_story = var_235_6.localPosition
			end

			local var_235_8 = 0.001

			if var_235_7 <= arg_232_1.time_ and arg_232_1.time_ < var_235_7 + var_235_8 then
				local var_235_9 = (arg_232_1.time_ - var_235_7) / var_235_8
				local var_235_10 = Vector3.New(0, -1.1, -5.9)

				var_235_6.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10025ui_story, var_235_10, var_235_9)

				local var_235_11 = manager.ui.mainCamera.transform.position - var_235_6.position

				var_235_6.forward = Vector3.New(var_235_11.x, var_235_11.y, var_235_11.z)

				local var_235_12 = var_235_6.localEulerAngles

				var_235_12.z = 0
				var_235_12.x = 0
				var_235_6.localEulerAngles = var_235_12
			end

			if arg_232_1.time_ >= var_235_7 + var_235_8 and arg_232_1.time_ < var_235_7 + var_235_8 + arg_235_0 then
				var_235_6.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_235_13 = manager.ui.mainCamera.transform.position - var_235_6.position

				var_235_6.forward = Vector3.New(var_235_13.x, var_235_13.y, var_235_13.z)

				local var_235_14 = var_235_6.localEulerAngles

				var_235_14.z = 0
				var_235_14.x = 0
				var_235_6.localEulerAngles = var_235_14
			end

			local var_235_15 = 0
			local var_235_16 = 0.45

			if var_235_15 < arg_232_1.time_ and arg_232_1.time_ <= var_235_15 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_17 = arg_232_1:FormatText(StoryNameCfg[328].name)

				arg_232_1.leftNameTxt_.text = var_235_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_18 = arg_232_1:GetWordFromCfg(116161052)
				local var_235_19 = arg_232_1:FormatText(var_235_18.content)

				arg_232_1.text_.text = var_235_19

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_20 = 18
				local var_235_21 = utf8.len(var_235_19)
				local var_235_22 = var_235_20 <= 0 and var_235_16 or var_235_16 * (var_235_21 / var_235_20)

				if var_235_22 > 0 and var_235_16 < var_235_22 then
					arg_232_1.talkMaxDuration = var_235_22

					if var_235_22 + var_235_15 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_22 + var_235_15
					end
				end

				arg_232_1.text_.text = var_235_19
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161052", "story_v_out_116161.awb") ~= 0 then
					local var_235_23 = manager.audio:GetVoiceLength("story_v_out_116161", "116161052", "story_v_out_116161.awb") / 1000

					if var_235_23 + var_235_15 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_23 + var_235_15
					end

					if var_235_18.prefab_name ~= "" and arg_232_1.actors_[var_235_18.prefab_name] ~= nil then
						local var_235_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_18.prefab_name].transform, "story_v_out_116161", "116161052", "story_v_out_116161.awb")

						arg_232_1:RecordAudio("116161052", var_235_24)
						arg_232_1:RecordAudio("116161052", var_235_24)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_116161", "116161052", "story_v_out_116161.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_116161", "116161052", "story_v_out_116161.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_25 = math.max(var_235_16, arg_232_1.talkMaxDuration)

			if var_235_15 <= arg_232_1.time_ and arg_232_1.time_ < var_235_15 + var_235_25 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_15) / var_235_25

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_15 + var_235_25 and arg_232_1.time_ < var_235_15 + var_235_25 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play116161053 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 116161053
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play116161054(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["10025ui_story"]
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect10025ui_story == nil then
				arg_236_1.var_.characterEffect10025ui_story = var_239_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.2

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 and not isNil(var_239_0) then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2

				if arg_236_1.var_.characterEffect10025ui_story and not isNil(var_239_0) then
					local var_239_4 = Mathf.Lerp(0, 0.5, var_239_3)

					arg_236_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_236_1.var_.characterEffect10025ui_story.fillRatio = var_239_4
				end
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect10025ui_story then
				local var_239_5 = 0.5

				arg_236_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_236_1.var_.characterEffect10025ui_story.fillRatio = var_239_5
			end

			local var_239_6 = 0
			local var_239_7 = 0.55

			if var_239_6 < arg_236_1.time_ and arg_236_1.time_ <= var_239_6 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_8 = arg_236_1:GetWordFromCfg(116161053)
				local var_239_9 = arg_236_1:FormatText(var_239_8.content)

				arg_236_1.text_.text = var_239_9

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_10 = 22
				local var_239_11 = utf8.len(var_239_9)
				local var_239_12 = var_239_10 <= 0 and var_239_7 or var_239_7 * (var_239_11 / var_239_10)

				if var_239_12 > 0 and var_239_7 < var_239_12 then
					arg_236_1.talkMaxDuration = var_239_12

					if var_239_12 + var_239_6 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_12 + var_239_6
					end
				end

				arg_236_1.text_.text = var_239_9
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_13 = math.max(var_239_7, arg_236_1.talkMaxDuration)

			if var_239_6 <= arg_236_1.time_ and arg_236_1.time_ < var_239_6 + var_239_13 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_6) / var_239_13

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_6 + var_239_13 and arg_236_1.time_ < var_239_6 + var_239_13 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play116161054 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 116161054
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play116161055(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0
			local var_243_1 = 0.75

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_2 = arg_240_1:FormatText(StoryNameCfg[7].name)

				arg_240_1.leftNameTxt_.text = var_243_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_3 = arg_240_1:GetWordFromCfg(116161054)
				local var_243_4 = arg_240_1:FormatText(var_243_3.content)

				arg_240_1.text_.text = var_243_4

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_5 = 30
				local var_243_6 = utf8.len(var_243_4)
				local var_243_7 = var_243_5 <= 0 and var_243_1 or var_243_1 * (var_243_6 / var_243_5)

				if var_243_7 > 0 and var_243_1 < var_243_7 then
					arg_240_1.talkMaxDuration = var_243_7

					if var_243_7 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_7 + var_243_0
					end
				end

				arg_240_1.text_.text = var_243_4
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_8 = math.max(var_243_1, arg_240_1.talkMaxDuration)

			if var_243_0 <= arg_240_1.time_ and arg_240_1.time_ < var_243_0 + var_243_8 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_0) / var_243_8

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_0 + var_243_8 and arg_240_1.time_ < var_243_0 + var_243_8 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play116161055 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 116161055
		arg_244_1.duration_ = 3.9

		local var_244_0 = {
			zh = 2.5,
			ja = 3.9
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play116161056(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["10025ui_story"]
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect10025ui_story == nil then
				arg_244_1.var_.characterEffect10025ui_story = var_247_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.2

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 and not isNil(var_247_0) then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2

				if arg_244_1.var_.characterEffect10025ui_story and not isNil(var_247_0) then
					arg_244_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect10025ui_story then
				arg_244_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_247_4 = 0

			if var_247_4 < arg_244_1.time_ and arg_244_1.time_ <= var_247_4 + arg_247_0 then
				arg_244_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_2")
			end

			local var_247_5 = 0

			if var_247_5 < arg_244_1.time_ and arg_244_1.time_ <= var_247_5 + arg_247_0 then
				arg_244_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_247_6 = 0
			local var_247_7 = 0.225

			if var_247_6 < arg_244_1.time_ and arg_244_1.time_ <= var_247_6 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_8 = arg_244_1:FormatText(StoryNameCfg[328].name)

				arg_244_1.leftNameTxt_.text = var_247_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_9 = arg_244_1:GetWordFromCfg(116161055)
				local var_247_10 = arg_244_1:FormatText(var_247_9.content)

				arg_244_1.text_.text = var_247_10

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_11 = 9
				local var_247_12 = utf8.len(var_247_10)
				local var_247_13 = var_247_11 <= 0 and var_247_7 or var_247_7 * (var_247_12 / var_247_11)

				if var_247_13 > 0 and var_247_7 < var_247_13 then
					arg_244_1.talkMaxDuration = var_247_13

					if var_247_13 + var_247_6 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_13 + var_247_6
					end
				end

				arg_244_1.text_.text = var_247_10
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161055", "story_v_out_116161.awb") ~= 0 then
					local var_247_14 = manager.audio:GetVoiceLength("story_v_out_116161", "116161055", "story_v_out_116161.awb") / 1000

					if var_247_14 + var_247_6 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_14 + var_247_6
					end

					if var_247_9.prefab_name ~= "" and arg_244_1.actors_[var_247_9.prefab_name] ~= nil then
						local var_247_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_9.prefab_name].transform, "story_v_out_116161", "116161055", "story_v_out_116161.awb")

						arg_244_1:RecordAudio("116161055", var_247_15)
						arg_244_1:RecordAudio("116161055", var_247_15)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_116161", "116161055", "story_v_out_116161.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_116161", "116161055", "story_v_out_116161.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_16 = math.max(var_247_7, arg_244_1.talkMaxDuration)

			if var_247_6 <= arg_244_1.time_ and arg_244_1.time_ < var_247_6 + var_247_16 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_6) / var_247_16

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_6 + var_247_16 and arg_244_1.time_ < var_247_6 + var_247_16 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play116161056 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 116161056
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play116161057(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["10025ui_story"]
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect10025ui_story == nil then
				arg_248_1.var_.characterEffect10025ui_story = var_251_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_2 = 0.2

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 and not isNil(var_251_0) then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2

				if arg_248_1.var_.characterEffect10025ui_story and not isNil(var_251_0) then
					local var_251_4 = Mathf.Lerp(0, 0.5, var_251_3)

					arg_248_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_248_1.var_.characterEffect10025ui_story.fillRatio = var_251_4
				end
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect10025ui_story then
				local var_251_5 = 0.5

				arg_248_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_248_1.var_.characterEffect10025ui_story.fillRatio = var_251_5
			end

			local var_251_6 = 0
			local var_251_7 = 0.6

			if var_251_6 < arg_248_1.time_ and arg_248_1.time_ <= var_251_6 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_8 = arg_248_1:FormatText(StoryNameCfg[7].name)

				arg_248_1.leftNameTxt_.text = var_251_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_9 = arg_248_1:GetWordFromCfg(116161056)
				local var_251_10 = arg_248_1:FormatText(var_251_9.content)

				arg_248_1.text_.text = var_251_10

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_11 = 24
				local var_251_12 = utf8.len(var_251_10)
				local var_251_13 = var_251_11 <= 0 and var_251_7 or var_251_7 * (var_251_12 / var_251_11)

				if var_251_13 > 0 and var_251_7 < var_251_13 then
					arg_248_1.talkMaxDuration = var_251_13

					if var_251_13 + var_251_6 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_13 + var_251_6
					end
				end

				arg_248_1.text_.text = var_251_10
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_14 = math.max(var_251_7, arg_248_1.talkMaxDuration)

			if var_251_6 <= arg_248_1.time_ and arg_248_1.time_ < var_251_6 + var_251_14 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_6) / var_251_14

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_6 + var_251_14 and arg_248_1.time_ < var_251_6 + var_251_14 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play116161057 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 116161057
		arg_252_1.duration_ = 7.03

		local var_252_0 = {
			zh = 5.7,
			ja = 7.033
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play116161058(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["10025ui_story"]
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect10025ui_story == nil then
				arg_252_1.var_.characterEffect10025ui_story = var_255_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_2 = 0.2

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 and not isNil(var_255_0) then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2

				if arg_252_1.var_.characterEffect10025ui_story and not isNil(var_255_0) then
					arg_252_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect10025ui_story then
				arg_252_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_255_4 = 0

			if var_255_4 < arg_252_1.time_ and arg_252_1.time_ <= var_255_4 + arg_255_0 then
				arg_252_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_255_5 = 0

			if var_255_5 < arg_252_1.time_ and arg_252_1.time_ <= var_255_5 + arg_255_0 then
				arg_252_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_255_6 = 0
			local var_255_7 = 0.425

			if var_255_6 < arg_252_1.time_ and arg_252_1.time_ <= var_255_6 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_8 = arg_252_1:FormatText(StoryNameCfg[328].name)

				arg_252_1.leftNameTxt_.text = var_255_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_9 = arg_252_1:GetWordFromCfg(116161057)
				local var_255_10 = arg_252_1:FormatText(var_255_9.content)

				arg_252_1.text_.text = var_255_10

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_11 = 17
				local var_255_12 = utf8.len(var_255_10)
				local var_255_13 = var_255_11 <= 0 and var_255_7 or var_255_7 * (var_255_12 / var_255_11)

				if var_255_13 > 0 and var_255_7 < var_255_13 then
					arg_252_1.talkMaxDuration = var_255_13

					if var_255_13 + var_255_6 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_13 + var_255_6
					end
				end

				arg_252_1.text_.text = var_255_10
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161057", "story_v_out_116161.awb") ~= 0 then
					local var_255_14 = manager.audio:GetVoiceLength("story_v_out_116161", "116161057", "story_v_out_116161.awb") / 1000

					if var_255_14 + var_255_6 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_14 + var_255_6
					end

					if var_255_9.prefab_name ~= "" and arg_252_1.actors_[var_255_9.prefab_name] ~= nil then
						local var_255_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_9.prefab_name].transform, "story_v_out_116161", "116161057", "story_v_out_116161.awb")

						arg_252_1:RecordAudio("116161057", var_255_15)
						arg_252_1:RecordAudio("116161057", var_255_15)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_116161", "116161057", "story_v_out_116161.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_116161", "116161057", "story_v_out_116161.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_16 = math.max(var_255_7, arg_252_1.talkMaxDuration)

			if var_255_6 <= arg_252_1.time_ and arg_252_1.time_ < var_255_6 + var_255_16 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_6) / var_255_16

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_6 + var_255_16 and arg_252_1.time_ < var_255_6 + var_255_16 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play116161058 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 116161058
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play116161059(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["10025ui_story"]
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect10025ui_story == nil then
				arg_256_1.var_.characterEffect10025ui_story = var_259_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_2 = 0.2

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 and not isNil(var_259_0) then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / var_259_2

				if arg_256_1.var_.characterEffect10025ui_story and not isNil(var_259_0) then
					local var_259_4 = Mathf.Lerp(0, 0.5, var_259_3)

					arg_256_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_256_1.var_.characterEffect10025ui_story.fillRatio = var_259_4
				end
			end

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect10025ui_story then
				local var_259_5 = 0.5

				arg_256_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_256_1.var_.characterEffect10025ui_story.fillRatio = var_259_5
			end

			local var_259_6 = 0
			local var_259_7 = 1.025

			if var_259_6 < arg_256_1.time_ and arg_256_1.time_ <= var_259_6 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_8 = arg_256_1:FormatText(StoryNameCfg[7].name)

				arg_256_1.leftNameTxt_.text = var_259_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_9 = arg_256_1:GetWordFromCfg(116161058)
				local var_259_10 = arg_256_1:FormatText(var_259_9.content)

				arg_256_1.text_.text = var_259_10

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_11 = 41
				local var_259_12 = utf8.len(var_259_10)
				local var_259_13 = var_259_11 <= 0 and var_259_7 or var_259_7 * (var_259_12 / var_259_11)

				if var_259_13 > 0 and var_259_7 < var_259_13 then
					arg_256_1.talkMaxDuration = var_259_13

					if var_259_13 + var_259_6 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_13 + var_259_6
					end
				end

				arg_256_1.text_.text = var_259_10
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_14 = math.max(var_259_7, arg_256_1.talkMaxDuration)

			if var_259_6 <= arg_256_1.time_ and arg_256_1.time_ < var_259_6 + var_259_14 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_6) / var_259_14

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_6 + var_259_14 and arg_256_1.time_ < var_259_6 + var_259_14 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play116161059 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 116161059
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play116161060(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0
			local var_263_1 = 0.6

			if var_263_0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_2 = arg_260_1:GetWordFromCfg(116161059)
				local var_263_3 = arg_260_1:FormatText(var_263_2.content)

				arg_260_1.text_.text = var_263_3

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_4 = 24
				local var_263_5 = utf8.len(var_263_3)
				local var_263_6 = var_263_4 <= 0 and var_263_1 or var_263_1 * (var_263_5 / var_263_4)

				if var_263_6 > 0 and var_263_1 < var_263_6 then
					arg_260_1.talkMaxDuration = var_263_6

					if var_263_6 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_6 + var_263_0
					end
				end

				arg_260_1.text_.text = var_263_3
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_7 = math.max(var_263_1, arg_260_1.talkMaxDuration)

			if var_263_0 <= arg_260_1.time_ and arg_260_1.time_ < var_263_0 + var_263_7 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_0) / var_263_7

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_0 + var_263_7 and arg_260_1.time_ < var_263_0 + var_263_7 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play116161060 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 116161060
		arg_264_1.duration_ = 2.93

		local var_264_0 = {
			zh = 2.933,
			ja = 2.9
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
			arg_264_1.auto_ = false
		end

		function arg_264_1.playNext_(arg_266_0)
			arg_264_1.onStoryFinished_()
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["10025ui_story"]
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect10025ui_story == nil then
				arg_264_1.var_.characterEffect10025ui_story = var_267_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_2 = 0.2

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_2 and not isNil(var_267_0) then
				local var_267_3 = (arg_264_1.time_ - var_267_1) / var_267_2

				if arg_264_1.var_.characterEffect10025ui_story and not isNil(var_267_0) then
					arg_264_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= var_267_1 + var_267_2 and arg_264_1.time_ < var_267_1 + var_267_2 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect10025ui_story then
				arg_264_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_267_4 = 0

			if var_267_4 < arg_264_1.time_ and arg_264_1.time_ <= var_267_4 + arg_267_0 then
				arg_264_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_2")
			end

			local var_267_5 = 0

			if var_267_5 < arg_264_1.time_ and arg_264_1.time_ <= var_267_5 + arg_267_0 then
				arg_264_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_267_6 = 0
			local var_267_7 = 0.15

			if var_267_6 < arg_264_1.time_ and arg_264_1.time_ <= var_267_6 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_8 = arg_264_1:FormatText(StoryNameCfg[328].name)

				arg_264_1.leftNameTxt_.text = var_267_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_9 = arg_264_1:GetWordFromCfg(116161060)
				local var_267_10 = arg_264_1:FormatText(var_267_9.content)

				arg_264_1.text_.text = var_267_10

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_11 = 6
				local var_267_12 = utf8.len(var_267_10)
				local var_267_13 = var_267_11 <= 0 and var_267_7 or var_267_7 * (var_267_12 / var_267_11)

				if var_267_13 > 0 and var_267_7 < var_267_13 then
					arg_264_1.talkMaxDuration = var_267_13

					if var_267_13 + var_267_6 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_13 + var_267_6
					end
				end

				arg_264_1.text_.text = var_267_10
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161060", "story_v_out_116161.awb") ~= 0 then
					local var_267_14 = manager.audio:GetVoiceLength("story_v_out_116161", "116161060", "story_v_out_116161.awb") / 1000

					if var_267_14 + var_267_6 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_14 + var_267_6
					end

					if var_267_9.prefab_name ~= "" and arg_264_1.actors_[var_267_9.prefab_name] ~= nil then
						local var_267_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_9.prefab_name].transform, "story_v_out_116161", "116161060", "story_v_out_116161.awb")

						arg_264_1:RecordAudio("116161060", var_267_15)
						arg_264_1:RecordAudio("116161060", var_267_15)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_116161", "116161060", "story_v_out_116161.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_116161", "116161060", "story_v_out_116161.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_16 = math.max(var_267_7, arg_264_1.talkMaxDuration)

			if var_267_6 <= arg_264_1.time_ and arg_264_1.time_ < var_267_6 + var_267_16 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_6) / var_267_16

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_6 + var_267_16 and arg_264_1.time_ < var_267_6 + var_267_16 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/SK0103",
		"TextureConfig/Background/SK0112",
		"TextureConfig/Background/SK0107",
		"TextureConfig/Background/SK0106",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/I03",
		"TextureConfig/Background/I06"
	},
	voices = {
		"story_v_out_116161.awb"
	}
}
