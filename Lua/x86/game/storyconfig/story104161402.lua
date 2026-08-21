return {
	Play416142001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416142001
		arg_1_1.duration_ = 5.7

		local var_1_0 = {
			zh = 5.6,
			ja = 5.7
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
				arg_1_0:Play416142002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I13i"

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
				local var_4_5 = arg_1_1.bgs_.I13i

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
					if iter_4_0 ~= "I13i" then
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

			local var_4_24 = manager.ui.mainCamera.transform
			local var_4_25 = 1

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_26 = arg_1_1.var_.effect112
				local var_4_27
				local var_4_28 = var_4_24

				if not var_4_26 then
					var_4_26 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_mist_in"), var_4_28)
					var_4_26.name = "112"
					arg_1_1.var_.effect112 = var_4_26
				else
					var_4_26.transform:SetParent(var_4_28)
				end

				var_4_26.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_26.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_4_29 = manager.ui.mainCameraCom_
				local var_4_30 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_4_29.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_4_31 = var_4_26.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_4_32 = 15
				local var_4_33 = 2 * var_4_32 * Mathf.Tan(var_4_29.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_4_29.aspect
				local var_4_34 = 1
				local var_4_35 = 1.7777777777777777

				if var_4_35 < var_4_29.aspect then
					var_4_34 = var_4_33 / (2 * var_4_32 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_4_35)
				end

				for iter_4_2, iter_4_3 in ipairs(var_4_31) do
					local var_4_36 = iter_4_3.transform.localScale

					iter_4_3.transform.localScale = Vector3.New(var_4_36.x / var_4_30 * var_4_34, var_4_36.y / var_4_30, var_4_36.z)
				end
			end

			local var_4_37 = 0
			local var_4_38 = 0.2

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				local var_4_39 = "play"
				local var_4_40 = "music"

				arg_1_1:AudioAction(var_4_39, var_4_40, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_41 = ""
				local var_4_42 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_42 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_42 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_42

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_42
						arg_1_1.bgmTxt2_.text = var_4_42
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

			local var_4_43 = 0.466666666666667
			local var_4_44 = 1

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				local var_4_45 = "play"
				local var_4_46 = "music"

				arg_1_1:AudioAction(var_4_45, var_4_46, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_4_47 = ""
				local var_4_48 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if var_4_48 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_48 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_48

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_48
						arg_1_1.bgmTxt2_.text = var_4_48
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

			local var_4_49 = 2
			local var_4_50 = 0.225

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

				local var_4_52 = arg_1_1:FormatText(StoryNameCfg[327].name)

				arg_1_1.leftNameTxt_.text = var_4_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_1")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_53 = arg_1_1:GetWordFromCfg(416142001)
				local var_4_54 = arg_1_1:FormatText(var_4_53.content)

				arg_1_1.text_.text = var_4_54

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_55 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142001", "story_v_out_416142.awb") ~= 0 then
					local var_4_58 = manager.audio:GetVoiceLength("story_v_out_416142", "416142001", "story_v_out_416142.awb") / 1000

					if var_4_58 + var_4_49 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_58 + var_4_49
					end

					if var_4_53.prefab_name ~= "" and arg_1_1.actors_[var_4_53.prefab_name] ~= nil then
						local var_4_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_53.prefab_name].transform, "story_v_out_416142", "416142001", "story_v_out_416142.awb")

						arg_1_1:RecordAudio("416142001", var_4_59)
						arg_1_1:RecordAudio("416142001", var_4_59)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416142", "416142001", "story_v_out_416142.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416142", "416142001", "story_v_out_416142.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_60 = var_4_49 + 0.3
			local var_4_61 = math.max(var_4_50, arg_1_1.talkMaxDuration)

			if var_4_60 <= arg_1_1.time_ and arg_1_1.time_ < var_4_60 + var_4_61 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_60) / var_4_61

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_60 + var_4_61 and arg_1_1.time_ < var_4_60 + var_4_61 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play416142002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416142002
		arg_9_1.duration_ = 4.5

		local var_9_0 = {
			zh = 2.833,
			ja = 4.5
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play416142003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = manager.ui.mainCamera.transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				local var_12_2 = arg_9_1.var_.effect112

				if var_12_2 then
					Object.Destroy(var_12_2)

					arg_9_1.var_.effect112 = nil
				end
			end

			local var_12_3 = 0
			local var_12_4 = 0.325

			if var_12_3 < arg_9_1.time_ and arg_9_1.time_ <= var_12_3 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_5 = arg_9_1:FormatText(StoryNameCfg[1080].name)

				arg_9_1.leftNameTxt_.text = var_12_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_1")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_6 = arg_9_1:GetWordFromCfg(416142002)
				local var_12_7 = arg_9_1:FormatText(var_12_6.content)

				arg_9_1.text_.text = var_12_7

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_8 = 13
				local var_12_9 = utf8.len(var_12_7)
				local var_12_10 = var_12_8 <= 0 and var_12_4 or var_12_4 * (var_12_9 / var_12_8)

				if var_12_10 > 0 and var_12_4 < var_12_10 then
					arg_9_1.talkMaxDuration = var_12_10

					if var_12_10 + var_12_3 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_10 + var_12_3
					end
				end

				arg_9_1.text_.text = var_12_7
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142002", "story_v_out_416142.awb") ~= 0 then
					local var_12_11 = manager.audio:GetVoiceLength("story_v_out_416142", "416142002", "story_v_out_416142.awb") / 1000

					if var_12_11 + var_12_3 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_11 + var_12_3
					end

					if var_12_6.prefab_name ~= "" and arg_9_1.actors_[var_12_6.prefab_name] ~= nil then
						local var_12_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_6.prefab_name].transform, "story_v_out_416142", "416142002", "story_v_out_416142.awb")

						arg_9_1:RecordAudio("416142002", var_12_12)
						arg_9_1:RecordAudio("416142002", var_12_12)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_416142", "416142002", "story_v_out_416142.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_416142", "416142002", "story_v_out_416142.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_13 = math.max(var_12_4, arg_9_1.talkMaxDuration)

			if var_12_3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_3 + var_12_13 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_3) / var_12_13

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_3 + var_12_13 and arg_9_1.time_ < var_12_3 + var_12_13 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play416142003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416142003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play416142004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.075

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

				local var_16_2 = arg_13_1:GetWordFromCfg(416142003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 43
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
	Play416142004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416142004
		arg_17_1.duration_ = 4.3

		local var_17_0 = {
			zh = 2.766,
			ja = 4.3
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play416142005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.25

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[1080].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_1")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(416142004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 10
				local var_20_6 = utf8.len(var_20_4)
				local var_20_7 = var_20_5 <= 0 and var_20_1 or var_20_1 * (var_20_6 / var_20_5)

				if var_20_7 > 0 and var_20_1 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142004", "story_v_out_416142.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_416142", "416142004", "story_v_out_416142.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_416142", "416142004", "story_v_out_416142.awb")

						arg_17_1:RecordAudio("416142004", var_20_9)
						arg_17_1:RecordAudio("416142004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416142", "416142004", "story_v_out_416142.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416142", "416142004", "story_v_out_416142.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_10 and arg_17_1.time_ < var_20_0 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play416142005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416142005
		arg_21_1.duration_ = 6.17

		local var_21_0 = {
			zh = 5.266,
			ja = 6.166
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play416142006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.425

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[327].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_3")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(416142005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 17
				local var_24_6 = utf8.len(var_24_4)
				local var_24_7 = var_24_5 <= 0 and var_24_1 or var_24_1 * (var_24_6 / var_24_5)

				if var_24_7 > 0 and var_24_1 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142005", "story_v_out_416142.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_416142", "416142005", "story_v_out_416142.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_416142", "416142005", "story_v_out_416142.awb")

						arg_21_1:RecordAudio("416142005", var_24_9)
						arg_21_1:RecordAudio("416142005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_416142", "416142005", "story_v_out_416142.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_416142", "416142005", "story_v_out_416142.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_10 and arg_21_1.time_ < var_24_0 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play416142006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416142006
		arg_25_1.duration_ = 4.23

		local var_25_0 = {
			zh = 3.133,
			ja = 4.233
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play416142007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.3

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[327].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_1")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(416142006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 12
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_1 or var_28_1 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_1 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142006", "story_v_out_416142.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_416142", "416142006", "story_v_out_416142.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_416142", "416142006", "story_v_out_416142.awb")

						arg_25_1:RecordAudio("416142006", var_28_9)
						arg_25_1:RecordAudio("416142006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_416142", "416142006", "story_v_out_416142.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_416142", "416142006", "story_v_out_416142.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_10 and arg_25_1.time_ < var_28_0 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play416142007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 416142007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play416142008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 1.225

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(416142007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 49
				local var_32_5 = utf8.len(var_32_3)
				local var_32_6 = var_32_4 <= 0 and var_32_1 or var_32_1 * (var_32_5 / var_32_4)

				if var_32_6 > 0 and var_32_1 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_7 and arg_29_1.time_ < var_32_0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play416142008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 416142008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play416142009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.975

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(416142008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 39
				local var_36_5 = utf8.len(var_36_3)
				local var_36_6 = var_36_4 <= 0 and var_36_1 or var_36_1 * (var_36_5 / var_36_4)

				if var_36_6 > 0 and var_36_1 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_7 and arg_33_1.time_ < var_36_0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play416142009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 416142009
		arg_37_1.duration_ = 4.6

		local var_37_0 = {
			zh = 4.6,
			ja = 4.5
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
				arg_37_0:Play416142010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = "1028"

			if arg_37_1.actors_[var_40_0] == nil then
				local var_40_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1028")

				if not isNil(var_40_1) then
					local var_40_2 = Object.Instantiate(var_40_1, arg_37_1.canvasGo_.transform)

					var_40_2.transform:SetSiblingIndex(1)

					var_40_2.name = var_40_0
					var_40_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_37_1.actors_[var_40_0] = var_40_2

					local var_40_3 = var_40_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_37_1.isInRecall_ then
						for iter_40_0, iter_40_1 in ipairs(var_40_3) do
							iter_40_1.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_40_4 = arg_37_1.actors_["1028"]
			local var_40_5 = 0

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.actorSpriteComps1028 == nil then
				arg_37_1.var_.actorSpriteComps1028 = var_40_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_6 = 0.2

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_6 and not isNil(var_40_4) then
				local var_40_7 = (arg_37_1.time_ - var_40_5) / var_40_6

				if arg_37_1.var_.actorSpriteComps1028 then
					for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_40_3 then
							if arg_37_1.isInRecall_ then
								local var_40_8 = Mathf.Lerp(iter_40_3.color.r, arg_37_1.hightColor1.r, var_40_7)
								local var_40_9 = Mathf.Lerp(iter_40_3.color.g, arg_37_1.hightColor1.g, var_40_7)
								local var_40_10 = Mathf.Lerp(iter_40_3.color.b, arg_37_1.hightColor1.b, var_40_7)

								iter_40_3.color = Color.New(var_40_8, var_40_9, var_40_10)
							else
								local var_40_11 = Mathf.Lerp(iter_40_3.color.r, 1, var_40_7)

								iter_40_3.color = Color.New(var_40_11, var_40_11, var_40_11)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_5 + var_40_6 and arg_37_1.time_ < var_40_5 + var_40_6 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.actorSpriteComps1028 then
				for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_40_5 then
						if arg_37_1.isInRecall_ then
							iter_40_5.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps1028 = nil
			end

			local var_40_12 = arg_37_1.actors_["1028"].transform
			local var_40_13 = 0

			if var_40_13 < arg_37_1.time_ and arg_37_1.time_ <= var_40_13 + arg_40_0 then
				arg_37_1.var_.moveOldPos1028 = var_40_12.localPosition
				var_40_12.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1028", 3)

				local var_40_14 = var_40_12.childCount

				for iter_40_6 = 0, var_40_14 - 1 do
					local var_40_15 = var_40_12:GetChild(iter_40_6)

					if var_40_15.name == "split_2" or not string.find(var_40_15.name, "split") then
						var_40_15.gameObject:SetActive(true)
					else
						var_40_15.gameObject:SetActive(false)
					end
				end
			end

			local var_40_16 = 0.001

			if var_40_13 <= arg_37_1.time_ and arg_37_1.time_ < var_40_13 + var_40_16 then
				local var_40_17 = (arg_37_1.time_ - var_40_13) / var_40_16
				local var_40_18 = Vector3.New(0, -402.7, -156.1)

				var_40_12.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1028, var_40_18, var_40_17)
			end

			if arg_37_1.time_ >= var_40_13 + var_40_16 and arg_37_1.time_ < var_40_13 + var_40_16 + arg_40_0 then
				var_40_12.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_40_19 = 0
			local var_40_20 = 0.425

			if var_40_19 < arg_37_1.time_ and arg_37_1.time_ <= var_40_19 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_21 = arg_37_1:FormatText(StoryNameCfg[327].name)

				arg_37_1.leftNameTxt_.text = var_40_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_22 = arg_37_1:GetWordFromCfg(416142009)
				local var_40_23 = arg_37_1:FormatText(var_40_22.content)

				arg_37_1.text_.text = var_40_23

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_24 = 17
				local var_40_25 = utf8.len(var_40_23)
				local var_40_26 = var_40_24 <= 0 and var_40_20 or var_40_20 * (var_40_25 / var_40_24)

				if var_40_26 > 0 and var_40_20 < var_40_26 then
					arg_37_1.talkMaxDuration = var_40_26

					if var_40_26 + var_40_19 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_26 + var_40_19
					end
				end

				arg_37_1.text_.text = var_40_23
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142009", "story_v_out_416142.awb") ~= 0 then
					local var_40_27 = manager.audio:GetVoiceLength("story_v_out_416142", "416142009", "story_v_out_416142.awb") / 1000

					if var_40_27 + var_40_19 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_27 + var_40_19
					end

					if var_40_22.prefab_name ~= "" and arg_37_1.actors_[var_40_22.prefab_name] ~= nil then
						local var_40_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_22.prefab_name].transform, "story_v_out_416142", "416142009", "story_v_out_416142.awb")

						arg_37_1:RecordAudio("416142009", var_40_28)
						arg_37_1:RecordAudio("416142009", var_40_28)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_416142", "416142009", "story_v_out_416142.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_416142", "416142009", "story_v_out_416142.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_29 = math.max(var_40_20, arg_37_1.talkMaxDuration)

			if var_40_19 <= arg_37_1.time_ and arg_37_1.time_ < var_40_19 + var_40_29 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_19) / var_40_29

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_19 + var_40_29 and arg_37_1.time_ < var_40_19 + var_40_29 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play416142010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416142010
		arg_41_1.duration_ = 5.9

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play416142011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1028"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps1028 == nil then
				arg_41_1.var_.actorSpriteComps1028 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps1028 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								local var_44_4 = Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor2.r, var_44_3)
								local var_44_5 = Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor2.g, var_44_3)
								local var_44_6 = Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor2.b, var_44_3)

								iter_44_1.color = Color.New(var_44_4, var_44_5, var_44_6)
							else
								local var_44_7 = Mathf.Lerp(iter_44_1.color.r, 0.5, var_44_3)

								iter_44_1.color = Color.New(var_44_7, var_44_7, var_44_7)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps1028 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1028 = nil
			end

			local var_44_8 = arg_41_1.actors_["1028"].transform
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 then
				arg_41_1.var_.moveOldPos1028 = var_44_8.localPosition
				var_44_8.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1028", 7)

				local var_44_10 = var_44_8.childCount

				for iter_44_4 = 0, var_44_10 - 1 do
					local var_44_11 = var_44_8:GetChild(iter_44_4)

					if var_44_11.name == "" or not string.find(var_44_11.name, "split") then
						var_44_11.gameObject:SetActive(true)
					else
						var_44_11.gameObject:SetActive(false)
					end
				end
			end

			local var_44_12 = 0.001

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_12 then
				local var_44_13 = (arg_41_1.time_ - var_44_9) / var_44_12
				local var_44_14 = Vector3.New(0, -2000, 0)

				var_44_8.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1028, var_44_14, var_44_13)
			end

			if arg_41_1.time_ >= var_44_9 + var_44_12 and arg_41_1.time_ < var_44_9 + var_44_12 + arg_44_0 then
				var_44_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_44_15 = 0.2

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_16 = 0.333333333333333

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_16 then
				local var_44_17 = (arg_41_1.time_ - var_44_15) / var_44_16
				local var_44_18 = Color.New(1, 1, 1)

				var_44_18.a = Mathf.Lerp(1, 0, var_44_17)
				arg_41_1.mask_.color = var_44_18
			end

			if arg_41_1.time_ >= var_44_15 + var_44_16 and arg_41_1.time_ < var_44_15 + var_44_16 + arg_44_0 then
				local var_44_19 = Color.New(1, 1, 1)
				local var_44_20 = 0

				arg_41_1.mask_.enabled = false
				var_44_19.a = var_44_20
				arg_41_1.mask_.color = var_44_19
			end

			local var_44_21 = 0.533333333333333

			if var_44_21 < arg_41_1.time_ and arg_41_1.time_ <= var_44_21 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_22 = 0.233333333333333

			if var_44_21 <= arg_41_1.time_ and arg_41_1.time_ < var_44_21 + var_44_22 then
				local var_44_23 = (arg_41_1.time_ - var_44_21) / var_44_22
				local var_44_24 = Color.New(1, 1, 1)

				var_44_24.a = Mathf.Lerp(1, 0, var_44_23)
				arg_41_1.mask_.color = var_44_24
			end

			if arg_41_1.time_ >= var_44_21 + var_44_22 and arg_41_1.time_ < var_44_21 + var_44_22 + arg_44_0 then
				local var_44_25 = Color.New(1, 1, 1)
				local var_44_26 = 0

				arg_41_1.mask_.enabled = false
				var_44_25.a = var_44_26
				arg_41_1.mask_.color = var_44_25
			end

			local var_44_27 = manager.ui.mainCamera.transform
			local var_44_28 = 0.333333333333333

			if var_44_28 < arg_41_1.time_ and arg_41_1.time_ <= var_44_28 + arg_44_0 then
				arg_41_1.var_.shakeOldPos = var_44_27.localPosition
			end

			local var_44_29 = 0.566666666666667

			if var_44_28 <= arg_41_1.time_ and arg_41_1.time_ < var_44_28 + var_44_29 then
				local var_44_30 = (arg_41_1.time_ - var_44_28) / 0.066
				local var_44_31, var_44_32 = math.modf(var_44_30)

				var_44_27.localPosition = Vector3.New(var_44_32 * 0.13, var_44_32 * 0.13, var_44_32 * 0.13) + arg_41_1.var_.shakeOldPos
			end

			if arg_41_1.time_ >= var_44_28 + var_44_29 and arg_41_1.time_ < var_44_28 + var_44_29 + arg_44_0 then
				var_44_27.localPosition = arg_41_1.var_.shakeOldPos
			end

			local var_44_33 = 0

			if var_44_33 < arg_41_1.time_ and arg_41_1.time_ <= var_44_33 + arg_44_0 then
				arg_41_1.allBtn_.enabled = false
			end

			local var_44_34 = 1.16666666666667

			if arg_41_1.time_ >= var_44_33 + var_44_34 and arg_41_1.time_ < var_44_33 + var_44_34 + arg_44_0 then
				arg_41_1.allBtn_.enabled = true
			end

			local var_44_35 = manager.ui.mainCamera.transform
			local var_44_36 = 0

			if var_44_36 < arg_41_1.time_ and arg_41_1.time_ <= var_44_36 + arg_44_0 then
				local var_44_37 = arg_41_1.var_.effect112

				if var_44_37 then
					Object.Destroy(var_44_37)

					arg_41_1.var_.effect112 = nil
				end
			end

			local var_44_38 = manager.ui.mainCamera.transform
			local var_44_39 = 0

			if var_44_39 < arg_41_1.time_ and arg_41_1.time_ <= var_44_39 + arg_44_0 then
				local var_44_40 = arg_41_1.var_.effect116
				local var_44_41
				local var_44_42 = var_44_38

				if not var_44_40 then
					var_44_40 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), var_44_42)
					var_44_40.name = "116"
					arg_41_1.var_.effect116 = var_44_40
				else
					var_44_40.transform:SetParent(var_44_42)
				end

				var_44_40.transform.localPosition = Vector3.New(0, 0, 0)
				var_44_40.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_44_43 = manager.ui.mainCameraCom_
				local var_44_44 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_44_43.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_44_45 = var_44_40.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_44_46 = 15
				local var_44_47 = 2 * var_44_46 * Mathf.Tan(var_44_43.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_44_43.aspect
				local var_44_48 = 1
				local var_44_49 = 1.7777777777777777

				if var_44_49 < var_44_43.aspect then
					var_44_48 = var_44_47 / (2 * var_44_46 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_44_49)
				end

				for iter_44_5, iter_44_6 in ipairs(var_44_45) do
					local var_44_50 = iter_44_6.transform.localScale

					iter_44_6.transform.localScale = Vector3.New(var_44_50.x / var_44_44 * var_44_48, var_44_50.y / var_44_44, var_44_50.z)
				end
			end

			local var_44_51 = 0
			local var_44_52 = 1

			if var_44_51 < arg_41_1.time_ and arg_41_1.time_ <= var_44_51 + arg_44_0 then
				local var_44_53 = "play"
				local var_44_54 = "effect"

				arg_41_1:AudioAction(var_44_53, var_44_54, "se_story_16", "se_story_16_thunder", "")
			end

			if arg_41_1.frameCnt_ <= 1 then
				arg_41_1.dialog_:SetActive(false)
			end

			local var_44_55 = 0.9
			local var_44_56 = 1.65

			if var_44_55 < arg_41_1.time_ and arg_41_1.time_ <= var_44_55 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_57 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_57:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_58 = arg_41_1:GetWordFromCfg(416142010)
				local var_44_59 = arg_41_1:FormatText(var_44_58.content)

				arg_41_1.text_.text = var_44_59

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_60 = 66
				local var_44_61 = utf8.len(var_44_59)
				local var_44_62 = var_44_60 <= 0 and var_44_56 or var_44_56 * (var_44_61 / var_44_60)

				if var_44_62 > 0 and var_44_56 < var_44_62 then
					arg_41_1.talkMaxDuration = var_44_62
					var_44_55 = var_44_55 + 0.3

					if var_44_62 + var_44_55 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_62 + var_44_55
					end
				end

				arg_41_1.text_.text = var_44_59
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_63 = var_44_55 + 0.3
			local var_44_64 = math.max(var_44_56, arg_41_1.talkMaxDuration)

			if var_44_63 <= arg_41_1.time_ and arg_41_1.time_ < var_44_63 + var_44_64 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_63) / var_44_64

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_63 + var_44_64 and arg_41_1.time_ < var_44_63 + var_44_64 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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

		arg_41_1:InitPlayNodeList()
	end,
	Play416142011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 416142011
		arg_47_1.duration_ = 3.63

		local var_47_0 = {
			zh = 2.066,
			ja = 3.633
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
				arg_47_0:Play416142012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["1028"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.actorSpriteComps1028 == nil then
				arg_47_1.var_.actorSpriteComps1028 = var_50_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_2 = 0.2

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.actorSpriteComps1028 then
					for iter_50_0, iter_50_1 in pairs(arg_47_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_50_1 then
							if arg_47_1.isInRecall_ then
								local var_50_4 = Mathf.Lerp(iter_50_1.color.r, arg_47_1.hightColor1.r, var_50_3)
								local var_50_5 = Mathf.Lerp(iter_50_1.color.g, arg_47_1.hightColor1.g, var_50_3)
								local var_50_6 = Mathf.Lerp(iter_50_1.color.b, arg_47_1.hightColor1.b, var_50_3)

								iter_50_1.color = Color.New(var_50_4, var_50_5, var_50_6)
							else
								local var_50_7 = Mathf.Lerp(iter_50_1.color.r, 1, var_50_3)

								iter_50_1.color = Color.New(var_50_7, var_50_7, var_50_7)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.actorSpriteComps1028 then
				for iter_50_2, iter_50_3 in pairs(arg_47_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_50_3 then
						if arg_47_1.isInRecall_ then
							iter_50_3.color = arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_50_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_47_1.var_.actorSpriteComps1028 = nil
			end

			local var_50_8 = 0
			local var_50_9 = 0.175

			if var_50_8 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_10 = arg_47_1:FormatText(StoryNameCfg[327].name)

				arg_47_1.leftNameTxt_.text = var_50_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_1")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_11 = arg_47_1:GetWordFromCfg(416142011)
				local var_50_12 = arg_47_1:FormatText(var_50_11.content)

				arg_47_1.text_.text = var_50_12

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_13 = 7
				local var_50_14 = utf8.len(var_50_12)
				local var_50_15 = var_50_13 <= 0 and var_50_9 or var_50_9 * (var_50_14 / var_50_13)

				if var_50_15 > 0 and var_50_9 < var_50_15 then
					arg_47_1.talkMaxDuration = var_50_15

					if var_50_15 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_15 + var_50_8
					end
				end

				arg_47_1.text_.text = var_50_12
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142011", "story_v_out_416142.awb") ~= 0 then
					local var_50_16 = manager.audio:GetVoiceLength("story_v_out_416142", "416142011", "story_v_out_416142.awb") / 1000

					if var_50_16 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_16 + var_50_8
					end

					if var_50_11.prefab_name ~= "" and arg_47_1.actors_[var_50_11.prefab_name] ~= nil then
						local var_50_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_11.prefab_name].transform, "story_v_out_416142", "416142011", "story_v_out_416142.awb")

						arg_47_1:RecordAudio("416142011", var_50_17)
						arg_47_1:RecordAudio("416142011", var_50_17)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_416142", "416142011", "story_v_out_416142.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_416142", "416142011", "story_v_out_416142.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_18 = math.max(var_50_9, arg_47_1.talkMaxDuration)

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_18 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_8) / var_50_18

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_8 + var_50_18 and arg_47_1.time_ < var_50_8 + var_50_18 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play416142012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 416142012
		arg_51_1.duration_ = 4.83

		local var_51_0 = {
			zh = 4.4,
			ja = 4.833
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
				arg_51_0:Play416142013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.275

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_2 = arg_51_1:FormatText(StoryNameCfg[1080].name)

				arg_51_1.leftNameTxt_.text = var_54_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_6")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:GetWordFromCfg(416142012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142012", "story_v_out_416142.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_out_416142", "416142012", "story_v_out_416142.awb") / 1000

					if var_54_8 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_0
					end

					if var_54_3.prefab_name ~= "" and arg_51_1.actors_[var_54_3.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_3.prefab_name].transform, "story_v_out_416142", "416142012", "story_v_out_416142.awb")

						arg_51_1:RecordAudio("416142012", var_54_9)
						arg_51_1:RecordAudio("416142012", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_416142", "416142012", "story_v_out_416142.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_416142", "416142012", "story_v_out_416142.awb")
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
	Play416142013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 416142013
		arg_55_1.duration_ = 7.17

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play416142014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = "STwhite"

			if arg_55_1.bgs_[var_58_0] == nil then
				local var_58_1 = Object.Instantiate(arg_55_1.paintGo_)

				var_58_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_58_0)
				var_58_1.name = var_58_0
				var_58_1.transform.parent = arg_55_1.stage_.transform
				var_58_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.bgs_[var_58_0] = var_58_1
			end

			local var_58_2 = 1

			if var_58_2 < arg_55_1.time_ and arg_55_1.time_ <= var_58_2 + arg_58_0 then
				local var_58_3 = manager.ui.mainCamera.transform.localPosition
				local var_58_4 = Vector3.New(0, 0, 10) + Vector3.New(var_58_3.x, var_58_3.y, 0)
				local var_58_5 = arg_55_1.bgs_.STwhite

				var_58_5.transform.localPosition = var_58_4
				var_58_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_58_6 = var_58_5:GetComponent("SpriteRenderer")

				if var_58_6 and var_58_6.sprite then
					local var_58_7 = (var_58_5.transform.localPosition - var_58_3).z
					local var_58_8 = manager.ui.mainCameraCom_
					local var_58_9 = 2 * var_58_7 * Mathf.Tan(var_58_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_58_10 = var_58_9 * var_58_8.aspect
					local var_58_11 = var_58_6.sprite.bounds.size.x
					local var_58_12 = var_58_6.sprite.bounds.size.y
					local var_58_13 = var_58_10 / var_58_11
					local var_58_14 = var_58_9 / var_58_12
					local var_58_15 = var_58_14 < var_58_13 and var_58_13 or var_58_14

					var_58_5.transform.localScale = Vector3.New(var_58_15, var_58_15, 0)
				end

				for iter_58_0, iter_58_1 in pairs(arg_55_1.bgs_) do
					if iter_58_0 ~= "STwhite" then
						iter_58_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_58_16 = 0

			if var_58_16 < arg_55_1.time_ and arg_55_1.time_ <= var_58_16 + arg_58_0 then
				arg_55_1.allBtn_.enabled = false
			end

			local var_58_17 = 0.3

			if arg_55_1.time_ >= var_58_16 + var_58_17 and arg_55_1.time_ < var_58_16 + var_58_17 + arg_58_0 then
				arg_55_1.allBtn_.enabled = true
			end

			local var_58_18 = 0

			if var_58_18 < arg_55_1.time_ and arg_55_1.time_ <= var_58_18 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_19 = 1

			if var_58_18 <= arg_55_1.time_ and arg_55_1.time_ < var_58_18 + var_58_19 then
				local var_58_20 = (arg_55_1.time_ - var_58_18) / var_58_19
				local var_58_21 = Color.New(1, 1, 1)

				var_58_21.a = Mathf.Lerp(0, 1, var_58_20)
				arg_55_1.mask_.color = var_58_21
			end

			if arg_55_1.time_ >= var_58_18 + var_58_19 and arg_55_1.time_ < var_58_18 + var_58_19 + arg_58_0 then
				local var_58_22 = Color.New(1, 1, 1)

				var_58_22.a = 1
				arg_55_1.mask_.color = var_58_22
			end

			local var_58_23 = 1

			if var_58_23 < arg_55_1.time_ and arg_55_1.time_ <= var_58_23 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_24 = 0.866666666666667

			if var_58_23 <= arg_55_1.time_ and arg_55_1.time_ < var_58_23 + var_58_24 then
				local var_58_25 = (arg_55_1.time_ - var_58_23) / var_58_24
				local var_58_26 = Color.New(1, 1, 1)

				var_58_26.a = Mathf.Lerp(1, 0, var_58_25)
				arg_55_1.mask_.color = var_58_26
			end

			if arg_55_1.time_ >= var_58_23 + var_58_24 and arg_55_1.time_ < var_58_23 + var_58_24 + arg_58_0 then
				local var_58_27 = Color.New(1, 1, 1)
				local var_58_28 = 0

				arg_55_1.mask_.enabled = false
				var_58_27.a = var_58_28
				arg_55_1.mask_.color = var_58_27
			end

			local var_58_29 = manager.ui.mainCamera.transform
			local var_58_30 = 1

			if var_58_30 < arg_55_1.time_ and arg_55_1.time_ <= var_58_30 + arg_58_0 then
				local var_58_31 = arg_55_1.var_.effect116

				if var_58_31 then
					Object.Destroy(var_58_31)

					arg_55_1.var_.effect116 = nil
				end
			end

			local var_58_32 = 1.66666666666667
			local var_58_33 = 1

			if var_58_32 < arg_55_1.time_ and arg_55_1.time_ <= var_58_32 + arg_58_0 then
				local var_58_34 = "play"
				local var_58_35 = "effect"

				arg_55_1:AudioAction(var_58_34, var_58_35, "se_story_138", "se_story_138_elecskill01", "")
			end

			if arg_55_1.frameCnt_ <= 1 then
				arg_55_1.dialog_:SetActive(false)
			end

			local var_58_36 = 2.16666666666667
			local var_58_37 = 1.575

			if var_58_36 < arg_55_1.time_ and arg_55_1.time_ <= var_58_36 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0

				arg_55_1.dialog_:SetActive(true)

				arg_55_1.dialogCg_.alpha = 0

				local var_58_38 = LeanTween.value(arg_55_1.dialog_, 0, 1, 0.3)

				var_58_38:setOnUpdate(LuaHelper.FloatAction(function(arg_59_0)
					arg_55_1.dialogCg_.alpha = arg_59_0
				end))
				var_58_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_55_1.dialog_)
					var_58_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_55_1.duration_ = arg_55_1.duration_ + 0.3

				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_39 = arg_55_1:GetWordFromCfg(416142013)
				local var_58_40 = arg_55_1:FormatText(var_58_39.content)

				arg_55_1.text_.text = var_58_40

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_41 = 63
				local var_58_42 = utf8.len(var_58_40)
				local var_58_43 = var_58_41 <= 0 and var_58_37 or var_58_37 * (var_58_42 / var_58_41)

				if var_58_43 > 0 and var_58_37 < var_58_43 then
					arg_55_1.talkMaxDuration = var_58_43
					var_58_36 = var_58_36 + 0.3

					if var_58_43 + var_58_36 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_43 + var_58_36
					end
				end

				arg_55_1.text_.text = var_58_40
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_44 = var_58_36 + 0.3
			local var_58_45 = math.max(var_58_37, arg_55_1.talkMaxDuration)

			if var_58_44 <= arg_55_1.time_ and arg_55_1.time_ < var_58_44 + var_58_45 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_44) / var_58_45

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_44 + var_58_45 and arg_55_1.time_ < var_58_44 + var_58_45 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play416142014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 416142014
		arg_61_1.duration_ = 9.23

		local var_61_0 = {
			zh = 7.633,
			ja = 9.233
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
				arg_61_0:Play416142015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				local var_64_1 = manager.ui.mainCamera.transform.localPosition
				local var_64_2 = Vector3.New(0, 0, 10) + Vector3.New(var_64_1.x, var_64_1.y, 0)
				local var_64_3 = arg_61_1.bgs_.I13i

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
					if iter_64_0 ~= "I13i" then
						iter_64_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_64_14 = 1

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

			local var_64_17 = 1

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

			local var_64_21 = 1

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

			local var_64_27 = arg_61_1.actors_["1028"]
			local var_64_28 = 2.6

			if var_64_28 < arg_61_1.time_ and arg_61_1.time_ <= var_64_28 + arg_64_0 and not isNil(var_64_27) and arg_61_1.var_.actorSpriteComps1028 == nil then
				arg_61_1.var_.actorSpriteComps1028 = var_64_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_29 = 0.2

			if var_64_28 <= arg_61_1.time_ and arg_61_1.time_ < var_64_28 + var_64_29 and not isNil(var_64_27) then
				local var_64_30 = (arg_61_1.time_ - var_64_28) / var_64_29

				if arg_61_1.var_.actorSpriteComps1028 then
					for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_64_3 then
							if arg_61_1.isInRecall_ then
								local var_64_31 = Mathf.Lerp(iter_64_3.color.r, arg_61_1.hightColor1.r, var_64_30)
								local var_64_32 = Mathf.Lerp(iter_64_3.color.g, arg_61_1.hightColor1.g, var_64_30)
								local var_64_33 = Mathf.Lerp(iter_64_3.color.b, arg_61_1.hightColor1.b, var_64_30)

								iter_64_3.color = Color.New(var_64_31, var_64_32, var_64_33)
							else
								local var_64_34 = Mathf.Lerp(iter_64_3.color.r, 1, var_64_30)

								iter_64_3.color = Color.New(var_64_34, var_64_34, var_64_34)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_28 + var_64_29 and arg_61_1.time_ < var_64_28 + var_64_29 + arg_64_0 and not isNil(var_64_27) and arg_61_1.var_.actorSpriteComps1028 then
				for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_64_5 then
						if arg_61_1.isInRecall_ then
							iter_64_5.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1028 = nil
			end

			local var_64_35 = arg_61_1.actors_["1028"].transform
			local var_64_36 = 2.6

			if var_64_36 < arg_61_1.time_ and arg_61_1.time_ <= var_64_36 + arg_64_0 then
				arg_61_1.var_.moveOldPos1028 = var_64_35.localPosition
				var_64_35.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1028", 3)

				local var_64_37 = var_64_35.childCount

				for iter_64_6 = 0, var_64_37 - 1 do
					local var_64_38 = var_64_35:GetChild(iter_64_6)

					if var_64_38.name == "" or not string.find(var_64_38.name, "split") then
						var_64_38.gameObject:SetActive(true)
					else
						var_64_38.gameObject:SetActive(false)
					end
				end
			end

			local var_64_39 = 0.001

			if var_64_36 <= arg_61_1.time_ and arg_61_1.time_ < var_64_36 + var_64_39 then
				local var_64_40 = (arg_61_1.time_ - var_64_36) / var_64_39
				local var_64_41 = Vector3.New(0, -402.7, -156.1)

				var_64_35.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1028, var_64_41, var_64_40)
			end

			if arg_61_1.time_ >= var_64_36 + var_64_39 and arg_61_1.time_ < var_64_36 + var_64_39 + arg_64_0 then
				var_64_35.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_64_42 = arg_61_1.actors_["1028"]
			local var_64_43 = 2.56666666666667

			if var_64_43 < arg_61_1.time_ and arg_61_1.time_ <= var_64_43 + arg_64_0 then
				local var_64_44 = var_64_42:GetComponentInChildren(typeof(CanvasGroup))

				if var_64_44 then
					arg_61_1.var_.alphaOldValue1028 = var_64_44.alpha
					arg_61_1.var_.characterEffect1028 = var_64_44
				end

				arg_61_1.var_.alphaOldValue1028 = 0
			end

			local var_64_45 = 0.233333333333333

			if var_64_43 <= arg_61_1.time_ and arg_61_1.time_ < var_64_43 + var_64_45 then
				local var_64_46 = (arg_61_1.time_ - var_64_43) / var_64_45
				local var_64_47 = Mathf.Lerp(arg_61_1.var_.alphaOldValue1028, 1, var_64_46)

				if arg_61_1.var_.characterEffect1028 then
					arg_61_1.var_.characterEffect1028.alpha = var_64_47
				end
			end

			if arg_61_1.time_ >= var_64_43 + var_64_45 and arg_61_1.time_ < var_64_43 + var_64_45 + arg_64_0 and arg_61_1.var_.characterEffect1028 then
				arg_61_1.var_.characterEffect1028.alpha = 1
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_48 = 3
			local var_64_49 = 0.4

			if var_64_48 < arg_61_1.time_ and arg_61_1.time_ <= var_64_48 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_50 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_50:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_51 = arg_61_1:FormatText(StoryNameCfg[327].name)

				arg_61_1.leftNameTxt_.text = var_64_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_52 = arg_61_1:GetWordFromCfg(416142014)
				local var_64_53 = arg_61_1:FormatText(var_64_52.content)

				arg_61_1.text_.text = var_64_53

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_54 = 16
				local var_64_55 = utf8.len(var_64_53)
				local var_64_56 = var_64_54 <= 0 and var_64_49 or var_64_49 * (var_64_55 / var_64_54)

				if var_64_56 > 0 and var_64_49 < var_64_56 then
					arg_61_1.talkMaxDuration = var_64_56
					var_64_48 = var_64_48 + 0.3

					if var_64_56 + var_64_48 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_56 + var_64_48
					end
				end

				arg_61_1.text_.text = var_64_53
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142014", "story_v_out_416142.awb") ~= 0 then
					local var_64_57 = manager.audio:GetVoiceLength("story_v_out_416142", "416142014", "story_v_out_416142.awb") / 1000

					if var_64_57 + var_64_48 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_57 + var_64_48
					end

					if var_64_52.prefab_name ~= "" and arg_61_1.actors_[var_64_52.prefab_name] ~= nil then
						local var_64_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_52.prefab_name].transform, "story_v_out_416142", "416142014", "story_v_out_416142.awb")

						arg_61_1:RecordAudio("416142014", var_64_58)
						arg_61_1:RecordAudio("416142014", var_64_58)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_416142", "416142014", "story_v_out_416142.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_416142", "416142014", "story_v_out_416142.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_59 = var_64_48 + 0.3
			local var_64_60 = math.max(var_64_49, arg_61_1.talkMaxDuration)

			if var_64_59 <= arg_61_1.time_ and arg_61_1.time_ < var_64_59 + var_64_60 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_59) / var_64_60

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_59 + var_64_60 and arg_61_1.time_ < var_64_59 + var_64_60 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.6,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play416142015 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 416142015
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play416142016(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1028"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.actorSpriteComps1028 == nil then
				arg_67_1.var_.actorSpriteComps1028 = var_70_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_2 = 0.2

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.actorSpriteComps1028 then
					for iter_70_0, iter_70_1 in pairs(arg_67_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_70_1 then
							if arg_67_1.isInRecall_ then
								local var_70_4 = Mathf.Lerp(iter_70_1.color.r, arg_67_1.hightColor2.r, var_70_3)
								local var_70_5 = Mathf.Lerp(iter_70_1.color.g, arg_67_1.hightColor2.g, var_70_3)
								local var_70_6 = Mathf.Lerp(iter_70_1.color.b, arg_67_1.hightColor2.b, var_70_3)

								iter_70_1.color = Color.New(var_70_4, var_70_5, var_70_6)
							else
								local var_70_7 = Mathf.Lerp(iter_70_1.color.r, 0.5, var_70_3)

								iter_70_1.color = Color.New(var_70_7, var_70_7, var_70_7)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.actorSpriteComps1028 then
				for iter_70_2, iter_70_3 in pairs(arg_67_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_70_3 then
						if arg_67_1.isInRecall_ then
							iter_70_3.color = arg_67_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_70_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_67_1.var_.actorSpriteComps1028 = nil
			end

			local var_70_8 = 0
			local var_70_9 = 1.375

			if var_70_8 < arg_67_1.time_ and arg_67_1.time_ <= var_70_8 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_10 = arg_67_1:GetWordFromCfg(416142015)
				local var_70_11 = arg_67_1:FormatText(var_70_10.content)

				arg_67_1.text_.text = var_70_11

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_12 = 55
				local var_70_13 = utf8.len(var_70_11)
				local var_70_14 = var_70_12 <= 0 and var_70_9 or var_70_9 * (var_70_13 / var_70_12)

				if var_70_14 > 0 and var_70_9 < var_70_14 then
					arg_67_1.talkMaxDuration = var_70_14

					if var_70_14 + var_70_8 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_14 + var_70_8
					end
				end

				arg_67_1.text_.text = var_70_11
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_15 = math.max(var_70_9, arg_67_1.talkMaxDuration)

			if var_70_8 <= arg_67_1.time_ and arg_67_1.time_ < var_70_8 + var_70_15 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_8) / var_70_15

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_8 + var_70_15 and arg_67_1.time_ < var_70_8 + var_70_15 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play416142016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 416142016
		arg_71_1.duration_ = 4.4

		local var_71_0 = {
			zh = 4.233,
			ja = 4.4
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
				arg_71_0:Play416142017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = "1086"

			if arg_71_1.actors_[var_74_0] == nil then
				local var_74_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

				if not isNil(var_74_1) then
					local var_74_2 = Object.Instantiate(var_74_1, arg_71_1.canvasGo_.transform)

					var_74_2.transform:SetSiblingIndex(1)

					var_74_2.name = var_74_0
					var_74_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_71_1.actors_[var_74_0] = var_74_2

					local var_74_3 = var_74_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_71_1.isInRecall_ then
						for iter_74_0, iter_74_1 in ipairs(var_74_3) do
							iter_74_1.color = arg_71_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_74_4 = arg_71_1.actors_["1086"]
			local var_74_5 = 0

			if var_74_5 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.actorSpriteComps1086 == nil then
				arg_71_1.var_.actorSpriteComps1086 = var_74_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_6 = 0.2

			if var_74_5 <= arg_71_1.time_ and arg_71_1.time_ < var_74_5 + var_74_6 and not isNil(var_74_4) then
				local var_74_7 = (arg_71_1.time_ - var_74_5) / var_74_6

				if arg_71_1.var_.actorSpriteComps1086 then
					for iter_74_2, iter_74_3 in pairs(arg_71_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_74_3 then
							if arg_71_1.isInRecall_ then
								local var_74_8 = Mathf.Lerp(iter_74_3.color.r, arg_71_1.hightColor1.r, var_74_7)
								local var_74_9 = Mathf.Lerp(iter_74_3.color.g, arg_71_1.hightColor1.g, var_74_7)
								local var_74_10 = Mathf.Lerp(iter_74_3.color.b, arg_71_1.hightColor1.b, var_74_7)

								iter_74_3.color = Color.New(var_74_8, var_74_9, var_74_10)
							else
								local var_74_11 = Mathf.Lerp(iter_74_3.color.r, 1, var_74_7)

								iter_74_3.color = Color.New(var_74_11, var_74_11, var_74_11)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= var_74_5 + var_74_6 and arg_71_1.time_ < var_74_5 + var_74_6 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.actorSpriteComps1086 then
				for iter_74_4, iter_74_5 in pairs(arg_71_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_74_5 then
						if arg_71_1.isInRecall_ then
							iter_74_5.color = arg_71_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_74_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_71_1.var_.actorSpriteComps1086 = nil
			end

			local var_74_12 = arg_71_1.actors_["1028"].transform
			local var_74_13 = 0

			if var_74_13 < arg_71_1.time_ and arg_71_1.time_ <= var_74_13 + arg_74_0 then
				arg_71_1.var_.moveOldPos1028 = var_74_12.localPosition
				var_74_12.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("1028", 7)

				local var_74_14 = var_74_12.childCount

				for iter_74_6 = 0, var_74_14 - 1 do
					local var_74_15 = var_74_12:GetChild(iter_74_6)

					if var_74_15.name == "" or not string.find(var_74_15.name, "split") then
						var_74_15.gameObject:SetActive(true)
					else
						var_74_15.gameObject:SetActive(false)
					end
				end
			end

			local var_74_16 = 0.001

			if var_74_13 <= arg_71_1.time_ and arg_71_1.time_ < var_74_13 + var_74_16 then
				local var_74_17 = (arg_71_1.time_ - var_74_13) / var_74_16
				local var_74_18 = Vector3.New(0, -2000, 0)

				var_74_12.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1028, var_74_18, var_74_17)
			end

			if arg_71_1.time_ >= var_74_13 + var_74_16 and arg_71_1.time_ < var_74_13 + var_74_16 + arg_74_0 then
				var_74_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_74_19 = arg_71_1.actors_["1086"].transform
			local var_74_20 = 0

			if var_74_20 < arg_71_1.time_ and arg_71_1.time_ <= var_74_20 + arg_74_0 then
				arg_71_1.var_.moveOldPos1086 = var_74_19.localPosition
				var_74_19.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("1086", 3)

				local var_74_21 = var_74_19.childCount

				for iter_74_7 = 0, var_74_21 - 1 do
					local var_74_22 = var_74_19:GetChild(iter_74_7)

					if var_74_22.name == "" or not string.find(var_74_22.name, "split") then
						var_74_22.gameObject:SetActive(true)
					else
						var_74_22.gameObject:SetActive(false)
					end
				end
			end

			local var_74_23 = 0.001

			if var_74_20 <= arg_71_1.time_ and arg_71_1.time_ < var_74_20 + var_74_23 then
				local var_74_24 = (arg_71_1.time_ - var_74_20) / var_74_23
				local var_74_25 = Vector3.New(0, -404.2, -237.9)

				var_74_19.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1086, var_74_25, var_74_24)
			end

			if arg_71_1.time_ >= var_74_20 + var_74_23 and arg_71_1.time_ < var_74_20 + var_74_23 + arg_74_0 then
				var_74_19.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_74_26 = 0
			local var_74_27 = 0.5

			if var_74_26 < arg_71_1.time_ and arg_71_1.time_ <= var_74_26 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_28 = arg_71_1:FormatText(StoryNameCfg[1080].name)

				arg_71_1.leftNameTxt_.text = var_74_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_29 = arg_71_1:GetWordFromCfg(416142016)
				local var_74_30 = arg_71_1:FormatText(var_74_29.content)

				arg_71_1.text_.text = var_74_30

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_31 = 20
				local var_74_32 = utf8.len(var_74_30)
				local var_74_33 = var_74_31 <= 0 and var_74_27 or var_74_27 * (var_74_32 / var_74_31)

				if var_74_33 > 0 and var_74_27 < var_74_33 then
					arg_71_1.talkMaxDuration = var_74_33

					if var_74_33 + var_74_26 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_33 + var_74_26
					end
				end

				arg_71_1.text_.text = var_74_30
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142016", "story_v_out_416142.awb") ~= 0 then
					local var_74_34 = manager.audio:GetVoiceLength("story_v_out_416142", "416142016", "story_v_out_416142.awb") / 1000

					if var_74_34 + var_74_26 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_34 + var_74_26
					end

					if var_74_29.prefab_name ~= "" and arg_71_1.actors_[var_74_29.prefab_name] ~= nil then
						local var_74_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_29.prefab_name].transform, "story_v_out_416142", "416142016", "story_v_out_416142.awb")

						arg_71_1:RecordAudio("416142016", var_74_35)
						arg_71_1:RecordAudio("416142016", var_74_35)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_416142", "416142016", "story_v_out_416142.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_416142", "416142016", "story_v_out_416142.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_36 = math.max(var_74_27, arg_71_1.talkMaxDuration)

			if var_74_26 <= arg_71_1.time_ and arg_71_1.time_ < var_74_26 + var_74_36 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_26) / var_74_36

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_26 + var_74_36 and arg_71_1.time_ < var_74_26 + var_74_36 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
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

		arg_71_1:InitPlayNodeList()
	end,
	Play416142017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 416142017
		arg_75_1.duration_ = 3.1

		local var_75_0 = {
			zh = 3.1,
			ja = 2.433
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
				arg_75_0:Play416142018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1028"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.actorSpriteComps1028 == nil then
				arg_75_1.var_.actorSpriteComps1028 = var_78_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_2 = 0.2

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.actorSpriteComps1028 then
					for iter_78_0, iter_78_1 in pairs(arg_75_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_78_1 then
							if arg_75_1.isInRecall_ then
								local var_78_4 = Mathf.Lerp(iter_78_1.color.r, arg_75_1.hightColor1.r, var_78_3)
								local var_78_5 = Mathf.Lerp(iter_78_1.color.g, arg_75_1.hightColor1.g, var_78_3)
								local var_78_6 = Mathf.Lerp(iter_78_1.color.b, arg_75_1.hightColor1.b, var_78_3)

								iter_78_1.color = Color.New(var_78_4, var_78_5, var_78_6)
							else
								local var_78_7 = Mathf.Lerp(iter_78_1.color.r, 1, var_78_3)

								iter_78_1.color = Color.New(var_78_7, var_78_7, var_78_7)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.actorSpriteComps1028 then
				for iter_78_2, iter_78_3 in pairs(arg_75_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_78_3 then
						if arg_75_1.isInRecall_ then
							iter_78_3.color = arg_75_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_78_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_75_1.var_.actorSpriteComps1028 = nil
			end

			local var_78_8 = arg_75_1.actors_["1086"]
			local var_78_9 = 0

			if var_78_9 < arg_75_1.time_ and arg_75_1.time_ <= var_78_9 + arg_78_0 and not isNil(var_78_8) and arg_75_1.var_.actorSpriteComps1086 == nil then
				arg_75_1.var_.actorSpriteComps1086 = var_78_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_10 = 0.2

			if var_78_9 <= arg_75_1.time_ and arg_75_1.time_ < var_78_9 + var_78_10 and not isNil(var_78_8) then
				local var_78_11 = (arg_75_1.time_ - var_78_9) / var_78_10

				if arg_75_1.var_.actorSpriteComps1086 then
					for iter_78_4, iter_78_5 in pairs(arg_75_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_78_5 then
							if arg_75_1.isInRecall_ then
								local var_78_12 = Mathf.Lerp(iter_78_5.color.r, arg_75_1.hightColor2.r, var_78_11)
								local var_78_13 = Mathf.Lerp(iter_78_5.color.g, arg_75_1.hightColor2.g, var_78_11)
								local var_78_14 = Mathf.Lerp(iter_78_5.color.b, arg_75_1.hightColor2.b, var_78_11)

								iter_78_5.color = Color.New(var_78_12, var_78_13, var_78_14)
							else
								local var_78_15 = Mathf.Lerp(iter_78_5.color.r, 0.5, var_78_11)

								iter_78_5.color = Color.New(var_78_15, var_78_15, var_78_15)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= var_78_9 + var_78_10 and arg_75_1.time_ < var_78_9 + var_78_10 + arg_78_0 and not isNil(var_78_8) and arg_75_1.var_.actorSpriteComps1086 then
				for iter_78_6, iter_78_7 in pairs(arg_75_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_78_7 then
						if arg_75_1.isInRecall_ then
							iter_78_7.color = arg_75_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_78_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_75_1.var_.actorSpriteComps1086 = nil
			end

			local var_78_16 = arg_75_1.actors_["1028"].transform
			local var_78_17 = 0

			if var_78_17 < arg_75_1.time_ and arg_75_1.time_ <= var_78_17 + arg_78_0 then
				arg_75_1.var_.moveOldPos1028 = var_78_16.localPosition
				var_78_16.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("1028", 2)

				local var_78_18 = var_78_16.childCount

				for iter_78_8 = 0, var_78_18 - 1 do
					local var_78_19 = var_78_16:GetChild(iter_78_8)

					if var_78_19.name == "" or not string.find(var_78_19.name, "split") then
						var_78_19.gameObject:SetActive(true)
					else
						var_78_19.gameObject:SetActive(false)
					end
				end
			end

			local var_78_20 = 0.001

			if var_78_17 <= arg_75_1.time_ and arg_75_1.time_ < var_78_17 + var_78_20 then
				local var_78_21 = (arg_75_1.time_ - var_78_17) / var_78_20
				local var_78_22 = Vector3.New(-390, -402.7, -156.1)

				var_78_16.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1028, var_78_22, var_78_21)
			end

			if arg_75_1.time_ >= var_78_17 + var_78_20 and arg_75_1.time_ < var_78_17 + var_78_20 + arg_78_0 then
				var_78_16.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_78_23 = arg_75_1.actors_["1086"].transform
			local var_78_24 = 0

			if var_78_24 < arg_75_1.time_ and arg_75_1.time_ <= var_78_24 + arg_78_0 then
				arg_75_1.var_.moveOldPos1086 = var_78_23.localPosition
				var_78_23.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("1086", 4)

				local var_78_25 = var_78_23.childCount

				for iter_78_9 = 0, var_78_25 - 1 do
					local var_78_26 = var_78_23:GetChild(iter_78_9)

					if var_78_26.name == "" or not string.find(var_78_26.name, "split") then
						var_78_26.gameObject:SetActive(true)
					else
						var_78_26.gameObject:SetActive(false)
					end
				end
			end

			local var_78_27 = 0.001

			if var_78_24 <= arg_75_1.time_ and arg_75_1.time_ < var_78_24 + var_78_27 then
				local var_78_28 = (arg_75_1.time_ - var_78_24) / var_78_27
				local var_78_29 = Vector3.New(390, -404.2, -237.9)

				var_78_23.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1086, var_78_29, var_78_28)
			end

			if arg_75_1.time_ >= var_78_24 + var_78_27 and arg_75_1.time_ < var_78_24 + var_78_27 + arg_78_0 then
				var_78_23.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_78_30 = 0
			local var_78_31 = 0.175

			if var_78_30 < arg_75_1.time_ and arg_75_1.time_ <= var_78_30 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_32 = arg_75_1:FormatText(StoryNameCfg[327].name)

				arg_75_1.leftNameTxt_.text = var_78_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_33 = arg_75_1:GetWordFromCfg(416142017)
				local var_78_34 = arg_75_1:FormatText(var_78_33.content)

				arg_75_1.text_.text = var_78_34

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_35 = 7
				local var_78_36 = utf8.len(var_78_34)
				local var_78_37 = var_78_35 <= 0 and var_78_31 or var_78_31 * (var_78_36 / var_78_35)

				if var_78_37 > 0 and var_78_31 < var_78_37 then
					arg_75_1.talkMaxDuration = var_78_37

					if var_78_37 + var_78_30 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_37 + var_78_30
					end
				end

				arg_75_1.text_.text = var_78_34
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142017", "story_v_out_416142.awb") ~= 0 then
					local var_78_38 = manager.audio:GetVoiceLength("story_v_out_416142", "416142017", "story_v_out_416142.awb") / 1000

					if var_78_38 + var_78_30 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_38 + var_78_30
					end

					if var_78_33.prefab_name ~= "" and arg_75_1.actors_[var_78_33.prefab_name] ~= nil then
						local var_78_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_33.prefab_name].transform, "story_v_out_416142", "416142017", "story_v_out_416142.awb")

						arg_75_1:RecordAudio("416142017", var_78_39)
						arg_75_1:RecordAudio("416142017", var_78_39)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_416142", "416142017", "story_v_out_416142.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_416142", "416142017", "story_v_out_416142.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_40 = math.max(var_78_31, arg_75_1.talkMaxDuration)

			if var_78_30 <= arg_75_1.time_ and arg_75_1.time_ < var_78_30 + var_78_40 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_30) / var_78_40

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_30 + var_78_40 and arg_75_1.time_ < var_78_30 + var_78_40 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
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

		arg_75_1:InitPlayNodeList()
	end,
	Play416142018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 416142018
		arg_79_1.duration_ = 4.2

		local var_79_0 = {
			zh = 3.333,
			ja = 4.2
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
				arg_79_0:Play416142019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1086"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.actorSpriteComps1086 == nil then
				arg_79_1.var_.actorSpriteComps1086 = var_82_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_2 = 0.2

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.actorSpriteComps1086 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_82_1 then
							if arg_79_1.isInRecall_ then
								local var_82_4 = Mathf.Lerp(iter_82_1.color.r, arg_79_1.hightColor1.r, var_82_3)
								local var_82_5 = Mathf.Lerp(iter_82_1.color.g, arg_79_1.hightColor1.g, var_82_3)
								local var_82_6 = Mathf.Lerp(iter_82_1.color.b, arg_79_1.hightColor1.b, var_82_3)

								iter_82_1.color = Color.New(var_82_4, var_82_5, var_82_6)
							else
								local var_82_7 = Mathf.Lerp(iter_82_1.color.r, 1, var_82_3)

								iter_82_1.color = Color.New(var_82_7, var_82_7, var_82_7)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.actorSpriteComps1086 then
				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_82_3 then
						if arg_79_1.isInRecall_ then
							iter_82_3.color = arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_82_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_79_1.var_.actorSpriteComps1086 = nil
			end

			local var_82_8 = arg_79_1.actors_["1028"]
			local var_82_9 = 0

			if var_82_9 < arg_79_1.time_ and arg_79_1.time_ <= var_82_9 + arg_82_0 and not isNil(var_82_8) and arg_79_1.var_.actorSpriteComps1028 == nil then
				arg_79_1.var_.actorSpriteComps1028 = var_82_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_10 = 0.2

			if var_82_9 <= arg_79_1.time_ and arg_79_1.time_ < var_82_9 + var_82_10 and not isNil(var_82_8) then
				local var_82_11 = (arg_79_1.time_ - var_82_9) / var_82_10

				if arg_79_1.var_.actorSpriteComps1028 then
					for iter_82_4, iter_82_5 in pairs(arg_79_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_82_5 then
							if arg_79_1.isInRecall_ then
								local var_82_12 = Mathf.Lerp(iter_82_5.color.r, arg_79_1.hightColor2.r, var_82_11)
								local var_82_13 = Mathf.Lerp(iter_82_5.color.g, arg_79_1.hightColor2.g, var_82_11)
								local var_82_14 = Mathf.Lerp(iter_82_5.color.b, arg_79_1.hightColor2.b, var_82_11)

								iter_82_5.color = Color.New(var_82_12, var_82_13, var_82_14)
							else
								local var_82_15 = Mathf.Lerp(iter_82_5.color.r, 0.5, var_82_11)

								iter_82_5.color = Color.New(var_82_15, var_82_15, var_82_15)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= var_82_9 + var_82_10 and arg_79_1.time_ < var_82_9 + var_82_10 + arg_82_0 and not isNil(var_82_8) and arg_79_1.var_.actorSpriteComps1028 then
				for iter_82_6, iter_82_7 in pairs(arg_79_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_82_7 then
						if arg_79_1.isInRecall_ then
							iter_82_7.color = arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_82_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_79_1.var_.actorSpriteComps1028 = nil
			end

			local var_82_16 = arg_79_1.actors_["1086"].transform
			local var_82_17 = 0

			if var_82_17 < arg_79_1.time_ and arg_79_1.time_ <= var_82_17 + arg_82_0 then
				arg_79_1.var_.moveOldPos1086 = var_82_16.localPosition
				var_82_16.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("1086", 4)

				local var_82_18 = var_82_16.childCount

				for iter_82_8 = 0, var_82_18 - 1 do
					local var_82_19 = var_82_16:GetChild(iter_82_8)

					if var_82_19.name == "split_6" or not string.find(var_82_19.name, "split") then
						var_82_19.gameObject:SetActive(true)
					else
						var_82_19.gameObject:SetActive(false)
					end
				end
			end

			local var_82_20 = 0.001

			if var_82_17 <= arg_79_1.time_ and arg_79_1.time_ < var_82_17 + var_82_20 then
				local var_82_21 = (arg_79_1.time_ - var_82_17) / var_82_20
				local var_82_22 = Vector3.New(390, -404.2, -237.9)

				var_82_16.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1086, var_82_22, var_82_21)
			end

			if arg_79_1.time_ >= var_82_17 + var_82_20 and arg_79_1.time_ < var_82_17 + var_82_20 + arg_82_0 then
				var_82_16.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_82_23 = 0
			local var_82_24 = 0.3

			if var_82_23 < arg_79_1.time_ and arg_79_1.time_ <= var_82_23 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_25 = arg_79_1:FormatText(StoryNameCfg[1080].name)

				arg_79_1.leftNameTxt_.text = var_82_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_26 = arg_79_1:GetWordFromCfg(416142018)
				local var_82_27 = arg_79_1:FormatText(var_82_26.content)

				arg_79_1.text_.text = var_82_27

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_28 = 12
				local var_82_29 = utf8.len(var_82_27)
				local var_82_30 = var_82_28 <= 0 and var_82_24 or var_82_24 * (var_82_29 / var_82_28)

				if var_82_30 > 0 and var_82_24 < var_82_30 then
					arg_79_1.talkMaxDuration = var_82_30

					if var_82_30 + var_82_23 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_30 + var_82_23
					end
				end

				arg_79_1.text_.text = var_82_27
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142018", "story_v_out_416142.awb") ~= 0 then
					local var_82_31 = manager.audio:GetVoiceLength("story_v_out_416142", "416142018", "story_v_out_416142.awb") / 1000

					if var_82_31 + var_82_23 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_31 + var_82_23
					end

					if var_82_26.prefab_name ~= "" and arg_79_1.actors_[var_82_26.prefab_name] ~= nil then
						local var_82_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_26.prefab_name].transform, "story_v_out_416142", "416142018", "story_v_out_416142.awb")

						arg_79_1:RecordAudio("416142018", var_82_32)
						arg_79_1:RecordAudio("416142018", var_82_32)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_416142", "416142018", "story_v_out_416142.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_416142", "416142018", "story_v_out_416142.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_33 = math.max(var_82_24, arg_79_1.talkMaxDuration)

			if var_82_23 <= arg_79_1.time_ and arg_79_1.time_ < var_82_23 + var_82_33 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_23) / var_82_33

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_23 + var_82_33 and arg_79_1.time_ < var_82_23 + var_82_33 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
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

		arg_79_1:InitPlayNodeList()
	end,
	Play416142019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 416142019
		arg_83_1.duration_ = 5.53

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play416142020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1086"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.actorSpriteComps1086 == nil then
				arg_83_1.var_.actorSpriteComps1086 = var_86_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_2 = 0.2

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.actorSpriteComps1086 then
					for iter_86_0, iter_86_1 in pairs(arg_83_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_86_1 then
							if arg_83_1.isInRecall_ then
								local var_86_4 = Mathf.Lerp(iter_86_1.color.r, arg_83_1.hightColor2.r, var_86_3)
								local var_86_5 = Mathf.Lerp(iter_86_1.color.g, arg_83_1.hightColor2.g, var_86_3)
								local var_86_6 = Mathf.Lerp(iter_86_1.color.b, arg_83_1.hightColor2.b, var_86_3)

								iter_86_1.color = Color.New(var_86_4, var_86_5, var_86_6)
							else
								local var_86_7 = Mathf.Lerp(iter_86_1.color.r, 0.5, var_86_3)

								iter_86_1.color = Color.New(var_86_7, var_86_7, var_86_7)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.actorSpriteComps1086 then
				for iter_86_2, iter_86_3 in pairs(arg_83_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_86_3 then
						if arg_83_1.isInRecall_ then
							iter_86_3.color = arg_83_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_86_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_83_1.var_.actorSpriteComps1086 = nil
			end

			local var_86_8 = arg_83_1.actors_["1028"].transform
			local var_86_9 = 0

			if var_86_9 < arg_83_1.time_ and arg_83_1.time_ <= var_86_9 + arg_86_0 then
				arg_83_1.var_.moveOldPos1028 = var_86_8.localPosition
				var_86_8.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("1028", 7)

				local var_86_10 = var_86_8.childCount

				for iter_86_4 = 0, var_86_10 - 1 do
					local var_86_11 = var_86_8:GetChild(iter_86_4)

					if var_86_11.name == "" or not string.find(var_86_11.name, "split") then
						var_86_11.gameObject:SetActive(true)
					else
						var_86_11.gameObject:SetActive(false)
					end
				end
			end

			local var_86_12 = 0.001

			if var_86_9 <= arg_83_1.time_ and arg_83_1.time_ < var_86_9 + var_86_12 then
				local var_86_13 = (arg_83_1.time_ - var_86_9) / var_86_12
				local var_86_14 = Vector3.New(0, -2000, 0)

				var_86_8.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1028, var_86_14, var_86_13)
			end

			if arg_83_1.time_ >= var_86_9 + var_86_12 and arg_83_1.time_ < var_86_9 + var_86_12 + arg_86_0 then
				var_86_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_86_15 = arg_83_1.actors_["1086"].transform
			local var_86_16 = 0

			if var_86_16 < arg_83_1.time_ and arg_83_1.time_ <= var_86_16 + arg_86_0 then
				arg_83_1.var_.moveOldPos1086 = var_86_15.localPosition
				var_86_15.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("1086", 7)

				local var_86_17 = var_86_15.childCount

				for iter_86_5 = 0, var_86_17 - 1 do
					local var_86_18 = var_86_15:GetChild(iter_86_5)

					if var_86_18.name == "" or not string.find(var_86_18.name, "split") then
						var_86_18.gameObject:SetActive(true)
					else
						var_86_18.gameObject:SetActive(false)
					end
				end
			end

			local var_86_19 = 0.001

			if var_86_16 <= arg_83_1.time_ and arg_83_1.time_ < var_86_16 + var_86_19 then
				local var_86_20 = (arg_83_1.time_ - var_86_16) / var_86_19
				local var_86_21 = Vector3.New(0, -2000, 0)

				var_86_15.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1086, var_86_21, var_86_20)
			end

			if arg_83_1.time_ >= var_86_16 + var_86_19 and arg_83_1.time_ < var_86_16 + var_86_19 + arg_86_0 then
				var_86_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_86_22 = manager.ui.mainCamera.transform
			local var_86_23 = 0

			if var_86_23 < arg_83_1.time_ and arg_83_1.time_ <= var_86_23 + arg_86_0 then
				local var_86_24 = arg_83_1.var_.effect7777
				local var_86_25
				local var_86_26 = var_86_22

				if not var_86_24 then
					var_86_24 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), var_86_26)
					var_86_24.name = "7777"
					arg_83_1.var_.effect7777 = var_86_24
				else
					var_86_24.transform:SetParent(var_86_26)
				end

				var_86_24.transform.localPosition = Vector3.New(0, 0, 0.66)
				var_86_24.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_86_27 = manager.ui.mainCameraCom_
				local var_86_28 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_86_27.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_86_29 = var_86_24.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_86_30 = 15
				local var_86_31 = 2 * var_86_30 * Mathf.Tan(var_86_27.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_86_27.aspect
				local var_86_32 = 1
				local var_86_33 = 1.7777777777777777

				if var_86_33 < var_86_27.aspect then
					var_86_32 = var_86_31 / (2 * var_86_30 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_86_33)
				end

				for iter_86_6, iter_86_7 in ipairs(var_86_29) do
					local var_86_34 = iter_86_7.transform.localScale

					iter_86_7.transform.localScale = Vector3.New(var_86_34.x / var_86_28 * var_86_32, var_86_34.y / var_86_28, var_86_34.z)
				end
			end

			local var_86_35 = manager.ui.mainCamera.transform
			local var_86_36 = 0.733333333333333

			if var_86_36 < arg_83_1.time_ and arg_83_1.time_ <= var_86_36 + arg_86_0 then
				local var_86_37 = arg_83_1.var_.effect7777

				if var_86_37 then
					Object.Destroy(var_86_37)

					arg_83_1.var_.effect7777 = nil
				end
			end

			local var_86_38 = 0

			if var_86_38 < arg_83_1.time_ and arg_83_1.time_ <= var_86_38 + arg_86_0 then
				arg_83_1.allBtn_.enabled = false
			end

			local var_86_39 = 0.833333333333333

			if arg_83_1.time_ >= var_86_38 + var_86_39 and arg_83_1.time_ < var_86_38 + var_86_39 + arg_86_0 then
				arg_83_1.allBtn_.enabled = true
			end

			local var_86_40 = 0
			local var_86_41 = 1

			if var_86_40 < arg_83_1.time_ and arg_83_1.time_ <= var_86_40 + arg_86_0 then
				local var_86_42 = "play"
				local var_86_43 = "effect"

				arg_83_1:AudioAction(var_86_42, var_86_43, "se_story_127", "se_story_127_hit", "")
			end

			if arg_83_1.frameCnt_ <= 1 then
				arg_83_1.dialog_:SetActive(false)
			end

			local var_86_44 = 0.533333333333333
			local var_86_45 = 1.5

			if var_86_44 < arg_83_1.time_ and arg_83_1.time_ <= var_86_44 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0

				arg_83_1.dialog_:SetActive(true)

				arg_83_1.dialogCg_.alpha = 0

				local var_86_46 = LeanTween.value(arg_83_1.dialog_, 0, 1, 0.3)

				var_86_46:setOnUpdate(LuaHelper.FloatAction(function(arg_87_0)
					arg_83_1.dialogCg_.alpha = arg_87_0
				end))
				var_86_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_83_1.dialog_)
					var_86_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_83_1.duration_ = arg_83_1.duration_ + 0.3

				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_47 = arg_83_1:GetWordFromCfg(416142019)
				local var_86_48 = arg_83_1:FormatText(var_86_47.content)

				arg_83_1.text_.text = var_86_48

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_49 = 60
				local var_86_50 = utf8.len(var_86_48)
				local var_86_51 = var_86_49 <= 0 and var_86_45 or var_86_45 * (var_86_50 / var_86_49)

				if var_86_51 > 0 and var_86_45 < var_86_51 then
					arg_83_1.talkMaxDuration = var_86_51
					var_86_44 = var_86_44 + 0.3

					if var_86_51 + var_86_44 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_51 + var_86_44
					end
				end

				arg_83_1.text_.text = var_86_48
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_52 = var_86_44 + 0.3
			local var_86_53 = math.max(var_86_45, arg_83_1.talkMaxDuration)

			if var_86_52 <= arg_83_1.time_ and arg_83_1.time_ < var_86_52 + var_86_53 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_52) / var_86_53

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_52 + var_86_53 and arg_83_1.time_ < var_86_52 + var_86_53 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
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

		arg_83_1:InitPlayNodeList()
	end,
	Play416142020 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 416142020
		arg_89_1.duration_ = 7.07

		local var_89_0 = {
			zh = 5.7,
			ja = 7.066
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
				arg_89_0:Play416142021(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.45

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[36].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:GetWordFromCfg(416142020)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 18
				local var_92_6 = utf8.len(var_92_4)
				local var_92_7 = var_92_5 <= 0 and var_92_1 or var_92_1 * (var_92_6 / var_92_5)

				if var_92_7 > 0 and var_92_1 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142020", "story_v_out_416142.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_416142", "416142020", "story_v_out_416142.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_416142", "416142020", "story_v_out_416142.awb")

						arg_89_1:RecordAudio("416142020", var_92_9)
						arg_89_1:RecordAudio("416142020", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_416142", "416142020", "story_v_out_416142.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_416142", "416142020", "story_v_out_416142.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_10 and arg_89_1.time_ < var_92_0 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play416142021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 416142021
		arg_93_1.duration_ = 5.5

		local var_93_0 = {
			zh = 5,
			ja = 5.5
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
				arg_93_0:Play416142022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.35

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[36].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:GetWordFromCfg(416142021)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142021", "story_v_out_416142.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_416142", "416142021", "story_v_out_416142.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_416142", "416142021", "story_v_out_416142.awb")

						arg_93_1:RecordAudio("416142021", var_96_9)
						arg_93_1:RecordAudio("416142021", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_416142", "416142021", "story_v_out_416142.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_416142", "416142021", "story_v_out_416142.awb")
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
	Play416142022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 416142022
		arg_97_1.duration_ = 6

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play416142023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = manager.ui.mainCamera.transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.shakeOldPos = var_100_0.localPosition
			end

			local var_100_2 = 0.8

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / 0.066
				local var_100_4, var_100_5 = math.modf(var_100_3)

				var_100_0.localPosition = Vector3.New(var_100_5 * 0.13, var_100_5 * 0.13, var_100_5 * 0.13) + arg_97_1.var_.shakeOldPos
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = arg_97_1.var_.shakeOldPos
			end

			local var_100_6 = 0.6

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = true

				arg_97_1:SetGaussion(false)
			end

			local var_100_7 = 0.5

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_7 then
				local var_100_8 = (arg_97_1.time_ - var_100_6) / var_100_7
				local var_100_9 = Color.New(0.5188679, 0.03671235, 0.03671235)

				var_100_9.a = Mathf.Lerp(1, 0, var_100_8)
				arg_97_1.mask_.color = var_100_9
			end

			if arg_97_1.time_ >= var_100_6 + var_100_7 and arg_97_1.time_ < var_100_6 + var_100_7 + arg_100_0 then
				local var_100_10 = Color.New(0.5188679, 0.03671235, 0.03671235)
				local var_100_11 = 0

				arg_97_1.mask_.enabled = false
				var_100_10.a = var_100_11
				arg_97_1.mask_.color = var_100_10
			end

			local var_100_12 = 0

			if var_100_12 < arg_97_1.time_ and arg_97_1.time_ <= var_100_12 + arg_100_0 then
				arg_97_1.allBtn_.enabled = false
			end

			local var_100_13 = 1.33333333333333

			if arg_97_1.time_ >= var_100_12 + var_100_13 and arg_97_1.time_ < var_100_12 + var_100_13 + arg_100_0 then
				arg_97_1.allBtn_.enabled = true
			end

			local var_100_14 = 0.7
			local var_100_15 = 1

			if var_100_14 < arg_97_1.time_ and arg_97_1.time_ <= var_100_14 + arg_100_0 then
				local var_100_16 = "play"
				local var_100_17 = "effect"

				arg_97_1:AudioAction(var_100_16, var_100_17, "se_story_15", "se_story_15_shock", "")
			end

			if arg_97_1.frameCnt_ <= 1 then
				arg_97_1.dialog_:SetActive(false)
			end

			local var_100_18 = 1
			local var_100_19 = 2.15

			if var_100_18 < arg_97_1.time_ and arg_97_1.time_ <= var_100_18 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0

				arg_97_1.dialog_:SetActive(true)

				arg_97_1.dialogCg_.alpha = 0

				local var_100_20 = LeanTween.value(arg_97_1.dialog_, 0, 1, 0.3)

				var_100_20:setOnUpdate(LuaHelper.FloatAction(function(arg_101_0)
					arg_97_1.dialogCg_.alpha = arg_101_0
				end))
				var_100_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_97_1.dialog_)
					var_100_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_97_1.duration_ = arg_97_1.duration_ + 0.3

				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_21 = arg_97_1:GetWordFromCfg(416142022)
				local var_100_22 = arg_97_1:FormatText(var_100_21.content)

				arg_97_1.text_.text = var_100_22

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_23 = 86
				local var_100_24 = utf8.len(var_100_22)
				local var_100_25 = var_100_23 <= 0 and var_100_19 or var_100_19 * (var_100_24 / var_100_23)

				if var_100_25 > 0 and var_100_19 < var_100_25 then
					arg_97_1.talkMaxDuration = var_100_25
					var_100_18 = var_100_18 + 0.3

					if var_100_25 + var_100_18 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_25 + var_100_18
					end
				end

				arg_97_1.text_.text = var_100_22
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_26 = var_100_18 + 0.3
			local var_100_27 = math.max(var_100_19, arg_97_1.talkMaxDuration)

			if var_100_26 <= arg_97_1.time_ and arg_97_1.time_ < var_100_26 + var_100_27 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_26) / var_100_27

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_26 + var_100_27 and arg_97_1.time_ < var_100_26 + var_100_27 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play416142023 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 416142023
		arg_103_1.duration_ = 3.47

		local var_103_0 = {
			zh = 3.466,
			ja = 3.366
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
				arg_103_0:Play416142024(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1028"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.actorSpriteComps1028 == nil then
				arg_103_1.var_.actorSpriteComps1028 = var_106_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_2 = 0.2

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.actorSpriteComps1028 then
					for iter_106_0, iter_106_1 in pairs(arg_103_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_106_1 then
							if arg_103_1.isInRecall_ then
								local var_106_4 = Mathf.Lerp(iter_106_1.color.r, arg_103_1.hightColor1.r, var_106_3)
								local var_106_5 = Mathf.Lerp(iter_106_1.color.g, arg_103_1.hightColor1.g, var_106_3)
								local var_106_6 = Mathf.Lerp(iter_106_1.color.b, arg_103_1.hightColor1.b, var_106_3)

								iter_106_1.color = Color.New(var_106_4, var_106_5, var_106_6)
							else
								local var_106_7 = Mathf.Lerp(iter_106_1.color.r, 1, var_106_3)

								iter_106_1.color = Color.New(var_106_7, var_106_7, var_106_7)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.actorSpriteComps1028 then
				for iter_106_2, iter_106_3 in pairs(arg_103_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_106_3 then
						if arg_103_1.isInRecall_ then
							iter_106_3.color = arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_106_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_103_1.var_.actorSpriteComps1028 = nil
			end

			local var_106_8 = arg_103_1.actors_["1028"].transform
			local var_106_9 = 0

			if var_106_9 < arg_103_1.time_ and arg_103_1.time_ <= var_106_9 + arg_106_0 then
				arg_103_1.var_.moveOldPos1028 = var_106_8.localPosition
				var_106_8.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("1028", 3)

				local var_106_10 = var_106_8.childCount

				for iter_106_4 = 0, var_106_10 - 1 do
					local var_106_11 = var_106_8:GetChild(iter_106_4)

					if var_106_11.name == "split_2" or not string.find(var_106_11.name, "split") then
						var_106_11.gameObject:SetActive(true)
					else
						var_106_11.gameObject:SetActive(false)
					end
				end
			end

			local var_106_12 = 0.001

			if var_106_9 <= arg_103_1.time_ and arg_103_1.time_ < var_106_9 + var_106_12 then
				local var_106_13 = (arg_103_1.time_ - var_106_9) / var_106_12
				local var_106_14 = Vector3.New(0, -402.7, -156.1)

				var_106_8.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1028, var_106_14, var_106_13)
			end

			if arg_103_1.time_ >= var_106_9 + var_106_12 and arg_103_1.time_ < var_106_9 + var_106_12 + arg_106_0 then
				var_106_8.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_106_15 = 0
			local var_106_16 = 0.4

			if var_106_15 < arg_103_1.time_ and arg_103_1.time_ <= var_106_15 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_17 = arg_103_1:FormatText(StoryNameCfg[327].name)

				arg_103_1.leftNameTxt_.text = var_106_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_18 = arg_103_1:GetWordFromCfg(416142023)
				local var_106_19 = arg_103_1:FormatText(var_106_18.content)

				arg_103_1.text_.text = var_106_19

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_20 = 16
				local var_106_21 = utf8.len(var_106_19)
				local var_106_22 = var_106_20 <= 0 and var_106_16 or var_106_16 * (var_106_21 / var_106_20)

				if var_106_22 > 0 and var_106_16 < var_106_22 then
					arg_103_1.talkMaxDuration = var_106_22

					if var_106_22 + var_106_15 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_22 + var_106_15
					end
				end

				arg_103_1.text_.text = var_106_19
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142023", "story_v_out_416142.awb") ~= 0 then
					local var_106_23 = manager.audio:GetVoiceLength("story_v_out_416142", "416142023", "story_v_out_416142.awb") / 1000

					if var_106_23 + var_106_15 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_23 + var_106_15
					end

					if var_106_18.prefab_name ~= "" and arg_103_1.actors_[var_106_18.prefab_name] ~= nil then
						local var_106_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_18.prefab_name].transform, "story_v_out_416142", "416142023", "story_v_out_416142.awb")

						arg_103_1:RecordAudio("416142023", var_106_24)
						arg_103_1:RecordAudio("416142023", var_106_24)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_416142", "416142023", "story_v_out_416142.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_416142", "416142023", "story_v_out_416142.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_25 = math.max(var_106_16, arg_103_1.talkMaxDuration)

			if var_106_15 <= arg_103_1.time_ and arg_103_1.time_ < var_106_15 + var_106_25 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_15) / var_106_25

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_15 + var_106_25 and arg_103_1.time_ < var_106_15 + var_106_25 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
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

		arg_103_1:InitPlayNodeList()
	end,
	Play416142024 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 416142024
		arg_107_1.duration_ = 6.6

		local var_107_0 = {
			zh = 3.333,
			ja = 6.6
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play416142025(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1086"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps1086 == nil then
				arg_107_1.var_.actorSpriteComps1086 = var_110_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_2 = 0.2

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.actorSpriteComps1086 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_110_1 then
							if arg_107_1.isInRecall_ then
								local var_110_4 = Mathf.Lerp(iter_110_1.color.r, arg_107_1.hightColor1.r, var_110_3)
								local var_110_5 = Mathf.Lerp(iter_110_1.color.g, arg_107_1.hightColor1.g, var_110_3)
								local var_110_6 = Mathf.Lerp(iter_110_1.color.b, arg_107_1.hightColor1.b, var_110_3)

								iter_110_1.color = Color.New(var_110_4, var_110_5, var_110_6)
							else
								local var_110_7 = Mathf.Lerp(iter_110_1.color.r, 1, var_110_3)

								iter_110_1.color = Color.New(var_110_7, var_110_7, var_110_7)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps1086 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_110_3 then
						if arg_107_1.isInRecall_ then
							iter_110_3.color = arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_110_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps1086 = nil
			end

			local var_110_8 = arg_107_1.actors_["1086"].transform
			local var_110_9 = 0

			if var_110_9 < arg_107_1.time_ and arg_107_1.time_ <= var_110_9 + arg_110_0 then
				arg_107_1.var_.moveOldPos1086 = var_110_8.localPosition
				var_110_8.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("1086", 4)

				local var_110_10 = var_110_8.childCount

				for iter_110_4 = 0, var_110_10 - 1 do
					local var_110_11 = var_110_8:GetChild(iter_110_4)

					if var_110_11.name == "split_6" or not string.find(var_110_11.name, "split") then
						var_110_11.gameObject:SetActive(true)
					else
						var_110_11.gameObject:SetActive(false)
					end
				end
			end

			local var_110_12 = 0.001

			if var_110_9 <= arg_107_1.time_ and arg_107_1.time_ < var_110_9 + var_110_12 then
				local var_110_13 = (arg_107_1.time_ - var_110_9) / var_110_12
				local var_110_14 = Vector3.New(390, -404.2, -237.9)

				var_110_8.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1086, var_110_14, var_110_13)
			end

			if arg_107_1.time_ >= var_110_9 + var_110_12 and arg_107_1.time_ < var_110_9 + var_110_12 + arg_110_0 then
				var_110_8.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_110_15 = arg_107_1.actors_["1028"].transform
			local var_110_16 = 0

			if var_110_16 < arg_107_1.time_ and arg_107_1.time_ <= var_110_16 + arg_110_0 then
				arg_107_1.var_.moveOldPos1028 = var_110_15.localPosition
				var_110_15.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("1028", 2)

				local var_110_17 = var_110_15.childCount

				for iter_110_5 = 0, var_110_17 - 1 do
					local var_110_18 = var_110_15:GetChild(iter_110_5)

					if var_110_18.name == "" or not string.find(var_110_18.name, "split") then
						var_110_18.gameObject:SetActive(true)
					else
						var_110_18.gameObject:SetActive(false)
					end
				end
			end

			local var_110_19 = 0.001

			if var_110_16 <= arg_107_1.time_ and arg_107_1.time_ < var_110_16 + var_110_19 then
				local var_110_20 = (arg_107_1.time_ - var_110_16) / var_110_19
				local var_110_21 = Vector3.New(-390, -402.7, -156.1)

				var_110_15.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1028, var_110_21, var_110_20)
			end

			if arg_107_1.time_ >= var_110_16 + var_110_19 and arg_107_1.time_ < var_110_16 + var_110_19 + arg_110_0 then
				var_110_15.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_110_22 = arg_107_1.actors_["1028"]
			local var_110_23 = 0

			if var_110_23 < arg_107_1.time_ and arg_107_1.time_ <= var_110_23 + arg_110_0 and not isNil(var_110_22) and arg_107_1.var_.actorSpriteComps1028 == nil then
				arg_107_1.var_.actorSpriteComps1028 = var_110_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_24 = 0.2

			if var_110_23 <= arg_107_1.time_ and arg_107_1.time_ < var_110_23 + var_110_24 and not isNil(var_110_22) then
				local var_110_25 = (arg_107_1.time_ - var_110_23) / var_110_24

				if arg_107_1.var_.actorSpriteComps1028 then
					for iter_110_6, iter_110_7 in pairs(arg_107_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_110_7 then
							if arg_107_1.isInRecall_ then
								local var_110_26 = Mathf.Lerp(iter_110_7.color.r, arg_107_1.hightColor2.r, var_110_25)
								local var_110_27 = Mathf.Lerp(iter_110_7.color.g, arg_107_1.hightColor2.g, var_110_25)
								local var_110_28 = Mathf.Lerp(iter_110_7.color.b, arg_107_1.hightColor2.b, var_110_25)

								iter_110_7.color = Color.New(var_110_26, var_110_27, var_110_28)
							else
								local var_110_29 = Mathf.Lerp(iter_110_7.color.r, 0.5, var_110_25)

								iter_110_7.color = Color.New(var_110_29, var_110_29, var_110_29)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= var_110_23 + var_110_24 and arg_107_1.time_ < var_110_23 + var_110_24 + arg_110_0 and not isNil(var_110_22) and arg_107_1.var_.actorSpriteComps1028 then
				for iter_110_8, iter_110_9 in pairs(arg_107_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_110_9 then
						if arg_107_1.isInRecall_ then
							iter_110_9.color = arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_110_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps1028 = nil
			end

			local var_110_30 = 0
			local var_110_31 = 0.35

			if var_110_30 < arg_107_1.time_ and arg_107_1.time_ <= var_110_30 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_32 = arg_107_1:FormatText(StoryNameCfg[1080].name)

				arg_107_1.leftNameTxt_.text = var_110_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_33 = arg_107_1:GetWordFromCfg(416142024)
				local var_110_34 = arg_107_1:FormatText(var_110_33.content)

				arg_107_1.text_.text = var_110_34

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_35 = 14
				local var_110_36 = utf8.len(var_110_34)
				local var_110_37 = var_110_35 <= 0 and var_110_31 or var_110_31 * (var_110_36 / var_110_35)

				if var_110_37 > 0 and var_110_31 < var_110_37 then
					arg_107_1.talkMaxDuration = var_110_37

					if var_110_37 + var_110_30 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_37 + var_110_30
					end
				end

				arg_107_1.text_.text = var_110_34
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142024", "story_v_out_416142.awb") ~= 0 then
					local var_110_38 = manager.audio:GetVoiceLength("story_v_out_416142", "416142024", "story_v_out_416142.awb") / 1000

					if var_110_38 + var_110_30 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_38 + var_110_30
					end

					if var_110_33.prefab_name ~= "" and arg_107_1.actors_[var_110_33.prefab_name] ~= nil then
						local var_110_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_33.prefab_name].transform, "story_v_out_416142", "416142024", "story_v_out_416142.awb")

						arg_107_1:RecordAudio("416142024", var_110_39)
						arg_107_1:RecordAudio("416142024", var_110_39)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_416142", "416142024", "story_v_out_416142.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_416142", "416142024", "story_v_out_416142.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_40 = math.max(var_110_31, arg_107_1.talkMaxDuration)

			if var_110_30 <= arg_107_1.time_ and arg_107_1.time_ < var_110_30 + var_110_40 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_30) / var_110_40

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_30 + var_110_40 and arg_107_1.time_ < var_110_30 + var_110_40 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
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
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play416142025 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 416142025
		arg_111_1.duration_ = 5.93

		local var_111_0 = {
			zh = 4.766,
			ja = 5.933
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
				arg_111_0:Play416142026(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1028"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.actorSpriteComps1028 == nil then
				arg_111_1.var_.actorSpriteComps1028 = var_114_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_2 = 0.2

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.actorSpriteComps1028 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_114_1 then
							if arg_111_1.isInRecall_ then
								local var_114_4 = Mathf.Lerp(iter_114_1.color.r, arg_111_1.hightColor1.r, var_114_3)
								local var_114_5 = Mathf.Lerp(iter_114_1.color.g, arg_111_1.hightColor1.g, var_114_3)
								local var_114_6 = Mathf.Lerp(iter_114_1.color.b, arg_111_1.hightColor1.b, var_114_3)

								iter_114_1.color = Color.New(var_114_4, var_114_5, var_114_6)
							else
								local var_114_7 = Mathf.Lerp(iter_114_1.color.r, 1, var_114_3)

								iter_114_1.color = Color.New(var_114_7, var_114_7, var_114_7)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.actorSpriteComps1028 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_114_3 then
						if arg_111_1.isInRecall_ then
							iter_114_3.color = arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_114_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps1028 = nil
			end

			local var_114_8 = arg_111_1.actors_["1086"]
			local var_114_9 = 0

			if var_114_9 < arg_111_1.time_ and arg_111_1.time_ <= var_114_9 + arg_114_0 and not isNil(var_114_8) and arg_111_1.var_.actorSpriteComps1086 == nil then
				arg_111_1.var_.actorSpriteComps1086 = var_114_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_10 = 0.2

			if var_114_9 <= arg_111_1.time_ and arg_111_1.time_ < var_114_9 + var_114_10 and not isNil(var_114_8) then
				local var_114_11 = (arg_111_1.time_ - var_114_9) / var_114_10

				if arg_111_1.var_.actorSpriteComps1086 then
					for iter_114_4, iter_114_5 in pairs(arg_111_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_114_5 then
							if arg_111_1.isInRecall_ then
								local var_114_12 = Mathf.Lerp(iter_114_5.color.r, arg_111_1.hightColor2.r, var_114_11)
								local var_114_13 = Mathf.Lerp(iter_114_5.color.g, arg_111_1.hightColor2.g, var_114_11)
								local var_114_14 = Mathf.Lerp(iter_114_5.color.b, arg_111_1.hightColor2.b, var_114_11)

								iter_114_5.color = Color.New(var_114_12, var_114_13, var_114_14)
							else
								local var_114_15 = Mathf.Lerp(iter_114_5.color.r, 0.5, var_114_11)

								iter_114_5.color = Color.New(var_114_15, var_114_15, var_114_15)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= var_114_9 + var_114_10 and arg_111_1.time_ < var_114_9 + var_114_10 + arg_114_0 and not isNil(var_114_8) and arg_111_1.var_.actorSpriteComps1086 then
				for iter_114_6, iter_114_7 in pairs(arg_111_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_114_7 then
						if arg_111_1.isInRecall_ then
							iter_114_7.color = arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_114_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps1086 = nil
			end

			local var_114_16 = 0
			local var_114_17 = 0.5

			if var_114_16 < arg_111_1.time_ and arg_111_1.time_ <= var_114_16 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_18 = arg_111_1:FormatText(StoryNameCfg[327].name)

				arg_111_1.leftNameTxt_.text = var_114_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_19 = arg_111_1:GetWordFromCfg(416142025)
				local var_114_20 = arg_111_1:FormatText(var_114_19.content)

				arg_111_1.text_.text = var_114_20

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_21 = 20
				local var_114_22 = utf8.len(var_114_20)
				local var_114_23 = var_114_21 <= 0 and var_114_17 or var_114_17 * (var_114_22 / var_114_21)

				if var_114_23 > 0 and var_114_17 < var_114_23 then
					arg_111_1.talkMaxDuration = var_114_23

					if var_114_23 + var_114_16 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_23 + var_114_16
					end
				end

				arg_111_1.text_.text = var_114_20
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142025", "story_v_out_416142.awb") ~= 0 then
					local var_114_24 = manager.audio:GetVoiceLength("story_v_out_416142", "416142025", "story_v_out_416142.awb") / 1000

					if var_114_24 + var_114_16 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_24 + var_114_16
					end

					if var_114_19.prefab_name ~= "" and arg_111_1.actors_[var_114_19.prefab_name] ~= nil then
						local var_114_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_19.prefab_name].transform, "story_v_out_416142", "416142025", "story_v_out_416142.awb")

						arg_111_1:RecordAudio("416142025", var_114_25)
						arg_111_1:RecordAudio("416142025", var_114_25)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_416142", "416142025", "story_v_out_416142.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_416142", "416142025", "story_v_out_416142.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_26 = math.max(var_114_17, arg_111_1.talkMaxDuration)

			if var_114_16 <= arg_111_1.time_ and arg_111_1.time_ < var_114_16 + var_114_26 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_16) / var_114_26

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_16 + var_114_26 and arg_111_1.time_ < var_114_16 + var_114_26 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play416142026 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 416142026
		arg_115_1.duration_ = 6.37

		local var_115_0 = {
			zh = 4.566,
			ja = 6.366
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
				arg_115_0:Play416142027(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1028"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos1028 = var_118_0.localPosition
				var_118_0.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("1028", 2)

				local var_118_2 = var_118_0.childCount

				for iter_118_0 = 0, var_118_2 - 1 do
					local var_118_3 = var_118_0:GetChild(iter_118_0)

					if var_118_3.name == "split_2" or not string.find(var_118_3.name, "split") then
						var_118_3.gameObject:SetActive(true)
					else
						var_118_3.gameObject:SetActive(false)
					end
				end
			end

			local var_118_4 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_4 then
				local var_118_5 = (arg_115_1.time_ - var_118_1) / var_118_4
				local var_118_6 = Vector3.New(-390, -402.7, -156.1)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1028, var_118_6, var_118_5)
			end

			if arg_115_1.time_ >= var_118_1 + var_118_4 and arg_115_1.time_ < var_118_1 + var_118_4 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_118_7 = 0
			local var_118_8 = 0.35

			if var_118_7 < arg_115_1.time_ and arg_115_1.time_ <= var_118_7 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_9 = arg_115_1:FormatText(StoryNameCfg[327].name)

				arg_115_1.leftNameTxt_.text = var_118_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_10 = arg_115_1:GetWordFromCfg(416142026)
				local var_118_11 = arg_115_1:FormatText(var_118_10.content)

				arg_115_1.text_.text = var_118_11

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_12 = 14
				local var_118_13 = utf8.len(var_118_11)
				local var_118_14 = var_118_12 <= 0 and var_118_8 or var_118_8 * (var_118_13 / var_118_12)

				if var_118_14 > 0 and var_118_8 < var_118_14 then
					arg_115_1.talkMaxDuration = var_118_14

					if var_118_14 + var_118_7 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_14 + var_118_7
					end
				end

				arg_115_1.text_.text = var_118_11
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142026", "story_v_out_416142.awb") ~= 0 then
					local var_118_15 = manager.audio:GetVoiceLength("story_v_out_416142", "416142026", "story_v_out_416142.awb") / 1000

					if var_118_15 + var_118_7 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_15 + var_118_7
					end

					if var_118_10.prefab_name ~= "" and arg_115_1.actors_[var_118_10.prefab_name] ~= nil then
						local var_118_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_10.prefab_name].transform, "story_v_out_416142", "416142026", "story_v_out_416142.awb")

						arg_115_1:RecordAudio("416142026", var_118_16)
						arg_115_1:RecordAudio("416142026", var_118_16)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_416142", "416142026", "story_v_out_416142.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_416142", "416142026", "story_v_out_416142.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_17 = math.max(var_118_8, arg_115_1.talkMaxDuration)

			if var_118_7 <= arg_115_1.time_ and arg_115_1.time_ < var_118_7 + var_118_17 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_7) / var_118_17

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_7 + var_118_17 and arg_115_1.time_ < var_118_7 + var_118_17 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
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

		arg_115_1:InitPlayNodeList()
	end,
	Play416142027 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 416142027
		arg_119_1.duration_ = 8.07

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play416142028(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = "SS1606a"

			if arg_119_1.bgs_[var_122_0] == nil then
				local var_122_1 = Object.Instantiate(arg_119_1.paintGo_)

				var_122_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_122_0)
				var_122_1.name = var_122_0
				var_122_1.transform.parent = arg_119_1.stage_.transform
				var_122_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.bgs_[var_122_0] = var_122_1
			end

			local var_122_2 = 1.33333333333333

			if var_122_2 < arg_119_1.time_ and arg_119_1.time_ <= var_122_2 + arg_122_0 then
				local var_122_3 = manager.ui.mainCamera.transform.localPosition
				local var_122_4 = Vector3.New(0, 0, 10) + Vector3.New(var_122_3.x, var_122_3.y, 0)
				local var_122_5 = arg_119_1.bgs_.SS1606a

				var_122_5.transform.localPosition = var_122_4
				var_122_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_122_6 = var_122_5:GetComponent("SpriteRenderer")

				if var_122_6 and var_122_6.sprite then
					local var_122_7 = (var_122_5.transform.localPosition - var_122_3).z
					local var_122_8 = manager.ui.mainCameraCom_
					local var_122_9 = 2 * var_122_7 * Mathf.Tan(var_122_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_122_10 = var_122_9 * var_122_8.aspect
					local var_122_11 = var_122_6.sprite.bounds.size.x
					local var_122_12 = var_122_6.sprite.bounds.size.y
					local var_122_13 = var_122_10 / var_122_11
					local var_122_14 = var_122_9 / var_122_12
					local var_122_15 = var_122_14 < var_122_13 and var_122_13 or var_122_14

					var_122_5.transform.localScale = Vector3.New(var_122_15, var_122_15, 0)
				end

				for iter_122_0, iter_122_1 in pairs(arg_119_1.bgs_) do
					if iter_122_0 ~= "SS1606a" then
						iter_122_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_122_16 = 0

			if var_122_16 < arg_119_1.time_ and arg_119_1.time_ <= var_122_16 + arg_122_0 then
				arg_119_1.allBtn_.enabled = false
			end

			local var_122_17 = 0.3

			if arg_119_1.time_ >= var_122_16 + var_122_17 and arg_119_1.time_ < var_122_16 + var_122_17 + arg_122_0 then
				arg_119_1.allBtn_.enabled = true
			end

			local var_122_18 = 0

			if var_122_18 < arg_119_1.time_ and arg_119_1.time_ <= var_122_18 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_19 = 1.33333333333333

			if var_122_18 <= arg_119_1.time_ and arg_119_1.time_ < var_122_18 + var_122_19 then
				local var_122_20 = (arg_119_1.time_ - var_122_18) / var_122_19
				local var_122_21 = Color.New(1, 1, 1)

				var_122_21.a = Mathf.Lerp(0, 1, var_122_20)
				arg_119_1.mask_.color = var_122_21
			end

			if arg_119_1.time_ >= var_122_18 + var_122_19 and arg_119_1.time_ < var_122_18 + var_122_19 + arg_122_0 then
				local var_122_22 = Color.New(1, 1, 1)

				var_122_22.a = 1
				arg_119_1.mask_.color = var_122_22
			end

			local var_122_23 = 1.33333333333333

			if var_122_23 < arg_119_1.time_ and arg_119_1.time_ <= var_122_23 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_24 = 1.16666666666667

			if var_122_23 <= arg_119_1.time_ and arg_119_1.time_ < var_122_23 + var_122_24 then
				local var_122_25 = (arg_119_1.time_ - var_122_23) / var_122_24
				local var_122_26 = Color.New(1, 1, 1)

				var_122_26.a = Mathf.Lerp(1, 0, var_122_25)
				arg_119_1.mask_.color = var_122_26
			end

			if arg_119_1.time_ >= var_122_23 + var_122_24 and arg_119_1.time_ < var_122_23 + var_122_24 + arg_122_0 then
				local var_122_27 = Color.New(1, 1, 1)
				local var_122_28 = 0

				arg_119_1.mask_.enabled = false
				var_122_27.a = var_122_28
				arg_119_1.mask_.color = var_122_27
			end

			local var_122_29 = arg_119_1.actors_["1028"].transform
			local var_122_30 = 1.3

			if var_122_30 < arg_119_1.time_ and arg_119_1.time_ <= var_122_30 + arg_122_0 then
				arg_119_1.var_.moveOldPos1028 = var_122_29.localPosition
				var_122_29.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("1028", 7)

				local var_122_31 = var_122_29.childCount

				for iter_122_2 = 0, var_122_31 - 1 do
					local var_122_32 = var_122_29:GetChild(iter_122_2)

					if var_122_32.name == "" or not string.find(var_122_32.name, "split") then
						var_122_32.gameObject:SetActive(true)
					else
						var_122_32.gameObject:SetActive(false)
					end
				end
			end

			local var_122_33 = 0.001

			if var_122_30 <= arg_119_1.time_ and arg_119_1.time_ < var_122_30 + var_122_33 then
				local var_122_34 = (arg_119_1.time_ - var_122_30) / var_122_33
				local var_122_35 = Vector3.New(0, -2000, 0)

				var_122_29.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1028, var_122_35, var_122_34)
			end

			if arg_119_1.time_ >= var_122_30 + var_122_33 and arg_119_1.time_ < var_122_30 + var_122_33 + arg_122_0 then
				var_122_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_122_36 = arg_119_1.actors_["1086"].transform
			local var_122_37 = 1.3

			if var_122_37 < arg_119_1.time_ and arg_119_1.time_ <= var_122_37 + arg_122_0 then
				arg_119_1.var_.moveOldPos1086 = var_122_36.localPosition
				var_122_36.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("1086", 7)

				local var_122_38 = var_122_36.childCount

				for iter_122_3 = 0, var_122_38 - 1 do
					local var_122_39 = var_122_36:GetChild(iter_122_3)

					if var_122_39.name == "" or not string.find(var_122_39.name, "split") then
						var_122_39.gameObject:SetActive(true)
					else
						var_122_39.gameObject:SetActive(false)
					end
				end
			end

			local var_122_40 = 0.001

			if var_122_37 <= arg_119_1.time_ and arg_119_1.time_ < var_122_37 + var_122_40 then
				local var_122_41 = (arg_119_1.time_ - var_122_37) / var_122_40
				local var_122_42 = Vector3.New(0, -2000, 0)

				var_122_36.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1086, var_122_42, var_122_41)
			end

			if arg_119_1.time_ >= var_122_37 + var_122_40 and arg_119_1.time_ < var_122_37 + var_122_40 + arg_122_0 then
				var_122_36.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_122_43 = manager.ui.mainCamera.transform
			local var_122_44 = 1.334

			if var_122_44 < arg_119_1.time_ and arg_119_1.time_ <= var_122_44 + arg_122_0 then
				local var_122_45 = arg_119_1.var_.effect119
				local var_122_46
				local var_122_47 = var_122_43

				if not var_122_45 then
					var_122_45 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), var_122_47)
					var_122_45.name = "119"
					arg_119_1.var_.effect119 = var_122_45
				else
					var_122_45.transform:SetParent(var_122_47)
				end

				var_122_45.transform.localPosition = Vector3.New(0, 0, 0)
				var_122_45.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_122_48 = manager.ui.mainCameraCom_
				local var_122_49 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_122_48.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_122_50 = var_122_45.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_122_51 = 15
				local var_122_52 = 2 * var_122_51 * Mathf.Tan(var_122_48.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_122_48.aspect
				local var_122_53 = 1
				local var_122_54 = 1.7777777777777777

				if var_122_54 < var_122_48.aspect then
					var_122_53 = var_122_52 / (2 * var_122_51 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_122_54)
				end

				for iter_122_4, iter_122_5 in ipairs(var_122_50) do
					local var_122_55 = iter_122_5.transform.localScale

					iter_122_5.transform.localScale = Vector3.New(var_122_55.x / var_122_49 * var_122_53, var_122_55.y / var_122_49, var_122_55.z)
				end
			end

			local var_122_56 = 1.334
			local var_122_57 = 1

			if var_122_56 < arg_119_1.time_ and arg_119_1.time_ <= var_122_56 + arg_122_0 then
				local var_122_58 = "play"
				local var_122_59 = "effect"

				arg_119_1:AudioAction(var_122_58, var_122_59, "se_story_16", "se_story_16_thunder02", "")
			end

			if arg_119_1.frameCnt_ <= 1 then
				arg_119_1.dialog_:SetActive(false)
			end

			local var_122_60 = 3.06666666666667
			local var_122_61 = 1.025

			if var_122_60 < arg_119_1.time_ and arg_119_1.time_ <= var_122_60 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0

				arg_119_1.dialog_:SetActive(true)

				arg_119_1.dialogCg_.alpha = 0

				local var_122_62 = LeanTween.value(arg_119_1.dialog_, 0, 1, 0.3)

				var_122_62:setOnUpdate(LuaHelper.FloatAction(function(arg_123_0)
					arg_119_1.dialogCg_.alpha = arg_123_0
				end))
				var_122_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_119_1.dialog_)
					var_122_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_119_1.duration_ = arg_119_1.duration_ + 0.3

				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_63 = arg_119_1:GetWordFromCfg(416142027)
				local var_122_64 = arg_119_1:FormatText(var_122_63.content)

				arg_119_1.text_.text = var_122_64

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_65 = 41
				local var_122_66 = utf8.len(var_122_64)
				local var_122_67 = var_122_65 <= 0 and var_122_61 or var_122_61 * (var_122_66 / var_122_65)

				if var_122_67 > 0 and var_122_61 < var_122_67 then
					arg_119_1.talkMaxDuration = var_122_67
					var_122_60 = var_122_60 + 0.3

					if var_122_67 + var_122_60 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_67 + var_122_60
					end
				end

				arg_119_1.text_.text = var_122_64
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_68 = var_122_60 + 0.3
			local var_122_69 = math.max(var_122_61, arg_119_1.talkMaxDuration)

			if var_122_68 <= arg_119_1.time_ and arg_119_1.time_ < var_122_68 + var_122_69 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_68) / var_122_69

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_68 + var_122_69 and arg_119_1.time_ < var_122_68 + var_122_69 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play416142028 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 416142028
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play416142029(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 1.4

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_2 = arg_125_1:GetWordFromCfg(416142028)
				local var_128_3 = arg_125_1:FormatText(var_128_2.content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 56
				local var_128_5 = utf8.len(var_128_3)
				local var_128_6 = var_128_4 <= 0 and var_128_1 or var_128_1 * (var_128_5 / var_128_4)

				if var_128_6 > 0 and var_128_1 < var_128_6 then
					arg_125_1.talkMaxDuration = var_128_6

					if var_128_6 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_6 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_7 and arg_125_1.time_ < var_128_0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play416142029 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 416142029
		arg_129_1.duration_ = 5.03

		local var_129_0 = {
			zh = 4.6,
			ja = 5.033
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
				arg_129_0:Play416142030(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.525

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[8].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10122_split_3")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:GetWordFromCfg(416142029)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 21
				local var_132_6 = utf8.len(var_132_4)
				local var_132_7 = var_132_5 <= 0 and var_132_1 or var_132_1 * (var_132_6 / var_132_5)

				if var_132_7 > 0 and var_132_1 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142029", "story_v_out_416142.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_416142", "416142029", "story_v_out_416142.awb") / 1000

					if var_132_8 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_0
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_416142", "416142029", "story_v_out_416142.awb")

						arg_129_1:RecordAudio("416142029", var_132_9)
						arg_129_1:RecordAudio("416142029", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_416142", "416142029", "story_v_out_416142.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_416142", "416142029", "story_v_out_416142.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_10 and arg_129_1.time_ < var_132_0 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play416142030 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 416142030
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play416142031(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 1.3

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_2 = arg_133_1:GetWordFromCfg(416142030)
				local var_136_3 = arg_133_1:FormatText(var_136_2.content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 52
				local var_136_5 = utf8.len(var_136_3)
				local var_136_6 = var_136_4 <= 0 and var_136_1 or var_136_1 * (var_136_5 / var_136_4)

				if var_136_6 > 0 and var_136_1 < var_136_6 then
					arg_133_1.talkMaxDuration = var_136_6

					if var_136_6 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_7 and arg_133_1.time_ < var_136_0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play416142031 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 416142031
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play416142032(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 1.35

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_2 = arg_137_1:GetWordFromCfg(416142031)
				local var_140_3 = arg_137_1:FormatText(var_140_2.content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 54
				local var_140_5 = utf8.len(var_140_3)
				local var_140_6 = var_140_4 <= 0 and var_140_1 or var_140_1 * (var_140_5 / var_140_4)

				if var_140_6 > 0 and var_140_1 < var_140_6 then
					arg_137_1.talkMaxDuration = var_140_6

					if var_140_6 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_7 and arg_137_1.time_ < var_140_0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play416142032 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 416142032
		arg_141_1.duration_ = 8.27

		local var_141_0 = {
			zh = 4.866,
			ja = 8.266
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
				arg_141_0:Play416142033(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 0.8

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_2 = arg_141_1:FormatText(StoryNameCfg[236].name)

				arg_141_1.leftNameTxt_.text = var_144_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_6")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_3 = arg_141_1:GetWordFromCfg(416142032)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 32
				local var_144_6 = utf8.len(var_144_4)
				local var_144_7 = var_144_5 <= 0 and var_144_1 or var_144_1 * (var_144_6 / var_144_5)

				if var_144_7 > 0 and var_144_1 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_4
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142032", "story_v_out_416142.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_416142", "416142032", "story_v_out_416142.awb") / 1000

					if var_144_8 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_0
					end

					if var_144_3.prefab_name ~= "" and arg_141_1.actors_[var_144_3.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_3.prefab_name].transform, "story_v_out_416142", "416142032", "story_v_out_416142.awb")

						arg_141_1:RecordAudio("416142032", var_144_9)
						arg_141_1:RecordAudio("416142032", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_416142", "416142032", "story_v_out_416142.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_416142", "416142032", "story_v_out_416142.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_10 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_10 and arg_141_1.time_ < var_144_0 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play416142033 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 416142033
		arg_145_1.duration_ = 4.43

		local var_145_0 = {
			zh = 2.9,
			ja = 4.433
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play416142034(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.35

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[8].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10122_split_3")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_3 = arg_145_1:GetWordFromCfg(416142033)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 14
				local var_148_6 = utf8.len(var_148_4)
				local var_148_7 = var_148_5 <= 0 and var_148_1 or var_148_1 * (var_148_6 / var_148_5)

				if var_148_7 > 0 and var_148_1 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_4
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142033", "story_v_out_416142.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_416142", "416142033", "story_v_out_416142.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_416142", "416142033", "story_v_out_416142.awb")

						arg_145_1:RecordAudio("416142033", var_148_9)
						arg_145_1:RecordAudio("416142033", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_416142", "416142033", "story_v_out_416142.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_416142", "416142033", "story_v_out_416142.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_10 and arg_145_1.time_ < var_148_0 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play416142034 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 416142034
		arg_149_1.duration_ = 6.53

		local var_149_0 = {
			zh = 5.633,
			ja = 6.533
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play416142035(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.825

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[236].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_6")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_3 = arg_149_1:GetWordFromCfg(416142034)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 33
				local var_152_6 = utf8.len(var_152_4)
				local var_152_7 = var_152_5 <= 0 and var_152_1 or var_152_1 * (var_152_6 / var_152_5)

				if var_152_7 > 0 and var_152_1 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142034", "story_v_out_416142.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_416142", "416142034", "story_v_out_416142.awb") / 1000

					if var_152_8 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_0
					end

					if var_152_3.prefab_name ~= "" and arg_149_1.actors_[var_152_3.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_3.prefab_name].transform, "story_v_out_416142", "416142034", "story_v_out_416142.awb")

						arg_149_1:RecordAudio("416142034", var_152_9)
						arg_149_1:RecordAudio("416142034", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_416142", "416142034", "story_v_out_416142.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_416142", "416142034", "story_v_out_416142.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_10 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_10

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_10 and arg_149_1.time_ < var_152_0 + var_152_10 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play416142035 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 416142035
		arg_153_1.duration_ = 7.37

		local var_153_0 = {
			zh = 4.4,
			ja = 7.366
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play416142036(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.65

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[236].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_6")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:GetWordFromCfg(416142035)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 26
				local var_156_6 = utf8.len(var_156_4)
				local var_156_7 = var_156_5 <= 0 and var_156_1 or var_156_1 * (var_156_6 / var_156_5)

				if var_156_7 > 0 and var_156_1 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142035", "story_v_out_416142.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_416142", "416142035", "story_v_out_416142.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_416142", "416142035", "story_v_out_416142.awb")

						arg_153_1:RecordAudio("416142035", var_156_9)
						arg_153_1:RecordAudio("416142035", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_416142", "416142035", "story_v_out_416142.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_416142", "416142035", "story_v_out_416142.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_10 and arg_153_1.time_ < var_156_0 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play416142036 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 416142036
		arg_157_1.duration_ = 6.37

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play416142037(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_1 = 0.866666666666667

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_1 then
				local var_160_2 = (arg_157_1.time_ - var_160_0) / var_160_1
				local var_160_3 = Color.New(1, 1, 1)

				var_160_3.a = Mathf.Lerp(1, 0, var_160_2)
				arg_157_1.mask_.color = var_160_3
			end

			if arg_157_1.time_ >= var_160_0 + var_160_1 and arg_157_1.time_ < var_160_0 + var_160_1 + arg_160_0 then
				local var_160_4 = Color.New(1, 1, 1)
				local var_160_5 = 0

				arg_157_1.mask_.enabled = false
				var_160_4.a = var_160_5
				arg_157_1.mask_.color = var_160_4
			end

			local var_160_6 = arg_157_1.bgs_.SS1606a.transform
			local var_160_7 = 0

			if var_160_7 < arg_157_1.time_ and arg_157_1.time_ <= var_160_7 + arg_160_0 then
				arg_157_1.var_.moveOldPosSS1606a = var_160_6.localPosition
			end

			local var_160_8 = 0.001

			if var_160_7 <= arg_157_1.time_ and arg_157_1.time_ < var_160_7 + var_160_8 then
				local var_160_9 = (arg_157_1.time_ - var_160_7) / var_160_8
				local var_160_10 = Vector3.New(0, 1, 10)

				var_160_6.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPosSS1606a, var_160_10, var_160_9)
			end

			if arg_157_1.time_ >= var_160_7 + var_160_8 and arg_157_1.time_ < var_160_7 + var_160_8 + arg_160_0 then
				var_160_6.localPosition = Vector3.New(0, 1, 10)
			end

			local var_160_11 = arg_157_1.bgs_.SS1606a.transform
			local var_160_12 = 0.034

			if var_160_12 < arg_157_1.time_ and arg_157_1.time_ <= var_160_12 + arg_160_0 then
				arg_157_1.var_.moveOldPosSS1606a = var_160_11.localPosition
			end

			local var_160_13 = 2.39933333333333

			if var_160_12 <= arg_157_1.time_ and arg_157_1.time_ < var_160_12 + var_160_13 then
				local var_160_14 = (arg_157_1.time_ - var_160_12) / var_160_13
				local var_160_15 = Vector3.New(0, 1, 9)

				var_160_11.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPosSS1606a, var_160_15, var_160_14)
			end

			if arg_157_1.time_ >= var_160_12 + var_160_13 and arg_157_1.time_ < var_160_12 + var_160_13 + arg_160_0 then
				var_160_11.localPosition = Vector3.New(0, 1, 9)
			end

			local var_160_16 = 0

			if var_160_16 < arg_157_1.time_ and arg_157_1.time_ <= var_160_16 + arg_160_0 then
				arg_157_1.allBtn_.enabled = false
			end

			local var_160_17 = 2.23333333333333

			if arg_157_1.time_ >= var_160_16 + var_160_17 and arg_157_1.time_ < var_160_16 + var_160_17 + arg_160_0 then
				arg_157_1.allBtn_.enabled = true
			end

			local var_160_18 = 0.266666666666667
			local var_160_19 = 1

			if var_160_18 < arg_157_1.time_ and arg_157_1.time_ <= var_160_18 + arg_160_0 then
				local var_160_20 = "play"
				local var_160_21 = "effect"

				arg_157_1:AudioAction(var_160_20, var_160_21, "se_story_side_1028", "se_story_1028_leiguang", "")
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_22 = 1.36666666666667
			local var_160_23 = 1.775

			if var_160_22 < arg_157_1.time_ and arg_157_1.time_ <= var_160_22 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				arg_157_1.dialog_:SetActive(true)

				arg_157_1.dialogCg_.alpha = 0

				local var_160_24 = LeanTween.value(arg_157_1.dialog_, 0, 1, 0.3)

				var_160_24:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_157_1.dialogCg_.alpha = arg_161_0
				end))
				var_160_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_157_1.dialog_)
					var_160_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_157_1.duration_ = arg_157_1.duration_ + 0.3

				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_25 = arg_157_1:GetWordFromCfg(416142036)
				local var_160_26 = arg_157_1:FormatText(var_160_25.content)

				arg_157_1.text_.text = var_160_26

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_27 = 71
				local var_160_28 = utf8.len(var_160_26)
				local var_160_29 = var_160_27 <= 0 and var_160_23 or var_160_23 * (var_160_28 / var_160_27)

				if var_160_29 > 0 and var_160_23 < var_160_29 then
					arg_157_1.talkMaxDuration = var_160_29
					var_160_22 = var_160_22 + 0.3

					if var_160_29 + var_160_22 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_29 + var_160_22
					end
				end

				arg_157_1.text_.text = var_160_26
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_30 = var_160_22 + 0.3
			local var_160_31 = math.max(var_160_23, arg_157_1.talkMaxDuration)

			if var_160_30 <= arg_157_1.time_ and arg_157_1.time_ < var_160_30 + var_160_31 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_30) / var_160_31

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_30 + var_160_31 and arg_157_1.time_ < var_160_30 + var_160_31 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1606a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1606a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.39933333333333,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play416142037 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 416142037
		arg_163_1.duration_ = 8.03

		local var_163_0 = {
			zh = 8.03333333333333,
			ja = 7.06633333333333
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play416142038(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = "I13f"

			if arg_163_1.bgs_[var_166_0] == nil then
				local var_166_1 = Object.Instantiate(arg_163_1.paintGo_)

				var_166_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_166_0)
				var_166_1.name = var_166_0
				var_166_1.transform.parent = arg_163_1.stage_.transform
				var_166_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.bgs_[var_166_0] = var_166_1
			end

			local var_166_2 = 1.33333333333333

			if var_166_2 < arg_163_1.time_ and arg_163_1.time_ <= var_166_2 + arg_166_0 then
				local var_166_3 = manager.ui.mainCamera.transform.localPosition
				local var_166_4 = Vector3.New(0, 0, 10) + Vector3.New(var_166_3.x, var_166_3.y, 0)
				local var_166_5 = arg_163_1.bgs_.I13f

				var_166_5.transform.localPosition = var_166_4
				var_166_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_166_6 = var_166_5:GetComponent("SpriteRenderer")

				if var_166_6 and var_166_6.sprite then
					local var_166_7 = (var_166_5.transform.localPosition - var_166_3).z
					local var_166_8 = manager.ui.mainCameraCom_
					local var_166_9 = 2 * var_166_7 * Mathf.Tan(var_166_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_166_10 = var_166_9 * var_166_8.aspect
					local var_166_11 = var_166_6.sprite.bounds.size.x
					local var_166_12 = var_166_6.sprite.bounds.size.y
					local var_166_13 = var_166_10 / var_166_11
					local var_166_14 = var_166_9 / var_166_12
					local var_166_15 = var_166_14 < var_166_13 and var_166_13 or var_166_14

					var_166_5.transform.localScale = Vector3.New(var_166_15, var_166_15, 0)
				end

				for iter_166_0, iter_166_1 in pairs(arg_163_1.bgs_) do
					if iter_166_0 ~= "I13f" then
						iter_166_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_166_16 = 0

			if var_166_16 < arg_163_1.time_ and arg_163_1.time_ <= var_166_16 + arg_166_0 then
				arg_163_1.allBtn_.enabled = false
			end

			local var_166_17 = 0.3

			if arg_163_1.time_ >= var_166_16 + var_166_17 and arg_163_1.time_ < var_166_16 + var_166_17 + arg_166_0 then
				arg_163_1.allBtn_.enabled = true
			end

			local var_166_18 = 0

			if var_166_18 < arg_163_1.time_ and arg_163_1.time_ <= var_166_18 + arg_166_0 then
				arg_163_1.mask_.enabled = true
				arg_163_1.mask_.raycastTarget = true

				arg_163_1:SetGaussion(false)
			end

			local var_166_19 = 1.33333333333333

			if var_166_18 <= arg_163_1.time_ and arg_163_1.time_ < var_166_18 + var_166_19 then
				local var_166_20 = (arg_163_1.time_ - var_166_18) / var_166_19
				local var_166_21 = Color.New(0, 0, 0)

				var_166_21.a = Mathf.Lerp(0, 1, var_166_20)
				arg_163_1.mask_.color = var_166_21
			end

			if arg_163_1.time_ >= var_166_18 + var_166_19 and arg_163_1.time_ < var_166_18 + var_166_19 + arg_166_0 then
				local var_166_22 = Color.New(0, 0, 0)

				var_166_22.a = 1
				arg_163_1.mask_.color = var_166_22
			end

			local var_166_23 = 1.33333333333333

			if var_166_23 < arg_163_1.time_ and arg_163_1.time_ <= var_166_23 + arg_166_0 then
				arg_163_1.mask_.enabled = true
				arg_163_1.mask_.raycastTarget = true

				arg_163_1:SetGaussion(false)
			end

			local var_166_24 = 2

			if var_166_23 <= arg_163_1.time_ and arg_163_1.time_ < var_166_23 + var_166_24 then
				local var_166_25 = (arg_163_1.time_ - var_166_23) / var_166_24
				local var_166_26 = Color.New(0, 0, 0)

				var_166_26.a = Mathf.Lerp(1, 0, var_166_25)
				arg_163_1.mask_.color = var_166_26
			end

			if arg_163_1.time_ >= var_166_23 + var_166_24 and arg_163_1.time_ < var_166_23 + var_166_24 + arg_166_0 then
				local var_166_27 = Color.New(0, 0, 0)
				local var_166_28 = 0

				arg_163_1.mask_.enabled = false
				var_166_27.a = var_166_28
				arg_163_1.mask_.color = var_166_27
			end

			local var_166_29 = "10122"

			if arg_163_1.actors_[var_166_29] == nil then
				local var_166_30 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10122")

				if not isNil(var_166_30) then
					local var_166_31 = Object.Instantiate(var_166_30, arg_163_1.canvasGo_.transform)

					var_166_31.transform:SetSiblingIndex(1)

					var_166_31.name = var_166_29
					var_166_31.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_163_1.actors_[var_166_29] = var_166_31

					local var_166_32 = var_166_31:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_163_1.isInRecall_ then
						for iter_166_2, iter_166_3 in ipairs(var_166_32) do
							iter_166_3.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_166_33 = arg_163_1.actors_["10122"]
			local var_166_34 = 3

			if var_166_34 < arg_163_1.time_ and arg_163_1.time_ <= var_166_34 + arg_166_0 and not isNil(var_166_33) and arg_163_1.var_.actorSpriteComps10122 == nil then
				arg_163_1.var_.actorSpriteComps10122 = var_166_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_35 = 0.2

			if var_166_34 <= arg_163_1.time_ and arg_163_1.time_ < var_166_34 + var_166_35 and not isNil(var_166_33) then
				local var_166_36 = (arg_163_1.time_ - var_166_34) / var_166_35

				if arg_163_1.var_.actorSpriteComps10122 then
					for iter_166_4, iter_166_5 in pairs(arg_163_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_166_5 then
							if arg_163_1.isInRecall_ then
								local var_166_37 = Mathf.Lerp(iter_166_5.color.r, arg_163_1.hightColor1.r, var_166_36)
								local var_166_38 = Mathf.Lerp(iter_166_5.color.g, arg_163_1.hightColor1.g, var_166_36)
								local var_166_39 = Mathf.Lerp(iter_166_5.color.b, arg_163_1.hightColor1.b, var_166_36)

								iter_166_5.color = Color.New(var_166_37, var_166_38, var_166_39)
							else
								local var_166_40 = Mathf.Lerp(iter_166_5.color.r, 1, var_166_36)

								iter_166_5.color = Color.New(var_166_40, var_166_40, var_166_40)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_34 + var_166_35 and arg_163_1.time_ < var_166_34 + var_166_35 + arg_166_0 and not isNil(var_166_33) and arg_163_1.var_.actorSpriteComps10122 then
				for iter_166_6, iter_166_7 in pairs(arg_163_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_166_7 then
						if arg_163_1.isInRecall_ then
							iter_166_7.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_166_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps10122 = nil
			end

			local var_166_41 = arg_163_1.actors_["10122"].transform
			local var_166_42 = 3

			if var_166_42 < arg_163_1.time_ and arg_163_1.time_ <= var_166_42 + arg_166_0 then
				arg_163_1.var_.moveOldPos10122 = var_166_41.localPosition
				var_166_41.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10122", 2)

				local var_166_43 = var_166_41.childCount

				for iter_166_8 = 0, var_166_43 - 1 do
					local var_166_44 = var_166_41:GetChild(iter_166_8)

					if var_166_44.name == "split_5" or not string.find(var_166_44.name, "split") then
						var_166_44.gameObject:SetActive(true)
					else
						var_166_44.gameObject:SetActive(false)
					end
				end
			end

			local var_166_45 = 0.001

			if var_166_42 <= arg_163_1.time_ and arg_163_1.time_ < var_166_42 + var_166_45 then
				local var_166_46 = (arg_163_1.time_ - var_166_42) / var_166_45
				local var_166_47 = Vector3.New(-390, -380, -100)

				var_166_41.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10122, var_166_47, var_166_46)
			end

			if arg_163_1.time_ >= var_166_42 + var_166_45 and arg_163_1.time_ < var_166_42 + var_166_45 + arg_166_0 then
				var_166_41.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_166_48 = arg_163_1.actors_["10122"]
			local var_166_49 = 3

			if var_166_49 < arg_163_1.time_ and arg_163_1.time_ <= var_166_49 + arg_166_0 then
				local var_166_50 = var_166_48:GetComponentInChildren(typeof(CanvasGroup))

				if var_166_50 then
					arg_163_1.var_.alphaOldValue10122 = var_166_50.alpha
					arg_163_1.var_.characterEffect10122 = var_166_50
				end

				arg_163_1.var_.alphaOldValue10122 = 0
			end

			local var_166_51 = 0.2

			if var_166_49 <= arg_163_1.time_ and arg_163_1.time_ < var_166_49 + var_166_51 then
				local var_166_52 = (arg_163_1.time_ - var_166_49) / var_166_51
				local var_166_53 = Mathf.Lerp(arg_163_1.var_.alphaOldValue10122, 1, var_166_52)

				if arg_163_1.var_.characterEffect10122 then
					arg_163_1.var_.characterEffect10122.alpha = var_166_53
				end
			end

			if arg_163_1.time_ >= var_166_49 + var_166_51 and arg_163_1.time_ < var_166_49 + var_166_51 + arg_166_0 and arg_163_1.var_.characterEffect10122 then
				arg_163_1.var_.characterEffect10122.alpha = 1
			end

			local var_166_54 = manager.ui.mainCamera.transform
			local var_166_55 = 1.334

			if var_166_55 < arg_163_1.time_ and arg_163_1.time_ <= var_166_55 + arg_166_0 then
				local var_166_56 = arg_163_1.var_.effect119

				if var_166_56 then
					Object.Destroy(var_166_56)

					arg_163_1.var_.effect119 = nil
				end
			end

			if arg_163_1.frameCnt_ <= 1 then
				arg_163_1.dialog_:SetActive(false)
			end

			local var_166_57 = 3.33333333333333
			local var_166_58 = 0.5

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

				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_60 = arg_163_1:FormatText(StoryNameCfg[8].name)

				arg_163_1.leftNameTxt_.text = var_166_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_61 = arg_163_1:GetWordFromCfg(416142037)
				local var_166_62 = arg_163_1:FormatText(var_166_61.content)

				arg_163_1.text_.text = var_166_62

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_63 = 20
				local var_166_64 = utf8.len(var_166_62)
				local var_166_65 = var_166_63 <= 0 and var_166_58 or var_166_58 * (var_166_64 / var_166_63)

				if var_166_65 > 0 and var_166_58 < var_166_65 then
					arg_163_1.talkMaxDuration = var_166_65
					var_166_57 = var_166_57 + 0.3

					if var_166_65 + var_166_57 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_65 + var_166_57
					end
				end

				arg_163_1.text_.text = var_166_62
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142037", "story_v_out_416142.awb") ~= 0 then
					local var_166_66 = manager.audio:GetVoiceLength("story_v_out_416142", "416142037", "story_v_out_416142.awb") / 1000

					if var_166_66 + var_166_57 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_66 + var_166_57
					end

					if var_166_61.prefab_name ~= "" and arg_163_1.actors_[var_166_61.prefab_name] ~= nil then
						local var_166_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_61.prefab_name].transform, "story_v_out_416142", "416142037", "story_v_out_416142.awb")

						arg_163_1:RecordAudio("416142037", var_166_67)
						arg_163_1:RecordAudio("416142037", var_166_67)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_416142", "416142037", "story_v_out_416142.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_416142", "416142037", "story_v_out_416142.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_68 = var_166_57 + 0.3
			local var_166_69 = math.max(var_166_58, arg_163_1.talkMaxDuration)

			if var_166_68 <= arg_163_1.time_ and arg_163_1.time_ < var_166_68 + var_166_69 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_68) / var_166_69

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_68 + var_166_69 and arg_163_1.time_ < var_166_68 + var_166_69 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play416142038 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 416142038
		arg_169_1.duration_ = 5.9

		local var_169_0 = {
			zh = 4.233,
			ja = 5.9
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play416142039(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = "10127"

			if arg_169_1.actors_[var_172_0] == nil then
				local var_172_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10127")

				if not isNil(var_172_1) then
					local var_172_2 = Object.Instantiate(var_172_1, arg_169_1.canvasGo_.transform)

					var_172_2.transform:SetSiblingIndex(1)

					var_172_2.name = var_172_0
					var_172_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_169_1.actors_[var_172_0] = var_172_2

					local var_172_3 = var_172_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_169_1.isInRecall_ then
						for iter_172_0, iter_172_1 in ipairs(var_172_3) do
							iter_172_1.color = arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_172_4 = arg_169_1.actors_["10127"]
			local var_172_5 = 0

			if var_172_5 < arg_169_1.time_ and arg_169_1.time_ <= var_172_5 + arg_172_0 and not isNil(var_172_4) and arg_169_1.var_.actorSpriteComps10127 == nil then
				arg_169_1.var_.actorSpriteComps10127 = var_172_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_6 = 0.2

			if var_172_5 <= arg_169_1.time_ and arg_169_1.time_ < var_172_5 + var_172_6 and not isNil(var_172_4) then
				local var_172_7 = (arg_169_1.time_ - var_172_5) / var_172_6

				if arg_169_1.var_.actorSpriteComps10127 then
					for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_172_3 then
							if arg_169_1.isInRecall_ then
								local var_172_8 = Mathf.Lerp(iter_172_3.color.r, arg_169_1.hightColor1.r, var_172_7)
								local var_172_9 = Mathf.Lerp(iter_172_3.color.g, arg_169_1.hightColor1.g, var_172_7)
								local var_172_10 = Mathf.Lerp(iter_172_3.color.b, arg_169_1.hightColor1.b, var_172_7)

								iter_172_3.color = Color.New(var_172_8, var_172_9, var_172_10)
							else
								local var_172_11 = Mathf.Lerp(iter_172_3.color.r, 1, var_172_7)

								iter_172_3.color = Color.New(var_172_11, var_172_11, var_172_11)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_5 + var_172_6 and arg_169_1.time_ < var_172_5 + var_172_6 + arg_172_0 and not isNil(var_172_4) and arg_169_1.var_.actorSpriteComps10127 then
				for iter_172_4, iter_172_5 in pairs(arg_169_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_172_5 then
						if arg_169_1.isInRecall_ then
							iter_172_5.color = arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_172_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps10127 = nil
			end

			local var_172_12 = arg_169_1.actors_["10122"]
			local var_172_13 = 0

			if var_172_13 < arg_169_1.time_ and arg_169_1.time_ <= var_172_13 + arg_172_0 and not isNil(var_172_12) and arg_169_1.var_.actorSpriteComps10122 == nil then
				arg_169_1.var_.actorSpriteComps10122 = var_172_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_14 = 0.2

			if var_172_13 <= arg_169_1.time_ and arg_169_1.time_ < var_172_13 + var_172_14 and not isNil(var_172_12) then
				local var_172_15 = (arg_169_1.time_ - var_172_13) / var_172_14

				if arg_169_1.var_.actorSpriteComps10122 then
					for iter_172_6, iter_172_7 in pairs(arg_169_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_172_7 then
							if arg_169_1.isInRecall_ then
								local var_172_16 = Mathf.Lerp(iter_172_7.color.r, arg_169_1.hightColor2.r, var_172_15)
								local var_172_17 = Mathf.Lerp(iter_172_7.color.g, arg_169_1.hightColor2.g, var_172_15)
								local var_172_18 = Mathf.Lerp(iter_172_7.color.b, arg_169_1.hightColor2.b, var_172_15)

								iter_172_7.color = Color.New(var_172_16, var_172_17, var_172_18)
							else
								local var_172_19 = Mathf.Lerp(iter_172_7.color.r, 0.5, var_172_15)

								iter_172_7.color = Color.New(var_172_19, var_172_19, var_172_19)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_13 + var_172_14 and arg_169_1.time_ < var_172_13 + var_172_14 + arg_172_0 and not isNil(var_172_12) and arg_169_1.var_.actorSpriteComps10122 then
				for iter_172_8, iter_172_9 in pairs(arg_169_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_172_9 then
						if arg_169_1.isInRecall_ then
							iter_172_9.color = arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_172_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps10122 = nil
			end

			local var_172_20 = arg_169_1.actors_["10127"].transform
			local var_172_21 = 0

			if var_172_21 < arg_169_1.time_ and arg_169_1.time_ <= var_172_21 + arg_172_0 then
				arg_169_1.var_.moveOldPos10127 = var_172_20.localPosition
				var_172_20.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10127", 4)

				local var_172_22 = var_172_20.childCount

				for iter_172_10 = 0, var_172_22 - 1 do
					local var_172_23 = var_172_20:GetChild(iter_172_10)

					if var_172_23.name == "split_1" or not string.find(var_172_23.name, "split") then
						var_172_23.gameObject:SetActive(true)
					else
						var_172_23.gameObject:SetActive(false)
					end
				end
			end

			local var_172_24 = 0.001

			if var_172_21 <= arg_169_1.time_ and arg_169_1.time_ < var_172_21 + var_172_24 then
				local var_172_25 = (arg_169_1.time_ - var_172_21) / var_172_24
				local var_172_26 = Vector3.New(345, -387.4, -316.5)

				var_172_20.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10127, var_172_26, var_172_25)
			end

			if arg_169_1.time_ >= var_172_21 + var_172_24 and arg_169_1.time_ < var_172_21 + var_172_24 + arg_172_0 then
				var_172_20.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_172_27 = 0
			local var_172_28 = 0.625

			if var_172_27 < arg_169_1.time_ and arg_169_1.time_ <= var_172_27 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_29 = arg_169_1:FormatText(StoryNameCfg[236].name)

				arg_169_1.leftNameTxt_.text = var_172_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_30 = arg_169_1:GetWordFromCfg(416142038)
				local var_172_31 = arg_169_1:FormatText(var_172_30.content)

				arg_169_1.text_.text = var_172_31

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_32 = 25
				local var_172_33 = utf8.len(var_172_31)
				local var_172_34 = var_172_32 <= 0 and var_172_28 or var_172_28 * (var_172_33 / var_172_32)

				if var_172_34 > 0 and var_172_28 < var_172_34 then
					arg_169_1.talkMaxDuration = var_172_34

					if var_172_34 + var_172_27 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_34 + var_172_27
					end
				end

				arg_169_1.text_.text = var_172_31
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142038", "story_v_out_416142.awb") ~= 0 then
					local var_172_35 = manager.audio:GetVoiceLength("story_v_out_416142", "416142038", "story_v_out_416142.awb") / 1000

					if var_172_35 + var_172_27 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_35 + var_172_27
					end

					if var_172_30.prefab_name ~= "" and arg_169_1.actors_[var_172_30.prefab_name] ~= nil then
						local var_172_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_30.prefab_name].transform, "story_v_out_416142", "416142038", "story_v_out_416142.awb")

						arg_169_1:RecordAudio("416142038", var_172_36)
						arg_169_1:RecordAudio("416142038", var_172_36)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_416142", "416142038", "story_v_out_416142.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_416142", "416142038", "story_v_out_416142.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_37 = math.max(var_172_28, arg_169_1.talkMaxDuration)

			if var_172_27 <= arg_169_1.time_ and arg_169_1.time_ < var_172_27 + var_172_37 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_27) / var_172_37

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_27 + var_172_37 and arg_169_1.time_ < var_172_27 + var_172_37 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play416142039 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 416142039
		arg_173_1.duration_ = 8.17

		local var_173_0 = {
			zh = 4.1,
			ja = 8.166
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play416142040(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 0.6

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_2 = arg_173_1:FormatText(StoryNameCfg[236].name)

				arg_173_1.leftNameTxt_.text = var_176_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_3 = arg_173_1:GetWordFromCfg(416142039)
				local var_176_4 = arg_173_1:FormatText(var_176_3.content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 24
				local var_176_6 = utf8.len(var_176_4)
				local var_176_7 = var_176_5 <= 0 and var_176_1 or var_176_1 * (var_176_6 / var_176_5)

				if var_176_7 > 0 and var_176_1 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_4
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142039", "story_v_out_416142.awb") ~= 0 then
					local var_176_8 = manager.audio:GetVoiceLength("story_v_out_416142", "416142039", "story_v_out_416142.awb") / 1000

					if var_176_8 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_0
					end

					if var_176_3.prefab_name ~= "" and arg_173_1.actors_[var_176_3.prefab_name] ~= nil then
						local var_176_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_3.prefab_name].transform, "story_v_out_416142", "416142039", "story_v_out_416142.awb")

						arg_173_1:RecordAudio("416142039", var_176_9)
						arg_173_1:RecordAudio("416142039", var_176_9)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_416142", "416142039", "story_v_out_416142.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_416142", "416142039", "story_v_out_416142.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_10 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_10 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_10

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_10 and arg_173_1.time_ < var_176_0 + var_176_10 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play416142040 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 416142040
		arg_177_1.duration_ = 1.9

		local var_177_0 = {
			zh = 1.9,
			ja = 1.5
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play416142041(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10122"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps10122 == nil then
				arg_177_1.var_.actorSpriteComps10122 = var_180_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_2 = 0.2

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.actorSpriteComps10122 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								local var_180_4 = Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor1.r, var_180_3)
								local var_180_5 = Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor1.g, var_180_3)
								local var_180_6 = Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor1.b, var_180_3)

								iter_180_1.color = Color.New(var_180_4, var_180_5, var_180_6)
							else
								local var_180_7 = Mathf.Lerp(iter_180_1.color.r, 1, var_180_3)

								iter_180_1.color = Color.New(var_180_7, var_180_7, var_180_7)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps10122 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_180_3 then
						if arg_177_1.isInRecall_ then
							iter_180_3.color = arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_180_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps10122 = nil
			end

			local var_180_8 = arg_177_1.actors_["10127"]
			local var_180_9 = 0

			if var_180_9 < arg_177_1.time_ and arg_177_1.time_ <= var_180_9 + arg_180_0 and not isNil(var_180_8) and arg_177_1.var_.actorSpriteComps10127 == nil then
				arg_177_1.var_.actorSpriteComps10127 = var_180_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_10 = 0.2

			if var_180_9 <= arg_177_1.time_ and arg_177_1.time_ < var_180_9 + var_180_10 and not isNil(var_180_8) then
				local var_180_11 = (arg_177_1.time_ - var_180_9) / var_180_10

				if arg_177_1.var_.actorSpriteComps10127 then
					for iter_180_4, iter_180_5 in pairs(arg_177_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_180_5 then
							if arg_177_1.isInRecall_ then
								local var_180_12 = Mathf.Lerp(iter_180_5.color.r, arg_177_1.hightColor2.r, var_180_11)
								local var_180_13 = Mathf.Lerp(iter_180_5.color.g, arg_177_1.hightColor2.g, var_180_11)
								local var_180_14 = Mathf.Lerp(iter_180_5.color.b, arg_177_1.hightColor2.b, var_180_11)

								iter_180_5.color = Color.New(var_180_12, var_180_13, var_180_14)
							else
								local var_180_15 = Mathf.Lerp(iter_180_5.color.r, 0.5, var_180_11)

								iter_180_5.color = Color.New(var_180_15, var_180_15, var_180_15)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_9 + var_180_10 and arg_177_1.time_ < var_180_9 + var_180_10 + arg_180_0 and not isNil(var_180_8) and arg_177_1.var_.actorSpriteComps10127 then
				for iter_180_6, iter_180_7 in pairs(arg_177_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_180_7 then
						if arg_177_1.isInRecall_ then
							iter_180_7.color = arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_180_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps10127 = nil
			end

			local var_180_16 = arg_177_1.actors_["10122"].transform
			local var_180_17 = 0

			if var_180_17 < arg_177_1.time_ and arg_177_1.time_ <= var_180_17 + arg_180_0 then
				arg_177_1.var_.moveOldPos10122 = var_180_16.localPosition
				var_180_16.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("10122", 2)

				local var_180_18 = var_180_16.childCount

				for iter_180_8 = 0, var_180_18 - 1 do
					local var_180_19 = var_180_16:GetChild(iter_180_8)

					if var_180_19.name == "split_4" or not string.find(var_180_19.name, "split") then
						var_180_19.gameObject:SetActive(true)
					else
						var_180_19.gameObject:SetActive(false)
					end
				end
			end

			local var_180_20 = 0.001

			if var_180_17 <= arg_177_1.time_ and arg_177_1.time_ < var_180_17 + var_180_20 then
				local var_180_21 = (arg_177_1.time_ - var_180_17) / var_180_20
				local var_180_22 = Vector3.New(-390, -380, -100)

				var_180_16.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10122, var_180_22, var_180_21)
			end

			if arg_177_1.time_ >= var_180_17 + var_180_20 and arg_177_1.time_ < var_180_17 + var_180_20 + arg_180_0 then
				var_180_16.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_180_23 = 0
			local var_180_24 = 0.1

			if var_180_23 < arg_177_1.time_ and arg_177_1.time_ <= var_180_23 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_25 = arg_177_1:FormatText(StoryNameCfg[8].name)

				arg_177_1.leftNameTxt_.text = var_180_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_26 = arg_177_1:GetWordFromCfg(416142040)
				local var_180_27 = arg_177_1:FormatText(var_180_26.content)

				arg_177_1.text_.text = var_180_27

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_28 = 4
				local var_180_29 = utf8.len(var_180_27)
				local var_180_30 = var_180_28 <= 0 and var_180_24 or var_180_24 * (var_180_29 / var_180_28)

				if var_180_30 > 0 and var_180_24 < var_180_30 then
					arg_177_1.talkMaxDuration = var_180_30

					if var_180_30 + var_180_23 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_30 + var_180_23
					end
				end

				arg_177_1.text_.text = var_180_27
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142040", "story_v_out_416142.awb") ~= 0 then
					local var_180_31 = manager.audio:GetVoiceLength("story_v_out_416142", "416142040", "story_v_out_416142.awb") / 1000

					if var_180_31 + var_180_23 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_31 + var_180_23
					end

					if var_180_26.prefab_name ~= "" and arg_177_1.actors_[var_180_26.prefab_name] ~= nil then
						local var_180_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_26.prefab_name].transform, "story_v_out_416142", "416142040", "story_v_out_416142.awb")

						arg_177_1:RecordAudio("416142040", var_180_32)
						arg_177_1:RecordAudio("416142040", var_180_32)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_416142", "416142040", "story_v_out_416142.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_416142", "416142040", "story_v_out_416142.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_33 = math.max(var_180_24, arg_177_1.talkMaxDuration)

			if var_180_23 <= arg_177_1.time_ and arg_177_1.time_ < var_180_23 + var_180_33 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_23) / var_180_33

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_23 + var_180_33 and arg_177_1.time_ < var_180_23 + var_180_33 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play416142041 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 416142041
		arg_181_1.duration_ = 5.9

		local var_181_0 = {
			zh = 3.6,
			ja = 5.9
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play416142042(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10127"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps10127 == nil then
				arg_181_1.var_.actorSpriteComps10127 = var_184_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_2 = 0.2

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.actorSpriteComps10127 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								local var_184_4 = Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor1.r, var_184_3)
								local var_184_5 = Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor1.g, var_184_3)
								local var_184_6 = Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor1.b, var_184_3)

								iter_184_1.color = Color.New(var_184_4, var_184_5, var_184_6)
							else
								local var_184_7 = Mathf.Lerp(iter_184_1.color.r, 1, var_184_3)

								iter_184_1.color = Color.New(var_184_7, var_184_7, var_184_7)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps10127 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_184_3 then
						if arg_181_1.isInRecall_ then
							iter_184_3.color = arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_184_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps10127 = nil
			end

			local var_184_8 = arg_181_1.actors_["10122"]
			local var_184_9 = 0

			if var_184_9 < arg_181_1.time_ and arg_181_1.time_ <= var_184_9 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps10122 == nil then
				arg_181_1.var_.actorSpriteComps10122 = var_184_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_10 = 0.2

			if var_184_9 <= arg_181_1.time_ and arg_181_1.time_ < var_184_9 + var_184_10 and not isNil(var_184_8) then
				local var_184_11 = (arg_181_1.time_ - var_184_9) / var_184_10

				if arg_181_1.var_.actorSpriteComps10122 then
					for iter_184_4, iter_184_5 in pairs(arg_181_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_184_5 then
							if arg_181_1.isInRecall_ then
								local var_184_12 = Mathf.Lerp(iter_184_5.color.r, arg_181_1.hightColor2.r, var_184_11)
								local var_184_13 = Mathf.Lerp(iter_184_5.color.g, arg_181_1.hightColor2.g, var_184_11)
								local var_184_14 = Mathf.Lerp(iter_184_5.color.b, arg_181_1.hightColor2.b, var_184_11)

								iter_184_5.color = Color.New(var_184_12, var_184_13, var_184_14)
							else
								local var_184_15 = Mathf.Lerp(iter_184_5.color.r, 0.5, var_184_11)

								iter_184_5.color = Color.New(var_184_15, var_184_15, var_184_15)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_9 + var_184_10 and arg_181_1.time_ < var_184_9 + var_184_10 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps10122 then
				for iter_184_6, iter_184_7 in pairs(arg_181_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_184_7 then
						if arg_181_1.isInRecall_ then
							iter_184_7.color = arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_184_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps10122 = nil
			end

			local var_184_16 = arg_181_1.actors_["10127"].transform
			local var_184_17 = 0

			if var_184_17 < arg_181_1.time_ and arg_181_1.time_ <= var_184_17 + arg_184_0 then
				arg_181_1.var_.moveOldPos10127 = var_184_16.localPosition
				var_184_16.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10127", 4)

				local var_184_18 = var_184_16.childCount

				for iter_184_8 = 0, var_184_18 - 1 do
					local var_184_19 = var_184_16:GetChild(iter_184_8)

					if var_184_19.name == "split_1" or not string.find(var_184_19.name, "split") then
						var_184_19.gameObject:SetActive(true)
					else
						var_184_19.gameObject:SetActive(false)
					end
				end
			end

			local var_184_20 = 0.001

			if var_184_17 <= arg_181_1.time_ and arg_181_1.time_ < var_184_17 + var_184_20 then
				local var_184_21 = (arg_181_1.time_ - var_184_17) / var_184_20
				local var_184_22 = Vector3.New(345, -387.4, -316.5)

				var_184_16.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10127, var_184_22, var_184_21)
			end

			if arg_181_1.time_ >= var_184_17 + var_184_20 and arg_181_1.time_ < var_184_17 + var_184_20 + arg_184_0 then
				var_184_16.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_184_23 = 0
			local var_184_24 = 0.475

			if var_184_23 < arg_181_1.time_ and arg_181_1.time_ <= var_184_23 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_25 = arg_181_1:FormatText(StoryNameCfg[236].name)

				arg_181_1.leftNameTxt_.text = var_184_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_26 = arg_181_1:GetWordFromCfg(416142041)
				local var_184_27 = arg_181_1:FormatText(var_184_26.content)

				arg_181_1.text_.text = var_184_27

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_28 = 19
				local var_184_29 = utf8.len(var_184_27)
				local var_184_30 = var_184_28 <= 0 and var_184_24 or var_184_24 * (var_184_29 / var_184_28)

				if var_184_30 > 0 and var_184_24 < var_184_30 then
					arg_181_1.talkMaxDuration = var_184_30

					if var_184_30 + var_184_23 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_30 + var_184_23
					end
				end

				arg_181_1.text_.text = var_184_27
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142041", "story_v_out_416142.awb") ~= 0 then
					local var_184_31 = manager.audio:GetVoiceLength("story_v_out_416142", "416142041", "story_v_out_416142.awb") / 1000

					if var_184_31 + var_184_23 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_31 + var_184_23
					end

					if var_184_26.prefab_name ~= "" and arg_181_1.actors_[var_184_26.prefab_name] ~= nil then
						local var_184_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_26.prefab_name].transform, "story_v_out_416142", "416142041", "story_v_out_416142.awb")

						arg_181_1:RecordAudio("416142041", var_184_32)
						arg_181_1:RecordAudio("416142041", var_184_32)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_416142", "416142041", "story_v_out_416142.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_416142", "416142041", "story_v_out_416142.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_33 = math.max(var_184_24, arg_181_1.talkMaxDuration)

			if var_184_23 <= arg_181_1.time_ and arg_181_1.time_ < var_184_23 + var_184_33 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_23) / var_184_33

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_23 + var_184_33 and arg_181_1.time_ < var_184_23 + var_184_33 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play416142042 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 416142042
		arg_185_1.duration_ = 4

		local var_185_0 = {
			zh = 2.333,
			ja = 4
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play416142043(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.225

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[236].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_3 = arg_185_1:GetWordFromCfg(416142042)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 9
				local var_188_6 = utf8.len(var_188_4)
				local var_188_7 = var_188_5 <= 0 and var_188_1 or var_188_1 * (var_188_6 / var_188_5)

				if var_188_7 > 0 and var_188_1 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416142", "416142042", "story_v_out_416142.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_out_416142", "416142042", "story_v_out_416142.awb") / 1000

					if var_188_8 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_0
					end

					if var_188_3.prefab_name ~= "" and arg_185_1.actors_[var_188_3.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_3.prefab_name].transform, "story_v_out_416142", "416142042", "story_v_out_416142.awb")

						arg_185_1:RecordAudio("416142042", var_188_9)
						arg_185_1:RecordAudio("416142042", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_416142", "416142042", "story_v_out_416142.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_416142", "416142042", "story_v_out_416142.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_10 and arg_185_1.time_ < var_188_0 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play416142043 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 416142043
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
			arg_189_1.auto_ = false
		end

		function arg_189_1.playNext_(arg_191_0)
			arg_189_1.onStoryFinished_()
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10127"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.actorSpriteComps10127 == nil then
				arg_189_1.var_.actorSpriteComps10127 = var_192_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_2 = 0.2

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.actorSpriteComps10127 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_192_1 then
							if arg_189_1.isInRecall_ then
								local var_192_4 = Mathf.Lerp(iter_192_1.color.r, arg_189_1.hightColor2.r, var_192_3)
								local var_192_5 = Mathf.Lerp(iter_192_1.color.g, arg_189_1.hightColor2.g, var_192_3)
								local var_192_6 = Mathf.Lerp(iter_192_1.color.b, arg_189_1.hightColor2.b, var_192_3)

								iter_192_1.color = Color.New(var_192_4, var_192_5, var_192_6)
							else
								local var_192_7 = Mathf.Lerp(iter_192_1.color.r, 0.5, var_192_3)

								iter_192_1.color = Color.New(var_192_7, var_192_7, var_192_7)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.actorSpriteComps10127 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_192_3 then
						if arg_189_1.isInRecall_ then
							iter_192_3.color = arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_192_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps10127 = nil
			end

			local var_192_8 = arg_189_1.actors_["10122"].transform
			local var_192_9 = 0

			if var_192_9 < arg_189_1.time_ and arg_189_1.time_ <= var_192_9 + arg_192_0 then
				arg_189_1.var_.moveOldPos10122 = var_192_8.localPosition
				var_192_8.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10122", 7)

				local var_192_10 = var_192_8.childCount

				for iter_192_4 = 0, var_192_10 - 1 do
					local var_192_11 = var_192_8:GetChild(iter_192_4)

					if var_192_11.name == "" or not string.find(var_192_11.name, "split") then
						var_192_11.gameObject:SetActive(true)
					else
						var_192_11.gameObject:SetActive(false)
					end
				end
			end

			local var_192_12 = 0.001

			if var_192_9 <= arg_189_1.time_ and arg_189_1.time_ < var_192_9 + var_192_12 then
				local var_192_13 = (arg_189_1.time_ - var_192_9) / var_192_12
				local var_192_14 = Vector3.New(0, -2000, 0)

				var_192_8.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10122, var_192_14, var_192_13)
			end

			if arg_189_1.time_ >= var_192_9 + var_192_12 and arg_189_1.time_ < var_192_9 + var_192_12 + arg_192_0 then
				var_192_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_192_15 = arg_189_1.actors_["10127"].transform
			local var_192_16 = 0

			if var_192_16 < arg_189_1.time_ and arg_189_1.time_ <= var_192_16 + arg_192_0 then
				arg_189_1.var_.moveOldPos10127 = var_192_15.localPosition
				var_192_15.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10127", 7)

				local var_192_17 = var_192_15.childCount

				for iter_192_5 = 0, var_192_17 - 1 do
					local var_192_18 = var_192_15:GetChild(iter_192_5)

					if var_192_18.name == "" or not string.find(var_192_18.name, "split") then
						var_192_18.gameObject:SetActive(true)
					else
						var_192_18.gameObject:SetActive(false)
					end
				end
			end

			local var_192_19 = 0.001

			if var_192_16 <= arg_189_1.time_ and arg_189_1.time_ < var_192_16 + var_192_19 then
				local var_192_20 = (arg_189_1.time_ - var_192_16) / var_192_19
				local var_192_21 = Vector3.New(0, -2000, 0)

				var_192_15.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10127, var_192_21, var_192_20)
			end

			if arg_189_1.time_ >= var_192_16 + var_192_19 and arg_189_1.time_ < var_192_16 + var_192_19 + arg_192_0 then
				var_192_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_192_22 = 0
			local var_192_23 = 1.25

			if var_192_22 < arg_189_1.time_ and arg_189_1.time_ <= var_192_22 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_24 = arg_189_1:GetWordFromCfg(416142043)
				local var_192_25 = arg_189_1:FormatText(var_192_24.content)

				arg_189_1.text_.text = var_192_25

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_26 = 50
				local var_192_27 = utf8.len(var_192_25)
				local var_192_28 = var_192_26 <= 0 and var_192_23 or var_192_23 * (var_192_27 / var_192_26)

				if var_192_28 > 0 and var_192_23 < var_192_28 then
					arg_189_1.talkMaxDuration = var_192_28

					if var_192_28 + var_192_22 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_28 + var_192_22
					end
				end

				arg_189_1.text_.text = var_192_25
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_29 = math.max(var_192_23, arg_189_1.talkMaxDuration)

			if var_192_22 <= arg_189_1.time_ and arg_189_1.time_ < var_192_22 + var_192_29 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_22) / var_192_29

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_22 + var_192_29 and arg_189_1.time_ < var_192_22 + var_192_29 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I13i",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/SS1606a",
		"TextureConfig/Background/I13f"
	},
	voices = {
		"story_v_out_416142.awb"
	}
}
