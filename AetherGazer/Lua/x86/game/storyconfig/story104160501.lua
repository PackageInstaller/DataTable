return {
	Play416051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416051001
		arg_1_1.duration_ = 6.4

		local var_1_0 = {
			zh = 5.133,
			ja = 6.4
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
				arg_1_0:Play416051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 2

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 0.166666666666667

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = "SS1602"

			if arg_1_1.bgs_[var_4_2] == nil then
				local var_4_3 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_2)
				var_4_3.name = var_4_2
				var_4_3.transform.parent = arg_1_1.stage_.transform
				var_4_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_2] = var_4_3
			end

			local var_4_4 = 0

			if var_4_4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				local var_4_5 = manager.ui.mainCamera.transform.localPosition
				local var_4_6 = Vector3.New(0, 0, 10) + Vector3.New(var_4_5.x, var_4_5.y, 0)
				local var_4_7 = arg_1_1.bgs_.SS1602

				var_4_7.transform.localPosition = var_4_6
				var_4_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_8 = var_4_7:GetComponent("SpriteRenderer")

				if var_4_8 and var_4_8.sprite then
					local var_4_9 = (var_4_7.transform.localPosition - var_4_5).z
					local var_4_10 = manager.ui.mainCameraCom_
					local var_4_11 = 2 * var_4_9 * Mathf.Tan(var_4_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_12 = var_4_11 * var_4_10.aspect
					local var_4_13 = var_4_8.sprite.bounds.size.x
					local var_4_14 = var_4_8.sprite.bounds.size.y
					local var_4_15 = var_4_12 / var_4_13
					local var_4_16 = var_4_11 / var_4_14
					local var_4_17 = var_4_16 < var_4_15 and var_4_15 or var_4_16

					var_4_7.transform.localScale = Vector3.New(var_4_17, var_4_17, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "SS1602" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
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

			local var_4_24 = manager.ui.mainCamera.transform
			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_26 = arg_1_1.var_.effect77
				local var_4_27
				local var_4_28 = var_4_24

				if not var_4_26 then
					var_4_26 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_4_28)
					var_4_26.name = "77"
					arg_1_1.var_.effect77 = var_4_26
				else
					var_4_26.transform:SetParent(var_4_28)
				end

				var_4_26.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_26.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_29 = manager.ui.mainCamera.transform
			local var_4_30 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_31 = arg_1_1.var_.effect77

				if var_4_31 then
					Object.Destroy(var_4_31)

					arg_1_1.var_.effect77 = nil
				end
			end

			local var_4_32 = 0
			local var_4_33 = 1

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "effect"

				arg_1_1:AudioAction(var_4_34, var_4_35, "se_story_16", "se_story_16_channel", "")
			end

			local var_4_36 = 0
			local var_4_37 = 0.2

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "music"

				arg_1_1:AudioAction(var_4_38, var_4_39, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_40 = ""
				local var_4_41 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_41 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_41 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_41

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_41
						arg_1_1.bgmTxt2_.text = var_4_41
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

			local var_4_42 = 2
			local var_4_43 = 0.35

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_44 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_44:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_45 = arg_1_1:FormatText(StoryNameCfg[36].name)

				arg_1_1.leftNameTxt_.text = var_4_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_46 = arg_1_1:GetWordFromCfg(416051001)
				local var_4_47 = arg_1_1:FormatText(var_4_46.content)

				arg_1_1.text_.text = var_4_47

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_48 = 14
				local var_4_49 = utf8.len(var_4_47)
				local var_4_50 = var_4_48 <= 0 and var_4_43 or var_4_43 * (var_4_49 / var_4_48)

				if var_4_50 > 0 and var_4_43 < var_4_50 then
					arg_1_1.talkMaxDuration = var_4_50
					var_4_42 = var_4_42 + 0.3

					if var_4_50 + var_4_42 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_50 + var_4_42
					end
				end

				arg_1_1.text_.text = var_4_47
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051001", "story_v_out_416051.awb") ~= 0 then
					local var_4_51 = manager.audio:GetVoiceLength("story_v_out_416051", "416051001", "story_v_out_416051.awb") / 1000

					if var_4_51 + var_4_42 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_51 + var_4_42
					end

					if var_4_46.prefab_name ~= "" and arg_1_1.actors_[var_4_46.prefab_name] ~= nil then
						local var_4_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_46.prefab_name].transform, "story_v_out_416051", "416051001", "story_v_out_416051.awb")

						arg_1_1:RecordAudio("416051001", var_4_52)
						arg_1_1:RecordAudio("416051001", var_4_52)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416051", "416051001", "story_v_out_416051.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416051", "416051001", "story_v_out_416051.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_53 = var_4_42 + 0.3
			local var_4_54 = math.max(var_4_43, arg_1_1.talkMaxDuration)

			if var_4_53 <= arg_1_1.time_ and arg_1_1.time_ < var_4_53 + var_4_54 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_53) / var_4_54

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_53 + var_4_54 and arg_1_1.time_ < var_4_53 + var_4_54 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play416051002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 416051002
		arg_8_1.duration_ = 6

		local var_8_0 = {
			zh = 2.866,
			ja = 6
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
				arg_8_0:Play416051003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				local var_11_2 = "play"
				local var_11_3 = "effect"

				arg_8_1:AudioAction(var_11_2, var_11_3, "se_story_16", "se_story_16_channel", "")
			end

			local var_11_4 = 0
			local var_11_5 = 0.4

			if var_11_4 < arg_8_1.time_ and arg_8_1.time_ <= var_11_4 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_6 = arg_8_1:FormatText(StoryNameCfg[36].name)

				arg_8_1.leftNameTxt_.text = var_11_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_7 = arg_8_1:GetWordFromCfg(416051002)
				local var_11_8 = arg_8_1:FormatText(var_11_7.content)

				arg_8_1.text_.text = var_11_8

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_9 = 16
				local var_11_10 = utf8.len(var_11_8)
				local var_11_11 = var_11_9 <= 0 and var_11_5 or var_11_5 * (var_11_10 / var_11_9)

				if var_11_11 > 0 and var_11_5 < var_11_11 then
					arg_8_1.talkMaxDuration = var_11_11

					if var_11_11 + var_11_4 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_11 + var_11_4
					end
				end

				arg_8_1.text_.text = var_11_8
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051002", "story_v_out_416051.awb") ~= 0 then
					local var_11_12 = manager.audio:GetVoiceLength("story_v_out_416051", "416051002", "story_v_out_416051.awb") / 1000

					if var_11_12 + var_11_4 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_12 + var_11_4
					end

					if var_11_7.prefab_name ~= "" and arg_8_1.actors_[var_11_7.prefab_name] ~= nil then
						local var_11_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_7.prefab_name].transform, "story_v_out_416051", "416051002", "story_v_out_416051.awb")

						arg_8_1:RecordAudio("416051002", var_11_13)
						arg_8_1:RecordAudio("416051002", var_11_13)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_416051", "416051002", "story_v_out_416051.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_416051", "416051002", "story_v_out_416051.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_14 = math.max(var_11_5, arg_8_1.talkMaxDuration)

			if var_11_4 <= arg_8_1.time_ and arg_8_1.time_ < var_11_4 + var_11_14 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_4) / var_11_14

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_4 + var_11_14 and arg_8_1.time_ < var_11_4 + var_11_14 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play416051003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 416051003
		arg_12_1.duration_ = 9

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play416051004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 4

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			local var_15_1 = 0.666666666666667

			if arg_12_1.time_ >= var_15_0 + var_15_1 and arg_12_1.time_ < var_15_0 + var_15_1 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			local var_15_2 = "I14f"

			if arg_12_1.bgs_[var_15_2] == nil then
				local var_15_3 = Object.Instantiate(arg_12_1.paintGo_)

				var_15_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_15_2)
				var_15_3.name = var_15_2
				var_15_3.transform.parent = arg_12_1.stage_.transform
				var_15_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.bgs_[var_15_2] = var_15_3
			end

			local var_15_4 = 2

			if var_15_4 < arg_12_1.time_ and arg_12_1.time_ <= var_15_4 + arg_15_0 then
				local var_15_5 = manager.ui.mainCamera.transform.localPosition
				local var_15_6 = Vector3.New(0, 0, 10) + Vector3.New(var_15_5.x, var_15_5.y, 0)
				local var_15_7 = arg_12_1.bgs_.I14f

				var_15_7.transform.localPosition = var_15_6
				var_15_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_15_8 = var_15_7:GetComponent("SpriteRenderer")

				if var_15_8 and var_15_8.sprite then
					local var_15_9 = (var_15_7.transform.localPosition - var_15_5).z
					local var_15_10 = manager.ui.mainCameraCom_
					local var_15_11 = 2 * var_15_9 * Mathf.Tan(var_15_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_15_12 = var_15_11 * var_15_10.aspect
					local var_15_13 = var_15_8.sprite.bounds.size.x
					local var_15_14 = var_15_8.sprite.bounds.size.y
					local var_15_15 = var_15_12 / var_15_13
					local var_15_16 = var_15_11 / var_15_14
					local var_15_17 = var_15_16 < var_15_15 and var_15_15 or var_15_16

					var_15_7.transform.localScale = Vector3.New(var_15_17, var_15_17, 0)
				end

				for iter_15_0, iter_15_1 in pairs(arg_12_1.bgs_) do
					if iter_15_0 ~= "I14f" then
						iter_15_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_15_18 = 0

			if var_15_18 < arg_12_1.time_ and arg_12_1.time_ <= var_15_18 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_19 = 2

			if var_15_18 <= arg_12_1.time_ and arg_12_1.time_ < var_15_18 + var_15_19 then
				local var_15_20 = (arg_12_1.time_ - var_15_18) / var_15_19
				local var_15_21 = Color.New(0, 0, 0)

				var_15_21.a = Mathf.Lerp(0, 1, var_15_20)
				arg_12_1.mask_.color = var_15_21
			end

			if arg_12_1.time_ >= var_15_18 + var_15_19 and arg_12_1.time_ < var_15_18 + var_15_19 + arg_15_0 then
				local var_15_22 = Color.New(0, 0, 0)

				var_15_22.a = 1
				arg_12_1.mask_.color = var_15_22
			end

			local var_15_23 = 2

			if var_15_23 < arg_12_1.time_ and arg_12_1.time_ <= var_15_23 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_24 = 2

			if var_15_23 <= arg_12_1.time_ and arg_12_1.time_ < var_15_23 + var_15_24 then
				local var_15_25 = (arg_12_1.time_ - var_15_23) / var_15_24
				local var_15_26 = Color.New(0, 0, 0)

				var_15_26.a = Mathf.Lerp(1, 0, var_15_25)
				arg_12_1.mask_.color = var_15_26
			end

			if arg_12_1.time_ >= var_15_23 + var_15_24 and arg_12_1.time_ < var_15_23 + var_15_24 + arg_15_0 then
				local var_15_27 = Color.New(0, 0, 0)
				local var_15_28 = 0

				arg_12_1.mask_.enabled = false
				var_15_27.a = var_15_28
				arg_12_1.mask_.color = var_15_27
			end

			local var_15_29 = manager.ui.mainCamera.transform
			local var_15_30 = 2

			if var_15_30 < arg_12_1.time_ and arg_12_1.time_ <= var_15_30 + arg_15_0 then
				local var_15_31 = arg_12_1.var_.effect51003
				local var_15_32
				local var_15_33 = var_15_29

				if not var_15_31 then
					var_15_31 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), var_15_33)
					var_15_31.name = "51003"
					arg_12_1.var_.effect51003 = var_15_31
				else
					var_15_31.transform:SetParent(var_15_33)
				end

				var_15_31.transform.localPosition = Vector3.New(0, 0, 0)
				var_15_31.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_15_34 = 0
			local var_15_35 = 0.2

			if var_15_34 < arg_12_1.time_ and arg_12_1.time_ <= var_15_34 + arg_15_0 then
				local var_15_36 = "play"
				local var_15_37 = "music"

				arg_12_1:AudioAction(var_15_36, var_15_37, "ui_battle", "ui_battle_stopbgm", "")

				local var_15_38 = ""
				local var_15_39 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_15_39 ~= "" then
					if arg_12_1.bgmTxt_.text ~= var_15_39 and arg_12_1.bgmTxt_.text ~= "" then
						if arg_12_1.bgmTxt2_.text ~= "" then
							arg_12_1.bgmTxt_.text = arg_12_1.bgmTxt2_.text
						end

						arg_12_1.bgmTxt2_.text = var_15_39

						arg_12_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_12_1.bgmTxt_.text = var_15_39
						arg_12_1.bgmTxt2_.text = var_15_39
					end

					if arg_12_1.bgmTimer then
						arg_12_1.bgmTimer:Stop()

						arg_12_1.bgmTimer = nil
					end

					if arg_12_1.settingData.show_music_name == 1 then
						arg_12_1.musicController:SetSelectedState("show")
						arg_12_1.musicAnimator_:Play("open", 0, 0)

						if arg_12_1.settingData.music_time ~= 0 then
							arg_12_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_12_1.settingData.music_time), function()
								if arg_12_1 == nil or isNil(arg_12_1.bgmTxt_) then
									return
								end

								arg_12_1.musicController:SetSelectedState("hide")
								arg_12_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_15_40 = 1.46666666666667
			local var_15_41 = 1

			if var_15_40 < arg_12_1.time_ and arg_12_1.time_ <= var_15_40 + arg_15_0 then
				local var_15_42 = "play"
				local var_15_43 = "music"

				arg_12_1:AudioAction(var_15_42, var_15_43, "bgm_activity_3_8_story_northwake_2", "bgm_activity_3_8_story_northwake_2", "bgm_activity_3_8_story_northwake_2.awb")

				local var_15_44 = ""
				local var_15_45 = manager.audio:GetAudioName("bgm_activity_3_8_story_northwake_2", "bgm_activity_3_8_story_northwake_2")

				if var_15_45 ~= "" then
					if arg_12_1.bgmTxt_.text ~= var_15_45 and arg_12_1.bgmTxt_.text ~= "" then
						if arg_12_1.bgmTxt2_.text ~= "" then
							arg_12_1.bgmTxt_.text = arg_12_1.bgmTxt2_.text
						end

						arg_12_1.bgmTxt2_.text = var_15_45

						arg_12_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_12_1.bgmTxt_.text = var_15_45
						arg_12_1.bgmTxt2_.text = var_15_45
					end

					if arg_12_1.bgmTimer then
						arg_12_1.bgmTimer:Stop()

						arg_12_1.bgmTimer = nil
					end

					if arg_12_1.settingData.show_music_name == 1 then
						arg_12_1.musicController:SetSelectedState("show")
						arg_12_1.musicAnimator_:Play("open", 0, 0)

						if arg_12_1.settingData.music_time ~= 0 then
							arg_12_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_12_1.settingData.music_time), function()
								if arg_12_1 == nil or isNil(arg_12_1.bgmTxt_) then
									return
								end

								arg_12_1.musicController:SetSelectedState("hide")
								arg_12_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_12_1.frameCnt_ <= 1 then
				arg_12_1.dialog_:SetActive(false)
			end

			local var_15_46 = 4
			local var_15_47 = 1.925

			if var_15_46 < arg_12_1.time_ and arg_12_1.time_ <= var_15_46 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_48 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_48:setOnUpdate(LuaHelper.FloatAction(function(arg_18_0)
					arg_12_1.dialogCg_.alpha = arg_18_0
				end))
				var_15_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_49 = arg_12_1:GetWordFromCfg(416051003)
				local var_15_50 = arg_12_1:FormatText(var_15_49.content)

				arg_12_1.text_.text = var_15_50

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_51 = 77
				local var_15_52 = utf8.len(var_15_50)
				local var_15_53 = var_15_51 <= 0 and var_15_47 or var_15_47 * (var_15_52 / var_15_51)

				if var_15_53 > 0 and var_15_47 < var_15_53 then
					arg_12_1.talkMaxDuration = var_15_53
					var_15_46 = var_15_46 + 0.3

					if var_15_53 + var_15_46 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_53 + var_15_46
					end
				end

				arg_12_1.text_.text = var_15_50
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_54 = var_15_46 + 0.3
			local var_15_55 = math.max(var_15_47, arg_12_1.talkMaxDuration)

			if var_15_54 <= arg_12_1.time_ and arg_12_1.time_ < var_15_54 + var_15_55 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_54) / var_15_55

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_54 + var_15_55 and arg_12_1.time_ < var_15_54 + var_15_55 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play416051004 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 416051004
		arg_20_1.duration_ = 6.37

		local var_20_0 = {
			zh = 4.633,
			ja = 6.366
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
				arg_20_0:Play416051005(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "1148"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1148")

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

			local var_23_4 = arg_20_1.actors_["1148"].transform
			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 then
				arg_20_1.var_.moveOldPos1148 = var_23_4.localPosition
				var_23_4.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("1148", 3)

				local var_23_6 = var_23_4.childCount

				for iter_23_2 = 0, var_23_6 - 1 do
					local var_23_7 = var_23_4:GetChild(iter_23_2)

					if var_23_7.name == "split_6" or not string.find(var_23_7.name, "split") then
						var_23_7.gameObject:SetActive(true)
					else
						var_23_7.gameObject:SetActive(false)
					end
				end
			end

			local var_23_8 = 0.001

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_8 then
				local var_23_9 = (arg_20_1.time_ - var_23_5) / var_23_8
				local var_23_10 = Vector3.New(0, -429, -180)

				var_23_4.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1148, var_23_10, var_23_9)
			end

			if arg_20_1.time_ >= var_23_5 + var_23_8 and arg_20_1.time_ < var_23_5 + var_23_8 + arg_23_0 then
				var_23_4.localPosition = Vector3.New(0, -429, -180)
			end

			local var_23_11 = arg_20_1.actors_["1148"]
			local var_23_12 = 0

			if var_23_12 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 and not isNil(var_23_11) and arg_20_1.var_.actorSpriteComps1148 == nil then
				arg_20_1.var_.actorSpriteComps1148 = var_23_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_13 = 0.125

			if var_23_12 <= arg_20_1.time_ and arg_20_1.time_ < var_23_12 + var_23_13 and not isNil(var_23_11) then
				local var_23_14 = (arg_20_1.time_ - var_23_12) / var_23_13

				if arg_20_1.var_.actorSpriteComps1148 then
					for iter_23_3, iter_23_4 in pairs(arg_20_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_23_4 then
							if arg_20_1.isInRecall_ then
								local var_23_15 = Mathf.Lerp(iter_23_4.color.r, arg_20_1.hightColor1.r, var_23_14)
								local var_23_16 = Mathf.Lerp(iter_23_4.color.g, arg_20_1.hightColor1.g, var_23_14)
								local var_23_17 = Mathf.Lerp(iter_23_4.color.b, arg_20_1.hightColor1.b, var_23_14)

								iter_23_4.color = Color.New(var_23_15, var_23_16, var_23_17)
							else
								local var_23_18 = Mathf.Lerp(iter_23_4.color.r, 1, var_23_14)

								iter_23_4.color = Color.New(var_23_18, var_23_18, var_23_18)
							end
						end
					end
				end
			end

			if arg_20_1.time_ >= var_23_12 + var_23_13 and arg_20_1.time_ < var_23_12 + var_23_13 + arg_23_0 and not isNil(var_23_11) and arg_20_1.var_.actorSpriteComps1148 then
				for iter_23_5, iter_23_6 in pairs(arg_20_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_23_6 then
						if arg_20_1.isInRecall_ then
							iter_23_6.color = arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_23_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_20_1.var_.actorSpriteComps1148 = nil
			end

			local var_23_19 = 0
			local var_23_20 = 0.475

			if var_23_19 < arg_20_1.time_ and arg_20_1.time_ <= var_23_19 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_21 = arg_20_1:FormatText(StoryNameCfg[8].name)

				arg_20_1.leftNameTxt_.text = var_23_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_22 = arg_20_1:GetWordFromCfg(416051004)
				local var_23_23 = arg_20_1:FormatText(var_23_22.content)

				arg_20_1.text_.text = var_23_23

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_24 = 19
				local var_23_25 = utf8.len(var_23_23)
				local var_23_26 = var_23_24 <= 0 and var_23_20 or var_23_20 * (var_23_25 / var_23_24)

				if var_23_26 > 0 and var_23_20 < var_23_26 then
					arg_20_1.talkMaxDuration = var_23_26

					if var_23_26 + var_23_19 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_26 + var_23_19
					end
				end

				arg_20_1.text_.text = var_23_23
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051004", "story_v_out_416051.awb") ~= 0 then
					local var_23_27 = manager.audio:GetVoiceLength("story_v_out_416051", "416051004", "story_v_out_416051.awb") / 1000

					if var_23_27 + var_23_19 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_27 + var_23_19
					end

					if var_23_22.prefab_name ~= "" and arg_20_1.actors_[var_23_22.prefab_name] ~= nil then
						local var_23_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_22.prefab_name].transform, "story_v_out_416051", "416051004", "story_v_out_416051.awb")

						arg_20_1:RecordAudio("416051004", var_23_28)
						arg_20_1:RecordAudio("416051004", var_23_28)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_416051", "416051004", "story_v_out_416051.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_416051", "416051004", "story_v_out_416051.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_29 = math.max(var_23_20, arg_20_1.talkMaxDuration)

			if var_23_19 <= arg_20_1.time_ and arg_20_1.time_ < var_23_19 + var_23_29 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_19) / var_23_29

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_19 + var_23_29 and arg_20_1.time_ < var_23_19 + var_23_29 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416051005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 416051005
		arg_24_1.duration_ = 5.8

		local var_24_0 = {
			zh = 4.1,
			ja = 5.8
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
				arg_24_0:Play416051006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.5

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[8].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_3 = arg_24_1:GetWordFromCfg(416051005)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 20
				local var_27_6 = utf8.len(var_27_4)
				local var_27_7 = var_27_5 <= 0 and var_27_1 or var_27_1 * (var_27_6 / var_27_5)

				if var_27_7 > 0 and var_27_1 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051005", "story_v_out_416051.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_416051", "416051005", "story_v_out_416051.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_416051", "416051005", "story_v_out_416051.awb")

						arg_24_1:RecordAudio("416051005", var_27_9)
						arg_24_1:RecordAudio("416051005", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_416051", "416051005", "story_v_out_416051.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_416051", "416051005", "story_v_out_416051.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_10 and arg_24_1.time_ < var_27_0 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play416051006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 416051006
		arg_28_1.duration_ = 4.9

		local var_28_0 = {
			zh = 4.9,
			ja = 3.933
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
				arg_28_0:Play416051007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1148"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.actorSpriteComps1148 == nil then
				arg_28_1.var_.actorSpriteComps1148 = var_31_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_2 = 0.125

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.actorSpriteComps1148 then
					for iter_31_0, iter_31_1 in pairs(arg_28_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_31_1 then
							if arg_28_1.isInRecall_ then
								local var_31_4 = Mathf.Lerp(iter_31_1.color.r, arg_28_1.hightColor2.r, var_31_3)
								local var_31_5 = Mathf.Lerp(iter_31_1.color.g, arg_28_1.hightColor2.g, var_31_3)
								local var_31_6 = Mathf.Lerp(iter_31_1.color.b, arg_28_1.hightColor2.b, var_31_3)

								iter_31_1.color = Color.New(var_31_4, var_31_5, var_31_6)
							else
								local var_31_7 = Mathf.Lerp(iter_31_1.color.r, 0.5, var_31_3)

								iter_31_1.color = Color.New(var_31_7, var_31_7, var_31_7)
							end
						end
					end
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.actorSpriteComps1148 then
				for iter_31_2, iter_31_3 in pairs(arg_28_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_31_3 then
						if arg_28_1.isInRecall_ then
							iter_31_3.color = arg_28_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_31_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_28_1.var_.actorSpriteComps1148 = nil
			end

			local var_31_8 = 0
			local var_31_9 = 0.4

			if var_31_8 < arg_28_1.time_ and arg_28_1.time_ <= var_31_8 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_10 = arg_28_1:FormatText(StoryNameCfg[1084].name)

				arg_28_1.leftNameTxt_.text = var_31_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_11 = arg_28_1:GetWordFromCfg(416051006)
				local var_31_12 = arg_28_1:FormatText(var_31_11.content)

				arg_28_1.text_.text = var_31_12

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_13 = 16
				local var_31_14 = utf8.len(var_31_12)
				local var_31_15 = var_31_13 <= 0 and var_31_9 or var_31_9 * (var_31_14 / var_31_13)

				if var_31_15 > 0 and var_31_9 < var_31_15 then
					arg_28_1.talkMaxDuration = var_31_15

					if var_31_15 + var_31_8 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_15 + var_31_8
					end
				end

				arg_28_1.text_.text = var_31_12
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051006", "story_v_out_416051.awb") ~= 0 then
					local var_31_16 = manager.audio:GetVoiceLength("story_v_out_416051", "416051006", "story_v_out_416051.awb") / 1000

					if var_31_16 + var_31_8 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_16 + var_31_8
					end

					if var_31_11.prefab_name ~= "" and arg_28_1.actors_[var_31_11.prefab_name] ~= nil then
						local var_31_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_11.prefab_name].transform, "story_v_out_416051", "416051006", "story_v_out_416051.awb")

						arg_28_1:RecordAudio("416051006", var_31_17)
						arg_28_1:RecordAudio("416051006", var_31_17)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_416051", "416051006", "story_v_out_416051.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_416051", "416051006", "story_v_out_416051.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_18 = math.max(var_31_9, arg_28_1.talkMaxDuration)

			if var_31_8 <= arg_28_1.time_ and arg_28_1.time_ < var_31_8 + var_31_18 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_8) / var_31_18

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_8 + var_31_18 and arg_28_1.time_ < var_31_8 + var_31_18 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play416051007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 416051007
		arg_32_1.duration_ = 10.17

		local var_32_0 = {
			zh = 5.1,
			ja = 10.166
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
				arg_32_0:Play416051008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1148"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps1148 == nil then
				arg_32_1.var_.actorSpriteComps1148 = var_35_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_2 = 0.125

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.actorSpriteComps1148 then
					for iter_35_0, iter_35_1 in pairs(arg_32_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps1148 then
				for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_35_3 then
						if arg_32_1.isInRecall_ then
							iter_35_3.color = arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_35_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_32_1.var_.actorSpriteComps1148 = nil
			end

			local var_35_8 = 0
			local var_35_9 = 0.55

			if var_35_8 < arg_32_1.time_ and arg_32_1.time_ <= var_35_8 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_10 = arg_32_1:FormatText(StoryNameCfg[8].name)

				arg_32_1.leftNameTxt_.text = var_35_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_11 = arg_32_1:GetWordFromCfg(416051007)
				local var_35_12 = arg_32_1:FormatText(var_35_11.content)

				arg_32_1.text_.text = var_35_12

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_13 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051007", "story_v_out_416051.awb") ~= 0 then
					local var_35_16 = manager.audio:GetVoiceLength("story_v_out_416051", "416051007", "story_v_out_416051.awb") / 1000

					if var_35_16 + var_35_8 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_16 + var_35_8
					end

					if var_35_11.prefab_name ~= "" and arg_32_1.actors_[var_35_11.prefab_name] ~= nil then
						local var_35_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_11.prefab_name].transform, "story_v_out_416051", "416051007", "story_v_out_416051.awb")

						arg_32_1:RecordAudio("416051007", var_35_17)
						arg_32_1:RecordAudio("416051007", var_35_17)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_416051", "416051007", "story_v_out_416051.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_416051", "416051007", "story_v_out_416051.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_18 = math.max(var_35_9, arg_32_1.talkMaxDuration)

			if var_35_8 <= arg_32_1.time_ and arg_32_1.time_ < var_35_8 + var_35_18 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_8) / var_35_18

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_8 + var_35_18 and arg_32_1.time_ < var_35_8 + var_35_18 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play416051008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 416051008
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play416051009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1148"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos1148 = var_39_0.localPosition
				var_39_0.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("1148", 7)

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

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1148, var_39_6, var_39_5)
			end

			if arg_36_1.time_ >= var_39_1 + var_39_4 and arg_36_1.time_ < var_39_1 + var_39_4 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_39_7 = 0
			local var_39_8 = 1.15

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

				local var_39_9 = arg_36_1:GetWordFromCfg(416051008)
				local var_39_10 = arg_36_1:FormatText(var_39_9.content)

				arg_36_1.text_.text = var_39_10

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 46
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
				actorName = "1148",
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
	Play416051009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 416051009
		arg_40_1.duration_ = 6.7

		local var_40_0 = {
			zh = 3.8,
			ja = 6.7
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
				arg_40_0:Play416051010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.4

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[1084].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:GetWordFromCfg(416051009)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051009", "story_v_out_416051.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_416051", "416051009", "story_v_out_416051.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_416051", "416051009", "story_v_out_416051.awb")

						arg_40_1:RecordAudio("416051009", var_43_9)
						arg_40_1:RecordAudio("416051009", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_416051", "416051009", "story_v_out_416051.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_416051", "416051009", "story_v_out_416051.awb")
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
	Play416051010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 416051010
		arg_44_1.duration_ = 8.7

		local var_44_0 = {
			zh = 4.6,
			ja = 8.7
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play416051011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1148"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos1148 = var_47_0.localPosition
				var_47_0.localScale = Vector3.New(1, 1, 1)

				arg_44_1:CheckSpriteTmpPos("1148", 3)

				local var_47_2 = var_47_0.childCount

				for iter_47_0 = 0, var_47_2 - 1 do
					local var_47_3 = var_47_0:GetChild(iter_47_0)

					if var_47_3.name == "split_6" or not string.find(var_47_3.name, "split") then
						var_47_3.gameObject:SetActive(true)
					else
						var_47_3.gameObject:SetActive(false)
					end
				end
			end

			local var_47_4 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_4 then
				local var_47_5 = (arg_44_1.time_ - var_47_1) / var_47_4
				local var_47_6 = Vector3.New(0, -429, -180)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1148, var_47_6, var_47_5)
			end

			if arg_44_1.time_ >= var_47_1 + var_47_4 and arg_44_1.time_ < var_47_1 + var_47_4 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_47_7 = arg_44_1.actors_["1148"]
			local var_47_8 = 0

			if var_47_8 < arg_44_1.time_ and arg_44_1.time_ <= var_47_8 + arg_47_0 and not isNil(var_47_7) and arg_44_1.var_.actorSpriteComps1148 == nil then
				arg_44_1.var_.actorSpriteComps1148 = var_47_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_9 = 0.125

			if var_47_8 <= arg_44_1.time_ and arg_44_1.time_ < var_47_8 + var_47_9 and not isNil(var_47_7) then
				local var_47_10 = (arg_44_1.time_ - var_47_8) / var_47_9

				if arg_44_1.var_.actorSpriteComps1148 then
					for iter_47_1, iter_47_2 in pairs(arg_44_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_47_2 then
							if arg_44_1.isInRecall_ then
								local var_47_11 = Mathf.Lerp(iter_47_2.color.r, arg_44_1.hightColor1.r, var_47_10)
								local var_47_12 = Mathf.Lerp(iter_47_2.color.g, arg_44_1.hightColor1.g, var_47_10)
								local var_47_13 = Mathf.Lerp(iter_47_2.color.b, arg_44_1.hightColor1.b, var_47_10)

								iter_47_2.color = Color.New(var_47_11, var_47_12, var_47_13)
							else
								local var_47_14 = Mathf.Lerp(iter_47_2.color.r, 1, var_47_10)

								iter_47_2.color = Color.New(var_47_14, var_47_14, var_47_14)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= var_47_8 + var_47_9 and arg_44_1.time_ < var_47_8 + var_47_9 + arg_47_0 and not isNil(var_47_7) and arg_44_1.var_.actorSpriteComps1148 then
				for iter_47_3, iter_47_4 in pairs(arg_44_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_47_4 then
						if arg_44_1.isInRecall_ then
							iter_47_4.color = arg_44_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_47_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_44_1.var_.actorSpriteComps1148 = nil
			end

			local var_47_15 = 0
			local var_47_16 = 0.5

			if var_47_15 < arg_44_1.time_ and arg_44_1.time_ <= var_47_15 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_17 = arg_44_1:FormatText(StoryNameCfg[8].name)

				arg_44_1.leftNameTxt_.text = var_47_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_18 = arg_44_1:GetWordFromCfg(416051010)
				local var_47_19 = arg_44_1:FormatText(var_47_18.content)

				arg_44_1.text_.text = var_47_19

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_20 = 20
				local var_47_21 = utf8.len(var_47_19)
				local var_47_22 = var_47_20 <= 0 and var_47_16 or var_47_16 * (var_47_21 / var_47_20)

				if var_47_22 > 0 and var_47_16 < var_47_22 then
					arg_44_1.talkMaxDuration = var_47_22

					if var_47_22 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_22 + var_47_15
					end
				end

				arg_44_1.text_.text = var_47_19
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051010", "story_v_out_416051.awb") ~= 0 then
					local var_47_23 = manager.audio:GetVoiceLength("story_v_out_416051", "416051010", "story_v_out_416051.awb") / 1000

					if var_47_23 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_23 + var_47_15
					end

					if var_47_18.prefab_name ~= "" and arg_44_1.actors_[var_47_18.prefab_name] ~= nil then
						local var_47_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_18.prefab_name].transform, "story_v_out_416051", "416051010", "story_v_out_416051.awb")

						arg_44_1:RecordAudio("416051010", var_47_24)
						arg_44_1:RecordAudio("416051010", var_47_24)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_416051", "416051010", "story_v_out_416051.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_416051", "416051010", "story_v_out_416051.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_25 = math.max(var_47_16, arg_44_1.talkMaxDuration)

			if var_47_15 <= arg_44_1.time_ and arg_44_1.time_ < var_47_15 + var_47_25 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_15) / var_47_25

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_15 + var_47_25 and arg_44_1.time_ < var_47_15 + var_47_25 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play416051011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 416051011
		arg_48_1.duration_ = 6

		local var_48_0 = {
			zh = 6,
			ja = 5.733
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
				arg_48_0:Play416051012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1148"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps1148 == nil then
				arg_48_1.var_.actorSpriteComps1148 = var_51_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_2 = 0.125

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.actorSpriteComps1148 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps1148 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_51_3 then
						if arg_48_1.isInRecall_ then
							iter_51_3.color = arg_48_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_51_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_48_1.var_.actorSpriteComps1148 = nil
			end

			local var_51_8 = 0
			local var_51_9 = 0.65

			if var_51_8 < arg_48_1.time_ and arg_48_1.time_ <= var_51_8 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_10 = arg_48_1:FormatText(StoryNameCfg[1084].name)

				arg_48_1.leftNameTxt_.text = var_51_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_11 = arg_48_1:GetWordFromCfg(416051011)
				local var_51_12 = arg_48_1:FormatText(var_51_11.content)

				arg_48_1.text_.text = var_51_12

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_13 = 26
				local var_51_14 = utf8.len(var_51_12)
				local var_51_15 = var_51_13 <= 0 and var_51_9 or var_51_9 * (var_51_14 / var_51_13)

				if var_51_15 > 0 and var_51_9 < var_51_15 then
					arg_48_1.talkMaxDuration = var_51_15

					if var_51_15 + var_51_8 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_15 + var_51_8
					end
				end

				arg_48_1.text_.text = var_51_12
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051011", "story_v_out_416051.awb") ~= 0 then
					local var_51_16 = manager.audio:GetVoiceLength("story_v_out_416051", "416051011", "story_v_out_416051.awb") / 1000

					if var_51_16 + var_51_8 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_16 + var_51_8
					end

					if var_51_11.prefab_name ~= "" and arg_48_1.actors_[var_51_11.prefab_name] ~= nil then
						local var_51_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_11.prefab_name].transform, "story_v_out_416051", "416051011", "story_v_out_416051.awb")

						arg_48_1:RecordAudio("416051011", var_51_17)
						arg_48_1:RecordAudio("416051011", var_51_17)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_416051", "416051011", "story_v_out_416051.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_416051", "416051011", "story_v_out_416051.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_18 = math.max(var_51_9, arg_48_1.talkMaxDuration)

			if var_51_8 <= arg_48_1.time_ and arg_48_1.time_ < var_51_8 + var_51_18 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_8) / var_51_18

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_8 + var_51_18 and arg_48_1.time_ < var_51_8 + var_51_18 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play416051012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 416051012
		arg_52_1.duration_ = 3.93

		local var_52_0 = {
			zh = 3.933,
			ja = 3.9
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
				arg_52_0:Play416051013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.45

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[1084].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:GetWordFromCfg(416051012)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051012", "story_v_out_416051.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_416051", "416051012", "story_v_out_416051.awb") / 1000

					if var_55_8 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_0
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_416051", "416051012", "story_v_out_416051.awb")

						arg_52_1:RecordAudio("416051012", var_55_9)
						arg_52_1:RecordAudio("416051012", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_416051", "416051012", "story_v_out_416051.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_416051", "416051012", "story_v_out_416051.awb")
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
	Play416051013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 416051013
		arg_56_1.duration_ = 4.6

		local var_56_0 = {
			zh = 3.866,
			ja = 4.6
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
				arg_56_0:Play416051014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1148"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps1148 == nil then
				arg_56_1.var_.actorSpriteComps1148 = var_59_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_2 = 0.125

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.actorSpriteComps1148 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps1148 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_59_3 then
						if arg_56_1.isInRecall_ then
							iter_59_3.color = arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_59_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_56_1.var_.actorSpriteComps1148 = nil
			end

			local var_59_8 = arg_56_1.actors_["1148"].transform
			local var_59_9 = 0

			if var_59_9 < arg_56_1.time_ and arg_56_1.time_ <= var_59_9 + arg_59_0 then
				arg_56_1.var_.moveOldPos1148 = var_59_8.localPosition
				var_59_8.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("1148", 3)

				local var_59_10 = var_59_8.childCount

				for iter_59_4 = 0, var_59_10 - 1 do
					local var_59_11 = var_59_8:GetChild(iter_59_4)

					if var_59_11.name == "split_3" or not string.find(var_59_11.name, "split") then
						var_59_11.gameObject:SetActive(true)
					else
						var_59_11.gameObject:SetActive(false)
					end
				end
			end

			local var_59_12 = 0.001

			if var_59_9 <= arg_56_1.time_ and arg_56_1.time_ < var_59_9 + var_59_12 then
				local var_59_13 = (arg_56_1.time_ - var_59_9) / var_59_12
				local var_59_14 = Vector3.New(0, -429, -180)

				var_59_8.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1148, var_59_14, var_59_13)
			end

			if arg_56_1.time_ >= var_59_9 + var_59_12 and arg_56_1.time_ < var_59_9 + var_59_12 + arg_59_0 then
				var_59_8.localPosition = Vector3.New(0, -429, -180)
			end

			local var_59_15 = 0
			local var_59_16 = 0.45

			if var_59_15 < arg_56_1.time_ and arg_56_1.time_ <= var_59_15 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_17 = arg_56_1:FormatText(StoryNameCfg[8].name)

				arg_56_1.leftNameTxt_.text = var_59_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_18 = arg_56_1:GetWordFromCfg(416051013)
				local var_59_19 = arg_56_1:FormatText(var_59_18.content)

				arg_56_1.text_.text = var_59_19

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_20 = 18
				local var_59_21 = utf8.len(var_59_19)
				local var_59_22 = var_59_20 <= 0 and var_59_16 or var_59_16 * (var_59_21 / var_59_20)

				if var_59_22 > 0 and var_59_16 < var_59_22 then
					arg_56_1.talkMaxDuration = var_59_22

					if var_59_22 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_22 + var_59_15
					end
				end

				arg_56_1.text_.text = var_59_19
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051013", "story_v_out_416051.awb") ~= 0 then
					local var_59_23 = manager.audio:GetVoiceLength("story_v_out_416051", "416051013", "story_v_out_416051.awb") / 1000

					if var_59_23 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_23 + var_59_15
					end

					if var_59_18.prefab_name ~= "" and arg_56_1.actors_[var_59_18.prefab_name] ~= nil then
						local var_59_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_18.prefab_name].transform, "story_v_out_416051", "416051013", "story_v_out_416051.awb")

						arg_56_1:RecordAudio("416051013", var_59_24)
						arg_56_1:RecordAudio("416051013", var_59_24)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_416051", "416051013", "story_v_out_416051.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_416051", "416051013", "story_v_out_416051.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_25 = math.max(var_59_16, arg_56_1.talkMaxDuration)

			if var_59_15 <= arg_56_1.time_ and arg_56_1.time_ < var_59_15 + var_59_25 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_15) / var_59_25

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_15 + var_59_25 and arg_56_1.time_ < var_59_15 + var_59_25 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416051014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 416051014
		arg_60_1.duration_ = 5.07

		local var_60_0 = {
			zh = 4.533,
			ja = 5.066
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
				arg_60_0:Play416051015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.45

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[8].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_3 = arg_60_1:GetWordFromCfg(416051014)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 18
				local var_63_6 = utf8.len(var_63_4)
				local var_63_7 = var_63_5 <= 0 and var_63_1 or var_63_1 * (var_63_6 / var_63_5)

				if var_63_7 > 0 and var_63_1 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051014", "story_v_out_416051.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_out_416051", "416051014", "story_v_out_416051.awb") / 1000

					if var_63_8 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_0
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_out_416051", "416051014", "story_v_out_416051.awb")

						arg_60_1:RecordAudio("416051014", var_63_9)
						arg_60_1:RecordAudio("416051014", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_416051", "416051014", "story_v_out_416051.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_416051", "416051014", "story_v_out_416051.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_10 and arg_60_1.time_ < var_63_0 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play416051015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 416051015
		arg_64_1.duration_ = 10.67

		local var_64_0 = {
			zh = 7.533,
			ja = 10.666
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play416051016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1148"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps1148 == nil then
				arg_64_1.var_.actorSpriteComps1148 = var_67_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_2 = 0.125

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.actorSpriteComps1148 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.actorSpriteComps1148 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_67_3 then
						if arg_64_1.isInRecall_ then
							iter_67_3.color = arg_64_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_67_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps1148 = nil
			end

			local var_67_8 = 0
			local var_67_9 = 0.8

			if var_67_8 < arg_64_1.time_ and arg_64_1.time_ <= var_67_8 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_10 = arg_64_1:FormatText(StoryNameCfg[1084].name)

				arg_64_1.leftNameTxt_.text = var_67_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_11 = arg_64_1:GetWordFromCfg(416051015)
				local var_67_12 = arg_64_1:FormatText(var_67_11.content)

				arg_64_1.text_.text = var_67_12

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_13 = 32
				local var_67_14 = utf8.len(var_67_12)
				local var_67_15 = var_67_13 <= 0 and var_67_9 or var_67_9 * (var_67_14 / var_67_13)

				if var_67_15 > 0 and var_67_9 < var_67_15 then
					arg_64_1.talkMaxDuration = var_67_15

					if var_67_15 + var_67_8 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_15 + var_67_8
					end
				end

				arg_64_1.text_.text = var_67_12
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051015", "story_v_out_416051.awb") ~= 0 then
					local var_67_16 = manager.audio:GetVoiceLength("story_v_out_416051", "416051015", "story_v_out_416051.awb") / 1000

					if var_67_16 + var_67_8 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_16 + var_67_8
					end

					if var_67_11.prefab_name ~= "" and arg_64_1.actors_[var_67_11.prefab_name] ~= nil then
						local var_67_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_11.prefab_name].transform, "story_v_out_416051", "416051015", "story_v_out_416051.awb")

						arg_64_1:RecordAudio("416051015", var_67_17)
						arg_64_1:RecordAudio("416051015", var_67_17)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_416051", "416051015", "story_v_out_416051.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_416051", "416051015", "story_v_out_416051.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_18 = math.max(var_67_9, arg_64_1.talkMaxDuration)

			if var_67_8 <= arg_64_1.time_ and arg_64_1.time_ < var_67_8 + var_67_18 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_8) / var_67_18

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_8 + var_67_18 and arg_64_1.time_ < var_67_8 + var_67_18 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play416051016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 416051016
		arg_68_1.duration_ = 6.47

		local var_68_0 = {
			zh = 3.466,
			ja = 6.466
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
				arg_68_0:Play416051017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1148"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps1148 == nil then
				arg_68_1.var_.actorSpriteComps1148 = var_71_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_2 = 0.125

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.actorSpriteComps1148 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps1148 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_71_3 then
						if arg_68_1.isInRecall_ then
							iter_71_3.color = arg_68_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_71_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_68_1.var_.actorSpriteComps1148 = nil
			end

			local var_71_8 = 0
			local var_71_9 = 0.45

			if var_71_8 < arg_68_1.time_ and arg_68_1.time_ <= var_71_8 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_10 = arg_68_1:FormatText(StoryNameCfg[8].name)

				arg_68_1.leftNameTxt_.text = var_71_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_11 = arg_68_1:GetWordFromCfg(416051016)
				local var_71_12 = arg_68_1:FormatText(var_71_11.content)

				arg_68_1.text_.text = var_71_12

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_13 = 18
				local var_71_14 = utf8.len(var_71_12)
				local var_71_15 = var_71_13 <= 0 and var_71_9 or var_71_9 * (var_71_14 / var_71_13)

				if var_71_15 > 0 and var_71_9 < var_71_15 then
					arg_68_1.talkMaxDuration = var_71_15

					if var_71_15 + var_71_8 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_15 + var_71_8
					end
				end

				arg_68_1.text_.text = var_71_12
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051016", "story_v_out_416051.awb") ~= 0 then
					local var_71_16 = manager.audio:GetVoiceLength("story_v_out_416051", "416051016", "story_v_out_416051.awb") / 1000

					if var_71_16 + var_71_8 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_16 + var_71_8
					end

					if var_71_11.prefab_name ~= "" and arg_68_1.actors_[var_71_11.prefab_name] ~= nil then
						local var_71_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_11.prefab_name].transform, "story_v_out_416051", "416051016", "story_v_out_416051.awb")

						arg_68_1:RecordAudio("416051016", var_71_17)
						arg_68_1:RecordAudio("416051016", var_71_17)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_416051", "416051016", "story_v_out_416051.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_416051", "416051016", "story_v_out_416051.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_18 = math.max(var_71_9, arg_68_1.talkMaxDuration)

			if var_71_8 <= arg_68_1.time_ and arg_68_1.time_ < var_71_8 + var_71_18 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_8) / var_71_18

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_8 + var_71_18 and arg_68_1.time_ < var_71_8 + var_71_18 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play416051017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 416051017
		arg_72_1.duration_ = 4.8

		local var_72_0 = {
			zh = 4.133,
			ja = 4.8
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
				arg_72_0:Play416051018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 0.475

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_2 = arg_72_1:FormatText(StoryNameCfg[8].name)

				arg_72_1.leftNameTxt_.text = var_75_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_3 = arg_72_1:GetWordFromCfg(416051017)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 19
				local var_75_6 = utf8.len(var_75_4)
				local var_75_7 = var_75_5 <= 0 and var_75_1 or var_75_1 * (var_75_6 / var_75_5)

				if var_75_7 > 0 and var_75_1 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_4
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051017", "story_v_out_416051.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_out_416051", "416051017", "story_v_out_416051.awb") / 1000

					if var_75_8 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_0
					end

					if var_75_3.prefab_name ~= "" and arg_72_1.actors_[var_75_3.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_3.prefab_name].transform, "story_v_out_416051", "416051017", "story_v_out_416051.awb")

						arg_72_1:RecordAudio("416051017", var_75_9)
						arg_72_1:RecordAudio("416051017", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_416051", "416051017", "story_v_out_416051.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_416051", "416051017", "story_v_out_416051.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_10 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_10 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_10

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_10 and arg_72_1.time_ < var_75_0 + var_75_10 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play416051018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 416051018
		arg_76_1.duration_ = 5.53

		local var_76_0 = {
			zh = 3.7,
			ja = 5.533
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
				arg_76_0:Play416051019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1148"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps1148 == nil then
				arg_76_1.var_.actorSpriteComps1148 = var_79_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_2 = 0.125

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.actorSpriteComps1148 then
					for iter_79_0, iter_79_1 in pairs(arg_76_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_79_1 then
							if arg_76_1.isInRecall_ then
								local var_79_4 = Mathf.Lerp(iter_79_1.color.r, arg_76_1.hightColor2.r, var_79_3)
								local var_79_5 = Mathf.Lerp(iter_79_1.color.g, arg_76_1.hightColor2.g, var_79_3)
								local var_79_6 = Mathf.Lerp(iter_79_1.color.b, arg_76_1.hightColor2.b, var_79_3)

								iter_79_1.color = Color.New(var_79_4, var_79_5, var_79_6)
							else
								local var_79_7 = Mathf.Lerp(iter_79_1.color.r, 0.5, var_79_3)

								iter_79_1.color = Color.New(var_79_7, var_79_7, var_79_7)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps1148 then
				for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_79_3 then
						if arg_76_1.isInRecall_ then
							iter_79_3.color = arg_76_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_79_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps1148 = nil
			end

			local var_79_8 = 0
			local var_79_9 = 0.425

			if var_79_8 < arg_76_1.time_ and arg_76_1.time_ <= var_79_8 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_10 = arg_76_1:FormatText(StoryNameCfg[1084].name)

				arg_76_1.leftNameTxt_.text = var_79_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_11 = arg_76_1:GetWordFromCfg(416051018)
				local var_79_12 = arg_76_1:FormatText(var_79_11.content)

				arg_76_1.text_.text = var_79_12

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_13 = 17
				local var_79_14 = utf8.len(var_79_12)
				local var_79_15 = var_79_13 <= 0 and var_79_9 or var_79_9 * (var_79_14 / var_79_13)

				if var_79_15 > 0 and var_79_9 < var_79_15 then
					arg_76_1.talkMaxDuration = var_79_15

					if var_79_15 + var_79_8 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_15 + var_79_8
					end
				end

				arg_76_1.text_.text = var_79_12
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051018", "story_v_out_416051.awb") ~= 0 then
					local var_79_16 = manager.audio:GetVoiceLength("story_v_out_416051", "416051018", "story_v_out_416051.awb") / 1000

					if var_79_16 + var_79_8 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_16 + var_79_8
					end

					if var_79_11.prefab_name ~= "" and arg_76_1.actors_[var_79_11.prefab_name] ~= nil then
						local var_79_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_11.prefab_name].transform, "story_v_out_416051", "416051018", "story_v_out_416051.awb")

						arg_76_1:RecordAudio("416051018", var_79_17)
						arg_76_1:RecordAudio("416051018", var_79_17)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_416051", "416051018", "story_v_out_416051.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_416051", "416051018", "story_v_out_416051.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_18 = math.max(var_79_9, arg_76_1.talkMaxDuration)

			if var_79_8 <= arg_76_1.time_ and arg_76_1.time_ < var_79_8 + var_79_18 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_8) / var_79_18

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_8 + var_79_18 and arg_76_1.time_ < var_79_8 + var_79_18 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play416051019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 416051019
		arg_80_1.duration_ = 7.33

		local var_80_0 = {
			zh = 4.333,
			ja = 7.333
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play416051020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1148"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.actorSpriteComps1148 == nil then
				arg_80_1.var_.actorSpriteComps1148 = var_83_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_2 = 0.125

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.actorSpriteComps1148 then
					for iter_83_0, iter_83_1 in pairs(arg_80_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.actorSpriteComps1148 then
				for iter_83_2, iter_83_3 in pairs(arg_80_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_83_3 then
						if arg_80_1.isInRecall_ then
							iter_83_3.color = arg_80_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_83_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_80_1.var_.actorSpriteComps1148 = nil
			end

			local var_83_8 = 0
			local var_83_9 = 0.45

			if var_83_8 < arg_80_1.time_ and arg_80_1.time_ <= var_83_8 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_10 = arg_80_1:FormatText(StoryNameCfg[8].name)

				arg_80_1.leftNameTxt_.text = var_83_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_11 = arg_80_1:GetWordFromCfg(416051019)
				local var_83_12 = arg_80_1:FormatText(var_83_11.content)

				arg_80_1.text_.text = var_83_12

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_13 = 18
				local var_83_14 = utf8.len(var_83_12)
				local var_83_15 = var_83_13 <= 0 and var_83_9 or var_83_9 * (var_83_14 / var_83_13)

				if var_83_15 > 0 and var_83_9 < var_83_15 then
					arg_80_1.talkMaxDuration = var_83_15

					if var_83_15 + var_83_8 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_15 + var_83_8
					end
				end

				arg_80_1.text_.text = var_83_12
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051019", "story_v_out_416051.awb") ~= 0 then
					local var_83_16 = manager.audio:GetVoiceLength("story_v_out_416051", "416051019", "story_v_out_416051.awb") / 1000

					if var_83_16 + var_83_8 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_16 + var_83_8
					end

					if var_83_11.prefab_name ~= "" and arg_80_1.actors_[var_83_11.prefab_name] ~= nil then
						local var_83_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_11.prefab_name].transform, "story_v_out_416051", "416051019", "story_v_out_416051.awb")

						arg_80_1:RecordAudio("416051019", var_83_17)
						arg_80_1:RecordAudio("416051019", var_83_17)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_416051", "416051019", "story_v_out_416051.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_416051", "416051019", "story_v_out_416051.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_18 = math.max(var_83_9, arg_80_1.talkMaxDuration)

			if var_83_8 <= arg_80_1.time_ and arg_80_1.time_ < var_83_8 + var_83_18 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_8) / var_83_18

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_8 + var_83_18 and arg_80_1.time_ < var_83_8 + var_83_18 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play416051020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 416051020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play416051021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1148"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos1148 = var_87_0.localPosition
				var_87_0.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("1148", 7)

				local var_87_2 = var_87_0.childCount

				for iter_87_0 = 0, var_87_2 - 1 do
					local var_87_3 = var_87_0:GetChild(iter_87_0)

					if var_87_3.name == "" or not string.find(var_87_3.name, "split") then
						var_87_3.gameObject:SetActive(true)
					else
						var_87_3.gameObject:SetActive(false)
					end
				end
			end

			local var_87_4 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_4 then
				local var_87_5 = (arg_84_1.time_ - var_87_1) / var_87_4
				local var_87_6 = Vector3.New(0, -2000, 0)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1148, var_87_6, var_87_5)
			end

			if arg_84_1.time_ >= var_87_1 + var_87_4 and arg_84_1.time_ < var_87_1 + var_87_4 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_87_7 = 0
			local var_87_8 = 2

			if var_87_7 < arg_84_1.time_ and arg_84_1.time_ <= var_87_7 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_9 = arg_84_1:GetWordFromCfg(416051020)
				local var_87_10 = arg_84_1:FormatText(var_87_9.content)

				arg_84_1.text_.text = var_87_10

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_11 = 80
				local var_87_12 = utf8.len(var_87_10)
				local var_87_13 = var_87_11 <= 0 and var_87_8 or var_87_8 * (var_87_12 / var_87_11)

				if var_87_13 > 0 and var_87_8 < var_87_13 then
					arg_84_1.talkMaxDuration = var_87_13

					if var_87_13 + var_87_7 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_13 + var_87_7
					end
				end

				arg_84_1.text_.text = var_87_10
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_14 = math.max(var_87_8, arg_84_1.talkMaxDuration)

			if var_87_7 <= arg_84_1.time_ and arg_84_1.time_ < var_87_7 + var_87_14 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_7) / var_87_14

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_7 + var_87_14 and arg_84_1.time_ < var_87_7 + var_87_14 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416051021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 416051021
		arg_88_1.duration_ = 9.7

		local var_88_0 = {
			zh = 9.7,
			ja = 8.366
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
				arg_88_0:Play416051022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 4

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.allBtn_.enabled = false
			end

			local var_91_1 = 0.3

			if arg_88_1.time_ >= var_91_0 + var_91_1 and arg_88_1.time_ < var_91_0 + var_91_1 + arg_91_0 then
				arg_88_1.allBtn_.enabled = true
			end

			local var_91_2 = "ST2101"

			if arg_88_1.bgs_[var_91_2] == nil then
				local var_91_3 = Object.Instantiate(arg_88_1.paintGo_)

				var_91_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_91_2)
				var_91_3.name = var_91_2
				var_91_3.transform.parent = arg_88_1.stage_.transform
				var_91_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.bgs_[var_91_2] = var_91_3
			end

			local var_91_4 = 2

			if var_91_4 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				local var_91_5 = manager.ui.mainCamera.transform.localPosition
				local var_91_6 = Vector3.New(0, 0, 10) + Vector3.New(var_91_5.x, var_91_5.y, 0)
				local var_91_7 = arg_88_1.bgs_.ST2101

				var_91_7.transform.localPosition = var_91_6
				var_91_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_91_8 = var_91_7:GetComponent("SpriteRenderer")

				if var_91_8 and var_91_8.sprite then
					local var_91_9 = (var_91_7.transform.localPosition - var_91_5).z
					local var_91_10 = manager.ui.mainCameraCom_
					local var_91_11 = 2 * var_91_9 * Mathf.Tan(var_91_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_91_12 = var_91_11 * var_91_10.aspect
					local var_91_13 = var_91_8.sprite.bounds.size.x
					local var_91_14 = var_91_8.sprite.bounds.size.y
					local var_91_15 = var_91_12 / var_91_13
					local var_91_16 = var_91_11 / var_91_14
					local var_91_17 = var_91_16 < var_91_15 and var_91_15 or var_91_16

					var_91_7.transform.localScale = Vector3.New(var_91_17, var_91_17, 0)
				end

				for iter_91_0, iter_91_1 in pairs(arg_88_1.bgs_) do
					if iter_91_0 ~= "ST2101" then
						iter_91_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_91_18 = 0

			if var_91_18 < arg_88_1.time_ and arg_88_1.time_ <= var_91_18 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_19 = 2

			if var_91_18 <= arg_88_1.time_ and arg_88_1.time_ < var_91_18 + var_91_19 then
				local var_91_20 = (arg_88_1.time_ - var_91_18) / var_91_19
				local var_91_21 = Color.New(0, 0, 0)

				var_91_21.a = Mathf.Lerp(0, 1, var_91_20)
				arg_88_1.mask_.color = var_91_21
			end

			if arg_88_1.time_ >= var_91_18 + var_91_19 and arg_88_1.time_ < var_91_18 + var_91_19 + arg_91_0 then
				local var_91_22 = Color.New(0, 0, 0)

				var_91_22.a = 1
				arg_88_1.mask_.color = var_91_22
			end

			local var_91_23 = 2

			if var_91_23 < arg_88_1.time_ and arg_88_1.time_ <= var_91_23 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_24 = 2

			if var_91_23 <= arg_88_1.time_ and arg_88_1.time_ < var_91_23 + var_91_24 then
				local var_91_25 = (arg_88_1.time_ - var_91_23) / var_91_24
				local var_91_26 = Color.New(0, 0, 0)

				var_91_26.a = Mathf.Lerp(1, 0, var_91_25)
				arg_88_1.mask_.color = var_91_26
			end

			if arg_88_1.time_ >= var_91_23 + var_91_24 and arg_88_1.time_ < var_91_23 + var_91_24 + arg_91_0 then
				local var_91_27 = Color.New(0, 0, 0)
				local var_91_28 = 0

				arg_88_1.mask_.enabled = false
				var_91_27.a = var_91_28
				arg_88_1.mask_.color = var_91_27
			end

			local var_91_29 = "10054"

			if arg_88_1.actors_[var_91_29] == nil then
				local var_91_30 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10054")

				if not isNil(var_91_30) then
					local var_91_31 = Object.Instantiate(var_91_30, arg_88_1.canvasGo_.transform)

					var_91_31.transform:SetSiblingIndex(1)

					var_91_31.name = var_91_29
					var_91_31.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_88_1.actors_[var_91_29] = var_91_31

					local var_91_32 = var_91_31:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_88_1.isInRecall_ then
						for iter_91_2, iter_91_3 in ipairs(var_91_32) do
							iter_91_3.color = arg_88_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_91_33 = arg_88_1.actors_["10054"].transform
			local var_91_34 = 3.73333333333333

			if var_91_34 < arg_88_1.time_ and arg_88_1.time_ <= var_91_34 + arg_91_0 then
				arg_88_1.var_.moveOldPos10054 = var_91_33.localPosition
				var_91_33.localScale = Vector3.New(1, 1, 1)

				arg_88_1:CheckSpriteTmpPos("10054", 3)

				local var_91_35 = var_91_33.childCount

				for iter_91_4 = 0, var_91_35 - 1 do
					local var_91_36 = var_91_33:GetChild(iter_91_4)

					if var_91_36.name == "split_4" or not string.find(var_91_36.name, "split") then
						var_91_36.gameObject:SetActive(true)
					else
						var_91_36.gameObject:SetActive(false)
					end
				end
			end

			local var_91_37 = 0.001

			if var_91_34 <= arg_88_1.time_ and arg_88_1.time_ < var_91_34 + var_91_37 then
				local var_91_38 = (arg_88_1.time_ - var_91_34) / var_91_37
				local var_91_39 = Vector3.New(0, -331.1, -274.72)

				var_91_33.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos10054, var_91_39, var_91_38)
			end

			if arg_88_1.time_ >= var_91_34 + var_91_37 and arg_88_1.time_ < var_91_34 + var_91_37 + arg_91_0 then
				var_91_33.localPosition = Vector3.New(0, -331.1, -274.72)
			end

			local var_91_40 = arg_88_1.actors_["10054"]
			local var_91_41 = 3.73333333333333

			if var_91_41 < arg_88_1.time_ and arg_88_1.time_ <= var_91_41 + arg_91_0 and not isNil(var_91_40) and arg_88_1.var_.actorSpriteComps10054 == nil then
				arg_88_1.var_.actorSpriteComps10054 = var_91_40:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_42 = 0.125

			if var_91_41 <= arg_88_1.time_ and arg_88_1.time_ < var_91_41 + var_91_42 and not isNil(var_91_40) then
				local var_91_43 = (arg_88_1.time_ - var_91_41) / var_91_42

				if arg_88_1.var_.actorSpriteComps10054 then
					for iter_91_5, iter_91_6 in pairs(arg_88_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_91_6 then
							if arg_88_1.isInRecall_ then
								local var_91_44 = Mathf.Lerp(iter_91_6.color.r, arg_88_1.hightColor1.r, var_91_43)
								local var_91_45 = Mathf.Lerp(iter_91_6.color.g, arg_88_1.hightColor1.g, var_91_43)
								local var_91_46 = Mathf.Lerp(iter_91_6.color.b, arg_88_1.hightColor1.b, var_91_43)

								iter_91_6.color = Color.New(var_91_44, var_91_45, var_91_46)
							else
								local var_91_47 = Mathf.Lerp(iter_91_6.color.r, 1, var_91_43)

								iter_91_6.color = Color.New(var_91_47, var_91_47, var_91_47)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= var_91_41 + var_91_42 and arg_88_1.time_ < var_91_41 + var_91_42 + arg_91_0 and not isNil(var_91_40) and arg_88_1.var_.actorSpriteComps10054 then
				for iter_91_7, iter_91_8 in pairs(arg_88_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_91_8 then
						if arg_88_1.isInRecall_ then
							iter_91_8.color = arg_88_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_91_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_88_1.var_.actorSpriteComps10054 = nil
			end

			local var_91_48 = arg_88_1.actors_["10054"]
			local var_91_49 = 3.73333333333333

			if var_91_49 < arg_88_1.time_ and arg_88_1.time_ <= var_91_49 + arg_91_0 then
				local var_91_50 = var_91_48:GetComponentInChildren(typeof(CanvasGroup))

				if var_91_50 then
					arg_88_1.var_.alphaOldValue10054 = var_91_50.alpha
					arg_88_1.var_.characterEffect10054 = var_91_50
				end

				arg_88_1.var_.alphaOldValue10054 = 0
			end

			local var_91_51 = 0.4

			if var_91_49 <= arg_88_1.time_ and arg_88_1.time_ < var_91_49 + var_91_51 then
				local var_91_52 = (arg_88_1.time_ - var_91_49) / var_91_51
				local var_91_53 = Mathf.Lerp(arg_88_1.var_.alphaOldValue10054, 1, var_91_52)

				if arg_88_1.var_.characterEffect10054 then
					arg_88_1.var_.characterEffect10054.alpha = var_91_53
				end
			end

			if arg_88_1.time_ >= var_91_49 + var_91_51 and arg_88_1.time_ < var_91_49 + var_91_51 + arg_91_0 and arg_88_1.var_.characterEffect10054 then
				arg_88_1.var_.characterEffect10054.alpha = 1
			end

			local var_91_54 = manager.ui.mainCamera.transform
			local var_91_55 = 2

			if var_91_55 < arg_88_1.time_ and arg_88_1.time_ <= var_91_55 + arg_91_0 then
				local var_91_56 = arg_88_1.var_.effect51003

				if var_91_56 then
					Object.Destroy(var_91_56)

					arg_88_1.var_.effect51003 = nil
				end
			end

			local var_91_57 = 0
			local var_91_58 = 0.2

			if var_91_57 < arg_88_1.time_ and arg_88_1.time_ <= var_91_57 + arg_91_0 then
				local var_91_59 = "play"
				local var_91_60 = "music"

				arg_88_1:AudioAction(var_91_59, var_91_60, "ui_battle", "ui_battle_stopbgm", "")

				local var_91_61 = ""
				local var_91_62 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_91_62 ~= "" then
					if arg_88_1.bgmTxt_.text ~= var_91_62 and arg_88_1.bgmTxt_.text ~= "" then
						if arg_88_1.bgmTxt2_.text ~= "" then
							arg_88_1.bgmTxt_.text = arg_88_1.bgmTxt2_.text
						end

						arg_88_1.bgmTxt2_.text = var_91_62

						arg_88_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_88_1.bgmTxt_.text = var_91_62
						arg_88_1.bgmTxt2_.text = var_91_62
					end

					if arg_88_1.bgmTimer then
						arg_88_1.bgmTimer:Stop()

						arg_88_1.bgmTimer = nil
					end

					if arg_88_1.settingData.show_music_name == 1 then
						arg_88_1.musicController:SetSelectedState("show")
						arg_88_1.musicAnimator_:Play("open", 0, 0)

						if arg_88_1.settingData.music_time ~= 0 then
							arg_88_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_88_1.settingData.music_time), function()
								if arg_88_1 == nil or isNil(arg_88_1.bgmTxt_) then
									return
								end

								arg_88_1.musicController:SetSelectedState("hide")
								arg_88_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_91_63 = 2.3
			local var_91_64 = 1

			if var_91_63 < arg_88_1.time_ and arg_88_1.time_ <= var_91_63 + arg_91_0 then
				local var_91_65 = "play"
				local var_91_66 = "music"

				arg_88_1:AudioAction(var_91_65, var_91_66, "bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg.awb")

				local var_91_67 = ""
				local var_91_68 = manager.audio:GetAudioName("bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg")

				if var_91_68 ~= "" then
					if arg_88_1.bgmTxt_.text ~= var_91_68 and arg_88_1.bgmTxt_.text ~= "" then
						if arg_88_1.bgmTxt2_.text ~= "" then
							arg_88_1.bgmTxt_.text = arg_88_1.bgmTxt2_.text
						end

						arg_88_1.bgmTxt2_.text = var_91_68

						arg_88_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_88_1.bgmTxt_.text = var_91_68
						arg_88_1.bgmTxt2_.text = var_91_68
					end

					if arg_88_1.bgmTimer then
						arg_88_1.bgmTimer:Stop()

						arg_88_1.bgmTimer = nil
					end

					if arg_88_1.settingData.show_music_name == 1 then
						arg_88_1.musicController:SetSelectedState("show")
						arg_88_1.musicAnimator_:Play("open", 0, 0)

						if arg_88_1.settingData.music_time ~= 0 then
							arg_88_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_88_1.settingData.music_time), function()
								if arg_88_1 == nil or isNil(arg_88_1.bgmTxt_) then
									return
								end

								arg_88_1.musicController:SetSelectedState("hide")
								arg_88_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_88_1.frameCnt_ <= 1 then
				arg_88_1.dialog_:SetActive(false)
			end

			local var_91_69 = 4
			local var_91_70 = 0.525

			if var_91_69 < arg_88_1.time_ and arg_88_1.time_ <= var_91_69 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0

				arg_88_1.dialog_:SetActive(true)

				arg_88_1.dialogCg_.alpha = 0

				local var_91_71 = LeanTween.value(arg_88_1.dialog_, 0, 1, 0.3)

				var_91_71:setOnUpdate(LuaHelper.FloatAction(function(arg_94_0)
					arg_88_1.dialogCg_.alpha = arg_94_0
				end))
				var_91_71:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_88_1.dialog_)
					var_91_71:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_88_1.duration_ = arg_88_1.duration_ + 0.3

				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_72 = arg_88_1:FormatText(StoryNameCfg[487].name)

				arg_88_1.leftNameTxt_.text = var_91_72

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_73 = arg_88_1:GetWordFromCfg(416051021)
				local var_91_74 = arg_88_1:FormatText(var_91_73.content)

				arg_88_1.text_.text = var_91_74

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_75 = 19
				local var_91_76 = utf8.len(var_91_74)
				local var_91_77 = var_91_75 <= 0 and var_91_70 or var_91_70 * (var_91_76 / var_91_75)

				if var_91_77 > 0 and var_91_70 < var_91_77 then
					arg_88_1.talkMaxDuration = var_91_77
					var_91_69 = var_91_69 + 0.3

					if var_91_77 + var_91_69 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_77 + var_91_69
					end
				end

				arg_88_1.text_.text = var_91_74
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051021", "story_v_out_416051.awb") ~= 0 then
					local var_91_78 = manager.audio:GetVoiceLength("story_v_out_416051", "416051021", "story_v_out_416051.awb") / 1000

					if var_91_78 + var_91_69 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_78 + var_91_69
					end

					if var_91_73.prefab_name ~= "" and arg_88_1.actors_[var_91_73.prefab_name] ~= nil then
						local var_91_79 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_73.prefab_name].transform, "story_v_out_416051", "416051021", "story_v_out_416051.awb")

						arg_88_1:RecordAudio("416051021", var_91_79)
						arg_88_1:RecordAudio("416051021", var_91_79)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_416051", "416051021", "story_v_out_416051.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_416051", "416051021", "story_v_out_416051.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_80 = var_91_69 + 0.3
			local var_91_81 = math.max(var_91_70, arg_88_1.talkMaxDuration)

			if var_91_80 <= arg_88_1.time_ and arg_88_1.time_ < var_91_80 + var_91_81 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_80) / var_91_81

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_80 + var_91_81 and arg_88_1.time_ < var_91_80 + var_91_81 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play416051022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 416051022
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play416051023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["10054"].transform
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.var_.moveOldPos10054 = var_99_0.localPosition
				var_99_0.localScale = Vector3.New(1, 1, 1)

				arg_96_1:CheckSpriteTmpPos("10054", 7)

				local var_99_2 = var_99_0.childCount

				for iter_99_0 = 0, var_99_2 - 1 do
					local var_99_3 = var_99_0:GetChild(iter_99_0)

					if var_99_3.name == "" or not string.find(var_99_3.name, "split") then
						var_99_3.gameObject:SetActive(true)
					else
						var_99_3.gameObject:SetActive(false)
					end
				end
			end

			local var_99_4 = 0.001

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_4 then
				local var_99_5 = (arg_96_1.time_ - var_99_1) / var_99_4
				local var_99_6 = Vector3.New(0, -2000, 0)

				var_99_0.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10054, var_99_6, var_99_5)
			end

			if arg_96_1.time_ >= var_99_1 + var_99_4 and arg_96_1.time_ < var_99_1 + var_99_4 + arg_99_0 then
				var_99_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_99_7 = 0
			local var_99_8 = 2

			if var_99_7 < arg_96_1.time_ and arg_96_1.time_ <= var_99_7 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_9 = arg_96_1:GetWordFromCfg(416051022)
				local var_99_10 = arg_96_1:FormatText(var_99_9.content)

				arg_96_1.text_.text = var_99_10

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_11 = 80
				local var_99_12 = utf8.len(var_99_10)
				local var_99_13 = var_99_11 <= 0 and var_99_8 or var_99_8 * (var_99_12 / var_99_11)

				if var_99_13 > 0 and var_99_8 < var_99_13 then
					arg_96_1.talkMaxDuration = var_99_13

					if var_99_13 + var_99_7 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_13 + var_99_7
					end
				end

				arg_96_1.text_.text = var_99_10
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_14 = math.max(var_99_8, arg_96_1.talkMaxDuration)

			if var_99_7 <= arg_96_1.time_ and arg_96_1.time_ < var_99_7 + var_99_14 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_7) / var_99_14

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_7 + var_99_14 and arg_96_1.time_ < var_99_7 + var_99_14 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play416051023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 416051023
		arg_100_1.duration_ = 6.83

		local var_100_0 = {
			zh = 3.666,
			ja = 6.833
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
				arg_100_0:Play416051024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["10054"].transform
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.var_.moveOldPos10054 = var_103_0.localPosition
				var_103_0.localScale = Vector3.New(1, 1, 1)

				arg_100_1:CheckSpriteTmpPos("10054", 3)

				local var_103_2 = var_103_0.childCount

				for iter_103_0 = 0, var_103_2 - 1 do
					local var_103_3 = var_103_0:GetChild(iter_103_0)

					if var_103_3.name == "" or not string.find(var_103_3.name, "split") then
						var_103_3.gameObject:SetActive(true)
					else
						var_103_3.gameObject:SetActive(false)
					end
				end
			end

			local var_103_4 = 0.001

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_4 then
				local var_103_5 = (arg_100_1.time_ - var_103_1) / var_103_4
				local var_103_6 = Vector3.New(0, -331.1, -274.72)

				var_103_0.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10054, var_103_6, var_103_5)
			end

			if arg_100_1.time_ >= var_103_1 + var_103_4 and arg_100_1.time_ < var_103_1 + var_103_4 + arg_103_0 then
				var_103_0.localPosition = Vector3.New(0, -331.1, -274.72)
			end

			local var_103_7 = arg_100_1.actors_["10054"]
			local var_103_8 = 0

			if var_103_8 < arg_100_1.time_ and arg_100_1.time_ <= var_103_8 + arg_103_0 and not isNil(var_103_7) and arg_100_1.var_.actorSpriteComps10054 == nil then
				arg_100_1.var_.actorSpriteComps10054 = var_103_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_9 = 0.125

			if var_103_8 <= arg_100_1.time_ and arg_100_1.time_ < var_103_8 + var_103_9 and not isNil(var_103_7) then
				local var_103_10 = (arg_100_1.time_ - var_103_8) / var_103_9

				if arg_100_1.var_.actorSpriteComps10054 then
					for iter_103_1, iter_103_2 in pairs(arg_100_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_103_2 then
							if arg_100_1.isInRecall_ then
								local var_103_11 = Mathf.Lerp(iter_103_2.color.r, arg_100_1.hightColor1.r, var_103_10)
								local var_103_12 = Mathf.Lerp(iter_103_2.color.g, arg_100_1.hightColor1.g, var_103_10)
								local var_103_13 = Mathf.Lerp(iter_103_2.color.b, arg_100_1.hightColor1.b, var_103_10)

								iter_103_2.color = Color.New(var_103_11, var_103_12, var_103_13)
							else
								local var_103_14 = Mathf.Lerp(iter_103_2.color.r, 1, var_103_10)

								iter_103_2.color = Color.New(var_103_14, var_103_14, var_103_14)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= var_103_8 + var_103_9 and arg_100_1.time_ < var_103_8 + var_103_9 + arg_103_0 and not isNil(var_103_7) and arg_100_1.var_.actorSpriteComps10054 then
				for iter_103_3, iter_103_4 in pairs(arg_100_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_103_4 then
						if arg_100_1.isInRecall_ then
							iter_103_4.color = arg_100_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_103_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_100_1.var_.actorSpriteComps10054 = nil
			end

			local var_103_15 = 0
			local var_103_16 = 0.5

			if var_103_15 < arg_100_1.time_ and arg_100_1.time_ <= var_103_15 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_17 = arg_100_1:FormatText(StoryNameCfg[487].name)

				arg_100_1.leftNameTxt_.text = var_103_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_18 = arg_100_1:GetWordFromCfg(416051023)
				local var_103_19 = arg_100_1:FormatText(var_103_18.content)

				arg_100_1.text_.text = var_103_19

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_20 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051023", "story_v_out_416051.awb") ~= 0 then
					local var_103_23 = manager.audio:GetVoiceLength("story_v_out_416051", "416051023", "story_v_out_416051.awb") / 1000

					if var_103_23 + var_103_15 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_23 + var_103_15
					end

					if var_103_18.prefab_name ~= "" and arg_100_1.actors_[var_103_18.prefab_name] ~= nil then
						local var_103_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_18.prefab_name].transform, "story_v_out_416051", "416051023", "story_v_out_416051.awb")

						arg_100_1:RecordAudio("416051023", var_103_24)
						arg_100_1:RecordAudio("416051023", var_103_24)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_416051", "416051023", "story_v_out_416051.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_416051", "416051023", "story_v_out_416051.awb")
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
				actorName = "10054",
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
	Play416051024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 416051024
		arg_104_1.duration_ = 9.83

		local var_104_0 = {
			zh = 5.666,
			ja = 9.833
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
				arg_104_0:Play416051025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["10054"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos10054 = var_107_0.localPosition
				var_107_0.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("10054", 2)

				local var_107_2 = var_107_0.childCount

				for iter_107_0 = 0, var_107_2 - 1 do
					local var_107_3 = var_107_0:GetChild(iter_107_0)

					if var_107_3.name == "" or not string.find(var_107_3.name, "split") then
						var_107_3.gameObject:SetActive(true)
					else
						var_107_3.gameObject:SetActive(false)
					end
				end
			end

			local var_107_4 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_4 then
				local var_107_5 = (arg_104_1.time_ - var_107_1) / var_107_4
				local var_107_6 = Vector3.New(-390, -331.1, -274.72)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10054, var_107_6, var_107_5)
			end

			if arg_104_1.time_ >= var_107_1 + var_107_4 and arg_104_1.time_ < var_107_1 + var_107_4 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(-390, -331.1, -274.72)
			end

			local var_107_7 = "1033"

			if arg_104_1.actors_[var_107_7] == nil then
				local var_107_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

				if not isNil(var_107_8) then
					local var_107_9 = Object.Instantiate(var_107_8, arg_104_1.canvasGo_.transform)

					var_107_9.transform:SetSiblingIndex(1)

					var_107_9.name = var_107_7
					var_107_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_104_1.actors_[var_107_7] = var_107_9

					local var_107_10 = var_107_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_104_1.isInRecall_ then
						for iter_107_1, iter_107_2 in ipairs(var_107_10) do
							iter_107_2.color = arg_104_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_107_11 = arg_104_1.actors_["1033"].transform
			local var_107_12 = 0

			if var_107_12 < arg_104_1.time_ and arg_104_1.time_ <= var_107_12 + arg_107_0 then
				arg_104_1.var_.moveOldPos1033 = var_107_11.localPosition
				var_107_11.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("1033", 4)

				local var_107_13 = var_107_11.childCount

				for iter_107_3 = 0, var_107_13 - 1 do
					local var_107_14 = var_107_11:GetChild(iter_107_3)

					if var_107_14.name == "split_6" or not string.find(var_107_14.name, "split") then
						var_107_14.gameObject:SetActive(true)
					else
						var_107_14.gameObject:SetActive(false)
					end
				end
			end

			local var_107_15 = 0.001

			if var_107_12 <= arg_104_1.time_ and arg_104_1.time_ < var_107_12 + var_107_15 then
				local var_107_16 = (arg_104_1.time_ - var_107_12) / var_107_15
				local var_107_17 = Vector3.New(390, -420, 0)

				var_107_11.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1033, var_107_17, var_107_16)
			end

			if arg_104_1.time_ >= var_107_12 + var_107_15 and arg_104_1.time_ < var_107_12 + var_107_15 + arg_107_0 then
				var_107_11.localPosition = Vector3.New(390, -420, 0)
			end

			local var_107_18 = arg_104_1.actors_["1033"]
			local var_107_19 = 0

			if var_107_19 < arg_104_1.time_ and arg_104_1.time_ <= var_107_19 + arg_107_0 and not isNil(var_107_18) and arg_104_1.var_.actorSpriteComps1033 == nil then
				arg_104_1.var_.actorSpriteComps1033 = var_107_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_20 = 0.125

			if var_107_19 <= arg_104_1.time_ and arg_104_1.time_ < var_107_19 + var_107_20 and not isNil(var_107_18) then
				local var_107_21 = (arg_104_1.time_ - var_107_19) / var_107_20

				if arg_104_1.var_.actorSpriteComps1033 then
					for iter_107_4, iter_107_5 in pairs(arg_104_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_107_5 then
							if arg_104_1.isInRecall_ then
								local var_107_22 = Mathf.Lerp(iter_107_5.color.r, arg_104_1.hightColor1.r, var_107_21)
								local var_107_23 = Mathf.Lerp(iter_107_5.color.g, arg_104_1.hightColor1.g, var_107_21)
								local var_107_24 = Mathf.Lerp(iter_107_5.color.b, arg_104_1.hightColor1.b, var_107_21)

								iter_107_5.color = Color.New(var_107_22, var_107_23, var_107_24)
							else
								local var_107_25 = Mathf.Lerp(iter_107_5.color.r, 1, var_107_21)

								iter_107_5.color = Color.New(var_107_25, var_107_25, var_107_25)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= var_107_19 + var_107_20 and arg_104_1.time_ < var_107_19 + var_107_20 + arg_107_0 and not isNil(var_107_18) and arg_104_1.var_.actorSpriteComps1033 then
				for iter_107_6, iter_107_7 in pairs(arg_104_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_107_7 then
						if arg_104_1.isInRecall_ then
							iter_107_7.color = arg_104_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_107_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_104_1.var_.actorSpriteComps1033 = nil
			end

			local var_107_26 = arg_104_1.actors_["10054"]
			local var_107_27 = 0

			if var_107_27 < arg_104_1.time_ and arg_104_1.time_ <= var_107_27 + arg_107_0 and not isNil(var_107_26) and arg_104_1.var_.actorSpriteComps10054 == nil then
				arg_104_1.var_.actorSpriteComps10054 = var_107_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_28 = 0.125

			if var_107_27 <= arg_104_1.time_ and arg_104_1.time_ < var_107_27 + var_107_28 and not isNil(var_107_26) then
				local var_107_29 = (arg_104_1.time_ - var_107_27) / var_107_28

				if arg_104_1.var_.actorSpriteComps10054 then
					for iter_107_8, iter_107_9 in pairs(arg_104_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_107_9 then
							if arg_104_1.isInRecall_ then
								local var_107_30 = Mathf.Lerp(iter_107_9.color.r, arg_104_1.hightColor2.r, var_107_29)
								local var_107_31 = Mathf.Lerp(iter_107_9.color.g, arg_104_1.hightColor2.g, var_107_29)
								local var_107_32 = Mathf.Lerp(iter_107_9.color.b, arg_104_1.hightColor2.b, var_107_29)

								iter_107_9.color = Color.New(var_107_30, var_107_31, var_107_32)
							else
								local var_107_33 = Mathf.Lerp(iter_107_9.color.r, 0.5, var_107_29)

								iter_107_9.color = Color.New(var_107_33, var_107_33, var_107_33)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= var_107_27 + var_107_28 and arg_104_1.time_ < var_107_27 + var_107_28 + arg_107_0 and not isNil(var_107_26) and arg_104_1.var_.actorSpriteComps10054 then
				for iter_107_10, iter_107_11 in pairs(arg_104_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_107_11 then
						if arg_104_1.isInRecall_ then
							iter_107_11.color = arg_104_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_107_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_104_1.var_.actorSpriteComps10054 = nil
			end

			local var_107_34 = 0
			local var_107_35 = 0.85

			if var_107_34 < arg_104_1.time_ and arg_104_1.time_ <= var_107_34 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_36 = arg_104_1:FormatText(StoryNameCfg[236].name)

				arg_104_1.leftNameTxt_.text = var_107_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_37 = arg_104_1:GetWordFromCfg(416051024)
				local var_107_38 = arg_104_1:FormatText(var_107_37.content)

				arg_104_1.text_.text = var_107_38

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_39 = 34
				local var_107_40 = utf8.len(var_107_38)
				local var_107_41 = var_107_39 <= 0 and var_107_35 or var_107_35 * (var_107_40 / var_107_39)

				if var_107_41 > 0 and var_107_35 < var_107_41 then
					arg_104_1.talkMaxDuration = var_107_41

					if var_107_41 + var_107_34 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_41 + var_107_34
					end
				end

				arg_104_1.text_.text = var_107_38
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051024", "story_v_out_416051.awb") ~= 0 then
					local var_107_42 = manager.audio:GetVoiceLength("story_v_out_416051", "416051024", "story_v_out_416051.awb") / 1000

					if var_107_42 + var_107_34 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_42 + var_107_34
					end

					if var_107_37.prefab_name ~= "" and arg_104_1.actors_[var_107_37.prefab_name] ~= nil then
						local var_107_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_37.prefab_name].transform, "story_v_out_416051", "416051024", "story_v_out_416051.awb")

						arg_104_1:RecordAudio("416051024", var_107_43)
						arg_104_1:RecordAudio("416051024", var_107_43)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_416051", "416051024", "story_v_out_416051.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_416051", "416051024", "story_v_out_416051.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_44 = math.max(var_107_35, arg_104_1.talkMaxDuration)

			if var_107_34 <= arg_104_1.time_ and arg_104_1.time_ < var_107_34 + var_107_44 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_34) / var_107_44

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_34 + var_107_44 and arg_104_1.time_ < var_107_34 + var_107_44 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
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
	Play416051025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 416051025
		arg_108_1.duration_ = 5.43

		local var_108_0 = {
			zh = 3.4,
			ja = 5.433
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
				arg_108_0:Play416051026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1033"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps1033 == nil then
				arg_108_1.var_.actorSpriteComps1033 = var_111_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_2 = 0.125

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.actorSpriteComps1033 then
					for iter_111_0, iter_111_1 in pairs(arg_108_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_111_1 then
							if arg_108_1.isInRecall_ then
								local var_111_4 = Mathf.Lerp(iter_111_1.color.r, arg_108_1.hightColor2.r, var_111_3)
								local var_111_5 = Mathf.Lerp(iter_111_1.color.g, arg_108_1.hightColor2.g, var_111_3)
								local var_111_6 = Mathf.Lerp(iter_111_1.color.b, arg_108_1.hightColor2.b, var_111_3)

								iter_111_1.color = Color.New(var_111_4, var_111_5, var_111_6)
							else
								local var_111_7 = Mathf.Lerp(iter_111_1.color.r, 0.5, var_111_3)

								iter_111_1.color = Color.New(var_111_7, var_111_7, var_111_7)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps1033 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_111_3 then
						if arg_108_1.isInRecall_ then
							iter_111_3.color = arg_108_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_111_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps1033 = nil
			end

			local var_111_8 = arg_108_1.actors_["10054"]
			local var_111_9 = 0

			if var_111_9 < arg_108_1.time_ and arg_108_1.time_ <= var_111_9 + arg_111_0 and not isNil(var_111_8) and arg_108_1.var_.actorSpriteComps10054 == nil then
				arg_108_1.var_.actorSpriteComps10054 = var_111_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_10 = 0.125

			if var_111_9 <= arg_108_1.time_ and arg_108_1.time_ < var_111_9 + var_111_10 and not isNil(var_111_8) then
				local var_111_11 = (arg_108_1.time_ - var_111_9) / var_111_10

				if arg_108_1.var_.actorSpriteComps10054 then
					for iter_111_4, iter_111_5 in pairs(arg_108_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_111_5 then
							if arg_108_1.isInRecall_ then
								local var_111_12 = Mathf.Lerp(iter_111_5.color.r, arg_108_1.hightColor1.r, var_111_11)
								local var_111_13 = Mathf.Lerp(iter_111_5.color.g, arg_108_1.hightColor1.g, var_111_11)
								local var_111_14 = Mathf.Lerp(iter_111_5.color.b, arg_108_1.hightColor1.b, var_111_11)

								iter_111_5.color = Color.New(var_111_12, var_111_13, var_111_14)
							else
								local var_111_15 = Mathf.Lerp(iter_111_5.color.r, 1, var_111_11)

								iter_111_5.color = Color.New(var_111_15, var_111_15, var_111_15)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= var_111_9 + var_111_10 and arg_108_1.time_ < var_111_9 + var_111_10 + arg_111_0 and not isNil(var_111_8) and arg_108_1.var_.actorSpriteComps10054 then
				for iter_111_6, iter_111_7 in pairs(arg_108_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_111_7 then
						if arg_108_1.isInRecall_ then
							iter_111_7.color = arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_111_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps10054 = nil
			end

			local var_111_16 = 0
			local var_111_17 = 0.475

			if var_111_16 < arg_108_1.time_ and arg_108_1.time_ <= var_111_16 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_18 = arg_108_1:FormatText(StoryNameCfg[487].name)

				arg_108_1.leftNameTxt_.text = var_111_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_19 = arg_108_1:GetWordFromCfg(416051025)
				local var_111_20 = arg_108_1:FormatText(var_111_19.content)

				arg_108_1.text_.text = var_111_20

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_21 = 19
				local var_111_22 = utf8.len(var_111_20)
				local var_111_23 = var_111_21 <= 0 and var_111_17 or var_111_17 * (var_111_22 / var_111_21)

				if var_111_23 > 0 and var_111_17 < var_111_23 then
					arg_108_1.talkMaxDuration = var_111_23

					if var_111_23 + var_111_16 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_23 + var_111_16
					end
				end

				arg_108_1.text_.text = var_111_20
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051025", "story_v_out_416051.awb") ~= 0 then
					local var_111_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051025", "story_v_out_416051.awb") / 1000

					if var_111_24 + var_111_16 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_24 + var_111_16
					end

					if var_111_19.prefab_name ~= "" and arg_108_1.actors_[var_111_19.prefab_name] ~= nil then
						local var_111_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_19.prefab_name].transform, "story_v_out_416051", "416051025", "story_v_out_416051.awb")

						arg_108_1:RecordAudio("416051025", var_111_25)
						arg_108_1:RecordAudio("416051025", var_111_25)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_416051", "416051025", "story_v_out_416051.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_416051", "416051025", "story_v_out_416051.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_26 = math.max(var_111_17, arg_108_1.talkMaxDuration)

			if var_111_16 <= arg_108_1.time_ and arg_108_1.time_ < var_111_16 + var_111_26 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_16) / var_111_26

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_16 + var_111_26 and arg_108_1.time_ < var_111_16 + var_111_26 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play416051026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 416051026
		arg_112_1.duration_ = 10.07

		local var_112_0 = {
			zh = 6.766,
			ja = 10.066
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
				arg_112_0:Play416051027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1033"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps1033 == nil then
				arg_112_1.var_.actorSpriteComps1033 = var_115_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_2 = 0.125

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.actorSpriteComps1033 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps1033 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_115_3 then
						if arg_112_1.isInRecall_ then
							iter_115_3.color = arg_112_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_115_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_112_1.var_.actorSpriteComps1033 = nil
			end

			local var_115_8 = arg_112_1.actors_["10054"]
			local var_115_9 = 0

			if var_115_9 < arg_112_1.time_ and arg_112_1.time_ <= var_115_9 + arg_115_0 and not isNil(var_115_8) and arg_112_1.var_.actorSpriteComps10054 == nil then
				arg_112_1.var_.actorSpriteComps10054 = var_115_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_10 = 0.125

			if var_115_9 <= arg_112_1.time_ and arg_112_1.time_ < var_115_9 + var_115_10 and not isNil(var_115_8) then
				local var_115_11 = (arg_112_1.time_ - var_115_9) / var_115_10

				if arg_112_1.var_.actorSpriteComps10054 then
					for iter_115_4, iter_115_5 in pairs(arg_112_1.var_.actorSpriteComps10054:ToTable()) do
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

			if arg_112_1.time_ >= var_115_9 + var_115_10 and arg_112_1.time_ < var_115_9 + var_115_10 + arg_115_0 and not isNil(var_115_8) and arg_112_1.var_.actorSpriteComps10054 then
				for iter_115_6, iter_115_7 in pairs(arg_112_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_115_7 then
						if arg_112_1.isInRecall_ then
							iter_115_7.color = arg_112_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_115_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_112_1.var_.actorSpriteComps10054 = nil
			end

			local var_115_16 = 0
			local var_115_17 = 0.7

			if var_115_16 < arg_112_1.time_ and arg_112_1.time_ <= var_115_16 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_18 = arg_112_1:FormatText(StoryNameCfg[236].name)

				arg_112_1.leftNameTxt_.text = var_115_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_19 = arg_112_1:GetWordFromCfg(416051026)
				local var_115_20 = arg_112_1:FormatText(var_115_19.content)

				arg_112_1.text_.text = var_115_20

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_21 = 28
				local var_115_22 = utf8.len(var_115_20)
				local var_115_23 = var_115_21 <= 0 and var_115_17 or var_115_17 * (var_115_22 / var_115_21)

				if var_115_23 > 0 and var_115_17 < var_115_23 then
					arg_112_1.talkMaxDuration = var_115_23

					if var_115_23 + var_115_16 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_23 + var_115_16
					end
				end

				arg_112_1.text_.text = var_115_20
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051026", "story_v_out_416051.awb") ~= 0 then
					local var_115_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051026", "story_v_out_416051.awb") / 1000

					if var_115_24 + var_115_16 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_24 + var_115_16
					end

					if var_115_19.prefab_name ~= "" and arg_112_1.actors_[var_115_19.prefab_name] ~= nil then
						local var_115_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_19.prefab_name].transform, "story_v_out_416051", "416051026", "story_v_out_416051.awb")

						arg_112_1:RecordAudio("416051026", var_115_25)
						arg_112_1:RecordAudio("416051026", var_115_25)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_416051", "416051026", "story_v_out_416051.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_416051", "416051026", "story_v_out_416051.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_26 = math.max(var_115_17, arg_112_1.talkMaxDuration)

			if var_115_16 <= arg_112_1.time_ and arg_112_1.time_ < var_115_16 + var_115_26 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_16) / var_115_26

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_16 + var_115_26 and arg_112_1.time_ < var_115_16 + var_115_26 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play416051027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 416051027
		arg_116_1.duration_ = 3.13

		local var_116_0 = {
			zh = 2.8,
			ja = 3.133
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
				arg_116_0:Play416051028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1033"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.actorSpriteComps1033 == nil then
				arg_116_1.var_.actorSpriteComps1033 = var_119_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_2 = 0.125

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.actorSpriteComps1033 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_119_1 then
							if arg_116_1.isInRecall_ then
								local var_119_4 = Mathf.Lerp(iter_119_1.color.r, arg_116_1.hightColor2.r, var_119_3)
								local var_119_5 = Mathf.Lerp(iter_119_1.color.g, arg_116_1.hightColor2.g, var_119_3)
								local var_119_6 = Mathf.Lerp(iter_119_1.color.b, arg_116_1.hightColor2.b, var_119_3)

								iter_119_1.color = Color.New(var_119_4, var_119_5, var_119_6)
							else
								local var_119_7 = Mathf.Lerp(iter_119_1.color.r, 0.5, var_119_3)

								iter_119_1.color = Color.New(var_119_7, var_119_7, var_119_7)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.actorSpriteComps1033 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_119_3 then
						if arg_116_1.isInRecall_ then
							iter_119_3.color = arg_116_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_119_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_116_1.var_.actorSpriteComps1033 = nil
			end

			local var_119_8 = arg_116_1.actors_["10054"]
			local var_119_9 = 0

			if var_119_9 < arg_116_1.time_ and arg_116_1.time_ <= var_119_9 + arg_119_0 and not isNil(var_119_8) and arg_116_1.var_.actorSpriteComps10054 == nil then
				arg_116_1.var_.actorSpriteComps10054 = var_119_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_10 = 0.125

			if var_119_9 <= arg_116_1.time_ and arg_116_1.time_ < var_119_9 + var_119_10 and not isNil(var_119_8) then
				local var_119_11 = (arg_116_1.time_ - var_119_9) / var_119_10

				if arg_116_1.var_.actorSpriteComps10054 then
					for iter_119_4, iter_119_5 in pairs(arg_116_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_119_5 then
							if arg_116_1.isInRecall_ then
								local var_119_12 = Mathf.Lerp(iter_119_5.color.r, arg_116_1.hightColor1.r, var_119_11)
								local var_119_13 = Mathf.Lerp(iter_119_5.color.g, arg_116_1.hightColor1.g, var_119_11)
								local var_119_14 = Mathf.Lerp(iter_119_5.color.b, arg_116_1.hightColor1.b, var_119_11)

								iter_119_5.color = Color.New(var_119_12, var_119_13, var_119_14)
							else
								local var_119_15 = Mathf.Lerp(iter_119_5.color.r, 1, var_119_11)

								iter_119_5.color = Color.New(var_119_15, var_119_15, var_119_15)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= var_119_9 + var_119_10 and arg_116_1.time_ < var_119_9 + var_119_10 + arg_119_0 and not isNil(var_119_8) and arg_116_1.var_.actorSpriteComps10054 then
				for iter_119_6, iter_119_7 in pairs(arg_116_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_119_7 then
						if arg_116_1.isInRecall_ then
							iter_119_7.color = arg_116_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_119_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_116_1.var_.actorSpriteComps10054 = nil
			end

			local var_119_16 = 0
			local var_119_17 = 0.225

			if var_119_16 < arg_116_1.time_ and arg_116_1.time_ <= var_119_16 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_18 = arg_116_1:FormatText(StoryNameCfg[487].name)

				arg_116_1.leftNameTxt_.text = var_119_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_19 = arg_116_1:GetWordFromCfg(416051027)
				local var_119_20 = arg_116_1:FormatText(var_119_19.content)

				arg_116_1.text_.text = var_119_20

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_21 = 9
				local var_119_22 = utf8.len(var_119_20)
				local var_119_23 = var_119_21 <= 0 and var_119_17 or var_119_17 * (var_119_22 / var_119_21)

				if var_119_23 > 0 and var_119_17 < var_119_23 then
					arg_116_1.talkMaxDuration = var_119_23

					if var_119_23 + var_119_16 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_23 + var_119_16
					end
				end

				arg_116_1.text_.text = var_119_20
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051027", "story_v_out_416051.awb") ~= 0 then
					local var_119_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051027", "story_v_out_416051.awb") / 1000

					if var_119_24 + var_119_16 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_24 + var_119_16
					end

					if var_119_19.prefab_name ~= "" and arg_116_1.actors_[var_119_19.prefab_name] ~= nil then
						local var_119_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_19.prefab_name].transform, "story_v_out_416051", "416051027", "story_v_out_416051.awb")

						arg_116_1:RecordAudio("416051027", var_119_25)
						arg_116_1:RecordAudio("416051027", var_119_25)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_416051", "416051027", "story_v_out_416051.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_416051", "416051027", "story_v_out_416051.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_26 = math.max(var_119_17, arg_116_1.talkMaxDuration)

			if var_119_16 <= arg_116_1.time_ and arg_116_1.time_ < var_119_16 + var_119_26 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_16) / var_119_26

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_16 + var_119_26 and arg_116_1.time_ < var_119_16 + var_119_26 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play416051028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 416051028
		arg_120_1.duration_ = 6.87

		local var_120_0 = {
			zh = 6.333,
			ja = 6.866
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
				arg_120_0:Play416051029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1033"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.actorSpriteComps1033 == nil then
				arg_120_1.var_.actorSpriteComps1033 = var_123_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_2 = 0.125

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.actorSpriteComps1033 then
					for iter_123_0, iter_123_1 in pairs(arg_120_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.actorSpriteComps1033 then
				for iter_123_2, iter_123_3 in pairs(arg_120_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_123_3 then
						if arg_120_1.isInRecall_ then
							iter_123_3.color = arg_120_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_123_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_120_1.var_.actorSpriteComps1033 = nil
			end

			local var_123_8 = arg_120_1.actors_["10054"]
			local var_123_9 = 0

			if var_123_9 < arg_120_1.time_ and arg_120_1.time_ <= var_123_9 + arg_123_0 and not isNil(var_123_8) and arg_120_1.var_.actorSpriteComps10054 == nil then
				arg_120_1.var_.actorSpriteComps10054 = var_123_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_10 = 0.125

			if var_123_9 <= arg_120_1.time_ and arg_120_1.time_ < var_123_9 + var_123_10 and not isNil(var_123_8) then
				local var_123_11 = (arg_120_1.time_ - var_123_9) / var_123_10

				if arg_120_1.var_.actorSpriteComps10054 then
					for iter_123_4, iter_123_5 in pairs(arg_120_1.var_.actorSpriteComps10054:ToTable()) do
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

			if arg_120_1.time_ >= var_123_9 + var_123_10 and arg_120_1.time_ < var_123_9 + var_123_10 + arg_123_0 and not isNil(var_123_8) and arg_120_1.var_.actorSpriteComps10054 then
				for iter_123_6, iter_123_7 in pairs(arg_120_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_123_7 then
						if arg_120_1.isInRecall_ then
							iter_123_7.color = arg_120_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_123_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_120_1.var_.actorSpriteComps10054 = nil
			end

			local var_123_16 = 0
			local var_123_17 = 0.75

			if var_123_16 < arg_120_1.time_ and arg_120_1.time_ <= var_123_16 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_18 = arg_120_1:FormatText(StoryNameCfg[236].name)

				arg_120_1.leftNameTxt_.text = var_123_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_19 = arg_120_1:GetWordFromCfg(416051028)
				local var_123_20 = arg_120_1:FormatText(var_123_19.content)

				arg_120_1.text_.text = var_123_20

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_21 = 30
				local var_123_22 = utf8.len(var_123_20)
				local var_123_23 = var_123_21 <= 0 and var_123_17 or var_123_17 * (var_123_22 / var_123_21)

				if var_123_23 > 0 and var_123_17 < var_123_23 then
					arg_120_1.talkMaxDuration = var_123_23

					if var_123_23 + var_123_16 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_23 + var_123_16
					end
				end

				arg_120_1.text_.text = var_123_20
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051028", "story_v_out_416051.awb") ~= 0 then
					local var_123_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051028", "story_v_out_416051.awb") / 1000

					if var_123_24 + var_123_16 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_24 + var_123_16
					end

					if var_123_19.prefab_name ~= "" and arg_120_1.actors_[var_123_19.prefab_name] ~= nil then
						local var_123_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_19.prefab_name].transform, "story_v_out_416051", "416051028", "story_v_out_416051.awb")

						arg_120_1:RecordAudio("416051028", var_123_25)
						arg_120_1:RecordAudio("416051028", var_123_25)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_416051", "416051028", "story_v_out_416051.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_416051", "416051028", "story_v_out_416051.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_26 = math.max(var_123_17, arg_120_1.talkMaxDuration)

			if var_123_16 <= arg_120_1.time_ and arg_120_1.time_ < var_123_16 + var_123_26 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_16) / var_123_26

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_16 + var_123_26 and arg_120_1.time_ < var_123_16 + var_123_26 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play416051029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 416051029
		arg_124_1.duration_ = 5.1

		local var_124_0 = {
			zh = 4.9,
			ja = 5.1
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
				arg_124_0:Play416051030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1033"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps1033 == nil then
				arg_124_1.var_.actorSpriteComps1033 = var_127_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_2 = 0.125

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.actorSpriteComps1033 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_127_1 then
							if arg_124_1.isInRecall_ then
								local var_127_4 = Mathf.Lerp(iter_127_1.color.r, arg_124_1.hightColor2.r, var_127_3)
								local var_127_5 = Mathf.Lerp(iter_127_1.color.g, arg_124_1.hightColor2.g, var_127_3)
								local var_127_6 = Mathf.Lerp(iter_127_1.color.b, arg_124_1.hightColor2.b, var_127_3)

								iter_127_1.color = Color.New(var_127_4, var_127_5, var_127_6)
							else
								local var_127_7 = Mathf.Lerp(iter_127_1.color.r, 0.5, var_127_3)

								iter_127_1.color = Color.New(var_127_7, var_127_7, var_127_7)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps1033 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_127_3 then
						if arg_124_1.isInRecall_ then
							iter_127_3.color = arg_124_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_127_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps1033 = nil
			end

			local var_127_8 = arg_124_1.actors_["10054"]
			local var_127_9 = 0

			if var_127_9 < arg_124_1.time_ and arg_124_1.time_ <= var_127_9 + arg_127_0 and not isNil(var_127_8) and arg_124_1.var_.actorSpriteComps10054 == nil then
				arg_124_1.var_.actorSpriteComps10054 = var_127_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_10 = 0.125

			if var_127_9 <= arg_124_1.time_ and arg_124_1.time_ < var_127_9 + var_127_10 and not isNil(var_127_8) then
				local var_127_11 = (arg_124_1.time_ - var_127_9) / var_127_10

				if arg_124_1.var_.actorSpriteComps10054 then
					for iter_127_4, iter_127_5 in pairs(arg_124_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_127_5 then
							if arg_124_1.isInRecall_ then
								local var_127_12 = Mathf.Lerp(iter_127_5.color.r, arg_124_1.hightColor1.r, var_127_11)
								local var_127_13 = Mathf.Lerp(iter_127_5.color.g, arg_124_1.hightColor1.g, var_127_11)
								local var_127_14 = Mathf.Lerp(iter_127_5.color.b, arg_124_1.hightColor1.b, var_127_11)

								iter_127_5.color = Color.New(var_127_12, var_127_13, var_127_14)
							else
								local var_127_15 = Mathf.Lerp(iter_127_5.color.r, 1, var_127_11)

								iter_127_5.color = Color.New(var_127_15, var_127_15, var_127_15)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= var_127_9 + var_127_10 and arg_124_1.time_ < var_127_9 + var_127_10 + arg_127_0 and not isNil(var_127_8) and arg_124_1.var_.actorSpriteComps10054 then
				for iter_127_6, iter_127_7 in pairs(arg_124_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_127_7 then
						if arg_124_1.isInRecall_ then
							iter_127_7.color = arg_124_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_127_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps10054 = nil
			end

			local var_127_16 = 0
			local var_127_17 = 0.325

			if var_127_16 < arg_124_1.time_ and arg_124_1.time_ <= var_127_16 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_18 = arg_124_1:FormatText(StoryNameCfg[487].name)

				arg_124_1.leftNameTxt_.text = var_127_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_19 = arg_124_1:GetWordFromCfg(416051029)
				local var_127_20 = arg_124_1:FormatText(var_127_19.content)

				arg_124_1.text_.text = var_127_20

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_21 = 13
				local var_127_22 = utf8.len(var_127_20)
				local var_127_23 = var_127_21 <= 0 and var_127_17 or var_127_17 * (var_127_22 / var_127_21)

				if var_127_23 > 0 and var_127_17 < var_127_23 then
					arg_124_1.talkMaxDuration = var_127_23

					if var_127_23 + var_127_16 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_23 + var_127_16
					end
				end

				arg_124_1.text_.text = var_127_20
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051029", "story_v_out_416051.awb") ~= 0 then
					local var_127_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051029", "story_v_out_416051.awb") / 1000

					if var_127_24 + var_127_16 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_24 + var_127_16
					end

					if var_127_19.prefab_name ~= "" and arg_124_1.actors_[var_127_19.prefab_name] ~= nil then
						local var_127_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_19.prefab_name].transform, "story_v_out_416051", "416051029", "story_v_out_416051.awb")

						arg_124_1:RecordAudio("416051029", var_127_25)
						arg_124_1:RecordAudio("416051029", var_127_25)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_416051", "416051029", "story_v_out_416051.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_416051", "416051029", "story_v_out_416051.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_26 = math.max(var_127_17, arg_124_1.talkMaxDuration)

			if var_127_16 <= arg_124_1.time_ and arg_124_1.time_ < var_127_16 + var_127_26 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_16) / var_127_26

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_16 + var_127_26 and arg_124_1.time_ < var_127_16 + var_127_26 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play416051030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 416051030
		arg_128_1.duration_ = 6.2

		local var_128_0 = {
			zh = 5.833,
			ja = 6.2
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
				arg_128_0:Play416051031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 4

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.allBtn_.enabled = false
			end

			local var_131_1 = 0.0666666666666669

			if arg_128_1.time_ >= var_131_0 + var_131_1 and arg_128_1.time_ < var_131_0 + var_131_1 + arg_131_0 then
				arg_128_1.allBtn_.enabled = true
			end

			local var_131_2 = 2

			if var_131_2 < arg_128_1.time_ and arg_128_1.time_ <= var_131_2 + arg_131_0 then
				local var_131_3 = manager.ui.mainCamera.transform.localPosition
				local var_131_4 = Vector3.New(0, 0, 10) + Vector3.New(var_131_3.x, var_131_3.y, 0)
				local var_131_5 = arg_128_1.bgs_.ST2101

				var_131_5.transform.localPosition = var_131_4
				var_131_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_131_6 = var_131_5:GetComponent("SpriteRenderer")

				if var_131_6 and var_131_6.sprite then
					local var_131_7 = (var_131_5.transform.localPosition - var_131_3).z
					local var_131_8 = manager.ui.mainCameraCom_
					local var_131_9 = 2 * var_131_7 * Mathf.Tan(var_131_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_131_10 = var_131_9 * var_131_8.aspect
					local var_131_11 = var_131_6.sprite.bounds.size.x
					local var_131_12 = var_131_6.sprite.bounds.size.y
					local var_131_13 = var_131_10 / var_131_11
					local var_131_14 = var_131_9 / var_131_12
					local var_131_15 = var_131_14 < var_131_13 and var_131_13 or var_131_14

					var_131_5.transform.localScale = Vector3.New(var_131_15, var_131_15, 0)
				end

				for iter_131_0, iter_131_1 in pairs(arg_128_1.bgs_) do
					if iter_131_0 ~= "ST2101" then
						iter_131_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_131_16 = 0

			if var_131_16 < arg_128_1.time_ and arg_128_1.time_ <= var_131_16 + arg_131_0 then
				arg_128_1.mask_.enabled = true
				arg_128_1.mask_.raycastTarget = true

				arg_128_1:SetGaussion(false)
			end

			local var_131_17 = 2

			if var_131_16 <= arg_128_1.time_ and arg_128_1.time_ < var_131_16 + var_131_17 then
				local var_131_18 = (arg_128_1.time_ - var_131_16) / var_131_17
				local var_131_19 = Color.New(0, 0, 0)

				var_131_19.a = Mathf.Lerp(0, 1, var_131_18)
				arg_128_1.mask_.color = var_131_19
			end

			if arg_128_1.time_ >= var_131_16 + var_131_17 and arg_128_1.time_ < var_131_16 + var_131_17 + arg_131_0 then
				local var_131_20 = Color.New(0, 0, 0)

				var_131_20.a = 1
				arg_128_1.mask_.color = var_131_20
			end

			local var_131_21 = 2

			if var_131_21 < arg_128_1.time_ and arg_128_1.time_ <= var_131_21 + arg_131_0 then
				arg_128_1.mask_.enabled = true
				arg_128_1.mask_.raycastTarget = true

				arg_128_1:SetGaussion(false)
			end

			local var_131_22 = 2

			if var_131_21 <= arg_128_1.time_ and arg_128_1.time_ < var_131_21 + var_131_22 then
				local var_131_23 = (arg_128_1.time_ - var_131_21) / var_131_22
				local var_131_24 = Color.New(0, 0, 0)

				var_131_24.a = Mathf.Lerp(1, 0, var_131_23)
				arg_128_1.mask_.color = var_131_24
			end

			if arg_128_1.time_ >= var_131_21 + var_131_22 and arg_128_1.time_ < var_131_21 + var_131_22 + arg_131_0 then
				local var_131_25 = Color.New(0, 0, 0)
				local var_131_26 = 0

				arg_128_1.mask_.enabled = false
				var_131_25.a = var_131_26
				arg_128_1.mask_.color = var_131_25
			end

			local var_131_27 = arg_128_1.actors_["10054"].transform
			local var_131_28 = 1.966

			if var_131_28 < arg_128_1.time_ and arg_128_1.time_ <= var_131_28 + arg_131_0 then
				arg_128_1.var_.moveOldPos10054 = var_131_27.localPosition
				var_131_27.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("10054", 7)

				local var_131_29 = var_131_27.childCount

				for iter_131_2 = 0, var_131_29 - 1 do
					local var_131_30 = var_131_27:GetChild(iter_131_2)

					if var_131_30.name == "" or not string.find(var_131_30.name, "split") then
						var_131_30.gameObject:SetActive(true)
					else
						var_131_30.gameObject:SetActive(false)
					end
				end
			end

			local var_131_31 = 0.001

			if var_131_28 <= arg_128_1.time_ and arg_128_1.time_ < var_131_28 + var_131_31 then
				local var_131_32 = (arg_128_1.time_ - var_131_28) / var_131_31
				local var_131_33 = Vector3.New(0, -2000, 0)

				var_131_27.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10054, var_131_33, var_131_32)
			end

			if arg_128_1.time_ >= var_131_28 + var_131_31 and arg_128_1.time_ < var_131_28 + var_131_31 + arg_131_0 then
				var_131_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_131_34 = arg_128_1.actors_["10054"].transform
			local var_131_35 = 3.73333333333333

			if var_131_35 < arg_128_1.time_ and arg_128_1.time_ <= var_131_35 + arg_131_0 then
				arg_128_1.var_.moveOldPos10054 = var_131_34.localPosition
				var_131_34.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("10054", 3)

				local var_131_36 = var_131_34.childCount

				for iter_131_3 = 0, var_131_36 - 1 do
					local var_131_37 = var_131_34:GetChild(iter_131_3)

					if var_131_37.name == "" or not string.find(var_131_37.name, "split") then
						var_131_37.gameObject:SetActive(true)
					else
						var_131_37.gameObject:SetActive(false)
					end
				end
			end

			local var_131_38 = 0.001

			if var_131_35 <= arg_128_1.time_ and arg_128_1.time_ < var_131_35 + var_131_38 then
				local var_131_39 = (arg_128_1.time_ - var_131_35) / var_131_38
				local var_131_40 = Vector3.New(0, -331.1, -274.72)

				var_131_34.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10054, var_131_40, var_131_39)
			end

			if arg_128_1.time_ >= var_131_35 + var_131_38 and arg_128_1.time_ < var_131_35 + var_131_38 + arg_131_0 then
				var_131_34.localPosition = Vector3.New(0, -331.1, -274.72)
			end

			local var_131_41 = arg_128_1.actors_["1033"].transform
			local var_131_42 = 1.966

			if var_131_42 < arg_128_1.time_ and arg_128_1.time_ <= var_131_42 + arg_131_0 then
				arg_128_1.var_.moveOldPos1033 = var_131_41.localPosition
				var_131_41.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("1033", 7)

				local var_131_43 = var_131_41.childCount

				for iter_131_4 = 0, var_131_43 - 1 do
					local var_131_44 = var_131_41:GetChild(iter_131_4)

					if var_131_44.name == "" or not string.find(var_131_44.name, "split") then
						var_131_44.gameObject:SetActive(true)
					else
						var_131_44.gameObject:SetActive(false)
					end
				end
			end

			local var_131_45 = 0.001

			if var_131_42 <= arg_128_1.time_ and arg_128_1.time_ < var_131_42 + var_131_45 then
				local var_131_46 = (arg_128_1.time_ - var_131_42) / var_131_45
				local var_131_47 = Vector3.New(0, -2000, 0)

				var_131_41.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1033, var_131_47, var_131_46)
			end

			if arg_128_1.time_ >= var_131_42 + var_131_45 and arg_128_1.time_ < var_131_42 + var_131_45 + arg_131_0 then
				var_131_41.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_131_48 = arg_128_1.actors_["10054"]
			local var_131_49 = 3.73333333333333

			if var_131_49 < arg_128_1.time_ and arg_128_1.time_ <= var_131_49 + arg_131_0 and not isNil(var_131_48) and arg_128_1.var_.actorSpriteComps10054 == nil then
				arg_128_1.var_.actorSpriteComps10054 = var_131_48:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_50 = 0.125

			if var_131_49 <= arg_128_1.time_ and arg_128_1.time_ < var_131_49 + var_131_50 and not isNil(var_131_48) then
				local var_131_51 = (arg_128_1.time_ - var_131_49) / var_131_50

				if arg_128_1.var_.actorSpriteComps10054 then
					for iter_131_5, iter_131_6 in pairs(arg_128_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_131_6 then
							if arg_128_1.isInRecall_ then
								local var_131_52 = Mathf.Lerp(iter_131_6.color.r, arg_128_1.hightColor1.r, var_131_51)
								local var_131_53 = Mathf.Lerp(iter_131_6.color.g, arg_128_1.hightColor1.g, var_131_51)
								local var_131_54 = Mathf.Lerp(iter_131_6.color.b, arg_128_1.hightColor1.b, var_131_51)

								iter_131_6.color = Color.New(var_131_52, var_131_53, var_131_54)
							else
								local var_131_55 = Mathf.Lerp(iter_131_6.color.r, 1, var_131_51)

								iter_131_6.color = Color.New(var_131_55, var_131_55, var_131_55)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= var_131_49 + var_131_50 and arg_128_1.time_ < var_131_49 + var_131_50 + arg_131_0 and not isNil(var_131_48) and arg_128_1.var_.actorSpriteComps10054 then
				for iter_131_7, iter_131_8 in pairs(arg_128_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_131_8 then
						if arg_128_1.isInRecall_ then
							iter_131_8.color = arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_131_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps10054 = nil
			end

			local var_131_56 = arg_128_1.actors_["10054"]
			local var_131_57 = 3.73333333333333

			if var_131_57 < arg_128_1.time_ and arg_128_1.time_ <= var_131_57 + arg_131_0 then
				local var_131_58 = var_131_56:GetComponentInChildren(typeof(CanvasGroup))

				if var_131_58 then
					arg_128_1.var_.alphaOldValue10054 = var_131_58.alpha
					arg_128_1.var_.characterEffect10054 = var_131_58
				end

				arg_128_1.var_.alphaOldValue10054 = 0
			end

			local var_131_59 = 0.333333333333333

			if var_131_57 <= arg_128_1.time_ and arg_128_1.time_ < var_131_57 + var_131_59 then
				local var_131_60 = (arg_128_1.time_ - var_131_57) / var_131_59
				local var_131_61 = Mathf.Lerp(arg_128_1.var_.alphaOldValue10054, 1, var_131_60)

				if arg_128_1.var_.characterEffect10054 then
					arg_128_1.var_.characterEffect10054.alpha = var_131_61
				end
			end

			if arg_128_1.time_ >= var_131_57 + var_131_59 and arg_128_1.time_ < var_131_57 + var_131_59 + arg_131_0 and arg_128_1.var_.characterEffect10054 then
				arg_128_1.var_.characterEffect10054.alpha = 1
			end

			if arg_128_1.frameCnt_ <= 1 then
				arg_128_1.dialog_:SetActive(false)
			end

			local var_131_62 = 4
			local var_131_63 = 0.15

			if var_131_62 < arg_128_1.time_ and arg_128_1.time_ <= var_131_62 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0

				arg_128_1.dialog_:SetActive(true)

				arg_128_1.dialogCg_.alpha = 0

				local var_131_64 = LeanTween.value(arg_128_1.dialog_, 0, 1, 0.3)

				var_131_64:setOnUpdate(LuaHelper.FloatAction(function(arg_132_0)
					arg_128_1.dialogCg_.alpha = arg_132_0
				end))
				var_131_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_128_1.dialog_)
					var_131_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_128_1.duration_ = arg_128_1.duration_ + 0.3

				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_65 = arg_128_1:FormatText(StoryNameCfg[487].name)

				arg_128_1.leftNameTxt_.text = var_131_65

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_66 = arg_128_1:GetWordFromCfg(416051030)
				local var_131_67 = arg_128_1:FormatText(var_131_66.content)

				arg_128_1.text_.text = var_131_67

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_68 = 6
				local var_131_69 = utf8.len(var_131_67)
				local var_131_70 = var_131_68 <= 0 and var_131_63 or var_131_63 * (var_131_69 / var_131_68)

				if var_131_70 > 0 and var_131_63 < var_131_70 then
					arg_128_1.talkMaxDuration = var_131_70
					var_131_62 = var_131_62 + 0.3

					if var_131_70 + var_131_62 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_70 + var_131_62
					end
				end

				arg_128_1.text_.text = var_131_67
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051030", "story_v_out_416051.awb") ~= 0 then
					local var_131_71 = manager.audio:GetVoiceLength("story_v_out_416051", "416051030", "story_v_out_416051.awb") / 1000

					if var_131_71 + var_131_62 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_71 + var_131_62
					end

					if var_131_66.prefab_name ~= "" and arg_128_1.actors_[var_131_66.prefab_name] ~= nil then
						local var_131_72 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_66.prefab_name].transform, "story_v_out_416051", "416051030", "story_v_out_416051.awb")

						arg_128_1:RecordAudio("416051030", var_131_72)
						arg_128_1:RecordAudio("416051030", var_131_72)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_416051", "416051030", "story_v_out_416051.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_416051", "416051030", "story_v_out_416051.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_73 = var_131_62 + 0.3
			local var_131_74 = math.max(var_131_63, arg_128_1.talkMaxDuration)

			if var_131_73 <= arg_128_1.time_ and arg_128_1.time_ < var_131_73 + var_131_74 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_73) / var_131_74

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_73 + var_131_74 and arg_128_1.time_ < var_131_73 + var_131_74 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play416051031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 416051031
		arg_134_1.duration_ = 9.83

		local var_134_0 = {
			zh = 6.366,
			ja = 9.833
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play416051032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["10054"].transform
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.var_.moveOldPos10054 = var_137_0.localPosition
				var_137_0.localScale = Vector3.New(1, 1, 1)

				arg_134_1:CheckSpriteTmpPos("10054", 2)

				local var_137_2 = var_137_0.childCount

				for iter_137_0 = 0, var_137_2 - 1 do
					local var_137_3 = var_137_0:GetChild(iter_137_0)

					if var_137_3.name == "" or not string.find(var_137_3.name, "split") then
						var_137_3.gameObject:SetActive(true)
					else
						var_137_3.gameObject:SetActive(false)
					end
				end
			end

			local var_137_4 = 0.001

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_4 then
				local var_137_5 = (arg_134_1.time_ - var_137_1) / var_137_4
				local var_137_6 = Vector3.New(-390, -331.1, -274.72)

				var_137_0.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos10054, var_137_6, var_137_5)
			end

			if arg_134_1.time_ >= var_137_1 + var_137_4 and arg_134_1.time_ < var_137_1 + var_137_4 + arg_137_0 then
				var_137_0.localPosition = Vector3.New(-390, -331.1, -274.72)
			end

			local var_137_7 = arg_134_1.actors_["10054"]
			local var_137_8 = 0

			if var_137_8 < arg_134_1.time_ and arg_134_1.time_ <= var_137_8 + arg_137_0 and not isNil(var_137_7) and arg_134_1.var_.actorSpriteComps10054 == nil then
				arg_134_1.var_.actorSpriteComps10054 = var_137_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_9 = 0.125

			if var_137_8 <= arg_134_1.time_ and arg_134_1.time_ < var_137_8 + var_137_9 and not isNil(var_137_7) then
				local var_137_10 = (arg_134_1.time_ - var_137_8) / var_137_9

				if arg_134_1.var_.actorSpriteComps10054 then
					for iter_137_1, iter_137_2 in pairs(arg_134_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_137_2 then
							if arg_134_1.isInRecall_ then
								local var_137_11 = Mathf.Lerp(iter_137_2.color.r, arg_134_1.hightColor2.r, var_137_10)
								local var_137_12 = Mathf.Lerp(iter_137_2.color.g, arg_134_1.hightColor2.g, var_137_10)
								local var_137_13 = Mathf.Lerp(iter_137_2.color.b, arg_134_1.hightColor2.b, var_137_10)

								iter_137_2.color = Color.New(var_137_11, var_137_12, var_137_13)
							else
								local var_137_14 = Mathf.Lerp(iter_137_2.color.r, 0.5, var_137_10)

								iter_137_2.color = Color.New(var_137_14, var_137_14, var_137_14)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= var_137_8 + var_137_9 and arg_134_1.time_ < var_137_8 + var_137_9 + arg_137_0 and not isNil(var_137_7) and arg_134_1.var_.actorSpriteComps10054 then
				for iter_137_3, iter_137_4 in pairs(arg_134_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_137_4 then
						if arg_134_1.isInRecall_ then
							iter_137_4.color = arg_134_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_137_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_134_1.var_.actorSpriteComps10054 = nil
			end

			local var_137_15 = arg_134_1.actors_["1033"]
			local var_137_16 = 0

			if var_137_16 < arg_134_1.time_ and arg_134_1.time_ <= var_137_16 + arg_137_0 and not isNil(var_137_15) and arg_134_1.var_.actorSpriteComps1033 == nil then
				arg_134_1.var_.actorSpriteComps1033 = var_137_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_17 = 0.125

			if var_137_16 <= arg_134_1.time_ and arg_134_1.time_ < var_137_16 + var_137_17 and not isNil(var_137_15) then
				local var_137_18 = (arg_134_1.time_ - var_137_16) / var_137_17

				if arg_134_1.var_.actorSpriteComps1033 then
					for iter_137_5, iter_137_6 in pairs(arg_134_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_137_6 then
							if arg_134_1.isInRecall_ then
								local var_137_19 = Mathf.Lerp(iter_137_6.color.r, arg_134_1.hightColor1.r, var_137_18)
								local var_137_20 = Mathf.Lerp(iter_137_6.color.g, arg_134_1.hightColor1.g, var_137_18)
								local var_137_21 = Mathf.Lerp(iter_137_6.color.b, arg_134_1.hightColor1.b, var_137_18)

								iter_137_6.color = Color.New(var_137_19, var_137_20, var_137_21)
							else
								local var_137_22 = Mathf.Lerp(iter_137_6.color.r, 1, var_137_18)

								iter_137_6.color = Color.New(var_137_22, var_137_22, var_137_22)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= var_137_16 + var_137_17 and arg_134_1.time_ < var_137_16 + var_137_17 + arg_137_0 and not isNil(var_137_15) and arg_134_1.var_.actorSpriteComps1033 then
				for iter_137_7, iter_137_8 in pairs(arg_134_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_137_8 then
						if arg_134_1.isInRecall_ then
							iter_137_8.color = arg_134_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_137_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_134_1.var_.actorSpriteComps1033 = nil
			end

			local var_137_23 = arg_134_1.actors_["1033"].transform
			local var_137_24 = 0

			if var_137_24 < arg_134_1.time_ and arg_134_1.time_ <= var_137_24 + arg_137_0 then
				arg_134_1.var_.moveOldPos1033 = var_137_23.localPosition
				var_137_23.localScale = Vector3.New(1, 1, 1)

				arg_134_1:CheckSpriteTmpPos("1033", 4)

				local var_137_25 = var_137_23.childCount

				for iter_137_9 = 0, var_137_25 - 1 do
					local var_137_26 = var_137_23:GetChild(iter_137_9)

					if var_137_26.name == "split_6" or not string.find(var_137_26.name, "split") then
						var_137_26.gameObject:SetActive(true)
					else
						var_137_26.gameObject:SetActive(false)
					end
				end
			end

			local var_137_27 = 0.001

			if var_137_24 <= arg_134_1.time_ and arg_134_1.time_ < var_137_24 + var_137_27 then
				local var_137_28 = (arg_134_1.time_ - var_137_24) / var_137_27
				local var_137_29 = Vector3.New(390, -420, 0)

				var_137_23.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1033, var_137_29, var_137_28)
			end

			if arg_134_1.time_ >= var_137_24 + var_137_27 and arg_134_1.time_ < var_137_24 + var_137_27 + arg_137_0 then
				var_137_23.localPosition = Vector3.New(390, -420, 0)
			end

			local var_137_30 = 0
			local var_137_31 = 0.8

			if var_137_30 < arg_134_1.time_ and arg_134_1.time_ <= var_137_30 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_32 = arg_134_1:FormatText(StoryNameCfg[236].name)

				arg_134_1.leftNameTxt_.text = var_137_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_33 = arg_134_1:GetWordFromCfg(416051031)
				local var_137_34 = arg_134_1:FormatText(var_137_33.content)

				arg_134_1.text_.text = var_137_34

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_35 = 32
				local var_137_36 = utf8.len(var_137_34)
				local var_137_37 = var_137_35 <= 0 and var_137_31 or var_137_31 * (var_137_36 / var_137_35)

				if var_137_37 > 0 and var_137_31 < var_137_37 then
					arg_134_1.talkMaxDuration = var_137_37

					if var_137_37 + var_137_30 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_37 + var_137_30
					end
				end

				arg_134_1.text_.text = var_137_34
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051031", "story_v_out_416051.awb") ~= 0 then
					local var_137_38 = manager.audio:GetVoiceLength("story_v_out_416051", "416051031", "story_v_out_416051.awb") / 1000

					if var_137_38 + var_137_30 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_38 + var_137_30
					end

					if var_137_33.prefab_name ~= "" and arg_134_1.actors_[var_137_33.prefab_name] ~= nil then
						local var_137_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_33.prefab_name].transform, "story_v_out_416051", "416051031", "story_v_out_416051.awb")

						arg_134_1:RecordAudio("416051031", var_137_39)
						arg_134_1:RecordAudio("416051031", var_137_39)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_416051", "416051031", "story_v_out_416051.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_416051", "416051031", "story_v_out_416051.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_40 = math.max(var_137_31, arg_134_1.talkMaxDuration)

			if var_137_30 <= arg_134_1.time_ and arg_134_1.time_ < var_137_30 + var_137_40 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_30) / var_137_40

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_30 + var_137_40 and arg_134_1.time_ < var_137_30 + var_137_40 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play416051032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 416051032
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play416051033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["10054"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.actorSpriteComps10054 == nil then
				arg_138_1.var_.actorSpriteComps10054 = var_141_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_2 = 0.125

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.actorSpriteComps10054 then
					for iter_141_0, iter_141_1 in pairs(arg_138_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_141_1 then
							if arg_138_1.isInRecall_ then
								local var_141_4 = Mathf.Lerp(iter_141_1.color.r, arg_138_1.hightColor2.r, var_141_3)
								local var_141_5 = Mathf.Lerp(iter_141_1.color.g, arg_138_1.hightColor2.g, var_141_3)
								local var_141_6 = Mathf.Lerp(iter_141_1.color.b, arg_138_1.hightColor2.b, var_141_3)

								iter_141_1.color = Color.New(var_141_4, var_141_5, var_141_6)
							else
								local var_141_7 = Mathf.Lerp(iter_141_1.color.r, 0.5, var_141_3)

								iter_141_1.color = Color.New(var_141_7, var_141_7, var_141_7)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.actorSpriteComps10054 then
				for iter_141_2, iter_141_3 in pairs(arg_138_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_141_3 then
						if arg_138_1.isInRecall_ then
							iter_141_3.color = arg_138_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_141_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_138_1.var_.actorSpriteComps10054 = nil
			end

			local var_141_8 = arg_138_1.actors_["1033"]
			local var_141_9 = 0

			if var_141_9 < arg_138_1.time_ and arg_138_1.time_ <= var_141_9 + arg_141_0 and not isNil(var_141_8) and arg_138_1.var_.actorSpriteComps1033 == nil then
				arg_138_1.var_.actorSpriteComps1033 = var_141_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_10 = 0.125

			if var_141_9 <= arg_138_1.time_ and arg_138_1.time_ < var_141_9 + var_141_10 and not isNil(var_141_8) then
				local var_141_11 = (arg_138_1.time_ - var_141_9) / var_141_10

				if arg_138_1.var_.actorSpriteComps1033 then
					for iter_141_4, iter_141_5 in pairs(arg_138_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_141_5 then
							if arg_138_1.isInRecall_ then
								local var_141_12 = Mathf.Lerp(iter_141_5.color.r, arg_138_1.hightColor2.r, var_141_11)
								local var_141_13 = Mathf.Lerp(iter_141_5.color.g, arg_138_1.hightColor2.g, var_141_11)
								local var_141_14 = Mathf.Lerp(iter_141_5.color.b, arg_138_1.hightColor2.b, var_141_11)

								iter_141_5.color = Color.New(var_141_12, var_141_13, var_141_14)
							else
								local var_141_15 = Mathf.Lerp(iter_141_5.color.r, 0.5, var_141_11)

								iter_141_5.color = Color.New(var_141_15, var_141_15, var_141_15)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= var_141_9 + var_141_10 and arg_138_1.time_ < var_141_9 + var_141_10 + arg_141_0 and not isNil(var_141_8) and arg_138_1.var_.actorSpriteComps1033 then
				for iter_141_6, iter_141_7 in pairs(arg_138_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_141_7 then
						if arg_138_1.isInRecall_ then
							iter_141_7.color = arg_138_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_141_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_138_1.var_.actorSpriteComps1033 = nil
			end

			local var_141_16 = 0
			local var_141_17 = 1.575

			if var_141_16 < arg_138_1.time_ and arg_138_1.time_ <= var_141_16 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_18 = arg_138_1:GetWordFromCfg(416051032)
				local var_141_19 = arg_138_1:FormatText(var_141_18.content)

				arg_138_1.text_.text = var_141_19

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_20 = 63
				local var_141_21 = utf8.len(var_141_19)
				local var_141_22 = var_141_20 <= 0 and var_141_17 or var_141_17 * (var_141_21 / var_141_20)

				if var_141_22 > 0 and var_141_17 < var_141_22 then
					arg_138_1.talkMaxDuration = var_141_22

					if var_141_22 + var_141_16 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_22 + var_141_16
					end
				end

				arg_138_1.text_.text = var_141_19
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_23 = math.max(var_141_17, arg_138_1.talkMaxDuration)

			if var_141_16 <= arg_138_1.time_ and arg_138_1.time_ < var_141_16 + var_141_23 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_16) / var_141_23

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_16 + var_141_23 and arg_138_1.time_ < var_141_16 + var_141_23 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play416051033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 416051033
		arg_142_1.duration_ = 5.5

		local var_142_0 = {
			zh = 4.133,
			ja = 5.5
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play416051034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["10054"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.actorSpriteComps10054 == nil then
				arg_142_1.var_.actorSpriteComps10054 = var_145_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_145_2 = 0.125

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.actorSpriteComps10054 then
					for iter_145_0, iter_145_1 in pairs(arg_142_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_145_1 then
							if arg_142_1.isInRecall_ then
								local var_145_4 = Mathf.Lerp(iter_145_1.color.r, arg_142_1.hightColor1.r, var_145_3)
								local var_145_5 = Mathf.Lerp(iter_145_1.color.g, arg_142_1.hightColor1.g, var_145_3)
								local var_145_6 = Mathf.Lerp(iter_145_1.color.b, arg_142_1.hightColor1.b, var_145_3)

								iter_145_1.color = Color.New(var_145_4, var_145_5, var_145_6)
							else
								local var_145_7 = Mathf.Lerp(iter_145_1.color.r, 1, var_145_3)

								iter_145_1.color = Color.New(var_145_7, var_145_7, var_145_7)
							end
						end
					end
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.actorSpriteComps10054 then
				for iter_145_2, iter_145_3 in pairs(arg_142_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_145_3 then
						if arg_142_1.isInRecall_ then
							iter_145_3.color = arg_142_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_145_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_142_1.var_.actorSpriteComps10054 = nil
			end

			local var_145_8 = arg_142_1.actors_["1033"]
			local var_145_9 = 0

			if var_145_9 < arg_142_1.time_ and arg_142_1.time_ <= var_145_9 + arg_145_0 and not isNil(var_145_8) and arg_142_1.var_.actorSpriteComps1033 == nil then
				arg_142_1.var_.actorSpriteComps1033 = var_145_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_145_10 = 0.125

			if var_145_9 <= arg_142_1.time_ and arg_142_1.time_ < var_145_9 + var_145_10 and not isNil(var_145_8) then
				local var_145_11 = (arg_142_1.time_ - var_145_9) / var_145_10

				if arg_142_1.var_.actorSpriteComps1033 then
					for iter_145_4, iter_145_5 in pairs(arg_142_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_145_5 then
							if arg_142_1.isInRecall_ then
								local var_145_12 = Mathf.Lerp(iter_145_5.color.r, arg_142_1.hightColor2.r, var_145_11)
								local var_145_13 = Mathf.Lerp(iter_145_5.color.g, arg_142_1.hightColor2.g, var_145_11)
								local var_145_14 = Mathf.Lerp(iter_145_5.color.b, arg_142_1.hightColor2.b, var_145_11)

								iter_145_5.color = Color.New(var_145_12, var_145_13, var_145_14)
							else
								local var_145_15 = Mathf.Lerp(iter_145_5.color.r, 0.5, var_145_11)

								iter_145_5.color = Color.New(var_145_15, var_145_15, var_145_15)
							end
						end
					end
				end
			end

			if arg_142_1.time_ >= var_145_9 + var_145_10 and arg_142_1.time_ < var_145_9 + var_145_10 + arg_145_0 and not isNil(var_145_8) and arg_142_1.var_.actorSpriteComps1033 then
				for iter_145_6, iter_145_7 in pairs(arg_142_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_145_7 then
						if arg_142_1.isInRecall_ then
							iter_145_7.color = arg_142_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_145_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_142_1.var_.actorSpriteComps1033 = nil
			end

			local var_145_16 = 0
			local var_145_17 = 0.525

			if var_145_16 < arg_142_1.time_ and arg_142_1.time_ <= var_145_16 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_18 = arg_142_1:FormatText(StoryNameCfg[487].name)

				arg_142_1.leftNameTxt_.text = var_145_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_19 = arg_142_1:GetWordFromCfg(416051033)
				local var_145_20 = arg_142_1:FormatText(var_145_19.content)

				arg_142_1.text_.text = var_145_20

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_21 = 21
				local var_145_22 = utf8.len(var_145_20)
				local var_145_23 = var_145_21 <= 0 and var_145_17 or var_145_17 * (var_145_22 / var_145_21)

				if var_145_23 > 0 and var_145_17 < var_145_23 then
					arg_142_1.talkMaxDuration = var_145_23

					if var_145_23 + var_145_16 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_23 + var_145_16
					end
				end

				arg_142_1.text_.text = var_145_20
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051033", "story_v_out_416051.awb") ~= 0 then
					local var_145_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051033", "story_v_out_416051.awb") / 1000

					if var_145_24 + var_145_16 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_24 + var_145_16
					end

					if var_145_19.prefab_name ~= "" and arg_142_1.actors_[var_145_19.prefab_name] ~= nil then
						local var_145_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_19.prefab_name].transform, "story_v_out_416051", "416051033", "story_v_out_416051.awb")

						arg_142_1:RecordAudio("416051033", var_145_25)
						arg_142_1:RecordAudio("416051033", var_145_25)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_416051", "416051033", "story_v_out_416051.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_416051", "416051033", "story_v_out_416051.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_26 = math.max(var_145_17, arg_142_1.talkMaxDuration)

			if var_145_16 <= arg_142_1.time_ and arg_142_1.time_ < var_145_16 + var_145_26 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_16) / var_145_26

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_16 + var_145_26 and arg_142_1.time_ < var_145_16 + var_145_26 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play416051034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 416051034
		arg_146_1.duration_ = 5.2

		local var_146_0 = {
			zh = 2.533,
			ja = 5.2
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play416051035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["10054"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.actorSpriteComps10054 == nil then
				arg_146_1.var_.actorSpriteComps10054 = var_149_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_2 = 0.125

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.actorSpriteComps10054 then
					for iter_149_0, iter_149_1 in pairs(arg_146_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_149_1 then
							if arg_146_1.isInRecall_ then
								local var_149_4 = Mathf.Lerp(iter_149_1.color.r, arg_146_1.hightColor2.r, var_149_3)
								local var_149_5 = Mathf.Lerp(iter_149_1.color.g, arg_146_1.hightColor2.g, var_149_3)
								local var_149_6 = Mathf.Lerp(iter_149_1.color.b, arg_146_1.hightColor2.b, var_149_3)

								iter_149_1.color = Color.New(var_149_4, var_149_5, var_149_6)
							else
								local var_149_7 = Mathf.Lerp(iter_149_1.color.r, 0.5, var_149_3)

								iter_149_1.color = Color.New(var_149_7, var_149_7, var_149_7)
							end
						end
					end
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.actorSpriteComps10054 then
				for iter_149_2, iter_149_3 in pairs(arg_146_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_149_3 then
						if arg_146_1.isInRecall_ then
							iter_149_3.color = arg_146_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_149_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_146_1.var_.actorSpriteComps10054 = nil
			end

			local var_149_8 = arg_146_1.actors_["1033"]
			local var_149_9 = 0

			if var_149_9 < arg_146_1.time_ and arg_146_1.time_ <= var_149_9 + arg_149_0 and not isNil(var_149_8) and arg_146_1.var_.actorSpriteComps1033 == nil then
				arg_146_1.var_.actorSpriteComps1033 = var_149_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_10 = 0.125

			if var_149_9 <= arg_146_1.time_ and arg_146_1.time_ < var_149_9 + var_149_10 and not isNil(var_149_8) then
				local var_149_11 = (arg_146_1.time_ - var_149_9) / var_149_10

				if arg_146_1.var_.actorSpriteComps1033 then
					for iter_149_4, iter_149_5 in pairs(arg_146_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_149_5 then
							if arg_146_1.isInRecall_ then
								local var_149_12 = Mathf.Lerp(iter_149_5.color.r, arg_146_1.hightColor1.r, var_149_11)
								local var_149_13 = Mathf.Lerp(iter_149_5.color.g, arg_146_1.hightColor1.g, var_149_11)
								local var_149_14 = Mathf.Lerp(iter_149_5.color.b, arg_146_1.hightColor1.b, var_149_11)

								iter_149_5.color = Color.New(var_149_12, var_149_13, var_149_14)
							else
								local var_149_15 = Mathf.Lerp(iter_149_5.color.r, 1, var_149_11)

								iter_149_5.color = Color.New(var_149_15, var_149_15, var_149_15)
							end
						end
					end
				end
			end

			if arg_146_1.time_ >= var_149_9 + var_149_10 and arg_146_1.time_ < var_149_9 + var_149_10 + arg_149_0 and not isNil(var_149_8) and arg_146_1.var_.actorSpriteComps1033 then
				for iter_149_6, iter_149_7 in pairs(arg_146_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_149_7 then
						if arg_146_1.isInRecall_ then
							iter_149_7.color = arg_146_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_149_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_146_1.var_.actorSpriteComps1033 = nil
			end

			local var_149_16 = 0
			local var_149_17 = 0.375

			if var_149_16 < arg_146_1.time_ and arg_146_1.time_ <= var_149_16 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_18 = arg_146_1:FormatText(StoryNameCfg[236].name)

				arg_146_1.leftNameTxt_.text = var_149_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_19 = arg_146_1:GetWordFromCfg(416051034)
				local var_149_20 = arg_146_1:FormatText(var_149_19.content)

				arg_146_1.text_.text = var_149_20

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_21 = 15
				local var_149_22 = utf8.len(var_149_20)
				local var_149_23 = var_149_21 <= 0 and var_149_17 or var_149_17 * (var_149_22 / var_149_21)

				if var_149_23 > 0 and var_149_17 < var_149_23 then
					arg_146_1.talkMaxDuration = var_149_23

					if var_149_23 + var_149_16 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_23 + var_149_16
					end
				end

				arg_146_1.text_.text = var_149_20
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051034", "story_v_out_416051.awb") ~= 0 then
					local var_149_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051034", "story_v_out_416051.awb") / 1000

					if var_149_24 + var_149_16 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_24 + var_149_16
					end

					if var_149_19.prefab_name ~= "" and arg_146_1.actors_[var_149_19.prefab_name] ~= nil then
						local var_149_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_19.prefab_name].transform, "story_v_out_416051", "416051034", "story_v_out_416051.awb")

						arg_146_1:RecordAudio("416051034", var_149_25)
						arg_146_1:RecordAudio("416051034", var_149_25)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_416051", "416051034", "story_v_out_416051.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_416051", "416051034", "story_v_out_416051.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_26 = math.max(var_149_17, arg_146_1.talkMaxDuration)

			if var_149_16 <= arg_146_1.time_ and arg_146_1.time_ < var_149_16 + var_149_26 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_16) / var_149_26

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_16 + var_149_26 and arg_146_1.time_ < var_149_16 + var_149_26 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play416051035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 416051035
		arg_150_1.duration_ = 4.1

		local var_150_0 = {
			zh = 1.733,
			ja = 4.1
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play416051036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["10054"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.actorSpriteComps10054 == nil then
				arg_150_1.var_.actorSpriteComps10054 = var_153_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_2 = 0.125

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.actorSpriteComps10054 then
					for iter_153_0, iter_153_1 in pairs(arg_150_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_153_1 then
							if arg_150_1.isInRecall_ then
								local var_153_4 = Mathf.Lerp(iter_153_1.color.r, arg_150_1.hightColor1.r, var_153_3)
								local var_153_5 = Mathf.Lerp(iter_153_1.color.g, arg_150_1.hightColor1.g, var_153_3)
								local var_153_6 = Mathf.Lerp(iter_153_1.color.b, arg_150_1.hightColor1.b, var_153_3)

								iter_153_1.color = Color.New(var_153_4, var_153_5, var_153_6)
							else
								local var_153_7 = Mathf.Lerp(iter_153_1.color.r, 1, var_153_3)

								iter_153_1.color = Color.New(var_153_7, var_153_7, var_153_7)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.actorSpriteComps10054 then
				for iter_153_2, iter_153_3 in pairs(arg_150_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_153_3 then
						if arg_150_1.isInRecall_ then
							iter_153_3.color = arg_150_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_153_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_150_1.var_.actorSpriteComps10054 = nil
			end

			local var_153_8 = arg_150_1.actors_["1033"]
			local var_153_9 = 0

			if var_153_9 < arg_150_1.time_ and arg_150_1.time_ <= var_153_9 + arg_153_0 and not isNil(var_153_8) and arg_150_1.var_.actorSpriteComps1033 == nil then
				arg_150_1.var_.actorSpriteComps1033 = var_153_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_10 = 0.125

			if var_153_9 <= arg_150_1.time_ and arg_150_1.time_ < var_153_9 + var_153_10 and not isNil(var_153_8) then
				local var_153_11 = (arg_150_1.time_ - var_153_9) / var_153_10

				if arg_150_1.var_.actorSpriteComps1033 then
					for iter_153_4, iter_153_5 in pairs(arg_150_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_153_5 then
							if arg_150_1.isInRecall_ then
								local var_153_12 = Mathf.Lerp(iter_153_5.color.r, arg_150_1.hightColor2.r, var_153_11)
								local var_153_13 = Mathf.Lerp(iter_153_5.color.g, arg_150_1.hightColor2.g, var_153_11)
								local var_153_14 = Mathf.Lerp(iter_153_5.color.b, arg_150_1.hightColor2.b, var_153_11)

								iter_153_5.color = Color.New(var_153_12, var_153_13, var_153_14)
							else
								local var_153_15 = Mathf.Lerp(iter_153_5.color.r, 0.5, var_153_11)

								iter_153_5.color = Color.New(var_153_15, var_153_15, var_153_15)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= var_153_9 + var_153_10 and arg_150_1.time_ < var_153_9 + var_153_10 + arg_153_0 and not isNil(var_153_8) and arg_150_1.var_.actorSpriteComps1033 then
				for iter_153_6, iter_153_7 in pairs(arg_150_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_153_7 then
						if arg_150_1.isInRecall_ then
							iter_153_7.color = arg_150_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_153_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_150_1.var_.actorSpriteComps1033 = nil
			end

			local var_153_16 = 0
			local var_153_17 = 0.225

			if var_153_16 < arg_150_1.time_ and arg_150_1.time_ <= var_153_16 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_18 = arg_150_1:FormatText(StoryNameCfg[487].name)

				arg_150_1.leftNameTxt_.text = var_153_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_19 = arg_150_1:GetWordFromCfg(416051035)
				local var_153_20 = arg_150_1:FormatText(var_153_19.content)

				arg_150_1.text_.text = var_153_20

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_21 = 9
				local var_153_22 = utf8.len(var_153_20)
				local var_153_23 = var_153_21 <= 0 and var_153_17 or var_153_17 * (var_153_22 / var_153_21)

				if var_153_23 > 0 and var_153_17 < var_153_23 then
					arg_150_1.talkMaxDuration = var_153_23

					if var_153_23 + var_153_16 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_23 + var_153_16
					end
				end

				arg_150_1.text_.text = var_153_20
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051035", "story_v_out_416051.awb") ~= 0 then
					local var_153_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051035", "story_v_out_416051.awb") / 1000

					if var_153_24 + var_153_16 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_24 + var_153_16
					end

					if var_153_19.prefab_name ~= "" and arg_150_1.actors_[var_153_19.prefab_name] ~= nil then
						local var_153_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_19.prefab_name].transform, "story_v_out_416051", "416051035", "story_v_out_416051.awb")

						arg_150_1:RecordAudio("416051035", var_153_25)
						arg_150_1:RecordAudio("416051035", var_153_25)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_416051", "416051035", "story_v_out_416051.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_416051", "416051035", "story_v_out_416051.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_26 = math.max(var_153_17, arg_150_1.talkMaxDuration)

			if var_153_16 <= arg_150_1.time_ and arg_150_1.time_ < var_153_16 + var_153_26 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_16) / var_153_26

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_16 + var_153_26 and arg_150_1.time_ < var_153_16 + var_153_26 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play416051036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 416051036
		arg_154_1.duration_ = 10.47

		local var_154_0 = {
			zh = 7.133,
			ja = 10.466
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play416051037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["10054"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.actorSpriteComps10054 == nil then
				arg_154_1.var_.actorSpriteComps10054 = var_157_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_2 = 0.125

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.actorSpriteComps10054 then
					for iter_157_0, iter_157_1 in pairs(arg_154_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_157_1 then
							if arg_154_1.isInRecall_ then
								local var_157_4 = Mathf.Lerp(iter_157_1.color.r, arg_154_1.hightColor2.r, var_157_3)
								local var_157_5 = Mathf.Lerp(iter_157_1.color.g, arg_154_1.hightColor2.g, var_157_3)
								local var_157_6 = Mathf.Lerp(iter_157_1.color.b, arg_154_1.hightColor2.b, var_157_3)

								iter_157_1.color = Color.New(var_157_4, var_157_5, var_157_6)
							else
								local var_157_7 = Mathf.Lerp(iter_157_1.color.r, 0.5, var_157_3)

								iter_157_1.color = Color.New(var_157_7, var_157_7, var_157_7)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.actorSpriteComps10054 then
				for iter_157_2, iter_157_3 in pairs(arg_154_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_157_3 then
						if arg_154_1.isInRecall_ then
							iter_157_3.color = arg_154_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_157_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_154_1.var_.actorSpriteComps10054 = nil
			end

			local var_157_8 = arg_154_1.actors_["1033"]
			local var_157_9 = 0

			if var_157_9 < arg_154_1.time_ and arg_154_1.time_ <= var_157_9 + arg_157_0 and not isNil(var_157_8) and arg_154_1.var_.actorSpriteComps1033 == nil then
				arg_154_1.var_.actorSpriteComps1033 = var_157_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_10 = 0.125

			if var_157_9 <= arg_154_1.time_ and arg_154_1.time_ < var_157_9 + var_157_10 and not isNil(var_157_8) then
				local var_157_11 = (arg_154_1.time_ - var_157_9) / var_157_10

				if arg_154_1.var_.actorSpriteComps1033 then
					for iter_157_4, iter_157_5 in pairs(arg_154_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_157_5 then
							if arg_154_1.isInRecall_ then
								local var_157_12 = Mathf.Lerp(iter_157_5.color.r, arg_154_1.hightColor1.r, var_157_11)
								local var_157_13 = Mathf.Lerp(iter_157_5.color.g, arg_154_1.hightColor1.g, var_157_11)
								local var_157_14 = Mathf.Lerp(iter_157_5.color.b, arg_154_1.hightColor1.b, var_157_11)

								iter_157_5.color = Color.New(var_157_12, var_157_13, var_157_14)
							else
								local var_157_15 = Mathf.Lerp(iter_157_5.color.r, 1, var_157_11)

								iter_157_5.color = Color.New(var_157_15, var_157_15, var_157_15)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= var_157_9 + var_157_10 and arg_154_1.time_ < var_157_9 + var_157_10 + arg_157_0 and not isNil(var_157_8) and arg_154_1.var_.actorSpriteComps1033 then
				for iter_157_6, iter_157_7 in pairs(arg_154_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_157_7 then
						if arg_154_1.isInRecall_ then
							iter_157_7.color = arg_154_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_157_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_154_1.var_.actorSpriteComps1033 = nil
			end

			local var_157_16 = 0
			local var_157_17 = 1

			if var_157_16 < arg_154_1.time_ and arg_154_1.time_ <= var_157_16 + arg_157_0 then
				local var_157_18 = "play"
				local var_157_19 = "effect"

				arg_154_1:AudioAction(var_157_18, var_157_19, "se_story_17", "se_story_17_messenger03", "")
			end

			local var_157_20 = 0
			local var_157_21 = 0.875

			if var_157_20 < arg_154_1.time_ and arg_154_1.time_ <= var_157_20 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_22 = arg_154_1:FormatText(StoryNameCfg[236].name)

				arg_154_1.leftNameTxt_.text = var_157_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_23 = arg_154_1:GetWordFromCfg(416051036)
				local var_157_24 = arg_154_1:FormatText(var_157_23.content)

				arg_154_1.text_.text = var_157_24

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_25 = 35
				local var_157_26 = utf8.len(var_157_24)
				local var_157_27 = var_157_25 <= 0 and var_157_21 or var_157_21 * (var_157_26 / var_157_25)

				if var_157_27 > 0 and var_157_21 < var_157_27 then
					arg_154_1.talkMaxDuration = var_157_27

					if var_157_27 + var_157_20 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_27 + var_157_20
					end
				end

				arg_154_1.text_.text = var_157_24
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051036", "story_v_out_416051.awb") ~= 0 then
					local var_157_28 = manager.audio:GetVoiceLength("story_v_out_416051", "416051036", "story_v_out_416051.awb") / 1000

					if var_157_28 + var_157_20 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_28 + var_157_20
					end

					if var_157_23.prefab_name ~= "" and arg_154_1.actors_[var_157_23.prefab_name] ~= nil then
						local var_157_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_23.prefab_name].transform, "story_v_out_416051", "416051036", "story_v_out_416051.awb")

						arg_154_1:RecordAudio("416051036", var_157_29)
						arg_154_1:RecordAudio("416051036", var_157_29)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_416051", "416051036", "story_v_out_416051.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_416051", "416051036", "story_v_out_416051.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_30 = math.max(var_157_21, arg_154_1.talkMaxDuration)

			if var_157_20 <= arg_154_1.time_ and arg_154_1.time_ < var_157_20 + var_157_30 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_20) / var_157_30

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_20 + var_157_30 and arg_154_1.time_ < var_157_20 + var_157_30 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play416051037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 416051037
		arg_158_1.duration_ = 5.87

		local var_158_0 = {
			zh = 5.766,
			ja = 5.866
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play416051038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0
			local var_161_1 = 0.8

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_2 = arg_158_1:FormatText(StoryNameCfg[236].name)

				arg_158_1.leftNameTxt_.text = var_161_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_3 = arg_158_1:GetWordFromCfg(416051037)
				local var_161_4 = arg_158_1:FormatText(var_161_3.content)

				arg_158_1.text_.text = var_161_4

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_5 = 32
				local var_161_6 = utf8.len(var_161_4)
				local var_161_7 = var_161_5 <= 0 and var_161_1 or var_161_1 * (var_161_6 / var_161_5)

				if var_161_7 > 0 and var_161_1 < var_161_7 then
					arg_158_1.talkMaxDuration = var_161_7

					if var_161_7 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_7 + var_161_0
					end
				end

				arg_158_1.text_.text = var_161_4
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051037", "story_v_out_416051.awb") ~= 0 then
					local var_161_8 = manager.audio:GetVoiceLength("story_v_out_416051", "416051037", "story_v_out_416051.awb") / 1000

					if var_161_8 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_8 + var_161_0
					end

					if var_161_3.prefab_name ~= "" and arg_158_1.actors_[var_161_3.prefab_name] ~= nil then
						local var_161_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_3.prefab_name].transform, "story_v_out_416051", "416051037", "story_v_out_416051.awb")

						arg_158_1:RecordAudio("416051037", var_161_9)
						arg_158_1:RecordAudio("416051037", var_161_9)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_416051", "416051037", "story_v_out_416051.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_416051", "416051037", "story_v_out_416051.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_10 = math.max(var_161_1, arg_158_1.talkMaxDuration)

			if var_161_0 <= arg_158_1.time_ and arg_158_1.time_ < var_161_0 + var_161_10 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_0) / var_161_10

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_0 + var_161_10 and arg_158_1.time_ < var_161_0 + var_161_10 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play416051038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 416051038
		arg_162_1.duration_ = 4.67

		local var_162_0 = {
			zh = 4.6,
			ja = 4.666
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play416051039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0
			local var_165_1 = 1

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				local var_165_2 = "play"
				local var_165_3 = "effect"

				arg_162_1:AudioAction(var_165_2, var_165_3, "se_story_17", "se_story_17_messenger03", "")
			end

			local var_165_4 = 0
			local var_165_5 = 0.675

			if var_165_4 < arg_162_1.time_ and arg_162_1.time_ <= var_165_4 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_6 = arg_162_1:FormatText(StoryNameCfg[236].name)

				arg_162_1.leftNameTxt_.text = var_165_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_7 = arg_162_1:GetWordFromCfg(416051038)
				local var_165_8 = arg_162_1:FormatText(var_165_7.content)

				arg_162_1.text_.text = var_165_8

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_9 = 27
				local var_165_10 = utf8.len(var_165_8)
				local var_165_11 = var_165_9 <= 0 and var_165_5 or var_165_5 * (var_165_10 / var_165_9)

				if var_165_11 > 0 and var_165_5 < var_165_11 then
					arg_162_1.talkMaxDuration = var_165_11

					if var_165_11 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_11 + var_165_4
					end
				end

				arg_162_1.text_.text = var_165_8
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051038", "story_v_out_416051.awb") ~= 0 then
					local var_165_12 = manager.audio:GetVoiceLength("story_v_out_416051", "416051038", "story_v_out_416051.awb") / 1000

					if var_165_12 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_12 + var_165_4
					end

					if var_165_7.prefab_name ~= "" and arg_162_1.actors_[var_165_7.prefab_name] ~= nil then
						local var_165_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_7.prefab_name].transform, "story_v_out_416051", "416051038", "story_v_out_416051.awb")

						arg_162_1:RecordAudio("416051038", var_165_13)
						arg_162_1:RecordAudio("416051038", var_165_13)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_416051", "416051038", "story_v_out_416051.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_416051", "416051038", "story_v_out_416051.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_14 = math.max(var_165_5, arg_162_1.talkMaxDuration)

			if var_165_4 <= arg_162_1.time_ and arg_162_1.time_ < var_165_4 + var_165_14 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_4) / var_165_14

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_4 + var_165_14 and arg_162_1.time_ < var_165_4 + var_165_14 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play416051039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 416051039
		arg_166_1.duration_ = 8.43

		local var_166_0 = {
			zh = 7.3,
			ja = 8.433
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play416051040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 4

			if var_169_0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				arg_166_1.allBtn_.enabled = false
			end

			local var_169_1 = 0.133333333333334

			if arg_166_1.time_ >= var_169_0 + var_169_1 and arg_166_1.time_ < var_169_0 + var_169_1 + arg_169_0 then
				arg_166_1.allBtn_.enabled = true
			end

			local var_169_2 = "ST0106"

			if arg_166_1.bgs_[var_169_2] == nil then
				local var_169_3 = Object.Instantiate(arg_166_1.paintGo_)

				var_169_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_169_2)
				var_169_3.name = var_169_2
				var_169_3.transform.parent = arg_166_1.stage_.transform
				var_169_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_166_1.bgs_[var_169_2] = var_169_3
			end

			local var_169_4 = 2

			if var_169_4 < arg_166_1.time_ and arg_166_1.time_ <= var_169_4 + arg_169_0 then
				local var_169_5 = manager.ui.mainCamera.transform.localPosition
				local var_169_6 = Vector3.New(0, 0, 10) + Vector3.New(var_169_5.x, var_169_5.y, 0)
				local var_169_7 = arg_166_1.bgs_.ST0106

				var_169_7.transform.localPosition = var_169_6
				var_169_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_169_8 = var_169_7:GetComponent("SpriteRenderer")

				if var_169_8 and var_169_8.sprite then
					local var_169_9 = (var_169_7.transform.localPosition - var_169_5).z
					local var_169_10 = manager.ui.mainCameraCom_
					local var_169_11 = 2 * var_169_9 * Mathf.Tan(var_169_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_169_12 = var_169_11 * var_169_10.aspect
					local var_169_13 = var_169_8.sprite.bounds.size.x
					local var_169_14 = var_169_8.sprite.bounds.size.y
					local var_169_15 = var_169_12 / var_169_13
					local var_169_16 = var_169_11 / var_169_14
					local var_169_17 = var_169_16 < var_169_15 and var_169_15 or var_169_16

					var_169_7.transform.localScale = Vector3.New(var_169_17, var_169_17, 0)
				end

				for iter_169_0, iter_169_1 in pairs(arg_166_1.bgs_) do
					if iter_169_0 ~= "ST0106" then
						iter_169_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_169_18 = 0

			if var_169_18 < arg_166_1.time_ and arg_166_1.time_ <= var_169_18 + arg_169_0 then
				arg_166_1.mask_.enabled = true
				arg_166_1.mask_.raycastTarget = true

				arg_166_1:SetGaussion(false)
			end

			local var_169_19 = 2

			if var_169_18 <= arg_166_1.time_ and arg_166_1.time_ < var_169_18 + var_169_19 then
				local var_169_20 = (arg_166_1.time_ - var_169_18) / var_169_19
				local var_169_21 = Color.New(0, 0, 0)

				var_169_21.a = Mathf.Lerp(0, 1, var_169_20)
				arg_166_1.mask_.color = var_169_21
			end

			if arg_166_1.time_ >= var_169_18 + var_169_19 and arg_166_1.time_ < var_169_18 + var_169_19 + arg_169_0 then
				local var_169_22 = Color.New(0, 0, 0)

				var_169_22.a = 1
				arg_166_1.mask_.color = var_169_22
			end

			local var_169_23 = 2

			if var_169_23 < arg_166_1.time_ and arg_166_1.time_ <= var_169_23 + arg_169_0 then
				arg_166_1.mask_.enabled = true
				arg_166_1.mask_.raycastTarget = true

				arg_166_1:SetGaussion(false)
			end

			local var_169_24 = 2

			if var_169_23 <= arg_166_1.time_ and arg_166_1.time_ < var_169_23 + var_169_24 then
				local var_169_25 = (arg_166_1.time_ - var_169_23) / var_169_24
				local var_169_26 = Color.New(0, 0, 0)

				var_169_26.a = Mathf.Lerp(1, 0, var_169_25)
				arg_166_1.mask_.color = var_169_26
			end

			if arg_166_1.time_ >= var_169_23 + var_169_24 and arg_166_1.time_ < var_169_23 + var_169_24 + arg_169_0 then
				local var_169_27 = Color.New(0, 0, 0)
				local var_169_28 = 0

				arg_166_1.mask_.enabled = false
				var_169_27.a = var_169_28
				arg_166_1.mask_.color = var_169_27
			end

			local var_169_29 = arg_166_1.actors_["1033"].transform
			local var_169_30 = 1.966

			if var_169_30 < arg_166_1.time_ and arg_166_1.time_ <= var_169_30 + arg_169_0 then
				arg_166_1.var_.moveOldPos1033 = var_169_29.localPosition
				var_169_29.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("1033", 7)

				local var_169_31 = var_169_29.childCount

				for iter_169_2 = 0, var_169_31 - 1 do
					local var_169_32 = var_169_29:GetChild(iter_169_2)

					if var_169_32.name == "" or not string.find(var_169_32.name, "split") then
						var_169_32.gameObject:SetActive(true)
					else
						var_169_32.gameObject:SetActive(false)
					end
				end
			end

			local var_169_33 = 0.001

			if var_169_30 <= arg_166_1.time_ and arg_166_1.time_ < var_169_30 + var_169_33 then
				local var_169_34 = (arg_166_1.time_ - var_169_30) / var_169_33
				local var_169_35 = Vector3.New(0, -2000, 0)

				var_169_29.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1033, var_169_35, var_169_34)
			end

			if arg_166_1.time_ >= var_169_30 + var_169_33 and arg_166_1.time_ < var_169_30 + var_169_33 + arg_169_0 then
				var_169_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_169_36 = arg_166_1.actors_["10054"].transform
			local var_169_37 = 1.966

			if var_169_37 < arg_166_1.time_ and arg_166_1.time_ <= var_169_37 + arg_169_0 then
				arg_166_1.var_.moveOldPos10054 = var_169_36.localPosition
				var_169_36.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("10054", 7)

				local var_169_38 = var_169_36.childCount

				for iter_169_3 = 0, var_169_38 - 1 do
					local var_169_39 = var_169_36:GetChild(iter_169_3)

					if var_169_39.name == "" or not string.find(var_169_39.name, "split") then
						var_169_39.gameObject:SetActive(true)
					else
						var_169_39.gameObject:SetActive(false)
					end
				end
			end

			local var_169_40 = 0.001

			if var_169_37 <= arg_166_1.time_ and arg_166_1.time_ < var_169_37 + var_169_40 then
				local var_169_41 = (arg_166_1.time_ - var_169_37) / var_169_40
				local var_169_42 = Vector3.New(0, -2000, 0)

				var_169_36.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10054, var_169_42, var_169_41)
			end

			if arg_166_1.time_ >= var_169_37 + var_169_40 and arg_166_1.time_ < var_169_37 + var_169_40 + arg_169_0 then
				var_169_36.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_169_43 = "1028"

			if arg_166_1.actors_[var_169_43] == nil then
				local var_169_44 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1028")

				if not isNil(var_169_44) then
					local var_169_45 = Object.Instantiate(var_169_44, arg_166_1.canvasGo_.transform)

					var_169_45.transform:SetSiblingIndex(1)

					var_169_45.name = var_169_43
					var_169_45.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_166_1.actors_[var_169_43] = var_169_45

					local var_169_46 = var_169_45:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_166_1.isInRecall_ then
						for iter_169_4, iter_169_5 in ipairs(var_169_46) do
							iter_169_5.color = arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_169_47 = arg_166_1.actors_["1028"]
			local var_169_48 = 3.73333333333333

			if var_169_48 < arg_166_1.time_ and arg_166_1.time_ <= var_169_48 + arg_169_0 and not isNil(var_169_47) and arg_166_1.var_.actorSpriteComps1028 == nil then
				arg_166_1.var_.actorSpriteComps1028 = var_169_47:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_49 = 0.125

			if var_169_48 <= arg_166_1.time_ and arg_166_1.time_ < var_169_48 + var_169_49 and not isNil(var_169_47) then
				local var_169_50 = (arg_166_1.time_ - var_169_48) / var_169_49

				if arg_166_1.var_.actorSpriteComps1028 then
					for iter_169_6, iter_169_7 in pairs(arg_166_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_169_7 then
							if arg_166_1.isInRecall_ then
								local var_169_51 = Mathf.Lerp(iter_169_7.color.r, arg_166_1.hightColor1.r, var_169_50)
								local var_169_52 = Mathf.Lerp(iter_169_7.color.g, arg_166_1.hightColor1.g, var_169_50)
								local var_169_53 = Mathf.Lerp(iter_169_7.color.b, arg_166_1.hightColor1.b, var_169_50)

								iter_169_7.color = Color.New(var_169_51, var_169_52, var_169_53)
							else
								local var_169_54 = Mathf.Lerp(iter_169_7.color.r, 1, var_169_50)

								iter_169_7.color = Color.New(var_169_54, var_169_54, var_169_54)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= var_169_48 + var_169_49 and arg_166_1.time_ < var_169_48 + var_169_49 + arg_169_0 and not isNil(var_169_47) and arg_166_1.var_.actorSpriteComps1028 then
				for iter_169_8, iter_169_9 in pairs(arg_166_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_169_9 then
						if arg_166_1.isInRecall_ then
							iter_169_9.color = arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_169_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_166_1.var_.actorSpriteComps1028 = nil
			end

			local var_169_55 = arg_166_1.actors_["1028"].transform
			local var_169_56 = 3.73333333333333

			if var_169_56 < arg_166_1.time_ and arg_166_1.time_ <= var_169_56 + arg_169_0 then
				arg_166_1.var_.moveOldPos1028 = var_169_55.localPosition
				var_169_55.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("1028", 3)

				local var_169_57 = var_169_55.childCount

				for iter_169_10 = 0, var_169_57 - 1 do
					local var_169_58 = var_169_55:GetChild(iter_169_10)

					if var_169_58.name == "" or not string.find(var_169_58.name, "split") then
						var_169_58.gameObject:SetActive(true)
					else
						var_169_58.gameObject:SetActive(false)
					end
				end
			end

			local var_169_59 = 0.001

			if var_169_56 <= arg_166_1.time_ and arg_166_1.time_ < var_169_56 + var_169_59 then
				local var_169_60 = (arg_166_1.time_ - var_169_56) / var_169_59
				local var_169_61 = Vector3.New(0, -402.7, -156.1)

				var_169_55.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1028, var_169_61, var_169_60)
			end

			if arg_166_1.time_ >= var_169_56 + var_169_59 and arg_166_1.time_ < var_169_56 + var_169_59 + arg_169_0 then
				var_169_55.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_169_62 = arg_166_1.actors_["1028"]
			local var_169_63 = 3.73333333333333

			if var_169_63 < arg_166_1.time_ and arg_166_1.time_ <= var_169_63 + arg_169_0 then
				local var_169_64 = var_169_62:GetComponentInChildren(typeof(CanvasGroup))

				if var_169_64 then
					arg_166_1.var_.alphaOldValue1028 = var_169_64.alpha
					arg_166_1.var_.characterEffect1028 = var_169_64
				end

				arg_166_1.var_.alphaOldValue1028 = 0
			end

			local var_169_65 = 0.3

			if var_169_63 <= arg_166_1.time_ and arg_166_1.time_ < var_169_63 + var_169_65 then
				local var_169_66 = (arg_166_1.time_ - var_169_63) / var_169_65
				local var_169_67 = Mathf.Lerp(arg_166_1.var_.alphaOldValue1028, 1, var_169_66)

				if arg_166_1.var_.characterEffect1028 then
					arg_166_1.var_.characterEffect1028.alpha = var_169_67
				end
			end

			if arg_166_1.time_ >= var_169_63 + var_169_65 and arg_166_1.time_ < var_169_63 + var_169_65 + arg_169_0 and arg_166_1.var_.characterEffect1028 then
				arg_166_1.var_.characterEffect1028.alpha = 1
			end

			local var_169_68 = 0
			local var_169_69 = 0.2

			if var_169_68 < arg_166_1.time_ and arg_166_1.time_ <= var_169_68 + arg_169_0 then
				local var_169_70 = "play"
				local var_169_71 = "music"

				arg_166_1:AudioAction(var_169_70, var_169_71, "ui_battle", "ui_battle_stopbgm", "")

				local var_169_72 = ""
				local var_169_73 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_169_73 ~= "" then
					if arg_166_1.bgmTxt_.text ~= var_169_73 and arg_166_1.bgmTxt_.text ~= "" then
						if arg_166_1.bgmTxt2_.text ~= "" then
							arg_166_1.bgmTxt_.text = arg_166_1.bgmTxt2_.text
						end

						arg_166_1.bgmTxt2_.text = var_169_73

						arg_166_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_166_1.bgmTxt_.text = var_169_73
						arg_166_1.bgmTxt2_.text = var_169_73
					end

					if arg_166_1.bgmTimer then
						arg_166_1.bgmTimer:Stop()

						arg_166_1.bgmTimer = nil
					end

					if arg_166_1.settingData.show_music_name == 1 then
						arg_166_1.musicController:SetSelectedState("show")
						arg_166_1.musicAnimator_:Play("open", 0, 0)

						if arg_166_1.settingData.music_time ~= 0 then
							arg_166_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_166_1.settingData.music_time), function()
								if arg_166_1 == nil or isNil(arg_166_1.bgmTxt_) then
									return
								end

								arg_166_1.musicController:SetSelectedState("hide")
								arg_166_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_169_74 = 1.43333333333333
			local var_169_75 = 1

			if var_169_74 < arg_166_1.time_ and arg_166_1.time_ <= var_169_74 + arg_169_0 then
				local var_169_76 = "play"
				local var_169_77 = "music"

				arg_166_1:AudioAction(var_169_76, var_169_77, "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village.awb")

				local var_169_78 = ""
				local var_169_79 = manager.audio:GetAudioName("bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village")

				if var_169_79 ~= "" then
					if arg_166_1.bgmTxt_.text ~= var_169_79 and arg_166_1.bgmTxt_.text ~= "" then
						if arg_166_1.bgmTxt2_.text ~= "" then
							arg_166_1.bgmTxt_.text = arg_166_1.bgmTxt2_.text
						end

						arg_166_1.bgmTxt2_.text = var_169_79

						arg_166_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_166_1.bgmTxt_.text = var_169_79
						arg_166_1.bgmTxt2_.text = var_169_79
					end

					if arg_166_1.bgmTimer then
						arg_166_1.bgmTimer:Stop()

						arg_166_1.bgmTimer = nil
					end

					if arg_166_1.settingData.show_music_name == 1 then
						arg_166_1.musicController:SetSelectedState("show")
						arg_166_1.musicAnimator_:Play("open", 0, 0)

						if arg_166_1.settingData.music_time ~= 0 then
							arg_166_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_166_1.settingData.music_time), function()
								if arg_166_1 == nil or isNil(arg_166_1.bgmTxt_) then
									return
								end

								arg_166_1.musicController:SetSelectedState("hide")
								arg_166_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_166_1.frameCnt_ <= 1 then
				arg_166_1.dialog_:SetActive(false)
			end

			local var_169_80 = 4
			local var_169_81 = 0.3

			if var_169_80 < arg_166_1.time_ and arg_166_1.time_ <= var_169_80 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0

				arg_166_1.dialog_:SetActive(true)

				arg_166_1.dialogCg_.alpha = 0

				local var_169_82 = LeanTween.value(arg_166_1.dialog_, 0, 1, 0.3)

				var_169_82:setOnUpdate(LuaHelper.FloatAction(function(arg_172_0)
					arg_166_1.dialogCg_.alpha = arg_172_0
				end))
				var_169_82:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_166_1.dialog_)
					var_169_82:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_166_1.duration_ = arg_166_1.duration_ + 0.3

				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_83 = arg_166_1:FormatText(StoryNameCfg[327].name)

				arg_166_1.leftNameTxt_.text = var_169_83

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_84 = arg_166_1:GetWordFromCfg(416051039)
				local var_169_85 = arg_166_1:FormatText(var_169_84.content)

				arg_166_1.text_.text = var_169_85

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_86 = 12
				local var_169_87 = utf8.len(var_169_85)
				local var_169_88 = var_169_86 <= 0 and var_169_81 or var_169_81 * (var_169_87 / var_169_86)

				if var_169_88 > 0 and var_169_81 < var_169_88 then
					arg_166_1.talkMaxDuration = var_169_88
					var_169_80 = var_169_80 + 0.3

					if var_169_88 + var_169_80 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_88 + var_169_80
					end
				end

				arg_166_1.text_.text = var_169_85
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051039", "story_v_out_416051.awb") ~= 0 then
					local var_169_89 = manager.audio:GetVoiceLength("story_v_out_416051", "416051039", "story_v_out_416051.awb") / 1000

					if var_169_89 + var_169_80 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_89 + var_169_80
					end

					if var_169_84.prefab_name ~= "" and arg_166_1.actors_[var_169_84.prefab_name] ~= nil then
						local var_169_90 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_84.prefab_name].transform, "story_v_out_416051", "416051039", "story_v_out_416051.awb")

						arg_166_1:RecordAudio("416051039", var_169_90)
						arg_166_1:RecordAudio("416051039", var_169_90)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_416051", "416051039", "story_v_out_416051.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_416051", "416051039", "story_v_out_416051.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_91 = var_169_80 + 0.3
			local var_169_92 = math.max(var_169_81, arg_166_1.talkMaxDuration)

			if var_169_91 <= arg_166_1.time_ and arg_166_1.time_ < var_169_91 + var_169_92 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_91) / var_169_92

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_91 + var_169_92 and arg_166_1.time_ < var_169_91 + var_169_92 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play416051040 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 416051040
		arg_174_1.duration_ = 5.33

		local var_174_0 = {
			zh = 5.333,
			ja = 4.833
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play416051041(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["1028"].transform
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.var_.moveOldPos1028 = var_177_0.localPosition
				var_177_0.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("1028", 2)

				local var_177_2 = var_177_0.childCount

				for iter_177_0 = 0, var_177_2 - 1 do
					local var_177_3 = var_177_0:GetChild(iter_177_0)

					if var_177_3.name == "" or not string.find(var_177_3.name, "split") then
						var_177_3.gameObject:SetActive(true)
					else
						var_177_3.gameObject:SetActive(false)
					end
				end
			end

			local var_177_4 = 0.001

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_4 then
				local var_177_5 = (arg_174_1.time_ - var_177_1) / var_177_4
				local var_177_6 = Vector3.New(-390, -402.7, -156.1)

				var_177_0.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1028, var_177_6, var_177_5)
			end

			if arg_174_1.time_ >= var_177_1 + var_177_4 and arg_174_1.time_ < var_177_1 + var_177_4 + arg_177_0 then
				var_177_0.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_177_7 = arg_174_1.actors_["1028"]
			local var_177_8 = 0

			if var_177_8 < arg_174_1.time_ and arg_174_1.time_ <= var_177_8 + arg_177_0 and not isNil(var_177_7) and arg_174_1.var_.actorSpriteComps1028 == nil then
				arg_174_1.var_.actorSpriteComps1028 = var_177_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_9 = 0.125

			if var_177_8 <= arg_174_1.time_ and arg_174_1.time_ < var_177_8 + var_177_9 and not isNil(var_177_7) then
				local var_177_10 = (arg_174_1.time_ - var_177_8) / var_177_9

				if arg_174_1.var_.actorSpriteComps1028 then
					for iter_177_1, iter_177_2 in pairs(arg_174_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_177_2 then
							if arg_174_1.isInRecall_ then
								local var_177_11 = Mathf.Lerp(iter_177_2.color.r, arg_174_1.hightColor2.r, var_177_10)
								local var_177_12 = Mathf.Lerp(iter_177_2.color.g, arg_174_1.hightColor2.g, var_177_10)
								local var_177_13 = Mathf.Lerp(iter_177_2.color.b, arg_174_1.hightColor2.b, var_177_10)

								iter_177_2.color = Color.New(var_177_11, var_177_12, var_177_13)
							else
								local var_177_14 = Mathf.Lerp(iter_177_2.color.r, 0.5, var_177_10)

								iter_177_2.color = Color.New(var_177_14, var_177_14, var_177_14)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= var_177_8 + var_177_9 and arg_174_1.time_ < var_177_8 + var_177_9 + arg_177_0 and not isNil(var_177_7) and arg_174_1.var_.actorSpriteComps1028 then
				for iter_177_3, iter_177_4 in pairs(arg_174_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_177_4 then
						if arg_174_1.isInRecall_ then
							iter_177_4.color = arg_174_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_177_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_174_1.var_.actorSpriteComps1028 = nil
			end

			local var_177_15 = "1086"

			if arg_174_1.actors_[var_177_15] == nil then
				local var_177_16 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

				if not isNil(var_177_16) then
					local var_177_17 = Object.Instantiate(var_177_16, arg_174_1.canvasGo_.transform)

					var_177_17.transform:SetSiblingIndex(1)

					var_177_17.name = var_177_15
					var_177_17.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_174_1.actors_[var_177_15] = var_177_17

					local var_177_18 = var_177_17:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_174_1.isInRecall_ then
						for iter_177_5, iter_177_6 in ipairs(var_177_18) do
							iter_177_6.color = arg_174_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_177_19 = arg_174_1.actors_["1086"]
			local var_177_20 = 0

			if var_177_20 < arg_174_1.time_ and arg_174_1.time_ <= var_177_20 + arg_177_0 and not isNil(var_177_19) and arg_174_1.var_.actorSpriteComps1086 == nil then
				arg_174_1.var_.actorSpriteComps1086 = var_177_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_21 = 0.125

			if var_177_20 <= arg_174_1.time_ and arg_174_1.time_ < var_177_20 + var_177_21 and not isNil(var_177_19) then
				local var_177_22 = (arg_174_1.time_ - var_177_20) / var_177_21

				if arg_174_1.var_.actorSpriteComps1086 then
					for iter_177_7, iter_177_8 in pairs(arg_174_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_177_8 then
							if arg_174_1.isInRecall_ then
								local var_177_23 = Mathf.Lerp(iter_177_8.color.r, arg_174_1.hightColor1.r, var_177_22)
								local var_177_24 = Mathf.Lerp(iter_177_8.color.g, arg_174_1.hightColor1.g, var_177_22)
								local var_177_25 = Mathf.Lerp(iter_177_8.color.b, arg_174_1.hightColor1.b, var_177_22)

								iter_177_8.color = Color.New(var_177_23, var_177_24, var_177_25)
							else
								local var_177_26 = Mathf.Lerp(iter_177_8.color.r, 1, var_177_22)

								iter_177_8.color = Color.New(var_177_26, var_177_26, var_177_26)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= var_177_20 + var_177_21 and arg_174_1.time_ < var_177_20 + var_177_21 + arg_177_0 and not isNil(var_177_19) and arg_174_1.var_.actorSpriteComps1086 then
				for iter_177_9, iter_177_10 in pairs(arg_174_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_177_10 then
						if arg_174_1.isInRecall_ then
							iter_177_10.color = arg_174_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_177_10.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_174_1.var_.actorSpriteComps1086 = nil
			end

			local var_177_27 = arg_174_1.actors_["1086"].transform
			local var_177_28 = 0

			if var_177_28 < arg_174_1.time_ and arg_174_1.time_ <= var_177_28 + arg_177_0 then
				arg_174_1.var_.moveOldPos1086 = var_177_27.localPosition
				var_177_27.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("1086", 4)

				local var_177_29 = var_177_27.childCount

				for iter_177_11 = 0, var_177_29 - 1 do
					local var_177_30 = var_177_27:GetChild(iter_177_11)

					if var_177_30.name == "split_1" or not string.find(var_177_30.name, "split") then
						var_177_30.gameObject:SetActive(true)
					else
						var_177_30.gameObject:SetActive(false)
					end
				end
			end

			local var_177_31 = 0.001

			if var_177_28 <= arg_174_1.time_ and arg_174_1.time_ < var_177_28 + var_177_31 then
				local var_177_32 = (arg_174_1.time_ - var_177_28) / var_177_31
				local var_177_33 = Vector3.New(390, -404.2, -237.9)

				var_177_27.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1086, var_177_33, var_177_32)
			end

			if arg_174_1.time_ >= var_177_28 + var_177_31 and arg_174_1.time_ < var_177_28 + var_177_31 + arg_177_0 then
				var_177_27.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_177_34 = 0
			local var_177_35 = 0.55

			if var_177_34 < arg_174_1.time_ and arg_174_1.time_ <= var_177_34 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_36 = arg_174_1:FormatText(StoryNameCfg[1080].name)

				arg_174_1.leftNameTxt_.text = var_177_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_37 = arg_174_1:GetWordFromCfg(416051040)
				local var_177_38 = arg_174_1:FormatText(var_177_37.content)

				arg_174_1.text_.text = var_177_38

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_39 = 22
				local var_177_40 = utf8.len(var_177_38)
				local var_177_41 = var_177_39 <= 0 and var_177_35 or var_177_35 * (var_177_40 / var_177_39)

				if var_177_41 > 0 and var_177_35 < var_177_41 then
					arg_174_1.talkMaxDuration = var_177_41

					if var_177_41 + var_177_34 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_41 + var_177_34
					end
				end

				arg_174_1.text_.text = var_177_38
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051040", "story_v_out_416051.awb") ~= 0 then
					local var_177_42 = manager.audio:GetVoiceLength("story_v_out_416051", "416051040", "story_v_out_416051.awb") / 1000

					if var_177_42 + var_177_34 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_42 + var_177_34
					end

					if var_177_37.prefab_name ~= "" and arg_174_1.actors_[var_177_37.prefab_name] ~= nil then
						local var_177_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_37.prefab_name].transform, "story_v_out_416051", "416051040", "story_v_out_416051.awb")

						arg_174_1:RecordAudio("416051040", var_177_43)
						arg_174_1:RecordAudio("416051040", var_177_43)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_416051", "416051040", "story_v_out_416051.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_416051", "416051040", "story_v_out_416051.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_44 = math.max(var_177_35, arg_174_1.talkMaxDuration)

			if var_177_34 <= arg_174_1.time_ and arg_174_1.time_ < var_177_34 + var_177_44 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_34) / var_177_44

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_34 + var_177_44 and arg_174_1.time_ < var_177_34 + var_177_44 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play416051041 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 416051041
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play416051042(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1086"]
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.actorSpriteComps1086 == nil then
				arg_178_1.var_.actorSpriteComps1086 = var_181_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_2 = 0.125

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 and not isNil(var_181_0) then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2

				if arg_178_1.var_.actorSpriteComps1086 then
					for iter_181_0, iter_181_1 in pairs(arg_178_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.actorSpriteComps1086 then
				for iter_181_2, iter_181_3 in pairs(arg_178_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_181_3 then
						if arg_178_1.isInRecall_ then
							iter_181_3.color = arg_178_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_181_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_178_1.var_.actorSpriteComps1086 = nil
			end

			local var_181_8 = 0
			local var_181_9 = 1.525

			if var_181_8 < arg_178_1.time_ and arg_178_1.time_ <= var_181_8 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_10 = arg_178_1:GetWordFromCfg(416051041)
				local var_181_11 = arg_178_1:FormatText(var_181_10.content)

				arg_178_1.text_.text = var_181_11

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_12 = 61
				local var_181_13 = utf8.len(var_181_11)
				local var_181_14 = var_181_12 <= 0 and var_181_9 or var_181_9 * (var_181_13 / var_181_12)

				if var_181_14 > 0 and var_181_9 < var_181_14 then
					arg_178_1.talkMaxDuration = var_181_14

					if var_181_14 + var_181_8 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_14 + var_181_8
					end
				end

				arg_178_1.text_.text = var_181_11
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_15 = math.max(var_181_9, arg_178_1.talkMaxDuration)

			if var_181_8 <= arg_178_1.time_ and arg_178_1.time_ < var_181_8 + var_181_15 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_8) / var_181_15

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_8 + var_181_15 and arg_178_1.time_ < var_181_8 + var_181_15 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play416051042 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 416051042
		arg_182_1.duration_ = 7.47

		local var_182_0 = {
			zh = 5.933,
			ja = 7.466
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play416051043(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1028"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.actorSpriteComps1028 == nil then
				arg_182_1.var_.actorSpriteComps1028 = var_185_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_2 = 0.125

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.actorSpriteComps1028 then
					for iter_185_0, iter_185_1 in pairs(arg_182_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_185_1 then
							if arg_182_1.isInRecall_ then
								local var_185_4 = Mathf.Lerp(iter_185_1.color.r, arg_182_1.hightColor1.r, var_185_3)
								local var_185_5 = Mathf.Lerp(iter_185_1.color.g, arg_182_1.hightColor1.g, var_185_3)
								local var_185_6 = Mathf.Lerp(iter_185_1.color.b, arg_182_1.hightColor1.b, var_185_3)

								iter_185_1.color = Color.New(var_185_4, var_185_5, var_185_6)
							else
								local var_185_7 = Mathf.Lerp(iter_185_1.color.r, 1, var_185_3)

								iter_185_1.color = Color.New(var_185_7, var_185_7, var_185_7)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.actorSpriteComps1028 then
				for iter_185_2, iter_185_3 in pairs(arg_182_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_185_3 then
						if arg_182_1.isInRecall_ then
							iter_185_3.color = arg_182_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_185_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_182_1.var_.actorSpriteComps1028 = nil
			end

			local var_185_8 = arg_182_1.actors_["1086"]
			local var_185_9 = 0

			if var_185_9 < arg_182_1.time_ and arg_182_1.time_ <= var_185_9 + arg_185_0 and not isNil(var_185_8) and arg_182_1.var_.actorSpriteComps1086 == nil then
				arg_182_1.var_.actorSpriteComps1086 = var_185_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_10 = 0.125

			if var_185_9 <= arg_182_1.time_ and arg_182_1.time_ < var_185_9 + var_185_10 and not isNil(var_185_8) then
				local var_185_11 = (arg_182_1.time_ - var_185_9) / var_185_10

				if arg_182_1.var_.actorSpriteComps1086 then
					for iter_185_4, iter_185_5 in pairs(arg_182_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_185_5 then
							if arg_182_1.isInRecall_ then
								local var_185_12 = Mathf.Lerp(iter_185_5.color.r, arg_182_1.hightColor2.r, var_185_11)
								local var_185_13 = Mathf.Lerp(iter_185_5.color.g, arg_182_1.hightColor2.g, var_185_11)
								local var_185_14 = Mathf.Lerp(iter_185_5.color.b, arg_182_1.hightColor2.b, var_185_11)

								iter_185_5.color = Color.New(var_185_12, var_185_13, var_185_14)
							else
								local var_185_15 = Mathf.Lerp(iter_185_5.color.r, 0.5, var_185_11)

								iter_185_5.color = Color.New(var_185_15, var_185_15, var_185_15)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= var_185_9 + var_185_10 and arg_182_1.time_ < var_185_9 + var_185_10 + arg_185_0 and not isNil(var_185_8) and arg_182_1.var_.actorSpriteComps1086 then
				for iter_185_6, iter_185_7 in pairs(arg_182_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_185_7 then
						if arg_182_1.isInRecall_ then
							iter_185_7.color = arg_182_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_185_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_182_1.var_.actorSpriteComps1086 = nil
			end

			local var_185_16 = 0
			local var_185_17 = 0.525

			if var_185_16 < arg_182_1.time_ and arg_182_1.time_ <= var_185_16 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_18 = arg_182_1:FormatText(StoryNameCfg[327].name)

				arg_182_1.leftNameTxt_.text = var_185_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_19 = arg_182_1:GetWordFromCfg(416051042)
				local var_185_20 = arg_182_1:FormatText(var_185_19.content)

				arg_182_1.text_.text = var_185_20

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_21 = 21
				local var_185_22 = utf8.len(var_185_20)
				local var_185_23 = var_185_21 <= 0 and var_185_17 or var_185_17 * (var_185_22 / var_185_21)

				if var_185_23 > 0 and var_185_17 < var_185_23 then
					arg_182_1.talkMaxDuration = var_185_23

					if var_185_23 + var_185_16 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_23 + var_185_16
					end
				end

				arg_182_1.text_.text = var_185_20
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051042", "story_v_out_416051.awb") ~= 0 then
					local var_185_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051042", "story_v_out_416051.awb") / 1000

					if var_185_24 + var_185_16 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_24 + var_185_16
					end

					if var_185_19.prefab_name ~= "" and arg_182_1.actors_[var_185_19.prefab_name] ~= nil then
						local var_185_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_19.prefab_name].transform, "story_v_out_416051", "416051042", "story_v_out_416051.awb")

						arg_182_1:RecordAudio("416051042", var_185_25)
						arg_182_1:RecordAudio("416051042", var_185_25)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_416051", "416051042", "story_v_out_416051.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_416051", "416051042", "story_v_out_416051.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_26 = math.max(var_185_17, arg_182_1.talkMaxDuration)

			if var_185_16 <= arg_182_1.time_ and arg_182_1.time_ < var_185_16 + var_185_26 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_16) / var_185_26

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_16 + var_185_26 and arg_182_1.time_ < var_185_16 + var_185_26 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play416051043 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 416051043
		arg_186_1.duration_ = 2.37

		local var_186_0 = {
			zh = 1.366,
			ja = 2.366
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play416051044(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["1028"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.actorSpriteComps1028 == nil then
				arg_186_1.var_.actorSpriteComps1028 = var_189_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_2 = 0.125

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.actorSpriteComps1028 then
					for iter_189_0, iter_189_1 in pairs(arg_186_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_189_1 then
							if arg_186_1.isInRecall_ then
								local var_189_4 = Mathf.Lerp(iter_189_1.color.r, arg_186_1.hightColor2.r, var_189_3)
								local var_189_5 = Mathf.Lerp(iter_189_1.color.g, arg_186_1.hightColor2.g, var_189_3)
								local var_189_6 = Mathf.Lerp(iter_189_1.color.b, arg_186_1.hightColor2.b, var_189_3)

								iter_189_1.color = Color.New(var_189_4, var_189_5, var_189_6)
							else
								local var_189_7 = Mathf.Lerp(iter_189_1.color.r, 0.5, var_189_3)

								iter_189_1.color = Color.New(var_189_7, var_189_7, var_189_7)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.actorSpriteComps1028 then
				for iter_189_2, iter_189_3 in pairs(arg_186_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_189_3 then
						if arg_186_1.isInRecall_ then
							iter_189_3.color = arg_186_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_189_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_186_1.var_.actorSpriteComps1028 = nil
			end

			local var_189_8 = arg_186_1.actors_["1086"]
			local var_189_9 = 0

			if var_189_9 < arg_186_1.time_ and arg_186_1.time_ <= var_189_9 + arg_189_0 and not isNil(var_189_8) and arg_186_1.var_.actorSpriteComps1086 == nil then
				arg_186_1.var_.actorSpriteComps1086 = var_189_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_10 = 0.125

			if var_189_9 <= arg_186_1.time_ and arg_186_1.time_ < var_189_9 + var_189_10 and not isNil(var_189_8) then
				local var_189_11 = (arg_186_1.time_ - var_189_9) / var_189_10

				if arg_186_1.var_.actorSpriteComps1086 then
					for iter_189_4, iter_189_5 in pairs(arg_186_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_189_5 then
							if arg_186_1.isInRecall_ then
								local var_189_12 = Mathf.Lerp(iter_189_5.color.r, arg_186_1.hightColor1.r, var_189_11)
								local var_189_13 = Mathf.Lerp(iter_189_5.color.g, arg_186_1.hightColor1.g, var_189_11)
								local var_189_14 = Mathf.Lerp(iter_189_5.color.b, arg_186_1.hightColor1.b, var_189_11)

								iter_189_5.color = Color.New(var_189_12, var_189_13, var_189_14)
							else
								local var_189_15 = Mathf.Lerp(iter_189_5.color.r, 1, var_189_11)

								iter_189_5.color = Color.New(var_189_15, var_189_15, var_189_15)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= var_189_9 + var_189_10 and arg_186_1.time_ < var_189_9 + var_189_10 + arg_189_0 and not isNil(var_189_8) and arg_186_1.var_.actorSpriteComps1086 then
				for iter_189_6, iter_189_7 in pairs(arg_186_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_189_7 then
						if arg_186_1.isInRecall_ then
							iter_189_7.color = arg_186_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_189_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_186_1.var_.actorSpriteComps1086 = nil
			end

			local var_189_16 = 0
			local var_189_17 = 0.05

			if var_189_16 < arg_186_1.time_ and arg_186_1.time_ <= var_189_16 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_18 = arg_186_1:FormatText(StoryNameCfg[1080].name)

				arg_186_1.leftNameTxt_.text = var_189_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_19 = arg_186_1:GetWordFromCfg(416051043)
				local var_189_20 = arg_186_1:FormatText(var_189_19.content)

				arg_186_1.text_.text = var_189_20

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_21 = 2
				local var_189_22 = utf8.len(var_189_20)
				local var_189_23 = var_189_21 <= 0 and var_189_17 or var_189_17 * (var_189_22 / var_189_21)

				if var_189_23 > 0 and var_189_17 < var_189_23 then
					arg_186_1.talkMaxDuration = var_189_23

					if var_189_23 + var_189_16 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_23 + var_189_16
					end
				end

				arg_186_1.text_.text = var_189_20
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051043", "story_v_out_416051.awb") ~= 0 then
					local var_189_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051043", "story_v_out_416051.awb") / 1000

					if var_189_24 + var_189_16 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_24 + var_189_16
					end

					if var_189_19.prefab_name ~= "" and arg_186_1.actors_[var_189_19.prefab_name] ~= nil then
						local var_189_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_19.prefab_name].transform, "story_v_out_416051", "416051043", "story_v_out_416051.awb")

						arg_186_1:RecordAudio("416051043", var_189_25)
						arg_186_1:RecordAudio("416051043", var_189_25)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_416051", "416051043", "story_v_out_416051.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_416051", "416051043", "story_v_out_416051.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_26 = math.max(var_189_17, arg_186_1.talkMaxDuration)

			if var_189_16 <= arg_186_1.time_ and arg_186_1.time_ < var_189_16 + var_189_26 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_16) / var_189_26

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_16 + var_189_26 and arg_186_1.time_ < var_189_16 + var_189_26 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play416051044 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 416051044
		arg_190_1.duration_ = 6.03

		local var_190_0 = {
			zh = 5.566,
			ja = 6.033
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play416051045(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["1028"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.actorSpriteComps1028 == nil then
				arg_190_1.var_.actorSpriteComps1028 = var_193_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_2 = 0.125

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.actorSpriteComps1028 then
					for iter_193_0, iter_193_1 in pairs(arg_190_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_193_1 then
							if arg_190_1.isInRecall_ then
								local var_193_4 = Mathf.Lerp(iter_193_1.color.r, arg_190_1.hightColor1.r, var_193_3)
								local var_193_5 = Mathf.Lerp(iter_193_1.color.g, arg_190_1.hightColor1.g, var_193_3)
								local var_193_6 = Mathf.Lerp(iter_193_1.color.b, arg_190_1.hightColor1.b, var_193_3)

								iter_193_1.color = Color.New(var_193_4, var_193_5, var_193_6)
							else
								local var_193_7 = Mathf.Lerp(iter_193_1.color.r, 1, var_193_3)

								iter_193_1.color = Color.New(var_193_7, var_193_7, var_193_7)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.actorSpriteComps1028 then
				for iter_193_2, iter_193_3 in pairs(arg_190_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_193_3 then
						if arg_190_1.isInRecall_ then
							iter_193_3.color = arg_190_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_193_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_190_1.var_.actorSpriteComps1028 = nil
			end

			local var_193_8 = arg_190_1.actors_["1086"]
			local var_193_9 = 0

			if var_193_9 < arg_190_1.time_ and arg_190_1.time_ <= var_193_9 + arg_193_0 and not isNil(var_193_8) and arg_190_1.var_.actorSpriteComps1086 == nil then
				arg_190_1.var_.actorSpriteComps1086 = var_193_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_10 = 0.125

			if var_193_9 <= arg_190_1.time_ and arg_190_1.time_ < var_193_9 + var_193_10 and not isNil(var_193_8) then
				local var_193_11 = (arg_190_1.time_ - var_193_9) / var_193_10

				if arg_190_1.var_.actorSpriteComps1086 then
					for iter_193_4, iter_193_5 in pairs(arg_190_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_193_5 then
							if arg_190_1.isInRecall_ then
								local var_193_12 = Mathf.Lerp(iter_193_5.color.r, arg_190_1.hightColor2.r, var_193_11)
								local var_193_13 = Mathf.Lerp(iter_193_5.color.g, arg_190_1.hightColor2.g, var_193_11)
								local var_193_14 = Mathf.Lerp(iter_193_5.color.b, arg_190_1.hightColor2.b, var_193_11)

								iter_193_5.color = Color.New(var_193_12, var_193_13, var_193_14)
							else
								local var_193_15 = Mathf.Lerp(iter_193_5.color.r, 0.5, var_193_11)

								iter_193_5.color = Color.New(var_193_15, var_193_15, var_193_15)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= var_193_9 + var_193_10 and arg_190_1.time_ < var_193_9 + var_193_10 + arg_193_0 and not isNil(var_193_8) and arg_190_1.var_.actorSpriteComps1086 then
				for iter_193_6, iter_193_7 in pairs(arg_190_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_193_7 then
						if arg_190_1.isInRecall_ then
							iter_193_7.color = arg_190_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_193_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_190_1.var_.actorSpriteComps1086 = nil
			end

			local var_193_16 = 0
			local var_193_17 = 0.35

			if var_193_16 < arg_190_1.time_ and arg_190_1.time_ <= var_193_16 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_18 = arg_190_1:FormatText(StoryNameCfg[327].name)

				arg_190_1.leftNameTxt_.text = var_193_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_19 = arg_190_1:GetWordFromCfg(416051044)
				local var_193_20 = arg_190_1:FormatText(var_193_19.content)

				arg_190_1.text_.text = var_193_20

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_21 = 14
				local var_193_22 = utf8.len(var_193_20)
				local var_193_23 = var_193_21 <= 0 and var_193_17 or var_193_17 * (var_193_22 / var_193_21)

				if var_193_23 > 0 and var_193_17 < var_193_23 then
					arg_190_1.talkMaxDuration = var_193_23

					if var_193_23 + var_193_16 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_23 + var_193_16
					end
				end

				arg_190_1.text_.text = var_193_20
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051044", "story_v_out_416051.awb") ~= 0 then
					local var_193_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051044", "story_v_out_416051.awb") / 1000

					if var_193_24 + var_193_16 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_24 + var_193_16
					end

					if var_193_19.prefab_name ~= "" and arg_190_1.actors_[var_193_19.prefab_name] ~= nil then
						local var_193_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_19.prefab_name].transform, "story_v_out_416051", "416051044", "story_v_out_416051.awb")

						arg_190_1:RecordAudio("416051044", var_193_25)
						arg_190_1:RecordAudio("416051044", var_193_25)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_416051", "416051044", "story_v_out_416051.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_416051", "416051044", "story_v_out_416051.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_26 = math.max(var_193_17, arg_190_1.talkMaxDuration)

			if var_193_16 <= arg_190_1.time_ and arg_190_1.time_ < var_193_16 + var_193_26 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_16) / var_193_26

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_16 + var_193_26 and arg_190_1.time_ < var_193_16 + var_193_26 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play416051045 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 416051045
		arg_194_1.duration_ = 4.5

		local var_194_0 = {
			zh = 2.533,
			ja = 4.5
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play416051046(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1028"]
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.actorSpriteComps1028 == nil then
				arg_194_1.var_.actorSpriteComps1028 = var_197_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_197_2 = 0.125

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 and not isNil(var_197_0) then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2

				if arg_194_1.var_.actorSpriteComps1028 then
					for iter_197_0, iter_197_1 in pairs(arg_194_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_197_1 then
							if arg_194_1.isInRecall_ then
								local var_197_4 = Mathf.Lerp(iter_197_1.color.r, arg_194_1.hightColor2.r, var_197_3)
								local var_197_5 = Mathf.Lerp(iter_197_1.color.g, arg_194_1.hightColor2.g, var_197_3)
								local var_197_6 = Mathf.Lerp(iter_197_1.color.b, arg_194_1.hightColor2.b, var_197_3)

								iter_197_1.color = Color.New(var_197_4, var_197_5, var_197_6)
							else
								local var_197_7 = Mathf.Lerp(iter_197_1.color.r, 0.5, var_197_3)

								iter_197_1.color = Color.New(var_197_7, var_197_7, var_197_7)
							end
						end
					end
				end
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.actorSpriteComps1028 then
				for iter_197_2, iter_197_3 in pairs(arg_194_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_197_3 then
						if arg_194_1.isInRecall_ then
							iter_197_3.color = arg_194_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_197_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_194_1.var_.actorSpriteComps1028 = nil
			end

			local var_197_8 = arg_194_1.actors_["1086"]
			local var_197_9 = 0

			if var_197_9 < arg_194_1.time_ and arg_194_1.time_ <= var_197_9 + arg_197_0 and not isNil(var_197_8) and arg_194_1.var_.actorSpriteComps1086 == nil then
				arg_194_1.var_.actorSpriteComps1086 = var_197_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_197_10 = 0.125

			if var_197_9 <= arg_194_1.time_ and arg_194_1.time_ < var_197_9 + var_197_10 and not isNil(var_197_8) then
				local var_197_11 = (arg_194_1.time_ - var_197_9) / var_197_10

				if arg_194_1.var_.actorSpriteComps1086 then
					for iter_197_4, iter_197_5 in pairs(arg_194_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_197_5 then
							if arg_194_1.isInRecall_ then
								local var_197_12 = Mathf.Lerp(iter_197_5.color.r, arg_194_1.hightColor1.r, var_197_11)
								local var_197_13 = Mathf.Lerp(iter_197_5.color.g, arg_194_1.hightColor1.g, var_197_11)
								local var_197_14 = Mathf.Lerp(iter_197_5.color.b, arg_194_1.hightColor1.b, var_197_11)

								iter_197_5.color = Color.New(var_197_12, var_197_13, var_197_14)
							else
								local var_197_15 = Mathf.Lerp(iter_197_5.color.r, 1, var_197_11)

								iter_197_5.color = Color.New(var_197_15, var_197_15, var_197_15)
							end
						end
					end
				end
			end

			if arg_194_1.time_ >= var_197_9 + var_197_10 and arg_194_1.time_ < var_197_9 + var_197_10 + arg_197_0 and not isNil(var_197_8) and arg_194_1.var_.actorSpriteComps1086 then
				for iter_197_6, iter_197_7 in pairs(arg_194_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_197_7 then
						if arg_194_1.isInRecall_ then
							iter_197_7.color = arg_194_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_197_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_194_1.var_.actorSpriteComps1086 = nil
			end

			local var_197_16 = 0
			local var_197_17 = 0.3

			if var_197_16 < arg_194_1.time_ and arg_194_1.time_ <= var_197_16 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_18 = arg_194_1:FormatText(StoryNameCfg[1080].name)

				arg_194_1.leftNameTxt_.text = var_197_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_19 = arg_194_1:GetWordFromCfg(416051045)
				local var_197_20 = arg_194_1:FormatText(var_197_19.content)

				arg_194_1.text_.text = var_197_20

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_21 = 12
				local var_197_22 = utf8.len(var_197_20)
				local var_197_23 = var_197_21 <= 0 and var_197_17 or var_197_17 * (var_197_22 / var_197_21)

				if var_197_23 > 0 and var_197_17 < var_197_23 then
					arg_194_1.talkMaxDuration = var_197_23

					if var_197_23 + var_197_16 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_23 + var_197_16
					end
				end

				arg_194_1.text_.text = var_197_20
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051045", "story_v_out_416051.awb") ~= 0 then
					local var_197_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051045", "story_v_out_416051.awb") / 1000

					if var_197_24 + var_197_16 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_24 + var_197_16
					end

					if var_197_19.prefab_name ~= "" and arg_194_1.actors_[var_197_19.prefab_name] ~= nil then
						local var_197_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_19.prefab_name].transform, "story_v_out_416051", "416051045", "story_v_out_416051.awb")

						arg_194_1:RecordAudio("416051045", var_197_25)
						arg_194_1:RecordAudio("416051045", var_197_25)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_416051", "416051045", "story_v_out_416051.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_416051", "416051045", "story_v_out_416051.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_26 = math.max(var_197_17, arg_194_1.talkMaxDuration)

			if var_197_16 <= arg_194_1.time_ and arg_194_1.time_ < var_197_16 + var_197_26 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_16) / var_197_26

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_16 + var_197_26 and arg_194_1.time_ < var_197_16 + var_197_26 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play416051046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 416051046
		arg_198_1.duration_ = 7.93

		local var_198_0 = {
			zh = 4.666,
			ja = 7.933
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play416051047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1028"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.actorSpriteComps1028 == nil then
				arg_198_1.var_.actorSpriteComps1028 = var_201_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_2 = 0.125

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.actorSpriteComps1028 then
					for iter_201_0, iter_201_1 in pairs(arg_198_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_201_1 then
							if arg_198_1.isInRecall_ then
								local var_201_4 = Mathf.Lerp(iter_201_1.color.r, arg_198_1.hightColor1.r, var_201_3)
								local var_201_5 = Mathf.Lerp(iter_201_1.color.g, arg_198_1.hightColor1.g, var_201_3)
								local var_201_6 = Mathf.Lerp(iter_201_1.color.b, arg_198_1.hightColor1.b, var_201_3)

								iter_201_1.color = Color.New(var_201_4, var_201_5, var_201_6)
							else
								local var_201_7 = Mathf.Lerp(iter_201_1.color.r, 1, var_201_3)

								iter_201_1.color = Color.New(var_201_7, var_201_7, var_201_7)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.actorSpriteComps1028 then
				for iter_201_2, iter_201_3 in pairs(arg_198_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_201_3 then
						if arg_198_1.isInRecall_ then
							iter_201_3.color = arg_198_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_201_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_198_1.var_.actorSpriteComps1028 = nil
			end

			local var_201_8 = arg_198_1.actors_["1086"]
			local var_201_9 = 0

			if var_201_9 < arg_198_1.time_ and arg_198_1.time_ <= var_201_9 + arg_201_0 and not isNil(var_201_8) and arg_198_1.var_.actorSpriteComps1086 == nil then
				arg_198_1.var_.actorSpriteComps1086 = var_201_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_10 = 0.125

			if var_201_9 <= arg_198_1.time_ and arg_198_1.time_ < var_201_9 + var_201_10 and not isNil(var_201_8) then
				local var_201_11 = (arg_198_1.time_ - var_201_9) / var_201_10

				if arg_198_1.var_.actorSpriteComps1086 then
					for iter_201_4, iter_201_5 in pairs(arg_198_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_201_5 then
							if arg_198_1.isInRecall_ then
								local var_201_12 = Mathf.Lerp(iter_201_5.color.r, arg_198_1.hightColor2.r, var_201_11)
								local var_201_13 = Mathf.Lerp(iter_201_5.color.g, arg_198_1.hightColor2.g, var_201_11)
								local var_201_14 = Mathf.Lerp(iter_201_5.color.b, arg_198_1.hightColor2.b, var_201_11)

								iter_201_5.color = Color.New(var_201_12, var_201_13, var_201_14)
							else
								local var_201_15 = Mathf.Lerp(iter_201_5.color.r, 0.5, var_201_11)

								iter_201_5.color = Color.New(var_201_15, var_201_15, var_201_15)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= var_201_9 + var_201_10 and arg_198_1.time_ < var_201_9 + var_201_10 + arg_201_0 and not isNil(var_201_8) and arg_198_1.var_.actorSpriteComps1086 then
				for iter_201_6, iter_201_7 in pairs(arg_198_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_201_7 then
						if arg_198_1.isInRecall_ then
							iter_201_7.color = arg_198_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_201_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_198_1.var_.actorSpriteComps1086 = nil
			end

			local var_201_16 = arg_198_1.actors_["1028"].transform
			local var_201_17 = 0

			if var_201_17 < arg_198_1.time_ and arg_198_1.time_ <= var_201_17 + arg_201_0 then
				arg_198_1.var_.moveOldPos1028 = var_201_16.localPosition
				var_201_16.localScale = Vector3.New(1, 1, 1)

				arg_198_1:CheckSpriteTmpPos("1028", 2)

				local var_201_18 = var_201_16.childCount

				for iter_201_8 = 0, var_201_18 - 1 do
					local var_201_19 = var_201_16:GetChild(iter_201_8)

					if var_201_19.name == "split_2" or not string.find(var_201_19.name, "split") then
						var_201_19.gameObject:SetActive(true)
					else
						var_201_19.gameObject:SetActive(false)
					end
				end
			end

			local var_201_20 = 0.001

			if var_201_17 <= arg_198_1.time_ and arg_198_1.time_ < var_201_17 + var_201_20 then
				local var_201_21 = (arg_198_1.time_ - var_201_17) / var_201_20
				local var_201_22 = Vector3.New(-390, -402.7, -156.1)

				var_201_16.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1028, var_201_22, var_201_21)
			end

			if arg_198_1.time_ >= var_201_17 + var_201_20 and arg_198_1.time_ < var_201_17 + var_201_20 + arg_201_0 then
				var_201_16.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_201_23 = 0
			local var_201_24 = 0.325

			if var_201_23 < arg_198_1.time_ and arg_198_1.time_ <= var_201_23 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_25 = arg_198_1:FormatText(StoryNameCfg[327].name)

				arg_198_1.leftNameTxt_.text = var_201_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_26 = arg_198_1:GetWordFromCfg(416051046)
				local var_201_27 = arg_198_1:FormatText(var_201_26.content)

				arg_198_1.text_.text = var_201_27

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_28 = 13
				local var_201_29 = utf8.len(var_201_27)
				local var_201_30 = var_201_28 <= 0 and var_201_24 or var_201_24 * (var_201_29 / var_201_28)

				if var_201_30 > 0 and var_201_24 < var_201_30 then
					arg_198_1.talkMaxDuration = var_201_30

					if var_201_30 + var_201_23 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_30 + var_201_23
					end
				end

				arg_198_1.text_.text = var_201_27
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051046", "story_v_out_416051.awb") ~= 0 then
					local var_201_31 = manager.audio:GetVoiceLength("story_v_out_416051", "416051046", "story_v_out_416051.awb") / 1000

					if var_201_31 + var_201_23 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_31 + var_201_23
					end

					if var_201_26.prefab_name ~= "" and arg_198_1.actors_[var_201_26.prefab_name] ~= nil then
						local var_201_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_26.prefab_name].transform, "story_v_out_416051", "416051046", "story_v_out_416051.awb")

						arg_198_1:RecordAudio("416051046", var_201_32)
						arg_198_1:RecordAudio("416051046", var_201_32)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_416051", "416051046", "story_v_out_416051.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_416051", "416051046", "story_v_out_416051.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_33 = math.max(var_201_24, arg_198_1.talkMaxDuration)

			if var_201_23 <= arg_198_1.time_ and arg_198_1.time_ < var_201_23 + var_201_33 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_23) / var_201_33

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_23 + var_201_33 and arg_198_1.time_ < var_201_23 + var_201_33 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play416051047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 416051047
		arg_202_1.duration_ = 5.1

		local var_202_0 = {
			zh = 3.6,
			ja = 5.1
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play416051048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["1086"].transform
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.var_.moveOldPos1086 = var_205_0.localPosition
				var_205_0.localScale = Vector3.New(1, 1, 1)

				arg_202_1:CheckSpriteTmpPos("1086", 7)

				local var_205_2 = var_205_0.childCount

				for iter_205_0 = 0, var_205_2 - 1 do
					local var_205_3 = var_205_0:GetChild(iter_205_0)

					if var_205_3.name == "" or not string.find(var_205_3.name, "split") then
						var_205_3.gameObject:SetActive(true)
					else
						var_205_3.gameObject:SetActive(false)
					end
				end
			end

			local var_205_4 = 0.001

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_4 then
				local var_205_5 = (arg_202_1.time_ - var_205_1) / var_205_4
				local var_205_6 = Vector3.New(0, -2000, 0)

				var_205_0.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1086, var_205_6, var_205_5)
			end

			if arg_202_1.time_ >= var_205_1 + var_205_4 and arg_202_1.time_ < var_205_1 + var_205_4 + arg_205_0 then
				var_205_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_205_7 = "10108"

			if arg_202_1.actors_[var_205_7] == nil then
				local var_205_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10108")

				if not isNil(var_205_8) then
					local var_205_9 = Object.Instantiate(var_205_8, arg_202_1.canvasGo_.transform)

					var_205_9.transform:SetSiblingIndex(1)

					var_205_9.name = var_205_7
					var_205_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_202_1.actors_[var_205_7] = var_205_9

					local var_205_10 = var_205_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_202_1.isInRecall_ then
						for iter_205_1, iter_205_2 in ipairs(var_205_10) do
							iter_205_2.color = arg_202_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_205_11 = arg_202_1.actors_["10108"]
			local var_205_12 = 0

			if var_205_12 < arg_202_1.time_ and arg_202_1.time_ <= var_205_12 + arg_205_0 and not isNil(var_205_11) and arg_202_1.var_.actorSpriteComps10108 == nil then
				arg_202_1.var_.actorSpriteComps10108 = var_205_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_13 = 0.125

			if var_205_12 <= arg_202_1.time_ and arg_202_1.time_ < var_205_12 + var_205_13 and not isNil(var_205_11) then
				local var_205_14 = (arg_202_1.time_ - var_205_12) / var_205_13

				if arg_202_1.var_.actorSpriteComps10108 then
					for iter_205_3, iter_205_4 in pairs(arg_202_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_205_4 then
							if arg_202_1.isInRecall_ then
								local var_205_15 = Mathf.Lerp(iter_205_4.color.r, arg_202_1.hightColor1.r, var_205_14)
								local var_205_16 = Mathf.Lerp(iter_205_4.color.g, arg_202_1.hightColor1.g, var_205_14)
								local var_205_17 = Mathf.Lerp(iter_205_4.color.b, arg_202_1.hightColor1.b, var_205_14)

								iter_205_4.color = Color.New(var_205_15, var_205_16, var_205_17)
							else
								local var_205_18 = Mathf.Lerp(iter_205_4.color.r, 1, var_205_14)

								iter_205_4.color = Color.New(var_205_18, var_205_18, var_205_18)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= var_205_12 + var_205_13 and arg_202_1.time_ < var_205_12 + var_205_13 + arg_205_0 and not isNil(var_205_11) and arg_202_1.var_.actorSpriteComps10108 then
				for iter_205_5, iter_205_6 in pairs(arg_202_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_205_6 then
						if arg_202_1.isInRecall_ then
							iter_205_6.color = arg_202_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_205_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_202_1.var_.actorSpriteComps10108 = nil
			end

			local var_205_19 = arg_202_1.actors_["10108"].transform
			local var_205_20 = 0

			if var_205_20 < arg_202_1.time_ and arg_202_1.time_ <= var_205_20 + arg_205_0 then
				arg_202_1.var_.moveOldPos10108 = var_205_19.localPosition
				var_205_19.localScale = Vector3.New(1, 1, 1)

				arg_202_1:CheckSpriteTmpPos("10108", 4)

				local var_205_21 = var_205_19.childCount

				for iter_205_7 = 0, var_205_21 - 1 do
					local var_205_22 = var_205_19:GetChild(iter_205_7)

					if var_205_22.name == "split_1" or not string.find(var_205_22.name, "split") then
						var_205_22.gameObject:SetActive(true)
					else
						var_205_22.gameObject:SetActive(false)
					end
				end
			end

			local var_205_23 = 0.001

			if var_205_20 <= arg_202_1.time_ and arg_202_1.time_ < var_205_20 + var_205_23 then
				local var_205_24 = (arg_202_1.time_ - var_205_20) / var_205_23
				local var_205_25 = Vector3.New(390, -399.6, -130)

				var_205_19.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos10108, var_205_25, var_205_24)
			end

			if arg_202_1.time_ >= var_205_20 + var_205_23 and arg_202_1.time_ < var_205_20 + var_205_23 + arg_205_0 then
				var_205_19.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_205_26 = arg_202_1.actors_["1028"]
			local var_205_27 = 0

			if var_205_27 < arg_202_1.time_ and arg_202_1.time_ <= var_205_27 + arg_205_0 and not isNil(var_205_26) and arg_202_1.var_.actorSpriteComps1028 == nil then
				arg_202_1.var_.actorSpriteComps1028 = var_205_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_28 = 0.125

			if var_205_27 <= arg_202_1.time_ and arg_202_1.time_ < var_205_27 + var_205_28 and not isNil(var_205_26) then
				local var_205_29 = (arg_202_1.time_ - var_205_27) / var_205_28

				if arg_202_1.var_.actorSpriteComps1028 then
					for iter_205_8, iter_205_9 in pairs(arg_202_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_205_9 then
							if arg_202_1.isInRecall_ then
								local var_205_30 = Mathf.Lerp(iter_205_9.color.r, arg_202_1.hightColor2.r, var_205_29)
								local var_205_31 = Mathf.Lerp(iter_205_9.color.g, arg_202_1.hightColor2.g, var_205_29)
								local var_205_32 = Mathf.Lerp(iter_205_9.color.b, arg_202_1.hightColor2.b, var_205_29)

								iter_205_9.color = Color.New(var_205_30, var_205_31, var_205_32)
							else
								local var_205_33 = Mathf.Lerp(iter_205_9.color.r, 0.5, var_205_29)

								iter_205_9.color = Color.New(var_205_33, var_205_33, var_205_33)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= var_205_27 + var_205_28 and arg_202_1.time_ < var_205_27 + var_205_28 + arg_205_0 and not isNil(var_205_26) and arg_202_1.var_.actorSpriteComps1028 then
				for iter_205_10, iter_205_11 in pairs(arg_202_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_205_11 then
						if arg_202_1.isInRecall_ then
							iter_205_11.color = arg_202_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_205_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_202_1.var_.actorSpriteComps1028 = nil
			end

			local var_205_34 = 0
			local var_205_35 = 0.375

			if var_205_34 < arg_202_1.time_ and arg_202_1.time_ <= var_205_34 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_36 = arg_202_1:FormatText(StoryNameCfg[1083].name)

				arg_202_1.leftNameTxt_.text = var_205_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_37 = arg_202_1:GetWordFromCfg(416051047)
				local var_205_38 = arg_202_1:FormatText(var_205_37.content)

				arg_202_1.text_.text = var_205_38

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_39 = 15
				local var_205_40 = utf8.len(var_205_38)
				local var_205_41 = var_205_39 <= 0 and var_205_35 or var_205_35 * (var_205_40 / var_205_39)

				if var_205_41 > 0 and var_205_35 < var_205_41 then
					arg_202_1.talkMaxDuration = var_205_41

					if var_205_41 + var_205_34 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_41 + var_205_34
					end
				end

				arg_202_1.text_.text = var_205_38
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051047", "story_v_out_416051.awb") ~= 0 then
					local var_205_42 = manager.audio:GetVoiceLength("story_v_out_416051", "416051047", "story_v_out_416051.awb") / 1000

					if var_205_42 + var_205_34 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_42 + var_205_34
					end

					if var_205_37.prefab_name ~= "" and arg_202_1.actors_[var_205_37.prefab_name] ~= nil then
						local var_205_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_37.prefab_name].transform, "story_v_out_416051", "416051047", "story_v_out_416051.awb")

						arg_202_1:RecordAudio("416051047", var_205_43)
						arg_202_1:RecordAudio("416051047", var_205_43)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_416051", "416051047", "story_v_out_416051.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_416051", "416051047", "story_v_out_416051.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_44 = math.max(var_205_35, arg_202_1.talkMaxDuration)

			if var_205_34 <= arg_202_1.time_ and arg_202_1.time_ < var_205_34 + var_205_44 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_34) / var_205_44

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_34 + var_205_44 and arg_202_1.time_ < var_205_34 + var_205_44 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play416051048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 416051048
		arg_206_1.duration_ = 4.63

		local var_206_0 = {
			zh = 4.333,
			ja = 4.633
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play416051049(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["1028"]
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.actorSpriteComps1028 == nil then
				arg_206_1.var_.actorSpriteComps1028 = var_209_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_2 = 0.125

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 and not isNil(var_209_0) then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2

				if arg_206_1.var_.actorSpriteComps1028 then
					for iter_209_0, iter_209_1 in pairs(arg_206_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_209_1 then
							if arg_206_1.isInRecall_ then
								local var_209_4 = Mathf.Lerp(iter_209_1.color.r, arg_206_1.hightColor1.r, var_209_3)
								local var_209_5 = Mathf.Lerp(iter_209_1.color.g, arg_206_1.hightColor1.g, var_209_3)
								local var_209_6 = Mathf.Lerp(iter_209_1.color.b, arg_206_1.hightColor1.b, var_209_3)

								iter_209_1.color = Color.New(var_209_4, var_209_5, var_209_6)
							else
								local var_209_7 = Mathf.Lerp(iter_209_1.color.r, 1, var_209_3)

								iter_209_1.color = Color.New(var_209_7, var_209_7, var_209_7)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.actorSpriteComps1028 then
				for iter_209_2, iter_209_3 in pairs(arg_206_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_209_3 then
						if arg_206_1.isInRecall_ then
							iter_209_3.color = arg_206_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_209_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_206_1.var_.actorSpriteComps1028 = nil
			end

			local var_209_8 = arg_206_1.actors_["10108"]
			local var_209_9 = 0

			if var_209_9 < arg_206_1.time_ and arg_206_1.time_ <= var_209_9 + arg_209_0 and not isNil(var_209_8) and arg_206_1.var_.actorSpriteComps10108 == nil then
				arg_206_1.var_.actorSpriteComps10108 = var_209_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_10 = 0.125

			if var_209_9 <= arg_206_1.time_ and arg_206_1.time_ < var_209_9 + var_209_10 and not isNil(var_209_8) then
				local var_209_11 = (arg_206_1.time_ - var_209_9) / var_209_10

				if arg_206_1.var_.actorSpriteComps10108 then
					for iter_209_4, iter_209_5 in pairs(arg_206_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_209_5 then
							if arg_206_1.isInRecall_ then
								local var_209_12 = Mathf.Lerp(iter_209_5.color.r, arg_206_1.hightColor2.r, var_209_11)
								local var_209_13 = Mathf.Lerp(iter_209_5.color.g, arg_206_1.hightColor2.g, var_209_11)
								local var_209_14 = Mathf.Lerp(iter_209_5.color.b, arg_206_1.hightColor2.b, var_209_11)

								iter_209_5.color = Color.New(var_209_12, var_209_13, var_209_14)
							else
								local var_209_15 = Mathf.Lerp(iter_209_5.color.r, 0.5, var_209_11)

								iter_209_5.color = Color.New(var_209_15, var_209_15, var_209_15)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= var_209_9 + var_209_10 and arg_206_1.time_ < var_209_9 + var_209_10 + arg_209_0 and not isNil(var_209_8) and arg_206_1.var_.actorSpriteComps10108 then
				for iter_209_6, iter_209_7 in pairs(arg_206_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_209_7 then
						if arg_206_1.isInRecall_ then
							iter_209_7.color = arg_206_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_209_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_206_1.var_.actorSpriteComps10108 = nil
			end

			local var_209_16 = arg_206_1.actors_["1028"].transform
			local var_209_17 = 0

			if var_209_17 < arg_206_1.time_ and arg_206_1.time_ <= var_209_17 + arg_209_0 then
				arg_206_1.var_.moveOldPos1028 = var_209_16.localPosition
				var_209_16.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("1028", 2)

				local var_209_18 = var_209_16.childCount

				for iter_209_8 = 0, var_209_18 - 1 do
					local var_209_19 = var_209_16:GetChild(iter_209_8)

					if var_209_19.name == "split_7" or not string.find(var_209_19.name, "split") then
						var_209_19.gameObject:SetActive(true)
					else
						var_209_19.gameObject:SetActive(false)
					end
				end
			end

			local var_209_20 = 0.001

			if var_209_17 <= arg_206_1.time_ and arg_206_1.time_ < var_209_17 + var_209_20 then
				local var_209_21 = (arg_206_1.time_ - var_209_17) / var_209_20
				local var_209_22 = Vector3.New(-390, -402.7, -156.1)

				var_209_16.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1028, var_209_22, var_209_21)
			end

			if arg_206_1.time_ >= var_209_17 + var_209_20 and arg_206_1.time_ < var_209_17 + var_209_20 + arg_209_0 then
				var_209_16.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_209_23 = 0
			local var_209_24 = 0.55

			if var_209_23 < arg_206_1.time_ and arg_206_1.time_ <= var_209_23 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_25 = arg_206_1:FormatText(StoryNameCfg[327].name)

				arg_206_1.leftNameTxt_.text = var_209_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_26 = arg_206_1:GetWordFromCfg(416051048)
				local var_209_27 = arg_206_1:FormatText(var_209_26.content)

				arg_206_1.text_.text = var_209_27

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_28 = 22
				local var_209_29 = utf8.len(var_209_27)
				local var_209_30 = var_209_28 <= 0 and var_209_24 or var_209_24 * (var_209_29 / var_209_28)

				if var_209_30 > 0 and var_209_24 < var_209_30 then
					arg_206_1.talkMaxDuration = var_209_30

					if var_209_30 + var_209_23 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_30 + var_209_23
					end
				end

				arg_206_1.text_.text = var_209_27
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051048", "story_v_out_416051.awb") ~= 0 then
					local var_209_31 = manager.audio:GetVoiceLength("story_v_out_416051", "416051048", "story_v_out_416051.awb") / 1000

					if var_209_31 + var_209_23 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_31 + var_209_23
					end

					if var_209_26.prefab_name ~= "" and arg_206_1.actors_[var_209_26.prefab_name] ~= nil then
						local var_209_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_26.prefab_name].transform, "story_v_out_416051", "416051048", "story_v_out_416051.awb")

						arg_206_1:RecordAudio("416051048", var_209_32)
						arg_206_1:RecordAudio("416051048", var_209_32)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_416051", "416051048", "story_v_out_416051.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_416051", "416051048", "story_v_out_416051.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_33 = math.max(var_209_24, arg_206_1.talkMaxDuration)

			if var_209_23 <= arg_206_1.time_ and arg_206_1.time_ < var_209_23 + var_209_33 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_23) / var_209_33

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_23 + var_209_33 and arg_206_1.time_ < var_209_23 + var_209_33 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play416051049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 416051049
		arg_210_1.duration_ = 15.87

		local var_210_0 = {
			zh = 6.166,
			ja = 15.866
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play416051050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["1028"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.actorSpriteComps1028 == nil then
				arg_210_1.var_.actorSpriteComps1028 = var_213_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_2 = 0.125

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.actorSpriteComps1028 then
					for iter_213_0, iter_213_1 in pairs(arg_210_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_213_1 then
							if arg_210_1.isInRecall_ then
								local var_213_4 = Mathf.Lerp(iter_213_1.color.r, arg_210_1.hightColor2.r, var_213_3)
								local var_213_5 = Mathf.Lerp(iter_213_1.color.g, arg_210_1.hightColor2.g, var_213_3)
								local var_213_6 = Mathf.Lerp(iter_213_1.color.b, arg_210_1.hightColor2.b, var_213_3)

								iter_213_1.color = Color.New(var_213_4, var_213_5, var_213_6)
							else
								local var_213_7 = Mathf.Lerp(iter_213_1.color.r, 0.5, var_213_3)

								iter_213_1.color = Color.New(var_213_7, var_213_7, var_213_7)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.actorSpriteComps1028 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_213_3 then
						if arg_210_1.isInRecall_ then
							iter_213_3.color = arg_210_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_213_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_210_1.var_.actorSpriteComps1028 = nil
			end

			local var_213_8 = arg_210_1.actors_["10108"]
			local var_213_9 = 0

			if var_213_9 < arg_210_1.time_ and arg_210_1.time_ <= var_213_9 + arg_213_0 and not isNil(var_213_8) and arg_210_1.var_.actorSpriteComps10108 == nil then
				arg_210_1.var_.actorSpriteComps10108 = var_213_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_10 = 0.125

			if var_213_9 <= arg_210_1.time_ and arg_210_1.time_ < var_213_9 + var_213_10 and not isNil(var_213_8) then
				local var_213_11 = (arg_210_1.time_ - var_213_9) / var_213_10

				if arg_210_1.var_.actorSpriteComps10108 then
					for iter_213_4, iter_213_5 in pairs(arg_210_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_213_5 then
							if arg_210_1.isInRecall_ then
								local var_213_12 = Mathf.Lerp(iter_213_5.color.r, arg_210_1.hightColor1.r, var_213_11)
								local var_213_13 = Mathf.Lerp(iter_213_5.color.g, arg_210_1.hightColor1.g, var_213_11)
								local var_213_14 = Mathf.Lerp(iter_213_5.color.b, arg_210_1.hightColor1.b, var_213_11)

								iter_213_5.color = Color.New(var_213_12, var_213_13, var_213_14)
							else
								local var_213_15 = Mathf.Lerp(iter_213_5.color.r, 1, var_213_11)

								iter_213_5.color = Color.New(var_213_15, var_213_15, var_213_15)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= var_213_9 + var_213_10 and arg_210_1.time_ < var_213_9 + var_213_10 + arg_213_0 and not isNil(var_213_8) and arg_210_1.var_.actorSpriteComps10108 then
				for iter_213_6, iter_213_7 in pairs(arg_210_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_213_7 then
						if arg_210_1.isInRecall_ then
							iter_213_7.color = arg_210_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_213_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_210_1.var_.actorSpriteComps10108 = nil
			end

			local var_213_16 = 0
			local var_213_17 = 0.525

			if var_213_16 < arg_210_1.time_ and arg_210_1.time_ <= var_213_16 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_18 = arg_210_1:FormatText(StoryNameCfg[1083].name)

				arg_210_1.leftNameTxt_.text = var_213_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_19 = arg_210_1:GetWordFromCfg(416051049)
				local var_213_20 = arg_210_1:FormatText(var_213_19.content)

				arg_210_1.text_.text = var_213_20

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_21 = 21
				local var_213_22 = utf8.len(var_213_20)
				local var_213_23 = var_213_21 <= 0 and var_213_17 or var_213_17 * (var_213_22 / var_213_21)

				if var_213_23 > 0 and var_213_17 < var_213_23 then
					arg_210_1.talkMaxDuration = var_213_23

					if var_213_23 + var_213_16 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_23 + var_213_16
					end
				end

				arg_210_1.text_.text = var_213_20
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051049", "story_v_out_416051.awb") ~= 0 then
					local var_213_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051049", "story_v_out_416051.awb") / 1000

					if var_213_24 + var_213_16 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_24 + var_213_16
					end

					if var_213_19.prefab_name ~= "" and arg_210_1.actors_[var_213_19.prefab_name] ~= nil then
						local var_213_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_19.prefab_name].transform, "story_v_out_416051", "416051049", "story_v_out_416051.awb")

						arg_210_1:RecordAudio("416051049", var_213_25)
						arg_210_1:RecordAudio("416051049", var_213_25)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_416051", "416051049", "story_v_out_416051.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_416051", "416051049", "story_v_out_416051.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_26 = math.max(var_213_17, arg_210_1.talkMaxDuration)

			if var_213_16 <= arg_210_1.time_ and arg_210_1.time_ < var_213_16 + var_213_26 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_16) / var_213_26

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_16 + var_213_26 and arg_210_1.time_ < var_213_16 + var_213_26 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play416051050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 416051050
		arg_214_1.duration_ = 6.73

		local var_214_0 = {
			zh = 4.633,
			ja = 6.733
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play416051051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["1028"]
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.actorSpriteComps1028 == nil then
				arg_214_1.var_.actorSpriteComps1028 = var_217_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_2 = 0.125

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 and not isNil(var_217_0) then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2

				if arg_214_1.var_.actorSpriteComps1028 then
					for iter_217_0, iter_217_1 in pairs(arg_214_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_217_1 then
							if arg_214_1.isInRecall_ then
								local var_217_4 = Mathf.Lerp(iter_217_1.color.r, arg_214_1.hightColor1.r, var_217_3)
								local var_217_5 = Mathf.Lerp(iter_217_1.color.g, arg_214_1.hightColor1.g, var_217_3)
								local var_217_6 = Mathf.Lerp(iter_217_1.color.b, arg_214_1.hightColor1.b, var_217_3)

								iter_217_1.color = Color.New(var_217_4, var_217_5, var_217_6)
							else
								local var_217_7 = Mathf.Lerp(iter_217_1.color.r, 1, var_217_3)

								iter_217_1.color = Color.New(var_217_7, var_217_7, var_217_7)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.actorSpriteComps1028 then
				for iter_217_2, iter_217_3 in pairs(arg_214_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_217_3 then
						if arg_214_1.isInRecall_ then
							iter_217_3.color = arg_214_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_217_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_214_1.var_.actorSpriteComps1028 = nil
			end

			local var_217_8 = arg_214_1.actors_["10108"]
			local var_217_9 = 0

			if var_217_9 < arg_214_1.time_ and arg_214_1.time_ <= var_217_9 + arg_217_0 and not isNil(var_217_8) and arg_214_1.var_.actorSpriteComps10108 == nil then
				arg_214_1.var_.actorSpriteComps10108 = var_217_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_10 = 0.125

			if var_217_9 <= arg_214_1.time_ and arg_214_1.time_ < var_217_9 + var_217_10 and not isNil(var_217_8) then
				local var_217_11 = (arg_214_1.time_ - var_217_9) / var_217_10

				if arg_214_1.var_.actorSpriteComps10108 then
					for iter_217_4, iter_217_5 in pairs(arg_214_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_217_5 then
							if arg_214_1.isInRecall_ then
								local var_217_12 = Mathf.Lerp(iter_217_5.color.r, arg_214_1.hightColor2.r, var_217_11)
								local var_217_13 = Mathf.Lerp(iter_217_5.color.g, arg_214_1.hightColor2.g, var_217_11)
								local var_217_14 = Mathf.Lerp(iter_217_5.color.b, arg_214_1.hightColor2.b, var_217_11)

								iter_217_5.color = Color.New(var_217_12, var_217_13, var_217_14)
							else
								local var_217_15 = Mathf.Lerp(iter_217_5.color.r, 0.5, var_217_11)

								iter_217_5.color = Color.New(var_217_15, var_217_15, var_217_15)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= var_217_9 + var_217_10 and arg_214_1.time_ < var_217_9 + var_217_10 + arg_217_0 and not isNil(var_217_8) and arg_214_1.var_.actorSpriteComps10108 then
				for iter_217_6, iter_217_7 in pairs(arg_214_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_217_7 then
						if arg_214_1.isInRecall_ then
							iter_217_7.color = arg_214_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_217_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_214_1.var_.actorSpriteComps10108 = nil
			end

			local var_217_16 = arg_214_1.actors_["1028"].transform
			local var_217_17 = 0

			if var_217_17 < arg_214_1.time_ and arg_214_1.time_ <= var_217_17 + arg_217_0 then
				arg_214_1.var_.moveOldPos1028 = var_217_16.localPosition
				var_217_16.localScale = Vector3.New(1, 1, 1)

				arg_214_1:CheckSpriteTmpPos("1028", 2)

				local var_217_18 = var_217_16.childCount

				for iter_217_8 = 0, var_217_18 - 1 do
					local var_217_19 = var_217_16:GetChild(iter_217_8)

					if var_217_19.name == "split_4" or not string.find(var_217_19.name, "split") then
						var_217_19.gameObject:SetActive(true)
					else
						var_217_19.gameObject:SetActive(false)
					end
				end
			end

			local var_217_20 = 0.001

			if var_217_17 <= arg_214_1.time_ and arg_214_1.time_ < var_217_17 + var_217_20 then
				local var_217_21 = (arg_214_1.time_ - var_217_17) / var_217_20
				local var_217_22 = Vector3.New(-390, -402.7, -156.1)

				var_217_16.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1028, var_217_22, var_217_21)
			end

			if arg_214_1.time_ >= var_217_17 + var_217_20 and arg_214_1.time_ < var_217_17 + var_217_20 + arg_217_0 then
				var_217_16.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_217_23 = 0
			local var_217_24 = 0.4

			if var_217_23 < arg_214_1.time_ and arg_214_1.time_ <= var_217_23 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_25 = arg_214_1:FormatText(StoryNameCfg[327].name)

				arg_214_1.leftNameTxt_.text = var_217_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_26 = arg_214_1:GetWordFromCfg(416051050)
				local var_217_27 = arg_214_1:FormatText(var_217_26.content)

				arg_214_1.text_.text = var_217_27

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_28 = 16
				local var_217_29 = utf8.len(var_217_27)
				local var_217_30 = var_217_28 <= 0 and var_217_24 or var_217_24 * (var_217_29 / var_217_28)

				if var_217_30 > 0 and var_217_24 < var_217_30 then
					arg_214_1.talkMaxDuration = var_217_30

					if var_217_30 + var_217_23 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_30 + var_217_23
					end
				end

				arg_214_1.text_.text = var_217_27
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051050", "story_v_out_416051.awb") ~= 0 then
					local var_217_31 = manager.audio:GetVoiceLength("story_v_out_416051", "416051050", "story_v_out_416051.awb") / 1000

					if var_217_31 + var_217_23 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_31 + var_217_23
					end

					if var_217_26.prefab_name ~= "" and arg_214_1.actors_[var_217_26.prefab_name] ~= nil then
						local var_217_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_26.prefab_name].transform, "story_v_out_416051", "416051050", "story_v_out_416051.awb")

						arg_214_1:RecordAudio("416051050", var_217_32)
						arg_214_1:RecordAudio("416051050", var_217_32)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_416051", "416051050", "story_v_out_416051.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_416051", "416051050", "story_v_out_416051.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_33 = math.max(var_217_24, arg_214_1.talkMaxDuration)

			if var_217_23 <= arg_214_1.time_ and arg_214_1.time_ < var_217_23 + var_217_33 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_23) / var_217_33

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_23 + var_217_33 and arg_214_1.time_ < var_217_23 + var_217_33 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play416051051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 416051051
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play416051052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["1028"]
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.actorSpriteComps1028 == nil then
				arg_218_1.var_.actorSpriteComps1028 = var_221_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_2 = 0.125

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 and not isNil(var_221_0) then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2

				if arg_218_1.var_.actorSpriteComps1028 then
					for iter_221_0, iter_221_1 in pairs(arg_218_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_221_1 then
							if arg_218_1.isInRecall_ then
								local var_221_4 = Mathf.Lerp(iter_221_1.color.r, arg_218_1.hightColor2.r, var_221_3)
								local var_221_5 = Mathf.Lerp(iter_221_1.color.g, arg_218_1.hightColor2.g, var_221_3)
								local var_221_6 = Mathf.Lerp(iter_221_1.color.b, arg_218_1.hightColor2.b, var_221_3)

								iter_221_1.color = Color.New(var_221_4, var_221_5, var_221_6)
							else
								local var_221_7 = Mathf.Lerp(iter_221_1.color.r, 0.5, var_221_3)

								iter_221_1.color = Color.New(var_221_7, var_221_7, var_221_7)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.actorSpriteComps1028 then
				for iter_221_2, iter_221_3 in pairs(arg_218_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_221_3 then
						if arg_218_1.isInRecall_ then
							iter_221_3.color = arg_218_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_221_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_218_1.var_.actorSpriteComps1028 = nil
			end

			local var_221_8 = arg_218_1.actors_["10108"]
			local var_221_9 = 0

			if var_221_9 < arg_218_1.time_ and arg_218_1.time_ <= var_221_9 + arg_221_0 and not isNil(var_221_8) and arg_218_1.var_.actorSpriteComps10108 == nil then
				arg_218_1.var_.actorSpriteComps10108 = var_221_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_10 = 0.125

			if var_221_9 <= arg_218_1.time_ and arg_218_1.time_ < var_221_9 + var_221_10 and not isNil(var_221_8) then
				local var_221_11 = (arg_218_1.time_ - var_221_9) / var_221_10

				if arg_218_1.var_.actorSpriteComps10108 then
					for iter_221_4, iter_221_5 in pairs(arg_218_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_221_5 then
							if arg_218_1.isInRecall_ then
								local var_221_12 = Mathf.Lerp(iter_221_5.color.r, arg_218_1.hightColor2.r, var_221_11)
								local var_221_13 = Mathf.Lerp(iter_221_5.color.g, arg_218_1.hightColor2.g, var_221_11)
								local var_221_14 = Mathf.Lerp(iter_221_5.color.b, arg_218_1.hightColor2.b, var_221_11)

								iter_221_5.color = Color.New(var_221_12, var_221_13, var_221_14)
							else
								local var_221_15 = Mathf.Lerp(iter_221_5.color.r, 0.5, var_221_11)

								iter_221_5.color = Color.New(var_221_15, var_221_15, var_221_15)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= var_221_9 + var_221_10 and arg_218_1.time_ < var_221_9 + var_221_10 + arg_221_0 and not isNil(var_221_8) and arg_218_1.var_.actorSpriteComps10108 then
				for iter_221_6, iter_221_7 in pairs(arg_218_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_221_7 then
						if arg_218_1.isInRecall_ then
							iter_221_7.color = arg_218_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_221_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_218_1.var_.actorSpriteComps10108 = nil
			end

			local var_221_16 = 0
			local var_221_17 = 1.575

			if var_221_16 < arg_218_1.time_ and arg_218_1.time_ <= var_221_16 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_18 = arg_218_1:GetWordFromCfg(416051051)
				local var_221_19 = arg_218_1:FormatText(var_221_18.content)

				arg_218_1.text_.text = var_221_19

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_20 = 63
				local var_221_21 = utf8.len(var_221_19)
				local var_221_22 = var_221_20 <= 0 and var_221_17 or var_221_17 * (var_221_21 / var_221_20)

				if var_221_22 > 0 and var_221_17 < var_221_22 then
					arg_218_1.talkMaxDuration = var_221_22

					if var_221_22 + var_221_16 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_22 + var_221_16
					end
				end

				arg_218_1.text_.text = var_221_19
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_23 = math.max(var_221_17, arg_218_1.talkMaxDuration)

			if var_221_16 <= arg_218_1.time_ and arg_218_1.time_ < var_221_16 + var_221_23 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_16) / var_221_23

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_16 + var_221_23 and arg_218_1.time_ < var_221_16 + var_221_23 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play416051052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 416051052
		arg_222_1.duration_ = 9.63

		local var_222_0 = {
			zh = 4.166,
			ja = 9.633
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play416051053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["1028"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps1028 == nil then
				arg_222_1.var_.actorSpriteComps1028 = var_225_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_2 = 0.2

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.actorSpriteComps1028 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_225_1 then
							if arg_222_1.isInRecall_ then
								local var_225_4 = Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor2.r, var_225_3)
								local var_225_5 = Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor2.g, var_225_3)
								local var_225_6 = Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor2.b, var_225_3)

								iter_225_1.color = Color.New(var_225_4, var_225_5, var_225_6)
							else
								local var_225_7 = Mathf.Lerp(iter_225_1.color.r, 0.5, var_225_3)

								iter_225_1.color = Color.New(var_225_7, var_225_7, var_225_7)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps1028 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_225_3 then
						if arg_222_1.isInRecall_ then
							iter_225_3.color = arg_222_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_225_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_222_1.var_.actorSpriteComps1028 = nil
			end

			local var_225_8 = arg_222_1.actors_["10108"]
			local var_225_9 = 0

			if var_225_9 < arg_222_1.time_ and arg_222_1.time_ <= var_225_9 + arg_225_0 and not isNil(var_225_8) and arg_222_1.var_.actorSpriteComps10108 == nil then
				arg_222_1.var_.actorSpriteComps10108 = var_225_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_10 = 0.125

			if var_225_9 <= arg_222_1.time_ and arg_222_1.time_ < var_225_9 + var_225_10 and not isNil(var_225_8) then
				local var_225_11 = (arg_222_1.time_ - var_225_9) / var_225_10

				if arg_222_1.var_.actorSpriteComps10108 then
					for iter_225_4, iter_225_5 in pairs(arg_222_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_225_5 then
							if arg_222_1.isInRecall_ then
								local var_225_12 = Mathf.Lerp(iter_225_5.color.r, arg_222_1.hightColor1.r, var_225_11)
								local var_225_13 = Mathf.Lerp(iter_225_5.color.g, arg_222_1.hightColor1.g, var_225_11)
								local var_225_14 = Mathf.Lerp(iter_225_5.color.b, arg_222_1.hightColor1.b, var_225_11)

								iter_225_5.color = Color.New(var_225_12, var_225_13, var_225_14)
							else
								local var_225_15 = Mathf.Lerp(iter_225_5.color.r, 1, var_225_11)

								iter_225_5.color = Color.New(var_225_15, var_225_15, var_225_15)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= var_225_9 + var_225_10 and arg_222_1.time_ < var_225_9 + var_225_10 + arg_225_0 and not isNil(var_225_8) and arg_222_1.var_.actorSpriteComps10108 then
				for iter_225_6, iter_225_7 in pairs(arg_222_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_225_7 then
						if arg_222_1.isInRecall_ then
							iter_225_7.color = arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_225_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_222_1.var_.actorSpriteComps10108 = nil
			end

			local var_225_16 = arg_222_1.actors_["10108"].transform
			local var_225_17 = 0

			if var_225_17 < arg_222_1.time_ and arg_222_1.time_ <= var_225_17 + arg_225_0 then
				arg_222_1.var_.moveOldPos10108 = var_225_16.localPosition
				var_225_16.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("10108", 4)

				local var_225_18 = var_225_16.childCount

				for iter_225_8 = 0, var_225_18 - 1 do
					local var_225_19 = var_225_16:GetChild(iter_225_8)

					if var_225_19.name == "split_2" or not string.find(var_225_19.name, "split") then
						var_225_19.gameObject:SetActive(true)
					else
						var_225_19.gameObject:SetActive(false)
					end
				end
			end

			local var_225_20 = 0.001

			if var_225_17 <= arg_222_1.time_ and arg_222_1.time_ < var_225_17 + var_225_20 then
				local var_225_21 = (arg_222_1.time_ - var_225_17) / var_225_20
				local var_225_22 = Vector3.New(390, -399.6, -130)

				var_225_16.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos10108, var_225_22, var_225_21)
			end

			if arg_222_1.time_ >= var_225_17 + var_225_20 and arg_222_1.time_ < var_225_17 + var_225_20 + arg_225_0 then
				var_225_16.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_225_23 = 0
			local var_225_24 = 0.35

			if var_225_23 < arg_222_1.time_ and arg_222_1.time_ <= var_225_23 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_25 = arg_222_1:FormatText(StoryNameCfg[1083].name)

				arg_222_1.leftNameTxt_.text = var_225_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_26 = arg_222_1:GetWordFromCfg(416051052)
				local var_225_27 = arg_222_1:FormatText(var_225_26.content)

				arg_222_1.text_.text = var_225_27

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_28 = 14
				local var_225_29 = utf8.len(var_225_27)
				local var_225_30 = var_225_28 <= 0 and var_225_24 or var_225_24 * (var_225_29 / var_225_28)

				if var_225_30 > 0 and var_225_24 < var_225_30 then
					arg_222_1.talkMaxDuration = var_225_30

					if var_225_30 + var_225_23 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_30 + var_225_23
					end
				end

				arg_222_1.text_.text = var_225_27
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051052", "story_v_out_416051.awb") ~= 0 then
					local var_225_31 = manager.audio:GetVoiceLength("story_v_out_416051", "416051052", "story_v_out_416051.awb") / 1000

					if var_225_31 + var_225_23 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_31 + var_225_23
					end

					if var_225_26.prefab_name ~= "" and arg_222_1.actors_[var_225_26.prefab_name] ~= nil then
						local var_225_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_26.prefab_name].transform, "story_v_out_416051", "416051052", "story_v_out_416051.awb")

						arg_222_1:RecordAudio("416051052", var_225_32)
						arg_222_1:RecordAudio("416051052", var_225_32)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_416051", "416051052", "story_v_out_416051.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_416051", "416051052", "story_v_out_416051.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_33 = math.max(var_225_24, arg_222_1.talkMaxDuration)

			if var_225_23 <= arg_222_1.time_ and arg_222_1.time_ < var_225_23 + var_225_33 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_23) / var_225_33

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_23 + var_225_33 and arg_222_1.time_ < var_225_23 + var_225_33 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
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
	Play416051053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 416051053
		arg_226_1.duration_ = 10.87

		local var_226_0 = {
			zh = 3.166,
			ja = 10.866
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play416051054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0
			local var_229_1 = 0.325

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_2 = arg_226_1:FormatText(StoryNameCfg[1083].name)

				arg_226_1.leftNameTxt_.text = var_229_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_3 = arg_226_1:GetWordFromCfg(416051053)
				local var_229_4 = arg_226_1:FormatText(var_229_3.content)

				arg_226_1.text_.text = var_229_4

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051053", "story_v_out_416051.awb") ~= 0 then
					local var_229_8 = manager.audio:GetVoiceLength("story_v_out_416051", "416051053", "story_v_out_416051.awb") / 1000

					if var_229_8 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_8 + var_229_0
					end

					if var_229_3.prefab_name ~= "" and arg_226_1.actors_[var_229_3.prefab_name] ~= nil then
						local var_229_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_3.prefab_name].transform, "story_v_out_416051", "416051053", "story_v_out_416051.awb")

						arg_226_1:RecordAudio("416051053", var_229_9)
						arg_226_1:RecordAudio("416051053", var_229_9)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_416051", "416051053", "story_v_out_416051.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_416051", "416051053", "story_v_out_416051.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_10 = math.max(var_229_1, arg_226_1.talkMaxDuration)

			if var_229_0 <= arg_226_1.time_ and arg_226_1.time_ < var_229_0 + var_229_10 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_0) / var_229_10

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_0 + var_229_10 and arg_226_1.time_ < var_229_0 + var_229_10 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play416051054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 416051054
		arg_230_1.duration_ = 5.63

		local var_230_0 = {
			zh = 2.833,
			ja = 5.633
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play416051055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["1028"]
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.actorSpriteComps1028 == nil then
				arg_230_1.var_.actorSpriteComps1028 = var_233_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_2 = 0.125

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 and not isNil(var_233_0) then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2

				if arg_230_1.var_.actorSpriteComps1028 then
					for iter_233_0, iter_233_1 in pairs(arg_230_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_233_1 then
							if arg_230_1.isInRecall_ then
								local var_233_4 = Mathf.Lerp(iter_233_1.color.r, arg_230_1.hightColor1.r, var_233_3)
								local var_233_5 = Mathf.Lerp(iter_233_1.color.g, arg_230_1.hightColor1.g, var_233_3)
								local var_233_6 = Mathf.Lerp(iter_233_1.color.b, arg_230_1.hightColor1.b, var_233_3)

								iter_233_1.color = Color.New(var_233_4, var_233_5, var_233_6)
							else
								local var_233_7 = Mathf.Lerp(iter_233_1.color.r, 1, var_233_3)

								iter_233_1.color = Color.New(var_233_7, var_233_7, var_233_7)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.actorSpriteComps1028 then
				for iter_233_2, iter_233_3 in pairs(arg_230_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_233_3 then
						if arg_230_1.isInRecall_ then
							iter_233_3.color = arg_230_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_233_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_230_1.var_.actorSpriteComps1028 = nil
			end

			local var_233_8 = arg_230_1.actors_["10108"]
			local var_233_9 = 0

			if var_233_9 < arg_230_1.time_ and arg_230_1.time_ <= var_233_9 + arg_233_0 and not isNil(var_233_8) and arg_230_1.var_.actorSpriteComps10108 == nil then
				arg_230_1.var_.actorSpriteComps10108 = var_233_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_10 = 0.125

			if var_233_9 <= arg_230_1.time_ and arg_230_1.time_ < var_233_9 + var_233_10 and not isNil(var_233_8) then
				local var_233_11 = (arg_230_1.time_ - var_233_9) / var_233_10

				if arg_230_1.var_.actorSpriteComps10108 then
					for iter_233_4, iter_233_5 in pairs(arg_230_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_233_5 then
							if arg_230_1.isInRecall_ then
								local var_233_12 = Mathf.Lerp(iter_233_5.color.r, arg_230_1.hightColor2.r, var_233_11)
								local var_233_13 = Mathf.Lerp(iter_233_5.color.g, arg_230_1.hightColor2.g, var_233_11)
								local var_233_14 = Mathf.Lerp(iter_233_5.color.b, arg_230_1.hightColor2.b, var_233_11)

								iter_233_5.color = Color.New(var_233_12, var_233_13, var_233_14)
							else
								local var_233_15 = Mathf.Lerp(iter_233_5.color.r, 0.5, var_233_11)

								iter_233_5.color = Color.New(var_233_15, var_233_15, var_233_15)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= var_233_9 + var_233_10 and arg_230_1.time_ < var_233_9 + var_233_10 + arg_233_0 and not isNil(var_233_8) and arg_230_1.var_.actorSpriteComps10108 then
				for iter_233_6, iter_233_7 in pairs(arg_230_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_233_7 then
						if arg_230_1.isInRecall_ then
							iter_233_7.color = arg_230_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_233_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_230_1.var_.actorSpriteComps10108 = nil
			end

			local var_233_16 = arg_230_1.actors_["1028"].transform
			local var_233_17 = 0

			if var_233_17 < arg_230_1.time_ and arg_230_1.time_ <= var_233_17 + arg_233_0 then
				arg_230_1.var_.moveOldPos1028 = var_233_16.localPosition
				var_233_16.localScale = Vector3.New(1, 1, 1)

				arg_230_1:CheckSpriteTmpPos("1028", 2)

				local var_233_18 = var_233_16.childCount

				for iter_233_8 = 0, var_233_18 - 1 do
					local var_233_19 = var_233_16:GetChild(iter_233_8)

					if var_233_19.name == "split_4" or not string.find(var_233_19.name, "split") then
						var_233_19.gameObject:SetActive(true)
					else
						var_233_19.gameObject:SetActive(false)
					end
				end
			end

			local var_233_20 = 0.001

			if var_233_17 <= arg_230_1.time_ and arg_230_1.time_ < var_233_17 + var_233_20 then
				local var_233_21 = (arg_230_1.time_ - var_233_17) / var_233_20
				local var_233_22 = Vector3.New(-390, -402.7, -156.1)

				var_233_16.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1028, var_233_22, var_233_21)
			end

			if arg_230_1.time_ >= var_233_17 + var_233_20 and arg_230_1.time_ < var_233_17 + var_233_20 + arg_233_0 then
				var_233_16.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_233_23 = 0
			local var_233_24 = 0.2

			if var_233_23 < arg_230_1.time_ and arg_230_1.time_ <= var_233_23 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_25 = arg_230_1:FormatText(StoryNameCfg[327].name)

				arg_230_1.leftNameTxt_.text = var_233_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_26 = arg_230_1:GetWordFromCfg(416051054)
				local var_233_27 = arg_230_1:FormatText(var_233_26.content)

				arg_230_1.text_.text = var_233_27

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_28 = 8
				local var_233_29 = utf8.len(var_233_27)
				local var_233_30 = var_233_28 <= 0 and var_233_24 or var_233_24 * (var_233_29 / var_233_28)

				if var_233_30 > 0 and var_233_24 < var_233_30 then
					arg_230_1.talkMaxDuration = var_233_30

					if var_233_30 + var_233_23 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_30 + var_233_23
					end
				end

				arg_230_1.text_.text = var_233_27
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051054", "story_v_out_416051.awb") ~= 0 then
					local var_233_31 = manager.audio:GetVoiceLength("story_v_out_416051", "416051054", "story_v_out_416051.awb") / 1000

					if var_233_31 + var_233_23 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_31 + var_233_23
					end

					if var_233_26.prefab_name ~= "" and arg_230_1.actors_[var_233_26.prefab_name] ~= nil then
						local var_233_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_26.prefab_name].transform, "story_v_out_416051", "416051054", "story_v_out_416051.awb")

						arg_230_1:RecordAudio("416051054", var_233_32)
						arg_230_1:RecordAudio("416051054", var_233_32)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_416051", "416051054", "story_v_out_416051.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_416051", "416051054", "story_v_out_416051.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_33 = math.max(var_233_24, arg_230_1.talkMaxDuration)

			if var_233_23 <= arg_230_1.time_ and arg_230_1.time_ < var_233_23 + var_233_33 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_23) / var_233_33

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_23 + var_233_33 and arg_230_1.time_ < var_233_23 + var_233_33 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play416051055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 416051055
		arg_234_1.duration_ = 5.77

		local var_234_0 = {
			zh = 3.2,
			ja = 5.766
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play416051056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["1028"]
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.actorSpriteComps1028 == nil then
				arg_234_1.var_.actorSpriteComps1028 = var_237_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_2 = 0.125

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 and not isNil(var_237_0) then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2

				if arg_234_1.var_.actorSpriteComps1028 then
					for iter_237_0, iter_237_1 in pairs(arg_234_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_237_1 then
							if arg_234_1.isInRecall_ then
								local var_237_4 = Mathf.Lerp(iter_237_1.color.r, arg_234_1.hightColor2.r, var_237_3)
								local var_237_5 = Mathf.Lerp(iter_237_1.color.g, arg_234_1.hightColor2.g, var_237_3)
								local var_237_6 = Mathf.Lerp(iter_237_1.color.b, arg_234_1.hightColor2.b, var_237_3)

								iter_237_1.color = Color.New(var_237_4, var_237_5, var_237_6)
							else
								local var_237_7 = Mathf.Lerp(iter_237_1.color.r, 0.5, var_237_3)

								iter_237_1.color = Color.New(var_237_7, var_237_7, var_237_7)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.actorSpriteComps1028 then
				for iter_237_2, iter_237_3 in pairs(arg_234_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_237_3 then
						if arg_234_1.isInRecall_ then
							iter_237_3.color = arg_234_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_237_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_234_1.var_.actorSpriteComps1028 = nil
			end

			local var_237_8 = arg_234_1.actors_["10108"]
			local var_237_9 = 0

			if var_237_9 < arg_234_1.time_ and arg_234_1.time_ <= var_237_9 + arg_237_0 and not isNil(var_237_8) and arg_234_1.var_.actorSpriteComps10108 == nil then
				arg_234_1.var_.actorSpriteComps10108 = var_237_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_10 = 0.125

			if var_237_9 <= arg_234_1.time_ and arg_234_1.time_ < var_237_9 + var_237_10 and not isNil(var_237_8) then
				local var_237_11 = (arg_234_1.time_ - var_237_9) / var_237_10

				if arg_234_1.var_.actorSpriteComps10108 then
					for iter_237_4, iter_237_5 in pairs(arg_234_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_237_5 then
							if arg_234_1.isInRecall_ then
								local var_237_12 = Mathf.Lerp(iter_237_5.color.r, arg_234_1.hightColor1.r, var_237_11)
								local var_237_13 = Mathf.Lerp(iter_237_5.color.g, arg_234_1.hightColor1.g, var_237_11)
								local var_237_14 = Mathf.Lerp(iter_237_5.color.b, arg_234_1.hightColor1.b, var_237_11)

								iter_237_5.color = Color.New(var_237_12, var_237_13, var_237_14)
							else
								local var_237_15 = Mathf.Lerp(iter_237_5.color.r, 1, var_237_11)

								iter_237_5.color = Color.New(var_237_15, var_237_15, var_237_15)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= var_237_9 + var_237_10 and arg_234_1.time_ < var_237_9 + var_237_10 + arg_237_0 and not isNil(var_237_8) and arg_234_1.var_.actorSpriteComps10108 then
				for iter_237_6, iter_237_7 in pairs(arg_234_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_237_7 then
						if arg_234_1.isInRecall_ then
							iter_237_7.color = arg_234_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_237_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_234_1.var_.actorSpriteComps10108 = nil
			end

			local var_237_16 = 0
			local var_237_17 = 0.325

			if var_237_16 < arg_234_1.time_ and arg_234_1.time_ <= var_237_16 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_18 = arg_234_1:FormatText(StoryNameCfg[1083].name)

				arg_234_1.leftNameTxt_.text = var_237_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_19 = arg_234_1:GetWordFromCfg(416051055)
				local var_237_20 = arg_234_1:FormatText(var_237_19.content)

				arg_234_1.text_.text = var_237_20

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_21 = 13
				local var_237_22 = utf8.len(var_237_20)
				local var_237_23 = var_237_21 <= 0 and var_237_17 or var_237_17 * (var_237_22 / var_237_21)

				if var_237_23 > 0 and var_237_17 < var_237_23 then
					arg_234_1.talkMaxDuration = var_237_23

					if var_237_23 + var_237_16 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_23 + var_237_16
					end
				end

				arg_234_1.text_.text = var_237_20
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051055", "story_v_out_416051.awb") ~= 0 then
					local var_237_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051055", "story_v_out_416051.awb") / 1000

					if var_237_24 + var_237_16 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_24 + var_237_16
					end

					if var_237_19.prefab_name ~= "" and arg_234_1.actors_[var_237_19.prefab_name] ~= nil then
						local var_237_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_19.prefab_name].transform, "story_v_out_416051", "416051055", "story_v_out_416051.awb")

						arg_234_1:RecordAudio("416051055", var_237_25)
						arg_234_1:RecordAudio("416051055", var_237_25)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_416051", "416051055", "story_v_out_416051.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_416051", "416051055", "story_v_out_416051.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_26 = math.max(var_237_17, arg_234_1.talkMaxDuration)

			if var_237_16 <= arg_234_1.time_ and arg_234_1.time_ < var_237_16 + var_237_26 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_16) / var_237_26

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_16 + var_237_26 and arg_234_1.time_ < var_237_16 + var_237_26 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play416051056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 416051056
		arg_238_1.duration_ = 8.37

		local var_238_0 = {
			zh = 5.733,
			ja = 8.366
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play416051057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["10108"].transform
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.var_.moveOldPos10108 = var_241_0.localPosition
				var_241_0.localScale = Vector3.New(1, 1, 1)

				arg_238_1:CheckSpriteTmpPos("10108", 7)

				local var_241_2 = var_241_0.childCount

				for iter_241_0 = 0, var_241_2 - 1 do
					local var_241_3 = var_241_0:GetChild(iter_241_0)

					if var_241_3.name == "" or not string.find(var_241_3.name, "split") then
						var_241_3.gameObject:SetActive(true)
					else
						var_241_3.gameObject:SetActive(false)
					end
				end
			end

			local var_241_4 = 0.001

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_4 then
				local var_241_5 = (arg_238_1.time_ - var_241_1) / var_241_4
				local var_241_6 = Vector3.New(0, -2000, 0)

				var_241_0.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos10108, var_241_6, var_241_5)
			end

			if arg_238_1.time_ >= var_241_1 + var_241_4 and arg_238_1.time_ < var_241_1 + var_241_4 + arg_241_0 then
				var_241_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_241_7 = arg_238_1.actors_["1028"]
			local var_241_8 = 0

			if var_241_8 < arg_238_1.time_ and arg_238_1.time_ <= var_241_8 + arg_241_0 and not isNil(var_241_7) and arg_238_1.var_.actorSpriteComps1028 == nil then
				arg_238_1.var_.actorSpriteComps1028 = var_241_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_9 = 0.125

			if var_241_8 <= arg_238_1.time_ and arg_238_1.time_ < var_241_8 + var_241_9 and not isNil(var_241_7) then
				local var_241_10 = (arg_238_1.time_ - var_241_8) / var_241_9

				if arg_238_1.var_.actorSpriteComps1028 then
					for iter_241_1, iter_241_2 in pairs(arg_238_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_241_2 then
							if arg_238_1.isInRecall_ then
								local var_241_11 = Mathf.Lerp(iter_241_2.color.r, arg_238_1.hightColor2.r, var_241_10)
								local var_241_12 = Mathf.Lerp(iter_241_2.color.g, arg_238_1.hightColor2.g, var_241_10)
								local var_241_13 = Mathf.Lerp(iter_241_2.color.b, arg_238_1.hightColor2.b, var_241_10)

								iter_241_2.color = Color.New(var_241_11, var_241_12, var_241_13)
							else
								local var_241_14 = Mathf.Lerp(iter_241_2.color.r, 0.5, var_241_10)

								iter_241_2.color = Color.New(var_241_14, var_241_14, var_241_14)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= var_241_8 + var_241_9 and arg_238_1.time_ < var_241_8 + var_241_9 + arg_241_0 and not isNil(var_241_7) and arg_238_1.var_.actorSpriteComps1028 then
				for iter_241_3, iter_241_4 in pairs(arg_238_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_241_4 then
						if arg_238_1.isInRecall_ then
							iter_241_4.color = arg_238_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_241_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_238_1.var_.actorSpriteComps1028 = nil
			end

			local var_241_15 = arg_238_1.actors_["1086"]
			local var_241_16 = 0

			if var_241_16 < arg_238_1.time_ and arg_238_1.time_ <= var_241_16 + arg_241_0 and not isNil(var_241_15) and arg_238_1.var_.actorSpriteComps1086 == nil then
				arg_238_1.var_.actorSpriteComps1086 = var_241_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_17 = 0.125

			if var_241_16 <= arg_238_1.time_ and arg_238_1.time_ < var_241_16 + var_241_17 and not isNil(var_241_15) then
				local var_241_18 = (arg_238_1.time_ - var_241_16) / var_241_17

				if arg_238_1.var_.actorSpriteComps1086 then
					for iter_241_5, iter_241_6 in pairs(arg_238_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_241_6 then
							if arg_238_1.isInRecall_ then
								local var_241_19 = Mathf.Lerp(iter_241_6.color.r, arg_238_1.hightColor1.r, var_241_18)
								local var_241_20 = Mathf.Lerp(iter_241_6.color.g, arg_238_1.hightColor1.g, var_241_18)
								local var_241_21 = Mathf.Lerp(iter_241_6.color.b, arg_238_1.hightColor1.b, var_241_18)

								iter_241_6.color = Color.New(var_241_19, var_241_20, var_241_21)
							else
								local var_241_22 = Mathf.Lerp(iter_241_6.color.r, 1, var_241_18)

								iter_241_6.color = Color.New(var_241_22, var_241_22, var_241_22)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= var_241_16 + var_241_17 and arg_238_1.time_ < var_241_16 + var_241_17 + arg_241_0 and not isNil(var_241_15) and arg_238_1.var_.actorSpriteComps1086 then
				for iter_241_7, iter_241_8 in pairs(arg_238_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_241_8 then
						if arg_238_1.isInRecall_ then
							iter_241_8.color = arg_238_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_241_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_238_1.var_.actorSpriteComps1086 = nil
			end

			local var_241_23 = arg_238_1.actors_["1086"].transform
			local var_241_24 = 0

			if var_241_24 < arg_238_1.time_ and arg_238_1.time_ <= var_241_24 + arg_241_0 then
				arg_238_1.var_.moveOldPos1086 = var_241_23.localPosition
				var_241_23.localScale = Vector3.New(1, 1, 1)

				arg_238_1:CheckSpriteTmpPos("1086", 4)

				local var_241_25 = var_241_23.childCount

				for iter_241_9 = 0, var_241_25 - 1 do
					local var_241_26 = var_241_23:GetChild(iter_241_9)

					if var_241_26.name == "split_2" or not string.find(var_241_26.name, "split") then
						var_241_26.gameObject:SetActive(true)
					else
						var_241_26.gameObject:SetActive(false)
					end
				end
			end

			local var_241_27 = 0.001

			if var_241_24 <= arg_238_1.time_ and arg_238_1.time_ < var_241_24 + var_241_27 then
				local var_241_28 = (arg_238_1.time_ - var_241_24) / var_241_27
				local var_241_29 = Vector3.New(390, -404.2, -237.9)

				var_241_23.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1086, var_241_29, var_241_28)
			end

			if arg_238_1.time_ >= var_241_24 + var_241_27 and arg_238_1.time_ < var_241_24 + var_241_27 + arg_241_0 then
				var_241_23.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_241_30 = 0
			local var_241_31 = 0.675

			if var_241_30 < arg_238_1.time_ and arg_238_1.time_ <= var_241_30 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_32 = arg_238_1:FormatText(StoryNameCfg[1080].name)

				arg_238_1.leftNameTxt_.text = var_241_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_33 = arg_238_1:GetWordFromCfg(416051056)
				local var_241_34 = arg_238_1:FormatText(var_241_33.content)

				arg_238_1.text_.text = var_241_34

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_35 = 27
				local var_241_36 = utf8.len(var_241_34)
				local var_241_37 = var_241_35 <= 0 and var_241_31 or var_241_31 * (var_241_36 / var_241_35)

				if var_241_37 > 0 and var_241_31 < var_241_37 then
					arg_238_1.talkMaxDuration = var_241_37

					if var_241_37 + var_241_30 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_37 + var_241_30
					end
				end

				arg_238_1.text_.text = var_241_34
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051056", "story_v_out_416051.awb") ~= 0 then
					local var_241_38 = manager.audio:GetVoiceLength("story_v_out_416051", "416051056", "story_v_out_416051.awb") / 1000

					if var_241_38 + var_241_30 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_38 + var_241_30
					end

					if var_241_33.prefab_name ~= "" and arg_238_1.actors_[var_241_33.prefab_name] ~= nil then
						local var_241_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_33.prefab_name].transform, "story_v_out_416051", "416051056", "story_v_out_416051.awb")

						arg_238_1:RecordAudio("416051056", var_241_39)
						arg_238_1:RecordAudio("416051056", var_241_39)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_416051", "416051056", "story_v_out_416051.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_416051", "416051056", "story_v_out_416051.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_40 = math.max(var_241_31, arg_238_1.talkMaxDuration)

			if var_241_30 <= arg_238_1.time_ and arg_238_1.time_ < var_241_30 + var_241_40 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_30) / var_241_40

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_30 + var_241_40 and arg_238_1.time_ < var_241_30 + var_241_40 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play416051057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 416051057
		arg_242_1.duration_ = 9.73

		local var_242_0 = {
			zh = 7.4,
			ja = 9.733
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play416051058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["1086"]
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.actorSpriteComps1086 == nil then
				arg_242_1.var_.actorSpriteComps1086 = var_245_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_245_2 = 0.125

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 and not isNil(var_245_0) then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2

				if arg_242_1.var_.actorSpriteComps1086 then
					for iter_245_0, iter_245_1 in pairs(arg_242_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_245_1 then
							if arg_242_1.isInRecall_ then
								local var_245_4 = Mathf.Lerp(iter_245_1.color.r, arg_242_1.hightColor2.r, var_245_3)
								local var_245_5 = Mathf.Lerp(iter_245_1.color.g, arg_242_1.hightColor2.g, var_245_3)
								local var_245_6 = Mathf.Lerp(iter_245_1.color.b, arg_242_1.hightColor2.b, var_245_3)

								iter_245_1.color = Color.New(var_245_4, var_245_5, var_245_6)
							else
								local var_245_7 = Mathf.Lerp(iter_245_1.color.r, 0.5, var_245_3)

								iter_245_1.color = Color.New(var_245_7, var_245_7, var_245_7)
							end
						end
					end
				end
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.actorSpriteComps1086 then
				for iter_245_2, iter_245_3 in pairs(arg_242_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_245_3 then
						if arg_242_1.isInRecall_ then
							iter_245_3.color = arg_242_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_245_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_242_1.var_.actorSpriteComps1086 = nil
			end

			local var_245_8 = arg_242_1.actors_["1028"]
			local var_245_9 = 0

			if var_245_9 < arg_242_1.time_ and arg_242_1.time_ <= var_245_9 + arg_245_0 and not isNil(var_245_8) and arg_242_1.var_.actorSpriteComps1028 == nil then
				arg_242_1.var_.actorSpriteComps1028 = var_245_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_245_10 = 0.125

			if var_245_9 <= arg_242_1.time_ and arg_242_1.time_ < var_245_9 + var_245_10 and not isNil(var_245_8) then
				local var_245_11 = (arg_242_1.time_ - var_245_9) / var_245_10

				if arg_242_1.var_.actorSpriteComps1028 then
					for iter_245_4, iter_245_5 in pairs(arg_242_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_245_5 then
							if arg_242_1.isInRecall_ then
								local var_245_12 = Mathf.Lerp(iter_245_5.color.r, arg_242_1.hightColor1.r, var_245_11)
								local var_245_13 = Mathf.Lerp(iter_245_5.color.g, arg_242_1.hightColor1.g, var_245_11)
								local var_245_14 = Mathf.Lerp(iter_245_5.color.b, arg_242_1.hightColor1.b, var_245_11)

								iter_245_5.color = Color.New(var_245_12, var_245_13, var_245_14)
							else
								local var_245_15 = Mathf.Lerp(iter_245_5.color.r, 1, var_245_11)

								iter_245_5.color = Color.New(var_245_15, var_245_15, var_245_15)
							end
						end
					end
				end
			end

			if arg_242_1.time_ >= var_245_9 + var_245_10 and arg_242_1.time_ < var_245_9 + var_245_10 + arg_245_0 and not isNil(var_245_8) and arg_242_1.var_.actorSpriteComps1028 then
				for iter_245_6, iter_245_7 in pairs(arg_242_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_245_7 then
						if arg_242_1.isInRecall_ then
							iter_245_7.color = arg_242_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_245_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_242_1.var_.actorSpriteComps1028 = nil
			end

			local var_245_16 = arg_242_1.actors_["1028"].transform
			local var_245_17 = 0

			if var_245_17 < arg_242_1.time_ and arg_242_1.time_ <= var_245_17 + arg_245_0 then
				arg_242_1.var_.moveOldPos1028 = var_245_16.localPosition
				var_245_16.localScale = Vector3.New(1, 1, 1)

				arg_242_1:CheckSpriteTmpPos("1028", 2)

				local var_245_18 = var_245_16.childCount

				for iter_245_8 = 0, var_245_18 - 1 do
					local var_245_19 = var_245_16:GetChild(iter_245_8)

					if var_245_19.name == "" or not string.find(var_245_19.name, "split") then
						var_245_19.gameObject:SetActive(true)
					else
						var_245_19.gameObject:SetActive(false)
					end
				end
			end

			local var_245_20 = 0.001

			if var_245_17 <= arg_242_1.time_ and arg_242_1.time_ < var_245_17 + var_245_20 then
				local var_245_21 = (arg_242_1.time_ - var_245_17) / var_245_20
				local var_245_22 = Vector3.New(-390, -402.7, -156.1)

				var_245_16.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1028, var_245_22, var_245_21)
			end

			if arg_242_1.time_ >= var_245_17 + var_245_20 and arg_242_1.time_ < var_245_17 + var_245_20 + arg_245_0 then
				var_245_16.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_245_23 = 0
			local var_245_24 = 0.8

			if var_245_23 < arg_242_1.time_ and arg_242_1.time_ <= var_245_23 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_25 = arg_242_1:FormatText(StoryNameCfg[327].name)

				arg_242_1.leftNameTxt_.text = var_245_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_26 = arg_242_1:GetWordFromCfg(416051057)
				local var_245_27 = arg_242_1:FormatText(var_245_26.content)

				arg_242_1.text_.text = var_245_27

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_28 = 32
				local var_245_29 = utf8.len(var_245_27)
				local var_245_30 = var_245_28 <= 0 and var_245_24 or var_245_24 * (var_245_29 / var_245_28)

				if var_245_30 > 0 and var_245_24 < var_245_30 then
					arg_242_1.talkMaxDuration = var_245_30

					if var_245_30 + var_245_23 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_30 + var_245_23
					end
				end

				arg_242_1.text_.text = var_245_27
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051057", "story_v_out_416051.awb") ~= 0 then
					local var_245_31 = manager.audio:GetVoiceLength("story_v_out_416051", "416051057", "story_v_out_416051.awb") / 1000

					if var_245_31 + var_245_23 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_31 + var_245_23
					end

					if var_245_26.prefab_name ~= "" and arg_242_1.actors_[var_245_26.prefab_name] ~= nil then
						local var_245_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_26.prefab_name].transform, "story_v_out_416051", "416051057", "story_v_out_416051.awb")

						arg_242_1:RecordAudio("416051057", var_245_32)
						arg_242_1:RecordAudio("416051057", var_245_32)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_416051", "416051057", "story_v_out_416051.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_416051", "416051057", "story_v_out_416051.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_33 = math.max(var_245_24, arg_242_1.talkMaxDuration)

			if var_245_23 <= arg_242_1.time_ and arg_242_1.time_ < var_245_23 + var_245_33 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_23) / var_245_33

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_23 + var_245_33 and arg_242_1.time_ < var_245_23 + var_245_33 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play416051058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 416051058
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play416051059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["1086"]
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.actorSpriteComps1086 == nil then
				arg_246_1.var_.actorSpriteComps1086 = var_249_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_2 = 0.125

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 and not isNil(var_249_0) then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2

				if arg_246_1.var_.actorSpriteComps1086 then
					for iter_249_0, iter_249_1 in pairs(arg_246_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_249_1 then
							if arg_246_1.isInRecall_ then
								local var_249_4 = Mathf.Lerp(iter_249_1.color.r, arg_246_1.hightColor2.r, var_249_3)
								local var_249_5 = Mathf.Lerp(iter_249_1.color.g, arg_246_1.hightColor2.g, var_249_3)
								local var_249_6 = Mathf.Lerp(iter_249_1.color.b, arg_246_1.hightColor2.b, var_249_3)

								iter_249_1.color = Color.New(var_249_4, var_249_5, var_249_6)
							else
								local var_249_7 = Mathf.Lerp(iter_249_1.color.r, 0.5, var_249_3)

								iter_249_1.color = Color.New(var_249_7, var_249_7, var_249_7)
							end
						end
					end
				end
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.actorSpriteComps1086 then
				for iter_249_2, iter_249_3 in pairs(arg_246_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_249_3 then
						if arg_246_1.isInRecall_ then
							iter_249_3.color = arg_246_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_249_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_246_1.var_.actorSpriteComps1086 = nil
			end

			local var_249_8 = arg_246_1.actors_["1028"]
			local var_249_9 = 0

			if var_249_9 < arg_246_1.time_ and arg_246_1.time_ <= var_249_9 + arg_249_0 and not isNil(var_249_8) and arg_246_1.var_.actorSpriteComps1028 == nil then
				arg_246_1.var_.actorSpriteComps1028 = var_249_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_10 = 0.125

			if var_249_9 <= arg_246_1.time_ and arg_246_1.time_ < var_249_9 + var_249_10 and not isNil(var_249_8) then
				local var_249_11 = (arg_246_1.time_ - var_249_9) / var_249_10

				if arg_246_1.var_.actorSpriteComps1028 then
					for iter_249_4, iter_249_5 in pairs(arg_246_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_249_5 then
							if arg_246_1.isInRecall_ then
								local var_249_12 = Mathf.Lerp(iter_249_5.color.r, arg_246_1.hightColor2.r, var_249_11)
								local var_249_13 = Mathf.Lerp(iter_249_5.color.g, arg_246_1.hightColor2.g, var_249_11)
								local var_249_14 = Mathf.Lerp(iter_249_5.color.b, arg_246_1.hightColor2.b, var_249_11)

								iter_249_5.color = Color.New(var_249_12, var_249_13, var_249_14)
							else
								local var_249_15 = Mathf.Lerp(iter_249_5.color.r, 0.5, var_249_11)

								iter_249_5.color = Color.New(var_249_15, var_249_15, var_249_15)
							end
						end
					end
				end
			end

			if arg_246_1.time_ >= var_249_9 + var_249_10 and arg_246_1.time_ < var_249_9 + var_249_10 + arg_249_0 and not isNil(var_249_8) and arg_246_1.var_.actorSpriteComps1028 then
				for iter_249_6, iter_249_7 in pairs(arg_246_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_249_7 then
						if arg_246_1.isInRecall_ then
							iter_249_7.color = arg_246_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_249_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_246_1.var_.actorSpriteComps1028 = nil
			end

			local var_249_16 = arg_246_1.actors_["1028"].transform
			local var_249_17 = 0

			if var_249_17 < arg_246_1.time_ and arg_246_1.time_ <= var_249_17 + arg_249_0 then
				arg_246_1.var_.moveOldPos1028 = var_249_16.localPosition
				var_249_16.localScale = Vector3.New(1, 1, 1)

				arg_246_1:CheckSpriteTmpPos("1028", 7)

				local var_249_18 = var_249_16.childCount

				for iter_249_8 = 0, var_249_18 - 1 do
					local var_249_19 = var_249_16:GetChild(iter_249_8)

					if var_249_19.name == "split_2" or not string.find(var_249_19.name, "split") then
						var_249_19.gameObject:SetActive(true)
					else
						var_249_19.gameObject:SetActive(false)
					end
				end
			end

			local var_249_20 = 0.001

			if var_249_17 <= arg_246_1.time_ and arg_246_1.time_ < var_249_17 + var_249_20 then
				local var_249_21 = (arg_246_1.time_ - var_249_17) / var_249_20
				local var_249_22 = Vector3.New(0, -2000, 0)

				var_249_16.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1028, var_249_22, var_249_21)
			end

			if arg_246_1.time_ >= var_249_17 + var_249_20 and arg_246_1.time_ < var_249_17 + var_249_20 + arg_249_0 then
				var_249_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_249_23 = arg_246_1.actors_["1086"].transform
			local var_249_24 = 0

			if var_249_24 < arg_246_1.time_ and arg_246_1.time_ <= var_249_24 + arg_249_0 then
				arg_246_1.var_.moveOldPos1086 = var_249_23.localPosition
				var_249_23.localScale = Vector3.New(1, 1, 1)

				arg_246_1:CheckSpriteTmpPos("1086", 7)

				local var_249_25 = var_249_23.childCount

				for iter_249_9 = 0, var_249_25 - 1 do
					local var_249_26 = var_249_23:GetChild(iter_249_9)

					if var_249_26.name == "split_2" or not string.find(var_249_26.name, "split") then
						var_249_26.gameObject:SetActive(true)
					else
						var_249_26.gameObject:SetActive(false)
					end
				end
			end

			local var_249_27 = 0.001

			if var_249_24 <= arg_246_1.time_ and arg_246_1.time_ < var_249_24 + var_249_27 then
				local var_249_28 = (arg_246_1.time_ - var_249_24) / var_249_27
				local var_249_29 = Vector3.New(0, -2000, 0)

				var_249_23.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1086, var_249_29, var_249_28)
			end

			if arg_246_1.time_ >= var_249_24 + var_249_27 and arg_246_1.time_ < var_249_24 + var_249_27 + arg_249_0 then
				var_249_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_249_30 = 0
			local var_249_31 = 1.675

			if var_249_30 < arg_246_1.time_ and arg_246_1.time_ <= var_249_30 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_32 = arg_246_1:GetWordFromCfg(416051058)
				local var_249_33 = arg_246_1:FormatText(var_249_32.content)

				arg_246_1.text_.text = var_249_33

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_34 = 67
				local var_249_35 = utf8.len(var_249_33)
				local var_249_36 = var_249_34 <= 0 and var_249_31 or var_249_31 * (var_249_35 / var_249_34)

				if var_249_36 > 0 and var_249_31 < var_249_36 then
					arg_246_1.talkMaxDuration = var_249_36

					if var_249_36 + var_249_30 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_36 + var_249_30
					end
				end

				arg_246_1.text_.text = var_249_33
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_37 = math.max(var_249_31, arg_246_1.talkMaxDuration)

			if var_249_30 <= arg_246_1.time_ and arg_246_1.time_ < var_249_30 + var_249_37 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_30) / var_249_37

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_30 + var_249_37 and arg_246_1.time_ < var_249_30 + var_249_37 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play416051059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 416051059
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play416051060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0
			local var_253_1 = 1

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				local var_253_2 = "play"
				local var_253_3 = "effect"

				arg_250_1:AudioAction(var_253_2, var_253_3, "se_story_17", "se_story_17_door_close02", "")
			end

			local var_253_4 = 0
			local var_253_5 = 0.9

			if var_253_4 < arg_250_1.time_ and arg_250_1.time_ <= var_253_4 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_6 = arg_250_1:GetWordFromCfg(416051059)
				local var_253_7 = arg_250_1:FormatText(var_253_6.content)

				arg_250_1.text_.text = var_253_7

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_8 = 36
				local var_253_9 = utf8.len(var_253_7)
				local var_253_10 = var_253_8 <= 0 and var_253_5 or var_253_5 * (var_253_9 / var_253_8)

				if var_253_10 > 0 and var_253_5 < var_253_10 then
					arg_250_1.talkMaxDuration = var_253_10

					if var_253_10 + var_253_4 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_10 + var_253_4
					end
				end

				arg_250_1.text_.text = var_253_7
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_11 = math.max(var_253_5, arg_250_1.talkMaxDuration)

			if var_253_4 <= arg_250_1.time_ and arg_250_1.time_ < var_253_4 + var_253_11 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_4) / var_253_11

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_4 + var_253_11 and arg_250_1.time_ < var_253_4 + var_253_11 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play416051060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 416051060
		arg_254_1.duration_ = 2.3

		local var_254_0 = {
			zh = 1.733,
			ja = 2.3
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play416051061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1086"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.actorSpriteComps1086 == nil then
				arg_254_1.var_.actorSpriteComps1086 = var_257_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_2 = 0.125

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.actorSpriteComps1086 then
					for iter_257_0, iter_257_1 in pairs(arg_254_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_257_1 then
							if arg_254_1.isInRecall_ then
								local var_257_4 = Mathf.Lerp(iter_257_1.color.r, arg_254_1.hightColor1.r, var_257_3)
								local var_257_5 = Mathf.Lerp(iter_257_1.color.g, arg_254_1.hightColor1.g, var_257_3)
								local var_257_6 = Mathf.Lerp(iter_257_1.color.b, arg_254_1.hightColor1.b, var_257_3)

								iter_257_1.color = Color.New(var_257_4, var_257_5, var_257_6)
							else
								local var_257_7 = Mathf.Lerp(iter_257_1.color.r, 1, var_257_3)

								iter_257_1.color = Color.New(var_257_7, var_257_7, var_257_7)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.actorSpriteComps1086 then
				for iter_257_2, iter_257_3 in pairs(arg_254_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_257_3 then
						if arg_254_1.isInRecall_ then
							iter_257_3.color = arg_254_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_257_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_254_1.var_.actorSpriteComps1086 = nil
			end

			local var_257_8 = arg_254_1.actors_["1028"]
			local var_257_9 = 0

			if var_257_9 < arg_254_1.time_ and arg_254_1.time_ <= var_257_9 + arg_257_0 and not isNil(var_257_8) and arg_254_1.var_.actorSpriteComps1028 == nil then
				arg_254_1.var_.actorSpriteComps1028 = var_257_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_10 = 0.125

			if var_257_9 <= arg_254_1.time_ and arg_254_1.time_ < var_257_9 + var_257_10 and not isNil(var_257_8) then
				local var_257_11 = (arg_254_1.time_ - var_257_9) / var_257_10

				if arg_254_1.var_.actorSpriteComps1028 then
					for iter_257_4, iter_257_5 in pairs(arg_254_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_257_5 then
							if arg_254_1.isInRecall_ then
								local var_257_12 = Mathf.Lerp(iter_257_5.color.r, arg_254_1.hightColor2.r, var_257_11)
								local var_257_13 = Mathf.Lerp(iter_257_5.color.g, arg_254_1.hightColor2.g, var_257_11)
								local var_257_14 = Mathf.Lerp(iter_257_5.color.b, arg_254_1.hightColor2.b, var_257_11)

								iter_257_5.color = Color.New(var_257_12, var_257_13, var_257_14)
							else
								local var_257_15 = Mathf.Lerp(iter_257_5.color.r, 0.5, var_257_11)

								iter_257_5.color = Color.New(var_257_15, var_257_15, var_257_15)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= var_257_9 + var_257_10 and arg_254_1.time_ < var_257_9 + var_257_10 + arg_257_0 and not isNil(var_257_8) and arg_254_1.var_.actorSpriteComps1028 then
				for iter_257_6, iter_257_7 in pairs(arg_254_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_257_7 then
						if arg_254_1.isInRecall_ then
							iter_257_7.color = arg_254_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_257_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_254_1.var_.actorSpriteComps1028 = nil
			end

			local var_257_16 = arg_254_1.actors_["1028"].transform
			local var_257_17 = 0

			if var_257_17 < arg_254_1.time_ and arg_254_1.time_ <= var_257_17 + arg_257_0 then
				arg_254_1.var_.moveOldPos1028 = var_257_16.localPosition
				var_257_16.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("1028", 2)

				local var_257_18 = var_257_16.childCount

				for iter_257_8 = 0, var_257_18 - 1 do
					local var_257_19 = var_257_16:GetChild(iter_257_8)

					if var_257_19.name == "split_2" or not string.find(var_257_19.name, "split") then
						var_257_19.gameObject:SetActive(true)
					else
						var_257_19.gameObject:SetActive(false)
					end
				end
			end

			local var_257_20 = 0.001

			if var_257_17 <= arg_254_1.time_ and arg_254_1.time_ < var_257_17 + var_257_20 then
				local var_257_21 = (arg_254_1.time_ - var_257_17) / var_257_20
				local var_257_22 = Vector3.New(-390, -402.7, -156.1)

				var_257_16.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1028, var_257_22, var_257_21)
			end

			if arg_254_1.time_ >= var_257_17 + var_257_20 and arg_254_1.time_ < var_257_17 + var_257_20 + arg_257_0 then
				var_257_16.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_257_23 = arg_254_1.actors_["1086"].transform
			local var_257_24 = 0

			if var_257_24 < arg_254_1.time_ and arg_254_1.time_ <= var_257_24 + arg_257_0 then
				arg_254_1.var_.moveOldPos1086 = var_257_23.localPosition
				var_257_23.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("1086", 4)

				local var_257_25 = var_257_23.childCount

				for iter_257_9 = 0, var_257_25 - 1 do
					local var_257_26 = var_257_23:GetChild(iter_257_9)

					if var_257_26.name == "split_1" or not string.find(var_257_26.name, "split") then
						var_257_26.gameObject:SetActive(true)
					else
						var_257_26.gameObject:SetActive(false)
					end
				end
			end

			local var_257_27 = 0.001

			if var_257_24 <= arg_254_1.time_ and arg_254_1.time_ < var_257_24 + var_257_27 then
				local var_257_28 = (arg_254_1.time_ - var_257_24) / var_257_27
				local var_257_29 = Vector3.New(390, -404.2, -237.9)

				var_257_23.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1086, var_257_29, var_257_28)
			end

			if arg_254_1.time_ >= var_257_24 + var_257_27 and arg_254_1.time_ < var_257_24 + var_257_27 + arg_257_0 then
				var_257_23.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_257_30 = 0
			local var_257_31 = 0.175

			if var_257_30 < arg_254_1.time_ and arg_254_1.time_ <= var_257_30 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_32 = arg_254_1:FormatText(StoryNameCfg[1080].name)

				arg_254_1.leftNameTxt_.text = var_257_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_33 = arg_254_1:GetWordFromCfg(416051060)
				local var_257_34 = arg_254_1:FormatText(var_257_33.content)

				arg_254_1.text_.text = var_257_34

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_35 = 7
				local var_257_36 = utf8.len(var_257_34)
				local var_257_37 = var_257_35 <= 0 and var_257_31 or var_257_31 * (var_257_36 / var_257_35)

				if var_257_37 > 0 and var_257_31 < var_257_37 then
					arg_254_1.talkMaxDuration = var_257_37

					if var_257_37 + var_257_30 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_37 + var_257_30
					end
				end

				arg_254_1.text_.text = var_257_34
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051060", "story_v_out_416051.awb") ~= 0 then
					local var_257_38 = manager.audio:GetVoiceLength("story_v_out_416051", "416051060", "story_v_out_416051.awb") / 1000

					if var_257_38 + var_257_30 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_38 + var_257_30
					end

					if var_257_33.prefab_name ~= "" and arg_254_1.actors_[var_257_33.prefab_name] ~= nil then
						local var_257_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_33.prefab_name].transform, "story_v_out_416051", "416051060", "story_v_out_416051.awb")

						arg_254_1:RecordAudio("416051060", var_257_39)
						arg_254_1:RecordAudio("416051060", var_257_39)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_416051", "416051060", "story_v_out_416051.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_416051", "416051060", "story_v_out_416051.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_40 = math.max(var_257_31, arg_254_1.talkMaxDuration)

			if var_257_30 <= arg_254_1.time_ and arg_254_1.time_ < var_257_30 + var_257_40 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_30) / var_257_40

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_30 + var_257_40 and arg_254_1.time_ < var_257_30 + var_257_40 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play416051061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 416051061
		arg_258_1.duration_ = 11

		local var_258_0 = {
			zh = 10.466,
			ja = 11
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play416051062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 4

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				arg_258_1.allBtn_.enabled = false
			end

			local var_261_1 = 0.3

			if arg_258_1.time_ >= var_261_0 + var_261_1 and arg_258_1.time_ < var_261_0 + var_261_1 + arg_261_0 then
				arg_258_1.allBtn_.enabled = true
			end

			local var_261_2 = "I13f"

			if arg_258_1.bgs_[var_261_2] == nil then
				local var_261_3 = Object.Instantiate(arg_258_1.paintGo_)

				var_261_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_261_2)
				var_261_3.name = var_261_2
				var_261_3.transform.parent = arg_258_1.stage_.transform
				var_261_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_258_1.bgs_[var_261_2] = var_261_3
			end

			local var_261_4 = 2

			if var_261_4 < arg_258_1.time_ and arg_258_1.time_ <= var_261_4 + arg_261_0 then
				local var_261_5 = manager.ui.mainCamera.transform.localPosition
				local var_261_6 = Vector3.New(0, 0, 10) + Vector3.New(var_261_5.x, var_261_5.y, 0)
				local var_261_7 = arg_258_1.bgs_.I13f

				var_261_7.transform.localPosition = var_261_6
				var_261_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_261_8 = var_261_7:GetComponent("SpriteRenderer")

				if var_261_8 and var_261_8.sprite then
					local var_261_9 = (var_261_7.transform.localPosition - var_261_5).z
					local var_261_10 = manager.ui.mainCameraCom_
					local var_261_11 = 2 * var_261_9 * Mathf.Tan(var_261_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_261_12 = var_261_11 * var_261_10.aspect
					local var_261_13 = var_261_8.sprite.bounds.size.x
					local var_261_14 = var_261_8.sprite.bounds.size.y
					local var_261_15 = var_261_12 / var_261_13
					local var_261_16 = var_261_11 / var_261_14
					local var_261_17 = var_261_16 < var_261_15 and var_261_15 or var_261_16

					var_261_7.transform.localScale = Vector3.New(var_261_17, var_261_17, 0)
				end

				for iter_261_0, iter_261_1 in pairs(arg_258_1.bgs_) do
					if iter_261_0 ~= "I13f" then
						iter_261_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_261_18 = 0

			if var_261_18 < arg_258_1.time_ and arg_258_1.time_ <= var_261_18 + arg_261_0 then
				arg_258_1.mask_.enabled = true
				arg_258_1.mask_.raycastTarget = true

				arg_258_1:SetGaussion(false)
			end

			local var_261_19 = 2

			if var_261_18 <= arg_258_1.time_ and arg_258_1.time_ < var_261_18 + var_261_19 then
				local var_261_20 = (arg_258_1.time_ - var_261_18) / var_261_19
				local var_261_21 = Color.New(0, 0, 0)

				var_261_21.a = Mathf.Lerp(0, 1, var_261_20)
				arg_258_1.mask_.color = var_261_21
			end

			if arg_258_1.time_ >= var_261_18 + var_261_19 and arg_258_1.time_ < var_261_18 + var_261_19 + arg_261_0 then
				local var_261_22 = Color.New(0, 0, 0)

				var_261_22.a = 1
				arg_258_1.mask_.color = var_261_22
			end

			local var_261_23 = 2

			if var_261_23 < arg_258_1.time_ and arg_258_1.time_ <= var_261_23 + arg_261_0 then
				arg_258_1.mask_.enabled = true
				arg_258_1.mask_.raycastTarget = true

				arg_258_1:SetGaussion(false)
			end

			local var_261_24 = 2

			if var_261_23 <= arg_258_1.time_ and arg_258_1.time_ < var_261_23 + var_261_24 then
				local var_261_25 = (arg_258_1.time_ - var_261_23) / var_261_24
				local var_261_26 = Color.New(0, 0, 0)

				var_261_26.a = Mathf.Lerp(1, 0, var_261_25)
				arg_258_1.mask_.color = var_261_26
			end

			if arg_258_1.time_ >= var_261_23 + var_261_24 and arg_258_1.time_ < var_261_23 + var_261_24 + arg_261_0 then
				local var_261_27 = Color.New(0, 0, 0)
				local var_261_28 = 0

				arg_258_1.mask_.enabled = false
				var_261_27.a = var_261_28
				arg_258_1.mask_.color = var_261_27
			end

			local var_261_29 = arg_258_1.actors_["1028"].transform
			local var_261_30 = 1.966

			if var_261_30 < arg_258_1.time_ and arg_258_1.time_ <= var_261_30 + arg_261_0 then
				arg_258_1.var_.moveOldPos1028 = var_261_29.localPosition
				var_261_29.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("1028", 7)

				local var_261_31 = var_261_29.childCount

				for iter_261_2 = 0, var_261_31 - 1 do
					local var_261_32 = var_261_29:GetChild(iter_261_2)

					if var_261_32.name == "" or not string.find(var_261_32.name, "split") then
						var_261_32.gameObject:SetActive(true)
					else
						var_261_32.gameObject:SetActive(false)
					end
				end
			end

			local var_261_33 = 0.001

			if var_261_30 <= arg_258_1.time_ and arg_258_1.time_ < var_261_30 + var_261_33 then
				local var_261_34 = (arg_258_1.time_ - var_261_30) / var_261_33
				local var_261_35 = Vector3.New(0, -2000, 0)

				var_261_29.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1028, var_261_35, var_261_34)
			end

			if arg_258_1.time_ >= var_261_30 + var_261_33 and arg_258_1.time_ < var_261_30 + var_261_33 + arg_261_0 then
				var_261_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_261_36 = arg_258_1.actors_["1086"].transform
			local var_261_37 = 1.966

			if var_261_37 < arg_258_1.time_ and arg_258_1.time_ <= var_261_37 + arg_261_0 then
				arg_258_1.var_.moveOldPos1086 = var_261_36.localPosition
				var_261_36.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("1086", 7)

				local var_261_38 = var_261_36.childCount

				for iter_261_3 = 0, var_261_38 - 1 do
					local var_261_39 = var_261_36:GetChild(iter_261_3)

					if var_261_39.name == "" or not string.find(var_261_39.name, "split") then
						var_261_39.gameObject:SetActive(true)
					else
						var_261_39.gameObject:SetActive(false)
					end
				end
			end

			local var_261_40 = 0.001

			if var_261_37 <= arg_258_1.time_ and arg_258_1.time_ < var_261_37 + var_261_40 then
				local var_261_41 = (arg_258_1.time_ - var_261_37) / var_261_40
				local var_261_42 = Vector3.New(0, -2000, 0)

				var_261_36.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1086, var_261_42, var_261_41)
			end

			if arg_258_1.time_ >= var_261_37 + var_261_40 and arg_258_1.time_ < var_261_37 + var_261_40 + arg_261_0 then
				var_261_36.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_261_43 = arg_258_1.actors_["1086"].transform
			local var_261_44 = 3.46733333333333

			if var_261_44 < arg_258_1.time_ and arg_258_1.time_ <= var_261_44 + arg_261_0 then
				arg_258_1.var_.moveOldPos1086 = var_261_43.localPosition
				var_261_43.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("1086", 3)

				local var_261_45 = var_261_43.childCount

				for iter_261_4 = 0, var_261_45 - 1 do
					local var_261_46 = var_261_43:GetChild(iter_261_4)

					if var_261_46.name == "" or not string.find(var_261_46.name, "split") then
						var_261_46.gameObject:SetActive(true)
					else
						var_261_46.gameObject:SetActive(false)
					end
				end
			end

			local var_261_47 = 0.001

			if var_261_44 <= arg_258_1.time_ and arg_258_1.time_ < var_261_44 + var_261_47 then
				local var_261_48 = (arg_258_1.time_ - var_261_44) / var_261_47
				local var_261_49 = Vector3.New(0, -404.2, -237.9)

				var_261_43.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1086, var_261_49, var_261_48)
			end

			if arg_258_1.time_ >= var_261_44 + var_261_47 and arg_258_1.time_ < var_261_44 + var_261_47 + arg_261_0 then
				var_261_43.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_261_50 = arg_258_1.actors_["1086"]
			local var_261_51 = 3.468

			if var_261_51 < arg_258_1.time_ and arg_258_1.time_ <= var_261_51 + arg_261_0 and not isNil(var_261_50) and arg_258_1.var_.actorSpriteComps1086 == nil then
				arg_258_1.var_.actorSpriteComps1086 = var_261_50:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_52 = 0.125

			if var_261_51 <= arg_258_1.time_ and arg_258_1.time_ < var_261_51 + var_261_52 and not isNil(var_261_50) then
				local var_261_53 = (arg_258_1.time_ - var_261_51) / var_261_52

				if arg_258_1.var_.actorSpriteComps1086 then
					for iter_261_5, iter_261_6 in pairs(arg_258_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_261_6 then
							if arg_258_1.isInRecall_ then
								local var_261_54 = Mathf.Lerp(iter_261_6.color.r, arg_258_1.hightColor1.r, var_261_53)
								local var_261_55 = Mathf.Lerp(iter_261_6.color.g, arg_258_1.hightColor1.g, var_261_53)
								local var_261_56 = Mathf.Lerp(iter_261_6.color.b, arg_258_1.hightColor1.b, var_261_53)

								iter_261_6.color = Color.New(var_261_54, var_261_55, var_261_56)
							else
								local var_261_57 = Mathf.Lerp(iter_261_6.color.r, 1, var_261_53)

								iter_261_6.color = Color.New(var_261_57, var_261_57, var_261_57)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= var_261_51 + var_261_52 and arg_258_1.time_ < var_261_51 + var_261_52 + arg_261_0 and not isNil(var_261_50) and arg_258_1.var_.actorSpriteComps1086 then
				for iter_261_7, iter_261_8 in pairs(arg_258_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_261_8 then
						if arg_258_1.isInRecall_ then
							iter_261_8.color = arg_258_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_261_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_258_1.var_.actorSpriteComps1086 = nil
			end

			local var_261_58 = arg_258_1.actors_["1086"]
			local var_261_59 = 3.46733333333333

			if var_261_59 < arg_258_1.time_ and arg_258_1.time_ <= var_261_59 + arg_261_0 then
				local var_261_60 = var_261_58:GetComponentInChildren(typeof(CanvasGroup))

				if var_261_60 then
					arg_258_1.var_.alphaOldValue1086 = var_261_60.alpha
					arg_258_1.var_.characterEffect1086 = var_261_60
				end

				arg_258_1.var_.alphaOldValue1086 = 0
			end

			local var_261_61 = 0.857666666666667

			if var_261_59 <= arg_258_1.time_ and arg_258_1.time_ < var_261_59 + var_261_61 then
				local var_261_62 = (arg_258_1.time_ - var_261_59) / var_261_61
				local var_261_63 = Mathf.Lerp(arg_258_1.var_.alphaOldValue1086, 1, var_261_62)

				if arg_258_1.var_.characterEffect1086 then
					arg_258_1.var_.characterEffect1086.alpha = var_261_63
				end
			end

			if arg_258_1.time_ >= var_261_59 + var_261_61 and arg_258_1.time_ < var_261_59 + var_261_61 + arg_261_0 and arg_258_1.var_.characterEffect1086 then
				arg_258_1.var_.characterEffect1086.alpha = 1
			end

			local var_261_64 = 0
			local var_261_65 = 0.2

			if var_261_64 < arg_258_1.time_ and arg_258_1.time_ <= var_261_64 + arg_261_0 then
				local var_261_66 = "play"
				local var_261_67 = "music"

				arg_258_1:AudioAction(var_261_66, var_261_67, "ui_battle", "ui_battle_stopbgm", "")

				local var_261_68 = ""
				local var_261_69 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_261_69 ~= "" then
					if arg_258_1.bgmTxt_.text ~= var_261_69 and arg_258_1.bgmTxt_.text ~= "" then
						if arg_258_1.bgmTxt2_.text ~= "" then
							arg_258_1.bgmTxt_.text = arg_258_1.bgmTxt2_.text
						end

						arg_258_1.bgmTxt2_.text = var_261_69

						arg_258_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_258_1.bgmTxt_.text = var_261_69
						arg_258_1.bgmTxt2_.text = var_261_69
					end

					if arg_258_1.bgmTimer then
						arg_258_1.bgmTimer:Stop()

						arg_258_1.bgmTimer = nil
					end

					if arg_258_1.settingData.show_music_name == 1 then
						arg_258_1.musicController:SetSelectedState("show")
						arg_258_1.musicAnimator_:Play("open", 0, 0)

						if arg_258_1.settingData.music_time ~= 0 then
							arg_258_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_258_1.settingData.music_time), function()
								if arg_258_1 == nil or isNil(arg_258_1.bgmTxt_) then
									return
								end

								arg_258_1.musicController:SetSelectedState("hide")
								arg_258_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_261_70 = 1.46666666666667
			local var_261_71 = 1

			if var_261_70 < arg_258_1.time_ and arg_258_1.time_ <= var_261_70 + arg_261_0 then
				local var_261_72 = "play"
				local var_261_73 = "music"

				arg_258_1:AudioAction(var_261_72, var_261_73, "bgm_activity_3_8_story_northwake_1", "bgm_activity_3_8_story_northwake_1", "bgm_activity_3_8_story_northwake_1.awb")

				local var_261_74 = ""
				local var_261_75 = manager.audio:GetAudioName("bgm_activity_3_8_story_northwake_1", "bgm_activity_3_8_story_northwake_1")

				if var_261_75 ~= "" then
					if arg_258_1.bgmTxt_.text ~= var_261_75 and arg_258_1.bgmTxt_.text ~= "" then
						if arg_258_1.bgmTxt2_.text ~= "" then
							arg_258_1.bgmTxt_.text = arg_258_1.bgmTxt2_.text
						end

						arg_258_1.bgmTxt2_.text = var_261_75

						arg_258_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_258_1.bgmTxt_.text = var_261_75
						arg_258_1.bgmTxt2_.text = var_261_75
					end

					if arg_258_1.bgmTimer then
						arg_258_1.bgmTimer:Stop()

						arg_258_1.bgmTimer = nil
					end

					if arg_258_1.settingData.show_music_name == 1 then
						arg_258_1.musicController:SetSelectedState("show")
						arg_258_1.musicAnimator_:Play("open", 0, 0)

						if arg_258_1.settingData.music_time ~= 0 then
							arg_258_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_258_1.settingData.music_time), function()
								if arg_258_1 == nil or isNil(arg_258_1.bgmTxt_) then
									return
								end

								arg_258_1.musicController:SetSelectedState("hide")
								arg_258_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_258_1.frameCnt_ <= 1 then
				arg_258_1.dialog_:SetActive(false)
			end

			local var_261_76 = 4
			local var_261_77 = 0.625

			if var_261_76 < arg_258_1.time_ and arg_258_1.time_ <= var_261_76 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0

				arg_258_1.dialog_:SetActive(true)

				arg_258_1.dialogCg_.alpha = 0

				local var_261_78 = LeanTween.value(arg_258_1.dialog_, 0, 1, 0.3)

				var_261_78:setOnUpdate(LuaHelper.FloatAction(function(arg_264_0)
					arg_258_1.dialogCg_.alpha = arg_264_0
				end))
				var_261_78:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_258_1.dialog_)
					var_261_78:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_258_1.duration_ = arg_258_1.duration_ + 0.3

				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_79 = arg_258_1:FormatText(StoryNameCfg[1080].name)

				arg_258_1.leftNameTxt_.text = var_261_79

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_80 = arg_258_1:GetWordFromCfg(416051061)
				local var_261_81 = arg_258_1:FormatText(var_261_80.content)

				arg_258_1.text_.text = var_261_81

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_82 = 25
				local var_261_83 = utf8.len(var_261_81)
				local var_261_84 = var_261_82 <= 0 and var_261_77 or var_261_77 * (var_261_83 / var_261_82)

				if var_261_84 > 0 and var_261_77 < var_261_84 then
					arg_258_1.talkMaxDuration = var_261_84
					var_261_76 = var_261_76 + 0.3

					if var_261_84 + var_261_76 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_84 + var_261_76
					end
				end

				arg_258_1.text_.text = var_261_81
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051061", "story_v_out_416051.awb") ~= 0 then
					local var_261_85 = manager.audio:GetVoiceLength("story_v_out_416051", "416051061", "story_v_out_416051.awb") / 1000

					if var_261_85 + var_261_76 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_85 + var_261_76
					end

					if var_261_80.prefab_name ~= "" and arg_258_1.actors_[var_261_80.prefab_name] ~= nil then
						local var_261_86 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_80.prefab_name].transform, "story_v_out_416051", "416051061", "story_v_out_416051.awb")

						arg_258_1:RecordAudio("416051061", var_261_86)
						arg_258_1:RecordAudio("416051061", var_261_86)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_416051", "416051061", "story_v_out_416051.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_416051", "416051061", "story_v_out_416051.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_87 = var_261_76 + 0.3
			local var_261_88 = math.max(var_261_77, arg_258_1.talkMaxDuration)

			if var_261_87 <= arg_258_1.time_ and arg_258_1.time_ < var_261_87 + var_261_88 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_87) / var_261_88

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_87 + var_261_88 and arg_258_1.time_ < var_261_87 + var_261_88 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.46733333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play416051062 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 416051062
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play416051063(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["1086"].transform
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.var_.moveOldPos1086 = var_269_0.localPosition
				var_269_0.localScale = Vector3.New(1, 1, 1)

				arg_266_1:CheckSpriteTmpPos("1086", 7)

				local var_269_2 = var_269_0.childCount

				for iter_269_0 = 0, var_269_2 - 1 do
					local var_269_3 = var_269_0:GetChild(iter_269_0)

					if var_269_3.name == "" or not string.find(var_269_3.name, "split") then
						var_269_3.gameObject:SetActive(true)
					else
						var_269_3.gameObject:SetActive(false)
					end
				end
			end

			local var_269_4 = 0.001

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_4 then
				local var_269_5 = (arg_266_1.time_ - var_269_1) / var_269_4
				local var_269_6 = Vector3.New(0, -2000, 0)

				var_269_0.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1086, var_269_6, var_269_5)
			end

			if arg_266_1.time_ >= var_269_1 + var_269_4 and arg_266_1.time_ < var_269_1 + var_269_4 + arg_269_0 then
				var_269_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_269_7 = 0
			local var_269_8 = 1.225

			if var_269_7 < arg_266_1.time_ and arg_266_1.time_ <= var_269_7 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_9 = arg_266_1:GetWordFromCfg(416051062)
				local var_269_10 = arg_266_1:FormatText(var_269_9.content)

				arg_266_1.text_.text = var_269_10

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_11 = 49
				local var_269_12 = utf8.len(var_269_10)
				local var_269_13 = var_269_11 <= 0 and var_269_8 or var_269_8 * (var_269_12 / var_269_11)

				if var_269_13 > 0 and var_269_8 < var_269_13 then
					arg_266_1.talkMaxDuration = var_269_13

					if var_269_13 + var_269_7 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_13 + var_269_7
					end
				end

				arg_266_1.text_.text = var_269_10
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_14 = math.max(var_269_8, arg_266_1.talkMaxDuration)

			if var_269_7 <= arg_266_1.time_ and arg_266_1.time_ < var_269_7 + var_269_14 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_7) / var_269_14

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_7 + var_269_14 and arg_266_1.time_ < var_269_7 + var_269_14 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play416051063 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 416051063
		arg_270_1.duration_ = 4.5

		local var_270_0 = {
			zh = 2.633,
			ja = 4.5
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play416051064(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["1028"].transform
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 then
				arg_270_1.var_.moveOldPos1028 = var_273_0.localPosition
				var_273_0.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("1028", 3)

				local var_273_2 = var_273_0.childCount

				for iter_273_0 = 0, var_273_2 - 1 do
					local var_273_3 = var_273_0:GetChild(iter_273_0)

					if var_273_3.name == "" or not string.find(var_273_3.name, "split") then
						var_273_3.gameObject:SetActive(true)
					else
						var_273_3.gameObject:SetActive(false)
					end
				end
			end

			local var_273_4 = 0.001

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_4 then
				local var_273_5 = (arg_270_1.time_ - var_273_1) / var_273_4
				local var_273_6 = Vector3.New(0, -402.7, -156.1)

				var_273_0.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1028, var_273_6, var_273_5)
			end

			if arg_270_1.time_ >= var_273_1 + var_273_4 and arg_270_1.time_ < var_273_1 + var_273_4 + arg_273_0 then
				var_273_0.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_273_7 = arg_270_1.actors_["1028"]
			local var_273_8 = 0

			if var_273_8 < arg_270_1.time_ and arg_270_1.time_ <= var_273_8 + arg_273_0 and not isNil(var_273_7) and arg_270_1.var_.actorSpriteComps1028 == nil then
				arg_270_1.var_.actorSpriteComps1028 = var_273_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_9 = 0.125

			if var_273_8 <= arg_270_1.time_ and arg_270_1.time_ < var_273_8 + var_273_9 and not isNil(var_273_7) then
				local var_273_10 = (arg_270_1.time_ - var_273_8) / var_273_9

				if arg_270_1.var_.actorSpriteComps1028 then
					for iter_273_1, iter_273_2 in pairs(arg_270_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_273_2 then
							if arg_270_1.isInRecall_ then
								local var_273_11 = Mathf.Lerp(iter_273_2.color.r, arg_270_1.hightColor1.r, var_273_10)
								local var_273_12 = Mathf.Lerp(iter_273_2.color.g, arg_270_1.hightColor1.g, var_273_10)
								local var_273_13 = Mathf.Lerp(iter_273_2.color.b, arg_270_1.hightColor1.b, var_273_10)

								iter_273_2.color = Color.New(var_273_11, var_273_12, var_273_13)
							else
								local var_273_14 = Mathf.Lerp(iter_273_2.color.r, 1, var_273_10)

								iter_273_2.color = Color.New(var_273_14, var_273_14, var_273_14)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= var_273_8 + var_273_9 and arg_270_1.time_ < var_273_8 + var_273_9 + arg_273_0 and not isNil(var_273_7) and arg_270_1.var_.actorSpriteComps1028 then
				for iter_273_3, iter_273_4 in pairs(arg_270_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_273_4 then
						if arg_270_1.isInRecall_ then
							iter_273_4.color = arg_270_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_273_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_270_1.var_.actorSpriteComps1028 = nil
			end

			local var_273_15 = 0
			local var_273_16 = 0.325

			if var_273_15 < arg_270_1.time_ and arg_270_1.time_ <= var_273_15 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_17 = arg_270_1:FormatText(StoryNameCfg[327].name)

				arg_270_1.leftNameTxt_.text = var_273_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_18 = arg_270_1:GetWordFromCfg(416051063)
				local var_273_19 = arg_270_1:FormatText(var_273_18.content)

				arg_270_1.text_.text = var_273_19

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_20 = 13
				local var_273_21 = utf8.len(var_273_19)
				local var_273_22 = var_273_20 <= 0 and var_273_16 or var_273_16 * (var_273_21 / var_273_20)

				if var_273_22 > 0 and var_273_16 < var_273_22 then
					arg_270_1.talkMaxDuration = var_273_22

					if var_273_22 + var_273_15 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_22 + var_273_15
					end
				end

				arg_270_1.text_.text = var_273_19
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051063", "story_v_out_416051.awb") ~= 0 then
					local var_273_23 = manager.audio:GetVoiceLength("story_v_out_416051", "416051063", "story_v_out_416051.awb") / 1000

					if var_273_23 + var_273_15 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_23 + var_273_15
					end

					if var_273_18.prefab_name ~= "" and arg_270_1.actors_[var_273_18.prefab_name] ~= nil then
						local var_273_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_18.prefab_name].transform, "story_v_out_416051", "416051063", "story_v_out_416051.awb")

						arg_270_1:RecordAudio("416051063", var_273_24)
						arg_270_1:RecordAudio("416051063", var_273_24)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_416051", "416051063", "story_v_out_416051.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_416051", "416051063", "story_v_out_416051.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_25 = math.max(var_273_16, arg_270_1.talkMaxDuration)

			if var_273_15 <= arg_270_1.time_ and arg_270_1.time_ < var_273_15 + var_273_25 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_15) / var_273_25

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_15 + var_273_25 and arg_270_1.time_ < var_273_15 + var_273_25 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play416051064 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 416051064
		arg_274_1.duration_ = 6.2

		local var_274_0 = {
			zh = 4.366,
			ja = 6.2
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play416051065(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["1028"].transform
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.var_.moveOldPos1028 = var_277_0.localPosition
				var_277_0.localScale = Vector3.New(1, 1, 1)

				arg_274_1:CheckSpriteTmpPos("1028", 2)

				local var_277_2 = var_277_0.childCount

				for iter_277_0 = 0, var_277_2 - 1 do
					local var_277_3 = var_277_0:GetChild(iter_277_0)

					if var_277_3.name == "" or not string.find(var_277_3.name, "split") then
						var_277_3.gameObject:SetActive(true)
					else
						var_277_3.gameObject:SetActive(false)
					end
				end
			end

			local var_277_4 = 0.001

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_4 then
				local var_277_5 = (arg_274_1.time_ - var_277_1) / var_277_4
				local var_277_6 = Vector3.New(-390, -402.7, -156.1)

				var_277_0.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1028, var_277_6, var_277_5)
			end

			if arg_274_1.time_ >= var_277_1 + var_277_4 and arg_274_1.time_ < var_277_1 + var_277_4 + arg_277_0 then
				var_277_0.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_277_7 = arg_274_1.actors_["1028"]
			local var_277_8 = 0

			if var_277_8 < arg_274_1.time_ and arg_274_1.time_ <= var_277_8 + arg_277_0 and not isNil(var_277_7) and arg_274_1.var_.actorSpriteComps1028 == nil then
				arg_274_1.var_.actorSpriteComps1028 = var_277_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_9 = 0.125

			if var_277_8 <= arg_274_1.time_ and arg_274_1.time_ < var_277_8 + var_277_9 and not isNil(var_277_7) then
				local var_277_10 = (arg_274_1.time_ - var_277_8) / var_277_9

				if arg_274_1.var_.actorSpriteComps1028 then
					for iter_277_1, iter_277_2 in pairs(arg_274_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_277_2 then
							if arg_274_1.isInRecall_ then
								local var_277_11 = Mathf.Lerp(iter_277_2.color.r, arg_274_1.hightColor2.r, var_277_10)
								local var_277_12 = Mathf.Lerp(iter_277_2.color.g, arg_274_1.hightColor2.g, var_277_10)
								local var_277_13 = Mathf.Lerp(iter_277_2.color.b, arg_274_1.hightColor2.b, var_277_10)

								iter_277_2.color = Color.New(var_277_11, var_277_12, var_277_13)
							else
								local var_277_14 = Mathf.Lerp(iter_277_2.color.r, 0.5, var_277_10)

								iter_277_2.color = Color.New(var_277_14, var_277_14, var_277_14)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= var_277_8 + var_277_9 and arg_274_1.time_ < var_277_8 + var_277_9 + arg_277_0 and not isNil(var_277_7) and arg_274_1.var_.actorSpriteComps1028 then
				for iter_277_3, iter_277_4 in pairs(arg_274_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_277_4 then
						if arg_274_1.isInRecall_ then
							iter_277_4.color = arg_274_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_277_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_274_1.var_.actorSpriteComps1028 = nil
			end

			local var_277_15 = arg_274_1.actors_["1086"]
			local var_277_16 = 0

			if var_277_16 < arg_274_1.time_ and arg_274_1.time_ <= var_277_16 + arg_277_0 and not isNil(var_277_15) and arg_274_1.var_.actorSpriteComps1086 == nil then
				arg_274_1.var_.actorSpriteComps1086 = var_277_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_17 = 0.125

			if var_277_16 <= arg_274_1.time_ and arg_274_1.time_ < var_277_16 + var_277_17 and not isNil(var_277_15) then
				local var_277_18 = (arg_274_1.time_ - var_277_16) / var_277_17

				if arg_274_1.var_.actorSpriteComps1086 then
					for iter_277_5, iter_277_6 in pairs(arg_274_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_277_6 then
							if arg_274_1.isInRecall_ then
								local var_277_19 = Mathf.Lerp(iter_277_6.color.r, arg_274_1.hightColor1.r, var_277_18)
								local var_277_20 = Mathf.Lerp(iter_277_6.color.g, arg_274_1.hightColor1.g, var_277_18)
								local var_277_21 = Mathf.Lerp(iter_277_6.color.b, arg_274_1.hightColor1.b, var_277_18)

								iter_277_6.color = Color.New(var_277_19, var_277_20, var_277_21)
							else
								local var_277_22 = Mathf.Lerp(iter_277_6.color.r, 1, var_277_18)

								iter_277_6.color = Color.New(var_277_22, var_277_22, var_277_22)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= var_277_16 + var_277_17 and arg_274_1.time_ < var_277_16 + var_277_17 + arg_277_0 and not isNil(var_277_15) and arg_274_1.var_.actorSpriteComps1086 then
				for iter_277_7, iter_277_8 in pairs(arg_274_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_277_8 then
						if arg_274_1.isInRecall_ then
							iter_277_8.color = arg_274_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_277_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_274_1.var_.actorSpriteComps1086 = nil
			end

			local var_277_23 = arg_274_1.actors_["1086"].transform
			local var_277_24 = 0

			if var_277_24 < arg_274_1.time_ and arg_274_1.time_ <= var_277_24 + arg_277_0 then
				arg_274_1.var_.moveOldPos1086 = var_277_23.localPosition
				var_277_23.localScale = Vector3.New(1, 1, 1)

				arg_274_1:CheckSpriteTmpPos("1086", 4)

				local var_277_25 = var_277_23.childCount

				for iter_277_9 = 0, var_277_25 - 1 do
					local var_277_26 = var_277_23:GetChild(iter_277_9)

					if var_277_26.name == "" or not string.find(var_277_26.name, "split") then
						var_277_26.gameObject:SetActive(true)
					else
						var_277_26.gameObject:SetActive(false)
					end
				end
			end

			local var_277_27 = 0.001

			if var_277_24 <= arg_274_1.time_ and arg_274_1.time_ < var_277_24 + var_277_27 then
				local var_277_28 = (arg_274_1.time_ - var_277_24) / var_277_27
				local var_277_29 = Vector3.New(390, -404.2, -237.9)

				var_277_23.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1086, var_277_29, var_277_28)
			end

			if arg_274_1.time_ >= var_277_24 + var_277_27 and arg_274_1.time_ < var_277_24 + var_277_27 + arg_277_0 then
				var_277_23.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_277_30 = 0
			local var_277_31 = 0.375

			if var_277_30 < arg_274_1.time_ and arg_274_1.time_ <= var_277_30 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_32 = arg_274_1:FormatText(StoryNameCfg[1080].name)

				arg_274_1.leftNameTxt_.text = var_277_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_33 = arg_274_1:GetWordFromCfg(416051064)
				local var_277_34 = arg_274_1:FormatText(var_277_33.content)

				arg_274_1.text_.text = var_277_34

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_35 = 15
				local var_277_36 = utf8.len(var_277_34)
				local var_277_37 = var_277_35 <= 0 and var_277_31 or var_277_31 * (var_277_36 / var_277_35)

				if var_277_37 > 0 and var_277_31 < var_277_37 then
					arg_274_1.talkMaxDuration = var_277_37

					if var_277_37 + var_277_30 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_37 + var_277_30
					end
				end

				arg_274_1.text_.text = var_277_34
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051064", "story_v_out_416051.awb") ~= 0 then
					local var_277_38 = manager.audio:GetVoiceLength("story_v_out_416051", "416051064", "story_v_out_416051.awb") / 1000

					if var_277_38 + var_277_30 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_38 + var_277_30
					end

					if var_277_33.prefab_name ~= "" and arg_274_1.actors_[var_277_33.prefab_name] ~= nil then
						local var_277_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_33.prefab_name].transform, "story_v_out_416051", "416051064", "story_v_out_416051.awb")

						arg_274_1:RecordAudio("416051064", var_277_39)
						arg_274_1:RecordAudio("416051064", var_277_39)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_416051", "416051064", "story_v_out_416051.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_416051", "416051064", "story_v_out_416051.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_40 = math.max(var_277_31, arg_274_1.talkMaxDuration)

			if var_277_30 <= arg_274_1.time_ and arg_274_1.time_ < var_277_30 + var_277_40 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_30) / var_277_40

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_30 + var_277_40 and arg_274_1.time_ < var_277_30 + var_277_40 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play416051065 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 416051065
		arg_278_1.duration_ = 7.1

		local var_278_0 = {
			zh = 5.7,
			ja = 7.1
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play416051066(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["1028"]
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.actorSpriteComps1028 == nil then
				arg_278_1.var_.actorSpriteComps1028 = var_281_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_2 = 0.125

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_2 and not isNil(var_281_0) then
				local var_281_3 = (arg_278_1.time_ - var_281_1) / var_281_2

				if arg_278_1.var_.actorSpriteComps1028 then
					for iter_281_0, iter_281_1 in pairs(arg_278_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_281_1 then
							if arg_278_1.isInRecall_ then
								local var_281_4 = Mathf.Lerp(iter_281_1.color.r, arg_278_1.hightColor1.r, var_281_3)
								local var_281_5 = Mathf.Lerp(iter_281_1.color.g, arg_278_1.hightColor1.g, var_281_3)
								local var_281_6 = Mathf.Lerp(iter_281_1.color.b, arg_278_1.hightColor1.b, var_281_3)

								iter_281_1.color = Color.New(var_281_4, var_281_5, var_281_6)
							else
								local var_281_7 = Mathf.Lerp(iter_281_1.color.r, 1, var_281_3)

								iter_281_1.color = Color.New(var_281_7, var_281_7, var_281_7)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= var_281_1 + var_281_2 and arg_278_1.time_ < var_281_1 + var_281_2 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.actorSpriteComps1028 then
				for iter_281_2, iter_281_3 in pairs(arg_278_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_281_3 then
						if arg_278_1.isInRecall_ then
							iter_281_3.color = arg_278_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_281_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_278_1.var_.actorSpriteComps1028 = nil
			end

			local var_281_8 = arg_278_1.actors_["1086"]
			local var_281_9 = 0

			if var_281_9 < arg_278_1.time_ and arg_278_1.time_ <= var_281_9 + arg_281_0 and not isNil(var_281_8) and arg_278_1.var_.actorSpriteComps1086 == nil then
				arg_278_1.var_.actorSpriteComps1086 = var_281_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_10 = 0.125

			if var_281_9 <= arg_278_1.time_ and arg_278_1.time_ < var_281_9 + var_281_10 and not isNil(var_281_8) then
				local var_281_11 = (arg_278_1.time_ - var_281_9) / var_281_10

				if arg_278_1.var_.actorSpriteComps1086 then
					for iter_281_4, iter_281_5 in pairs(arg_278_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_281_5 then
							if arg_278_1.isInRecall_ then
								local var_281_12 = Mathf.Lerp(iter_281_5.color.r, arg_278_1.hightColor2.r, var_281_11)
								local var_281_13 = Mathf.Lerp(iter_281_5.color.g, arg_278_1.hightColor2.g, var_281_11)
								local var_281_14 = Mathf.Lerp(iter_281_5.color.b, arg_278_1.hightColor2.b, var_281_11)

								iter_281_5.color = Color.New(var_281_12, var_281_13, var_281_14)
							else
								local var_281_15 = Mathf.Lerp(iter_281_5.color.r, 0.5, var_281_11)

								iter_281_5.color = Color.New(var_281_15, var_281_15, var_281_15)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= var_281_9 + var_281_10 and arg_278_1.time_ < var_281_9 + var_281_10 + arg_281_0 and not isNil(var_281_8) and arg_278_1.var_.actorSpriteComps1086 then
				for iter_281_6, iter_281_7 in pairs(arg_278_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_281_7 then
						if arg_278_1.isInRecall_ then
							iter_281_7.color = arg_278_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_281_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_278_1.var_.actorSpriteComps1086 = nil
			end

			local var_281_16 = 0
			local var_281_17 = 0.675

			if var_281_16 < arg_278_1.time_ and arg_278_1.time_ <= var_281_16 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_18 = arg_278_1:FormatText(StoryNameCfg[327].name)

				arg_278_1.leftNameTxt_.text = var_281_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_19 = arg_278_1:GetWordFromCfg(416051065)
				local var_281_20 = arg_278_1:FormatText(var_281_19.content)

				arg_278_1.text_.text = var_281_20

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_21 = 27
				local var_281_22 = utf8.len(var_281_20)
				local var_281_23 = var_281_21 <= 0 and var_281_17 or var_281_17 * (var_281_22 / var_281_21)

				if var_281_23 > 0 and var_281_17 < var_281_23 then
					arg_278_1.talkMaxDuration = var_281_23

					if var_281_23 + var_281_16 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_23 + var_281_16
					end
				end

				arg_278_1.text_.text = var_281_20
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051065", "story_v_out_416051.awb") ~= 0 then
					local var_281_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051065", "story_v_out_416051.awb") / 1000

					if var_281_24 + var_281_16 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_24 + var_281_16
					end

					if var_281_19.prefab_name ~= "" and arg_278_1.actors_[var_281_19.prefab_name] ~= nil then
						local var_281_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_19.prefab_name].transform, "story_v_out_416051", "416051065", "story_v_out_416051.awb")

						arg_278_1:RecordAudio("416051065", var_281_25)
						arg_278_1:RecordAudio("416051065", var_281_25)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_416051", "416051065", "story_v_out_416051.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_416051", "416051065", "story_v_out_416051.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_26 = math.max(var_281_17, arg_278_1.talkMaxDuration)

			if var_281_16 <= arg_278_1.time_ and arg_278_1.time_ < var_281_16 + var_281_26 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_16) / var_281_26

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_16 + var_281_26 and arg_278_1.time_ < var_281_16 + var_281_26 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play416051066 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 416051066
		arg_282_1.duration_ = 7.63

		local var_282_0 = {
			zh = 4.933,
			ja = 7.633
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play416051067(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["1028"]
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.actorSpriteComps1028 == nil then
				arg_282_1.var_.actorSpriteComps1028 = var_285_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_2 = 0.125

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 and not isNil(var_285_0) then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2

				if arg_282_1.var_.actorSpriteComps1028 then
					for iter_285_0, iter_285_1 in pairs(arg_282_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_285_1 then
							if arg_282_1.isInRecall_ then
								local var_285_4 = Mathf.Lerp(iter_285_1.color.r, arg_282_1.hightColor2.r, var_285_3)
								local var_285_5 = Mathf.Lerp(iter_285_1.color.g, arg_282_1.hightColor2.g, var_285_3)
								local var_285_6 = Mathf.Lerp(iter_285_1.color.b, arg_282_1.hightColor2.b, var_285_3)

								iter_285_1.color = Color.New(var_285_4, var_285_5, var_285_6)
							else
								local var_285_7 = Mathf.Lerp(iter_285_1.color.r, 0.5, var_285_3)

								iter_285_1.color = Color.New(var_285_7, var_285_7, var_285_7)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.actorSpriteComps1028 then
				for iter_285_2, iter_285_3 in pairs(arg_282_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_285_3 then
						if arg_282_1.isInRecall_ then
							iter_285_3.color = arg_282_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_285_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_282_1.var_.actorSpriteComps1028 = nil
			end

			local var_285_8 = arg_282_1.actors_["1086"]
			local var_285_9 = 0

			if var_285_9 < arg_282_1.time_ and arg_282_1.time_ <= var_285_9 + arg_285_0 and not isNil(var_285_8) and arg_282_1.var_.actorSpriteComps1086 == nil then
				arg_282_1.var_.actorSpriteComps1086 = var_285_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_10 = 0.125

			if var_285_9 <= arg_282_1.time_ and arg_282_1.time_ < var_285_9 + var_285_10 and not isNil(var_285_8) then
				local var_285_11 = (arg_282_1.time_ - var_285_9) / var_285_10

				if arg_282_1.var_.actorSpriteComps1086 then
					for iter_285_4, iter_285_5 in pairs(arg_282_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_285_5 then
							if arg_282_1.isInRecall_ then
								local var_285_12 = Mathf.Lerp(iter_285_5.color.r, arg_282_1.hightColor1.r, var_285_11)
								local var_285_13 = Mathf.Lerp(iter_285_5.color.g, arg_282_1.hightColor1.g, var_285_11)
								local var_285_14 = Mathf.Lerp(iter_285_5.color.b, arg_282_1.hightColor1.b, var_285_11)

								iter_285_5.color = Color.New(var_285_12, var_285_13, var_285_14)
							else
								local var_285_15 = Mathf.Lerp(iter_285_5.color.r, 1, var_285_11)

								iter_285_5.color = Color.New(var_285_15, var_285_15, var_285_15)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= var_285_9 + var_285_10 and arg_282_1.time_ < var_285_9 + var_285_10 + arg_285_0 and not isNil(var_285_8) and arg_282_1.var_.actorSpriteComps1086 then
				for iter_285_6, iter_285_7 in pairs(arg_282_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_285_7 then
						if arg_282_1.isInRecall_ then
							iter_285_7.color = arg_282_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_285_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_282_1.var_.actorSpriteComps1086 = nil
			end

			local var_285_16 = 0
			local var_285_17 = 0.575

			if var_285_16 < arg_282_1.time_ and arg_282_1.time_ <= var_285_16 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_18 = arg_282_1:FormatText(StoryNameCfg[1080].name)

				arg_282_1.leftNameTxt_.text = var_285_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_19 = arg_282_1:GetWordFromCfg(416051066)
				local var_285_20 = arg_282_1:FormatText(var_285_19.content)

				arg_282_1.text_.text = var_285_20

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_21 = 23
				local var_285_22 = utf8.len(var_285_20)
				local var_285_23 = var_285_21 <= 0 and var_285_17 or var_285_17 * (var_285_22 / var_285_21)

				if var_285_23 > 0 and var_285_17 < var_285_23 then
					arg_282_1.talkMaxDuration = var_285_23

					if var_285_23 + var_285_16 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_23 + var_285_16
					end
				end

				arg_282_1.text_.text = var_285_20
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051066", "story_v_out_416051.awb") ~= 0 then
					local var_285_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051066", "story_v_out_416051.awb") / 1000

					if var_285_24 + var_285_16 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_24 + var_285_16
					end

					if var_285_19.prefab_name ~= "" and arg_282_1.actors_[var_285_19.prefab_name] ~= nil then
						local var_285_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_19.prefab_name].transform, "story_v_out_416051", "416051066", "story_v_out_416051.awb")

						arg_282_1:RecordAudio("416051066", var_285_25)
						arg_282_1:RecordAudio("416051066", var_285_25)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_416051", "416051066", "story_v_out_416051.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_416051", "416051066", "story_v_out_416051.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_26 = math.max(var_285_17, arg_282_1.talkMaxDuration)

			if var_285_16 <= arg_282_1.time_ and arg_282_1.time_ < var_285_16 + var_285_26 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_16) / var_285_26

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_16 + var_285_26 and arg_282_1.time_ < var_285_16 + var_285_26 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play416051067 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 416051067
		arg_286_1.duration_ = 7.9

		local var_286_0 = {
			zh = 5.266,
			ja = 7.9
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play416051068(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = arg_286_1.actors_["1028"]
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.actorSpriteComps1028 == nil then
				arg_286_1.var_.actorSpriteComps1028 = var_289_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_2 = 0.125

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_2 and not isNil(var_289_0) then
				local var_289_3 = (arg_286_1.time_ - var_289_1) / var_289_2

				if arg_286_1.var_.actorSpriteComps1028 then
					for iter_289_0, iter_289_1 in pairs(arg_286_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_289_1 then
							if arg_286_1.isInRecall_ then
								local var_289_4 = Mathf.Lerp(iter_289_1.color.r, arg_286_1.hightColor1.r, var_289_3)
								local var_289_5 = Mathf.Lerp(iter_289_1.color.g, arg_286_1.hightColor1.g, var_289_3)
								local var_289_6 = Mathf.Lerp(iter_289_1.color.b, arg_286_1.hightColor1.b, var_289_3)

								iter_289_1.color = Color.New(var_289_4, var_289_5, var_289_6)
							else
								local var_289_7 = Mathf.Lerp(iter_289_1.color.r, 1, var_289_3)

								iter_289_1.color = Color.New(var_289_7, var_289_7, var_289_7)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= var_289_1 + var_289_2 and arg_286_1.time_ < var_289_1 + var_289_2 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.actorSpriteComps1028 then
				for iter_289_2, iter_289_3 in pairs(arg_286_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_289_3 then
						if arg_286_1.isInRecall_ then
							iter_289_3.color = arg_286_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_289_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_286_1.var_.actorSpriteComps1028 = nil
			end

			local var_289_8 = arg_286_1.actors_["1086"]
			local var_289_9 = 0

			if var_289_9 < arg_286_1.time_ and arg_286_1.time_ <= var_289_9 + arg_289_0 and not isNil(var_289_8) and arg_286_1.var_.actorSpriteComps1086 == nil then
				arg_286_1.var_.actorSpriteComps1086 = var_289_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_10 = 0.125

			if var_289_9 <= arg_286_1.time_ and arg_286_1.time_ < var_289_9 + var_289_10 and not isNil(var_289_8) then
				local var_289_11 = (arg_286_1.time_ - var_289_9) / var_289_10

				if arg_286_1.var_.actorSpriteComps1086 then
					for iter_289_4, iter_289_5 in pairs(arg_286_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_289_5 then
							if arg_286_1.isInRecall_ then
								local var_289_12 = Mathf.Lerp(iter_289_5.color.r, arg_286_1.hightColor2.r, var_289_11)
								local var_289_13 = Mathf.Lerp(iter_289_5.color.g, arg_286_1.hightColor2.g, var_289_11)
								local var_289_14 = Mathf.Lerp(iter_289_5.color.b, arg_286_1.hightColor2.b, var_289_11)

								iter_289_5.color = Color.New(var_289_12, var_289_13, var_289_14)
							else
								local var_289_15 = Mathf.Lerp(iter_289_5.color.r, 0.5, var_289_11)

								iter_289_5.color = Color.New(var_289_15, var_289_15, var_289_15)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= var_289_9 + var_289_10 and arg_286_1.time_ < var_289_9 + var_289_10 + arg_289_0 and not isNil(var_289_8) and arg_286_1.var_.actorSpriteComps1086 then
				for iter_289_6, iter_289_7 in pairs(arg_286_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_289_7 then
						if arg_286_1.isInRecall_ then
							iter_289_7.color = arg_286_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_289_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_286_1.var_.actorSpriteComps1086 = nil
			end

			local var_289_16 = 0
			local var_289_17 = 0.55

			if var_289_16 < arg_286_1.time_ and arg_286_1.time_ <= var_289_16 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_18 = arg_286_1:FormatText(StoryNameCfg[327].name)

				arg_286_1.leftNameTxt_.text = var_289_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_19 = arg_286_1:GetWordFromCfg(416051067)
				local var_289_20 = arg_286_1:FormatText(var_289_19.content)

				arg_286_1.text_.text = var_289_20

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_21 = 22
				local var_289_22 = utf8.len(var_289_20)
				local var_289_23 = var_289_21 <= 0 and var_289_17 or var_289_17 * (var_289_22 / var_289_21)

				if var_289_23 > 0 and var_289_17 < var_289_23 then
					arg_286_1.talkMaxDuration = var_289_23

					if var_289_23 + var_289_16 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_23 + var_289_16
					end
				end

				arg_286_1.text_.text = var_289_20
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051067", "story_v_out_416051.awb") ~= 0 then
					local var_289_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051067", "story_v_out_416051.awb") / 1000

					if var_289_24 + var_289_16 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_24 + var_289_16
					end

					if var_289_19.prefab_name ~= "" and arg_286_1.actors_[var_289_19.prefab_name] ~= nil then
						local var_289_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_19.prefab_name].transform, "story_v_out_416051", "416051067", "story_v_out_416051.awb")

						arg_286_1:RecordAudio("416051067", var_289_25)
						arg_286_1:RecordAudio("416051067", var_289_25)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_416051", "416051067", "story_v_out_416051.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_416051", "416051067", "story_v_out_416051.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_26 = math.max(var_289_17, arg_286_1.talkMaxDuration)

			if var_289_16 <= arg_286_1.time_ and arg_286_1.time_ < var_289_16 + var_289_26 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_16) / var_289_26

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_16 + var_289_26 and arg_286_1.time_ < var_289_16 + var_289_26 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play416051068 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 416051068
		arg_290_1.duration_ = 6.93

		local var_290_0 = {
			zh = 4,
			ja = 6.933
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play416051069(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["1028"]
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.actorSpriteComps1028 == nil then
				arg_290_1.var_.actorSpriteComps1028 = var_293_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_2 = 0.125

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 and not isNil(var_293_0) then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2

				if arg_290_1.var_.actorSpriteComps1028 then
					for iter_293_0, iter_293_1 in pairs(arg_290_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_293_1 then
							if arg_290_1.isInRecall_ then
								local var_293_4 = Mathf.Lerp(iter_293_1.color.r, arg_290_1.hightColor2.r, var_293_3)
								local var_293_5 = Mathf.Lerp(iter_293_1.color.g, arg_290_1.hightColor2.g, var_293_3)
								local var_293_6 = Mathf.Lerp(iter_293_1.color.b, arg_290_1.hightColor2.b, var_293_3)

								iter_293_1.color = Color.New(var_293_4, var_293_5, var_293_6)
							else
								local var_293_7 = Mathf.Lerp(iter_293_1.color.r, 0.5, var_293_3)

								iter_293_1.color = Color.New(var_293_7, var_293_7, var_293_7)
							end
						end
					end
				end
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.actorSpriteComps1028 then
				for iter_293_2, iter_293_3 in pairs(arg_290_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_293_3 then
						if arg_290_1.isInRecall_ then
							iter_293_3.color = arg_290_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_293_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_290_1.var_.actorSpriteComps1028 = nil
			end

			local var_293_8 = arg_290_1.actors_["1086"]
			local var_293_9 = 0

			if var_293_9 < arg_290_1.time_ and arg_290_1.time_ <= var_293_9 + arg_293_0 and not isNil(var_293_8) and arg_290_1.var_.actorSpriteComps1086 == nil then
				arg_290_1.var_.actorSpriteComps1086 = var_293_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_10 = 0.125

			if var_293_9 <= arg_290_1.time_ and arg_290_1.time_ < var_293_9 + var_293_10 and not isNil(var_293_8) then
				local var_293_11 = (arg_290_1.time_ - var_293_9) / var_293_10

				if arg_290_1.var_.actorSpriteComps1086 then
					for iter_293_4, iter_293_5 in pairs(arg_290_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_293_5 then
							if arg_290_1.isInRecall_ then
								local var_293_12 = Mathf.Lerp(iter_293_5.color.r, arg_290_1.hightColor1.r, var_293_11)
								local var_293_13 = Mathf.Lerp(iter_293_5.color.g, arg_290_1.hightColor1.g, var_293_11)
								local var_293_14 = Mathf.Lerp(iter_293_5.color.b, arg_290_1.hightColor1.b, var_293_11)

								iter_293_5.color = Color.New(var_293_12, var_293_13, var_293_14)
							else
								local var_293_15 = Mathf.Lerp(iter_293_5.color.r, 1, var_293_11)

								iter_293_5.color = Color.New(var_293_15, var_293_15, var_293_15)
							end
						end
					end
				end
			end

			if arg_290_1.time_ >= var_293_9 + var_293_10 and arg_290_1.time_ < var_293_9 + var_293_10 + arg_293_0 and not isNil(var_293_8) and arg_290_1.var_.actorSpriteComps1086 then
				for iter_293_6, iter_293_7 in pairs(arg_290_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_293_7 then
						if arg_290_1.isInRecall_ then
							iter_293_7.color = arg_290_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_293_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_290_1.var_.actorSpriteComps1086 = nil
			end

			local var_293_16 = 0
			local var_293_17 = 0.5

			if var_293_16 < arg_290_1.time_ and arg_290_1.time_ <= var_293_16 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_18 = arg_290_1:FormatText(StoryNameCfg[1080].name)

				arg_290_1.leftNameTxt_.text = var_293_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_19 = arg_290_1:GetWordFromCfg(416051068)
				local var_293_20 = arg_290_1:FormatText(var_293_19.content)

				arg_290_1.text_.text = var_293_20

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_21 = 20
				local var_293_22 = utf8.len(var_293_20)
				local var_293_23 = var_293_21 <= 0 and var_293_17 or var_293_17 * (var_293_22 / var_293_21)

				if var_293_23 > 0 and var_293_17 < var_293_23 then
					arg_290_1.talkMaxDuration = var_293_23

					if var_293_23 + var_293_16 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_23 + var_293_16
					end
				end

				arg_290_1.text_.text = var_293_20
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051068", "story_v_out_416051.awb") ~= 0 then
					local var_293_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051068", "story_v_out_416051.awb") / 1000

					if var_293_24 + var_293_16 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_24 + var_293_16
					end

					if var_293_19.prefab_name ~= "" and arg_290_1.actors_[var_293_19.prefab_name] ~= nil then
						local var_293_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_19.prefab_name].transform, "story_v_out_416051", "416051068", "story_v_out_416051.awb")

						arg_290_1:RecordAudio("416051068", var_293_25)
						arg_290_1:RecordAudio("416051068", var_293_25)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_416051", "416051068", "story_v_out_416051.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_416051", "416051068", "story_v_out_416051.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_26 = math.max(var_293_17, arg_290_1.talkMaxDuration)

			if var_293_16 <= arg_290_1.time_ and arg_290_1.time_ < var_293_16 + var_293_26 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_16) / var_293_26

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_16 + var_293_26 and arg_290_1.time_ < var_293_16 + var_293_26 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play416051069 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 416051069
		arg_294_1.duration_ = 6.53

		local var_294_0 = {
			zh = 4.6,
			ja = 6.533
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play416051070(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["1028"]
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.actorSpriteComps1028 == nil then
				arg_294_1.var_.actorSpriteComps1028 = var_297_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_297_2 = 0.125

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 and not isNil(var_297_0) then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2

				if arg_294_1.var_.actorSpriteComps1028 then
					for iter_297_0, iter_297_1 in pairs(arg_294_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_297_1 then
							if arg_294_1.isInRecall_ then
								local var_297_4 = Mathf.Lerp(iter_297_1.color.r, arg_294_1.hightColor1.r, var_297_3)
								local var_297_5 = Mathf.Lerp(iter_297_1.color.g, arg_294_1.hightColor1.g, var_297_3)
								local var_297_6 = Mathf.Lerp(iter_297_1.color.b, arg_294_1.hightColor1.b, var_297_3)

								iter_297_1.color = Color.New(var_297_4, var_297_5, var_297_6)
							else
								local var_297_7 = Mathf.Lerp(iter_297_1.color.r, 1, var_297_3)

								iter_297_1.color = Color.New(var_297_7, var_297_7, var_297_7)
							end
						end
					end
				end
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.actorSpriteComps1028 then
				for iter_297_2, iter_297_3 in pairs(arg_294_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_297_3 then
						if arg_294_1.isInRecall_ then
							iter_297_3.color = arg_294_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_297_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_294_1.var_.actorSpriteComps1028 = nil
			end

			local var_297_8 = arg_294_1.actors_["1086"]
			local var_297_9 = 0

			if var_297_9 < arg_294_1.time_ and arg_294_1.time_ <= var_297_9 + arg_297_0 and not isNil(var_297_8) and arg_294_1.var_.actorSpriteComps1086 == nil then
				arg_294_1.var_.actorSpriteComps1086 = var_297_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_297_10 = 0.125

			if var_297_9 <= arg_294_1.time_ and arg_294_1.time_ < var_297_9 + var_297_10 and not isNil(var_297_8) then
				local var_297_11 = (arg_294_1.time_ - var_297_9) / var_297_10

				if arg_294_1.var_.actorSpriteComps1086 then
					for iter_297_4, iter_297_5 in pairs(arg_294_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_297_5 then
							if arg_294_1.isInRecall_ then
								local var_297_12 = Mathf.Lerp(iter_297_5.color.r, arg_294_1.hightColor2.r, var_297_11)
								local var_297_13 = Mathf.Lerp(iter_297_5.color.g, arg_294_1.hightColor2.g, var_297_11)
								local var_297_14 = Mathf.Lerp(iter_297_5.color.b, arg_294_1.hightColor2.b, var_297_11)

								iter_297_5.color = Color.New(var_297_12, var_297_13, var_297_14)
							else
								local var_297_15 = Mathf.Lerp(iter_297_5.color.r, 0.5, var_297_11)

								iter_297_5.color = Color.New(var_297_15, var_297_15, var_297_15)
							end
						end
					end
				end
			end

			if arg_294_1.time_ >= var_297_9 + var_297_10 and arg_294_1.time_ < var_297_9 + var_297_10 + arg_297_0 and not isNil(var_297_8) and arg_294_1.var_.actorSpriteComps1086 then
				for iter_297_6, iter_297_7 in pairs(arg_294_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_297_7 then
						if arg_294_1.isInRecall_ then
							iter_297_7.color = arg_294_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_297_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_294_1.var_.actorSpriteComps1086 = nil
			end

			local var_297_16 = 0
			local var_297_17 = 0.425

			if var_297_16 < arg_294_1.time_ and arg_294_1.time_ <= var_297_16 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_18 = arg_294_1:FormatText(StoryNameCfg[327].name)

				arg_294_1.leftNameTxt_.text = var_297_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_19 = arg_294_1:GetWordFromCfg(416051069)
				local var_297_20 = arg_294_1:FormatText(var_297_19.content)

				arg_294_1.text_.text = var_297_20

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_21 = 17
				local var_297_22 = utf8.len(var_297_20)
				local var_297_23 = var_297_21 <= 0 and var_297_17 or var_297_17 * (var_297_22 / var_297_21)

				if var_297_23 > 0 and var_297_17 < var_297_23 then
					arg_294_1.talkMaxDuration = var_297_23

					if var_297_23 + var_297_16 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_23 + var_297_16
					end
				end

				arg_294_1.text_.text = var_297_20
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051069", "story_v_out_416051.awb") ~= 0 then
					local var_297_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051069", "story_v_out_416051.awb") / 1000

					if var_297_24 + var_297_16 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_24 + var_297_16
					end

					if var_297_19.prefab_name ~= "" and arg_294_1.actors_[var_297_19.prefab_name] ~= nil then
						local var_297_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_19.prefab_name].transform, "story_v_out_416051", "416051069", "story_v_out_416051.awb")

						arg_294_1:RecordAudio("416051069", var_297_25)
						arg_294_1:RecordAudio("416051069", var_297_25)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_416051", "416051069", "story_v_out_416051.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_416051", "416051069", "story_v_out_416051.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_26 = math.max(var_297_17, arg_294_1.talkMaxDuration)

			if var_297_16 <= arg_294_1.time_ and arg_294_1.time_ < var_297_16 + var_297_26 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_16) / var_297_26

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_16 + var_297_26 and arg_294_1.time_ < var_297_16 + var_297_26 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play416051070 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 416051070
		arg_298_1.duration_ = 7.33

		local var_298_0 = {
			zh = 5.966,
			ja = 7.333
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play416051071(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["1028"]
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.actorSpriteComps1028 == nil then
				arg_298_1.var_.actorSpriteComps1028 = var_301_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_301_2 = 0.125

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 and not isNil(var_301_0) then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2

				if arg_298_1.var_.actorSpriteComps1028 then
					for iter_301_0, iter_301_1 in pairs(arg_298_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_301_1 then
							if arg_298_1.isInRecall_ then
								local var_301_4 = Mathf.Lerp(iter_301_1.color.r, arg_298_1.hightColor2.r, var_301_3)
								local var_301_5 = Mathf.Lerp(iter_301_1.color.g, arg_298_1.hightColor2.g, var_301_3)
								local var_301_6 = Mathf.Lerp(iter_301_1.color.b, arg_298_1.hightColor2.b, var_301_3)

								iter_301_1.color = Color.New(var_301_4, var_301_5, var_301_6)
							else
								local var_301_7 = Mathf.Lerp(iter_301_1.color.r, 0.5, var_301_3)

								iter_301_1.color = Color.New(var_301_7, var_301_7, var_301_7)
							end
						end
					end
				end
			end

			if arg_298_1.time_ >= var_301_1 + var_301_2 and arg_298_1.time_ < var_301_1 + var_301_2 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.actorSpriteComps1028 then
				for iter_301_2, iter_301_3 in pairs(arg_298_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_301_3 then
						if arg_298_1.isInRecall_ then
							iter_301_3.color = arg_298_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_301_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_298_1.var_.actorSpriteComps1028 = nil
			end

			local var_301_8 = arg_298_1.actors_["1086"]
			local var_301_9 = 0

			if var_301_9 < arg_298_1.time_ and arg_298_1.time_ <= var_301_9 + arg_301_0 and not isNil(var_301_8) and arg_298_1.var_.actorSpriteComps1086 == nil then
				arg_298_1.var_.actorSpriteComps1086 = var_301_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_301_10 = 0.125

			if var_301_9 <= arg_298_1.time_ and arg_298_1.time_ < var_301_9 + var_301_10 and not isNil(var_301_8) then
				local var_301_11 = (arg_298_1.time_ - var_301_9) / var_301_10

				if arg_298_1.var_.actorSpriteComps1086 then
					for iter_301_4, iter_301_5 in pairs(arg_298_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_301_5 then
							if arg_298_1.isInRecall_ then
								local var_301_12 = Mathf.Lerp(iter_301_5.color.r, arg_298_1.hightColor1.r, var_301_11)
								local var_301_13 = Mathf.Lerp(iter_301_5.color.g, arg_298_1.hightColor1.g, var_301_11)
								local var_301_14 = Mathf.Lerp(iter_301_5.color.b, arg_298_1.hightColor1.b, var_301_11)

								iter_301_5.color = Color.New(var_301_12, var_301_13, var_301_14)
							else
								local var_301_15 = Mathf.Lerp(iter_301_5.color.r, 1, var_301_11)

								iter_301_5.color = Color.New(var_301_15, var_301_15, var_301_15)
							end
						end
					end
				end
			end

			if arg_298_1.time_ >= var_301_9 + var_301_10 and arg_298_1.time_ < var_301_9 + var_301_10 + arg_301_0 and not isNil(var_301_8) and arg_298_1.var_.actorSpriteComps1086 then
				for iter_301_6, iter_301_7 in pairs(arg_298_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_301_7 then
						if arg_298_1.isInRecall_ then
							iter_301_7.color = arg_298_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_301_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_298_1.var_.actorSpriteComps1086 = nil
			end

			local var_301_16 = arg_298_1.actors_["1086"].transform
			local var_301_17 = 0

			if var_301_17 < arg_298_1.time_ and arg_298_1.time_ <= var_301_17 + arg_301_0 then
				arg_298_1.var_.moveOldPos1086 = var_301_16.localPosition
				var_301_16.localScale = Vector3.New(1, 1, 1)

				arg_298_1:CheckSpriteTmpPos("1086", 4)

				local var_301_18 = var_301_16.childCount

				for iter_301_8 = 0, var_301_18 - 1 do
					local var_301_19 = var_301_16:GetChild(iter_301_8)

					if var_301_19.name == "split_4" or not string.find(var_301_19.name, "split") then
						var_301_19.gameObject:SetActive(true)
					else
						var_301_19.gameObject:SetActive(false)
					end
				end
			end

			local var_301_20 = 0.001

			if var_301_17 <= arg_298_1.time_ and arg_298_1.time_ < var_301_17 + var_301_20 then
				local var_301_21 = (arg_298_1.time_ - var_301_17) / var_301_20
				local var_301_22 = Vector3.New(390, -404.2, -237.9)

				var_301_16.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1086, var_301_22, var_301_21)
			end

			if arg_298_1.time_ >= var_301_17 + var_301_20 and arg_298_1.time_ < var_301_17 + var_301_20 + arg_301_0 then
				var_301_16.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_301_23 = 0
			local var_301_24 = 0.55

			if var_301_23 < arg_298_1.time_ and arg_298_1.time_ <= var_301_23 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_25 = arg_298_1:FormatText(StoryNameCfg[1080].name)

				arg_298_1.leftNameTxt_.text = var_301_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_26 = arg_298_1:GetWordFromCfg(416051070)
				local var_301_27 = arg_298_1:FormatText(var_301_26.content)

				arg_298_1.text_.text = var_301_27

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_28 = 22
				local var_301_29 = utf8.len(var_301_27)
				local var_301_30 = var_301_28 <= 0 and var_301_24 or var_301_24 * (var_301_29 / var_301_28)

				if var_301_30 > 0 and var_301_24 < var_301_30 then
					arg_298_1.talkMaxDuration = var_301_30

					if var_301_30 + var_301_23 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_30 + var_301_23
					end
				end

				arg_298_1.text_.text = var_301_27
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051070", "story_v_out_416051.awb") ~= 0 then
					local var_301_31 = manager.audio:GetVoiceLength("story_v_out_416051", "416051070", "story_v_out_416051.awb") / 1000

					if var_301_31 + var_301_23 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_31 + var_301_23
					end

					if var_301_26.prefab_name ~= "" and arg_298_1.actors_[var_301_26.prefab_name] ~= nil then
						local var_301_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_26.prefab_name].transform, "story_v_out_416051", "416051070", "story_v_out_416051.awb")

						arg_298_1:RecordAudio("416051070", var_301_32)
						arg_298_1:RecordAudio("416051070", var_301_32)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_416051", "416051070", "story_v_out_416051.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_416051", "416051070", "story_v_out_416051.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_33 = math.max(var_301_24, arg_298_1.talkMaxDuration)

			if var_301_23 <= arg_298_1.time_ and arg_298_1.time_ < var_301_23 + var_301_33 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_23) / var_301_33

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_23 + var_301_33 and arg_298_1.time_ < var_301_23 + var_301_33 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play416051071 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 416051071
		arg_302_1.duration_ = 7.9

		local var_302_0 = {
			zh = 4.533,
			ja = 7.9
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play416051072(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["1028"]
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.actorSpriteComps1028 == nil then
				arg_302_1.var_.actorSpriteComps1028 = var_305_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_305_2 = 0.125

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 and not isNil(var_305_0) then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2

				if arg_302_1.var_.actorSpriteComps1028 then
					for iter_305_0, iter_305_1 in pairs(arg_302_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_305_1 then
							if arg_302_1.isInRecall_ then
								local var_305_4 = Mathf.Lerp(iter_305_1.color.r, arg_302_1.hightColor1.r, var_305_3)
								local var_305_5 = Mathf.Lerp(iter_305_1.color.g, arg_302_1.hightColor1.g, var_305_3)
								local var_305_6 = Mathf.Lerp(iter_305_1.color.b, arg_302_1.hightColor1.b, var_305_3)

								iter_305_1.color = Color.New(var_305_4, var_305_5, var_305_6)
							else
								local var_305_7 = Mathf.Lerp(iter_305_1.color.r, 1, var_305_3)

								iter_305_1.color = Color.New(var_305_7, var_305_7, var_305_7)
							end
						end
					end
				end
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.actorSpriteComps1028 then
				for iter_305_2, iter_305_3 in pairs(arg_302_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_305_3 then
						if arg_302_1.isInRecall_ then
							iter_305_3.color = arg_302_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_305_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_302_1.var_.actorSpriteComps1028 = nil
			end

			local var_305_8 = arg_302_1.actors_["1086"]
			local var_305_9 = 0

			if var_305_9 < arg_302_1.time_ and arg_302_1.time_ <= var_305_9 + arg_305_0 and not isNil(var_305_8) and arg_302_1.var_.actorSpriteComps1086 == nil then
				arg_302_1.var_.actorSpriteComps1086 = var_305_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_305_10 = 0.125

			if var_305_9 <= arg_302_1.time_ and arg_302_1.time_ < var_305_9 + var_305_10 and not isNil(var_305_8) then
				local var_305_11 = (arg_302_1.time_ - var_305_9) / var_305_10

				if arg_302_1.var_.actorSpriteComps1086 then
					for iter_305_4, iter_305_5 in pairs(arg_302_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_305_5 then
							if arg_302_1.isInRecall_ then
								local var_305_12 = Mathf.Lerp(iter_305_5.color.r, arg_302_1.hightColor2.r, var_305_11)
								local var_305_13 = Mathf.Lerp(iter_305_5.color.g, arg_302_1.hightColor2.g, var_305_11)
								local var_305_14 = Mathf.Lerp(iter_305_5.color.b, arg_302_1.hightColor2.b, var_305_11)

								iter_305_5.color = Color.New(var_305_12, var_305_13, var_305_14)
							else
								local var_305_15 = Mathf.Lerp(iter_305_5.color.r, 0.5, var_305_11)

								iter_305_5.color = Color.New(var_305_15, var_305_15, var_305_15)
							end
						end
					end
				end
			end

			if arg_302_1.time_ >= var_305_9 + var_305_10 and arg_302_1.time_ < var_305_9 + var_305_10 + arg_305_0 and not isNil(var_305_8) and arg_302_1.var_.actorSpriteComps1086 then
				for iter_305_6, iter_305_7 in pairs(arg_302_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_305_7 then
						if arg_302_1.isInRecall_ then
							iter_305_7.color = arg_302_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_305_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_302_1.var_.actorSpriteComps1086 = nil
			end

			local var_305_16 = 0
			local var_305_17 = 0.575

			if var_305_16 < arg_302_1.time_ and arg_302_1.time_ <= var_305_16 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_18 = arg_302_1:FormatText(StoryNameCfg[327].name)

				arg_302_1.leftNameTxt_.text = var_305_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_19 = arg_302_1:GetWordFromCfg(416051071)
				local var_305_20 = arg_302_1:FormatText(var_305_19.content)

				arg_302_1.text_.text = var_305_20

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_21 = 23
				local var_305_22 = utf8.len(var_305_20)
				local var_305_23 = var_305_21 <= 0 and var_305_17 or var_305_17 * (var_305_22 / var_305_21)

				if var_305_23 > 0 and var_305_17 < var_305_23 then
					arg_302_1.talkMaxDuration = var_305_23

					if var_305_23 + var_305_16 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_23 + var_305_16
					end
				end

				arg_302_1.text_.text = var_305_20
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051071", "story_v_out_416051.awb") ~= 0 then
					local var_305_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051071", "story_v_out_416051.awb") / 1000

					if var_305_24 + var_305_16 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_24 + var_305_16
					end

					if var_305_19.prefab_name ~= "" and arg_302_1.actors_[var_305_19.prefab_name] ~= nil then
						local var_305_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_19.prefab_name].transform, "story_v_out_416051", "416051071", "story_v_out_416051.awb")

						arg_302_1:RecordAudio("416051071", var_305_25)
						arg_302_1:RecordAudio("416051071", var_305_25)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_416051", "416051071", "story_v_out_416051.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_416051", "416051071", "story_v_out_416051.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_26 = math.max(var_305_17, arg_302_1.talkMaxDuration)

			if var_305_16 <= arg_302_1.time_ and arg_302_1.time_ < var_305_16 + var_305_26 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_16) / var_305_26

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_16 + var_305_26 and arg_302_1.time_ < var_305_16 + var_305_26 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play416051072 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 416051072
		arg_306_1.duration_ = 6.9

		local var_306_0 = {
			zh = 5.133,
			ja = 6.9
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play416051073(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["1028"]
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.actorSpriteComps1028 == nil then
				arg_306_1.var_.actorSpriteComps1028 = var_309_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_2 = 0.125

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 and not isNil(var_309_0) then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2

				if arg_306_1.var_.actorSpriteComps1028 then
					for iter_309_0, iter_309_1 in pairs(arg_306_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_309_1 then
							if arg_306_1.isInRecall_ then
								local var_309_4 = Mathf.Lerp(iter_309_1.color.r, arg_306_1.hightColor2.r, var_309_3)
								local var_309_5 = Mathf.Lerp(iter_309_1.color.g, arg_306_1.hightColor2.g, var_309_3)
								local var_309_6 = Mathf.Lerp(iter_309_1.color.b, arg_306_1.hightColor2.b, var_309_3)

								iter_309_1.color = Color.New(var_309_4, var_309_5, var_309_6)
							else
								local var_309_7 = Mathf.Lerp(iter_309_1.color.r, 0.5, var_309_3)

								iter_309_1.color = Color.New(var_309_7, var_309_7, var_309_7)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.actorSpriteComps1028 then
				for iter_309_2, iter_309_3 in pairs(arg_306_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_309_3 then
						if arg_306_1.isInRecall_ then
							iter_309_3.color = arg_306_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_309_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_306_1.var_.actorSpriteComps1028 = nil
			end

			local var_309_8 = arg_306_1.actors_["1086"]
			local var_309_9 = 0

			if var_309_9 < arg_306_1.time_ and arg_306_1.time_ <= var_309_9 + arg_309_0 and not isNil(var_309_8) and arg_306_1.var_.actorSpriteComps1086 == nil then
				arg_306_1.var_.actorSpriteComps1086 = var_309_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_10 = 0.125

			if var_309_9 <= arg_306_1.time_ and arg_306_1.time_ < var_309_9 + var_309_10 and not isNil(var_309_8) then
				local var_309_11 = (arg_306_1.time_ - var_309_9) / var_309_10

				if arg_306_1.var_.actorSpriteComps1086 then
					for iter_309_4, iter_309_5 in pairs(arg_306_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_309_5 then
							if arg_306_1.isInRecall_ then
								local var_309_12 = Mathf.Lerp(iter_309_5.color.r, arg_306_1.hightColor1.r, var_309_11)
								local var_309_13 = Mathf.Lerp(iter_309_5.color.g, arg_306_1.hightColor1.g, var_309_11)
								local var_309_14 = Mathf.Lerp(iter_309_5.color.b, arg_306_1.hightColor1.b, var_309_11)

								iter_309_5.color = Color.New(var_309_12, var_309_13, var_309_14)
							else
								local var_309_15 = Mathf.Lerp(iter_309_5.color.r, 1, var_309_11)

								iter_309_5.color = Color.New(var_309_15, var_309_15, var_309_15)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= var_309_9 + var_309_10 and arg_306_1.time_ < var_309_9 + var_309_10 + arg_309_0 and not isNil(var_309_8) and arg_306_1.var_.actorSpriteComps1086 then
				for iter_309_6, iter_309_7 in pairs(arg_306_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_309_7 then
						if arg_306_1.isInRecall_ then
							iter_309_7.color = arg_306_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_309_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_306_1.var_.actorSpriteComps1086 = nil
			end

			local var_309_16 = 0
			local var_309_17 = 0.7

			if var_309_16 < arg_306_1.time_ and arg_306_1.time_ <= var_309_16 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_18 = arg_306_1:FormatText(StoryNameCfg[1080].name)

				arg_306_1.leftNameTxt_.text = var_309_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_19 = arg_306_1:GetWordFromCfg(416051072)
				local var_309_20 = arg_306_1:FormatText(var_309_19.content)

				arg_306_1.text_.text = var_309_20

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_21 = 28
				local var_309_22 = utf8.len(var_309_20)
				local var_309_23 = var_309_21 <= 0 and var_309_17 or var_309_17 * (var_309_22 / var_309_21)

				if var_309_23 > 0 and var_309_17 < var_309_23 then
					arg_306_1.talkMaxDuration = var_309_23

					if var_309_23 + var_309_16 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_23 + var_309_16
					end
				end

				arg_306_1.text_.text = var_309_20
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051072", "story_v_out_416051.awb") ~= 0 then
					local var_309_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051072", "story_v_out_416051.awb") / 1000

					if var_309_24 + var_309_16 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_24 + var_309_16
					end

					if var_309_19.prefab_name ~= "" and arg_306_1.actors_[var_309_19.prefab_name] ~= nil then
						local var_309_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_19.prefab_name].transform, "story_v_out_416051", "416051072", "story_v_out_416051.awb")

						arg_306_1:RecordAudio("416051072", var_309_25)
						arg_306_1:RecordAudio("416051072", var_309_25)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_416051", "416051072", "story_v_out_416051.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_416051", "416051072", "story_v_out_416051.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_26 = math.max(var_309_17, arg_306_1.talkMaxDuration)

			if var_309_16 <= arg_306_1.time_ and arg_306_1.time_ < var_309_16 + var_309_26 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_16) / var_309_26

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_16 + var_309_26 and arg_306_1.time_ < var_309_16 + var_309_26 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play416051073 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 416051073
		arg_310_1.duration_ = 5.77

		local var_310_0 = {
			zh = 4.2,
			ja = 5.766
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play416051074(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["1028"]
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.actorSpriteComps1028 == nil then
				arg_310_1.var_.actorSpriteComps1028 = var_313_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_2 = 0.125

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 and not isNil(var_313_0) then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2

				if arg_310_1.var_.actorSpriteComps1028 then
					for iter_313_0, iter_313_1 in pairs(arg_310_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_313_1 then
							if arg_310_1.isInRecall_ then
								local var_313_4 = Mathf.Lerp(iter_313_1.color.r, arg_310_1.hightColor1.r, var_313_3)
								local var_313_5 = Mathf.Lerp(iter_313_1.color.g, arg_310_1.hightColor1.g, var_313_3)
								local var_313_6 = Mathf.Lerp(iter_313_1.color.b, arg_310_1.hightColor1.b, var_313_3)

								iter_313_1.color = Color.New(var_313_4, var_313_5, var_313_6)
							else
								local var_313_7 = Mathf.Lerp(iter_313_1.color.r, 1, var_313_3)

								iter_313_1.color = Color.New(var_313_7, var_313_7, var_313_7)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.actorSpriteComps1028 then
				for iter_313_2, iter_313_3 in pairs(arg_310_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_313_3 then
						if arg_310_1.isInRecall_ then
							iter_313_3.color = arg_310_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_313_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_310_1.var_.actorSpriteComps1028 = nil
			end

			local var_313_8 = arg_310_1.actors_["1086"]
			local var_313_9 = 0

			if var_313_9 < arg_310_1.time_ and arg_310_1.time_ <= var_313_9 + arg_313_0 and not isNil(var_313_8) and arg_310_1.var_.actorSpriteComps1086 == nil then
				arg_310_1.var_.actorSpriteComps1086 = var_313_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_10 = 0.125

			if var_313_9 <= arg_310_1.time_ and arg_310_1.time_ < var_313_9 + var_313_10 and not isNil(var_313_8) then
				local var_313_11 = (arg_310_1.time_ - var_313_9) / var_313_10

				if arg_310_1.var_.actorSpriteComps1086 then
					for iter_313_4, iter_313_5 in pairs(arg_310_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_313_5 then
							if arg_310_1.isInRecall_ then
								local var_313_12 = Mathf.Lerp(iter_313_5.color.r, arg_310_1.hightColor2.r, var_313_11)
								local var_313_13 = Mathf.Lerp(iter_313_5.color.g, arg_310_1.hightColor2.g, var_313_11)
								local var_313_14 = Mathf.Lerp(iter_313_5.color.b, arg_310_1.hightColor2.b, var_313_11)

								iter_313_5.color = Color.New(var_313_12, var_313_13, var_313_14)
							else
								local var_313_15 = Mathf.Lerp(iter_313_5.color.r, 0.5, var_313_11)

								iter_313_5.color = Color.New(var_313_15, var_313_15, var_313_15)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= var_313_9 + var_313_10 and arg_310_1.time_ < var_313_9 + var_313_10 + arg_313_0 and not isNil(var_313_8) and arg_310_1.var_.actorSpriteComps1086 then
				for iter_313_6, iter_313_7 in pairs(arg_310_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_313_7 then
						if arg_310_1.isInRecall_ then
							iter_313_7.color = arg_310_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_313_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_310_1.var_.actorSpriteComps1086 = nil
			end

			local var_313_16 = 0
			local var_313_17 = 0.425

			if var_313_16 < arg_310_1.time_ and arg_310_1.time_ <= var_313_16 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_18 = arg_310_1:FormatText(StoryNameCfg[327].name)

				arg_310_1.leftNameTxt_.text = var_313_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_19 = arg_310_1:GetWordFromCfg(416051073)
				local var_313_20 = arg_310_1:FormatText(var_313_19.content)

				arg_310_1.text_.text = var_313_20

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_21 = 17
				local var_313_22 = utf8.len(var_313_20)
				local var_313_23 = var_313_21 <= 0 and var_313_17 or var_313_17 * (var_313_22 / var_313_21)

				if var_313_23 > 0 and var_313_17 < var_313_23 then
					arg_310_1.talkMaxDuration = var_313_23

					if var_313_23 + var_313_16 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_23 + var_313_16
					end
				end

				arg_310_1.text_.text = var_313_20
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051073", "story_v_out_416051.awb") ~= 0 then
					local var_313_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051073", "story_v_out_416051.awb") / 1000

					if var_313_24 + var_313_16 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_24 + var_313_16
					end

					if var_313_19.prefab_name ~= "" and arg_310_1.actors_[var_313_19.prefab_name] ~= nil then
						local var_313_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_19.prefab_name].transform, "story_v_out_416051", "416051073", "story_v_out_416051.awb")

						arg_310_1:RecordAudio("416051073", var_313_25)
						arg_310_1:RecordAudio("416051073", var_313_25)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_416051", "416051073", "story_v_out_416051.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_416051", "416051073", "story_v_out_416051.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_26 = math.max(var_313_17, arg_310_1.talkMaxDuration)

			if var_313_16 <= arg_310_1.time_ and arg_310_1.time_ < var_313_16 + var_313_26 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_16) / var_313_26

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_16 + var_313_26 and arg_310_1.time_ < var_313_16 + var_313_26 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play416051074 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 416051074
		arg_314_1.duration_ = 5.97

		local var_314_0 = {
			zh = 5.9,
			ja = 5.966
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play416051075(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["1028"]
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.actorSpriteComps1028 == nil then
				arg_314_1.var_.actorSpriteComps1028 = var_317_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_2 = 0.125

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 and not isNil(var_317_0) then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2

				if arg_314_1.var_.actorSpriteComps1028 then
					for iter_317_0, iter_317_1 in pairs(arg_314_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_317_1 then
							if arg_314_1.isInRecall_ then
								local var_317_4 = Mathf.Lerp(iter_317_1.color.r, arg_314_1.hightColor2.r, var_317_3)
								local var_317_5 = Mathf.Lerp(iter_317_1.color.g, arg_314_1.hightColor2.g, var_317_3)
								local var_317_6 = Mathf.Lerp(iter_317_1.color.b, arg_314_1.hightColor2.b, var_317_3)

								iter_317_1.color = Color.New(var_317_4, var_317_5, var_317_6)
							else
								local var_317_7 = Mathf.Lerp(iter_317_1.color.r, 0.5, var_317_3)

								iter_317_1.color = Color.New(var_317_7, var_317_7, var_317_7)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.actorSpriteComps1028 then
				for iter_317_2, iter_317_3 in pairs(arg_314_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_317_3 then
						if arg_314_1.isInRecall_ then
							iter_317_3.color = arg_314_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_317_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_314_1.var_.actorSpriteComps1028 = nil
			end

			local var_317_8 = arg_314_1.actors_["1086"]
			local var_317_9 = 0

			if var_317_9 < arg_314_1.time_ and arg_314_1.time_ <= var_317_9 + arg_317_0 and not isNil(var_317_8) and arg_314_1.var_.actorSpriteComps1086 == nil then
				arg_314_1.var_.actorSpriteComps1086 = var_317_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_10 = 0.125

			if var_317_9 <= arg_314_1.time_ and arg_314_1.time_ < var_317_9 + var_317_10 and not isNil(var_317_8) then
				local var_317_11 = (arg_314_1.time_ - var_317_9) / var_317_10

				if arg_314_1.var_.actorSpriteComps1086 then
					for iter_317_4, iter_317_5 in pairs(arg_314_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_317_5 then
							if arg_314_1.isInRecall_ then
								local var_317_12 = Mathf.Lerp(iter_317_5.color.r, arg_314_1.hightColor1.r, var_317_11)
								local var_317_13 = Mathf.Lerp(iter_317_5.color.g, arg_314_1.hightColor1.g, var_317_11)
								local var_317_14 = Mathf.Lerp(iter_317_5.color.b, arg_314_1.hightColor1.b, var_317_11)

								iter_317_5.color = Color.New(var_317_12, var_317_13, var_317_14)
							else
								local var_317_15 = Mathf.Lerp(iter_317_5.color.r, 1, var_317_11)

								iter_317_5.color = Color.New(var_317_15, var_317_15, var_317_15)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= var_317_9 + var_317_10 and arg_314_1.time_ < var_317_9 + var_317_10 + arg_317_0 and not isNil(var_317_8) and arg_314_1.var_.actorSpriteComps1086 then
				for iter_317_6, iter_317_7 in pairs(arg_314_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_317_7 then
						if arg_314_1.isInRecall_ then
							iter_317_7.color = arg_314_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_317_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_314_1.var_.actorSpriteComps1086 = nil
			end

			local var_317_16 = arg_314_1.actors_["1086"].transform
			local var_317_17 = 0

			if var_317_17 < arg_314_1.time_ and arg_314_1.time_ <= var_317_17 + arg_317_0 then
				arg_314_1.var_.moveOldPos1086 = var_317_16.localPosition
				var_317_16.localScale = Vector3.New(1, 1, 1)

				arg_314_1:CheckSpriteTmpPos("1086", 4)

				local var_317_18 = var_317_16.childCount

				for iter_317_8 = 0, var_317_18 - 1 do
					local var_317_19 = var_317_16:GetChild(iter_317_8)

					if var_317_19.name == "split_1" or not string.find(var_317_19.name, "split") then
						var_317_19.gameObject:SetActive(true)
					else
						var_317_19.gameObject:SetActive(false)
					end
				end
			end

			local var_317_20 = 0.001

			if var_317_17 <= arg_314_1.time_ and arg_314_1.time_ < var_317_17 + var_317_20 then
				local var_317_21 = (arg_314_1.time_ - var_317_17) / var_317_20
				local var_317_22 = Vector3.New(390, -404.2, -237.9)

				var_317_16.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos1086, var_317_22, var_317_21)
			end

			if arg_314_1.time_ >= var_317_17 + var_317_20 and arg_314_1.time_ < var_317_17 + var_317_20 + arg_317_0 then
				var_317_16.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_317_23 = 0
			local var_317_24 = 0.675

			if var_317_23 < arg_314_1.time_ and arg_314_1.time_ <= var_317_23 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_25 = arg_314_1:FormatText(StoryNameCfg[1080].name)

				arg_314_1.leftNameTxt_.text = var_317_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_26 = arg_314_1:GetWordFromCfg(416051074)
				local var_317_27 = arg_314_1:FormatText(var_317_26.content)

				arg_314_1.text_.text = var_317_27

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_28 = 27
				local var_317_29 = utf8.len(var_317_27)
				local var_317_30 = var_317_28 <= 0 and var_317_24 or var_317_24 * (var_317_29 / var_317_28)

				if var_317_30 > 0 and var_317_24 < var_317_30 then
					arg_314_1.talkMaxDuration = var_317_30

					if var_317_30 + var_317_23 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_30 + var_317_23
					end
				end

				arg_314_1.text_.text = var_317_27
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051074", "story_v_out_416051.awb") ~= 0 then
					local var_317_31 = manager.audio:GetVoiceLength("story_v_out_416051", "416051074", "story_v_out_416051.awb") / 1000

					if var_317_31 + var_317_23 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_31 + var_317_23
					end

					if var_317_26.prefab_name ~= "" and arg_314_1.actors_[var_317_26.prefab_name] ~= nil then
						local var_317_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_26.prefab_name].transform, "story_v_out_416051", "416051074", "story_v_out_416051.awb")

						arg_314_1:RecordAudio("416051074", var_317_32)
						arg_314_1:RecordAudio("416051074", var_317_32)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_416051", "416051074", "story_v_out_416051.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_416051", "416051074", "story_v_out_416051.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_33 = math.max(var_317_24, arg_314_1.talkMaxDuration)

			if var_317_23 <= arg_314_1.time_ and arg_314_1.time_ < var_317_23 + var_317_33 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_23) / var_317_33

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_23 + var_317_33 and arg_314_1.time_ < var_317_23 + var_317_33 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_314_1:InitPlayNodeList()
	end,
	Play416051075 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 416051075
		arg_318_1.duration_ = 5.77

		local var_318_0 = {
			zh = 4.733,
			ja = 5.766
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play416051076(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["1028"]
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.actorSpriteComps1028 == nil then
				arg_318_1.var_.actorSpriteComps1028 = var_321_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_321_2 = 0.125

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_2 and not isNil(var_321_0) then
				local var_321_3 = (arg_318_1.time_ - var_321_1) / var_321_2

				if arg_318_1.var_.actorSpriteComps1028 then
					for iter_321_0, iter_321_1 in pairs(arg_318_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_321_1 then
							if arg_318_1.isInRecall_ then
								local var_321_4 = Mathf.Lerp(iter_321_1.color.r, arg_318_1.hightColor1.r, var_321_3)
								local var_321_5 = Mathf.Lerp(iter_321_1.color.g, arg_318_1.hightColor1.g, var_321_3)
								local var_321_6 = Mathf.Lerp(iter_321_1.color.b, arg_318_1.hightColor1.b, var_321_3)

								iter_321_1.color = Color.New(var_321_4, var_321_5, var_321_6)
							else
								local var_321_7 = Mathf.Lerp(iter_321_1.color.r, 1, var_321_3)

								iter_321_1.color = Color.New(var_321_7, var_321_7, var_321_7)
							end
						end
					end
				end
			end

			if arg_318_1.time_ >= var_321_1 + var_321_2 and arg_318_1.time_ < var_321_1 + var_321_2 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.actorSpriteComps1028 then
				for iter_321_2, iter_321_3 in pairs(arg_318_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_321_3 then
						if arg_318_1.isInRecall_ then
							iter_321_3.color = arg_318_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_321_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_318_1.var_.actorSpriteComps1028 = nil
			end

			local var_321_8 = arg_318_1.actors_["1086"]
			local var_321_9 = 0

			if var_321_9 < arg_318_1.time_ and arg_318_1.time_ <= var_321_9 + arg_321_0 and not isNil(var_321_8) and arg_318_1.var_.actorSpriteComps1086 == nil then
				arg_318_1.var_.actorSpriteComps1086 = var_321_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_321_10 = 0.125

			if var_321_9 <= arg_318_1.time_ and arg_318_1.time_ < var_321_9 + var_321_10 and not isNil(var_321_8) then
				local var_321_11 = (arg_318_1.time_ - var_321_9) / var_321_10

				if arg_318_1.var_.actorSpriteComps1086 then
					for iter_321_4, iter_321_5 in pairs(arg_318_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_321_5 then
							if arg_318_1.isInRecall_ then
								local var_321_12 = Mathf.Lerp(iter_321_5.color.r, arg_318_1.hightColor2.r, var_321_11)
								local var_321_13 = Mathf.Lerp(iter_321_5.color.g, arg_318_1.hightColor2.g, var_321_11)
								local var_321_14 = Mathf.Lerp(iter_321_5.color.b, arg_318_1.hightColor2.b, var_321_11)

								iter_321_5.color = Color.New(var_321_12, var_321_13, var_321_14)
							else
								local var_321_15 = Mathf.Lerp(iter_321_5.color.r, 0.5, var_321_11)

								iter_321_5.color = Color.New(var_321_15, var_321_15, var_321_15)
							end
						end
					end
				end
			end

			if arg_318_1.time_ >= var_321_9 + var_321_10 and arg_318_1.time_ < var_321_9 + var_321_10 + arg_321_0 and not isNil(var_321_8) and arg_318_1.var_.actorSpriteComps1086 then
				for iter_321_6, iter_321_7 in pairs(arg_318_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_321_7 then
						if arg_318_1.isInRecall_ then
							iter_321_7.color = arg_318_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_321_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_318_1.var_.actorSpriteComps1086 = nil
			end

			local var_321_16 = 0
			local var_321_17 = 0.525

			if var_321_16 < arg_318_1.time_ and arg_318_1.time_ <= var_321_16 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_18 = arg_318_1:FormatText(StoryNameCfg[327].name)

				arg_318_1.leftNameTxt_.text = var_321_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_19 = arg_318_1:GetWordFromCfg(416051075)
				local var_321_20 = arg_318_1:FormatText(var_321_19.content)

				arg_318_1.text_.text = var_321_20

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_21 = 21
				local var_321_22 = utf8.len(var_321_20)
				local var_321_23 = var_321_21 <= 0 and var_321_17 or var_321_17 * (var_321_22 / var_321_21)

				if var_321_23 > 0 and var_321_17 < var_321_23 then
					arg_318_1.talkMaxDuration = var_321_23

					if var_321_23 + var_321_16 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_23 + var_321_16
					end
				end

				arg_318_1.text_.text = var_321_20
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051075", "story_v_out_416051.awb") ~= 0 then
					local var_321_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051075", "story_v_out_416051.awb") / 1000

					if var_321_24 + var_321_16 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_24 + var_321_16
					end

					if var_321_19.prefab_name ~= "" and arg_318_1.actors_[var_321_19.prefab_name] ~= nil then
						local var_321_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_19.prefab_name].transform, "story_v_out_416051", "416051075", "story_v_out_416051.awb")

						arg_318_1:RecordAudio("416051075", var_321_25)
						arg_318_1:RecordAudio("416051075", var_321_25)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_416051", "416051075", "story_v_out_416051.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_416051", "416051075", "story_v_out_416051.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_26 = math.max(var_321_17, arg_318_1.talkMaxDuration)

			if var_321_16 <= arg_318_1.time_ and arg_318_1.time_ < var_321_16 + var_321_26 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_16) / var_321_26

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_16 + var_321_26 and arg_318_1.time_ < var_321_16 + var_321_26 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play416051076 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 416051076
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play416051077(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = arg_322_1.actors_["1028"]
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.actorSpriteComps1028 == nil then
				arg_322_1.var_.actorSpriteComps1028 = var_325_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_325_2 = 0.125

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_2 and not isNil(var_325_0) then
				local var_325_3 = (arg_322_1.time_ - var_325_1) / var_325_2

				if arg_322_1.var_.actorSpriteComps1028 then
					for iter_325_0, iter_325_1 in pairs(arg_322_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_325_1 then
							if arg_322_1.isInRecall_ then
								local var_325_4 = Mathf.Lerp(iter_325_1.color.r, arg_322_1.hightColor2.r, var_325_3)
								local var_325_5 = Mathf.Lerp(iter_325_1.color.g, arg_322_1.hightColor2.g, var_325_3)
								local var_325_6 = Mathf.Lerp(iter_325_1.color.b, arg_322_1.hightColor2.b, var_325_3)

								iter_325_1.color = Color.New(var_325_4, var_325_5, var_325_6)
							else
								local var_325_7 = Mathf.Lerp(iter_325_1.color.r, 0.5, var_325_3)

								iter_325_1.color = Color.New(var_325_7, var_325_7, var_325_7)
							end
						end
					end
				end
			end

			if arg_322_1.time_ >= var_325_1 + var_325_2 and arg_322_1.time_ < var_325_1 + var_325_2 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.actorSpriteComps1028 then
				for iter_325_2, iter_325_3 in pairs(arg_322_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_325_3 then
						if arg_322_1.isInRecall_ then
							iter_325_3.color = arg_322_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_325_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_322_1.var_.actorSpriteComps1028 = nil
			end

			local var_325_8 = arg_322_1.actors_["1086"]
			local var_325_9 = 0

			if var_325_9 < arg_322_1.time_ and arg_322_1.time_ <= var_325_9 + arg_325_0 and not isNil(var_325_8) and arg_322_1.var_.actorSpriteComps1086 == nil then
				arg_322_1.var_.actorSpriteComps1086 = var_325_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_325_10 = 0.125

			if var_325_9 <= arg_322_1.time_ and arg_322_1.time_ < var_325_9 + var_325_10 and not isNil(var_325_8) then
				local var_325_11 = (arg_322_1.time_ - var_325_9) / var_325_10

				if arg_322_1.var_.actorSpriteComps1086 then
					for iter_325_4, iter_325_5 in pairs(arg_322_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_325_5 then
							if arg_322_1.isInRecall_ then
								local var_325_12 = Mathf.Lerp(iter_325_5.color.r, arg_322_1.hightColor2.r, var_325_11)
								local var_325_13 = Mathf.Lerp(iter_325_5.color.g, arg_322_1.hightColor2.g, var_325_11)
								local var_325_14 = Mathf.Lerp(iter_325_5.color.b, arg_322_1.hightColor2.b, var_325_11)

								iter_325_5.color = Color.New(var_325_12, var_325_13, var_325_14)
							else
								local var_325_15 = Mathf.Lerp(iter_325_5.color.r, 0.5, var_325_11)

								iter_325_5.color = Color.New(var_325_15, var_325_15, var_325_15)
							end
						end
					end
				end
			end

			if arg_322_1.time_ >= var_325_9 + var_325_10 and arg_322_1.time_ < var_325_9 + var_325_10 + arg_325_0 and not isNil(var_325_8) and arg_322_1.var_.actorSpriteComps1086 then
				for iter_325_6, iter_325_7 in pairs(arg_322_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_325_7 then
						if arg_322_1.isInRecall_ then
							iter_325_7.color = arg_322_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_325_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_322_1.var_.actorSpriteComps1086 = nil
			end

			local var_325_16 = 0
			local var_325_17 = 1.825

			if var_325_16 < arg_322_1.time_ and arg_322_1.time_ <= var_325_16 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_18 = arg_322_1:GetWordFromCfg(416051076)
				local var_325_19 = arg_322_1:FormatText(var_325_18.content)

				arg_322_1.text_.text = var_325_19

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_20 = 73
				local var_325_21 = utf8.len(var_325_19)
				local var_325_22 = var_325_20 <= 0 and var_325_17 or var_325_17 * (var_325_21 / var_325_20)

				if var_325_22 > 0 and var_325_17 < var_325_22 then
					arg_322_1.talkMaxDuration = var_325_22

					if var_325_22 + var_325_16 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_22 + var_325_16
					end
				end

				arg_322_1.text_.text = var_325_19
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_23 = math.max(var_325_17, arg_322_1.talkMaxDuration)

			if var_325_16 <= arg_322_1.time_ and arg_322_1.time_ < var_325_16 + var_325_23 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_16) / var_325_23

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_16 + var_325_23 and arg_322_1.time_ < var_325_16 + var_325_23 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play416051077 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 416051077
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play416051078(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0
			local var_329_1 = 1.725

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_2 = arg_326_1:GetWordFromCfg(416051077)
				local var_329_3 = arg_326_1:FormatText(var_329_2.content)

				arg_326_1.text_.text = var_329_3

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_4 = 69
				local var_329_5 = utf8.len(var_329_3)
				local var_329_6 = var_329_4 <= 0 and var_329_1 or var_329_1 * (var_329_5 / var_329_4)

				if var_329_6 > 0 and var_329_1 < var_329_6 then
					arg_326_1.talkMaxDuration = var_329_6

					if var_329_6 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_6 + var_329_0
					end
				end

				arg_326_1.text_.text = var_329_3
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_7 = math.max(var_329_1, arg_326_1.talkMaxDuration)

			if var_329_0 <= arg_326_1.time_ and arg_326_1.time_ < var_329_0 + var_329_7 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_0) / var_329_7

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_0 + var_329_7 and arg_326_1.time_ < var_329_0 + var_329_7 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play416051078 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 416051078
		arg_330_1.duration_ = 2.03

		local var_330_0 = {
			zh = 2.033,
			ja = 1.433
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play416051079(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["1028"]
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.actorSpriteComps1028 == nil then
				arg_330_1.var_.actorSpriteComps1028 = var_333_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_333_2 = 0.125

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 and not isNil(var_333_0) then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2

				if arg_330_1.var_.actorSpriteComps1028 then
					for iter_333_0, iter_333_1 in pairs(arg_330_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_333_1 then
							if arg_330_1.isInRecall_ then
								local var_333_4 = Mathf.Lerp(iter_333_1.color.r, arg_330_1.hightColor1.r, var_333_3)
								local var_333_5 = Mathf.Lerp(iter_333_1.color.g, arg_330_1.hightColor1.g, var_333_3)
								local var_333_6 = Mathf.Lerp(iter_333_1.color.b, arg_330_1.hightColor1.b, var_333_3)

								iter_333_1.color = Color.New(var_333_4, var_333_5, var_333_6)
							else
								local var_333_7 = Mathf.Lerp(iter_333_1.color.r, 1, var_333_3)

								iter_333_1.color = Color.New(var_333_7, var_333_7, var_333_7)
							end
						end
					end
				end
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.actorSpriteComps1028 then
				for iter_333_2, iter_333_3 in pairs(arg_330_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_333_3 then
						if arg_330_1.isInRecall_ then
							iter_333_3.color = arg_330_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_333_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_330_1.var_.actorSpriteComps1028 = nil
			end

			local var_333_8 = arg_330_1.actors_["1086"]
			local var_333_9 = 0

			if var_333_9 < arg_330_1.time_ and arg_330_1.time_ <= var_333_9 + arg_333_0 and not isNil(var_333_8) and arg_330_1.var_.actorSpriteComps1086 == nil then
				arg_330_1.var_.actorSpriteComps1086 = var_333_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_333_10 = 0.125

			if var_333_9 <= arg_330_1.time_ and arg_330_1.time_ < var_333_9 + var_333_10 and not isNil(var_333_8) then
				local var_333_11 = (arg_330_1.time_ - var_333_9) / var_333_10

				if arg_330_1.var_.actorSpriteComps1086 then
					for iter_333_4, iter_333_5 in pairs(arg_330_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_333_5 then
							if arg_330_1.isInRecall_ then
								local var_333_12 = Mathf.Lerp(iter_333_5.color.r, arg_330_1.hightColor2.r, var_333_11)
								local var_333_13 = Mathf.Lerp(iter_333_5.color.g, arg_330_1.hightColor2.g, var_333_11)
								local var_333_14 = Mathf.Lerp(iter_333_5.color.b, arg_330_1.hightColor2.b, var_333_11)

								iter_333_5.color = Color.New(var_333_12, var_333_13, var_333_14)
							else
								local var_333_15 = Mathf.Lerp(iter_333_5.color.r, 0.5, var_333_11)

								iter_333_5.color = Color.New(var_333_15, var_333_15, var_333_15)
							end
						end
					end
				end
			end

			if arg_330_1.time_ >= var_333_9 + var_333_10 and arg_330_1.time_ < var_333_9 + var_333_10 + arg_333_0 and not isNil(var_333_8) and arg_330_1.var_.actorSpriteComps1086 then
				for iter_333_6, iter_333_7 in pairs(arg_330_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_333_7 then
						if arg_330_1.isInRecall_ then
							iter_333_7.color = arg_330_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_333_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_330_1.var_.actorSpriteComps1086 = nil
			end

			local var_333_16 = 0
			local var_333_17 = 0.1

			if var_333_16 < arg_330_1.time_ and arg_330_1.time_ <= var_333_16 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_18 = arg_330_1:FormatText(StoryNameCfg[327].name)

				arg_330_1.leftNameTxt_.text = var_333_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_19 = arg_330_1:GetWordFromCfg(416051078)
				local var_333_20 = arg_330_1:FormatText(var_333_19.content)

				arg_330_1.text_.text = var_333_20

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_21 = 4
				local var_333_22 = utf8.len(var_333_20)
				local var_333_23 = var_333_21 <= 0 and var_333_17 or var_333_17 * (var_333_22 / var_333_21)

				if var_333_23 > 0 and var_333_17 < var_333_23 then
					arg_330_1.talkMaxDuration = var_333_23

					if var_333_23 + var_333_16 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_23 + var_333_16
					end
				end

				arg_330_1.text_.text = var_333_20
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051078", "story_v_out_416051.awb") ~= 0 then
					local var_333_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051078", "story_v_out_416051.awb") / 1000

					if var_333_24 + var_333_16 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_24 + var_333_16
					end

					if var_333_19.prefab_name ~= "" and arg_330_1.actors_[var_333_19.prefab_name] ~= nil then
						local var_333_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_19.prefab_name].transform, "story_v_out_416051", "416051078", "story_v_out_416051.awb")

						arg_330_1:RecordAudio("416051078", var_333_25)
						arg_330_1:RecordAudio("416051078", var_333_25)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_416051", "416051078", "story_v_out_416051.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_416051", "416051078", "story_v_out_416051.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_26 = math.max(var_333_17, arg_330_1.talkMaxDuration)

			if var_333_16 <= arg_330_1.time_ and arg_330_1.time_ < var_333_16 + var_333_26 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_16) / var_333_26

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_16 + var_333_26 and arg_330_1.time_ < var_333_16 + var_333_26 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play416051079 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 416051079
		arg_334_1.duration_ = 7.17

		local var_334_0 = {
			zh = 6.7,
			ja = 7.166
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play416051080(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["1028"]
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.actorSpriteComps1028 == nil then
				arg_334_1.var_.actorSpriteComps1028 = var_337_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_2 = 0.125

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_2 and not isNil(var_337_0) then
				local var_337_3 = (arg_334_1.time_ - var_337_1) / var_337_2

				if arg_334_1.var_.actorSpriteComps1028 then
					for iter_337_0, iter_337_1 in pairs(arg_334_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_337_1 then
							if arg_334_1.isInRecall_ then
								local var_337_4 = Mathf.Lerp(iter_337_1.color.r, arg_334_1.hightColor2.r, var_337_3)
								local var_337_5 = Mathf.Lerp(iter_337_1.color.g, arg_334_1.hightColor2.g, var_337_3)
								local var_337_6 = Mathf.Lerp(iter_337_1.color.b, arg_334_1.hightColor2.b, var_337_3)

								iter_337_1.color = Color.New(var_337_4, var_337_5, var_337_6)
							else
								local var_337_7 = Mathf.Lerp(iter_337_1.color.r, 0.5, var_337_3)

								iter_337_1.color = Color.New(var_337_7, var_337_7, var_337_7)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= var_337_1 + var_337_2 and arg_334_1.time_ < var_337_1 + var_337_2 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.actorSpriteComps1028 then
				for iter_337_2, iter_337_3 in pairs(arg_334_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_337_3 then
						if arg_334_1.isInRecall_ then
							iter_337_3.color = arg_334_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_337_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_334_1.var_.actorSpriteComps1028 = nil
			end

			local var_337_8 = arg_334_1.actors_["1086"]
			local var_337_9 = 0

			if var_337_9 < arg_334_1.time_ and arg_334_1.time_ <= var_337_9 + arg_337_0 and not isNil(var_337_8) and arg_334_1.var_.actorSpriteComps1086 == nil then
				arg_334_1.var_.actorSpriteComps1086 = var_337_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_10 = 0.125

			if var_337_9 <= arg_334_1.time_ and arg_334_1.time_ < var_337_9 + var_337_10 and not isNil(var_337_8) then
				local var_337_11 = (arg_334_1.time_ - var_337_9) / var_337_10

				if arg_334_1.var_.actorSpriteComps1086 then
					for iter_337_4, iter_337_5 in pairs(arg_334_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_337_5 then
							if arg_334_1.isInRecall_ then
								local var_337_12 = Mathf.Lerp(iter_337_5.color.r, arg_334_1.hightColor1.r, var_337_11)
								local var_337_13 = Mathf.Lerp(iter_337_5.color.g, arg_334_1.hightColor1.g, var_337_11)
								local var_337_14 = Mathf.Lerp(iter_337_5.color.b, arg_334_1.hightColor1.b, var_337_11)

								iter_337_5.color = Color.New(var_337_12, var_337_13, var_337_14)
							else
								local var_337_15 = Mathf.Lerp(iter_337_5.color.r, 1, var_337_11)

								iter_337_5.color = Color.New(var_337_15, var_337_15, var_337_15)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= var_337_9 + var_337_10 and arg_334_1.time_ < var_337_9 + var_337_10 + arg_337_0 and not isNil(var_337_8) and arg_334_1.var_.actorSpriteComps1086 then
				for iter_337_6, iter_337_7 in pairs(arg_334_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_337_7 then
						if arg_334_1.isInRecall_ then
							iter_337_7.color = arg_334_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_337_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_334_1.var_.actorSpriteComps1086 = nil
			end

			local var_337_16 = 0
			local var_337_17 = 0.425

			if var_337_16 < arg_334_1.time_ and arg_334_1.time_ <= var_337_16 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_18 = arg_334_1:FormatText(StoryNameCfg[1080].name)

				arg_334_1.leftNameTxt_.text = var_337_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_19 = arg_334_1:GetWordFromCfg(416051079)
				local var_337_20 = arg_334_1:FormatText(var_337_19.content)

				arg_334_1.text_.text = var_337_20

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_21 = 17
				local var_337_22 = utf8.len(var_337_20)
				local var_337_23 = var_337_21 <= 0 and var_337_17 or var_337_17 * (var_337_22 / var_337_21)

				if var_337_23 > 0 and var_337_17 < var_337_23 then
					arg_334_1.talkMaxDuration = var_337_23

					if var_337_23 + var_337_16 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_23 + var_337_16
					end
				end

				arg_334_1.text_.text = var_337_20
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051079", "story_v_out_416051.awb") ~= 0 then
					local var_337_24 = manager.audio:GetVoiceLength("story_v_out_416051", "416051079", "story_v_out_416051.awb") / 1000

					if var_337_24 + var_337_16 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_24 + var_337_16
					end

					if var_337_19.prefab_name ~= "" and arg_334_1.actors_[var_337_19.prefab_name] ~= nil then
						local var_337_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_19.prefab_name].transform, "story_v_out_416051", "416051079", "story_v_out_416051.awb")

						arg_334_1:RecordAudio("416051079", var_337_25)
						arg_334_1:RecordAudio("416051079", var_337_25)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_416051", "416051079", "story_v_out_416051.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_416051", "416051079", "story_v_out_416051.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_26 = math.max(var_337_17, arg_334_1.talkMaxDuration)

			if var_337_16 <= arg_334_1.time_ and arg_334_1.time_ < var_337_16 + var_337_26 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_16) / var_337_26

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_16 + var_337_26 and arg_334_1.time_ < var_337_16 + var_337_26 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play416051080 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 416051080
		arg_338_1.duration_ = 3.73

		local var_338_0 = {
			zh = 3.066,
			ja = 3.733
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play416051081(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["1086"]
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.actorSpriteComps1086 == nil then
				arg_338_1.var_.actorSpriteComps1086 = var_341_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_341_2 = 0.125

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 and not isNil(var_341_0) then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2

				if arg_338_1.var_.actorSpriteComps1086 then
					for iter_341_0, iter_341_1 in pairs(arg_338_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_341_1 then
							if arg_338_1.isInRecall_ then
								local var_341_4 = Mathf.Lerp(iter_341_1.color.r, arg_338_1.hightColor1.r, var_341_3)
								local var_341_5 = Mathf.Lerp(iter_341_1.color.g, arg_338_1.hightColor1.g, var_341_3)
								local var_341_6 = Mathf.Lerp(iter_341_1.color.b, arg_338_1.hightColor1.b, var_341_3)

								iter_341_1.color = Color.New(var_341_4, var_341_5, var_341_6)
							else
								local var_341_7 = Mathf.Lerp(iter_341_1.color.r, 1, var_341_3)

								iter_341_1.color = Color.New(var_341_7, var_341_7, var_341_7)
							end
						end
					end
				end
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.actorSpriteComps1086 then
				for iter_341_2, iter_341_3 in pairs(arg_338_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_341_3 then
						if arg_338_1.isInRecall_ then
							iter_341_3.color = arg_338_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_341_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_338_1.var_.actorSpriteComps1086 = nil
			end

			local var_341_8 = arg_338_1.actors_["1028"].transform
			local var_341_9 = 0

			if var_341_9 < arg_338_1.time_ and arg_338_1.time_ <= var_341_9 + arg_341_0 then
				arg_338_1.var_.moveOldPos1028 = var_341_8.localPosition
				var_341_8.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("1028", 7)

				local var_341_10 = var_341_8.childCount

				for iter_341_4 = 0, var_341_10 - 1 do
					local var_341_11 = var_341_8:GetChild(iter_341_4)

					if var_341_11.name == "" or not string.find(var_341_11.name, "split") then
						var_341_11.gameObject:SetActive(true)
					else
						var_341_11.gameObject:SetActive(false)
					end
				end
			end

			local var_341_12 = 0.001

			if var_341_9 <= arg_338_1.time_ and arg_338_1.time_ < var_341_9 + var_341_12 then
				local var_341_13 = (arg_338_1.time_ - var_341_9) / var_341_12
				local var_341_14 = Vector3.New(0, -2000, 0)

				var_341_8.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1028, var_341_14, var_341_13)
			end

			if arg_338_1.time_ >= var_341_9 + var_341_12 and arg_338_1.time_ < var_341_9 + var_341_12 + arg_341_0 then
				var_341_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_341_15 = arg_338_1.actors_["1086"].transform
			local var_341_16 = 0

			if var_341_16 < arg_338_1.time_ and arg_338_1.time_ <= var_341_16 + arg_341_0 then
				arg_338_1.var_.moveOldPos1086 = var_341_15.localPosition
				var_341_15.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("1086", 3)

				local var_341_17 = var_341_15.childCount

				for iter_341_5 = 0, var_341_17 - 1 do
					local var_341_18 = var_341_15:GetChild(iter_341_5)

					if var_341_18.name == "split_3" or not string.find(var_341_18.name, "split") then
						var_341_18.gameObject:SetActive(true)
					else
						var_341_18.gameObject:SetActive(false)
					end
				end
			end

			local var_341_19 = 0.001

			if var_341_16 <= arg_338_1.time_ and arg_338_1.time_ < var_341_16 + var_341_19 then
				local var_341_20 = (arg_338_1.time_ - var_341_16) / var_341_19
				local var_341_21 = Vector3.New(0, -404.2, -237.9)

				var_341_15.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1086, var_341_21, var_341_20)
			end

			if arg_338_1.time_ >= var_341_16 + var_341_19 and arg_338_1.time_ < var_341_16 + var_341_19 + arg_341_0 then
				var_341_15.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_341_22 = 0
			local var_341_23 = 0.35

			if var_341_22 < arg_338_1.time_ and arg_338_1.time_ <= var_341_22 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_24 = arg_338_1:FormatText(StoryNameCfg[1080].name)

				arg_338_1.leftNameTxt_.text = var_341_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_25 = arg_338_1:GetWordFromCfg(416051080)
				local var_341_26 = arg_338_1:FormatText(var_341_25.content)

				arg_338_1.text_.text = var_341_26

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_27 = 14
				local var_341_28 = utf8.len(var_341_26)
				local var_341_29 = var_341_27 <= 0 and var_341_23 or var_341_23 * (var_341_28 / var_341_27)

				if var_341_29 > 0 and var_341_23 < var_341_29 then
					arg_338_1.talkMaxDuration = var_341_29

					if var_341_29 + var_341_22 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_29 + var_341_22
					end
				end

				arg_338_1.text_.text = var_341_26
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051080", "story_v_out_416051.awb") ~= 0 then
					local var_341_30 = manager.audio:GetVoiceLength("story_v_out_416051", "416051080", "story_v_out_416051.awb") / 1000

					if var_341_30 + var_341_22 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_30 + var_341_22
					end

					if var_341_25.prefab_name ~= "" and arg_338_1.actors_[var_341_25.prefab_name] ~= nil then
						local var_341_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_25.prefab_name].transform, "story_v_out_416051", "416051080", "story_v_out_416051.awb")

						arg_338_1:RecordAudio("416051080", var_341_31)
						arg_338_1:RecordAudio("416051080", var_341_31)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_416051", "416051080", "story_v_out_416051.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_416051", "416051080", "story_v_out_416051.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_32 = math.max(var_341_23, arg_338_1.talkMaxDuration)

			if var_341_22 <= arg_338_1.time_ and arg_338_1.time_ < var_341_22 + var_341_32 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_22) / var_341_32

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_22 + var_341_32 and arg_338_1.time_ < var_341_22 + var_341_32 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play416051081 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 416051081
		arg_342_1.duration_ = 6.03

		local var_342_0 = {
			zh = 2.666,
			ja = 6.033
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play416051082(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["1086"]
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.actorSpriteComps1086 == nil then
				arg_342_1.var_.actorSpriteComps1086 = var_345_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_2 = 0.125

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 and not isNil(var_345_0) then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2

				if arg_342_1.var_.actorSpriteComps1086 then
					for iter_345_0, iter_345_1 in pairs(arg_342_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_345_1 then
							if arg_342_1.isInRecall_ then
								local var_345_4 = Mathf.Lerp(iter_345_1.color.r, arg_342_1.hightColor2.r, var_345_3)
								local var_345_5 = Mathf.Lerp(iter_345_1.color.g, arg_342_1.hightColor2.g, var_345_3)
								local var_345_6 = Mathf.Lerp(iter_345_1.color.b, arg_342_1.hightColor2.b, var_345_3)

								iter_345_1.color = Color.New(var_345_4, var_345_5, var_345_6)
							else
								local var_345_7 = Mathf.Lerp(iter_345_1.color.r, 0.5, var_345_3)

								iter_345_1.color = Color.New(var_345_7, var_345_7, var_345_7)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.actorSpriteComps1086 then
				for iter_345_2, iter_345_3 in pairs(arg_342_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_345_3 then
						if arg_342_1.isInRecall_ then
							iter_345_3.color = arg_342_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_345_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_342_1.var_.actorSpriteComps1086 = nil
			end

			local var_345_8 = 0
			local var_345_9 = 0.35

			if var_345_8 < arg_342_1.time_ and arg_342_1.time_ <= var_345_8 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_10 = arg_342_1:FormatText(StoryNameCfg[546].name)

				arg_342_1.leftNameTxt_.text = var_345_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_11 = arg_342_1:GetWordFromCfg(416051081)
				local var_345_12 = arg_342_1:FormatText(var_345_11.content)

				arg_342_1.text_.text = var_345_12

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_13 = 14
				local var_345_14 = utf8.len(var_345_12)
				local var_345_15 = var_345_13 <= 0 and var_345_9 or var_345_9 * (var_345_14 / var_345_13)

				if var_345_15 > 0 and var_345_9 < var_345_15 then
					arg_342_1.talkMaxDuration = var_345_15

					if var_345_15 + var_345_8 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_15 + var_345_8
					end
				end

				arg_342_1.text_.text = var_345_12
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051081", "story_v_out_416051.awb") ~= 0 then
					local var_345_16 = manager.audio:GetVoiceLength("story_v_out_416051", "416051081", "story_v_out_416051.awb") / 1000

					if var_345_16 + var_345_8 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_16 + var_345_8
					end

					if var_345_11.prefab_name ~= "" and arg_342_1.actors_[var_345_11.prefab_name] ~= nil then
						local var_345_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_11.prefab_name].transform, "story_v_out_416051", "416051081", "story_v_out_416051.awb")

						arg_342_1:RecordAudio("416051081", var_345_17)
						arg_342_1:RecordAudio("416051081", var_345_17)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_416051", "416051081", "story_v_out_416051.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_416051", "416051081", "story_v_out_416051.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_18 = math.max(var_345_9, arg_342_1.talkMaxDuration)

			if var_345_8 <= arg_342_1.time_ and arg_342_1.time_ < var_345_8 + var_345_18 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_8) / var_345_18

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_8 + var_345_18 and arg_342_1.time_ < var_345_8 + var_345_18 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play416051082 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 416051082
		arg_346_1.duration_ = 8.73

		local var_346_0 = {
			zh = 8.033,
			ja = 8.733
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play416051083(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["1086"]
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.actorSpriteComps1086 == nil then
				arg_346_1.var_.actorSpriteComps1086 = var_349_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_349_2 = 0.125

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_2 and not isNil(var_349_0) then
				local var_349_3 = (arg_346_1.time_ - var_349_1) / var_349_2

				if arg_346_1.var_.actorSpriteComps1086 then
					for iter_349_0, iter_349_1 in pairs(arg_346_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_349_1 then
							if arg_346_1.isInRecall_ then
								local var_349_4 = Mathf.Lerp(iter_349_1.color.r, arg_346_1.hightColor1.r, var_349_3)
								local var_349_5 = Mathf.Lerp(iter_349_1.color.g, arg_346_1.hightColor1.g, var_349_3)
								local var_349_6 = Mathf.Lerp(iter_349_1.color.b, arg_346_1.hightColor1.b, var_349_3)

								iter_349_1.color = Color.New(var_349_4, var_349_5, var_349_6)
							else
								local var_349_7 = Mathf.Lerp(iter_349_1.color.r, 1, var_349_3)

								iter_349_1.color = Color.New(var_349_7, var_349_7, var_349_7)
							end
						end
					end
				end
			end

			if arg_346_1.time_ >= var_349_1 + var_349_2 and arg_346_1.time_ < var_349_1 + var_349_2 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.actorSpriteComps1086 then
				for iter_349_2, iter_349_3 in pairs(arg_346_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_349_3 then
						if arg_346_1.isInRecall_ then
							iter_349_3.color = arg_346_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_349_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_346_1.var_.actorSpriteComps1086 = nil
			end

			local var_349_8 = arg_346_1.actors_["1086"].transform
			local var_349_9 = 0

			if var_349_9 < arg_346_1.time_ and arg_346_1.time_ <= var_349_9 + arg_349_0 then
				arg_346_1.var_.moveOldPos1086 = var_349_8.localPosition
				var_349_8.localScale = Vector3.New(1, 1, 1)

				arg_346_1:CheckSpriteTmpPos("1086", 3)

				local var_349_10 = var_349_8.childCount

				for iter_349_4 = 0, var_349_10 - 1 do
					local var_349_11 = var_349_8:GetChild(iter_349_4)

					if var_349_11.name == "split_4" or not string.find(var_349_11.name, "split") then
						var_349_11.gameObject:SetActive(true)
					else
						var_349_11.gameObject:SetActive(false)
					end
				end
			end

			local var_349_12 = 0.001

			if var_349_9 <= arg_346_1.time_ and arg_346_1.time_ < var_349_9 + var_349_12 then
				local var_349_13 = (arg_346_1.time_ - var_349_9) / var_349_12
				local var_349_14 = Vector3.New(0, -404.2, -237.9)

				var_349_8.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1086, var_349_14, var_349_13)
			end

			if arg_346_1.time_ >= var_349_9 + var_349_12 and arg_346_1.time_ < var_349_9 + var_349_12 + arg_349_0 then
				var_349_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_349_15 = 0
			local var_349_16 = 0.525

			if var_349_15 < arg_346_1.time_ and arg_346_1.time_ <= var_349_15 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_17 = arg_346_1:FormatText(StoryNameCfg[1080].name)

				arg_346_1.leftNameTxt_.text = var_349_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_18 = arg_346_1:GetWordFromCfg(416051082)
				local var_349_19 = arg_346_1:FormatText(var_349_18.content)

				arg_346_1.text_.text = var_349_19

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_20 = 21
				local var_349_21 = utf8.len(var_349_19)
				local var_349_22 = var_349_20 <= 0 and var_349_16 or var_349_16 * (var_349_21 / var_349_20)

				if var_349_22 > 0 and var_349_16 < var_349_22 then
					arg_346_1.talkMaxDuration = var_349_22

					if var_349_22 + var_349_15 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_22 + var_349_15
					end
				end

				arg_346_1.text_.text = var_349_19
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051082", "story_v_out_416051.awb") ~= 0 then
					local var_349_23 = manager.audio:GetVoiceLength("story_v_out_416051", "416051082", "story_v_out_416051.awb") / 1000

					if var_349_23 + var_349_15 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_23 + var_349_15
					end

					if var_349_18.prefab_name ~= "" and arg_346_1.actors_[var_349_18.prefab_name] ~= nil then
						local var_349_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_18.prefab_name].transform, "story_v_out_416051", "416051082", "story_v_out_416051.awb")

						arg_346_1:RecordAudio("416051082", var_349_24)
						arg_346_1:RecordAudio("416051082", var_349_24)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_416051", "416051082", "story_v_out_416051.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_416051", "416051082", "story_v_out_416051.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_25 = math.max(var_349_16, arg_346_1.talkMaxDuration)

			if var_349_15 <= arg_346_1.time_ and arg_346_1.time_ < var_349_15 + var_349_25 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_15) / var_349_25

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_15 + var_349_25 and arg_346_1.time_ < var_349_15 + var_349_25 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play416051083 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 416051083
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play416051084(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["1086"]
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.actorSpriteComps1086 == nil then
				arg_350_1.var_.actorSpriteComps1086 = var_353_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_2 = 0.125

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 and not isNil(var_353_0) then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2

				if arg_350_1.var_.actorSpriteComps1086 then
					for iter_353_0, iter_353_1 in pairs(arg_350_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_353_1 then
							if arg_350_1.isInRecall_ then
								local var_353_4 = Mathf.Lerp(iter_353_1.color.r, arg_350_1.hightColor2.r, var_353_3)
								local var_353_5 = Mathf.Lerp(iter_353_1.color.g, arg_350_1.hightColor2.g, var_353_3)
								local var_353_6 = Mathf.Lerp(iter_353_1.color.b, arg_350_1.hightColor2.b, var_353_3)

								iter_353_1.color = Color.New(var_353_4, var_353_5, var_353_6)
							else
								local var_353_7 = Mathf.Lerp(iter_353_1.color.r, 0.5, var_353_3)

								iter_353_1.color = Color.New(var_353_7, var_353_7, var_353_7)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.actorSpriteComps1086 then
				for iter_353_2, iter_353_3 in pairs(arg_350_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_353_3 then
						if arg_350_1.isInRecall_ then
							iter_353_3.color = arg_350_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_353_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_350_1.var_.actorSpriteComps1086 = nil
			end

			local var_353_8 = 0.866666666666667
			local var_353_9 = 0.5

			if var_353_8 < arg_350_1.time_ and arg_350_1.time_ <= var_353_8 + arg_353_0 then
				local var_353_10 = "play"
				local var_353_11 = "effect"

				arg_350_1:AudioAction(var_353_10, var_353_11, "se_story_122_03", "se_story_122_03_swordlight", "")
			end

			local var_353_12 = 0

			if var_353_12 < arg_350_1.time_ and arg_350_1.time_ <= var_353_12 + arg_353_0 then
				arg_350_1.allBtn_.enabled = false
			end

			local var_353_13 = 0.866666666666667

			if arg_350_1.time_ >= var_353_12 + var_353_13 and arg_350_1.time_ < var_353_12 + var_353_13 + arg_353_0 then
				arg_350_1.allBtn_.enabled = true
			end

			local var_353_14 = 0
			local var_353_15 = 1.5

			if var_353_14 < arg_350_1.time_ and arg_350_1.time_ <= var_353_14 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_16 = arg_350_1:GetWordFromCfg(416051083)
				local var_353_17 = arg_350_1:FormatText(var_353_16.content)

				arg_350_1.text_.text = var_353_17

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_18 = 60
				local var_353_19 = utf8.len(var_353_17)
				local var_353_20 = var_353_18 <= 0 and var_353_15 or var_353_15 * (var_353_19 / var_353_18)

				if var_353_20 > 0 and var_353_15 < var_353_20 then
					arg_350_1.talkMaxDuration = var_353_20

					if var_353_20 + var_353_14 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_20 + var_353_14
					end
				end

				arg_350_1.text_.text = var_353_17
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_21 = math.max(var_353_15, arg_350_1.talkMaxDuration)

			if var_353_14 <= arg_350_1.time_ and arg_350_1.time_ < var_353_14 + var_353_21 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_14) / var_353_21

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_14 + var_353_21 and arg_350_1.time_ < var_353_14 + var_353_21 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play416051084 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 416051084
		arg_354_1.duration_ = 3.53

		local var_354_0 = {
			zh = 3.533,
			ja = 3.266
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
			arg_354_1.auto_ = false
		end

		function arg_354_1.playNext_(arg_356_0)
			arg_354_1.onStoryFinished_()
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["1086"]
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.actorSpriteComps1086 == nil then
				arg_354_1.var_.actorSpriteComps1086 = var_357_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_357_2 = 0.125

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 and not isNil(var_357_0) then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2

				if arg_354_1.var_.actorSpriteComps1086 then
					for iter_357_0, iter_357_1 in pairs(arg_354_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_357_1 then
							if arg_354_1.isInRecall_ then
								local var_357_4 = Mathf.Lerp(iter_357_1.color.r, arg_354_1.hightColor1.r, var_357_3)
								local var_357_5 = Mathf.Lerp(iter_357_1.color.g, arg_354_1.hightColor1.g, var_357_3)
								local var_357_6 = Mathf.Lerp(iter_357_1.color.b, arg_354_1.hightColor1.b, var_357_3)

								iter_357_1.color = Color.New(var_357_4, var_357_5, var_357_6)
							else
								local var_357_7 = Mathf.Lerp(iter_357_1.color.r, 1, var_357_3)

								iter_357_1.color = Color.New(var_357_7, var_357_7, var_357_7)
							end
						end
					end
				end
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.actorSpriteComps1086 then
				for iter_357_2, iter_357_3 in pairs(arg_354_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_357_3 then
						if arg_354_1.isInRecall_ then
							iter_357_3.color = arg_354_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_357_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_354_1.var_.actorSpriteComps1086 = nil
			end

			local var_357_8 = arg_354_1.actors_["1086"].transform
			local var_357_9 = 0

			if var_357_9 < arg_354_1.time_ and arg_354_1.time_ <= var_357_9 + arg_357_0 then
				arg_354_1.var_.moveOldPos1086 = var_357_8.localPosition
				var_357_8.localScale = Vector3.New(1, 1, 1)

				arg_354_1:CheckSpriteTmpPos("1086", 3)

				local var_357_10 = var_357_8.childCount

				for iter_357_4 = 0, var_357_10 - 1 do
					local var_357_11 = var_357_8:GetChild(iter_357_4)

					if var_357_11.name == "split_6" or not string.find(var_357_11.name, "split") then
						var_357_11.gameObject:SetActive(true)
					else
						var_357_11.gameObject:SetActive(false)
					end
				end
			end

			local var_357_12 = 0.001

			if var_357_9 <= arg_354_1.time_ and arg_354_1.time_ < var_357_9 + var_357_12 then
				local var_357_13 = (arg_354_1.time_ - var_357_9) / var_357_12
				local var_357_14 = Vector3.New(0, -404.2, -237.9)

				var_357_8.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos1086, var_357_14, var_357_13)
			end

			if arg_354_1.time_ >= var_357_9 + var_357_12 and arg_354_1.time_ < var_357_9 + var_357_12 + arg_357_0 then
				var_357_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_357_15 = 0
			local var_357_16 = 0.2

			if var_357_15 < arg_354_1.time_ and arg_354_1.time_ <= var_357_15 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_17 = arg_354_1:FormatText(StoryNameCfg[1080].name)

				arg_354_1.leftNameTxt_.text = var_357_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_18 = arg_354_1:GetWordFromCfg(416051084)
				local var_357_19 = arg_354_1:FormatText(var_357_18.content)

				arg_354_1.text_.text = var_357_19

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_20 = 8
				local var_357_21 = utf8.len(var_357_19)
				local var_357_22 = var_357_20 <= 0 and var_357_16 or var_357_16 * (var_357_21 / var_357_20)

				if var_357_22 > 0 and var_357_16 < var_357_22 then
					arg_354_1.talkMaxDuration = var_357_22

					if var_357_22 + var_357_15 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_22 + var_357_15
					end
				end

				arg_354_1.text_.text = var_357_19
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051084", "story_v_out_416051.awb") ~= 0 then
					local var_357_23 = manager.audio:GetVoiceLength("story_v_out_416051", "416051084", "story_v_out_416051.awb") / 1000

					if var_357_23 + var_357_15 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_23 + var_357_15
					end

					if var_357_18.prefab_name ~= "" and arg_354_1.actors_[var_357_18.prefab_name] ~= nil then
						local var_357_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_18.prefab_name].transform, "story_v_out_416051", "416051084", "story_v_out_416051.awb")

						arg_354_1:RecordAudio("416051084", var_357_24)
						arg_354_1:RecordAudio("416051084", var_357_24)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_416051", "416051084", "story_v_out_416051.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_416051", "416051084", "story_v_out_416051.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_25 = math.max(var_357_16, arg_354_1.talkMaxDuration)

			if var_357_15 <= arg_354_1.time_ and arg_354_1.time_ < var_357_15 + var_357_25 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_15) / var_357_25

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_15 + var_357_25 and arg_354_1.time_ < var_357_15 + var_357_25 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/SS1602",
		"TextureConfig/Background/I14f",
		"TextureConfig/Background/ST2101",
		"TextureConfig/Background/ST0106",
		"TextureConfig/Background/I13f"
	},
	voices = {
		"story_v_out_416051.awb"
	}
}
