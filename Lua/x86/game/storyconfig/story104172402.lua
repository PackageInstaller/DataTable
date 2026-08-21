return {
	Play417242001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417242001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play417242002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 2

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 0.7

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = "I17f"

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
				local var_4_7 = arg_1_1.bgs_.I17f

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
					if iter_4_0 ~= "I17f" then
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

			local var_4_24 = 2
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_120_00", "se_story_120_00_sword02", "")
			end

			local var_4_28 = 0.02
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "effect"

				arg_1_1:AudioAction(var_4_30, var_4_31, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_4_32 = 0
			local var_4_33 = 0.2

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_37 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_37 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_37

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_37
						arg_1_1.bgmTxt2_.text = var_4_37
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

			local var_4_38 = 2
			local var_4_39 = 1.525

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_41 = arg_1_1:GetWordFromCfg(417242001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 61
				local var_4_44 = utf8.len(var_4_42)
				local var_4_45 = var_4_43 <= 0 and var_4_39 or var_4_39 * (var_4_44 / var_4_43)

				if var_4_45 > 0 and var_4_39 < var_4_45 then
					arg_1_1.talkMaxDuration = var_4_45
					var_4_38 = var_4_38 + 0.3

					if var_4_45 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_42
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_46 = var_4_38 + 0.3
			local var_4_47 = math.max(var_4_39, arg_1_1.talkMaxDuration)

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

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play417242002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 417242002
		arg_8_1.duration_ = 4.53

		local var_8_0 = {
			zh = 2,
			ja = 4.533
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
				arg_8_0:Play417242003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1034"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(var_11_1, arg_8_1.canvasGo_.transform)

					var_11_2.transform:SetSiblingIndex(1)

					var_11_2.name = var_11_0
					var_11_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_8_1.actors_[var_11_0] = var_11_2

					local var_11_3 = var_11_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_8_1.isInRecall_ then
						for iter_11_0, iter_11_1 in ipairs(var_11_3) do
							iter_11_1.color = arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_11_4 = arg_8_1.actors_["1034"]
			local var_11_5 = 0

			if var_11_5 < arg_8_1.time_ and arg_8_1.time_ <= var_11_5 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.actorSpriteComps1034 == nil then
				arg_8_1.var_.actorSpriteComps1034 = var_11_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_6 = 0.2

			if var_11_5 <= arg_8_1.time_ and arg_8_1.time_ < var_11_5 + var_11_6 and not isNil(var_11_4) then
				local var_11_7 = (arg_8_1.time_ - var_11_5) / var_11_6

				if arg_8_1.var_.actorSpriteComps1034 then
					for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_11_3 then
							if arg_8_1.isInRecall_ then
								local var_11_8 = Mathf.Lerp(iter_11_3.color.r, arg_8_1.hightColor1.r, var_11_7)
								local var_11_9 = Mathf.Lerp(iter_11_3.color.g, arg_8_1.hightColor1.g, var_11_7)
								local var_11_10 = Mathf.Lerp(iter_11_3.color.b, arg_8_1.hightColor1.b, var_11_7)

								iter_11_3.color = Color.New(var_11_8, var_11_9, var_11_10)
							else
								local var_11_11 = Mathf.Lerp(iter_11_3.color.r, 1, var_11_7)

								iter_11_3.color = Color.New(var_11_11, var_11_11, var_11_11)
							end
						end
					end
				end
			end

			if arg_8_1.time_ >= var_11_5 + var_11_6 and arg_8_1.time_ < var_11_5 + var_11_6 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.actorSpriteComps1034 then
				for iter_11_4, iter_11_5 in pairs(arg_8_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_11_5 then
						if arg_8_1.isInRecall_ then
							iter_11_5.color = arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_11_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_8_1.var_.actorSpriteComps1034 = nil
			end

			local var_11_12 = arg_8_1.actors_["1034"].transform
			local var_11_13 = 0

			if var_11_13 < arg_8_1.time_ and arg_8_1.time_ <= var_11_13 + arg_11_0 then
				arg_8_1.var_.moveOldPos1034 = var_11_12.localPosition
				var_11_12.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("1034", 3)

				local var_11_14 = var_11_12.childCount

				for iter_11_6 = 0, var_11_14 - 1 do
					local var_11_15 = var_11_12:GetChild(iter_11_6)

					if var_11_15.name == "split_4" or not string.find(var_11_15.name, "split") then
						var_11_15.gameObject:SetActive(true)
					else
						var_11_15.gameObject:SetActive(false)
					end
				end
			end

			local var_11_16 = 0.001

			if var_11_13 <= arg_8_1.time_ and arg_8_1.time_ < var_11_13 + var_11_16 then
				local var_11_17 = (arg_8_1.time_ - var_11_13) / var_11_16
				local var_11_18 = Vector3.New(0, -331.9, -324)

				var_11_12.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1034, var_11_18, var_11_17)
			end

			if arg_8_1.time_ >= var_11_13 + var_11_16 and arg_8_1.time_ < var_11_13 + var_11_16 + arg_11_0 then
				var_11_12.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_11_19 = 0
			local var_11_20 = 0.2

			if var_11_19 < arg_8_1.time_ and arg_8_1.time_ <= var_11_19 + arg_11_0 then
				local var_11_21 = "play"
				local var_11_22 = "music"

				arg_8_1:AudioAction(var_11_21, var_11_22, "ui_battle", "ui_battle_stopbgm", "")

				local var_11_23 = ""
				local var_11_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_11_24 ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_24 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_24

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_24
						arg_8_1.bgmTxt2_.text = var_11_24
					end

					if arg_8_1.bgmTimer then
						arg_8_1.bgmTimer:Stop()

						arg_8_1.bgmTimer = nil
					end

					if arg_8_1.settingData.show_music_name == 1 then
						arg_8_1.musicController:SetSelectedState("show")
						arg_8_1.musicAnimator_:Play("open", 0, 0)

						if arg_8_1.settingData.music_time ~= 0 then
							arg_8_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_8_1.settingData.music_time), function()
								if arg_8_1 == nil or isNil(arg_8_1.bgmTxt_) then
									return
								end

								arg_8_1.musicController:SetSelectedState("hide")
								arg_8_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_11_25 = 0.4
			local var_11_26 = 1

			if var_11_25 < arg_8_1.time_ and arg_8_1.time_ <= var_11_25 + arg_11_0 then
				local var_11_27 = "play"
				local var_11_28 = "music"

				arg_8_1:AudioAction(var_11_27, var_11_28, "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1.awb")

				local var_11_29 = ""
				local var_11_30 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1")

				if var_11_30 ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_30 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_30

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_30
						arg_8_1.bgmTxt2_.text = var_11_30
					end

					if arg_8_1.bgmTimer then
						arg_8_1.bgmTimer:Stop()

						arg_8_1.bgmTimer = nil
					end

					if arg_8_1.settingData.show_music_name == 1 then
						arg_8_1.musicController:SetSelectedState("show")
						arg_8_1.musicAnimator_:Play("open", 0, 0)

						if arg_8_1.settingData.music_time ~= 0 then
							arg_8_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_8_1.settingData.music_time), function()
								if arg_8_1 == nil or isNil(arg_8_1.bgmTxt_) then
									return
								end

								arg_8_1.musicController:SetSelectedState("hide")
								arg_8_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_11_31 = 0
			local var_11_32 = 0.275

			if var_11_31 < arg_8_1.time_ and arg_8_1.time_ <= var_11_31 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_33 = arg_8_1:FormatText(StoryNameCfg[1109].name)

				arg_8_1.leftNameTxt_.text = var_11_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_34 = arg_8_1:GetWordFromCfg(417242002)
				local var_11_35 = arg_8_1:FormatText(var_11_34.content)

				arg_8_1.text_.text = var_11_35

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_36 = 11
				local var_11_37 = utf8.len(var_11_35)
				local var_11_38 = var_11_36 <= 0 and var_11_32 or var_11_32 * (var_11_37 / var_11_36)

				if var_11_38 > 0 and var_11_32 < var_11_38 then
					arg_8_1.talkMaxDuration = var_11_38

					if var_11_38 + var_11_31 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_38 + var_11_31
					end
				end

				arg_8_1.text_.text = var_11_35
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242002", "story_v_out_417242.awb") ~= 0 then
					local var_11_39 = manager.audio:GetVoiceLength("story_v_out_417242", "417242002", "story_v_out_417242.awb") / 1000

					if var_11_39 + var_11_31 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_39 + var_11_31
					end

					if var_11_34.prefab_name ~= "" and arg_8_1.actors_[var_11_34.prefab_name] ~= nil then
						local var_11_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_34.prefab_name].transform, "story_v_out_417242", "417242002", "story_v_out_417242.awb")

						arg_8_1:RecordAudio("417242002", var_11_40)
						arg_8_1:RecordAudio("417242002", var_11_40)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_417242", "417242002", "story_v_out_417242.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_417242", "417242002", "story_v_out_417242.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_41 = math.max(var_11_32, arg_8_1.talkMaxDuration)

			if var_11_31 <= arg_8_1.time_ and arg_8_1.time_ < var_11_31 + var_11_41 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_31) / var_11_41

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_31 + var_11_41 and arg_8_1.time_ < var_11_31 + var_11_41 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play417242003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417242003
		arg_14_1.duration_ = 1.87

		local var_14_0 = {
			zh = 1.866,
			ja = 1.4
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
				arg_14_0:Play417242004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = "10128"

			if arg_14_1.actors_[var_17_0] == nil then
				local var_17_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_17_1) then
					local var_17_2 = Object.Instantiate(var_17_1, arg_14_1.canvasGo_.transform)

					var_17_2.transform:SetSiblingIndex(1)

					var_17_2.name = var_17_0
					var_17_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_14_1.actors_[var_17_0] = var_17_2

					local var_17_3 = var_17_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_14_1.isInRecall_ then
						for iter_17_0, iter_17_1 in ipairs(var_17_3) do
							iter_17_1.color = arg_14_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_17_4 = arg_14_1.actors_["10128"]
			local var_17_5 = 0

			if var_17_5 < arg_14_1.time_ and arg_14_1.time_ <= var_17_5 + arg_17_0 and not isNil(var_17_4) and arg_14_1.var_.actorSpriteComps10128 == nil then
				arg_14_1.var_.actorSpriteComps10128 = var_17_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_6 = 0.2

			if var_17_5 <= arg_14_1.time_ and arg_14_1.time_ < var_17_5 + var_17_6 and not isNil(var_17_4) then
				local var_17_7 = (arg_14_1.time_ - var_17_5) / var_17_6

				if arg_14_1.var_.actorSpriteComps10128 then
					for iter_17_2, iter_17_3 in pairs(arg_14_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_17_3 then
							if arg_14_1.isInRecall_ then
								local var_17_8 = Mathf.Lerp(iter_17_3.color.r, arg_14_1.hightColor1.r, var_17_7)
								local var_17_9 = Mathf.Lerp(iter_17_3.color.g, arg_14_1.hightColor1.g, var_17_7)
								local var_17_10 = Mathf.Lerp(iter_17_3.color.b, arg_14_1.hightColor1.b, var_17_7)

								iter_17_3.color = Color.New(var_17_8, var_17_9, var_17_10)
							else
								local var_17_11 = Mathf.Lerp(iter_17_3.color.r, 1, var_17_7)

								iter_17_3.color = Color.New(var_17_11, var_17_11, var_17_11)
							end
						end
					end
				end
			end

			if arg_14_1.time_ >= var_17_5 + var_17_6 and arg_14_1.time_ < var_17_5 + var_17_6 + arg_17_0 and not isNil(var_17_4) and arg_14_1.var_.actorSpriteComps10128 then
				for iter_17_4, iter_17_5 in pairs(arg_14_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_17_5 then
						if arg_14_1.isInRecall_ then
							iter_17_5.color = arg_14_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_17_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_14_1.var_.actorSpriteComps10128 = nil
			end

			local var_17_12 = arg_14_1.actors_["1034"]
			local var_17_13 = 0

			if var_17_13 < arg_14_1.time_ and arg_14_1.time_ <= var_17_13 + arg_17_0 and not isNil(var_17_12) and arg_14_1.var_.actorSpriteComps1034 == nil then
				arg_14_1.var_.actorSpriteComps1034 = var_17_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_14 = 0.2

			if var_17_13 <= arg_14_1.time_ and arg_14_1.time_ < var_17_13 + var_17_14 and not isNil(var_17_12) then
				local var_17_15 = (arg_14_1.time_ - var_17_13) / var_17_14

				if arg_14_1.var_.actorSpriteComps1034 then
					for iter_17_6, iter_17_7 in pairs(arg_14_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_17_7 then
							if arg_14_1.isInRecall_ then
								local var_17_16 = Mathf.Lerp(iter_17_7.color.r, arg_14_1.hightColor2.r, var_17_15)
								local var_17_17 = Mathf.Lerp(iter_17_7.color.g, arg_14_1.hightColor2.g, var_17_15)
								local var_17_18 = Mathf.Lerp(iter_17_7.color.b, arg_14_1.hightColor2.b, var_17_15)

								iter_17_7.color = Color.New(var_17_16, var_17_17, var_17_18)
							else
								local var_17_19 = Mathf.Lerp(iter_17_7.color.r, 0.5, var_17_15)

								iter_17_7.color = Color.New(var_17_19, var_17_19, var_17_19)
							end
						end
					end
				end
			end

			if arg_14_1.time_ >= var_17_13 + var_17_14 and arg_14_1.time_ < var_17_13 + var_17_14 + arg_17_0 and not isNil(var_17_12) and arg_14_1.var_.actorSpriteComps1034 then
				for iter_17_8, iter_17_9 in pairs(arg_14_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_17_9 then
						if arg_14_1.isInRecall_ then
							iter_17_9.color = arg_14_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_17_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_14_1.var_.actorSpriteComps1034 = nil
			end

			local var_17_20 = arg_14_1.actors_["1034"].transform
			local var_17_21 = 0

			if var_17_21 < arg_14_1.time_ and arg_14_1.time_ <= var_17_21 + arg_17_0 then
				arg_14_1.var_.moveOldPos1034 = var_17_20.localPosition
				var_17_20.localScale = Vector3.New(1, 1, 1)

				arg_14_1:CheckSpriteTmpPos("1034", 2)

				local var_17_22 = var_17_20.childCount

				for iter_17_10 = 0, var_17_22 - 1 do
					local var_17_23 = var_17_20:GetChild(iter_17_10)

					if var_17_23.name == "split_4" or not string.find(var_17_23.name, "split") then
						var_17_23.gameObject:SetActive(true)
					else
						var_17_23.gameObject:SetActive(false)
					end
				end
			end

			local var_17_24 = 0.001

			if var_17_21 <= arg_14_1.time_ and arg_14_1.time_ < var_17_21 + var_17_24 then
				local var_17_25 = (arg_14_1.time_ - var_17_21) / var_17_24
				local var_17_26 = Vector3.New(-390, -331.9, -324)

				var_17_20.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos1034, var_17_26, var_17_25)
			end

			if arg_14_1.time_ >= var_17_21 + var_17_24 and arg_14_1.time_ < var_17_21 + var_17_24 + arg_17_0 then
				var_17_20.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_17_27 = arg_14_1.actors_["10128"].transform
			local var_17_28 = 0

			if var_17_28 < arg_14_1.time_ and arg_14_1.time_ <= var_17_28 + arg_17_0 then
				arg_14_1.var_.moveOldPos10128 = var_17_27.localPosition
				var_17_27.localScale = Vector3.New(1, 1, 1)

				arg_14_1:CheckSpriteTmpPos("10128", 4)

				local var_17_29 = var_17_27.childCount

				for iter_17_11 = 0, var_17_29 - 1 do
					local var_17_30 = var_17_27:GetChild(iter_17_11)

					if var_17_30.name == "" or not string.find(var_17_30.name, "split") then
						var_17_30.gameObject:SetActive(true)
					else
						var_17_30.gameObject:SetActive(false)
					end
				end
			end

			local var_17_31 = 0.001

			if var_17_28 <= arg_14_1.time_ and arg_14_1.time_ < var_17_28 + var_17_31 then
				local var_17_32 = (arg_14_1.time_ - var_17_28) / var_17_31
				local var_17_33 = Vector3.New(390, -347, -300)

				var_17_27.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos10128, var_17_33, var_17_32)
			end

			if arg_14_1.time_ >= var_17_28 + var_17_31 and arg_14_1.time_ < var_17_28 + var_17_31 + arg_17_0 then
				var_17_27.localPosition = Vector3.New(390, -347, -300)
			end

			local var_17_34 = 0
			local var_17_35 = 0.275

			if var_17_34 < arg_14_1.time_ and arg_14_1.time_ <= var_17_34 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_36 = arg_14_1:FormatText(StoryNameCfg[595].name)

				arg_14_1.leftNameTxt_.text = var_17_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_37 = arg_14_1:GetWordFromCfg(417242003)
				local var_17_38 = arg_14_1:FormatText(var_17_37.content)

				arg_14_1.text_.text = var_17_38

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_39 = 11
				local var_17_40 = utf8.len(var_17_38)
				local var_17_41 = var_17_39 <= 0 and var_17_35 or var_17_35 * (var_17_40 / var_17_39)

				if var_17_41 > 0 and var_17_35 < var_17_41 then
					arg_14_1.talkMaxDuration = var_17_41

					if var_17_41 + var_17_34 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_41 + var_17_34
					end
				end

				arg_14_1.text_.text = var_17_38
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242003", "story_v_out_417242.awb") ~= 0 then
					local var_17_42 = manager.audio:GetVoiceLength("story_v_out_417242", "417242003", "story_v_out_417242.awb") / 1000

					if var_17_42 + var_17_34 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_42 + var_17_34
					end

					if var_17_37.prefab_name ~= "" and arg_14_1.actors_[var_17_37.prefab_name] ~= nil then
						local var_17_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_37.prefab_name].transform, "story_v_out_417242", "417242003", "story_v_out_417242.awb")

						arg_14_1:RecordAudio("417242003", var_17_43)
						arg_14_1:RecordAudio("417242003", var_17_43)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_417242", "417242003", "story_v_out_417242.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_417242", "417242003", "story_v_out_417242.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_44 = math.max(var_17_35, arg_14_1.talkMaxDuration)

			if var_17_34 <= arg_14_1.time_ and arg_14_1.time_ < var_17_34 + var_17_44 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_34) / var_17_44

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_34 + var_17_44 and arg_14_1.time_ < var_17_34 + var_17_44 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play417242004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417242004
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play417242005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = arg_18_1.actors_["1034"]
			local var_21_1 = 0

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.actorSpriteComps1034 == nil then
				arg_18_1.var_.actorSpriteComps1034 = var_21_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_21_2 = 0.2

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_2 and not isNil(var_21_0) then
				local var_21_3 = (arg_18_1.time_ - var_21_1) / var_21_2

				if arg_18_1.var_.actorSpriteComps1034 then
					for iter_21_0, iter_21_1 in pairs(arg_18_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_21_1 then
							if arg_18_1.isInRecall_ then
								local var_21_4 = Mathf.Lerp(iter_21_1.color.r, arg_18_1.hightColor1.r, var_21_3)
								local var_21_5 = Mathf.Lerp(iter_21_1.color.g, arg_18_1.hightColor1.g, var_21_3)
								local var_21_6 = Mathf.Lerp(iter_21_1.color.b, arg_18_1.hightColor1.b, var_21_3)

								iter_21_1.color = Color.New(var_21_4, var_21_5, var_21_6)
							else
								local var_21_7 = Mathf.Lerp(iter_21_1.color.r, 1, var_21_3)

								iter_21_1.color = Color.New(var_21_7, var_21_7, var_21_7)
							end
						end
					end
				end
			end

			if arg_18_1.time_ >= var_21_1 + var_21_2 and arg_18_1.time_ < var_21_1 + var_21_2 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.actorSpriteComps1034 then
				for iter_21_2, iter_21_3 in pairs(arg_18_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_21_3 then
						if arg_18_1.isInRecall_ then
							iter_21_3.color = arg_18_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_21_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_18_1.var_.actorSpriteComps1034 = nil
			end

			local var_21_8 = arg_18_1.actors_["10128"]
			local var_21_9 = 0

			if var_21_9 < arg_18_1.time_ and arg_18_1.time_ <= var_21_9 + arg_21_0 and not isNil(var_21_8) and arg_18_1.var_.actorSpriteComps10128 == nil then
				arg_18_1.var_.actorSpriteComps10128 = var_21_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_21_10 = 0.2

			if var_21_9 <= arg_18_1.time_ and arg_18_1.time_ < var_21_9 + var_21_10 and not isNil(var_21_8) then
				local var_21_11 = (arg_18_1.time_ - var_21_9) / var_21_10

				if arg_18_1.var_.actorSpriteComps10128 then
					for iter_21_4, iter_21_5 in pairs(arg_18_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_21_5 then
							if arg_18_1.isInRecall_ then
								local var_21_12 = Mathf.Lerp(iter_21_5.color.r, arg_18_1.hightColor2.r, var_21_11)
								local var_21_13 = Mathf.Lerp(iter_21_5.color.g, arg_18_1.hightColor2.g, var_21_11)
								local var_21_14 = Mathf.Lerp(iter_21_5.color.b, arg_18_1.hightColor2.b, var_21_11)

								iter_21_5.color = Color.New(var_21_12, var_21_13, var_21_14)
							else
								local var_21_15 = Mathf.Lerp(iter_21_5.color.r, 0.5, var_21_11)

								iter_21_5.color = Color.New(var_21_15, var_21_15, var_21_15)
							end
						end
					end
				end
			end

			if arg_18_1.time_ >= var_21_9 + var_21_10 and arg_18_1.time_ < var_21_9 + var_21_10 + arg_21_0 and not isNil(var_21_8) and arg_18_1.var_.actorSpriteComps10128 then
				for iter_21_6, iter_21_7 in pairs(arg_18_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_21_7 then
						if arg_18_1.isInRecall_ then
							iter_21_7.color = arg_18_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_21_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_18_1.var_.actorSpriteComps10128 = nil
			end

			local var_21_16 = 0
			local var_21_17 = 0.05

			if var_21_16 < arg_18_1.time_ and arg_18_1.time_ <= var_21_16 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_18 = arg_18_1:FormatText(StoryNameCfg[1109].name)

				arg_18_1.leftNameTxt_.text = var_21_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_19 = arg_18_1:GetWordFromCfg(417242004)
				local var_21_20 = arg_18_1:FormatText(var_21_19.content)

				arg_18_1.text_.text = var_21_20

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_21 = 2
				local var_21_22 = utf8.len(var_21_20)
				local var_21_23 = var_21_21 <= 0 and var_21_17 or var_21_17 * (var_21_22 / var_21_21)

				if var_21_23 > 0 and var_21_17 < var_21_23 then
					arg_18_1.talkMaxDuration = var_21_23

					if var_21_23 + var_21_16 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_23 + var_21_16
					end
				end

				arg_18_1.text_.text = var_21_20
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_24 = math.max(var_21_17, arg_18_1.talkMaxDuration)

			if var_21_16 <= arg_18_1.time_ and arg_18_1.time_ < var_21_16 + var_21_24 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_16) / var_21_24

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_16 + var_21_24 and arg_18_1.time_ < var_21_16 + var_21_24 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play417242005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417242005
		arg_22_1.duration_ = 7.6

		local var_22_0 = {
			zh = 4.1,
			ja = 7.6
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play417242006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = "10115"

			if arg_22_1.actors_[var_25_0] == nil then
				local var_25_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10115")

				if not isNil(var_25_1) then
					local var_25_2 = Object.Instantiate(var_25_1, arg_22_1.canvasGo_.transform)

					var_25_2.transform:SetSiblingIndex(1)

					var_25_2.name = var_25_0
					var_25_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_22_1.actors_[var_25_0] = var_25_2

					local var_25_3 = var_25_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_22_1.isInRecall_ then
						for iter_25_0, iter_25_1 in ipairs(var_25_3) do
							iter_25_1.color = arg_22_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_25_4 = arg_22_1.actors_["10115"]
			local var_25_5 = 0

			if var_25_5 < arg_22_1.time_ and arg_22_1.time_ <= var_25_5 + arg_25_0 and not isNil(var_25_4) and arg_22_1.var_.actorSpriteComps10115 == nil then
				arg_22_1.var_.actorSpriteComps10115 = var_25_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_25_6 = 0.2

			if var_25_5 <= arg_22_1.time_ and arg_22_1.time_ < var_25_5 + var_25_6 and not isNil(var_25_4) then
				local var_25_7 = (arg_22_1.time_ - var_25_5) / var_25_6

				if arg_22_1.var_.actorSpriteComps10115 then
					for iter_25_2, iter_25_3 in pairs(arg_22_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_25_3 then
							if arg_22_1.isInRecall_ then
								local var_25_8 = Mathf.Lerp(iter_25_3.color.r, arg_22_1.hightColor1.r, var_25_7)
								local var_25_9 = Mathf.Lerp(iter_25_3.color.g, arg_22_1.hightColor1.g, var_25_7)
								local var_25_10 = Mathf.Lerp(iter_25_3.color.b, arg_22_1.hightColor1.b, var_25_7)

								iter_25_3.color = Color.New(var_25_8, var_25_9, var_25_10)
							else
								local var_25_11 = Mathf.Lerp(iter_25_3.color.r, 1, var_25_7)

								iter_25_3.color = Color.New(var_25_11, var_25_11, var_25_11)
							end
						end
					end
				end
			end

			if arg_22_1.time_ >= var_25_5 + var_25_6 and arg_22_1.time_ < var_25_5 + var_25_6 + arg_25_0 and not isNil(var_25_4) and arg_22_1.var_.actorSpriteComps10115 then
				for iter_25_4, iter_25_5 in pairs(arg_22_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_25_5 then
						if arg_22_1.isInRecall_ then
							iter_25_5.color = arg_22_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_25_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_22_1.var_.actorSpriteComps10115 = nil
			end

			local var_25_12 = arg_22_1.actors_["1034"].transform
			local var_25_13 = 0

			if var_25_13 < arg_22_1.time_ and arg_22_1.time_ <= var_25_13 + arg_25_0 then
				arg_22_1.var_.moveOldPos1034 = var_25_12.localPosition
				var_25_12.localScale = Vector3.New(1, 1, 1)

				arg_22_1:CheckSpriteTmpPos("1034", 7)

				local var_25_14 = var_25_12.childCount

				for iter_25_6 = 0, var_25_14 - 1 do
					local var_25_15 = var_25_12:GetChild(iter_25_6)

					if var_25_15.name == "" or not string.find(var_25_15.name, "split") then
						var_25_15.gameObject:SetActive(true)
					else
						var_25_15.gameObject:SetActive(false)
					end
				end
			end

			local var_25_16 = 0.001

			if var_25_13 <= arg_22_1.time_ and arg_22_1.time_ < var_25_13 + var_25_16 then
				local var_25_17 = (arg_22_1.time_ - var_25_13) / var_25_16
				local var_25_18 = Vector3.New(0, -2000, 0)

				var_25_12.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1034, var_25_18, var_25_17)
			end

			if arg_22_1.time_ >= var_25_13 + var_25_16 and arg_22_1.time_ < var_25_13 + var_25_16 + arg_25_0 then
				var_25_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_25_19 = arg_22_1.actors_["10128"].transform
			local var_25_20 = 0

			if var_25_20 < arg_22_1.time_ and arg_22_1.time_ <= var_25_20 + arg_25_0 then
				arg_22_1.var_.moveOldPos10128 = var_25_19.localPosition
				var_25_19.localScale = Vector3.New(1, 1, 1)

				arg_22_1:CheckSpriteTmpPos("10128", 7)

				local var_25_21 = var_25_19.childCount

				for iter_25_7 = 0, var_25_21 - 1 do
					local var_25_22 = var_25_19:GetChild(iter_25_7)

					if var_25_22.name == "" or not string.find(var_25_22.name, "split") then
						var_25_22.gameObject:SetActive(true)
					else
						var_25_22.gameObject:SetActive(false)
					end
				end
			end

			local var_25_23 = 0.001

			if var_25_20 <= arg_22_1.time_ and arg_22_1.time_ < var_25_20 + var_25_23 then
				local var_25_24 = (arg_22_1.time_ - var_25_20) / var_25_23
				local var_25_25 = Vector3.New(0, -2000, -300)

				var_25_19.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos10128, var_25_25, var_25_24)
			end

			if arg_22_1.time_ >= var_25_20 + var_25_23 and arg_22_1.time_ < var_25_20 + var_25_23 + arg_25_0 then
				var_25_19.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_25_26 = arg_22_1.actors_["10115"].transform
			local var_25_27 = 0

			if var_25_27 < arg_22_1.time_ and arg_22_1.time_ <= var_25_27 + arg_25_0 then
				arg_22_1.var_.moveOldPos10115 = var_25_26.localPosition
				var_25_26.localScale = Vector3.New(1, 1, 1)

				arg_22_1:CheckSpriteTmpPos("10115", 3)

				local var_25_28 = var_25_26.childCount

				for iter_25_8 = 0, var_25_28 - 1 do
					local var_25_29 = var_25_26:GetChild(iter_25_8)

					if var_25_29.name == "split_2" or not string.find(var_25_29.name, "split") then
						var_25_29.gameObject:SetActive(true)
					else
						var_25_29.gameObject:SetActive(false)
					end
				end
			end

			local var_25_30 = 0.001

			if var_25_27 <= arg_22_1.time_ and arg_22_1.time_ < var_25_27 + var_25_30 then
				local var_25_31 = (arg_22_1.time_ - var_25_27) / var_25_30
				local var_25_32 = Vector3.New(0, -387.3, -246.2)

				var_25_26.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos10115, var_25_32, var_25_31)
			end

			if arg_22_1.time_ >= var_25_27 + var_25_30 and arg_22_1.time_ < var_25_27 + var_25_30 + arg_25_0 then
				var_25_26.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_25_33 = 0
			local var_25_34 = 0.425

			if var_25_33 < arg_22_1.time_ and arg_22_1.time_ <= var_25_33 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_35 = arg_22_1:FormatText(StoryNameCfg[1113].name)

				arg_22_1.leftNameTxt_.text = var_25_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_36 = arg_22_1:GetWordFromCfg(417242005)
				local var_25_37 = arg_22_1:FormatText(var_25_36.content)

				arg_22_1.text_.text = var_25_37

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_38 = 17
				local var_25_39 = utf8.len(var_25_37)
				local var_25_40 = var_25_38 <= 0 and var_25_34 or var_25_34 * (var_25_39 / var_25_38)

				if var_25_40 > 0 and var_25_34 < var_25_40 then
					arg_22_1.talkMaxDuration = var_25_40

					if var_25_40 + var_25_33 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_40 + var_25_33
					end
				end

				arg_22_1.text_.text = var_25_37
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242005", "story_v_out_417242.awb") ~= 0 then
					local var_25_41 = manager.audio:GetVoiceLength("story_v_out_417242", "417242005", "story_v_out_417242.awb") / 1000

					if var_25_41 + var_25_33 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_41 + var_25_33
					end

					if var_25_36.prefab_name ~= "" and arg_22_1.actors_[var_25_36.prefab_name] ~= nil then
						local var_25_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_36.prefab_name].transform, "story_v_out_417242", "417242005", "story_v_out_417242.awb")

						arg_22_1:RecordAudio("417242005", var_25_42)
						arg_22_1:RecordAudio("417242005", var_25_42)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417242", "417242005", "story_v_out_417242.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417242", "417242005", "story_v_out_417242.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_43 = math.max(var_25_34, arg_22_1.talkMaxDuration)

			if var_25_33 <= arg_22_1.time_ and arg_22_1.time_ < var_25_33 + var_25_43 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_33) / var_25_43

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_33 + var_25_43 and arg_22_1.time_ < var_25_33 + var_25_43 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play417242006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417242006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play417242007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["10115"].transform
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 then
				arg_26_1.var_.moveOldPos10115 = var_29_0.localPosition
				var_29_0.localScale = Vector3.New(1, 1, 1)

				arg_26_1:CheckSpriteTmpPos("10115", 7)

				local var_29_2 = var_29_0.childCount

				for iter_29_0 = 0, var_29_2 - 1 do
					local var_29_3 = var_29_0:GetChild(iter_29_0)

					if var_29_3.name == "" or not string.find(var_29_3.name, "split") then
						var_29_3.gameObject:SetActive(true)
					else
						var_29_3.gameObject:SetActive(false)
					end
				end
			end

			local var_29_4 = 0.001

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_4 then
				local var_29_5 = (arg_26_1.time_ - var_29_1) / var_29_4
				local var_29_6 = Vector3.New(0, -2000, 0)

				var_29_0.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos10115, var_29_6, var_29_5)
			end

			if arg_26_1.time_ >= var_29_1 + var_29_4 and arg_26_1.time_ < var_29_1 + var_29_4 + arg_29_0 then
				var_29_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_29_7 = 0
			local var_29_8 = 1.15

			if var_29_7 < arg_26_1.time_ and arg_26_1.time_ <= var_29_7 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_9 = arg_26_1:GetWordFromCfg(417242006)
				local var_29_10 = arg_26_1:FormatText(var_29_9.content)

				arg_26_1.text_.text = var_29_10

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_11 = 46
				local var_29_12 = utf8.len(var_29_10)
				local var_29_13 = var_29_11 <= 0 and var_29_8 or var_29_8 * (var_29_12 / var_29_11)

				if var_29_13 > 0 and var_29_8 < var_29_13 then
					arg_26_1.talkMaxDuration = var_29_13

					if var_29_13 + var_29_7 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_13 + var_29_7
					end
				end

				arg_26_1.text_.text = var_29_10
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_14 = math.max(var_29_8, arg_26_1.talkMaxDuration)

			if var_29_7 <= arg_26_1.time_ and arg_26_1.time_ < var_29_7 + var_29_14 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_7) / var_29_14

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_7 + var_29_14 and arg_26_1.time_ < var_29_7 + var_29_14 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play417242007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417242007
		arg_30_1.duration_ = 2.2

		local var_30_0 = {
			zh = 1.166,
			ja = 2.2
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play417242008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["10128"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.actorSpriteComps10128 == nil then
				arg_30_1.var_.actorSpriteComps10128 = var_33_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_2 = 0.2

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.actorSpriteComps10128 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_33_1 then
							if arg_30_1.isInRecall_ then
								local var_33_4 = Mathf.Lerp(iter_33_1.color.r, arg_30_1.hightColor1.r, var_33_3)
								local var_33_5 = Mathf.Lerp(iter_33_1.color.g, arg_30_1.hightColor1.g, var_33_3)
								local var_33_6 = Mathf.Lerp(iter_33_1.color.b, arg_30_1.hightColor1.b, var_33_3)

								iter_33_1.color = Color.New(var_33_4, var_33_5, var_33_6)
							else
								local var_33_7 = Mathf.Lerp(iter_33_1.color.r, 1, var_33_3)

								iter_33_1.color = Color.New(var_33_7, var_33_7, var_33_7)
							end
						end
					end
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.actorSpriteComps10128 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_33_3 then
						if arg_30_1.isInRecall_ then
							iter_33_3.color = arg_30_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_33_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_30_1.var_.actorSpriteComps10128 = nil
			end

			local var_33_8 = arg_30_1.actors_["10128"].transform
			local var_33_9 = 0

			if var_33_9 < arg_30_1.time_ and arg_30_1.time_ <= var_33_9 + arg_33_0 then
				arg_30_1.var_.moveOldPos10128 = var_33_8.localPosition
				var_33_8.localScale = Vector3.New(1, 1, 1)

				arg_30_1:CheckSpriteTmpPos("10128", 3)

				local var_33_10 = var_33_8.childCount

				for iter_33_4 = 0, var_33_10 - 1 do
					local var_33_11 = var_33_8:GetChild(iter_33_4)

					if var_33_11.name == "split_6" or not string.find(var_33_11.name, "split") then
						var_33_11.gameObject:SetActive(true)
					else
						var_33_11.gameObject:SetActive(false)
					end
				end
			end

			local var_33_12 = 0.001

			if var_33_9 <= arg_30_1.time_ and arg_30_1.time_ < var_33_9 + var_33_12 then
				local var_33_13 = (arg_30_1.time_ - var_33_9) / var_33_12
				local var_33_14 = Vector3.New(0, -347, -300)

				var_33_8.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos10128, var_33_14, var_33_13)
			end

			if arg_30_1.time_ >= var_33_9 + var_33_12 and arg_30_1.time_ < var_33_9 + var_33_12 + arg_33_0 then
				var_33_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_33_15 = 0
			local var_33_16 = 0.2

			if var_33_15 < arg_30_1.time_ and arg_30_1.time_ <= var_33_15 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_17 = arg_30_1:FormatText(StoryNameCfg[595].name)

				arg_30_1.leftNameTxt_.text = var_33_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_18 = arg_30_1:GetWordFromCfg(417242007)
				local var_33_19 = arg_30_1:FormatText(var_33_18.content)

				arg_30_1.text_.text = var_33_19

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_20 = 8
				local var_33_21 = utf8.len(var_33_19)
				local var_33_22 = var_33_20 <= 0 and var_33_16 or var_33_16 * (var_33_21 / var_33_20)

				if var_33_22 > 0 and var_33_16 < var_33_22 then
					arg_30_1.talkMaxDuration = var_33_22

					if var_33_22 + var_33_15 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_22 + var_33_15
					end
				end

				arg_30_1.text_.text = var_33_19
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242007", "story_v_out_417242.awb") ~= 0 then
					local var_33_23 = manager.audio:GetVoiceLength("story_v_out_417242", "417242007", "story_v_out_417242.awb") / 1000

					if var_33_23 + var_33_15 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_23 + var_33_15
					end

					if var_33_18.prefab_name ~= "" and arg_30_1.actors_[var_33_18.prefab_name] ~= nil then
						local var_33_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_18.prefab_name].transform, "story_v_out_417242", "417242007", "story_v_out_417242.awb")

						arg_30_1:RecordAudio("417242007", var_33_24)
						arg_30_1:RecordAudio("417242007", var_33_24)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417242", "417242007", "story_v_out_417242.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417242", "417242007", "story_v_out_417242.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_25 = math.max(var_33_16, arg_30_1.talkMaxDuration)

			if var_33_15 <= arg_30_1.time_ and arg_30_1.time_ < var_33_15 + var_33_25 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_15) / var_33_25

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_15 + var_33_25 and arg_30_1.time_ < var_33_15 + var_33_25 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play417242008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417242008
		arg_34_1.duration_ = 3.07

		local var_34_0 = {
			zh = 1.433,
			ja = 3.066
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play417242009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["1034"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.actorSpriteComps1034 == nil then
				arg_34_1.var_.actorSpriteComps1034 = var_37_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_2 = 0.2

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.actorSpriteComps1034 then
					for iter_37_0, iter_37_1 in pairs(arg_34_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_37_1 then
							if arg_34_1.isInRecall_ then
								local var_37_4 = Mathf.Lerp(iter_37_1.color.r, arg_34_1.hightColor1.r, var_37_3)
								local var_37_5 = Mathf.Lerp(iter_37_1.color.g, arg_34_1.hightColor1.g, var_37_3)
								local var_37_6 = Mathf.Lerp(iter_37_1.color.b, arg_34_1.hightColor1.b, var_37_3)

								iter_37_1.color = Color.New(var_37_4, var_37_5, var_37_6)
							else
								local var_37_7 = Mathf.Lerp(iter_37_1.color.r, 1, var_37_3)

								iter_37_1.color = Color.New(var_37_7, var_37_7, var_37_7)
							end
						end
					end
				end
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.actorSpriteComps1034 then
				for iter_37_2, iter_37_3 in pairs(arg_34_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_37_3 then
						if arg_34_1.isInRecall_ then
							iter_37_3.color = arg_34_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_37_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_34_1.var_.actorSpriteComps1034 = nil
			end

			local var_37_8 = arg_34_1.actors_["10128"]
			local var_37_9 = 0

			if var_37_9 < arg_34_1.time_ and arg_34_1.time_ <= var_37_9 + arg_37_0 and not isNil(var_37_8) and arg_34_1.var_.actorSpriteComps10128 == nil then
				arg_34_1.var_.actorSpriteComps10128 = var_37_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_10 = 0.2

			if var_37_9 <= arg_34_1.time_ and arg_34_1.time_ < var_37_9 + var_37_10 and not isNil(var_37_8) then
				local var_37_11 = (arg_34_1.time_ - var_37_9) / var_37_10

				if arg_34_1.var_.actorSpriteComps10128 then
					for iter_37_4, iter_37_5 in pairs(arg_34_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_37_5 then
							if arg_34_1.isInRecall_ then
								local var_37_12 = Mathf.Lerp(iter_37_5.color.r, arg_34_1.hightColor2.r, var_37_11)
								local var_37_13 = Mathf.Lerp(iter_37_5.color.g, arg_34_1.hightColor2.g, var_37_11)
								local var_37_14 = Mathf.Lerp(iter_37_5.color.b, arg_34_1.hightColor2.b, var_37_11)

								iter_37_5.color = Color.New(var_37_12, var_37_13, var_37_14)
							else
								local var_37_15 = Mathf.Lerp(iter_37_5.color.r, 0.5, var_37_11)

								iter_37_5.color = Color.New(var_37_15, var_37_15, var_37_15)
							end
						end
					end
				end
			end

			if arg_34_1.time_ >= var_37_9 + var_37_10 and arg_34_1.time_ < var_37_9 + var_37_10 + arg_37_0 and not isNil(var_37_8) and arg_34_1.var_.actorSpriteComps10128 then
				for iter_37_6, iter_37_7 in pairs(arg_34_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_37_7 then
						if arg_34_1.isInRecall_ then
							iter_37_7.color = arg_34_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_37_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_34_1.var_.actorSpriteComps10128 = nil
			end

			local var_37_16 = arg_34_1.actors_["1034"].transform
			local var_37_17 = 0

			if var_37_17 < arg_34_1.time_ and arg_34_1.time_ <= var_37_17 + arg_37_0 then
				arg_34_1.var_.moveOldPos1034 = var_37_16.localPosition
				var_37_16.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("1034", 3)

				local var_37_18 = var_37_16.childCount

				for iter_37_8 = 0, var_37_18 - 1 do
					local var_37_19 = var_37_16:GetChild(iter_37_8)

					if var_37_19.name == "split_1" or not string.find(var_37_19.name, "split") then
						var_37_19.gameObject:SetActive(true)
					else
						var_37_19.gameObject:SetActive(false)
					end
				end
			end

			local var_37_20 = 0.001

			if var_37_17 <= arg_34_1.time_ and arg_34_1.time_ < var_37_17 + var_37_20 then
				local var_37_21 = (arg_34_1.time_ - var_37_17) / var_37_20
				local var_37_22 = Vector3.New(0, -331.9, -324)

				var_37_16.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1034, var_37_22, var_37_21)
			end

			if arg_34_1.time_ >= var_37_17 + var_37_20 and arg_34_1.time_ < var_37_17 + var_37_20 + arg_37_0 then
				var_37_16.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_37_23 = arg_34_1.actors_["10128"].transform
			local var_37_24 = 0

			if var_37_24 < arg_34_1.time_ and arg_34_1.time_ <= var_37_24 + arg_37_0 then
				arg_34_1.var_.moveOldPos10128 = var_37_23.localPosition
				var_37_23.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("10128", 7)

				local var_37_25 = var_37_23.childCount

				for iter_37_9 = 0, var_37_25 - 1 do
					local var_37_26 = var_37_23:GetChild(iter_37_9)

					if var_37_26.name == "" or not string.find(var_37_26.name, "split") then
						var_37_26.gameObject:SetActive(true)
					else
						var_37_26.gameObject:SetActive(false)
					end
				end
			end

			local var_37_27 = 0.001

			if var_37_24 <= arg_34_1.time_ and arg_34_1.time_ < var_37_24 + var_37_27 then
				local var_37_28 = (arg_34_1.time_ - var_37_24) / var_37_27
				local var_37_29 = Vector3.New(0, -2000, -300)

				var_37_23.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos10128, var_37_29, var_37_28)
			end

			if arg_34_1.time_ >= var_37_24 + var_37_27 and arg_34_1.time_ < var_37_24 + var_37_27 + arg_37_0 then
				var_37_23.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_37_30 = 0
			local var_37_31 = 0.175

			if var_37_30 < arg_34_1.time_ and arg_34_1.time_ <= var_37_30 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_32 = arg_34_1:FormatText(StoryNameCfg[1109].name)

				arg_34_1.leftNameTxt_.text = var_37_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_33 = arg_34_1:GetWordFromCfg(417242008)
				local var_37_34 = arg_34_1:FormatText(var_37_33.content)

				arg_34_1.text_.text = var_37_34

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_35 = 7
				local var_37_36 = utf8.len(var_37_34)
				local var_37_37 = var_37_35 <= 0 and var_37_31 or var_37_31 * (var_37_36 / var_37_35)

				if var_37_37 > 0 and var_37_31 < var_37_37 then
					arg_34_1.talkMaxDuration = var_37_37

					if var_37_37 + var_37_30 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_37 + var_37_30
					end
				end

				arg_34_1.text_.text = var_37_34
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242008", "story_v_out_417242.awb") ~= 0 then
					local var_37_38 = manager.audio:GetVoiceLength("story_v_out_417242", "417242008", "story_v_out_417242.awb") / 1000

					if var_37_38 + var_37_30 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_38 + var_37_30
					end

					if var_37_33.prefab_name ~= "" and arg_34_1.actors_[var_37_33.prefab_name] ~= nil then
						local var_37_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_33.prefab_name].transform, "story_v_out_417242", "417242008", "story_v_out_417242.awb")

						arg_34_1:RecordAudio("417242008", var_37_39)
						arg_34_1:RecordAudio("417242008", var_37_39)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_417242", "417242008", "story_v_out_417242.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_417242", "417242008", "story_v_out_417242.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_40 = math.max(var_37_31, arg_34_1.talkMaxDuration)

			if var_37_30 <= arg_34_1.time_ and arg_34_1.time_ < var_37_30 + var_37_40 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_30) / var_37_40

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_30 + var_37_40 and arg_34_1.time_ < var_37_30 + var_37_40 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play417242009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417242009
		arg_38_1.duration_ = 2.67

		local var_38_0 = {
			zh = 1.4,
			ja = 2.666
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play417242010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["10128"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.actorSpriteComps10128 == nil then
				arg_38_1.var_.actorSpriteComps10128 = var_41_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_2 = 0.2

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.actorSpriteComps10128 then
					for iter_41_0, iter_41_1 in pairs(arg_38_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_41_1 then
							if arg_38_1.isInRecall_ then
								local var_41_4 = Mathf.Lerp(iter_41_1.color.r, arg_38_1.hightColor1.r, var_41_3)
								local var_41_5 = Mathf.Lerp(iter_41_1.color.g, arg_38_1.hightColor1.g, var_41_3)
								local var_41_6 = Mathf.Lerp(iter_41_1.color.b, arg_38_1.hightColor1.b, var_41_3)

								iter_41_1.color = Color.New(var_41_4, var_41_5, var_41_6)
							else
								local var_41_7 = Mathf.Lerp(iter_41_1.color.r, 1, var_41_3)

								iter_41_1.color = Color.New(var_41_7, var_41_7, var_41_7)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.actorSpriteComps10128 then
				for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_41_3 then
						if arg_38_1.isInRecall_ then
							iter_41_3.color = arg_38_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_41_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_38_1.var_.actorSpriteComps10128 = nil
			end

			local var_41_8 = arg_38_1.actors_["1034"]
			local var_41_9 = 0

			if var_41_9 < arg_38_1.time_ and arg_38_1.time_ <= var_41_9 + arg_41_0 and not isNil(var_41_8) and arg_38_1.var_.actorSpriteComps1034 == nil then
				arg_38_1.var_.actorSpriteComps1034 = var_41_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_10 = 0.2

			if var_41_9 <= arg_38_1.time_ and arg_38_1.time_ < var_41_9 + var_41_10 and not isNil(var_41_8) then
				local var_41_11 = (arg_38_1.time_ - var_41_9) / var_41_10

				if arg_38_1.var_.actorSpriteComps1034 then
					for iter_41_4, iter_41_5 in pairs(arg_38_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_41_5 then
							if arg_38_1.isInRecall_ then
								local var_41_12 = Mathf.Lerp(iter_41_5.color.r, arg_38_1.hightColor2.r, var_41_11)
								local var_41_13 = Mathf.Lerp(iter_41_5.color.g, arg_38_1.hightColor2.g, var_41_11)
								local var_41_14 = Mathf.Lerp(iter_41_5.color.b, arg_38_1.hightColor2.b, var_41_11)

								iter_41_5.color = Color.New(var_41_12, var_41_13, var_41_14)
							else
								local var_41_15 = Mathf.Lerp(iter_41_5.color.r, 0.5, var_41_11)

								iter_41_5.color = Color.New(var_41_15, var_41_15, var_41_15)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= var_41_9 + var_41_10 and arg_38_1.time_ < var_41_9 + var_41_10 + arg_41_0 and not isNil(var_41_8) and arg_38_1.var_.actorSpriteComps1034 then
				for iter_41_6, iter_41_7 in pairs(arg_38_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_41_7 then
						if arg_38_1.isInRecall_ then
							iter_41_7.color = arg_38_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_41_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_38_1.var_.actorSpriteComps1034 = nil
			end

			local var_41_16 = arg_38_1.actors_["1034"].transform
			local var_41_17 = 0

			if var_41_17 < arg_38_1.time_ and arg_38_1.time_ <= var_41_17 + arg_41_0 then
				arg_38_1.var_.moveOldPos1034 = var_41_16.localPosition
				var_41_16.localScale = Vector3.New(1, 1, 1)

				arg_38_1:CheckSpriteTmpPos("1034", 2)

				local var_41_18 = var_41_16.childCount

				for iter_41_8 = 0, var_41_18 - 1 do
					local var_41_19 = var_41_16:GetChild(iter_41_8)

					if var_41_19.name == "" or not string.find(var_41_19.name, "split") then
						var_41_19.gameObject:SetActive(true)
					else
						var_41_19.gameObject:SetActive(false)
					end
				end
			end

			local var_41_20 = 0.001

			if var_41_17 <= arg_38_1.time_ and arg_38_1.time_ < var_41_17 + var_41_20 then
				local var_41_21 = (arg_38_1.time_ - var_41_17) / var_41_20
				local var_41_22 = Vector3.New(-390, -331.9, -324)

				var_41_16.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1034, var_41_22, var_41_21)
			end

			if arg_38_1.time_ >= var_41_17 + var_41_20 and arg_38_1.time_ < var_41_17 + var_41_20 + arg_41_0 then
				var_41_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_41_23 = arg_38_1.actors_["10128"].transform
			local var_41_24 = 0

			if var_41_24 < arg_38_1.time_ and arg_38_1.time_ <= var_41_24 + arg_41_0 then
				arg_38_1.var_.moveOldPos10128 = var_41_23.localPosition
				var_41_23.localScale = Vector3.New(1, 1, 1)

				arg_38_1:CheckSpriteTmpPos("10128", 4)

				local var_41_25 = var_41_23.childCount

				for iter_41_9 = 0, var_41_25 - 1 do
					local var_41_26 = var_41_23:GetChild(iter_41_9)

					if var_41_26.name == "split_2" or not string.find(var_41_26.name, "split") then
						var_41_26.gameObject:SetActive(true)
					else
						var_41_26.gameObject:SetActive(false)
					end
				end
			end

			local var_41_27 = 0.001

			if var_41_24 <= arg_38_1.time_ and arg_38_1.time_ < var_41_24 + var_41_27 then
				local var_41_28 = (arg_38_1.time_ - var_41_24) / var_41_27
				local var_41_29 = Vector3.New(390, -347, -300)

				var_41_23.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos10128, var_41_29, var_41_28)
			end

			if arg_38_1.time_ >= var_41_24 + var_41_27 and arg_38_1.time_ < var_41_24 + var_41_27 + arg_41_0 then
				var_41_23.localPosition = Vector3.New(390, -347, -300)
			end

			local var_41_30 = 0
			local var_41_31 = 0.175

			if var_41_30 < arg_38_1.time_ and arg_38_1.time_ <= var_41_30 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_32 = arg_38_1:FormatText(StoryNameCfg[595].name)

				arg_38_1.leftNameTxt_.text = var_41_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_33 = arg_38_1:GetWordFromCfg(417242009)
				local var_41_34 = arg_38_1:FormatText(var_41_33.content)

				arg_38_1.text_.text = var_41_34

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_35 = 7
				local var_41_36 = utf8.len(var_41_34)
				local var_41_37 = var_41_35 <= 0 and var_41_31 or var_41_31 * (var_41_36 / var_41_35)

				if var_41_37 > 0 and var_41_31 < var_41_37 then
					arg_38_1.talkMaxDuration = var_41_37

					if var_41_37 + var_41_30 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_37 + var_41_30
					end
				end

				arg_38_1.text_.text = var_41_34
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242009", "story_v_out_417242.awb") ~= 0 then
					local var_41_38 = manager.audio:GetVoiceLength("story_v_out_417242", "417242009", "story_v_out_417242.awb") / 1000

					if var_41_38 + var_41_30 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_38 + var_41_30
					end

					if var_41_33.prefab_name ~= "" and arg_38_1.actors_[var_41_33.prefab_name] ~= nil then
						local var_41_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_33.prefab_name].transform, "story_v_out_417242", "417242009", "story_v_out_417242.awb")

						arg_38_1:RecordAudio("417242009", var_41_39)
						arg_38_1:RecordAudio("417242009", var_41_39)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417242", "417242009", "story_v_out_417242.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417242", "417242009", "story_v_out_417242.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_40 = math.max(var_41_31, arg_38_1.talkMaxDuration)

			if var_41_30 <= arg_38_1.time_ and arg_38_1.time_ < var_41_30 + var_41_40 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_30) / var_41_40

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_30 + var_41_40 and arg_38_1.time_ < var_41_30 + var_41_40 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play417242010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417242010
		arg_42_1.duration_ = 3.77

		local var_42_0 = {
			zh = 3.766,
			ja = 3.6
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
				arg_42_0:Play417242011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["1034"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.actorSpriteComps1034 == nil then
				arg_42_1.var_.actorSpriteComps1034 = var_45_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_2 = 0.2

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.actorSpriteComps1034 then
					for iter_45_0, iter_45_1 in pairs(arg_42_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_45_1 then
							if arg_42_1.isInRecall_ then
								local var_45_4 = Mathf.Lerp(iter_45_1.color.r, arg_42_1.hightColor1.r, var_45_3)
								local var_45_5 = Mathf.Lerp(iter_45_1.color.g, arg_42_1.hightColor1.g, var_45_3)
								local var_45_6 = Mathf.Lerp(iter_45_1.color.b, arg_42_1.hightColor1.b, var_45_3)

								iter_45_1.color = Color.New(var_45_4, var_45_5, var_45_6)
							else
								local var_45_7 = Mathf.Lerp(iter_45_1.color.r, 1, var_45_3)

								iter_45_1.color = Color.New(var_45_7, var_45_7, var_45_7)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.actorSpriteComps1034 then
				for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_45_3 then
						if arg_42_1.isInRecall_ then
							iter_45_3.color = arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_45_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps1034 = nil
			end

			local var_45_8 = arg_42_1.actors_["10128"]
			local var_45_9 = 0

			if var_45_9 < arg_42_1.time_ and arg_42_1.time_ <= var_45_9 + arg_45_0 and not isNil(var_45_8) and arg_42_1.var_.actorSpriteComps10128 == nil then
				arg_42_1.var_.actorSpriteComps10128 = var_45_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_10 = 0.2

			if var_45_9 <= arg_42_1.time_ and arg_42_1.time_ < var_45_9 + var_45_10 and not isNil(var_45_8) then
				local var_45_11 = (arg_42_1.time_ - var_45_9) / var_45_10

				if arg_42_1.var_.actorSpriteComps10128 then
					for iter_45_4, iter_45_5 in pairs(arg_42_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_45_5 then
							if arg_42_1.isInRecall_ then
								local var_45_12 = Mathf.Lerp(iter_45_5.color.r, arg_42_1.hightColor2.r, var_45_11)
								local var_45_13 = Mathf.Lerp(iter_45_5.color.g, arg_42_1.hightColor2.g, var_45_11)
								local var_45_14 = Mathf.Lerp(iter_45_5.color.b, arg_42_1.hightColor2.b, var_45_11)

								iter_45_5.color = Color.New(var_45_12, var_45_13, var_45_14)
							else
								local var_45_15 = Mathf.Lerp(iter_45_5.color.r, 0.5, var_45_11)

								iter_45_5.color = Color.New(var_45_15, var_45_15, var_45_15)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= var_45_9 + var_45_10 and arg_42_1.time_ < var_45_9 + var_45_10 + arg_45_0 and not isNil(var_45_8) and arg_42_1.var_.actorSpriteComps10128 then
				for iter_45_6, iter_45_7 in pairs(arg_42_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_45_7 then
						if arg_42_1.isInRecall_ then
							iter_45_7.color = arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_45_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps10128 = nil
			end

			local var_45_16 = arg_42_1.actors_["1034"].transform
			local var_45_17 = 0

			if var_45_17 < arg_42_1.time_ and arg_42_1.time_ <= var_45_17 + arg_45_0 then
				arg_42_1.var_.moveOldPos1034 = var_45_16.localPosition
				var_45_16.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("1034", 3)

				local var_45_18 = var_45_16.childCount

				for iter_45_8 = 0, var_45_18 - 1 do
					local var_45_19 = var_45_16:GetChild(iter_45_8)

					if var_45_19.name == "" or not string.find(var_45_19.name, "split") then
						var_45_19.gameObject:SetActive(true)
					else
						var_45_19.gameObject:SetActive(false)
					end
				end
			end

			local var_45_20 = 0.001

			if var_45_17 <= arg_42_1.time_ and arg_42_1.time_ < var_45_17 + var_45_20 then
				local var_45_21 = (arg_42_1.time_ - var_45_17) / var_45_20
				local var_45_22 = Vector3.New(0, -331.9, -324)

				var_45_16.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1034, var_45_22, var_45_21)
			end

			if arg_42_1.time_ >= var_45_17 + var_45_20 and arg_42_1.time_ < var_45_17 + var_45_20 + arg_45_0 then
				var_45_16.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_45_23 = arg_42_1.actors_["10128"].transform
			local var_45_24 = 0

			if var_45_24 < arg_42_1.time_ and arg_42_1.time_ <= var_45_24 + arg_45_0 then
				arg_42_1.var_.moveOldPos10128 = var_45_23.localPosition
				var_45_23.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("10128", 7)

				local var_45_25 = var_45_23.childCount

				for iter_45_9 = 0, var_45_25 - 1 do
					local var_45_26 = var_45_23:GetChild(iter_45_9)

					if var_45_26.name == "" or not string.find(var_45_26.name, "split") then
						var_45_26.gameObject:SetActive(true)
					else
						var_45_26.gameObject:SetActive(false)
					end
				end
			end

			local var_45_27 = 0.001

			if var_45_24 <= arg_42_1.time_ and arg_42_1.time_ < var_45_24 + var_45_27 then
				local var_45_28 = (arg_42_1.time_ - var_45_24) / var_45_27
				local var_45_29 = Vector3.New(0, -2000, -300)

				var_45_23.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10128, var_45_29, var_45_28)
			end

			if arg_42_1.time_ >= var_45_24 + var_45_27 and arg_42_1.time_ < var_45_24 + var_45_27 + arg_45_0 then
				var_45_23.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_45_30 = 0
			local var_45_31 = 0.5

			if var_45_30 < arg_42_1.time_ and arg_42_1.time_ <= var_45_30 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_32 = arg_42_1:FormatText(StoryNameCfg[1109].name)

				arg_42_1.leftNameTxt_.text = var_45_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_33 = arg_42_1:GetWordFromCfg(417242010)
				local var_45_34 = arg_42_1:FormatText(var_45_33.content)

				arg_42_1.text_.text = var_45_34

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_35 = 20
				local var_45_36 = utf8.len(var_45_34)
				local var_45_37 = var_45_35 <= 0 and var_45_31 or var_45_31 * (var_45_36 / var_45_35)

				if var_45_37 > 0 and var_45_31 < var_45_37 then
					arg_42_1.talkMaxDuration = var_45_37

					if var_45_37 + var_45_30 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_37 + var_45_30
					end
				end

				arg_42_1.text_.text = var_45_34
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242010", "story_v_out_417242.awb") ~= 0 then
					local var_45_38 = manager.audio:GetVoiceLength("story_v_out_417242", "417242010", "story_v_out_417242.awb") / 1000

					if var_45_38 + var_45_30 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_38 + var_45_30
					end

					if var_45_33.prefab_name ~= "" and arg_42_1.actors_[var_45_33.prefab_name] ~= nil then
						local var_45_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_33.prefab_name].transform, "story_v_out_417242", "417242010", "story_v_out_417242.awb")

						arg_42_1:RecordAudio("417242010", var_45_39)
						arg_42_1:RecordAudio("417242010", var_45_39)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_417242", "417242010", "story_v_out_417242.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_417242", "417242010", "story_v_out_417242.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_40 = math.max(var_45_31, arg_42_1.talkMaxDuration)

			if var_45_30 <= arg_42_1.time_ and arg_42_1.time_ < var_45_30 + var_45_40 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_30) / var_45_40

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_30 + var_45_40 and arg_42_1.time_ < var_45_30 + var_45_40 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play417242011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417242011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play417242012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["1034"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.actorSpriteComps1034 == nil then
				arg_46_1.var_.actorSpriteComps1034 = var_49_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_2 = 0.2

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.actorSpriteComps1034 then
					for iter_49_0, iter_49_1 in pairs(arg_46_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_49_1 then
							if arg_46_1.isInRecall_ then
								local var_49_4 = Mathf.Lerp(iter_49_1.color.r, arg_46_1.hightColor2.r, var_49_3)
								local var_49_5 = Mathf.Lerp(iter_49_1.color.g, arg_46_1.hightColor2.g, var_49_3)
								local var_49_6 = Mathf.Lerp(iter_49_1.color.b, arg_46_1.hightColor2.b, var_49_3)

								iter_49_1.color = Color.New(var_49_4, var_49_5, var_49_6)
							else
								local var_49_7 = Mathf.Lerp(iter_49_1.color.r, 0.5, var_49_3)

								iter_49_1.color = Color.New(var_49_7, var_49_7, var_49_7)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.actorSpriteComps1034 then
				for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_49_3 then
						if arg_46_1.isInRecall_ then
							iter_49_3.color = arg_46_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_49_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_46_1.var_.actorSpriteComps1034 = nil
			end

			local var_49_8 = arg_46_1.actors_["1034"].transform
			local var_49_9 = 0

			if var_49_9 < arg_46_1.time_ and arg_46_1.time_ <= var_49_9 + arg_49_0 then
				arg_46_1.var_.moveOldPos1034 = var_49_8.localPosition
				var_49_8.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("1034", 7)

				local var_49_10 = var_49_8.childCount

				for iter_49_4 = 0, var_49_10 - 1 do
					local var_49_11 = var_49_8:GetChild(iter_49_4)

					if var_49_11.name == "" or not string.find(var_49_11.name, "split") then
						var_49_11.gameObject:SetActive(true)
					else
						var_49_11.gameObject:SetActive(false)
					end
				end
			end

			local var_49_12 = 0.001

			if var_49_9 <= arg_46_1.time_ and arg_46_1.time_ < var_49_9 + var_49_12 then
				local var_49_13 = (arg_46_1.time_ - var_49_9) / var_49_12
				local var_49_14 = Vector3.New(0, -2000, 0)

				var_49_8.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1034, var_49_14, var_49_13)
			end

			if arg_46_1.time_ >= var_49_9 + var_49_12 and arg_46_1.time_ < var_49_9 + var_49_12 + arg_49_0 then
				var_49_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_49_15 = 0
			local var_49_16 = 1.625

			if var_49_15 < arg_46_1.time_ and arg_46_1.time_ <= var_49_15 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_17 = arg_46_1:GetWordFromCfg(417242011)
				local var_49_18 = arg_46_1:FormatText(var_49_17.content)

				arg_46_1.text_.text = var_49_18

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_19 = 65
				local var_49_20 = utf8.len(var_49_18)
				local var_49_21 = var_49_19 <= 0 and var_49_16 or var_49_16 * (var_49_20 / var_49_19)

				if var_49_21 > 0 and var_49_16 < var_49_21 then
					arg_46_1.talkMaxDuration = var_49_21

					if var_49_21 + var_49_15 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_21 + var_49_15
					end
				end

				arg_46_1.text_.text = var_49_18
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_22 = math.max(var_49_16, arg_46_1.talkMaxDuration)

			if var_49_15 <= arg_46_1.time_ and arg_46_1.time_ < var_49_15 + var_49_22 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_15) / var_49_22

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_15 + var_49_22 and arg_46_1.time_ < var_49_15 + var_49_22 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play417242012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417242012
		arg_50_1.duration_ = 8.67

		local var_50_0 = {
			zh = 7.366,
			ja = 8.666
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
				arg_50_0:Play417242013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 4

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.allBtn_.enabled = false
			end

			local var_53_1 = 0.133333333333333

			if arg_50_1.time_ >= var_53_0 + var_53_1 and arg_50_1.time_ < var_53_0 + var_53_1 + arg_53_0 then
				arg_50_1.allBtn_.enabled = true
			end

			local var_53_2 = "ST73"

			if arg_50_1.bgs_[var_53_2] == nil then
				local var_53_3 = Object.Instantiate(arg_50_1.paintGo_)

				var_53_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_53_2)
				var_53_3.name = var_53_2
				var_53_3.transform.parent = arg_50_1.stage_.transform
				var_53_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_50_1.bgs_[var_53_2] = var_53_3
			end

			local var_53_4 = 2

			if var_53_4 < arg_50_1.time_ and arg_50_1.time_ <= var_53_4 + arg_53_0 then
				local var_53_5 = manager.ui.mainCamera.transform.localPosition
				local var_53_6 = Vector3.New(0, 0, 10) + Vector3.New(var_53_5.x, var_53_5.y, 0)
				local var_53_7 = arg_50_1.bgs_.ST73

				var_53_7.transform.localPosition = var_53_6
				var_53_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_53_8 = var_53_7:GetComponent("SpriteRenderer")

				if var_53_8 and var_53_8.sprite then
					local var_53_9 = (var_53_7.transform.localPosition - var_53_5).z
					local var_53_10 = manager.ui.mainCameraCom_
					local var_53_11 = 2 * var_53_9 * Mathf.Tan(var_53_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_53_12 = var_53_11 * var_53_10.aspect
					local var_53_13 = var_53_8.sprite.bounds.size.x
					local var_53_14 = var_53_8.sprite.bounds.size.y
					local var_53_15 = var_53_12 / var_53_13
					local var_53_16 = var_53_11 / var_53_14
					local var_53_17 = var_53_16 < var_53_15 and var_53_15 or var_53_16

					var_53_7.transform.localScale = Vector3.New(var_53_17, var_53_17, 0)
				end

				for iter_53_0, iter_53_1 in pairs(arg_50_1.bgs_) do
					if iter_53_0 ~= "ST73" then
						iter_53_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_53_18 = 0

			if var_53_18 < arg_50_1.time_ and arg_50_1.time_ <= var_53_18 + arg_53_0 then
				arg_50_1.mask_.enabled = true
				arg_50_1.mask_.raycastTarget = true

				arg_50_1:SetGaussion(false)
			end

			local var_53_19 = 2

			if var_53_18 <= arg_50_1.time_ and arg_50_1.time_ < var_53_18 + var_53_19 then
				local var_53_20 = (arg_50_1.time_ - var_53_18) / var_53_19
				local var_53_21 = Color.New(0, 0, 0)

				var_53_21.a = Mathf.Lerp(0, 1, var_53_20)
				arg_50_1.mask_.color = var_53_21
			end

			if arg_50_1.time_ >= var_53_18 + var_53_19 and arg_50_1.time_ < var_53_18 + var_53_19 + arg_53_0 then
				local var_53_22 = Color.New(0, 0, 0)

				var_53_22.a = 1
				arg_50_1.mask_.color = var_53_22
			end

			local var_53_23 = 2

			if var_53_23 < arg_50_1.time_ and arg_50_1.time_ <= var_53_23 + arg_53_0 then
				arg_50_1.mask_.enabled = true
				arg_50_1.mask_.raycastTarget = true

				arg_50_1:SetGaussion(false)
			end

			local var_53_24 = 2

			if var_53_23 <= arg_50_1.time_ and arg_50_1.time_ < var_53_23 + var_53_24 then
				local var_53_25 = (arg_50_1.time_ - var_53_23) / var_53_24
				local var_53_26 = Color.New(0, 0, 0)

				var_53_26.a = Mathf.Lerp(1, 0, var_53_25)
				arg_50_1.mask_.color = var_53_26
			end

			if arg_50_1.time_ >= var_53_23 + var_53_24 and arg_50_1.time_ < var_53_23 + var_53_24 + arg_53_0 then
				local var_53_27 = Color.New(0, 0, 0)
				local var_53_28 = 0

				arg_50_1.mask_.enabled = false
				var_53_27.a = var_53_28
				arg_50_1.mask_.color = var_53_27
			end

			local var_53_29 = arg_50_1.actors_["10115"]
			local var_53_30 = 3.7

			if var_53_30 < arg_50_1.time_ and arg_50_1.time_ <= var_53_30 + arg_53_0 and not isNil(var_53_29) and arg_50_1.var_.actorSpriteComps10115 == nil then
				arg_50_1.var_.actorSpriteComps10115 = var_53_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_31 = 0.2

			if var_53_30 <= arg_50_1.time_ and arg_50_1.time_ < var_53_30 + var_53_31 and not isNil(var_53_29) then
				local var_53_32 = (arg_50_1.time_ - var_53_30) / var_53_31

				if arg_50_1.var_.actorSpriteComps10115 then
					for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_53_3 then
							if arg_50_1.isInRecall_ then
								local var_53_33 = Mathf.Lerp(iter_53_3.color.r, arg_50_1.hightColor1.r, var_53_32)
								local var_53_34 = Mathf.Lerp(iter_53_3.color.g, arg_50_1.hightColor1.g, var_53_32)
								local var_53_35 = Mathf.Lerp(iter_53_3.color.b, arg_50_1.hightColor1.b, var_53_32)

								iter_53_3.color = Color.New(var_53_33, var_53_34, var_53_35)
							else
								local var_53_36 = Mathf.Lerp(iter_53_3.color.r, 1, var_53_32)

								iter_53_3.color = Color.New(var_53_36, var_53_36, var_53_36)
							end
						end
					end
				end
			end

			if arg_50_1.time_ >= var_53_30 + var_53_31 and arg_50_1.time_ < var_53_30 + var_53_31 + arg_53_0 and not isNil(var_53_29) and arg_50_1.var_.actorSpriteComps10115 then
				for iter_53_4, iter_53_5 in pairs(arg_50_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_53_5 then
						if arg_50_1.isInRecall_ then
							iter_53_5.color = arg_50_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_53_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_50_1.var_.actorSpriteComps10115 = nil
			end

			local var_53_37 = arg_50_1.actors_["10115"].transform
			local var_53_38 = 3.7

			if var_53_38 < arg_50_1.time_ and arg_50_1.time_ <= var_53_38 + arg_53_0 then
				arg_50_1.var_.moveOldPos10115 = var_53_37.localPosition
				var_53_37.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("10115", 3)

				local var_53_39 = var_53_37.childCount

				for iter_53_6 = 0, var_53_39 - 1 do
					local var_53_40 = var_53_37:GetChild(iter_53_6)

					if var_53_40.name == "split_2" or not string.find(var_53_40.name, "split") then
						var_53_40.gameObject:SetActive(true)
					else
						var_53_40.gameObject:SetActive(false)
					end
				end
			end

			local var_53_41 = 0.001

			if var_53_38 <= arg_50_1.time_ and arg_50_1.time_ < var_53_38 + var_53_41 then
				local var_53_42 = (arg_50_1.time_ - var_53_38) / var_53_41
				local var_53_43 = Vector3.New(0, -387.3, -246.2)

				var_53_37.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos10115, var_53_43, var_53_42)
			end

			if arg_50_1.time_ >= var_53_38 + var_53_41 and arg_50_1.time_ < var_53_38 + var_53_41 + arg_53_0 then
				var_53_37.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_53_44 = arg_50_1.actors_["10115"]
			local var_53_45 = 3.7

			if var_53_45 < arg_50_1.time_ and arg_50_1.time_ <= var_53_45 + arg_53_0 then
				local var_53_46 = var_53_44:GetComponentInChildren(typeof(CanvasGroup))

				if var_53_46 then
					arg_50_1.var_.alphaOldValue10115 = var_53_46.alpha
					arg_50_1.var_.characterEffect10115 = var_53_46
				end

				arg_50_1.var_.alphaOldValue10115 = 0
			end

			local var_53_47 = 0.3

			if var_53_45 <= arg_50_1.time_ and arg_50_1.time_ < var_53_45 + var_53_47 then
				local var_53_48 = (arg_50_1.time_ - var_53_45) / var_53_47
				local var_53_49 = Mathf.Lerp(arg_50_1.var_.alphaOldValue10115, 1, var_53_48)

				if arg_50_1.var_.characterEffect10115 then
					arg_50_1.var_.characterEffect10115.alpha = var_53_49
				end
			end

			if arg_50_1.time_ >= var_53_45 + var_53_47 and arg_50_1.time_ < var_53_45 + var_53_47 + arg_53_0 and arg_50_1.var_.characterEffect10115 then
				arg_50_1.var_.characterEffect10115.alpha = 1
			end

			local var_53_50 = 1.43333333333333
			local var_53_51 = 1

			if var_53_50 < arg_50_1.time_ and arg_50_1.time_ <= var_53_50 + arg_53_0 then
				local var_53_52 = "stop"
				local var_53_53 = "effect"

				arg_50_1:AudioAction(var_53_52, var_53_53, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if arg_50_1.frameCnt_ <= 1 then
				arg_50_1.dialog_:SetActive(false)
			end

			local var_53_54 = 4
			local var_53_55 = 0.3

			if var_53_54 < arg_50_1.time_ and arg_50_1.time_ <= var_53_54 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0

				arg_50_1.dialog_:SetActive(true)

				arg_50_1.dialogCg_.alpha = 0

				local var_53_56 = LeanTween.value(arg_50_1.dialog_, 0, 1, 0.3)

				var_53_56:setOnUpdate(LuaHelper.FloatAction(function(arg_54_0)
					arg_50_1.dialogCg_.alpha = arg_54_0
				end))
				var_53_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_50_1.dialog_)
					var_53_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_50_1.duration_ = arg_50_1.duration_ + 0.3

				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_57 = arg_50_1:FormatText(StoryNameCfg[1113].name)

				arg_50_1.leftNameTxt_.text = var_53_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_58 = arg_50_1:GetWordFromCfg(417242012)
				local var_53_59 = arg_50_1:FormatText(var_53_58.content)

				arg_50_1.text_.text = var_53_59

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_60 = 12
				local var_53_61 = utf8.len(var_53_59)
				local var_53_62 = var_53_60 <= 0 and var_53_55 or var_53_55 * (var_53_61 / var_53_60)

				if var_53_62 > 0 and var_53_55 < var_53_62 then
					arg_50_1.talkMaxDuration = var_53_62
					var_53_54 = var_53_54 + 0.3

					if var_53_62 + var_53_54 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_62 + var_53_54
					end
				end

				arg_50_1.text_.text = var_53_59
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242012", "story_v_out_417242.awb") ~= 0 then
					local var_53_63 = manager.audio:GetVoiceLength("story_v_out_417242", "417242012", "story_v_out_417242.awb") / 1000

					if var_53_63 + var_53_54 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_63 + var_53_54
					end

					if var_53_58.prefab_name ~= "" and arg_50_1.actors_[var_53_58.prefab_name] ~= nil then
						local var_53_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_58.prefab_name].transform, "story_v_out_417242", "417242012", "story_v_out_417242.awb")

						arg_50_1:RecordAudio("417242012", var_53_64)
						arg_50_1:RecordAudio("417242012", var_53_64)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_417242", "417242012", "story_v_out_417242.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_417242", "417242012", "story_v_out_417242.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_65 = var_53_54 + 0.3
			local var_53_66 = math.max(var_53_55, arg_50_1.talkMaxDuration)

			if var_53_65 <= arg_50_1.time_ and arg_50_1.time_ < var_53_65 + var_53_66 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_65) / var_53_66

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_65 + var_53_66 and arg_50_1.time_ < var_53_65 + var_53_66 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play417242013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 417242013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play417242014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["10115"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps10115 == nil then
				arg_56_1.var_.actorSpriteComps10115 = var_59_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_2 = 0.2

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.actorSpriteComps10115 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_59_1 then
							if arg_56_1.isInRecall_ then
								local var_59_4 = Mathf.Lerp(iter_59_1.color.r, arg_56_1.hightColor2.r, var_59_3)
								local var_59_5 = Mathf.Lerp(iter_59_1.color.g, arg_56_1.hightColor2.g, var_59_3)
								local var_59_6 = Mathf.Lerp(iter_59_1.color.b, arg_56_1.hightColor2.b, var_59_3)

								iter_59_1.color = Color.New(var_59_4, var_59_5, var_59_6)
							else
								local var_59_7 = Mathf.Lerp(iter_59_1.color.r, 0.5, var_59_3)

								iter_59_1.color = Color.New(var_59_7, var_59_7, var_59_7)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps10115 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_59_3 then
						if arg_56_1.isInRecall_ then
							iter_59_3.color = arg_56_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_59_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_56_1.var_.actorSpriteComps10115 = nil
			end

			local var_59_8 = arg_56_1.actors_["10115"].transform
			local var_59_9 = 0

			if var_59_9 < arg_56_1.time_ and arg_56_1.time_ <= var_59_9 + arg_59_0 then
				arg_56_1.var_.moveOldPos10115 = var_59_8.localPosition
				var_59_8.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("10115", 7)

				local var_59_10 = var_59_8.childCount

				for iter_59_4 = 0, var_59_10 - 1 do
					local var_59_11 = var_59_8:GetChild(iter_59_4)

					if var_59_11.name == "" or not string.find(var_59_11.name, "split") then
						var_59_11.gameObject:SetActive(true)
					else
						var_59_11.gameObject:SetActive(false)
					end
				end
			end

			local var_59_12 = 0.001

			if var_59_9 <= arg_56_1.time_ and arg_56_1.time_ < var_59_9 + var_59_12 then
				local var_59_13 = (arg_56_1.time_ - var_59_9) / var_59_12
				local var_59_14 = Vector3.New(0, -2000, 0)

				var_59_8.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10115, var_59_14, var_59_13)
			end

			if arg_56_1.time_ >= var_59_9 + var_59_12 and arg_56_1.time_ < var_59_9 + var_59_12 + arg_59_0 then
				var_59_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_59_15 = 0
			local var_59_16 = 1.475

			if var_59_15 < arg_56_1.time_ and arg_56_1.time_ <= var_59_15 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_17 = arg_56_1:GetWordFromCfg(417242013)
				local var_59_18 = arg_56_1:FormatText(var_59_17.content)

				arg_56_1.text_.text = var_59_18

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_19 = 59
				local var_59_20 = utf8.len(var_59_18)
				local var_59_21 = var_59_19 <= 0 and var_59_16 or var_59_16 * (var_59_20 / var_59_19)

				if var_59_21 > 0 and var_59_16 < var_59_21 then
					arg_56_1.talkMaxDuration = var_59_21

					if var_59_21 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_21 + var_59_15
					end
				end

				arg_56_1.text_.text = var_59_18
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_22 = math.max(var_59_16, arg_56_1.talkMaxDuration)

			if var_59_15 <= arg_56_1.time_ and arg_56_1.time_ < var_59_15 + var_59_22 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_15) / var_59_22

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_15 + var_59_22 and arg_56_1.time_ < var_59_15 + var_59_22 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
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
	Play417242014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 417242014
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play417242015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 1.45

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_2 = arg_60_1:GetWordFromCfg(417242014)
				local var_63_3 = arg_60_1:FormatText(var_63_2.content)

				arg_60_1.text_.text = var_63_3

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 58
				local var_63_5 = utf8.len(var_63_3)
				local var_63_6 = var_63_4 <= 0 and var_63_1 or var_63_1 * (var_63_5 / var_63_4)

				if var_63_6 > 0 and var_63_1 < var_63_6 then
					arg_60_1.talkMaxDuration = var_63_6

					if var_63_6 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_6 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_3
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_7 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_7 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_7

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_7 and arg_60_1.time_ < var_63_0 + var_63_7 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play417242015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 417242015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play417242016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.533333333333333
			local var_67_1 = 1

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				local var_67_2 = "play"
				local var_67_3 = "effect"

				arg_64_1:AudioAction(var_67_2, var_67_3, "se_story_1311", "se_story_1311_bag", "")
			end

			local var_67_4 = 0
			local var_67_5 = 1.025

			if var_67_4 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_6 = arg_64_1:GetWordFromCfg(417242015)
				local var_67_7 = arg_64_1:FormatText(var_67_6.content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_8 = 41
				local var_67_9 = utf8.len(var_67_7)
				local var_67_10 = var_67_8 <= 0 and var_67_5 or var_67_5 * (var_67_9 / var_67_8)

				if var_67_10 > 0 and var_67_5 < var_67_10 then
					arg_64_1.talkMaxDuration = var_67_10

					if var_67_10 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_11 = math.max(var_67_5, arg_64_1.talkMaxDuration)

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_11 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_4) / var_67_11

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_4 + var_67_11 and arg_64_1.time_ < var_67_4 + var_67_11 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play417242016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 417242016
		arg_68_1.duration_ = 4.57

		local var_68_0 = {
			zh = 4.066,
			ja = 4.566
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
				arg_68_0:Play417242017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["10115"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps10115 == nil then
				arg_68_1.var_.actorSpriteComps10115 = var_71_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_2 = 0.2

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.actorSpriteComps10115 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps10115 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_71_3 then
						if arg_68_1.isInRecall_ then
							iter_71_3.color = arg_68_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_71_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_68_1.var_.actorSpriteComps10115 = nil
			end

			local var_71_8 = arg_68_1.actors_["10115"].transform
			local var_71_9 = 0

			if var_71_9 < arg_68_1.time_ and arg_68_1.time_ <= var_71_9 + arg_71_0 then
				arg_68_1.var_.moveOldPos10115 = var_71_8.localPosition
				var_71_8.localScale = Vector3.New(1, 1, 1)

				arg_68_1:CheckSpriteTmpPos("10115", 3)

				local var_71_10 = var_71_8.childCount

				for iter_71_4 = 0, var_71_10 - 1 do
					local var_71_11 = var_71_8:GetChild(iter_71_4)

					if var_71_11.name == "split_6" or not string.find(var_71_11.name, "split") then
						var_71_11.gameObject:SetActive(true)
					else
						var_71_11.gameObject:SetActive(false)
					end
				end
			end

			local var_71_12 = 0.001

			if var_71_9 <= arg_68_1.time_ and arg_68_1.time_ < var_71_9 + var_71_12 then
				local var_71_13 = (arg_68_1.time_ - var_71_9) / var_71_12
				local var_71_14 = Vector3.New(0, -387.3, -246.2)

				var_71_8.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10115, var_71_14, var_71_13)
			end

			if arg_68_1.time_ >= var_71_9 + var_71_12 and arg_68_1.time_ < var_71_9 + var_71_12 + arg_71_0 then
				var_71_8.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_71_15 = 0
			local var_71_16 = 0.525

			if var_71_15 < arg_68_1.time_ and arg_68_1.time_ <= var_71_15 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_17 = arg_68_1:FormatText(StoryNameCfg[1113].name)

				arg_68_1.leftNameTxt_.text = var_71_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_18 = arg_68_1:GetWordFromCfg(417242016)
				local var_71_19 = arg_68_1:FormatText(var_71_18.content)

				arg_68_1.text_.text = var_71_19

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_20 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242016", "story_v_out_417242.awb") ~= 0 then
					local var_71_23 = manager.audio:GetVoiceLength("story_v_out_417242", "417242016", "story_v_out_417242.awb") / 1000

					if var_71_23 + var_71_15 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_23 + var_71_15
					end

					if var_71_18.prefab_name ~= "" and arg_68_1.actors_[var_71_18.prefab_name] ~= nil then
						local var_71_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_18.prefab_name].transform, "story_v_out_417242", "417242016", "story_v_out_417242.awb")

						arg_68_1:RecordAudio("417242016", var_71_24)
						arg_68_1:RecordAudio("417242016", var_71_24)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_417242", "417242016", "story_v_out_417242.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_417242", "417242016", "story_v_out_417242.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_25 = math.max(var_71_16, arg_68_1.talkMaxDuration)

			if var_71_15 <= arg_68_1.time_ and arg_68_1.time_ < var_71_15 + var_71_25 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_15) / var_71_25

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_15 + var_71_25 and arg_68_1.time_ < var_71_15 + var_71_25 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
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
	Play417242017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 417242017
		arg_72_1.duration_ = 4.33

		local var_72_0 = {
			zh = 3.733,
			ja = 4.333
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
				arg_72_0:Play417242018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["10128"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.actorSpriteComps10128 == nil then
				arg_72_1.var_.actorSpriteComps10128 = var_75_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_2 = 0.2

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.actorSpriteComps10128 then
					for iter_75_0, iter_75_1 in pairs(arg_72_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_75_1 then
							if arg_72_1.isInRecall_ then
								local var_75_4 = Mathf.Lerp(iter_75_1.color.r, arg_72_1.hightColor1.r, var_75_3)
								local var_75_5 = Mathf.Lerp(iter_75_1.color.g, arg_72_1.hightColor1.g, var_75_3)
								local var_75_6 = Mathf.Lerp(iter_75_1.color.b, arg_72_1.hightColor1.b, var_75_3)

								iter_75_1.color = Color.New(var_75_4, var_75_5, var_75_6)
							else
								local var_75_7 = Mathf.Lerp(iter_75_1.color.r, 1, var_75_3)

								iter_75_1.color = Color.New(var_75_7, var_75_7, var_75_7)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.actorSpriteComps10128 then
				for iter_75_2, iter_75_3 in pairs(arg_72_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_75_3 then
						if arg_72_1.isInRecall_ then
							iter_75_3.color = arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_75_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_72_1.var_.actorSpriteComps10128 = nil
			end

			local var_75_8 = arg_72_1.actors_["10115"]
			local var_75_9 = 0

			if var_75_9 < arg_72_1.time_ and arg_72_1.time_ <= var_75_9 + arg_75_0 and not isNil(var_75_8) and arg_72_1.var_.actorSpriteComps10115 == nil then
				arg_72_1.var_.actorSpriteComps10115 = var_75_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_10 = 0.2

			if var_75_9 <= arg_72_1.time_ and arg_72_1.time_ < var_75_9 + var_75_10 and not isNil(var_75_8) then
				local var_75_11 = (arg_72_1.time_ - var_75_9) / var_75_10

				if arg_72_1.var_.actorSpriteComps10115 then
					for iter_75_4, iter_75_5 in pairs(arg_72_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_75_5 then
							if arg_72_1.isInRecall_ then
								local var_75_12 = Mathf.Lerp(iter_75_5.color.r, arg_72_1.hightColor2.r, var_75_11)
								local var_75_13 = Mathf.Lerp(iter_75_5.color.g, arg_72_1.hightColor2.g, var_75_11)
								local var_75_14 = Mathf.Lerp(iter_75_5.color.b, arg_72_1.hightColor2.b, var_75_11)

								iter_75_5.color = Color.New(var_75_12, var_75_13, var_75_14)
							else
								local var_75_15 = Mathf.Lerp(iter_75_5.color.r, 0.5, var_75_11)

								iter_75_5.color = Color.New(var_75_15, var_75_15, var_75_15)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= var_75_9 + var_75_10 and arg_72_1.time_ < var_75_9 + var_75_10 + arg_75_0 and not isNil(var_75_8) and arg_72_1.var_.actorSpriteComps10115 then
				for iter_75_6, iter_75_7 in pairs(arg_72_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_75_7 then
						if arg_72_1.isInRecall_ then
							iter_75_7.color = arg_72_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_75_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_72_1.var_.actorSpriteComps10115 = nil
			end

			local var_75_16 = arg_72_1.actors_["10128"].transform
			local var_75_17 = 0

			if var_75_17 < arg_72_1.time_ and arg_72_1.time_ <= var_75_17 + arg_75_0 then
				arg_72_1.var_.moveOldPos10128 = var_75_16.localPosition
				var_75_16.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("10128", 4)

				local var_75_18 = var_75_16.childCount

				for iter_75_8 = 0, var_75_18 - 1 do
					local var_75_19 = var_75_16:GetChild(iter_75_8)

					if var_75_19.name == "" or not string.find(var_75_19.name, "split") then
						var_75_19.gameObject:SetActive(true)
					else
						var_75_19.gameObject:SetActive(false)
					end
				end
			end

			local var_75_20 = 0.001

			if var_75_17 <= arg_72_1.time_ and arg_72_1.time_ < var_75_17 + var_75_20 then
				local var_75_21 = (arg_72_1.time_ - var_75_17) / var_75_20
				local var_75_22 = Vector3.New(390, -347, -300)

				var_75_16.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10128, var_75_22, var_75_21)
			end

			if arg_72_1.time_ >= var_75_17 + var_75_20 and arg_72_1.time_ < var_75_17 + var_75_20 + arg_75_0 then
				var_75_16.localPosition = Vector3.New(390, -347, -300)
			end

			local var_75_23 = arg_72_1.actors_["10115"].transform
			local var_75_24 = 0

			if var_75_24 < arg_72_1.time_ and arg_72_1.time_ <= var_75_24 + arg_75_0 then
				arg_72_1.var_.moveOldPos10115 = var_75_23.localPosition
				var_75_23.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("10115", 2)

				local var_75_25 = var_75_23.childCount

				for iter_75_9 = 0, var_75_25 - 1 do
					local var_75_26 = var_75_23:GetChild(iter_75_9)

					if var_75_26.name == "" or not string.find(var_75_26.name, "split") then
						var_75_26.gameObject:SetActive(true)
					else
						var_75_26.gameObject:SetActive(false)
					end
				end
			end

			local var_75_27 = 0.001

			if var_75_24 <= arg_72_1.time_ and arg_72_1.time_ < var_75_24 + var_75_27 then
				local var_75_28 = (arg_72_1.time_ - var_75_24) / var_75_27
				local var_75_29 = Vector3.New(-390, -387.3, -246.2)

				var_75_23.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10115, var_75_29, var_75_28)
			end

			if arg_72_1.time_ >= var_75_24 + var_75_27 and arg_72_1.time_ < var_75_24 + var_75_27 + arg_75_0 then
				var_75_23.localPosition = Vector3.New(-390, -387.3, -246.2)
			end

			local var_75_30 = 0
			local var_75_31 = 0.425

			if var_75_30 < arg_72_1.time_ and arg_72_1.time_ <= var_75_30 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_32 = arg_72_1:FormatText(StoryNameCfg[595].name)

				arg_72_1.leftNameTxt_.text = var_75_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_33 = arg_72_1:GetWordFromCfg(417242017)
				local var_75_34 = arg_72_1:FormatText(var_75_33.content)

				arg_72_1.text_.text = var_75_34

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_35 = 17
				local var_75_36 = utf8.len(var_75_34)
				local var_75_37 = var_75_35 <= 0 and var_75_31 or var_75_31 * (var_75_36 / var_75_35)

				if var_75_37 > 0 and var_75_31 < var_75_37 then
					arg_72_1.talkMaxDuration = var_75_37

					if var_75_37 + var_75_30 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_37 + var_75_30
					end
				end

				arg_72_1.text_.text = var_75_34
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242017", "story_v_out_417242.awb") ~= 0 then
					local var_75_38 = manager.audio:GetVoiceLength("story_v_out_417242", "417242017", "story_v_out_417242.awb") / 1000

					if var_75_38 + var_75_30 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_38 + var_75_30
					end

					if var_75_33.prefab_name ~= "" and arg_72_1.actors_[var_75_33.prefab_name] ~= nil then
						local var_75_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_33.prefab_name].transform, "story_v_out_417242", "417242017", "story_v_out_417242.awb")

						arg_72_1:RecordAudio("417242017", var_75_39)
						arg_72_1:RecordAudio("417242017", var_75_39)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_417242", "417242017", "story_v_out_417242.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_417242", "417242017", "story_v_out_417242.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_40 = math.max(var_75_31, arg_72_1.talkMaxDuration)

			if var_75_30 <= arg_72_1.time_ and arg_72_1.time_ < var_75_30 + var_75_40 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_30) / var_75_40

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_30 + var_75_40 and arg_72_1.time_ < var_75_30 + var_75_40 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10115",
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
	Play417242018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 417242018
		arg_76_1.duration_ = 1

		local var_76_0 = {
			zh = 0.999999999999,
			ja = 1
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
				arg_76_0:Play417242019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1034"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps1034 == nil then
				arg_76_1.var_.actorSpriteComps1034 = var_79_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_2 = 0.2

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.actorSpriteComps1034 then
					for iter_79_0, iter_79_1 in pairs(arg_76_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps1034 then
				for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_79_3 then
						if arg_76_1.isInRecall_ then
							iter_79_3.color = arg_76_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_79_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps1034 = nil
			end

			local var_79_8 = arg_76_1.actors_["10128"]
			local var_79_9 = 0

			if var_79_9 < arg_76_1.time_ and arg_76_1.time_ <= var_79_9 + arg_79_0 and not isNil(var_79_8) and arg_76_1.var_.actorSpriteComps10128 == nil then
				arg_76_1.var_.actorSpriteComps10128 = var_79_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_10 = 0.2

			if var_79_9 <= arg_76_1.time_ and arg_76_1.time_ < var_79_9 + var_79_10 and not isNil(var_79_8) then
				local var_79_11 = (arg_76_1.time_ - var_79_9) / var_79_10

				if arg_76_1.var_.actorSpriteComps10128 then
					for iter_79_4, iter_79_5 in pairs(arg_76_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_76_1.time_ >= var_79_9 + var_79_10 and arg_76_1.time_ < var_79_9 + var_79_10 + arg_79_0 and not isNil(var_79_8) and arg_76_1.var_.actorSpriteComps10128 then
				for iter_79_6, iter_79_7 in pairs(arg_76_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_79_7 then
						if arg_76_1.isInRecall_ then
							iter_79_7.color = arg_76_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_79_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps10128 = nil
			end

			local var_79_16 = arg_76_1.actors_["1034"].transform
			local var_79_17 = 0

			if var_79_17 < arg_76_1.time_ and arg_76_1.time_ <= var_79_17 + arg_79_0 then
				arg_76_1.var_.moveOldPos1034 = var_79_16.localPosition
				var_79_16.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("1034", 3)

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
				local var_79_22 = Vector3.New(0, -331.9, -324)

				var_79_16.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1034, var_79_22, var_79_21)
			end

			if arg_76_1.time_ >= var_79_17 + var_79_20 and arg_76_1.time_ < var_79_17 + var_79_20 + arg_79_0 then
				var_79_16.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_79_23 = arg_76_1.actors_["10128"].transform
			local var_79_24 = 0

			if var_79_24 < arg_76_1.time_ and arg_76_1.time_ <= var_79_24 + arg_79_0 then
				arg_76_1.var_.moveOldPos10128 = var_79_23.localPosition
				var_79_23.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("10128", 7)

				local var_79_25 = var_79_23.childCount

				for iter_79_9 = 0, var_79_25 - 1 do
					local var_79_26 = var_79_23:GetChild(iter_79_9)

					if var_79_26.name == "" or not string.find(var_79_26.name, "split") then
						var_79_26.gameObject:SetActive(true)
					else
						var_79_26.gameObject:SetActive(false)
					end
				end
			end

			local var_79_27 = 0.001

			if var_79_24 <= arg_76_1.time_ and arg_76_1.time_ < var_79_24 + var_79_27 then
				local var_79_28 = (arg_76_1.time_ - var_79_24) / var_79_27
				local var_79_29 = Vector3.New(0, -2000, -300)

				var_79_23.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10128, var_79_29, var_79_28)
			end

			if arg_76_1.time_ >= var_79_24 + var_79_27 and arg_76_1.time_ < var_79_24 + var_79_27 + arg_79_0 then
				var_79_23.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_79_30 = arg_76_1.actors_["10115"].transform
			local var_79_31 = 0

			if var_79_31 < arg_76_1.time_ and arg_76_1.time_ <= var_79_31 + arg_79_0 then
				arg_76_1.var_.moveOldPos10115 = var_79_30.localPosition
				var_79_30.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("10115", 7)

				local var_79_32 = var_79_30.childCount

				for iter_79_10 = 0, var_79_32 - 1 do
					local var_79_33 = var_79_30:GetChild(iter_79_10)

					if var_79_33.name == "" or not string.find(var_79_33.name, "split") then
						var_79_33.gameObject:SetActive(true)
					else
						var_79_33.gameObject:SetActive(false)
					end
				end
			end

			local var_79_34 = 0.001

			if var_79_31 <= arg_76_1.time_ and arg_76_1.time_ < var_79_31 + var_79_34 then
				local var_79_35 = (arg_76_1.time_ - var_79_31) / var_79_34
				local var_79_36 = Vector3.New(0, -2000, 0)

				var_79_30.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10115, var_79_36, var_79_35)
			end

			if arg_76_1.time_ >= var_79_31 + var_79_34 and arg_76_1.time_ < var_79_31 + var_79_34 + arg_79_0 then
				var_79_30.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_79_37 = 0
			local var_79_38 = 0.1

			if var_79_37 < arg_76_1.time_ and arg_76_1.time_ <= var_79_37 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_39 = arg_76_1:FormatText(StoryNameCfg[1109].name)

				arg_76_1.leftNameTxt_.text = var_79_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_40 = arg_76_1:GetWordFromCfg(417242018)
				local var_79_41 = arg_76_1:FormatText(var_79_40.content)

				arg_76_1.text_.text = var_79_41

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_42 = 4
				local var_79_43 = utf8.len(var_79_41)
				local var_79_44 = var_79_42 <= 0 and var_79_38 or var_79_38 * (var_79_43 / var_79_42)

				if var_79_44 > 0 and var_79_38 < var_79_44 then
					arg_76_1.talkMaxDuration = var_79_44

					if var_79_44 + var_79_37 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_44 + var_79_37
					end
				end

				arg_76_1.text_.text = var_79_41
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242018", "story_v_out_417242.awb") ~= 0 then
					local var_79_45 = manager.audio:GetVoiceLength("story_v_out_417242", "417242018", "story_v_out_417242.awb") / 1000

					if var_79_45 + var_79_37 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_45 + var_79_37
					end

					if var_79_40.prefab_name ~= "" and arg_76_1.actors_[var_79_40.prefab_name] ~= nil then
						local var_79_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_40.prefab_name].transform, "story_v_out_417242", "417242018", "story_v_out_417242.awb")

						arg_76_1:RecordAudio("417242018", var_79_46)
						arg_76_1:RecordAudio("417242018", var_79_46)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_417242", "417242018", "story_v_out_417242.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_417242", "417242018", "story_v_out_417242.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_47 = math.max(var_79_38, arg_76_1.talkMaxDuration)

			if var_79_37 <= arg_76_1.time_ and arg_76_1.time_ < var_79_37 + var_79_47 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_37) / var_79_47

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_37 + var_79_47 and arg_76_1.time_ < var_79_37 + var_79_47 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10115",
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
	Play417242019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 417242019
		arg_80_1.duration_ = 9.53

		local var_80_0 = {
			zh = 5.966,
			ja = 9.533
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
				arg_80_0:Play417242020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["10115"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.actorSpriteComps10115 == nil then
				arg_80_1.var_.actorSpriteComps10115 = var_83_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_2 = 0.2

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.actorSpriteComps10115 then
					for iter_83_0, iter_83_1 in pairs(arg_80_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.actorSpriteComps10115 then
				for iter_83_2, iter_83_3 in pairs(arg_80_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_83_3 then
						if arg_80_1.isInRecall_ then
							iter_83_3.color = arg_80_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_83_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_80_1.var_.actorSpriteComps10115 = nil
			end

			local var_83_8 = arg_80_1.actors_["1034"]
			local var_83_9 = 0

			if var_83_9 < arg_80_1.time_ and arg_80_1.time_ <= var_83_9 + arg_83_0 and not isNil(var_83_8) and arg_80_1.var_.actorSpriteComps1034 == nil then
				arg_80_1.var_.actorSpriteComps1034 = var_83_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_10 = 0.2

			if var_83_9 <= arg_80_1.time_ and arg_80_1.time_ < var_83_9 + var_83_10 and not isNil(var_83_8) then
				local var_83_11 = (arg_80_1.time_ - var_83_9) / var_83_10

				if arg_80_1.var_.actorSpriteComps1034 then
					for iter_83_4, iter_83_5 in pairs(arg_80_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_80_1.time_ >= var_83_9 + var_83_10 and arg_80_1.time_ < var_83_9 + var_83_10 + arg_83_0 and not isNil(var_83_8) and arg_80_1.var_.actorSpriteComps1034 then
				for iter_83_6, iter_83_7 in pairs(arg_80_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_83_7 then
						if arg_80_1.isInRecall_ then
							iter_83_7.color = arg_80_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_83_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_80_1.var_.actorSpriteComps1034 = nil
			end

			local var_83_16 = arg_80_1.actors_["1034"].transform
			local var_83_17 = 0

			if var_83_17 < arg_80_1.time_ and arg_80_1.time_ <= var_83_17 + arg_83_0 then
				arg_80_1.var_.moveOldPos1034 = var_83_16.localPosition
				var_83_16.localScale = Vector3.New(1, 1, 1)

				arg_80_1:CheckSpriteTmpPos("1034", 7)

				local var_83_18 = var_83_16.childCount

				for iter_83_8 = 0, var_83_18 - 1 do
					local var_83_19 = var_83_16:GetChild(iter_83_8)

					if var_83_19.name == "" or not string.find(var_83_19.name, "split") then
						var_83_19.gameObject:SetActive(true)
					else
						var_83_19.gameObject:SetActive(false)
					end
				end
			end

			local var_83_20 = 0.001

			if var_83_17 <= arg_80_1.time_ and arg_80_1.time_ < var_83_17 + var_83_20 then
				local var_83_21 = (arg_80_1.time_ - var_83_17) / var_83_20
				local var_83_22 = Vector3.New(0, -2000, 0)

				var_83_16.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1034, var_83_22, var_83_21)
			end

			if arg_80_1.time_ >= var_83_17 + var_83_20 and arg_80_1.time_ < var_83_17 + var_83_20 + arg_83_0 then
				var_83_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_83_23 = arg_80_1.actors_["10115"].transform
			local var_83_24 = 0

			if var_83_24 < arg_80_1.time_ and arg_80_1.time_ <= var_83_24 + arg_83_0 then
				arg_80_1.var_.moveOldPos10115 = var_83_23.localPosition
				var_83_23.localScale = Vector3.New(1, 1, 1)

				arg_80_1:CheckSpriteTmpPos("10115", 3)

				local var_83_25 = var_83_23.childCount

				for iter_83_9 = 0, var_83_25 - 1 do
					local var_83_26 = var_83_23:GetChild(iter_83_9)

					if var_83_26.name == "" or not string.find(var_83_26.name, "split") then
						var_83_26.gameObject:SetActive(true)
					else
						var_83_26.gameObject:SetActive(false)
					end
				end
			end

			local var_83_27 = 0.001

			if var_83_24 <= arg_80_1.time_ and arg_80_1.time_ < var_83_24 + var_83_27 then
				local var_83_28 = (arg_80_1.time_ - var_83_24) / var_83_27
				local var_83_29 = Vector3.New(0, -387.3, -246.2)

				var_83_23.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10115, var_83_29, var_83_28)
			end

			if arg_80_1.time_ >= var_83_24 + var_83_27 and arg_80_1.time_ < var_83_24 + var_83_27 + arg_83_0 then
				var_83_23.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_83_30 = 0
			local var_83_31 = 0.9

			if var_83_30 < arg_80_1.time_ and arg_80_1.time_ <= var_83_30 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_32 = arg_80_1:FormatText(StoryNameCfg[1113].name)

				arg_80_1.leftNameTxt_.text = var_83_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_33 = arg_80_1:GetWordFromCfg(417242019)
				local var_83_34 = arg_80_1:FormatText(var_83_33.content)

				arg_80_1.text_.text = var_83_34

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_35 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242019", "story_v_out_417242.awb") ~= 0 then
					local var_83_38 = manager.audio:GetVoiceLength("story_v_out_417242", "417242019", "story_v_out_417242.awb") / 1000

					if var_83_38 + var_83_30 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_38 + var_83_30
					end

					if var_83_33.prefab_name ~= "" and arg_80_1.actors_[var_83_33.prefab_name] ~= nil then
						local var_83_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_33.prefab_name].transform, "story_v_out_417242", "417242019", "story_v_out_417242.awb")

						arg_80_1:RecordAudio("417242019", var_83_39)
						arg_80_1:RecordAudio("417242019", var_83_39)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_417242", "417242019", "story_v_out_417242.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_417242", "417242019", "story_v_out_417242.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_40 = math.max(var_83_31, arg_80_1.talkMaxDuration)

			if var_83_30 <= arg_80_1.time_ and arg_80_1.time_ < var_83_30 + var_83_40 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_30) / var_83_40

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_30 + var_83_40 and arg_80_1.time_ < var_83_30 + var_83_40 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10115",
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
	Play417242020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 417242020
		arg_84_1.duration_ = 9.1

		local var_84_0 = {
			zh = 8.966,
			ja = 9.1
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
				arg_84_0:Play417242021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 1.025

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_2 = arg_84_1:FormatText(StoryNameCfg[1113].name)

				arg_84_1.leftNameTxt_.text = var_87_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_3 = arg_84_1:GetWordFromCfg(417242020)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 41
				local var_87_6 = utf8.len(var_87_4)
				local var_87_7 = var_87_5 <= 0 and var_87_1 or var_87_1 * (var_87_6 / var_87_5)

				if var_87_7 > 0 and var_87_1 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242020", "story_v_out_417242.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_417242", "417242020", "story_v_out_417242.awb") / 1000

					if var_87_8 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_0
					end

					if var_87_3.prefab_name ~= "" and arg_84_1.actors_[var_87_3.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_3.prefab_name].transform, "story_v_out_417242", "417242020", "story_v_out_417242.awb")

						arg_84_1:RecordAudio("417242020", var_87_9)
						arg_84_1:RecordAudio("417242020", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_417242", "417242020", "story_v_out_417242.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_417242", "417242020", "story_v_out_417242.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_10 and arg_84_1.time_ < var_87_0 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play417242021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 417242021
		arg_88_1.duration_ = 8.07

		local var_88_0 = {
			zh = 6.833,
			ja = 8.066
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
				arg_88_0:Play417242022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["10115"].transform
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.var_.moveOldPos10115 = var_91_0.localPosition
				var_91_0.localScale = Vector3.New(1, 1, 1)

				arg_88_1:CheckSpriteTmpPos("10115", 3)

				local var_91_2 = var_91_0.childCount

				for iter_91_0 = 0, var_91_2 - 1 do
					local var_91_3 = var_91_0:GetChild(iter_91_0)

					if var_91_3.name == "split_6" or not string.find(var_91_3.name, "split") then
						var_91_3.gameObject:SetActive(true)
					else
						var_91_3.gameObject:SetActive(false)
					end
				end
			end

			local var_91_4 = 0.001

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_4 then
				local var_91_5 = (arg_88_1.time_ - var_91_1) / var_91_4
				local var_91_6 = Vector3.New(0, -387.3, -246.2)

				var_91_0.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos10115, var_91_6, var_91_5)
			end

			if arg_88_1.time_ >= var_91_1 + var_91_4 and arg_88_1.time_ < var_91_1 + var_91_4 + arg_91_0 then
				var_91_0.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_91_7 = 0
			local var_91_8 = 0.725

			if var_91_7 < arg_88_1.time_ and arg_88_1.time_ <= var_91_7 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_9 = arg_88_1:FormatText(StoryNameCfg[1113].name)

				arg_88_1.leftNameTxt_.text = var_91_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_10 = arg_88_1:GetWordFromCfg(417242021)
				local var_91_11 = arg_88_1:FormatText(var_91_10.content)

				arg_88_1.text_.text = var_91_11

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_12 = 29
				local var_91_13 = utf8.len(var_91_11)
				local var_91_14 = var_91_12 <= 0 and var_91_8 or var_91_8 * (var_91_13 / var_91_12)

				if var_91_14 > 0 and var_91_8 < var_91_14 then
					arg_88_1.talkMaxDuration = var_91_14

					if var_91_14 + var_91_7 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_14 + var_91_7
					end
				end

				arg_88_1.text_.text = var_91_11
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242021", "story_v_out_417242.awb") ~= 0 then
					local var_91_15 = manager.audio:GetVoiceLength("story_v_out_417242", "417242021", "story_v_out_417242.awb") / 1000

					if var_91_15 + var_91_7 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_15 + var_91_7
					end

					if var_91_10.prefab_name ~= "" and arg_88_1.actors_[var_91_10.prefab_name] ~= nil then
						local var_91_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_10.prefab_name].transform, "story_v_out_417242", "417242021", "story_v_out_417242.awb")

						arg_88_1:RecordAudio("417242021", var_91_16)
						arg_88_1:RecordAudio("417242021", var_91_16)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_417242", "417242021", "story_v_out_417242.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_417242", "417242021", "story_v_out_417242.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_17 = math.max(var_91_8, arg_88_1.talkMaxDuration)

			if var_91_7 <= arg_88_1.time_ and arg_88_1.time_ < var_91_7 + var_91_17 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_7) / var_91_17

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_7 + var_91_17 and arg_88_1.time_ < var_91_7 + var_91_17 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
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
	Play417242022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 417242022
		arg_92_1.duration_ = 8.57

		local var_92_0 = {
			zh = 5.333,
			ja = 8.566
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
			arg_92_1.auto_ = false
		end

		function arg_92_1.playNext_(arg_94_0)
			arg_92_1.onStoryFinished_()
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 0.5

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_2 = arg_92_1:FormatText(StoryNameCfg[1113].name)

				arg_92_1.leftNameTxt_.text = var_95_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_3 = arg_92_1:GetWordFromCfg(417242022)
				local var_95_4 = arg_92_1:FormatText(var_95_3.content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242022", "story_v_out_417242.awb") ~= 0 then
					local var_95_8 = manager.audio:GetVoiceLength("story_v_out_417242", "417242022", "story_v_out_417242.awb") / 1000

					if var_95_8 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_0
					end

					if var_95_3.prefab_name ~= "" and arg_92_1.actors_[var_95_3.prefab_name] ~= nil then
						local var_95_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_3.prefab_name].transform, "story_v_out_417242", "417242022", "story_v_out_417242.awb")

						arg_92_1:RecordAudio("417242022", var_95_9)
						arg_92_1:RecordAudio("417242022", var_95_9)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_417242", "417242022", "story_v_out_417242.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_417242", "417242022", "story_v_out_417242.awb")
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
	assets = {
		"TextureConfig/Background/I17f",
		"TextureConfig/Background/ST73"
	},
	voices = {
		"story_v_out_417242.awb"
	}
}
