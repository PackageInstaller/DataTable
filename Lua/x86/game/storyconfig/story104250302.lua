return {
	Play425032001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 425032001
		arg_1_1.duration_ = 7.9

		local var_1_0 = {
			zh = 6,
			ja = 7.9
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
				arg_1_0:Play425032002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 1.999999999999

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 0.3

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = "ST2107"

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
				local var_4_7 = arg_1_1.bgs_.ST2107

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
					if iter_4_0 ~= "ST2107" then
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

			local var_4_24 = 0.1
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			local var_4_28 = 0
			local var_4_29 = 0.3

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_34 = 0.500666666666667
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "music"

				arg_1_1:AudioAction(var_4_36, var_4_37, "bgm_activity_3_10_story_daily_acoustic", "bgm_activity_3_10_story_daily_acoustic", "bgm_activity_3_10_story_daily_acoustic.awb")

				local var_4_38 = ""
				local var_4_39 = manager.audio:GetAudioName("bgm_activity_3_10_story_daily_acoustic", "bgm_activity_3_10_story_daily_acoustic")

				if var_4_39 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_39 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_39

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_39
						arg_1_1.bgmTxt2_.text = var_4_39
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

			local var_4_40 = 2
			local var_4_41 = 0.525

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_42 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_42:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_43 = arg_1_1:FormatText(StoryNameCfg[36].name)

				arg_1_1.leftNameTxt_.text = var_4_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowstudentwa")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_44 = arg_1_1:GetWordFromCfg(425032001)
				local var_4_45 = arg_1_1:FormatText(var_4_44.content)

				arg_1_1.text_.text = var_4_45

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_46 = 21
				local var_4_47 = utf8.len(var_4_45)
				local var_4_48 = var_4_46 <= 0 and var_4_41 or var_4_41 * (var_4_47 / var_4_46)

				if var_4_48 > 0 and var_4_41 < var_4_48 then
					arg_1_1.talkMaxDuration = var_4_48
					var_4_40 = var_4_40 + 0.3

					if var_4_48 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_48 + var_4_40
					end
				end

				arg_1_1.text_.text = var_4_45
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032001", "story_v_out_425032.awb") ~= 0 then
					local var_4_49 = manager.audio:GetVoiceLength("story_v_out_425032", "425032001", "story_v_out_425032.awb") / 1000

					if var_4_49 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_49 + var_4_40
					end

					if var_4_44.prefab_name ~= "" and arg_1_1.actors_[var_4_44.prefab_name] ~= nil then
						local var_4_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_44.prefab_name].transform, "story_v_out_425032", "425032001", "story_v_out_425032.awb")

						arg_1_1:RecordAudio("425032001", var_4_50)
						arg_1_1:RecordAudio("425032001", var_4_50)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_425032", "425032001", "story_v_out_425032.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_425032", "425032001", "story_v_out_425032.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_51 = var_4_40 + 0.3
			local var_4_52 = math.max(var_4_41, arg_1_1.talkMaxDuration)

			if var_4_51 <= arg_1_1.time_ and arg_1_1.time_ < var_4_51 + var_4_52 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_51) / var_4_52

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_51 + var_4_52 and arg_1_1.time_ < var_4_51 + var_4_52 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play425032002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 425032002
		arg_9_1.duration_ = 10.43

		local var_9_0 = {
			zh = 5.7,
			ja = 10.433
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
				arg_9_0:Play425032003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1086"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(var_12_1, arg_9_1.canvasGo_.transform)

					var_12_2.transform:SetSiblingIndex(1)

					var_12_2.name = var_12_0
					var_12_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_[var_12_0] = var_12_2

					local var_12_3 = var_12_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs(var_12_3) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_4 = arg_9_1.actors_["1086"]
			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 and not isNil(var_12_4) and arg_9_1.var_.actorSpriteComps1086 == nil then
				arg_9_1.var_.actorSpriteComps1086 = var_12_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_6 = 0.2

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_6 and not isNil(var_12_4) then
				local var_12_7 = (arg_9_1.time_ - var_12_5) / var_12_6

				if arg_9_1.var_.actorSpriteComps1086 then
					for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_12_3 then
							if arg_9_1.isInRecall_ then
								local var_12_8 = Mathf.Lerp(iter_12_3.color.r, arg_9_1.hightColor1.r, var_12_7)
								local var_12_9 = Mathf.Lerp(iter_12_3.color.g, arg_9_1.hightColor1.g, var_12_7)
								local var_12_10 = Mathf.Lerp(iter_12_3.color.b, arg_9_1.hightColor1.b, var_12_7)

								iter_12_3.color = Color.New(var_12_8, var_12_9, var_12_10)
							else
								local var_12_11 = Mathf.Lerp(iter_12_3.color.r, 1, var_12_7)

								iter_12_3.color = Color.New(var_12_11, var_12_11, var_12_11)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_5 + var_12_6 and arg_9_1.time_ < var_12_5 + var_12_6 + arg_12_0 and not isNil(var_12_4) and arg_9_1.var_.actorSpriteComps1086 then
				for iter_12_4, iter_12_5 in pairs(arg_9_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_12_5 then
						if arg_9_1.isInRecall_ then
							iter_12_5.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps1086 = nil
			end

			local var_12_12 = arg_9_1.actors_["1086"].transform
			local var_12_13 = 0

			if var_12_13 < arg_9_1.time_ and arg_9_1.time_ <= var_12_13 + arg_12_0 then
				arg_9_1.var_.moveOldPos1086 = var_12_12.localPosition
				var_12_12.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1086", 3)

				local var_12_14 = var_12_12.childCount

				for iter_12_6 = 0, var_12_14 - 1 do
					local var_12_15 = var_12_12:GetChild(iter_12_6)

					if var_12_15.name == "" or not string.find(var_12_15.name, "split") then
						var_12_15.gameObject:SetActive(true)
					else
						var_12_15.gameObject:SetActive(false)
					end
				end
			end

			local var_12_16 = 0.001

			if var_12_13 <= arg_9_1.time_ and arg_9_1.time_ < var_12_13 + var_12_16 then
				local var_12_17 = (arg_9_1.time_ - var_12_13) / var_12_16
				local var_12_18 = Vector3.New(0, -404.2, -237.9)

				var_12_12.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1086, var_12_18, var_12_17)
			end

			if arg_9_1.time_ >= var_12_13 + var_12_16 and arg_9_1.time_ < var_12_13 + var_12_16 + arg_12_0 then
				var_12_12.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_12_19 = 0
			local var_12_20 = 0.7

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_21 = arg_9_1:FormatText(StoryNameCfg[1080].name)

				arg_9_1.leftNameTxt_.text = var_12_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_22 = arg_9_1:GetWordFromCfg(425032002)
				local var_12_23 = arg_9_1:FormatText(var_12_22.content)

				arg_9_1.text_.text = var_12_23

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_24 = 28
				local var_12_25 = utf8.len(var_12_23)
				local var_12_26 = var_12_24 <= 0 and var_12_20 or var_12_20 * (var_12_25 / var_12_24)

				if var_12_26 > 0 and var_12_20 < var_12_26 then
					arg_9_1.talkMaxDuration = var_12_26

					if var_12_26 + var_12_19 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_26 + var_12_19
					end
				end

				arg_9_1.text_.text = var_12_23
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032002", "story_v_out_425032.awb") ~= 0 then
					local var_12_27 = manager.audio:GetVoiceLength("story_v_out_425032", "425032002", "story_v_out_425032.awb") / 1000

					if var_12_27 + var_12_19 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_27 + var_12_19
					end

					if var_12_22.prefab_name ~= "" and arg_9_1.actors_[var_12_22.prefab_name] ~= nil then
						local var_12_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_22.prefab_name].transform, "story_v_out_425032", "425032002", "story_v_out_425032.awb")

						arg_9_1:RecordAudio("425032002", var_12_28)
						arg_9_1:RecordAudio("425032002", var_12_28)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_425032", "425032002", "story_v_out_425032.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_425032", "425032002", "story_v_out_425032.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_29 = math.max(var_12_20, arg_9_1.talkMaxDuration)

			if var_12_19 <= arg_9_1.time_ and arg_9_1.time_ < var_12_19 + var_12_29 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_19) / var_12_29

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_19 + var_12_29 and arg_9_1.time_ < var_12_19 + var_12_29 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play425032003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 425032003
		arg_13_1.duration_ = 4.37

		local var_13_0 = {
			zh = 3.3,
			ja = 4.366
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
				arg_13_0:Play425032004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1086"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps1086 == nil then
				arg_13_1.var_.actorSpriteComps1086 = var_16_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_2 = 0.2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.actorSpriteComps1086 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_16_1 then
							if arg_13_1.isInRecall_ then
								local var_16_4 = Mathf.Lerp(iter_16_1.color.r, arg_13_1.hightColor2.r, var_16_3)
								local var_16_5 = Mathf.Lerp(iter_16_1.color.g, arg_13_1.hightColor2.g, var_16_3)
								local var_16_6 = Mathf.Lerp(iter_16_1.color.b, arg_13_1.hightColor2.b, var_16_3)

								iter_16_1.color = Color.New(var_16_4, var_16_5, var_16_6)
							else
								local var_16_7 = Mathf.Lerp(iter_16_1.color.r, 0.5, var_16_3)

								iter_16_1.color = Color.New(var_16_7, var_16_7, var_16_7)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps1086 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_16_3 then
						if arg_13_1.isInRecall_ then
							iter_16_3.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1086 = nil
			end

			local var_16_8 = 0
			local var_16_9 = 0.4

			if var_16_8 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_10 = arg_13_1:FormatText(StoryNameCfg[36].name)

				arg_13_1.leftNameTxt_.text = var_16_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowstudentwa")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_11 = arg_13_1:GetWordFromCfg(425032003)
				local var_16_12 = arg_13_1:FormatText(var_16_11.content)

				arg_13_1.text_.text = var_16_12

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 16
				local var_16_14 = utf8.len(var_16_12)
				local var_16_15 = var_16_13 <= 0 and var_16_9 or var_16_9 * (var_16_14 / var_16_13)

				if var_16_15 > 0 and var_16_9 < var_16_15 then
					arg_13_1.talkMaxDuration = var_16_15

					if var_16_15 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_12
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032003", "story_v_out_425032.awb") ~= 0 then
					local var_16_16 = manager.audio:GetVoiceLength("story_v_out_425032", "425032003", "story_v_out_425032.awb") / 1000

					if var_16_16 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_8
					end

					if var_16_11.prefab_name ~= "" and arg_13_1.actors_[var_16_11.prefab_name] ~= nil then
						local var_16_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_11.prefab_name].transform, "story_v_out_425032", "425032003", "story_v_out_425032.awb")

						arg_13_1:RecordAudio("425032003", var_16_17)
						arg_13_1:RecordAudio("425032003", var_16_17)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_425032", "425032003", "story_v_out_425032.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_425032", "425032003", "story_v_out_425032.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_18 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_18 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_18

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_18 and arg_13_1.time_ < var_16_8 + var_16_18 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play425032004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 425032004
		arg_17_1.duration_ = 5.83

		local var_17_0 = {
			zh = 5.366,
			ja = 5.833
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
				arg_17_0:Play425032005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1086"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps1086 == nil then
				arg_17_1.var_.actorSpriteComps1086 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps1086 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								local var_20_4 = Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor1.r, var_20_3)
								local var_20_5 = Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor1.g, var_20_3)
								local var_20_6 = Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor1.b, var_20_3)

								iter_20_1.color = Color.New(var_20_4, var_20_5, var_20_6)
							else
								local var_20_7 = Mathf.Lerp(iter_20_1.color.r, 1, var_20_3)

								iter_20_1.color = Color.New(var_20_7, var_20_7, var_20_7)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps1086 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1086 = nil
			end

			local var_20_8 = arg_17_1.actors_["1086"].transform
			local var_20_9 = 0

			if var_20_9 < arg_17_1.time_ and arg_17_1.time_ <= var_20_9 + arg_20_0 then
				arg_17_1.var_.moveOldPos1086 = var_20_8.localPosition
				var_20_8.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1086", 3)

				local var_20_10 = var_20_8.childCount

				for iter_20_4 = 0, var_20_10 - 1 do
					local var_20_11 = var_20_8:GetChild(iter_20_4)

					if var_20_11.name == "split_4" or not string.find(var_20_11.name, "split") then
						var_20_11.gameObject:SetActive(true)
					else
						var_20_11.gameObject:SetActive(false)
					end
				end
			end

			local var_20_12 = 0.001

			if var_20_9 <= arg_17_1.time_ and arg_17_1.time_ < var_20_9 + var_20_12 then
				local var_20_13 = (arg_17_1.time_ - var_20_9) / var_20_12
				local var_20_14 = Vector3.New(0, -404.2, -237.9)

				var_20_8.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1086, var_20_14, var_20_13)
			end

			if arg_17_1.time_ >= var_20_9 + var_20_12 and arg_17_1.time_ < var_20_9 + var_20_12 + arg_20_0 then
				var_20_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_20_15 = 0
			local var_20_16 = 0.7

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_17 = arg_17_1:FormatText(StoryNameCfg[1080].name)

				arg_17_1.leftNameTxt_.text = var_20_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_18 = arg_17_1:GetWordFromCfg(425032004)
				local var_20_19 = arg_17_1:FormatText(var_20_18.content)

				arg_17_1.text_.text = var_20_19

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_20 = 28
				local var_20_21 = utf8.len(var_20_19)
				local var_20_22 = var_20_20 <= 0 and var_20_16 or var_20_16 * (var_20_21 / var_20_20)

				if var_20_22 > 0 and var_20_16 < var_20_22 then
					arg_17_1.talkMaxDuration = var_20_22

					if var_20_22 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_22 + var_20_15
					end
				end

				arg_17_1.text_.text = var_20_19
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032004", "story_v_out_425032.awb") ~= 0 then
					local var_20_23 = manager.audio:GetVoiceLength("story_v_out_425032", "425032004", "story_v_out_425032.awb") / 1000

					if var_20_23 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_23 + var_20_15
					end

					if var_20_18.prefab_name ~= "" and arg_17_1.actors_[var_20_18.prefab_name] ~= nil then
						local var_20_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_18.prefab_name].transform, "story_v_out_425032", "425032004", "story_v_out_425032.awb")

						arg_17_1:RecordAudio("425032004", var_20_24)
						arg_17_1:RecordAudio("425032004", var_20_24)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_425032", "425032004", "story_v_out_425032.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_425032", "425032004", "story_v_out_425032.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_25 = math.max(var_20_16, arg_17_1.talkMaxDuration)

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_25 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_15) / var_20_25

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_15 + var_20_25 and arg_17_1.time_ < var_20_15 + var_20_25 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play425032005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 425032005
		arg_21_1.duration_ = 2.07

		local var_21_0 = {
			zh = 2.066,
			ja = 1.666
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
				arg_21_0:Play425032006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "1137"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1137")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(var_24_1, arg_21_1.canvasGo_.transform)

					var_24_2.transform:SetSiblingIndex(1)

					var_24_2.name = var_24_0
					var_24_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_21_1.actors_[var_24_0] = var_24_2

					local var_24_3 = var_24_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_21_1.isInRecall_ then
						for iter_24_0, iter_24_1 in ipairs(var_24_3) do
							iter_24_1.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_24_4 = arg_21_1.actors_["1137"]
			local var_24_5 = 0

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.actorSpriteComps1137 == nil then
				arg_21_1.var_.actorSpriteComps1137 = var_24_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_6 = 0.2

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_6 and not isNil(var_24_4) then
				local var_24_7 = (arg_21_1.time_ - var_24_5) / var_24_6

				if arg_21_1.var_.actorSpriteComps1137 then
					for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_24_3 then
							if arg_21_1.isInRecall_ then
								local var_24_8 = Mathf.Lerp(iter_24_3.color.r, arg_21_1.hightColor1.r, var_24_7)
								local var_24_9 = Mathf.Lerp(iter_24_3.color.g, arg_21_1.hightColor1.g, var_24_7)
								local var_24_10 = Mathf.Lerp(iter_24_3.color.b, arg_21_1.hightColor1.b, var_24_7)

								iter_24_3.color = Color.New(var_24_8, var_24_9, var_24_10)
							else
								local var_24_11 = Mathf.Lerp(iter_24_3.color.r, 1, var_24_7)

								iter_24_3.color = Color.New(var_24_11, var_24_11, var_24_11)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_5 + var_24_6 and arg_21_1.time_ < var_24_5 + var_24_6 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.actorSpriteComps1137 then
				for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_24_5 then
						if arg_21_1.isInRecall_ then
							iter_24_5.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1137 = nil
			end

			local var_24_12 = arg_21_1.actors_["1086"]
			local var_24_13 = 0

			if var_24_13 < arg_21_1.time_ and arg_21_1.time_ <= var_24_13 + arg_24_0 and not isNil(var_24_12) and arg_21_1.var_.actorSpriteComps1086 == nil then
				arg_21_1.var_.actorSpriteComps1086 = var_24_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_14 = 0.2

			if var_24_13 <= arg_21_1.time_ and arg_21_1.time_ < var_24_13 + var_24_14 and not isNil(var_24_12) then
				local var_24_15 = (arg_21_1.time_ - var_24_13) / var_24_14

				if arg_21_1.var_.actorSpriteComps1086 then
					for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_24_7 then
							if arg_21_1.isInRecall_ then
								local var_24_16 = Mathf.Lerp(iter_24_7.color.r, arg_21_1.hightColor2.r, var_24_15)
								local var_24_17 = Mathf.Lerp(iter_24_7.color.g, arg_21_1.hightColor2.g, var_24_15)
								local var_24_18 = Mathf.Lerp(iter_24_7.color.b, arg_21_1.hightColor2.b, var_24_15)

								iter_24_7.color = Color.New(var_24_16, var_24_17, var_24_18)
							else
								local var_24_19 = Mathf.Lerp(iter_24_7.color.r, 0.5, var_24_15)

								iter_24_7.color = Color.New(var_24_19, var_24_19, var_24_19)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_13 + var_24_14 and arg_21_1.time_ < var_24_13 + var_24_14 + arg_24_0 and not isNil(var_24_12) and arg_21_1.var_.actorSpriteComps1086 then
				for iter_24_8, iter_24_9 in pairs(arg_21_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_24_9 then
						if arg_21_1.isInRecall_ then
							iter_24_9.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1086 = nil
			end

			local var_24_20 = arg_21_1.actors_["1137"].transform
			local var_24_21 = 0

			if var_24_21 < arg_21_1.time_ and arg_21_1.time_ <= var_24_21 + arg_24_0 then
				arg_21_1.var_.moveOldPos1137 = var_24_20.localPosition
				var_24_20.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1137", 3)

				local var_24_22 = var_24_20.childCount

				for iter_24_10 = 0, var_24_22 - 1 do
					local var_24_23 = var_24_20:GetChild(iter_24_10)

					if var_24_23.name == "split_4" or not string.find(var_24_23.name, "split") then
						var_24_23.gameObject:SetActive(true)
					else
						var_24_23.gameObject:SetActive(false)
					end
				end
			end

			local var_24_24 = 0.001

			if var_24_21 <= arg_21_1.time_ and arg_21_1.time_ < var_24_21 + var_24_24 then
				local var_24_25 = (arg_21_1.time_ - var_24_21) / var_24_24
				local var_24_26 = Vector3.New(0, -425, -200)

				var_24_20.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1137, var_24_26, var_24_25)
			end

			if arg_21_1.time_ >= var_24_21 + var_24_24 and arg_21_1.time_ < var_24_21 + var_24_24 + arg_24_0 then
				var_24_20.localPosition = Vector3.New(0, -425, -200)
			end

			local var_24_27 = arg_21_1.actors_["1086"].transform
			local var_24_28 = 0

			if var_24_28 < arg_21_1.time_ and arg_21_1.time_ <= var_24_28 + arg_24_0 then
				arg_21_1.var_.moveOldPos1086 = var_24_27.localPosition
				var_24_27.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1086", 7)

				local var_24_29 = var_24_27.childCount

				for iter_24_11 = 0, var_24_29 - 1 do
					local var_24_30 = var_24_27:GetChild(iter_24_11)

					if var_24_30.name == "" or not string.find(var_24_30.name, "split") then
						var_24_30.gameObject:SetActive(true)
					else
						var_24_30.gameObject:SetActive(false)
					end
				end
			end

			local var_24_31 = 0.001

			if var_24_28 <= arg_21_1.time_ and arg_21_1.time_ < var_24_28 + var_24_31 then
				local var_24_32 = (arg_21_1.time_ - var_24_28) / var_24_31
				local var_24_33 = Vector3.New(0, -2000, 0)

				var_24_27.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1086, var_24_33, var_24_32)
			end

			if arg_21_1.time_ >= var_24_28 + var_24_31 and arg_21_1.time_ < var_24_28 + var_24_31 + arg_24_0 then
				var_24_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_24_34 = 0
			local var_24_35 = 0.05

			if var_24_34 < arg_21_1.time_ and arg_21_1.time_ <= var_24_34 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_36 = arg_21_1:FormatText(StoryNameCfg[15].name)

				arg_21_1.leftNameTxt_.text = var_24_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_37 = arg_21_1:GetWordFromCfg(425032005)
				local var_24_38 = arg_21_1:FormatText(var_24_37.content)

				arg_21_1.text_.text = var_24_38

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_39 = 2
				local var_24_40 = utf8.len(var_24_38)
				local var_24_41 = var_24_39 <= 0 and var_24_35 or var_24_35 * (var_24_40 / var_24_39)

				if var_24_41 > 0 and var_24_35 < var_24_41 then
					arg_21_1.talkMaxDuration = var_24_41

					if var_24_41 + var_24_34 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_41 + var_24_34
					end
				end

				arg_21_1.text_.text = var_24_38
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032005", "story_v_out_425032.awb") ~= 0 then
					local var_24_42 = manager.audio:GetVoiceLength("story_v_out_425032", "425032005", "story_v_out_425032.awb") / 1000

					if var_24_42 + var_24_34 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_42 + var_24_34
					end

					if var_24_37.prefab_name ~= "" and arg_21_1.actors_[var_24_37.prefab_name] ~= nil then
						local var_24_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_37.prefab_name].transform, "story_v_out_425032", "425032005", "story_v_out_425032.awb")

						arg_21_1:RecordAudio("425032005", var_24_43)
						arg_21_1:RecordAudio("425032005", var_24_43)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_425032", "425032005", "story_v_out_425032.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_425032", "425032005", "story_v_out_425032.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_44 = math.max(var_24_35, arg_21_1.talkMaxDuration)

			if var_24_34 <= arg_21_1.time_ and arg_21_1.time_ < var_24_34 + var_24_44 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_34) / var_24_44

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_34 + var_24_44 and arg_21_1.time_ < var_24_34 + var_24_44 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
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

		arg_21_1:InitPlayNodeList()
	end,
	Play425032006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 425032006
		arg_25_1.duration_ = 1

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play425032007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1137"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps1137 == nil then
				arg_25_1.var_.actorSpriteComps1137 = var_28_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.actorSpriteComps1137 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_28_1 then
							if arg_25_1.isInRecall_ then
								local var_28_4 = Mathf.Lerp(iter_28_1.color.r, arg_25_1.hightColor2.r, var_28_3)
								local var_28_5 = Mathf.Lerp(iter_28_1.color.g, arg_25_1.hightColor2.g, var_28_3)
								local var_28_6 = Mathf.Lerp(iter_28_1.color.b, arg_25_1.hightColor2.b, var_28_3)

								iter_28_1.color = Color.New(var_28_4, var_28_5, var_28_6)
							else
								local var_28_7 = Mathf.Lerp(iter_28_1.color.r, 0.5, var_28_3)

								iter_28_1.color = Color.New(var_28_7, var_28_7, var_28_7)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps1137 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_28_3 then
						if arg_25_1.isInRecall_ then
							iter_28_3.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1137 = nil
			end

			local var_28_8 = 0
			local var_28_9 = 0.0329999998211861

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_10 = arg_25_1:FormatText(StoryNameCfg[55].name)

				arg_25_1.leftNameTxt_.text = var_28_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_11 = arg_25_1:GetWordFromCfg(425032006)
				local var_28_12 = arg_25_1:FormatText(var_28_11.content)

				arg_25_1.text_.text = var_28_12

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 1
				local var_28_14 = utf8.len(var_28_12)
				local var_28_15 = var_28_13 <= 0 and var_28_9 or var_28_9 * (var_28_14 / var_28_13)

				if var_28_15 > 0 and var_28_9 < var_28_15 then
					arg_25_1.talkMaxDuration = var_28_15

					if var_28_15 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_15 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_12
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032006", "story_v_out_425032.awb") ~= 0 then
					local var_28_16 = manager.audio:GetVoiceLength("story_v_out_425032", "425032006", "story_v_out_425032.awb") / 1000

					if var_28_16 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_16 + var_28_8
					end

					if var_28_11.prefab_name ~= "" and arg_25_1.actors_[var_28_11.prefab_name] ~= nil then
						local var_28_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_11.prefab_name].transform, "story_v_out_425032", "425032006", "story_v_out_425032.awb")

						arg_25_1:RecordAudio("425032006", var_28_17)
						arg_25_1:RecordAudio("425032006", var_28_17)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_425032", "425032006", "story_v_out_425032.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_425032", "425032006", "story_v_out_425032.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_18 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_18 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_8) / var_28_18

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_8 + var_28_18 and arg_25_1.time_ < var_28_8 + var_28_18 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play425032007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 425032007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play425032008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "1080"

			if arg_29_1.actors_[var_32_0] == nil then
				local var_32_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1080")

				if not isNil(var_32_1) then
					local var_32_2 = Object.Instantiate(var_32_1, arg_29_1.canvasGo_.transform)

					var_32_2.transform:SetSiblingIndex(1)

					var_32_2.name = var_32_0
					var_32_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_29_1.actors_[var_32_0] = var_32_2

					local var_32_3 = var_32_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_29_1.isInRecall_ then
						for iter_32_0, iter_32_1 in ipairs(var_32_3) do
							iter_32_1.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_32_4 = arg_29_1.actors_["1080"].transform
			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.var_.moveOldPos1080 = var_32_4.localPosition
				var_32_4.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1080", 7)

				local var_32_6 = var_32_4.childCount

				for iter_32_2 = 0, var_32_6 - 1 do
					local var_32_7 = var_32_4:GetChild(iter_32_2)

					if var_32_7.name == "" or not string.find(var_32_7.name, "split") then
						var_32_7.gameObject:SetActive(true)
					else
						var_32_7.gameObject:SetActive(false)
					end
				end
			end

			local var_32_8 = 0.001

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_8 then
				local var_32_9 = (arg_29_1.time_ - var_32_5) / var_32_8
				local var_32_10 = Vector3.New(0, -2000, 0)

				var_32_4.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1080, var_32_10, var_32_9)
			end

			if arg_29_1.time_ >= var_32_5 + var_32_8 and arg_29_1.time_ < var_32_5 + var_32_8 + arg_32_0 then
				var_32_4.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_11 = arg_29_1.actors_["1137"].transform
			local var_32_12 = 0

			if var_32_12 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.var_.moveOldPos1137 = var_32_11.localPosition
				var_32_11.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1137", 7)

				local var_32_13 = var_32_11.childCount

				for iter_32_3 = 0, var_32_13 - 1 do
					local var_32_14 = var_32_11:GetChild(iter_32_3)

					if var_32_14.name == "" or not string.find(var_32_14.name, "split") then
						var_32_14.gameObject:SetActive(true)
					else
						var_32_14.gameObject:SetActive(false)
					end
				end
			end

			local var_32_15 = 0.001

			if var_32_12 <= arg_29_1.time_ and arg_29_1.time_ < var_32_12 + var_32_15 then
				local var_32_16 = (arg_29_1.time_ - var_32_12) / var_32_15
				local var_32_17 = Vector3.New(0, -2000, 0)

				var_32_11.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1137, var_32_17, var_32_16)
			end

			if arg_29_1.time_ >= var_32_12 + var_32_15 and arg_29_1.time_ < var_32_12 + var_32_15 + arg_32_0 then
				var_32_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_18 = 0
			local var_32_19 = 1.575

			if var_32_18 < arg_29_1.time_ and arg_29_1.time_ <= var_32_18 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_20 = arg_29_1:GetWordFromCfg(425032007)
				local var_32_21 = arg_29_1:FormatText(var_32_20.content)

				arg_29_1.text_.text = var_32_21

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_22 = 63
				local var_32_23 = utf8.len(var_32_21)
				local var_32_24 = var_32_22 <= 0 and var_32_19 or var_32_19 * (var_32_23 / var_32_22)

				if var_32_24 > 0 and var_32_19 < var_32_24 then
					arg_29_1.talkMaxDuration = var_32_24

					if var_32_24 + var_32_18 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_24 + var_32_18
					end
				end

				arg_29_1.text_.text = var_32_21
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_25 = math.max(var_32_19, arg_29_1.talkMaxDuration)

			if var_32_18 <= arg_29_1.time_ and arg_29_1.time_ < var_32_18 + var_32_25 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_18) / var_32_25

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_18 + var_32_25 and arg_29_1.time_ < var_32_18 + var_32_25 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play425032008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 425032008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play425032009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.85

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

				local var_36_2 = arg_33_1:GetWordFromCfg(425032008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 34
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
	Play425032009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 425032009
		arg_37_1.duration_ = 11.7

		local var_37_0 = {
			zh = 2.666,
			ja = 11.7
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
				arg_37_0:Play425032010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1137"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps1137 == nil then
				arg_37_1.var_.actorSpriteComps1137 = var_40_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_2 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.actorSpriteComps1137 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_40_1 then
							if arg_37_1.isInRecall_ then
								local var_40_4 = Mathf.Lerp(iter_40_1.color.r, arg_37_1.hightColor1.r, var_40_3)
								local var_40_5 = Mathf.Lerp(iter_40_1.color.g, arg_37_1.hightColor1.g, var_40_3)
								local var_40_6 = Mathf.Lerp(iter_40_1.color.b, arg_37_1.hightColor1.b, var_40_3)

								iter_40_1.color = Color.New(var_40_4, var_40_5, var_40_6)
							else
								local var_40_7 = Mathf.Lerp(iter_40_1.color.r, 1, var_40_3)

								iter_40_1.color = Color.New(var_40_7, var_40_7, var_40_7)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps1137 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_40_3 then
						if arg_37_1.isInRecall_ then
							iter_40_3.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps1137 = nil
			end

			local var_40_8 = arg_37_1.actors_["1137"].transform
			local var_40_9 = 0

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 then
				arg_37_1.var_.moveOldPos1137 = var_40_8.localPosition
				var_40_8.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1137", 2)

				local var_40_10 = var_40_8.childCount

				for iter_40_4 = 0, var_40_10 - 1 do
					local var_40_11 = var_40_8:GetChild(iter_40_4)

					if var_40_11.name == "split_4" or not string.find(var_40_11.name, "split") then
						var_40_11.gameObject:SetActive(true)
					else
						var_40_11.gameObject:SetActive(false)
					end
				end
			end

			local var_40_12 = 0.001

			if var_40_9 <= arg_37_1.time_ and arg_37_1.time_ < var_40_9 + var_40_12 then
				local var_40_13 = (arg_37_1.time_ - var_40_9) / var_40_12
				local var_40_14 = Vector3.New(-390, -425, -200)

				var_40_8.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1137, var_40_14, var_40_13)
			end

			if arg_37_1.time_ >= var_40_9 + var_40_12 and arg_37_1.time_ < var_40_9 + var_40_12 + arg_40_0 then
				var_40_8.localPosition = Vector3.New(-390, -425, -200)
			end

			local var_40_15 = 0
			local var_40_16 = 0.2

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_17 = arg_37_1:FormatText(StoryNameCfg[15].name)

				arg_37_1.leftNameTxt_.text = var_40_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_18 = arg_37_1:GetWordFromCfg(425032009)
				local var_40_19 = arg_37_1:FormatText(var_40_18.content)

				arg_37_1.text_.text = var_40_19

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 8
				local var_40_21 = utf8.len(var_40_19)
				local var_40_22 = var_40_20 <= 0 and var_40_16 or var_40_16 * (var_40_21 / var_40_20)

				if var_40_22 > 0 and var_40_16 < var_40_22 then
					arg_37_1.talkMaxDuration = var_40_22

					if var_40_22 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_22 + var_40_15
					end
				end

				arg_37_1.text_.text = var_40_19
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032009", "story_v_out_425032.awb") ~= 0 then
					local var_40_23 = manager.audio:GetVoiceLength("story_v_out_425032", "425032009", "story_v_out_425032.awb") / 1000

					if var_40_23 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_15
					end

					if var_40_18.prefab_name ~= "" and arg_37_1.actors_[var_40_18.prefab_name] ~= nil then
						local var_40_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_18.prefab_name].transform, "story_v_out_425032", "425032009", "story_v_out_425032.awb")

						arg_37_1:RecordAudio("425032009", var_40_24)
						arg_37_1:RecordAudio("425032009", var_40_24)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_425032", "425032009", "story_v_out_425032.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_425032", "425032009", "story_v_out_425032.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_25 = math.max(var_40_16, arg_37_1.talkMaxDuration)

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_25 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_15) / var_40_25

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_15 + var_40_25 and arg_37_1.time_ < var_40_15 + var_40_25 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
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
	Play425032010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 425032010
		arg_41_1.duration_ = 6.23

		local var_41_0 = {
			zh = 2.466,
			ja = 6.233
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
				arg_41_0:Play425032011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1080"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps1080 == nil then
				arg_41_1.var_.actorSpriteComps1080 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps1080 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								local var_44_4 = Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor1.r, var_44_3)
								local var_44_5 = Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor1.g, var_44_3)
								local var_44_6 = Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor1.b, var_44_3)

								iter_44_1.color = Color.New(var_44_4, var_44_5, var_44_6)
							else
								local var_44_7 = Mathf.Lerp(iter_44_1.color.r, 1, var_44_3)

								iter_44_1.color = Color.New(var_44_7, var_44_7, var_44_7)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps1080 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1080 = nil
			end

			local var_44_8 = arg_41_1.actors_["1137"]
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps1137 == nil then
				arg_41_1.var_.actorSpriteComps1137 = var_44_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_10 = 0.2

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_10 and not isNil(var_44_8) then
				local var_44_11 = (arg_41_1.time_ - var_44_9) / var_44_10

				if arg_41_1.var_.actorSpriteComps1137 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_44_5 then
							if arg_41_1.isInRecall_ then
								local var_44_12 = Mathf.Lerp(iter_44_5.color.r, arg_41_1.hightColor2.r, var_44_11)
								local var_44_13 = Mathf.Lerp(iter_44_5.color.g, arg_41_1.hightColor2.g, var_44_11)
								local var_44_14 = Mathf.Lerp(iter_44_5.color.b, arg_41_1.hightColor2.b, var_44_11)

								iter_44_5.color = Color.New(var_44_12, var_44_13, var_44_14)
							else
								local var_44_15 = Mathf.Lerp(iter_44_5.color.r, 0.5, var_44_11)

								iter_44_5.color = Color.New(var_44_15, var_44_15, var_44_15)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_9 + var_44_10 and arg_41_1.time_ < var_44_9 + var_44_10 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps1137 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_44_7 then
						if arg_41_1.isInRecall_ then
							iter_44_7.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1137 = nil
			end

			local var_44_16 = arg_41_1.actors_["1080"].transform
			local var_44_17 = 0

			if var_44_17 < arg_41_1.time_ and arg_41_1.time_ <= var_44_17 + arg_44_0 then
				arg_41_1.var_.moveOldPos1080 = var_44_16.localPosition
				var_44_16.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1080", 4)

				local var_44_18 = var_44_16.childCount

				for iter_44_8 = 0, var_44_18 - 1 do
					local var_44_19 = var_44_16:GetChild(iter_44_8)

					if var_44_19.name == "" or not string.find(var_44_19.name, "split") then
						var_44_19.gameObject:SetActive(true)
					else
						var_44_19.gameObject:SetActive(false)
					end
				end
			end

			local var_44_20 = 0.001

			if var_44_17 <= arg_41_1.time_ and arg_41_1.time_ < var_44_17 + var_44_20 then
				local var_44_21 = (arg_41_1.time_ - var_44_17) / var_44_20
				local var_44_22 = Vector3.New(390, -378, -170)

				var_44_16.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1080, var_44_22, var_44_21)
			end

			if arg_41_1.time_ >= var_44_17 + var_44_20 and arg_41_1.time_ < var_44_17 + var_44_20 + arg_44_0 then
				var_44_16.localPosition = Vector3.New(390, -378, -170)
			end

			local var_44_23 = 0
			local var_44_24 = 0.2

			if var_44_23 < arg_41_1.time_ and arg_41_1.time_ <= var_44_23 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_25 = arg_41_1:FormatText(StoryNameCfg[55].name)

				arg_41_1.leftNameTxt_.text = var_44_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_26 = arg_41_1:GetWordFromCfg(425032010)
				local var_44_27 = arg_41_1:FormatText(var_44_26.content)

				arg_41_1.text_.text = var_44_27

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_28 = 8
				local var_44_29 = utf8.len(var_44_27)
				local var_44_30 = var_44_28 <= 0 and var_44_24 or var_44_24 * (var_44_29 / var_44_28)

				if var_44_30 > 0 and var_44_24 < var_44_30 then
					arg_41_1.talkMaxDuration = var_44_30

					if var_44_30 + var_44_23 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_30 + var_44_23
					end
				end

				arg_41_1.text_.text = var_44_27
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032010", "story_v_out_425032.awb") ~= 0 then
					local var_44_31 = manager.audio:GetVoiceLength("story_v_out_425032", "425032010", "story_v_out_425032.awb") / 1000

					if var_44_31 + var_44_23 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_31 + var_44_23
					end

					if var_44_26.prefab_name ~= "" and arg_41_1.actors_[var_44_26.prefab_name] ~= nil then
						local var_44_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_26.prefab_name].transform, "story_v_out_425032", "425032010", "story_v_out_425032.awb")

						arg_41_1:RecordAudio("425032010", var_44_32)
						arg_41_1:RecordAudio("425032010", var_44_32)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_425032", "425032010", "story_v_out_425032.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_425032", "425032010", "story_v_out_425032.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_33 = math.max(var_44_24, arg_41_1.talkMaxDuration)

			if var_44_23 <= arg_41_1.time_ and arg_41_1.time_ < var_44_23 + var_44_33 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_23) / var_44_33

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_23 + var_44_33 and arg_41_1.time_ < var_44_23 + var_44_33 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
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
	Play425032011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 425032011
		arg_45_1.duration_ = 8.47

		local var_45_0 = {
			zh = 5.733,
			ja = 8.466
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
				arg_45_0:Play425032012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1137"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps1137 == nil then
				arg_45_1.var_.actorSpriteComps1137 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps1137 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								local var_48_4 = Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor1.r, var_48_3)
								local var_48_5 = Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor1.g, var_48_3)
								local var_48_6 = Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor1.b, var_48_3)

								iter_48_1.color = Color.New(var_48_4, var_48_5, var_48_6)
							else
								local var_48_7 = Mathf.Lerp(iter_48_1.color.r, 1, var_48_3)

								iter_48_1.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps1137 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1137 = nil
			end

			local var_48_8 = arg_45_1.actors_["1080"]
			local var_48_9 = 0

			if var_48_9 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps1080 == nil then
				arg_45_1.var_.actorSpriteComps1080 = var_48_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_10 = 0.2

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_10 and not isNil(var_48_8) then
				local var_48_11 = (arg_45_1.time_ - var_48_9) / var_48_10

				if arg_45_1.var_.actorSpriteComps1080 then
					for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_48_5 then
							if arg_45_1.isInRecall_ then
								local var_48_12 = Mathf.Lerp(iter_48_5.color.r, arg_45_1.hightColor2.r, var_48_11)
								local var_48_13 = Mathf.Lerp(iter_48_5.color.g, arg_45_1.hightColor2.g, var_48_11)
								local var_48_14 = Mathf.Lerp(iter_48_5.color.b, arg_45_1.hightColor2.b, var_48_11)

								iter_48_5.color = Color.New(var_48_12, var_48_13, var_48_14)
							else
								local var_48_15 = Mathf.Lerp(iter_48_5.color.r, 0.5, var_48_11)

								iter_48_5.color = Color.New(var_48_15, var_48_15, var_48_15)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_9 + var_48_10 and arg_45_1.time_ < var_48_9 + var_48_10 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps1080 then
				for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_48_7 then
						if arg_45_1.isInRecall_ then
							iter_48_7.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1080 = nil
			end

			local var_48_16 = 0
			local var_48_17 = 0.475

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_18 = arg_45_1:FormatText(StoryNameCfg[15].name)

				arg_45_1.leftNameTxt_.text = var_48_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_19 = arg_45_1:GetWordFromCfg(425032011)
				local var_48_20 = arg_45_1:FormatText(var_48_19.content)

				arg_45_1.text_.text = var_48_20

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_21 = 19
				local var_48_22 = utf8.len(var_48_20)
				local var_48_23 = var_48_21 <= 0 and var_48_17 or var_48_17 * (var_48_22 / var_48_21)

				if var_48_23 > 0 and var_48_17 < var_48_23 then
					arg_45_1.talkMaxDuration = var_48_23

					if var_48_23 + var_48_16 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_23 + var_48_16
					end
				end

				arg_45_1.text_.text = var_48_20
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032011", "story_v_out_425032.awb") ~= 0 then
					local var_48_24 = manager.audio:GetVoiceLength("story_v_out_425032", "425032011", "story_v_out_425032.awb") / 1000

					if var_48_24 + var_48_16 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_24 + var_48_16
					end

					if var_48_19.prefab_name ~= "" and arg_45_1.actors_[var_48_19.prefab_name] ~= nil then
						local var_48_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_19.prefab_name].transform, "story_v_out_425032", "425032011", "story_v_out_425032.awb")

						arg_45_1:RecordAudio("425032011", var_48_25)
						arg_45_1:RecordAudio("425032011", var_48_25)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_425032", "425032011", "story_v_out_425032.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_425032", "425032011", "story_v_out_425032.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_26 = math.max(var_48_17, arg_45_1.talkMaxDuration)

			if var_48_16 <= arg_45_1.time_ and arg_45_1.time_ < var_48_16 + var_48_26 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_16) / var_48_26

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_16 + var_48_26 and arg_45_1.time_ < var_48_16 + var_48_26 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play425032012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 425032012
		arg_49_1.duration_ = 4.2

		local var_49_0 = {
			zh = 4.033,
			ja = 4.2
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
				arg_49_0:Play425032013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1080"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps1080 == nil then
				arg_49_1.var_.actorSpriteComps1080 = var_52_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.actorSpriteComps1080 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								local var_52_4 = Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor1.r, var_52_3)
								local var_52_5 = Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor1.g, var_52_3)
								local var_52_6 = Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor1.b, var_52_3)

								iter_52_1.color = Color.New(var_52_4, var_52_5, var_52_6)
							else
								local var_52_7 = Mathf.Lerp(iter_52_1.color.r, 1, var_52_3)

								iter_52_1.color = Color.New(var_52_7, var_52_7, var_52_7)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps1080 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_52_3 then
						if arg_49_1.isInRecall_ then
							iter_52_3.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps1080 = nil
			end

			local var_52_8 = arg_49_1.actors_["1137"]
			local var_52_9 = 0

			if var_52_9 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.actorSpriteComps1137 == nil then
				arg_49_1.var_.actorSpriteComps1137 = var_52_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_10 = 0.2

			if var_52_9 <= arg_49_1.time_ and arg_49_1.time_ < var_52_9 + var_52_10 and not isNil(var_52_8) then
				local var_52_11 = (arg_49_1.time_ - var_52_9) / var_52_10

				if arg_49_1.var_.actorSpriteComps1137 then
					for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_52_5 then
							if arg_49_1.isInRecall_ then
								local var_52_12 = Mathf.Lerp(iter_52_5.color.r, arg_49_1.hightColor2.r, var_52_11)
								local var_52_13 = Mathf.Lerp(iter_52_5.color.g, arg_49_1.hightColor2.g, var_52_11)
								local var_52_14 = Mathf.Lerp(iter_52_5.color.b, arg_49_1.hightColor2.b, var_52_11)

								iter_52_5.color = Color.New(var_52_12, var_52_13, var_52_14)
							else
								local var_52_15 = Mathf.Lerp(iter_52_5.color.r, 0.5, var_52_11)

								iter_52_5.color = Color.New(var_52_15, var_52_15, var_52_15)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_9 + var_52_10 and arg_49_1.time_ < var_52_9 + var_52_10 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.actorSpriteComps1137 then
				for iter_52_6, iter_52_7 in pairs(arg_49_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_52_7 then
						if arg_49_1.isInRecall_ then
							iter_52_7.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps1137 = nil
			end

			local var_52_16 = arg_49_1.actors_["1080"].transform
			local var_52_17 = 0

			if var_52_17 < arg_49_1.time_ and arg_49_1.time_ <= var_52_17 + arg_52_0 then
				arg_49_1.var_.moveOldPos1080 = var_52_16.localPosition
				var_52_16.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1080", 4)

				local var_52_18 = var_52_16.childCount

				for iter_52_8 = 0, var_52_18 - 1 do
					local var_52_19 = var_52_16:GetChild(iter_52_8)

					if var_52_19.name == "" or not string.find(var_52_19.name, "split") then
						var_52_19.gameObject:SetActive(true)
					else
						var_52_19.gameObject:SetActive(false)
					end
				end
			end

			local var_52_20 = 0.001

			if var_52_17 <= arg_49_1.time_ and arg_49_1.time_ < var_52_17 + var_52_20 then
				local var_52_21 = (arg_49_1.time_ - var_52_17) / var_52_20
				local var_52_22 = Vector3.New(390, -378, -170)

				var_52_16.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1080, var_52_22, var_52_21)
			end

			if arg_49_1.time_ >= var_52_17 + var_52_20 and arg_49_1.time_ < var_52_17 + var_52_20 + arg_52_0 then
				var_52_16.localPosition = Vector3.New(390, -378, -170)
			end

			local var_52_23 = 0
			local var_52_24 = 0.35

			if var_52_23 < arg_49_1.time_ and arg_49_1.time_ <= var_52_23 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_25 = arg_49_1:FormatText(StoryNameCfg[55].name)

				arg_49_1.leftNameTxt_.text = var_52_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_26 = arg_49_1:GetWordFromCfg(425032012)
				local var_52_27 = arg_49_1:FormatText(var_52_26.content)

				arg_49_1.text_.text = var_52_27

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_28 = 14
				local var_52_29 = utf8.len(var_52_27)
				local var_52_30 = var_52_28 <= 0 and var_52_24 or var_52_24 * (var_52_29 / var_52_28)

				if var_52_30 > 0 and var_52_24 < var_52_30 then
					arg_49_1.talkMaxDuration = var_52_30

					if var_52_30 + var_52_23 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_30 + var_52_23
					end
				end

				arg_49_1.text_.text = var_52_27
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032012", "story_v_out_425032.awb") ~= 0 then
					local var_52_31 = manager.audio:GetVoiceLength("story_v_out_425032", "425032012", "story_v_out_425032.awb") / 1000

					if var_52_31 + var_52_23 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_31 + var_52_23
					end

					if var_52_26.prefab_name ~= "" and arg_49_1.actors_[var_52_26.prefab_name] ~= nil then
						local var_52_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_26.prefab_name].transform, "story_v_out_425032", "425032012", "story_v_out_425032.awb")

						arg_49_1:RecordAudio("425032012", var_52_32)
						arg_49_1:RecordAudio("425032012", var_52_32)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_425032", "425032012", "story_v_out_425032.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_425032", "425032012", "story_v_out_425032.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_33 = math.max(var_52_24, arg_49_1.talkMaxDuration)

			if var_52_23 <= arg_49_1.time_ and arg_49_1.time_ < var_52_23 + var_52_33 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_23) / var_52_33

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_23 + var_52_33 and arg_49_1.time_ < var_52_23 + var_52_33 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play425032013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 425032013
		arg_53_1.duration_ = 11.27

		local var_53_0 = {
			zh = 7.033,
			ja = 11.266
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play425032014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1137"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps1137 == nil then
				arg_53_1.var_.actorSpriteComps1137 = var_56_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_2 = 0.2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.actorSpriteComps1137 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								local var_56_4 = Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor1.r, var_56_3)
								local var_56_5 = Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor1.g, var_56_3)
								local var_56_6 = Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor1.b, var_56_3)

								iter_56_1.color = Color.New(var_56_4, var_56_5, var_56_6)
							else
								local var_56_7 = Mathf.Lerp(iter_56_1.color.r, 1, var_56_3)

								iter_56_1.color = Color.New(var_56_7, var_56_7, var_56_7)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps1137 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_56_3 then
						if arg_53_1.isInRecall_ then
							iter_56_3.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1137 = nil
			end

			local var_56_8 = arg_53_1.actors_["1080"]
			local var_56_9 = 0

			if var_56_9 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.actorSpriteComps1080 == nil then
				arg_53_1.var_.actorSpriteComps1080 = var_56_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_10 = 0.2

			if var_56_9 <= arg_53_1.time_ and arg_53_1.time_ < var_56_9 + var_56_10 and not isNil(var_56_8) then
				local var_56_11 = (arg_53_1.time_ - var_56_9) / var_56_10

				if arg_53_1.var_.actorSpriteComps1080 then
					for iter_56_4, iter_56_5 in pairs(arg_53_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_56_5 then
							if arg_53_1.isInRecall_ then
								local var_56_12 = Mathf.Lerp(iter_56_5.color.r, arg_53_1.hightColor2.r, var_56_11)
								local var_56_13 = Mathf.Lerp(iter_56_5.color.g, arg_53_1.hightColor2.g, var_56_11)
								local var_56_14 = Mathf.Lerp(iter_56_5.color.b, arg_53_1.hightColor2.b, var_56_11)

								iter_56_5.color = Color.New(var_56_12, var_56_13, var_56_14)
							else
								local var_56_15 = Mathf.Lerp(iter_56_5.color.r, 0.5, var_56_11)

								iter_56_5.color = Color.New(var_56_15, var_56_15, var_56_15)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_9 + var_56_10 and arg_53_1.time_ < var_56_9 + var_56_10 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.actorSpriteComps1080 then
				for iter_56_6, iter_56_7 in pairs(arg_53_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_56_7 then
						if arg_53_1.isInRecall_ then
							iter_56_7.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1080 = nil
			end

			local var_56_16 = 0
			local var_56_17 = 0.65

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_18 = arg_53_1:FormatText(StoryNameCfg[15].name)

				arg_53_1.leftNameTxt_.text = var_56_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_19 = arg_53_1:GetWordFromCfg(425032013)
				local var_56_20 = arg_53_1:FormatText(var_56_19.content)

				arg_53_1.text_.text = var_56_20

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_21 = 26
				local var_56_22 = utf8.len(var_56_20)
				local var_56_23 = var_56_21 <= 0 and var_56_17 or var_56_17 * (var_56_22 / var_56_21)

				if var_56_23 > 0 and var_56_17 < var_56_23 then
					arg_53_1.talkMaxDuration = var_56_23

					if var_56_23 + var_56_16 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_23 + var_56_16
					end
				end

				arg_53_1.text_.text = var_56_20
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032013", "story_v_out_425032.awb") ~= 0 then
					local var_56_24 = manager.audio:GetVoiceLength("story_v_out_425032", "425032013", "story_v_out_425032.awb") / 1000

					if var_56_24 + var_56_16 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_24 + var_56_16
					end

					if var_56_19.prefab_name ~= "" and arg_53_1.actors_[var_56_19.prefab_name] ~= nil then
						local var_56_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_19.prefab_name].transform, "story_v_out_425032", "425032013", "story_v_out_425032.awb")

						arg_53_1:RecordAudio("425032013", var_56_25)
						arg_53_1:RecordAudio("425032013", var_56_25)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_425032", "425032013", "story_v_out_425032.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_425032", "425032013", "story_v_out_425032.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_26 = math.max(var_56_17, arg_53_1.talkMaxDuration)

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_26 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_16) / var_56_26

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_16 + var_56_26 and arg_53_1.time_ < var_56_16 + var_56_26 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play425032014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 425032014
		arg_57_1.duration_ = 4.87

		local var_57_0 = {
			zh = 4.5,
			ja = 4.866
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play425032015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1080"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps1080 == nil then
				arg_57_1.var_.actorSpriteComps1080 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 0.2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps1080 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								local var_60_4 = Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor1.r, var_60_3)
								local var_60_5 = Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor1.g, var_60_3)
								local var_60_6 = Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor1.b, var_60_3)

								iter_60_1.color = Color.New(var_60_4, var_60_5, var_60_6)
							else
								local var_60_7 = Mathf.Lerp(iter_60_1.color.r, 1, var_60_3)

								iter_60_1.color = Color.New(var_60_7, var_60_7, var_60_7)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps1080 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1080 = nil
			end

			local var_60_8 = arg_57_1.actors_["1137"]
			local var_60_9 = 0

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps1137 == nil then
				arg_57_1.var_.actorSpriteComps1137 = var_60_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_10 = 0.2

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_10 and not isNil(var_60_8) then
				local var_60_11 = (arg_57_1.time_ - var_60_9) / var_60_10

				if arg_57_1.var_.actorSpriteComps1137 then
					for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_60_5 then
							if arg_57_1.isInRecall_ then
								local var_60_12 = Mathf.Lerp(iter_60_5.color.r, arg_57_1.hightColor2.r, var_60_11)
								local var_60_13 = Mathf.Lerp(iter_60_5.color.g, arg_57_1.hightColor2.g, var_60_11)
								local var_60_14 = Mathf.Lerp(iter_60_5.color.b, arg_57_1.hightColor2.b, var_60_11)

								iter_60_5.color = Color.New(var_60_12, var_60_13, var_60_14)
							else
								local var_60_15 = Mathf.Lerp(iter_60_5.color.r, 0.5, var_60_11)

								iter_60_5.color = Color.New(var_60_15, var_60_15, var_60_15)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_9 + var_60_10 and arg_57_1.time_ < var_60_9 + var_60_10 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps1137 then
				for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_60_7 then
						if arg_57_1.isInRecall_ then
							iter_60_7.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1137 = nil
			end

			local var_60_16 = arg_57_1.actors_["1080"].transform
			local var_60_17 = 0

			if var_60_17 < arg_57_1.time_ and arg_57_1.time_ <= var_60_17 + arg_60_0 then
				arg_57_1.var_.moveOldPos1080 = var_60_16.localPosition
				var_60_16.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1080", 4)

				local var_60_18 = var_60_16.childCount

				for iter_60_8 = 0, var_60_18 - 1 do
					local var_60_19 = var_60_16:GetChild(iter_60_8)

					if var_60_19.name == "" or not string.find(var_60_19.name, "split") then
						var_60_19.gameObject:SetActive(true)
					else
						var_60_19.gameObject:SetActive(false)
					end
				end
			end

			local var_60_20 = 0.001

			if var_60_17 <= arg_57_1.time_ and arg_57_1.time_ < var_60_17 + var_60_20 then
				local var_60_21 = (arg_57_1.time_ - var_60_17) / var_60_20
				local var_60_22 = Vector3.New(390, -378, -170)

				var_60_16.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1080, var_60_22, var_60_21)
			end

			if arg_57_1.time_ >= var_60_17 + var_60_20 and arg_57_1.time_ < var_60_17 + var_60_20 + arg_60_0 then
				var_60_16.localPosition = Vector3.New(390, -378, -170)
			end

			local var_60_23 = 0
			local var_60_24 = 0.55

			if var_60_23 < arg_57_1.time_ and arg_57_1.time_ <= var_60_23 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_25 = arg_57_1:FormatText(StoryNameCfg[55].name)

				arg_57_1.leftNameTxt_.text = var_60_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_26 = arg_57_1:GetWordFromCfg(425032014)
				local var_60_27 = arg_57_1:FormatText(var_60_26.content)

				arg_57_1.text_.text = var_60_27

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_28 = 22
				local var_60_29 = utf8.len(var_60_27)
				local var_60_30 = var_60_28 <= 0 and var_60_24 or var_60_24 * (var_60_29 / var_60_28)

				if var_60_30 > 0 and var_60_24 < var_60_30 then
					arg_57_1.talkMaxDuration = var_60_30

					if var_60_30 + var_60_23 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_30 + var_60_23
					end
				end

				arg_57_1.text_.text = var_60_27
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032014", "story_v_out_425032.awb") ~= 0 then
					local var_60_31 = manager.audio:GetVoiceLength("story_v_out_425032", "425032014", "story_v_out_425032.awb") / 1000

					if var_60_31 + var_60_23 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_31 + var_60_23
					end

					if var_60_26.prefab_name ~= "" and arg_57_1.actors_[var_60_26.prefab_name] ~= nil then
						local var_60_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_26.prefab_name].transform, "story_v_out_425032", "425032014", "story_v_out_425032.awb")

						arg_57_1:RecordAudio("425032014", var_60_32)
						arg_57_1:RecordAudio("425032014", var_60_32)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_425032", "425032014", "story_v_out_425032.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_425032", "425032014", "story_v_out_425032.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_33 = math.max(var_60_24, arg_57_1.talkMaxDuration)

			if var_60_23 <= arg_57_1.time_ and arg_57_1.time_ < var_60_23 + var_60_33 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_23) / var_60_33

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_23 + var_60_33 and arg_57_1.time_ < var_60_23 + var_60_33 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play425032015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 425032015
		arg_61_1.duration_ = 11.2

		local var_61_0 = {
			zh = 6.9,
			ja = 11.2
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
				arg_61_0:Play425032016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1137"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps1137 == nil then
				arg_61_1.var_.actorSpriteComps1137 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps1137 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								local var_64_4 = Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor1.r, var_64_3)
								local var_64_5 = Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor1.g, var_64_3)
								local var_64_6 = Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor1.b, var_64_3)

								iter_64_1.color = Color.New(var_64_4, var_64_5, var_64_6)
							else
								local var_64_7 = Mathf.Lerp(iter_64_1.color.r, 1, var_64_3)

								iter_64_1.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps1137 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1137 = nil
			end

			local var_64_8 = arg_61_1.actors_["1080"]
			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps1080 == nil then
				arg_61_1.var_.actorSpriteComps1080 = var_64_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_10 = 0.2

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_10 and not isNil(var_64_8) then
				local var_64_11 = (arg_61_1.time_ - var_64_9) / var_64_10

				if arg_61_1.var_.actorSpriteComps1080 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_64_5 then
							if arg_61_1.isInRecall_ then
								local var_64_12 = Mathf.Lerp(iter_64_5.color.r, arg_61_1.hightColor2.r, var_64_11)
								local var_64_13 = Mathf.Lerp(iter_64_5.color.g, arg_61_1.hightColor2.g, var_64_11)
								local var_64_14 = Mathf.Lerp(iter_64_5.color.b, arg_61_1.hightColor2.b, var_64_11)

								iter_64_5.color = Color.New(var_64_12, var_64_13, var_64_14)
							else
								local var_64_15 = Mathf.Lerp(iter_64_5.color.r, 0.5, var_64_11)

								iter_64_5.color = Color.New(var_64_15, var_64_15, var_64_15)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_9 + var_64_10 and arg_61_1.time_ < var_64_9 + var_64_10 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps1080 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_64_7 then
						if arg_61_1.isInRecall_ then
							iter_64_7.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1080 = nil
			end

			local var_64_16 = 0
			local var_64_17 = 0.725

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_18 = arg_61_1:FormatText(StoryNameCfg[15].name)

				arg_61_1.leftNameTxt_.text = var_64_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_19 = arg_61_1:GetWordFromCfg(425032015)
				local var_64_20 = arg_61_1:FormatText(var_64_19.content)

				arg_61_1.text_.text = var_64_20

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_21 = 29
				local var_64_22 = utf8.len(var_64_20)
				local var_64_23 = var_64_21 <= 0 and var_64_17 or var_64_17 * (var_64_22 / var_64_21)

				if var_64_23 > 0 and var_64_17 < var_64_23 then
					arg_61_1.talkMaxDuration = var_64_23

					if var_64_23 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_23 + var_64_16
					end
				end

				arg_61_1.text_.text = var_64_20
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032015", "story_v_out_425032.awb") ~= 0 then
					local var_64_24 = manager.audio:GetVoiceLength("story_v_out_425032", "425032015", "story_v_out_425032.awb") / 1000

					if var_64_24 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_24 + var_64_16
					end

					if var_64_19.prefab_name ~= "" and arg_61_1.actors_[var_64_19.prefab_name] ~= nil then
						local var_64_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_19.prefab_name].transform, "story_v_out_425032", "425032015", "story_v_out_425032.awb")

						arg_61_1:RecordAudio("425032015", var_64_25)
						arg_61_1:RecordAudio("425032015", var_64_25)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_425032", "425032015", "story_v_out_425032.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_425032", "425032015", "story_v_out_425032.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_26 = math.max(var_64_17, arg_61_1.talkMaxDuration)

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_26 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_16) / var_64_26

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_16 + var_64_26 and arg_61_1.time_ < var_64_16 + var_64_26 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play425032016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 425032016
		arg_65_1.duration_ = 5.13

		local var_65_0 = {
			zh = 2.4,
			ja = 5.133
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play425032017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1080"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1080 == nil then
				arg_65_1.var_.actorSpriteComps1080 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps1080 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								local var_68_4 = Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor1.r, var_68_3)
								local var_68_5 = Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor1.g, var_68_3)
								local var_68_6 = Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor1.b, var_68_3)

								iter_68_1.color = Color.New(var_68_4, var_68_5, var_68_6)
							else
								local var_68_7 = Mathf.Lerp(iter_68_1.color.r, 1, var_68_3)

								iter_68_1.color = Color.New(var_68_7, var_68_7, var_68_7)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1080 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1080 = nil
			end

			local var_68_8 = arg_65_1.actors_["1137"]
			local var_68_9 = 0

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps1137 == nil then
				arg_65_1.var_.actorSpriteComps1137 = var_68_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_10 = 0.2

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_10 and not isNil(var_68_8) then
				local var_68_11 = (arg_65_1.time_ - var_68_9) / var_68_10

				if arg_65_1.var_.actorSpriteComps1137 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_68_5 then
							if arg_65_1.isInRecall_ then
								local var_68_12 = Mathf.Lerp(iter_68_5.color.r, arg_65_1.hightColor2.r, var_68_11)
								local var_68_13 = Mathf.Lerp(iter_68_5.color.g, arg_65_1.hightColor2.g, var_68_11)
								local var_68_14 = Mathf.Lerp(iter_68_5.color.b, arg_65_1.hightColor2.b, var_68_11)

								iter_68_5.color = Color.New(var_68_12, var_68_13, var_68_14)
							else
								local var_68_15 = Mathf.Lerp(iter_68_5.color.r, 0.5, var_68_11)

								iter_68_5.color = Color.New(var_68_15, var_68_15, var_68_15)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_9 + var_68_10 and arg_65_1.time_ < var_68_9 + var_68_10 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps1137 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_68_7 then
						if arg_65_1.isInRecall_ then
							iter_68_7.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1137 = nil
			end

			local var_68_16 = arg_65_1.actors_["1080"].transform
			local var_68_17 = 0

			if var_68_17 < arg_65_1.time_ and arg_65_1.time_ <= var_68_17 + arg_68_0 then
				arg_65_1.var_.moveOldPos1080 = var_68_16.localPosition
				var_68_16.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("1080", 4)

				local var_68_18 = var_68_16.childCount

				for iter_68_8 = 0, var_68_18 - 1 do
					local var_68_19 = var_68_16:GetChild(iter_68_8)

					if var_68_19.name == "" or not string.find(var_68_19.name, "split") then
						var_68_19.gameObject:SetActive(true)
					else
						var_68_19.gameObject:SetActive(false)
					end
				end
			end

			local var_68_20 = 0.001

			if var_68_17 <= arg_65_1.time_ and arg_65_1.time_ < var_68_17 + var_68_20 then
				local var_68_21 = (arg_65_1.time_ - var_68_17) / var_68_20
				local var_68_22 = Vector3.New(390, -378, -170)

				var_68_16.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1080, var_68_22, var_68_21)
			end

			if arg_65_1.time_ >= var_68_17 + var_68_20 and arg_65_1.time_ < var_68_17 + var_68_20 + arg_68_0 then
				var_68_16.localPosition = Vector3.New(390, -378, -170)
			end

			local var_68_23 = 0
			local var_68_24 = 0.25

			if var_68_23 < arg_65_1.time_ and arg_65_1.time_ <= var_68_23 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_25 = arg_65_1:FormatText(StoryNameCfg[55].name)

				arg_65_1.leftNameTxt_.text = var_68_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_26 = arg_65_1:GetWordFromCfg(425032016)
				local var_68_27 = arg_65_1:FormatText(var_68_26.content)

				arg_65_1.text_.text = var_68_27

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_28 = 10
				local var_68_29 = utf8.len(var_68_27)
				local var_68_30 = var_68_28 <= 0 and var_68_24 or var_68_24 * (var_68_29 / var_68_28)

				if var_68_30 > 0 and var_68_24 < var_68_30 then
					arg_65_1.talkMaxDuration = var_68_30

					if var_68_30 + var_68_23 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_30 + var_68_23
					end
				end

				arg_65_1.text_.text = var_68_27
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032016", "story_v_out_425032.awb") ~= 0 then
					local var_68_31 = manager.audio:GetVoiceLength("story_v_out_425032", "425032016", "story_v_out_425032.awb") / 1000

					if var_68_31 + var_68_23 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_31 + var_68_23
					end

					if var_68_26.prefab_name ~= "" and arg_65_1.actors_[var_68_26.prefab_name] ~= nil then
						local var_68_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_26.prefab_name].transform, "story_v_out_425032", "425032016", "story_v_out_425032.awb")

						arg_65_1:RecordAudio("425032016", var_68_32)
						arg_65_1:RecordAudio("425032016", var_68_32)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_425032", "425032016", "story_v_out_425032.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_425032", "425032016", "story_v_out_425032.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_33 = math.max(var_68_24, arg_65_1.talkMaxDuration)

			if var_68_23 <= arg_65_1.time_ and arg_65_1.time_ < var_68_23 + var_68_33 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_23) / var_68_33

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_23 + var_68_33 and arg_65_1.time_ < var_68_23 + var_68_33 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1080",
				frequency = 12,
				className = "StoryShakeNode",
				duration = 0.333333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.ACTOR_SPRITE,
				offset = Vector3.New(5, 5, 0)
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play425032017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 425032017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play425032018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1080"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1080 = var_72_0.localPosition
				var_72_0.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1080", 7)

				local var_72_2 = var_72_0.childCount

				for iter_72_0 = 0, var_72_2 - 1 do
					local var_72_3 = var_72_0:GetChild(iter_72_0)

					if var_72_3.name == "" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_4 then
				local var_72_5 = (arg_69_1.time_ - var_72_1) / var_72_4
				local var_72_6 = Vector3.New(0, -2000, 0)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1080, var_72_6, var_72_5)
			end

			if arg_69_1.time_ >= var_72_1 + var_72_4 and arg_69_1.time_ < var_72_1 + var_72_4 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_72_7 = arg_69_1.actors_["1137"].transform
			local var_72_8 = 0

			if var_72_8 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.var_.moveOldPos1137 = var_72_7.localPosition
				var_72_7.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1137", 7)

				local var_72_9 = var_72_7.childCount

				for iter_72_1 = 0, var_72_9 - 1 do
					local var_72_10 = var_72_7:GetChild(iter_72_1)

					if var_72_10.name == "" or not string.find(var_72_10.name, "split") then
						var_72_10.gameObject:SetActive(true)
					else
						var_72_10.gameObject:SetActive(false)
					end
				end
			end

			local var_72_11 = 0.001

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_11 then
				local var_72_12 = (arg_69_1.time_ - var_72_8) / var_72_11
				local var_72_13 = Vector3.New(0, -2000, 0)

				var_72_7.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1137, var_72_13, var_72_12)
			end

			if arg_69_1.time_ >= var_72_8 + var_72_11 and arg_69_1.time_ < var_72_8 + var_72_11 + arg_72_0 then
				var_72_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_72_14 = 0
			local var_72_15 = 1.025

			if var_72_14 < arg_69_1.time_ and arg_69_1.time_ <= var_72_14 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_16 = arg_69_1:GetWordFromCfg(425032017)
				local var_72_17 = arg_69_1:FormatText(var_72_16.content)

				arg_69_1.text_.text = var_72_17

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_18 = 41
				local var_72_19 = utf8.len(var_72_17)
				local var_72_20 = var_72_18 <= 0 and var_72_15 or var_72_15 * (var_72_19 / var_72_18)

				if var_72_20 > 0 and var_72_15 < var_72_20 then
					arg_69_1.talkMaxDuration = var_72_20

					if var_72_20 + var_72_14 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_20 + var_72_14
					end
				end

				arg_69_1.text_.text = var_72_17
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_21 = math.max(var_72_15, arg_69_1.talkMaxDuration)

			if var_72_14 <= arg_69_1.time_ and arg_69_1.time_ < var_72_14 + var_72_21 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_14) / var_72_21

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_14 + var_72_21 and arg_69_1.time_ < var_72_14 + var_72_21 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play425032018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 425032018
		arg_73_1.duration_ = 10.27

		local var_73_0 = {
			zh = 7,
			ja = 10.266
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play425032019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1080"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps1080 == nil then
				arg_73_1.var_.actorSpriteComps1080 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps1080 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								local var_76_4 = Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor1.r, var_76_3)
								local var_76_5 = Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor1.g, var_76_3)
								local var_76_6 = Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor1.b, var_76_3)

								iter_76_1.color = Color.New(var_76_4, var_76_5, var_76_6)
							else
								local var_76_7 = Mathf.Lerp(iter_76_1.color.r, 1, var_76_3)

								iter_76_1.color = Color.New(var_76_7, var_76_7, var_76_7)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps1080 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps1080 = nil
			end

			local var_76_8 = arg_73_1.actors_["1080"].transform
			local var_76_9 = 0

			if var_76_9 < arg_73_1.time_ and arg_73_1.time_ <= var_76_9 + arg_76_0 then
				arg_73_1.var_.moveOldPos1080 = var_76_8.localPosition
				var_76_8.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1080", 3)

				local var_76_10 = var_76_8.childCount

				for iter_76_4 = 0, var_76_10 - 1 do
					local var_76_11 = var_76_8:GetChild(iter_76_4)

					if var_76_11.name == "" or not string.find(var_76_11.name, "split") then
						var_76_11.gameObject:SetActive(true)
					else
						var_76_11.gameObject:SetActive(false)
					end
				end
			end

			local var_76_12 = 0.001

			if var_76_9 <= arg_73_1.time_ and arg_73_1.time_ < var_76_9 + var_76_12 then
				local var_76_13 = (arg_73_1.time_ - var_76_9) / var_76_12
				local var_76_14 = Vector3.New(0, -378, -170)

				var_76_8.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1080, var_76_14, var_76_13)
			end

			if arg_73_1.time_ >= var_76_9 + var_76_12 and arg_73_1.time_ < var_76_9 + var_76_12 + arg_76_0 then
				var_76_8.localPosition = Vector3.New(0, -378, -170)
			end

			local var_76_15 = 0
			local var_76_16 = 1

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_17 = arg_73_1:FormatText(StoryNameCfg[55].name)

				arg_73_1.leftNameTxt_.text = var_76_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_18 = arg_73_1:GetWordFromCfg(425032018)
				local var_76_19 = arg_73_1:FormatText(var_76_18.content)

				arg_73_1.text_.text = var_76_19

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_20 = 40
				local var_76_21 = utf8.len(var_76_19)
				local var_76_22 = var_76_20 <= 0 and var_76_16 or var_76_16 * (var_76_21 / var_76_20)

				if var_76_22 > 0 and var_76_16 < var_76_22 then
					arg_73_1.talkMaxDuration = var_76_22

					if var_76_22 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_22 + var_76_15
					end
				end

				arg_73_1.text_.text = var_76_19
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032018", "story_v_out_425032.awb") ~= 0 then
					local var_76_23 = manager.audio:GetVoiceLength("story_v_out_425032", "425032018", "story_v_out_425032.awb") / 1000

					if var_76_23 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_23 + var_76_15
					end

					if var_76_18.prefab_name ~= "" and arg_73_1.actors_[var_76_18.prefab_name] ~= nil then
						local var_76_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_18.prefab_name].transform, "story_v_out_425032", "425032018", "story_v_out_425032.awb")

						arg_73_1:RecordAudio("425032018", var_76_24)
						arg_73_1:RecordAudio("425032018", var_76_24)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_425032", "425032018", "story_v_out_425032.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_425032", "425032018", "story_v_out_425032.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_25 = math.max(var_76_16, arg_73_1.talkMaxDuration)

			if var_76_15 <= arg_73_1.time_ and arg_73_1.time_ < var_76_15 + var_76_25 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_15) / var_76_25

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_15 + var_76_25 and arg_73_1.time_ < var_76_15 + var_76_25 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play425032019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 425032019
		arg_77_1.duration_ = 8

		local var_77_0 = {
			zh = 3,
			ja = 8
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play425032020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1080"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos1080 = var_80_0.localPosition
				var_80_0.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1080", 3)

				local var_80_2 = var_80_0.childCount

				for iter_80_0 = 0, var_80_2 - 1 do
					local var_80_3 = var_80_0:GetChild(iter_80_0)

					if var_80_3.name == "" or not string.find(var_80_3.name, "split") then
						var_80_3.gameObject:SetActive(true)
					else
						var_80_3.gameObject:SetActive(false)
					end
				end
			end

			local var_80_4 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_4 then
				local var_80_5 = (arg_77_1.time_ - var_80_1) / var_80_4
				local var_80_6 = Vector3.New(0, -378, -170)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1080, var_80_6, var_80_5)
			end

			if arg_77_1.time_ >= var_80_1 + var_80_4 and arg_77_1.time_ < var_80_1 + var_80_4 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0, -378, -170)
			end

			local var_80_7 = 0

			if var_80_7 < arg_77_1.time_ and arg_77_1.time_ <= var_80_7 + arg_80_0 then
				arg_77_1.allBtn_.enabled = false
			end

			local var_80_8 = 0.4

			if arg_77_1.time_ >= var_80_7 + var_80_8 and arg_77_1.time_ < var_80_7 + var_80_8 + arg_80_0 then
				arg_77_1.allBtn_.enabled = true
			end

			local var_80_9 = 0
			local var_80_10 = 0.4

			if var_80_9 < arg_77_1.time_ and arg_77_1.time_ <= var_80_9 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_11 = arg_77_1:FormatText(StoryNameCfg[55].name)

				arg_77_1.leftNameTxt_.text = var_80_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_12 = arg_77_1:GetWordFromCfg(425032019)
				local var_80_13 = arg_77_1:FormatText(var_80_12.content)

				arg_77_1.text_.text = var_80_13

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_14 = 16
				local var_80_15 = utf8.len(var_80_13)
				local var_80_16 = var_80_14 <= 0 and var_80_10 or var_80_10 * (var_80_15 / var_80_14)

				if var_80_16 > 0 and var_80_10 < var_80_16 then
					arg_77_1.talkMaxDuration = var_80_16

					if var_80_16 + var_80_9 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_16 + var_80_9
					end
				end

				arg_77_1.text_.text = var_80_13
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032019", "story_v_out_425032.awb") ~= 0 then
					local var_80_17 = manager.audio:GetVoiceLength("story_v_out_425032", "425032019", "story_v_out_425032.awb") / 1000

					if var_80_17 + var_80_9 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_17 + var_80_9
					end

					if var_80_12.prefab_name ~= "" and arg_77_1.actors_[var_80_12.prefab_name] ~= nil then
						local var_80_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_12.prefab_name].transform, "story_v_out_425032", "425032019", "story_v_out_425032.awb")

						arg_77_1:RecordAudio("425032019", var_80_18)
						arg_77_1:RecordAudio("425032019", var_80_18)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_425032", "425032019", "story_v_out_425032.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_425032", "425032019", "story_v_out_425032.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_19 = math.max(var_80_10, arg_77_1.talkMaxDuration)

			if var_80_9 <= arg_77_1.time_ and arg_77_1.time_ < var_80_9 + var_80_19 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_9) / var_80_19

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_9 + var_80_19 and arg_77_1.time_ < var_80_9 + var_80_19 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "ST2107",
				frequency = 12,
				className = "StoryShakeNode",
				duration = 0.3,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.BACKGROUND,
				offset = Vector3.New(0.1, 0.1, 0)
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play425032020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 425032020
		arg_81_1.duration_ = 6.57

		local var_81_0 = {
			zh = 3.666,
			ja = 6.566
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play425032021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1086"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps1086 == nil then
				arg_81_1.var_.actorSpriteComps1086 = var_84_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_2 = 0.2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.actorSpriteComps1086 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_84_1 then
							if arg_81_1.isInRecall_ then
								local var_84_4 = Mathf.Lerp(iter_84_1.color.r, arg_81_1.hightColor1.r, var_84_3)
								local var_84_5 = Mathf.Lerp(iter_84_1.color.g, arg_81_1.hightColor1.g, var_84_3)
								local var_84_6 = Mathf.Lerp(iter_84_1.color.b, arg_81_1.hightColor1.b, var_84_3)

								iter_84_1.color = Color.New(var_84_4, var_84_5, var_84_6)
							else
								local var_84_7 = Mathf.Lerp(iter_84_1.color.r, 1, var_84_3)

								iter_84_1.color = Color.New(var_84_7, var_84_7, var_84_7)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps1086 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_84_3 then
						if arg_81_1.isInRecall_ then
							iter_84_3.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_84_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps1086 = nil
			end

			local var_84_8 = arg_81_1.actors_["1080"]
			local var_84_9 = 0

			if var_84_9 < arg_81_1.time_ and arg_81_1.time_ <= var_84_9 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps1080 == nil then
				arg_81_1.var_.actorSpriteComps1080 = var_84_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_10 = 0.2

			if var_84_9 <= arg_81_1.time_ and arg_81_1.time_ < var_84_9 + var_84_10 and not isNil(var_84_8) then
				local var_84_11 = (arg_81_1.time_ - var_84_9) / var_84_10

				if arg_81_1.var_.actorSpriteComps1080 then
					for iter_84_4, iter_84_5 in pairs(arg_81_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_84_5 then
							if arg_81_1.isInRecall_ then
								local var_84_12 = Mathf.Lerp(iter_84_5.color.r, arg_81_1.hightColor2.r, var_84_11)
								local var_84_13 = Mathf.Lerp(iter_84_5.color.g, arg_81_1.hightColor2.g, var_84_11)
								local var_84_14 = Mathf.Lerp(iter_84_5.color.b, arg_81_1.hightColor2.b, var_84_11)

								iter_84_5.color = Color.New(var_84_12, var_84_13, var_84_14)
							else
								local var_84_15 = Mathf.Lerp(iter_84_5.color.r, 0.5, var_84_11)

								iter_84_5.color = Color.New(var_84_15, var_84_15, var_84_15)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_9 + var_84_10 and arg_81_1.time_ < var_84_9 + var_84_10 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps1080 then
				for iter_84_6, iter_84_7 in pairs(arg_81_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_84_7 then
						if arg_81_1.isInRecall_ then
							iter_84_7.color = arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_84_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps1080 = nil
			end

			local var_84_16 = arg_81_1.actors_["1086"].transform
			local var_84_17 = 0

			if var_84_17 < arg_81_1.time_ and arg_81_1.time_ <= var_84_17 + arg_84_0 then
				arg_81_1.var_.moveOldPos1086 = var_84_16.localPosition
				var_84_16.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1086", 2)

				local var_84_18 = var_84_16.childCount

				for iter_84_8 = 0, var_84_18 - 1 do
					local var_84_19 = var_84_16:GetChild(iter_84_8)

					if var_84_19.name == "" or not string.find(var_84_19.name, "split") then
						var_84_19.gameObject:SetActive(true)
					else
						var_84_19.gameObject:SetActive(false)
					end
				end
			end

			local var_84_20 = 0.001

			if var_84_17 <= arg_81_1.time_ and arg_81_1.time_ < var_84_17 + var_84_20 then
				local var_84_21 = (arg_81_1.time_ - var_84_17) / var_84_20
				local var_84_22 = Vector3.New(-390, -404.2, -237.9)

				var_84_16.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1086, var_84_22, var_84_21)
			end

			if arg_81_1.time_ >= var_84_17 + var_84_20 and arg_81_1.time_ < var_84_17 + var_84_20 + arg_84_0 then
				var_84_16.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_84_23 = arg_81_1.actors_["1080"].transform
			local var_84_24 = 0

			if var_84_24 < arg_81_1.time_ and arg_81_1.time_ <= var_84_24 + arg_84_0 then
				arg_81_1.var_.moveOldPos1080 = var_84_23.localPosition
				var_84_23.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1080", 7)

				local var_84_25 = var_84_23.childCount

				for iter_84_9 = 0, var_84_25 - 1 do
					local var_84_26 = var_84_23:GetChild(iter_84_9)

					if var_84_26.name == "" or not string.find(var_84_26.name, "split") then
						var_84_26.gameObject:SetActive(true)
					else
						var_84_26.gameObject:SetActive(false)
					end
				end
			end

			local var_84_27 = 0.001

			if var_84_24 <= arg_81_1.time_ and arg_81_1.time_ < var_84_24 + var_84_27 then
				local var_84_28 = (arg_81_1.time_ - var_84_24) / var_84_27
				local var_84_29 = Vector3.New(0, -2000, 0)

				var_84_23.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1080, var_84_29, var_84_28)
			end

			if arg_81_1.time_ >= var_84_24 + var_84_27 and arg_81_1.time_ < var_84_24 + var_84_27 + arg_84_0 then
				var_84_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_84_30 = 0
			local var_84_31 = 0.475

			if var_84_30 < arg_81_1.time_ and arg_81_1.time_ <= var_84_30 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_32 = arg_81_1:FormatText(StoryNameCfg[1080].name)

				arg_81_1.leftNameTxt_.text = var_84_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_33 = arg_81_1:GetWordFromCfg(425032020)
				local var_84_34 = arg_81_1:FormatText(var_84_33.content)

				arg_81_1.text_.text = var_84_34

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_35 = 19
				local var_84_36 = utf8.len(var_84_34)
				local var_84_37 = var_84_35 <= 0 and var_84_31 or var_84_31 * (var_84_36 / var_84_35)

				if var_84_37 > 0 and var_84_31 < var_84_37 then
					arg_81_1.talkMaxDuration = var_84_37

					if var_84_37 + var_84_30 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_37 + var_84_30
					end
				end

				arg_81_1.text_.text = var_84_34
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032020", "story_v_out_425032.awb") ~= 0 then
					local var_84_38 = manager.audio:GetVoiceLength("story_v_out_425032", "425032020", "story_v_out_425032.awb") / 1000

					if var_84_38 + var_84_30 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_38 + var_84_30
					end

					if var_84_33.prefab_name ~= "" and arg_81_1.actors_[var_84_33.prefab_name] ~= nil then
						local var_84_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_33.prefab_name].transform, "story_v_out_425032", "425032020", "story_v_out_425032.awb")

						arg_81_1:RecordAudio("425032020", var_84_39)
						arg_81_1:RecordAudio("425032020", var_84_39)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_425032", "425032020", "story_v_out_425032.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_425032", "425032020", "story_v_out_425032.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_40 = math.max(var_84_31, arg_81_1.talkMaxDuration)

			if var_84_30 <= arg_81_1.time_ and arg_81_1.time_ < var_84_30 + var_84_40 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_30) / var_84_40

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_30 + var_84_40 and arg_81_1.time_ < var_84_30 + var_84_40 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
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
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play425032021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 425032021
		arg_85_1.duration_ = 1.57

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play425032022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1137"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps1137 == nil then
				arg_85_1.var_.actorSpriteComps1137 = var_88_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_2 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.actorSpriteComps1137 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								local var_88_4 = Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor1.r, var_88_3)
								local var_88_5 = Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor1.g, var_88_3)
								local var_88_6 = Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor1.b, var_88_3)

								iter_88_1.color = Color.New(var_88_4, var_88_5, var_88_6)
							else
								local var_88_7 = Mathf.Lerp(iter_88_1.color.r, 1, var_88_3)

								iter_88_1.color = Color.New(var_88_7, var_88_7, var_88_7)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps1137 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_88_3 then
						if arg_85_1.isInRecall_ then
							iter_88_3.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps1137 = nil
			end

			local var_88_8 = arg_85_1.actors_["1086"]
			local var_88_9 = 0

			if var_88_9 < arg_85_1.time_ and arg_85_1.time_ <= var_88_9 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps1086 == nil then
				arg_85_1.var_.actorSpriteComps1086 = var_88_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_10 = 0.2

			if var_88_9 <= arg_85_1.time_ and arg_85_1.time_ < var_88_9 + var_88_10 and not isNil(var_88_8) then
				local var_88_11 = (arg_85_1.time_ - var_88_9) / var_88_10

				if arg_85_1.var_.actorSpriteComps1086 then
					for iter_88_4, iter_88_5 in pairs(arg_85_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_88_5 then
							if arg_85_1.isInRecall_ then
								local var_88_12 = Mathf.Lerp(iter_88_5.color.r, arg_85_1.hightColor2.r, var_88_11)
								local var_88_13 = Mathf.Lerp(iter_88_5.color.g, arg_85_1.hightColor2.g, var_88_11)
								local var_88_14 = Mathf.Lerp(iter_88_5.color.b, arg_85_1.hightColor2.b, var_88_11)

								iter_88_5.color = Color.New(var_88_12, var_88_13, var_88_14)
							else
								local var_88_15 = Mathf.Lerp(iter_88_5.color.r, 0.5, var_88_11)

								iter_88_5.color = Color.New(var_88_15, var_88_15, var_88_15)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_9 + var_88_10 and arg_85_1.time_ < var_88_9 + var_88_10 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps1086 then
				for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_88_7 then
						if arg_85_1.isInRecall_ then
							iter_88_7.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps1086 = nil
			end

			local var_88_16 = arg_85_1.actors_["1137"].transform
			local var_88_17 = 0

			if var_88_17 < arg_85_1.time_ and arg_85_1.time_ <= var_88_17 + arg_88_0 then
				arg_85_1.var_.moveOldPos1137 = var_88_16.localPosition
				var_88_16.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("1137", 4)

				local var_88_18 = var_88_16.childCount

				for iter_88_8 = 0, var_88_18 - 1 do
					local var_88_19 = var_88_16:GetChild(iter_88_8)

					if var_88_19.name == "split_4" or not string.find(var_88_19.name, "split") then
						var_88_19.gameObject:SetActive(true)
					else
						var_88_19.gameObject:SetActive(false)
					end
				end
			end

			local var_88_20 = 0.001

			if var_88_17 <= arg_85_1.time_ and arg_85_1.time_ < var_88_17 + var_88_20 then
				local var_88_21 = (arg_85_1.time_ - var_88_17) / var_88_20
				local var_88_22 = Vector3.New(390, -425, -200)

				var_88_16.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1137, var_88_22, var_88_21)
			end

			if arg_85_1.time_ >= var_88_17 + var_88_20 and arg_85_1.time_ < var_88_17 + var_88_20 + arg_88_0 then
				var_88_16.localPosition = Vector3.New(390, -425, -200)
			end

			local var_88_23 = 0
			local var_88_24 = 0.075

			if var_88_23 < arg_85_1.time_ and arg_85_1.time_ <= var_88_23 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_25 = arg_85_1:FormatText(StoryNameCfg[15].name)

				arg_85_1.leftNameTxt_.text = var_88_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_26 = arg_85_1:GetWordFromCfg(425032021)
				local var_88_27 = arg_85_1:FormatText(var_88_26.content)

				arg_85_1.text_.text = var_88_27

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_28 = 3
				local var_88_29 = utf8.len(var_88_27)
				local var_88_30 = var_88_28 <= 0 and var_88_24 or var_88_24 * (var_88_29 / var_88_28)

				if var_88_30 > 0 and var_88_24 < var_88_30 then
					arg_85_1.talkMaxDuration = var_88_30

					if var_88_30 + var_88_23 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_30 + var_88_23
					end
				end

				arg_85_1.text_.text = var_88_27
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032021", "story_v_out_425032.awb") ~= 0 then
					local var_88_31 = manager.audio:GetVoiceLength("story_v_out_425032", "425032021", "story_v_out_425032.awb") / 1000

					if var_88_31 + var_88_23 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_31 + var_88_23
					end

					if var_88_26.prefab_name ~= "" and arg_85_1.actors_[var_88_26.prefab_name] ~= nil then
						local var_88_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_26.prefab_name].transform, "story_v_out_425032", "425032021", "story_v_out_425032.awb")

						arg_85_1:RecordAudio("425032021", var_88_32)
						arg_85_1:RecordAudio("425032021", var_88_32)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_425032", "425032021", "story_v_out_425032.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_425032", "425032021", "story_v_out_425032.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_33 = math.max(var_88_24, arg_85_1.talkMaxDuration)

			if var_88_23 <= arg_85_1.time_ and arg_85_1.time_ < var_88_23 + var_88_33 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_23) / var_88_33

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_23 + var_88_33 and arg_85_1.time_ < var_88_23 + var_88_33 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play425032022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 425032022
		arg_89_1.duration_ = 10.6

		local var_89_0 = {
			zh = 9.5,
			ja = 10.6
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
				arg_89_0:Play425032023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1086"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps1086 == nil then
				arg_89_1.var_.actorSpriteComps1086 = var_92_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_2 = 0.2

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.actorSpriteComps1086 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_92_1 then
							if arg_89_1.isInRecall_ then
								local var_92_4 = Mathf.Lerp(iter_92_1.color.r, arg_89_1.hightColor1.r, var_92_3)
								local var_92_5 = Mathf.Lerp(iter_92_1.color.g, arg_89_1.hightColor1.g, var_92_3)
								local var_92_6 = Mathf.Lerp(iter_92_1.color.b, arg_89_1.hightColor1.b, var_92_3)

								iter_92_1.color = Color.New(var_92_4, var_92_5, var_92_6)
							else
								local var_92_7 = Mathf.Lerp(iter_92_1.color.r, 1, var_92_3)

								iter_92_1.color = Color.New(var_92_7, var_92_7, var_92_7)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps1086 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_92_3 then
						if arg_89_1.isInRecall_ then
							iter_92_3.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps1086 = nil
			end

			local var_92_8 = arg_89_1.actors_["1137"]
			local var_92_9 = 0

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps1137 == nil then
				arg_89_1.var_.actorSpriteComps1137 = var_92_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_10 = 0.2

			if var_92_9 <= arg_89_1.time_ and arg_89_1.time_ < var_92_9 + var_92_10 and not isNil(var_92_8) then
				local var_92_11 = (arg_89_1.time_ - var_92_9) / var_92_10

				if arg_89_1.var_.actorSpriteComps1137 then
					for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_92_5 then
							if arg_89_1.isInRecall_ then
								local var_92_12 = Mathf.Lerp(iter_92_5.color.r, arg_89_1.hightColor2.r, var_92_11)
								local var_92_13 = Mathf.Lerp(iter_92_5.color.g, arg_89_1.hightColor2.g, var_92_11)
								local var_92_14 = Mathf.Lerp(iter_92_5.color.b, arg_89_1.hightColor2.b, var_92_11)

								iter_92_5.color = Color.New(var_92_12, var_92_13, var_92_14)
							else
								local var_92_15 = Mathf.Lerp(iter_92_5.color.r, 0.5, var_92_11)

								iter_92_5.color = Color.New(var_92_15, var_92_15, var_92_15)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_9 + var_92_10 and arg_89_1.time_ < var_92_9 + var_92_10 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps1137 then
				for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_92_7 then
						if arg_89_1.isInRecall_ then
							iter_92_7.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps1137 = nil
			end

			local var_92_16 = arg_89_1.actors_["1086"].transform
			local var_92_17 = 0

			if var_92_17 < arg_89_1.time_ and arg_89_1.time_ <= var_92_17 + arg_92_0 then
				arg_89_1.var_.moveOldPos1086 = var_92_16.localPosition
				var_92_16.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1086", 2)

				local var_92_18 = var_92_16.childCount

				for iter_92_8 = 0, var_92_18 - 1 do
					local var_92_19 = var_92_16:GetChild(iter_92_8)

					if var_92_19.name == "" or not string.find(var_92_19.name, "split") then
						var_92_19.gameObject:SetActive(true)
					else
						var_92_19.gameObject:SetActive(false)
					end
				end
			end

			local var_92_20 = 0.001

			if var_92_17 <= arg_89_1.time_ and arg_89_1.time_ < var_92_17 + var_92_20 then
				local var_92_21 = (arg_89_1.time_ - var_92_17) / var_92_20
				local var_92_22 = Vector3.New(-390, -404.2, -237.9)

				var_92_16.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1086, var_92_22, var_92_21)
			end

			if arg_89_1.time_ >= var_92_17 + var_92_20 and arg_89_1.time_ < var_92_17 + var_92_20 + arg_92_0 then
				var_92_16.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_92_23 = 0
			local var_92_24 = 1.425

			if var_92_23 < arg_89_1.time_ and arg_89_1.time_ <= var_92_23 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_25 = arg_89_1:FormatText(StoryNameCfg[1080].name)

				arg_89_1.leftNameTxt_.text = var_92_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_26 = arg_89_1:GetWordFromCfg(425032022)
				local var_92_27 = arg_89_1:FormatText(var_92_26.content)

				arg_89_1.text_.text = var_92_27

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_28 = 57
				local var_92_29 = utf8.len(var_92_27)
				local var_92_30 = var_92_28 <= 0 and var_92_24 or var_92_24 * (var_92_29 / var_92_28)

				if var_92_30 > 0 and var_92_24 < var_92_30 then
					arg_89_1.talkMaxDuration = var_92_30

					if var_92_30 + var_92_23 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_30 + var_92_23
					end
				end

				arg_89_1.text_.text = var_92_27
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032022", "story_v_out_425032.awb") ~= 0 then
					local var_92_31 = manager.audio:GetVoiceLength("story_v_out_425032", "425032022", "story_v_out_425032.awb") / 1000

					if var_92_31 + var_92_23 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_31 + var_92_23
					end

					if var_92_26.prefab_name ~= "" and arg_89_1.actors_[var_92_26.prefab_name] ~= nil then
						local var_92_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_26.prefab_name].transform, "story_v_out_425032", "425032022", "story_v_out_425032.awb")

						arg_89_1:RecordAudio("425032022", var_92_32)
						arg_89_1:RecordAudio("425032022", var_92_32)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_425032", "425032022", "story_v_out_425032.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_425032", "425032022", "story_v_out_425032.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_33 = math.max(var_92_24, arg_89_1.talkMaxDuration)

			if var_92_23 <= arg_89_1.time_ and arg_89_1.time_ < var_92_23 + var_92_33 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_23) / var_92_33

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_23 + var_92_33 and arg_89_1.time_ < var_92_23 + var_92_33 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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

		arg_89_1:InitPlayNodeList()
	end,
	Play425032023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 425032023
		arg_93_1.duration_ = 1.3

		local var_93_0 = {
			zh = 1.133,
			ja = 1.3
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
				arg_93_0:Play425032024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1080"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps1080 == nil then
				arg_93_1.var_.actorSpriteComps1080 = var_96_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_2 = 0.2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.actorSpriteComps1080 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_96_1 then
							if arg_93_1.isInRecall_ then
								local var_96_4 = Mathf.Lerp(iter_96_1.color.r, arg_93_1.hightColor1.r, var_96_3)
								local var_96_5 = Mathf.Lerp(iter_96_1.color.g, arg_93_1.hightColor1.g, var_96_3)
								local var_96_6 = Mathf.Lerp(iter_96_1.color.b, arg_93_1.hightColor1.b, var_96_3)

								iter_96_1.color = Color.New(var_96_4, var_96_5, var_96_6)
							else
								local var_96_7 = Mathf.Lerp(iter_96_1.color.r, 1, var_96_3)

								iter_96_1.color = Color.New(var_96_7, var_96_7, var_96_7)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps1080 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_96_3 then
						if arg_93_1.isInRecall_ then
							iter_96_3.color = arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_96_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps1080 = nil
			end

			local var_96_8 = arg_93_1.actors_["1086"]
			local var_96_9 = 0

			if var_96_9 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps1086 == nil then
				arg_93_1.var_.actorSpriteComps1086 = var_96_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_10 = 0.2

			if var_96_9 <= arg_93_1.time_ and arg_93_1.time_ < var_96_9 + var_96_10 and not isNil(var_96_8) then
				local var_96_11 = (arg_93_1.time_ - var_96_9) / var_96_10

				if arg_93_1.var_.actorSpriteComps1086 then
					for iter_96_4, iter_96_5 in pairs(arg_93_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_96_5 then
							if arg_93_1.isInRecall_ then
								local var_96_12 = Mathf.Lerp(iter_96_5.color.r, arg_93_1.hightColor2.r, var_96_11)
								local var_96_13 = Mathf.Lerp(iter_96_5.color.g, arg_93_1.hightColor2.g, var_96_11)
								local var_96_14 = Mathf.Lerp(iter_96_5.color.b, arg_93_1.hightColor2.b, var_96_11)

								iter_96_5.color = Color.New(var_96_12, var_96_13, var_96_14)
							else
								local var_96_15 = Mathf.Lerp(iter_96_5.color.r, 0.5, var_96_11)

								iter_96_5.color = Color.New(var_96_15, var_96_15, var_96_15)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_9 + var_96_10 and arg_93_1.time_ < var_96_9 + var_96_10 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps1086 then
				for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_96_7 then
						if arg_93_1.isInRecall_ then
							iter_96_7.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps1086 = nil
			end

			local var_96_16 = arg_93_1.actors_["1080"].transform
			local var_96_17 = 0

			if var_96_17 < arg_93_1.time_ and arg_93_1.time_ <= var_96_17 + arg_96_0 then
				arg_93_1.var_.moveOldPos1080 = var_96_16.localPosition
				var_96_16.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1080", 4)

				local var_96_18 = var_96_16.childCount

				for iter_96_8 = 0, var_96_18 - 1 do
					local var_96_19 = var_96_16:GetChild(iter_96_8)

					if var_96_19.name == "" or not string.find(var_96_19.name, "split") then
						var_96_19.gameObject:SetActive(true)
					else
						var_96_19.gameObject:SetActive(false)
					end
				end
			end

			local var_96_20 = 0.001

			if var_96_17 <= arg_93_1.time_ and arg_93_1.time_ < var_96_17 + var_96_20 then
				local var_96_21 = (arg_93_1.time_ - var_96_17) / var_96_20
				local var_96_22 = Vector3.New(390, -378, -170)

				var_96_16.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1080, var_96_22, var_96_21)
			end

			if arg_93_1.time_ >= var_96_17 + var_96_20 and arg_93_1.time_ < var_96_17 + var_96_20 + arg_96_0 then
				var_96_16.localPosition = Vector3.New(390, -378, -170)
			end

			local var_96_23 = arg_93_1.actors_["1137"].transform
			local var_96_24 = 0

			if var_96_24 < arg_93_1.time_ and arg_93_1.time_ <= var_96_24 + arg_96_0 then
				arg_93_1.var_.moveOldPos1137 = var_96_23.localPosition
				var_96_23.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1137", 7)

				local var_96_25 = var_96_23.childCount

				for iter_96_9 = 0, var_96_25 - 1 do
					local var_96_26 = var_96_23:GetChild(iter_96_9)

					if var_96_26.name == "" or not string.find(var_96_26.name, "split") then
						var_96_26.gameObject:SetActive(true)
					else
						var_96_26.gameObject:SetActive(false)
					end
				end
			end

			local var_96_27 = 0.001

			if var_96_24 <= arg_93_1.time_ and arg_93_1.time_ < var_96_24 + var_96_27 then
				local var_96_28 = (arg_93_1.time_ - var_96_24) / var_96_27
				local var_96_29 = Vector3.New(0, -2000, 0)

				var_96_23.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1137, var_96_29, var_96_28)
			end

			if arg_93_1.time_ >= var_96_24 + var_96_27 and arg_93_1.time_ < var_96_24 + var_96_27 + arg_96_0 then
				var_96_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_96_30 = 0
			local var_96_31 = 0.1

			if var_96_30 < arg_93_1.time_ and arg_93_1.time_ <= var_96_30 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_32 = arg_93_1:FormatText(StoryNameCfg[55].name)

				arg_93_1.leftNameTxt_.text = var_96_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_33 = arg_93_1:GetWordFromCfg(425032023)
				local var_96_34 = arg_93_1:FormatText(var_96_33.content)

				arg_93_1.text_.text = var_96_34

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_35 = 4
				local var_96_36 = utf8.len(var_96_34)
				local var_96_37 = var_96_35 <= 0 and var_96_31 or var_96_31 * (var_96_36 / var_96_35)

				if var_96_37 > 0 and var_96_31 < var_96_37 then
					arg_93_1.talkMaxDuration = var_96_37

					if var_96_37 + var_96_30 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_37 + var_96_30
					end
				end

				arg_93_1.text_.text = var_96_34
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032023", "story_v_out_425032.awb") ~= 0 then
					local var_96_38 = manager.audio:GetVoiceLength("story_v_out_425032", "425032023", "story_v_out_425032.awb") / 1000

					if var_96_38 + var_96_30 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_38 + var_96_30
					end

					if var_96_33.prefab_name ~= "" and arg_93_1.actors_[var_96_33.prefab_name] ~= nil then
						local var_96_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_33.prefab_name].transform, "story_v_out_425032", "425032023", "story_v_out_425032.awb")

						arg_93_1:RecordAudio("425032023", var_96_39)
						arg_93_1:RecordAudio("425032023", var_96_39)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_425032", "425032023", "story_v_out_425032.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_425032", "425032023", "story_v_out_425032.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_40 = math.max(var_96_31, arg_93_1.talkMaxDuration)

			if var_96_30 <= arg_93_1.time_ and arg_93_1.time_ < var_96_30 + var_96_40 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_30) / var_96_40

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_30 + var_96_40 and arg_93_1.time_ < var_96_30 + var_96_40 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play425032024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 425032024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play425032025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1080"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps1080 == nil then
				arg_97_1.var_.actorSpriteComps1080 = var_100_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_2 = 0.2

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.actorSpriteComps1080 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_100_1 then
							if arg_97_1.isInRecall_ then
								local var_100_4 = Mathf.Lerp(iter_100_1.color.r, arg_97_1.hightColor2.r, var_100_3)
								local var_100_5 = Mathf.Lerp(iter_100_1.color.g, arg_97_1.hightColor2.g, var_100_3)
								local var_100_6 = Mathf.Lerp(iter_100_1.color.b, arg_97_1.hightColor2.b, var_100_3)

								iter_100_1.color = Color.New(var_100_4, var_100_5, var_100_6)
							else
								local var_100_7 = Mathf.Lerp(iter_100_1.color.r, 0.5, var_100_3)

								iter_100_1.color = Color.New(var_100_7, var_100_7, var_100_7)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps1080 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_100_3 then
						if arg_97_1.isInRecall_ then
							iter_100_3.color = arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_100_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps1080 = nil
			end

			local var_100_8 = arg_97_1.actors_["1080"].transform
			local var_100_9 = 0

			if var_100_9 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 then
				arg_97_1.var_.moveOldPos1080 = var_100_8.localPosition
				var_100_8.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1080", 7)

				local var_100_10 = var_100_8.childCount

				for iter_100_4 = 0, var_100_10 - 1 do
					local var_100_11 = var_100_8:GetChild(iter_100_4)

					if var_100_11.name == "" or not string.find(var_100_11.name, "split") then
						var_100_11.gameObject:SetActive(true)
					else
						var_100_11.gameObject:SetActive(false)
					end
				end
			end

			local var_100_12 = 0.001

			if var_100_9 <= arg_97_1.time_ and arg_97_1.time_ < var_100_9 + var_100_12 then
				local var_100_13 = (arg_97_1.time_ - var_100_9) / var_100_12
				local var_100_14 = Vector3.New(0, -2000, 0)

				var_100_8.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1080, var_100_14, var_100_13)
			end

			if arg_97_1.time_ >= var_100_9 + var_100_12 and arg_97_1.time_ < var_100_9 + var_100_12 + arg_100_0 then
				var_100_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_100_15 = arg_97_1.actors_["1086"].transform
			local var_100_16 = 0

			if var_100_16 < arg_97_1.time_ and arg_97_1.time_ <= var_100_16 + arg_100_0 then
				arg_97_1.var_.moveOldPos1086 = var_100_15.localPosition
				var_100_15.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1086", 7)

				local var_100_17 = var_100_15.childCount

				for iter_100_5 = 0, var_100_17 - 1 do
					local var_100_18 = var_100_15:GetChild(iter_100_5)

					if var_100_18.name == "" or not string.find(var_100_18.name, "split") then
						var_100_18.gameObject:SetActive(true)
					else
						var_100_18.gameObject:SetActive(false)
					end
				end
			end

			local var_100_19 = 0.001

			if var_100_16 <= arg_97_1.time_ and arg_97_1.time_ < var_100_16 + var_100_19 then
				local var_100_20 = (arg_97_1.time_ - var_100_16) / var_100_19
				local var_100_21 = Vector3.New(0, -2000, 0)

				var_100_15.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1086, var_100_21, var_100_20)
			end

			if arg_97_1.time_ >= var_100_16 + var_100_19 and arg_97_1.time_ < var_100_16 + var_100_19 + arg_100_0 then
				var_100_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_100_22 = 0
			local var_100_23 = 0.9

			if var_100_22 < arg_97_1.time_ and arg_97_1.time_ <= var_100_22 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_24 = arg_97_1:GetWordFromCfg(425032024)
				local var_100_25 = arg_97_1:FormatText(var_100_24.content)

				arg_97_1.text_.text = var_100_25

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_26 = 36
				local var_100_27 = utf8.len(var_100_25)
				local var_100_28 = var_100_26 <= 0 and var_100_23 or var_100_23 * (var_100_27 / var_100_26)

				if var_100_28 > 0 and var_100_23 < var_100_28 then
					arg_97_1.talkMaxDuration = var_100_28

					if var_100_28 + var_100_22 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_28 + var_100_22
					end
				end

				arg_97_1.text_.text = var_100_25
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_29 = math.max(var_100_23, arg_97_1.talkMaxDuration)

			if var_100_22 <= arg_97_1.time_ and arg_97_1.time_ < var_100_22 + var_100_29 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_22) / var_100_29

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_22 + var_100_29 and arg_97_1.time_ < var_100_22 + var_100_29 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
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

		arg_97_1:InitPlayNodeList()
	end,
	Play425032025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 425032025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play425032026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.925

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_2 = arg_101_1:GetWordFromCfg(425032025)
				local var_104_3 = arg_101_1:FormatText(var_104_2.content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 37
				local var_104_5 = utf8.len(var_104_3)
				local var_104_6 = var_104_4 <= 0 and var_104_1 or var_104_1 * (var_104_5 / var_104_4)

				if var_104_6 > 0 and var_104_1 < var_104_6 then
					arg_101_1.talkMaxDuration = var_104_6

					if var_104_6 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_7 and arg_101_1.time_ < var_104_0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play425032026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 425032026
		arg_105_1.duration_ = 3.3

		local var_105_0 = {
			zh = 1.533,
			ja = 3.3
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
				arg_105_0:Play425032027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1086"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps1086 == nil then
				arg_105_1.var_.actorSpriteComps1086 = var_108_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_2 = 0.2

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.actorSpriteComps1086 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								local var_108_4 = Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor1.r, var_108_3)
								local var_108_5 = Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor1.g, var_108_3)
								local var_108_6 = Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor1.b, var_108_3)

								iter_108_1.color = Color.New(var_108_4, var_108_5, var_108_6)
							else
								local var_108_7 = Mathf.Lerp(iter_108_1.color.r, 1, var_108_3)

								iter_108_1.color = Color.New(var_108_7, var_108_7, var_108_7)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps1086 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_108_3 then
						if arg_105_1.isInRecall_ then
							iter_108_3.color = arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_108_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps1086 = nil
			end

			local var_108_8 = arg_105_1.actors_["1086"].transform
			local var_108_9 = 0

			if var_108_9 < arg_105_1.time_ and arg_105_1.time_ <= var_108_9 + arg_108_0 then
				arg_105_1.var_.moveOldPos1086 = var_108_8.localPosition
				var_108_8.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("1086", 2)

				local var_108_10 = var_108_8.childCount

				for iter_108_4 = 0, var_108_10 - 1 do
					local var_108_11 = var_108_8:GetChild(iter_108_4)

					if var_108_11.name == "" or not string.find(var_108_11.name, "split") then
						var_108_11.gameObject:SetActive(true)
					else
						var_108_11.gameObject:SetActive(false)
					end
				end
			end

			local var_108_12 = 0.001

			if var_108_9 <= arg_105_1.time_ and arg_105_1.time_ < var_108_9 + var_108_12 then
				local var_108_13 = (arg_105_1.time_ - var_108_9) / var_108_12
				local var_108_14 = Vector3.New(-390, -404.2, -237.9)

				var_108_8.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1086, var_108_14, var_108_13)
			end

			if arg_105_1.time_ >= var_108_9 + var_108_12 and arg_105_1.time_ < var_108_9 + var_108_12 + arg_108_0 then
				var_108_8.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_108_15 = 0
			local var_108_16 = 0.15

			if var_108_15 < arg_105_1.time_ and arg_105_1.time_ <= var_108_15 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_17 = arg_105_1:FormatText(StoryNameCfg[1080].name)

				arg_105_1.leftNameTxt_.text = var_108_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_18 = arg_105_1:GetWordFromCfg(425032026)
				local var_108_19 = arg_105_1:FormatText(var_108_18.content)

				arg_105_1.text_.text = var_108_19

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_20 = 6
				local var_108_21 = utf8.len(var_108_19)
				local var_108_22 = var_108_20 <= 0 and var_108_16 or var_108_16 * (var_108_21 / var_108_20)

				if var_108_22 > 0 and var_108_16 < var_108_22 then
					arg_105_1.talkMaxDuration = var_108_22

					if var_108_22 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_22 + var_108_15
					end
				end

				arg_105_1.text_.text = var_108_19
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032026", "story_v_out_425032.awb") ~= 0 then
					local var_108_23 = manager.audio:GetVoiceLength("story_v_out_425032", "425032026", "story_v_out_425032.awb") / 1000

					if var_108_23 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_23 + var_108_15
					end

					if var_108_18.prefab_name ~= "" and arg_105_1.actors_[var_108_18.prefab_name] ~= nil then
						local var_108_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_18.prefab_name].transform, "story_v_out_425032", "425032026", "story_v_out_425032.awb")

						arg_105_1:RecordAudio("425032026", var_108_24)
						arg_105_1:RecordAudio("425032026", var_108_24)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_425032", "425032026", "story_v_out_425032.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_425032", "425032026", "story_v_out_425032.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_25 = math.max(var_108_16, arg_105_1.talkMaxDuration)

			if var_108_15 <= arg_105_1.time_ and arg_105_1.time_ < var_108_15 + var_108_25 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_15) / var_108_25

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_15 + var_108_25 and arg_105_1.time_ < var_108_15 + var_108_25 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
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

		arg_105_1:InitPlayNodeList()
	end,
	Play425032027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 425032027
		arg_109_1.duration_ = 10.17

		local var_109_0 = {
			zh = 8.633,
			ja = 10.166
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
				arg_109_0:Play425032028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1080"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps1080 == nil then
				arg_109_1.var_.actorSpriteComps1080 = var_112_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_2 = 0.2

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.actorSpriteComps1080 then
					for iter_112_0, iter_112_1 in pairs(arg_109_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_112_1 then
							if arg_109_1.isInRecall_ then
								local var_112_4 = Mathf.Lerp(iter_112_1.color.r, arg_109_1.hightColor1.r, var_112_3)
								local var_112_5 = Mathf.Lerp(iter_112_1.color.g, arg_109_1.hightColor1.g, var_112_3)
								local var_112_6 = Mathf.Lerp(iter_112_1.color.b, arg_109_1.hightColor1.b, var_112_3)

								iter_112_1.color = Color.New(var_112_4, var_112_5, var_112_6)
							else
								local var_112_7 = Mathf.Lerp(iter_112_1.color.r, 1, var_112_3)

								iter_112_1.color = Color.New(var_112_7, var_112_7, var_112_7)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps1080 then
				for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_112_3 then
						if arg_109_1.isInRecall_ then
							iter_112_3.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps1080 = nil
			end

			local var_112_8 = arg_109_1.actors_["1086"]
			local var_112_9 = 0

			if var_112_9 < arg_109_1.time_ and arg_109_1.time_ <= var_112_9 + arg_112_0 and not isNil(var_112_8) and arg_109_1.var_.actorSpriteComps1086 == nil then
				arg_109_1.var_.actorSpriteComps1086 = var_112_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_10 = 0.2

			if var_112_9 <= arg_109_1.time_ and arg_109_1.time_ < var_112_9 + var_112_10 and not isNil(var_112_8) then
				local var_112_11 = (arg_109_1.time_ - var_112_9) / var_112_10

				if arg_109_1.var_.actorSpriteComps1086 then
					for iter_112_4, iter_112_5 in pairs(arg_109_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_112_5 then
							if arg_109_1.isInRecall_ then
								local var_112_12 = Mathf.Lerp(iter_112_5.color.r, arg_109_1.hightColor2.r, var_112_11)
								local var_112_13 = Mathf.Lerp(iter_112_5.color.g, arg_109_1.hightColor2.g, var_112_11)
								local var_112_14 = Mathf.Lerp(iter_112_5.color.b, arg_109_1.hightColor2.b, var_112_11)

								iter_112_5.color = Color.New(var_112_12, var_112_13, var_112_14)
							else
								local var_112_15 = Mathf.Lerp(iter_112_5.color.r, 0.5, var_112_11)

								iter_112_5.color = Color.New(var_112_15, var_112_15, var_112_15)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_9 + var_112_10 and arg_109_1.time_ < var_112_9 + var_112_10 + arg_112_0 and not isNil(var_112_8) and arg_109_1.var_.actorSpriteComps1086 then
				for iter_112_6, iter_112_7 in pairs(arg_109_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_112_7 then
						if arg_109_1.isInRecall_ then
							iter_112_7.color = arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_112_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps1086 = nil
			end

			local var_112_16 = arg_109_1.actors_["1080"].transform
			local var_112_17 = 0

			if var_112_17 < arg_109_1.time_ and arg_109_1.time_ <= var_112_17 + arg_112_0 then
				arg_109_1.var_.moveOldPos1080 = var_112_16.localPosition
				var_112_16.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("1080", 4)

				local var_112_18 = var_112_16.childCount

				for iter_112_8 = 0, var_112_18 - 1 do
					local var_112_19 = var_112_16:GetChild(iter_112_8)

					if var_112_19.name == "" or not string.find(var_112_19.name, "split") then
						var_112_19.gameObject:SetActive(true)
					else
						var_112_19.gameObject:SetActive(false)
					end
				end
			end

			local var_112_20 = 0.001

			if var_112_17 <= arg_109_1.time_ and arg_109_1.time_ < var_112_17 + var_112_20 then
				local var_112_21 = (arg_109_1.time_ - var_112_17) / var_112_20
				local var_112_22 = Vector3.New(390, -378, -170)

				var_112_16.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1080, var_112_22, var_112_21)
			end

			if arg_109_1.time_ >= var_112_17 + var_112_20 and arg_109_1.time_ < var_112_17 + var_112_20 + arg_112_0 then
				var_112_16.localPosition = Vector3.New(390, -378, -170)
			end

			local var_112_23 = 0
			local var_112_24 = 1.075

			if var_112_23 < arg_109_1.time_ and arg_109_1.time_ <= var_112_23 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_25 = arg_109_1:FormatText(StoryNameCfg[55].name)

				arg_109_1.leftNameTxt_.text = var_112_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_26 = arg_109_1:GetWordFromCfg(425032027)
				local var_112_27 = arg_109_1:FormatText(var_112_26.content)

				arg_109_1.text_.text = var_112_27

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_28 = 43
				local var_112_29 = utf8.len(var_112_27)
				local var_112_30 = var_112_28 <= 0 and var_112_24 or var_112_24 * (var_112_29 / var_112_28)

				if var_112_30 > 0 and var_112_24 < var_112_30 then
					arg_109_1.talkMaxDuration = var_112_30

					if var_112_30 + var_112_23 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_30 + var_112_23
					end
				end

				arg_109_1.text_.text = var_112_27
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032027", "story_v_out_425032.awb") ~= 0 then
					local var_112_31 = manager.audio:GetVoiceLength("story_v_out_425032", "425032027", "story_v_out_425032.awb") / 1000

					if var_112_31 + var_112_23 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_31 + var_112_23
					end

					if var_112_26.prefab_name ~= "" and arg_109_1.actors_[var_112_26.prefab_name] ~= nil then
						local var_112_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_26.prefab_name].transform, "story_v_out_425032", "425032027", "story_v_out_425032.awb")

						arg_109_1:RecordAudio("425032027", var_112_32)
						arg_109_1:RecordAudio("425032027", var_112_32)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_425032", "425032027", "story_v_out_425032.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_425032", "425032027", "story_v_out_425032.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_33 = math.max(var_112_24, arg_109_1.talkMaxDuration)

			if var_112_23 <= arg_109_1.time_ and arg_109_1.time_ < var_112_23 + var_112_33 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_23) / var_112_33

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_23 + var_112_33 and arg_109_1.time_ < var_112_23 + var_112_33 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play425032028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 425032028
		arg_113_1.duration_ = 6.13

		local var_113_0 = {
			zh = 6.1,
			ja = 6.133
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play425032029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1086"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps1086 == nil then
				arg_113_1.var_.actorSpriteComps1086 = var_116_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_2 = 0.2

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.actorSpriteComps1086 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_116_1 then
							if arg_113_1.isInRecall_ then
								local var_116_4 = Mathf.Lerp(iter_116_1.color.r, arg_113_1.hightColor1.r, var_116_3)
								local var_116_5 = Mathf.Lerp(iter_116_1.color.g, arg_113_1.hightColor1.g, var_116_3)
								local var_116_6 = Mathf.Lerp(iter_116_1.color.b, arg_113_1.hightColor1.b, var_116_3)

								iter_116_1.color = Color.New(var_116_4, var_116_5, var_116_6)
							else
								local var_116_7 = Mathf.Lerp(iter_116_1.color.r, 1, var_116_3)

								iter_116_1.color = Color.New(var_116_7, var_116_7, var_116_7)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps1086 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_116_3 then
						if arg_113_1.isInRecall_ then
							iter_116_3.color = arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_116_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps1086 = nil
			end

			local var_116_8 = arg_113_1.actors_["1080"]
			local var_116_9 = 0

			if var_116_9 < arg_113_1.time_ and arg_113_1.time_ <= var_116_9 + arg_116_0 and not isNil(var_116_8) and arg_113_1.var_.actorSpriteComps1080 == nil then
				arg_113_1.var_.actorSpriteComps1080 = var_116_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_10 = 0.2

			if var_116_9 <= arg_113_1.time_ and arg_113_1.time_ < var_116_9 + var_116_10 and not isNil(var_116_8) then
				local var_116_11 = (arg_113_1.time_ - var_116_9) / var_116_10

				if arg_113_1.var_.actorSpriteComps1080 then
					for iter_116_4, iter_116_5 in pairs(arg_113_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_116_5 then
							if arg_113_1.isInRecall_ then
								local var_116_12 = Mathf.Lerp(iter_116_5.color.r, arg_113_1.hightColor2.r, var_116_11)
								local var_116_13 = Mathf.Lerp(iter_116_5.color.g, arg_113_1.hightColor2.g, var_116_11)
								local var_116_14 = Mathf.Lerp(iter_116_5.color.b, arg_113_1.hightColor2.b, var_116_11)

								iter_116_5.color = Color.New(var_116_12, var_116_13, var_116_14)
							else
								local var_116_15 = Mathf.Lerp(iter_116_5.color.r, 0.5, var_116_11)

								iter_116_5.color = Color.New(var_116_15, var_116_15, var_116_15)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_9 + var_116_10 and arg_113_1.time_ < var_116_9 + var_116_10 + arg_116_0 and not isNil(var_116_8) and arg_113_1.var_.actorSpriteComps1080 then
				for iter_116_6, iter_116_7 in pairs(arg_113_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_116_7 then
						if arg_113_1.isInRecall_ then
							iter_116_7.color = arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_116_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps1080 = nil
			end

			local var_116_16 = arg_113_1.actors_["1086"].transform
			local var_116_17 = 0

			if var_116_17 < arg_113_1.time_ and arg_113_1.time_ <= var_116_17 + arg_116_0 then
				arg_113_1.var_.moveOldPos1086 = var_116_16.localPosition
				var_116_16.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("1086", 2)

				local var_116_18 = var_116_16.childCount

				for iter_116_8 = 0, var_116_18 - 1 do
					local var_116_19 = var_116_16:GetChild(iter_116_8)

					if var_116_19.name == "" or not string.find(var_116_19.name, "split") then
						var_116_19.gameObject:SetActive(true)
					else
						var_116_19.gameObject:SetActive(false)
					end
				end
			end

			local var_116_20 = 0.001

			if var_116_17 <= arg_113_1.time_ and arg_113_1.time_ < var_116_17 + var_116_20 then
				local var_116_21 = (arg_113_1.time_ - var_116_17) / var_116_20
				local var_116_22 = Vector3.New(-390, -404.2, -237.9)

				var_116_16.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1086, var_116_22, var_116_21)
			end

			if arg_113_1.time_ >= var_116_17 + var_116_20 and arg_113_1.time_ < var_116_17 + var_116_20 + arg_116_0 then
				var_116_16.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_116_23 = 0
			local var_116_24 = 0.725

			if var_116_23 < arg_113_1.time_ and arg_113_1.time_ <= var_116_23 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_25 = arg_113_1:FormatText(StoryNameCfg[1080].name)

				arg_113_1.leftNameTxt_.text = var_116_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_26 = arg_113_1:GetWordFromCfg(425032028)
				local var_116_27 = arg_113_1:FormatText(var_116_26.content)

				arg_113_1.text_.text = var_116_27

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_28 = 29
				local var_116_29 = utf8.len(var_116_27)
				local var_116_30 = var_116_28 <= 0 and var_116_24 or var_116_24 * (var_116_29 / var_116_28)

				if var_116_30 > 0 and var_116_24 < var_116_30 then
					arg_113_1.talkMaxDuration = var_116_30

					if var_116_30 + var_116_23 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_30 + var_116_23
					end
				end

				arg_113_1.text_.text = var_116_27
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032028", "story_v_out_425032.awb") ~= 0 then
					local var_116_31 = manager.audio:GetVoiceLength("story_v_out_425032", "425032028", "story_v_out_425032.awb") / 1000

					if var_116_31 + var_116_23 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_31 + var_116_23
					end

					if var_116_26.prefab_name ~= "" and arg_113_1.actors_[var_116_26.prefab_name] ~= nil then
						local var_116_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_26.prefab_name].transform, "story_v_out_425032", "425032028", "story_v_out_425032.awb")

						arg_113_1:RecordAudio("425032028", var_116_32)
						arg_113_1:RecordAudio("425032028", var_116_32)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_425032", "425032028", "story_v_out_425032.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_425032", "425032028", "story_v_out_425032.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_33 = math.max(var_116_24, arg_113_1.talkMaxDuration)

			if var_116_23 <= arg_113_1.time_ and arg_113_1.time_ < var_116_23 + var_116_33 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_23) / var_116_33

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_23 + var_116_33 and arg_113_1.time_ < var_116_23 + var_116_33 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
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

		arg_113_1:InitPlayNodeList()
	end,
	Play425032029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 425032029
		arg_117_1.duration_ = 8

		local var_117_0 = {
			zh = 5.833,
			ja = 8
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
				arg_117_0:Play425032030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1086"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos1086 = var_120_0.localPosition
				var_120_0.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("1086", 2)

				local var_120_2 = var_120_0.childCount

				for iter_120_0 = 0, var_120_2 - 1 do
					local var_120_3 = var_120_0:GetChild(iter_120_0)

					if var_120_3.name == "" or not string.find(var_120_3.name, "split") then
						var_120_3.gameObject:SetActive(true)
					else
						var_120_3.gameObject:SetActive(false)
					end
				end
			end

			local var_120_4 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_4 then
				local var_120_5 = (arg_117_1.time_ - var_120_1) / var_120_4
				local var_120_6 = Vector3.New(-390, -404.2, -237.9)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1086, var_120_6, var_120_5)
			end

			if arg_117_1.time_ >= var_120_1 + var_120_4 and arg_117_1.time_ < var_120_1 + var_120_4 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_120_7 = 0
			local var_120_8 = 0.8

			if var_120_7 < arg_117_1.time_ and arg_117_1.time_ <= var_120_7 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_9 = arg_117_1:FormatText(StoryNameCfg[1080].name)

				arg_117_1.leftNameTxt_.text = var_120_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_10 = arg_117_1:GetWordFromCfg(425032029)
				local var_120_11 = arg_117_1:FormatText(var_120_10.content)

				arg_117_1.text_.text = var_120_11

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_12 = 32
				local var_120_13 = utf8.len(var_120_11)
				local var_120_14 = var_120_12 <= 0 and var_120_8 or var_120_8 * (var_120_13 / var_120_12)

				if var_120_14 > 0 and var_120_8 < var_120_14 then
					arg_117_1.talkMaxDuration = var_120_14

					if var_120_14 + var_120_7 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_14 + var_120_7
					end
				end

				arg_117_1.text_.text = var_120_11
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032029", "story_v_out_425032.awb") ~= 0 then
					local var_120_15 = manager.audio:GetVoiceLength("story_v_out_425032", "425032029", "story_v_out_425032.awb") / 1000

					if var_120_15 + var_120_7 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_15 + var_120_7
					end

					if var_120_10.prefab_name ~= "" and arg_117_1.actors_[var_120_10.prefab_name] ~= nil then
						local var_120_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_10.prefab_name].transform, "story_v_out_425032", "425032029", "story_v_out_425032.awb")

						arg_117_1:RecordAudio("425032029", var_120_16)
						arg_117_1:RecordAudio("425032029", var_120_16)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_425032", "425032029", "story_v_out_425032.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_425032", "425032029", "story_v_out_425032.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_17 = math.max(var_120_8, arg_117_1.talkMaxDuration)

			if var_120_7 <= arg_117_1.time_ and arg_117_1.time_ < var_120_7 + var_120_17 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_7) / var_120_17

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_7 + var_120_17 and arg_117_1.time_ < var_120_7 + var_120_17 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play425032030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 425032030
		arg_121_1.duration_ = 9

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play425032031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 4

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.allBtn_.enabled = false
			end

			local var_124_1 = 0.3

			if arg_121_1.time_ >= var_124_0 + var_124_1 and arg_121_1.time_ < var_124_0 + var_124_1 + arg_124_0 then
				arg_121_1.allBtn_.enabled = true
			end

			local var_124_2 = "ST2108"

			if arg_121_1.bgs_[var_124_2] == nil then
				local var_124_3 = Object.Instantiate(arg_121_1.paintGo_)

				var_124_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_124_2)
				var_124_3.name = var_124_2
				var_124_3.transform.parent = arg_121_1.stage_.transform
				var_124_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.bgs_[var_124_2] = var_124_3
			end

			local var_124_4 = 2

			if var_124_4 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				local var_124_5 = manager.ui.mainCamera.transform.localPosition
				local var_124_6 = Vector3.New(0, 0, 10) + Vector3.New(var_124_5.x, var_124_5.y, 0)
				local var_124_7 = arg_121_1.bgs_.ST2108

				var_124_7.transform.localPosition = var_124_6
				var_124_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_124_8 = var_124_7:GetComponent("SpriteRenderer")

				if var_124_8 and var_124_8.sprite then
					local var_124_9 = (var_124_7.transform.localPosition - var_124_5).z
					local var_124_10 = manager.ui.mainCameraCom_
					local var_124_11 = 2 * var_124_9 * Mathf.Tan(var_124_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_124_12 = var_124_11 * var_124_10.aspect
					local var_124_13 = var_124_8.sprite.bounds.size.x
					local var_124_14 = var_124_8.sprite.bounds.size.y
					local var_124_15 = var_124_12 / var_124_13
					local var_124_16 = var_124_11 / var_124_14
					local var_124_17 = var_124_16 < var_124_15 and var_124_15 or var_124_16

					var_124_7.transform.localScale = Vector3.New(var_124_17, var_124_17, 0)
				end

				for iter_124_0, iter_124_1 in pairs(arg_121_1.bgs_) do
					if iter_124_0 ~= "ST2108" then
						iter_124_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_124_18 = 0

			if var_124_18 < arg_121_1.time_ and arg_121_1.time_ <= var_124_18 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_19 = 2

			if var_124_18 <= arg_121_1.time_ and arg_121_1.time_ < var_124_18 + var_124_19 then
				local var_124_20 = (arg_121_1.time_ - var_124_18) / var_124_19
				local var_124_21 = Color.New(0, 0, 0)

				var_124_21.a = Mathf.Lerp(0, 1, var_124_20)
				arg_121_1.mask_.color = var_124_21
			end

			if arg_121_1.time_ >= var_124_18 + var_124_19 and arg_121_1.time_ < var_124_18 + var_124_19 + arg_124_0 then
				local var_124_22 = Color.New(0, 0, 0)

				var_124_22.a = 1
				arg_121_1.mask_.color = var_124_22
			end

			local var_124_23 = 2

			if var_124_23 < arg_121_1.time_ and arg_121_1.time_ <= var_124_23 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_24 = 2

			if var_124_23 <= arg_121_1.time_ and arg_121_1.time_ < var_124_23 + var_124_24 then
				local var_124_25 = (arg_121_1.time_ - var_124_23) / var_124_24
				local var_124_26 = Color.New(0, 0, 0)

				var_124_26.a = Mathf.Lerp(1, 0, var_124_25)
				arg_121_1.mask_.color = var_124_26
			end

			if arg_121_1.time_ >= var_124_23 + var_124_24 and arg_121_1.time_ < var_124_23 + var_124_24 + arg_124_0 then
				local var_124_27 = Color.New(0, 0, 0)
				local var_124_28 = 0

				arg_121_1.mask_.enabled = false
				var_124_27.a = var_124_28
				arg_121_1.mask_.color = var_124_27
			end

			local var_124_29 = arg_121_1.actors_["1086"].transform
			local var_124_30 = 2

			if var_124_30 < arg_121_1.time_ and arg_121_1.time_ <= var_124_30 + arg_124_0 then
				arg_121_1.var_.moveOldPos1086 = var_124_29.localPosition
				var_124_29.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("1086", 7)

				local var_124_31 = var_124_29.childCount

				for iter_124_2 = 0, var_124_31 - 1 do
					local var_124_32 = var_124_29:GetChild(iter_124_2)

					if var_124_32.name == "" or not string.find(var_124_32.name, "split") then
						var_124_32.gameObject:SetActive(true)
					else
						var_124_32.gameObject:SetActive(false)
					end
				end
			end

			local var_124_33 = 0.001

			if var_124_30 <= arg_121_1.time_ and arg_121_1.time_ < var_124_30 + var_124_33 then
				local var_124_34 = (arg_121_1.time_ - var_124_30) / var_124_33
				local var_124_35 = Vector3.New(0, -2000, 0)

				var_124_29.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1086, var_124_35, var_124_34)
			end

			if arg_121_1.time_ >= var_124_30 + var_124_33 and arg_121_1.time_ < var_124_30 + var_124_33 + arg_124_0 then
				var_124_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_124_36 = arg_121_1.actors_["1080"].transform
			local var_124_37 = 2

			if var_124_37 < arg_121_1.time_ and arg_121_1.time_ <= var_124_37 + arg_124_0 then
				arg_121_1.var_.moveOldPos1080 = var_124_36.localPosition
				var_124_36.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("1080", 7)

				local var_124_38 = var_124_36.childCount

				for iter_124_3 = 0, var_124_38 - 1 do
					local var_124_39 = var_124_36:GetChild(iter_124_3)

					if var_124_39.name == "" or not string.find(var_124_39.name, "split") then
						var_124_39.gameObject:SetActive(true)
					else
						var_124_39.gameObject:SetActive(false)
					end
				end
			end

			local var_124_40 = 0.001

			if var_124_37 <= arg_121_1.time_ and arg_121_1.time_ < var_124_37 + var_124_40 then
				local var_124_41 = (arg_121_1.time_ - var_124_37) / var_124_40
				local var_124_42 = Vector3.New(0, -2000, 0)

				var_124_36.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1080, var_124_42, var_124_41)
			end

			if arg_121_1.time_ >= var_124_37 + var_124_40 and arg_121_1.time_ < var_124_37 + var_124_40 + arg_124_0 then
				var_124_36.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_124_43 = 1.53333333333333
			local var_124_44 = 1

			if var_124_43 < arg_121_1.time_ and arg_121_1.time_ <= var_124_43 + arg_124_0 then
				local var_124_45 = "stop"
				local var_124_46 = "effect"

				arg_121_1:AudioAction(var_124_45, var_124_46, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			local var_124_47 = 1.53333333333333
			local var_124_48 = 1

			if var_124_47 < arg_121_1.time_ and arg_121_1.time_ <= var_124_47 + arg_124_0 then
				local var_124_49 = "play"
				local var_124_50 = "effect"

				arg_121_1:AudioAction(var_124_49, var_124_50, "se_story_142", "se_story_142_amb_commandroom", "")
			end

			local var_124_51 = 4
			local var_124_52 = 1

			if var_124_51 < arg_121_1.time_ and arg_121_1.time_ <= var_124_51 + arg_124_0 then
				local var_124_53 = "play"
				local var_124_54 = "effect"

				arg_121_1:AudioAction(var_124_53, var_124_54, "se_story_1310", "se_story_1310_clap", "")
			end

			if arg_121_1.frameCnt_ <= 1 then
				arg_121_1.dialog_:SetActive(false)
			end

			local var_124_55 = 4
			local var_124_56 = 0.6

			if var_124_55 < arg_121_1.time_ and arg_121_1.time_ <= var_124_55 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_57 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_57:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_58 = arg_121_1:GetWordFromCfg(425032030)
				local var_124_59 = arg_121_1:FormatText(var_124_58.content)

				arg_121_1.text_.text = var_124_59

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_60 = 24
				local var_124_61 = utf8.len(var_124_59)
				local var_124_62 = var_124_60 <= 0 and var_124_56 or var_124_56 * (var_124_61 / var_124_60)

				if var_124_62 > 0 and var_124_56 < var_124_62 then
					arg_121_1.talkMaxDuration = var_124_62
					var_124_55 = var_124_55 + 0.3

					if var_124_62 + var_124_55 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_62 + var_124_55
					end
				end

				arg_121_1.text_.text = var_124_59
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_63 = var_124_55 + 0.3
			local var_124_64 = math.max(var_124_56, arg_121_1.talkMaxDuration)

			if var_124_63 <= arg_121_1.time_ and arg_121_1.time_ < var_124_63 + var_124_64 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_63) / var_124_64

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_63 + var_124_64 and arg_121_1.time_ < var_124_63 + var_124_64 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play425032031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 425032031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play425032032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 1.3

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_2 = arg_127_1:GetWordFromCfg(425032031)
				local var_130_3 = arg_127_1:FormatText(var_130_2.content)

				arg_127_1.text_.text = var_130_3

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 52
				local var_130_5 = utf8.len(var_130_3)
				local var_130_6 = var_130_4 <= 0 and var_130_1 or var_130_1 * (var_130_5 / var_130_4)

				if var_130_6 > 0 and var_130_1 < var_130_6 then
					arg_127_1.talkMaxDuration = var_130_6

					if var_130_6 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_6 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_3
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_7 and arg_127_1.time_ < var_130_0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play425032032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 425032032
		arg_131_1.duration_ = 11

		local var_131_0 = {
			zh = 10.133,
			ja = 11
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
				arg_131_0:Play425032033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1086"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps1086 == nil then
				arg_131_1.var_.actorSpriteComps1086 = var_134_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_2 = 0.2

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.actorSpriteComps1086 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_134_1 then
							if arg_131_1.isInRecall_ then
								local var_134_4 = Mathf.Lerp(iter_134_1.color.r, arg_131_1.hightColor1.r, var_134_3)
								local var_134_5 = Mathf.Lerp(iter_134_1.color.g, arg_131_1.hightColor1.g, var_134_3)
								local var_134_6 = Mathf.Lerp(iter_134_1.color.b, arg_131_1.hightColor1.b, var_134_3)

								iter_134_1.color = Color.New(var_134_4, var_134_5, var_134_6)
							else
								local var_134_7 = Mathf.Lerp(iter_134_1.color.r, 1, var_134_3)

								iter_134_1.color = Color.New(var_134_7, var_134_7, var_134_7)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps1086 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_134_3 then
						if arg_131_1.isInRecall_ then
							iter_134_3.color = arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_134_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps1086 = nil
			end

			local var_134_8 = arg_131_1.actors_["1086"].transform
			local var_134_9 = 0

			if var_134_9 < arg_131_1.time_ and arg_131_1.time_ <= var_134_9 + arg_134_0 then
				arg_131_1.var_.moveOldPos1086 = var_134_8.localPosition
				var_134_8.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("1086", 3)

				local var_134_10 = var_134_8.childCount

				for iter_134_4 = 0, var_134_10 - 1 do
					local var_134_11 = var_134_8:GetChild(iter_134_4)

					if var_134_11.name == "" or not string.find(var_134_11.name, "split") then
						var_134_11.gameObject:SetActive(true)
					else
						var_134_11.gameObject:SetActive(false)
					end
				end
			end

			local var_134_12 = 0.001

			if var_134_9 <= arg_131_1.time_ and arg_131_1.time_ < var_134_9 + var_134_12 then
				local var_134_13 = (arg_131_1.time_ - var_134_9) / var_134_12
				local var_134_14 = Vector3.New(0, -404.2, -237.9)

				var_134_8.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1086, var_134_14, var_134_13)
			end

			if arg_131_1.time_ >= var_134_9 + var_134_12 and arg_131_1.time_ < var_134_9 + var_134_12 + arg_134_0 then
				var_134_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_134_15 = 0
			local var_134_16 = 1.3

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_17 = arg_131_1:FormatText(StoryNameCfg[1080].name)

				arg_131_1.leftNameTxt_.text = var_134_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_18 = arg_131_1:GetWordFromCfg(425032032)
				local var_134_19 = arg_131_1:FormatText(var_134_18.content)

				arg_131_1.text_.text = var_134_19

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_20 = 52
				local var_134_21 = utf8.len(var_134_19)
				local var_134_22 = var_134_20 <= 0 and var_134_16 or var_134_16 * (var_134_21 / var_134_20)

				if var_134_22 > 0 and var_134_16 < var_134_22 then
					arg_131_1.talkMaxDuration = var_134_22

					if var_134_22 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_22 + var_134_15
					end
				end

				arg_131_1.text_.text = var_134_19
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032032", "story_v_out_425032.awb") ~= 0 then
					local var_134_23 = manager.audio:GetVoiceLength("story_v_out_425032", "425032032", "story_v_out_425032.awb") / 1000

					if var_134_23 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_23 + var_134_15
					end

					if var_134_18.prefab_name ~= "" and arg_131_1.actors_[var_134_18.prefab_name] ~= nil then
						local var_134_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_18.prefab_name].transform, "story_v_out_425032", "425032032", "story_v_out_425032.awb")

						arg_131_1:RecordAudio("425032032", var_134_24)
						arg_131_1:RecordAudio("425032032", var_134_24)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_425032", "425032032", "story_v_out_425032.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_425032", "425032032", "story_v_out_425032.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_25 = math.max(var_134_16, arg_131_1.talkMaxDuration)

			if var_134_15 <= arg_131_1.time_ and arg_131_1.time_ < var_134_15 + var_134_25 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_15) / var_134_25

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_15 + var_134_25 and arg_131_1.time_ < var_134_15 + var_134_25 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
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

		arg_131_1:InitPlayNodeList()
	end,
	Play425032033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 425032033
		arg_135_1.duration_ = 10.8

		local var_135_0 = {
			zh = 9.966,
			ja = 10.8
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
				arg_135_0:Play425032034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 1.325

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[1080].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_3 = arg_135_1:GetWordFromCfg(425032033)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 53
				local var_138_6 = utf8.len(var_138_4)
				local var_138_7 = var_138_5 <= 0 and var_138_1 or var_138_1 * (var_138_6 / var_138_5)

				if var_138_7 > 0 and var_138_1 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032033", "story_v_out_425032.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_425032", "425032033", "story_v_out_425032.awb") / 1000

					if var_138_8 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_0
					end

					if var_138_3.prefab_name ~= "" and arg_135_1.actors_[var_138_3.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_3.prefab_name].transform, "story_v_out_425032", "425032033", "story_v_out_425032.awb")

						arg_135_1:RecordAudio("425032033", var_138_9)
						arg_135_1:RecordAudio("425032033", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_425032", "425032033", "story_v_out_425032.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_425032", "425032033", "story_v_out_425032.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_10 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_10 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_10

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_10 and arg_135_1.time_ < var_138_0 + var_138_10 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play425032034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 425032034
		arg_139_1.duration_ = 5.3

		local var_139_0 = {
			zh = 5.3,
			ja = 3.7
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play425032035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 0.65

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[1080].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_3 = arg_139_1:GetWordFromCfg(425032034)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 26
				local var_142_6 = utf8.len(var_142_4)
				local var_142_7 = var_142_5 <= 0 and var_142_1 or var_142_1 * (var_142_6 / var_142_5)

				if var_142_7 > 0 and var_142_1 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032034", "story_v_out_425032.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_out_425032", "425032034", "story_v_out_425032.awb") / 1000

					if var_142_8 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_0
					end

					if var_142_3.prefab_name ~= "" and arg_139_1.actors_[var_142_3.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_3.prefab_name].transform, "story_v_out_425032", "425032034", "story_v_out_425032.awb")

						arg_139_1:RecordAudio("425032034", var_142_9)
						arg_139_1:RecordAudio("425032034", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_425032", "425032034", "story_v_out_425032.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_425032", "425032034", "story_v_out_425032.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_10 and arg_139_1.time_ < var_142_0 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play425032035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 425032035
		arg_143_1.duration_ = 16.27

		local var_143_0 = {
			zh = 8.566,
			ja = 16.266
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play425032036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1080"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.actorSpriteComps1080 == nil then
				arg_143_1.var_.actorSpriteComps1080 = var_146_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_2 = 0.2

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.actorSpriteComps1080 then
					for iter_146_0, iter_146_1 in pairs(arg_143_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_146_1 then
							if arg_143_1.isInRecall_ then
								local var_146_4 = Mathf.Lerp(iter_146_1.color.r, arg_143_1.hightColor1.r, var_146_3)
								local var_146_5 = Mathf.Lerp(iter_146_1.color.g, arg_143_1.hightColor1.g, var_146_3)
								local var_146_6 = Mathf.Lerp(iter_146_1.color.b, arg_143_1.hightColor1.b, var_146_3)

								iter_146_1.color = Color.New(var_146_4, var_146_5, var_146_6)
							else
								local var_146_7 = Mathf.Lerp(iter_146_1.color.r, 1, var_146_3)

								iter_146_1.color = Color.New(var_146_7, var_146_7, var_146_7)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.actorSpriteComps1080 then
				for iter_146_2, iter_146_3 in pairs(arg_143_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_146_3 then
						if arg_143_1.isInRecall_ then
							iter_146_3.color = arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_146_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps1080 = nil
			end

			local var_146_8 = arg_143_1.actors_["1086"]
			local var_146_9 = 0

			if var_146_9 < arg_143_1.time_ and arg_143_1.time_ <= var_146_9 + arg_146_0 and not isNil(var_146_8) and arg_143_1.var_.actorSpriteComps1086 == nil then
				arg_143_1.var_.actorSpriteComps1086 = var_146_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_10 = 0.2

			if var_146_9 <= arg_143_1.time_ and arg_143_1.time_ < var_146_9 + var_146_10 and not isNil(var_146_8) then
				local var_146_11 = (arg_143_1.time_ - var_146_9) / var_146_10

				if arg_143_1.var_.actorSpriteComps1086 then
					for iter_146_4, iter_146_5 in pairs(arg_143_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_146_5 then
							if arg_143_1.isInRecall_ then
								local var_146_12 = Mathf.Lerp(iter_146_5.color.r, arg_143_1.hightColor2.r, var_146_11)
								local var_146_13 = Mathf.Lerp(iter_146_5.color.g, arg_143_1.hightColor2.g, var_146_11)
								local var_146_14 = Mathf.Lerp(iter_146_5.color.b, arg_143_1.hightColor2.b, var_146_11)

								iter_146_5.color = Color.New(var_146_12, var_146_13, var_146_14)
							else
								local var_146_15 = Mathf.Lerp(iter_146_5.color.r, 0.5, var_146_11)

								iter_146_5.color = Color.New(var_146_15, var_146_15, var_146_15)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= var_146_9 + var_146_10 and arg_143_1.time_ < var_146_9 + var_146_10 + arg_146_0 and not isNil(var_146_8) and arg_143_1.var_.actorSpriteComps1086 then
				for iter_146_6, iter_146_7 in pairs(arg_143_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_146_7 then
						if arg_143_1.isInRecall_ then
							iter_146_7.color = arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_146_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps1086 = nil
			end

			local var_146_16 = arg_143_1.actors_["1080"].transform
			local var_146_17 = 0

			if var_146_17 < arg_143_1.time_ and arg_143_1.time_ <= var_146_17 + arg_146_0 then
				arg_143_1.var_.moveOldPos1080 = var_146_16.localPosition
				var_146_16.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("1080", 4)

				local var_146_18 = var_146_16.childCount

				for iter_146_8 = 0, var_146_18 - 1 do
					local var_146_19 = var_146_16:GetChild(iter_146_8)

					if var_146_19.name == "" or not string.find(var_146_19.name, "split") then
						var_146_19.gameObject:SetActive(true)
					else
						var_146_19.gameObject:SetActive(false)
					end
				end
			end

			local var_146_20 = 0.001

			if var_146_17 <= arg_143_1.time_ and arg_143_1.time_ < var_146_17 + var_146_20 then
				local var_146_21 = (arg_143_1.time_ - var_146_17) / var_146_20
				local var_146_22 = Vector3.New(390, -378, -170)

				var_146_16.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1080, var_146_22, var_146_21)
			end

			if arg_143_1.time_ >= var_146_17 + var_146_20 and arg_143_1.time_ < var_146_17 + var_146_20 + arg_146_0 then
				var_146_16.localPosition = Vector3.New(390, -378, -170)
			end

			local var_146_23 = arg_143_1.actors_["1086"].transform
			local var_146_24 = 0

			if var_146_24 < arg_143_1.time_ and arg_143_1.time_ <= var_146_24 + arg_146_0 then
				arg_143_1.var_.moveOldPos1086 = var_146_23.localPosition
				var_146_23.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("1086", 2)

				local var_146_25 = var_146_23.childCount

				for iter_146_9 = 0, var_146_25 - 1 do
					local var_146_26 = var_146_23:GetChild(iter_146_9)

					if var_146_26.name == "" or not string.find(var_146_26.name, "split") then
						var_146_26.gameObject:SetActive(true)
					else
						var_146_26.gameObject:SetActive(false)
					end
				end
			end

			local var_146_27 = 0.001

			if var_146_24 <= arg_143_1.time_ and arg_143_1.time_ < var_146_24 + var_146_27 then
				local var_146_28 = (arg_143_1.time_ - var_146_24) / var_146_27
				local var_146_29 = Vector3.New(-390, -404.2, -237.9)

				var_146_23.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1086, var_146_29, var_146_28)
			end

			if arg_143_1.time_ >= var_146_24 + var_146_27 and arg_143_1.time_ < var_146_24 + var_146_27 + arg_146_0 then
				var_146_23.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_146_30 = 0
			local var_146_31 = 1.05

			if var_146_30 < arg_143_1.time_ and arg_143_1.time_ <= var_146_30 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_32 = arg_143_1:FormatText(StoryNameCfg[55].name)

				arg_143_1.leftNameTxt_.text = var_146_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_33 = arg_143_1:GetWordFromCfg(425032035)
				local var_146_34 = arg_143_1:FormatText(var_146_33.content)

				arg_143_1.text_.text = var_146_34

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_35 = 42
				local var_146_36 = utf8.len(var_146_34)
				local var_146_37 = var_146_35 <= 0 and var_146_31 or var_146_31 * (var_146_36 / var_146_35)

				if var_146_37 > 0 and var_146_31 < var_146_37 then
					arg_143_1.talkMaxDuration = var_146_37

					if var_146_37 + var_146_30 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_37 + var_146_30
					end
				end

				arg_143_1.text_.text = var_146_34
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032035", "story_v_out_425032.awb") ~= 0 then
					local var_146_38 = manager.audio:GetVoiceLength("story_v_out_425032", "425032035", "story_v_out_425032.awb") / 1000

					if var_146_38 + var_146_30 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_38 + var_146_30
					end

					if var_146_33.prefab_name ~= "" and arg_143_1.actors_[var_146_33.prefab_name] ~= nil then
						local var_146_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_33.prefab_name].transform, "story_v_out_425032", "425032035", "story_v_out_425032.awb")

						arg_143_1:RecordAudio("425032035", var_146_39)
						arg_143_1:RecordAudio("425032035", var_146_39)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_425032", "425032035", "story_v_out_425032.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_425032", "425032035", "story_v_out_425032.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_40 = math.max(var_146_31, arg_143_1.talkMaxDuration)

			if var_146_30 <= arg_143_1.time_ and arg_143_1.time_ < var_146_30 + var_146_40 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_30) / var_146_40

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_30 + var_146_40 and arg_143_1.time_ < var_146_30 + var_146_40 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
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

		arg_143_1:InitPlayNodeList()
	end,
	Play425032036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 425032036
		arg_147_1.duration_ = 10.9

		local var_147_0 = {
			zh = 7.8,
			ja = 10.9
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
				arg_147_0:Play425032037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1086"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.actorSpriteComps1086 == nil then
				arg_147_1.var_.actorSpriteComps1086 = var_150_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_2 = 0.2

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.actorSpriteComps1086 then
					for iter_150_0, iter_150_1 in pairs(arg_147_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_150_1 then
							if arg_147_1.isInRecall_ then
								local var_150_4 = Mathf.Lerp(iter_150_1.color.r, arg_147_1.hightColor1.r, var_150_3)
								local var_150_5 = Mathf.Lerp(iter_150_1.color.g, arg_147_1.hightColor1.g, var_150_3)
								local var_150_6 = Mathf.Lerp(iter_150_1.color.b, arg_147_1.hightColor1.b, var_150_3)

								iter_150_1.color = Color.New(var_150_4, var_150_5, var_150_6)
							else
								local var_150_7 = Mathf.Lerp(iter_150_1.color.r, 1, var_150_3)

								iter_150_1.color = Color.New(var_150_7, var_150_7, var_150_7)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.actorSpriteComps1086 then
				for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_150_3 then
						if arg_147_1.isInRecall_ then
							iter_150_3.color = arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_150_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps1086 = nil
			end

			local var_150_8 = arg_147_1.actors_["1080"]
			local var_150_9 = 0

			if var_150_9 < arg_147_1.time_ and arg_147_1.time_ <= var_150_9 + arg_150_0 and not isNil(var_150_8) and arg_147_1.var_.actorSpriteComps1080 == nil then
				arg_147_1.var_.actorSpriteComps1080 = var_150_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_10 = 0.2

			if var_150_9 <= arg_147_1.time_ and arg_147_1.time_ < var_150_9 + var_150_10 and not isNil(var_150_8) then
				local var_150_11 = (arg_147_1.time_ - var_150_9) / var_150_10

				if arg_147_1.var_.actorSpriteComps1080 then
					for iter_150_4, iter_150_5 in pairs(arg_147_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_150_5 then
							if arg_147_1.isInRecall_ then
								local var_150_12 = Mathf.Lerp(iter_150_5.color.r, arg_147_1.hightColor2.r, var_150_11)
								local var_150_13 = Mathf.Lerp(iter_150_5.color.g, arg_147_1.hightColor2.g, var_150_11)
								local var_150_14 = Mathf.Lerp(iter_150_5.color.b, arg_147_1.hightColor2.b, var_150_11)

								iter_150_5.color = Color.New(var_150_12, var_150_13, var_150_14)
							else
								local var_150_15 = Mathf.Lerp(iter_150_5.color.r, 0.5, var_150_11)

								iter_150_5.color = Color.New(var_150_15, var_150_15, var_150_15)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_9 + var_150_10 and arg_147_1.time_ < var_150_9 + var_150_10 + arg_150_0 and not isNil(var_150_8) and arg_147_1.var_.actorSpriteComps1080 then
				for iter_150_6, iter_150_7 in pairs(arg_147_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_150_7 then
						if arg_147_1.isInRecall_ then
							iter_150_7.color = arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_150_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps1080 = nil
			end

			local var_150_16 = arg_147_1.actors_["1086"].transform
			local var_150_17 = 0

			if var_150_17 < arg_147_1.time_ and arg_147_1.time_ <= var_150_17 + arg_150_0 then
				arg_147_1.var_.moveOldPos1086 = var_150_16.localPosition
				var_150_16.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1086", 2)

				local var_150_18 = var_150_16.childCount

				for iter_150_8 = 0, var_150_18 - 1 do
					local var_150_19 = var_150_16:GetChild(iter_150_8)

					if var_150_19.name == "split_4" or not string.find(var_150_19.name, "split") then
						var_150_19.gameObject:SetActive(true)
					else
						var_150_19.gameObject:SetActive(false)
					end
				end
			end

			local var_150_20 = 0.001

			if var_150_17 <= arg_147_1.time_ and arg_147_1.time_ < var_150_17 + var_150_20 then
				local var_150_21 = (arg_147_1.time_ - var_150_17) / var_150_20
				local var_150_22 = Vector3.New(-390, -404.2, -237.9)

				var_150_16.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1086, var_150_22, var_150_21)
			end

			if arg_147_1.time_ >= var_150_17 + var_150_20 and arg_147_1.time_ < var_150_17 + var_150_20 + arg_150_0 then
				var_150_16.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_150_23 = 0
			local var_150_24 = 0.925

			if var_150_23 < arg_147_1.time_ and arg_147_1.time_ <= var_150_23 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_25 = arg_147_1:FormatText(StoryNameCfg[1080].name)

				arg_147_1.leftNameTxt_.text = var_150_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_26 = arg_147_1:GetWordFromCfg(425032036)
				local var_150_27 = arg_147_1:FormatText(var_150_26.content)

				arg_147_1.text_.text = var_150_27

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_28 = 37
				local var_150_29 = utf8.len(var_150_27)
				local var_150_30 = var_150_28 <= 0 and var_150_24 or var_150_24 * (var_150_29 / var_150_28)

				if var_150_30 > 0 and var_150_24 < var_150_30 then
					arg_147_1.talkMaxDuration = var_150_30

					if var_150_30 + var_150_23 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_30 + var_150_23
					end
				end

				arg_147_1.text_.text = var_150_27
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032036", "story_v_out_425032.awb") ~= 0 then
					local var_150_31 = manager.audio:GetVoiceLength("story_v_out_425032", "425032036", "story_v_out_425032.awb") / 1000

					if var_150_31 + var_150_23 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_31 + var_150_23
					end

					if var_150_26.prefab_name ~= "" and arg_147_1.actors_[var_150_26.prefab_name] ~= nil then
						local var_150_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_26.prefab_name].transform, "story_v_out_425032", "425032036", "story_v_out_425032.awb")

						arg_147_1:RecordAudio("425032036", var_150_32)
						arg_147_1:RecordAudio("425032036", var_150_32)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_425032", "425032036", "story_v_out_425032.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_425032", "425032036", "story_v_out_425032.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_33 = math.max(var_150_24, arg_147_1.talkMaxDuration)

			if var_150_23 <= arg_147_1.time_ and arg_147_1.time_ < var_150_23 + var_150_33 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_23) / var_150_33

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_23 + var_150_33 and arg_147_1.time_ < var_150_23 + var_150_33 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play425032037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 425032037
		arg_151_1.duration_ = 4.47

		local var_151_0 = {
			zh = 3.1,
			ja = 4.466
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play425032038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1137"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps1137 == nil then
				arg_151_1.var_.actorSpriteComps1137 = var_154_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_2 = 0.2

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.actorSpriteComps1137 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								local var_154_4 = Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor1.r, var_154_3)
								local var_154_5 = Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor1.g, var_154_3)
								local var_154_6 = Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor1.b, var_154_3)

								iter_154_1.color = Color.New(var_154_4, var_154_5, var_154_6)
							else
								local var_154_7 = Mathf.Lerp(iter_154_1.color.r, 1, var_154_3)

								iter_154_1.color = Color.New(var_154_7, var_154_7, var_154_7)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps1137 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_154_3 then
						if arg_151_1.isInRecall_ then
							iter_154_3.color = arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_154_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps1137 = nil
			end

			local var_154_8 = arg_151_1.actors_["1086"]
			local var_154_9 = 0

			if var_154_9 < arg_151_1.time_ and arg_151_1.time_ <= var_154_9 + arg_154_0 and not isNil(var_154_8) and arg_151_1.var_.actorSpriteComps1086 == nil then
				arg_151_1.var_.actorSpriteComps1086 = var_154_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_10 = 0.2

			if var_154_9 <= arg_151_1.time_ and arg_151_1.time_ < var_154_9 + var_154_10 and not isNil(var_154_8) then
				local var_154_11 = (arg_151_1.time_ - var_154_9) / var_154_10

				if arg_151_1.var_.actorSpriteComps1086 then
					for iter_154_4, iter_154_5 in pairs(arg_151_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_154_5 then
							if arg_151_1.isInRecall_ then
								local var_154_12 = Mathf.Lerp(iter_154_5.color.r, arg_151_1.hightColor2.r, var_154_11)
								local var_154_13 = Mathf.Lerp(iter_154_5.color.g, arg_151_1.hightColor2.g, var_154_11)
								local var_154_14 = Mathf.Lerp(iter_154_5.color.b, arg_151_1.hightColor2.b, var_154_11)

								iter_154_5.color = Color.New(var_154_12, var_154_13, var_154_14)
							else
								local var_154_15 = Mathf.Lerp(iter_154_5.color.r, 0.5, var_154_11)

								iter_154_5.color = Color.New(var_154_15, var_154_15, var_154_15)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= var_154_9 + var_154_10 and arg_151_1.time_ < var_154_9 + var_154_10 + arg_154_0 and not isNil(var_154_8) and arg_151_1.var_.actorSpriteComps1086 then
				for iter_154_6, iter_154_7 in pairs(arg_151_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_154_7 then
						if arg_151_1.isInRecall_ then
							iter_154_7.color = arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_154_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps1086 = nil
			end

			local var_154_16 = arg_151_1.actors_["1137"].transform
			local var_154_17 = 0

			if var_154_17 < arg_151_1.time_ and arg_151_1.time_ <= var_154_17 + arg_154_0 then
				arg_151_1.var_.moveOldPos1137 = var_154_16.localPosition
				var_154_16.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("1137", 2)

				local var_154_18 = var_154_16.childCount

				for iter_154_8 = 0, var_154_18 - 1 do
					local var_154_19 = var_154_16:GetChild(iter_154_8)

					if var_154_19.name == "split_4" or not string.find(var_154_19.name, "split") then
						var_154_19.gameObject:SetActive(true)
					else
						var_154_19.gameObject:SetActive(false)
					end
				end
			end

			local var_154_20 = 0.001

			if var_154_17 <= arg_151_1.time_ and arg_151_1.time_ < var_154_17 + var_154_20 then
				local var_154_21 = (arg_151_1.time_ - var_154_17) / var_154_20
				local var_154_22 = Vector3.New(-390, -425, -200)

				var_154_16.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1137, var_154_22, var_154_21)
			end

			if arg_151_1.time_ >= var_154_17 + var_154_20 and arg_151_1.time_ < var_154_17 + var_154_20 + arg_154_0 then
				var_154_16.localPosition = Vector3.New(-390, -425, -200)
			end

			local var_154_23 = arg_151_1.actors_["1086"].transform
			local var_154_24 = 0

			if var_154_24 < arg_151_1.time_ and arg_151_1.time_ <= var_154_24 + arg_154_0 then
				arg_151_1.var_.moveOldPos1086 = var_154_23.localPosition
				var_154_23.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("1086", 7)

				local var_154_25 = var_154_23.childCount

				for iter_154_9 = 0, var_154_25 - 1 do
					local var_154_26 = var_154_23:GetChild(iter_154_9)

					if var_154_26.name == "" or not string.find(var_154_26.name, "split") then
						var_154_26.gameObject:SetActive(true)
					else
						var_154_26.gameObject:SetActive(false)
					end
				end
			end

			local var_154_27 = 0.001

			if var_154_24 <= arg_151_1.time_ and arg_151_1.time_ < var_154_24 + var_154_27 then
				local var_154_28 = (arg_151_1.time_ - var_154_24) / var_154_27
				local var_154_29 = Vector3.New(0, -2000, 0)

				var_154_23.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1086, var_154_29, var_154_28)
			end

			if arg_151_1.time_ >= var_154_24 + var_154_27 and arg_151_1.time_ < var_154_24 + var_154_27 + arg_154_0 then
				var_154_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_154_30 = 0
			local var_154_31 = 0.275

			if var_154_30 < arg_151_1.time_ and arg_151_1.time_ <= var_154_30 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_32 = arg_151_1:FormatText(StoryNameCfg[15].name)

				arg_151_1.leftNameTxt_.text = var_154_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_33 = arg_151_1:GetWordFromCfg(425032037)
				local var_154_34 = arg_151_1:FormatText(var_154_33.content)

				arg_151_1.text_.text = var_154_34

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_35 = 11
				local var_154_36 = utf8.len(var_154_34)
				local var_154_37 = var_154_35 <= 0 and var_154_31 or var_154_31 * (var_154_36 / var_154_35)

				if var_154_37 > 0 and var_154_31 < var_154_37 then
					arg_151_1.talkMaxDuration = var_154_37

					if var_154_37 + var_154_30 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_37 + var_154_30
					end
				end

				arg_151_1.text_.text = var_154_34
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032037", "story_v_out_425032.awb") ~= 0 then
					local var_154_38 = manager.audio:GetVoiceLength("story_v_out_425032", "425032037", "story_v_out_425032.awb") / 1000

					if var_154_38 + var_154_30 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_38 + var_154_30
					end

					if var_154_33.prefab_name ~= "" and arg_151_1.actors_[var_154_33.prefab_name] ~= nil then
						local var_154_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_33.prefab_name].transform, "story_v_out_425032", "425032037", "story_v_out_425032.awb")

						arg_151_1:RecordAudio("425032037", var_154_39)
						arg_151_1:RecordAudio("425032037", var_154_39)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_425032", "425032037", "story_v_out_425032.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_425032", "425032037", "story_v_out_425032.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_40 = math.max(var_154_31, arg_151_1.talkMaxDuration)

			if var_154_30 <= arg_151_1.time_ and arg_151_1.time_ < var_154_30 + var_154_40 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_30) / var_154_40

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_30 + var_154_40 and arg_151_1.time_ < var_154_30 + var_154_40 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
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

		arg_151_1:InitPlayNodeList()
	end,
	Play425032038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 425032038
		arg_155_1.duration_ = 4.9

		local var_155_0 = {
			zh = 3.233,
			ja = 4.9
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play425032039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1080"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.actorSpriteComps1080 == nil then
				arg_155_1.var_.actorSpriteComps1080 = var_158_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_2 = 0.2

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.actorSpriteComps1080 then
					for iter_158_0, iter_158_1 in pairs(arg_155_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_158_1 then
							if arg_155_1.isInRecall_ then
								local var_158_4 = Mathf.Lerp(iter_158_1.color.r, arg_155_1.hightColor1.r, var_158_3)
								local var_158_5 = Mathf.Lerp(iter_158_1.color.g, arg_155_1.hightColor1.g, var_158_3)
								local var_158_6 = Mathf.Lerp(iter_158_1.color.b, arg_155_1.hightColor1.b, var_158_3)

								iter_158_1.color = Color.New(var_158_4, var_158_5, var_158_6)
							else
								local var_158_7 = Mathf.Lerp(iter_158_1.color.r, 1, var_158_3)

								iter_158_1.color = Color.New(var_158_7, var_158_7, var_158_7)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.actorSpriteComps1080 then
				for iter_158_2, iter_158_3 in pairs(arg_155_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_158_3 then
						if arg_155_1.isInRecall_ then
							iter_158_3.color = arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_158_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps1080 = nil
			end

			local var_158_8 = arg_155_1.actors_["1137"]
			local var_158_9 = 0

			if var_158_9 < arg_155_1.time_ and arg_155_1.time_ <= var_158_9 + arg_158_0 and not isNil(var_158_8) and arg_155_1.var_.actorSpriteComps1137 == nil then
				arg_155_1.var_.actorSpriteComps1137 = var_158_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_10 = 0.2

			if var_158_9 <= arg_155_1.time_ and arg_155_1.time_ < var_158_9 + var_158_10 and not isNil(var_158_8) then
				local var_158_11 = (arg_155_1.time_ - var_158_9) / var_158_10

				if arg_155_1.var_.actorSpriteComps1137 then
					for iter_158_4, iter_158_5 in pairs(arg_155_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_158_5 then
							if arg_155_1.isInRecall_ then
								local var_158_12 = Mathf.Lerp(iter_158_5.color.r, arg_155_1.hightColor2.r, var_158_11)
								local var_158_13 = Mathf.Lerp(iter_158_5.color.g, arg_155_1.hightColor2.g, var_158_11)
								local var_158_14 = Mathf.Lerp(iter_158_5.color.b, arg_155_1.hightColor2.b, var_158_11)

								iter_158_5.color = Color.New(var_158_12, var_158_13, var_158_14)
							else
								local var_158_15 = Mathf.Lerp(iter_158_5.color.r, 0.5, var_158_11)

								iter_158_5.color = Color.New(var_158_15, var_158_15, var_158_15)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= var_158_9 + var_158_10 and arg_155_1.time_ < var_158_9 + var_158_10 + arg_158_0 and not isNil(var_158_8) and arg_155_1.var_.actorSpriteComps1137 then
				for iter_158_6, iter_158_7 in pairs(arg_155_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_158_7 then
						if arg_155_1.isInRecall_ then
							iter_158_7.color = arg_155_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_158_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps1137 = nil
			end

			local var_158_16 = arg_155_1.actors_["1080"].transform
			local var_158_17 = 0

			if var_158_17 < arg_155_1.time_ and arg_155_1.time_ <= var_158_17 + arg_158_0 then
				arg_155_1.var_.moveOldPos1080 = var_158_16.localPosition
				var_158_16.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("1080", 4)

				local var_158_18 = var_158_16.childCount

				for iter_158_8 = 0, var_158_18 - 1 do
					local var_158_19 = var_158_16:GetChild(iter_158_8)

					if var_158_19.name == "" or not string.find(var_158_19.name, "split") then
						var_158_19.gameObject:SetActive(true)
					else
						var_158_19.gameObject:SetActive(false)
					end
				end
			end

			local var_158_20 = 0.001

			if var_158_17 <= arg_155_1.time_ and arg_155_1.time_ < var_158_17 + var_158_20 then
				local var_158_21 = (arg_155_1.time_ - var_158_17) / var_158_20
				local var_158_22 = Vector3.New(390, -378, -170)

				var_158_16.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1080, var_158_22, var_158_21)
			end

			if arg_155_1.time_ >= var_158_17 + var_158_20 and arg_155_1.time_ < var_158_17 + var_158_20 + arg_158_0 then
				var_158_16.localPosition = Vector3.New(390, -378, -170)
			end

			local var_158_23 = 0
			local var_158_24 = 0.275

			if var_158_23 < arg_155_1.time_ and arg_155_1.time_ <= var_158_23 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_25 = arg_155_1:FormatText(StoryNameCfg[55].name)

				arg_155_1.leftNameTxt_.text = var_158_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_26 = arg_155_1:GetWordFromCfg(425032038)
				local var_158_27 = arg_155_1:FormatText(var_158_26.content)

				arg_155_1.text_.text = var_158_27

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_28 = 11
				local var_158_29 = utf8.len(var_158_27)
				local var_158_30 = var_158_28 <= 0 and var_158_24 or var_158_24 * (var_158_29 / var_158_28)

				if var_158_30 > 0 and var_158_24 < var_158_30 then
					arg_155_1.talkMaxDuration = var_158_30

					if var_158_30 + var_158_23 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_30 + var_158_23
					end
				end

				arg_155_1.text_.text = var_158_27
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032038", "story_v_out_425032.awb") ~= 0 then
					local var_158_31 = manager.audio:GetVoiceLength("story_v_out_425032", "425032038", "story_v_out_425032.awb") / 1000

					if var_158_31 + var_158_23 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_31 + var_158_23
					end

					if var_158_26.prefab_name ~= "" and arg_155_1.actors_[var_158_26.prefab_name] ~= nil then
						local var_158_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_26.prefab_name].transform, "story_v_out_425032", "425032038", "story_v_out_425032.awb")

						arg_155_1:RecordAudio("425032038", var_158_32)
						arg_155_1:RecordAudio("425032038", var_158_32)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_425032", "425032038", "story_v_out_425032.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_425032", "425032038", "story_v_out_425032.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_33 = math.max(var_158_24, arg_155_1.talkMaxDuration)

			if var_158_23 <= arg_155_1.time_ and arg_155_1.time_ < var_158_23 + var_158_33 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_23) / var_158_33

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_23 + var_158_33 and arg_155_1.time_ < var_158_23 + var_158_33 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play425032039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 425032039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play425032040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1080"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.actorSpriteComps1080 == nil then
				arg_159_1.var_.actorSpriteComps1080 = var_162_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_2 = 0.2

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.actorSpriteComps1080 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_162_1 then
							if arg_159_1.isInRecall_ then
								local var_162_4 = Mathf.Lerp(iter_162_1.color.r, arg_159_1.hightColor2.r, var_162_3)
								local var_162_5 = Mathf.Lerp(iter_162_1.color.g, arg_159_1.hightColor2.g, var_162_3)
								local var_162_6 = Mathf.Lerp(iter_162_1.color.b, arg_159_1.hightColor2.b, var_162_3)

								iter_162_1.color = Color.New(var_162_4, var_162_5, var_162_6)
							else
								local var_162_7 = Mathf.Lerp(iter_162_1.color.r, 0.5, var_162_3)

								iter_162_1.color = Color.New(var_162_7, var_162_7, var_162_7)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.actorSpriteComps1080 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_162_3 then
						if arg_159_1.isInRecall_ then
							iter_162_3.color = arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_162_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_159_1.var_.actorSpriteComps1080 = nil
			end

			local var_162_8 = 0
			local var_162_9 = 1.425

			if var_162_8 < arg_159_1.time_ and arg_159_1.time_ <= var_162_8 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_10 = arg_159_1:GetWordFromCfg(425032039)
				local var_162_11 = arg_159_1:FormatText(var_162_10.content)

				arg_159_1.text_.text = var_162_11

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_12 = 57
				local var_162_13 = utf8.len(var_162_11)
				local var_162_14 = var_162_12 <= 0 and var_162_9 or var_162_9 * (var_162_13 / var_162_12)

				if var_162_14 > 0 and var_162_9 < var_162_14 then
					arg_159_1.talkMaxDuration = var_162_14

					if var_162_14 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_14 + var_162_8
					end
				end

				arg_159_1.text_.text = var_162_11
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_15 = math.max(var_162_9, arg_159_1.talkMaxDuration)

			if var_162_8 <= arg_159_1.time_ and arg_159_1.time_ < var_162_8 + var_162_15 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_8) / var_162_15

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_8 + var_162_15 and arg_159_1.time_ < var_162_8 + var_162_15 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play425032040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 425032040
		arg_163_1.duration_ = 7.23

		local var_163_0 = {
			zh = 4,
			ja = 7.233
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
				arg_163_0:Play425032041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1137"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.actorSpriteComps1137 == nil then
				arg_163_1.var_.actorSpriteComps1137 = var_166_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_2 = 0.2

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.actorSpriteComps1137 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_166_1 then
							if arg_163_1.isInRecall_ then
								local var_166_4 = Mathf.Lerp(iter_166_1.color.r, arg_163_1.hightColor1.r, var_166_3)
								local var_166_5 = Mathf.Lerp(iter_166_1.color.g, arg_163_1.hightColor1.g, var_166_3)
								local var_166_6 = Mathf.Lerp(iter_166_1.color.b, arg_163_1.hightColor1.b, var_166_3)

								iter_166_1.color = Color.New(var_166_4, var_166_5, var_166_6)
							else
								local var_166_7 = Mathf.Lerp(iter_166_1.color.r, 1, var_166_3)

								iter_166_1.color = Color.New(var_166_7, var_166_7, var_166_7)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.actorSpriteComps1137 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_166_3 then
						if arg_163_1.isInRecall_ then
							iter_166_3.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_166_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps1137 = nil
			end

			local var_166_8 = 0
			local var_166_9 = 0.45

			if var_166_8 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_10 = arg_163_1:FormatText(StoryNameCfg[15].name)

				arg_163_1.leftNameTxt_.text = var_166_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_11 = arg_163_1:GetWordFromCfg(425032040)
				local var_166_12 = arg_163_1:FormatText(var_166_11.content)

				arg_163_1.text_.text = var_166_12

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_13 = 18
				local var_166_14 = utf8.len(var_166_12)
				local var_166_15 = var_166_13 <= 0 and var_166_9 or var_166_9 * (var_166_14 / var_166_13)

				if var_166_15 > 0 and var_166_9 < var_166_15 then
					arg_163_1.talkMaxDuration = var_166_15

					if var_166_15 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_15 + var_166_8
					end
				end

				arg_163_1.text_.text = var_166_12
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032040", "story_v_out_425032.awb") ~= 0 then
					local var_166_16 = manager.audio:GetVoiceLength("story_v_out_425032", "425032040", "story_v_out_425032.awb") / 1000

					if var_166_16 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_16 + var_166_8
					end

					if var_166_11.prefab_name ~= "" and arg_163_1.actors_[var_166_11.prefab_name] ~= nil then
						local var_166_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_11.prefab_name].transform, "story_v_out_425032", "425032040", "story_v_out_425032.awb")

						arg_163_1:RecordAudio("425032040", var_166_17)
						arg_163_1:RecordAudio("425032040", var_166_17)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_425032", "425032040", "story_v_out_425032.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_425032", "425032040", "story_v_out_425032.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_18 = math.max(var_166_9, arg_163_1.talkMaxDuration)

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_18 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_8) / var_166_18

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_8 + var_166_18 and arg_163_1.time_ < var_166_8 + var_166_18 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play425032041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 425032041
		arg_167_1.duration_ = 5.8

		local var_167_0 = {
			zh = 4.666,
			ja = 5.8
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play425032042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1080"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps1080 == nil then
				arg_167_1.var_.actorSpriteComps1080 = var_170_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_2 = 0.2

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.actorSpriteComps1080 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_170_1 then
							if arg_167_1.isInRecall_ then
								local var_170_4 = Mathf.Lerp(iter_170_1.color.r, arg_167_1.hightColor1.r, var_170_3)
								local var_170_5 = Mathf.Lerp(iter_170_1.color.g, arg_167_1.hightColor1.g, var_170_3)
								local var_170_6 = Mathf.Lerp(iter_170_1.color.b, arg_167_1.hightColor1.b, var_170_3)

								iter_170_1.color = Color.New(var_170_4, var_170_5, var_170_6)
							else
								local var_170_7 = Mathf.Lerp(iter_170_1.color.r, 1, var_170_3)

								iter_170_1.color = Color.New(var_170_7, var_170_7, var_170_7)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps1080 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_170_3 then
						if arg_167_1.isInRecall_ then
							iter_170_3.color = arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_170_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps1080 = nil
			end

			local var_170_8 = arg_167_1.actors_["1137"]
			local var_170_9 = 0

			if var_170_9 < arg_167_1.time_ and arg_167_1.time_ <= var_170_9 + arg_170_0 and not isNil(var_170_8) and arg_167_1.var_.actorSpriteComps1137 == nil then
				arg_167_1.var_.actorSpriteComps1137 = var_170_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_10 = 0.2

			if var_170_9 <= arg_167_1.time_ and arg_167_1.time_ < var_170_9 + var_170_10 and not isNil(var_170_8) then
				local var_170_11 = (arg_167_1.time_ - var_170_9) / var_170_10

				if arg_167_1.var_.actorSpriteComps1137 then
					for iter_170_4, iter_170_5 in pairs(arg_167_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_170_5 then
							if arg_167_1.isInRecall_ then
								local var_170_12 = Mathf.Lerp(iter_170_5.color.r, arg_167_1.hightColor2.r, var_170_11)
								local var_170_13 = Mathf.Lerp(iter_170_5.color.g, arg_167_1.hightColor2.g, var_170_11)
								local var_170_14 = Mathf.Lerp(iter_170_5.color.b, arg_167_1.hightColor2.b, var_170_11)

								iter_170_5.color = Color.New(var_170_12, var_170_13, var_170_14)
							else
								local var_170_15 = Mathf.Lerp(iter_170_5.color.r, 0.5, var_170_11)

								iter_170_5.color = Color.New(var_170_15, var_170_15, var_170_15)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= var_170_9 + var_170_10 and arg_167_1.time_ < var_170_9 + var_170_10 + arg_170_0 and not isNil(var_170_8) and arg_167_1.var_.actorSpriteComps1137 then
				for iter_170_6, iter_170_7 in pairs(arg_167_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_170_7 then
						if arg_167_1.isInRecall_ then
							iter_170_7.color = arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_170_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps1137 = nil
			end

			local var_170_16 = arg_167_1.actors_["1080"].transform
			local var_170_17 = 0

			if var_170_17 < arg_167_1.time_ and arg_167_1.time_ <= var_170_17 + arg_170_0 then
				arg_167_1.var_.moveOldPos1080 = var_170_16.localPosition
				var_170_16.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("1080", 4)

				local var_170_18 = var_170_16.childCount

				for iter_170_8 = 0, var_170_18 - 1 do
					local var_170_19 = var_170_16:GetChild(iter_170_8)

					if var_170_19.name == "" or not string.find(var_170_19.name, "split") then
						var_170_19.gameObject:SetActive(true)
					else
						var_170_19.gameObject:SetActive(false)
					end
				end
			end

			local var_170_20 = 0.001

			if var_170_17 <= arg_167_1.time_ and arg_167_1.time_ < var_170_17 + var_170_20 then
				local var_170_21 = (arg_167_1.time_ - var_170_17) / var_170_20
				local var_170_22 = Vector3.New(390, -378, -170)

				var_170_16.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1080, var_170_22, var_170_21)
			end

			if arg_167_1.time_ >= var_170_17 + var_170_20 and arg_167_1.time_ < var_170_17 + var_170_20 + arg_170_0 then
				var_170_16.localPosition = Vector3.New(390, -378, -170)
			end

			local var_170_23 = 0
			local var_170_24 = 0.375

			if var_170_23 < arg_167_1.time_ and arg_167_1.time_ <= var_170_23 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_25 = arg_167_1:FormatText(StoryNameCfg[55].name)

				arg_167_1.leftNameTxt_.text = var_170_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_26 = arg_167_1:GetWordFromCfg(425032041)
				local var_170_27 = arg_167_1:FormatText(var_170_26.content)

				arg_167_1.text_.text = var_170_27

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_28 = 15
				local var_170_29 = utf8.len(var_170_27)
				local var_170_30 = var_170_28 <= 0 and var_170_24 or var_170_24 * (var_170_29 / var_170_28)

				if var_170_30 > 0 and var_170_24 < var_170_30 then
					arg_167_1.talkMaxDuration = var_170_30

					if var_170_30 + var_170_23 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_30 + var_170_23
					end
				end

				arg_167_1.text_.text = var_170_27
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032041", "story_v_out_425032.awb") ~= 0 then
					local var_170_31 = manager.audio:GetVoiceLength("story_v_out_425032", "425032041", "story_v_out_425032.awb") / 1000

					if var_170_31 + var_170_23 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_31 + var_170_23
					end

					if var_170_26.prefab_name ~= "" and arg_167_1.actors_[var_170_26.prefab_name] ~= nil then
						local var_170_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_26.prefab_name].transform, "story_v_out_425032", "425032041", "story_v_out_425032.awb")

						arg_167_1:RecordAudio("425032041", var_170_32)
						arg_167_1:RecordAudio("425032041", var_170_32)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_425032", "425032041", "story_v_out_425032.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_425032", "425032041", "story_v_out_425032.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_33 = math.max(var_170_24, arg_167_1.talkMaxDuration)

			if var_170_23 <= arg_167_1.time_ and arg_167_1.time_ < var_170_23 + var_170_33 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_23) / var_170_33

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_23 + var_170_33 and arg_167_1.time_ < var_170_23 + var_170_33 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play425032042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 425032042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play425032043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1080"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.actorSpriteComps1080 == nil then
				arg_171_1.var_.actorSpriteComps1080 = var_174_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_2 = 0.2

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.actorSpriteComps1080 then
					for iter_174_0, iter_174_1 in pairs(arg_171_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_174_1 then
							if arg_171_1.isInRecall_ then
								local var_174_4 = Mathf.Lerp(iter_174_1.color.r, arg_171_1.hightColor2.r, var_174_3)
								local var_174_5 = Mathf.Lerp(iter_174_1.color.g, arg_171_1.hightColor2.g, var_174_3)
								local var_174_6 = Mathf.Lerp(iter_174_1.color.b, arg_171_1.hightColor2.b, var_174_3)

								iter_174_1.color = Color.New(var_174_4, var_174_5, var_174_6)
							else
								local var_174_7 = Mathf.Lerp(iter_174_1.color.r, 0.5, var_174_3)

								iter_174_1.color = Color.New(var_174_7, var_174_7, var_174_7)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.actorSpriteComps1080 then
				for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_174_3 then
						if arg_171_1.isInRecall_ then
							iter_174_3.color = arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_174_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps1080 = nil
			end

			local var_174_8 = 0
			local var_174_9 = 0.65

			if var_174_8 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_10 = arg_171_1:GetWordFromCfg(425032042)
				local var_174_11 = arg_171_1:FormatText(var_174_10.content)

				arg_171_1.text_.text = var_174_11

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_12 = 26
				local var_174_13 = utf8.len(var_174_11)
				local var_174_14 = var_174_12 <= 0 and var_174_9 or var_174_9 * (var_174_13 / var_174_12)

				if var_174_14 > 0 and var_174_9 < var_174_14 then
					arg_171_1.talkMaxDuration = var_174_14

					if var_174_14 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_14 + var_174_8
					end
				end

				arg_171_1.text_.text = var_174_11
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_15 = math.max(var_174_9, arg_171_1.talkMaxDuration)

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_15 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_8) / var_174_15

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_8 + var_174_15 and arg_171_1.time_ < var_174_8 + var_174_15 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play425032043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 425032043
		arg_175_1.duration_ = 7.6

		local var_175_0 = {
			zh = 6.9,
			ja = 7.6
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
				arg_175_0:Play425032044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1086"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.actorSpriteComps1086 == nil then
				arg_175_1.var_.actorSpriteComps1086 = var_178_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_2 = 0.2

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.actorSpriteComps1086 then
					for iter_178_0, iter_178_1 in pairs(arg_175_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_178_1 then
							if arg_175_1.isInRecall_ then
								local var_178_4 = Mathf.Lerp(iter_178_1.color.r, arg_175_1.hightColor1.r, var_178_3)
								local var_178_5 = Mathf.Lerp(iter_178_1.color.g, arg_175_1.hightColor1.g, var_178_3)
								local var_178_6 = Mathf.Lerp(iter_178_1.color.b, arg_175_1.hightColor1.b, var_178_3)

								iter_178_1.color = Color.New(var_178_4, var_178_5, var_178_6)
							else
								local var_178_7 = Mathf.Lerp(iter_178_1.color.r, 1, var_178_3)

								iter_178_1.color = Color.New(var_178_7, var_178_7, var_178_7)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.actorSpriteComps1086 then
				for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_178_3 then
						if arg_175_1.isInRecall_ then
							iter_178_3.color = arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_178_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_175_1.var_.actorSpriteComps1086 = nil
			end

			local var_178_8 = arg_175_1.actors_["1086"].transform
			local var_178_9 = 0

			if var_178_9 < arg_175_1.time_ and arg_175_1.time_ <= var_178_9 + arg_178_0 then
				arg_175_1.var_.moveOldPos1086 = var_178_8.localPosition
				var_178_8.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("1086", 2)

				local var_178_10 = var_178_8.childCount

				for iter_178_4 = 0, var_178_10 - 1 do
					local var_178_11 = var_178_8:GetChild(iter_178_4)

					if var_178_11.name == "" or not string.find(var_178_11.name, "split") then
						var_178_11.gameObject:SetActive(true)
					else
						var_178_11.gameObject:SetActive(false)
					end
				end
			end

			local var_178_12 = 0.001

			if var_178_9 <= arg_175_1.time_ and arg_175_1.time_ < var_178_9 + var_178_12 then
				local var_178_13 = (arg_175_1.time_ - var_178_9) / var_178_12
				local var_178_14 = Vector3.New(-390, -404.2, -237.9)

				var_178_8.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1086, var_178_14, var_178_13)
			end

			if arg_175_1.time_ >= var_178_9 + var_178_12 and arg_175_1.time_ < var_178_9 + var_178_12 + arg_178_0 then
				var_178_8.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_178_15 = arg_175_1.actors_["1137"].transform
			local var_178_16 = 0

			if var_178_16 < arg_175_1.time_ and arg_175_1.time_ <= var_178_16 + arg_178_0 then
				arg_175_1.var_.moveOldPos1137 = var_178_15.localPosition
				var_178_15.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("1137", 7)

				local var_178_17 = var_178_15.childCount

				for iter_178_5 = 0, var_178_17 - 1 do
					local var_178_18 = var_178_15:GetChild(iter_178_5)

					if var_178_18.name == "" or not string.find(var_178_18.name, "split") then
						var_178_18.gameObject:SetActive(true)
					else
						var_178_18.gameObject:SetActive(false)
					end
				end
			end

			local var_178_19 = 0.001

			if var_178_16 <= arg_175_1.time_ and arg_175_1.time_ < var_178_16 + var_178_19 then
				local var_178_20 = (arg_175_1.time_ - var_178_16) / var_178_19
				local var_178_21 = Vector3.New(0, -2000, 0)

				var_178_15.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1137, var_178_21, var_178_20)
			end

			if arg_175_1.time_ >= var_178_16 + var_178_19 and arg_175_1.time_ < var_178_16 + var_178_19 + arg_178_0 then
				var_178_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_178_22 = 0
			local var_178_23 = 1

			if var_178_22 < arg_175_1.time_ and arg_175_1.time_ <= var_178_22 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_24 = arg_175_1:FormatText(StoryNameCfg[1080].name)

				arg_175_1.leftNameTxt_.text = var_178_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_25 = arg_175_1:GetWordFromCfg(425032043)
				local var_178_26 = arg_175_1:FormatText(var_178_25.content)

				arg_175_1.text_.text = var_178_26

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_27 = 40
				local var_178_28 = utf8.len(var_178_26)
				local var_178_29 = var_178_27 <= 0 and var_178_23 or var_178_23 * (var_178_28 / var_178_27)

				if var_178_29 > 0 and var_178_23 < var_178_29 then
					arg_175_1.talkMaxDuration = var_178_29

					if var_178_29 + var_178_22 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_29 + var_178_22
					end
				end

				arg_175_1.text_.text = var_178_26
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032043", "story_v_out_425032.awb") ~= 0 then
					local var_178_30 = manager.audio:GetVoiceLength("story_v_out_425032", "425032043", "story_v_out_425032.awb") / 1000

					if var_178_30 + var_178_22 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_30 + var_178_22
					end

					if var_178_25.prefab_name ~= "" and arg_175_1.actors_[var_178_25.prefab_name] ~= nil then
						local var_178_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_25.prefab_name].transform, "story_v_out_425032", "425032043", "story_v_out_425032.awb")

						arg_175_1:RecordAudio("425032043", var_178_31)
						arg_175_1:RecordAudio("425032043", var_178_31)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_425032", "425032043", "story_v_out_425032.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_425032", "425032043", "story_v_out_425032.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_32 = math.max(var_178_23, arg_175_1.talkMaxDuration)

			if var_178_22 <= arg_175_1.time_ and arg_175_1.time_ < var_178_22 + var_178_32 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_22) / var_178_32

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_22 + var_178_32 and arg_175_1.time_ < var_178_22 + var_178_32 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play425032044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 425032044
		arg_179_1.duration_ = 4.13

		local var_179_0 = {
			zh = 3.2,
			ja = 4.133
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
				arg_179_0:Play425032045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1080"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.actorSpriteComps1080 == nil then
				arg_179_1.var_.actorSpriteComps1080 = var_182_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_2 = 0.2

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.actorSpriteComps1080 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_182_1 then
							if arg_179_1.isInRecall_ then
								local var_182_4 = Mathf.Lerp(iter_182_1.color.r, arg_179_1.hightColor1.r, var_182_3)
								local var_182_5 = Mathf.Lerp(iter_182_1.color.g, arg_179_1.hightColor1.g, var_182_3)
								local var_182_6 = Mathf.Lerp(iter_182_1.color.b, arg_179_1.hightColor1.b, var_182_3)

								iter_182_1.color = Color.New(var_182_4, var_182_5, var_182_6)
							else
								local var_182_7 = Mathf.Lerp(iter_182_1.color.r, 1, var_182_3)

								iter_182_1.color = Color.New(var_182_7, var_182_7, var_182_7)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.actorSpriteComps1080 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_182_3 then
						if arg_179_1.isInRecall_ then
							iter_182_3.color = arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_182_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps1080 = nil
			end

			local var_182_8 = arg_179_1.actors_["1086"]
			local var_182_9 = 0

			if var_182_9 < arg_179_1.time_ and arg_179_1.time_ <= var_182_9 + arg_182_0 and not isNil(var_182_8) and arg_179_1.var_.actorSpriteComps1086 == nil then
				arg_179_1.var_.actorSpriteComps1086 = var_182_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_10 = 0.2

			if var_182_9 <= arg_179_1.time_ and arg_179_1.time_ < var_182_9 + var_182_10 and not isNil(var_182_8) then
				local var_182_11 = (arg_179_1.time_ - var_182_9) / var_182_10

				if arg_179_1.var_.actorSpriteComps1086 then
					for iter_182_4, iter_182_5 in pairs(arg_179_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_182_5 then
							if arg_179_1.isInRecall_ then
								local var_182_12 = Mathf.Lerp(iter_182_5.color.r, arg_179_1.hightColor2.r, var_182_11)
								local var_182_13 = Mathf.Lerp(iter_182_5.color.g, arg_179_1.hightColor2.g, var_182_11)
								local var_182_14 = Mathf.Lerp(iter_182_5.color.b, arg_179_1.hightColor2.b, var_182_11)

								iter_182_5.color = Color.New(var_182_12, var_182_13, var_182_14)
							else
								local var_182_15 = Mathf.Lerp(iter_182_5.color.r, 0.5, var_182_11)

								iter_182_5.color = Color.New(var_182_15, var_182_15, var_182_15)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_9 + var_182_10 and arg_179_1.time_ < var_182_9 + var_182_10 + arg_182_0 and not isNil(var_182_8) and arg_179_1.var_.actorSpriteComps1086 then
				for iter_182_6, iter_182_7 in pairs(arg_179_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_182_7 then
						if arg_179_1.isInRecall_ then
							iter_182_7.color = arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_182_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps1086 = nil
			end

			local var_182_16 = arg_179_1.actors_["1080"].transform
			local var_182_17 = 0

			if var_182_17 < arg_179_1.time_ and arg_179_1.time_ <= var_182_17 + arg_182_0 then
				arg_179_1.var_.moveOldPos1080 = var_182_16.localPosition
				var_182_16.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("1080", 4)

				local var_182_18 = var_182_16.childCount

				for iter_182_8 = 0, var_182_18 - 1 do
					local var_182_19 = var_182_16:GetChild(iter_182_8)

					if var_182_19.name == "" or not string.find(var_182_19.name, "split") then
						var_182_19.gameObject:SetActive(true)
					else
						var_182_19.gameObject:SetActive(false)
					end
				end
			end

			local var_182_20 = 0.001

			if var_182_17 <= arg_179_1.time_ and arg_179_1.time_ < var_182_17 + var_182_20 then
				local var_182_21 = (arg_179_1.time_ - var_182_17) / var_182_20
				local var_182_22 = Vector3.New(390, -378, -170)

				var_182_16.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1080, var_182_22, var_182_21)
			end

			if arg_179_1.time_ >= var_182_17 + var_182_20 and arg_179_1.time_ < var_182_17 + var_182_20 + arg_182_0 then
				var_182_16.localPosition = Vector3.New(390, -378, -170)
			end

			local var_182_23 = 0
			local var_182_24 = 0.425

			if var_182_23 < arg_179_1.time_ and arg_179_1.time_ <= var_182_23 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_25 = arg_179_1:FormatText(StoryNameCfg[55].name)

				arg_179_1.leftNameTxt_.text = var_182_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_26 = arg_179_1:GetWordFromCfg(425032044)
				local var_182_27 = arg_179_1:FormatText(var_182_26.content)

				arg_179_1.text_.text = var_182_27

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_28 = 17
				local var_182_29 = utf8.len(var_182_27)
				local var_182_30 = var_182_28 <= 0 and var_182_24 or var_182_24 * (var_182_29 / var_182_28)

				if var_182_30 > 0 and var_182_24 < var_182_30 then
					arg_179_1.talkMaxDuration = var_182_30

					if var_182_30 + var_182_23 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_30 + var_182_23
					end
				end

				arg_179_1.text_.text = var_182_27
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032044", "story_v_out_425032.awb") ~= 0 then
					local var_182_31 = manager.audio:GetVoiceLength("story_v_out_425032", "425032044", "story_v_out_425032.awb") / 1000

					if var_182_31 + var_182_23 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_31 + var_182_23
					end

					if var_182_26.prefab_name ~= "" and arg_179_1.actors_[var_182_26.prefab_name] ~= nil then
						local var_182_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_26.prefab_name].transform, "story_v_out_425032", "425032044", "story_v_out_425032.awb")

						arg_179_1:RecordAudio("425032044", var_182_32)
						arg_179_1:RecordAudio("425032044", var_182_32)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_425032", "425032044", "story_v_out_425032.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_425032", "425032044", "story_v_out_425032.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_33 = math.max(var_182_24, arg_179_1.talkMaxDuration)

			if var_182_23 <= arg_179_1.time_ and arg_179_1.time_ < var_182_23 + var_182_33 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_23) / var_182_33

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_23 + var_182_33 and arg_179_1.time_ < var_182_23 + var_182_33 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play425032045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 425032045
		arg_183_1.duration_ = 13.7

		local var_183_0 = {
			zh = 10.733,
			ja = 13.7
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play425032046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1086"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.actorSpriteComps1086 == nil then
				arg_183_1.var_.actorSpriteComps1086 = var_186_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_2 = 0.2

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.actorSpriteComps1086 then
					for iter_186_0, iter_186_1 in pairs(arg_183_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_186_1 then
							if arg_183_1.isInRecall_ then
								local var_186_4 = Mathf.Lerp(iter_186_1.color.r, arg_183_1.hightColor1.r, var_186_3)
								local var_186_5 = Mathf.Lerp(iter_186_1.color.g, arg_183_1.hightColor1.g, var_186_3)
								local var_186_6 = Mathf.Lerp(iter_186_1.color.b, arg_183_1.hightColor1.b, var_186_3)

								iter_186_1.color = Color.New(var_186_4, var_186_5, var_186_6)
							else
								local var_186_7 = Mathf.Lerp(iter_186_1.color.r, 1, var_186_3)

								iter_186_1.color = Color.New(var_186_7, var_186_7, var_186_7)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.actorSpriteComps1086 then
				for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_186_3 then
						if arg_183_1.isInRecall_ then
							iter_186_3.color = arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_186_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps1086 = nil
			end

			local var_186_8 = arg_183_1.actors_["1080"]
			local var_186_9 = 0

			if var_186_9 < arg_183_1.time_ and arg_183_1.time_ <= var_186_9 + arg_186_0 and not isNil(var_186_8) and arg_183_1.var_.actorSpriteComps1080 == nil then
				arg_183_1.var_.actorSpriteComps1080 = var_186_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_10 = 0.2

			if var_186_9 <= arg_183_1.time_ and arg_183_1.time_ < var_186_9 + var_186_10 and not isNil(var_186_8) then
				local var_186_11 = (arg_183_1.time_ - var_186_9) / var_186_10

				if arg_183_1.var_.actorSpriteComps1080 then
					for iter_186_4, iter_186_5 in pairs(arg_183_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_186_5 then
							if arg_183_1.isInRecall_ then
								local var_186_12 = Mathf.Lerp(iter_186_5.color.r, arg_183_1.hightColor2.r, var_186_11)
								local var_186_13 = Mathf.Lerp(iter_186_5.color.g, arg_183_1.hightColor2.g, var_186_11)
								local var_186_14 = Mathf.Lerp(iter_186_5.color.b, arg_183_1.hightColor2.b, var_186_11)

								iter_186_5.color = Color.New(var_186_12, var_186_13, var_186_14)
							else
								local var_186_15 = Mathf.Lerp(iter_186_5.color.r, 0.5, var_186_11)

								iter_186_5.color = Color.New(var_186_15, var_186_15, var_186_15)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= var_186_9 + var_186_10 and arg_183_1.time_ < var_186_9 + var_186_10 + arg_186_0 and not isNil(var_186_8) and arg_183_1.var_.actorSpriteComps1080 then
				for iter_186_6, iter_186_7 in pairs(arg_183_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_186_7 then
						if arg_183_1.isInRecall_ then
							iter_186_7.color = arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_186_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps1080 = nil
			end

			local var_186_16 = arg_183_1.actors_["1086"].transform
			local var_186_17 = 0

			if var_186_17 < arg_183_1.time_ and arg_183_1.time_ <= var_186_17 + arg_186_0 then
				arg_183_1.var_.moveOldPos1086 = var_186_16.localPosition
				var_186_16.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("1086", 2)

				local var_186_18 = var_186_16.childCount

				for iter_186_8 = 0, var_186_18 - 1 do
					local var_186_19 = var_186_16:GetChild(iter_186_8)

					if var_186_19.name == "" or not string.find(var_186_19.name, "split") then
						var_186_19.gameObject:SetActive(true)
					else
						var_186_19.gameObject:SetActive(false)
					end
				end
			end

			local var_186_20 = 0.001

			if var_186_17 <= arg_183_1.time_ and arg_183_1.time_ < var_186_17 + var_186_20 then
				local var_186_21 = (arg_183_1.time_ - var_186_17) / var_186_20
				local var_186_22 = Vector3.New(-390, -404.2, -237.9)

				var_186_16.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1086, var_186_22, var_186_21)
			end

			if arg_183_1.time_ >= var_186_17 + var_186_20 and arg_183_1.time_ < var_186_17 + var_186_20 + arg_186_0 then
				var_186_16.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_186_23 = 0
			local var_186_24 = 1.4

			if var_186_23 < arg_183_1.time_ and arg_183_1.time_ <= var_186_23 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_25 = arg_183_1:FormatText(StoryNameCfg[1080].name)

				arg_183_1.leftNameTxt_.text = var_186_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_26 = arg_183_1:GetWordFromCfg(425032045)
				local var_186_27 = arg_183_1:FormatText(var_186_26.content)

				arg_183_1.text_.text = var_186_27

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_28 = 56
				local var_186_29 = utf8.len(var_186_27)
				local var_186_30 = var_186_28 <= 0 and var_186_24 or var_186_24 * (var_186_29 / var_186_28)

				if var_186_30 > 0 and var_186_24 < var_186_30 then
					arg_183_1.talkMaxDuration = var_186_30

					if var_186_30 + var_186_23 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_30 + var_186_23
					end
				end

				arg_183_1.text_.text = var_186_27
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032045", "story_v_out_425032.awb") ~= 0 then
					local var_186_31 = manager.audio:GetVoiceLength("story_v_out_425032", "425032045", "story_v_out_425032.awb") / 1000

					if var_186_31 + var_186_23 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_31 + var_186_23
					end

					if var_186_26.prefab_name ~= "" and arg_183_1.actors_[var_186_26.prefab_name] ~= nil then
						local var_186_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_26.prefab_name].transform, "story_v_out_425032", "425032045", "story_v_out_425032.awb")

						arg_183_1:RecordAudio("425032045", var_186_32)
						arg_183_1:RecordAudio("425032045", var_186_32)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_425032", "425032045", "story_v_out_425032.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_425032", "425032045", "story_v_out_425032.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_33 = math.max(var_186_24, arg_183_1.talkMaxDuration)

			if var_186_23 <= arg_183_1.time_ and arg_183_1.time_ < var_186_23 + var_186_33 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_23) / var_186_33

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_23 + var_186_33 and arg_183_1.time_ < var_186_23 + var_186_33 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play425032046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 425032046
		arg_187_1.duration_ = 5.03

		local var_187_0 = {
			zh = 2.966,
			ja = 5.033
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
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play425032047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1080"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.actorSpriteComps1080 == nil then
				arg_187_1.var_.actorSpriteComps1080 = var_190_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_2 = 0.2

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.actorSpriteComps1080 then
					for iter_190_0, iter_190_1 in pairs(arg_187_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_190_1 then
							if arg_187_1.isInRecall_ then
								local var_190_4 = Mathf.Lerp(iter_190_1.color.r, arg_187_1.hightColor1.r, var_190_3)
								local var_190_5 = Mathf.Lerp(iter_190_1.color.g, arg_187_1.hightColor1.g, var_190_3)
								local var_190_6 = Mathf.Lerp(iter_190_1.color.b, arg_187_1.hightColor1.b, var_190_3)

								iter_190_1.color = Color.New(var_190_4, var_190_5, var_190_6)
							else
								local var_190_7 = Mathf.Lerp(iter_190_1.color.r, 1, var_190_3)

								iter_190_1.color = Color.New(var_190_7, var_190_7, var_190_7)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.actorSpriteComps1080 then
				for iter_190_2, iter_190_3 in pairs(arg_187_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_190_3 then
						if arg_187_1.isInRecall_ then
							iter_190_3.color = arg_187_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_190_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_187_1.var_.actorSpriteComps1080 = nil
			end

			local var_190_8 = arg_187_1.actors_["1086"]
			local var_190_9 = 0

			if var_190_9 < arg_187_1.time_ and arg_187_1.time_ <= var_190_9 + arg_190_0 and not isNil(var_190_8) and arg_187_1.var_.actorSpriteComps1086 == nil then
				arg_187_1.var_.actorSpriteComps1086 = var_190_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_10 = 0.2

			if var_190_9 <= arg_187_1.time_ and arg_187_1.time_ < var_190_9 + var_190_10 and not isNil(var_190_8) then
				local var_190_11 = (arg_187_1.time_ - var_190_9) / var_190_10

				if arg_187_1.var_.actorSpriteComps1086 then
					for iter_190_4, iter_190_5 in pairs(arg_187_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_190_5 then
							if arg_187_1.isInRecall_ then
								local var_190_12 = Mathf.Lerp(iter_190_5.color.r, arg_187_1.hightColor2.r, var_190_11)
								local var_190_13 = Mathf.Lerp(iter_190_5.color.g, arg_187_1.hightColor2.g, var_190_11)
								local var_190_14 = Mathf.Lerp(iter_190_5.color.b, arg_187_1.hightColor2.b, var_190_11)

								iter_190_5.color = Color.New(var_190_12, var_190_13, var_190_14)
							else
								local var_190_15 = Mathf.Lerp(iter_190_5.color.r, 0.5, var_190_11)

								iter_190_5.color = Color.New(var_190_15, var_190_15, var_190_15)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= var_190_9 + var_190_10 and arg_187_1.time_ < var_190_9 + var_190_10 + arg_190_0 and not isNil(var_190_8) and arg_187_1.var_.actorSpriteComps1086 then
				for iter_190_6, iter_190_7 in pairs(arg_187_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_190_7 then
						if arg_187_1.isInRecall_ then
							iter_190_7.color = arg_187_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_190_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_187_1.var_.actorSpriteComps1086 = nil
			end

			local var_190_16 = arg_187_1.actors_["1080"].transform
			local var_190_17 = 0

			if var_190_17 < arg_187_1.time_ and arg_187_1.time_ <= var_190_17 + arg_190_0 then
				arg_187_1.var_.moveOldPos1080 = var_190_16.localPosition
				var_190_16.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("1080", 4)

				local var_190_18 = var_190_16.childCount

				for iter_190_8 = 0, var_190_18 - 1 do
					local var_190_19 = var_190_16:GetChild(iter_190_8)

					if var_190_19.name == "" or not string.find(var_190_19.name, "split") then
						var_190_19.gameObject:SetActive(true)
					else
						var_190_19.gameObject:SetActive(false)
					end
				end
			end

			local var_190_20 = 0.001

			if var_190_17 <= arg_187_1.time_ and arg_187_1.time_ < var_190_17 + var_190_20 then
				local var_190_21 = (arg_187_1.time_ - var_190_17) / var_190_20
				local var_190_22 = Vector3.New(390, -378, -170)

				var_190_16.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1080, var_190_22, var_190_21)
			end

			if arg_187_1.time_ >= var_190_17 + var_190_20 and arg_187_1.time_ < var_190_17 + var_190_20 + arg_190_0 then
				var_190_16.localPosition = Vector3.New(390, -378, -170)
			end

			local var_190_23 = 0
			local var_190_24 = 0.425

			if var_190_23 < arg_187_1.time_ and arg_187_1.time_ <= var_190_23 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_25 = arg_187_1:FormatText(StoryNameCfg[55].name)

				arg_187_1.leftNameTxt_.text = var_190_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_26 = arg_187_1:GetWordFromCfg(425032046)
				local var_190_27 = arg_187_1:FormatText(var_190_26.content)

				arg_187_1.text_.text = var_190_27

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_28 = 17
				local var_190_29 = utf8.len(var_190_27)
				local var_190_30 = var_190_28 <= 0 and var_190_24 or var_190_24 * (var_190_29 / var_190_28)

				if var_190_30 > 0 and var_190_24 < var_190_30 then
					arg_187_1.talkMaxDuration = var_190_30

					if var_190_30 + var_190_23 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_30 + var_190_23
					end
				end

				arg_187_1.text_.text = var_190_27
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032046", "story_v_out_425032.awb") ~= 0 then
					local var_190_31 = manager.audio:GetVoiceLength("story_v_out_425032", "425032046", "story_v_out_425032.awb") / 1000

					if var_190_31 + var_190_23 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_31 + var_190_23
					end

					if var_190_26.prefab_name ~= "" and arg_187_1.actors_[var_190_26.prefab_name] ~= nil then
						local var_190_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_26.prefab_name].transform, "story_v_out_425032", "425032046", "story_v_out_425032.awb")

						arg_187_1:RecordAudio("425032046", var_190_32)
						arg_187_1:RecordAudio("425032046", var_190_32)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_425032", "425032046", "story_v_out_425032.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_425032", "425032046", "story_v_out_425032.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_33 = math.max(var_190_24, arg_187_1.talkMaxDuration)

			if var_190_23 <= arg_187_1.time_ and arg_187_1.time_ < var_190_23 + var_190_33 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_23) / var_190_33

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_23 + var_190_33 and arg_187_1.time_ < var_190_23 + var_190_33 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play425032047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 425032047
		arg_191_1.duration_ = 12.73

		local var_191_0 = {
			zh = 7.466,
			ja = 12.733
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play425032048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1086"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.actorSpriteComps1086 == nil then
				arg_191_1.var_.actorSpriteComps1086 = var_194_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_2 = 0.2

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.actorSpriteComps1086 then
					for iter_194_0, iter_194_1 in pairs(arg_191_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_194_1 then
							if arg_191_1.isInRecall_ then
								local var_194_4 = Mathf.Lerp(iter_194_1.color.r, arg_191_1.hightColor1.r, var_194_3)
								local var_194_5 = Mathf.Lerp(iter_194_1.color.g, arg_191_1.hightColor1.g, var_194_3)
								local var_194_6 = Mathf.Lerp(iter_194_1.color.b, arg_191_1.hightColor1.b, var_194_3)

								iter_194_1.color = Color.New(var_194_4, var_194_5, var_194_6)
							else
								local var_194_7 = Mathf.Lerp(iter_194_1.color.r, 1, var_194_3)

								iter_194_1.color = Color.New(var_194_7, var_194_7, var_194_7)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.actorSpriteComps1086 then
				for iter_194_2, iter_194_3 in pairs(arg_191_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_194_3 then
						if arg_191_1.isInRecall_ then
							iter_194_3.color = arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_194_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_191_1.var_.actorSpriteComps1086 = nil
			end

			local var_194_8 = arg_191_1.actors_["1080"]
			local var_194_9 = 0

			if var_194_9 < arg_191_1.time_ and arg_191_1.time_ <= var_194_9 + arg_194_0 and not isNil(var_194_8) and arg_191_1.var_.actorSpriteComps1080 == nil then
				arg_191_1.var_.actorSpriteComps1080 = var_194_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_10 = 0.2

			if var_194_9 <= arg_191_1.time_ and arg_191_1.time_ < var_194_9 + var_194_10 and not isNil(var_194_8) then
				local var_194_11 = (arg_191_1.time_ - var_194_9) / var_194_10

				if arg_191_1.var_.actorSpriteComps1080 then
					for iter_194_4, iter_194_5 in pairs(arg_191_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_194_5 then
							if arg_191_1.isInRecall_ then
								local var_194_12 = Mathf.Lerp(iter_194_5.color.r, arg_191_1.hightColor2.r, var_194_11)
								local var_194_13 = Mathf.Lerp(iter_194_5.color.g, arg_191_1.hightColor2.g, var_194_11)
								local var_194_14 = Mathf.Lerp(iter_194_5.color.b, arg_191_1.hightColor2.b, var_194_11)

								iter_194_5.color = Color.New(var_194_12, var_194_13, var_194_14)
							else
								local var_194_15 = Mathf.Lerp(iter_194_5.color.r, 0.5, var_194_11)

								iter_194_5.color = Color.New(var_194_15, var_194_15, var_194_15)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= var_194_9 + var_194_10 and arg_191_1.time_ < var_194_9 + var_194_10 + arg_194_0 and not isNil(var_194_8) and arg_191_1.var_.actorSpriteComps1080 then
				for iter_194_6, iter_194_7 in pairs(arg_191_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_194_7 then
						if arg_191_1.isInRecall_ then
							iter_194_7.color = arg_191_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_194_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_191_1.var_.actorSpriteComps1080 = nil
			end

			local var_194_16 = arg_191_1.actors_["1086"].transform
			local var_194_17 = 0

			if var_194_17 < arg_191_1.time_ and arg_191_1.time_ <= var_194_17 + arg_194_0 then
				arg_191_1.var_.moveOldPos1086 = var_194_16.localPosition
				var_194_16.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("1086", 2)

				local var_194_18 = var_194_16.childCount

				for iter_194_8 = 0, var_194_18 - 1 do
					local var_194_19 = var_194_16:GetChild(iter_194_8)

					if var_194_19.name == "" or not string.find(var_194_19.name, "split") then
						var_194_19.gameObject:SetActive(true)
					else
						var_194_19.gameObject:SetActive(false)
					end
				end
			end

			local var_194_20 = 0.001

			if var_194_17 <= arg_191_1.time_ and arg_191_1.time_ < var_194_17 + var_194_20 then
				local var_194_21 = (arg_191_1.time_ - var_194_17) / var_194_20
				local var_194_22 = Vector3.New(-390, -404.2, -237.9)

				var_194_16.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1086, var_194_22, var_194_21)
			end

			if arg_191_1.time_ >= var_194_17 + var_194_20 and arg_191_1.time_ < var_194_17 + var_194_20 + arg_194_0 then
				var_194_16.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_194_23 = 0
			local var_194_24 = 0.95

			if var_194_23 < arg_191_1.time_ and arg_191_1.time_ <= var_194_23 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_25 = arg_191_1:FormatText(StoryNameCfg[1080].name)

				arg_191_1.leftNameTxt_.text = var_194_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_26 = arg_191_1:GetWordFromCfg(425032047)
				local var_194_27 = arg_191_1:FormatText(var_194_26.content)

				arg_191_1.text_.text = var_194_27

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_28 = 38
				local var_194_29 = utf8.len(var_194_27)
				local var_194_30 = var_194_28 <= 0 and var_194_24 or var_194_24 * (var_194_29 / var_194_28)

				if var_194_30 > 0 and var_194_24 < var_194_30 then
					arg_191_1.talkMaxDuration = var_194_30

					if var_194_30 + var_194_23 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_30 + var_194_23
					end
				end

				arg_191_1.text_.text = var_194_27
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032047", "story_v_out_425032.awb") ~= 0 then
					local var_194_31 = manager.audio:GetVoiceLength("story_v_out_425032", "425032047", "story_v_out_425032.awb") / 1000

					if var_194_31 + var_194_23 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_31 + var_194_23
					end

					if var_194_26.prefab_name ~= "" and arg_191_1.actors_[var_194_26.prefab_name] ~= nil then
						local var_194_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_26.prefab_name].transform, "story_v_out_425032", "425032047", "story_v_out_425032.awb")

						arg_191_1:RecordAudio("425032047", var_194_32)
						arg_191_1:RecordAudio("425032047", var_194_32)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_425032", "425032047", "story_v_out_425032.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_425032", "425032047", "story_v_out_425032.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_33 = math.max(var_194_24, arg_191_1.talkMaxDuration)

			if var_194_23 <= arg_191_1.time_ and arg_191_1.time_ < var_194_23 + var_194_33 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_23) / var_194_33

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_23 + var_194_33 and arg_191_1.time_ < var_194_23 + var_194_33 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
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

		arg_191_1:InitPlayNodeList()
	end,
	Play425032048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 425032048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play425032049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1086"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos1086 = var_198_0.localPosition
				var_198_0.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("1086", 7)

				local var_198_2 = var_198_0.childCount

				for iter_198_0 = 0, var_198_2 - 1 do
					local var_198_3 = var_198_0:GetChild(iter_198_0)

					if var_198_3.name == "" or not string.find(var_198_3.name, "split") then
						var_198_3.gameObject:SetActive(true)
					else
						var_198_3.gameObject:SetActive(false)
					end
				end
			end

			local var_198_4 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_4 then
				local var_198_5 = (arg_195_1.time_ - var_198_1) / var_198_4
				local var_198_6 = Vector3.New(0, -2000, 0)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1086, var_198_6, var_198_5)
			end

			if arg_195_1.time_ >= var_198_1 + var_198_4 and arg_195_1.time_ < var_198_1 + var_198_4 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_198_7 = arg_195_1.actors_["1080"].transform
			local var_198_8 = 0

			if var_198_8 < arg_195_1.time_ and arg_195_1.time_ <= var_198_8 + arg_198_0 then
				arg_195_1.var_.moveOldPos1080 = var_198_7.localPosition
				var_198_7.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("1080", 7)

				local var_198_9 = var_198_7.childCount

				for iter_198_1 = 0, var_198_9 - 1 do
					local var_198_10 = var_198_7:GetChild(iter_198_1)

					if var_198_10.name == "" or not string.find(var_198_10.name, "split") then
						var_198_10.gameObject:SetActive(true)
					else
						var_198_10.gameObject:SetActive(false)
					end
				end
			end

			local var_198_11 = 0.001

			if var_198_8 <= arg_195_1.time_ and arg_195_1.time_ < var_198_8 + var_198_11 then
				local var_198_12 = (arg_195_1.time_ - var_198_8) / var_198_11
				local var_198_13 = Vector3.New(0, -2000, 0)

				var_198_7.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1080, var_198_13, var_198_12)
			end

			if arg_195_1.time_ >= var_198_8 + var_198_11 and arg_195_1.time_ < var_198_8 + var_198_11 + arg_198_0 then
				var_198_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_198_14 = 0
			local var_198_15 = 1.55

			if var_198_14 < arg_195_1.time_ and arg_195_1.time_ <= var_198_14 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_16 = arg_195_1:GetWordFromCfg(425032048)
				local var_198_17 = arg_195_1:FormatText(var_198_16.content)

				arg_195_1.text_.text = var_198_17

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_18 = 62
				local var_198_19 = utf8.len(var_198_17)
				local var_198_20 = var_198_18 <= 0 and var_198_15 or var_198_15 * (var_198_19 / var_198_18)

				if var_198_20 > 0 and var_198_15 < var_198_20 then
					arg_195_1.talkMaxDuration = var_198_20

					if var_198_20 + var_198_14 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_20 + var_198_14
					end
				end

				arg_195_1.text_.text = var_198_17
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_21 = math.max(var_198_15, arg_195_1.talkMaxDuration)

			if var_198_14 <= arg_195_1.time_ and arg_195_1.time_ < var_198_14 + var_198_21 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_14) / var_198_21

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_14 + var_198_21 and arg_195_1.time_ < var_198_14 + var_198_21 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
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
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play425032049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 425032049
		arg_199_1.duration_ = 5.13

		local var_199_0 = {
			zh = 2.4,
			ja = 5.133
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play425032050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 0.325

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_2 = arg_199_1:FormatText(StoryNameCfg[688].name)

				arg_199_1.leftNameTxt_.text = var_202_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_3 = arg_199_1:GetWordFromCfg(425032049)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 13
				local var_202_6 = utf8.len(var_202_4)
				local var_202_7 = var_202_5 <= 0 and var_202_1 or var_202_1 * (var_202_6 / var_202_5)

				if var_202_7 > 0 and var_202_1 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032049", "story_v_out_425032.awb") ~= 0 then
					local var_202_8 = manager.audio:GetVoiceLength("story_v_out_425032", "425032049", "story_v_out_425032.awb") / 1000

					if var_202_8 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_0
					end

					if var_202_3.prefab_name ~= "" and arg_199_1.actors_[var_202_3.prefab_name] ~= nil then
						local var_202_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_3.prefab_name].transform, "story_v_out_425032", "425032049", "story_v_out_425032.awb")

						arg_199_1:RecordAudio("425032049", var_202_9)
						arg_199_1:RecordAudio("425032049", var_202_9)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_425032", "425032049", "story_v_out_425032.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_425032", "425032049", "story_v_out_425032.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_10 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_10 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_10

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_10 and arg_199_1.time_ < var_202_0 + var_202_10 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play425032050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 425032050
		arg_203_1.duration_ = 2.4

		local var_203_0 = {
			zh = 2.4,
			ja = 2.3
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play425032051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1086"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.actorSpriteComps1086 == nil then
				arg_203_1.var_.actorSpriteComps1086 = var_206_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_2 = 0.2

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.actorSpriteComps1086 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_206_1 then
							if arg_203_1.isInRecall_ then
								local var_206_4 = Mathf.Lerp(iter_206_1.color.r, arg_203_1.hightColor1.r, var_206_3)
								local var_206_5 = Mathf.Lerp(iter_206_1.color.g, arg_203_1.hightColor1.g, var_206_3)
								local var_206_6 = Mathf.Lerp(iter_206_1.color.b, arg_203_1.hightColor1.b, var_206_3)

								iter_206_1.color = Color.New(var_206_4, var_206_5, var_206_6)
							else
								local var_206_7 = Mathf.Lerp(iter_206_1.color.r, 1, var_206_3)

								iter_206_1.color = Color.New(var_206_7, var_206_7, var_206_7)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.actorSpriteComps1086 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_206_3 then
						if arg_203_1.isInRecall_ then
							iter_206_3.color = arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_206_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_203_1.var_.actorSpriteComps1086 = nil
			end

			local var_206_8 = arg_203_1.actors_["1086"].transform
			local var_206_9 = 0

			if var_206_9 < arg_203_1.time_ and arg_203_1.time_ <= var_206_9 + arg_206_0 then
				arg_203_1.var_.moveOldPos1086 = var_206_8.localPosition
				var_206_8.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("1086", 3)

				local var_206_10 = var_206_8.childCount

				for iter_206_4 = 0, var_206_10 - 1 do
					local var_206_11 = var_206_8:GetChild(iter_206_4)

					if var_206_11.name == "split_4" or not string.find(var_206_11.name, "split") then
						var_206_11.gameObject:SetActive(true)
					else
						var_206_11.gameObject:SetActive(false)
					end
				end
			end

			local var_206_12 = 0.001

			if var_206_9 <= arg_203_1.time_ and arg_203_1.time_ < var_206_9 + var_206_12 then
				local var_206_13 = (arg_203_1.time_ - var_206_9) / var_206_12
				local var_206_14 = Vector3.New(0, -404.2, -237.9)

				var_206_8.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1086, var_206_14, var_206_13)
			end

			if arg_203_1.time_ >= var_206_9 + var_206_12 and arg_203_1.time_ < var_206_9 + var_206_12 + arg_206_0 then
				var_206_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_206_15 = 0
			local var_206_16 = 0.225

			if var_206_15 < arg_203_1.time_ and arg_203_1.time_ <= var_206_15 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_17 = arg_203_1:FormatText(StoryNameCfg[1080].name)

				arg_203_1.leftNameTxt_.text = var_206_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_18 = arg_203_1:GetWordFromCfg(425032050)
				local var_206_19 = arg_203_1:FormatText(var_206_18.content)

				arg_203_1.text_.text = var_206_19

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_20 = 9
				local var_206_21 = utf8.len(var_206_19)
				local var_206_22 = var_206_20 <= 0 and var_206_16 or var_206_16 * (var_206_21 / var_206_20)

				if var_206_22 > 0 and var_206_16 < var_206_22 then
					arg_203_1.talkMaxDuration = var_206_22

					if var_206_22 + var_206_15 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_22 + var_206_15
					end
				end

				arg_203_1.text_.text = var_206_19
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032050", "story_v_out_425032.awb") ~= 0 then
					local var_206_23 = manager.audio:GetVoiceLength("story_v_out_425032", "425032050", "story_v_out_425032.awb") / 1000

					if var_206_23 + var_206_15 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_23 + var_206_15
					end

					if var_206_18.prefab_name ~= "" and arg_203_1.actors_[var_206_18.prefab_name] ~= nil then
						local var_206_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_18.prefab_name].transform, "story_v_out_425032", "425032050", "story_v_out_425032.awb")

						arg_203_1:RecordAudio("425032050", var_206_24)
						arg_203_1:RecordAudio("425032050", var_206_24)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_425032", "425032050", "story_v_out_425032.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_425032", "425032050", "story_v_out_425032.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_25 = math.max(var_206_16, arg_203_1.talkMaxDuration)

			if var_206_15 <= arg_203_1.time_ and arg_203_1.time_ < var_206_15 + var_206_25 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_15) / var_206_25

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_15 + var_206_25 and arg_203_1.time_ < var_206_15 + var_206_25 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
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

		arg_203_1:InitPlayNodeList()
	end,
	Play425032051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 425032051
		arg_207_1.duration_ = 4.33

		local var_207_0 = {
			zh = 3.266,
			ja = 4.333
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play425032052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1086"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos1086 = var_210_0.localPosition
				var_210_0.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("1086", 3)

				local var_210_2 = var_210_0.childCount

				for iter_210_0 = 0, var_210_2 - 1 do
					local var_210_3 = var_210_0:GetChild(iter_210_0)

					if var_210_3.name == "split_1" then
						var_210_3:SetAsLastSibling()
						var_210_3.gameObject:SetActive(true)

						arg_207_1.var_.actorSpriteSplit1086 = var_210_3.gameObject:GetComponent(typeof(Image))

						arg_207_1.var_.actorSpriteSplit1086:SetAlpha(0)
					end
				end
			end

			local var_210_4 = 0.5

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_4 then
				local var_210_5 = (arg_207_1.time_ - var_210_1) / var_210_4
				local var_210_6 = Vector3.New(0, -404.2, -237.9)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1086, var_210_6, var_210_5)

				if arg_207_1.var_.actorSpriteSplit1086 ~= nil then
					arg_207_1.var_.actorSpriteSplit1086:SetAlpha(var_210_5)
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_4 and arg_207_1.time_ < var_210_1 + var_210_4 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(0, -404.2, -237.9)

				if arg_207_1.var_.actorSpriteSplit1086 ~= nil then
					arg_207_1.var_.actorSpriteSplit1086:SetAlpha(1)
				end
			end

			local var_210_7 = 0
			local var_210_8 = 0.5

			if var_210_7 < arg_207_1.time_ and arg_207_1.time_ <= var_210_7 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_9 = arg_207_1:FormatText(StoryNameCfg[1080].name)

				arg_207_1.leftNameTxt_.text = var_210_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_10 = arg_207_1:GetWordFromCfg(425032051)
				local var_210_11 = arg_207_1:FormatText(var_210_10.content)

				arg_207_1.text_.text = var_210_11

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_12 = 20
				local var_210_13 = utf8.len(var_210_11)
				local var_210_14 = var_210_12 <= 0 and var_210_8 or var_210_8 * (var_210_13 / var_210_12)

				if var_210_14 > 0 and var_210_8 < var_210_14 then
					arg_207_1.talkMaxDuration = var_210_14

					if var_210_14 + var_210_7 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_14 + var_210_7
					end
				end

				arg_207_1.text_.text = var_210_11
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032051", "story_v_out_425032.awb") ~= 0 then
					local var_210_15 = manager.audio:GetVoiceLength("story_v_out_425032", "425032051", "story_v_out_425032.awb") / 1000

					if var_210_15 + var_210_7 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_15 + var_210_7
					end

					if var_210_10.prefab_name ~= "" and arg_207_1.actors_[var_210_10.prefab_name] ~= nil then
						local var_210_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_10.prefab_name].transform, "story_v_out_425032", "425032051", "story_v_out_425032.awb")

						arg_207_1:RecordAudio("425032051", var_210_16)
						arg_207_1:RecordAudio("425032051", var_210_16)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_425032", "425032051", "story_v_out_425032.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_425032", "425032051", "story_v_out_425032.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_17 = math.max(var_210_8, arg_207_1.talkMaxDuration)

			if var_210_7 <= arg_207_1.time_ and arg_207_1.time_ < var_210_7 + var_210_17 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_7) / var_210_17

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_7 + var_210_17 and arg_207_1.time_ < var_210_7 + var_210_17 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play425032052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 425032052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play425032053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1086"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos1086 = var_214_0.localPosition
				var_214_0.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("1086", 7)

				local var_214_2 = var_214_0.childCount

				for iter_214_0 = 0, var_214_2 - 1 do
					local var_214_3 = var_214_0:GetChild(iter_214_0)

					if var_214_3.name == "" or not string.find(var_214_3.name, "split") then
						var_214_3.gameObject:SetActive(true)
					else
						var_214_3.gameObject:SetActive(false)
					end
				end
			end

			local var_214_4 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_4 then
				local var_214_5 = (arg_211_1.time_ - var_214_1) / var_214_4
				local var_214_6 = Vector3.New(0, -2000, 0)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1086, var_214_6, var_214_5)
			end

			if arg_211_1.time_ >= var_214_1 + var_214_4 and arg_211_1.time_ < var_214_1 + var_214_4 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_214_7 = 0
			local var_214_8 = 0.775

			if var_214_7 < arg_211_1.time_ and arg_211_1.time_ <= var_214_7 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_9 = arg_211_1:GetWordFromCfg(425032052)
				local var_214_10 = arg_211_1:FormatText(var_214_9.content)

				arg_211_1.text_.text = var_214_10

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_11 = 31
				local var_214_12 = utf8.len(var_214_10)
				local var_214_13 = var_214_11 <= 0 and var_214_8 or var_214_8 * (var_214_12 / var_214_11)

				if var_214_13 > 0 and var_214_8 < var_214_13 then
					arg_211_1.talkMaxDuration = var_214_13

					if var_214_13 + var_214_7 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_13 + var_214_7
					end
				end

				arg_211_1.text_.text = var_214_10
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_14 = math.max(var_214_8, arg_211_1.talkMaxDuration)

			if var_214_7 <= arg_211_1.time_ and arg_211_1.time_ < var_214_7 + var_214_14 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_7) / var_214_14

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_7 + var_214_14 and arg_211_1.time_ < var_214_7 + var_214_14 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
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

		arg_211_1:InitPlayNodeList()
	end,
	Play425032053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 425032053
		arg_215_1.duration_ = 4.03

		local var_215_0 = {
			zh = 1.533,
			ja = 4.033
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play425032054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1080"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.actorSpriteComps1080 == nil then
				arg_215_1.var_.actorSpriteComps1080 = var_218_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_2 = 0.2

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.actorSpriteComps1080 then
					for iter_218_0, iter_218_1 in pairs(arg_215_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_218_1 then
							if arg_215_1.isInRecall_ then
								local var_218_4 = Mathf.Lerp(iter_218_1.color.r, arg_215_1.hightColor1.r, var_218_3)
								local var_218_5 = Mathf.Lerp(iter_218_1.color.g, arg_215_1.hightColor1.g, var_218_3)
								local var_218_6 = Mathf.Lerp(iter_218_1.color.b, arg_215_1.hightColor1.b, var_218_3)

								iter_218_1.color = Color.New(var_218_4, var_218_5, var_218_6)
							else
								local var_218_7 = Mathf.Lerp(iter_218_1.color.r, 1, var_218_3)

								iter_218_1.color = Color.New(var_218_7, var_218_7, var_218_7)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.actorSpriteComps1080 then
				for iter_218_2, iter_218_3 in pairs(arg_215_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_218_3 then
						if arg_215_1.isInRecall_ then
							iter_218_3.color = arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_218_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_215_1.var_.actorSpriteComps1080 = nil
			end

			local var_218_8 = arg_215_1.actors_["1080"].transform
			local var_218_9 = 0

			if var_218_9 < arg_215_1.time_ and arg_215_1.time_ <= var_218_9 + arg_218_0 then
				arg_215_1.var_.moveOldPos1080 = var_218_8.localPosition
				var_218_8.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("1080", 2)

				local var_218_10 = var_218_8.childCount

				for iter_218_4 = 0, var_218_10 - 1 do
					local var_218_11 = var_218_8:GetChild(iter_218_4)

					if var_218_11.name == "" or not string.find(var_218_11.name, "split") then
						var_218_11.gameObject:SetActive(true)
					else
						var_218_11.gameObject:SetActive(false)
					end
				end
			end

			local var_218_12 = 0.001

			if var_218_9 <= arg_215_1.time_ and arg_215_1.time_ < var_218_9 + var_218_12 then
				local var_218_13 = (arg_215_1.time_ - var_218_9) / var_218_12
				local var_218_14 = Vector3.New(-390, -378, -170)

				var_218_8.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1080, var_218_14, var_218_13)
			end

			if arg_215_1.time_ >= var_218_9 + var_218_12 and arg_215_1.time_ < var_218_9 + var_218_12 + arg_218_0 then
				var_218_8.localPosition = Vector3.New(-390, -378, -170)
			end

			local var_218_15 = 0
			local var_218_16 = 0.25

			if var_218_15 < arg_215_1.time_ and arg_215_1.time_ <= var_218_15 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_17 = arg_215_1:FormatText(StoryNameCfg[55].name)

				arg_215_1.leftNameTxt_.text = var_218_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_18 = arg_215_1:GetWordFromCfg(425032053)
				local var_218_19 = arg_215_1:FormatText(var_218_18.content)

				arg_215_1.text_.text = var_218_19

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_20 = 10
				local var_218_21 = utf8.len(var_218_19)
				local var_218_22 = var_218_20 <= 0 and var_218_16 or var_218_16 * (var_218_21 / var_218_20)

				if var_218_22 > 0 and var_218_16 < var_218_22 then
					arg_215_1.talkMaxDuration = var_218_22

					if var_218_22 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_22 + var_218_15
					end
				end

				arg_215_1.text_.text = var_218_19
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032053", "story_v_out_425032.awb") ~= 0 then
					local var_218_23 = manager.audio:GetVoiceLength("story_v_out_425032", "425032053", "story_v_out_425032.awb") / 1000

					if var_218_23 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_23 + var_218_15
					end

					if var_218_18.prefab_name ~= "" and arg_215_1.actors_[var_218_18.prefab_name] ~= nil then
						local var_218_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_18.prefab_name].transform, "story_v_out_425032", "425032053", "story_v_out_425032.awb")

						arg_215_1:RecordAudio("425032053", var_218_24)
						arg_215_1:RecordAudio("425032053", var_218_24)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_425032", "425032053", "story_v_out_425032.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_425032", "425032053", "story_v_out_425032.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_25 = math.max(var_218_16, arg_215_1.talkMaxDuration)

			if var_218_15 <= arg_215_1.time_ and arg_215_1.time_ < var_218_15 + var_218_25 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_15) / var_218_25

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_15 + var_218_25 and arg_215_1.time_ < var_218_15 + var_218_25 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play425032054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 425032054
		arg_219_1.duration_ = 5.03

		local var_219_0 = {
			zh = 3.366,
			ja = 5.033
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play425032055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1137"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.actorSpriteComps1137 == nil then
				arg_219_1.var_.actorSpriteComps1137 = var_222_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_2 = 0.2

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 and not isNil(var_222_0) then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2

				if arg_219_1.var_.actorSpriteComps1137 then
					for iter_222_0, iter_222_1 in pairs(arg_219_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_222_1 then
							if arg_219_1.isInRecall_ then
								local var_222_4 = Mathf.Lerp(iter_222_1.color.r, arg_219_1.hightColor1.r, var_222_3)
								local var_222_5 = Mathf.Lerp(iter_222_1.color.g, arg_219_1.hightColor1.g, var_222_3)
								local var_222_6 = Mathf.Lerp(iter_222_1.color.b, arg_219_1.hightColor1.b, var_222_3)

								iter_222_1.color = Color.New(var_222_4, var_222_5, var_222_6)
							else
								local var_222_7 = Mathf.Lerp(iter_222_1.color.r, 1, var_222_3)

								iter_222_1.color = Color.New(var_222_7, var_222_7, var_222_7)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.actorSpriteComps1137 then
				for iter_222_2, iter_222_3 in pairs(arg_219_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_222_3 then
						if arg_219_1.isInRecall_ then
							iter_222_3.color = arg_219_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_222_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_219_1.var_.actorSpriteComps1137 = nil
			end

			local var_222_8 = arg_219_1.actors_["1080"]
			local var_222_9 = 0

			if var_222_9 < arg_219_1.time_ and arg_219_1.time_ <= var_222_9 + arg_222_0 and not isNil(var_222_8) and arg_219_1.var_.actorSpriteComps1080 == nil then
				arg_219_1.var_.actorSpriteComps1080 = var_222_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_10 = 0.2

			if var_222_9 <= arg_219_1.time_ and arg_219_1.time_ < var_222_9 + var_222_10 and not isNil(var_222_8) then
				local var_222_11 = (arg_219_1.time_ - var_222_9) / var_222_10

				if arg_219_1.var_.actorSpriteComps1080 then
					for iter_222_4, iter_222_5 in pairs(arg_219_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_222_5 then
							if arg_219_1.isInRecall_ then
								local var_222_12 = Mathf.Lerp(iter_222_5.color.r, arg_219_1.hightColor2.r, var_222_11)
								local var_222_13 = Mathf.Lerp(iter_222_5.color.g, arg_219_1.hightColor2.g, var_222_11)
								local var_222_14 = Mathf.Lerp(iter_222_5.color.b, arg_219_1.hightColor2.b, var_222_11)

								iter_222_5.color = Color.New(var_222_12, var_222_13, var_222_14)
							else
								local var_222_15 = Mathf.Lerp(iter_222_5.color.r, 0.5, var_222_11)

								iter_222_5.color = Color.New(var_222_15, var_222_15, var_222_15)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= var_222_9 + var_222_10 and arg_219_1.time_ < var_222_9 + var_222_10 + arg_222_0 and not isNil(var_222_8) and arg_219_1.var_.actorSpriteComps1080 then
				for iter_222_6, iter_222_7 in pairs(arg_219_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_222_7 then
						if arg_219_1.isInRecall_ then
							iter_222_7.color = arg_219_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_222_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_219_1.var_.actorSpriteComps1080 = nil
			end

			local var_222_16 = arg_219_1.actors_["1137"].transform
			local var_222_17 = 0

			if var_222_17 < arg_219_1.time_ and arg_219_1.time_ <= var_222_17 + arg_222_0 then
				arg_219_1.var_.moveOldPos1137 = var_222_16.localPosition
				var_222_16.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("1137", 4)

				local var_222_18 = var_222_16.childCount

				for iter_222_8 = 0, var_222_18 - 1 do
					local var_222_19 = var_222_16:GetChild(iter_222_8)

					if var_222_19.name == "" or not string.find(var_222_19.name, "split") then
						var_222_19.gameObject:SetActive(true)
					else
						var_222_19.gameObject:SetActive(false)
					end
				end
			end

			local var_222_20 = 0.001

			if var_222_17 <= arg_219_1.time_ and arg_219_1.time_ < var_222_17 + var_222_20 then
				local var_222_21 = (arg_219_1.time_ - var_222_17) / var_222_20
				local var_222_22 = Vector3.New(390, -425, -200)

				var_222_16.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1137, var_222_22, var_222_21)
			end

			if arg_219_1.time_ >= var_222_17 + var_222_20 and arg_219_1.time_ < var_222_17 + var_222_20 + arg_222_0 then
				var_222_16.localPosition = Vector3.New(390, -425, -200)
			end

			local var_222_23 = 0
			local var_222_24 = 0.2

			if var_222_23 < arg_219_1.time_ and arg_219_1.time_ <= var_222_23 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_25 = arg_219_1:FormatText(StoryNameCfg[15].name)

				arg_219_1.leftNameTxt_.text = var_222_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_26 = arg_219_1:GetWordFromCfg(425032054)
				local var_222_27 = arg_219_1:FormatText(var_222_26.content)

				arg_219_1.text_.text = var_222_27

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_28 = 8
				local var_222_29 = utf8.len(var_222_27)
				local var_222_30 = var_222_28 <= 0 and var_222_24 or var_222_24 * (var_222_29 / var_222_28)

				if var_222_30 > 0 and var_222_24 < var_222_30 then
					arg_219_1.talkMaxDuration = var_222_30

					if var_222_30 + var_222_23 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_30 + var_222_23
					end
				end

				arg_219_1.text_.text = var_222_27
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032054", "story_v_out_425032.awb") ~= 0 then
					local var_222_31 = manager.audio:GetVoiceLength("story_v_out_425032", "425032054", "story_v_out_425032.awb") / 1000

					if var_222_31 + var_222_23 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_31 + var_222_23
					end

					if var_222_26.prefab_name ~= "" and arg_219_1.actors_[var_222_26.prefab_name] ~= nil then
						local var_222_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_26.prefab_name].transform, "story_v_out_425032", "425032054", "story_v_out_425032.awb")

						arg_219_1:RecordAudio("425032054", var_222_32)
						arg_219_1:RecordAudio("425032054", var_222_32)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_425032", "425032054", "story_v_out_425032.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_425032", "425032054", "story_v_out_425032.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_33 = math.max(var_222_24, arg_219_1.talkMaxDuration)

			if var_222_23 <= arg_219_1.time_ and arg_219_1.time_ < var_222_23 + var_222_33 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_23) / var_222_33

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_23 + var_222_33 and arg_219_1.time_ < var_222_23 + var_222_33 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play425032055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 425032055
		arg_223_1.duration_ = 1.4

		local var_223_0 = {
			zh = 0.999999999999,
			ja = 1.4
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play425032056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1080"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.actorSpriteComps1080 == nil then
				arg_223_1.var_.actorSpriteComps1080 = var_226_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_2 = 0.2

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.actorSpriteComps1080 then
					for iter_226_0, iter_226_1 in pairs(arg_223_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_226_1 then
							if arg_223_1.isInRecall_ then
								local var_226_4 = Mathf.Lerp(iter_226_1.color.r, arg_223_1.hightColor1.r, var_226_3)
								local var_226_5 = Mathf.Lerp(iter_226_1.color.g, arg_223_1.hightColor1.g, var_226_3)
								local var_226_6 = Mathf.Lerp(iter_226_1.color.b, arg_223_1.hightColor1.b, var_226_3)

								iter_226_1.color = Color.New(var_226_4, var_226_5, var_226_6)
							else
								local var_226_7 = Mathf.Lerp(iter_226_1.color.r, 1, var_226_3)

								iter_226_1.color = Color.New(var_226_7, var_226_7, var_226_7)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.actorSpriteComps1080 then
				for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_226_3 then
						if arg_223_1.isInRecall_ then
							iter_226_3.color = arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_226_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_223_1.var_.actorSpriteComps1080 = nil
			end

			local var_226_8 = arg_223_1.actors_["1137"]
			local var_226_9 = 0

			if var_226_9 < arg_223_1.time_ and arg_223_1.time_ <= var_226_9 + arg_226_0 and not isNil(var_226_8) and arg_223_1.var_.actorSpriteComps1137 == nil then
				arg_223_1.var_.actorSpriteComps1137 = var_226_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_10 = 0.2

			if var_226_9 <= arg_223_1.time_ and arg_223_1.time_ < var_226_9 + var_226_10 and not isNil(var_226_8) then
				local var_226_11 = (arg_223_1.time_ - var_226_9) / var_226_10

				if arg_223_1.var_.actorSpriteComps1137 then
					for iter_226_4, iter_226_5 in pairs(arg_223_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_226_5 then
							if arg_223_1.isInRecall_ then
								local var_226_12 = Mathf.Lerp(iter_226_5.color.r, arg_223_1.hightColor2.r, var_226_11)
								local var_226_13 = Mathf.Lerp(iter_226_5.color.g, arg_223_1.hightColor2.g, var_226_11)
								local var_226_14 = Mathf.Lerp(iter_226_5.color.b, arg_223_1.hightColor2.b, var_226_11)

								iter_226_5.color = Color.New(var_226_12, var_226_13, var_226_14)
							else
								local var_226_15 = Mathf.Lerp(iter_226_5.color.r, 0.5, var_226_11)

								iter_226_5.color = Color.New(var_226_15, var_226_15, var_226_15)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= var_226_9 + var_226_10 and arg_223_1.time_ < var_226_9 + var_226_10 + arg_226_0 and not isNil(var_226_8) and arg_223_1.var_.actorSpriteComps1137 then
				for iter_226_6, iter_226_7 in pairs(arg_223_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_226_7 then
						if arg_223_1.isInRecall_ then
							iter_226_7.color = arg_223_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_226_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_223_1.var_.actorSpriteComps1137 = nil
			end

			local var_226_16 = arg_223_1.actors_["1080"].transform
			local var_226_17 = 0

			if var_226_17 < arg_223_1.time_ and arg_223_1.time_ <= var_226_17 + arg_226_0 then
				arg_223_1.var_.moveOldPos1080 = var_226_16.localPosition
				var_226_16.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("1080", 2)

				local var_226_18 = var_226_16.childCount

				for iter_226_8 = 0, var_226_18 - 1 do
					local var_226_19 = var_226_16:GetChild(iter_226_8)

					if var_226_19.name == "" or not string.find(var_226_19.name, "split") then
						var_226_19.gameObject:SetActive(true)
					else
						var_226_19.gameObject:SetActive(false)
					end
				end
			end

			local var_226_20 = 0.001

			if var_226_17 <= arg_223_1.time_ and arg_223_1.time_ < var_226_17 + var_226_20 then
				local var_226_21 = (arg_223_1.time_ - var_226_17) / var_226_20
				local var_226_22 = Vector3.New(-390, -378, -170)

				var_226_16.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1080, var_226_22, var_226_21)
			end

			if arg_223_1.time_ >= var_226_17 + var_226_20 and arg_223_1.time_ < var_226_17 + var_226_20 + arg_226_0 then
				var_226_16.localPosition = Vector3.New(-390, -378, -170)
			end

			local var_226_23 = 0
			local var_226_24 = 0.125

			if var_226_23 < arg_223_1.time_ and arg_223_1.time_ <= var_226_23 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_25 = arg_223_1:FormatText(StoryNameCfg[55].name)

				arg_223_1.leftNameTxt_.text = var_226_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_26 = arg_223_1:GetWordFromCfg(425032055)
				local var_226_27 = arg_223_1:FormatText(var_226_26.content)

				arg_223_1.text_.text = var_226_27

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_28 = 5
				local var_226_29 = utf8.len(var_226_27)
				local var_226_30 = var_226_28 <= 0 and var_226_24 or var_226_24 * (var_226_29 / var_226_28)

				if var_226_30 > 0 and var_226_24 < var_226_30 then
					arg_223_1.talkMaxDuration = var_226_30

					if var_226_30 + var_226_23 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_30 + var_226_23
					end
				end

				arg_223_1.text_.text = var_226_27
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032055", "story_v_out_425032.awb") ~= 0 then
					local var_226_31 = manager.audio:GetVoiceLength("story_v_out_425032", "425032055", "story_v_out_425032.awb") / 1000

					if var_226_31 + var_226_23 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_31 + var_226_23
					end

					if var_226_26.prefab_name ~= "" and arg_223_1.actors_[var_226_26.prefab_name] ~= nil then
						local var_226_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_26.prefab_name].transform, "story_v_out_425032", "425032055", "story_v_out_425032.awb")

						arg_223_1:RecordAudio("425032055", var_226_32)
						arg_223_1:RecordAudio("425032055", var_226_32)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_425032", "425032055", "story_v_out_425032.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_425032", "425032055", "story_v_out_425032.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_33 = math.max(var_226_24, arg_223_1.talkMaxDuration)

			if var_226_23 <= arg_223_1.time_ and arg_223_1.time_ < var_226_23 + var_226_33 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_23) / var_226_33

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_23 + var_226_33 and arg_223_1.time_ < var_226_23 + var_226_33 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play425032056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 425032056
		arg_227_1.duration_ = 2.9

		local var_227_0 = {
			zh = 1.466,
			ja = 2.9
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play425032057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1137"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.actorSpriteComps1137 == nil then
				arg_227_1.var_.actorSpriteComps1137 = var_230_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_2 = 0.2

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.actorSpriteComps1137 then
					for iter_230_0, iter_230_1 in pairs(arg_227_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_230_1 then
							if arg_227_1.isInRecall_ then
								local var_230_4 = Mathf.Lerp(iter_230_1.color.r, arg_227_1.hightColor1.r, var_230_3)
								local var_230_5 = Mathf.Lerp(iter_230_1.color.g, arg_227_1.hightColor1.g, var_230_3)
								local var_230_6 = Mathf.Lerp(iter_230_1.color.b, arg_227_1.hightColor1.b, var_230_3)

								iter_230_1.color = Color.New(var_230_4, var_230_5, var_230_6)
							else
								local var_230_7 = Mathf.Lerp(iter_230_1.color.r, 1, var_230_3)

								iter_230_1.color = Color.New(var_230_7, var_230_7, var_230_7)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.actorSpriteComps1137 then
				for iter_230_2, iter_230_3 in pairs(arg_227_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_230_3 then
						if arg_227_1.isInRecall_ then
							iter_230_3.color = arg_227_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_230_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_227_1.var_.actorSpriteComps1137 = nil
			end

			local var_230_8 = arg_227_1.actors_["1080"]
			local var_230_9 = 0

			if var_230_9 < arg_227_1.time_ and arg_227_1.time_ <= var_230_9 + arg_230_0 and not isNil(var_230_8) and arg_227_1.var_.actorSpriteComps1080 == nil then
				arg_227_1.var_.actorSpriteComps1080 = var_230_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_10 = 0.2

			if var_230_9 <= arg_227_1.time_ and arg_227_1.time_ < var_230_9 + var_230_10 and not isNil(var_230_8) then
				local var_230_11 = (arg_227_1.time_ - var_230_9) / var_230_10

				if arg_227_1.var_.actorSpriteComps1080 then
					for iter_230_4, iter_230_5 in pairs(arg_227_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_230_5 then
							if arg_227_1.isInRecall_ then
								local var_230_12 = Mathf.Lerp(iter_230_5.color.r, arg_227_1.hightColor2.r, var_230_11)
								local var_230_13 = Mathf.Lerp(iter_230_5.color.g, arg_227_1.hightColor2.g, var_230_11)
								local var_230_14 = Mathf.Lerp(iter_230_5.color.b, arg_227_1.hightColor2.b, var_230_11)

								iter_230_5.color = Color.New(var_230_12, var_230_13, var_230_14)
							else
								local var_230_15 = Mathf.Lerp(iter_230_5.color.r, 0.5, var_230_11)

								iter_230_5.color = Color.New(var_230_15, var_230_15, var_230_15)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= var_230_9 + var_230_10 and arg_227_1.time_ < var_230_9 + var_230_10 + arg_230_0 and not isNil(var_230_8) and arg_227_1.var_.actorSpriteComps1080 then
				for iter_230_6, iter_230_7 in pairs(arg_227_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_230_7 then
						if arg_227_1.isInRecall_ then
							iter_230_7.color = arg_227_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_230_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_227_1.var_.actorSpriteComps1080 = nil
			end

			local var_230_16 = arg_227_1.actors_["1137"].transform
			local var_230_17 = 0

			if var_230_17 < arg_227_1.time_ and arg_227_1.time_ <= var_230_17 + arg_230_0 then
				arg_227_1.var_.moveOldPos1137 = var_230_16.localPosition
				var_230_16.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("1137", 4)

				local var_230_18 = var_230_16.childCount

				for iter_230_8 = 0, var_230_18 - 1 do
					local var_230_19 = var_230_16:GetChild(iter_230_8)

					if var_230_19.name == "split_4" then
						var_230_19:SetAsLastSibling()
						var_230_19.gameObject:SetActive(true)

						arg_227_1.var_.actorSpriteSplit1137 = var_230_19.gameObject:GetComponent(typeof(Image))

						arg_227_1.var_.actorSpriteSplit1137:SetAlpha(0)
					end
				end
			end

			local var_230_20 = 0.5

			if var_230_17 <= arg_227_1.time_ and arg_227_1.time_ < var_230_17 + var_230_20 then
				local var_230_21 = (arg_227_1.time_ - var_230_17) / var_230_20
				local var_230_22 = Vector3.New(390, -425, -200)

				var_230_16.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1137, var_230_22, var_230_21)

				if arg_227_1.var_.actorSpriteSplit1137 ~= nil then
					arg_227_1.var_.actorSpriteSplit1137:SetAlpha(var_230_21)
				end
			end

			if arg_227_1.time_ >= var_230_17 + var_230_20 and arg_227_1.time_ < var_230_17 + var_230_20 + arg_230_0 then
				var_230_16.localPosition = Vector3.New(390, -425, -200)

				if arg_227_1.var_.actorSpriteSplit1137 ~= nil then
					arg_227_1.var_.actorSpriteSplit1137:SetAlpha(1)
				end
			end

			local var_230_23 = 0
			local var_230_24 = 0.125

			if var_230_23 < arg_227_1.time_ and arg_227_1.time_ <= var_230_23 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_25 = arg_227_1:FormatText(StoryNameCfg[15].name)

				arg_227_1.leftNameTxt_.text = var_230_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_26 = arg_227_1:GetWordFromCfg(425032056)
				local var_230_27 = arg_227_1:FormatText(var_230_26.content)

				arg_227_1.text_.text = var_230_27

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_28 = 5
				local var_230_29 = utf8.len(var_230_27)
				local var_230_30 = var_230_28 <= 0 and var_230_24 or var_230_24 * (var_230_29 / var_230_28)

				if var_230_30 > 0 and var_230_24 < var_230_30 then
					arg_227_1.talkMaxDuration = var_230_30

					if var_230_30 + var_230_23 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_30 + var_230_23
					end
				end

				arg_227_1.text_.text = var_230_27
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032056", "story_v_out_425032.awb") ~= 0 then
					local var_230_31 = manager.audio:GetVoiceLength("story_v_out_425032", "425032056", "story_v_out_425032.awb") / 1000

					if var_230_31 + var_230_23 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_31 + var_230_23
					end

					if var_230_26.prefab_name ~= "" and arg_227_1.actors_[var_230_26.prefab_name] ~= nil then
						local var_230_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_26.prefab_name].transform, "story_v_out_425032", "425032056", "story_v_out_425032.awb")

						arg_227_1:RecordAudio("425032056", var_230_32)
						arg_227_1:RecordAudio("425032056", var_230_32)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_425032", "425032056", "story_v_out_425032.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_425032", "425032056", "story_v_out_425032.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_33 = math.max(var_230_24, arg_227_1.talkMaxDuration)

			if var_230_23 <= arg_227_1.time_ and arg_227_1.time_ < var_230_23 + var_230_33 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_23) / var_230_33

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_23 + var_230_33 and arg_227_1.time_ < var_230_23 + var_230_33 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play425032057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 425032057
		arg_231_1.duration_ = 7.13

		local var_231_0 = {
			zh = 3.9,
			ja = 7.133
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play425032058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1080"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps1080 == nil then
				arg_231_1.var_.actorSpriteComps1080 = var_234_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_2 = 0.2

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.actorSpriteComps1080 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_234_1 then
							if arg_231_1.isInRecall_ then
								local var_234_4 = Mathf.Lerp(iter_234_1.color.r, arg_231_1.hightColor1.r, var_234_3)
								local var_234_5 = Mathf.Lerp(iter_234_1.color.g, arg_231_1.hightColor1.g, var_234_3)
								local var_234_6 = Mathf.Lerp(iter_234_1.color.b, arg_231_1.hightColor1.b, var_234_3)

								iter_234_1.color = Color.New(var_234_4, var_234_5, var_234_6)
							else
								local var_234_7 = Mathf.Lerp(iter_234_1.color.r, 1, var_234_3)

								iter_234_1.color = Color.New(var_234_7, var_234_7, var_234_7)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps1080 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_234_3 then
						if arg_231_1.isInRecall_ then
							iter_234_3.color = arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_234_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps1080 = nil
			end

			local var_234_8 = arg_231_1.actors_["1137"]
			local var_234_9 = 0

			if var_234_9 < arg_231_1.time_ and arg_231_1.time_ <= var_234_9 + arg_234_0 and not isNil(var_234_8) and arg_231_1.var_.actorSpriteComps1137 == nil then
				arg_231_1.var_.actorSpriteComps1137 = var_234_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_10 = 0.2

			if var_234_9 <= arg_231_1.time_ and arg_231_1.time_ < var_234_9 + var_234_10 and not isNil(var_234_8) then
				local var_234_11 = (arg_231_1.time_ - var_234_9) / var_234_10

				if arg_231_1.var_.actorSpriteComps1137 then
					for iter_234_4, iter_234_5 in pairs(arg_231_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_234_5 then
							if arg_231_1.isInRecall_ then
								local var_234_12 = Mathf.Lerp(iter_234_5.color.r, arg_231_1.hightColor2.r, var_234_11)
								local var_234_13 = Mathf.Lerp(iter_234_5.color.g, arg_231_1.hightColor2.g, var_234_11)
								local var_234_14 = Mathf.Lerp(iter_234_5.color.b, arg_231_1.hightColor2.b, var_234_11)

								iter_234_5.color = Color.New(var_234_12, var_234_13, var_234_14)
							else
								local var_234_15 = Mathf.Lerp(iter_234_5.color.r, 0.5, var_234_11)

								iter_234_5.color = Color.New(var_234_15, var_234_15, var_234_15)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= var_234_9 + var_234_10 and arg_231_1.time_ < var_234_9 + var_234_10 + arg_234_0 and not isNil(var_234_8) and arg_231_1.var_.actorSpriteComps1137 then
				for iter_234_6, iter_234_7 in pairs(arg_231_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_234_7 then
						if arg_231_1.isInRecall_ then
							iter_234_7.color = arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_234_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps1137 = nil
			end

			local var_234_16 = arg_231_1.actors_["1080"].transform
			local var_234_17 = 0

			if var_234_17 < arg_231_1.time_ and arg_231_1.time_ <= var_234_17 + arg_234_0 then
				arg_231_1.var_.moveOldPos1080 = var_234_16.localPosition
				var_234_16.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("1080", 2)

				local var_234_18 = var_234_16.childCount

				for iter_234_8 = 0, var_234_18 - 1 do
					local var_234_19 = var_234_16:GetChild(iter_234_8)

					if var_234_19.name == "" or not string.find(var_234_19.name, "split") then
						var_234_19.gameObject:SetActive(true)
					else
						var_234_19.gameObject:SetActive(false)
					end
				end
			end

			local var_234_20 = 0.001

			if var_234_17 <= arg_231_1.time_ and arg_231_1.time_ < var_234_17 + var_234_20 then
				local var_234_21 = (arg_231_1.time_ - var_234_17) / var_234_20
				local var_234_22 = Vector3.New(-390, -378, -170)

				var_234_16.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1080, var_234_22, var_234_21)
			end

			if arg_231_1.time_ >= var_234_17 + var_234_20 and arg_231_1.time_ < var_234_17 + var_234_20 + arg_234_0 then
				var_234_16.localPosition = Vector3.New(-390, -378, -170)
			end

			local var_234_23 = 0
			local var_234_24 = 0.4

			if var_234_23 < arg_231_1.time_ and arg_231_1.time_ <= var_234_23 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_25 = arg_231_1:FormatText(StoryNameCfg[55].name)

				arg_231_1.leftNameTxt_.text = var_234_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_26 = arg_231_1:GetWordFromCfg(425032057)
				local var_234_27 = arg_231_1:FormatText(var_234_26.content)

				arg_231_1.text_.text = var_234_27

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_28 = 16
				local var_234_29 = utf8.len(var_234_27)
				local var_234_30 = var_234_28 <= 0 and var_234_24 or var_234_24 * (var_234_29 / var_234_28)

				if var_234_30 > 0 and var_234_24 < var_234_30 then
					arg_231_1.talkMaxDuration = var_234_30

					if var_234_30 + var_234_23 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_30 + var_234_23
					end
				end

				arg_231_1.text_.text = var_234_27
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032057", "story_v_out_425032.awb") ~= 0 then
					local var_234_31 = manager.audio:GetVoiceLength("story_v_out_425032", "425032057", "story_v_out_425032.awb") / 1000

					if var_234_31 + var_234_23 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_31 + var_234_23
					end

					if var_234_26.prefab_name ~= "" and arg_231_1.actors_[var_234_26.prefab_name] ~= nil then
						local var_234_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_26.prefab_name].transform, "story_v_out_425032", "425032057", "story_v_out_425032.awb")

						arg_231_1:RecordAudio("425032057", var_234_32)
						arg_231_1:RecordAudio("425032057", var_234_32)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_425032", "425032057", "story_v_out_425032.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_425032", "425032057", "story_v_out_425032.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_33 = math.max(var_234_24, arg_231_1.talkMaxDuration)

			if var_234_23 <= arg_231_1.time_ and arg_231_1.time_ < var_234_23 + var_234_33 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_23) / var_234_33

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_23 + var_234_33 and arg_231_1.time_ < var_234_23 + var_234_33 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play425032058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 425032058
		arg_235_1.duration_ = 5.13

		local var_235_0 = {
			zh = 4.1,
			ja = 5.133
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play425032059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1137"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps1137 == nil then
				arg_235_1.var_.actorSpriteComps1137 = var_238_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_2 = 0.2

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.actorSpriteComps1137 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_238_1 then
							if arg_235_1.isInRecall_ then
								local var_238_4 = Mathf.Lerp(iter_238_1.color.r, arg_235_1.hightColor1.r, var_238_3)
								local var_238_5 = Mathf.Lerp(iter_238_1.color.g, arg_235_1.hightColor1.g, var_238_3)
								local var_238_6 = Mathf.Lerp(iter_238_1.color.b, arg_235_1.hightColor1.b, var_238_3)

								iter_238_1.color = Color.New(var_238_4, var_238_5, var_238_6)
							else
								local var_238_7 = Mathf.Lerp(iter_238_1.color.r, 1, var_238_3)

								iter_238_1.color = Color.New(var_238_7, var_238_7, var_238_7)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps1137 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_238_3 then
						if arg_235_1.isInRecall_ then
							iter_238_3.color = arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_238_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps1137 = nil
			end

			local var_238_8 = arg_235_1.actors_["1080"]
			local var_238_9 = 0

			if var_238_9 < arg_235_1.time_ and arg_235_1.time_ <= var_238_9 + arg_238_0 and not isNil(var_238_8) and arg_235_1.var_.actorSpriteComps1080 == nil then
				arg_235_1.var_.actorSpriteComps1080 = var_238_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_10 = 0.2

			if var_238_9 <= arg_235_1.time_ and arg_235_1.time_ < var_238_9 + var_238_10 and not isNil(var_238_8) then
				local var_238_11 = (arg_235_1.time_ - var_238_9) / var_238_10

				if arg_235_1.var_.actorSpriteComps1080 then
					for iter_238_4, iter_238_5 in pairs(arg_235_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_238_5 then
							if arg_235_1.isInRecall_ then
								local var_238_12 = Mathf.Lerp(iter_238_5.color.r, arg_235_1.hightColor2.r, var_238_11)
								local var_238_13 = Mathf.Lerp(iter_238_5.color.g, arg_235_1.hightColor2.g, var_238_11)
								local var_238_14 = Mathf.Lerp(iter_238_5.color.b, arg_235_1.hightColor2.b, var_238_11)

								iter_238_5.color = Color.New(var_238_12, var_238_13, var_238_14)
							else
								local var_238_15 = Mathf.Lerp(iter_238_5.color.r, 0.5, var_238_11)

								iter_238_5.color = Color.New(var_238_15, var_238_15, var_238_15)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= var_238_9 + var_238_10 and arg_235_1.time_ < var_238_9 + var_238_10 + arg_238_0 and not isNil(var_238_8) and arg_235_1.var_.actorSpriteComps1080 then
				for iter_238_6, iter_238_7 in pairs(arg_235_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_238_7 then
						if arg_235_1.isInRecall_ then
							iter_238_7.color = arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_238_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps1080 = nil
			end

			local var_238_16 = 0
			local var_238_17 = 0.475

			if var_238_16 < arg_235_1.time_ and arg_235_1.time_ <= var_238_16 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_18 = arg_235_1:FormatText(StoryNameCfg[15].name)

				arg_235_1.leftNameTxt_.text = var_238_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_19 = arg_235_1:GetWordFromCfg(425032058)
				local var_238_20 = arg_235_1:FormatText(var_238_19.content)

				arg_235_1.text_.text = var_238_20

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_21 = 19
				local var_238_22 = utf8.len(var_238_20)
				local var_238_23 = var_238_21 <= 0 and var_238_17 or var_238_17 * (var_238_22 / var_238_21)

				if var_238_23 > 0 and var_238_17 < var_238_23 then
					arg_235_1.talkMaxDuration = var_238_23

					if var_238_23 + var_238_16 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_23 + var_238_16
					end
				end

				arg_235_1.text_.text = var_238_20
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032058", "story_v_out_425032.awb") ~= 0 then
					local var_238_24 = manager.audio:GetVoiceLength("story_v_out_425032", "425032058", "story_v_out_425032.awb") / 1000

					if var_238_24 + var_238_16 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_24 + var_238_16
					end

					if var_238_19.prefab_name ~= "" and arg_235_1.actors_[var_238_19.prefab_name] ~= nil then
						local var_238_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_19.prefab_name].transform, "story_v_out_425032", "425032058", "story_v_out_425032.awb")

						arg_235_1:RecordAudio("425032058", var_238_25)
						arg_235_1:RecordAudio("425032058", var_238_25)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_425032", "425032058", "story_v_out_425032.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_425032", "425032058", "story_v_out_425032.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_26 = math.max(var_238_17, arg_235_1.talkMaxDuration)

			if var_238_16 <= arg_235_1.time_ and arg_235_1.time_ < var_238_16 + var_238_26 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_16) / var_238_26

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_16 + var_238_26 and arg_235_1.time_ < var_238_16 + var_238_26 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play425032059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 425032059
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play425032060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1137"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos1137 = var_242_0.localPosition
				var_242_0.localScale = Vector3.New(1, 1, 1)

				arg_239_1:CheckSpriteTmpPos("1137", 7)

				local var_242_2 = var_242_0.childCount

				for iter_242_0 = 0, var_242_2 - 1 do
					local var_242_3 = var_242_0:GetChild(iter_242_0)

					if var_242_3.name == "" or not string.find(var_242_3.name, "split") then
						var_242_3.gameObject:SetActive(true)
					else
						var_242_3.gameObject:SetActive(false)
					end
				end
			end

			local var_242_4 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_4 then
				local var_242_5 = (arg_239_1.time_ - var_242_1) / var_242_4
				local var_242_6 = Vector3.New(0, -2000, 0)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1137, var_242_6, var_242_5)
			end

			if arg_239_1.time_ >= var_242_1 + var_242_4 and arg_239_1.time_ < var_242_1 + var_242_4 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_242_7 = arg_239_1.actors_["1080"].transform
			local var_242_8 = 0

			if var_242_8 < arg_239_1.time_ and arg_239_1.time_ <= var_242_8 + arg_242_0 then
				arg_239_1.var_.moveOldPos1080 = var_242_7.localPosition
				var_242_7.localScale = Vector3.New(1, 1, 1)

				arg_239_1:CheckSpriteTmpPos("1080", 7)

				local var_242_9 = var_242_7.childCount

				for iter_242_1 = 0, var_242_9 - 1 do
					local var_242_10 = var_242_7:GetChild(iter_242_1)

					if var_242_10.name == "" or not string.find(var_242_10.name, "split") then
						var_242_10.gameObject:SetActive(true)
					else
						var_242_10.gameObject:SetActive(false)
					end
				end
			end

			local var_242_11 = 0.001

			if var_242_8 <= arg_239_1.time_ and arg_239_1.time_ < var_242_8 + var_242_11 then
				local var_242_12 = (arg_239_1.time_ - var_242_8) / var_242_11
				local var_242_13 = Vector3.New(0, -2000, 0)

				var_242_7.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1080, var_242_13, var_242_12)
			end

			if arg_239_1.time_ >= var_242_8 + var_242_11 and arg_239_1.time_ < var_242_8 + var_242_11 + arg_242_0 then
				var_242_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_242_14 = 0.666666666666667
			local var_242_15 = 1

			if var_242_14 < arg_239_1.time_ and arg_239_1.time_ <= var_242_14 + arg_242_0 then
				local var_242_16 = "play"
				local var_242_17 = "effect"

				arg_239_1:AudioAction(var_242_16, var_242_17, "se_story_141", "se_story_141_footstep_upstairs", "")
			end

			local var_242_18 = 0
			local var_242_19 = 1.075

			if var_242_18 < arg_239_1.time_ and arg_239_1.time_ <= var_242_18 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_20 = arg_239_1:GetWordFromCfg(425032059)
				local var_242_21 = arg_239_1:FormatText(var_242_20.content)

				arg_239_1.text_.text = var_242_21

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_22 = 43
				local var_242_23 = utf8.len(var_242_21)
				local var_242_24 = var_242_22 <= 0 and var_242_19 or var_242_19 * (var_242_23 / var_242_22)

				if var_242_24 > 0 and var_242_19 < var_242_24 then
					arg_239_1.talkMaxDuration = var_242_24

					if var_242_24 + var_242_18 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_24 + var_242_18
					end
				end

				arg_239_1.text_.text = var_242_21
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_25 = math.max(var_242_19, arg_239_1.talkMaxDuration)

			if var_242_18 <= arg_239_1.time_ and arg_239_1.time_ < var_242_18 + var_242_25 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_18) / var_242_25

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_18 + var_242_25 and arg_239_1.time_ < var_242_18 + var_242_25 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play425032060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 425032060
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play425032061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 1.15

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_2 = arg_243_1:GetWordFromCfg(425032060)
				local var_246_3 = arg_243_1:FormatText(var_246_2.content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 46
				local var_246_5 = utf8.len(var_246_3)
				local var_246_6 = var_246_4 <= 0 and var_246_1 or var_246_1 * (var_246_5 / var_246_4)

				if var_246_6 > 0 and var_246_1 < var_246_6 then
					arg_243_1.talkMaxDuration = var_246_6

					if var_246_6 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_6 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_7 and arg_243_1.time_ < var_246_0 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play425032061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 425032061
		arg_247_1.duration_ = 11.57

		local var_247_0 = {
			zh = 9.5,
			ja = 11.566
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play425032062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1137"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps1137 == nil then
				arg_247_1.var_.actorSpriteComps1137 = var_250_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_2 = 0.2

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.actorSpriteComps1137 then
					for iter_250_0, iter_250_1 in pairs(arg_247_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_250_1 then
							if arg_247_1.isInRecall_ then
								local var_250_4 = Mathf.Lerp(iter_250_1.color.r, arg_247_1.hightColor1.r, var_250_3)
								local var_250_5 = Mathf.Lerp(iter_250_1.color.g, arg_247_1.hightColor1.g, var_250_3)
								local var_250_6 = Mathf.Lerp(iter_250_1.color.b, arg_247_1.hightColor1.b, var_250_3)

								iter_250_1.color = Color.New(var_250_4, var_250_5, var_250_6)
							else
								local var_250_7 = Mathf.Lerp(iter_250_1.color.r, 1, var_250_3)

								iter_250_1.color = Color.New(var_250_7, var_250_7, var_250_7)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps1137 then
				for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_250_3 then
						if arg_247_1.isInRecall_ then
							iter_250_3.color = arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_250_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps1137 = nil
			end

			local var_250_8 = arg_247_1.actors_["1137"].transform
			local var_250_9 = 0

			if var_250_9 < arg_247_1.time_ and arg_247_1.time_ <= var_250_9 + arg_250_0 then
				arg_247_1.var_.moveOldPos1137 = var_250_8.localPosition
				var_250_8.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("1137", 3)

				local var_250_10 = var_250_8.childCount

				for iter_250_4 = 0, var_250_10 - 1 do
					local var_250_11 = var_250_8:GetChild(iter_250_4)

					if var_250_11.name == "split_4" or not string.find(var_250_11.name, "split") then
						var_250_11.gameObject:SetActive(true)
					else
						var_250_11.gameObject:SetActive(false)
					end
				end
			end

			local var_250_12 = 0.001

			if var_250_9 <= arg_247_1.time_ and arg_247_1.time_ < var_250_9 + var_250_12 then
				local var_250_13 = (arg_247_1.time_ - var_250_9) / var_250_12
				local var_250_14 = Vector3.New(0, -425, -200)

				var_250_8.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1137, var_250_14, var_250_13)
			end

			if arg_247_1.time_ >= var_250_9 + var_250_12 and arg_247_1.time_ < var_250_9 + var_250_12 + arg_250_0 then
				var_250_8.localPosition = Vector3.New(0, -425, -200)
			end

			local var_250_15 = 0
			local var_250_16 = 0.925

			if var_250_15 < arg_247_1.time_ and arg_247_1.time_ <= var_250_15 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_17 = arg_247_1:FormatText(StoryNameCfg[15].name)

				arg_247_1.leftNameTxt_.text = var_250_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_18 = arg_247_1:GetWordFromCfg(425032061)
				local var_250_19 = arg_247_1:FormatText(var_250_18.content)

				arg_247_1.text_.text = var_250_19

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_20 = 37
				local var_250_21 = utf8.len(var_250_19)
				local var_250_22 = var_250_20 <= 0 and var_250_16 or var_250_16 * (var_250_21 / var_250_20)

				if var_250_22 > 0 and var_250_16 < var_250_22 then
					arg_247_1.talkMaxDuration = var_250_22

					if var_250_22 + var_250_15 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_22 + var_250_15
					end
				end

				arg_247_1.text_.text = var_250_19
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032061", "story_v_out_425032.awb") ~= 0 then
					local var_250_23 = manager.audio:GetVoiceLength("story_v_out_425032", "425032061", "story_v_out_425032.awb") / 1000

					if var_250_23 + var_250_15 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_23 + var_250_15
					end

					if var_250_18.prefab_name ~= "" and arg_247_1.actors_[var_250_18.prefab_name] ~= nil then
						local var_250_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_18.prefab_name].transform, "story_v_out_425032", "425032061", "story_v_out_425032.awb")

						arg_247_1:RecordAudio("425032061", var_250_24)
						arg_247_1:RecordAudio("425032061", var_250_24)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_425032", "425032061", "story_v_out_425032.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_425032", "425032061", "story_v_out_425032.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_25 = math.max(var_250_16, arg_247_1.talkMaxDuration)

			if var_250_15 <= arg_247_1.time_ and arg_247_1.time_ < var_250_15 + var_250_25 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_15) / var_250_25

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_15 + var_250_25 and arg_247_1.time_ < var_250_15 + var_250_25 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play425032062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 425032062
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play425032063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1137"].transform
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.var_.moveOldPos1137 = var_254_0.localPosition
				var_254_0.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("1137", 7)

				local var_254_2 = var_254_0.childCount

				for iter_254_0 = 0, var_254_2 - 1 do
					local var_254_3 = var_254_0:GetChild(iter_254_0)

					if var_254_3.name == "" or not string.find(var_254_3.name, "split") then
						var_254_3.gameObject:SetActive(true)
					else
						var_254_3.gameObject:SetActive(false)
					end
				end
			end

			local var_254_4 = 0.001

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_4 then
				local var_254_5 = (arg_251_1.time_ - var_254_1) / var_254_4
				local var_254_6 = Vector3.New(0, -2000, 0)

				var_254_0.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1137, var_254_6, var_254_5)
			end

			if arg_251_1.time_ >= var_254_1 + var_254_4 and arg_251_1.time_ < var_254_1 + var_254_4 + arg_254_0 then
				var_254_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_254_7 = manager.ui.mainCamera.transform
			local var_254_8 = 0

			if var_254_8 < arg_251_1.time_ and arg_251_1.time_ <= var_254_8 + arg_254_0 then
				local var_254_9 = arg_251_1.var_.effect2062
				local var_254_10
				local var_254_11 = var_254_7

				if not var_254_9 then
					var_254_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_scan_in_out"), var_254_11)
					var_254_9.name = "2062"
					arg_251_1.var_.effect2062 = var_254_9
				else
					var_254_9.transform:SetParent(var_254_11)
				end

				var_254_9.transform.localPosition = Vector3.New(0, 0, -2)
				var_254_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_254_12 = 0
			local var_254_13 = 1

			if var_254_12 < arg_251_1.time_ and arg_251_1.time_ <= var_254_12 + arg_254_0 then
				local var_254_14 = "play"
				local var_254_15 = "effect"

				arg_251_1:AudioAction(var_254_14, var_254_15, "se_story_121_04", "se_story_121_04_magic", "")
			end

			local var_254_16 = 0
			local var_254_17 = 1.075

			if var_254_16 < arg_251_1.time_ and arg_251_1.time_ <= var_254_16 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_18 = arg_251_1:GetWordFromCfg(425032062)
				local var_254_19 = arg_251_1:FormatText(var_254_18.content)

				arg_251_1.text_.text = var_254_19

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_20 = 43
				local var_254_21 = utf8.len(var_254_19)
				local var_254_22 = var_254_20 <= 0 and var_254_17 or var_254_17 * (var_254_21 / var_254_20)

				if var_254_22 > 0 and var_254_17 < var_254_22 then
					arg_251_1.talkMaxDuration = var_254_22

					if var_254_22 + var_254_16 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_22 + var_254_16
					end
				end

				arg_251_1.text_.text = var_254_19
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_23 = math.max(var_254_17, arg_251_1.talkMaxDuration)

			if var_254_16 <= arg_251_1.time_ and arg_251_1.time_ < var_254_16 + var_254_23 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_16) / var_254_23

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_16 + var_254_23 and arg_251_1.time_ < var_254_16 + var_254_23 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play425032063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 425032063
		arg_255_1.duration_ = 5.3

		local var_255_0 = {
			zh = 2.733,
			ja = 5.3
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play425032064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["1137"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.actorSpriteComps1137 == nil then
				arg_255_1.var_.actorSpriteComps1137 = var_258_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_2 = 0.2

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.actorSpriteComps1137 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_258_1 then
							if arg_255_1.isInRecall_ then
								local var_258_4 = Mathf.Lerp(iter_258_1.color.r, arg_255_1.hightColor1.r, var_258_3)
								local var_258_5 = Mathf.Lerp(iter_258_1.color.g, arg_255_1.hightColor1.g, var_258_3)
								local var_258_6 = Mathf.Lerp(iter_258_1.color.b, arg_255_1.hightColor1.b, var_258_3)

								iter_258_1.color = Color.New(var_258_4, var_258_5, var_258_6)
							else
								local var_258_7 = Mathf.Lerp(iter_258_1.color.r, 1, var_258_3)

								iter_258_1.color = Color.New(var_258_7, var_258_7, var_258_7)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.actorSpriteComps1137 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_258_3 then
						if arg_255_1.isInRecall_ then
							iter_258_3.color = arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_258_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_255_1.var_.actorSpriteComps1137 = nil
			end

			local var_258_8 = arg_255_1.actors_["1137"].transform
			local var_258_9 = 0

			if var_258_9 < arg_255_1.time_ and arg_255_1.time_ <= var_258_9 + arg_258_0 then
				arg_255_1.var_.moveOldPos1137 = var_258_8.localPosition
				var_258_8.localScale = Vector3.New(1, 1, 1)

				arg_255_1:CheckSpriteTmpPos("1137", 2)

				local var_258_10 = var_258_8.childCount

				for iter_258_4 = 0, var_258_10 - 1 do
					local var_258_11 = var_258_8:GetChild(iter_258_4)

					if var_258_11.name == "split_4" or not string.find(var_258_11.name, "split") then
						var_258_11.gameObject:SetActive(true)
					else
						var_258_11.gameObject:SetActive(false)
					end
				end
			end

			local var_258_12 = 0.001

			if var_258_9 <= arg_255_1.time_ and arg_255_1.time_ < var_258_9 + var_258_12 then
				local var_258_13 = (arg_255_1.time_ - var_258_9) / var_258_12
				local var_258_14 = Vector3.New(-390, -425, -200)

				var_258_8.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1137, var_258_14, var_258_13)
			end

			if arg_255_1.time_ >= var_258_9 + var_258_12 and arg_255_1.time_ < var_258_9 + var_258_12 + arg_258_0 then
				var_258_8.localPosition = Vector3.New(-390, -425, -200)
			end

			local var_258_15 = manager.ui.mainCamera.transform
			local var_258_16 = 0

			if var_258_16 < arg_255_1.time_ and arg_255_1.time_ <= var_258_16 + arg_258_0 then
				local var_258_17 = arg_255_1.var_.effect2062

				if var_258_17 then
					Object.Destroy(var_258_17)

					arg_255_1.var_.effect2062 = nil
				end
			end

			local var_258_18 = 0
			local var_258_19 = 0.375

			if var_258_18 < arg_255_1.time_ and arg_255_1.time_ <= var_258_18 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_20 = arg_255_1:FormatText(StoryNameCfg[15].name)

				arg_255_1.leftNameTxt_.text = var_258_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_21 = arg_255_1:GetWordFromCfg(425032063)
				local var_258_22 = arg_255_1:FormatText(var_258_21.content)

				arg_255_1.text_.text = var_258_22

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_23 = 15
				local var_258_24 = utf8.len(var_258_22)
				local var_258_25 = var_258_23 <= 0 and var_258_19 or var_258_19 * (var_258_24 / var_258_23)

				if var_258_25 > 0 and var_258_19 < var_258_25 then
					arg_255_1.talkMaxDuration = var_258_25

					if var_258_25 + var_258_18 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_25 + var_258_18
					end
				end

				arg_255_1.text_.text = var_258_22
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032063", "story_v_out_425032.awb") ~= 0 then
					local var_258_26 = manager.audio:GetVoiceLength("story_v_out_425032", "425032063", "story_v_out_425032.awb") / 1000

					if var_258_26 + var_258_18 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_26 + var_258_18
					end

					if var_258_21.prefab_name ~= "" and arg_255_1.actors_[var_258_21.prefab_name] ~= nil then
						local var_258_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_21.prefab_name].transform, "story_v_out_425032", "425032063", "story_v_out_425032.awb")

						arg_255_1:RecordAudio("425032063", var_258_27)
						arg_255_1:RecordAudio("425032063", var_258_27)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_425032", "425032063", "story_v_out_425032.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_425032", "425032063", "story_v_out_425032.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_28 = math.max(var_258_19, arg_255_1.talkMaxDuration)

			if var_258_18 <= arg_255_1.time_ and arg_255_1.time_ < var_258_18 + var_258_28 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_18) / var_258_28

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_18 + var_258_28 and arg_255_1.time_ < var_258_18 + var_258_28 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play425032064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 425032064
		arg_259_1.duration_ = 2.37

		local var_259_0 = {
			zh = 1.733,
			ja = 2.366
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play425032065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1080"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps1080 == nil then
				arg_259_1.var_.actorSpriteComps1080 = var_262_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_2 = 0.2

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.actorSpriteComps1080 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_262_1 then
							if arg_259_1.isInRecall_ then
								local var_262_4 = Mathf.Lerp(iter_262_1.color.r, arg_259_1.hightColor1.r, var_262_3)
								local var_262_5 = Mathf.Lerp(iter_262_1.color.g, arg_259_1.hightColor1.g, var_262_3)
								local var_262_6 = Mathf.Lerp(iter_262_1.color.b, arg_259_1.hightColor1.b, var_262_3)

								iter_262_1.color = Color.New(var_262_4, var_262_5, var_262_6)
							else
								local var_262_7 = Mathf.Lerp(iter_262_1.color.r, 1, var_262_3)

								iter_262_1.color = Color.New(var_262_7, var_262_7, var_262_7)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps1080 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_262_3 then
						if arg_259_1.isInRecall_ then
							iter_262_3.color = arg_259_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_262_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_259_1.var_.actorSpriteComps1080 = nil
			end

			local var_262_8 = arg_259_1.actors_["1137"]
			local var_262_9 = 0

			if var_262_9 < arg_259_1.time_ and arg_259_1.time_ <= var_262_9 + arg_262_0 and not isNil(var_262_8) and arg_259_1.var_.actorSpriteComps1137 == nil then
				arg_259_1.var_.actorSpriteComps1137 = var_262_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_10 = 0.2

			if var_262_9 <= arg_259_1.time_ and arg_259_1.time_ < var_262_9 + var_262_10 and not isNil(var_262_8) then
				local var_262_11 = (arg_259_1.time_ - var_262_9) / var_262_10

				if arg_259_1.var_.actorSpriteComps1137 then
					for iter_262_4, iter_262_5 in pairs(arg_259_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_262_5 then
							if arg_259_1.isInRecall_ then
								local var_262_12 = Mathf.Lerp(iter_262_5.color.r, arg_259_1.hightColor2.r, var_262_11)
								local var_262_13 = Mathf.Lerp(iter_262_5.color.g, arg_259_1.hightColor2.g, var_262_11)
								local var_262_14 = Mathf.Lerp(iter_262_5.color.b, arg_259_1.hightColor2.b, var_262_11)

								iter_262_5.color = Color.New(var_262_12, var_262_13, var_262_14)
							else
								local var_262_15 = Mathf.Lerp(iter_262_5.color.r, 0.5, var_262_11)

								iter_262_5.color = Color.New(var_262_15, var_262_15, var_262_15)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= var_262_9 + var_262_10 and arg_259_1.time_ < var_262_9 + var_262_10 + arg_262_0 and not isNil(var_262_8) and arg_259_1.var_.actorSpriteComps1137 then
				for iter_262_6, iter_262_7 in pairs(arg_259_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_262_7 then
						if arg_259_1.isInRecall_ then
							iter_262_7.color = arg_259_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_262_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_259_1.var_.actorSpriteComps1137 = nil
			end

			local var_262_16 = arg_259_1.actors_["1080"].transform
			local var_262_17 = 0

			if var_262_17 < arg_259_1.time_ and arg_259_1.time_ <= var_262_17 + arg_262_0 then
				arg_259_1.var_.moveOldPos1080 = var_262_16.localPosition
				var_262_16.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("1080", 4)

				local var_262_18 = var_262_16.childCount

				for iter_262_8 = 0, var_262_18 - 1 do
					local var_262_19 = var_262_16:GetChild(iter_262_8)

					if var_262_19.name == "" or not string.find(var_262_19.name, "split") then
						var_262_19.gameObject:SetActive(true)
					else
						var_262_19.gameObject:SetActive(false)
					end
				end
			end

			local var_262_20 = 0.001

			if var_262_17 <= arg_259_1.time_ and arg_259_1.time_ < var_262_17 + var_262_20 then
				local var_262_21 = (arg_259_1.time_ - var_262_17) / var_262_20
				local var_262_22 = Vector3.New(390, -378, -170)

				var_262_16.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1080, var_262_22, var_262_21)
			end

			if arg_259_1.time_ >= var_262_17 + var_262_20 and arg_259_1.time_ < var_262_17 + var_262_20 + arg_262_0 then
				var_262_16.localPosition = Vector3.New(390, -378, -170)
			end

			local var_262_23 = 0
			local var_262_24 = 0.225

			if var_262_23 < arg_259_1.time_ and arg_259_1.time_ <= var_262_23 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_25 = arg_259_1:FormatText(StoryNameCfg[55].name)

				arg_259_1.leftNameTxt_.text = var_262_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_26 = arg_259_1:GetWordFromCfg(425032064)
				local var_262_27 = arg_259_1:FormatText(var_262_26.content)

				arg_259_1.text_.text = var_262_27

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_28 = 9
				local var_262_29 = utf8.len(var_262_27)
				local var_262_30 = var_262_28 <= 0 and var_262_24 or var_262_24 * (var_262_29 / var_262_28)

				if var_262_30 > 0 and var_262_24 < var_262_30 then
					arg_259_1.talkMaxDuration = var_262_30

					if var_262_30 + var_262_23 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_30 + var_262_23
					end
				end

				arg_259_1.text_.text = var_262_27
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032064", "story_v_out_425032.awb") ~= 0 then
					local var_262_31 = manager.audio:GetVoiceLength("story_v_out_425032", "425032064", "story_v_out_425032.awb") / 1000

					if var_262_31 + var_262_23 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_31 + var_262_23
					end

					if var_262_26.prefab_name ~= "" and arg_259_1.actors_[var_262_26.prefab_name] ~= nil then
						local var_262_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_26.prefab_name].transform, "story_v_out_425032", "425032064", "story_v_out_425032.awb")

						arg_259_1:RecordAudio("425032064", var_262_32)
						arg_259_1:RecordAudio("425032064", var_262_32)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_425032", "425032064", "story_v_out_425032.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_425032", "425032064", "story_v_out_425032.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_33 = math.max(var_262_24, arg_259_1.talkMaxDuration)

			if var_262_23 <= arg_259_1.time_ and arg_259_1.time_ < var_262_23 + var_262_33 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_23) / var_262_33

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_23 + var_262_33 and arg_259_1.time_ < var_262_23 + var_262_33 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play425032065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 425032065
		arg_263_1.duration_ = 7.77

		local var_263_0 = {
			zh = 5.3,
			ja = 7.766
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play425032066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1137"]
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps1137 == nil then
				arg_263_1.var_.actorSpriteComps1137 = var_266_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_2 = 0.2

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 and not isNil(var_266_0) then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2

				if arg_263_1.var_.actorSpriteComps1137 then
					for iter_266_0, iter_266_1 in pairs(arg_263_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_266_1 then
							if arg_263_1.isInRecall_ then
								local var_266_4 = Mathf.Lerp(iter_266_1.color.r, arg_263_1.hightColor1.r, var_266_3)
								local var_266_5 = Mathf.Lerp(iter_266_1.color.g, arg_263_1.hightColor1.g, var_266_3)
								local var_266_6 = Mathf.Lerp(iter_266_1.color.b, arg_263_1.hightColor1.b, var_266_3)

								iter_266_1.color = Color.New(var_266_4, var_266_5, var_266_6)
							else
								local var_266_7 = Mathf.Lerp(iter_266_1.color.r, 1, var_266_3)

								iter_266_1.color = Color.New(var_266_7, var_266_7, var_266_7)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps1137 then
				for iter_266_2, iter_266_3 in pairs(arg_263_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_266_3 then
						if arg_263_1.isInRecall_ then
							iter_266_3.color = arg_263_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_266_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_263_1.var_.actorSpriteComps1137 = nil
			end

			local var_266_8 = arg_263_1.actors_["1080"]
			local var_266_9 = 0

			if var_266_9 < arg_263_1.time_ and arg_263_1.time_ <= var_266_9 + arg_266_0 and not isNil(var_266_8) and arg_263_1.var_.actorSpriteComps1080 == nil then
				arg_263_1.var_.actorSpriteComps1080 = var_266_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_10 = 0.2

			if var_266_9 <= arg_263_1.time_ and arg_263_1.time_ < var_266_9 + var_266_10 and not isNil(var_266_8) then
				local var_266_11 = (arg_263_1.time_ - var_266_9) / var_266_10

				if arg_263_1.var_.actorSpriteComps1080 then
					for iter_266_4, iter_266_5 in pairs(arg_263_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_266_5 then
							if arg_263_1.isInRecall_ then
								local var_266_12 = Mathf.Lerp(iter_266_5.color.r, arg_263_1.hightColor2.r, var_266_11)
								local var_266_13 = Mathf.Lerp(iter_266_5.color.g, arg_263_1.hightColor2.g, var_266_11)
								local var_266_14 = Mathf.Lerp(iter_266_5.color.b, arg_263_1.hightColor2.b, var_266_11)

								iter_266_5.color = Color.New(var_266_12, var_266_13, var_266_14)
							else
								local var_266_15 = Mathf.Lerp(iter_266_5.color.r, 0.5, var_266_11)

								iter_266_5.color = Color.New(var_266_15, var_266_15, var_266_15)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= var_266_9 + var_266_10 and arg_263_1.time_ < var_266_9 + var_266_10 + arg_266_0 and not isNil(var_266_8) and arg_263_1.var_.actorSpriteComps1080 then
				for iter_266_6, iter_266_7 in pairs(arg_263_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_266_7 then
						if arg_263_1.isInRecall_ then
							iter_266_7.color = arg_263_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_266_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_263_1.var_.actorSpriteComps1080 = nil
			end

			local var_266_16 = 0
			local var_266_17 = 0.4

			if var_266_16 < arg_263_1.time_ and arg_263_1.time_ <= var_266_16 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_18 = arg_263_1:FormatText(StoryNameCfg[15].name)

				arg_263_1.leftNameTxt_.text = var_266_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_19 = arg_263_1:GetWordFromCfg(425032065)
				local var_266_20 = arg_263_1:FormatText(var_266_19.content)

				arg_263_1.text_.text = var_266_20

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_21 = 16
				local var_266_22 = utf8.len(var_266_20)
				local var_266_23 = var_266_21 <= 0 and var_266_17 or var_266_17 * (var_266_22 / var_266_21)

				if var_266_23 > 0 and var_266_17 < var_266_23 then
					arg_263_1.talkMaxDuration = var_266_23

					if var_266_23 + var_266_16 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_23 + var_266_16
					end
				end

				arg_263_1.text_.text = var_266_20
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032065", "story_v_out_425032.awb") ~= 0 then
					local var_266_24 = manager.audio:GetVoiceLength("story_v_out_425032", "425032065", "story_v_out_425032.awb") / 1000

					if var_266_24 + var_266_16 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_24 + var_266_16
					end

					if var_266_19.prefab_name ~= "" and arg_263_1.actors_[var_266_19.prefab_name] ~= nil then
						local var_266_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_19.prefab_name].transform, "story_v_out_425032", "425032065", "story_v_out_425032.awb")

						arg_263_1:RecordAudio("425032065", var_266_25)
						arg_263_1:RecordAudio("425032065", var_266_25)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_425032", "425032065", "story_v_out_425032.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_425032", "425032065", "story_v_out_425032.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_26 = math.max(var_266_17, arg_263_1.talkMaxDuration)

			if var_266_16 <= arg_263_1.time_ and arg_263_1.time_ < var_266_16 + var_266_26 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_16) / var_266_26

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_16 + var_266_26 and arg_263_1.time_ < var_266_16 + var_266_26 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play425032066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 425032066
		arg_267_1.duration_ = 7.33

		local var_267_0 = {
			zh = 5.4,
			ja = 7.333
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play425032067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0
			local var_270_1 = 0.7

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_2 = arg_267_1:FormatText(StoryNameCfg[15].name)

				arg_267_1.leftNameTxt_.text = var_270_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_3 = arg_267_1:GetWordFromCfg(425032066)
				local var_270_4 = arg_267_1:FormatText(var_270_3.content)

				arg_267_1.text_.text = var_270_4

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 51
				local var_270_6 = utf8.len(var_270_4)
				local var_270_7 = var_270_5 <= 0 and var_270_1 or var_270_1 * (var_270_6 / var_270_5)

				if var_270_7 > 0 and var_270_1 < var_270_7 then
					arg_267_1.talkMaxDuration = var_270_7

					if var_270_7 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_7 + var_270_0
					end
				end

				arg_267_1.text_.text = var_270_4
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032066", "story_v_out_425032.awb") ~= 0 then
					local var_270_8 = manager.audio:GetVoiceLength("story_v_out_425032", "425032066", "story_v_out_425032.awb") / 1000

					if var_270_8 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_8 + var_270_0
					end

					if var_270_3.prefab_name ~= "" and arg_267_1.actors_[var_270_3.prefab_name] ~= nil then
						local var_270_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_3.prefab_name].transform, "story_v_out_425032", "425032066", "story_v_out_425032.awb")

						arg_267_1:RecordAudio("425032066", var_270_9)
						arg_267_1:RecordAudio("425032066", var_270_9)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_425032", "425032066", "story_v_out_425032.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_425032", "425032066", "story_v_out_425032.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_10 = math.max(var_270_1, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_10 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_0) / var_270_10

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_10 and arg_267_1.time_ < var_270_0 + var_270_10 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play425032067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 425032067
		arg_271_1.duration_ = 7.53

		local var_271_0 = {
			zh = 5.233,
			ja = 7.533
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play425032068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1080"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps1080 == nil then
				arg_271_1.var_.actorSpriteComps1080 = var_274_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_2 = 0.2

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.actorSpriteComps1080 then
					for iter_274_0, iter_274_1 in pairs(arg_271_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_274_1 then
							if arg_271_1.isInRecall_ then
								local var_274_4 = Mathf.Lerp(iter_274_1.color.r, arg_271_1.hightColor1.r, var_274_3)
								local var_274_5 = Mathf.Lerp(iter_274_1.color.g, arg_271_1.hightColor1.g, var_274_3)
								local var_274_6 = Mathf.Lerp(iter_274_1.color.b, arg_271_1.hightColor1.b, var_274_3)

								iter_274_1.color = Color.New(var_274_4, var_274_5, var_274_6)
							else
								local var_274_7 = Mathf.Lerp(iter_274_1.color.r, 1, var_274_3)

								iter_274_1.color = Color.New(var_274_7, var_274_7, var_274_7)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps1080 then
				for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_274_3 then
						if arg_271_1.isInRecall_ then
							iter_274_3.color = arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_274_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps1080 = nil
			end

			local var_274_8 = arg_271_1.actors_["1137"]
			local var_274_9 = 0

			if var_274_9 < arg_271_1.time_ and arg_271_1.time_ <= var_274_9 + arg_274_0 and not isNil(var_274_8) and arg_271_1.var_.actorSpriteComps1137 == nil then
				arg_271_1.var_.actorSpriteComps1137 = var_274_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_10 = 0.2

			if var_274_9 <= arg_271_1.time_ and arg_271_1.time_ < var_274_9 + var_274_10 and not isNil(var_274_8) then
				local var_274_11 = (arg_271_1.time_ - var_274_9) / var_274_10

				if arg_271_1.var_.actorSpriteComps1137 then
					for iter_274_4, iter_274_5 in pairs(arg_271_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_274_5 then
							if arg_271_1.isInRecall_ then
								local var_274_12 = Mathf.Lerp(iter_274_5.color.r, arg_271_1.hightColor2.r, var_274_11)
								local var_274_13 = Mathf.Lerp(iter_274_5.color.g, arg_271_1.hightColor2.g, var_274_11)
								local var_274_14 = Mathf.Lerp(iter_274_5.color.b, arg_271_1.hightColor2.b, var_274_11)

								iter_274_5.color = Color.New(var_274_12, var_274_13, var_274_14)
							else
								local var_274_15 = Mathf.Lerp(iter_274_5.color.r, 0.5, var_274_11)

								iter_274_5.color = Color.New(var_274_15, var_274_15, var_274_15)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= var_274_9 + var_274_10 and arg_271_1.time_ < var_274_9 + var_274_10 + arg_274_0 and not isNil(var_274_8) and arg_271_1.var_.actorSpriteComps1137 then
				for iter_274_6, iter_274_7 in pairs(arg_271_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_274_7 then
						if arg_271_1.isInRecall_ then
							iter_274_7.color = arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_274_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps1137 = nil
			end

			local var_274_16 = 0
			local var_274_17 = 0.425

			if var_274_16 < arg_271_1.time_ and arg_271_1.time_ <= var_274_16 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_18 = arg_271_1:FormatText(StoryNameCfg[55].name)

				arg_271_1.leftNameTxt_.text = var_274_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_19 = arg_271_1:GetWordFromCfg(425032067)
				local var_274_20 = arg_271_1:FormatText(var_274_19.content)

				arg_271_1.text_.text = var_274_20

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_21 = 40
				local var_274_22 = utf8.len(var_274_20)
				local var_274_23 = var_274_21 <= 0 and var_274_17 or var_274_17 * (var_274_22 / var_274_21)

				if var_274_23 > 0 and var_274_17 < var_274_23 then
					arg_271_1.talkMaxDuration = var_274_23

					if var_274_23 + var_274_16 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_23 + var_274_16
					end
				end

				arg_271_1.text_.text = var_274_20
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032067", "story_v_out_425032.awb") ~= 0 then
					local var_274_24 = manager.audio:GetVoiceLength("story_v_out_425032", "425032067", "story_v_out_425032.awb") / 1000

					if var_274_24 + var_274_16 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_24 + var_274_16
					end

					if var_274_19.prefab_name ~= "" and arg_271_1.actors_[var_274_19.prefab_name] ~= nil then
						local var_274_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_19.prefab_name].transform, "story_v_out_425032", "425032067", "story_v_out_425032.awb")

						arg_271_1:RecordAudio("425032067", var_274_25)
						arg_271_1:RecordAudio("425032067", var_274_25)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_425032", "425032067", "story_v_out_425032.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_425032", "425032067", "story_v_out_425032.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_26 = math.max(var_274_17, arg_271_1.talkMaxDuration)

			if var_274_16 <= arg_271_1.time_ and arg_271_1.time_ < var_274_16 + var_274_26 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_16) / var_274_26

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_16 + var_274_26 and arg_271_1.time_ < var_274_16 + var_274_26 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play425032068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 425032068
		arg_275_1.duration_ = 2.07

		local var_275_0 = {
			zh = 2.066,
			ja = 1.933
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play425032069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1137"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps1137 == nil then
				arg_275_1.var_.actorSpriteComps1137 = var_278_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_2 = 0.2

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.actorSpriteComps1137 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_278_1 then
							if arg_275_1.isInRecall_ then
								local var_278_4 = Mathf.Lerp(iter_278_1.color.r, arg_275_1.hightColor1.r, var_278_3)
								local var_278_5 = Mathf.Lerp(iter_278_1.color.g, arg_275_1.hightColor1.g, var_278_3)
								local var_278_6 = Mathf.Lerp(iter_278_1.color.b, arg_275_1.hightColor1.b, var_278_3)

								iter_278_1.color = Color.New(var_278_4, var_278_5, var_278_6)
							else
								local var_278_7 = Mathf.Lerp(iter_278_1.color.r, 1, var_278_3)

								iter_278_1.color = Color.New(var_278_7, var_278_7, var_278_7)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps1137 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_278_3 then
						if arg_275_1.isInRecall_ then
							iter_278_3.color = arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_278_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_275_1.var_.actorSpriteComps1137 = nil
			end

			local var_278_8 = arg_275_1.actors_["1080"]
			local var_278_9 = 0

			if var_278_9 < arg_275_1.time_ and arg_275_1.time_ <= var_278_9 + arg_278_0 and not isNil(var_278_8) and arg_275_1.var_.actorSpriteComps1080 == nil then
				arg_275_1.var_.actorSpriteComps1080 = var_278_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_10 = 0.2

			if var_278_9 <= arg_275_1.time_ and arg_275_1.time_ < var_278_9 + var_278_10 and not isNil(var_278_8) then
				local var_278_11 = (arg_275_1.time_ - var_278_9) / var_278_10

				if arg_275_1.var_.actorSpriteComps1080 then
					for iter_278_4, iter_278_5 in pairs(arg_275_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_278_5 then
							if arg_275_1.isInRecall_ then
								local var_278_12 = Mathf.Lerp(iter_278_5.color.r, arg_275_1.hightColor2.r, var_278_11)
								local var_278_13 = Mathf.Lerp(iter_278_5.color.g, arg_275_1.hightColor2.g, var_278_11)
								local var_278_14 = Mathf.Lerp(iter_278_5.color.b, arg_275_1.hightColor2.b, var_278_11)

								iter_278_5.color = Color.New(var_278_12, var_278_13, var_278_14)
							else
								local var_278_15 = Mathf.Lerp(iter_278_5.color.r, 0.5, var_278_11)

								iter_278_5.color = Color.New(var_278_15, var_278_15, var_278_15)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= var_278_9 + var_278_10 and arg_275_1.time_ < var_278_9 + var_278_10 + arg_278_0 and not isNil(var_278_8) and arg_275_1.var_.actorSpriteComps1080 then
				for iter_278_6, iter_278_7 in pairs(arg_275_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_278_7 then
						if arg_275_1.isInRecall_ then
							iter_278_7.color = arg_275_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_278_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_275_1.var_.actorSpriteComps1080 = nil
			end

			local var_278_16 = 0
			local var_278_17 = 0.05

			if var_278_16 < arg_275_1.time_ and arg_275_1.time_ <= var_278_16 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_18 = arg_275_1:FormatText(StoryNameCfg[15].name)

				arg_275_1.leftNameTxt_.text = var_278_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_19 = arg_275_1:GetWordFromCfg(425032068)
				local var_278_20 = arg_275_1:FormatText(var_278_19.content)

				arg_275_1.text_.text = var_278_20

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_21 = 2
				local var_278_22 = utf8.len(var_278_20)
				local var_278_23 = var_278_21 <= 0 and var_278_17 or var_278_17 * (var_278_22 / var_278_21)

				if var_278_23 > 0 and var_278_17 < var_278_23 then
					arg_275_1.talkMaxDuration = var_278_23

					if var_278_23 + var_278_16 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_23 + var_278_16
					end
				end

				arg_275_1.text_.text = var_278_20
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032068", "story_v_out_425032.awb") ~= 0 then
					local var_278_24 = manager.audio:GetVoiceLength("story_v_out_425032", "425032068", "story_v_out_425032.awb") / 1000

					if var_278_24 + var_278_16 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_24 + var_278_16
					end

					if var_278_19.prefab_name ~= "" and arg_275_1.actors_[var_278_19.prefab_name] ~= nil then
						local var_278_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_19.prefab_name].transform, "story_v_out_425032", "425032068", "story_v_out_425032.awb")

						arg_275_1:RecordAudio("425032068", var_278_25)
						arg_275_1:RecordAudio("425032068", var_278_25)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_425032", "425032068", "story_v_out_425032.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_425032", "425032068", "story_v_out_425032.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_26 = math.max(var_278_17, arg_275_1.talkMaxDuration)

			if var_278_16 <= arg_275_1.time_ and arg_275_1.time_ < var_278_16 + var_278_26 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_16) / var_278_26

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_16 + var_278_26 and arg_275_1.time_ < var_278_16 + var_278_26 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play425032069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 425032069
		arg_279_1.duration_ = 11.8

		local var_279_0 = {
			zh = 5.933,
			ja = 11.8
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play425032070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1080"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps1080 == nil then
				arg_279_1.var_.actorSpriteComps1080 = var_282_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_2 = 0.2

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.actorSpriteComps1080 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_282_1 then
							if arg_279_1.isInRecall_ then
								local var_282_4 = Mathf.Lerp(iter_282_1.color.r, arg_279_1.hightColor1.r, var_282_3)
								local var_282_5 = Mathf.Lerp(iter_282_1.color.g, arg_279_1.hightColor1.g, var_282_3)
								local var_282_6 = Mathf.Lerp(iter_282_1.color.b, arg_279_1.hightColor1.b, var_282_3)

								iter_282_1.color = Color.New(var_282_4, var_282_5, var_282_6)
							else
								local var_282_7 = Mathf.Lerp(iter_282_1.color.r, 1, var_282_3)

								iter_282_1.color = Color.New(var_282_7, var_282_7, var_282_7)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps1080 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_282_3 then
						if arg_279_1.isInRecall_ then
							iter_282_3.color = arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_282_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_279_1.var_.actorSpriteComps1080 = nil
			end

			local var_282_8 = arg_279_1.actors_["1137"]
			local var_282_9 = 0

			if var_282_9 < arg_279_1.time_ and arg_279_1.time_ <= var_282_9 + arg_282_0 and not isNil(var_282_8) and arg_279_1.var_.actorSpriteComps1137 == nil then
				arg_279_1.var_.actorSpriteComps1137 = var_282_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_10 = 0.2

			if var_282_9 <= arg_279_1.time_ and arg_279_1.time_ < var_282_9 + var_282_10 and not isNil(var_282_8) then
				local var_282_11 = (arg_279_1.time_ - var_282_9) / var_282_10

				if arg_279_1.var_.actorSpriteComps1137 then
					for iter_282_4, iter_282_5 in pairs(arg_279_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_282_5 then
							if arg_279_1.isInRecall_ then
								local var_282_12 = Mathf.Lerp(iter_282_5.color.r, arg_279_1.hightColor2.r, var_282_11)
								local var_282_13 = Mathf.Lerp(iter_282_5.color.g, arg_279_1.hightColor2.g, var_282_11)
								local var_282_14 = Mathf.Lerp(iter_282_5.color.b, arg_279_1.hightColor2.b, var_282_11)

								iter_282_5.color = Color.New(var_282_12, var_282_13, var_282_14)
							else
								local var_282_15 = Mathf.Lerp(iter_282_5.color.r, 0.5, var_282_11)

								iter_282_5.color = Color.New(var_282_15, var_282_15, var_282_15)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= var_282_9 + var_282_10 and arg_279_1.time_ < var_282_9 + var_282_10 + arg_282_0 and not isNil(var_282_8) and arg_279_1.var_.actorSpriteComps1137 then
				for iter_282_6, iter_282_7 in pairs(arg_279_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_282_7 then
						if arg_279_1.isInRecall_ then
							iter_282_7.color = arg_279_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_282_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_279_1.var_.actorSpriteComps1137 = nil
			end

			local var_282_16 = 0
			local var_282_17 = 0.725

			if var_282_16 < arg_279_1.time_ and arg_279_1.time_ <= var_282_16 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_18 = arg_279_1:FormatText(StoryNameCfg[55].name)

				arg_279_1.leftNameTxt_.text = var_282_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_19 = arg_279_1:GetWordFromCfg(425032069)
				local var_282_20 = arg_279_1:FormatText(var_282_19.content)

				arg_279_1.text_.text = var_282_20

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_21 = 29
				local var_282_22 = utf8.len(var_282_20)
				local var_282_23 = var_282_21 <= 0 and var_282_17 or var_282_17 * (var_282_22 / var_282_21)

				if var_282_23 > 0 and var_282_17 < var_282_23 then
					arg_279_1.talkMaxDuration = var_282_23

					if var_282_23 + var_282_16 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_23 + var_282_16
					end
				end

				arg_279_1.text_.text = var_282_20
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032069", "story_v_out_425032.awb") ~= 0 then
					local var_282_24 = manager.audio:GetVoiceLength("story_v_out_425032", "425032069", "story_v_out_425032.awb") / 1000

					if var_282_24 + var_282_16 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_24 + var_282_16
					end

					if var_282_19.prefab_name ~= "" and arg_279_1.actors_[var_282_19.prefab_name] ~= nil then
						local var_282_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_19.prefab_name].transform, "story_v_out_425032", "425032069", "story_v_out_425032.awb")

						arg_279_1:RecordAudio("425032069", var_282_25)
						arg_279_1:RecordAudio("425032069", var_282_25)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_425032", "425032069", "story_v_out_425032.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_425032", "425032069", "story_v_out_425032.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_26 = math.max(var_282_17, arg_279_1.talkMaxDuration)

			if var_282_16 <= arg_279_1.time_ and arg_279_1.time_ < var_282_16 + var_282_26 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_16) / var_282_26

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_16 + var_282_26 and arg_279_1.time_ < var_282_16 + var_282_26 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play425032070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 425032070
		arg_283_1.duration_ = 8.73

		local var_283_0 = {
			zh = 5.133,
			ja = 8.733
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play425032071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0
			local var_286_1 = 0.675

			if var_286_0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_2 = arg_283_1:FormatText(StoryNameCfg[55].name)

				arg_283_1.leftNameTxt_.text = var_286_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_3 = arg_283_1:GetWordFromCfg(425032070)
				local var_286_4 = arg_283_1:FormatText(var_286_3.content)

				arg_283_1.text_.text = var_286_4

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 27
				local var_286_6 = utf8.len(var_286_4)
				local var_286_7 = var_286_5 <= 0 and var_286_1 or var_286_1 * (var_286_6 / var_286_5)

				if var_286_7 > 0 and var_286_1 < var_286_7 then
					arg_283_1.talkMaxDuration = var_286_7

					if var_286_7 + var_286_0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_7 + var_286_0
					end
				end

				arg_283_1.text_.text = var_286_4
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032070", "story_v_out_425032.awb") ~= 0 then
					local var_286_8 = manager.audio:GetVoiceLength("story_v_out_425032", "425032070", "story_v_out_425032.awb") / 1000

					if var_286_8 + var_286_0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_8 + var_286_0
					end

					if var_286_3.prefab_name ~= "" and arg_283_1.actors_[var_286_3.prefab_name] ~= nil then
						local var_286_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_3.prefab_name].transform, "story_v_out_425032", "425032070", "story_v_out_425032.awb")

						arg_283_1:RecordAudio("425032070", var_286_9)
						arg_283_1:RecordAudio("425032070", var_286_9)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_425032", "425032070", "story_v_out_425032.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_425032", "425032070", "story_v_out_425032.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_10 = math.max(var_286_1, arg_283_1.talkMaxDuration)

			if var_286_0 <= arg_283_1.time_ and arg_283_1.time_ < var_286_0 + var_286_10 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_0) / var_286_10

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_0 + var_286_10 and arg_283_1.time_ < var_286_0 + var_286_10 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play425032071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 425032071
		arg_287_1.duration_ = 2.47

		local var_287_0 = {
			zh = 1.666,
			ja = 2.466
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play425032072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1137"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps1137 == nil then
				arg_287_1.var_.actorSpriteComps1137 = var_290_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_2 = 0.2

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.actorSpriteComps1137 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_290_1 then
							if arg_287_1.isInRecall_ then
								local var_290_4 = Mathf.Lerp(iter_290_1.color.r, arg_287_1.hightColor1.r, var_290_3)
								local var_290_5 = Mathf.Lerp(iter_290_1.color.g, arg_287_1.hightColor1.g, var_290_3)
								local var_290_6 = Mathf.Lerp(iter_290_1.color.b, arg_287_1.hightColor1.b, var_290_3)

								iter_290_1.color = Color.New(var_290_4, var_290_5, var_290_6)
							else
								local var_290_7 = Mathf.Lerp(iter_290_1.color.r, 1, var_290_3)

								iter_290_1.color = Color.New(var_290_7, var_290_7, var_290_7)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps1137 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_290_3 then
						if arg_287_1.isInRecall_ then
							iter_290_3.color = arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_290_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_287_1.var_.actorSpriteComps1137 = nil
			end

			local var_290_8 = arg_287_1.actors_["1080"]
			local var_290_9 = 0

			if var_290_9 < arg_287_1.time_ and arg_287_1.time_ <= var_290_9 + arg_290_0 and not isNil(var_290_8) and arg_287_1.var_.actorSpriteComps1080 == nil then
				arg_287_1.var_.actorSpriteComps1080 = var_290_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_10 = 0.2

			if var_290_9 <= arg_287_1.time_ and arg_287_1.time_ < var_290_9 + var_290_10 and not isNil(var_290_8) then
				local var_290_11 = (arg_287_1.time_ - var_290_9) / var_290_10

				if arg_287_1.var_.actorSpriteComps1080 then
					for iter_290_4, iter_290_5 in pairs(arg_287_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_290_5 then
							if arg_287_1.isInRecall_ then
								local var_290_12 = Mathf.Lerp(iter_290_5.color.r, arg_287_1.hightColor2.r, var_290_11)
								local var_290_13 = Mathf.Lerp(iter_290_5.color.g, arg_287_1.hightColor2.g, var_290_11)
								local var_290_14 = Mathf.Lerp(iter_290_5.color.b, arg_287_1.hightColor2.b, var_290_11)

								iter_290_5.color = Color.New(var_290_12, var_290_13, var_290_14)
							else
								local var_290_15 = Mathf.Lerp(iter_290_5.color.r, 0.5, var_290_11)

								iter_290_5.color = Color.New(var_290_15, var_290_15, var_290_15)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= var_290_9 + var_290_10 and arg_287_1.time_ < var_290_9 + var_290_10 + arg_290_0 and not isNil(var_290_8) and arg_287_1.var_.actorSpriteComps1080 then
				for iter_290_6, iter_290_7 in pairs(arg_287_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_290_7 then
						if arg_287_1.isInRecall_ then
							iter_290_7.color = arg_287_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_290_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_287_1.var_.actorSpriteComps1080 = nil
			end

			local var_290_16 = 0
			local var_290_17 = 0.225

			if var_290_16 < arg_287_1.time_ and arg_287_1.time_ <= var_290_16 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_18 = arg_287_1:FormatText(StoryNameCfg[15].name)

				arg_287_1.leftNameTxt_.text = var_290_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_19 = arg_287_1:GetWordFromCfg(425032071)
				local var_290_20 = arg_287_1:FormatText(var_290_19.content)

				arg_287_1.text_.text = var_290_20

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_21 = 9
				local var_290_22 = utf8.len(var_290_20)
				local var_290_23 = var_290_21 <= 0 and var_290_17 or var_290_17 * (var_290_22 / var_290_21)

				if var_290_23 > 0 and var_290_17 < var_290_23 then
					arg_287_1.talkMaxDuration = var_290_23

					if var_290_23 + var_290_16 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_23 + var_290_16
					end
				end

				arg_287_1.text_.text = var_290_20
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032071", "story_v_out_425032.awb") ~= 0 then
					local var_290_24 = manager.audio:GetVoiceLength("story_v_out_425032", "425032071", "story_v_out_425032.awb") / 1000

					if var_290_24 + var_290_16 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_24 + var_290_16
					end

					if var_290_19.prefab_name ~= "" and arg_287_1.actors_[var_290_19.prefab_name] ~= nil then
						local var_290_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_19.prefab_name].transform, "story_v_out_425032", "425032071", "story_v_out_425032.awb")

						arg_287_1:RecordAudio("425032071", var_290_25)
						arg_287_1:RecordAudio("425032071", var_290_25)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_425032", "425032071", "story_v_out_425032.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_425032", "425032071", "story_v_out_425032.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_26 = math.max(var_290_17, arg_287_1.talkMaxDuration)

			if var_290_16 <= arg_287_1.time_ and arg_287_1.time_ < var_290_16 + var_290_26 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_16) / var_290_26

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_16 + var_290_26 and arg_287_1.time_ < var_290_16 + var_290_26 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play425032072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 425032072
		arg_291_1.duration_ = 10.9

		local var_291_0 = {
			zh = 5.7,
			ja = 10.9
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play425032073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1080"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps1080 == nil then
				arg_291_1.var_.actorSpriteComps1080 = var_294_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_2 = 0.2

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.actorSpriteComps1080 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_294_1 then
							if arg_291_1.isInRecall_ then
								local var_294_4 = Mathf.Lerp(iter_294_1.color.r, arg_291_1.hightColor1.r, var_294_3)
								local var_294_5 = Mathf.Lerp(iter_294_1.color.g, arg_291_1.hightColor1.g, var_294_3)
								local var_294_6 = Mathf.Lerp(iter_294_1.color.b, arg_291_1.hightColor1.b, var_294_3)

								iter_294_1.color = Color.New(var_294_4, var_294_5, var_294_6)
							else
								local var_294_7 = Mathf.Lerp(iter_294_1.color.r, 1, var_294_3)

								iter_294_1.color = Color.New(var_294_7, var_294_7, var_294_7)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps1080 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_294_3 then
						if arg_291_1.isInRecall_ then
							iter_294_3.color = arg_291_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_294_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps1080 = nil
			end

			local var_294_8 = arg_291_1.actors_["1137"]
			local var_294_9 = 0

			if var_294_9 < arg_291_1.time_ and arg_291_1.time_ <= var_294_9 + arg_294_0 and not isNil(var_294_8) and arg_291_1.var_.actorSpriteComps1137 == nil then
				arg_291_1.var_.actorSpriteComps1137 = var_294_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_10 = 0.2

			if var_294_9 <= arg_291_1.time_ and arg_291_1.time_ < var_294_9 + var_294_10 and not isNil(var_294_8) then
				local var_294_11 = (arg_291_1.time_ - var_294_9) / var_294_10

				if arg_291_1.var_.actorSpriteComps1137 then
					for iter_294_4, iter_294_5 in pairs(arg_291_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_294_5 then
							if arg_291_1.isInRecall_ then
								local var_294_12 = Mathf.Lerp(iter_294_5.color.r, arg_291_1.hightColor2.r, var_294_11)
								local var_294_13 = Mathf.Lerp(iter_294_5.color.g, arg_291_1.hightColor2.g, var_294_11)
								local var_294_14 = Mathf.Lerp(iter_294_5.color.b, arg_291_1.hightColor2.b, var_294_11)

								iter_294_5.color = Color.New(var_294_12, var_294_13, var_294_14)
							else
								local var_294_15 = Mathf.Lerp(iter_294_5.color.r, 0.5, var_294_11)

								iter_294_5.color = Color.New(var_294_15, var_294_15, var_294_15)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= var_294_9 + var_294_10 and arg_291_1.time_ < var_294_9 + var_294_10 + arg_294_0 and not isNil(var_294_8) and arg_291_1.var_.actorSpriteComps1137 then
				for iter_294_6, iter_294_7 in pairs(arg_291_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_294_7 then
						if arg_291_1.isInRecall_ then
							iter_294_7.color = arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_294_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps1137 = nil
			end

			local var_294_16 = 0
			local var_294_17 = 0.85

			if var_294_16 < arg_291_1.time_ and arg_291_1.time_ <= var_294_16 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_18 = arg_291_1:FormatText(StoryNameCfg[55].name)

				arg_291_1.leftNameTxt_.text = var_294_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_19 = arg_291_1:GetWordFromCfg(425032072)
				local var_294_20 = arg_291_1:FormatText(var_294_19.content)

				arg_291_1.text_.text = var_294_20

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_21 = 25
				local var_294_22 = utf8.len(var_294_20)
				local var_294_23 = var_294_21 <= 0 and var_294_17 or var_294_17 * (var_294_22 / var_294_21)

				if var_294_23 > 0 and var_294_17 < var_294_23 then
					arg_291_1.talkMaxDuration = var_294_23

					if var_294_23 + var_294_16 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_23 + var_294_16
					end
				end

				arg_291_1.text_.text = var_294_20
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032072", "story_v_out_425032.awb") ~= 0 then
					local var_294_24 = manager.audio:GetVoiceLength("story_v_out_425032", "425032072", "story_v_out_425032.awb") / 1000

					if var_294_24 + var_294_16 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_24 + var_294_16
					end

					if var_294_19.prefab_name ~= "" and arg_291_1.actors_[var_294_19.prefab_name] ~= nil then
						local var_294_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_19.prefab_name].transform, "story_v_out_425032", "425032072", "story_v_out_425032.awb")

						arg_291_1:RecordAudio("425032072", var_294_25)
						arg_291_1:RecordAudio("425032072", var_294_25)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_425032", "425032072", "story_v_out_425032.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_425032", "425032072", "story_v_out_425032.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_26 = math.max(var_294_17, arg_291_1.talkMaxDuration)

			if var_294_16 <= arg_291_1.time_ and arg_291_1.time_ < var_294_16 + var_294_26 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_16) / var_294_26

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_16 + var_294_26 and arg_291_1.time_ < var_294_16 + var_294_26 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play425032073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 425032073
		arg_295_1.duration_ = 8.6

		local var_295_0 = {
			zh = 6.333,
			ja = 8.6
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play425032074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 0.75

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_2 = arg_295_1:FormatText(StoryNameCfg[55].name)

				arg_295_1.leftNameTxt_.text = var_298_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_3 = arg_295_1:GetWordFromCfg(425032073)
				local var_298_4 = arg_295_1:FormatText(var_298_3.content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 30
				local var_298_6 = utf8.len(var_298_4)
				local var_298_7 = var_298_5 <= 0 and var_298_1 or var_298_1 * (var_298_6 / var_298_5)

				if var_298_7 > 0 and var_298_1 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_0
					end
				end

				arg_295_1.text_.text = var_298_4
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032073", "story_v_out_425032.awb") ~= 0 then
					local var_298_8 = manager.audio:GetVoiceLength("story_v_out_425032", "425032073", "story_v_out_425032.awb") / 1000

					if var_298_8 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_8 + var_298_0
					end

					if var_298_3.prefab_name ~= "" and arg_295_1.actors_[var_298_3.prefab_name] ~= nil then
						local var_298_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_3.prefab_name].transform, "story_v_out_425032", "425032073", "story_v_out_425032.awb")

						arg_295_1:RecordAudio("425032073", var_298_9)
						arg_295_1:RecordAudio("425032073", var_298_9)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_425032", "425032073", "story_v_out_425032.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_425032", "425032073", "story_v_out_425032.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_10 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_10 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_10

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_10 and arg_295_1.time_ < var_298_0 + var_298_10 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play425032074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 425032074
		arg_299_1.duration_ = 2.33

		local var_299_0 = {
			zh = 2.066,
			ja = 2.333
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play425032075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1137"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.actorSpriteComps1137 == nil then
				arg_299_1.var_.actorSpriteComps1137 = var_302_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_2 = 0.2

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 and not isNil(var_302_0) then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2

				if arg_299_1.var_.actorSpriteComps1137 then
					for iter_302_0, iter_302_1 in pairs(arg_299_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_302_1 then
							if arg_299_1.isInRecall_ then
								local var_302_4 = Mathf.Lerp(iter_302_1.color.r, arg_299_1.hightColor1.r, var_302_3)
								local var_302_5 = Mathf.Lerp(iter_302_1.color.g, arg_299_1.hightColor1.g, var_302_3)
								local var_302_6 = Mathf.Lerp(iter_302_1.color.b, arg_299_1.hightColor1.b, var_302_3)

								iter_302_1.color = Color.New(var_302_4, var_302_5, var_302_6)
							else
								local var_302_7 = Mathf.Lerp(iter_302_1.color.r, 1, var_302_3)

								iter_302_1.color = Color.New(var_302_7, var_302_7, var_302_7)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.actorSpriteComps1137 then
				for iter_302_2, iter_302_3 in pairs(arg_299_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_302_3 then
						if arg_299_1.isInRecall_ then
							iter_302_3.color = arg_299_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_302_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_299_1.var_.actorSpriteComps1137 = nil
			end

			local var_302_8 = arg_299_1.actors_["1080"]
			local var_302_9 = 0

			if var_302_9 < arg_299_1.time_ and arg_299_1.time_ <= var_302_9 + arg_302_0 and not isNil(var_302_8) and arg_299_1.var_.actorSpriteComps1080 == nil then
				arg_299_1.var_.actorSpriteComps1080 = var_302_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_10 = 0.2

			if var_302_9 <= arg_299_1.time_ and arg_299_1.time_ < var_302_9 + var_302_10 and not isNil(var_302_8) then
				local var_302_11 = (arg_299_1.time_ - var_302_9) / var_302_10

				if arg_299_1.var_.actorSpriteComps1080 then
					for iter_302_4, iter_302_5 in pairs(arg_299_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_302_5 then
							if arg_299_1.isInRecall_ then
								local var_302_12 = Mathf.Lerp(iter_302_5.color.r, arg_299_1.hightColor2.r, var_302_11)
								local var_302_13 = Mathf.Lerp(iter_302_5.color.g, arg_299_1.hightColor2.g, var_302_11)
								local var_302_14 = Mathf.Lerp(iter_302_5.color.b, arg_299_1.hightColor2.b, var_302_11)

								iter_302_5.color = Color.New(var_302_12, var_302_13, var_302_14)
							else
								local var_302_15 = Mathf.Lerp(iter_302_5.color.r, 0.5, var_302_11)

								iter_302_5.color = Color.New(var_302_15, var_302_15, var_302_15)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= var_302_9 + var_302_10 and arg_299_1.time_ < var_302_9 + var_302_10 + arg_302_0 and not isNil(var_302_8) and arg_299_1.var_.actorSpriteComps1080 then
				for iter_302_6, iter_302_7 in pairs(arg_299_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_302_7 then
						if arg_299_1.isInRecall_ then
							iter_302_7.color = arg_299_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_302_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_299_1.var_.actorSpriteComps1080 = nil
			end

			local var_302_16 = 0
			local var_302_17 = 0.05

			if var_302_16 < arg_299_1.time_ and arg_299_1.time_ <= var_302_16 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_18 = arg_299_1:FormatText(StoryNameCfg[15].name)

				arg_299_1.leftNameTxt_.text = var_302_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_19 = arg_299_1:GetWordFromCfg(425032074)
				local var_302_20 = arg_299_1:FormatText(var_302_19.content)

				arg_299_1.text_.text = var_302_20

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_21 = 2
				local var_302_22 = utf8.len(var_302_20)
				local var_302_23 = var_302_21 <= 0 and var_302_17 or var_302_17 * (var_302_22 / var_302_21)

				if var_302_23 > 0 and var_302_17 < var_302_23 then
					arg_299_1.talkMaxDuration = var_302_23

					if var_302_23 + var_302_16 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_23 + var_302_16
					end
				end

				arg_299_1.text_.text = var_302_20
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032074", "story_v_out_425032.awb") ~= 0 then
					local var_302_24 = manager.audio:GetVoiceLength("story_v_out_425032", "425032074", "story_v_out_425032.awb") / 1000

					if var_302_24 + var_302_16 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_24 + var_302_16
					end

					if var_302_19.prefab_name ~= "" and arg_299_1.actors_[var_302_19.prefab_name] ~= nil then
						local var_302_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_19.prefab_name].transform, "story_v_out_425032", "425032074", "story_v_out_425032.awb")

						arg_299_1:RecordAudio("425032074", var_302_25)
						arg_299_1:RecordAudio("425032074", var_302_25)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_425032", "425032074", "story_v_out_425032.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_425032", "425032074", "story_v_out_425032.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_26 = math.max(var_302_17, arg_299_1.talkMaxDuration)

			if var_302_16 <= arg_299_1.time_ and arg_299_1.time_ < var_302_16 + var_302_26 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_16) / var_302_26

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_16 + var_302_26 and arg_299_1.time_ < var_302_16 + var_302_26 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play425032075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 425032075
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play425032076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1137"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.actorSpriteComps1137 == nil then
				arg_303_1.var_.actorSpriteComps1137 = var_306_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_2 = 0.2

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.actorSpriteComps1137 then
					for iter_306_0, iter_306_1 in pairs(arg_303_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_306_1 then
							if arg_303_1.isInRecall_ then
								local var_306_4 = Mathf.Lerp(iter_306_1.color.r, arg_303_1.hightColor2.r, var_306_3)
								local var_306_5 = Mathf.Lerp(iter_306_1.color.g, arg_303_1.hightColor2.g, var_306_3)
								local var_306_6 = Mathf.Lerp(iter_306_1.color.b, arg_303_1.hightColor2.b, var_306_3)

								iter_306_1.color = Color.New(var_306_4, var_306_5, var_306_6)
							else
								local var_306_7 = Mathf.Lerp(iter_306_1.color.r, 0.5, var_306_3)

								iter_306_1.color = Color.New(var_306_7, var_306_7, var_306_7)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.actorSpriteComps1137 then
				for iter_306_2, iter_306_3 in pairs(arg_303_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_306_3 then
						if arg_303_1.isInRecall_ then
							iter_306_3.color = arg_303_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_306_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_303_1.var_.actorSpriteComps1137 = nil
			end

			local var_306_8 = arg_303_1.actors_["1137"].transform
			local var_306_9 = 0

			if var_306_9 < arg_303_1.time_ and arg_303_1.time_ <= var_306_9 + arg_306_0 then
				arg_303_1.var_.moveOldPos1137 = var_306_8.localPosition
				var_306_8.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("1137", 7)

				local var_306_10 = var_306_8.childCount

				for iter_306_4 = 0, var_306_10 - 1 do
					local var_306_11 = var_306_8:GetChild(iter_306_4)

					if var_306_11.name == "" or not string.find(var_306_11.name, "split") then
						var_306_11.gameObject:SetActive(true)
					else
						var_306_11.gameObject:SetActive(false)
					end
				end
			end

			local var_306_12 = 0.001

			if var_306_9 <= arg_303_1.time_ and arg_303_1.time_ < var_306_9 + var_306_12 then
				local var_306_13 = (arg_303_1.time_ - var_306_9) / var_306_12
				local var_306_14 = Vector3.New(0, -2000, 0)

				var_306_8.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1137, var_306_14, var_306_13)
			end

			if arg_303_1.time_ >= var_306_9 + var_306_12 and arg_303_1.time_ < var_306_9 + var_306_12 + arg_306_0 then
				var_306_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_306_15 = arg_303_1.actors_["1080"].transform
			local var_306_16 = 0

			if var_306_16 < arg_303_1.time_ and arg_303_1.time_ <= var_306_16 + arg_306_0 then
				arg_303_1.var_.moveOldPos1080 = var_306_15.localPosition
				var_306_15.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("1080", 7)

				local var_306_17 = var_306_15.childCount

				for iter_306_5 = 0, var_306_17 - 1 do
					local var_306_18 = var_306_15:GetChild(iter_306_5)

					if var_306_18.name == "" or not string.find(var_306_18.name, "split") then
						var_306_18.gameObject:SetActive(true)
					else
						var_306_18.gameObject:SetActive(false)
					end
				end
			end

			local var_306_19 = 0.001

			if var_306_16 <= arg_303_1.time_ and arg_303_1.time_ < var_306_16 + var_306_19 then
				local var_306_20 = (arg_303_1.time_ - var_306_16) / var_306_19
				local var_306_21 = Vector3.New(0, -2000, 0)

				var_306_15.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1080, var_306_21, var_306_20)
			end

			if arg_303_1.time_ >= var_306_16 + var_306_19 and arg_303_1.time_ < var_306_16 + var_306_19 + arg_306_0 then
				var_306_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_306_22 = 0
			local var_306_23 = 1.475

			if var_306_22 < arg_303_1.time_ and arg_303_1.time_ <= var_306_22 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_24 = arg_303_1:GetWordFromCfg(425032075)
				local var_306_25 = arg_303_1:FormatText(var_306_24.content)

				arg_303_1.text_.text = var_306_25

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_26 = 59
				local var_306_27 = utf8.len(var_306_25)
				local var_306_28 = var_306_26 <= 0 and var_306_23 or var_306_23 * (var_306_27 / var_306_26)

				if var_306_28 > 0 and var_306_23 < var_306_28 then
					arg_303_1.talkMaxDuration = var_306_28

					if var_306_28 + var_306_22 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_28 + var_306_22
					end
				end

				arg_303_1.text_.text = var_306_25
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_29 = math.max(var_306_23, arg_303_1.talkMaxDuration)

			if var_306_22 <= arg_303_1.time_ and arg_303_1.time_ < var_306_22 + var_306_29 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_22) / var_306_29

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_22 + var_306_29 and arg_303_1.time_ < var_306_22 + var_306_29 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play425032076 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 425032076
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play425032077(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0.1
			local var_310_1 = 1

			if var_310_0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				local var_310_2 = "play"
				local var_310_3 = "effect"

				arg_307_1:AudioAction(var_310_2, var_310_3, "se_story_1310", "se_story_1310_machine01", "")
			end

			local var_310_4 = 0
			local var_310_5 = 0.675

			if var_310_4 < arg_307_1.time_ and arg_307_1.time_ <= var_310_4 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_6 = arg_307_1:GetWordFromCfg(425032076)
				local var_310_7 = arg_307_1:FormatText(var_310_6.content)

				arg_307_1.text_.text = var_310_7

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_8 = 27
				local var_310_9 = utf8.len(var_310_7)
				local var_310_10 = var_310_8 <= 0 and var_310_5 or var_310_5 * (var_310_9 / var_310_8)

				if var_310_10 > 0 and var_310_5 < var_310_10 then
					arg_307_1.talkMaxDuration = var_310_10

					if var_310_10 + var_310_4 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_10 + var_310_4
					end
				end

				arg_307_1.text_.text = var_310_7
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_11 = math.max(var_310_5, arg_307_1.talkMaxDuration)

			if var_310_4 <= arg_307_1.time_ and arg_307_1.time_ < var_310_4 + var_310_11 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_4) / var_310_11

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_4 + var_310_11 and arg_307_1.time_ < var_310_4 + var_310_11 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play425032077 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 425032077
		arg_311_1.duration_ = 4.53

		local var_311_0 = {
			zh = 3.233,
			ja = 4.533
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play425032078(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1086"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps1086 == nil then
				arg_311_1.var_.actorSpriteComps1086 = var_314_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_2 = 0.2

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.actorSpriteComps1086 then
					for iter_314_0, iter_314_1 in pairs(arg_311_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_314_1 then
							if arg_311_1.isInRecall_ then
								local var_314_4 = Mathf.Lerp(iter_314_1.color.r, arg_311_1.hightColor1.r, var_314_3)
								local var_314_5 = Mathf.Lerp(iter_314_1.color.g, arg_311_1.hightColor1.g, var_314_3)
								local var_314_6 = Mathf.Lerp(iter_314_1.color.b, arg_311_1.hightColor1.b, var_314_3)

								iter_314_1.color = Color.New(var_314_4, var_314_5, var_314_6)
							else
								local var_314_7 = Mathf.Lerp(iter_314_1.color.r, 1, var_314_3)

								iter_314_1.color = Color.New(var_314_7, var_314_7, var_314_7)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps1086 then
				for iter_314_2, iter_314_3 in pairs(arg_311_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_314_3 then
						if arg_311_1.isInRecall_ then
							iter_314_3.color = arg_311_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_314_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_311_1.var_.actorSpriteComps1086 = nil
			end

			local var_314_8 = arg_311_1.actors_["1086"].transform
			local var_314_9 = 0

			if var_314_9 < arg_311_1.time_ and arg_311_1.time_ <= var_314_9 + arg_314_0 then
				arg_311_1.var_.moveOldPos1086 = var_314_8.localPosition
				var_314_8.localScale = Vector3.New(1, 1, 1)

				arg_311_1:CheckSpriteTmpPos("1086", 3)

				local var_314_10 = var_314_8.childCount

				for iter_314_4 = 0, var_314_10 - 1 do
					local var_314_11 = var_314_8:GetChild(iter_314_4)

					if var_314_11.name == "" or not string.find(var_314_11.name, "split") then
						var_314_11.gameObject:SetActive(true)
					else
						var_314_11.gameObject:SetActive(false)
					end
				end
			end

			local var_314_12 = 0.001

			if var_314_9 <= arg_311_1.time_ and arg_311_1.time_ < var_314_9 + var_314_12 then
				local var_314_13 = (arg_311_1.time_ - var_314_9) / var_314_12
				local var_314_14 = Vector3.New(0, -404.2, -237.9)

				var_314_8.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1086, var_314_14, var_314_13)
			end

			if arg_311_1.time_ >= var_314_9 + var_314_12 and arg_311_1.time_ < var_314_9 + var_314_12 + arg_314_0 then
				var_314_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_314_15 = 0
			local var_314_16 = 0.375

			if var_314_15 < arg_311_1.time_ and arg_311_1.time_ <= var_314_15 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_17 = arg_311_1:FormatText(StoryNameCfg[1080].name)

				arg_311_1.leftNameTxt_.text = var_314_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_18 = arg_311_1:GetWordFromCfg(425032077)
				local var_314_19 = arg_311_1:FormatText(var_314_18.content)

				arg_311_1.text_.text = var_314_19

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_20 = 15
				local var_314_21 = utf8.len(var_314_19)
				local var_314_22 = var_314_20 <= 0 and var_314_16 or var_314_16 * (var_314_21 / var_314_20)

				if var_314_22 > 0 and var_314_16 < var_314_22 then
					arg_311_1.talkMaxDuration = var_314_22

					if var_314_22 + var_314_15 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_22 + var_314_15
					end
				end

				arg_311_1.text_.text = var_314_19
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032077", "story_v_out_425032.awb") ~= 0 then
					local var_314_23 = manager.audio:GetVoiceLength("story_v_out_425032", "425032077", "story_v_out_425032.awb") / 1000

					if var_314_23 + var_314_15 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_23 + var_314_15
					end

					if var_314_18.prefab_name ~= "" and arg_311_1.actors_[var_314_18.prefab_name] ~= nil then
						local var_314_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_18.prefab_name].transform, "story_v_out_425032", "425032077", "story_v_out_425032.awb")

						arg_311_1:RecordAudio("425032077", var_314_24)
						arg_311_1:RecordAudio("425032077", var_314_24)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_425032", "425032077", "story_v_out_425032.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_425032", "425032077", "story_v_out_425032.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_25 = math.max(var_314_16, arg_311_1.talkMaxDuration)

			if var_314_15 <= arg_311_1.time_ and arg_311_1.time_ < var_314_15 + var_314_25 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_15) / var_314_25

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_15 + var_314_25 and arg_311_1.time_ < var_314_15 + var_314_25 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
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

		arg_311_1:InitPlayNodeList()
	end,
	Play425032078 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 425032078
		arg_315_1.duration_ = 14.03

		local var_315_0 = {
			zh = 7.633,
			ja = 14.033
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play425032079(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["1137"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps1137 == nil then
				arg_315_1.var_.actorSpriteComps1137 = var_318_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_2 = 0.2

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.actorSpriteComps1137 then
					for iter_318_0, iter_318_1 in pairs(arg_315_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_318_1 then
							if arg_315_1.isInRecall_ then
								local var_318_4 = Mathf.Lerp(iter_318_1.color.r, arg_315_1.hightColor1.r, var_318_3)
								local var_318_5 = Mathf.Lerp(iter_318_1.color.g, arg_315_1.hightColor1.g, var_318_3)
								local var_318_6 = Mathf.Lerp(iter_318_1.color.b, arg_315_1.hightColor1.b, var_318_3)

								iter_318_1.color = Color.New(var_318_4, var_318_5, var_318_6)
							else
								local var_318_7 = Mathf.Lerp(iter_318_1.color.r, 1, var_318_3)

								iter_318_1.color = Color.New(var_318_7, var_318_7, var_318_7)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps1137 then
				for iter_318_2, iter_318_3 in pairs(arg_315_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_318_3 then
						if arg_315_1.isInRecall_ then
							iter_318_3.color = arg_315_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_318_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_315_1.var_.actorSpriteComps1137 = nil
			end

			local var_318_8 = arg_315_1.actors_["1137"].transform
			local var_318_9 = 0

			if var_318_9 < arg_315_1.time_ and arg_315_1.time_ <= var_318_9 + arg_318_0 then
				arg_315_1.var_.moveOldPos1137 = var_318_8.localPosition
				var_318_8.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("1137", 2)

				local var_318_10 = var_318_8.childCount

				for iter_318_4 = 0, var_318_10 - 1 do
					local var_318_11 = var_318_8:GetChild(iter_318_4)

					if var_318_11.name == "split_4" or not string.find(var_318_11.name, "split") then
						var_318_11.gameObject:SetActive(true)
					else
						var_318_11.gameObject:SetActive(false)
					end
				end
			end

			local var_318_12 = 0.001

			if var_318_9 <= arg_315_1.time_ and arg_315_1.time_ < var_318_9 + var_318_12 then
				local var_318_13 = (arg_315_1.time_ - var_318_9) / var_318_12
				local var_318_14 = Vector3.New(-390, -425, -200)

				var_318_8.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1137, var_318_14, var_318_13)
			end

			if arg_315_1.time_ >= var_318_9 + var_318_12 and arg_315_1.time_ < var_318_9 + var_318_12 + arg_318_0 then
				var_318_8.localPosition = Vector3.New(-390, -425, -200)
			end

			local var_318_15 = arg_315_1.actors_["1086"].transform
			local var_318_16 = 0

			if var_318_16 < arg_315_1.time_ and arg_315_1.time_ <= var_318_16 + arg_318_0 then
				arg_315_1.var_.moveOldPos1086 = var_318_15.localPosition
				var_318_15.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("1086", 7)

				local var_318_17 = var_318_15.childCount

				for iter_318_5 = 0, var_318_17 - 1 do
					local var_318_18 = var_318_15:GetChild(iter_318_5)

					if var_318_18.name == "" or not string.find(var_318_18.name, "split") then
						var_318_18.gameObject:SetActive(true)
					else
						var_318_18.gameObject:SetActive(false)
					end
				end
			end

			local var_318_19 = 0.001

			if var_318_16 <= arg_315_1.time_ and arg_315_1.time_ < var_318_16 + var_318_19 then
				local var_318_20 = (arg_315_1.time_ - var_318_16) / var_318_19
				local var_318_21 = Vector3.New(0, -2000, 0)

				var_318_15.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1086, var_318_21, var_318_20)
			end

			if arg_315_1.time_ >= var_318_16 + var_318_19 and arg_315_1.time_ < var_318_16 + var_318_19 + arg_318_0 then
				var_318_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_318_22 = 0
			local var_318_23 = 0.825

			if var_318_22 < arg_315_1.time_ and arg_315_1.time_ <= var_318_22 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_24 = arg_315_1:FormatText(StoryNameCfg[15].name)

				arg_315_1.leftNameTxt_.text = var_318_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_25 = arg_315_1:GetWordFromCfg(425032078)
				local var_318_26 = arg_315_1:FormatText(var_318_25.content)

				arg_315_1.text_.text = var_318_26

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_27 = 33
				local var_318_28 = utf8.len(var_318_26)
				local var_318_29 = var_318_27 <= 0 and var_318_23 or var_318_23 * (var_318_28 / var_318_27)

				if var_318_29 > 0 and var_318_23 < var_318_29 then
					arg_315_1.talkMaxDuration = var_318_29

					if var_318_29 + var_318_22 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_29 + var_318_22
					end
				end

				arg_315_1.text_.text = var_318_26
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032078", "story_v_out_425032.awb") ~= 0 then
					local var_318_30 = manager.audio:GetVoiceLength("story_v_out_425032", "425032078", "story_v_out_425032.awb") / 1000

					if var_318_30 + var_318_22 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_30 + var_318_22
					end

					if var_318_25.prefab_name ~= "" and arg_315_1.actors_[var_318_25.prefab_name] ~= nil then
						local var_318_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_25.prefab_name].transform, "story_v_out_425032", "425032078", "story_v_out_425032.awb")

						arg_315_1:RecordAudio("425032078", var_318_31)
						arg_315_1:RecordAudio("425032078", var_318_31)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_425032", "425032078", "story_v_out_425032.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_425032", "425032078", "story_v_out_425032.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_32 = math.max(var_318_23, arg_315_1.talkMaxDuration)

			if var_318_22 <= arg_315_1.time_ and arg_315_1.time_ < var_318_22 + var_318_32 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_22) / var_318_32

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_22 + var_318_32 and arg_315_1.time_ < var_318_22 + var_318_32 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
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

		arg_315_1:InitPlayNodeList()
	end,
	Play425032079 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 425032079
		arg_319_1.duration_ = 11.9

		local var_319_0 = {
			zh = 6.066,
			ja = 11.9
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play425032080(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["1080"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.actorSpriteComps1080 == nil then
				arg_319_1.var_.actorSpriteComps1080 = var_322_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_2 = 0.2

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 and not isNil(var_322_0) then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2

				if arg_319_1.var_.actorSpriteComps1080 then
					for iter_322_0, iter_322_1 in pairs(arg_319_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_322_1 then
							if arg_319_1.isInRecall_ then
								local var_322_4 = Mathf.Lerp(iter_322_1.color.r, arg_319_1.hightColor1.r, var_322_3)
								local var_322_5 = Mathf.Lerp(iter_322_1.color.g, arg_319_1.hightColor1.g, var_322_3)
								local var_322_6 = Mathf.Lerp(iter_322_1.color.b, arg_319_1.hightColor1.b, var_322_3)

								iter_322_1.color = Color.New(var_322_4, var_322_5, var_322_6)
							else
								local var_322_7 = Mathf.Lerp(iter_322_1.color.r, 1, var_322_3)

								iter_322_1.color = Color.New(var_322_7, var_322_7, var_322_7)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.actorSpriteComps1080 then
				for iter_322_2, iter_322_3 in pairs(arg_319_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_322_3 then
						if arg_319_1.isInRecall_ then
							iter_322_3.color = arg_319_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_322_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_319_1.var_.actorSpriteComps1080 = nil
			end

			local var_322_8 = arg_319_1.actors_["1137"]
			local var_322_9 = 0

			if var_322_9 < arg_319_1.time_ and arg_319_1.time_ <= var_322_9 + arg_322_0 and not isNil(var_322_8) and arg_319_1.var_.actorSpriteComps1137 == nil then
				arg_319_1.var_.actorSpriteComps1137 = var_322_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_10 = 0.2

			if var_322_9 <= arg_319_1.time_ and arg_319_1.time_ < var_322_9 + var_322_10 and not isNil(var_322_8) then
				local var_322_11 = (arg_319_1.time_ - var_322_9) / var_322_10

				if arg_319_1.var_.actorSpriteComps1137 then
					for iter_322_4, iter_322_5 in pairs(arg_319_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_322_5 then
							if arg_319_1.isInRecall_ then
								local var_322_12 = Mathf.Lerp(iter_322_5.color.r, arg_319_1.hightColor2.r, var_322_11)
								local var_322_13 = Mathf.Lerp(iter_322_5.color.g, arg_319_1.hightColor2.g, var_322_11)
								local var_322_14 = Mathf.Lerp(iter_322_5.color.b, arg_319_1.hightColor2.b, var_322_11)

								iter_322_5.color = Color.New(var_322_12, var_322_13, var_322_14)
							else
								local var_322_15 = Mathf.Lerp(iter_322_5.color.r, 0.5, var_322_11)

								iter_322_5.color = Color.New(var_322_15, var_322_15, var_322_15)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= var_322_9 + var_322_10 and arg_319_1.time_ < var_322_9 + var_322_10 + arg_322_0 and not isNil(var_322_8) and arg_319_1.var_.actorSpriteComps1137 then
				for iter_322_6, iter_322_7 in pairs(arg_319_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_322_7 then
						if arg_319_1.isInRecall_ then
							iter_322_7.color = arg_319_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_322_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_319_1.var_.actorSpriteComps1137 = nil
			end

			local var_322_16 = arg_319_1.actors_["1080"].transform
			local var_322_17 = 0

			if var_322_17 < arg_319_1.time_ and arg_319_1.time_ <= var_322_17 + arg_322_0 then
				arg_319_1.var_.moveOldPos1080 = var_322_16.localPosition
				var_322_16.localScale = Vector3.New(1, 1, 1)

				arg_319_1:CheckSpriteTmpPos("1080", 4)

				local var_322_18 = var_322_16.childCount

				for iter_322_8 = 0, var_322_18 - 1 do
					local var_322_19 = var_322_16:GetChild(iter_322_8)

					if var_322_19.name == "" or not string.find(var_322_19.name, "split") then
						var_322_19.gameObject:SetActive(true)
					else
						var_322_19.gameObject:SetActive(false)
					end
				end
			end

			local var_322_20 = 0.001

			if var_322_17 <= arg_319_1.time_ and arg_319_1.time_ < var_322_17 + var_322_20 then
				local var_322_21 = (arg_319_1.time_ - var_322_17) / var_322_20
				local var_322_22 = Vector3.New(390, -378, -170)

				var_322_16.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1080, var_322_22, var_322_21)
			end

			if arg_319_1.time_ >= var_322_17 + var_322_20 and arg_319_1.time_ < var_322_17 + var_322_20 + arg_322_0 then
				var_322_16.localPosition = Vector3.New(390, -378, -170)
			end

			local var_322_23 = 0
			local var_322_24 = 0.625

			if var_322_23 < arg_319_1.time_ and arg_319_1.time_ <= var_322_23 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_25 = arg_319_1:FormatText(StoryNameCfg[55].name)

				arg_319_1.leftNameTxt_.text = var_322_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_26 = arg_319_1:GetWordFromCfg(425032079)
				local var_322_27 = arg_319_1:FormatText(var_322_26.content)

				arg_319_1.text_.text = var_322_27

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_28 = 25
				local var_322_29 = utf8.len(var_322_27)
				local var_322_30 = var_322_28 <= 0 and var_322_24 or var_322_24 * (var_322_29 / var_322_28)

				if var_322_30 > 0 and var_322_24 < var_322_30 then
					arg_319_1.talkMaxDuration = var_322_30

					if var_322_30 + var_322_23 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_30 + var_322_23
					end
				end

				arg_319_1.text_.text = var_322_27
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032079", "story_v_out_425032.awb") ~= 0 then
					local var_322_31 = manager.audio:GetVoiceLength("story_v_out_425032", "425032079", "story_v_out_425032.awb") / 1000

					if var_322_31 + var_322_23 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_31 + var_322_23
					end

					if var_322_26.prefab_name ~= "" and arg_319_1.actors_[var_322_26.prefab_name] ~= nil then
						local var_322_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_26.prefab_name].transform, "story_v_out_425032", "425032079", "story_v_out_425032.awb")

						arg_319_1:RecordAudio("425032079", var_322_32)
						arg_319_1:RecordAudio("425032079", var_322_32)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_425032", "425032079", "story_v_out_425032.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_425032", "425032079", "story_v_out_425032.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_33 = math.max(var_322_24, arg_319_1.talkMaxDuration)

			if var_322_23 <= arg_319_1.time_ and arg_319_1.time_ < var_322_23 + var_322_33 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_23) / var_322_33

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_23 + var_322_33 and arg_319_1.time_ < var_322_23 + var_322_33 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play425032080 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 425032080
		arg_323_1.duration_ = 10.2

		local var_323_0 = {
			zh = 5.833,
			ja = 10.2
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play425032081(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["1137"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.actorSpriteComps1137 == nil then
				arg_323_1.var_.actorSpriteComps1137 = var_326_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_2 = 0.2

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.actorSpriteComps1137 then
					for iter_326_0, iter_326_1 in pairs(arg_323_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_326_1 then
							if arg_323_1.isInRecall_ then
								local var_326_4 = Mathf.Lerp(iter_326_1.color.r, arg_323_1.hightColor1.r, var_326_3)
								local var_326_5 = Mathf.Lerp(iter_326_1.color.g, arg_323_1.hightColor1.g, var_326_3)
								local var_326_6 = Mathf.Lerp(iter_326_1.color.b, arg_323_1.hightColor1.b, var_326_3)

								iter_326_1.color = Color.New(var_326_4, var_326_5, var_326_6)
							else
								local var_326_7 = Mathf.Lerp(iter_326_1.color.r, 1, var_326_3)

								iter_326_1.color = Color.New(var_326_7, var_326_7, var_326_7)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.actorSpriteComps1137 then
				for iter_326_2, iter_326_3 in pairs(arg_323_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_326_3 then
						if arg_323_1.isInRecall_ then
							iter_326_3.color = arg_323_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_326_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_323_1.var_.actorSpriteComps1137 = nil
			end

			local var_326_8 = arg_323_1.actors_["1080"]
			local var_326_9 = 0

			if var_326_9 < arg_323_1.time_ and arg_323_1.time_ <= var_326_9 + arg_326_0 and not isNil(var_326_8) and arg_323_1.var_.actorSpriteComps1080 == nil then
				arg_323_1.var_.actorSpriteComps1080 = var_326_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_10 = 0.2

			if var_326_9 <= arg_323_1.time_ and arg_323_1.time_ < var_326_9 + var_326_10 and not isNil(var_326_8) then
				local var_326_11 = (arg_323_1.time_ - var_326_9) / var_326_10

				if arg_323_1.var_.actorSpriteComps1080 then
					for iter_326_4, iter_326_5 in pairs(arg_323_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_326_5 then
							if arg_323_1.isInRecall_ then
								local var_326_12 = Mathf.Lerp(iter_326_5.color.r, arg_323_1.hightColor2.r, var_326_11)
								local var_326_13 = Mathf.Lerp(iter_326_5.color.g, arg_323_1.hightColor2.g, var_326_11)
								local var_326_14 = Mathf.Lerp(iter_326_5.color.b, arg_323_1.hightColor2.b, var_326_11)

								iter_326_5.color = Color.New(var_326_12, var_326_13, var_326_14)
							else
								local var_326_15 = Mathf.Lerp(iter_326_5.color.r, 0.5, var_326_11)

								iter_326_5.color = Color.New(var_326_15, var_326_15, var_326_15)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= var_326_9 + var_326_10 and arg_323_1.time_ < var_326_9 + var_326_10 + arg_326_0 and not isNil(var_326_8) and arg_323_1.var_.actorSpriteComps1080 then
				for iter_326_6, iter_326_7 in pairs(arg_323_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_326_7 then
						if arg_323_1.isInRecall_ then
							iter_326_7.color = arg_323_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_326_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_323_1.var_.actorSpriteComps1080 = nil
			end

			local var_326_16 = 0
			local var_326_17 = 0.475

			if var_326_16 < arg_323_1.time_ and arg_323_1.time_ <= var_326_16 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_18 = arg_323_1:FormatText(StoryNameCfg[15].name)

				arg_323_1.leftNameTxt_.text = var_326_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_19 = arg_323_1:GetWordFromCfg(425032080)
				local var_326_20 = arg_323_1:FormatText(var_326_19.content)

				arg_323_1.text_.text = var_326_20

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_21 = 19
				local var_326_22 = utf8.len(var_326_20)
				local var_326_23 = var_326_21 <= 0 and var_326_17 or var_326_17 * (var_326_22 / var_326_21)

				if var_326_23 > 0 and var_326_17 < var_326_23 then
					arg_323_1.talkMaxDuration = var_326_23

					if var_326_23 + var_326_16 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_23 + var_326_16
					end
				end

				arg_323_1.text_.text = var_326_20
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032080", "story_v_out_425032.awb") ~= 0 then
					local var_326_24 = manager.audio:GetVoiceLength("story_v_out_425032", "425032080", "story_v_out_425032.awb") / 1000

					if var_326_24 + var_326_16 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_24 + var_326_16
					end

					if var_326_19.prefab_name ~= "" and arg_323_1.actors_[var_326_19.prefab_name] ~= nil then
						local var_326_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_19.prefab_name].transform, "story_v_out_425032", "425032080", "story_v_out_425032.awb")

						arg_323_1:RecordAudio("425032080", var_326_25)
						arg_323_1:RecordAudio("425032080", var_326_25)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_425032", "425032080", "story_v_out_425032.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_425032", "425032080", "story_v_out_425032.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_26 = math.max(var_326_17, arg_323_1.talkMaxDuration)

			if var_326_16 <= arg_323_1.time_ and arg_323_1.time_ < var_326_16 + var_326_26 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_16) / var_326_26

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_16 + var_326_26 and arg_323_1.time_ < var_326_16 + var_326_26 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play425032081 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 425032081
		arg_327_1.duration_ = 7.93

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play425032082(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = "STblack"

			if arg_327_1.bgs_[var_330_0] == nil then
				local var_330_1 = Object.Instantiate(arg_327_1.paintGo_)

				var_330_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_330_0)
				var_330_1.name = var_330_0
				var_330_1.transform.parent = arg_327_1.stage_.transform
				var_330_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_327_1.bgs_[var_330_0] = var_330_1
			end

			local var_330_2 = 5.20000033333333

			if var_330_2 < arg_327_1.time_ and arg_327_1.time_ <= var_330_2 + arg_330_0 then
				local var_330_3 = manager.ui.mainCamera.transform.localPosition
				local var_330_4 = Vector3.New(0, 0, 10) + Vector3.New(var_330_3.x, var_330_3.y, 0)
				local var_330_5 = arg_327_1.bgs_.STblack

				var_330_5.transform.localPosition = var_330_4
				var_330_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_330_6 = var_330_5:GetComponent("SpriteRenderer")

				if var_330_6 and var_330_6.sprite then
					local var_330_7 = (var_330_5.transform.localPosition - var_330_3).z
					local var_330_8 = manager.ui.mainCameraCom_
					local var_330_9 = 2 * var_330_7 * Mathf.Tan(var_330_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_330_10 = var_330_9 * var_330_8.aspect
					local var_330_11 = var_330_6.sprite.bounds.size.x
					local var_330_12 = var_330_6.sprite.bounds.size.y
					local var_330_13 = var_330_10 / var_330_11
					local var_330_14 = var_330_9 / var_330_12
					local var_330_15 = var_330_14 < var_330_13 and var_330_13 or var_330_14

					var_330_5.transform.localScale = Vector3.New(var_330_15, var_330_15, 0)
				end

				for iter_330_0, iter_330_1 in pairs(arg_327_1.bgs_) do
					if iter_330_0 ~= "STblack" then
						iter_330_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_330_16 = 7.20000033333332

			if var_330_16 < arg_327_1.time_ and arg_327_1.time_ <= var_330_16 + arg_330_0 then
				arg_327_1.allBtn_.enabled = false
			end

			local var_330_17 = 0.733333333333333

			if arg_327_1.time_ >= var_330_16 + var_330_17 and arg_327_1.time_ < var_330_16 + var_330_17 + arg_330_0 then
				arg_327_1.allBtn_.enabled = true
			end

			local var_330_18 = 0

			if var_330_18 < arg_327_1.time_ and arg_327_1.time_ <= var_330_18 + arg_330_0 then
				arg_327_1.mask_.enabled = true
				arg_327_1.mask_.raycastTarget = true

				arg_327_1:SetGaussion(false)
			end

			local var_330_19 = 2

			if var_330_18 <= arg_327_1.time_ and arg_327_1.time_ < var_330_18 + var_330_19 then
				local var_330_20 = (arg_327_1.time_ - var_330_18) / var_330_19
				local var_330_21 = Color.New(0, 0, 0)

				var_330_21.a = Mathf.Lerp(0, 1, var_330_20)
				arg_327_1.mask_.color = var_330_21
			end

			if arg_327_1.time_ >= var_330_18 + var_330_19 and arg_327_1.time_ < var_330_18 + var_330_19 + arg_330_0 then
				local var_330_22 = Color.New(0, 0, 0)

				var_330_22.a = 1
				arg_327_1.mask_.color = var_330_22
			end

			local var_330_23 = 1.999999999999

			if var_330_23 < arg_327_1.time_ and arg_327_1.time_ <= var_330_23 + arg_330_0 then
				arg_327_1.mask_.enabled = true
				arg_327_1.mask_.raycastTarget = true

				arg_327_1:SetGaussion(false)
			end

			local var_330_24 = 2

			if var_330_23 <= arg_327_1.time_ and arg_327_1.time_ < var_330_23 + var_330_24 then
				local var_330_25 = (arg_327_1.time_ - var_330_23) / var_330_24
				local var_330_26 = Color.New(0, 0, 0)

				var_330_26.a = Mathf.Lerp(1, 0, var_330_25)
				arg_327_1.mask_.color = var_330_26
			end

			if arg_327_1.time_ >= var_330_23 + var_330_24 and arg_327_1.time_ < var_330_23 + var_330_24 + arg_330_0 then
				local var_330_27 = Color.New(0, 0, 0)
				local var_330_28 = 0

				arg_327_1.mask_.enabled = false
				var_330_27.a = var_330_28
				arg_327_1.mask_.color = var_330_27
			end

			local var_330_29 = arg_327_1.actors_["1137"].transform
			local var_330_30 = 2

			if var_330_30 < arg_327_1.time_ and arg_327_1.time_ <= var_330_30 + arg_330_0 then
				arg_327_1.var_.moveOldPos1137 = var_330_29.localPosition
				var_330_29.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("1137", 7)

				local var_330_31 = var_330_29.childCount

				for iter_330_2 = 0, var_330_31 - 1 do
					local var_330_32 = var_330_29:GetChild(iter_330_2)

					if var_330_32.name == "split_4" or not string.find(var_330_32.name, "split") then
						var_330_32.gameObject:SetActive(true)
					else
						var_330_32.gameObject:SetActive(false)
					end
				end
			end

			local var_330_33 = 0.001

			if var_330_30 <= arg_327_1.time_ and arg_327_1.time_ < var_330_30 + var_330_33 then
				local var_330_34 = (arg_327_1.time_ - var_330_30) / var_330_33
				local var_330_35 = Vector3.New(0, -2000, 0)

				var_330_29.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1137, var_330_35, var_330_34)
			end

			if arg_327_1.time_ >= var_330_30 + var_330_33 and arg_327_1.time_ < var_330_30 + var_330_33 + arg_330_0 then
				var_330_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_330_36 = arg_327_1.actors_["1080"].transform
			local var_330_37 = 2

			if var_330_37 < arg_327_1.time_ and arg_327_1.time_ <= var_330_37 + arg_330_0 then
				arg_327_1.var_.moveOldPos1080 = var_330_36.localPosition
				var_330_36.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("1080", 7)

				local var_330_38 = var_330_36.childCount

				for iter_330_3 = 0, var_330_38 - 1 do
					local var_330_39 = var_330_36:GetChild(iter_330_3)

					if var_330_39.name == "" or not string.find(var_330_39.name, "split") then
						var_330_39.gameObject:SetActive(true)
					else
						var_330_39.gameObject:SetActive(false)
					end
				end
			end

			local var_330_40 = 0.001

			if var_330_37 <= arg_327_1.time_ and arg_327_1.time_ < var_330_37 + var_330_40 then
				local var_330_41 = (arg_327_1.time_ - var_330_37) / var_330_40
				local var_330_42 = Vector3.New(0, -2000, 0)

				var_330_36.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1080, var_330_42, var_330_41)
			end

			if arg_327_1.time_ >= var_330_37 + var_330_40 and arg_327_1.time_ < var_330_37 + var_330_40 + arg_330_0 then
				var_330_36.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_330_43 = 0.133333333333333
			local var_330_44 = 0.3

			if var_330_43 < arg_327_1.time_ and arg_327_1.time_ <= var_330_43 + arg_330_0 then
				local var_330_45 = "play"
				local var_330_46 = "music"

				arg_327_1:AudioAction(var_330_45, var_330_46, "ui_battle", "ui_battle_stopbgm", "")

				local var_330_47 = ""
				local var_330_48 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_330_48 ~= "" then
					if arg_327_1.bgmTxt_.text ~= var_330_48 and arg_327_1.bgmTxt_.text ~= "" then
						if arg_327_1.bgmTxt2_.text ~= "" then
							arg_327_1.bgmTxt_.text = arg_327_1.bgmTxt2_.text
						end

						arg_327_1.bgmTxt2_.text = var_330_48

						arg_327_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_327_1.bgmTxt_.text = var_330_48
						arg_327_1.bgmTxt2_.text = var_330_48
					end

					if arg_327_1.bgmTimer then
						arg_327_1.bgmTimer:Stop()

						arg_327_1.bgmTimer = nil
					end

					if arg_327_1.settingData.show_music_name == 1 then
						arg_327_1.musicController:SetSelectedState("show")
						arg_327_1.musicAnimator_:Play("open", 0, 0)

						if arg_327_1.settingData.music_time ~= 0 then
							arg_327_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_327_1.settingData.music_time), function()
								if arg_327_1 == nil or isNil(arg_327_1.bgmTxt_) then
									return
								end

								arg_327_1.musicController:SetSelectedState("hide")
								arg_327_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_330_49 = 2
			local var_330_50 = 1.999999999999
			local var_330_51 = "M01K"

			if var_330_49 < arg_327_1.time_ and arg_327_1.time_ <= var_330_49 + arg_330_0 then
				arg_327_1.timestampController_:SetSelectedState("show")
				arg_327_1.timestampAni_:Play("in")

				arg_327_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_330_51)

				arg_327_1.timestampColorController_:SetSelectedState("hot")
				arg_327_1.timeColdImg_:SetAlpha(0.031)

				local var_330_52 = arg_327_1:GetWordFromCfg(501106)
				local var_330_53 = arg_327_1:FormatText(var_330_52.content)

				arg_327_1.text_timeText_.text = var_330_53

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_timeText_)

				local var_330_54 = arg_327_1:GetWordFromCfg(501076)
				local var_330_55 = arg_327_1:FormatText(var_330_54.content)

				arg_327_1.text_siteText_.text = var_330_55

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_siteText_)
			end

			if arg_327_1.time_ >= var_330_49 + var_330_50 and arg_327_1.time_ < var_330_49 + var_330_50 + arg_330_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_327_1.timestampAni_, "out", function()
					arg_327_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_330_56 = 4.00000033333333

			if var_330_56 < arg_327_1.time_ and arg_327_1.time_ <= var_330_56 + arg_330_0 then
				arg_327_1.mask_.enabled = true
				arg_327_1.mask_.raycastTarget = true

				arg_327_1:SetGaussion(false)
			end

			local var_330_57 = 1.2

			if var_330_56 <= arg_327_1.time_ and arg_327_1.time_ < var_330_56 + var_330_57 then
				local var_330_58 = (arg_327_1.time_ - var_330_56) / var_330_57
				local var_330_59 = Color.New(0, 0, 0)

				var_330_59.a = Mathf.Lerp(0, 1, var_330_58)
				arg_327_1.mask_.color = var_330_59
			end

			if arg_327_1.time_ >= var_330_56 + var_330_57 and arg_327_1.time_ < var_330_56 + var_330_57 + arg_330_0 then
				local var_330_60 = Color.New(0, 0, 0)

				var_330_60.a = 1
				arg_327_1.mask_.color = var_330_60
			end

			local var_330_61 = 5.20000033333333

			if var_330_61 < arg_327_1.time_ and arg_327_1.time_ <= var_330_61 + arg_330_0 then
				arg_327_1.mask_.enabled = true
				arg_327_1.mask_.raycastTarget = true

				arg_327_1:SetGaussion(false)
			end

			local var_330_62 = 1.2

			if var_330_61 <= arg_327_1.time_ and arg_327_1.time_ < var_330_61 + var_330_62 then
				local var_330_63 = (arg_327_1.time_ - var_330_61) / var_330_62
				local var_330_64 = Color.New(0, 0, 0)

				var_330_64.a = Mathf.Lerp(1, 0, var_330_63)
				arg_327_1.mask_.color = var_330_64
			end

			if arg_327_1.time_ >= var_330_61 + var_330_62 and arg_327_1.time_ < var_330_61 + var_330_62 + arg_330_0 then
				local var_330_65 = Color.New(0, 0, 0)
				local var_330_66 = 0

				arg_327_1.mask_.enabled = false
				var_330_65.a = var_330_66
				arg_327_1.mask_.color = var_330_65
			end

			local var_330_67 = 2

			if var_330_67 < arg_327_1.time_ and arg_327_1.time_ <= var_330_67 + arg_330_0 then
				local var_330_68 = manager.ui.mainCamera.transform.localPosition
				local var_330_69 = Vector3.New(0, 0, 10) + Vector3.New(var_330_68.x, var_330_68.y, 0)
				local var_330_70 = arg_327_1.bgs_.ST2108

				var_330_70.transform.localPosition = var_330_69
				var_330_70.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_330_71 = var_330_70:GetComponent("SpriteRenderer")

				if var_330_71 and var_330_71.sprite then
					local var_330_72 = (var_330_70.transform.localPosition - var_330_68).z
					local var_330_73 = manager.ui.mainCameraCom_
					local var_330_74 = 2 * var_330_72 * Mathf.Tan(var_330_73.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_330_75 = var_330_74 * var_330_73.aspect
					local var_330_76 = var_330_71.sprite.bounds.size.x
					local var_330_77 = var_330_71.sprite.bounds.size.y
					local var_330_78 = var_330_75 / var_330_76
					local var_330_79 = var_330_74 / var_330_77
					local var_330_80 = var_330_79 < var_330_78 and var_330_78 or var_330_79

					var_330_70.transform.localScale = Vector3.New(var_330_80, var_330_80, 0)
				end

				for iter_330_4, iter_330_5 in pairs(arg_327_1.bgs_) do
					if iter_330_4 ~= "ST2108" then
						iter_330_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 425032081,
				charCount = 41,
				enableLayoutChange = true,
				duration = 2.73333333333333,
				groupID = "2081",
				startTime = 5.20000033333333,
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

		arg_327_1:InitPlayNodeList()
	end,
	Play425032082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 425032082
		arg_333_1.duration_ = 3.13

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play425032083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			return
		end

		arg_333_1.nodeConfigList_ = {
			{
				groupID = "2081",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 425032082,
				charCount = 47,
				enableLayoutChange = true,
				duration = 3.13333333333333,
				groupID = "2082",
				startTime = 0,
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

		arg_333_1:InitPlayNodeList()
	end,
	Play425032083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 425032083
		arg_337_1.duration_ = 3.47

		local var_337_0 = {
			zh = 2,
			ja = 3.466
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
				arg_337_0:Play425032084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0
			local var_340_1 = 0.175

			if var_340_0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_2 = arg_337_1:FormatText(StoryNameCfg[36].name)

				arg_337_1.leftNameTxt_.text = var_340_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_3 = arg_337_1:GetWordFromCfg(425032083)
				local var_340_4 = arg_337_1:FormatText(var_340_3.content)

				arg_337_1.text_.text = var_340_4

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032083", "story_v_out_425032.awb") ~= 0 then
					local var_340_8 = manager.audio:GetVoiceLength("story_v_out_425032", "425032083", "story_v_out_425032.awb") / 1000

					if var_340_8 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_0
					end

					if var_340_3.prefab_name ~= "" and arg_337_1.actors_[var_340_3.prefab_name] ~= nil then
						local var_340_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_3.prefab_name].transform, "story_v_out_425032", "425032083", "story_v_out_425032.awb")

						arg_337_1:RecordAudio("425032083", var_340_9)
						arg_337_1:RecordAudio("425032083", var_340_9)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_425032", "425032083", "story_v_out_425032.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_425032", "425032083", "story_v_out_425032.awb")
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

		arg_337_1.nodeConfigList_ = {
			{
				groupID = "2082",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play425032084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 425032084
		arg_341_1.duration_ = 8

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play425032085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = "ST2402"

			if arg_341_1.bgs_[var_344_0] == nil then
				local var_344_1 = Object.Instantiate(arg_341_1.paintGo_)

				var_344_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_344_0)
				var_344_1.name = var_344_0
				var_344_1.transform.parent = arg_341_1.stage_.transform
				var_344_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_341_1.bgs_[var_344_0] = var_344_1
			end

			local var_344_2 = 1

			if var_344_2 < arg_341_1.time_ and arg_341_1.time_ <= var_344_2 + arg_344_0 then
				local var_344_3 = manager.ui.mainCamera.transform.localPosition
				local var_344_4 = Vector3.New(0, 0, 10) + Vector3.New(var_344_3.x, var_344_3.y, 0)
				local var_344_5 = arg_341_1.bgs_.ST2402

				var_344_5.transform.localPosition = var_344_4
				var_344_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_344_6 = var_344_5:GetComponent("SpriteRenderer")

				if var_344_6 and var_344_6.sprite then
					local var_344_7 = (var_344_5.transform.localPosition - var_344_3).z
					local var_344_8 = manager.ui.mainCameraCom_
					local var_344_9 = 2 * var_344_7 * Mathf.Tan(var_344_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_344_10 = var_344_9 * var_344_8.aspect
					local var_344_11 = var_344_6.sprite.bounds.size.x
					local var_344_12 = var_344_6.sprite.bounds.size.y
					local var_344_13 = var_344_10 / var_344_11
					local var_344_14 = var_344_9 / var_344_12
					local var_344_15 = var_344_14 < var_344_13 and var_344_13 or var_344_14

					var_344_5.transform.localScale = Vector3.New(var_344_15, var_344_15, 0)
				end

				for iter_344_0, iter_344_1 in pairs(arg_341_1.bgs_) do
					if iter_344_0 ~= "ST2402" then
						iter_344_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_344_16 = 2.999999999999

			if var_344_16 < arg_341_1.time_ and arg_341_1.time_ <= var_344_16 + arg_344_0 then
				arg_341_1.allBtn_.enabled = false
			end

			local var_344_17 = 1.099999999999

			if arg_341_1.time_ >= var_344_16 + var_344_17 and arg_341_1.time_ < var_344_16 + var_344_17 + arg_344_0 then
				arg_341_1.allBtn_.enabled = true
			end

			local var_344_18 = 0

			if var_344_18 < arg_341_1.time_ and arg_341_1.time_ <= var_344_18 + arg_344_0 then
				arg_341_1.mask_.enabled = true
				arg_341_1.mask_.raycastTarget = true

				arg_341_1:SetGaussion(false)
			end

			local var_344_19 = 1

			if var_344_18 <= arg_341_1.time_ and arg_341_1.time_ < var_344_18 + var_344_19 then
				local var_344_20 = (arg_341_1.time_ - var_344_18) / var_344_19
				local var_344_21 = Color.New(0, 0, 0)

				var_344_21.a = Mathf.Lerp(0, 1, var_344_20)
				arg_341_1.mask_.color = var_344_21
			end

			if arg_341_1.time_ >= var_344_18 + var_344_19 and arg_341_1.time_ < var_344_18 + var_344_19 + arg_344_0 then
				local var_344_22 = Color.New(0, 0, 0)

				var_344_22.a = 1
				arg_341_1.mask_.color = var_344_22
			end

			local var_344_23 = 1

			if var_344_23 < arg_341_1.time_ and arg_341_1.time_ <= var_344_23 + arg_344_0 then
				arg_341_1.mask_.enabled = true
				arg_341_1.mask_.raycastTarget = true

				arg_341_1:SetGaussion(false)
			end

			local var_344_24 = 2

			if var_344_23 <= arg_341_1.time_ and arg_341_1.time_ < var_344_23 + var_344_24 then
				local var_344_25 = (arg_341_1.time_ - var_344_23) / var_344_24
				local var_344_26 = Color.New(0, 0, 0)

				var_344_26.a = Mathf.Lerp(1, 0, var_344_25)
				arg_341_1.mask_.color = var_344_26
			end

			if arg_341_1.time_ >= var_344_23 + var_344_24 and arg_341_1.time_ < var_344_23 + var_344_24 + arg_344_0 then
				local var_344_27 = Color.New(0, 0, 0)
				local var_344_28 = 0

				arg_341_1.mask_.enabled = false
				var_344_27.a = var_344_28
				arg_341_1.mask_.color = var_344_27
			end

			local var_344_29 = manager.ui.mainCamera.transform
			local var_344_30 = 1

			if var_344_30 < arg_341_1.time_ and arg_341_1.time_ <= var_344_30 + arg_344_0 then
				local var_344_31 = arg_341_1.var_.effect2084
				local var_344_32
				local var_344_33 = var_344_29

				if not var_344_31 then
					var_344_31 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapopen"), var_344_33)
					var_344_31.name = "2084"
					arg_341_1.var_.effect2084 = var_344_31
				else
					var_344_31.transform:SetParent(var_344_33)
				end

				var_344_31.transform.localPosition = Vector3.New(0, 0, 0)
				var_344_31.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_344_34 = manager.ui.mainCamera.transform
			local var_344_35 = 4.9

			if var_344_35 < arg_341_1.time_ and arg_341_1.time_ <= var_344_35 + arg_344_0 then
				local var_344_36 = arg_341_1.var_.effect2084

				if var_344_36 then
					Object.Destroy(var_344_36)

					arg_341_1.var_.effect2084 = nil
				end
			end

			local var_344_37
			local var_344_38 = 1

			if var_344_38 < arg_341_1.time_ and arg_341_1.time_ <= var_344_38 + arg_344_0 then
				local var_344_39 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_344_39 then
					var_344_39.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_344_39.radialBlurScale = 1
					var_344_39.radialBlurGradient = 1
					var_344_39.radialBlurIntensity = 1

					if var_344_37 then
						var_344_39.radialBlurTarget = var_344_37.transform
					end
				end
			end

			local var_344_40 = 3.099999999998

			if var_344_38 <= arg_341_1.time_ and arg_341_1.time_ < var_344_38 + var_344_40 then
				local var_344_41 = (arg_341_1.time_ - var_344_38) / var_344_40
				local var_344_42 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_344_42 then
					var_344_42.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_344_42.radialBlurScale = Mathf.Lerp(1, 0, var_344_41)
					var_344_42.radialBlurGradient = Mathf.Lerp(1, 0, var_344_41)
					var_344_42.radialBlurIntensity = Mathf.Lerp(1, 0, var_344_41)
				end
			end

			if arg_341_1.time_ >= var_344_38 + var_344_40 and arg_341_1.time_ < var_344_38 + var_344_40 + arg_344_0 then
				local var_344_43 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_344_43 then
					var_344_43.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_344_43.radialBlurScale = 0
					var_344_43.radialBlurGradient = 0
					var_344_43.radialBlurIntensity = 0
				end
			end

			local var_344_44 = 0.1
			local var_344_45 = 1

			if var_344_44 < arg_341_1.time_ and arg_341_1.time_ <= var_344_44 + arg_344_0 then
				local var_344_46 = "stop"
				local var_344_47 = "effect"

				arg_341_1:AudioAction(var_344_46, var_344_47, "se_story_142", "se_story_142_amb_commandroom", "")
			end

			local var_344_48 = 0.7
			local var_344_49 = 1

			if var_344_48 < arg_341_1.time_ and arg_341_1.time_ <= var_344_48 + arg_344_0 then
				local var_344_50 = "play"
				local var_344_51 = "effect"

				arg_341_1:AudioAction(var_344_50, var_344_51, "se_story_1310", "se_story_1310_wind", "")
			end

			local var_344_52 = 0
			local var_344_53 = 0.3

			if var_344_52 < arg_341_1.time_ and arg_341_1.time_ <= var_344_52 + arg_344_0 then
				local var_344_54 = "play"
				local var_344_55 = "music"

				arg_341_1:AudioAction(var_344_54, var_344_55, "ui_battle", "ui_battle_stopbgm", "")

				local var_344_56 = ""
				local var_344_57 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_344_57 ~= "" then
					if arg_341_1.bgmTxt_.text ~= var_344_57 and arg_341_1.bgmTxt_.text ~= "" then
						if arg_341_1.bgmTxt2_.text ~= "" then
							arg_341_1.bgmTxt_.text = arg_341_1.bgmTxt2_.text
						end

						arg_341_1.bgmTxt2_.text = var_344_57

						arg_341_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_341_1.bgmTxt_.text = var_344_57
						arg_341_1.bgmTxt2_.text = var_344_57
					end

					if arg_341_1.bgmTimer then
						arg_341_1.bgmTimer:Stop()

						arg_341_1.bgmTimer = nil
					end

					if arg_341_1.settingData.show_music_name == 1 then
						arg_341_1.musicController:SetSelectedState("show")
						arg_341_1.musicAnimator_:Play("open", 0, 0)

						if arg_341_1.settingData.music_time ~= 0 then
							arg_341_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_341_1.settingData.music_time), function()
								if arg_341_1 == nil or isNil(arg_341_1.bgmTxt_) then
									return
								end

								arg_341_1.musicController:SetSelectedState("hide")
								arg_341_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_344_58 = 0.7
			local var_344_59 = 1

			if var_344_58 < arg_341_1.time_ and arg_341_1.time_ <= var_344_58 + arg_344_0 then
				local var_344_60 = "play"
				local var_344_61 = "music"

				arg_341_1:AudioAction(var_344_60, var_344_61, "bgm_activity_4_7_story_garden", "bgm_activity_4_7_story_garden", "bgm_activity_4_7_story_garden.awb")

				local var_344_62 = ""
				local var_344_63 = manager.audio:GetAudioName("bgm_activity_4_7_story_garden", "bgm_activity_4_7_story_garden")

				if var_344_63 ~= "" then
					if arg_341_1.bgmTxt_.text ~= var_344_63 and arg_341_1.bgmTxt_.text ~= "" then
						if arg_341_1.bgmTxt2_.text ~= "" then
							arg_341_1.bgmTxt_.text = arg_341_1.bgmTxt2_.text
						end

						arg_341_1.bgmTxt2_.text = var_344_63

						arg_341_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_341_1.bgmTxt_.text = var_344_63
						arg_341_1.bgmTxt2_.text = var_344_63
					end

					if arg_341_1.bgmTimer then
						arg_341_1.bgmTimer:Stop()

						arg_341_1.bgmTimer = nil
					end

					if arg_341_1.settingData.show_music_name == 1 then
						arg_341_1.musicController:SetSelectedState("show")
						arg_341_1.musicAnimator_:Play("open", 0, 0)

						if arg_341_1.settingData.music_time ~= 0 then
							arg_341_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_341_1.settingData.music_time), function()
								if arg_341_1 == nil or isNil(arg_341_1.bgmTxt_) then
									return
								end

								arg_341_1.musicController:SetSelectedState("hide")
								arg_341_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_341_1.frameCnt_ <= 1 then
				arg_341_1.dialog_:SetActive(false)
			end

			local var_344_64 = 2.999999999999
			local var_344_65 = 1.1

			if var_344_64 < arg_341_1.time_ and arg_341_1.time_ <= var_344_64 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0

				arg_341_1.dialog_:SetActive(true)

				arg_341_1.dialogCg_.alpha = 0

				local var_344_66 = LeanTween.value(arg_341_1.dialog_, 0, 1, 0.3)

				var_344_66:setOnUpdate(LuaHelper.FloatAction(function(arg_347_0)
					arg_341_1.dialogCg_.alpha = arg_347_0
				end))
				var_344_66:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_341_1.dialog_)
					var_344_66:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_341_1.duration_ = arg_341_1.duration_ + 0.3

				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_67 = arg_341_1:GetWordFromCfg(425032084)
				local var_344_68 = arg_341_1:FormatText(var_344_67.content)

				arg_341_1.text_.text = var_344_68

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_69 = 44
				local var_344_70 = utf8.len(var_344_68)
				local var_344_71 = var_344_69 <= 0 and var_344_65 or var_344_65 * (var_344_70 / var_344_69)

				if var_344_71 > 0 and var_344_65 < var_344_71 then
					arg_341_1.talkMaxDuration = var_344_71
					var_344_64 = var_344_64 + 0.3

					if var_344_71 + var_344_64 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_71 + var_344_64
					end
				end

				arg_341_1.text_.text = var_344_68
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_72 = var_344_64 + 0.3
			local var_344_73 = math.max(var_344_65, arg_341_1.talkMaxDuration)

			if var_344_72 <= arg_341_1.time_ and arg_341_1.time_ < var_344_72 + var_344_73 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_72) / var_344_73

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_72 + var_344_73 and arg_341_1.time_ < var_344_72 + var_344_73 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play425032085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 425032085
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play425032086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0
			local var_352_1 = 0.125

			if var_352_0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_2 = arg_349_1:FormatText(StoryNameCfg[7].name)

				arg_349_1.leftNameTxt_.text = var_352_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_3 = arg_349_1:GetWordFromCfg(425032085)
				local var_352_4 = arg_349_1:FormatText(var_352_3.content)

				arg_349_1.text_.text = var_352_4

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_5 = 5
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
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_8 = math.max(var_352_1, arg_349_1.talkMaxDuration)

			if var_352_0 <= arg_349_1.time_ and arg_349_1.time_ < var_352_0 + var_352_8 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_0) / var_352_8

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_0 + var_352_8 and arg_349_1.time_ < var_352_0 + var_352_8 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play425032086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 425032086
		arg_353_1.duration_ = 3.03

		local var_353_0 = {
			zh = 1.433,
			ja = 3.033
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play425032087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0
			local var_356_1 = 0.15

			if var_356_0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_2 = arg_353_1:FormatText(StoryNameCfg[36].name)

				arg_353_1.leftNameTxt_.text = var_356_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_3 = arg_353_1:GetWordFromCfg(425032086)
				local var_356_4 = arg_353_1:FormatText(var_356_3.content)

				arg_353_1.text_.text = var_356_4

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032086", "story_v_out_425032.awb") ~= 0 then
					local var_356_8 = manager.audio:GetVoiceLength("story_v_out_425032", "425032086", "story_v_out_425032.awb") / 1000

					if var_356_8 + var_356_0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_8 + var_356_0
					end

					if var_356_3.prefab_name ~= "" and arg_353_1.actors_[var_356_3.prefab_name] ~= nil then
						local var_356_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_3.prefab_name].transform, "story_v_out_425032", "425032086", "story_v_out_425032.awb")

						arg_353_1:RecordAudio("425032086", var_356_9)
						arg_353_1:RecordAudio("425032086", var_356_9)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_425032", "425032086", "story_v_out_425032.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_425032", "425032086", "story_v_out_425032.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_10 = math.max(var_356_1, arg_353_1.talkMaxDuration)

			if var_356_0 <= arg_353_1.time_ and arg_353_1.time_ < var_356_0 + var_356_10 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_0) / var_356_10

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_0 + var_356_10 and arg_353_1.time_ < var_356_0 + var_356_10 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play425032087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 425032087
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play425032088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0
			local var_360_1 = 1.825

			if var_360_0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_2 = arg_357_1:GetWordFromCfg(425032087)
				local var_360_3 = arg_357_1:FormatText(var_360_2.content)

				arg_357_1.text_.text = var_360_3

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_4 = 73
				local var_360_5 = utf8.len(var_360_3)
				local var_360_6 = var_360_4 <= 0 and var_360_1 or var_360_1 * (var_360_5 / var_360_4)

				if var_360_6 > 0 and var_360_1 < var_360_6 then
					arg_357_1.talkMaxDuration = var_360_6

					if var_360_6 + var_360_0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_6 + var_360_0
					end
				end

				arg_357_1.text_.text = var_360_3
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_7 = math.max(var_360_1, arg_357_1.talkMaxDuration)

			if var_360_0 <= arg_357_1.time_ and arg_357_1.time_ < var_360_0 + var_360_7 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_0) / var_360_7

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_0 + var_360_7 and arg_357_1.time_ < var_360_0 + var_360_7 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play425032088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 425032088
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play425032089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0
			local var_364_1 = 1.325

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

				local var_364_2 = arg_361_1:GetWordFromCfg(425032088)
				local var_364_3 = arg_361_1:FormatText(var_364_2.content)

				arg_361_1.text_.text = var_364_3

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_4 = 53
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
	Play425032089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 425032089
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play425032090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0
			local var_368_1 = 0.2

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_2 = arg_365_1:FormatText(StoryNameCfg[7].name)

				arg_365_1.leftNameTxt_.text = var_368_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_3 = arg_365_1:GetWordFromCfg(425032089)
				local var_368_4 = arg_365_1:FormatText(var_368_3.content)

				arg_365_1.text_.text = var_368_4

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 8
				local var_368_6 = utf8.len(var_368_4)
				local var_368_7 = var_368_5 <= 0 and var_368_1 or var_368_1 * (var_368_6 / var_368_5)

				if var_368_7 > 0 and var_368_1 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_0
					end
				end

				arg_365_1.text_.text = var_368_4
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_8 = math.max(var_368_1, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_8 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_0) / var_368_8

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_8 and arg_365_1.time_ < var_368_0 + var_368_8 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play425032090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 425032090
		arg_369_1.duration_ = 3.37

		local var_369_0 = {
			zh = 1.666,
			ja = 3.366
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play425032091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = "10157"

			if arg_369_1.actors_[var_372_0] == nil then
				local var_372_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10157")

				if not isNil(var_372_1) then
					local var_372_2 = Object.Instantiate(var_372_1, arg_369_1.canvasGo_.transform)

					var_372_2.transform:SetSiblingIndex(1)

					var_372_2.name = var_372_0
					var_372_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_369_1.actors_[var_372_0] = var_372_2

					local var_372_3 = var_372_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_369_1.isInRecall_ then
						for iter_372_0, iter_372_1 in ipairs(var_372_3) do
							iter_372_1.color = arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_372_4 = arg_369_1.actors_["10157"]
			local var_372_5 = 0

			if var_372_5 < arg_369_1.time_ and arg_369_1.time_ <= var_372_5 + arg_372_0 and not isNil(var_372_4) and arg_369_1.var_.actorSpriteComps10157 == nil then
				arg_369_1.var_.actorSpriteComps10157 = var_372_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_6 = 0.2

			if var_372_5 <= arg_369_1.time_ and arg_369_1.time_ < var_372_5 + var_372_6 and not isNil(var_372_4) then
				local var_372_7 = (arg_369_1.time_ - var_372_5) / var_372_6

				if arg_369_1.var_.actorSpriteComps10157 then
					for iter_372_2, iter_372_3 in pairs(arg_369_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_372_3 then
							if arg_369_1.isInRecall_ then
								local var_372_8 = Mathf.Lerp(iter_372_3.color.r, arg_369_1.hightColor1.r, var_372_7)
								local var_372_9 = Mathf.Lerp(iter_372_3.color.g, arg_369_1.hightColor1.g, var_372_7)
								local var_372_10 = Mathf.Lerp(iter_372_3.color.b, arg_369_1.hightColor1.b, var_372_7)

								iter_372_3.color = Color.New(var_372_8, var_372_9, var_372_10)
							else
								local var_372_11 = Mathf.Lerp(iter_372_3.color.r, 1, var_372_7)

								iter_372_3.color = Color.New(var_372_11, var_372_11, var_372_11)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= var_372_5 + var_372_6 and arg_369_1.time_ < var_372_5 + var_372_6 + arg_372_0 and not isNil(var_372_4) and arg_369_1.var_.actorSpriteComps10157 then
				for iter_372_4, iter_372_5 in pairs(arg_369_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_372_5 then
						if arg_369_1.isInRecall_ then
							iter_372_5.color = arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_372_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_369_1.var_.actorSpriteComps10157 = nil
			end

			local var_372_12 = arg_369_1.actors_["10157"].transform
			local var_372_13 = 0

			if var_372_13 < arg_369_1.time_ and arg_369_1.time_ <= var_372_13 + arg_372_0 then
				arg_369_1.var_.moveOldPos10157 = var_372_12.localPosition
				var_372_12.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("10157", 3)

				local var_372_14 = var_372_12.childCount

				for iter_372_6 = 0, var_372_14 - 1 do
					local var_372_15 = var_372_12:GetChild(iter_372_6)

					if var_372_15.name == "" or not string.find(var_372_15.name, "split") then
						var_372_15.gameObject:SetActive(true)
					else
						var_372_15.gameObject:SetActive(false)
					end
				end
			end

			local var_372_16 = 0.001

			if var_372_13 <= arg_369_1.time_ and arg_369_1.time_ < var_372_13 + var_372_16 then
				local var_372_17 = (arg_369_1.time_ - var_372_13) / var_372_16
				local var_372_18 = Vector3.New(0, -402.7, -156.1)

				var_372_12.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos10157, var_372_18, var_372_17)
			end

			if arg_369_1.time_ >= var_372_13 + var_372_16 and arg_369_1.time_ < var_372_13 + var_372_16 + arg_372_0 then
				var_372_12.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_372_19 = 0
			local var_372_20 = 0.125

			if var_372_19 < arg_369_1.time_ and arg_369_1.time_ <= var_372_19 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_21 = arg_369_1:FormatText(StoryNameCfg[1434].name)

				arg_369_1.leftNameTxt_.text = var_372_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_22 = arg_369_1:GetWordFromCfg(425032090)
				local var_372_23 = arg_369_1:FormatText(var_372_22.content)

				arg_369_1.text_.text = var_372_23

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_24 = 5
				local var_372_25 = utf8.len(var_372_23)
				local var_372_26 = var_372_24 <= 0 and var_372_20 or var_372_20 * (var_372_25 / var_372_24)

				if var_372_26 > 0 and var_372_20 < var_372_26 then
					arg_369_1.talkMaxDuration = var_372_26

					if var_372_26 + var_372_19 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_26 + var_372_19
					end
				end

				arg_369_1.text_.text = var_372_23
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032090", "story_v_out_425032.awb") ~= 0 then
					local var_372_27 = manager.audio:GetVoiceLength("story_v_out_425032", "425032090", "story_v_out_425032.awb") / 1000

					if var_372_27 + var_372_19 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_27 + var_372_19
					end

					if var_372_22.prefab_name ~= "" and arg_369_1.actors_[var_372_22.prefab_name] ~= nil then
						local var_372_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_22.prefab_name].transform, "story_v_out_425032", "425032090", "story_v_out_425032.awb")

						arg_369_1:RecordAudio("425032090", var_372_28)
						arg_369_1:RecordAudio("425032090", var_372_28)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_425032", "425032090", "story_v_out_425032.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_425032", "425032090", "story_v_out_425032.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_29 = math.max(var_372_20, arg_369_1.talkMaxDuration)

			if var_372_19 <= arg_369_1.time_ and arg_369_1.time_ < var_372_19 + var_372_29 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_19) / var_372_29

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_19 + var_372_29 and arg_369_1.time_ < var_372_19 + var_372_29 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play425032091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 425032091
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play425032092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["10157"]
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.actorSpriteComps10157 == nil then
				arg_373_1.var_.actorSpriteComps10157 = var_376_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_2 = 0.2

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 and not isNil(var_376_0) then
				local var_376_3 = (arg_373_1.time_ - var_376_1) / var_376_2

				if arg_373_1.var_.actorSpriteComps10157 then
					for iter_376_0, iter_376_1 in pairs(arg_373_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_376_1 then
							if arg_373_1.isInRecall_ then
								local var_376_4 = Mathf.Lerp(iter_376_1.color.r, arg_373_1.hightColor2.r, var_376_3)
								local var_376_5 = Mathf.Lerp(iter_376_1.color.g, arg_373_1.hightColor2.g, var_376_3)
								local var_376_6 = Mathf.Lerp(iter_376_1.color.b, arg_373_1.hightColor2.b, var_376_3)

								iter_376_1.color = Color.New(var_376_4, var_376_5, var_376_6)
							else
								local var_376_7 = Mathf.Lerp(iter_376_1.color.r, 0.5, var_376_3)

								iter_376_1.color = Color.New(var_376_7, var_376_7, var_376_7)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= var_376_1 + var_376_2 and arg_373_1.time_ < var_376_1 + var_376_2 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.actorSpriteComps10157 then
				for iter_376_2, iter_376_3 in pairs(arg_373_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_376_3 then
						if arg_373_1.isInRecall_ then
							iter_376_3.color = arg_373_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_376_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_373_1.var_.actorSpriteComps10157 = nil
			end

			local var_376_8 = 0
			local var_376_9 = 0.625

			if var_376_8 < arg_373_1.time_ and arg_373_1.time_ <= var_376_8 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_10 = arg_373_1:FormatText(StoryNameCfg[7].name)

				arg_373_1.leftNameTxt_.text = var_376_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_11 = arg_373_1:GetWordFromCfg(425032091)
				local var_376_12 = arg_373_1:FormatText(var_376_11.content)

				arg_373_1.text_.text = var_376_12

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_13 = 25
				local var_376_14 = utf8.len(var_376_12)
				local var_376_15 = var_376_13 <= 0 and var_376_9 or var_376_9 * (var_376_14 / var_376_13)

				if var_376_15 > 0 and var_376_9 < var_376_15 then
					arg_373_1.talkMaxDuration = var_376_15

					if var_376_15 + var_376_8 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_15 + var_376_8
					end
				end

				arg_373_1.text_.text = var_376_12
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_16 = math.max(var_376_9, arg_373_1.talkMaxDuration)

			if var_376_8 <= arg_373_1.time_ and arg_373_1.time_ < var_376_8 + var_376_16 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_8) / var_376_16

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_8 + var_376_16 and arg_373_1.time_ < var_376_8 + var_376_16 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play425032092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 425032092
		arg_377_1.duration_ = 7.87

		local var_377_0 = {
			zh = 5.966,
			ja = 7.866
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play425032093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["10157"]
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.actorSpriteComps10157 == nil then
				arg_377_1.var_.actorSpriteComps10157 = var_380_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_2 = 0.2

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_2 and not isNil(var_380_0) then
				local var_380_3 = (arg_377_1.time_ - var_380_1) / var_380_2

				if arg_377_1.var_.actorSpriteComps10157 then
					for iter_380_0, iter_380_1 in pairs(arg_377_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_380_1 then
							if arg_377_1.isInRecall_ then
								local var_380_4 = Mathf.Lerp(iter_380_1.color.r, arg_377_1.hightColor1.r, var_380_3)
								local var_380_5 = Mathf.Lerp(iter_380_1.color.g, arg_377_1.hightColor1.g, var_380_3)
								local var_380_6 = Mathf.Lerp(iter_380_1.color.b, arg_377_1.hightColor1.b, var_380_3)

								iter_380_1.color = Color.New(var_380_4, var_380_5, var_380_6)
							else
								local var_380_7 = Mathf.Lerp(iter_380_1.color.r, 1, var_380_3)

								iter_380_1.color = Color.New(var_380_7, var_380_7, var_380_7)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= var_380_1 + var_380_2 and arg_377_1.time_ < var_380_1 + var_380_2 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.actorSpriteComps10157 then
				for iter_380_2, iter_380_3 in pairs(arg_377_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_380_3 then
						if arg_377_1.isInRecall_ then
							iter_380_3.color = arg_377_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_380_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_377_1.var_.actorSpriteComps10157 = nil
			end

			local var_380_8 = arg_377_1.actors_["10157"].transform
			local var_380_9 = 0

			if var_380_9 < arg_377_1.time_ and arg_377_1.time_ <= var_380_9 + arg_380_0 then
				arg_377_1.var_.moveOldPos10157 = var_380_8.localPosition
				var_380_8.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("10157", 3)

				local var_380_10 = var_380_8.childCount

				for iter_380_4 = 0, var_380_10 - 1 do
					local var_380_11 = var_380_8:GetChild(iter_380_4)

					if var_380_11.name == "split_4" then
						var_380_11:SetAsLastSibling()
						var_380_11.gameObject:SetActive(true)

						arg_377_1.var_.actorSpriteSplit10157 = var_380_11.gameObject:GetComponent(typeof(Image))

						arg_377_1.var_.actorSpriteSplit10157:SetAlpha(0)
					end
				end
			end

			local var_380_12 = 0.5

			if var_380_9 <= arg_377_1.time_ and arg_377_1.time_ < var_380_9 + var_380_12 then
				local var_380_13 = (arg_377_1.time_ - var_380_9) / var_380_12
				local var_380_14 = Vector3.New(0, -402.7, -156.1)

				var_380_8.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos10157, var_380_14, var_380_13)

				if arg_377_1.var_.actorSpriteSplit10157 ~= nil then
					arg_377_1.var_.actorSpriteSplit10157:SetAlpha(var_380_13)
				end
			end

			if arg_377_1.time_ >= var_380_9 + var_380_12 and arg_377_1.time_ < var_380_9 + var_380_12 + arg_380_0 then
				var_380_8.localPosition = Vector3.New(0, -402.7, -156.1)

				if arg_377_1.var_.actorSpriteSplit10157 ~= nil then
					arg_377_1.var_.actorSpriteSplit10157:SetAlpha(1)
				end
			end

			local var_380_15 = 0
			local var_380_16 = 0.6

			if var_380_15 < arg_377_1.time_ and arg_377_1.time_ <= var_380_15 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_17 = arg_377_1:FormatText(StoryNameCfg[1434].name)

				arg_377_1.leftNameTxt_.text = var_380_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_18 = arg_377_1:GetWordFromCfg(425032092)
				local var_380_19 = arg_377_1:FormatText(var_380_18.content)

				arg_377_1.text_.text = var_380_19

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_20 = 24
				local var_380_21 = utf8.len(var_380_19)
				local var_380_22 = var_380_20 <= 0 and var_380_16 or var_380_16 * (var_380_21 / var_380_20)

				if var_380_22 > 0 and var_380_16 < var_380_22 then
					arg_377_1.talkMaxDuration = var_380_22

					if var_380_22 + var_380_15 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_22 + var_380_15
					end
				end

				arg_377_1.text_.text = var_380_19
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032092", "story_v_out_425032.awb") ~= 0 then
					local var_380_23 = manager.audio:GetVoiceLength("story_v_out_425032", "425032092", "story_v_out_425032.awb") / 1000

					if var_380_23 + var_380_15 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_23 + var_380_15
					end

					if var_380_18.prefab_name ~= "" and arg_377_1.actors_[var_380_18.prefab_name] ~= nil then
						local var_380_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_18.prefab_name].transform, "story_v_out_425032", "425032092", "story_v_out_425032.awb")

						arg_377_1:RecordAudio("425032092", var_380_24)
						arg_377_1:RecordAudio("425032092", var_380_24)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_425032", "425032092", "story_v_out_425032.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_425032", "425032092", "story_v_out_425032.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_25 = math.max(var_380_16, arg_377_1.talkMaxDuration)

			if var_380_15 <= arg_377_1.time_ and arg_377_1.time_ < var_380_15 + var_380_25 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_15) / var_380_25

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_15 + var_380_25 and arg_377_1.time_ < var_380_15 + var_380_25 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play425032093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 425032093
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play425032094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["10157"]
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.actorSpriteComps10157 == nil then
				arg_381_1.var_.actorSpriteComps10157 = var_384_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_2 = 0.2

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_2 and not isNil(var_384_0) then
				local var_384_3 = (arg_381_1.time_ - var_384_1) / var_384_2

				if arg_381_1.var_.actorSpriteComps10157 then
					for iter_384_0, iter_384_1 in pairs(arg_381_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_384_1 then
							if arg_381_1.isInRecall_ then
								local var_384_4 = Mathf.Lerp(iter_384_1.color.r, arg_381_1.hightColor2.r, var_384_3)
								local var_384_5 = Mathf.Lerp(iter_384_1.color.g, arg_381_1.hightColor2.g, var_384_3)
								local var_384_6 = Mathf.Lerp(iter_384_1.color.b, arg_381_1.hightColor2.b, var_384_3)

								iter_384_1.color = Color.New(var_384_4, var_384_5, var_384_6)
							else
								local var_384_7 = Mathf.Lerp(iter_384_1.color.r, 0.5, var_384_3)

								iter_384_1.color = Color.New(var_384_7, var_384_7, var_384_7)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= var_384_1 + var_384_2 and arg_381_1.time_ < var_384_1 + var_384_2 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.actorSpriteComps10157 then
				for iter_384_2, iter_384_3 in pairs(arg_381_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_384_3 then
						if arg_381_1.isInRecall_ then
							iter_384_3.color = arg_381_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_384_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_381_1.var_.actorSpriteComps10157 = nil
			end

			local var_384_8 = 0
			local var_384_9 = 0.45

			if var_384_8 < arg_381_1.time_ and arg_381_1.time_ <= var_384_8 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_10 = arg_381_1:FormatText(StoryNameCfg[7].name)

				arg_381_1.leftNameTxt_.text = var_384_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, true)
				arg_381_1.iconController_:SetSelectedState("hero")

				arg_381_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_381_1.callingController_:SetSelectedState("normal")

				arg_381_1.keyicon_.color = Color.New(1, 1, 1)
				arg_381_1.icon_.color = Color.New(1, 1, 1)

				local var_384_11 = arg_381_1:GetWordFromCfg(425032093)
				local var_384_12 = arg_381_1:FormatText(var_384_11.content)

				arg_381_1.text_.text = var_384_12

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_13 = 18
				local var_384_14 = utf8.len(var_384_12)
				local var_384_15 = var_384_13 <= 0 and var_384_9 or var_384_9 * (var_384_14 / var_384_13)

				if var_384_15 > 0 and var_384_9 < var_384_15 then
					arg_381_1.talkMaxDuration = var_384_15

					if var_384_15 + var_384_8 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_15 + var_384_8
					end
				end

				arg_381_1.text_.text = var_384_12
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_16 = math.max(var_384_9, arg_381_1.talkMaxDuration)

			if var_384_8 <= arg_381_1.time_ and arg_381_1.time_ < var_384_8 + var_384_16 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_8) / var_384_16

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_8 + var_384_16 and arg_381_1.time_ < var_384_8 + var_384_16 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play425032094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 425032094
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play425032095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["10157"].transform
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 then
				arg_385_1.var_.moveOldPos10157 = var_388_0.localPosition
				var_388_0.localScale = Vector3.New(1, 1, 1)

				arg_385_1:CheckSpriteTmpPos("10157", 7)

				local var_388_2 = var_388_0.childCount

				for iter_388_0 = 0, var_388_2 - 1 do
					local var_388_3 = var_388_0:GetChild(iter_388_0)

					if var_388_3.name == "" or not string.find(var_388_3.name, "split") then
						var_388_3.gameObject:SetActive(true)
					else
						var_388_3.gameObject:SetActive(false)
					end
				end
			end

			local var_388_4 = 0.001

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_4 then
				local var_388_5 = (arg_385_1.time_ - var_388_1) / var_388_4
				local var_388_6 = Vector3.New(0, -2000, 0)

				var_388_0.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos10157, var_388_6, var_388_5)
			end

			if arg_385_1.time_ >= var_388_1 + var_388_4 and arg_385_1.time_ < var_388_1 + var_388_4 + arg_388_0 then
				var_388_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_388_7 = 0
			local var_388_8 = 1.675

			if var_388_7 < arg_385_1.time_ and arg_385_1.time_ <= var_388_7 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_9 = arg_385_1:GetWordFromCfg(425032094)
				local var_388_10 = arg_385_1:FormatText(var_388_9.content)

				arg_385_1.text_.text = var_388_10

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_11 = 67
				local var_388_12 = utf8.len(var_388_10)
				local var_388_13 = var_388_11 <= 0 and var_388_8 or var_388_8 * (var_388_12 / var_388_11)

				if var_388_13 > 0 and var_388_8 < var_388_13 then
					arg_385_1.talkMaxDuration = var_388_13

					if var_388_13 + var_388_7 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_13 + var_388_7
					end
				end

				arg_385_1.text_.text = var_388_10
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_14 = math.max(var_388_8, arg_385_1.talkMaxDuration)

			if var_388_7 <= arg_385_1.time_ and arg_385_1.time_ < var_388_7 + var_388_14 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_7) / var_388_14

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_7 + var_388_14 and arg_385_1.time_ < var_388_7 + var_388_14 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play425032095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 425032095
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play425032096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0
			local var_392_1 = 0.575

			if var_392_0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_2 = arg_389_1:GetWordFromCfg(425032095)
				local var_392_3 = arg_389_1:FormatText(var_392_2.content)

				arg_389_1.text_.text = var_392_3

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_4 = 23
				local var_392_5 = utf8.len(var_392_3)
				local var_392_6 = var_392_4 <= 0 and var_392_1 or var_392_1 * (var_392_5 / var_392_4)

				if var_392_6 > 0 and var_392_1 < var_392_6 then
					arg_389_1.talkMaxDuration = var_392_6

					if var_392_6 + var_392_0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_6 + var_392_0
					end
				end

				arg_389_1.text_.text = var_392_3
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_7 = math.max(var_392_1, arg_389_1.talkMaxDuration)

			if var_392_0 <= arg_389_1.time_ and arg_389_1.time_ < var_392_0 + var_392_7 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_0) / var_392_7

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_0 + var_392_7 and arg_389_1.time_ < var_392_0 + var_392_7 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play425032096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 425032096
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play425032097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0
			local var_396_1 = 0.275

			if var_396_0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_2 = arg_393_1:FormatText(StoryNameCfg[7].name)

				arg_393_1.leftNameTxt_.text = var_396_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, true)
				arg_393_1.iconController_:SetSelectedState("hero")

				arg_393_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_393_1.callingController_:SetSelectedState("normal")

				arg_393_1.keyicon_.color = Color.New(1, 1, 1)
				arg_393_1.icon_.color = Color.New(1, 1, 1)

				local var_396_3 = arg_393_1:GetWordFromCfg(425032096)
				local var_396_4 = arg_393_1:FormatText(var_396_3.content)

				arg_393_1.text_.text = var_396_4

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_5 = 11
				local var_396_6 = utf8.len(var_396_4)
				local var_396_7 = var_396_5 <= 0 and var_396_1 or var_396_1 * (var_396_6 / var_396_5)

				if var_396_7 > 0 and var_396_1 < var_396_7 then
					arg_393_1.talkMaxDuration = var_396_7

					if var_396_7 + var_396_0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_7 + var_396_0
					end
				end

				arg_393_1.text_.text = var_396_4
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_8 = math.max(var_396_1, arg_393_1.talkMaxDuration)

			if var_396_0 <= arg_393_1.time_ and arg_393_1.time_ < var_396_0 + var_396_8 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_0) / var_396_8

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_0 + var_396_8 and arg_393_1.time_ < var_396_0 + var_396_8 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play425032097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 425032097
		arg_397_1.duration_ = 4.97

		local var_397_0 = {
			zh = 4.6,
			ja = 4.966
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play425032098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["10157"]
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.actorSpriteComps10157 == nil then
				arg_397_1.var_.actorSpriteComps10157 = var_400_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_2 = 0.2

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 and not isNil(var_400_0) then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2

				if arg_397_1.var_.actorSpriteComps10157 then
					for iter_400_0, iter_400_1 in pairs(arg_397_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_400_1 then
							if arg_397_1.isInRecall_ then
								local var_400_4 = Mathf.Lerp(iter_400_1.color.r, arg_397_1.hightColor1.r, var_400_3)
								local var_400_5 = Mathf.Lerp(iter_400_1.color.g, arg_397_1.hightColor1.g, var_400_3)
								local var_400_6 = Mathf.Lerp(iter_400_1.color.b, arg_397_1.hightColor1.b, var_400_3)

								iter_400_1.color = Color.New(var_400_4, var_400_5, var_400_6)
							else
								local var_400_7 = Mathf.Lerp(iter_400_1.color.r, 1, var_400_3)

								iter_400_1.color = Color.New(var_400_7, var_400_7, var_400_7)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.actorSpriteComps10157 then
				for iter_400_2, iter_400_3 in pairs(arg_397_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_400_3 then
						if arg_397_1.isInRecall_ then
							iter_400_3.color = arg_397_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_400_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_397_1.var_.actorSpriteComps10157 = nil
			end

			local var_400_8 = arg_397_1.actors_["10157"].transform
			local var_400_9 = 0

			if var_400_9 < arg_397_1.time_ and arg_397_1.time_ <= var_400_9 + arg_400_0 then
				arg_397_1.var_.moveOldPos10157 = var_400_8.localPosition
				var_400_8.localScale = Vector3.New(1, 1, 1)

				arg_397_1:CheckSpriteTmpPos("10157", 3)

				local var_400_10 = var_400_8.childCount

				for iter_400_4 = 0, var_400_10 - 1 do
					local var_400_11 = var_400_8:GetChild(iter_400_4)

					if var_400_11.name == "" or not string.find(var_400_11.name, "split") then
						var_400_11.gameObject:SetActive(true)
					else
						var_400_11.gameObject:SetActive(false)
					end
				end
			end

			local var_400_12 = 0.001

			if var_400_9 <= arg_397_1.time_ and arg_397_1.time_ < var_400_9 + var_400_12 then
				local var_400_13 = (arg_397_1.time_ - var_400_9) / var_400_12
				local var_400_14 = Vector3.New(0, -402.7, -156.1)

				var_400_8.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos10157, var_400_14, var_400_13)
			end

			if arg_397_1.time_ >= var_400_9 + var_400_12 and arg_397_1.time_ < var_400_9 + var_400_12 + arg_400_0 then
				var_400_8.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_400_15 = 0
			local var_400_16 = 0.45

			if var_400_15 < arg_397_1.time_ and arg_397_1.time_ <= var_400_15 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_17 = arg_397_1:FormatText(StoryNameCfg[1434].name)

				arg_397_1.leftNameTxt_.text = var_400_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_18 = arg_397_1:GetWordFromCfg(425032097)
				local var_400_19 = arg_397_1:FormatText(var_400_18.content)

				arg_397_1.text_.text = var_400_19

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_20 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032097", "story_v_out_425032.awb") ~= 0 then
					local var_400_23 = manager.audio:GetVoiceLength("story_v_out_425032", "425032097", "story_v_out_425032.awb") / 1000

					if var_400_23 + var_400_15 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_23 + var_400_15
					end

					if var_400_18.prefab_name ~= "" and arg_397_1.actors_[var_400_18.prefab_name] ~= nil then
						local var_400_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_18.prefab_name].transform, "story_v_out_425032", "425032097", "story_v_out_425032.awb")

						arg_397_1:RecordAudio("425032097", var_400_24)
						arg_397_1:RecordAudio("425032097", var_400_24)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_425032", "425032097", "story_v_out_425032.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_425032", "425032097", "story_v_out_425032.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_25 = math.max(var_400_16, arg_397_1.talkMaxDuration)

			if var_400_15 <= arg_397_1.time_ and arg_397_1.time_ < var_400_15 + var_400_25 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_15) / var_400_25

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_15 + var_400_25 and arg_397_1.time_ < var_400_15 + var_400_25 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_397_1:InitPlayNodeList()
	end,
	Play425032098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 425032098
		arg_401_1.duration_ = 5.2

		local var_401_0 = {
			zh = 4.233,
			ja = 5.2
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play425032099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["10157"].transform
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.var_.moveOldPos10157 = var_404_0.localPosition
				var_404_0.localScale = Vector3.New(1, 1, 1)

				arg_401_1:CheckSpriteTmpPos("10157", 3)

				local var_404_2 = var_404_0.childCount

				for iter_404_0 = 0, var_404_2 - 1 do
					local var_404_3 = var_404_0:GetChild(iter_404_0)

					if var_404_3.name == "" or not string.find(var_404_3.name, "split") then
						var_404_3.gameObject:SetActive(true)
					else
						var_404_3.gameObject:SetActive(false)
					end
				end
			end

			local var_404_4 = 0.001

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_4 then
				local var_404_5 = (arg_401_1.time_ - var_404_1) / var_404_4
				local var_404_6 = Vector3.New(0, -402.7, -156.1)

				var_404_0.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos10157, var_404_6, var_404_5)
			end

			if arg_401_1.time_ >= var_404_1 + var_404_4 and arg_401_1.time_ < var_404_1 + var_404_4 + arg_404_0 then
				var_404_0.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_404_7 = 0
			local var_404_8 = 0.425

			if var_404_7 < arg_401_1.time_ and arg_401_1.time_ <= var_404_7 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_9 = arg_401_1:FormatText(StoryNameCfg[1434].name)

				arg_401_1.leftNameTxt_.text = var_404_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_10 = arg_401_1:GetWordFromCfg(425032098)
				local var_404_11 = arg_401_1:FormatText(var_404_10.content)

				arg_401_1.text_.text = var_404_11

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_12 = 17
				local var_404_13 = utf8.len(var_404_11)
				local var_404_14 = var_404_12 <= 0 and var_404_8 or var_404_8 * (var_404_13 / var_404_12)

				if var_404_14 > 0 and var_404_8 < var_404_14 then
					arg_401_1.talkMaxDuration = var_404_14

					if var_404_14 + var_404_7 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_14 + var_404_7
					end
				end

				arg_401_1.text_.text = var_404_11
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032098", "story_v_out_425032.awb") ~= 0 then
					local var_404_15 = manager.audio:GetVoiceLength("story_v_out_425032", "425032098", "story_v_out_425032.awb") / 1000

					if var_404_15 + var_404_7 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_15 + var_404_7
					end

					if var_404_10.prefab_name ~= "" and arg_401_1.actors_[var_404_10.prefab_name] ~= nil then
						local var_404_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_10.prefab_name].transform, "story_v_out_425032", "425032098", "story_v_out_425032.awb")

						arg_401_1:RecordAudio("425032098", var_404_16)
						arg_401_1:RecordAudio("425032098", var_404_16)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_425032", "425032098", "story_v_out_425032.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_425032", "425032098", "story_v_out_425032.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_17 = math.max(var_404_8, arg_401_1.talkMaxDuration)

			if var_404_7 <= arg_401_1.time_ and arg_401_1.time_ < var_404_7 + var_404_17 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_7) / var_404_17

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_7 + var_404_17 and arg_401_1.time_ < var_404_7 + var_404_17 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play425032099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 425032099
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play425032100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["10157"]
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.actorSpriteComps10157 == nil then
				arg_405_1.var_.actorSpriteComps10157 = var_408_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_408_2 = 0.2

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_2 and not isNil(var_408_0) then
				local var_408_3 = (arg_405_1.time_ - var_408_1) / var_408_2

				if arg_405_1.var_.actorSpriteComps10157 then
					for iter_408_0, iter_408_1 in pairs(arg_405_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_408_1 then
							if arg_405_1.isInRecall_ then
								local var_408_4 = Mathf.Lerp(iter_408_1.color.r, arg_405_1.hightColor2.r, var_408_3)
								local var_408_5 = Mathf.Lerp(iter_408_1.color.g, arg_405_1.hightColor2.g, var_408_3)
								local var_408_6 = Mathf.Lerp(iter_408_1.color.b, arg_405_1.hightColor2.b, var_408_3)

								iter_408_1.color = Color.New(var_408_4, var_408_5, var_408_6)
							else
								local var_408_7 = Mathf.Lerp(iter_408_1.color.r, 0.5, var_408_3)

								iter_408_1.color = Color.New(var_408_7, var_408_7, var_408_7)
							end
						end
					end
				end
			end

			if arg_405_1.time_ >= var_408_1 + var_408_2 and arg_405_1.time_ < var_408_1 + var_408_2 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.actorSpriteComps10157 then
				for iter_408_2, iter_408_3 in pairs(arg_405_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_408_3 then
						if arg_405_1.isInRecall_ then
							iter_408_3.color = arg_405_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_408_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_405_1.var_.actorSpriteComps10157 = nil
			end

			local var_408_8 = arg_405_1.actors_["10157"].transform
			local var_408_9 = 0

			if var_408_9 < arg_405_1.time_ and arg_405_1.time_ <= var_408_9 + arg_408_0 then
				arg_405_1.var_.moveOldPos10157 = var_408_8.localPosition
				var_408_8.localScale = Vector3.New(1, 1, 1)

				arg_405_1:CheckSpriteTmpPos("10157", 7)

				local var_408_10 = var_408_8.childCount

				for iter_408_4 = 0, var_408_10 - 1 do
					local var_408_11 = var_408_8:GetChild(iter_408_4)

					if var_408_11.name == "" or not string.find(var_408_11.name, "split") then
						var_408_11.gameObject:SetActive(true)
					else
						var_408_11.gameObject:SetActive(false)
					end
				end
			end

			local var_408_12 = 0.001

			if var_408_9 <= arg_405_1.time_ and arg_405_1.time_ < var_408_9 + var_408_12 then
				local var_408_13 = (arg_405_1.time_ - var_408_9) / var_408_12
				local var_408_14 = Vector3.New(0, -2000, 0)

				var_408_8.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos10157, var_408_14, var_408_13)
			end

			if arg_405_1.time_ >= var_408_9 + var_408_12 and arg_405_1.time_ < var_408_9 + var_408_12 + arg_408_0 then
				var_408_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_408_15 = 0
			local var_408_16 = 1.475

			if var_408_15 < arg_405_1.time_ and arg_405_1.time_ <= var_408_15 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_17 = arg_405_1:GetWordFromCfg(425032099)
				local var_408_18 = arg_405_1:FormatText(var_408_17.content)

				arg_405_1.text_.text = var_408_18

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_19 = 59
				local var_408_20 = utf8.len(var_408_18)
				local var_408_21 = var_408_19 <= 0 and var_408_16 or var_408_16 * (var_408_20 / var_408_19)

				if var_408_21 > 0 and var_408_16 < var_408_21 then
					arg_405_1.talkMaxDuration = var_408_21

					if var_408_21 + var_408_15 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_21 + var_408_15
					end
				end

				arg_405_1.text_.text = var_408_18
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_22 = math.max(var_408_16, arg_405_1.talkMaxDuration)

			if var_408_15 <= arg_405_1.time_ and arg_405_1.time_ < var_408_15 + var_408_22 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_15) / var_408_22

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_15 + var_408_22 and arg_405_1.time_ < var_408_15 + var_408_22 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play425032100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 425032100
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play425032101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0
			local var_412_1 = 0.45

			if var_412_0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_2 = arg_409_1:FormatText(StoryNameCfg[7].name)

				arg_409_1.leftNameTxt_.text = var_412_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_3 = arg_409_1:GetWordFromCfg(425032100)
				local var_412_4 = arg_409_1:FormatText(var_412_3.content)

				arg_409_1.text_.text = var_412_4

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_5 = 18
				local var_412_6 = utf8.len(var_412_4)
				local var_412_7 = var_412_5 <= 0 and var_412_1 or var_412_1 * (var_412_6 / var_412_5)

				if var_412_7 > 0 and var_412_1 < var_412_7 then
					arg_409_1.talkMaxDuration = var_412_7

					if var_412_7 + var_412_0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_7 + var_412_0
					end
				end

				arg_409_1.text_.text = var_412_4
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_8 = math.max(var_412_1, arg_409_1.talkMaxDuration)

			if var_412_0 <= arg_409_1.time_ and arg_409_1.time_ < var_412_0 + var_412_8 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_0) / var_412_8

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_0 + var_412_8 and arg_409_1.time_ < var_412_0 + var_412_8 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play425032101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 425032101
		arg_413_1.duration_ = 12.77

		local var_413_0 = {
			zh = 9.3,
			ja = 12.766
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play425032102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["10157"]
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.actorSpriteComps10157 == nil then
				arg_413_1.var_.actorSpriteComps10157 = var_416_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_416_2 = 0.2

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 and not isNil(var_416_0) then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2

				if arg_413_1.var_.actorSpriteComps10157 then
					for iter_416_0, iter_416_1 in pairs(arg_413_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_416_1 then
							if arg_413_1.isInRecall_ then
								local var_416_4 = Mathf.Lerp(iter_416_1.color.r, arg_413_1.hightColor1.r, var_416_3)
								local var_416_5 = Mathf.Lerp(iter_416_1.color.g, arg_413_1.hightColor1.g, var_416_3)
								local var_416_6 = Mathf.Lerp(iter_416_1.color.b, arg_413_1.hightColor1.b, var_416_3)

								iter_416_1.color = Color.New(var_416_4, var_416_5, var_416_6)
							else
								local var_416_7 = Mathf.Lerp(iter_416_1.color.r, 1, var_416_3)

								iter_416_1.color = Color.New(var_416_7, var_416_7, var_416_7)
							end
						end
					end
				end
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.actorSpriteComps10157 then
				for iter_416_2, iter_416_3 in pairs(arg_413_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_416_3 then
						if arg_413_1.isInRecall_ then
							iter_416_3.color = arg_413_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_416_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_413_1.var_.actorSpriteComps10157 = nil
			end

			local var_416_8 = arg_413_1.actors_["10157"].transform
			local var_416_9 = 0

			if var_416_9 < arg_413_1.time_ and arg_413_1.time_ <= var_416_9 + arg_416_0 then
				arg_413_1.var_.moveOldPos10157 = var_416_8.localPosition
				var_416_8.localScale = Vector3.New(1, 1, 1)

				arg_413_1:CheckSpriteTmpPos("10157", 3)

				local var_416_10 = var_416_8.childCount

				for iter_416_4 = 0, var_416_10 - 1 do
					local var_416_11 = var_416_8:GetChild(iter_416_4)

					if var_416_11.name == "split_4" or not string.find(var_416_11.name, "split") then
						var_416_11.gameObject:SetActive(true)
					else
						var_416_11.gameObject:SetActive(false)
					end
				end
			end

			local var_416_12 = 0.001

			if var_416_9 <= arg_413_1.time_ and arg_413_1.time_ < var_416_9 + var_416_12 then
				local var_416_13 = (arg_413_1.time_ - var_416_9) / var_416_12
				local var_416_14 = Vector3.New(0, -402.7, -156.1)

				var_416_8.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos10157, var_416_14, var_416_13)
			end

			if arg_413_1.time_ >= var_416_9 + var_416_12 and arg_413_1.time_ < var_416_9 + var_416_12 + arg_416_0 then
				var_416_8.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_416_15 = 0
			local var_416_16 = 0.9

			if var_416_15 < arg_413_1.time_ and arg_413_1.time_ <= var_416_15 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_17 = arg_413_1:FormatText(StoryNameCfg[1434].name)

				arg_413_1.leftNameTxt_.text = var_416_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_18 = arg_413_1:GetWordFromCfg(425032101)
				local var_416_19 = arg_413_1:FormatText(var_416_18.content)

				arg_413_1.text_.text = var_416_19

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_20 = 37
				local var_416_21 = utf8.len(var_416_19)
				local var_416_22 = var_416_20 <= 0 and var_416_16 or var_416_16 * (var_416_21 / var_416_20)

				if var_416_22 > 0 and var_416_16 < var_416_22 then
					arg_413_1.talkMaxDuration = var_416_22

					if var_416_22 + var_416_15 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_22 + var_416_15
					end
				end

				arg_413_1.text_.text = var_416_19
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032101", "story_v_out_425032.awb") ~= 0 then
					local var_416_23 = manager.audio:GetVoiceLength("story_v_out_425032", "425032101", "story_v_out_425032.awb") / 1000

					if var_416_23 + var_416_15 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_23 + var_416_15
					end

					if var_416_18.prefab_name ~= "" and arg_413_1.actors_[var_416_18.prefab_name] ~= nil then
						local var_416_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_18.prefab_name].transform, "story_v_out_425032", "425032101", "story_v_out_425032.awb")

						arg_413_1:RecordAudio("425032101", var_416_24)
						arg_413_1:RecordAudio("425032101", var_416_24)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_425032", "425032101", "story_v_out_425032.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_425032", "425032101", "story_v_out_425032.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_25 = math.max(var_416_16, arg_413_1.talkMaxDuration)

			if var_416_15 <= arg_413_1.time_ and arg_413_1.time_ < var_416_15 + var_416_25 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_15) / var_416_25

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_15 + var_416_25 and arg_413_1.time_ < var_416_15 + var_416_25 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play425032102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 425032102
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play425032103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["10157"]
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.actorSpriteComps10157 == nil then
				arg_417_1.var_.actorSpriteComps10157 = var_420_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_420_2 = 0.2

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_2 and not isNil(var_420_0) then
				local var_420_3 = (arg_417_1.time_ - var_420_1) / var_420_2

				if arg_417_1.var_.actorSpriteComps10157 then
					for iter_420_0, iter_420_1 in pairs(arg_417_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_420_1 then
							if arg_417_1.isInRecall_ then
								local var_420_4 = Mathf.Lerp(iter_420_1.color.r, arg_417_1.hightColor2.r, var_420_3)
								local var_420_5 = Mathf.Lerp(iter_420_1.color.g, arg_417_1.hightColor2.g, var_420_3)
								local var_420_6 = Mathf.Lerp(iter_420_1.color.b, arg_417_1.hightColor2.b, var_420_3)

								iter_420_1.color = Color.New(var_420_4, var_420_5, var_420_6)
							else
								local var_420_7 = Mathf.Lerp(iter_420_1.color.r, 0.5, var_420_3)

								iter_420_1.color = Color.New(var_420_7, var_420_7, var_420_7)
							end
						end
					end
				end
			end

			if arg_417_1.time_ >= var_420_1 + var_420_2 and arg_417_1.time_ < var_420_1 + var_420_2 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.actorSpriteComps10157 then
				for iter_420_2, iter_420_3 in pairs(arg_417_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_420_3 then
						if arg_417_1.isInRecall_ then
							iter_420_3.color = arg_417_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_420_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_417_1.var_.actorSpriteComps10157 = nil
			end

			local var_420_8 = 0
			local var_420_9 = 0.775

			if var_420_8 < arg_417_1.time_ and arg_417_1.time_ <= var_420_8 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_10 = arg_417_1:FormatText(StoryNameCfg[7].name)

				arg_417_1.leftNameTxt_.text = var_420_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_11 = arg_417_1:GetWordFromCfg(425032102)
				local var_420_12 = arg_417_1:FormatText(var_420_11.content)

				arg_417_1.text_.text = var_420_12

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_13 = 31
				local var_420_14 = utf8.len(var_420_12)
				local var_420_15 = var_420_13 <= 0 and var_420_9 or var_420_9 * (var_420_14 / var_420_13)

				if var_420_15 > 0 and var_420_9 < var_420_15 then
					arg_417_1.talkMaxDuration = var_420_15

					if var_420_15 + var_420_8 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_15 + var_420_8
					end
				end

				arg_417_1.text_.text = var_420_12
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_16 = math.max(var_420_9, arg_417_1.talkMaxDuration)

			if var_420_8 <= arg_417_1.time_ and arg_417_1.time_ < var_420_8 + var_420_16 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_8) / var_420_16

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_8 + var_420_16 and arg_417_1.time_ < var_420_8 + var_420_16 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play425032103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 425032103
		arg_421_1.duration_ = 4.07

		local var_421_0 = {
			zh = 2.433,
			ja = 4.066
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
				arg_421_0:Play425032104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["10157"]
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 and not isNil(var_424_0) and arg_421_1.var_.actorSpriteComps10157 == nil then
				arg_421_1.var_.actorSpriteComps10157 = var_424_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_424_2 = 0.2

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_2 and not isNil(var_424_0) then
				local var_424_3 = (arg_421_1.time_ - var_424_1) / var_424_2

				if arg_421_1.var_.actorSpriteComps10157 then
					for iter_424_0, iter_424_1 in pairs(arg_421_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_424_1 then
							if arg_421_1.isInRecall_ then
								local var_424_4 = Mathf.Lerp(iter_424_1.color.r, arg_421_1.hightColor1.r, var_424_3)
								local var_424_5 = Mathf.Lerp(iter_424_1.color.g, arg_421_1.hightColor1.g, var_424_3)
								local var_424_6 = Mathf.Lerp(iter_424_1.color.b, arg_421_1.hightColor1.b, var_424_3)

								iter_424_1.color = Color.New(var_424_4, var_424_5, var_424_6)
							else
								local var_424_7 = Mathf.Lerp(iter_424_1.color.r, 1, var_424_3)

								iter_424_1.color = Color.New(var_424_7, var_424_7, var_424_7)
							end
						end
					end
				end
			end

			if arg_421_1.time_ >= var_424_1 + var_424_2 and arg_421_1.time_ < var_424_1 + var_424_2 + arg_424_0 and not isNil(var_424_0) and arg_421_1.var_.actorSpriteComps10157 then
				for iter_424_2, iter_424_3 in pairs(arg_421_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_424_3 then
						if arg_421_1.isInRecall_ then
							iter_424_3.color = arg_421_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_424_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_421_1.var_.actorSpriteComps10157 = nil
			end

			local var_424_8 = arg_421_1.actors_["10157"].transform
			local var_424_9 = 0

			if var_424_9 < arg_421_1.time_ and arg_421_1.time_ <= var_424_9 + arg_424_0 then
				arg_421_1.var_.moveOldPos10157 = var_424_8.localPosition
				var_424_8.localScale = Vector3.New(1, 1, 1)

				arg_421_1:CheckSpriteTmpPos("10157", 3)

				local var_424_10 = var_424_8.childCount

				for iter_424_4 = 0, var_424_10 - 1 do
					local var_424_11 = var_424_8:GetChild(iter_424_4)

					if var_424_11.name == "" then
						var_424_11:SetAsLastSibling()
						var_424_11.gameObject:SetActive(true)

						arg_421_1.var_.actorSpriteSplit10157 = var_424_11.gameObject:GetComponent(typeof(Image))

						arg_421_1.var_.actorSpriteSplit10157:SetAlpha(0)
					end
				end
			end

			local var_424_12 = 0.5

			if var_424_9 <= arg_421_1.time_ and arg_421_1.time_ < var_424_9 + var_424_12 then
				local var_424_13 = (arg_421_1.time_ - var_424_9) / var_424_12
				local var_424_14 = Vector3.New(0, -402.7, -156.1)

				var_424_8.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos10157, var_424_14, var_424_13)

				if arg_421_1.var_.actorSpriteSplit10157 ~= nil then
					arg_421_1.var_.actorSpriteSplit10157:SetAlpha(var_424_13)
				end
			end

			if arg_421_1.time_ >= var_424_9 + var_424_12 and arg_421_1.time_ < var_424_9 + var_424_12 + arg_424_0 then
				var_424_8.localPosition = Vector3.New(0, -402.7, -156.1)

				if arg_421_1.var_.actorSpriteSplit10157 ~= nil then
					arg_421_1.var_.actorSpriteSplit10157:SetAlpha(1)
				end
			end

			local var_424_15 = 0
			local var_424_16 = 0.275

			if var_424_15 < arg_421_1.time_ and arg_421_1.time_ <= var_424_15 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_17 = arg_421_1:FormatText(StoryNameCfg[1434].name)

				arg_421_1.leftNameTxt_.text = var_424_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_18 = arg_421_1:GetWordFromCfg(425032103)
				local var_424_19 = arg_421_1:FormatText(var_424_18.content)

				arg_421_1.text_.text = var_424_19

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_20 = 11
				local var_424_21 = utf8.len(var_424_19)
				local var_424_22 = var_424_20 <= 0 and var_424_16 or var_424_16 * (var_424_21 / var_424_20)

				if var_424_22 > 0 and var_424_16 < var_424_22 then
					arg_421_1.talkMaxDuration = var_424_22

					if var_424_22 + var_424_15 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_22 + var_424_15
					end
				end

				arg_421_1.text_.text = var_424_19
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032103", "story_v_out_425032.awb") ~= 0 then
					local var_424_23 = manager.audio:GetVoiceLength("story_v_out_425032", "425032103", "story_v_out_425032.awb") / 1000

					if var_424_23 + var_424_15 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_23 + var_424_15
					end

					if var_424_18.prefab_name ~= "" and arg_421_1.actors_[var_424_18.prefab_name] ~= nil then
						local var_424_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_18.prefab_name].transform, "story_v_out_425032", "425032103", "story_v_out_425032.awb")

						arg_421_1:RecordAudio("425032103", var_424_24)
						arg_421_1:RecordAudio("425032103", var_424_24)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_425032", "425032103", "story_v_out_425032.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_425032", "425032103", "story_v_out_425032.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_25 = math.max(var_424_16, arg_421_1.talkMaxDuration)

			if var_424_15 <= arg_421_1.time_ and arg_421_1.time_ < var_424_15 + var_424_25 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_15) / var_424_25

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_15 + var_424_25 and arg_421_1.time_ < var_424_15 + var_424_25 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play425032104 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 425032104
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play425032105(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["10157"]
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.actorSpriteComps10157 == nil then
				arg_425_1.var_.actorSpriteComps10157 = var_428_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_428_2 = 0.2

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_2 and not isNil(var_428_0) then
				local var_428_3 = (arg_425_1.time_ - var_428_1) / var_428_2

				if arg_425_1.var_.actorSpriteComps10157 then
					for iter_428_0, iter_428_1 in pairs(arg_425_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_428_1 then
							if arg_425_1.isInRecall_ then
								local var_428_4 = Mathf.Lerp(iter_428_1.color.r, arg_425_1.hightColor2.r, var_428_3)
								local var_428_5 = Mathf.Lerp(iter_428_1.color.g, arg_425_1.hightColor2.g, var_428_3)
								local var_428_6 = Mathf.Lerp(iter_428_1.color.b, arg_425_1.hightColor2.b, var_428_3)

								iter_428_1.color = Color.New(var_428_4, var_428_5, var_428_6)
							else
								local var_428_7 = Mathf.Lerp(iter_428_1.color.r, 0.5, var_428_3)

								iter_428_1.color = Color.New(var_428_7, var_428_7, var_428_7)
							end
						end
					end
				end
			end

			if arg_425_1.time_ >= var_428_1 + var_428_2 and arg_425_1.time_ < var_428_1 + var_428_2 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.actorSpriteComps10157 then
				for iter_428_2, iter_428_3 in pairs(arg_425_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_428_3 then
						if arg_425_1.isInRecall_ then
							iter_428_3.color = arg_425_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_428_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_425_1.var_.actorSpriteComps10157 = nil
			end

			local var_428_8 = 0
			local var_428_9 = 0.05

			if var_428_8 < arg_425_1.time_ and arg_425_1.time_ <= var_428_8 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_10 = arg_425_1:FormatText(StoryNameCfg[7].name)

				arg_425_1.leftNameTxt_.text = var_428_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_11 = arg_425_1:GetWordFromCfg(425032104)
				local var_428_12 = arg_425_1:FormatText(var_428_11.content)

				arg_425_1.text_.text = var_428_12

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_13 = 2
				local var_428_14 = utf8.len(var_428_12)
				local var_428_15 = var_428_13 <= 0 and var_428_9 or var_428_9 * (var_428_14 / var_428_13)

				if var_428_15 > 0 and var_428_9 < var_428_15 then
					arg_425_1.talkMaxDuration = var_428_15

					if var_428_15 + var_428_8 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_15 + var_428_8
					end
				end

				arg_425_1.text_.text = var_428_12
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_16 = math.max(var_428_9, arg_425_1.talkMaxDuration)

			if var_428_8 <= arg_425_1.time_ and arg_425_1.time_ < var_428_8 + var_428_16 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_8) / var_428_16

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_8 + var_428_16 and arg_425_1.time_ < var_428_8 + var_428_16 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play425032105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 425032105
		arg_429_1.duration_ = 10.2

		local var_429_0 = {
			zh = 8.233,
			ja = 10.2
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
				arg_429_0:Play425032106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = arg_429_1.actors_["10157"]
			local var_432_1 = 0

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.actorSpriteComps10157 == nil then
				arg_429_1.var_.actorSpriteComps10157 = var_432_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_432_2 = 0.2

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_2 and not isNil(var_432_0) then
				local var_432_3 = (arg_429_1.time_ - var_432_1) / var_432_2

				if arg_429_1.var_.actorSpriteComps10157 then
					for iter_432_0, iter_432_1 in pairs(arg_429_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_432_1 then
							if arg_429_1.isInRecall_ then
								local var_432_4 = Mathf.Lerp(iter_432_1.color.r, arg_429_1.hightColor1.r, var_432_3)
								local var_432_5 = Mathf.Lerp(iter_432_1.color.g, arg_429_1.hightColor1.g, var_432_3)
								local var_432_6 = Mathf.Lerp(iter_432_1.color.b, arg_429_1.hightColor1.b, var_432_3)

								iter_432_1.color = Color.New(var_432_4, var_432_5, var_432_6)
							else
								local var_432_7 = Mathf.Lerp(iter_432_1.color.r, 1, var_432_3)

								iter_432_1.color = Color.New(var_432_7, var_432_7, var_432_7)
							end
						end
					end
				end
			end

			if arg_429_1.time_ >= var_432_1 + var_432_2 and arg_429_1.time_ < var_432_1 + var_432_2 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.actorSpriteComps10157 then
				for iter_432_2, iter_432_3 in pairs(arg_429_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_432_3 then
						if arg_429_1.isInRecall_ then
							iter_432_3.color = arg_429_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_432_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_429_1.var_.actorSpriteComps10157 = nil
			end

			local var_432_8 = 0
			local var_432_9 = 0.725

			if var_432_8 < arg_429_1.time_ and arg_429_1.time_ <= var_432_8 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				local var_432_10 = arg_429_1:FormatText(StoryNameCfg[1434].name)

				arg_429_1.leftNameTxt_.text = var_432_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_11 = arg_429_1:GetWordFromCfg(425032105)
				local var_432_12 = arg_429_1:FormatText(var_432_11.content)

				arg_429_1.text_.text = var_432_12

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_13 = 29
				local var_432_14 = utf8.len(var_432_12)
				local var_432_15 = var_432_13 <= 0 and var_432_9 or var_432_9 * (var_432_14 / var_432_13)

				if var_432_15 > 0 and var_432_9 < var_432_15 then
					arg_429_1.talkMaxDuration = var_432_15

					if var_432_15 + var_432_8 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_15 + var_432_8
					end
				end

				arg_429_1.text_.text = var_432_12
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032105", "story_v_out_425032.awb") ~= 0 then
					local var_432_16 = manager.audio:GetVoiceLength("story_v_out_425032", "425032105", "story_v_out_425032.awb") / 1000

					if var_432_16 + var_432_8 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_16 + var_432_8
					end

					if var_432_11.prefab_name ~= "" and arg_429_1.actors_[var_432_11.prefab_name] ~= nil then
						local var_432_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_11.prefab_name].transform, "story_v_out_425032", "425032105", "story_v_out_425032.awb")

						arg_429_1:RecordAudio("425032105", var_432_17)
						arg_429_1:RecordAudio("425032105", var_432_17)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_425032", "425032105", "story_v_out_425032.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_425032", "425032105", "story_v_out_425032.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_18 = math.max(var_432_9, arg_429_1.talkMaxDuration)

			if var_432_8 <= arg_429_1.time_ and arg_429_1.time_ < var_432_8 + var_432_18 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_8) / var_432_18

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_8 + var_432_18 and arg_429_1.time_ < var_432_8 + var_432_18 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play425032106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 425032106
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play425032107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = arg_433_1.actors_["10157"]
			local var_436_1 = 0

			if var_436_1 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 and not isNil(var_436_0) and arg_433_1.var_.actorSpriteComps10157 == nil then
				arg_433_1.var_.actorSpriteComps10157 = var_436_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_436_2 = 0.2

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_2 and not isNil(var_436_0) then
				local var_436_3 = (arg_433_1.time_ - var_436_1) / var_436_2

				if arg_433_1.var_.actorSpriteComps10157 then
					for iter_436_0, iter_436_1 in pairs(arg_433_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_436_1 then
							if arg_433_1.isInRecall_ then
								local var_436_4 = Mathf.Lerp(iter_436_1.color.r, arg_433_1.hightColor2.r, var_436_3)
								local var_436_5 = Mathf.Lerp(iter_436_1.color.g, arg_433_1.hightColor2.g, var_436_3)
								local var_436_6 = Mathf.Lerp(iter_436_1.color.b, arg_433_1.hightColor2.b, var_436_3)

								iter_436_1.color = Color.New(var_436_4, var_436_5, var_436_6)
							else
								local var_436_7 = Mathf.Lerp(iter_436_1.color.r, 0.5, var_436_3)

								iter_436_1.color = Color.New(var_436_7, var_436_7, var_436_7)
							end
						end
					end
				end
			end

			if arg_433_1.time_ >= var_436_1 + var_436_2 and arg_433_1.time_ < var_436_1 + var_436_2 + arg_436_0 and not isNil(var_436_0) and arg_433_1.var_.actorSpriteComps10157 then
				for iter_436_2, iter_436_3 in pairs(arg_433_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_436_3 then
						if arg_433_1.isInRecall_ then
							iter_436_3.color = arg_433_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_436_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_433_1.var_.actorSpriteComps10157 = nil
			end

			local var_436_8 = 0
			local var_436_9 = 0.825

			if var_436_8 < arg_433_1.time_ and arg_433_1.time_ <= var_436_8 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, false)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_10 = arg_433_1:GetWordFromCfg(425032106)
				local var_436_11 = arg_433_1:FormatText(var_436_10.content)

				arg_433_1.text_.text = var_436_11

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_12 = 33
				local var_436_13 = utf8.len(var_436_11)
				local var_436_14 = var_436_12 <= 0 and var_436_9 or var_436_9 * (var_436_13 / var_436_12)

				if var_436_14 > 0 and var_436_9 < var_436_14 then
					arg_433_1.talkMaxDuration = var_436_14

					if var_436_14 + var_436_8 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_14 + var_436_8
					end
				end

				arg_433_1.text_.text = var_436_11
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_15 = math.max(var_436_9, arg_433_1.talkMaxDuration)

			if var_436_8 <= arg_433_1.time_ and arg_433_1.time_ < var_436_8 + var_436_15 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_8) / var_436_15

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_8 + var_436_15 and arg_433_1.time_ < var_436_8 + var_436_15 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play425032107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 425032107
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play425032108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0
			local var_440_1 = 0.1

			if var_440_0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_2 = arg_437_1:FormatText(StoryNameCfg[7].name)

				arg_437_1.leftNameTxt_.text = var_440_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_3 = arg_437_1:GetWordFromCfg(425032107)
				local var_440_4 = arg_437_1:FormatText(var_440_3.content)

				arg_437_1.text_.text = var_440_4

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_5 = 4
				local var_440_6 = utf8.len(var_440_4)
				local var_440_7 = var_440_5 <= 0 and var_440_1 or var_440_1 * (var_440_6 / var_440_5)

				if var_440_7 > 0 and var_440_1 < var_440_7 then
					arg_437_1.talkMaxDuration = var_440_7

					if var_440_7 + var_440_0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_7 + var_440_0
					end
				end

				arg_437_1.text_.text = var_440_4
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_8 = math.max(var_440_1, arg_437_1.talkMaxDuration)

			if var_440_0 <= arg_437_1.time_ and arg_437_1.time_ < var_440_0 + var_440_8 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_0) / var_440_8

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_0 + var_440_8 and arg_437_1.time_ < var_440_0 + var_440_8 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play425032108 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 425032108
		arg_441_1.duration_ = 14.1

		local var_441_0 = {
			zh = 7.866,
			ja = 14.1
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
				arg_441_0:Play425032109(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = arg_441_1.actors_["10157"]
			local var_444_1 = 0

			if var_444_1 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 and not isNil(var_444_0) and arg_441_1.var_.actorSpriteComps10157 == nil then
				arg_441_1.var_.actorSpriteComps10157 = var_444_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_444_2 = 0.2

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_2 and not isNil(var_444_0) then
				local var_444_3 = (arg_441_1.time_ - var_444_1) / var_444_2

				if arg_441_1.var_.actorSpriteComps10157 then
					for iter_444_0, iter_444_1 in pairs(arg_441_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_444_1 then
							if arg_441_1.isInRecall_ then
								local var_444_4 = Mathf.Lerp(iter_444_1.color.r, arg_441_1.hightColor1.r, var_444_3)
								local var_444_5 = Mathf.Lerp(iter_444_1.color.g, arg_441_1.hightColor1.g, var_444_3)
								local var_444_6 = Mathf.Lerp(iter_444_1.color.b, arg_441_1.hightColor1.b, var_444_3)

								iter_444_1.color = Color.New(var_444_4, var_444_5, var_444_6)
							else
								local var_444_7 = Mathf.Lerp(iter_444_1.color.r, 1, var_444_3)

								iter_444_1.color = Color.New(var_444_7, var_444_7, var_444_7)
							end
						end
					end
				end
			end

			if arg_441_1.time_ >= var_444_1 + var_444_2 and arg_441_1.time_ < var_444_1 + var_444_2 + arg_444_0 and not isNil(var_444_0) and arg_441_1.var_.actorSpriteComps10157 then
				for iter_444_2, iter_444_3 in pairs(arg_441_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_444_3 then
						if arg_441_1.isInRecall_ then
							iter_444_3.color = arg_441_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_444_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_441_1.var_.actorSpriteComps10157 = nil
			end

			local var_444_8 = arg_441_1.actors_["10157"].transform
			local var_444_9 = 0

			if var_444_9 < arg_441_1.time_ and arg_441_1.time_ <= var_444_9 + arg_444_0 then
				arg_441_1.var_.moveOldPos10157 = var_444_8.localPosition
				var_444_8.localScale = Vector3.New(1, 1, 1)

				arg_441_1:CheckSpriteTmpPos("10157", 3)

				local var_444_10 = var_444_8.childCount

				for iter_444_4 = 0, var_444_10 - 1 do
					local var_444_11 = var_444_8:GetChild(iter_444_4)

					if var_444_11.name == "split_4" then
						var_444_11:SetAsLastSibling()
						var_444_11.gameObject:SetActive(true)

						arg_441_1.var_.actorSpriteSplit10157 = var_444_11.gameObject:GetComponent(typeof(Image))

						arg_441_1.var_.actorSpriteSplit10157:SetAlpha(0)
					end
				end
			end

			local var_444_12 = 0.5

			if var_444_9 <= arg_441_1.time_ and arg_441_1.time_ < var_444_9 + var_444_12 then
				local var_444_13 = (arg_441_1.time_ - var_444_9) / var_444_12
				local var_444_14 = Vector3.New(0, -402.7, -156.1)

				var_444_8.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos10157, var_444_14, var_444_13)

				if arg_441_1.var_.actorSpriteSplit10157 ~= nil then
					arg_441_1.var_.actorSpriteSplit10157:SetAlpha(var_444_13)
				end
			end

			if arg_441_1.time_ >= var_444_9 + var_444_12 and arg_441_1.time_ < var_444_9 + var_444_12 + arg_444_0 then
				var_444_8.localPosition = Vector3.New(0, -402.7, -156.1)

				if arg_441_1.var_.actorSpriteSplit10157 ~= nil then
					arg_441_1.var_.actorSpriteSplit10157:SetAlpha(1)
				end
			end

			local var_444_15 = 0
			local var_444_16 = 0.65

			if var_444_15 < arg_441_1.time_ and arg_441_1.time_ <= var_444_15 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_17 = arg_441_1:FormatText(StoryNameCfg[1434].name)

				arg_441_1.leftNameTxt_.text = var_444_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_18 = arg_441_1:GetWordFromCfg(425032108)
				local var_444_19 = arg_441_1:FormatText(var_444_18.content)

				arg_441_1.text_.text = var_444_19

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_20 = 26
				local var_444_21 = utf8.len(var_444_19)
				local var_444_22 = var_444_20 <= 0 and var_444_16 or var_444_16 * (var_444_21 / var_444_20)

				if var_444_22 > 0 and var_444_16 < var_444_22 then
					arg_441_1.talkMaxDuration = var_444_22

					if var_444_22 + var_444_15 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_22 + var_444_15
					end
				end

				arg_441_1.text_.text = var_444_19
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032108", "story_v_out_425032.awb") ~= 0 then
					local var_444_23 = manager.audio:GetVoiceLength("story_v_out_425032", "425032108", "story_v_out_425032.awb") / 1000

					if var_444_23 + var_444_15 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_23 + var_444_15
					end

					if var_444_18.prefab_name ~= "" and arg_441_1.actors_[var_444_18.prefab_name] ~= nil then
						local var_444_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_18.prefab_name].transform, "story_v_out_425032", "425032108", "story_v_out_425032.awb")

						arg_441_1:RecordAudio("425032108", var_444_24)
						arg_441_1:RecordAudio("425032108", var_444_24)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_425032", "425032108", "story_v_out_425032.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_425032", "425032108", "story_v_out_425032.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_25 = math.max(var_444_16, arg_441_1.talkMaxDuration)

			if var_444_15 <= arg_441_1.time_ and arg_441_1.time_ < var_444_15 + var_444_25 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_15) / var_444_25

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_15 + var_444_25 and arg_441_1.time_ < var_444_15 + var_444_25 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_441_1:InitPlayNodeList()
	end,
	Play425032109 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 425032109
		arg_445_1.duration_ = 5.9

		local var_445_0 = {
			zh = 4.633,
			ja = 5.9
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
				arg_445_0:Play425032110(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0
			local var_448_1 = 0.425

			if var_448_0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_2 = arg_445_1:FormatText(StoryNameCfg[1434].name)

				arg_445_1.leftNameTxt_.text = var_448_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_3 = arg_445_1:GetWordFromCfg(425032109)
				local var_448_4 = arg_445_1:FormatText(var_448_3.content)

				arg_445_1.text_.text = var_448_4

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_5 = 17
				local var_448_6 = utf8.len(var_448_4)
				local var_448_7 = var_448_5 <= 0 and var_448_1 or var_448_1 * (var_448_6 / var_448_5)

				if var_448_7 > 0 and var_448_1 < var_448_7 then
					arg_445_1.talkMaxDuration = var_448_7

					if var_448_7 + var_448_0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_7 + var_448_0
					end
				end

				arg_445_1.text_.text = var_448_4
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032109", "story_v_out_425032.awb") ~= 0 then
					local var_448_8 = manager.audio:GetVoiceLength("story_v_out_425032", "425032109", "story_v_out_425032.awb") / 1000

					if var_448_8 + var_448_0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_8 + var_448_0
					end

					if var_448_3.prefab_name ~= "" and arg_445_1.actors_[var_448_3.prefab_name] ~= nil then
						local var_448_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_3.prefab_name].transform, "story_v_out_425032", "425032109", "story_v_out_425032.awb")

						arg_445_1:RecordAudio("425032109", var_448_9)
						arg_445_1:RecordAudio("425032109", var_448_9)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_425032", "425032109", "story_v_out_425032.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_425032", "425032109", "story_v_out_425032.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_10 = math.max(var_448_1, arg_445_1.talkMaxDuration)

			if var_448_0 <= arg_445_1.time_ and arg_445_1.time_ < var_448_0 + var_448_10 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_0) / var_448_10

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_0 + var_448_10 and arg_445_1.time_ < var_448_0 + var_448_10 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play425032110 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 425032110
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play425032111(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = arg_449_1.actors_["10157"]
			local var_452_1 = 0

			if var_452_1 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 and not isNil(var_452_0) and arg_449_1.var_.actorSpriteComps10157 == nil then
				arg_449_1.var_.actorSpriteComps10157 = var_452_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_452_2 = 0.2

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_2 and not isNil(var_452_0) then
				local var_452_3 = (arg_449_1.time_ - var_452_1) / var_452_2

				if arg_449_1.var_.actorSpriteComps10157 then
					for iter_452_0, iter_452_1 in pairs(arg_449_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_452_1 then
							if arg_449_1.isInRecall_ then
								local var_452_4 = Mathf.Lerp(iter_452_1.color.r, arg_449_1.hightColor2.r, var_452_3)
								local var_452_5 = Mathf.Lerp(iter_452_1.color.g, arg_449_1.hightColor2.g, var_452_3)
								local var_452_6 = Mathf.Lerp(iter_452_1.color.b, arg_449_1.hightColor2.b, var_452_3)

								iter_452_1.color = Color.New(var_452_4, var_452_5, var_452_6)
							else
								local var_452_7 = Mathf.Lerp(iter_452_1.color.r, 0.5, var_452_3)

								iter_452_1.color = Color.New(var_452_7, var_452_7, var_452_7)
							end
						end
					end
				end
			end

			if arg_449_1.time_ >= var_452_1 + var_452_2 and arg_449_1.time_ < var_452_1 + var_452_2 + arg_452_0 and not isNil(var_452_0) and arg_449_1.var_.actorSpriteComps10157 then
				for iter_452_2, iter_452_3 in pairs(arg_449_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_452_3 then
						if arg_449_1.isInRecall_ then
							iter_452_3.color = arg_449_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_452_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_449_1.var_.actorSpriteComps10157 = nil
			end

			local var_452_8 = arg_449_1.actors_["10157"].transform
			local var_452_9 = 0

			if var_452_9 < arg_449_1.time_ and arg_449_1.time_ <= var_452_9 + arg_452_0 then
				arg_449_1.var_.moveOldPos10157 = var_452_8.localPosition
				var_452_8.localScale = Vector3.New(1, 1, 1)

				arg_449_1:CheckSpriteTmpPos("10157", 7)

				local var_452_10 = var_452_8.childCount

				for iter_452_4 = 0, var_452_10 - 1 do
					local var_452_11 = var_452_8:GetChild(iter_452_4)

					if var_452_11.name == "" or not string.find(var_452_11.name, "split") then
						var_452_11.gameObject:SetActive(true)
					else
						var_452_11.gameObject:SetActive(false)
					end
				end
			end

			local var_452_12 = 0.001

			if var_452_9 <= arg_449_1.time_ and arg_449_1.time_ < var_452_9 + var_452_12 then
				local var_452_13 = (arg_449_1.time_ - var_452_9) / var_452_12
				local var_452_14 = Vector3.New(0, -2000, 0)

				var_452_8.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos10157, var_452_14, var_452_13)
			end

			if arg_449_1.time_ >= var_452_9 + var_452_12 and arg_449_1.time_ < var_452_9 + var_452_12 + arg_452_0 then
				var_452_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_452_15 = 0.1
			local var_452_16 = 1

			if var_452_15 < arg_449_1.time_ and arg_449_1.time_ <= var_452_15 + arg_452_0 then
				local var_452_17 = "play"
				local var_452_18 = "effect"

				arg_449_1:AudioAction(var_452_17, var_452_18, "se_story_140", "se_story_140_synth", "")
			end

			local var_452_19 = manager.ui.mainCamera.transform
			local var_452_20 = 0

			if var_452_20 < arg_449_1.time_ and arg_449_1.time_ <= var_452_20 + arg_452_0 then
				local var_452_21 = arg_449_1.var_.effect2110
				local var_452_22
				local var_452_23 = var_452_19

				if not var_452_21 then
					var_452_21 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_452_23)
					var_452_21.name = "2110"
					arg_449_1.var_.effect2110 = var_452_21
				else
					var_452_21.transform:SetParent(var_452_23)
				end

				var_452_21.transform.localPosition = Vector3.New(0, 0, 0)
				var_452_21.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_452_24 = manager.ui.mainCamera.transform
			local var_452_25 = 2.3

			if var_452_25 < arg_449_1.time_ and arg_449_1.time_ <= var_452_25 + arg_452_0 then
				local var_452_26 = arg_449_1.var_.effect2110

				if var_452_26 then
					Object.Destroy(var_452_26)

					arg_449_1.var_.effect2110 = nil
				end
			end

			local var_452_27 = 0
			local var_452_28 = 0.875

			if var_452_27 < arg_449_1.time_ and arg_449_1.time_ <= var_452_27 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, false)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_29 = arg_449_1:GetWordFromCfg(425032110)
				local var_452_30 = arg_449_1:FormatText(var_452_29.content)

				arg_449_1.text_.text = var_452_30

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_31 = 35
				local var_452_32 = utf8.len(var_452_30)
				local var_452_33 = var_452_31 <= 0 and var_452_28 or var_452_28 * (var_452_32 / var_452_31)

				if var_452_33 > 0 and var_452_28 < var_452_33 then
					arg_449_1.talkMaxDuration = var_452_33

					if var_452_33 + var_452_27 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_33 + var_452_27
					end
				end

				arg_449_1.text_.text = var_452_30
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_34 = math.max(var_452_28, arg_449_1.talkMaxDuration)

			if var_452_27 <= arg_449_1.time_ and arg_449_1.time_ < var_452_27 + var_452_34 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_27) / var_452_34

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_27 + var_452_34 and arg_449_1.time_ < var_452_27 + var_452_34 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play425032111 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 425032111
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play425032112(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0
			local var_456_1 = 0.175

			if var_456_0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				local var_456_2 = arg_453_1:FormatText(StoryNameCfg[7].name)

				arg_453_1.leftNameTxt_.text = var_456_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, true)
				arg_453_1.iconController_:SetSelectedState("hero")

				arg_453_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_453_1.callingController_:SetSelectedState("normal")

				arg_453_1.keyicon_.color = Color.New(1, 1, 1)
				arg_453_1.icon_.color = Color.New(1, 1, 1)

				local var_456_3 = arg_453_1:GetWordFromCfg(425032111)
				local var_456_4 = arg_453_1:FormatText(var_456_3.content)

				arg_453_1.text_.text = var_456_4

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_5 = 7
				local var_456_6 = utf8.len(var_456_4)
				local var_456_7 = var_456_5 <= 0 and var_456_1 or var_456_1 * (var_456_6 / var_456_5)

				if var_456_7 > 0 and var_456_1 < var_456_7 then
					arg_453_1.talkMaxDuration = var_456_7

					if var_456_7 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_7 + var_456_0
					end
				end

				arg_453_1.text_.text = var_456_4
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_8 = math.max(var_456_1, arg_453_1.talkMaxDuration)

			if var_456_0 <= arg_453_1.time_ and arg_453_1.time_ < var_456_0 + var_456_8 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_0) / var_456_8

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_0 + var_456_8 and arg_453_1.time_ < var_456_0 + var_456_8 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play425032112 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 425032112
		arg_457_1.duration_ = 7.2

		local var_457_0 = {
			zh = 4.9,
			ja = 7.2
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play425032113(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = arg_457_1.actors_["10157"]
			local var_460_1 = 0

			if var_460_1 < arg_457_1.time_ and arg_457_1.time_ <= var_460_1 + arg_460_0 and not isNil(var_460_0) and arg_457_1.var_.actorSpriteComps10157 == nil then
				arg_457_1.var_.actorSpriteComps10157 = var_460_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_460_2 = 0.2

			if var_460_1 <= arg_457_1.time_ and arg_457_1.time_ < var_460_1 + var_460_2 and not isNil(var_460_0) then
				local var_460_3 = (arg_457_1.time_ - var_460_1) / var_460_2

				if arg_457_1.var_.actorSpriteComps10157 then
					for iter_460_0, iter_460_1 in pairs(arg_457_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_460_1 then
							if arg_457_1.isInRecall_ then
								local var_460_4 = Mathf.Lerp(iter_460_1.color.r, arg_457_1.hightColor1.r, var_460_3)
								local var_460_5 = Mathf.Lerp(iter_460_1.color.g, arg_457_1.hightColor1.g, var_460_3)
								local var_460_6 = Mathf.Lerp(iter_460_1.color.b, arg_457_1.hightColor1.b, var_460_3)

								iter_460_1.color = Color.New(var_460_4, var_460_5, var_460_6)
							else
								local var_460_7 = Mathf.Lerp(iter_460_1.color.r, 1, var_460_3)

								iter_460_1.color = Color.New(var_460_7, var_460_7, var_460_7)
							end
						end
					end
				end
			end

			if arg_457_1.time_ >= var_460_1 + var_460_2 and arg_457_1.time_ < var_460_1 + var_460_2 + arg_460_0 and not isNil(var_460_0) and arg_457_1.var_.actorSpriteComps10157 then
				for iter_460_2, iter_460_3 in pairs(arg_457_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_460_3 then
						if arg_457_1.isInRecall_ then
							iter_460_3.color = arg_457_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_460_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_457_1.var_.actorSpriteComps10157 = nil
			end

			local var_460_8 = arg_457_1.actors_["10157"].transform
			local var_460_9 = 0

			if var_460_9 < arg_457_1.time_ and arg_457_1.time_ <= var_460_9 + arg_460_0 then
				arg_457_1.var_.moveOldPos10157 = var_460_8.localPosition
				var_460_8.localScale = Vector3.New(1, 1, 1)

				arg_457_1:CheckSpriteTmpPos("10157", 3)

				local var_460_10 = var_460_8.childCount

				for iter_460_4 = 0, var_460_10 - 1 do
					local var_460_11 = var_460_8:GetChild(iter_460_4)

					if var_460_11.name == "split_3" or not string.find(var_460_11.name, "split") then
						var_460_11.gameObject:SetActive(true)
					else
						var_460_11.gameObject:SetActive(false)
					end
				end
			end

			local var_460_12 = 0.001

			if var_460_9 <= arg_457_1.time_ and arg_457_1.time_ < var_460_9 + var_460_12 then
				local var_460_13 = (arg_457_1.time_ - var_460_9) / var_460_12
				local var_460_14 = Vector3.New(0, -402.7, -156.1)

				var_460_8.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos10157, var_460_14, var_460_13)
			end

			if arg_457_1.time_ >= var_460_9 + var_460_12 and arg_457_1.time_ < var_460_9 + var_460_12 + arg_460_0 then
				var_460_8.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_460_15 = 0
			local var_460_16 = 0.425

			if var_460_15 < arg_457_1.time_ and arg_457_1.time_ <= var_460_15 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				local var_460_17 = arg_457_1:FormatText(StoryNameCfg[1434].name)

				arg_457_1.leftNameTxt_.text = var_460_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_18 = arg_457_1:GetWordFromCfg(425032112)
				local var_460_19 = arg_457_1:FormatText(var_460_18.content)

				arg_457_1.text_.text = var_460_19

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_20 = 17
				local var_460_21 = utf8.len(var_460_19)
				local var_460_22 = var_460_20 <= 0 and var_460_16 or var_460_16 * (var_460_21 / var_460_20)

				if var_460_22 > 0 and var_460_16 < var_460_22 then
					arg_457_1.talkMaxDuration = var_460_22

					if var_460_22 + var_460_15 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_22 + var_460_15
					end
				end

				arg_457_1.text_.text = var_460_19
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032112", "story_v_out_425032.awb") ~= 0 then
					local var_460_23 = manager.audio:GetVoiceLength("story_v_out_425032", "425032112", "story_v_out_425032.awb") / 1000

					if var_460_23 + var_460_15 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_23 + var_460_15
					end

					if var_460_18.prefab_name ~= "" and arg_457_1.actors_[var_460_18.prefab_name] ~= nil then
						local var_460_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_18.prefab_name].transform, "story_v_out_425032", "425032112", "story_v_out_425032.awb")

						arg_457_1:RecordAudio("425032112", var_460_24)
						arg_457_1:RecordAudio("425032112", var_460_24)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_425032", "425032112", "story_v_out_425032.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_425032", "425032112", "story_v_out_425032.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_25 = math.max(var_460_16, arg_457_1.talkMaxDuration)

			if var_460_15 <= arg_457_1.time_ and arg_457_1.time_ < var_460_15 + var_460_25 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_15) / var_460_25

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_15 + var_460_25 and arg_457_1.time_ < var_460_15 + var_460_25 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_457_1:InitPlayNodeList()
	end,
	Play425032113 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 425032113
		arg_461_1.duration_ = 9.2

		local var_461_0 = {
			zh = 7.333,
			ja = 9.2
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
				arg_461_0:Play425032114(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0
			local var_464_1 = 0.7

			if var_464_0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_2 = arg_461_1:FormatText(StoryNameCfg[1434].name)

				arg_461_1.leftNameTxt_.text = var_464_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_3 = arg_461_1:GetWordFromCfg(425032113)
				local var_464_4 = arg_461_1:FormatText(var_464_3.content)

				arg_461_1.text_.text = var_464_4

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_5 = 28
				local var_464_6 = utf8.len(var_464_4)
				local var_464_7 = var_464_5 <= 0 and var_464_1 or var_464_1 * (var_464_6 / var_464_5)

				if var_464_7 > 0 and var_464_1 < var_464_7 then
					arg_461_1.talkMaxDuration = var_464_7

					if var_464_7 + var_464_0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_7 + var_464_0
					end
				end

				arg_461_1.text_.text = var_464_4
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425032", "425032113", "story_v_out_425032.awb") ~= 0 then
					local var_464_8 = manager.audio:GetVoiceLength("story_v_out_425032", "425032113", "story_v_out_425032.awb") / 1000

					if var_464_8 + var_464_0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_8 + var_464_0
					end

					if var_464_3.prefab_name ~= "" and arg_461_1.actors_[var_464_3.prefab_name] ~= nil then
						local var_464_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_3.prefab_name].transform, "story_v_out_425032", "425032113", "story_v_out_425032.awb")

						arg_461_1:RecordAudio("425032113", var_464_9)
						arg_461_1:RecordAudio("425032113", var_464_9)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_425032", "425032113", "story_v_out_425032.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_425032", "425032113", "story_v_out_425032.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_10 = math.max(var_464_1, arg_461_1.talkMaxDuration)

			if var_464_0 <= arg_461_1.time_ and arg_461_1.time_ < var_464_0 + var_464_10 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_0) / var_464_10

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_0 + var_464_10 and arg_461_1.time_ < var_464_0 + var_464_10 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play425032114 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 425032114
		arg_465_1.duration_ = 5.63

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
			arg_465_1.auto_ = false
		end

		function arg_465_1.playNext_(arg_467_0)
			arg_465_1.onStoryFinished_()
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = arg_465_1.actors_["10157"].transform
			local var_468_1 = 0

			if var_468_1 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 then
				arg_465_1.var_.moveOldPos10157 = var_468_0.localPosition
				var_468_0.localScale = Vector3.New(1, 1, 1)

				arg_465_1:CheckSpriteTmpPos("10157", 7)

				local var_468_2 = var_468_0.childCount

				for iter_468_0 = 0, var_468_2 - 1 do
					local var_468_3 = var_468_0:GetChild(iter_468_0)

					if var_468_3.name == "split_3" or not string.find(var_468_3.name, "split") then
						var_468_3.gameObject:SetActive(true)
					else
						var_468_3.gameObject:SetActive(false)
					end
				end
			end

			local var_468_4 = 0.001

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_4 then
				local var_468_5 = (arg_465_1.time_ - var_468_1) / var_468_4
				local var_468_6 = Vector3.New(0, -2000, 0)

				var_468_0.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos10157, var_468_6, var_468_5)
			end

			if arg_465_1.time_ >= var_468_1 + var_468_4 and arg_465_1.time_ < var_468_1 + var_468_4 + arg_468_0 then
				var_468_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_468_7 = manager.ui.mainCamera.transform
			local var_468_8 = 0

			if var_468_8 < arg_465_1.time_ and arg_465_1.time_ <= var_468_8 + arg_468_0 then
				arg_465_1.var_.shakeOldPos = var_468_7.localPosition
			end

			local var_468_9 = 0.633333333333333

			if var_468_8 <= arg_465_1.time_ and arg_465_1.time_ < var_468_8 + var_468_9 then
				local var_468_10 = (arg_465_1.time_ - var_468_8) / 0.066
				local var_468_11, var_468_12 = math.modf(var_468_10)

				var_468_7.localPosition = Vector3.New(var_468_12 * 0.13, var_468_12 * 0.13, var_468_12 * 0.13) + arg_465_1.var_.shakeOldPos
			end

			if arg_465_1.time_ >= var_468_8 + var_468_9 and arg_465_1.time_ < var_468_8 + var_468_9 + arg_468_0 then
				var_468_7.localPosition = arg_465_1.var_.shakeOldPos
			end

			local var_468_13 = 0
			local var_468_14 = 1

			if var_468_13 < arg_465_1.time_ and arg_465_1.time_ <= var_468_13 + arg_468_0 then
				local var_468_15 = "play"
				local var_468_16 = "effect"

				arg_465_1:AudioAction(var_468_15, var_468_16, "se_story_1210", "se_story_1210_explosion", "")
			end

			local var_468_17 = 0

			if var_468_17 < arg_465_1.time_ and arg_465_1.time_ <= var_468_17 + arg_468_0 then
				arg_465_1.allBtn_.enabled = false
			end

			local var_468_18 = 0.858333333333333

			if arg_465_1.time_ >= var_468_17 + var_468_18 and arg_465_1.time_ < var_468_17 + var_468_18 + arg_468_0 then
				arg_465_1.allBtn_.enabled = true
			end

			if arg_465_1.frameCnt_ <= 1 then
				arg_465_1.dialog_:SetActive(false)
			end

			local var_468_19 = 0.633333333333333
			local var_468_20 = 0.225

			if var_468_19 < arg_465_1.time_ and arg_465_1.time_ <= var_468_19 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0

				arg_465_1.dialog_:SetActive(true)

				arg_465_1.dialogCg_.alpha = 0

				local var_468_21 = LeanTween.value(arg_465_1.dialog_, 0, 1, 0.3)

				var_468_21:setOnUpdate(LuaHelper.FloatAction(function(arg_469_0)
					arg_465_1.dialogCg_.alpha = arg_469_0
				end))
				var_468_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_465_1.dialog_)
					var_468_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_465_1.duration_ = arg_465_1.duration_ + 0.3

				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_22 = arg_465_1:GetWordFromCfg(425032114)
				local var_468_23 = arg_465_1:FormatText(var_468_22.content)

				arg_465_1.text_.text = var_468_23

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_24 = 9
				local var_468_25 = utf8.len(var_468_23)
				local var_468_26 = var_468_24 <= 0 and var_468_20 or var_468_20 * (var_468_25 / var_468_24)

				if var_468_26 > 0 and var_468_20 < var_468_26 then
					arg_465_1.talkMaxDuration = var_468_26
					var_468_19 = var_468_19 + 0.3

					if var_468_26 + var_468_19 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_26 + var_468_19
					end
				end

				arg_465_1.text_.text = var_468_23
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_27 = var_468_19 + 0.3
			local var_468_28 = math.max(var_468_20, arg_465_1.talkMaxDuration)

			if var_468_27 <= arg_465_1.time_ and arg_465_1.time_ < var_468_27 + var_468_28 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_27) / var_468_28

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_27 + var_468_28 and arg_465_1.time_ < var_468_27 + var_468_28 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_465_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2107",
		"TextureConfig/Background/ST2108",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/M01K",
		"TextureConfig/Background/ST2402"
	},
	voices = {
		"story_v_out_425032.awb"
	}
}
