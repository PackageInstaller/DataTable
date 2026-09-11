return {
	Play113172001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113172001
		arg_1_1.duration_ = 12.77

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play113172002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.OM0104 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "OM0104")
				var_4_0.name = "OM0104"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.OM0104 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				if arg_1_0.sceneSettingEffect_ then
					arg_1_1.sceneSettingEffect_.enabled = false
				end

				arg_1_1.sceneSettingGo_:SetActive(true)

				local var_4_1 = arg_1_1.bgs_.OM0104

				arg_1_1.bgs_.OM0104.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "OM0104" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = arg_1_1.bgs_.OM0104.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosOM0104 = var_4_4.localPosition
			end

			local var_4_5 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				var_4_4.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosOM0104, Vector3.New(-5, -1, 0.69), (arg_1_1.time_ - 0) / var_4_5)
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 then
				var_4_4.localPosition = Vector3.New(-5, -1, 0.69)
			end

			local var_4_6 = arg_1_1.bgs_.OM0104.transform

			if 0.0166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.0166666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPosOM0104 = var_4_6.localPosition
			end

			local var_4_7 = 3.98333333333333

			if 0.0166666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 0.0166666666666667 + var_4_7 then
				var_4_6.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosOM0104, Vector3.New(-5, -1.5, 0.69), (arg_1_1.time_ - 0.0166666666666667) / var_4_7)
			end

			if arg_1_1.time_ >= 0.0166666666666667 + var_4_7 and arg_1_1.time_ < 0.0166666666666667 + var_4_7 + arg_4_0 then
				var_4_6.localPosition = Vector3.New(-5, -1.5, 0.69)
			end

			local var_4_8 = arg_1_1.bgs_.OM0104.transform

			if 4 < arg_1_1.time_ and arg_1_1.time_ <= 4 + arg_4_0 then
				arg_1_1.var_.moveOldPosOM0104 = var_4_8.localPosition
			end

			local var_4_9 = 0.001

			if 4 <= arg_1_1.time_ and arg_1_1.time_ < 4 + var_4_9 then
				var_4_8.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosOM0104, Vector3.New(4.5, 1.1, 1), (arg_1_1.time_ - 4) / var_4_9)
			end

			if arg_1_1.time_ >= 4 + var_4_9 and arg_1_1.time_ < 4 + var_4_9 + arg_4_0 then
				var_4_8.localPosition = Vector3.New(4.5, 1.1, 1)
			end

			local var_4_10 = arg_1_1.bgs_.OM0104.transform

			if 4.01666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 4.01666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPosOM0104 = var_4_10.localPosition
			end

			local var_4_11 = 3.98333333333333

			if 4.01666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 4.01666666666667 + var_4_11 then
				var_4_10.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosOM0104, Vector3.New(4.5, 0.8, 1), (arg_1_1.time_ - 4.01666666666667) / var_4_11)
			end

			if arg_1_1.time_ >= 4.01666666666667 + var_4_11 and arg_1_1.time_ < 4.01666666666667 + var_4_11 + arg_4_0 then
				var_4_10.localPosition = Vector3.New(4.5, 0.8, 1)
			end

			local var_4_12 = arg_1_1.bgs_.OM0104.transform

			if 8 < arg_1_1.time_ and arg_1_1.time_ <= 8 + arg_4_0 then
				arg_1_1.var_.moveOldPosOM0104 = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 8 <= arg_1_1.time_ and arg_1_1.time_ < 8 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosOM0104, Vector3.New(0, 1, 9.5), (arg_1_1.time_ - 8) / var_4_13)
			end

			if arg_1_1.time_ >= 8 + var_4_13 and arg_1_1.time_ < 8 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_4_14 = arg_1_1.bgs_.OM0104.transform

			if 8.01666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 8.01666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPosOM0104 = var_4_14.localPosition
			end

			local var_4_15 = 2.5

			if 8.01666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 8.01666666666667 + var_4_15 then
				var_4_14.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosOM0104, Vector3.New(0, 1, 10), (arg_1_1.time_ - 8.01666666666667) / var_4_15)
			end

			if arg_1_1.time_ >= 8.01666666666667 + var_4_15 and arg_1_1.time_ < 8.01666666666667 + var_4_15 + arg_4_0 then
				var_4_14.localPosition = Vector3.New(0, 1, 10)
			end

			local var_4_16 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = Color.New(0, 0, 0)

				var_4_18.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_16) / var_4_17)
				arg_1_1.mask_.color = var_4_18
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_19 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_19.a = 0
				arg_1_1.mask_.color = var_4_19
			end

			local var_4_20 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_21 = 2

			if var_4_20 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				local var_4_22 = Color.New(0, 0, 0)

				var_4_22.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_20) / var_4_21)
				arg_1_1.mask_.color = var_4_22
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				local var_4_23 = Color.New(0, 0, 0)

				var_4_23.a = 1
				arg_1_1.mask_.color = var_4_23
			end

			local var_4_24 = 4

			if 4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_25 = 2

			if var_4_24 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				local var_4_26 = Color.New(0, 0, 0)

				var_4_26.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_24) / var_4_25)
				arg_1_1.mask_.color = var_4_26
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				local var_4_27 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_27.a = 0
				arg_1_1.mask_.color = var_4_27
			end

			local var_4_28 = 6

			if 6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_29 = 2

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = Color.New(0, 0, 0)

				var_4_30.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_28) / var_4_29)
				arg_1_1.mask_.color = var_4_30
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				local var_4_31 = Color.New(0, 0, 0)

				var_4_31.a = 1
				arg_1_1.mask_.color = var_4_31
			end

			local var_4_32 = 8

			if 8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_33 = 1.5

			if var_4_32 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				local var_4_34 = Color.New(0, 0, 0)

				var_4_34.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_32) / var_4_33)
				arg_1_1.mask_.color = var_4_34
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				local var_4_35 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_35.a = 0
				arg_1_1.mask_.color = var_4_35
			end

			local var_4_36 = 10

			if 10 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_36 + 0.6 and arg_1_1.time_ < var_4_36 + 0.6 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_37 = manager.ui.mainCamera.transform

			if 10 < arg_1_1.time_ and arg_1_1.time_ <= 10 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_37.localPosition
			end

			local var_4_38 = 0.6

			if 10 <= arg_1_1.time_ and arg_1_1.time_ < 10 + var_4_38 then
				local var_4_39, var_4_40 = math.modf((arg_1_1.time_ - 10) / 0.066)

				var_4_37.localPosition = Vector3.New(var_4_40 * 0.13, var_4_40 * 0.13, var_4_40 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= 10 + var_4_38 and arg_1_1.time_ < 10 + var_4_38 + arg_4_0 then
				var_4_37.localPosition = arg_1_1.var_.shakeOldPos
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_10", "se_story_10_smash", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_44 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_44 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_44

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_44
						arg_1_1.bgmTxt2_.text = var_4_44
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

			if 10 < arg_1_1.time_ and arg_1_1.time_ <= 10 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2.awb")

				local var_4_47 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_47 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_47

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_47
						arg_1_1.bgmTxt2_.text = var_4_47
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

			if 10 < arg_1_1.time_ and arg_1_1.time_ <= 10 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story", "se_story_robot_e", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_49 = 10
			local var_4_50 = 0.125

			if 10 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[68].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2037")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_52 = arg_1_1:GetWordFromCfg(113172001)
				local var_4_53 = arg_1_1:FormatText(var_4_52.content)

				arg_1_1.text_.text = var_4_53

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_55 = 5 <= 0 and var_4_50 or var_4_50 * (utf8.len(var_4_53) / 5)

				if (5 <= 0 and var_4_50 or var_4_50 * (utf8.len(var_4_53) / 5)) > 0 and var_4_50 < var_4_55 then
					arg_1_1.talkMaxDuration = var_4_55
					var_4_49 = var_4_49 + 0.3

					if var_4_55 + var_4_49 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_55 + var_4_49
					end
				end

				arg_1_1.text_.text = var_4_53
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172001", "story_v_out_113172.awb") ~= 0 then
					local var_4_56 = manager.audio:GetVoiceLength("story_v_out_113172", "113172001", "story_v_out_113172.awb") / 1000

					if var_4_56 + var_4_49 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_56 + var_4_49
					end

					if var_4_52.prefab_name ~= "" and arg_1_1.actors_[var_4_52.prefab_name] ~= nil then
						local var_4_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_52.prefab_name].transform, "story_v_out_113172", "113172001", "story_v_out_113172.awb")

						arg_1_1:RecordAudio("113172001", var_4_57)
						arg_1_1:RecordAudio("113172001", var_4_57)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_113172", "113172001", "story_v_out_113172.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_113172", "113172001", "story_v_out_113172.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_58 = var_4_49 + 0.3
			local var_4_59 = math.max(var_4_50, arg_1_1.talkMaxDuration)

			if var_4_49 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_58 + var_4_59 then
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
				actorName = "OM0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.98333333333333,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.98333333333333,
				className = "StoryMoveNode",
				startTime = 4.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.5,
				className = "StoryMoveNode",
				startTime = 8.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play113172002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 113172002
		arg_9_1.duration_ = 1.93

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play113172003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_10", "se_story_10_smash02", "")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_15", "se_story_15_roar3", "")
			end

			local var_12_2 = 0
			local var_12_3 = 0.1

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_2 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[68].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2038")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_4 = arg_9_1:GetWordFromCfg(113172002)
				local var_12_5 = arg_9_1:FormatText(var_12_4.content)

				arg_9_1.text_.text = var_12_5

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_7 = 4 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_5) / 4)

				if (4 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_5) / 4)) > 0 and var_12_3 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_2 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_2
					end
				end

				arg_9_1.text_.text = var_12_5
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172002", "story_v_out_113172.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_113172", "113172002", "story_v_out_113172.awb") / 1000

					if var_12_8 + var_12_2 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_2
					end

					if var_12_4.prefab_name ~= "" and arg_9_1.actors_[var_12_4.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_4.prefab_name].transform, "story_v_out_113172", "113172002", "story_v_out_113172.awb")

						arg_9_1:RecordAudio("113172002", var_12_9)
						arg_9_1:RecordAudio("113172002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_113172", "113172002", "story_v_out_113172.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_113172", "113172002", "story_v_out_113172.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_10 = math.max(var_12_3, arg_9_1.talkMaxDuration)

			if var_12_2 <= arg_9_1.time_ and arg_9_1.time_ < var_12_2 + var_12_10 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_2) / var_12_10

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_2 + var_12_10 and arg_9_1.time_ < var_12_2 + var_12_10 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play113172003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 113172003
		arg_13_1.duration_ = 5.53

		local var_13_0 = {
			ja = 2.966,
			ko = 3.3,
			zh = 5.533,
			en = 3.7
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play113172004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.475

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(113172003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 19 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 19)

				if (19 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 19)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172003", "story_v_out_113172.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_113172", "113172003", "story_v_out_113172.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_113172", "113172003", "story_v_out_113172.awb")

						arg_13_1:RecordAudio("113172003", var_16_6)
						arg_13_1:RecordAudio("113172003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_113172", "113172003", "story_v_out_113172.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_113172", "113172003", "story_v_out_113172.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play113172004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 113172004
		arg_17_1.duration_ = 15.97

		local var_17_0 = {
			ja = 9.833,
			ko = 8.066,
			zh = 10.5,
			en = 15.966
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
				arg_17_0:Play113172005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.85

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005_B")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(113172004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 34 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 34)

				if (34 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 34)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172004", "story_v_out_113172.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_113172", "113172004", "story_v_out_113172.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_113172", "113172004", "story_v_out_113172.awb")

						arg_17_1:RecordAudio("113172004", var_20_6)
						arg_17_1:RecordAudio("113172004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_113172", "113172004", "story_v_out_113172.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_113172", "113172004", "story_v_out_113172.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play113172005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 113172005
		arg_21_1.duration_ = 9.4

		local var_21_0 = {
			ja = 7.966,
			ko = 9.4,
			zh = 8.633,
			en = 7.7
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
				arg_21_0:Play113172006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.725

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005_B")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(113172005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 29 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 29)

				if (29 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 29)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172005", "story_v_out_113172.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_113172", "113172005", "story_v_out_113172.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_113172", "113172005", "story_v_out_113172.awb")

						arg_21_1:RecordAudio("113172005", var_24_6)
						arg_21_1:RecordAudio("113172005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_113172", "113172005", "story_v_out_113172.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_113172", "113172005", "story_v_out_113172.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play113172006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 113172006
		arg_25_1.duration_ = 2.5

		local var_25_0 = {
			ja = 2.3,
			ko = 1.9,
			zh = 2.1,
			en = 2.5
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
				arg_25_0:Play113172007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_28_0 = 0.6

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				local var_28_1, var_28_2 = math.modf((arg_25_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_28_2 * 0.13, var_28_2 * 0.13, var_28_2 * 0.13) + arg_25_1.var_.shakeOldPos
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				manager.ui.mainCamera.transform.localPosition = arg_25_1.var_.shakeOldPos
			end

			local var_28_3 = 0

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
				arg_25_1.allBtn_.enabled = false
			end

			if arg_25_1.time_ >= var_28_3 + 0.6 and arg_25_1.time_ < var_28_3 + 0.6 + arg_28_0 then
				arg_25_1.allBtn_.enabled = true
			end

			local var_28_4 = 0
			local var_28_5 = 0.25

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(113172006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 10 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 10)

				if (10 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 10)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172006", "story_v_out_113172.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_out_113172", "113172006", "story_v_out_113172.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_out_113172", "113172006", "story_v_out_113172.awb")

						arg_25_1:RecordAudio("113172006", var_28_11)
						arg_25_1:RecordAudio("113172006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_113172", "113172006", "story_v_out_113172.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_113172", "113172006", "story_v_out_113172.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_12 and arg_25_1.time_ < var_28_4 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play113172007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 113172007
		arg_29_1.duration_ = 7.4

		local var_29_0 = {
			ja = 7.4,
			ko = 5.466,
			zh = 7,
			en = 5.966
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play113172008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:AudioAction("play", "effect", "se_story_10", "se_story_10_smash03", "")
			end

			local var_32_1 = 0
			local var_32_2 = 0.65

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005_B")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(113172007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_6 = 26 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 26)

				if (26 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 26)) > 0 and var_32_2 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172007", "story_v_out_113172.awb") ~= 0 then
					local var_32_7 = manager.audio:GetVoiceLength("story_v_out_113172", "113172007", "story_v_out_113172.awb") / 1000

					if var_32_7 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_1
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_113172", "113172007", "story_v_out_113172.awb")

						arg_29_1:RecordAudio("113172007", var_32_8)
						arg_29_1:RecordAudio("113172007", var_32_8)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_113172", "113172007", "story_v_out_113172.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_113172", "113172007", "story_v_out_113172.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_9 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_9 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_9

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_9 and arg_29_1.time_ < var_32_1 + var_32_9 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play113172008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 113172008
		arg_33_1.duration_ = 4.3

		local var_33_0 = {
			ja = 3.9,
			ko = 3.533,
			zh = 3.533,
			en = 4.3
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play113172009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.225

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005_B")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_1 = arg_33_1:GetWordFromCfg(113172008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 9 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 9)

				if (9 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 9)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172008", "story_v_out_113172.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_113172", "113172008", "story_v_out_113172.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_113172", "113172008", "story_v_out_113172.awb")

						arg_33_1:RecordAudio("113172008", var_36_6)
						arg_33_1:RecordAudio("113172008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_113172", "113172008", "story_v_out_113172.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_113172", "113172008", "story_v_out_113172.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play113172009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 113172009
		arg_37_1.duration_ = 9.23

		local var_37_0 = {
			ja = 6.033,
			ko = 5.633,
			zh = 9.233,
			en = 4.8
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
				arg_37_0:Play113172010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.6

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:GetWordFromCfg(113172009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 24 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 24)

				if (24 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 24)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172009", "story_v_out_113172.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_113172", "113172009", "story_v_out_113172.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_113172", "113172009", "story_v_out_113172.awb")

						arg_37_1:RecordAudio("113172009", var_40_6)
						arg_37_1:RecordAudio("113172009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_113172", "113172009", "story_v_out_113172.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_113172", "113172009", "story_v_out_113172.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play113172010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 113172010
		arg_41_1.duration_ = 10.97

		local var_41_0 = {
			ja = 10.966,
			ko = 5.366,
			zh = 7.9,
			en = 6.5
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play113172011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.45

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005_B")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:GetWordFromCfg(113172010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 18 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 18)

				if (18 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 18)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172010", "story_v_out_113172.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_113172", "113172010", "story_v_out_113172.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_113172", "113172010", "story_v_out_113172.awb")

						arg_41_1:RecordAudio("113172010", var_44_6)
						arg_41_1:RecordAudio("113172010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_113172", "113172010", "story_v_out_113172.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_113172", "113172010", "story_v_out_113172.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play113172011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 113172011
		arg_45_1.duration_ = 2.27

		local var_45_0 = {
			ja = 1,
			ko = 1.233,
			zh = 2.266,
			en = 1.033
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play113172012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.05

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(113172011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 2 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 2)

				if (2 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 2)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172011", "story_v_out_113172.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_113172", "113172011", "story_v_out_113172.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_113172", "113172011", "story_v_out_113172.awb")

						arg_45_1:RecordAudio("113172011", var_48_6)
						arg_45_1:RecordAudio("113172011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_113172", "113172011", "story_v_out_113172.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_113172", "113172011", "story_v_out_113172.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play113172012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 113172012
		arg_49_1.duration_ = 15.4

		local var_49_0 = {
			ja = 15.4,
			ko = 9.866,
			zh = 11.133,
			en = 10.766
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
				arg_49_0:Play113172013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if arg_49_1.bgs_.F03b == nil then
				local var_52_0 = Object.Instantiate(arg_49_1.paintGo_)

				var_52_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F03b")
				var_52_0.name = "F03b"
				var_52_0.transform.parent = arg_49_1.stage_.transform
				var_52_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.bgs_.F03b = var_52_0
			end

			if 2 < arg_49_1.time_ and arg_49_1.time_ <= 2 + arg_52_0 then
				local var_52_1 = arg_49_1.bgs_.F03b

				arg_49_1.bgs_.F03b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_52_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_52_2 = var_52_1:GetComponent("SpriteRenderer")

				if var_52_2 and var_52_2.sprite then
					local var_52_3 = 2 * (var_52_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_52_1.transform.localScale = Vector3.New(var_52_3 / var_52_2.sprite.bounds.size.y < var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x and var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x or var_52_3 / var_52_2.sprite.bounds.size.y, var_52_3 / var_52_2.sprite.bounds.size.y < var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x and var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x or var_52_3 / var_52_2.sprite.bounds.size.y, 0)
				end

				for iter_52_0, iter_52_1 in pairs(arg_49_1.bgs_) do
					if iter_52_0 ~= "F03b" then
						iter_52_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_52_4 = 0

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_5 = 2

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_5 then
				local var_52_6 = Color.New(0, 0, 0)

				var_52_6.a = Mathf.Lerp(0, 1, (arg_49_1.time_ - var_52_4) / var_52_5)
				arg_49_1.mask_.color = var_52_6
			end

			if arg_49_1.time_ >= var_52_4 + var_52_5 and arg_49_1.time_ < var_52_4 + var_52_5 + arg_52_0 then
				local var_52_7 = Color.New(0, 0, 0)

				var_52_7.a = 1
				arg_49_1.mask_.color = var_52_7
			end

			local var_52_8 = 2

			if 2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_9 = 2

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_9 then
				local var_52_10 = Color.New(0, 0, 0)

				var_52_10.a = Mathf.Lerp(1, 0, (arg_49_1.time_ - var_52_8) / var_52_9)
				arg_49_1.mask_.color = var_52_10
			end

			if arg_49_1.time_ >= var_52_8 + var_52_9 and arg_49_1.time_ < var_52_8 + var_52_9 + arg_52_0 then
				local var_52_11 = Color.New(0, 0, 0)

				arg_49_1.mask_.enabled = false
				var_52_11.a = 0
				arg_49_1.mask_.color = var_52_11
			end

			local var_52_12 = "10006ui_story"

			if arg_49_1.actors_["10006ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10006ui_story"))) then
				local var_52_13 = Object.Instantiate(Asset.Load("Char/" .. "10006ui_story"), arg_49_1.stage_.transform)

				var_52_13.name = var_52_12
				var_52_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.actors_[var_52_12] = var_52_13

				local var_52_14 = var_52_13:GetComponentInChildren(typeof(CharacterEffect))

				var_52_14.enabled = true

				local var_52_15 = GameObjectTools.GetOrAddComponent(var_52_13, typeof(DynamicBoneHelper))

				if var_52_15 then
					var_52_15:EnableDynamicBone(false)
				end

				arg_49_1:ShowWeapon(var_52_14.transform, false)

				arg_49_1.var_[var_52_12 .. "Animator"] = var_52_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_49_1.var_[var_52_12 .. "Animator"].applyRootMotion = true
				arg_49_1.var_[var_52_12 .. "LipSync"] = var_52_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_52_16 = arg_49_1.actors_["10006ui_story"].transform

			if 4 < arg_49_1.time_ and arg_49_1.time_ <= 4 + arg_52_0 then
				arg_49_1.var_.moveOldPos10006ui_story = var_52_16.localPosition
			end

			local var_52_17 = 0.001

			if 4 <= arg_49_1.time_ and arg_49_1.time_ < 4 + var_52_17 then
				var_52_16.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10006ui_story, Vector3.New(-0.7, -0.98, -5.65), (arg_49_1.time_ - 4) / var_52_17)
				var_52_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_16.position).x, (manager.ui.mainCamera.transform.position - var_52_16.position).y, (manager.ui.mainCamera.transform.position - var_52_16.position).z)
				var_52_16.localEulerAngles.z = 0
				var_52_16.localEulerAngles.x = 0
				var_52_16.localEulerAngles = var_52_16.localEulerAngles
			end

			if arg_49_1.time_ >= 4 + var_52_17 and arg_49_1.time_ < 4 + var_52_17 + arg_52_0 then
				var_52_16.localPosition = Vector3.New(-0.7, -0.98, -5.65)
				var_52_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_16.position).x, (manager.ui.mainCamera.transform.position - var_52_16.position).y, (manager.ui.mainCamera.transform.position - var_52_16.position).z)
				var_52_16.localEulerAngles.z = 0
				var_52_16.localEulerAngles.x = 0
				var_52_16.localEulerAngles = var_52_16.localEulerAngles
			end

			if 4 < arg_49_1.time_ and arg_49_1.time_ <= 4 + arg_52_0 then
				arg_49_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action3_1")
			end

			if 4 < arg_49_1.time_ and arg_49_1.time_ <= 4 + arg_52_0 then
				arg_49_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_52_18 = arg_49_1.actors_["10006ui_story"]

			if 4 < arg_49_1.time_ and arg_49_1.time_ <= 4 + arg_52_0 and not isNil(var_52_18) and arg_49_1.var_.characterEffect10006ui_story == nil then
				arg_49_1.var_.characterEffect10006ui_story = var_52_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_19 = 0.2

			if 4 <= arg_49_1.time_ and arg_49_1.time_ < 4 + var_52_19 and not isNil(var_52_18) then
				if arg_49_1.var_.characterEffect10006ui_story and not isNil(var_52_18) then
					arg_49_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 4 + var_52_19 and arg_49_1.time_ < 4 + var_52_19 + arg_52_0 and not isNil(var_52_18) and arg_49_1.var_.characterEffect10006ui_story then
				arg_49_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			if arg_49_1.frameCnt_ <= 1 then
				arg_49_1.dialog_:SetActive(false)
			end

			local var_52_21 = 4
			local var_52_22 = 0.7

			if 4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_21 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				arg_49_1.dialog_:SetActive(true)

				arg_49_1.dialogCg_.alpha = 0

				local var_52_23 = LeanTween.value(arg_49_1.dialog_, 0, 1, 0.3)

				var_52_23:setOnUpdate(LuaHelper.FloatAction(function(arg_53_0)
					arg_49_1.dialogCg_.alpha = arg_53_0
				end))
				var_52_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_49_1.dialog_)
					var_52_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_49_1.duration_ = arg_49_1.duration_ + 0.3

				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_24 = arg_49_1:GetWordFromCfg(113172012)
				local var_52_25 = arg_49_1:FormatText(var_52_24.content)

				arg_49_1.text_.text = var_52_25

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_27 = 28 <= 0 and var_52_22 or var_52_22 * (utf8.len(var_52_25) / 28)

				if (28 <= 0 and var_52_22 or var_52_22 * (utf8.len(var_52_25) / 28)) > 0 and var_52_22 < var_52_27 then
					arg_49_1.talkMaxDuration = var_52_27
					var_52_21 = var_52_21 + 0.3

					if var_52_27 + var_52_21 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_27 + var_52_21
					end
				end

				arg_49_1.text_.text = var_52_25
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172012", "story_v_out_113172.awb") ~= 0 then
					local var_52_28 = manager.audio:GetVoiceLength("story_v_out_113172", "113172012", "story_v_out_113172.awb") / 1000

					if var_52_28 + var_52_21 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_28 + var_52_21
					end

					if var_52_24.prefab_name ~= "" and arg_49_1.actors_[var_52_24.prefab_name] ~= nil then
						local var_52_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_24.prefab_name].transform, "story_v_out_113172", "113172012", "story_v_out_113172.awb")

						arg_49_1:RecordAudio("113172012", var_52_29)
						arg_49_1:RecordAudio("113172012", var_52_29)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_113172", "113172012", "story_v_out_113172.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_113172", "113172012", "story_v_out_113172.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_30 = var_52_21 + 0.3
			local var_52_31 = math.max(var_52_22, arg_49_1.talkMaxDuration)

			if var_52_21 + 0.3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_30 + var_52_31 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_30) / var_52_31

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_30 + var_52_31 and arg_49_1.time_ < var_52_30 + var_52_31 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play113172013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 113172013
		arg_55_1.duration_ = 4.67

		local var_55_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 4.666,
			en = 2.2
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
				arg_55_0:Play113172014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if arg_55_1.actors_["1041ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1041ui_story"))) then
				local var_58_0 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_55_1.stage_.transform)

				var_58_0.name = "1041ui_story"
				var_58_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.actors_["1041ui_story"] = var_58_0

				local var_58_1 = var_58_0:GetComponentInChildren(typeof(CharacterEffect))

				var_58_1.enabled = true

				local var_58_2 = GameObjectTools.GetOrAddComponent(var_58_0, typeof(DynamicBoneHelper))

				if var_58_2 then
					var_58_2:EnableDynamicBone(false)
				end

				arg_55_1:ShowWeapon(var_58_1.transform, false)

				arg_55_1.var_["1041ui_story" .. "Animator"] = var_58_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_55_1.var_["1041ui_story" .. "Animator"].applyRootMotion = true
				arg_55_1.var_["1041ui_story" .. "LipSync"] = var_58_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_58_3 = arg_55_1.actors_["1041ui_story"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1041ui_story = var_58_3.localPosition
			end

			local var_58_4 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				var_58_3.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1041ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_55_1.time_ - 0) / var_58_4)
				var_58_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_3.position).x, (manager.ui.mainCamera.transform.position - var_58_3.position).y, (manager.ui.mainCamera.transform.position - var_58_3.position).z)
				var_58_3.localEulerAngles.z = 0
				var_58_3.localEulerAngles.x = 0
				var_58_3.localEulerAngles = var_58_3.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				var_58_3.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_58_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_3.position).x, (manager.ui.mainCamera.transform.position - var_58_3.position).y, (manager.ui.mainCamera.transform.position - var_58_3.position).z)
				var_58_3.localEulerAngles.z = 0
				var_58_3.localEulerAngles.x = 0
				var_58_3.localEulerAngles = var_58_3.localEulerAngles
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action9_2")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_58_5 = arg_55_1.actors_["1041ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_5) and arg_55_1.var_.characterEffect1041ui_story == nil then
				arg_55_1.var_.characterEffect1041ui_story = var_58_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_6 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_6 and not isNil(var_58_5) then
				if arg_55_1.var_.characterEffect1041ui_story and not isNil(var_58_5) then
					arg_55_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_6 and arg_55_1.time_ < 0 + var_58_6 + arg_58_0 and not isNil(var_58_5) and arg_55_1.var_.characterEffect1041ui_story then
				arg_55_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_58_8 = arg_55_1.actors_["10006ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_8) and arg_55_1.var_.characterEffect10006ui_story == nil then
				arg_55_1.var_.characterEffect10006ui_story = var_58_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_9 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_9 and not isNil(var_58_8) then
				if arg_55_1.var_.characterEffect10006ui_story and not isNil(var_58_8) then
					arg_55_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_55_1.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_9)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_9 and arg_55_1.time_ < 0 + var_58_9 + arg_58_0 and not isNil(var_58_8) and arg_55_1.var_.characterEffect10006ui_story then
				arg_55_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_55_1.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			local var_58_10 = 0
			local var_58_11 = 0.05

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_10 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_12 = arg_55_1:GetWordFromCfg(113172013)
				local var_58_13 = arg_55_1:FormatText(var_58_12.content)

				arg_55_1.text_.text = var_58_13

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_15 = 2 <= 0 and var_58_11 or var_58_11 * (utf8.len(var_58_13) / 2)

				if (2 <= 0 and var_58_11 or var_58_11 * (utf8.len(var_58_13) / 2)) > 0 and var_58_11 < var_58_15 then
					arg_55_1.talkMaxDuration = var_58_15

					if var_58_15 + var_58_10 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_15 + var_58_10
					end
				end

				arg_55_1.text_.text = var_58_13
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172013", "story_v_out_113172.awb") ~= 0 then
					local var_58_16 = manager.audio:GetVoiceLength("story_v_out_113172", "113172013", "story_v_out_113172.awb") / 1000

					if var_58_16 + var_58_10 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_16 + var_58_10
					end

					if var_58_12.prefab_name ~= "" and arg_55_1.actors_[var_58_12.prefab_name] ~= nil then
						local var_58_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_12.prefab_name].transform, "story_v_out_113172", "113172013", "story_v_out_113172.awb")

						arg_55_1:RecordAudio("113172013", var_58_17)
						arg_55_1:RecordAudio("113172013", var_58_17)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_113172", "113172013", "story_v_out_113172.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_113172", "113172013", "story_v_out_113172.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_18 = math.max(var_58_11, arg_55_1.talkMaxDuration)

			if var_58_10 <= arg_55_1.time_ and arg_55_1.time_ < var_58_10 + var_58_18 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_10) / var_58_18

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_10 + var_58_18 and arg_55_1.time_ < var_58_10 + var_58_18 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play113172014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 113172014
		arg_59_1.duration_ = 4.83

		local var_59_0 = {
			ja = 3.233,
			ko = 2.366,
			zh = 4.833,
			en = 3.266
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
				arg_59_0:Play113172015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_62_0 = 0
			local var_62_1 = 0.2

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_2 = arg_59_1:GetWordFromCfg(113172014)
				local var_62_3 = arg_59_1:FormatText(var_62_2.content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 8 <= 0 and var_62_1 or var_62_1 * (utf8.len(var_62_3) / 8)

				if (8 <= 0 and var_62_1 or var_62_1 * (utf8.len(var_62_3) / 8)) > 0 and var_62_1 < var_62_5 then
					arg_59_1.talkMaxDuration = var_62_5

					if var_62_5 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172014", "story_v_out_113172.awb") ~= 0 then
					local var_62_6 = manager.audio:GetVoiceLength("story_v_out_113172", "113172014", "story_v_out_113172.awb") / 1000

					if var_62_6 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_6 + var_62_0
					end

					if var_62_2.prefab_name ~= "" and arg_59_1.actors_[var_62_2.prefab_name] ~= nil then
						local var_62_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_2.prefab_name].transform, "story_v_out_113172", "113172014", "story_v_out_113172.awb")

						arg_59_1:RecordAudio("113172014", var_62_7)
						arg_59_1:RecordAudio("113172014", var_62_7)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_113172", "113172014", "story_v_out_113172.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_113172", "113172014", "story_v_out_113172.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_8 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_8 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_8

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_8 and arg_59_1.time_ < var_62_0 + var_62_8 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play113172015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 113172015
		arg_63_1.duration_ = 2

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play113172016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_66_0 = arg_63_1.actors_["10006ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect10006ui_story == nil then
				arg_63_1.var_.characterEffect10006ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_1 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_1 and not isNil(var_66_0) then
				if arg_63_1.var_.characterEffect10006ui_story and not isNil(var_66_0) then
					arg_63_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_1 and arg_63_1.time_ < 0 + var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect10006ui_story then
				arg_63_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_66_3 = arg_63_1.actors_["1041ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_3) and arg_63_1.var_.characterEffect1041ui_story == nil then
				arg_63_1.var_.characterEffect1041ui_story = var_66_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_4 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 and not isNil(var_66_3) then
				if arg_63_1.var_.characterEffect1041ui_story and not isNil(var_66_3) then
					arg_63_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_4)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 and not isNil(var_66_3) and arg_63_1.var_.characterEffect1041ui_story then
				arg_63_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_66_5 = 0
			local var_66_6 = 0.1

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_7 = arg_63_1:GetWordFromCfg(113172015)
				local var_66_8 = arg_63_1:FormatText(var_66_7.content)

				arg_63_1.text_.text = var_66_8

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_10 = 4 <= 0 and var_66_6 or var_66_6 * (utf8.len(var_66_8) / 4)

				if (4 <= 0 and var_66_6 or var_66_6 * (utf8.len(var_66_8) / 4)) > 0 and var_66_6 < var_66_10 then
					arg_63_1.talkMaxDuration = var_66_10

					if var_66_10 + var_66_5 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_5
					end
				end

				arg_63_1.text_.text = var_66_8
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172015", "story_v_out_113172.awb") ~= 0 then
					local var_66_11 = manager.audio:GetVoiceLength("story_v_out_113172", "113172015", "story_v_out_113172.awb") / 1000

					if var_66_11 + var_66_5 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_11 + var_66_5
					end

					if var_66_7.prefab_name ~= "" and arg_63_1.actors_[var_66_7.prefab_name] ~= nil then
						local var_66_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_7.prefab_name].transform, "story_v_out_113172", "113172015", "story_v_out_113172.awb")

						arg_63_1:RecordAudio("113172015", var_66_12)
						arg_63_1:RecordAudio("113172015", var_66_12)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_113172", "113172015", "story_v_out_113172.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_113172", "113172015", "story_v_out_113172.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_13 = math.max(var_66_6, arg_63_1.talkMaxDuration)

			if var_66_5 <= arg_63_1.time_ and arg_63_1.time_ < var_66_5 + var_66_13 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_5) / var_66_13

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_5 + var_66_13 and arg_63_1.time_ < var_66_5 + var_66_13 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play113172016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 113172016
		arg_67_1.duration_ = 10

		local var_67_0 = {
			ja = 10,
			ko = 4.1,
			zh = 6.566,
			en = 9.2
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
				arg_67_0:Play113172017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if arg_67_1.actors_["10006ui_tpose"] == nil and not isNil((Asset.Load("Char/" .. "10006ui_tpose"))) then
				local var_70_0 = Object.Instantiate(Asset.Load("Char/" .. "10006ui_tpose"), arg_67_1.stage_.transform)

				var_70_0.name = "10006ui_tpose"
				var_70_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_67_1.actors_["10006ui_tpose"] = var_70_0

				local var_70_1 = var_70_0:GetComponentInChildren(typeof(CharacterEffect))

				var_70_1.enabled = true

				local var_70_2 = GameObjectTools.GetOrAddComponent(var_70_0, typeof(DynamicBoneHelper))

				if var_70_2 then
					var_70_2:EnableDynamicBone(false)
				end

				arg_67_1:ShowWeapon(var_70_1.transform, false)

				arg_67_1.var_["10006ui_tpose" .. "Animator"] = var_70_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_67_1.var_["10006ui_tpose" .. "Animator"].applyRootMotion = true
				arg_67_1.var_["10006ui_tpose" .. "LipSync"] = var_70_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_70_3 = arg_67_1.actors_["10006ui_tpose"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_3) and arg_67_1.var_.characterEffect10006ui_tpose == nil then
				arg_67_1.var_.characterEffect10006ui_tpose = var_70_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_4 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 and not isNil(var_70_3) then
				if arg_67_1.var_.characterEffect10006ui_tpose and not isNil(var_70_3) then
					arg_67_1.var_.characterEffect10006ui_tpose.fillFlat = true
					arg_67_1.var_.characterEffect10006ui_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_4)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 and not isNil(var_70_3) and arg_67_1.var_.characterEffect10006ui_tpose then
				arg_67_1.var_.characterEffect10006ui_tpose.fillFlat = true
				arg_67_1.var_.characterEffect10006ui_tpose.fillRatio = 0.5
			end

			local var_70_5 = arg_67_1.actors_["1041ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_5) and arg_67_1.var_.characterEffect1041ui_story == nil then
				arg_67_1.var_.characterEffect1041ui_story = var_70_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_6 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_6 and not isNil(var_70_5) then
				if arg_67_1.var_.characterEffect1041ui_story and not isNil(var_70_5) then
					arg_67_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_6 and arg_67_1.time_ < 0 + var_70_6 + arg_70_0 and not isNil(var_70_5) and arg_67_1.var_.characterEffect1041ui_story then
				arg_67_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_70_8 = 0
			local var_70_9 = 0.4

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_8 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_10 = arg_67_1:GetWordFromCfg(113172016)
				local var_70_11 = arg_67_1:FormatText(var_70_10.content)

				arg_67_1.text_.text = var_70_11

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_13 = 16 <= 0 and var_70_9 or var_70_9 * (utf8.len(var_70_11) / 16)

				if (16 <= 0 and var_70_9 or var_70_9 * (utf8.len(var_70_11) / 16)) > 0 and var_70_9 < var_70_13 then
					arg_67_1.talkMaxDuration = var_70_13

					if var_70_13 + var_70_8 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_13 + var_70_8
					end
				end

				arg_67_1.text_.text = var_70_11
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172016", "story_v_out_113172.awb") ~= 0 then
					local var_70_14 = manager.audio:GetVoiceLength("story_v_out_113172", "113172016", "story_v_out_113172.awb") / 1000

					if var_70_14 + var_70_8 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_14 + var_70_8
					end

					if var_70_10.prefab_name ~= "" and arg_67_1.actors_[var_70_10.prefab_name] ~= nil then
						local var_70_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_10.prefab_name].transform, "story_v_out_113172", "113172016", "story_v_out_113172.awb")

						arg_67_1:RecordAudio("113172016", var_70_15)
						arg_67_1:RecordAudio("113172016", var_70_15)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_113172", "113172016", "story_v_out_113172.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_113172", "113172016", "story_v_out_113172.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_16 = math.max(var_70_9, arg_67_1.talkMaxDuration)

			if var_70_8 <= arg_67_1.time_ and arg_67_1.time_ < var_70_8 + var_70_16 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_8) / var_70_16

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_8 + var_70_16 and arg_67_1.time_ < var_70_8 + var_70_16 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play113172017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 113172017
		arg_71_1.duration_ = 9.7

		local var_71_0 = {
			ja = 9.7,
			ko = 3.133,
			zh = 2.933,
			en = 3.9
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
				arg_71_0:Play113172018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["1041ui_story"]) and arg_71_1.var_.characterEffect1041ui_story == nil then
				arg_71_1.var_.characterEffect1041ui_story = arg_71_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["1041ui_story"]) then
				if arg_71_1.var_.characterEffect1041ui_story and not isNil(arg_71_1.actors_["1041ui_story"]) then
					arg_71_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_0)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["1041ui_story"]) and arg_71_1.var_.characterEffect1041ui_story then
				arg_71_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_74_1 = arg_71_1.actors_["10006ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect10006ui_story == nil then
				arg_71_1.var_.characterEffect10006ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect10006ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect10006ui_story then
				arg_71_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006actionlink/10006action434")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_74_4 = 0
			local var_74_5 = 0.35

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:GetWordFromCfg(113172017)
				local var_74_7 = arg_71_1:FormatText(var_74_6.content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 14 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 14)

				if (14 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 14)) > 0 and var_74_5 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9

					if var_74_9 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_7
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172017", "story_v_out_113172.awb") ~= 0 then
					local var_74_10 = manager.audio:GetVoiceLength("story_v_out_113172", "113172017", "story_v_out_113172.awb") / 1000

					if var_74_10 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_4
					end

					if var_74_6.prefab_name ~= "" and arg_71_1.actors_[var_74_6.prefab_name] ~= nil then
						local var_74_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_6.prefab_name].transform, "story_v_out_113172", "113172017", "story_v_out_113172.awb")

						arg_71_1:RecordAudio("113172017", var_74_11)
						arg_71_1:RecordAudio("113172017", var_74_11)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_113172", "113172017", "story_v_out_113172.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_113172", "113172017", "story_v_out_113172.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_12 = math.max(var_74_5, arg_71_1.talkMaxDuration)

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_12 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_4) / var_74_12

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_4 + var_74_12 and arg_71_1.time_ < var_74_4 + var_74_12 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play113172018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 113172018
		arg_75_1.duration_ = 5.1

		local var_75_0 = {
			ja = 1.999999999999,
			ko = 2.3,
			zh = 5.1,
			en = 1.999999999999
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
				arg_75_0:Play113172019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["10006ui_story"]) and arg_75_1.var_.characterEffect10006ui_story == nil then
				arg_75_1.var_.characterEffect10006ui_story = arg_75_1.actors_["10006ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["10006ui_story"]) then
				if arg_75_1.var_.characterEffect10006ui_story and not isNil(arg_75_1.actors_["10006ui_story"]) then
					arg_75_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_75_1.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["10006ui_story"]) and arg_75_1.var_.characterEffect10006ui_story then
				arg_75_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_75_1.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			local var_78_1 = arg_75_1.actors_["1041ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect1041ui_story == nil then
				arg_75_1.var_.characterEffect1041ui_story = var_78_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_2 and not isNil(var_78_1) then
				if arg_75_1.var_.characterEffect1041ui_story and not isNil(var_78_1) then
					arg_75_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_2 and arg_75_1.time_ < 0 + var_78_2 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect1041ui_story then
				arg_75_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_78_4 = 0
			local var_78_5 = 0.05

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_4 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_6 = arg_75_1:GetWordFromCfg(113172018)
				local var_78_7 = arg_75_1:FormatText(var_78_6.content)

				arg_75_1.text_.text = var_78_7

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_9 = 2 <= 0 and var_78_5 or var_78_5 * (utf8.len(var_78_7) / 2)

				if (2 <= 0 and var_78_5 or var_78_5 * (utf8.len(var_78_7) / 2)) > 0 and var_78_5 < var_78_9 then
					arg_75_1.talkMaxDuration = var_78_9

					if var_78_9 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_9 + var_78_4
					end
				end

				arg_75_1.text_.text = var_78_7
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172018", "story_v_out_113172.awb") ~= 0 then
					local var_78_10 = manager.audio:GetVoiceLength("story_v_out_113172", "113172018", "story_v_out_113172.awb") / 1000

					if var_78_10 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_4
					end

					if var_78_6.prefab_name ~= "" and arg_75_1.actors_[var_78_6.prefab_name] ~= nil then
						local var_78_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_6.prefab_name].transform, "story_v_out_113172", "113172018", "story_v_out_113172.awb")

						arg_75_1:RecordAudio("113172018", var_78_11)
						arg_75_1:RecordAudio("113172018", var_78_11)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_113172", "113172018", "story_v_out_113172.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_113172", "113172018", "story_v_out_113172.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_12 = math.max(var_78_5, arg_75_1.talkMaxDuration)

			if var_78_4 <= arg_75_1.time_ and arg_75_1.time_ < var_78_4 + var_78_12 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_4) / var_78_12

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_4 + var_78_12 and arg_75_1.time_ < var_78_4 + var_78_12 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play113172019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 113172019
		arg_79_1.duration_ = 4.23

		local var_79_0 = {
			ja = 4.233,
			ko = 3.1,
			zh = 2.8,
			en = 3.633
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
				arg_79_0:Play113172020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1041ui_story"]) and arg_79_1.var_.characterEffect1041ui_story == nil then
				arg_79_1.var_.characterEffect1041ui_story = arg_79_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1041ui_story"]) then
				if arg_79_1.var_.characterEffect1041ui_story and not isNil(arg_79_1.actors_["1041ui_story"]) then
					arg_79_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_0)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1041ui_story"]) and arg_79_1.var_.characterEffect1041ui_story then
				arg_79_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_82_1 = arg_79_1.actors_["10006ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect10006ui_story == nil then
				arg_79_1.var_.characterEffect10006ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect10006ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect10006ui_story then
				arg_79_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006actionlink/10006action446")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_82_4 = 0
			local var_82_5 = 0.3

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_6 = arg_79_1:GetWordFromCfg(113172019)
				local var_82_7 = arg_79_1:FormatText(var_82_6.content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 12 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 12)

				if (12 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 12)) > 0 and var_82_5 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172019", "story_v_out_113172.awb") ~= 0 then
					local var_82_10 = manager.audio:GetVoiceLength("story_v_out_113172", "113172019", "story_v_out_113172.awb") / 1000

					if var_82_10 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_4
					end

					if var_82_6.prefab_name ~= "" and arg_79_1.actors_[var_82_6.prefab_name] ~= nil then
						local var_82_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_6.prefab_name].transform, "story_v_out_113172", "113172019", "story_v_out_113172.awb")

						arg_79_1:RecordAudio("113172019", var_82_11)
						arg_79_1:RecordAudio("113172019", var_82_11)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_113172", "113172019", "story_v_out_113172.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_113172", "113172019", "story_v_out_113172.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_12 = math.max(var_82_5, arg_79_1.talkMaxDuration)

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_12 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_4) / var_82_12

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_4 + var_82_12 and arg_79_1.time_ < var_82_4 + var_82_12 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play113172020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 113172020
		arg_83_1.duration_ = 5.53

		local var_83_0 = {
			ja = 3.033,
			ko = 4.066,
			zh = 5.066,
			en = 5.533
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
				arg_83_0:Play113172021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos10006ui_story = arg_83_1.actors_["10006ui_story"].transform.localPosition
			end

			local var_86_0 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.actors_["10006ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10006ui_story, Vector3.New(0, 100, 0), (arg_83_1.time_ - 0) / var_86_0)
				arg_83_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["10006ui_story"].transform.position).z)
				arg_83_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["10006ui_story"].transform.localEulerAngles = arg_83_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["10006ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_83_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["10006ui_story"].transform.position).z)
				arg_83_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["10006ui_story"].transform.localEulerAngles = arg_83_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			local var_86_1 = arg_83_1.actors_["1041ui_story"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1041ui_story = var_86_1.localPosition
			end

			local var_86_2 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_2 then
				var_86_1.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_83_1.time_ - 0) / var_86_2)
				var_86_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_1.position).x, (manager.ui.mainCamera.transform.position - var_86_1.position).y, (manager.ui.mainCamera.transform.position - var_86_1.position).z)
				var_86_1.localEulerAngles.z = 0
				var_86_1.localEulerAngles.x = 0
				var_86_1.localEulerAngles = var_86_1.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_2 and arg_83_1.time_ < 0 + var_86_2 + arg_86_0 then
				var_86_1.localPosition = Vector3.New(0, 100, 0)
				var_86_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_1.position).x, (manager.ui.mainCamera.transform.position - var_86_1.position).y, (manager.ui.mainCamera.transform.position - var_86_1.position).z)
				var_86_1.localEulerAngles.z = 0
				var_86_1.localEulerAngles.x = 0
				var_86_1.localEulerAngles = var_86_1.localEulerAngles
			end

			local var_86_3 = manager.ui.mainCamera.transform

			if 2 < arg_83_1.time_ and arg_83_1.time_ <= 2 + arg_86_0 then
				arg_83_1.var_.shakeOldPos = var_86_3.localPosition
			end

			local var_86_4 = 0.6

			if 2 <= arg_83_1.time_ and arg_83_1.time_ < 2 + var_86_4 then
				local var_86_5, var_86_6 = math.modf((arg_83_1.time_ - 2) / 0.066)

				var_86_3.localPosition = Vector3.New(var_86_6 * 0.13, var_86_6 * 0.13, var_86_6 * 0.13) + arg_83_1.var_.shakeOldPos
			end

			if arg_83_1.time_ >= 2 + var_86_4 and arg_83_1.time_ < 2 + var_86_4 + arg_86_0 then
				var_86_3.localPosition = arg_83_1.var_.shakeOldPos
			end

			local var_86_7 = 0

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_7 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_8 = 2

			if var_86_7 <= arg_83_1.time_ and arg_83_1.time_ < var_86_7 + var_86_8 then
				local var_86_9 = Color.New(1, 1, 1)

				var_86_9.a = Mathf.Lerp(1, 0, (arg_83_1.time_ - var_86_7) / var_86_8)
				arg_83_1.mask_.color = var_86_9
			end

			if arg_83_1.time_ >= var_86_7 + var_86_8 and arg_83_1.time_ < var_86_7 + var_86_8 + arg_86_0 then
				local var_86_10 = Color.New(1, 1, 1)

				arg_83_1.mask_.enabled = false
				var_86_10.a = 0
				arg_83_1.mask_.color = var_86_10
			end

			if 0.766666666666667 < arg_83_1.time_ and arg_83_1.time_ <= 0.766666666666667 + arg_86_0 then
				arg_83_1:AudioAction("play", "effect", "se_story_10", "se_story_10_beat", "")
			end

			if arg_83_1.frameCnt_ <= 1 then
				arg_83_1.dialog_:SetActive(false)
			end

			local var_86_12 = 2
			local var_86_13 = 0.2

			if 2 < arg_83_1.time_ and arg_83_1.time_ <= var_86_12 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0

				arg_83_1.dialog_:SetActive(true)

				arg_83_1.dialogCg_.alpha = 0

				local var_86_14 = LeanTween.value(arg_83_1.dialog_, 0, 1, 0.3)

				var_86_14:setOnUpdate(LuaHelper.FloatAction(function(arg_87_0)
					arg_83_1.dialogCg_.alpha = arg_87_0
				end))
				var_86_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_83_1.dialog_)
					var_86_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_83_1.duration_ = arg_83_1.duration_ + 0.3

				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_15 = arg_83_1:GetWordFromCfg(113172020)
				local var_86_16 = arg_83_1:FormatText(var_86_15.content)

				arg_83_1.text_.text = var_86_16

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_18 = 8 <= 0 and var_86_13 or var_86_13 * (utf8.len(var_86_16) / 8)

				if (8 <= 0 and var_86_13 or var_86_13 * (utf8.len(var_86_16) / 8)) > 0 and var_86_13 < var_86_18 then
					arg_83_1.talkMaxDuration = var_86_18
					var_86_12 = var_86_12 + 0.3

					if var_86_18 + var_86_12 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_18 + var_86_12
					end
				end

				arg_83_1.text_.text = var_86_16
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172020", "story_v_out_113172.awb") ~= 0 then
					local var_86_19 = manager.audio:GetVoiceLength("story_v_out_113172", "113172020", "story_v_out_113172.awb") / 1000

					if var_86_19 + var_86_12 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_19 + var_86_12
					end

					if var_86_15.prefab_name ~= "" and arg_83_1.actors_[var_86_15.prefab_name] ~= nil then
						local var_86_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_15.prefab_name].transform, "story_v_out_113172", "113172020", "story_v_out_113172.awb")

						arg_83_1:RecordAudio("113172020", var_86_20)
						arg_83_1:RecordAudio("113172020", var_86_20)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_113172", "113172020", "story_v_out_113172.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_113172", "113172020", "story_v_out_113172.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_21 = var_86_12 + 0.3
			local var_86_22 = math.max(var_86_13, arg_83_1.talkMaxDuration)

			if var_86_12 + 0.3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_21 + var_86_22 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_21) / var_86_22

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_21 + var_86_22 and arg_83_1.time_ < var_86_21 + var_86_22 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play113172021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 113172021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play113172022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.875

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(113172021).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 35 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 35)

				if (35 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 35)) > 0 and var_92_0 < var_92_3 then
					arg_89_1.talkMaxDuration = var_92_3

					if var_92_3 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_3 + 0
					end
				end

				arg_89_1.text_.text = var_92_1
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_4 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_4

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play113172022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 113172022
		arg_93_1.duration_ = 3.63

		local var_93_0 = {
			ja = 2.2,
			ko = 3.633,
			zh = 1.933,
			en = 2.366
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
				arg_93_0:Play113172023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_96_0 = 0.6

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				local var_96_1, var_96_2 = math.modf((arg_93_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_96_2 * 0.13, var_96_2 * 0.13, var_96_2 * 0.13) + arg_93_1.var_.shakeOldPos
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				manager.ui.mainCamera.transform.localPosition = arg_93_1.var_.shakeOldPos
			end

			local var_96_3 = 0

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_3 + arg_96_0 then
				arg_93_1.allBtn_.enabled = false
			end

			if arg_93_1.time_ >= var_96_3 + 0.6 and arg_93_1.time_ < var_96_3 + 0.6 + arg_96_0 then
				arg_93_1.allBtn_.enabled = true
			end

			local var_96_4 = 0
			local var_96_5 = 0.225

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_6 = arg_93_1:GetWordFromCfg(113172022)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 9 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 9)

				if (9 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 9)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172022", "story_v_out_113172.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_113172", "113172022", "story_v_out_113172.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_113172", "113172022", "story_v_out_113172.awb")

						arg_93_1:RecordAudio("113172022", var_96_11)
						arg_93_1:RecordAudio("113172022", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_113172", "113172022", "story_v_out_113172.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_113172", "113172022", "story_v_out_113172.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_5, arg_93_1.talkMaxDuration)

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_4) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_4 + var_96_12 and arg_93_1.time_ < var_96_4 + var_96_12 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play113172023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 113172023
		arg_97_1.duration_ = 6.1

		local var_97_0 = {
			ja = 5.2,
			ko = 2.3,
			zh = 2.333,
			en = 6.1
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
				arg_97_0:Play113172024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10006ui_story = arg_97_1.actors_["10006ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["10006ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10006ui_story, Vector3.New(0, -0.98, -5.65), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10006ui_story"].transform.position).z)
				arg_97_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10006ui_story"].transform.localEulerAngles = arg_97_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["10006ui_story"].transform.localPosition = Vector3.New(0, -0.98, -5.65)
				arg_97_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10006ui_story"].transform.position).z)
				arg_97_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10006ui_story"].transform.localEulerAngles = arg_97_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action4_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_100_1 = arg_97_1.actors_["10006ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10006ui_story == nil then
				arg_97_1.var_.characterEffect10006ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect10006ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10006ui_story then
				arg_97_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_100_4 = 0
			local var_100_5 = 0.225

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(113172023)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 9 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 9)

				if (9 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 9)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172023", "story_v_out_113172.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_113172", "113172023", "story_v_out_113172.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_out_113172", "113172023", "story_v_out_113172.awb")

						arg_97_1:RecordAudio("113172023", var_100_11)
						arg_97_1:RecordAudio("113172023", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_113172", "113172023", "story_v_out_113172.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_113172", "113172023", "story_v_out_113172.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play113172024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 113172024
		arg_101_1.duration_ = 3.27

		local var_101_0 = {
			ja = 3.266,
			ko = 1.999999999999,
			zh = 2.966,
			en = 2.766
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
				arg_101_0:Play113172025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_104_0 = 0
			local var_104_1 = 0.2

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_2 = arg_101_1:GetWordFromCfg(113172024)
				local var_104_3 = arg_101_1:FormatText(var_104_2.content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 8 <= 0 and var_104_1 or var_104_1 * (utf8.len(var_104_3) / 8)

				if (8 <= 0 and var_104_1 or var_104_1 * (utf8.len(var_104_3) / 8)) > 0 and var_104_1 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172024", "story_v_out_113172.awb") ~= 0 then
					local var_104_6 = manager.audio:GetVoiceLength("story_v_out_113172", "113172024", "story_v_out_113172.awb") / 1000

					if var_104_6 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_0
					end

					if var_104_2.prefab_name ~= "" and arg_101_1.actors_[var_104_2.prefab_name] ~= nil then
						local var_104_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_2.prefab_name].transform, "story_v_out_113172", "113172024", "story_v_out_113172.awb")

						arg_101_1:RecordAudio("113172024", var_104_7)
						arg_101_1:RecordAudio("113172024", var_104_7)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_113172", "113172024", "story_v_out_113172.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_113172", "113172024", "story_v_out_113172.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_8 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_8 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_8

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_8 and arg_101_1.time_ < var_104_0 + var_104_8 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play113172025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 113172025
		arg_105_1.duration_ = 8.53

		local var_105_0 = {
			ja = 5.866,
			ko = 7.533,
			zh = 6.033,
			en = 8.533
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
				arg_105_0:Play113172026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006actionlink/10006action443")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_108_0 = 0
			local var_108_1 = 0.675

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_2 = arg_105_1:GetWordFromCfg(113172025)
				local var_108_3 = arg_105_1:FormatText(var_108_2.content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 27 <= 0 and var_108_1 or var_108_1 * (utf8.len(var_108_3) / 27)

				if (27 <= 0 and var_108_1 or var_108_1 * (utf8.len(var_108_3) / 27)) > 0 and var_108_1 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172025", "story_v_out_113172.awb") ~= 0 then
					local var_108_6 = manager.audio:GetVoiceLength("story_v_out_113172", "113172025", "story_v_out_113172.awb") / 1000

					if var_108_6 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_0
					end

					if var_108_2.prefab_name ~= "" and arg_105_1.actors_[var_108_2.prefab_name] ~= nil then
						local var_108_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_2.prefab_name].transform, "story_v_out_113172", "113172025", "story_v_out_113172.awb")

						arg_105_1:RecordAudio("113172025", var_108_7)
						arg_105_1:RecordAudio("113172025", var_108_7)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_113172", "113172025", "story_v_out_113172.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_113172", "113172025", "story_v_out_113172.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_8 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_8 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_8

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_8 and arg_105_1.time_ < var_108_0 + var_108_8 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play113172026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 113172026
		arg_109_1.duration_ = 6.47

		local var_109_0 = {
			ja = 6.466,
			ko = 3.166,
			zh = 2.9,
			en = 4.466
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
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play113172027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_112_0 = 0
			local var_112_1 = 0.35

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_2 = arg_109_1:GetWordFromCfg(113172026)
				local var_112_3 = arg_109_1:FormatText(var_112_2.content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 14 <= 0 and var_112_1 or var_112_1 * (utf8.len(var_112_3) / 14)

				if (14 <= 0 and var_112_1 or var_112_1 * (utf8.len(var_112_3) / 14)) > 0 and var_112_1 < var_112_5 then
					arg_109_1.talkMaxDuration = var_112_5

					if var_112_5 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172026", "story_v_out_113172.awb") ~= 0 then
					local var_112_6 = manager.audio:GetVoiceLength("story_v_out_113172", "113172026", "story_v_out_113172.awb") / 1000

					if var_112_6 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_0
					end

					if var_112_2.prefab_name ~= "" and arg_109_1.actors_[var_112_2.prefab_name] ~= nil then
						local var_112_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_2.prefab_name].transform, "story_v_out_113172", "113172026", "story_v_out_113172.awb")

						arg_109_1:RecordAudio("113172026", var_112_7)
						arg_109_1:RecordAudio("113172026", var_112_7)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_113172", "113172026", "story_v_out_113172.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_113172", "113172026", "story_v_out_113172.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_8 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_8 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_8

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_8 and arg_109_1.time_ < var_112_0 + var_112_8 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play113172027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 113172027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play113172028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10006ui_story = arg_113_1.actors_["10006ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["10006ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10006ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10006ui_story"].transform.position).z)
				arg_113_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10006ui_story"].transform.localEulerAngles = arg_113_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["10006ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10006ui_story"].transform.position).z)
				arg_113_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10006ui_story"].transform.localEulerAngles = arg_113_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			local var_116_1 = 0
			local var_116_2 = 0.725

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(113172027).content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 29 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 29)

				if (29 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 29)) > 0 and var_116_2 < var_116_5 then
					arg_113_1.talkMaxDuration = var_116_5

					if var_116_5 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_6 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_6 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_6

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_6 and arg_113_1.time_ < var_116_1 + var_116_6 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play113172028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 113172028
		arg_117_1.duration_ = 11.23

		local var_117_0 = {
			ja = 10.966,
			ko = 9.166,
			zh = 11.233,
			en = 8.333
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play113172029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10006ui_story = arg_117_1.actors_["10006ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["10006ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10006ui_story, Vector3.New(0, -0.98, -5.65), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10006ui_story"].transform.position).z)
				arg_117_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["10006ui_story"].transform.localEulerAngles = arg_117_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["10006ui_story"].transform.localPosition = Vector3.New(0, -0.98, -5.65)
				arg_117_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10006ui_story"].transform.position).z)
				arg_117_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["10006ui_story"].transform.localEulerAngles = arg_117_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action3_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_120_1 = arg_117_1.actors_["10006ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect10006ui_story == nil then
				arg_117_1.var_.characterEffect10006ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect10006ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect10006ui_story then
				arg_117_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_120_4 = 0
			local var_120_5 = 1.075

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(113172028)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 43 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 43)

				if (43 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 43)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172028", "story_v_out_113172.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_113172", "113172028", "story_v_out_113172.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_113172", "113172028", "story_v_out_113172.awb")

						arg_117_1:RecordAudio("113172028", var_120_11)
						arg_117_1:RecordAudio("113172028", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_113172", "113172028", "story_v_out_113172.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_113172", "113172028", "story_v_out_113172.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_12 = math.max(var_120_5, arg_117_1.talkMaxDuration)

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_12 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_4) / var_120_12

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_4 + var_120_12 and arg_117_1.time_ < var_120_4 + var_120_12 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play113172029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 113172029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play113172030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10006ui_story = arg_121_1.actors_["10006ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["10006ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10006ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10006ui_story"].transform.position).z)
				arg_121_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10006ui_story"].transform.localEulerAngles = arg_121_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["10006ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10006ui_story"].transform.position).z)
				arg_121_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10006ui_story"].transform.localEulerAngles = arg_121_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:AudioAction("play", "effect", "se_story_10", "se_story_10_snap", "")
			end

			local var_124_2 = 0
			local var_124_3 = 0.825

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_2 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_4 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(113172029).content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_6 = 33 <= 0 and var_124_3 or var_124_3 * (utf8.len(var_124_4) / 33)

				if (33 <= 0 and var_124_3 or var_124_3 * (utf8.len(var_124_4) / 33)) > 0 and var_124_3 < var_124_6 then
					arg_121_1.talkMaxDuration = var_124_6

					if var_124_6 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_6 + var_124_2
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_3, arg_121_1.talkMaxDuration)

			if var_124_2 <= arg_121_1.time_ and arg_121_1.time_ < var_124_2 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_2) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_2 + var_124_7 and arg_121_1.time_ < var_124_2 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play113172030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 113172030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play113172031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.85

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(113172030).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 34 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 34)

				if (34 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 34)) > 0 and var_128_0 < var_128_3 then
					arg_125_1.talkMaxDuration = var_128_3

					if var_128_3 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_3 + 0
					end
				end

				arg_125_1.text_.text = var_128_1
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_4 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_4

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play113172031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 113172031
		arg_129_1.duration_ = 8.97

		local var_129_0 = {
			ja = 8.8,
			ko = 8.466,
			zh = 8.966,
			en = 8.833
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
				arg_129_0:Play113172032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10006ui_story = arg_129_1.actors_["10006ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["10006ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10006ui_story, Vector3.New(0, -0.98, -5.65), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10006ui_story"].transform.position).z)
				arg_129_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["10006ui_story"].transform.localEulerAngles = arg_129_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["10006ui_story"].transform.localPosition = Vector3.New(0, -0.98, -5.65)
				arg_129_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10006ui_story"].transform.position).z)
				arg_129_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["10006ui_story"].transform.localEulerAngles = arg_129_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action4_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_132_1 = arg_129_1.actors_["10006ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect10006ui_story == nil then
				arg_129_1.var_.characterEffect10006ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect10006ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect10006ui_story then
				arg_129_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_132_4 = 0
			local var_132_5 = 1.025

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(113172031)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 41 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 41)

				if (41 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 41)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172031", "story_v_out_113172.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_out_113172", "113172031", "story_v_out_113172.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_out_113172", "113172031", "story_v_out_113172.awb")

						arg_129_1:RecordAudio("113172031", var_132_11)
						arg_129_1:RecordAudio("113172031", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_113172", "113172031", "story_v_out_113172.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_113172", "113172031", "story_v_out_113172.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_12 = math.max(var_132_5, arg_129_1.talkMaxDuration)

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_12 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_4) / var_132_12

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_4 + var_132_12 and arg_129_1.time_ < var_132_4 + var_132_12 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play113172032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 113172032
		arg_133_1.duration_ = 11.7

		local var_133_0 = {
			ja = 11.7,
			ko = 8.4,
			zh = 10.3,
			en = 9.633
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play113172033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006actionlink/10006action443")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_136_0 = 0
			local var_136_1 = 1.1

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_2 = arg_133_1:GetWordFromCfg(113172032)
				local var_136_3 = arg_133_1:FormatText(var_136_2.content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 44 <= 0 and var_136_1 or var_136_1 * (utf8.len(var_136_3) / 44)

				if (44 <= 0 and var_136_1 or var_136_1 * (utf8.len(var_136_3) / 44)) > 0 and var_136_1 < var_136_5 then
					arg_133_1.talkMaxDuration = var_136_5

					if var_136_5 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172032", "story_v_out_113172.awb") ~= 0 then
					local var_136_6 = manager.audio:GetVoiceLength("story_v_out_113172", "113172032", "story_v_out_113172.awb") / 1000

					if var_136_6 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_0
					end

					if var_136_2.prefab_name ~= "" and arg_133_1.actors_[var_136_2.prefab_name] ~= nil then
						local var_136_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_2.prefab_name].transform, "story_v_out_113172", "113172032", "story_v_out_113172.awb")

						arg_133_1:RecordAudio("113172032", var_136_7)
						arg_133_1:RecordAudio("113172032", var_136_7)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_113172", "113172032", "story_v_out_113172.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_113172", "113172032", "story_v_out_113172.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_8 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_8 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_8

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_8 and arg_133_1.time_ < var_136_0 + var_136_8 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play113172033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 113172033
		arg_137_1.duration_ = 11.6

		local var_137_0 = {
			ja = 11.6,
			ko = 6.966,
			zh = 7.8,
			en = 10.6
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play113172034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_140_0 = 0
			local var_140_1 = 0.875

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_2 = arg_137_1:GetWordFromCfg(113172033)
				local var_140_3 = arg_137_1:FormatText(var_140_2.content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 35 <= 0 and var_140_1 or var_140_1 * (utf8.len(var_140_3) / 35)

				if (35 <= 0 and var_140_1 or var_140_1 * (utf8.len(var_140_3) / 35)) > 0 and var_140_1 < var_140_5 then
					arg_137_1.talkMaxDuration = var_140_5

					if var_140_5 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172033", "story_v_out_113172.awb") ~= 0 then
					local var_140_6 = manager.audio:GetVoiceLength("story_v_out_113172", "113172033", "story_v_out_113172.awb") / 1000

					if var_140_6 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_0
					end

					if var_140_2.prefab_name ~= "" and arg_137_1.actors_[var_140_2.prefab_name] ~= nil then
						local var_140_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_2.prefab_name].transform, "story_v_out_113172", "113172033", "story_v_out_113172.awb")

						arg_137_1:RecordAudio("113172033", var_140_7)
						arg_137_1:RecordAudio("113172033", var_140_7)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_113172", "113172033", "story_v_out_113172.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_113172", "113172033", "story_v_out_113172.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_8 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_8 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_8

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_8 and arg_137_1.time_ < var_140_0 + var_140_8 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play113172034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 113172034
		arg_141_1.duration_ = 9

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play113172035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.mask_.enabled = true
				arg_141_1.mask_.raycastTarget = true

				arg_141_1:SetGaussion(false)
			end

			local var_144_0 = 2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				local var_144_1 = Color.New(0, 0, 0)

				var_144_1.a = Mathf.Lerp(0, 1, (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.mask_.color = var_144_1
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				local var_144_2 = Color.New(0, 0, 0)

				var_144_2.a = 1
				arg_141_1.mask_.color = var_144_2
			end

			local var_144_3 = 2

			if 2 < arg_141_1.time_ and arg_141_1.time_ <= var_144_3 + arg_144_0 then
				arg_141_1.mask_.enabled = true
				arg_141_1.mask_.raycastTarget = true

				arg_141_1:SetGaussion(false)
			end

			local var_144_4 = 2

			if var_144_3 <= arg_141_1.time_ and arg_141_1.time_ < var_144_3 + var_144_4 then
				local var_144_5 = Color.New(1, 1, 1)

				var_144_5.a = Mathf.Lerp(1, 0, (arg_141_1.time_ - var_144_3) / var_144_4)
				arg_141_1.mask_.color = var_144_5
			end

			if arg_141_1.time_ >= var_144_3 + var_144_4 and arg_141_1.time_ < var_144_3 + var_144_4 + arg_144_0 then
				local var_144_6 = Color.New(1, 1, 1)

				arg_141_1.mask_.enabled = false
				var_144_6.a = 0
				arg_141_1.mask_.color = var_144_6
			end

			local var_144_7 = "OM0105"

			if arg_141_1.bgs_.OM0105 == nil then
				local var_144_8 = Object.Instantiate(arg_141_1.paintGo_)

				var_144_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_144_7)
				var_144_8.name = var_144_7
				var_144_8.transform.parent = arg_141_1.stage_.transform
				var_144_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_141_1.bgs_[var_144_7] = var_144_8
			end

			if 2 < arg_141_1.time_ and arg_141_1.time_ <= 2 + arg_144_0 then
				local var_144_9 = arg_141_1.bgs_.OM0105

				arg_141_1.bgs_.OM0105.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_144_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_144_10 = var_144_9:GetComponent("SpriteRenderer")

				if var_144_10 and var_144_10.sprite then
					local var_144_11 = 2 * (var_144_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_144_9.transform.localScale = Vector3.New(var_144_11 / var_144_10.sprite.bounds.size.y < var_144_11 * manager.ui.mainCameraCom_.aspect / var_144_10.sprite.bounds.size.x and var_144_11 * manager.ui.mainCameraCom_.aspect / var_144_10.sprite.bounds.size.x or var_144_11 / var_144_10.sprite.bounds.size.y, var_144_11 / var_144_10.sprite.bounds.size.y < var_144_11 * manager.ui.mainCameraCom_.aspect / var_144_10.sprite.bounds.size.x and var_144_11 * manager.ui.mainCameraCom_.aspect / var_144_10.sprite.bounds.size.x or var_144_11 / var_144_10.sprite.bounds.size.y, 0)
				end

				for iter_144_0, iter_144_1 in pairs(arg_141_1.bgs_) do
					if iter_144_0 ~= "OM0105" then
						iter_144_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_144_12 = arg_141_1.actors_["10006ui_story"].transform

			if 1.966 < arg_141_1.time_ and arg_141_1.time_ <= 1.966 + arg_144_0 then
				arg_141_1.var_.moveOldPos10006ui_story = var_144_12.localPosition
			end

			local var_144_13 = 0.001

			if 1.966 <= arg_141_1.time_ and arg_141_1.time_ < 1.966 + var_144_13 then
				var_144_12.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10006ui_story, Vector3.New(0, 100, 0), (arg_141_1.time_ - 1.966) / var_144_13)
				var_144_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_12.position).x, (manager.ui.mainCamera.transform.position - var_144_12.position).y, (manager.ui.mainCamera.transform.position - var_144_12.position).z)
				var_144_12.localEulerAngles.z = 0
				var_144_12.localEulerAngles.x = 0
				var_144_12.localEulerAngles = var_144_12.localEulerAngles
			end

			if arg_141_1.time_ >= 1.966 + var_144_13 and arg_141_1.time_ < 1.966 + var_144_13 + arg_144_0 then
				var_144_12.localPosition = Vector3.New(0, 100, 0)
				var_144_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_12.position).x, (manager.ui.mainCamera.transform.position - var_144_12.position).y, (manager.ui.mainCamera.transform.position - var_144_12.position).z)
				var_144_12.localEulerAngles.z = 0
				var_144_12.localEulerAngles.x = 0
				var_144_12.localEulerAngles = var_144_12.localEulerAngles
			end

			local var_144_14 = arg_141_1.bgs_.OM0105.transform

			if 2 < arg_141_1.time_ and arg_141_1.time_ <= 2 + arg_144_0 then
				arg_141_1.var_.moveOldPosOM0105 = var_144_14.localPosition
			end

			local var_144_15 = 0.001

			if 2 <= arg_141_1.time_ and arg_141_1.time_ < 2 + var_144_15 then
				var_144_14.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPosOM0105, Vector3.New(0, 1, 9), (arg_141_1.time_ - 2) / var_144_15)
			end

			if arg_141_1.time_ >= 2 + var_144_15 and arg_141_1.time_ < 2 + var_144_15 + arg_144_0 then
				var_144_14.localPosition = Vector3.New(0, 1, 9)
			end

			local var_144_16 = arg_141_1.bgs_.OM0105.transform

			if 2.034 < arg_141_1.time_ and arg_141_1.time_ <= 2.034 + arg_144_0 then
				arg_141_1.var_.moveOldPosOM0105 = var_144_16.localPosition
			end

			local var_144_17 = 3.5

			if 2.034 <= arg_141_1.time_ and arg_141_1.time_ < 2.034 + var_144_17 then
				var_144_16.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPosOM0105, Vector3.New(0, 1, 10), (arg_141_1.time_ - 2.034) / var_144_17)
			end

			if arg_141_1.time_ >= 2.034 + var_144_17 and arg_141_1.time_ < 2.034 + var_144_17 + arg_144_0 then
				var_144_16.localPosition = Vector3.New(0, 1, 10)
			end

			local var_144_18 = 4

			if 4 < arg_141_1.time_ and arg_141_1.time_ <= var_144_18 + arg_144_0 then
				arg_141_1.allBtn_.enabled = false
			end

			if arg_141_1.time_ >= var_144_18 + 1.534 and arg_141_1.time_ < var_144_18 + 1.534 + arg_144_0 then
				arg_141_1.allBtn_.enabled = true
			end

			if arg_141_1.frameCnt_ <= 1 then
				arg_141_1.dialog_:SetActive(false)
			end

			local var_144_19 = 4
			local var_144_20 = 0.725

			if 4 < arg_141_1.time_ and arg_141_1.time_ <= var_144_19 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				arg_141_1.dialog_:SetActive(true)

				arg_141_1.dialogCg_.alpha = 0

				local var_144_21 = LeanTween.value(arg_141_1.dialog_, 0, 1, 0.3)

				var_144_21:setOnUpdate(LuaHelper.FloatAction(function(arg_145_0)
					arg_141_1.dialogCg_.alpha = arg_145_0
				end))
				var_144_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_141_1.dialog_)
					var_144_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_141_1.duration_ = arg_141_1.duration_ + 0.3

				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_22 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(113172034).content)

				arg_141_1.text_.text = var_144_22

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_24 = 29 <= 0 and var_144_20 or var_144_20 * (utf8.len(var_144_22) / 29)

				if (29 <= 0 and var_144_20 or var_144_20 * (utf8.len(var_144_22) / 29)) > 0 and var_144_20 < var_144_24 then
					arg_141_1.talkMaxDuration = var_144_24
					var_144_19 = var_144_19 + 0.3

					if var_144_24 + var_144_19 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_24 + var_144_19
					end
				end

				arg_141_1.text_.text = var_144_22
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_25 = var_144_19 + 0.3
			local var_144_26 = math.max(var_144_20, arg_141_1.talkMaxDuration)

			if var_144_19 + 0.3 <= arg_141_1.time_ and arg_141_1.time_ < var_144_25 + var_144_26 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_25) / var_144_26

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_25 + var_144_26 and arg_141_1.time_ < var_144_25 + var_144_26 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "OM0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play113172035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 113172035
		arg_147_1.duration_ = 5.57

		local var_147_0 = {
			ja = 5.066,
			ko = 3.7,
			zh = 5.566,
			en = 4.533
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play113172036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.4

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:GetWordFromCfg(113172035)
				local var_150_2 = arg_147_1:FormatText(var_150_1.content)

				arg_147_1.text_.text = var_150_2

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 16 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 16)

				if (16 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 16)) > 0 and var_150_0 < var_150_4 then
					arg_147_1.talkMaxDuration = var_150_4

					if var_150_4 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_4 + 0
					end
				end

				arg_147_1.text_.text = var_150_2
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172035", "story_v_out_113172.awb") ~= 0 then
					local var_150_5 = manager.audio:GetVoiceLength("story_v_out_113172", "113172035", "story_v_out_113172.awb") / 1000

					if var_150_5 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + 0
					end

					if var_150_1.prefab_name ~= "" and arg_147_1.actors_[var_150_1.prefab_name] ~= nil then
						local var_150_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_1.prefab_name].transform, "story_v_out_113172", "113172035", "story_v_out_113172.awb")

						arg_147_1:RecordAudio("113172035", var_150_6)
						arg_147_1:RecordAudio("113172035", var_150_6)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_113172", "113172035", "story_v_out_113172.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_113172", "113172035", "story_v_out_113172.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play113172036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 113172036
		arg_151_1.duration_ = 6.5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play113172037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_154_0 = 1.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				local var_154_1, var_154_2 = math.modf((arg_151_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_154_2 * 0.13, var_154_2 * 0.13, var_154_2 * 0.13) + arg_151_1.var_.shakeOldPos
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				manager.ui.mainCamera.transform.localPosition = arg_151_1.var_.shakeOldPos
			end

			local var_154_3 = 0

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_3 + arg_154_0 then
				arg_151_1.allBtn_.enabled = false
			end

			if arg_151_1.time_ >= var_154_3 + 1.5 and arg_151_1.time_ < var_154_3 + 1.5 + arg_154_0 then
				arg_151_1.allBtn_.enabled = true
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:AudioAction("play", "effect", "se_story_10", "se_story_10_light", "")
			end

			if arg_151_1.frameCnt_ <= 1 then
				arg_151_1.dialog_:SetActive(false)
			end

			local var_154_5 = 1.5
			local var_154_6 = 1.3

			if 1.5 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0

				arg_151_1.dialog_:SetActive(true)

				arg_151_1.dialogCg_.alpha = 0

				local var_154_7 = LeanTween.value(arg_151_1.dialog_, 0, 1, 0.3)

				var_154_7:setOnUpdate(LuaHelper.FloatAction(function(arg_155_0)
					arg_151_1.dialogCg_.alpha = arg_155_0
				end))
				var_154_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_151_1.dialog_)
					var_154_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_151_1.duration_ = arg_151_1.duration_ + 0.3

				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_8 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(113172036).content)

				arg_151_1.text_.text = var_154_8

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_10 = 52 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 52)

				if (52 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 52)) > 0 and var_154_6 < var_154_10 then
					arg_151_1.talkMaxDuration = var_154_10
					var_154_5 = var_154_5 + 0.3

					if var_154_10 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_5
					end
				end

				arg_151_1.text_.text = var_154_8
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_11 = var_154_5 + 0.3
			local var_154_12 = math.max(var_154_6, arg_151_1.talkMaxDuration)

			if var_154_5 + 0.3 <= arg_151_1.time_ and arg_151_1.time_ < var_154_11 + var_154_12 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_11) / var_154_12

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_11 + var_154_12 and arg_151_1.time_ < var_154_11 + var_154_12 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play113172037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 113172037
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play113172038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:AudioAction("play", "effect", "se_story_10", "se_story_10_crack", "")
			end

			local var_160_1 = 0
			local var_160_2 = 0.55

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(113172037).content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 22 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 22)

				if (22 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 22)) > 0 and var_160_2 < var_160_5 then
					arg_157_1.talkMaxDuration = var_160_5

					if var_160_5 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + var_160_1
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_6 = math.max(var_160_2, arg_157_1.talkMaxDuration)

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_6 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_1) / var_160_6

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_1 + var_160_6 and arg_157_1.time_ < var_160_1 + var_160_6 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play113172038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 113172038
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play113172039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:AudioAction("play", "effect", "se_story_10", "se_story_10_fog02", "")
			end

			local var_164_1 = 0
			local var_164_2 = 0.725

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_3 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(113172038).content)

				arg_161_1.text_.text = var_164_3

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 29 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_3) / 29)

				if (29 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_3) / 29)) > 0 and var_164_2 < var_164_5 then
					arg_161_1.talkMaxDuration = var_164_5

					if var_164_5 + var_164_1 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + var_164_1
					end
				end

				arg_161_1.text_.text = var_164_3
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_6 = math.max(var_164_2, arg_161_1.talkMaxDuration)

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_6 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_1) / var_164_6

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_1 + var_164_6 and arg_161_1.time_ < var_164_1 + var_164_6 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play113172039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 113172039
		arg_165_1.duration_ = 6.9

		local var_165_0 = {
			ja = 6.433,
			ko = 3.6,
			zh = 6.166,
			en = 6.9
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play113172040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.3

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:GetWordFromCfg(113172039)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 12 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 12)

				if (12 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 12)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172039", "story_v_out_113172.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_out_113172", "113172039", "story_v_out_113172.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_out_113172", "113172039", "story_v_out_113172.awb")

						arg_165_1:RecordAudio("113172039", var_168_6)
						arg_165_1:RecordAudio("113172039", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_113172", "113172039", "story_v_out_113172.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_113172", "113172039", "story_v_out_113172.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play113172040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 113172040
		arg_169_1.duration_ = 5.8

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play113172041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_172_0 = 0.6

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				local var_172_1, var_172_2 = math.modf((arg_169_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_172_2 * 0.13, var_172_2 * 0.13, var_172_2 * 0.13) + arg_169_1.var_.shakeOldPos
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				manager.ui.mainCamera.transform.localPosition = arg_169_1.var_.shakeOldPos
			end

			local var_172_3 = 0

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_3 + arg_172_0 then
				arg_169_1.allBtn_.enabled = false
			end

			if arg_169_1.time_ >= var_172_3 + 0.8 and arg_169_1.time_ < var_172_3 + 0.8 + arg_172_0 then
				arg_169_1.allBtn_.enabled = true
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:AudioAction("play", "effect", "se_story_10", "se_story_10_fall", "")
			end

			if arg_169_1.frameCnt_ <= 1 then
				arg_169_1.dialog_:SetActive(false)
			end

			local var_172_5 = 0.8
			local var_172_6 = 0.425

			if 0.8 < arg_169_1.time_ and arg_169_1.time_ <= var_172_5 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				arg_169_1.dialog_:SetActive(true)

				arg_169_1.dialogCg_.alpha = 0

				local var_172_7 = LeanTween.value(arg_169_1.dialog_, 0, 1, 0.3)

				var_172_7:setOnUpdate(LuaHelper.FloatAction(function(arg_173_0)
					arg_169_1.dialogCg_.alpha = arg_173_0
				end))
				var_172_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_169_1.dialog_)
					var_172_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_169_1.duration_ = arg_169_1.duration_ + 0.3

				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_8 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(113172040).content)

				arg_169_1.text_.text = var_172_8

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_10 = 17 <= 0 and var_172_6 or var_172_6 * (utf8.len(var_172_8) / 17)

				if (17 <= 0 and var_172_6 or var_172_6 * (utf8.len(var_172_8) / 17)) > 0 and var_172_6 < var_172_10 then
					arg_169_1.talkMaxDuration = var_172_10
					var_172_5 = var_172_5 + 0.3

					if var_172_10 + var_172_5 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_5
					end
				end

				arg_169_1.text_.text = var_172_8
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_11 = var_172_5 + 0.3
			local var_172_12 = math.max(var_172_6, arg_169_1.talkMaxDuration)

			if var_172_5 + 0.3 <= arg_169_1.time_ and arg_169_1.time_ < var_172_11 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_11) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_11 + var_172_12 and arg_169_1.time_ < var_172_11 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play113172041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 113172041
		arg_175_1.duration_ = 9.1

		local var_175_0 = {
			ja = 6.733,
			ko = 4.633,
			zh = 5.6,
			en = 9.1
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play113172042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.575

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:GetWordFromCfg(113172041)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 23 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 23)

				if (23 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 23)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172041", "story_v_out_113172.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_113172", "113172041", "story_v_out_113172.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_113172", "113172041", "story_v_out_113172.awb")

						arg_175_1:RecordAudio("113172041", var_178_6)
						arg_175_1:RecordAudio("113172041", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_113172", "113172041", "story_v_out_113172.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_113172", "113172041", "story_v_out_113172.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play113172042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 113172042
		arg_179_1.duration_ = 4.6

		local var_179_0 = {
			ja = 4.6,
			ko = 2.9,
			zh = 2.633,
			en = 4.4
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play113172043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.2

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:GetWordFromCfg(113172042)
				local var_182_2 = arg_179_1:FormatText(var_182_1.content)

				arg_179_1.text_.text = var_182_2

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 8 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 8)

				if (8 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 8)) > 0 and var_182_0 < var_182_4 then
					arg_179_1.talkMaxDuration = var_182_4

					if var_182_4 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_4 + 0
					end
				end

				arg_179_1.text_.text = var_182_2
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172042", "story_v_out_113172.awb") ~= 0 then
					local var_182_5 = manager.audio:GetVoiceLength("story_v_out_113172", "113172042", "story_v_out_113172.awb") / 1000

					if var_182_5 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + 0
					end

					if var_182_1.prefab_name ~= "" and arg_179_1.actors_[var_182_1.prefab_name] ~= nil then
						local var_182_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_1.prefab_name].transform, "story_v_out_113172", "113172042", "story_v_out_113172.awb")

						arg_179_1:RecordAudio("113172042", var_182_6)
						arg_179_1:RecordAudio("113172042", var_182_6)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_113172", "113172042", "story_v_out_113172.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_113172", "113172042", "story_v_out_113172.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play113172043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 113172043
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play113172044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.6

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(113172043).content)

				arg_183_1.text_.text = var_186_1

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_3 = 24 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 24)

				if (24 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 24)) > 0 and var_186_0 < var_186_3 then
					arg_183_1.talkMaxDuration = var_186_3

					if var_186_3 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_3 + 0
					end
				end

				arg_183_1.text_.text = var_186_1
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_4 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_4

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play113172044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 113172044
		arg_187_1.duration_ = 8.1

		local var_187_0 = {
			ja = 7.6,
			ko = 4.833,
			zh = 6.666,
			en = 8.1
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
			arg_187_1.auto_ = false
		end

		function arg_187_1.playNext_(arg_189_0)
			arg_187_1.onStoryFinished_()
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.525

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:GetWordFromCfg(113172044)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 21 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 21)

				if (21 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 21)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172044", "story_v_out_113172.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_out_113172", "113172044", "story_v_out_113172.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_out_113172", "113172044", "story_v_out_113172.awb")

						arg_187_1:RecordAudio("113172044", var_190_6)
						arg_187_1:RecordAudio("113172044", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_113172", "113172044", "story_v_out_113172.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_113172", "113172044", "story_v_out_113172.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/OM0104",
		"TextureConfig/Background/F03b",
		"TextureConfig/Background/OM0105"
	},
	voices = {
		"story_v_out_113172.awb"
	}
}
