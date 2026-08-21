return {
	Play424111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 424111001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play424111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST0115a"

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
				local var_4_5 = arg_1_1.bgs_.ST0115a

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
					if iter_4_0 ~= "ST0115a" then
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

			local var_4_24 = 0
			local var_4_25 = 0.3

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_29 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			local var_4_30 = 0.433333333333333
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_4_6_story_suspense", "bgm_activity_4_6_story_suspense", "bgm_activity_4_6_story_suspense.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_4_6_story_suspense", "bgm_activity_4_6_story_suspense")

				if var_4_35 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_35 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_35

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_35
						arg_1_1.bgmTxt2_.text = var_4_35
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

			local var_4_36 = 0.1
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "se_story_146", "se_story_146_wind02", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_40 = 2
			local var_4_41 = 0.275

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

				local var_4_43 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_43

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

				local var_4_44 = arg_1_1:GetWordFromCfg(424111001)
				local var_4_45 = arg_1_1:FormatText(var_4_44.content)

				arg_1_1.text_.text = var_4_45

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_46 = 11
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
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_49 = var_4_40 + 0.3
			local var_4_50 = math.max(var_4_41, arg_1_1.talkMaxDuration)

			if var_4_49 <= arg_1_1.time_ and arg_1_1.time_ < var_4_49 + var_4_50 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_49) / var_4_50

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_49 + var_4_50 and arg_1_1.time_ < var_4_49 + var_4_50 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play424111002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 424111002
		arg_9_1.duration_ = 8.3

		local var_9_0 = {
			zh = 5.833,
			ja = 8.3
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
				arg_9_0:Play424111003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "10155"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10155")

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

			local var_12_4 = arg_9_1.actors_["10155"]
			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 and not isNil(var_12_4) and arg_9_1.var_.actorSpriteComps10155 == nil then
				arg_9_1.var_.actorSpriteComps10155 = var_12_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_6 = 0.2

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_6 and not isNil(var_12_4) then
				local var_12_7 = (arg_9_1.time_ - var_12_5) / var_12_6

				if arg_9_1.var_.actorSpriteComps10155 then
					for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_9_1.time_ >= var_12_5 + var_12_6 and arg_9_1.time_ < var_12_5 + var_12_6 + arg_12_0 and not isNil(var_12_4) and arg_9_1.var_.actorSpriteComps10155 then
				for iter_12_4, iter_12_5 in pairs(arg_9_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_12_5 then
						if arg_9_1.isInRecall_ then
							iter_12_5.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10155 = nil
			end

			local var_12_12 = arg_9_1.actors_["10155"].transform
			local var_12_13 = 0

			if var_12_13 < arg_9_1.time_ and arg_9_1.time_ <= var_12_13 + arg_12_0 then
				arg_9_1.var_.moveOldPos10155 = var_12_12.localPosition
				var_12_12.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10155", 3)

				local var_12_14 = var_12_12.childCount

				for iter_12_6 = 0, var_12_14 - 1 do
					local var_12_15 = var_12_12:GetChild(iter_12_6)

					if var_12_15.name == "split_6" or not string.find(var_12_15.name, "split") then
						var_12_15.gameObject:SetActive(true)
					else
						var_12_15.gameObject:SetActive(false)
					end
				end
			end

			local var_12_16 = 0.001

			if var_12_13 <= arg_9_1.time_ and arg_9_1.time_ < var_12_13 + var_12_16 then
				local var_12_17 = (arg_9_1.time_ - var_12_13) / var_12_16
				local var_12_18 = Vector3.New(-40, -390, -250)

				var_12_12.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10155, var_12_18, var_12_17)
			end

			if arg_9_1.time_ >= var_12_13 + var_12_16 and arg_9_1.time_ < var_12_13 + var_12_16 + arg_12_0 then
				var_12_12.localPosition = Vector3.New(-40, -390, -250)
			end

			local var_12_19 = arg_9_1.actors_["10155"]
			local var_12_20 = 0

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				local var_12_21 = var_12_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_21 then
					arg_9_1.var_.alphaOldValue10155 = var_12_21.alpha
					arg_9_1.var_.characterEffect10155 = var_12_21
				end

				arg_9_1.var_.alphaOldValue10155 = 0
			end

			local var_12_22 = 0.5

			if var_12_20 <= arg_9_1.time_ and arg_9_1.time_ < var_12_20 + var_12_22 then
				local var_12_23 = (arg_9_1.time_ - var_12_20) / var_12_22
				local var_12_24 = Mathf.Lerp(arg_9_1.var_.alphaOldValue10155, 1, var_12_23)

				if arg_9_1.var_.characterEffect10155 then
					arg_9_1.var_.characterEffect10155.alpha = var_12_24
				end
			end

			if arg_9_1.time_ >= var_12_20 + var_12_22 and arg_9_1.time_ < var_12_20 + var_12_22 + arg_12_0 and arg_9_1.var_.characterEffect10155 then
				arg_9_1.var_.characterEffect10155.alpha = 1
			end

			local var_12_25 = 0
			local var_12_26 = 0.325

			if var_12_25 < arg_9_1.time_ and arg_9_1.time_ <= var_12_25 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_27 = arg_9_1:FormatText(StoryNameCfg[1391].name)

				arg_9_1.leftNameTxt_.text = var_12_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_28 = arg_9_1:GetWordFromCfg(424111002)
				local var_12_29 = arg_9_1:FormatText(var_12_28.content)

				arg_9_1.text_.text = var_12_29

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_30 = 13
				local var_12_31 = utf8.len(var_12_29)
				local var_12_32 = var_12_30 <= 0 and var_12_26 or var_12_26 * (var_12_31 / var_12_30)

				if var_12_32 > 0 and var_12_26 < var_12_32 then
					arg_9_1.talkMaxDuration = var_12_32

					if var_12_32 + var_12_25 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_32 + var_12_25
					end
				end

				arg_9_1.text_.text = var_12_29
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111002", "story_v_out_424111.awb") ~= 0 then
					local var_12_33 = manager.audio:GetVoiceLength("story_v_out_424111", "424111002", "story_v_out_424111.awb") / 1000

					if var_12_33 + var_12_25 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_33 + var_12_25
					end

					if var_12_28.prefab_name ~= "" and arg_9_1.actors_[var_12_28.prefab_name] ~= nil then
						local var_12_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_28.prefab_name].transform, "story_v_out_424111", "424111002", "story_v_out_424111.awb")

						arg_9_1:RecordAudio("424111002", var_12_34)
						arg_9_1:RecordAudio("424111002", var_12_34)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_424111", "424111002", "story_v_out_424111.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_424111", "424111002", "story_v_out_424111.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_35 = math.max(var_12_26, arg_9_1.talkMaxDuration)

			if var_12_25 <= arg_9_1.time_ and arg_9_1.time_ < var_12_25 + var_12_35 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_25) / var_12_35

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_25 + var_12_35 and arg_9_1.time_ < var_12_25 + var_12_35 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
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
	Play424111003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 424111003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play424111004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10155"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps10155 == nil then
				arg_13_1.var_.actorSpriteComps10155 = var_16_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_2 = 0.2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.actorSpriteComps10155 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps10155 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_16_3 then
						if arg_13_1.isInRecall_ then
							iter_16_3.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10155 = nil
			end

			local var_16_8 = 0
			local var_16_9 = 1.275

			if var_16_8 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_10 = arg_13_1:FormatText(StoryNameCfg[7].name)

				arg_13_1.leftNameTxt_.text = var_16_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_11 = arg_13_1:GetWordFromCfg(424111003)
				local var_16_12 = arg_13_1:FormatText(var_16_11.content)

				arg_13_1.text_.text = var_16_12

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 51
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
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_16 and arg_13_1.time_ < var_16_8 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play424111004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 424111004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play424111005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.45

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[7].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(424111004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 58
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
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_8 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_8 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_8

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_8 and arg_17_1.time_ < var_20_0 + var_20_8 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play424111005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 424111005
		arg_21_1.duration_ = 4.3

		local var_21_0 = {
			zh = 3.7,
			ja = 4.3
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
				arg_21_0:Play424111006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.475

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[177].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(424111005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111005", "story_v_out_424111.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_424111", "424111005", "story_v_out_424111.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_424111", "424111005", "story_v_out_424111.awb")

						arg_21_1:RecordAudio("424111005", var_24_9)
						arg_21_1:RecordAudio("424111005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_424111", "424111005", "story_v_out_424111.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_424111", "424111005", "story_v_out_424111.awb")
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
	Play424111006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 424111006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play424111007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.475

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(424111006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 19
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
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_8 and arg_25_1.time_ < var_28_0 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play424111007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 424111007
		arg_29_1.duration_ = 16.57

		local var_29_0 = {
			zh = 8.333,
			ja = 16.566
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
				arg_29_0:Play424111008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10155"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10155 == nil then
				arg_29_1.var_.actorSpriteComps10155 = var_32_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.actorSpriteComps10155 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								local var_32_4 = Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor1.r, var_32_3)
								local var_32_5 = Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor1.g, var_32_3)
								local var_32_6 = Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor1.b, var_32_3)

								iter_32_1.color = Color.New(var_32_4, var_32_5, var_32_6)
							else
								local var_32_7 = Mathf.Lerp(iter_32_1.color.r, 1, var_32_3)

								iter_32_1.color = Color.New(var_32_7, var_32_7, var_32_7)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10155 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_32_3 then
						if arg_29_1.isInRecall_ then
							iter_32_3.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10155 = nil
			end

			local var_32_8 = arg_29_1.actors_["10155"].transform
			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 then
				arg_29_1.var_.moveOldPos10155 = var_32_8.localPosition
				var_32_8.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10155", 3)

				local var_32_10 = var_32_8.childCount

				for iter_32_4 = 0, var_32_10 - 1 do
					local var_32_11 = var_32_8:GetChild(iter_32_4)

					if var_32_11.name == "split_6" or not string.find(var_32_11.name, "split") then
						var_32_11.gameObject:SetActive(true)
					else
						var_32_11.gameObject:SetActive(false)
					end
				end
			end

			local var_32_12 = 0.001

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_12 then
				local var_32_13 = (arg_29_1.time_ - var_32_9) / var_32_12
				local var_32_14 = Vector3.New(-40, -390, -250)

				var_32_8.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10155, var_32_14, var_32_13)
			end

			if arg_29_1.time_ >= var_32_9 + var_32_12 and arg_29_1.time_ < var_32_9 + var_32_12 + arg_32_0 then
				var_32_8.localPosition = Vector3.New(-40, -390, -250)
			end

			local var_32_15 = 0
			local var_32_16 = 0.575

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_17 = arg_29_1:FormatText(StoryNameCfg[1391].name)

				arg_29_1.leftNameTxt_.text = var_32_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_18 = arg_29_1:GetWordFromCfg(424111007)
				local var_32_19 = arg_29_1:FormatText(var_32_18.content)

				arg_29_1.text_.text = var_32_19

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_20 = 23
				local var_32_21 = utf8.len(var_32_19)
				local var_32_22 = var_32_20 <= 0 and var_32_16 or var_32_16 * (var_32_21 / var_32_20)

				if var_32_22 > 0 and var_32_16 < var_32_22 then
					arg_29_1.talkMaxDuration = var_32_22

					if var_32_22 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_22 + var_32_15
					end
				end

				arg_29_1.text_.text = var_32_19
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111007", "story_v_out_424111.awb") ~= 0 then
					local var_32_23 = manager.audio:GetVoiceLength("story_v_out_424111", "424111007", "story_v_out_424111.awb") / 1000

					if var_32_23 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_23 + var_32_15
					end

					if var_32_18.prefab_name ~= "" and arg_29_1.actors_[var_32_18.prefab_name] ~= nil then
						local var_32_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_18.prefab_name].transform, "story_v_out_424111", "424111007", "story_v_out_424111.awb")

						arg_29_1:RecordAudio("424111007", var_32_24)
						arg_29_1:RecordAudio("424111007", var_32_24)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_424111", "424111007", "story_v_out_424111.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_424111", "424111007", "story_v_out_424111.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_25 = math.max(var_32_16, arg_29_1.talkMaxDuration)

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_25 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_15) / var_32_25

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_15 + var_32_25 and arg_29_1.time_ < var_32_15 + var_32_25 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play424111008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 424111008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play424111009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10155"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10155 == nil then
				arg_33_1.var_.actorSpriteComps10155 = var_36_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_2 = 0.2

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.actorSpriteComps10155 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_36_1 then
							if arg_33_1.isInRecall_ then
								local var_36_4 = Mathf.Lerp(iter_36_1.color.r, arg_33_1.hightColor2.r, var_36_3)
								local var_36_5 = Mathf.Lerp(iter_36_1.color.g, arg_33_1.hightColor2.g, var_36_3)
								local var_36_6 = Mathf.Lerp(iter_36_1.color.b, arg_33_1.hightColor2.b, var_36_3)

								iter_36_1.color = Color.New(var_36_4, var_36_5, var_36_6)
							else
								local var_36_7 = Mathf.Lerp(iter_36_1.color.r, 0.5, var_36_3)

								iter_36_1.color = Color.New(var_36_7, var_36_7, var_36_7)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10155 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10155 = nil
			end

			local var_36_8 = 0
			local var_36_9 = 0.7

			if var_36_8 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_10 = arg_33_1:FormatText(StoryNameCfg[7].name)

				arg_33_1.leftNameTxt_.text = var_36_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_11 = arg_33_1:GetWordFromCfg(424111008)
				local var_36_12 = arg_33_1:FormatText(var_36_11.content)

				arg_33_1.text_.text = var_36_12

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 28
				local var_36_14 = utf8.len(var_36_12)
				local var_36_15 = var_36_13 <= 0 and var_36_9 or var_36_9 * (var_36_14 / var_36_13)

				if var_36_15 > 0 and var_36_9 < var_36_15 then
					arg_33_1.talkMaxDuration = var_36_15

					if var_36_15 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_15 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_12
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_9, arg_33_1.talkMaxDuration)

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_8) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_8 + var_36_16 and arg_33_1.time_ < var_36_8 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play424111009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 424111009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play424111010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10155"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos10155 = var_40_0.localPosition
				var_40_0.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10155", 7)

				local var_40_2 = var_40_0.childCount

				for iter_40_0 = 0, var_40_2 - 1 do
					local var_40_3 = var_40_0:GetChild(iter_40_0)

					if var_40_3.name == "" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_4 then
				local var_40_5 = (arg_37_1.time_ - var_40_1) / var_40_4
				local var_40_6 = Vector3.New(0, -2000, 0)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10155, var_40_6, var_40_5)
			end

			if arg_37_1.time_ >= var_40_1 + var_40_4 and arg_37_1.time_ < var_40_1 + var_40_4 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_40_7 = 0
			local var_40_8 = 1.5

			if var_40_7 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_9 = arg_37_1:GetWordFromCfg(424111009)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 60
				local var_40_12 = utf8.len(var_40_10)
				local var_40_13 = var_40_11 <= 0 and var_40_8 or var_40_8 * (var_40_12 / var_40_11)

				if var_40_13 > 0 and var_40_8 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_7 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_7
					end
				end

				arg_37_1.text_.text = var_40_10
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_8, arg_37_1.talkMaxDuration)

			if var_40_7 <= arg_37_1.time_ and arg_37_1.time_ < var_40_7 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_7) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_7 + var_40_14 and arg_37_1.time_ < var_40_7 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
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
	Play424111010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 424111010
		arg_41_1.duration_ = 6.27

		local var_41_0 = {
			zh = 3.933,
			ja = 6.266
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
				arg_41_0:Play424111011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10155"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10155 == nil then
				arg_41_1.var_.actorSpriteComps10155 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps10155 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10155 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10155 = nil
			end

			local var_44_8 = arg_41_1.actors_["10155"].transform
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 then
				arg_41_1.var_.moveOldPos10155 = var_44_8.localPosition
				var_44_8.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10155", 2)

				local var_44_10 = var_44_8.childCount

				for iter_44_4 = 0, var_44_10 - 1 do
					local var_44_11 = var_44_8:GetChild(iter_44_4)

					if var_44_11.name == "split_6" or not string.find(var_44_11.name, "split") then
						var_44_11.gameObject:SetActive(true)
					else
						var_44_11.gameObject:SetActive(false)
					end
				end
			end

			local var_44_12 = 0.001

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_12 then
				local var_44_13 = (arg_41_1.time_ - var_44_9) / var_44_12
				local var_44_14 = Vector3.New(-410, -390, -250)

				var_44_8.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10155, var_44_14, var_44_13)
			end

			if arg_41_1.time_ >= var_44_9 + var_44_12 and arg_41_1.time_ < var_44_9 + var_44_12 + arg_44_0 then
				var_44_8.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_44_15 = 0
			local var_44_16 = 0.325

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_17 = arg_41_1:FormatText(StoryNameCfg[1391].name)

				arg_41_1.leftNameTxt_.text = var_44_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_18 = arg_41_1:GetWordFromCfg(424111010)
				local var_44_19 = arg_41_1:FormatText(var_44_18.content)

				arg_41_1.text_.text = var_44_19

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_20 = 13
				local var_44_21 = utf8.len(var_44_19)
				local var_44_22 = var_44_20 <= 0 and var_44_16 or var_44_16 * (var_44_21 / var_44_20)

				if var_44_22 > 0 and var_44_16 < var_44_22 then
					arg_41_1.talkMaxDuration = var_44_22

					if var_44_22 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_22 + var_44_15
					end
				end

				arg_41_1.text_.text = var_44_19
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111010", "story_v_out_424111.awb") ~= 0 then
					local var_44_23 = manager.audio:GetVoiceLength("story_v_out_424111", "424111010", "story_v_out_424111.awb") / 1000

					if var_44_23 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_23 + var_44_15
					end

					if var_44_18.prefab_name ~= "" and arg_41_1.actors_[var_44_18.prefab_name] ~= nil then
						local var_44_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_18.prefab_name].transform, "story_v_out_424111", "424111010", "story_v_out_424111.awb")

						arg_41_1:RecordAudio("424111010", var_44_24)
						arg_41_1:RecordAudio("424111010", var_44_24)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_424111", "424111010", "story_v_out_424111.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_424111", "424111010", "story_v_out_424111.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_25 = math.max(var_44_16, arg_41_1.talkMaxDuration)

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_25 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_15) / var_44_25

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_15 + var_44_25 and arg_41_1.time_ < var_44_15 + var_44_25 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
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
	Play424111011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 424111011
		arg_45_1.duration_ = 4.23

		local var_45_0 = {
			zh = 3.433,
			ja = 4.233
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
				arg_45_0:Play424111012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = "1094"

			if arg_45_1.actors_[var_48_0] == nil then
				local var_48_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1094")

				if not isNil(var_48_1) then
					local var_48_2 = Object.Instantiate(var_48_1, arg_45_1.canvasGo_.transform)

					var_48_2.transform:SetSiblingIndex(1)

					var_48_2.name = var_48_0
					var_48_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_45_1.actors_[var_48_0] = var_48_2

					local var_48_3 = var_48_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_45_1.isInRecall_ then
						for iter_48_0, iter_48_1 in ipairs(var_48_3) do
							iter_48_1.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_48_4 = arg_45_1.actors_["1094"]
			local var_48_5 = 0

			if var_48_5 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.actorSpriteComps1094 == nil then
				arg_45_1.var_.actorSpriteComps1094 = var_48_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_6 = 0.2

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_6 and not isNil(var_48_4) then
				local var_48_7 = (arg_45_1.time_ - var_48_5) / var_48_6

				if arg_45_1.var_.actorSpriteComps1094 then
					for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_48_3 then
							if arg_45_1.isInRecall_ then
								local var_48_8 = Mathf.Lerp(iter_48_3.color.r, arg_45_1.hightColor1.r, var_48_7)
								local var_48_9 = Mathf.Lerp(iter_48_3.color.g, arg_45_1.hightColor1.g, var_48_7)
								local var_48_10 = Mathf.Lerp(iter_48_3.color.b, arg_45_1.hightColor1.b, var_48_7)

								iter_48_3.color = Color.New(var_48_8, var_48_9, var_48_10)
							else
								local var_48_11 = Mathf.Lerp(iter_48_3.color.r, 1, var_48_7)

								iter_48_3.color = Color.New(var_48_11, var_48_11, var_48_11)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_5 + var_48_6 and arg_45_1.time_ < var_48_5 + var_48_6 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.actorSpriteComps1094 then
				for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_48_5 then
						if arg_45_1.isInRecall_ then
							iter_48_5.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1094 = nil
			end

			local var_48_12 = arg_45_1.actors_["10155"]
			local var_48_13 = 0

			if var_48_13 < arg_45_1.time_ and arg_45_1.time_ <= var_48_13 + arg_48_0 and not isNil(var_48_12) and arg_45_1.var_.actorSpriteComps10155 == nil then
				arg_45_1.var_.actorSpriteComps10155 = var_48_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_14 = 0.2

			if var_48_13 <= arg_45_1.time_ and arg_45_1.time_ < var_48_13 + var_48_14 and not isNil(var_48_12) then
				local var_48_15 = (arg_45_1.time_ - var_48_13) / var_48_14

				if arg_45_1.var_.actorSpriteComps10155 then
					for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_48_7 then
							if arg_45_1.isInRecall_ then
								local var_48_16 = Mathf.Lerp(iter_48_7.color.r, arg_45_1.hightColor2.r, var_48_15)
								local var_48_17 = Mathf.Lerp(iter_48_7.color.g, arg_45_1.hightColor2.g, var_48_15)
								local var_48_18 = Mathf.Lerp(iter_48_7.color.b, arg_45_1.hightColor2.b, var_48_15)

								iter_48_7.color = Color.New(var_48_16, var_48_17, var_48_18)
							else
								local var_48_19 = Mathf.Lerp(iter_48_7.color.r, 0.5, var_48_15)

								iter_48_7.color = Color.New(var_48_19, var_48_19, var_48_19)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_13 + var_48_14 and arg_45_1.time_ < var_48_13 + var_48_14 + arg_48_0 and not isNil(var_48_12) and arg_45_1.var_.actorSpriteComps10155 then
				for iter_48_8, iter_48_9 in pairs(arg_45_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_48_9 then
						if arg_45_1.isInRecall_ then
							iter_48_9.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10155 = nil
			end

			local var_48_20 = arg_45_1.actors_["1094"].transform
			local var_48_21 = 0

			if var_48_21 < arg_45_1.time_ and arg_45_1.time_ <= var_48_21 + arg_48_0 then
				arg_45_1.var_.moveOldPos1094 = var_48_20.localPosition
				var_48_20.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1094", 4)

				local var_48_22 = var_48_20.childCount

				for iter_48_10 = 0, var_48_22 - 1 do
					local var_48_23 = var_48_20:GetChild(iter_48_10)

					if var_48_23.name == "" or not string.find(var_48_23.name, "split") then
						var_48_23.gameObject:SetActive(true)
					else
						var_48_23.gameObject:SetActive(false)
					end
				end
			end

			local var_48_24 = 0.001

			if var_48_21 <= arg_45_1.time_ and arg_45_1.time_ < var_48_21 + var_48_24 then
				local var_48_25 = (arg_45_1.time_ - var_48_21) / var_48_24
				local var_48_26 = Vector3.New(470, -335, -230)

				var_48_20.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1094, var_48_26, var_48_25)
			end

			if arg_45_1.time_ >= var_48_21 + var_48_24 and arg_45_1.time_ < var_48_21 + var_48_24 + arg_48_0 then
				var_48_20.localPosition = Vector3.New(470, -335, -230)
			end

			local var_48_27 = 0
			local var_48_28 = 0.275

			if var_48_27 < arg_45_1.time_ and arg_45_1.time_ <= var_48_27 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_29 = arg_45_1:FormatText(StoryNameCfg[181].name)

				arg_45_1.leftNameTxt_.text = var_48_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_30 = arg_45_1:GetWordFromCfg(424111011)
				local var_48_31 = arg_45_1:FormatText(var_48_30.content)

				arg_45_1.text_.text = var_48_31

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_32 = 11
				local var_48_33 = utf8.len(var_48_31)
				local var_48_34 = var_48_32 <= 0 and var_48_28 or var_48_28 * (var_48_33 / var_48_32)

				if var_48_34 > 0 and var_48_28 < var_48_34 then
					arg_45_1.talkMaxDuration = var_48_34

					if var_48_34 + var_48_27 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_34 + var_48_27
					end
				end

				arg_45_1.text_.text = var_48_31
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111011", "story_v_out_424111.awb") ~= 0 then
					local var_48_35 = manager.audio:GetVoiceLength("story_v_out_424111", "424111011", "story_v_out_424111.awb") / 1000

					if var_48_35 + var_48_27 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_35 + var_48_27
					end

					if var_48_30.prefab_name ~= "" and arg_45_1.actors_[var_48_30.prefab_name] ~= nil then
						local var_48_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_30.prefab_name].transform, "story_v_out_424111", "424111011", "story_v_out_424111.awb")

						arg_45_1:RecordAudio("424111011", var_48_36)
						arg_45_1:RecordAudio("424111011", var_48_36)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_424111", "424111011", "story_v_out_424111.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_424111", "424111011", "story_v_out_424111.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_37 = math.max(var_48_28, arg_45_1.talkMaxDuration)

			if var_48_27 <= arg_45_1.time_ and arg_45_1.time_ < var_48_27 + var_48_37 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_27) / var_48_37

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_27 + var_48_37 and arg_45_1.time_ < var_48_27 + var_48_37 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play424111012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 424111012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play424111013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1094"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps1094 == nil then
				arg_49_1.var_.actorSpriteComps1094 = var_52_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.actorSpriteComps1094 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								local var_52_4 = Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor2.r, var_52_3)
								local var_52_5 = Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor2.g, var_52_3)
								local var_52_6 = Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor2.b, var_52_3)

								iter_52_1.color = Color.New(var_52_4, var_52_5, var_52_6)
							else
								local var_52_7 = Mathf.Lerp(iter_52_1.color.r, 0.5, var_52_3)

								iter_52_1.color = Color.New(var_52_7, var_52_7, var_52_7)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps1094 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_52_3 then
						if arg_49_1.isInRecall_ then
							iter_52_3.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps1094 = nil
			end

			local var_52_8 = 0
			local var_52_9 = 0.975

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_10 = arg_49_1:FormatText(StoryNameCfg[7].name)

				arg_49_1.leftNameTxt_.text = var_52_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_11 = arg_49_1:GetWordFromCfg(424111012)
				local var_52_12 = arg_49_1:FormatText(var_52_11.content)

				arg_49_1.text_.text = var_52_12

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_13 = 39
				local var_52_14 = utf8.len(var_52_12)
				local var_52_15 = var_52_13 <= 0 and var_52_9 or var_52_9 * (var_52_14 / var_52_13)

				if var_52_15 > 0 and var_52_9 < var_52_15 then
					arg_49_1.talkMaxDuration = var_52_15

					if var_52_15 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_15 + var_52_8
					end
				end

				arg_49_1.text_.text = var_52_12
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_16 = math.max(var_52_9, arg_49_1.talkMaxDuration)

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_8) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_8 + var_52_16 and arg_49_1.time_ < var_52_8 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play424111013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 424111013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play424111014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1094"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1094 = var_56_0.localPosition
				var_56_0.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1094", 7)

				local var_56_2 = var_56_0.childCount

				for iter_56_0 = 0, var_56_2 - 1 do
					local var_56_3 = var_56_0:GetChild(iter_56_0)

					if var_56_3.name == "" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_4 then
				local var_56_5 = (arg_53_1.time_ - var_56_1) / var_56_4
				local var_56_6 = Vector3.New(0, -2000, 0)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1094, var_56_6, var_56_5)
			end

			if arg_53_1.time_ >= var_56_1 + var_56_4 and arg_53_1.time_ < var_56_1 + var_56_4 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_56_7 = arg_53_1.actors_["10155"].transform
			local var_56_8 = 0

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.var_.moveOldPos10155 = var_56_7.localPosition
				var_56_7.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10155", 7)

				local var_56_9 = var_56_7.childCount

				for iter_56_1 = 0, var_56_9 - 1 do
					local var_56_10 = var_56_7:GetChild(iter_56_1)

					if var_56_10.name == "" or not string.find(var_56_10.name, "split") then
						var_56_10.gameObject:SetActive(true)
					else
						var_56_10.gameObject:SetActive(false)
					end
				end
			end

			local var_56_11 = 0.001

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_11 then
				local var_56_12 = (arg_53_1.time_ - var_56_8) / var_56_11
				local var_56_13 = Vector3.New(0, -2000, 0)

				var_56_7.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10155, var_56_13, var_56_12)
			end

			if arg_53_1.time_ >= var_56_8 + var_56_11 and arg_53_1.time_ < var_56_8 + var_56_11 + arg_56_0 then
				var_56_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_56_14 = 0.1
			local var_56_15 = 1

			if var_56_14 < arg_53_1.time_ and arg_53_1.time_ <= var_56_14 + arg_56_0 then
				local var_56_16 = "play"
				local var_56_17 = "effect"

				arg_53_1:AudioAction(var_56_16, var_56_17, "se_story_140", "se_story_140_data01", "")
			end

			local var_56_18 = 0
			local var_56_19 = 0.825

			if var_56_18 < arg_53_1.time_ and arg_53_1.time_ <= var_56_18 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_20 = arg_53_1:GetWordFromCfg(424111013)
				local var_56_21 = arg_53_1:FormatText(var_56_20.content)

				arg_53_1.text_.text = var_56_21

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_22 = 33
				local var_56_23 = utf8.len(var_56_21)
				local var_56_24 = var_56_22 <= 0 and var_56_19 or var_56_19 * (var_56_23 / var_56_22)

				if var_56_24 > 0 and var_56_19 < var_56_24 then
					arg_53_1.talkMaxDuration = var_56_24

					if var_56_24 + var_56_18 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_24 + var_56_18
					end
				end

				arg_53_1.text_.text = var_56_21
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_25 = math.max(var_56_19, arg_53_1.talkMaxDuration)

			if var_56_18 <= arg_53_1.time_ and arg_53_1.time_ < var_56_18 + var_56_25 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_18) / var_56_25

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_18 + var_56_25 and arg_53_1.time_ < var_56_18 + var_56_25 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play424111014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 424111014
		arg_57_1.duration_ = 9

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play424111015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = "ST0116a"

			if arg_57_1.bgs_[var_60_0] == nil then
				local var_60_1 = Object.Instantiate(arg_57_1.paintGo_)

				var_60_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_60_0)
				var_60_1.name = var_60_0
				var_60_1.transform.parent = arg_57_1.stage_.transform
				var_60_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.bgs_[var_60_0] = var_60_1
			end

			local var_60_2 = 2

			if var_60_2 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				local var_60_3 = manager.ui.mainCamera.transform.localPosition
				local var_60_4 = Vector3.New(0, 0, 10) + Vector3.New(var_60_3.x, var_60_3.y, 0)
				local var_60_5 = arg_57_1.bgs_.ST0116a

				var_60_5.transform.localPosition = var_60_4
				var_60_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_60_6 = var_60_5:GetComponent("SpriteRenderer")

				if var_60_6 and var_60_6.sprite then
					local var_60_7 = (var_60_5.transform.localPosition - var_60_3).z
					local var_60_8 = manager.ui.mainCameraCom_
					local var_60_9 = 2 * var_60_7 * Mathf.Tan(var_60_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_60_10 = var_60_9 * var_60_8.aspect
					local var_60_11 = var_60_6.sprite.bounds.size.x
					local var_60_12 = var_60_6.sprite.bounds.size.y
					local var_60_13 = var_60_10 / var_60_11
					local var_60_14 = var_60_9 / var_60_12
					local var_60_15 = var_60_14 < var_60_13 and var_60_13 or var_60_14

					var_60_5.transform.localScale = Vector3.New(var_60_15, var_60_15, 0)
				end

				for iter_60_0, iter_60_1 in pairs(arg_57_1.bgs_) do
					if iter_60_0 ~= "ST0116a" then
						iter_60_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_60_16 = 3.999999999999

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 then
				arg_57_1.allBtn_.enabled = false
			end

			local var_60_17 = 0.3

			if arg_57_1.time_ >= var_60_16 + var_60_17 and arg_57_1.time_ < var_60_16 + var_60_17 + arg_60_0 then
				arg_57_1.allBtn_.enabled = true
			end

			local var_60_18 = 0

			if var_60_18 < arg_57_1.time_ and arg_57_1.time_ <= var_60_18 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_19 = 2

			if var_60_18 <= arg_57_1.time_ and arg_57_1.time_ < var_60_18 + var_60_19 then
				local var_60_20 = (arg_57_1.time_ - var_60_18) / var_60_19
				local var_60_21 = Color.New(0, 0, 0)

				var_60_21.a = Mathf.Lerp(0, 1, var_60_20)
				arg_57_1.mask_.color = var_60_21
			end

			if arg_57_1.time_ >= var_60_18 + var_60_19 and arg_57_1.time_ < var_60_18 + var_60_19 + arg_60_0 then
				local var_60_22 = Color.New(0, 0, 0)

				var_60_22.a = 1
				arg_57_1.mask_.color = var_60_22
			end

			local var_60_23 = 2

			if var_60_23 < arg_57_1.time_ and arg_57_1.time_ <= var_60_23 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_24 = 2

			if var_60_23 <= arg_57_1.time_ and arg_57_1.time_ < var_60_23 + var_60_24 then
				local var_60_25 = (arg_57_1.time_ - var_60_23) / var_60_24
				local var_60_26 = Color.New(0, 0, 0)

				var_60_26.a = Mathf.Lerp(1, 0, var_60_25)
				arg_57_1.mask_.color = var_60_26
			end

			if arg_57_1.time_ >= var_60_23 + var_60_24 and arg_57_1.time_ < var_60_23 + var_60_24 + arg_60_0 then
				local var_60_27 = Color.New(0, 0, 0)
				local var_60_28 = 0

				arg_57_1.mask_.enabled = false
				var_60_27.a = var_60_28
				arg_57_1.mask_.color = var_60_27
			end

			local var_60_29 = 0.233333333333333
			local var_60_30 = 1

			if var_60_29 < arg_57_1.time_ and arg_57_1.time_ <= var_60_29 + arg_60_0 then
				local var_60_31 = "stop"
				local var_60_32 = "effect"

				arg_57_1:AudioAction(var_60_31, var_60_32, "se_story_146", "se_story_146_wind02", "")
			end

			local var_60_33 = 1.66666666666667
			local var_60_34 = 1

			if var_60_33 < arg_57_1.time_ and arg_57_1.time_ <= var_60_33 + arg_60_0 then
				local var_60_35 = "play"
				local var_60_36 = "effect"

				arg_57_1:AudioAction(var_60_35, var_60_36, "se_story_side_1095", "se_story_side_1095_amb_forest_night_nowater", "")
			end

			if arg_57_1.frameCnt_ <= 1 then
				arg_57_1.dialog_:SetActive(false)
			end

			local var_60_37 = 3.999999999999
			local var_60_38 = 1.4

			if var_60_37 < arg_57_1.time_ and arg_57_1.time_ <= var_60_37 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_39 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_39:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_40 = arg_57_1:GetWordFromCfg(424111014)
				local var_60_41 = arg_57_1:FormatText(var_60_40.content)

				arg_57_1.text_.text = var_60_41

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_42 = 56
				local var_60_43 = utf8.len(var_60_41)
				local var_60_44 = var_60_42 <= 0 and var_60_38 or var_60_38 * (var_60_43 / var_60_42)

				if var_60_44 > 0 and var_60_38 < var_60_44 then
					arg_57_1.talkMaxDuration = var_60_44
					var_60_37 = var_60_37 + 0.3

					if var_60_44 + var_60_37 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_44 + var_60_37
					end
				end

				arg_57_1.text_.text = var_60_41
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_45 = var_60_37 + 0.3
			local var_60_46 = math.max(var_60_38, arg_57_1.talkMaxDuration)

			if var_60_45 <= arg_57_1.time_ and arg_57_1.time_ < var_60_45 + var_60_46 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_45) / var_60_46

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_45 + var_60_46 and arg_57_1.time_ < var_60_45 + var_60_46 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play424111015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 424111015
		arg_63_1.duration_ = 1.17

		local var_63_0 = {
			zh = 1,
			ja = 1.166
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play424111016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1094"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.actorSpriteComps1094 == nil then
				arg_63_1.var_.actorSpriteComps1094 = var_66_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_2 = 0.2

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.actorSpriteComps1094 then
					for iter_66_0, iter_66_1 in pairs(arg_63_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_66_1 then
							if arg_63_1.isInRecall_ then
								local var_66_4 = Mathf.Lerp(iter_66_1.color.r, arg_63_1.hightColor1.r, var_66_3)
								local var_66_5 = Mathf.Lerp(iter_66_1.color.g, arg_63_1.hightColor1.g, var_66_3)
								local var_66_6 = Mathf.Lerp(iter_66_1.color.b, arg_63_1.hightColor1.b, var_66_3)

								iter_66_1.color = Color.New(var_66_4, var_66_5, var_66_6)
							else
								local var_66_7 = Mathf.Lerp(iter_66_1.color.r, 1, var_66_3)

								iter_66_1.color = Color.New(var_66_7, var_66_7, var_66_7)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.actorSpriteComps1094 then
				for iter_66_2, iter_66_3 in pairs(arg_63_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_66_3 then
						if arg_63_1.isInRecall_ then
							iter_66_3.color = arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_66_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_63_1.var_.actorSpriteComps1094 = nil
			end

			local var_66_8 = arg_63_1.actors_["1094"].transform
			local var_66_9 = 0

			if var_66_9 < arg_63_1.time_ and arg_63_1.time_ <= var_66_9 + arg_66_0 then
				arg_63_1.var_.moveOldPos1094 = var_66_8.localPosition
				var_66_8.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("1094", 3)

				local var_66_10 = var_66_8.childCount

				for iter_66_4 = 0, var_66_10 - 1 do
					local var_66_11 = var_66_8:GetChild(iter_66_4)

					if var_66_11.name == "split_1" or not string.find(var_66_11.name, "split") then
						var_66_11.gameObject:SetActive(true)
					else
						var_66_11.gameObject:SetActive(false)
					end
				end
			end

			local var_66_12 = 0.001

			if var_66_9 <= arg_63_1.time_ and arg_63_1.time_ < var_66_9 + var_66_12 then
				local var_66_13 = (arg_63_1.time_ - var_66_9) / var_66_12
				local var_66_14 = Vector3.New(0, -335, -230)

				var_66_8.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1094, var_66_14, var_66_13)
			end

			if arg_63_1.time_ >= var_66_9 + var_66_12 and arg_63_1.time_ < var_66_9 + var_66_12 + arg_66_0 then
				var_66_8.localPosition = Vector3.New(0, -335, -230)
			end

			local var_66_15 = arg_63_1.actors_["1094"]
			local var_66_16 = 0

			if var_66_16 < arg_63_1.time_ and arg_63_1.time_ <= var_66_16 + arg_66_0 then
				local var_66_17 = var_66_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_66_17 then
					arg_63_1.var_.alphaOldValue1094 = var_66_17.alpha
					arg_63_1.var_.characterEffect1094 = var_66_17
				end

				arg_63_1.var_.alphaOldValue1094 = 0
			end

			local var_66_18 = 0.5

			if var_66_16 <= arg_63_1.time_ and arg_63_1.time_ < var_66_16 + var_66_18 then
				local var_66_19 = (arg_63_1.time_ - var_66_16) / var_66_18
				local var_66_20 = Mathf.Lerp(arg_63_1.var_.alphaOldValue1094, 1, var_66_19)

				if arg_63_1.var_.characterEffect1094 then
					arg_63_1.var_.characterEffect1094.alpha = var_66_20
				end
			end

			if arg_63_1.time_ >= var_66_16 + var_66_18 and arg_63_1.time_ < var_66_16 + var_66_18 + arg_66_0 and arg_63_1.var_.characterEffect1094 then
				arg_63_1.var_.characterEffect1094.alpha = 1
			end

			local var_66_21 = 0
			local var_66_22 = 0.075

			if var_66_21 < arg_63_1.time_ and arg_63_1.time_ <= var_66_21 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_23 = arg_63_1:FormatText(StoryNameCfg[181].name)

				arg_63_1.leftNameTxt_.text = var_66_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_24 = arg_63_1:GetWordFromCfg(424111015)
				local var_66_25 = arg_63_1:FormatText(var_66_24.content)

				arg_63_1.text_.text = var_66_25

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_26 = 3
				local var_66_27 = utf8.len(var_66_25)
				local var_66_28 = var_66_26 <= 0 and var_66_22 or var_66_22 * (var_66_27 / var_66_26)

				if var_66_28 > 0 and var_66_22 < var_66_28 then
					arg_63_1.talkMaxDuration = var_66_28

					if var_66_28 + var_66_21 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_28 + var_66_21
					end
				end

				arg_63_1.text_.text = var_66_25
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111015", "story_v_out_424111.awb") ~= 0 then
					local var_66_29 = manager.audio:GetVoiceLength("story_v_out_424111", "424111015", "story_v_out_424111.awb") / 1000

					if var_66_29 + var_66_21 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_29 + var_66_21
					end

					if var_66_24.prefab_name ~= "" and arg_63_1.actors_[var_66_24.prefab_name] ~= nil then
						local var_66_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_24.prefab_name].transform, "story_v_out_424111", "424111015", "story_v_out_424111.awb")

						arg_63_1:RecordAudio("424111015", var_66_30)
						arg_63_1:RecordAudio("424111015", var_66_30)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_424111", "424111015", "story_v_out_424111.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_424111", "424111015", "story_v_out_424111.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_31 = math.max(var_66_22, arg_63_1.talkMaxDuration)

			if var_66_21 <= arg_63_1.time_ and arg_63_1.time_ < var_66_21 + var_66_31 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_21) / var_66_31

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_21 + var_66_31 and arg_63_1.time_ < var_66_21 + var_66_31 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play424111016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 424111016
		arg_67_1.duration_ = 1.8

		local var_67_0 = {
			zh = 1.8,
			ja = 1.7
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
				arg_67_0:Play424111017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1094"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.actorSpriteComps1094 == nil then
				arg_67_1.var_.actorSpriteComps1094 = var_70_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_2 = 0.2

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.actorSpriteComps1094 then
					for iter_70_0, iter_70_1 in pairs(arg_67_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.actorSpriteComps1094 then
				for iter_70_2, iter_70_3 in pairs(arg_67_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_70_3 then
						if arg_67_1.isInRecall_ then
							iter_70_3.color = arg_67_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_70_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_67_1.var_.actorSpriteComps1094 = nil
			end

			local var_70_8 = 0
			local var_70_9 = 0.2

			if var_70_8 < arg_67_1.time_ and arg_67_1.time_ <= var_70_8 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_10 = arg_67_1:FormatText(StoryNameCfg[177].name)

				arg_67_1.leftNameTxt_.text = var_70_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_11 = arg_67_1:GetWordFromCfg(424111016)
				local var_70_12 = arg_67_1:FormatText(var_70_11.content)

				arg_67_1.text_.text = var_70_12

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_13 = 8
				local var_70_14 = utf8.len(var_70_12)
				local var_70_15 = var_70_13 <= 0 and var_70_9 or var_70_9 * (var_70_14 / var_70_13)

				if var_70_15 > 0 and var_70_9 < var_70_15 then
					arg_67_1.talkMaxDuration = var_70_15

					if var_70_15 + var_70_8 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_15 + var_70_8
					end
				end

				arg_67_1.text_.text = var_70_12
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111016", "story_v_out_424111.awb") ~= 0 then
					local var_70_16 = manager.audio:GetVoiceLength("story_v_out_424111", "424111016", "story_v_out_424111.awb") / 1000

					if var_70_16 + var_70_8 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_16 + var_70_8
					end

					if var_70_11.prefab_name ~= "" and arg_67_1.actors_[var_70_11.prefab_name] ~= nil then
						local var_70_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_11.prefab_name].transform, "story_v_out_424111", "424111016", "story_v_out_424111.awb")

						arg_67_1:RecordAudio("424111016", var_70_17)
						arg_67_1:RecordAudio("424111016", var_70_17)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_424111", "424111016", "story_v_out_424111.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_424111", "424111016", "story_v_out_424111.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_18 = math.max(var_70_9, arg_67_1.talkMaxDuration)

			if var_70_8 <= arg_67_1.time_ and arg_67_1.time_ < var_70_8 + var_70_18 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_8) / var_70_18

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_8 + var_70_18 and arg_67_1.time_ < var_70_8 + var_70_18 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play424111017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 424111017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play424111018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1094"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos1094 = var_74_0.localPosition
				var_74_0.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("1094", 7)

				local var_74_2 = var_74_0.childCount

				for iter_74_0 = 0, var_74_2 - 1 do
					local var_74_3 = var_74_0:GetChild(iter_74_0)

					if var_74_3.name == "" or not string.find(var_74_3.name, "split") then
						var_74_3.gameObject:SetActive(true)
					else
						var_74_3.gameObject:SetActive(false)
					end
				end
			end

			local var_74_4 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_4 then
				local var_74_5 = (arg_71_1.time_ - var_74_1) / var_74_4
				local var_74_6 = Vector3.New(0, -2000, 0)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1094, var_74_6, var_74_5)
			end

			if arg_71_1.time_ >= var_74_1 + var_74_4 and arg_71_1.time_ < var_74_1 + var_74_4 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_74_7 = 0
			local var_74_8 = 0.3

			if var_74_7 < arg_71_1.time_ and arg_71_1.time_ <= var_74_7 + arg_74_0 then
				local var_74_9 = "play"
				local var_74_10 = "music"

				arg_71_1:AudioAction(var_74_9, var_74_10, "ui_battle", "ui_battle_stopbgm", "")

				local var_74_11 = ""
				local var_74_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_74_12 ~= "" then
					if arg_71_1.bgmTxt_.text ~= var_74_12 and arg_71_1.bgmTxt_.text ~= "" then
						if arg_71_1.bgmTxt2_.text ~= "" then
							arg_71_1.bgmTxt_.text = arg_71_1.bgmTxt2_.text
						end

						arg_71_1.bgmTxt2_.text = var_74_12

						arg_71_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_71_1.bgmTxt_.text = var_74_12
						arg_71_1.bgmTxt2_.text = var_74_12
					end

					if arg_71_1.bgmTimer then
						arg_71_1.bgmTimer:Stop()

						arg_71_1.bgmTimer = nil
					end

					if arg_71_1.settingData.show_music_name == 1 then
						arg_71_1.musicController:SetSelectedState("show")
						arg_71_1.musicAnimator_:Play("open", 0, 0)

						if arg_71_1.settingData.music_time ~= 0 then
							arg_71_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_71_1.settingData.music_time), function()
								if arg_71_1 == nil or isNil(arg_71_1.bgmTxt_) then
									return
								end

								arg_71_1.musicController:SetSelectedState("hide")
								arg_71_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_74_13 = 0.35
			local var_74_14 = 1

			if var_74_13 < arg_71_1.time_ and arg_71_1.time_ <= var_74_13 + arg_74_0 then
				local var_74_15 = "play"
				local var_74_16 = "music"

				arg_71_1:AudioAction(var_74_15, var_74_16, "bgm_activity_4_6_story_battle", "bgm_activity_4_6_story_battle", "bgm_activity_4_6_story_battle.awb")

				local var_74_17 = ""
				local var_74_18 = manager.audio:GetAudioName("bgm_activity_4_6_story_battle", "bgm_activity_4_6_story_battle")

				if var_74_18 ~= "" then
					if arg_71_1.bgmTxt_.text ~= var_74_18 and arg_71_1.bgmTxt_.text ~= "" then
						if arg_71_1.bgmTxt2_.text ~= "" then
							arg_71_1.bgmTxt_.text = arg_71_1.bgmTxt2_.text
						end

						arg_71_1.bgmTxt2_.text = var_74_18

						arg_71_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_71_1.bgmTxt_.text = var_74_18
						arg_71_1.bgmTxt2_.text = var_74_18
					end

					if arg_71_1.bgmTimer then
						arg_71_1.bgmTimer:Stop()

						arg_71_1.bgmTimer = nil
					end

					if arg_71_1.settingData.show_music_name == 1 then
						arg_71_1.musicController:SetSelectedState("show")
						arg_71_1.musicAnimator_:Play("open", 0, 0)

						if arg_71_1.settingData.music_time ~= 0 then
							arg_71_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_71_1.settingData.music_time), function()
								if arg_71_1 == nil or isNil(arg_71_1.bgmTxt_) then
									return
								end

								arg_71_1.musicController:SetSelectedState("hide")
								arg_71_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_74_19 = 0
			local var_74_20 = 1.35

			if var_74_19 < arg_71_1.time_ and arg_71_1.time_ <= var_74_19 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_21 = arg_71_1:GetWordFromCfg(424111017)
				local var_74_22 = arg_71_1:FormatText(var_74_21.content)

				arg_71_1.text_.text = var_74_22

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_23 = 54
				local var_74_24 = utf8.len(var_74_22)
				local var_74_25 = var_74_23 <= 0 and var_74_20 or var_74_20 * (var_74_24 / var_74_23)

				if var_74_25 > 0 and var_74_20 < var_74_25 then
					arg_71_1.talkMaxDuration = var_74_25

					if var_74_25 + var_74_19 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_25 + var_74_19
					end
				end

				arg_71_1.text_.text = var_74_22
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_26 = math.max(var_74_20, arg_71_1.talkMaxDuration)

			if var_74_19 <= arg_71_1.time_ and arg_71_1.time_ < var_74_19 + var_74_26 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_19) / var_74_26

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_19 + var_74_26 and arg_71_1.time_ < var_74_19 + var_74_26 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
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
	Play424111018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 424111018
		arg_77_1.duration_ = 6.73

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play424111019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = manager.ui.mainCamera.transform
			local var_80_1 = 0.5

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				local var_80_2 = arg_77_1.var_.effectchidunhongzha1
				local var_80_3
				local var_80_4 = var_80_0

				if not var_80_2 then
					var_80_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), var_80_4)
					var_80_2.name = "chidunhongzha1"
					arg_77_1.var_.effectchidunhongzha1 = var_80_2
				else
					var_80_2.transform:SetParent(var_80_4)
				end

				var_80_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_80_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_80_5 = manager.ui.mainCameraCom_
				local var_80_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_80_5.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_80_7 = var_80_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_80_8 = 15
				local var_80_9 = 2 * var_80_8 * Mathf.Tan(var_80_5.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_80_5.aspect
				local var_80_10 = 1
				local var_80_11 = 1.7777777777777777

				if var_80_11 < var_80_5.aspect then
					var_80_10 = var_80_9 / (2 * var_80_8 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_80_11)
				end

				for iter_80_0, iter_80_1 in ipairs(var_80_7) do
					local var_80_12 = iter_80_1.transform.localScale

					iter_80_1.transform.localScale = Vector3.New(var_80_12.x / var_80_6 * var_80_10, var_80_12.y / var_80_6, var_80_12.z)
				end
			end

			local var_80_13 = manager.ui.mainCamera.transform
			local var_80_14 = 2.5

			if var_80_14 < arg_77_1.time_ and arg_77_1.time_ <= var_80_14 + arg_80_0 then
				local var_80_15 = arg_77_1.var_.effectchidunhongzha1

				if var_80_15 then
					Object.Destroy(var_80_15)

					arg_77_1.var_.effectchidunhongzha1 = nil
				end
			end

			local var_80_16 = manager.ui.mainCamera.transform
			local var_80_17 = 0.5

			if var_80_17 < arg_77_1.time_ and arg_77_1.time_ <= var_80_17 + arg_80_0 then
				local var_80_18 = arg_77_1.var_.effectchidunhongzha2
				local var_80_19
				local var_80_20 = var_80_16

				if not var_80_18 then
					var_80_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xishan_violet"), var_80_20)
					var_80_18.name = "chidunhongzha2"
					arg_77_1.var_.effectchidunhongzha2 = var_80_18
				else
					var_80_18.transform:SetParent(var_80_20)
				end

				var_80_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_80_18.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_80_21 = manager.ui.mainCameraCom_
				local var_80_22 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_80_21.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_80_23 = var_80_18.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_80_24 = 15
				local var_80_25 = 2 * var_80_24 * Mathf.Tan(var_80_21.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_80_21.aspect
				local var_80_26 = 1
				local var_80_27 = 1.7777777777777777

				if var_80_27 < var_80_21.aspect then
					var_80_26 = var_80_25 / (2 * var_80_24 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_80_27)
				end

				for iter_80_2, iter_80_3 in ipairs(var_80_23) do
					local var_80_28 = iter_80_3.transform.localScale

					iter_80_3.transform.localScale = Vector3.New(var_80_28.x / var_80_22 * var_80_26, var_80_28.y / var_80_22, var_80_28.z)
				end
			end

			local var_80_29 = 0

			if var_80_29 < arg_77_1.time_ and arg_77_1.time_ <= var_80_29 + arg_80_0 then
				arg_77_1.allBtn_.enabled = false
			end

			local var_80_30 = 1.83333333333333

			if arg_77_1.time_ >= var_80_29 + var_80_30 and arg_77_1.time_ < var_80_29 + var_80_30 + arg_80_0 then
				arg_77_1.allBtn_.enabled = true
			end

			local var_80_31 = 0.1
			local var_80_32 = 1

			if var_80_31 < arg_77_1.time_ and arg_77_1.time_ <= var_80_31 + arg_80_0 then
				local var_80_33 = "play"
				local var_80_34 = "effect"

				arg_77_1:AudioAction(var_80_33, var_80_34, "se_story_16", "se_story_16_energy02", "")
			end

			local var_80_35 = "ST0117"

			if arg_77_1.bgs_[var_80_35] == nil then
				local var_80_36 = Object.Instantiate(arg_77_1.paintGo_)

				var_80_36:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_80_35)
				var_80_36.name = var_80_35
				var_80_36.transform.parent = arg_77_1.stage_.transform
				var_80_36.transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.bgs_[var_80_35] = var_80_36
			end

			local var_80_37 = 0.5

			if var_80_37 < arg_77_1.time_ and arg_77_1.time_ <= var_80_37 + arg_80_0 then
				local var_80_38 = manager.ui.mainCamera.transform.localPosition
				local var_80_39 = Vector3.New(0, 0, 10) + Vector3.New(var_80_38.x, var_80_38.y, 0)
				local var_80_40 = arg_77_1.bgs_.ST0117

				var_80_40.transform.localPosition = var_80_39
				var_80_40.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_80_41 = var_80_40:GetComponent("SpriteRenderer")

				if var_80_41 and var_80_41.sprite then
					local var_80_42 = (var_80_40.transform.localPosition - var_80_38).z
					local var_80_43 = manager.ui.mainCameraCom_
					local var_80_44 = 2 * var_80_42 * Mathf.Tan(var_80_43.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_80_45 = var_80_44 * var_80_43.aspect
					local var_80_46 = var_80_41.sprite.bounds.size.x
					local var_80_47 = var_80_41.sprite.bounds.size.y
					local var_80_48 = var_80_45 / var_80_46
					local var_80_49 = var_80_44 / var_80_47
					local var_80_50 = var_80_49 < var_80_48 and var_80_48 or var_80_49

					var_80_40.transform.localScale = Vector3.New(var_80_50, var_80_50, 0)
				end

				for iter_80_4, iter_80_5 in pairs(arg_77_1.bgs_) do
					if iter_80_4 ~= "ST0117" then
						iter_80_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_51 = 1.73333333333333
			local var_80_52 = 1.45

			if var_80_51 < arg_77_1.time_ and arg_77_1.time_ <= var_80_51 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_53 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_53:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_54 = arg_77_1:GetWordFromCfg(424111018)
				local var_80_55 = arg_77_1:FormatText(var_80_54.content)

				arg_77_1.text_.text = var_80_55

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_56 = 58
				local var_80_57 = utf8.len(var_80_55)
				local var_80_58 = var_80_56 <= 0 and var_80_52 or var_80_52 * (var_80_57 / var_80_56)

				if var_80_58 > 0 and var_80_52 < var_80_58 then
					arg_77_1.talkMaxDuration = var_80_58
					var_80_51 = var_80_51 + 0.3

					if var_80_58 + var_80_51 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_58 + var_80_51
					end
				end

				arg_77_1.text_.text = var_80_55
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_59 = var_80_51 + 0.3
			local var_80_60 = math.max(var_80_52, arg_77_1.talkMaxDuration)

			if var_80_59 <= arg_77_1.time_ and arg_77_1.time_ < var_80_59 + var_80_60 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_59) / var_80_60

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_59 + var_80_60 and arg_77_1.time_ < var_80_59 + var_80_60 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 25,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/LeftRight_Shake",
				duration = 1.5,
				amplitudeGain = 0.8,
				startTime = 0.733333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play424111019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 424111019
		arg_83_1.duration_ = 9

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play424111020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 4

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.allBtn_.enabled = false
			end

			local var_86_1 = 0.3

			if arg_83_1.time_ >= var_86_0 + var_86_1 and arg_83_1.time_ < var_86_0 + var_86_1 + arg_86_0 then
				arg_83_1.allBtn_.enabled = true
			end

			local var_86_2 = 0

			if var_86_2 < arg_83_1.time_ and arg_83_1.time_ <= var_86_2 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_3 = 2

			if var_86_2 <= arg_83_1.time_ and arg_83_1.time_ < var_86_2 + var_86_3 then
				local var_86_4 = (arg_83_1.time_ - var_86_2) / var_86_3
				local var_86_5 = Color.New(0, 0, 0)

				var_86_5.a = Mathf.Lerp(0, 1, var_86_4)
				arg_83_1.mask_.color = var_86_5
			end

			if arg_83_1.time_ >= var_86_2 + var_86_3 and arg_83_1.time_ < var_86_2 + var_86_3 + arg_86_0 then
				local var_86_6 = Color.New(0, 0, 0)

				var_86_6.a = 1
				arg_83_1.mask_.color = var_86_6
			end

			local var_86_7 = 2

			if var_86_7 < arg_83_1.time_ and arg_83_1.time_ <= var_86_7 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_8 = 2

			if var_86_7 <= arg_83_1.time_ and arg_83_1.time_ < var_86_7 + var_86_8 then
				local var_86_9 = (arg_83_1.time_ - var_86_7) / var_86_8
				local var_86_10 = Color.New(0, 0, 0)

				var_86_10.a = Mathf.Lerp(1, 0, var_86_9)
				arg_83_1.mask_.color = var_86_10
			end

			if arg_83_1.time_ >= var_86_7 + var_86_8 and arg_83_1.time_ < var_86_7 + var_86_8 + arg_86_0 then
				local var_86_11 = Color.New(0, 0, 0)
				local var_86_12 = 0

				arg_83_1.mask_.enabled = false
				var_86_11.a = var_86_12
				arg_83_1.mask_.color = var_86_11
			end

			local var_86_13 = 0.233333333333333
			local var_86_14 = 1

			if var_86_13 < arg_83_1.time_ and arg_83_1.time_ <= var_86_13 + arg_86_0 then
				local var_86_15 = "stop"
				local var_86_16 = "effect"

				arg_83_1:AudioAction(var_86_15, var_86_16, "se_story_side_1095", "se_story_side_1095_amb_forest_night_nowater", "")
			end

			local var_86_17 = 1.63333333333333
			local var_86_18 = 1

			if var_86_17 < arg_83_1.time_ and arg_83_1.time_ <= var_86_17 + arg_86_0 then
				local var_86_19 = "play"
				local var_86_20 = "effect"

				arg_83_1:AudioAction(var_86_19, var_86_20, "se_story_145", "se_story_145_amb_drone", "")
			end

			local var_86_21 = manager.ui.mainCamera.transform
			local var_86_22 = 2

			if var_86_22 < arg_83_1.time_ and arg_83_1.time_ <= var_86_22 + arg_86_0 then
				local var_86_23 = arg_83_1.var_.effectchidunhongzha2

				if var_86_23 then
					Object.Destroy(var_86_23)

					arg_83_1.var_.effectchidunhongzha2 = nil
				end
			end

			if arg_83_1.frameCnt_ <= 1 then
				arg_83_1.dialog_:SetActive(false)
			end

			local var_86_24 = 4
			local var_86_25 = 0.95

			if var_86_24 < arg_83_1.time_ and arg_83_1.time_ <= var_86_24 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0

				arg_83_1.dialog_:SetActive(true)

				arg_83_1.dialogCg_.alpha = 0

				local var_86_26 = LeanTween.value(arg_83_1.dialog_, 0, 1, 0.3)

				var_86_26:setOnUpdate(LuaHelper.FloatAction(function(arg_87_0)
					arg_83_1.dialogCg_.alpha = arg_87_0
				end))
				var_86_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_83_1.dialog_)
					var_86_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_83_1.duration_ = arg_83_1.duration_ + 0.3

				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_27 = arg_83_1:GetWordFromCfg(424111019)
				local var_86_28 = arg_83_1:FormatText(var_86_27.content)

				arg_83_1.text_.text = var_86_28

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_29 = 29
				local var_86_30 = utf8.len(var_86_28)
				local var_86_31 = var_86_29 <= 0 and var_86_25 or var_86_25 * (var_86_30 / var_86_29)

				if var_86_31 > 0 and var_86_25 < var_86_31 then
					arg_83_1.talkMaxDuration = var_86_31
					var_86_24 = var_86_24 + 0.3

					if var_86_31 + var_86_24 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_31 + var_86_24
					end
				end

				arg_83_1.text_.text = var_86_28
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_32 = var_86_24 + 0.3
			local var_86_33 = math.max(var_86_25, arg_83_1.talkMaxDuration)

			if var_86_32 <= arg_83_1.time_ and arg_83_1.time_ < var_86_32 + var_86_33 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_32) / var_86_33

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_32 + var_86_33 and arg_83_1.time_ < var_86_32 + var_86_33 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play424111020 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 424111020
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play424111021(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 1.375

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_2 = arg_89_1:GetWordFromCfg(424111020)
				local var_92_3 = arg_89_1:FormatText(var_92_2.content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 55
				local var_92_5 = utf8.len(var_92_3)
				local var_92_6 = var_92_4 <= 0 and var_92_1 or var_92_1 * (var_92_5 / var_92_4)

				if var_92_6 > 0 and var_92_1 < var_92_6 then
					arg_89_1.talkMaxDuration = var_92_6

					if var_92_6 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_7 and arg_89_1.time_ < var_92_0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play424111021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 424111021
		arg_93_1.duration_ = 4.27

		local var_93_0 = {
			zh = 2.166,
			ja = 4.266
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
				arg_93_0:Play424111022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1094"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps1094 == nil then
				arg_93_1.var_.actorSpriteComps1094 = var_96_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_2 = 0.2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.actorSpriteComps1094 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps1094 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_96_3 then
						if arg_93_1.isInRecall_ then
							iter_96_3.color = arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_96_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps1094 = nil
			end

			local var_96_8 = arg_93_1.actors_["1094"].transform
			local var_96_9 = 0

			if var_96_9 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 then
				arg_93_1.var_.moveOldPos1094 = var_96_8.localPosition
				var_96_8.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1094", 3)

				local var_96_10 = var_96_8.childCount

				for iter_96_4 = 0, var_96_10 - 1 do
					local var_96_11 = var_96_8:GetChild(iter_96_4)

					if var_96_11.name == "split_3" then
						var_96_11:SetAsLastSibling()
						var_96_11.gameObject:SetActive(true)

						arg_93_1.var_.actorSpriteSplit1094 = var_96_11.gameObject:GetComponent(typeof(Image))

						arg_93_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_96_12 = 0.001

			if var_96_9 <= arg_93_1.time_ and arg_93_1.time_ < var_96_9 + var_96_12 then
				local var_96_13 = (arg_93_1.time_ - var_96_9) / var_96_12
				local var_96_14 = Vector3.New(0, -335, -230)

				var_96_8.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1094, var_96_14, var_96_13)

				if arg_93_1.var_.actorSpriteSplit1094 ~= nil then
					arg_93_1.var_.actorSpriteSplit1094:SetAlpha(var_96_13)
				end
			end

			if arg_93_1.time_ >= var_96_9 + var_96_12 and arg_93_1.time_ < var_96_9 + var_96_12 + arg_96_0 then
				var_96_8.localPosition = Vector3.New(0, -335, -230)

				if arg_93_1.var_.actorSpriteSplit1094 ~= nil then
					arg_93_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_96_15 = 0
			local var_96_16 = 0.25

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_17 = arg_93_1:FormatText(StoryNameCfg[181].name)

				arg_93_1.leftNameTxt_.text = var_96_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_18 = arg_93_1:GetWordFromCfg(424111021)
				local var_96_19 = arg_93_1:FormatText(var_96_18.content)

				arg_93_1.text_.text = var_96_19

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_20 = 10
				local var_96_21 = utf8.len(var_96_19)
				local var_96_22 = var_96_20 <= 0 and var_96_16 or var_96_16 * (var_96_21 / var_96_20)

				if var_96_22 > 0 and var_96_16 < var_96_22 then
					arg_93_1.talkMaxDuration = var_96_22

					if var_96_22 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_22 + var_96_15
					end
				end

				arg_93_1.text_.text = var_96_19
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111021", "story_v_out_424111.awb") ~= 0 then
					local var_96_23 = manager.audio:GetVoiceLength("story_v_out_424111", "424111021", "story_v_out_424111.awb") / 1000

					if var_96_23 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_23 + var_96_15
					end

					if var_96_18.prefab_name ~= "" and arg_93_1.actors_[var_96_18.prefab_name] ~= nil then
						local var_96_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_18.prefab_name].transform, "story_v_out_424111", "424111021", "story_v_out_424111.awb")

						arg_93_1:RecordAudio("424111021", var_96_24)
						arg_93_1:RecordAudio("424111021", var_96_24)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_424111", "424111021", "story_v_out_424111.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_424111", "424111021", "story_v_out_424111.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_25 = math.max(var_96_16, arg_93_1.talkMaxDuration)

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_25 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_15) / var_96_25

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_15 + var_96_25 and arg_93_1.time_ < var_96_15 + var_96_25 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play424111022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 424111022
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play424111023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1094"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps1094 == nil then
				arg_97_1.var_.actorSpriteComps1094 = var_100_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_2 = 0.2

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.actorSpriteComps1094 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps1094 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_100_3 then
						if arg_97_1.isInRecall_ then
							iter_100_3.color = arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_100_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps1094 = nil
			end

			local var_100_8 = arg_97_1.actors_["1094"].transform
			local var_100_9 = 0

			if var_100_9 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 then
				arg_97_1.var_.moveOldPos1094 = var_100_8.localPosition
				var_100_8.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1094", 7)

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

				var_100_8.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1094, var_100_14, var_100_13)
			end

			if arg_97_1.time_ >= var_100_9 + var_100_12 and arg_97_1.time_ < var_100_9 + var_100_12 + arg_100_0 then
				var_100_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_100_15 = 0.034
			local var_100_16 = 1

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 then
				local var_100_17 = "play"
				local var_100_18 = "effect"

				arg_97_1:AudioAction(var_100_17, var_100_18, "se_story_145", "se_story_145_summon_launcher", "")
			end

			local var_100_19 = 0
			local var_100_20 = 1.15

			if var_100_19 < arg_97_1.time_ and arg_97_1.time_ <= var_100_19 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_21 = arg_97_1:GetWordFromCfg(424111022)
				local var_100_22 = arg_97_1:FormatText(var_100_21.content)

				arg_97_1.text_.text = var_100_22

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_23 = 46
				local var_100_24 = utf8.len(var_100_22)
				local var_100_25 = var_100_23 <= 0 and var_100_20 or var_100_20 * (var_100_24 / var_100_23)

				if var_100_25 > 0 and var_100_20 < var_100_25 then
					arg_97_1.talkMaxDuration = var_100_25

					if var_100_25 + var_100_19 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_25 + var_100_19
					end
				end

				arg_97_1.text_.text = var_100_22
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_26 = math.max(var_100_20, arg_97_1.talkMaxDuration)

			if var_100_19 <= arg_97_1.time_ and arg_97_1.time_ < var_100_19 + var_100_26 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_19) / var_100_26

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_19 + var_100_26 and arg_97_1.time_ < var_100_19 + var_100_26 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
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
	Play424111023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 424111023
		arg_101_1.duration_ = 6

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play424111024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = manager.ui.mainCamera.transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				local var_104_2 = arg_101_1.var_.effectshennengdanyu46
				local var_104_3
				local var_104_4 = var_104_0

				if not var_104_2 then
					var_104_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rockfall"), var_104_4)
					var_104_2.name = "shennengdanyu46"
					arg_101_1.var_.effectshennengdanyu46 = var_104_2
				else
					var_104_2.transform:SetParent(var_104_4)
				end

				var_104_2.transform.localPosition = Vector3.New(0, 0, -0.2)
				var_104_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_104_5 = manager.ui.mainCameraCom_
				local var_104_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_104_5.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_104_7 = var_104_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_104_8 = 15
				local var_104_9 = 2 * var_104_8 * Mathf.Tan(var_104_5.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_104_5.aspect
				local var_104_10 = 1
				local var_104_11 = 1.7777777777777777

				if var_104_11 < var_104_5.aspect then
					var_104_10 = var_104_9 / (2 * var_104_8 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_104_11)
				end

				for iter_104_0, iter_104_1 in ipairs(var_104_7) do
					local var_104_12 = iter_104_1.transform.localScale

					iter_104_1.transform.localScale = Vector3.New(var_104_12.x / var_104_6 * var_104_10, var_104_12.y / var_104_6, var_104_12.z)
				end
			end

			local var_104_13 = manager.ui.mainCamera.transform
			local var_104_14 = 0

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1.var_.shakeOldPos = var_104_13.localPosition
			end

			local var_104_15 = 1.5

			if var_104_14 <= arg_101_1.time_ and arg_101_1.time_ < var_104_14 + var_104_15 then
				local var_104_16 = (arg_101_1.time_ - var_104_14) / 0.066
				local var_104_17, var_104_18 = math.modf(var_104_16)

				var_104_13.localPosition = Vector3.New(var_104_18 * 0.13, var_104_18 * 0.13, var_104_18 * 0.13) + arg_101_1.var_.shakeOldPos
			end

			if arg_101_1.time_ >= var_104_14 + var_104_15 and arg_101_1.time_ < var_104_14 + var_104_15 + arg_104_0 then
				var_104_13.localPosition = arg_101_1.var_.shakeOldPos
			end

			local var_104_19 = manager.ui.mainCamera.transform
			local var_104_20 = 0.2

			if var_104_20 < arg_101_1.time_ and arg_101_1.time_ <= var_104_20 + arg_104_0 then
				local var_104_21 = arg_101_1.var_.effectzisehuoyan8
				local var_104_22
				local var_104_23 = var_104_19

				if not var_104_21 then
					var_104_21 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue4"), var_104_23)
					var_104_21.name = "zisehuoyan8"
					arg_101_1.var_.effectzisehuoyan8 = var_104_21
				else
					var_104_21.transform:SetParent(var_104_23)
				end

				var_104_21.transform.localPosition = Vector3.New(0.37, 1.21, -1)
				var_104_21.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_104_24 = manager.ui.mainCameraCom_
				local var_104_25 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_104_24.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_104_26 = var_104_21.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_104_27 = 15
				local var_104_28 = 2 * var_104_27 * Mathf.Tan(var_104_24.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_104_24.aspect
				local var_104_29 = 1
				local var_104_30 = 1.7777777777777777

				if var_104_30 < var_104_24.aspect then
					var_104_29 = var_104_28 / (2 * var_104_27 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_104_30)
				end

				for iter_104_2, iter_104_3 in ipairs(var_104_26) do
					local var_104_31 = iter_104_3.transform.localScale

					iter_104_3.transform.localScale = Vector3.New(var_104_31.x / var_104_25 * var_104_29, var_104_31.y / var_104_25, var_104_31.z)
				end
			end

			local var_104_32 = manager.ui.mainCamera.transform
			local var_104_33 = 0.5

			if var_104_33 < arg_101_1.time_ and arg_101_1.time_ <= var_104_33 + arg_104_0 then
				local var_104_34 = arg_101_1.var_.effectzisehuoyan9
				local var_104_35
				local var_104_36 = var_104_32

				if not var_104_34 then
					var_104_34 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue4"), var_104_36)
					var_104_34.name = "zisehuoyan9"
					arg_101_1.var_.effectzisehuoyan9 = var_104_34
				else
					var_104_34.transform:SetParent(var_104_36)
				end

				var_104_34.transform.localPosition = Vector3.New(1.09, 1, -1.5)
				var_104_34.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_104_37 = manager.ui.mainCameraCom_
				local var_104_38 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_104_37.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_104_39 = var_104_34.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_104_40 = 15
				local var_104_41 = 2 * var_104_40 * Mathf.Tan(var_104_37.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_104_37.aspect
				local var_104_42 = 1
				local var_104_43 = 1.7777777777777777

				if var_104_43 < var_104_37.aspect then
					var_104_42 = var_104_41 / (2 * var_104_40 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_104_43)
				end

				for iter_104_4, iter_104_5 in ipairs(var_104_39) do
					local var_104_44 = iter_104_5.transform.localScale

					iter_104_5.transform.localScale = Vector3.New(var_104_44.x / var_104_38 * var_104_42, var_104_44.y / var_104_38, var_104_44.z)
				end
			end

			local var_104_45 = manager.ui.mainCamera.transform
			local var_104_46 = 0

			if var_104_46 < arg_101_1.time_ and arg_101_1.time_ <= var_104_46 + arg_104_0 then
				local var_104_47 = arg_101_1.var_.effectzisehuoyan10
				local var_104_48
				local var_104_49 = var_104_45

				if not var_104_47 then
					var_104_47 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue4"), var_104_49)
					var_104_47.name = "zisehuoyan10"
					arg_101_1.var_.effectzisehuoyan10 = var_104_47
				else
					var_104_47.transform:SetParent(var_104_49)
				end

				var_104_47.transform.localPosition = Vector3.New(-0.56, -0.48, -0.8)
				var_104_47.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_104_50 = manager.ui.mainCameraCom_
				local var_104_51 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_104_50.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_104_52 = var_104_47.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_104_53 = 15
				local var_104_54 = 2 * var_104_53 * Mathf.Tan(var_104_50.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_104_50.aspect
				local var_104_55 = 1
				local var_104_56 = 1.7777777777777777

				if var_104_56 < var_104_50.aspect then
					var_104_55 = var_104_54 / (2 * var_104_53 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_104_56)
				end

				for iter_104_6, iter_104_7 in ipairs(var_104_52) do
					local var_104_57 = iter_104_7.transform.localScale

					iter_104_7.transform.localScale = Vector3.New(var_104_57.x / var_104_51 * var_104_55, var_104_57.y / var_104_51, var_104_57.z)
				end
			end

			local var_104_58 = manager.ui.mainCamera.transform
			local var_104_59 = 2.66666666666667

			if var_104_59 < arg_101_1.time_ and arg_101_1.time_ <= var_104_59 + arg_104_0 then
				local var_104_60 = arg_101_1.var_.effectzisehuoyan8

				if var_104_60 then
					Object.Destroy(var_104_60)

					arg_101_1.var_.effectzisehuoyan8 = nil
				end
			end

			local var_104_61 = manager.ui.mainCamera.transform
			local var_104_62 = 2.66666666666667

			if var_104_62 < arg_101_1.time_ and arg_101_1.time_ <= var_104_62 + arg_104_0 then
				local var_104_63 = arg_101_1.var_.effectzisehuoyan9

				if var_104_63 then
					Object.Destroy(var_104_63)

					arg_101_1.var_.effectzisehuoyan9 = nil
				end
			end

			local var_104_64 = manager.ui.mainCamera.transform
			local var_104_65 = 2.66666666666667

			if var_104_65 < arg_101_1.time_ and arg_101_1.time_ <= var_104_65 + arg_104_0 then
				local var_104_66 = arg_101_1.var_.effectzisehuoyan10

				if var_104_66 then
					Object.Destroy(var_104_66)

					arg_101_1.var_.effectzisehuoyan10 = nil
				end
			end

			local var_104_67 = 0

			if var_104_67 < arg_101_1.time_ and arg_101_1.time_ <= var_104_67 + arg_104_0 then
				arg_101_1.allBtn_.enabled = false
			end

			local var_104_68 = 1.5

			if arg_101_1.time_ >= var_104_67 + var_104_68 and arg_101_1.time_ < var_104_67 + var_104_68 + arg_104_0 then
				arg_101_1.allBtn_.enabled = true
			end

			local var_104_69 = 0
			local var_104_70 = 1

			if var_104_69 < arg_101_1.time_ and arg_101_1.time_ <= var_104_69 + arg_104_0 then
				local var_104_71 = "play"
				local var_104_72 = "effect"

				arg_101_1:AudioAction(var_104_71, var_104_72, "se_story_144", "se_story_144_gun_battle02", "")
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_73 = 1
			local var_104_74 = 1.2

			if var_104_73 < arg_101_1.time_ and arg_101_1.time_ <= var_104_73 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_75 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_75:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_75:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_75:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_76 = arg_101_1:GetWordFromCfg(424111023)
				local var_104_77 = arg_101_1:FormatText(var_104_76.content)

				arg_101_1.text_.text = var_104_77

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_78 = 48
				local var_104_79 = utf8.len(var_104_77)
				local var_104_80 = var_104_78 <= 0 and var_104_74 or var_104_74 * (var_104_79 / var_104_78)

				if var_104_80 > 0 and var_104_74 < var_104_80 then
					arg_101_1.talkMaxDuration = var_104_80
					var_104_73 = var_104_73 + 0.3

					if var_104_80 + var_104_73 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_80 + var_104_73
					end
				end

				arg_101_1.text_.text = var_104_77
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_81 = var_104_73 + 0.3
			local var_104_82 = math.max(var_104_74, arg_101_1.talkMaxDuration)

			if var_104_81 <= arg_101_1.time_ and arg_101_1.time_ < var_104_81 + var_104_82 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_81) / var_104_82

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_81 + var_104_82 and arg_101_1.time_ < var_104_81 + var_104_82 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play424111024 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 424111024
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play424111025(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0.7
			local var_110_1 = 1

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				local var_110_2 = "play"
				local var_110_3 = "effect"

				arg_107_1:AudioAction(var_110_2, var_110_3, "se_story_side_1028", "se_story_1028_thunder", "")
			end

			local var_110_4 = 0
			local var_110_5 = 1.15

			if var_110_4 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_6 = arg_107_1:GetWordFromCfg(424111024)
				local var_110_7 = arg_107_1:FormatText(var_110_6.content)

				arg_107_1.text_.text = var_110_7

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_8 = 46
				local var_110_9 = utf8.len(var_110_7)
				local var_110_10 = var_110_8 <= 0 and var_110_5 or var_110_5 * (var_110_9 / var_110_8)

				if var_110_10 > 0 and var_110_5 < var_110_10 then
					arg_107_1.talkMaxDuration = var_110_10

					if var_110_10 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_4
					end
				end

				arg_107_1.text_.text = var_110_7
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_11 = math.max(var_110_5, arg_107_1.talkMaxDuration)

			if var_110_4 <= arg_107_1.time_ and arg_107_1.time_ < var_110_4 + var_110_11 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_4) / var_110_11

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_4 + var_110_11 and arg_107_1.time_ < var_110_4 + var_110_11 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play424111025 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 424111025
		arg_111_1.duration_ = 3.33

		local var_111_0 = {
			zh = 3.233,
			ja = 3.333
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
				arg_111_0:Play424111026(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.25

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[1391].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10155_split_6")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_3 = arg_111_1:GetWordFromCfg(424111025)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 10
				local var_114_6 = utf8.len(var_114_4)
				local var_114_7 = var_114_5 <= 0 and var_114_1 or var_114_1 * (var_114_6 / var_114_5)

				if var_114_7 > 0 and var_114_1 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111025", "story_v_out_424111.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_424111", "424111025", "story_v_out_424111.awb") / 1000

					if var_114_8 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_0
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_out_424111", "424111025", "story_v_out_424111.awb")

						arg_111_1:RecordAudio("424111025", var_114_9)
						arg_111_1:RecordAudio("424111025", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_424111", "424111025", "story_v_out_424111.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_424111", "424111025", "story_v_out_424111.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_10 and arg_111_1.time_ < var_114_0 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play424111026 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 424111026
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play424111027(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["10155"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.actorSpriteComps10155 == nil then
				arg_115_1.var_.actorSpriteComps10155 = var_118_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_2 = 0.2

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.actorSpriteComps10155 then
					for iter_118_0, iter_118_1 in pairs(arg_115_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_118_1 then
							if arg_115_1.isInRecall_ then
								local var_118_4 = Mathf.Lerp(iter_118_1.color.r, arg_115_1.hightColor2.r, var_118_3)
								local var_118_5 = Mathf.Lerp(iter_118_1.color.g, arg_115_1.hightColor2.g, var_118_3)
								local var_118_6 = Mathf.Lerp(iter_118_1.color.b, arg_115_1.hightColor2.b, var_118_3)

								iter_118_1.color = Color.New(var_118_4, var_118_5, var_118_6)
							else
								local var_118_7 = Mathf.Lerp(iter_118_1.color.r, 0.5, var_118_3)

								iter_118_1.color = Color.New(var_118_7, var_118_7, var_118_7)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.actorSpriteComps10155 then
				for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_118_3 then
						if arg_115_1.isInRecall_ then
							iter_118_3.color = arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_118_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps10155 = nil
			end

			local var_118_8 = 0
			local var_118_9 = 0.15

			if var_118_8 < arg_115_1.time_ and arg_115_1.time_ <= var_118_8 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_10 = arg_115_1:FormatText(StoryNameCfg[7].name)

				arg_115_1.leftNameTxt_.text = var_118_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_11 = arg_115_1:GetWordFromCfg(424111026)
				local var_118_12 = arg_115_1:FormatText(var_118_11.content)

				arg_115_1.text_.text = var_118_12

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_13 = 6
				local var_118_14 = utf8.len(var_118_12)
				local var_118_15 = var_118_13 <= 0 and var_118_9 or var_118_9 * (var_118_14 / var_118_13)

				if var_118_15 > 0 and var_118_9 < var_118_15 then
					arg_115_1.talkMaxDuration = var_118_15

					if var_118_15 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_15 + var_118_8
					end
				end

				arg_115_1.text_.text = var_118_12
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_16 = math.max(var_118_9, arg_115_1.talkMaxDuration)

			if var_118_8 <= arg_115_1.time_ and arg_115_1.time_ < var_118_8 + var_118_16 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_8) / var_118_16

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_8 + var_118_16 and arg_115_1.time_ < var_118_8 + var_118_16 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play424111027 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 424111027
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play424111028(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10155"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos10155 = var_122_0.localPosition
				var_122_0.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10155", 7)

				local var_122_2 = var_122_0.childCount

				for iter_122_0 = 0, var_122_2 - 1 do
					local var_122_3 = var_122_0:GetChild(iter_122_0)

					if var_122_3.name == "" or not string.find(var_122_3.name, "split") then
						var_122_3.gameObject:SetActive(true)
					else
						var_122_3.gameObject:SetActive(false)
					end
				end
			end

			local var_122_4 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_4 then
				local var_122_5 = (arg_119_1.time_ - var_122_1) / var_122_4
				local var_122_6 = Vector3.New(0, -2000, 0)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10155, var_122_6, var_122_5)
			end

			if arg_119_1.time_ >= var_122_1 + var_122_4 and arg_119_1.time_ < var_122_1 + var_122_4 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_122_7 = 0
			local var_122_8 = 1.525

			if var_122_7 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_9 = arg_119_1:GetWordFromCfg(424111027)
				local var_122_10 = arg_119_1:FormatText(var_122_9.content)

				arg_119_1.text_.text = var_122_10

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_11 = 61
				local var_122_12 = utf8.len(var_122_10)
				local var_122_13 = var_122_11 <= 0 and var_122_8 or var_122_8 * (var_122_12 / var_122_11)

				if var_122_13 > 0 and var_122_8 < var_122_13 then
					arg_119_1.talkMaxDuration = var_122_13

					if var_122_13 + var_122_7 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_13 + var_122_7
					end
				end

				arg_119_1.text_.text = var_122_10
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_14 = math.max(var_122_8, arg_119_1.talkMaxDuration)

			if var_122_7 <= arg_119_1.time_ and arg_119_1.time_ < var_122_7 + var_122_14 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_7) / var_122_14

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_7 + var_122_14 and arg_119_1.time_ < var_122_7 + var_122_14 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play424111028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 424111028
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play424111029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 1.725

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_2 = arg_123_1:GetWordFromCfg(424111028)
				local var_126_3 = arg_123_1:FormatText(var_126_2.content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 69
				local var_126_5 = utf8.len(var_126_3)
				local var_126_6 = var_126_4 <= 0 and var_126_1 or var_126_1 * (var_126_5 / var_126_4)

				if var_126_6 > 0 and var_126_1 < var_126_6 then
					arg_123_1.talkMaxDuration = var_126_6

					if var_126_6 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_7 and arg_123_1.time_ < var_126_0 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play424111029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 424111029
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play424111030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.525

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[7].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:GetWordFromCfg(424111029)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 21
				local var_130_6 = utf8.len(var_130_4)
				local var_130_7 = var_130_5 <= 0 and var_130_1 or var_130_1 * (var_130_6 / var_130_5)

				if var_130_7 > 0 and var_130_1 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_8 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_8 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_8

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_8 and arg_127_1.time_ < var_130_0 + var_130_8 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play424111030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 424111030
		arg_131_1.duration_ = 1

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play424111031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1094"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps1094 == nil then
				arg_131_1.var_.actorSpriteComps1094 = var_134_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_2 = 0.2

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.actorSpriteComps1094 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps1094 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_134_3 then
						if arg_131_1.isInRecall_ then
							iter_134_3.color = arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_134_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps1094 = nil
			end

			local var_134_8 = arg_131_1.actors_["1094"].transform
			local var_134_9 = 0

			if var_134_9 < arg_131_1.time_ and arg_131_1.time_ <= var_134_9 + arg_134_0 then
				arg_131_1.var_.moveOldPos1094 = var_134_8.localPosition
				var_134_8.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("1094", 3)

				local var_134_10 = var_134_8.childCount

				for iter_134_4 = 0, var_134_10 - 1 do
					local var_134_11 = var_134_8:GetChild(iter_134_4)

					if var_134_11.name == "split_3" then
						var_134_11:SetAsLastSibling()
						var_134_11.gameObject:SetActive(true)

						arg_131_1.var_.actorSpriteSplit1094 = var_134_11.gameObject:GetComponent(typeof(Image))

						arg_131_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_134_12 = 0.001

			if var_134_9 <= arg_131_1.time_ and arg_131_1.time_ < var_134_9 + var_134_12 then
				local var_134_13 = (arg_131_1.time_ - var_134_9) / var_134_12
				local var_134_14 = Vector3.New(0, -335, -230)

				var_134_8.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1094, var_134_14, var_134_13)

				if arg_131_1.var_.actorSpriteSplit1094 ~= nil then
					arg_131_1.var_.actorSpriteSplit1094:SetAlpha(var_134_13)
				end
			end

			if arg_131_1.time_ >= var_134_9 + var_134_12 and arg_131_1.time_ < var_134_9 + var_134_12 + arg_134_0 then
				var_134_8.localPosition = Vector3.New(0, -335, -230)

				if arg_131_1.var_.actorSpriteSplit1094 ~= nil then
					arg_131_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_134_15 = 0
			local var_134_16 = 0.05

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_17 = arg_131_1:FormatText(StoryNameCfg[181].name)

				arg_131_1.leftNameTxt_.text = var_134_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_18 = arg_131_1:GetWordFromCfg(424111030)
				local var_134_19 = arg_131_1:FormatText(var_134_18.content)

				arg_131_1.text_.text = var_134_19

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_20 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111030", "story_v_out_424111.awb") ~= 0 then
					local var_134_23 = manager.audio:GetVoiceLength("story_v_out_424111", "424111030", "story_v_out_424111.awb") / 1000

					if var_134_23 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_23 + var_134_15
					end

					if var_134_18.prefab_name ~= "" and arg_131_1.actors_[var_134_18.prefab_name] ~= nil then
						local var_134_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_18.prefab_name].transform, "story_v_out_424111", "424111030", "story_v_out_424111.awb")

						arg_131_1:RecordAudio("424111030", var_134_24)
						arg_131_1:RecordAudio("424111030", var_134_24)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_424111", "424111030", "story_v_out_424111.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_424111", "424111030", "story_v_out_424111.awb")
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
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play424111031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 424111031
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play424111032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1094"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.actorSpriteComps1094 == nil then
				arg_135_1.var_.actorSpriteComps1094 = var_138_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_2 = 0.2

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.actorSpriteComps1094 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_138_1 then
							if arg_135_1.isInRecall_ then
								local var_138_4 = Mathf.Lerp(iter_138_1.color.r, arg_135_1.hightColor2.r, var_138_3)
								local var_138_5 = Mathf.Lerp(iter_138_1.color.g, arg_135_1.hightColor2.g, var_138_3)
								local var_138_6 = Mathf.Lerp(iter_138_1.color.b, arg_135_1.hightColor2.b, var_138_3)

								iter_138_1.color = Color.New(var_138_4, var_138_5, var_138_6)
							else
								local var_138_7 = Mathf.Lerp(iter_138_1.color.r, 0.5, var_138_3)

								iter_138_1.color = Color.New(var_138_7, var_138_7, var_138_7)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.actorSpriteComps1094 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_138_3 then
						if arg_135_1.isInRecall_ then
							iter_138_3.color = arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_138_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps1094 = nil
			end

			local var_138_8 = arg_135_1.actors_["1094"].transform
			local var_138_9 = 0

			if var_138_9 < arg_135_1.time_ and arg_135_1.time_ <= var_138_9 + arg_138_0 then
				arg_135_1.var_.moveOldPos1094 = var_138_8.localPosition
				var_138_8.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("1094", 7)

				local var_138_10 = var_138_8.childCount

				for iter_138_4 = 0, var_138_10 - 1 do
					local var_138_11 = var_138_8:GetChild(iter_138_4)

					if var_138_11.name == "" or not string.find(var_138_11.name, "split") then
						var_138_11.gameObject:SetActive(true)
					else
						var_138_11.gameObject:SetActive(false)
					end
				end
			end

			local var_138_12 = 0.001

			if var_138_9 <= arg_135_1.time_ and arg_135_1.time_ < var_138_9 + var_138_12 then
				local var_138_13 = (arg_135_1.time_ - var_138_9) / var_138_12
				local var_138_14 = Vector3.New(0, -2000, 0)

				var_138_8.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1094, var_138_14, var_138_13)
			end

			if arg_135_1.time_ >= var_138_9 + var_138_12 and arg_135_1.time_ < var_138_9 + var_138_12 + arg_138_0 then
				var_138_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_138_15 = 0.2
			local var_138_16 = 1

			if var_138_15 < arg_135_1.time_ and arg_135_1.time_ <= var_138_15 + arg_138_0 then
				local var_138_17 = "play"
				local var_138_18 = "effect"

				arg_135_1:AudioAction(var_138_17, var_138_18, "se_story_145", "se_story_145_summon_launcher", "")
			end

			local var_138_19 = 0
			local var_138_20 = 0.3

			if var_138_19 < arg_135_1.time_ and arg_135_1.time_ <= var_138_19 + arg_138_0 then
				local var_138_21 = "play"
				local var_138_22 = "music"

				arg_135_1:AudioAction(var_138_21, var_138_22, "ui_battle", "ui_battle_stopbgm", "")

				local var_138_23 = ""
				local var_138_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_138_24 ~= "" then
					if arg_135_1.bgmTxt_.text ~= var_138_24 and arg_135_1.bgmTxt_.text ~= "" then
						if arg_135_1.bgmTxt2_.text ~= "" then
							arg_135_1.bgmTxt_.text = arg_135_1.bgmTxt2_.text
						end

						arg_135_1.bgmTxt2_.text = var_138_24

						arg_135_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_135_1.bgmTxt_.text = var_138_24
						arg_135_1.bgmTxt2_.text = var_138_24
					end

					if arg_135_1.bgmTimer then
						arg_135_1.bgmTimer:Stop()

						arg_135_1.bgmTimer = nil
					end

					if arg_135_1.settingData.show_music_name == 1 then
						arg_135_1.musicController:SetSelectedState("show")
						arg_135_1.musicAnimator_:Play("open", 0, 0)

						if arg_135_1.settingData.music_time ~= 0 then
							arg_135_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_135_1.settingData.music_time), function()
								if arg_135_1 == nil or isNil(arg_135_1.bgmTxt_) then
									return
								end

								arg_135_1.musicController:SetSelectedState("hide")
								arg_135_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_138_25 = 0
			local var_138_26 = 1.075

			if var_138_25 < arg_135_1.time_ and arg_135_1.time_ <= var_138_25 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_27 = arg_135_1:GetWordFromCfg(424111031)
				local var_138_28 = arg_135_1:FormatText(var_138_27.content)

				arg_135_1.text_.text = var_138_28

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_29 = 43
				local var_138_30 = utf8.len(var_138_28)
				local var_138_31 = var_138_29 <= 0 and var_138_26 or var_138_26 * (var_138_30 / var_138_29)

				if var_138_31 > 0 and var_138_26 < var_138_31 then
					arg_135_1.talkMaxDuration = var_138_31

					if var_138_31 + var_138_25 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_31 + var_138_25
					end
				end

				arg_135_1.text_.text = var_138_28
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_32 = math.max(var_138_26, arg_135_1.talkMaxDuration)

			if var_138_25 <= arg_135_1.time_ and arg_135_1.time_ < var_138_25 + var_138_32 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_25) / var_138_32

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_25 + var_138_32 and arg_135_1.time_ < var_138_25 + var_138_32 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play424111032 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 424111032
		arg_140_1.duration_ = 3

		local var_140_0 = {
			zh = 2.4,
			ja = 3
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play424111033(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1094"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.actorSpriteComps1094 == nil then
				arg_140_1.var_.actorSpriteComps1094 = var_143_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_2 = 0.2

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.actorSpriteComps1094 then
					for iter_143_0, iter_143_1 in pairs(arg_140_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_143_1 then
							if arg_140_1.isInRecall_ then
								local var_143_4 = Mathf.Lerp(iter_143_1.color.r, arg_140_1.hightColor1.r, var_143_3)
								local var_143_5 = Mathf.Lerp(iter_143_1.color.g, arg_140_1.hightColor1.g, var_143_3)
								local var_143_6 = Mathf.Lerp(iter_143_1.color.b, arg_140_1.hightColor1.b, var_143_3)

								iter_143_1.color = Color.New(var_143_4, var_143_5, var_143_6)
							else
								local var_143_7 = Mathf.Lerp(iter_143_1.color.r, 1, var_143_3)

								iter_143_1.color = Color.New(var_143_7, var_143_7, var_143_7)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.actorSpriteComps1094 then
				for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_143_3 then
						if arg_140_1.isInRecall_ then
							iter_143_3.color = arg_140_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_143_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_140_1.var_.actorSpriteComps1094 = nil
			end

			local var_143_8 = arg_140_1.actors_["1094"].transform
			local var_143_9 = 0

			if var_143_9 < arg_140_1.time_ and arg_140_1.time_ <= var_143_9 + arg_143_0 then
				arg_140_1.var_.moveOldPos1094 = var_143_8.localPosition
				var_143_8.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("1094", 3)

				local var_143_10 = var_143_8.childCount

				for iter_143_4 = 0, var_143_10 - 1 do
					local var_143_11 = var_143_8:GetChild(iter_143_4)

					if var_143_11.name == "split_3" or not string.find(var_143_11.name, "split") then
						var_143_11.gameObject:SetActive(true)
					else
						var_143_11.gameObject:SetActive(false)
					end
				end
			end

			local var_143_12 = 0.001

			if var_143_9 <= arg_140_1.time_ and arg_140_1.time_ < var_143_9 + var_143_12 then
				local var_143_13 = (arg_140_1.time_ - var_143_9) / var_143_12
				local var_143_14 = Vector3.New(0, -335, -230)

				var_143_8.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1094, var_143_14, var_143_13)
			end

			if arg_140_1.time_ >= var_143_9 + var_143_12 and arg_140_1.time_ < var_143_9 + var_143_12 + arg_143_0 then
				var_143_8.localPosition = Vector3.New(0, -335, -230)
			end

			local var_143_15 = 0.034
			local var_143_16 = 1

			if var_143_15 < arg_140_1.time_ and arg_140_1.time_ <= var_143_15 + arg_143_0 then
				local var_143_17 = "play"
				local var_143_18 = "music"

				arg_140_1:AudioAction(var_143_17, var_143_18, "bgm_activity_4_6_story_hel", "bgm_activity_4_6_story_hel", "bgm_activity_4_6_story_hel.awb")

				local var_143_19 = ""
				local var_143_20 = manager.audio:GetAudioName("bgm_activity_4_6_story_hel", "bgm_activity_4_6_story_hel")

				if var_143_20 ~= "" then
					if arg_140_1.bgmTxt_.text ~= var_143_20 and arg_140_1.bgmTxt_.text ~= "" then
						if arg_140_1.bgmTxt2_.text ~= "" then
							arg_140_1.bgmTxt_.text = arg_140_1.bgmTxt2_.text
						end

						arg_140_1.bgmTxt2_.text = var_143_20

						arg_140_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_140_1.bgmTxt_.text = var_143_20
						arg_140_1.bgmTxt2_.text = var_143_20
					end

					if arg_140_1.bgmTimer then
						arg_140_1.bgmTimer:Stop()

						arg_140_1.bgmTimer = nil
					end

					if arg_140_1.settingData.show_music_name == 1 then
						arg_140_1.musicController:SetSelectedState("show")
						arg_140_1.musicAnimator_:Play("open", 0, 0)

						if arg_140_1.settingData.music_time ~= 0 then
							arg_140_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_140_1.settingData.music_time), function()
								if arg_140_1 == nil or isNil(arg_140_1.bgmTxt_) then
									return
								end

								arg_140_1.musicController:SetSelectedState("hide")
								arg_140_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_143_21 = 0
			local var_143_22 = 0.225

			if var_143_21 < arg_140_1.time_ and arg_140_1.time_ <= var_143_21 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_23 = arg_140_1:FormatText(StoryNameCfg[181].name)

				arg_140_1.leftNameTxt_.text = var_143_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_24 = arg_140_1:GetWordFromCfg(424111032)
				local var_143_25 = arg_140_1:FormatText(var_143_24.content)

				arg_140_1.text_.text = var_143_25

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_26 = 9
				local var_143_27 = utf8.len(var_143_25)
				local var_143_28 = var_143_26 <= 0 and var_143_22 or var_143_22 * (var_143_27 / var_143_26)

				if var_143_28 > 0 and var_143_22 < var_143_28 then
					arg_140_1.talkMaxDuration = var_143_28

					if var_143_28 + var_143_21 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_28 + var_143_21
					end
				end

				arg_140_1.text_.text = var_143_25
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111032", "story_v_out_424111.awb") ~= 0 then
					local var_143_29 = manager.audio:GetVoiceLength("story_v_out_424111", "424111032", "story_v_out_424111.awb") / 1000

					if var_143_29 + var_143_21 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_29 + var_143_21
					end

					if var_143_24.prefab_name ~= "" and arg_140_1.actors_[var_143_24.prefab_name] ~= nil then
						local var_143_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_24.prefab_name].transform, "story_v_out_424111", "424111032", "story_v_out_424111.awb")

						arg_140_1:RecordAudio("424111032", var_143_30)
						arg_140_1:RecordAudio("424111032", var_143_30)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_424111", "424111032", "story_v_out_424111.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_424111", "424111032", "story_v_out_424111.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_31 = math.max(var_143_22, arg_140_1.talkMaxDuration)

			if var_143_21 <= arg_140_1.time_ and arg_140_1.time_ < var_143_21 + var_143_31 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_21) / var_143_31

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_21 + var_143_31 and arg_140_1.time_ < var_143_21 + var_143_31 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play424111033 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 424111033
		arg_145_1.duration_ = 6.6

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play424111034(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1094"]
			local var_148_1 = 0.966

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps1094 == nil then
				arg_145_1.var_.actorSpriteComps1094 = var_148_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_2 = 0.034

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.actorSpriteComps1094 then
					for iter_148_0, iter_148_1 in pairs(arg_145_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_148_1 then
							if arg_145_1.isInRecall_ then
								local var_148_4 = Mathf.Lerp(iter_148_1.color.r, arg_145_1.hightColor2.r, var_148_3)
								local var_148_5 = Mathf.Lerp(iter_148_1.color.g, arg_145_1.hightColor2.g, var_148_3)
								local var_148_6 = Mathf.Lerp(iter_148_1.color.b, arg_145_1.hightColor2.b, var_148_3)

								iter_148_1.color = Color.New(var_148_4, var_148_5, var_148_6)
							else
								local var_148_7 = Mathf.Lerp(iter_148_1.color.r, 0.5, var_148_3)

								iter_148_1.color = Color.New(var_148_7, var_148_7, var_148_7)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps1094 then
				for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_148_3 then
						if arg_145_1.isInRecall_ then
							iter_148_3.color = arg_145_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_148_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps1094 = nil
			end

			local var_148_8 = arg_145_1.actors_["1094"].transform
			local var_148_9 = 0.966

			if var_148_9 < arg_145_1.time_ and arg_145_1.time_ <= var_148_9 + arg_148_0 then
				arg_145_1.var_.moveOldPos1094 = var_148_8.localPosition
				var_148_8.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("1094", 7)

				local var_148_10 = var_148_8.childCount

				for iter_148_4 = 0, var_148_10 - 1 do
					local var_148_11 = var_148_8:GetChild(iter_148_4)

					if var_148_11.name == "" or not string.find(var_148_11.name, "split") then
						var_148_11.gameObject:SetActive(true)
					else
						var_148_11.gameObject:SetActive(false)
					end
				end
			end

			local var_148_12 = 0.001

			if var_148_9 <= arg_145_1.time_ and arg_145_1.time_ < var_148_9 + var_148_12 then
				local var_148_13 = (arg_145_1.time_ - var_148_9) / var_148_12
				local var_148_14 = Vector3.New(0, -2000, 0)

				var_148_8.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1094, var_148_14, var_148_13)
			end

			if arg_145_1.time_ >= var_148_9 + var_148_12 and arg_145_1.time_ < var_148_9 + var_148_12 + arg_148_0 then
				var_148_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_148_15 = 0

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_16 = 1

			if var_148_15 <= arg_145_1.time_ and arg_145_1.time_ < var_148_15 + var_148_16 then
				local var_148_17 = (arg_145_1.time_ - var_148_15) / var_148_16
				local var_148_18 = Color.New(1, 1, 1)

				var_148_18.a = Mathf.Lerp(0, 1, var_148_17)
				arg_145_1.mask_.color = var_148_18
			end

			if arg_145_1.time_ >= var_148_15 + var_148_16 and arg_145_1.time_ < var_148_15 + var_148_16 + arg_148_0 then
				local var_148_19 = Color.New(1, 1, 1)

				var_148_19.a = 1
				arg_145_1.mask_.color = var_148_19
			end

			local var_148_20 = 1

			if var_148_20 < arg_145_1.time_ and arg_145_1.time_ <= var_148_20 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_21 = 1

			if var_148_20 <= arg_145_1.time_ and arg_145_1.time_ < var_148_20 + var_148_21 then
				local var_148_22 = (arg_145_1.time_ - var_148_20) / var_148_21
				local var_148_23 = Color.New(1, 1, 1)

				var_148_23.a = Mathf.Lerp(1, 0, var_148_22)
				arg_145_1.mask_.color = var_148_23
			end

			if arg_145_1.time_ >= var_148_20 + var_148_21 and arg_145_1.time_ < var_148_20 + var_148_21 + arg_148_0 then
				local var_148_24 = Color.New(1, 1, 1)
				local var_148_25 = 0

				arg_145_1.mask_.enabled = false
				var_148_24.a = var_148_25
				arg_145_1.mask_.color = var_148_24
			end

			local var_148_26 = 0
			local var_148_27 = 1

			if var_148_26 < arg_145_1.time_ and arg_145_1.time_ <= var_148_26 + arg_148_0 then
				local var_148_28 = "play"
				local var_148_29 = "effect"

				arg_145_1:AudioAction(var_148_28, var_148_29, "se_story_145", "se_story_145_explosion02", "")
			end

			if arg_145_1.frameCnt_ <= 1 then
				arg_145_1.dialog_:SetActive(false)
			end

			local var_148_30 = 1.6
			local var_148_31 = 1.375

			if var_148_30 < arg_145_1.time_ and arg_145_1.time_ <= var_148_30 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				arg_145_1.dialog_:SetActive(true)

				arg_145_1.dialogCg_.alpha = 0

				local var_148_32 = LeanTween.value(arg_145_1.dialog_, 0, 1, 0.3)

				var_148_32:setOnUpdate(LuaHelper.FloatAction(function(arg_149_0)
					arg_145_1.dialogCg_.alpha = arg_149_0
				end))
				var_148_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_145_1.dialog_)
					var_148_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_145_1.duration_ = arg_145_1.duration_ + 0.3

				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_33 = arg_145_1:GetWordFromCfg(424111033)
				local var_148_34 = arg_145_1:FormatText(var_148_33.content)

				arg_145_1.text_.text = var_148_34

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_35 = 55
				local var_148_36 = utf8.len(var_148_34)
				local var_148_37 = var_148_35 <= 0 and var_148_31 or var_148_31 * (var_148_36 / var_148_35)

				if var_148_37 > 0 and var_148_31 < var_148_37 then
					arg_145_1.talkMaxDuration = var_148_37
					var_148_30 = var_148_30 + 0.3

					if var_148_37 + var_148_30 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_37 + var_148_30
					end
				end

				arg_145_1.text_.text = var_148_34
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_38 = var_148_30 + 0.3
			local var_148_39 = math.max(var_148_31, arg_145_1.talkMaxDuration)

			if var_148_38 <= arg_145_1.time_ and arg_145_1.time_ < var_148_38 + var_148_39 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_38) / var_148_39

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_38 + var_148_39 and arg_145_1.time_ < var_148_38 + var_148_39 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play424111034 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 424111034
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play424111035(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 0.9

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_2 = arg_151_1:GetWordFromCfg(424111034)
				local var_154_3 = arg_151_1:FormatText(var_154_2.content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 36
				local var_154_5 = utf8.len(var_154_3)
				local var_154_6 = var_154_4 <= 0 and var_154_1 or var_154_1 * (var_154_5 / var_154_4)

				if var_154_6 > 0 and var_154_1 < var_154_6 then
					arg_151_1.talkMaxDuration = var_154_6

					if var_154_6 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_6 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_3
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_7 and arg_151_1.time_ < var_154_0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play424111035 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 424111035
		arg_155_1.duration_ = 5.2

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play424111036(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = manager.ui.mainCamera.transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				local var_158_2 = arg_155_1.var_.effectchushouzhuizhu1
				local var_158_3
				local var_158_4 = var_158_0

				if not var_158_2 then
					var_158_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_out"), var_158_4)
					var_158_2.name = "chushouzhuizhu1"
					arg_155_1.var_.effectchushouzhuizhu1 = var_158_2
				else
					var_158_2.transform:SetParent(var_158_4)
				end

				var_158_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_158_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_158_5 = manager.ui.mainCameraCom_
				local var_158_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_158_5.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_158_7 = var_158_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_158_8 = 15
				local var_158_9 = 2 * var_158_8 * Mathf.Tan(var_158_5.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_158_5.aspect
				local var_158_10 = 1
				local var_158_11 = 1.7777777777777777

				if var_158_11 < var_158_5.aspect then
					var_158_10 = var_158_9 / (2 * var_158_8 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_158_11)
				end

				for iter_158_0, iter_158_1 in ipairs(var_158_7) do
					local var_158_12 = iter_158_1.transform.localScale

					iter_158_1.transform.localScale = Vector3.New(var_158_12.x / var_158_6 * var_158_10, var_158_12.y / var_158_6, var_158_12.z)
				end
			end

			local var_158_13 = 0
			local var_158_14 = 1

			if var_158_13 < arg_155_1.time_ and arg_155_1.time_ <= var_158_13 + arg_158_0 then
				local var_158_15 = "play"
				local var_158_16 = "effect"

				arg_155_1:AudioAction(var_158_15, var_158_16, "se_story_145", "se_story_145_rock", "")
			end

			if arg_155_1.frameCnt_ <= 1 then
				arg_155_1.dialog_:SetActive(false)
			end

			local var_158_17 = 0.2
			local var_158_18 = 1.25

			if var_158_17 < arg_155_1.time_ and arg_155_1.time_ <= var_158_17 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0

				arg_155_1.dialog_:SetActive(true)

				arg_155_1.dialogCg_.alpha = 0

				local var_158_19 = LeanTween.value(arg_155_1.dialog_, 0, 1, 0.3)

				var_158_19:setOnUpdate(LuaHelper.FloatAction(function(arg_159_0)
					arg_155_1.dialogCg_.alpha = arg_159_0
				end))
				var_158_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_155_1.dialog_)
					var_158_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_155_1.duration_ = arg_155_1.duration_ + 0.3

				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_20 = arg_155_1:GetWordFromCfg(424111035)
				local var_158_21 = arg_155_1:FormatText(var_158_20.content)

				arg_155_1.text_.text = var_158_21

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_22 = 50
				local var_158_23 = utf8.len(var_158_21)
				local var_158_24 = var_158_22 <= 0 and var_158_18 or var_158_18 * (var_158_23 / var_158_22)

				if var_158_24 > 0 and var_158_18 < var_158_24 then
					arg_155_1.talkMaxDuration = var_158_24
					var_158_17 = var_158_17 + 0.3

					if var_158_24 + var_158_17 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_24 + var_158_17
					end
				end

				arg_155_1.text_.text = var_158_21
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_25 = var_158_17 + 0.3
			local var_158_26 = math.max(var_158_18, arg_155_1.talkMaxDuration)

			if var_158_25 <= arg_155_1.time_ and arg_155_1.time_ < var_158_25 + var_158_26 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_25) / var_158_26

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_25 + var_158_26 and arg_155_1.time_ < var_158_25 + var_158_26 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 25,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/HeavyAttack_Shake",
				duration = 0.8,
				amplitudeGain = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play424111036 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 424111036
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play424111037(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.125

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[7].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_3 = arg_161_1:GetWordFromCfg(424111036)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 5
				local var_164_6 = utf8.len(var_164_4)
				local var_164_7 = var_164_5 <= 0 and var_164_1 or var_164_1 * (var_164_6 / var_164_5)

				if var_164_7 > 0 and var_164_1 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_8 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_8 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_8

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_8 and arg_161_1.time_ < var_164_0 + var_164_8 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play424111037 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 424111037
		arg_165_1.duration_ = 5.17

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play424111038(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = manager.ui.mainCamera.transform
			local var_168_1 = 0.166666666666667

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				local var_168_2 = arg_165_1.var_.effectdiaozhuanqiangkou1
				local var_168_3
				local var_168_4 = var_168_0

				if not var_168_2 then
					var_168_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_168_4)
					var_168_2.name = "diaozhuanqiangkou1"
					arg_165_1.var_.effectdiaozhuanqiangkou1 = var_168_2
				else
					var_168_2.transform:SetParent(var_168_4)
				end

				var_168_2.transform.localPosition = Vector3.New(0, -0.5, 0)
				var_168_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_168_5 = manager.ui.mainCameraCom_
				local var_168_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_168_5.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_168_7 = var_168_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_168_8 = 15
				local var_168_9 = 2 * var_168_8 * Mathf.Tan(var_168_5.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_168_5.aspect
				local var_168_10 = 1
				local var_168_11 = 1.7777777777777777

				if var_168_11 < var_168_5.aspect then
					var_168_10 = var_168_9 / (2 * var_168_8 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_168_11)
				end

				for iter_168_0, iter_168_1 in ipairs(var_168_7) do
					local var_168_12 = iter_168_1.transform.localScale

					iter_168_1.transform.localScale = Vector3.New(var_168_12.x / var_168_6 * var_168_10, var_168_12.y / var_168_6, var_168_12.z)
				end
			end

			local var_168_13 = manager.ui.mainCamera.transform
			local var_168_14 = 0.166666666666667

			if var_168_14 < arg_165_1.time_ and arg_165_1.time_ <= var_168_14 + arg_168_0 then
				arg_165_1.var_.shakeOldPos = var_168_13.localPosition
			end

			local var_168_15 = 0.3

			if var_168_14 <= arg_165_1.time_ and arg_165_1.time_ < var_168_14 + var_168_15 then
				local var_168_16 = (arg_165_1.time_ - var_168_14) / 0.066
				local var_168_17, var_168_18 = math.modf(var_168_16)

				var_168_13.localPosition = Vector3.New(var_168_18 * 0.13, var_168_18 * 0.13, var_168_18 * 0.13) + arg_165_1.var_.shakeOldPos
			end

			if arg_165_1.time_ >= var_168_14 + var_168_15 and arg_165_1.time_ < var_168_14 + var_168_15 + arg_168_0 then
				var_168_13.localPosition = arg_165_1.var_.shakeOldPos
			end

			local var_168_19 = 0

			if var_168_19 < arg_165_1.time_ and arg_165_1.time_ <= var_168_19 + arg_168_0 then
				arg_165_1.allBtn_.enabled = false
			end

			local var_168_20 = 0.166666666666667

			if arg_165_1.time_ >= var_168_19 + var_168_20 and arg_165_1.time_ < var_168_19 + var_168_20 + arg_168_0 then
				arg_165_1.allBtn_.enabled = true
			end

			local var_168_21 = 0.166666666666667
			local var_168_22 = 1

			if var_168_21 < arg_165_1.time_ and arg_165_1.time_ <= var_168_21 + arg_168_0 then
				local var_168_23 = "play"
				local var_168_24 = "effect"

				arg_165_1:AudioAction(var_168_23, var_168_24, "se_story_1310", "se_story_1310_gun02", "")
			end

			if arg_165_1.frameCnt_ <= 1 then
				arg_165_1.dialog_:SetActive(false)
			end

			local var_168_25 = 0.166666666666667
			local var_168_26 = 1.425

			if var_168_25 < arg_165_1.time_ and arg_165_1.time_ <= var_168_25 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				arg_165_1.dialog_:SetActive(true)

				arg_165_1.dialogCg_.alpha = 0

				local var_168_27 = LeanTween.value(arg_165_1.dialog_, 0, 1, 0.3)

				var_168_27:setOnUpdate(LuaHelper.FloatAction(function(arg_169_0)
					arg_165_1.dialogCg_.alpha = arg_169_0
				end))
				var_168_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_165_1.dialog_)
					var_168_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_165_1.duration_ = arg_165_1.duration_ + 0.3

				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_28 = arg_165_1:GetWordFromCfg(424111037)
				local var_168_29 = arg_165_1:FormatText(var_168_28.content)

				arg_165_1.text_.text = var_168_29

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_30 = 57
				local var_168_31 = utf8.len(var_168_29)
				local var_168_32 = var_168_30 <= 0 and var_168_26 or var_168_26 * (var_168_31 / var_168_30)

				if var_168_32 > 0 and var_168_26 < var_168_32 then
					arg_165_1.talkMaxDuration = var_168_32
					var_168_25 = var_168_25 + 0.3

					if var_168_32 + var_168_25 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_32 + var_168_25
					end
				end

				arg_165_1.text_.text = var_168_29
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_33 = var_168_25 + 0.3
			local var_168_34 = math.max(var_168_26, arg_165_1.talkMaxDuration)

			if var_168_33 <= arg_165_1.time_ and arg_165_1.time_ < var_168_33 + var_168_34 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_33) / var_168_34

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_33 + var_168_34 and arg_165_1.time_ < var_168_33 + var_168_34 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play424111038 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 424111038
		arg_171_1.duration_ = 3.57

		local var_171_0 = {
			zh = 3.333,
			ja = 3.566
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play424111039(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.3

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[1387].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10153_split_5")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_3 = arg_171_1:GetWordFromCfg(424111038)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 12
				local var_174_6 = utf8.len(var_174_4)
				local var_174_7 = var_174_5 <= 0 and var_174_1 or var_174_1 * (var_174_6 / var_174_5)

				if var_174_7 > 0 and var_174_1 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_4
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111038", "story_v_out_424111.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_424111", "424111038", "story_v_out_424111.awb") / 1000

					if var_174_8 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_0
					end

					if var_174_3.prefab_name ~= "" and arg_171_1.actors_[var_174_3.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_3.prefab_name].transform, "story_v_out_424111", "424111038", "story_v_out_424111.awb")

						arg_171_1:RecordAudio("424111038", var_174_9)
						arg_171_1:RecordAudio("424111038", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_424111", "424111038", "story_v_out_424111.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_424111", "424111038", "story_v_out_424111.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_10 and arg_171_1.time_ < var_174_0 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play424111039 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 424111039
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play424111040(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = "1029"

			if arg_175_1.actors_[var_178_0] == nil then
				local var_178_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1029")

				if not isNil(var_178_1) then
					local var_178_2 = Object.Instantiate(var_178_1, arg_175_1.canvasGo_.transform)

					var_178_2.transform:SetSiblingIndex(1)

					var_178_2.name = var_178_0
					var_178_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_175_1.actors_[var_178_0] = var_178_2

					local var_178_3 = var_178_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_175_1.isInRecall_ then
						for iter_178_0, iter_178_1 in ipairs(var_178_3) do
							iter_178_1.color = arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_178_4 = arg_175_1.actors_["1029"]
			local var_178_5 = 0

			if var_178_5 < arg_175_1.time_ and arg_175_1.time_ <= var_178_5 + arg_178_0 and not isNil(var_178_4) and arg_175_1.var_.actorSpriteComps1029 == nil then
				arg_175_1.var_.actorSpriteComps1029 = var_178_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_6 = 0.2

			if var_178_5 <= arg_175_1.time_ and arg_175_1.time_ < var_178_5 + var_178_6 and not isNil(var_178_4) then
				local var_178_7 = (arg_175_1.time_ - var_178_5) / var_178_6

				if arg_175_1.var_.actorSpriteComps1029 then
					for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_178_3 then
							if arg_175_1.isInRecall_ then
								local var_178_8 = Mathf.Lerp(iter_178_3.color.r, arg_175_1.hightColor2.r, var_178_7)
								local var_178_9 = Mathf.Lerp(iter_178_3.color.g, arg_175_1.hightColor2.g, var_178_7)
								local var_178_10 = Mathf.Lerp(iter_178_3.color.b, arg_175_1.hightColor2.b, var_178_7)

								iter_178_3.color = Color.New(var_178_8, var_178_9, var_178_10)
							else
								local var_178_11 = Mathf.Lerp(iter_178_3.color.r, 0.5, var_178_7)

								iter_178_3.color = Color.New(var_178_11, var_178_11, var_178_11)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= var_178_5 + var_178_6 and arg_175_1.time_ < var_178_5 + var_178_6 + arg_178_0 and not isNil(var_178_4) and arg_175_1.var_.actorSpriteComps1029 then
				for iter_178_4, iter_178_5 in pairs(arg_175_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_178_5 then
						if arg_175_1.isInRecall_ then
							iter_178_5.color = arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_178_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_175_1.var_.actorSpriteComps1029 = nil
			end

			local var_178_12 = arg_175_1.actors_["1029"].transform
			local var_178_13 = 0

			if var_178_13 < arg_175_1.time_ and arg_175_1.time_ <= var_178_13 + arg_178_0 then
				arg_175_1.var_.moveOldPos1029 = var_178_12.localPosition
				var_178_12.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("1029", 7)

				local var_178_14 = var_178_12.childCount

				for iter_178_6 = 0, var_178_14 - 1 do
					local var_178_15 = var_178_12:GetChild(iter_178_6)

					if var_178_15.name == "" or not string.find(var_178_15.name, "split") then
						var_178_15.gameObject:SetActive(true)
					else
						var_178_15.gameObject:SetActive(false)
					end
				end
			end

			local var_178_16 = 0.001

			if var_178_13 <= arg_175_1.time_ and arg_175_1.time_ < var_178_13 + var_178_16 then
				local var_178_17 = (arg_175_1.time_ - var_178_13) / var_178_16
				local var_178_18 = Vector3.New(0, -2000, -140)

				var_178_12.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1029, var_178_18, var_178_17)
			end

			if arg_175_1.time_ >= var_178_13 + var_178_16 and arg_175_1.time_ < var_178_13 + var_178_16 + arg_178_0 then
				var_178_12.localPosition = Vector3.New(0, -2000, -140)
			end

			local var_178_19 = 0.034
			local var_178_20 = 1

			if var_178_19 < arg_175_1.time_ and arg_175_1.time_ <= var_178_19 + arg_178_0 then
				local var_178_21 = "play"
				local var_178_22 = "effect"

				arg_175_1:AudioAction(var_178_21, var_178_22, "se_story_145", "se_story_145_star_movement_wobble02", "")
			end

			local var_178_23 = 0
			local var_178_24 = 1.1

			if var_178_23 < arg_175_1.time_ and arg_175_1.time_ <= var_178_23 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_25 = arg_175_1:GetWordFromCfg(424111039)
				local var_178_26 = arg_175_1:FormatText(var_178_25.content)

				arg_175_1.text_.text = var_178_26

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_27 = 44
				local var_178_28 = utf8.len(var_178_26)
				local var_178_29 = var_178_27 <= 0 and var_178_24 or var_178_24 * (var_178_28 / var_178_27)

				if var_178_29 > 0 and var_178_24 < var_178_29 then
					arg_175_1.talkMaxDuration = var_178_29

					if var_178_29 + var_178_23 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_29 + var_178_23
					end
				end

				arg_175_1.text_.text = var_178_26
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_30 = math.max(var_178_24, arg_175_1.talkMaxDuration)

			if var_178_23 <= arg_175_1.time_ and arg_175_1.time_ < var_178_23 + var_178_30 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_23) / var_178_30

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_23 + var_178_30 and arg_175_1.time_ < var_178_23 + var_178_30 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029",
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
	Play424111040 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 424111040
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play424111041(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.225

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[7].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_3 = arg_179_1:GetWordFromCfg(424111040)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 9
				local var_182_6 = utf8.len(var_182_4)
				local var_182_7 = var_182_5 <= 0 and var_182_1 or var_182_1 * (var_182_6 / var_182_5)

				if var_182_7 > 0 and var_182_1 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_8 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_8 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_8

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_8 and arg_179_1.time_ < var_182_0 + var_182_8 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play424111041 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 424111041
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play424111042(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.05

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[36].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Timor")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:GetWordFromCfg(424111041)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 2
				local var_186_6 = utf8.len(var_186_4)
				local var_186_7 = var_186_5 <= 0 and var_186_1 or var_186_1 * (var_186_6 / var_186_5)

				if var_186_7 > 0 and var_186_1 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_8 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_8 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_8

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_8 and arg_183_1.time_ < var_186_0 + var_186_8 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play424111042 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 424111042
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play424111043(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.475
			local var_190_1 = 1

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				local var_190_2 = "play"
				local var_190_3 = "effect"

				arg_187_1:AudioAction(var_190_2, var_190_3, "se_story_140", "se_story_140_tear", "")
			end

			local var_190_4 = 0
			local var_190_5 = 1.475

			if var_190_4 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_6 = arg_187_1:GetWordFromCfg(424111042)
				local var_190_7 = arg_187_1:FormatText(var_190_6.content)

				arg_187_1.text_.text = var_190_7

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_8 = 59
				local var_190_9 = utf8.len(var_190_7)
				local var_190_10 = var_190_8 <= 0 and var_190_5 or var_190_5 * (var_190_9 / var_190_8)

				if var_190_10 > 0 and var_190_5 < var_190_10 then
					arg_187_1.talkMaxDuration = var_190_10

					if var_190_10 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_7
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_11 = math.max(var_190_5, arg_187_1.talkMaxDuration)

			if var_190_4 <= arg_187_1.time_ and arg_187_1.time_ < var_190_4 + var_190_11 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_4) / var_190_11

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_4 + var_190_11 and arg_187_1.time_ < var_190_4 + var_190_11 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play424111043 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 424111043
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play424111044(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 1.225

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_2 = arg_191_1:GetWordFromCfg(424111043)
				local var_194_3 = arg_191_1:FormatText(var_194_2.content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 49
				local var_194_5 = utf8.len(var_194_3)
				local var_194_6 = var_194_4 <= 0 and var_194_1 or var_194_1 * (var_194_5 / var_194_4)

				if var_194_6 > 0 and var_194_1 < var_194_6 then
					arg_191_1.talkMaxDuration = var_194_6

					if var_194_6 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_6 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_7 and arg_191_1.time_ < var_194_0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play424111044 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 424111044
		arg_195_1.duration_ = 3.33

		local var_195_0 = {
			zh = 2.5,
			ja = 3.333
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play424111045(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 0.25

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[177].name)

				arg_195_1.leftNameTxt_.text = var_198_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:GetWordFromCfg(424111044)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 10
				local var_198_6 = utf8.len(var_198_4)
				local var_198_7 = var_198_5 <= 0 and var_198_1 or var_198_1 * (var_198_6 / var_198_5)

				if var_198_7 > 0 and var_198_1 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_4
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111044", "story_v_out_424111.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_out_424111", "424111044", "story_v_out_424111.awb") / 1000

					if var_198_8 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_0
					end

					if var_198_3.prefab_name ~= "" and arg_195_1.actors_[var_198_3.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_3.prefab_name].transform, "story_v_out_424111", "424111044", "story_v_out_424111.awb")

						arg_195_1:RecordAudio("424111044", var_198_9)
						arg_195_1:RecordAudio("424111044", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_424111", "424111044", "story_v_out_424111.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_424111", "424111044", "story_v_out_424111.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_10 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_10 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_10

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_10 and arg_195_1.time_ < var_198_0 + var_198_10 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play424111045 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 424111045
		arg_199_1.duration_ = 3.6

		local var_199_0 = {
			zh = 3.233,
			ja = 3.6
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
				arg_199_0:Play424111046(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = "10153"

			if arg_199_1.actors_[var_202_0] == nil then
				local var_202_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10153")

				if not isNil(var_202_1) then
					local var_202_2 = Object.Instantiate(var_202_1, arg_199_1.canvasGo_.transform)

					var_202_2.transform:SetSiblingIndex(1)

					var_202_2.name = var_202_0
					var_202_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_199_1.actors_[var_202_0] = var_202_2

					local var_202_3 = var_202_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_199_1.isInRecall_ then
						for iter_202_0, iter_202_1 in ipairs(var_202_3) do
							iter_202_1.color = arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_202_4 = arg_199_1.actors_["10153"]
			local var_202_5 = 0

			if var_202_5 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 and not isNil(var_202_4) and arg_199_1.var_.actorSpriteComps10153 == nil then
				arg_199_1.var_.actorSpriteComps10153 = var_202_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_6 = 0.2

			if var_202_5 <= arg_199_1.time_ and arg_199_1.time_ < var_202_5 + var_202_6 and not isNil(var_202_4) then
				local var_202_7 = (arg_199_1.time_ - var_202_5) / var_202_6

				if arg_199_1.var_.actorSpriteComps10153 then
					for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_202_3 then
							if arg_199_1.isInRecall_ then
								local var_202_8 = Mathf.Lerp(iter_202_3.color.r, arg_199_1.hightColor1.r, var_202_7)
								local var_202_9 = Mathf.Lerp(iter_202_3.color.g, arg_199_1.hightColor1.g, var_202_7)
								local var_202_10 = Mathf.Lerp(iter_202_3.color.b, arg_199_1.hightColor1.b, var_202_7)

								iter_202_3.color = Color.New(var_202_8, var_202_9, var_202_10)
							else
								local var_202_11 = Mathf.Lerp(iter_202_3.color.r, 1, var_202_7)

								iter_202_3.color = Color.New(var_202_11, var_202_11, var_202_11)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= var_202_5 + var_202_6 and arg_199_1.time_ < var_202_5 + var_202_6 + arg_202_0 and not isNil(var_202_4) and arg_199_1.var_.actorSpriteComps10153 then
				for iter_202_4, iter_202_5 in pairs(arg_199_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_202_5 then
						if arg_199_1.isInRecall_ then
							iter_202_5.color = arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_202_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps10153 = nil
			end

			local var_202_12 = arg_199_1.actors_["10153"].transform
			local var_202_13 = 0

			if var_202_13 < arg_199_1.time_ and arg_199_1.time_ <= var_202_13 + arg_202_0 then
				arg_199_1.var_.moveOldPos10153 = var_202_12.localPosition
				var_202_12.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("10153", 3)

				local var_202_14 = var_202_12.childCount

				for iter_202_6 = 0, var_202_14 - 1 do
					local var_202_15 = var_202_12:GetChild(iter_202_6)

					if var_202_15.name == "" or not string.find(var_202_15.name, "split") then
						var_202_15.gameObject:SetActive(true)
					else
						var_202_15.gameObject:SetActive(false)
					end
				end
			end

			local var_202_16 = 0.001

			if var_202_13 <= arg_199_1.time_ and arg_199_1.time_ < var_202_13 + var_202_16 then
				local var_202_17 = (arg_199_1.time_ - var_202_13) / var_202_16
				local var_202_18 = Vector3.New(-60, -395, -330)

				var_202_12.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10153, var_202_18, var_202_17)
			end

			if arg_199_1.time_ >= var_202_13 + var_202_16 and arg_199_1.time_ < var_202_13 + var_202_16 + arg_202_0 then
				var_202_12.localPosition = Vector3.New(-60, -395, -330)
			end

			local var_202_19 = 0
			local var_202_20 = 0.35

			if var_202_19 < arg_199_1.time_ and arg_199_1.time_ <= var_202_19 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_21 = arg_199_1:FormatText(StoryNameCfg[1387].name)

				arg_199_1.leftNameTxt_.text = var_202_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_22 = arg_199_1:GetWordFromCfg(424111045)
				local var_202_23 = arg_199_1:FormatText(var_202_22.content)

				arg_199_1.text_.text = var_202_23

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_24 = 14
				local var_202_25 = utf8.len(var_202_23)
				local var_202_26 = var_202_24 <= 0 and var_202_20 or var_202_20 * (var_202_25 / var_202_24)

				if var_202_26 > 0 and var_202_20 < var_202_26 then
					arg_199_1.talkMaxDuration = var_202_26

					if var_202_26 + var_202_19 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_26 + var_202_19
					end
				end

				arg_199_1.text_.text = var_202_23
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111045", "story_v_out_424111.awb") ~= 0 then
					local var_202_27 = manager.audio:GetVoiceLength("story_v_out_424111", "424111045", "story_v_out_424111.awb") / 1000

					if var_202_27 + var_202_19 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_27 + var_202_19
					end

					if var_202_22.prefab_name ~= "" and arg_199_1.actors_[var_202_22.prefab_name] ~= nil then
						local var_202_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_22.prefab_name].transform, "story_v_out_424111", "424111045", "story_v_out_424111.awb")

						arg_199_1:RecordAudio("424111045", var_202_28)
						arg_199_1:RecordAudio("424111045", var_202_28)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_424111", "424111045", "story_v_out_424111.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_424111", "424111045", "story_v_out_424111.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_29 = math.max(var_202_20, arg_199_1.talkMaxDuration)

			if var_202_19 <= arg_199_1.time_ and arg_199_1.time_ < var_202_19 + var_202_29 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_19) / var_202_29

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_19 + var_202_29 and arg_199_1.time_ < var_202_19 + var_202_29 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play424111046 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 424111046
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play424111047(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["10153"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.actorSpriteComps10153 == nil then
				arg_203_1.var_.actorSpriteComps10153 = var_206_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_2 = 0.2

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.actorSpriteComps10153 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_206_1 then
							if arg_203_1.isInRecall_ then
								local var_206_4 = Mathf.Lerp(iter_206_1.color.r, arg_203_1.hightColor2.r, var_206_3)
								local var_206_5 = Mathf.Lerp(iter_206_1.color.g, arg_203_1.hightColor2.g, var_206_3)
								local var_206_6 = Mathf.Lerp(iter_206_1.color.b, arg_203_1.hightColor2.b, var_206_3)

								iter_206_1.color = Color.New(var_206_4, var_206_5, var_206_6)
							else
								local var_206_7 = Mathf.Lerp(iter_206_1.color.r, 0.5, var_206_3)

								iter_206_1.color = Color.New(var_206_7, var_206_7, var_206_7)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.actorSpriteComps10153 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_206_3 then
						if arg_203_1.isInRecall_ then
							iter_206_3.color = arg_203_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_206_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_203_1.var_.actorSpriteComps10153 = nil
			end

			local var_206_8 = 0
			local var_206_9 = 0.35

			if var_206_8 < arg_203_1.time_ and arg_203_1.time_ <= var_206_8 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_10 = arg_203_1:FormatText(StoryNameCfg[7].name)

				arg_203_1.leftNameTxt_.text = var_206_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_11 = arg_203_1:GetWordFromCfg(424111046)
				local var_206_12 = arg_203_1:FormatText(var_206_11.content)

				arg_203_1.text_.text = var_206_12

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_13 = 14
				local var_206_14 = utf8.len(var_206_12)
				local var_206_15 = var_206_13 <= 0 and var_206_9 or var_206_9 * (var_206_14 / var_206_13)

				if var_206_15 > 0 and var_206_9 < var_206_15 then
					arg_203_1.talkMaxDuration = var_206_15

					if var_206_15 + var_206_8 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_15 + var_206_8
					end
				end

				arg_203_1.text_.text = var_206_12
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_16 = math.max(var_206_9, arg_203_1.talkMaxDuration)

			if var_206_8 <= arg_203_1.time_ and arg_203_1.time_ < var_206_8 + var_206_16 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_8) / var_206_16

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_8 + var_206_16 and arg_203_1.time_ < var_206_8 + var_206_16 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play424111047 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 424111047
		arg_207_1.duration_ = 3.53

		local var_207_0 = {
			zh = 3.533,
			ja = 2.7
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
				arg_207_0:Play424111048(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.5

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_2 = arg_207_1:FormatText(StoryNameCfg[177].name)

				arg_207_1.leftNameTxt_.text = var_210_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_3 = arg_207_1:GetWordFromCfg(424111047)
				local var_210_4 = arg_207_1:FormatText(var_210_3.content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 20
				local var_210_6 = utf8.len(var_210_4)
				local var_210_7 = var_210_5 <= 0 and var_210_1 or var_210_1 * (var_210_6 / var_210_5)

				if var_210_7 > 0 and var_210_1 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_4
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111047", "story_v_out_424111.awb") ~= 0 then
					local var_210_8 = manager.audio:GetVoiceLength("story_v_out_424111", "424111047", "story_v_out_424111.awb") / 1000

					if var_210_8 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_0
					end

					if var_210_3.prefab_name ~= "" and arg_207_1.actors_[var_210_3.prefab_name] ~= nil then
						local var_210_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_3.prefab_name].transform, "story_v_out_424111", "424111047", "story_v_out_424111.awb")

						arg_207_1:RecordAudio("424111047", var_210_9)
						arg_207_1:RecordAudio("424111047", var_210_9)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_424111", "424111047", "story_v_out_424111.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_424111", "424111047", "story_v_out_424111.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_10 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_10 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_10

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_10 and arg_207_1.time_ < var_210_0 + var_210_10 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play424111048 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 424111048
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play424111049(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["10153"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos10153 = var_214_0.localPosition
				var_214_0.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("10153", 7)

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

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10153, var_214_6, var_214_5)
			end

			if arg_211_1.time_ >= var_214_1 + var_214_4 and arg_211_1.time_ < var_214_1 + var_214_4 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_214_7 = manager.ui.mainCamera.transform
			local var_214_8 = 0

			if var_214_8 < arg_211_1.time_ and arg_211_1.time_ <= var_214_8 + arg_214_0 then
				local var_214_9 = arg_211_1.var_.effecthainenghudun1
				local var_214_10
				local var_214_11 = var_214_7

				if not var_214_9 then
					var_214_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_fogbank_red_in"), var_214_11)
					var_214_9.name = "hainenghudun1"
					arg_211_1.var_.effecthainenghudun1 = var_214_9
				else
					var_214_9.transform:SetParent(var_214_11)
				end

				var_214_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_214_9.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_214_12 = manager.ui.mainCameraCom_
				local var_214_13 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_214_12.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_214_14 = var_214_9.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_214_15 = 15
				local var_214_16 = 2 * var_214_15 * Mathf.Tan(var_214_12.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_214_12.aspect
				local var_214_17 = 1
				local var_214_18 = 1.7777777777777777

				if var_214_18 < var_214_12.aspect then
					var_214_17 = var_214_16 / (2 * var_214_15 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_214_18)
				end

				for iter_214_1, iter_214_2 in ipairs(var_214_14) do
					local var_214_19 = iter_214_2.transform.localScale

					iter_214_2.transform.localScale = Vector3.New(var_214_19.x / var_214_13 * var_214_17, var_214_19.y / var_214_13, var_214_19.z)
				end
			end

			local var_214_20 = 0
			local var_214_21 = 1.55

			if var_214_20 < arg_211_1.time_ and arg_211_1.time_ <= var_214_20 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_22 = arg_211_1:GetWordFromCfg(424111048)
				local var_214_23 = arg_211_1:FormatText(var_214_22.content)

				arg_211_1.text_.text = var_214_23

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_24 = 62
				local var_214_25 = utf8.len(var_214_23)
				local var_214_26 = var_214_24 <= 0 and var_214_21 or var_214_21 * (var_214_25 / var_214_24)

				if var_214_26 > 0 and var_214_21 < var_214_26 then
					arg_211_1.talkMaxDuration = var_214_26

					if var_214_26 + var_214_20 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_26 + var_214_20
					end
				end

				arg_211_1.text_.text = var_214_23
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_27 = math.max(var_214_21, arg_211_1.talkMaxDuration)

			if var_214_20 <= arg_211_1.time_ and arg_211_1.time_ < var_214_20 + var_214_27 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_20) / var_214_27

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_20 + var_214_27 and arg_211_1.time_ < var_214_20 + var_214_27 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
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
	Play424111049 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 424111049
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play424111050(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = manager.ui.mainCamera.transform
			local var_218_1 = 0.133333333333333

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				local var_218_2 = arg_215_1.var_.effectshennengguangzhu1
				local var_218_3
				local var_218_4 = var_218_0

				if not var_218_2 then
					var_218_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue"), var_218_4)
					var_218_2.name = "shennengguangzhu1"
					arg_215_1.var_.effectshennengguangzhu1 = var_218_2
				else
					var_218_2.transform:SetParent(var_218_4)
				end

				var_218_2.transform.localPosition = Vector3.New(0, 0.43, -4.5)
				var_218_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_218_5 = manager.ui.mainCameraCom_
				local var_218_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_218_5.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_218_7 = var_218_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_218_8 = 15
				local var_218_9 = 2 * var_218_8 * Mathf.Tan(var_218_5.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_218_5.aspect
				local var_218_10 = 1
				local var_218_11 = 1.7777777777777777

				if var_218_11 < var_218_5.aspect then
					var_218_10 = var_218_9 / (2 * var_218_8 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_218_11)
				end

				for iter_218_0, iter_218_1 in ipairs(var_218_7) do
					local var_218_12 = iter_218_1.transform.localScale

					iter_218_1.transform.localScale = Vector3.New(var_218_12.x / var_218_6 * var_218_10, var_218_12.y / var_218_6, var_218_12.z)
				end
			end

			local var_218_13 = manager.ui.mainCamera.transform
			local var_218_14 = 1.13333333333333

			if var_218_14 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 then
				local var_218_15 = arg_215_1.var_.effectshennengguangzhu1

				if var_218_15 then
					Object.Destroy(var_218_15)

					arg_215_1.var_.effectshennengguangzhu1 = nil
				end
			end

			local var_218_16 = manager.ui.mainCamera.transform
			local var_218_17 = 0.133333333333333

			if var_218_17 < arg_215_1.time_ and arg_215_1.time_ <= var_218_17 + arg_218_0 then
				arg_215_1.var_.shakeOldPos = var_218_16.localPosition
			end

			local var_218_18 = 0.4

			if var_218_17 <= arg_215_1.time_ and arg_215_1.time_ < var_218_17 + var_218_18 then
				local var_218_19 = (arg_215_1.time_ - var_218_17) / 0.066
				local var_218_20, var_218_21 = math.modf(var_218_19)

				var_218_16.localPosition = Vector3.New(var_218_21 * 0.13, var_218_21 * 0.13, var_218_21 * 0.13) + arg_215_1.var_.shakeOldPos
			end

			if arg_215_1.time_ >= var_218_17 + var_218_18 and arg_215_1.time_ < var_218_17 + var_218_18 + arg_218_0 then
				var_218_16.localPosition = arg_215_1.var_.shakeOldPos
			end

			local var_218_22 = manager.ui.mainCamera.transform
			local var_218_23 = 0.133333333333333

			if var_218_23 < arg_215_1.time_ and arg_215_1.time_ <= var_218_23 + arg_218_0 then
				local var_218_24 = arg_215_1.var_.effectshennengguangzhu2
				local var_218_25
				local var_218_26 = var_218_22

				if not var_218_24 then
					var_218_24 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rockfalldi"), var_218_26)
					var_218_24.name = "shennengguangzhu2"
					arg_215_1.var_.effectshennengguangzhu2 = var_218_24
				else
					var_218_24.transform:SetParent(var_218_26)
				end

				var_218_24.transform.localPosition = Vector3.New(0, 0.43, -4.5)
				var_218_24.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_218_27 = manager.ui.mainCameraCom_
				local var_218_28 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_218_27.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_218_29 = var_218_24.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_218_30 = 15
				local var_218_31 = 2 * var_218_30 * Mathf.Tan(var_218_27.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_218_27.aspect
				local var_218_32 = 1
				local var_218_33 = 1.7777777777777777

				if var_218_33 < var_218_27.aspect then
					var_218_32 = var_218_31 / (2 * var_218_30 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_218_33)
				end

				for iter_218_2, iter_218_3 in ipairs(var_218_29) do
					local var_218_34 = iter_218_3.transform.localScale

					iter_218_3.transform.localScale = Vector3.New(var_218_34.x / var_218_28 * var_218_32, var_218_34.y / var_218_28, var_218_34.z)
				end
			end

			local var_218_35 = manager.ui.mainCamera.transform
			local var_218_36 = 3.13333333333333

			if var_218_36 < arg_215_1.time_ and arg_215_1.time_ <= var_218_36 + arg_218_0 then
				local var_218_37 = arg_215_1.var_.effectshennengguangzhu2

				if var_218_37 then
					Object.Destroy(var_218_37)

					arg_215_1.var_.effectshennengguangzhu2 = nil
				end
			end

			local var_218_38 = 0

			if var_218_38 < arg_215_1.time_ and arg_215_1.time_ <= var_218_38 + arg_218_0 then
				arg_215_1.allBtn_.enabled = false
			end

			local var_218_39 = 0.533333333333333

			if arg_215_1.time_ >= var_218_38 + var_218_39 and arg_215_1.time_ < var_218_38 + var_218_39 + arg_218_0 then
				arg_215_1.allBtn_.enabled = true
			end

			local var_218_40 = 0.1
			local var_218_41 = 1

			if var_218_40 < arg_215_1.time_ and arg_215_1.time_ <= var_218_40 + arg_218_0 then
				local var_218_42 = "play"
				local var_218_43 = "effect"

				arg_215_1:AudioAction(var_218_42, var_218_43, "se_story_146", "se_story_146_laser01", "")
			end

			local var_218_44 = 0
			local var_218_45 = 1

			if var_218_44 < arg_215_1.time_ and arg_215_1.time_ <= var_218_44 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0

				arg_215_1.dialog_:SetActive(true)

				arg_215_1.dialogCg_.alpha = 0

				local var_218_46 = LeanTween.value(arg_215_1.dialog_, 0, 1, 0.3)

				var_218_46:setOnUpdate(LuaHelper.FloatAction(function(arg_219_0)
					arg_215_1.dialogCg_.alpha = arg_219_0
				end))
				var_218_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_215_1.dialog_)
					var_218_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_215_1.duration_ = arg_215_1.duration_ + 0.3

				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_47 = arg_215_1:GetWordFromCfg(424111049)
				local var_218_48 = arg_215_1:FormatText(var_218_47.content)

				arg_215_1.text_.text = var_218_48

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_49 = 40
				local var_218_50 = utf8.len(var_218_48)
				local var_218_51 = var_218_49 <= 0 and var_218_45 or var_218_45 * (var_218_50 / var_218_49)

				if var_218_51 > 0 and var_218_45 < var_218_51 then
					arg_215_1.talkMaxDuration = var_218_51
					var_218_44 = var_218_44 + 0.3

					if var_218_51 + var_218_44 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_51 + var_218_44
					end
				end

				arg_215_1.text_.text = var_218_48
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_52 = var_218_44 + 0.3
			local var_218_53 = math.max(var_218_45, arg_215_1.talkMaxDuration)

			if var_218_52 <= arg_215_1.time_ and arg_215_1.time_ < var_218_52 + var_218_53 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_52) / var_218_53

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_52 + var_218_53 and arg_215_1.time_ < var_218_52 + var_218_53 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play424111050 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 424111050
		arg_221_1.duration_ = 2

		local var_221_0 = {
			zh = 1.133,
			ja = 2
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play424111051(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 0.1

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_2 = arg_221_1:FormatText(StoryNameCfg[177].name)

				arg_221_1.leftNameTxt_.text = var_224_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_3 = arg_221_1:GetWordFromCfg(424111050)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 4
				local var_224_6 = utf8.len(var_224_4)
				local var_224_7 = var_224_5 <= 0 and var_224_1 or var_224_1 * (var_224_6 / var_224_5)

				if var_224_7 > 0 and var_224_1 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111050", "story_v_out_424111.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_out_424111", "424111050", "story_v_out_424111.awb") / 1000

					if var_224_8 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_0
					end

					if var_224_3.prefab_name ~= "" and arg_221_1.actors_[var_224_3.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_3.prefab_name].transform, "story_v_out_424111", "424111050", "story_v_out_424111.awb")

						arg_221_1:RecordAudio("424111050", var_224_9)
						arg_221_1:RecordAudio("424111050", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_424111", "424111050", "story_v_out_424111.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_424111", "424111050", "story_v_out_424111.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_10 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_10 and arg_221_1.time_ < var_224_0 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play424111051 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 424111051
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play424111052(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 1

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				local var_228_2 = "play"
				local var_228_3 = "effect"

				arg_225_1:AudioAction(var_228_2, var_228_3, "se_story_146", "se_story_146_roar01", "")
			end

			local var_228_4 = 0
			local var_228_5 = 0.15

			if var_228_4 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_6 = arg_225_1:FormatText(StoryNameCfg[1409].name)

				arg_225_1.leftNameTxt_.text = var_228_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Timor")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_7 = arg_225_1:GetWordFromCfg(424111051)
				local var_228_8 = arg_225_1:FormatText(var_228_7.content)

				arg_225_1.text_.text = var_228_8

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_9 = 6
				local var_228_10 = utf8.len(var_228_8)
				local var_228_11 = var_228_9 <= 0 and var_228_5 or var_228_5 * (var_228_10 / var_228_9)

				if var_228_11 > 0 and var_228_5 < var_228_11 then
					arg_225_1.talkMaxDuration = var_228_11

					if var_228_11 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_11 + var_228_4
					end
				end

				arg_225_1.text_.text = var_228_8
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_12 = math.max(var_228_5, arg_225_1.talkMaxDuration)

			if var_228_4 <= arg_225_1.time_ and arg_225_1.time_ < var_228_4 + var_228_12 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_4) / var_228_12

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_4 + var_228_12 and arg_225_1.time_ < var_228_4 + var_228_12 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play424111052 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 424111052
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play424111053(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 1.1

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_2 = arg_229_1:GetWordFromCfg(424111052)
				local var_232_3 = arg_229_1:FormatText(var_232_2.content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 44
				local var_232_5 = utf8.len(var_232_3)
				local var_232_6 = var_232_4 <= 0 and var_232_1 or var_232_1 * (var_232_5 / var_232_4)

				if var_232_6 > 0 and var_232_1 < var_232_6 then
					arg_229_1.talkMaxDuration = var_232_6

					if var_232_6 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_6 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_3
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_7 and arg_229_1.time_ < var_232_0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play424111053 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 424111053
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play424111054(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 1.125

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_2 = arg_233_1:GetWordFromCfg(424111053)
				local var_236_3 = arg_233_1:FormatText(var_236_2.content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_4 = 45
				local var_236_5 = utf8.len(var_236_3)
				local var_236_6 = var_236_4 <= 0 and var_236_1 or var_236_1 * (var_236_5 / var_236_4)

				if var_236_6 > 0 and var_236_1 < var_236_6 then
					arg_233_1.talkMaxDuration = var_236_6

					if var_236_6 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_6 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_3
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_7 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_7 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_7

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_7 and arg_233_1.time_ < var_236_0 + var_236_7 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play424111054 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 424111054
		arg_237_1.duration_ = 5.33

		local var_237_0 = {
			zh = 2.766,
			ja = 5.333
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
				arg_237_0:Play424111055(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 0.225

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0

				arg_237_1.dialog_:SetActive(true)

				arg_237_1.dialogCg_.alpha = 0

				local var_240_2 = LeanTween.value(arg_237_1.dialog_, 0, 1, 0.3)

				var_240_2:setOnUpdate(LuaHelper.FloatAction(function(arg_241_0)
					arg_237_1.dialogCg_.alpha = arg_241_0
				end))
				var_240_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_237_1.dialog_)
					var_240_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_237_1.duration_ = arg_237_1.duration_ + 0.3

				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_3 = arg_237_1:FormatText(StoryNameCfg[1391].name)

				arg_237_1.leftNameTxt_.text = var_240_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10155_split_6")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_4 = arg_237_1:GetWordFromCfg(424111054)
				local var_240_5 = arg_237_1:FormatText(var_240_4.content)

				arg_237_1.text_.text = var_240_5

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_6 = 9
				local var_240_7 = utf8.len(var_240_5)
				local var_240_8 = var_240_6 <= 0 and var_240_1 or var_240_1 * (var_240_7 / var_240_6)

				if var_240_8 > 0 and var_240_1 < var_240_8 then
					arg_237_1.talkMaxDuration = var_240_8
					var_240_0 = var_240_0 + 0.3

					if var_240_8 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_5
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111054", "story_v_out_424111.awb") ~= 0 then
					local var_240_9 = manager.audio:GetVoiceLength("story_v_out_424111", "424111054", "story_v_out_424111.awb") / 1000

					if var_240_9 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_9 + var_240_0
					end

					if var_240_4.prefab_name ~= "" and arg_237_1.actors_[var_240_4.prefab_name] ~= nil then
						local var_240_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_4.prefab_name].transform, "story_v_out_424111", "424111054", "story_v_out_424111.awb")

						arg_237_1:RecordAudio("424111054", var_240_10)
						arg_237_1:RecordAudio("424111054", var_240_10)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_424111", "424111054", "story_v_out_424111.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_424111", "424111054", "story_v_out_424111.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_11 = var_240_0 + 0.3
			local var_240_12 = math.max(var_240_1, arg_237_1.talkMaxDuration)

			if var_240_11 <= arg_237_1.time_ and arg_237_1.time_ < var_240_11 + var_240_12 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_11) / var_240_12

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_11 + var_240_12 and arg_237_1.time_ < var_240_11 + var_240_12 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play424111055 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 424111055
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play424111056(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["10155"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps10155 == nil then
				arg_243_1.var_.actorSpriteComps10155 = var_246_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_2 = 0.2

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.actorSpriteComps10155 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_246_1 then
							if arg_243_1.isInRecall_ then
								local var_246_4 = Mathf.Lerp(iter_246_1.color.r, arg_243_1.hightColor2.r, var_246_3)
								local var_246_5 = Mathf.Lerp(iter_246_1.color.g, arg_243_1.hightColor2.g, var_246_3)
								local var_246_6 = Mathf.Lerp(iter_246_1.color.b, arg_243_1.hightColor2.b, var_246_3)

								iter_246_1.color = Color.New(var_246_4, var_246_5, var_246_6)
							else
								local var_246_7 = Mathf.Lerp(iter_246_1.color.r, 0.5, var_246_3)

								iter_246_1.color = Color.New(var_246_7, var_246_7, var_246_7)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps10155 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_246_3 then
						if arg_243_1.isInRecall_ then
							iter_246_3.color = arg_243_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_246_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps10155 = nil
			end

			local var_246_8 = 0
			local var_246_9 = 0.45

			if var_246_8 < arg_243_1.time_ and arg_243_1.time_ <= var_246_8 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_10 = arg_243_1:FormatText(StoryNameCfg[7].name)

				arg_243_1.leftNameTxt_.text = var_246_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_11 = arg_243_1:GetWordFromCfg(424111055)
				local var_246_12 = arg_243_1:FormatText(var_246_11.content)

				arg_243_1.text_.text = var_246_12

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_13 = 18
				local var_246_14 = utf8.len(var_246_12)
				local var_246_15 = var_246_13 <= 0 and var_246_9 or var_246_9 * (var_246_14 / var_246_13)

				if var_246_15 > 0 and var_246_9 < var_246_15 then
					arg_243_1.talkMaxDuration = var_246_15

					if var_246_15 + var_246_8 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_15 + var_246_8
					end
				end

				arg_243_1.text_.text = var_246_12
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_16 = math.max(var_246_9, arg_243_1.talkMaxDuration)

			if var_246_8 <= arg_243_1.time_ and arg_243_1.time_ < var_246_8 + var_246_16 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_8) / var_246_16

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_8 + var_246_16 and arg_243_1.time_ < var_246_8 + var_246_16 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play424111056 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 424111056
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play424111057(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["10155"].transform
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.moveOldPos10155 = var_250_0.localPosition
				var_250_0.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10155", 7)

				local var_250_2 = var_250_0.childCount

				for iter_250_0 = 0, var_250_2 - 1 do
					local var_250_3 = var_250_0:GetChild(iter_250_0)

					if var_250_3.name == "" or not string.find(var_250_3.name, "split") then
						var_250_3.gameObject:SetActive(true)
					else
						var_250_3.gameObject:SetActive(false)
					end
				end
			end

			local var_250_4 = 0.001

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_4 then
				local var_250_5 = (arg_247_1.time_ - var_250_1) / var_250_4
				local var_250_6 = Vector3.New(0, -2000, 0)

				var_250_0.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10155, var_250_6, var_250_5)
			end

			if arg_247_1.time_ >= var_250_1 + var_250_4 and arg_247_1.time_ < var_250_1 + var_250_4 + arg_250_0 then
				var_250_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_250_7 = 0.166666666666667
			local var_250_8 = 1

			if var_250_7 < arg_247_1.time_ and arg_247_1.time_ <= var_250_7 + arg_250_0 then
				local var_250_9 = "play"
				local var_250_10 = "effect"

				arg_247_1:AudioAction(var_250_9, var_250_10, "se_story_144", "se_story_144_gun07", "")
			end

			local var_250_11 = 0
			local var_250_12 = 0.875

			if var_250_11 < arg_247_1.time_ and arg_247_1.time_ <= var_250_11 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_13 = arg_247_1:GetWordFromCfg(424111056)
				local var_250_14 = arg_247_1:FormatText(var_250_13.content)

				arg_247_1.text_.text = var_250_14

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_15 = 35
				local var_250_16 = utf8.len(var_250_14)
				local var_250_17 = var_250_15 <= 0 and var_250_12 or var_250_12 * (var_250_16 / var_250_15)

				if var_250_17 > 0 and var_250_12 < var_250_17 then
					arg_247_1.talkMaxDuration = var_250_17

					if var_250_17 + var_250_11 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_17 + var_250_11
					end
				end

				arg_247_1.text_.text = var_250_14
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_18 = math.max(var_250_12, arg_247_1.talkMaxDuration)

			if var_250_11 <= arg_247_1.time_ and arg_247_1.time_ < var_250_11 + var_250_18 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_11) / var_250_18

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_11 + var_250_18 and arg_247_1.time_ < var_250_11 + var_250_18 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
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
	Play424111057 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 424111057
		arg_251_1.duration_ = 6.37

		local var_251_0 = {
			zh = 5.933,
			ja = 6.366
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play424111058(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["10153"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.actorSpriteComps10153 == nil then
				arg_251_1.var_.actorSpriteComps10153 = var_254_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_2 = 0.2

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.actorSpriteComps10153 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_254_1 then
							if arg_251_1.isInRecall_ then
								local var_254_4 = Mathf.Lerp(iter_254_1.color.r, arg_251_1.hightColor1.r, var_254_3)
								local var_254_5 = Mathf.Lerp(iter_254_1.color.g, arg_251_1.hightColor1.g, var_254_3)
								local var_254_6 = Mathf.Lerp(iter_254_1.color.b, arg_251_1.hightColor1.b, var_254_3)

								iter_254_1.color = Color.New(var_254_4, var_254_5, var_254_6)
							else
								local var_254_7 = Mathf.Lerp(iter_254_1.color.r, 1, var_254_3)

								iter_254_1.color = Color.New(var_254_7, var_254_7, var_254_7)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.actorSpriteComps10153 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_254_3 then
						if arg_251_1.isInRecall_ then
							iter_254_3.color = arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_254_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_251_1.var_.actorSpriteComps10153 = nil
			end

			local var_254_8 = arg_251_1.actors_["10153"].transform
			local var_254_9 = 0

			if var_254_9 < arg_251_1.time_ and arg_251_1.time_ <= var_254_9 + arg_254_0 then
				arg_251_1.var_.moveOldPos10153 = var_254_8.localPosition
				var_254_8.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("10153", 2)

				local var_254_10 = var_254_8.childCount

				for iter_254_4 = 0, var_254_10 - 1 do
					local var_254_11 = var_254_8:GetChild(iter_254_4)

					if var_254_11.name == "split_3" or not string.find(var_254_11.name, "split") then
						var_254_11.gameObject:SetActive(true)
					else
						var_254_11.gameObject:SetActive(false)
					end
				end
			end

			local var_254_12 = 0.001

			if var_254_9 <= arg_251_1.time_ and arg_251_1.time_ < var_254_9 + var_254_12 then
				local var_254_13 = (arg_251_1.time_ - var_254_9) / var_254_12
				local var_254_14 = Vector3.New(-400, -395, -330)

				var_254_8.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10153, var_254_14, var_254_13)
			end

			if arg_251_1.time_ >= var_254_9 + var_254_12 and arg_251_1.time_ < var_254_9 + var_254_12 + arg_254_0 then
				var_254_8.localPosition = Vector3.New(-400, -395, -330)
			end

			local var_254_15 = 0
			local var_254_16 = 0.6

			if var_254_15 < arg_251_1.time_ and arg_251_1.time_ <= var_254_15 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_17 = arg_251_1:FormatText(StoryNameCfg[1387].name)

				arg_251_1.leftNameTxt_.text = var_254_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_18 = arg_251_1:GetWordFromCfg(424111057)
				local var_254_19 = arg_251_1:FormatText(var_254_18.content)

				arg_251_1.text_.text = var_254_19

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_20 = 24
				local var_254_21 = utf8.len(var_254_19)
				local var_254_22 = var_254_20 <= 0 and var_254_16 or var_254_16 * (var_254_21 / var_254_20)

				if var_254_22 > 0 and var_254_16 < var_254_22 then
					arg_251_1.talkMaxDuration = var_254_22

					if var_254_22 + var_254_15 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_22 + var_254_15
					end
				end

				arg_251_1.text_.text = var_254_19
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111057", "story_v_out_424111.awb") ~= 0 then
					local var_254_23 = manager.audio:GetVoiceLength("story_v_out_424111", "424111057", "story_v_out_424111.awb") / 1000

					if var_254_23 + var_254_15 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_23 + var_254_15
					end

					if var_254_18.prefab_name ~= "" and arg_251_1.actors_[var_254_18.prefab_name] ~= nil then
						local var_254_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_18.prefab_name].transform, "story_v_out_424111", "424111057", "story_v_out_424111.awb")

						arg_251_1:RecordAudio("424111057", var_254_24)
						arg_251_1:RecordAudio("424111057", var_254_24)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_424111", "424111057", "story_v_out_424111.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_424111", "424111057", "story_v_out_424111.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_25 = math.max(var_254_16, arg_251_1.talkMaxDuration)

			if var_254_15 <= arg_251_1.time_ and arg_251_1.time_ < var_254_15 + var_254_25 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_15) / var_254_25

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_15 + var_254_25 and arg_251_1.time_ < var_254_15 + var_254_25 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
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
	Play424111058 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 424111058
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play424111059(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["10153"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.actorSpriteComps10153 == nil then
				arg_255_1.var_.actorSpriteComps10153 = var_258_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_2 = 0.2

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.actorSpriteComps10153 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_258_1 then
							if arg_255_1.isInRecall_ then
								local var_258_4 = Mathf.Lerp(iter_258_1.color.r, arg_255_1.hightColor2.r, var_258_3)
								local var_258_5 = Mathf.Lerp(iter_258_1.color.g, arg_255_1.hightColor2.g, var_258_3)
								local var_258_6 = Mathf.Lerp(iter_258_1.color.b, arg_255_1.hightColor2.b, var_258_3)

								iter_258_1.color = Color.New(var_258_4, var_258_5, var_258_6)
							else
								local var_258_7 = Mathf.Lerp(iter_258_1.color.r, 0.5, var_258_3)

								iter_258_1.color = Color.New(var_258_7, var_258_7, var_258_7)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.actorSpriteComps10153 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_258_3 then
						if arg_255_1.isInRecall_ then
							iter_258_3.color = arg_255_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_258_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_255_1.var_.actorSpriteComps10153 = nil
			end

			local var_258_8 = 0.45
			local var_258_9 = 1

			if var_258_8 < arg_255_1.time_ and arg_255_1.time_ <= var_258_8 + arg_258_0 then
				local var_258_10 = "play"
				local var_258_11 = "effect"

				arg_255_1:AudioAction(var_258_10, var_258_11, "se_story_140", "se_story_140_explosion01", "")
			end

			local var_258_12 = 0
			local var_258_13 = 1.45

			if var_258_12 < arg_255_1.time_ and arg_255_1.time_ <= var_258_12 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_14 = arg_255_1:GetWordFromCfg(424111058)
				local var_258_15 = arg_255_1:FormatText(var_258_14.content)

				arg_255_1.text_.text = var_258_15

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_16 = 58
				local var_258_17 = utf8.len(var_258_15)
				local var_258_18 = var_258_16 <= 0 and var_258_13 or var_258_13 * (var_258_17 / var_258_16)

				if var_258_18 > 0 and var_258_13 < var_258_18 then
					arg_255_1.talkMaxDuration = var_258_18

					if var_258_18 + var_258_12 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_18 + var_258_12
					end
				end

				arg_255_1.text_.text = var_258_15
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_19 = math.max(var_258_13, arg_255_1.talkMaxDuration)

			if var_258_12 <= arg_255_1.time_ and arg_255_1.time_ < var_258_12 + var_258_19 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_12) / var_258_19

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_12 + var_258_19 and arg_255_1.time_ < var_258_12 + var_258_19 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play424111059 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 424111059
		arg_259_1.duration_ = 10.53

		local var_259_0 = {
			zh = 8.066,
			ja = 10.533
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
				arg_259_0:Play424111060(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1094"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps1094 == nil then
				arg_259_1.var_.actorSpriteComps1094 = var_262_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_2 = 0.2

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.actorSpriteComps1094 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps1094 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_262_3 then
						if arg_259_1.isInRecall_ then
							iter_262_3.color = arg_259_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_262_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_259_1.var_.actorSpriteComps1094 = nil
			end

			local var_262_8 = arg_259_1.actors_["1094"].transform
			local var_262_9 = 0

			if var_262_9 < arg_259_1.time_ and arg_259_1.time_ <= var_262_9 + arg_262_0 then
				arg_259_1.var_.moveOldPos1094 = var_262_8.localPosition
				var_262_8.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("1094", 4)

				local var_262_10 = var_262_8.childCount

				for iter_262_4 = 0, var_262_10 - 1 do
					local var_262_11 = var_262_8:GetChild(iter_262_4)

					if var_262_11.name == "split_3" or not string.find(var_262_11.name, "split") then
						var_262_11.gameObject:SetActive(true)
					else
						var_262_11.gameObject:SetActive(false)
					end
				end
			end

			local var_262_12 = 0.001

			if var_262_9 <= arg_259_1.time_ and arg_259_1.time_ < var_262_9 + var_262_12 then
				local var_262_13 = (arg_259_1.time_ - var_262_9) / var_262_12
				local var_262_14 = Vector3.New(470, -335, -230)

				var_262_8.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1094, var_262_14, var_262_13)
			end

			if arg_259_1.time_ >= var_262_9 + var_262_12 and arg_259_1.time_ < var_262_9 + var_262_12 + arg_262_0 then
				var_262_8.localPosition = Vector3.New(470, -335, -230)
			end

			local var_262_15 = 0
			local var_262_16 = 0.725

			if var_262_15 < arg_259_1.time_ and arg_259_1.time_ <= var_262_15 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_17 = arg_259_1:FormatText(StoryNameCfg[181].name)

				arg_259_1.leftNameTxt_.text = var_262_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_18 = arg_259_1:GetWordFromCfg(424111059)
				local var_262_19 = arg_259_1:FormatText(var_262_18.content)

				arg_259_1.text_.text = var_262_19

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_20 = 29
				local var_262_21 = utf8.len(var_262_19)
				local var_262_22 = var_262_20 <= 0 and var_262_16 or var_262_16 * (var_262_21 / var_262_20)

				if var_262_22 > 0 and var_262_16 < var_262_22 then
					arg_259_1.talkMaxDuration = var_262_22

					if var_262_22 + var_262_15 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_22 + var_262_15
					end
				end

				arg_259_1.text_.text = var_262_19
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111059", "story_v_out_424111.awb") ~= 0 then
					local var_262_23 = manager.audio:GetVoiceLength("story_v_out_424111", "424111059", "story_v_out_424111.awb") / 1000

					if var_262_23 + var_262_15 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_23 + var_262_15
					end

					if var_262_18.prefab_name ~= "" and arg_259_1.actors_[var_262_18.prefab_name] ~= nil then
						local var_262_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_18.prefab_name].transform, "story_v_out_424111", "424111059", "story_v_out_424111.awb")

						arg_259_1:RecordAudio("424111059", var_262_24)
						arg_259_1:RecordAudio("424111059", var_262_24)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_424111", "424111059", "story_v_out_424111.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_424111", "424111059", "story_v_out_424111.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_25 = math.max(var_262_16, arg_259_1.talkMaxDuration)

			if var_262_15 <= arg_259_1.time_ and arg_259_1.time_ < var_262_15 + var_262_25 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_15) / var_262_25

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_15 + var_262_25 and arg_259_1.time_ < var_262_15 + var_262_25 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
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
	Play424111060 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 424111060
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play424111061(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1094"]
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps1094 == nil then
				arg_263_1.var_.actorSpriteComps1094 = var_266_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_2 = 0.2

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 and not isNil(var_266_0) then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2

				if arg_263_1.var_.actorSpriteComps1094 then
					for iter_266_0, iter_266_1 in pairs(arg_263_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_266_1 then
							if arg_263_1.isInRecall_ then
								local var_266_4 = Mathf.Lerp(iter_266_1.color.r, arg_263_1.hightColor2.r, var_266_3)
								local var_266_5 = Mathf.Lerp(iter_266_1.color.g, arg_263_1.hightColor2.g, var_266_3)
								local var_266_6 = Mathf.Lerp(iter_266_1.color.b, arg_263_1.hightColor2.b, var_266_3)

								iter_266_1.color = Color.New(var_266_4, var_266_5, var_266_6)
							else
								local var_266_7 = Mathf.Lerp(iter_266_1.color.r, 0.5, var_266_3)

								iter_266_1.color = Color.New(var_266_7, var_266_7, var_266_7)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps1094 then
				for iter_266_2, iter_266_3 in pairs(arg_263_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_266_3 then
						if arg_263_1.isInRecall_ then
							iter_266_3.color = arg_263_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_266_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_263_1.var_.actorSpriteComps1094 = nil
			end

			local var_266_8 = 0
			local var_266_9 = 0.825

			if var_266_8 < arg_263_1.time_ and arg_263_1.time_ <= var_266_8 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_10 = arg_263_1:GetWordFromCfg(424111060)
				local var_266_11 = arg_263_1:FormatText(var_266_10.content)

				arg_263_1.text_.text = var_266_11

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_12 = 33
				local var_266_13 = utf8.len(var_266_11)
				local var_266_14 = var_266_12 <= 0 and var_266_9 or var_266_9 * (var_266_13 / var_266_12)

				if var_266_14 > 0 and var_266_9 < var_266_14 then
					arg_263_1.talkMaxDuration = var_266_14

					if var_266_14 + var_266_8 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_14 + var_266_8
					end
				end

				arg_263_1.text_.text = var_266_11
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_15 = math.max(var_266_9, arg_263_1.talkMaxDuration)

			if var_266_8 <= arg_263_1.time_ and arg_263_1.time_ < var_266_8 + var_266_15 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_8) / var_266_15

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_8 + var_266_15 and arg_263_1.time_ < var_266_8 + var_266_15 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play424111061 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 424111061
		arg_267_1.duration_ = 6.67

		local var_267_0 = {
			zh = 5.833,
			ja = 6.666
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
				arg_267_0:Play424111062(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["10153"]
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.actorSpriteComps10153 == nil then
				arg_267_1.var_.actorSpriteComps10153 = var_270_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_2 = 0.2

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 and not isNil(var_270_0) then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2

				if arg_267_1.var_.actorSpriteComps10153 then
					for iter_270_0, iter_270_1 in pairs(arg_267_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_270_1 then
							if arg_267_1.isInRecall_ then
								local var_270_4 = Mathf.Lerp(iter_270_1.color.r, arg_267_1.hightColor1.r, var_270_3)
								local var_270_5 = Mathf.Lerp(iter_270_1.color.g, arg_267_1.hightColor1.g, var_270_3)
								local var_270_6 = Mathf.Lerp(iter_270_1.color.b, arg_267_1.hightColor1.b, var_270_3)

								iter_270_1.color = Color.New(var_270_4, var_270_5, var_270_6)
							else
								local var_270_7 = Mathf.Lerp(iter_270_1.color.r, 1, var_270_3)

								iter_270_1.color = Color.New(var_270_7, var_270_7, var_270_7)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.actorSpriteComps10153 then
				for iter_270_2, iter_270_3 in pairs(arg_267_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_270_3 then
						if arg_267_1.isInRecall_ then
							iter_270_3.color = arg_267_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_270_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_267_1.var_.actorSpriteComps10153 = nil
			end

			local var_270_8 = arg_267_1.actors_["10153"].transform
			local var_270_9 = 0

			if var_270_9 < arg_267_1.time_ and arg_267_1.time_ <= var_270_9 + arg_270_0 then
				arg_267_1.var_.moveOldPos10153 = var_270_8.localPosition
				var_270_8.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("10153", 2)

				local var_270_10 = var_270_8.childCount

				for iter_270_4 = 0, var_270_10 - 1 do
					local var_270_11 = var_270_8:GetChild(iter_270_4)

					if var_270_11.name == "split_1" then
						var_270_11:SetAsLastSibling()
						var_270_11.gameObject:SetActive(true)

						arg_267_1.var_.actorSpriteSplit10153 = var_270_11.gameObject:GetComponent(typeof(Image))

						arg_267_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_270_12 = 0.5

			if var_270_9 <= arg_267_1.time_ and arg_267_1.time_ < var_270_9 + var_270_12 then
				local var_270_13 = (arg_267_1.time_ - var_270_9) / var_270_12
				local var_270_14 = Vector3.New(-400, -395, -330)

				var_270_8.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos10153, var_270_14, var_270_13)

				if arg_267_1.var_.actorSpriteSplit10153 ~= nil then
					arg_267_1.var_.actorSpriteSplit10153:SetAlpha(var_270_13)
				end
			end

			if arg_267_1.time_ >= var_270_9 + var_270_12 and arg_267_1.time_ < var_270_9 + var_270_12 + arg_270_0 then
				var_270_8.localPosition = Vector3.New(-400, -395, -330)

				if arg_267_1.var_.actorSpriteSplit10153 ~= nil then
					arg_267_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_270_15 = 0
			local var_270_16 = 0.725

			if var_270_15 < arg_267_1.time_ and arg_267_1.time_ <= var_270_15 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_17 = arg_267_1:FormatText(StoryNameCfg[1387].name)

				arg_267_1.leftNameTxt_.text = var_270_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_18 = arg_267_1:GetWordFromCfg(424111061)
				local var_270_19 = arg_267_1:FormatText(var_270_18.content)

				arg_267_1.text_.text = var_270_19

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_20 = 29
				local var_270_21 = utf8.len(var_270_19)
				local var_270_22 = var_270_20 <= 0 and var_270_16 or var_270_16 * (var_270_21 / var_270_20)

				if var_270_22 > 0 and var_270_16 < var_270_22 then
					arg_267_1.talkMaxDuration = var_270_22

					if var_270_22 + var_270_15 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_22 + var_270_15
					end
				end

				arg_267_1.text_.text = var_270_19
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111061", "story_v_out_424111.awb") ~= 0 then
					local var_270_23 = manager.audio:GetVoiceLength("story_v_out_424111", "424111061", "story_v_out_424111.awb") / 1000

					if var_270_23 + var_270_15 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_23 + var_270_15
					end

					if var_270_18.prefab_name ~= "" and arg_267_1.actors_[var_270_18.prefab_name] ~= nil then
						local var_270_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_18.prefab_name].transform, "story_v_out_424111", "424111061", "story_v_out_424111.awb")

						arg_267_1:RecordAudio("424111061", var_270_24)
						arg_267_1:RecordAudio("424111061", var_270_24)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_424111", "424111061", "story_v_out_424111.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_424111", "424111061", "story_v_out_424111.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_25 = math.max(var_270_16, arg_267_1.talkMaxDuration)

			if var_270_15 <= arg_267_1.time_ and arg_267_1.time_ < var_270_15 + var_270_25 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_15) / var_270_25

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_15 + var_270_25 and arg_267_1.time_ < var_270_15 + var_270_25 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play424111062 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 424111062
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play424111063(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["10153"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps10153 == nil then
				arg_271_1.var_.actorSpriteComps10153 = var_274_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_2 = 0.2

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.actorSpriteComps10153 then
					for iter_274_0, iter_274_1 in pairs(arg_271_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_274_1 then
							if arg_271_1.isInRecall_ then
								local var_274_4 = Mathf.Lerp(iter_274_1.color.r, arg_271_1.hightColor2.r, var_274_3)
								local var_274_5 = Mathf.Lerp(iter_274_1.color.g, arg_271_1.hightColor2.g, var_274_3)
								local var_274_6 = Mathf.Lerp(iter_274_1.color.b, arg_271_1.hightColor2.b, var_274_3)

								iter_274_1.color = Color.New(var_274_4, var_274_5, var_274_6)
							else
								local var_274_7 = Mathf.Lerp(iter_274_1.color.r, 0.5, var_274_3)

								iter_274_1.color = Color.New(var_274_7, var_274_7, var_274_7)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps10153 then
				for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_274_3 then
						if arg_271_1.isInRecall_ then
							iter_274_3.color = arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_274_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps10153 = nil
			end

			local var_274_8 = arg_271_1.actors_["10153"].transform
			local var_274_9 = 0

			if var_274_9 < arg_271_1.time_ and arg_271_1.time_ <= var_274_9 + arg_274_0 then
				arg_271_1.var_.moveOldPos10153 = var_274_8.localPosition
				var_274_8.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("10153", 7)

				local var_274_10 = var_274_8.childCount

				for iter_274_4 = 0, var_274_10 - 1 do
					local var_274_11 = var_274_8:GetChild(iter_274_4)

					if var_274_11.name == "" or not string.find(var_274_11.name, "split") then
						var_274_11.gameObject:SetActive(true)
					else
						var_274_11.gameObject:SetActive(false)
					end
				end
			end

			local var_274_12 = 0.001

			if var_274_9 <= arg_271_1.time_ and arg_271_1.time_ < var_274_9 + var_274_12 then
				local var_274_13 = (arg_271_1.time_ - var_274_9) / var_274_12
				local var_274_14 = Vector3.New(0, -2000, 0)

				var_274_8.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10153, var_274_14, var_274_13)
			end

			if arg_271_1.time_ >= var_274_9 + var_274_12 and arg_271_1.time_ < var_274_9 + var_274_12 + arg_274_0 then
				var_274_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_274_15 = arg_271_1.actors_["1094"].transform
			local var_274_16 = 0

			if var_274_16 < arg_271_1.time_ and arg_271_1.time_ <= var_274_16 + arg_274_0 then
				arg_271_1.var_.moveOldPos1094 = var_274_15.localPosition
				var_274_15.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("1094", 7)

				local var_274_17 = var_274_15.childCount

				for iter_274_5 = 0, var_274_17 - 1 do
					local var_274_18 = var_274_15:GetChild(iter_274_5)

					if var_274_18.name == "" or not string.find(var_274_18.name, "split") then
						var_274_18.gameObject:SetActive(true)
					else
						var_274_18.gameObject:SetActive(false)
					end
				end
			end

			local var_274_19 = 0.001

			if var_274_16 <= arg_271_1.time_ and arg_271_1.time_ < var_274_16 + var_274_19 then
				local var_274_20 = (arg_271_1.time_ - var_274_16) / var_274_19
				local var_274_21 = Vector3.New(0, -2000, 0)

				var_274_15.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1094, var_274_21, var_274_20)
			end

			if arg_271_1.time_ >= var_274_16 + var_274_19 and arg_271_1.time_ < var_274_16 + var_274_19 + arg_274_0 then
				var_274_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_274_22 = 0
			local var_274_23 = 0.9

			if var_274_22 < arg_271_1.time_ and arg_271_1.time_ <= var_274_22 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_24 = arg_271_1:GetWordFromCfg(424111062)
				local var_274_25 = arg_271_1:FormatText(var_274_24.content)

				arg_271_1.text_.text = var_274_25

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_26 = 36
				local var_274_27 = utf8.len(var_274_25)
				local var_274_28 = var_274_26 <= 0 and var_274_23 or var_274_23 * (var_274_27 / var_274_26)

				if var_274_28 > 0 and var_274_23 < var_274_28 then
					arg_271_1.talkMaxDuration = var_274_28

					if var_274_28 + var_274_22 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_28 + var_274_22
					end
				end

				arg_271_1.text_.text = var_274_25
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_29 = math.max(var_274_23, arg_271_1.talkMaxDuration)

			if var_274_22 <= arg_271_1.time_ and arg_271_1.time_ < var_274_22 + var_274_29 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_22) / var_274_29

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_22 + var_274_29 and arg_271_1.time_ < var_274_22 + var_274_29 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play424111063 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 424111063
		arg_275_1.duration_ = 2.17

		local var_275_0 = {
			zh = 2.166,
			ja = 1.966
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
				arg_275_0:Play424111064(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0
			local var_278_1 = 0.2

			if var_278_0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_2 = arg_275_1:FormatText(StoryNameCfg[177].name)

				arg_275_1.leftNameTxt_.text = var_278_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_3 = arg_275_1:GetWordFromCfg(424111063)
				local var_278_4 = arg_275_1:FormatText(var_278_3.content)

				arg_275_1.text_.text = var_278_4

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 8
				local var_278_6 = utf8.len(var_278_4)
				local var_278_7 = var_278_5 <= 0 and var_278_1 or var_278_1 * (var_278_6 / var_278_5)

				if var_278_7 > 0 and var_278_1 < var_278_7 then
					arg_275_1.talkMaxDuration = var_278_7

					if var_278_7 + var_278_0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_0
					end
				end

				arg_275_1.text_.text = var_278_4
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111063", "story_v_out_424111.awb") ~= 0 then
					local var_278_8 = manager.audio:GetVoiceLength("story_v_out_424111", "424111063", "story_v_out_424111.awb") / 1000

					if var_278_8 + var_278_0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_8 + var_278_0
					end

					if var_278_3.prefab_name ~= "" and arg_275_1.actors_[var_278_3.prefab_name] ~= nil then
						local var_278_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_3.prefab_name].transform, "story_v_out_424111", "424111063", "story_v_out_424111.awb")

						arg_275_1:RecordAudio("424111063", var_278_9)
						arg_275_1:RecordAudio("424111063", var_278_9)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_424111", "424111063", "story_v_out_424111.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_424111", "424111063", "story_v_out_424111.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_10 = math.max(var_278_1, arg_275_1.talkMaxDuration)

			if var_278_0 <= arg_275_1.time_ and arg_275_1.time_ < var_278_0 + var_278_10 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_0) / var_278_10

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_0 + var_278_10 and arg_275_1.time_ < var_278_0 + var_278_10 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play424111064 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 424111064
		arg_279_1.duration_ = 2.37

		local var_279_0 = {
			zh = 2.166,
			ja = 2.366
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
				arg_279_0:Play424111065(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["10153"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps10153 == nil then
				arg_279_1.var_.actorSpriteComps10153 = var_282_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_2 = 0.2

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.actorSpriteComps10153 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps10153:ToTable()) do
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

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps10153 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_282_3 then
						if arg_279_1.isInRecall_ then
							iter_282_3.color = arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_282_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_279_1.var_.actorSpriteComps10153 = nil
			end

			local var_282_8 = arg_279_1.actors_["10153"].transform
			local var_282_9 = 0

			if var_282_9 < arg_279_1.time_ and arg_279_1.time_ <= var_282_9 + arg_282_0 then
				arg_279_1.var_.moveOldPos10153 = var_282_8.localPosition
				var_282_8.localScale = Vector3.New(1, 1, 1)

				arg_279_1:CheckSpriteTmpPos("10153", 3)

				local var_282_10 = var_282_8.childCount

				for iter_282_4 = 0, var_282_10 - 1 do
					local var_282_11 = var_282_8:GetChild(iter_282_4)

					if var_282_11.name == "split_1" or not string.find(var_282_11.name, "split") then
						var_282_11.gameObject:SetActive(true)
					else
						var_282_11.gameObject:SetActive(false)
					end
				end
			end

			local var_282_12 = 0.001

			if var_282_9 <= arg_279_1.time_ and arg_279_1.time_ < var_282_9 + var_282_12 then
				local var_282_13 = (arg_279_1.time_ - var_282_9) / var_282_12
				local var_282_14 = Vector3.New(-60, -395, -330)

				var_282_8.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10153, var_282_14, var_282_13)
			end

			if arg_279_1.time_ >= var_282_9 + var_282_12 and arg_279_1.time_ < var_282_9 + var_282_12 + arg_282_0 then
				var_282_8.localPosition = Vector3.New(-60, -395, -330)
			end

			local var_282_15 = 0
			local var_282_16 = 0.275

			if var_282_15 < arg_279_1.time_ and arg_279_1.time_ <= var_282_15 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_17 = arg_279_1:FormatText(StoryNameCfg[1387].name)

				arg_279_1.leftNameTxt_.text = var_282_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_18 = arg_279_1:GetWordFromCfg(424111064)
				local var_282_19 = arg_279_1:FormatText(var_282_18.content)

				arg_279_1.text_.text = var_282_19

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_20 = 11
				local var_282_21 = utf8.len(var_282_19)
				local var_282_22 = var_282_20 <= 0 and var_282_16 or var_282_16 * (var_282_21 / var_282_20)

				if var_282_22 > 0 and var_282_16 < var_282_22 then
					arg_279_1.talkMaxDuration = var_282_22

					if var_282_22 + var_282_15 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_22 + var_282_15
					end
				end

				arg_279_1.text_.text = var_282_19
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111064", "story_v_out_424111.awb") ~= 0 then
					local var_282_23 = manager.audio:GetVoiceLength("story_v_out_424111", "424111064", "story_v_out_424111.awb") / 1000

					if var_282_23 + var_282_15 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_23 + var_282_15
					end

					if var_282_18.prefab_name ~= "" and arg_279_1.actors_[var_282_18.prefab_name] ~= nil then
						local var_282_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_18.prefab_name].transform, "story_v_out_424111", "424111064", "story_v_out_424111.awb")

						arg_279_1:RecordAudio("424111064", var_282_24)
						arg_279_1:RecordAudio("424111064", var_282_24)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_424111", "424111064", "story_v_out_424111.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_424111", "424111064", "story_v_out_424111.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_25 = math.max(var_282_16, arg_279_1.talkMaxDuration)

			if var_282_15 <= arg_279_1.time_ and arg_279_1.time_ < var_282_15 + var_282_25 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_15) / var_282_25

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_15 + var_282_25 and arg_279_1.time_ < var_282_15 + var_282_25 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play424111065 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 424111065
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play424111066(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["10153"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps10153 == nil then
				arg_283_1.var_.actorSpriteComps10153 = var_286_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_2 = 0.2

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.actorSpriteComps10153 then
					for iter_286_0, iter_286_1 in pairs(arg_283_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_286_1 then
							if arg_283_1.isInRecall_ then
								local var_286_4 = Mathf.Lerp(iter_286_1.color.r, arg_283_1.hightColor2.r, var_286_3)
								local var_286_5 = Mathf.Lerp(iter_286_1.color.g, arg_283_1.hightColor2.g, var_286_3)
								local var_286_6 = Mathf.Lerp(iter_286_1.color.b, arg_283_1.hightColor2.b, var_286_3)

								iter_286_1.color = Color.New(var_286_4, var_286_5, var_286_6)
							else
								local var_286_7 = Mathf.Lerp(iter_286_1.color.r, 0.5, var_286_3)

								iter_286_1.color = Color.New(var_286_7, var_286_7, var_286_7)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps10153 then
				for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_286_3 then
						if arg_283_1.isInRecall_ then
							iter_286_3.color = arg_283_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_286_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_283_1.var_.actorSpriteComps10153 = nil
			end

			local var_286_8 = arg_283_1.actors_["10153"].transform
			local var_286_9 = 0

			if var_286_9 < arg_283_1.time_ and arg_283_1.time_ <= var_286_9 + arg_286_0 then
				arg_283_1.var_.moveOldPos10153 = var_286_8.localPosition
				var_286_8.localScale = Vector3.New(1, 1, 1)

				arg_283_1:CheckSpriteTmpPos("10153", 7)

				local var_286_10 = var_286_8.childCount

				for iter_286_4 = 0, var_286_10 - 1 do
					local var_286_11 = var_286_8:GetChild(iter_286_4)

					if var_286_11.name == "" or not string.find(var_286_11.name, "split") then
						var_286_11.gameObject:SetActive(true)
					else
						var_286_11.gameObject:SetActive(false)
					end
				end
			end

			local var_286_12 = 0.001

			if var_286_9 <= arg_283_1.time_ and arg_283_1.time_ < var_286_9 + var_286_12 then
				local var_286_13 = (arg_283_1.time_ - var_286_9) / var_286_12
				local var_286_14 = Vector3.New(0, -2000, 0)

				var_286_8.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10153, var_286_14, var_286_13)
			end

			if arg_283_1.time_ >= var_286_9 + var_286_12 and arg_283_1.time_ < var_286_9 + var_286_12 + arg_286_0 then
				var_286_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_286_15 = manager.ui.mainCamera.transform
			local var_286_16 = 0

			if var_286_16 < arg_283_1.time_ and arg_283_1.time_ <= var_286_16 + arg_286_0 then
				arg_283_1.var_.shakeOldPos = var_286_15.localPosition
			end

			local var_286_17 = 1

			if var_286_16 <= arg_283_1.time_ and arg_283_1.time_ < var_286_16 + var_286_17 then
				local var_286_18 = (arg_283_1.time_ - var_286_16) / 0.066
				local var_286_19, var_286_20 = math.modf(var_286_18)

				var_286_15.localPosition = Vector3.New(var_286_20 * 0.13, var_286_20 * 0.13, var_286_20 * 0.13) + arg_283_1.var_.shakeOldPos
			end

			if arg_283_1.time_ >= var_286_16 + var_286_17 and arg_283_1.time_ < var_286_16 + var_286_17 + arg_286_0 then
				var_286_15.localPosition = arg_283_1.var_.shakeOldPos
			end

			local var_286_21 = 0

			if var_286_21 < arg_283_1.time_ and arg_283_1.time_ <= var_286_21 + arg_286_0 then
				arg_283_1.allBtn_.enabled = false
			end

			local var_286_22 = 1

			if arg_283_1.time_ >= var_286_21 + var_286_22 and arg_283_1.time_ < var_286_21 + var_286_22 + arg_286_0 then
				arg_283_1.allBtn_.enabled = true
			end

			local var_286_23 = 0
			local var_286_24 = 1

			if var_286_23 < arg_283_1.time_ and arg_283_1.time_ <= var_286_23 + arg_286_0 then
				local var_286_25 = "play"
				local var_286_26 = "effect"

				arg_283_1:AudioAction(var_286_25, var_286_26, "se_story_122_03", "se_story_122_03_hit", "")
			end

			local var_286_27 = 0

			if var_286_27 < arg_283_1.time_ and arg_283_1.time_ <= var_286_27 + arg_286_0 then
				arg_283_1.allBtn_.enabled = false
			end

			local var_286_28 = 0.966666666666667

			if arg_283_1.time_ >= var_286_27 + var_286_28 and arg_283_1.time_ < var_286_27 + var_286_28 + arg_286_0 then
				arg_283_1.allBtn_.enabled = true
			end

			local var_286_29 = 0
			local var_286_30 = 0.975

			if var_286_29 < arg_283_1.time_ and arg_283_1.time_ <= var_286_29 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_31 = arg_283_1:GetWordFromCfg(424111065)
				local var_286_32 = arg_283_1:FormatText(var_286_31.content)

				arg_283_1.text_.text = var_286_32

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_33 = 39
				local var_286_34 = utf8.len(var_286_32)
				local var_286_35 = var_286_33 <= 0 and var_286_30 or var_286_30 * (var_286_34 / var_286_33)

				if var_286_35 > 0 and var_286_30 < var_286_35 then
					arg_283_1.talkMaxDuration = var_286_35

					if var_286_35 + var_286_29 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_35 + var_286_29
					end
				end

				arg_283_1.text_.text = var_286_32
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_36 = math.max(var_286_30, arg_283_1.talkMaxDuration)

			if var_286_29 <= arg_283_1.time_ and arg_283_1.time_ < var_286_29 + var_286_36 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_29) / var_286_36

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_29 + var_286_36 and arg_283_1.time_ < var_286_29 + var_286_36 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play424111066 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 424111066
		arg_287_1.duration_ = 4.37

		local var_287_0 = {
			zh = 4.366,
			ja = 4.233
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
				arg_287_0:Play424111067(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["10153"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps10153 == nil then
				arg_287_1.var_.actorSpriteComps10153 = var_290_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_2 = 0.2

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.actorSpriteComps10153 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps10153:ToTable()) do
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

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps10153 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_290_3 then
						if arg_287_1.isInRecall_ then
							iter_290_3.color = arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_290_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_287_1.var_.actorSpriteComps10153 = nil
			end

			local var_290_8 = arg_287_1.actors_["10153"].transform
			local var_290_9 = 0

			if var_290_9 < arg_287_1.time_ and arg_287_1.time_ <= var_290_9 + arg_290_0 then
				arg_287_1.var_.moveOldPos10153 = var_290_8.localPosition
				var_290_8.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("10153", 3)

				local var_290_10 = var_290_8.childCount

				for iter_290_4 = 0, var_290_10 - 1 do
					local var_290_11 = var_290_8:GetChild(iter_290_4)

					if var_290_11.name == "split_3" or not string.find(var_290_11.name, "split") then
						var_290_11.gameObject:SetActive(true)
					else
						var_290_11.gameObject:SetActive(false)
					end
				end
			end

			local var_290_12 = 0.001

			if var_290_9 <= arg_287_1.time_ and arg_287_1.time_ < var_290_9 + var_290_12 then
				local var_290_13 = (arg_287_1.time_ - var_290_9) / var_290_12
				local var_290_14 = Vector3.New(-60, -395, -330)

				var_290_8.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10153, var_290_14, var_290_13)
			end

			if arg_287_1.time_ >= var_290_9 + var_290_12 and arg_287_1.time_ < var_290_9 + var_290_12 + arg_290_0 then
				var_290_8.localPosition = Vector3.New(-60, -395, -330)
			end

			local var_290_15 = 0
			local var_290_16 = 0.4

			if var_290_15 < arg_287_1.time_ and arg_287_1.time_ <= var_290_15 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_17 = arg_287_1:FormatText(StoryNameCfg[1387].name)

				arg_287_1.leftNameTxt_.text = var_290_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_18 = arg_287_1:GetWordFromCfg(424111066)
				local var_290_19 = arg_287_1:FormatText(var_290_18.content)

				arg_287_1.text_.text = var_290_19

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_20 = 16
				local var_290_21 = utf8.len(var_290_19)
				local var_290_22 = var_290_20 <= 0 and var_290_16 or var_290_16 * (var_290_21 / var_290_20)

				if var_290_22 > 0 and var_290_16 < var_290_22 then
					arg_287_1.talkMaxDuration = var_290_22

					if var_290_22 + var_290_15 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_22 + var_290_15
					end
				end

				arg_287_1.text_.text = var_290_19
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111066", "story_v_out_424111.awb") ~= 0 then
					local var_290_23 = manager.audio:GetVoiceLength("story_v_out_424111", "424111066", "story_v_out_424111.awb") / 1000

					if var_290_23 + var_290_15 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_23 + var_290_15
					end

					if var_290_18.prefab_name ~= "" and arg_287_1.actors_[var_290_18.prefab_name] ~= nil then
						local var_290_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_18.prefab_name].transform, "story_v_out_424111", "424111066", "story_v_out_424111.awb")

						arg_287_1:RecordAudio("424111066", var_290_24)
						arg_287_1:RecordAudio("424111066", var_290_24)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_424111", "424111066", "story_v_out_424111.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_424111", "424111066", "story_v_out_424111.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_25 = math.max(var_290_16, arg_287_1.talkMaxDuration)

			if var_290_15 <= arg_287_1.time_ and arg_287_1.time_ < var_290_15 + var_290_25 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_15) / var_290_25

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_15 + var_290_25 and arg_287_1.time_ < var_290_15 + var_290_25 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0329999998211861,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play424111067 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 424111067
		arg_291_1.duration_ = 6.97

		local var_291_0 = {
			zh = 6.4,
			ja = 6.966
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
				arg_291_0:Play424111068(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = "SS2403"

			if arg_291_1.bgs_[var_294_0] == nil then
				local var_294_1 = Object.Instantiate(arg_291_1.paintGo_)

				var_294_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_294_0)
				var_294_1.name = var_294_0
				var_294_1.transform.parent = arg_291_1.stage_.transform
				var_294_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_291_1.bgs_[var_294_0] = var_294_1
			end

			local var_294_2 = 2

			if var_294_2 < arg_291_1.time_ and arg_291_1.time_ <= var_294_2 + arg_294_0 then
				local var_294_3 = manager.ui.mainCamera.transform.localPosition
				local var_294_4 = Vector3.New(0, 0, 10) + Vector3.New(var_294_3.x, var_294_3.y, 0)
				local var_294_5 = arg_291_1.bgs_.SS2403

				var_294_5.transform.localPosition = var_294_4
				var_294_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_294_6 = var_294_5:GetComponent("SpriteRenderer")

				if var_294_6 and var_294_6.sprite then
					local var_294_7 = (var_294_5.transform.localPosition - var_294_3).z
					local var_294_8 = manager.ui.mainCameraCom_
					local var_294_9 = 2 * var_294_7 * Mathf.Tan(var_294_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_294_10 = var_294_9 * var_294_8.aspect
					local var_294_11 = var_294_6.sprite.bounds.size.x
					local var_294_12 = var_294_6.sprite.bounds.size.y
					local var_294_13 = var_294_10 / var_294_11
					local var_294_14 = var_294_9 / var_294_12
					local var_294_15 = var_294_14 < var_294_13 and var_294_13 or var_294_14

					var_294_5.transform.localScale = Vector3.New(var_294_15, var_294_15, 0)
				end

				for iter_294_0, iter_294_1 in pairs(arg_291_1.bgs_) do
					if iter_294_0 ~= "SS2403" then
						iter_294_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_294_16 = 4

			if var_294_16 < arg_291_1.time_ and arg_291_1.time_ <= var_294_16 + arg_294_0 then
				arg_291_1.allBtn_.enabled = false
			end

			local var_294_17 = 0.3

			if arg_291_1.time_ >= var_294_16 + var_294_17 and arg_291_1.time_ < var_294_16 + var_294_17 + arg_294_0 then
				arg_291_1.allBtn_.enabled = true
			end

			local var_294_18 = 0

			if var_294_18 < arg_291_1.time_ and arg_291_1.time_ <= var_294_18 + arg_294_0 then
				arg_291_1.mask_.enabled = true
				arg_291_1.mask_.raycastTarget = true

				arg_291_1:SetGaussion(false)
			end

			local var_294_19 = 2

			if var_294_18 <= arg_291_1.time_ and arg_291_1.time_ < var_294_18 + var_294_19 then
				local var_294_20 = (arg_291_1.time_ - var_294_18) / var_294_19
				local var_294_21 = Color.New(0, 0, 0)

				var_294_21.a = Mathf.Lerp(0, 1, var_294_20)
				arg_291_1.mask_.color = var_294_21
			end

			if arg_291_1.time_ >= var_294_18 + var_294_19 and arg_291_1.time_ < var_294_18 + var_294_19 + arg_294_0 then
				local var_294_22 = Color.New(0, 0, 0)

				var_294_22.a = 1
				arg_291_1.mask_.color = var_294_22
			end

			local var_294_23 = 2

			if var_294_23 < arg_291_1.time_ and arg_291_1.time_ <= var_294_23 + arg_294_0 then
				arg_291_1.mask_.enabled = true
				arg_291_1.mask_.raycastTarget = true

				arg_291_1:SetGaussion(false)
			end

			local var_294_24 = 2

			if var_294_23 <= arg_291_1.time_ and arg_291_1.time_ < var_294_23 + var_294_24 then
				local var_294_25 = (arg_291_1.time_ - var_294_23) / var_294_24
				local var_294_26 = Color.New(0, 0, 0)

				var_294_26.a = Mathf.Lerp(1, 0, var_294_25)
				arg_291_1.mask_.color = var_294_26
			end

			if arg_291_1.time_ >= var_294_23 + var_294_24 and arg_291_1.time_ < var_294_23 + var_294_24 + arg_294_0 then
				local var_294_27 = Color.New(0, 0, 0)
				local var_294_28 = 0

				arg_291_1.mask_.enabled = false
				var_294_27.a = var_294_28
				arg_291_1.mask_.color = var_294_27
			end

			local var_294_29 = arg_291_1.actors_["10153"]
			local var_294_30 = 1.966

			if var_294_30 < arg_291_1.time_ and arg_291_1.time_ <= var_294_30 + arg_294_0 and not isNil(var_294_29) and arg_291_1.var_.actorSpriteComps10153 == nil then
				arg_291_1.var_.actorSpriteComps10153 = var_294_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_31 = 0.034

			if var_294_30 <= arg_291_1.time_ and arg_291_1.time_ < var_294_30 + var_294_31 and not isNil(var_294_29) then
				local var_294_32 = (arg_291_1.time_ - var_294_30) / var_294_31

				if arg_291_1.var_.actorSpriteComps10153 then
					for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_294_3 then
							if arg_291_1.isInRecall_ then
								local var_294_33 = Mathf.Lerp(iter_294_3.color.r, arg_291_1.hightColor2.r, var_294_32)
								local var_294_34 = Mathf.Lerp(iter_294_3.color.g, arg_291_1.hightColor2.g, var_294_32)
								local var_294_35 = Mathf.Lerp(iter_294_3.color.b, arg_291_1.hightColor2.b, var_294_32)

								iter_294_3.color = Color.New(var_294_33, var_294_34, var_294_35)
							else
								local var_294_36 = Mathf.Lerp(iter_294_3.color.r, 0.5, var_294_32)

								iter_294_3.color = Color.New(var_294_36, var_294_36, var_294_36)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= var_294_30 + var_294_31 and arg_291_1.time_ < var_294_30 + var_294_31 + arg_294_0 and not isNil(var_294_29) and arg_291_1.var_.actorSpriteComps10153 then
				for iter_294_4, iter_294_5 in pairs(arg_291_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_294_5 then
						if arg_291_1.isInRecall_ then
							iter_294_5.color = arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_294_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps10153 = nil
			end

			local var_294_37 = arg_291_1.actors_["10153"].transform
			local var_294_38 = 1.966

			if var_294_38 < arg_291_1.time_ and arg_291_1.time_ <= var_294_38 + arg_294_0 then
				arg_291_1.var_.moveOldPos10153 = var_294_37.localPosition
				var_294_37.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("10153", 7)

				local var_294_39 = var_294_37.childCount

				for iter_294_6 = 0, var_294_39 - 1 do
					local var_294_40 = var_294_37:GetChild(iter_294_6)

					if var_294_40.name == "" or not string.find(var_294_40.name, "split") then
						var_294_40.gameObject:SetActive(true)
					else
						var_294_40.gameObject:SetActive(false)
					end
				end
			end

			local var_294_41 = 0.001

			if var_294_38 <= arg_291_1.time_ and arg_291_1.time_ < var_294_38 + var_294_41 then
				local var_294_42 = (arg_291_1.time_ - var_294_38) / var_294_41
				local var_294_43 = Vector3.New(0, -2000, 0)

				var_294_37.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10153, var_294_43, var_294_42)
			end

			if arg_291_1.time_ >= var_294_38 + var_294_41 and arg_291_1.time_ < var_294_38 + var_294_41 + arg_294_0 then
				var_294_37.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_294_44 = manager.ui.mainCamera.transform
			local var_294_45 = 2

			if var_294_45 < arg_291_1.time_ and arg_291_1.time_ <= var_294_45 + arg_294_0 then
				local var_294_46 = arg_291_1.var_.effecthainenghudun1

				if var_294_46 then
					Object.Destroy(var_294_46)

					arg_291_1.var_.effecthainenghudun1 = nil
				end
			end

			local var_294_47 = manager.ui.mainCamera.transform
			local var_294_48 = 2

			if var_294_48 < arg_291_1.time_ and arg_291_1.time_ <= var_294_48 + arg_294_0 then
				local var_294_49 = arg_291_1.var_.effecthailasongbie1
				local var_294_50
				local var_294_51 = var_294_47

				if not var_294_49 then
					var_294_49 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blueglow"), var_294_51)
					var_294_49.name = "hailasongbie1"
					arg_291_1.var_.effecthailasongbie1 = var_294_49
				else
					var_294_49.transform:SetParent(var_294_51)
				end

				var_294_49.transform.localPosition = Vector3.New(0, 0, 0)
				var_294_49.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_294_52 = manager.ui.mainCameraCom_
				local var_294_53 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_294_52.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_294_54 = var_294_49.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_294_55 = 15
				local var_294_56 = 2 * var_294_55 * Mathf.Tan(var_294_52.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_294_52.aspect
				local var_294_57 = 1
				local var_294_58 = 1.7777777777777777

				if var_294_58 < var_294_52.aspect then
					var_294_57 = var_294_56 / (2 * var_294_55 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_294_58)
				end

				for iter_294_7, iter_294_8 in ipairs(var_294_54) do
					local var_294_59 = iter_294_8.transform.localScale

					iter_294_8.transform.localScale = Vector3.New(var_294_59.x / var_294_53 * var_294_57, var_294_59.y / var_294_53, var_294_59.z)
				end
			end

			local var_294_60 = arg_291_1.bgs_.SS2403.transform
			local var_294_61 = 2

			if var_294_61 < arg_291_1.time_ and arg_291_1.time_ <= var_294_61 + arg_294_0 then
				arg_291_1.var_.moveOldPosSS2403 = var_294_60.localPosition
			end

			local var_294_62 = 2.075

			if var_294_61 <= arg_291_1.time_ and arg_291_1.time_ < var_294_61 + var_294_62 then
				local var_294_63 = (arg_291_1.time_ - var_294_61) / var_294_62
				local var_294_64 = Vector3.New(0, 1, 10)

				var_294_60.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPosSS2403, var_294_64, var_294_63)
			end

			if arg_291_1.time_ >= var_294_61 + var_294_62 and arg_291_1.time_ < var_294_61 + var_294_62 + arg_294_0 then
				var_294_60.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_291_1.frameCnt_ <= 1 then
				arg_291_1.dialog_:SetActive(false)
			end

			local var_294_65 = 4
			local var_294_66 = 0.175

			if var_294_65 < arg_291_1.time_ and arg_291_1.time_ <= var_294_65 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0

				arg_291_1.dialog_:SetActive(true)

				arg_291_1.dialogCg_.alpha = 0

				local var_294_67 = LeanTween.value(arg_291_1.dialog_, 0, 1, 0.3)

				var_294_67:setOnUpdate(LuaHelper.FloatAction(function(arg_295_0)
					arg_291_1.dialogCg_.alpha = arg_295_0
				end))
				var_294_67:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_291_1.dialog_)
					var_294_67:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_291_1.duration_ = arg_291_1.duration_ + 0.3

				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_68 = arg_291_1:FormatText(StoryNameCfg[181].name)

				arg_291_1.leftNameTxt_.text = var_294_68

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_69 = arg_291_1:GetWordFromCfg(424111067)
				local var_294_70 = arg_291_1:FormatText(var_294_69.content)

				arg_291_1.text_.text = var_294_70

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_71 = 7
				local var_294_72 = utf8.len(var_294_70)
				local var_294_73 = var_294_71 <= 0 and var_294_66 or var_294_66 * (var_294_72 / var_294_71)

				if var_294_73 > 0 and var_294_66 < var_294_73 then
					arg_291_1.talkMaxDuration = var_294_73
					var_294_65 = var_294_65 + 0.3

					if var_294_73 + var_294_65 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_73 + var_294_65
					end
				end

				arg_291_1.text_.text = var_294_70
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111067", "story_v_out_424111.awb") ~= 0 then
					local var_294_74 = manager.audio:GetVoiceLength("story_v_out_424111", "424111067", "story_v_out_424111.awb") / 1000

					if var_294_74 + var_294_65 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_74 + var_294_65
					end

					if var_294_69.prefab_name ~= "" and arg_291_1.actors_[var_294_69.prefab_name] ~= nil then
						local var_294_75 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_69.prefab_name].transform, "story_v_out_424111", "424111067", "story_v_out_424111.awb")

						arg_291_1:RecordAudio("424111067", var_294_75)
						arg_291_1:RecordAudio("424111067", var_294_75)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_424111", "424111067", "story_v_out_424111.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_424111", "424111067", "story_v_out_424111.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_76 = var_294_65 + 0.3
			local var_294_77 = math.max(var_294_66, arg_291_1.talkMaxDuration)

			if var_294_76 <= arg_291_1.time_ and arg_291_1.time_ < var_294_76 + var_294_77 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_76) / var_294_77

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_76 + var_294_77 and arg_291_1.time_ < var_294_76 + var_294_77 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2403",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.075,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0, 3),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play424111068 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 424111068
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play424111069(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0.1
			local var_300_1 = 1

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				local var_300_2 = "play"
				local var_300_3 = "effect"

				arg_297_1:AudioAction(var_300_2, var_300_3, "se_story_145", "se_story_145_summon_light", "")
			end

			local var_300_4 = 0
			local var_300_5 = 0.95

			if var_300_4 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_6 = arg_297_1:GetWordFromCfg(424111068)
				local var_300_7 = arg_297_1:FormatText(var_300_6.content)

				arg_297_1.text_.text = var_300_7

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_8 = 38
				local var_300_9 = utf8.len(var_300_7)
				local var_300_10 = var_300_8 <= 0 and var_300_5 or var_300_5 * (var_300_9 / var_300_8)

				if var_300_10 > 0 and var_300_5 < var_300_10 then
					arg_297_1.talkMaxDuration = var_300_10

					if var_300_10 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_10 + var_300_4
					end
				end

				arg_297_1.text_.text = var_300_7
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_11 = math.max(var_300_5, arg_297_1.talkMaxDuration)

			if var_300_4 <= arg_297_1.time_ and arg_297_1.time_ < var_300_4 + var_300_11 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_4) / var_300_11

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_4 + var_300_11 and arg_297_1.time_ < var_300_4 + var_300_11 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play424111069 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 424111069
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play424111070(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.233333333333333
			local var_304_1 = 1

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				local var_304_2 = "play"
				local var_304_3 = "effect"

				arg_301_1:AudioAction(var_304_2, var_304_3, "se_story_136", "se_story_136_metalhit", "")
			end

			local var_304_4 = 0
			local var_304_5 = 1.55

			if var_304_4 < arg_301_1.time_ and arg_301_1.time_ <= var_304_4 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_6 = arg_301_1:GetWordFromCfg(424111069)
				local var_304_7 = arg_301_1:FormatText(var_304_6.content)

				arg_301_1.text_.text = var_304_7

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_8 = 62
				local var_304_9 = utf8.len(var_304_7)
				local var_304_10 = var_304_8 <= 0 and var_304_5 or var_304_5 * (var_304_9 / var_304_8)

				if var_304_10 > 0 and var_304_5 < var_304_10 then
					arg_301_1.talkMaxDuration = var_304_10

					if var_304_10 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_4
					end
				end

				arg_301_1.text_.text = var_304_7
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_11 = math.max(var_304_5, arg_301_1.talkMaxDuration)

			if var_304_4 <= arg_301_1.time_ and arg_301_1.time_ < var_304_4 + var_304_11 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_4) / var_304_11

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_4 + var_304_11 and arg_301_1.time_ < var_304_4 + var_304_11 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play424111070 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 424111070
		arg_305_1.duration_ = 6.7

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play424111071(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = "SS2403a"

			if arg_305_1.bgs_[var_308_0] == nil then
				local var_308_1 = Object.Instantiate(arg_305_1.paintGo_)

				var_308_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_308_0)
				var_308_1.name = var_308_0
				var_308_1.transform.parent = arg_305_1.stage_.transform
				var_308_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_305_1.bgs_[var_308_0] = var_308_1
			end

			local var_308_2 = 1.2

			if var_308_2 < arg_305_1.time_ and arg_305_1.time_ <= var_308_2 + arg_308_0 then
				local var_308_3 = manager.ui.mainCamera.transform.localPosition
				local var_308_4 = Vector3.New(0, 0, 10) + Vector3.New(var_308_3.x, var_308_3.y, 0)
				local var_308_5 = arg_305_1.bgs_.SS2403a

				var_308_5.transform.localPosition = var_308_4
				var_308_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_308_6 = var_308_5:GetComponent("SpriteRenderer")

				if var_308_6 and var_308_6.sprite then
					local var_308_7 = (var_308_5.transform.localPosition - var_308_3).z
					local var_308_8 = manager.ui.mainCameraCom_
					local var_308_9 = 2 * var_308_7 * Mathf.Tan(var_308_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_308_10 = var_308_9 * var_308_8.aspect
					local var_308_11 = var_308_6.sprite.bounds.size.x
					local var_308_12 = var_308_6.sprite.bounds.size.y
					local var_308_13 = var_308_10 / var_308_11
					local var_308_14 = var_308_9 / var_308_12
					local var_308_15 = var_308_14 < var_308_13 and var_308_13 or var_308_14

					var_308_5.transform.localScale = Vector3.New(var_308_15, var_308_15, 0)
				end

				for iter_308_0, iter_308_1 in pairs(arg_305_1.bgs_) do
					if iter_308_0 ~= "SS2403a" then
						iter_308_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_308_16 = 1.7

			if var_308_16 < arg_305_1.time_ and arg_305_1.time_ <= var_308_16 + arg_308_0 then
				arg_305_1.allBtn_.enabled = false
			end

			local var_308_17 = 0.3

			if arg_305_1.time_ >= var_308_16 + var_308_17 and arg_305_1.time_ < var_308_16 + var_308_17 + arg_308_0 then
				arg_305_1.allBtn_.enabled = true
			end

			local var_308_18 = manager.ui.mainCamera.transform
			local var_308_19 = 0

			if var_308_19 < arg_305_1.time_ and arg_305_1.time_ <= var_308_19 + arg_308_0 then
				local var_308_20 = arg_305_1.var_.effecthailazhuanchang
				local var_308_21
				local var_308_22 = var_308_18

				if not var_308_20 then
					var_308_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), var_308_22)
					var_308_20.name = "hailazhuanchang"
					arg_305_1.var_.effecthailazhuanchang = var_308_20
				else
					var_308_20.transform:SetParent(var_308_22)
				end

				var_308_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_308_20.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_308_23 = manager.ui.mainCameraCom_
				local var_308_24 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_308_23.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_308_25 = var_308_20.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_308_26 = 15
				local var_308_27 = 2 * var_308_26 * Mathf.Tan(var_308_23.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_308_23.aspect
				local var_308_28 = 1
				local var_308_29 = 1.7777777777777777

				if var_308_29 < var_308_23.aspect then
					var_308_28 = var_308_27 / (2 * var_308_26 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_308_29)
				end

				for iter_308_2, iter_308_3 in ipairs(var_308_25) do
					local var_308_30 = iter_308_3.transform.localScale

					iter_308_3.transform.localScale = Vector3.New(var_308_30.x / var_308_24 * var_308_28, var_308_30.y / var_308_24, var_308_30.z)
				end
			end

			local var_308_31 = manager.ui.mainCamera.transform
			local var_308_32 = 1.2

			if var_308_32 < arg_305_1.time_ and arg_305_1.time_ <= var_308_32 + arg_308_0 then
				local var_308_33 = arg_305_1.var_.effecthailazhuanchang

				if var_308_33 then
					Object.Destroy(var_308_33)

					arg_305_1.var_.effecthailazhuanchang = nil
				end
			end

			local var_308_34 = manager.ui.mainCamera.transform
			local var_308_35 = 1.2

			if var_308_35 < arg_305_1.time_ and arg_305_1.time_ <= var_308_35 + arg_308_0 then
				local var_308_36 = arg_305_1.var_.effecthailazhuanchang2
				local var_308_37
				local var_308_38 = var_308_34

				if not var_308_36 then
					var_308_36 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), var_308_38)
					var_308_36.name = "hailazhuanchang2"
					arg_305_1.var_.effecthailazhuanchang2 = var_308_36
				else
					var_308_36.transform:SetParent(var_308_38)
				end

				var_308_36.transform.localPosition = Vector3.New(0, 0, 0)
				var_308_36.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_308_39 = manager.ui.mainCameraCom_
				local var_308_40 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_308_39.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_308_41 = var_308_36.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_308_42 = 15
				local var_308_43 = 2 * var_308_42 * Mathf.Tan(var_308_39.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_308_39.aspect
				local var_308_44 = 1
				local var_308_45 = 1.7777777777777777

				if var_308_45 < var_308_39.aspect then
					var_308_44 = var_308_43 / (2 * var_308_42 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_308_45)
				end

				for iter_308_4, iter_308_5 in ipairs(var_308_41) do
					local var_308_46 = iter_308_5.transform.localScale

					iter_308_5.transform.localScale = Vector3.New(var_308_46.x / var_308_40 * var_308_44, var_308_46.y / var_308_40, var_308_46.z)
				end
			end

			local var_308_47 = arg_305_1.bgs_.SS2403a.transform
			local var_308_48 = 1.2

			if var_308_48 < arg_305_1.time_ and arg_305_1.time_ <= var_308_48 + arg_308_0 then
				arg_305_1.var_.moveOldPosSS2403a = var_308_47.localPosition
			end

			local var_308_49 = 1.76666666666667

			if var_308_48 <= arg_305_1.time_ and arg_305_1.time_ < var_308_48 + var_308_49 then
				local var_308_50 = (arg_305_1.time_ - var_308_48) / var_308_49
				local var_308_51 = Vector3.New(0, 1, 9)

				var_308_47.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPosSS2403a, var_308_51, var_308_50)
			end

			if arg_305_1.time_ >= var_308_48 + var_308_49 and arg_305_1.time_ < var_308_48 + var_308_49 + arg_308_0 then
				var_308_47.localPosition = Vector3.New(0, 1, 9)
			end

			if arg_305_1.frameCnt_ <= 1 then
				arg_305_1.dialog_:SetActive(false)
			end

			local var_308_52 = 1.7
			local var_308_53 = 0.075

			if var_308_52 < arg_305_1.time_ and arg_305_1.time_ <= var_308_52 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0

				arg_305_1.dialog_:SetActive(true)

				arg_305_1.dialogCg_.alpha = 0

				local var_308_54 = LeanTween.value(arg_305_1.dialog_, 0, 1, 0.3)

				var_308_54:setOnUpdate(LuaHelper.FloatAction(function(arg_309_0)
					arg_305_1.dialogCg_.alpha = arg_309_0
				end))
				var_308_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_305_1.dialog_)
					var_308_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_305_1.duration_ = arg_305_1.duration_ + 0.3

				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_55 = arg_305_1:FormatText(StoryNameCfg[1409].name)

				arg_305_1.leftNameTxt_.text = var_308_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Timor")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_56 = arg_305_1:GetWordFromCfg(424111070)
				local var_308_57 = arg_305_1:FormatText(var_308_56.content)

				arg_305_1.text_.text = var_308_57

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_58 = 3
				local var_308_59 = utf8.len(var_308_57)
				local var_308_60 = var_308_58 <= 0 and var_308_53 or var_308_53 * (var_308_59 / var_308_58)

				if var_308_60 > 0 and var_308_53 < var_308_60 then
					arg_305_1.talkMaxDuration = var_308_60
					var_308_52 = var_308_52 + 0.3

					if var_308_60 + var_308_52 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_60 + var_308_52
					end
				end

				arg_305_1.text_.text = var_308_57
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_61 = var_308_52 + 0.3
			local var_308_62 = math.max(var_308_53, arg_305_1.talkMaxDuration)

			if var_308_61 <= arg_305_1.time_ and arg_305_1.time_ < var_308_61 + var_308_62 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_61) / var_308_62

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_61 + var_308_62 and arg_305_1.time_ < var_308_61 + var_308_62 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2403a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.76666666666667,
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play424111071 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 424111071
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play424111072(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0
			local var_314_1 = 0.925

			if var_314_0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_2 = arg_311_1:GetWordFromCfg(424111071)
				local var_314_3 = arg_311_1:FormatText(var_314_2.content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_4 = 37
				local var_314_5 = utf8.len(var_314_3)
				local var_314_6 = var_314_4 <= 0 and var_314_1 or var_314_1 * (var_314_5 / var_314_4)

				if var_314_6 > 0 and var_314_1 < var_314_6 then
					arg_311_1.talkMaxDuration = var_314_6

					if var_314_6 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_6 + var_314_0
					end
				end

				arg_311_1.text_.text = var_314_3
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_7 = math.max(var_314_1, arg_311_1.talkMaxDuration)

			if var_314_0 <= arg_311_1.time_ and arg_311_1.time_ < var_314_0 + var_314_7 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_0) / var_314_7

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_0 + var_314_7 and arg_311_1.time_ < var_314_0 + var_314_7 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play424111072 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 424111072
		arg_315_1.duration_ = 1.27

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play424111073(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0
			local var_318_1 = 0.1

			if var_318_0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_2 = arg_315_1:FormatText(StoryNameCfg[181].name)

				arg_315_1.leftNameTxt_.text = var_318_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_3 = arg_315_1:GetWordFromCfg(424111072)
				local var_318_4 = arg_315_1:FormatText(var_318_3.content)

				arg_315_1.text_.text = var_318_4

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 4
				local var_318_6 = utf8.len(var_318_4)
				local var_318_7 = var_318_5 <= 0 and var_318_1 or var_318_1 * (var_318_6 / var_318_5)

				if var_318_7 > 0 and var_318_1 < var_318_7 then
					arg_315_1.talkMaxDuration = var_318_7

					if var_318_7 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_7 + var_318_0
					end
				end

				arg_315_1.text_.text = var_318_4
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111072", "story_v_out_424111.awb") ~= 0 then
					local var_318_8 = manager.audio:GetVoiceLength("story_v_out_424111", "424111072", "story_v_out_424111.awb") / 1000

					if var_318_8 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_8 + var_318_0
					end

					if var_318_3.prefab_name ~= "" and arg_315_1.actors_[var_318_3.prefab_name] ~= nil then
						local var_318_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_3.prefab_name].transform, "story_v_out_424111", "424111072", "story_v_out_424111.awb")

						arg_315_1:RecordAudio("424111072", var_318_9)
						arg_315_1:RecordAudio("424111072", var_318_9)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_424111", "424111072", "story_v_out_424111.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_424111", "424111072", "story_v_out_424111.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_10 = math.max(var_318_1, arg_315_1.talkMaxDuration)

			if var_318_0 <= arg_315_1.time_ and arg_315_1.time_ < var_318_0 + var_318_10 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_0) / var_318_10

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_0 + var_318_10 and arg_315_1.time_ < var_318_0 + var_318_10 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play424111073 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 424111073
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play424111074(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = manager.ui.mainCamera.transform
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				local var_322_2 = arg_319_1.var_.effectshennengshoushudao
				local var_322_3
				local var_322_4 = var_322_0

				if not var_322_2 then
					var_322_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_scan_in_out"), var_322_4)
					var_322_2.name = "shennengshoushudao"
					arg_319_1.var_.effectshennengshoushudao = var_322_2
				else
					var_322_2.transform:SetParent(var_322_4)
				end

				var_322_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_322_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_322_5 = manager.ui.mainCameraCom_
				local var_322_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_322_5.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_322_7 = var_322_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_322_8 = 15
				local var_322_9 = 2 * var_322_8 * Mathf.Tan(var_322_5.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_322_5.aspect
				local var_322_10 = 1
				local var_322_11 = 1.7777777777777777

				if var_322_11 < var_322_5.aspect then
					var_322_10 = var_322_9 / (2 * var_322_8 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_322_11)
				end

				for iter_322_0, iter_322_1 in ipairs(var_322_7) do
					local var_322_12 = iter_322_1.transform.localScale

					iter_322_1.transform.localScale = Vector3.New(var_322_12.x / var_322_6 * var_322_10, var_322_12.y / var_322_6, var_322_12.z)
				end
			end

			local var_322_13 = manager.ui.mainCamera.transform
			local var_322_14 = 1.83333333333333

			if var_322_14 < arg_319_1.time_ and arg_319_1.time_ <= var_322_14 + arg_322_0 then
				local var_322_15 = arg_319_1.var_.effectshennengshoushudao

				if var_322_15 then
					Object.Destroy(var_322_15)

					arg_319_1.var_.effectshennengshoushudao = nil
				end
			end

			local var_322_16
			local var_322_17 = 0

			if var_322_17 < arg_319_1.time_ and arg_319_1.time_ <= var_322_17 + arg_322_0 then
				local var_322_18 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_322_18 then
					var_322_18.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_322_18.radialBlurScale = 0
					var_322_18.radialBlurGradient = 1
					var_322_18.radialBlurIntensity = 1

					if var_322_16 then
						var_322_18.radialBlurTarget = var_322_16.transform
					end
				end
			end

			local var_322_19 = 1

			if var_322_17 <= arg_319_1.time_ and arg_319_1.time_ < var_322_17 + var_322_19 then
				local var_322_20 = (arg_319_1.time_ - var_322_17) / var_322_19
				local var_322_21 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_322_21 then
					var_322_21.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_322_21.radialBlurScale = Mathf.Lerp(0, 0.272, var_322_20)
					var_322_21.radialBlurGradient = Mathf.Lerp(1, 1, var_322_20)
					var_322_21.radialBlurIntensity = Mathf.Lerp(1, 1, var_322_20)
				end
			end

			if arg_319_1.time_ >= var_322_17 + var_322_19 and arg_319_1.time_ < var_322_17 + var_322_19 + arg_322_0 then
				local var_322_22 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_322_22 then
					var_322_22.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_322_22.radialBlurScale = 0.272
					var_322_22.radialBlurGradient = 1
					var_322_22.radialBlurIntensity = 1
				end
			end

			local var_322_23 = 0
			local var_322_24 = 1

			if var_322_23 < arg_319_1.time_ and arg_319_1.time_ <= var_322_23 + arg_322_0 then
				local var_322_25 = "play"
				local var_322_26 = "effect"

				arg_319_1:AudioAction(var_322_25, var_322_26, "se_story_126_01", "se_story_126_01_Portal", "")
			end

			local var_322_27 = 0
			local var_322_28 = 1.5

			if var_322_27 < arg_319_1.time_ and arg_319_1.time_ <= var_322_27 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_29 = arg_319_1:GetWordFromCfg(424111073)
				local var_322_30 = arg_319_1:FormatText(var_322_29.content)

				arg_319_1.text_.text = var_322_30

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_31 = 60
				local var_322_32 = utf8.len(var_322_30)
				local var_322_33 = var_322_31 <= 0 and var_322_28 or var_322_28 * (var_322_32 / var_322_31)

				if var_322_33 > 0 and var_322_28 < var_322_33 then
					arg_319_1.talkMaxDuration = var_322_33

					if var_322_33 + var_322_27 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_33 + var_322_27
					end
				end

				arg_319_1.text_.text = var_322_30
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_34 = math.max(var_322_28, arg_319_1.talkMaxDuration)

			if var_322_27 <= arg_319_1.time_ and arg_319_1.time_ < var_322_27 + var_322_34 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_27) / var_322_34

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_27 + var_322_34 and arg_319_1.time_ < var_322_27 + var_322_34 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play424111074 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 424111074
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play424111075(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = 0
			local var_326_1 = 1

			if var_326_0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_0 + arg_326_0 then
				local var_326_2 = "play"
				local var_326_3 = "effect"

				arg_323_1:AudioAction(var_326_2, var_326_3, "se_story_146", "se_story_146_roar02", "")
			end

			local var_326_4 = 0
			local var_326_5 = 0.1

			if var_326_4 < arg_323_1.time_ and arg_323_1.time_ <= var_326_4 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_6 = arg_323_1:FormatText(StoryNameCfg[1409].name)

				arg_323_1.leftNameTxt_.text = var_326_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, true)
				arg_323_1.iconController_:SetSelectedState("hero")

				arg_323_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Timor")

				arg_323_1.callingController_:SetSelectedState("normal")

				arg_323_1.keyicon_.color = Color.New(1, 1, 1)
				arg_323_1.icon_.color = Color.New(1, 1, 1)

				local var_326_7 = arg_323_1:GetWordFromCfg(424111074)
				local var_326_8 = arg_323_1:FormatText(var_326_7.content)

				arg_323_1.text_.text = var_326_8

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_9 = 4
				local var_326_10 = utf8.len(var_326_8)
				local var_326_11 = var_326_9 <= 0 and var_326_5 or var_326_5 * (var_326_10 / var_326_9)

				if var_326_11 > 0 and var_326_5 < var_326_11 then
					arg_323_1.talkMaxDuration = var_326_11

					if var_326_11 + var_326_4 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_11 + var_326_4
					end
				end

				arg_323_1.text_.text = var_326_8
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_12 = math.max(var_326_5, arg_323_1.talkMaxDuration)

			if var_326_4 <= arg_323_1.time_ and arg_323_1.time_ < var_326_4 + var_326_12 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_4) / var_326_12

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_4 + var_326_12 and arg_323_1.time_ < var_326_4 + var_326_12 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play424111075 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 424111075
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play424111076(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0
			local var_330_1 = 1.45

			if var_330_0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_2 = arg_327_1:GetWordFromCfg(424111075)
				local var_330_3 = arg_327_1:FormatText(var_330_2.content)

				arg_327_1.text_.text = var_330_3

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_4 = 58
				local var_330_5 = utf8.len(var_330_3)
				local var_330_6 = var_330_4 <= 0 and var_330_1 or var_330_1 * (var_330_5 / var_330_4)

				if var_330_6 > 0 and var_330_1 < var_330_6 then
					arg_327_1.talkMaxDuration = var_330_6

					if var_330_6 + var_330_0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_6 + var_330_0
					end
				end

				arg_327_1.text_.text = var_330_3
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_7 = math.max(var_330_1, arg_327_1.talkMaxDuration)

			if var_330_0 <= arg_327_1.time_ and arg_327_1.time_ < var_330_0 + var_330_7 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_0) / var_330_7

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_0 + var_330_7 and arg_327_1.time_ < var_330_0 + var_330_7 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play424111076 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 424111076
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play424111077(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0.4
			local var_334_1 = 1

			if var_334_0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_0 + arg_334_0 then
				local var_334_2 = "play"
				local var_334_3 = "effect"

				arg_331_1:AudioAction(var_334_2, var_334_3, "se_story_121_04", "se_story_121_04_rock", "")
			end

			local var_334_4 = 0
			local var_334_5 = 1.4

			if var_334_4 < arg_331_1.time_ and arg_331_1.time_ <= var_334_4 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_6 = arg_331_1:GetWordFromCfg(424111076)
				local var_334_7 = arg_331_1:FormatText(var_334_6.content)

				arg_331_1.text_.text = var_334_7

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_8 = 56
				local var_334_9 = utf8.len(var_334_7)
				local var_334_10 = var_334_8 <= 0 and var_334_5 or var_334_5 * (var_334_9 / var_334_8)

				if var_334_10 > 0 and var_334_5 < var_334_10 then
					arg_331_1.talkMaxDuration = var_334_10

					if var_334_10 + var_334_4 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_10 + var_334_4
					end
				end

				arg_331_1.text_.text = var_334_7
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_11 = math.max(var_334_5, arg_331_1.talkMaxDuration)

			if var_334_4 <= arg_331_1.time_ and arg_331_1.time_ < var_334_4 + var_334_11 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_4) / var_334_11

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_4 + var_334_11 and arg_331_1.time_ < var_334_4 + var_334_11 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play424111077 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 424111077
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play424111078(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0
			local var_338_1 = 0.125

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_2 = arg_335_1:FormatText(StoryNameCfg[7].name)

				arg_335_1.leftNameTxt_.text = var_338_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_3 = arg_335_1:GetWordFromCfg(424111077)
				local var_338_4 = arg_335_1:FormatText(var_338_3.content)

				arg_335_1.text_.text = var_338_4

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 5
				local var_338_6 = utf8.len(var_338_4)
				local var_338_7 = var_338_5 <= 0 and var_338_1 or var_338_1 * (var_338_6 / var_338_5)

				if var_338_7 > 0 and var_338_1 < var_338_7 then
					arg_335_1.talkMaxDuration = var_338_7

					if var_338_7 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_7 + var_338_0
					end
				end

				arg_335_1.text_.text = var_338_4
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_8 = math.max(var_338_1, arg_335_1.talkMaxDuration)

			if var_338_0 <= arg_335_1.time_ and arg_335_1.time_ < var_338_0 + var_338_8 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_0) / var_338_8

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_0 + var_338_8 and arg_335_1.time_ < var_338_0 + var_338_8 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play424111078 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 424111078
		arg_339_1.duration_ = 5.61

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play424111079(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0
			local var_342_1 = 0.5

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				local var_342_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_342_2 then
					var_342_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_342_2.radialBlurScale = 0
					var_342_2.radialBlurGradient = 1
					var_342_2.radialBlurIntensity = 1

					if var_342_0 then
						var_342_2.radialBlurTarget = var_342_0.transform
					end
				end
			end

			local var_342_3 = 0.105201698839664

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_3 then
				local var_342_4 = (arg_339_1.time_ - var_342_1) / var_342_3
				local var_342_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_342_5 then
					var_342_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_342_5.radialBlurScale = Mathf.Lerp(0, 0, var_342_4)
					var_342_5.radialBlurGradient = Mathf.Lerp(1, 1, var_342_4)
					var_342_5.radialBlurIntensity = Mathf.Lerp(1, 1, var_342_4)
				end
			end

			if arg_339_1.time_ >= var_342_1 + var_342_3 and arg_339_1.time_ < var_342_1 + var_342_3 + arg_342_0 then
				local var_342_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_342_6 then
					var_342_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_342_6.radialBlurScale = 0
					var_342_6.radialBlurGradient = 1
					var_342_6.radialBlurIntensity = 1
				end
			end

			local var_342_7 = 0

			if var_342_7 < arg_339_1.time_ and arg_339_1.time_ <= var_342_7 + arg_342_0 then
				arg_339_1.mask_.enabled = true
				arg_339_1.mask_.raycastTarget = true

				arg_339_1:SetGaussion(false)
			end

			local var_342_8 = 0.5

			if var_342_7 <= arg_339_1.time_ and arg_339_1.time_ < var_342_7 + var_342_8 then
				local var_342_9 = (arg_339_1.time_ - var_342_7) / var_342_8
				local var_342_10 = Color.New(1, 1, 1)

				var_342_10.a = Mathf.Lerp(0, 1, var_342_9)
				arg_339_1.mask_.color = var_342_10
			end

			if arg_339_1.time_ >= var_342_7 + var_342_8 and arg_339_1.time_ < var_342_7 + var_342_8 + arg_342_0 then
				local var_342_11 = Color.New(1, 1, 1)

				var_342_11.a = 1
				arg_339_1.mask_.color = var_342_11
			end

			local var_342_12 = 0.5

			if var_342_12 < arg_339_1.time_ and arg_339_1.time_ <= var_342_12 + arg_342_0 then
				arg_339_1.mask_.enabled = true
				arg_339_1.mask_.raycastTarget = true

				arg_339_1:SetGaussion(false)
			end

			local var_342_13 = 0.7

			if var_342_12 <= arg_339_1.time_ and arg_339_1.time_ < var_342_12 + var_342_13 then
				local var_342_14 = (arg_339_1.time_ - var_342_12) / var_342_13
				local var_342_15 = Color.New(1, 1, 1)

				var_342_15.a = Mathf.Lerp(1, 0, var_342_14)
				arg_339_1.mask_.color = var_342_15
			end

			if arg_339_1.time_ >= var_342_12 + var_342_13 and arg_339_1.time_ < var_342_12 + var_342_13 + arg_342_0 then
				local var_342_16 = Color.New(1, 1, 1)
				local var_342_17 = 0

				arg_339_1.mask_.enabled = false
				var_342_16.a = var_342_17
				arg_339_1.mask_.color = var_342_16
			end

			local var_342_18 = manager.ui.mainCamera.transform
			local var_342_19 = 0.5

			if var_342_19 < arg_339_1.time_ and arg_339_1.time_ <= var_342_19 + arg_342_0 then
				arg_339_1.var_.shakeOldPos = var_342_18.localPosition
			end

			local var_342_20 = 0.6

			if var_342_19 <= arg_339_1.time_ and arg_339_1.time_ < var_342_19 + var_342_20 then
				local var_342_21 = (arg_339_1.time_ - var_342_19) / 0.066
				local var_342_22, var_342_23 = math.modf(var_342_21)

				var_342_18.localPosition = Vector3.New(var_342_23 * 0.13, var_342_23 * 0.13, var_342_23 * 0.13) + arg_339_1.var_.shakeOldPos
			end

			if arg_339_1.time_ >= var_342_19 + var_342_20 and arg_339_1.time_ < var_342_19 + var_342_20 + arg_342_0 then
				var_342_18.localPosition = arg_339_1.var_.shakeOldPos
			end

			local var_342_24 = 0
			local var_342_25 = 1

			if var_342_24 < arg_339_1.time_ and arg_339_1.time_ <= var_342_24 + arg_342_0 then
				local var_342_26 = "play"
				local var_342_27 = "effect"

				arg_339_1:AudioAction(var_342_26, var_342_27, "se_story_140", "se_story_140_laser", "")
			end

			if arg_339_1.frameCnt_ <= 1 then
				arg_339_1.dialog_:SetActive(false)
			end

			local var_342_28 = 0.605201698839664
			local var_342_29 = 1.15

			if var_342_28 < arg_339_1.time_ and arg_339_1.time_ <= var_342_28 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0

				arg_339_1.dialog_:SetActive(true)

				arg_339_1.dialogCg_.alpha = 0

				local var_342_30 = LeanTween.value(arg_339_1.dialog_, 0, 1, 0.3)

				var_342_30:setOnUpdate(LuaHelper.FloatAction(function(arg_343_0)
					arg_339_1.dialogCg_.alpha = arg_343_0
				end))
				var_342_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_339_1.dialog_)
					var_342_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_339_1.duration_ = arg_339_1.duration_ + 0.3

				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_31 = arg_339_1:GetWordFromCfg(424111078)
				local var_342_32 = arg_339_1:FormatText(var_342_31.content)

				arg_339_1.text_.text = var_342_32

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_33 = 46
				local var_342_34 = utf8.len(var_342_32)
				local var_342_35 = var_342_33 <= 0 and var_342_29 or var_342_29 * (var_342_34 / var_342_33)

				if var_342_35 > 0 and var_342_29 < var_342_35 then
					arg_339_1.talkMaxDuration = var_342_35
					var_342_28 = var_342_28 + 0.3

					if var_342_35 + var_342_28 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_35 + var_342_28
					end
				end

				arg_339_1.text_.text = var_342_32
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_36 = var_342_28 + 0.3
			local var_342_37 = math.max(var_342_29, arg_339_1.talkMaxDuration)

			if var_342_36 <= arg_339_1.time_ and arg_339_1.time_ < var_342_36 + var_342_37 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_36) / var_342_37

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_36 + var_342_37 and arg_339_1.time_ < var_342_36 + var_342_37 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play424111079 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 424111079
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play424111080(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0
			local var_348_1 = 1

			if var_348_0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_0 + arg_348_0 then
				local var_348_2 = "play"
				local var_348_3 = "effect"

				arg_345_1:AudioAction(var_348_2, var_348_3, "se_story_140", "se_story_140_explosion04", "")
			end

			local var_348_4 = 0
			local var_348_5 = 1.625

			if var_348_4 < arg_345_1.time_ and arg_345_1.time_ <= var_348_4 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_6 = arg_345_1:GetWordFromCfg(424111079)
				local var_348_7 = arg_345_1:FormatText(var_348_6.content)

				arg_345_1.text_.text = var_348_7

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_8 = 65
				local var_348_9 = utf8.len(var_348_7)
				local var_348_10 = var_348_8 <= 0 and var_348_5 or var_348_5 * (var_348_9 / var_348_8)

				if var_348_10 > 0 and var_348_5 < var_348_10 then
					arg_345_1.talkMaxDuration = var_348_10

					if var_348_10 + var_348_4 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_10 + var_348_4
					end
				end

				arg_345_1.text_.text = var_348_7
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_11 = math.max(var_348_5, arg_345_1.talkMaxDuration)

			if var_348_4 <= arg_345_1.time_ and arg_345_1.time_ < var_348_4 + var_348_11 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_4) / var_348_11

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_4 + var_348_11 and arg_345_1.time_ < var_348_4 + var_348_11 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play424111080 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 424111080
		arg_349_1.duration_ = 4.17

		local var_349_0 = {
			zh = 3.233,
			ja = 4.166
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
				arg_349_0:Play424111081(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.bgs_.SS2403a.transform
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.var_.moveOldPosSS2403a = var_352_0.localPosition
			end

			local var_352_2 = 1

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2
				local var_352_4 = Vector3.New(0, 1, 8)

				var_352_0.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPosSS2403a, var_352_4, var_352_3)
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 then
				var_352_0.localPosition = Vector3.New(0, 1, 8)
			end

			local var_352_5 = 0
			local var_352_6 = 0.25

			if var_352_5 < arg_349_1.time_ and arg_349_1.time_ <= var_352_5 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0

				arg_349_1.dialog_:SetActive(true)

				arg_349_1.dialogCg_.alpha = 0

				local var_352_7 = LeanTween.value(arg_349_1.dialog_, 0, 1, 0.3)

				var_352_7:setOnUpdate(LuaHelper.FloatAction(function(arg_353_0)
					arg_349_1.dialogCg_.alpha = arg_353_0
				end))
				var_352_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_349_1.dialog_)
					var_352_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_349_1.duration_ = arg_349_1.duration_ + 0.3

				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_8 = arg_349_1:FormatText(StoryNameCfg[181].name)

				arg_349_1.leftNameTxt_.text = var_352_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_9 = arg_349_1:GetWordFromCfg(424111080)
				local var_352_10 = arg_349_1:FormatText(var_352_9.content)

				arg_349_1.text_.text = var_352_10

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_11 = 10
				local var_352_12 = utf8.len(var_352_10)
				local var_352_13 = var_352_11 <= 0 and var_352_6 or var_352_6 * (var_352_12 / var_352_11)

				if var_352_13 > 0 and var_352_6 < var_352_13 then
					arg_349_1.talkMaxDuration = var_352_13
					var_352_5 = var_352_5 + 0.3

					if var_352_13 + var_352_5 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_13 + var_352_5
					end
				end

				arg_349_1.text_.text = var_352_10
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111080", "story_v_out_424111.awb") ~= 0 then
					local var_352_14 = manager.audio:GetVoiceLength("story_v_out_424111", "424111080", "story_v_out_424111.awb") / 1000

					if var_352_14 + var_352_5 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_14 + var_352_5
					end

					if var_352_9.prefab_name ~= "" and arg_349_1.actors_[var_352_9.prefab_name] ~= nil then
						local var_352_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_9.prefab_name].transform, "story_v_out_424111", "424111080", "story_v_out_424111.awb")

						arg_349_1:RecordAudio("424111080", var_352_15)
						arg_349_1:RecordAudio("424111080", var_352_15)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_424111", "424111080", "story_v_out_424111.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_424111", "424111080", "story_v_out_424111.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_16 = var_352_5 + 0.3
			local var_352_17 = math.max(var_352_6, arg_349_1.talkMaxDuration)

			if var_352_16 <= arg_349_1.time_ and arg_349_1.time_ < var_352_16 + var_352_17 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_16) / var_352_17

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_16 + var_352_17 and arg_349_1.time_ < var_352_16 + var_352_17 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2403a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(0, 1, 8),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play424111081 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 424111081
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play424111082(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0
			local var_358_1 = 1.2

			if var_358_0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_2 = arg_355_1:GetWordFromCfg(424111081)
				local var_358_3 = arg_355_1:FormatText(var_358_2.content)

				arg_355_1.text_.text = var_358_3

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_4 = 48
				local var_358_5 = utf8.len(var_358_3)
				local var_358_6 = var_358_4 <= 0 and var_358_1 or var_358_1 * (var_358_5 / var_358_4)

				if var_358_6 > 0 and var_358_1 < var_358_6 then
					arg_355_1.talkMaxDuration = var_358_6

					if var_358_6 + var_358_0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_6 + var_358_0
					end
				end

				arg_355_1.text_.text = var_358_3
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_7 = math.max(var_358_1, arg_355_1.talkMaxDuration)

			if var_358_0 <= arg_355_1.time_ and arg_355_1.time_ < var_358_0 + var_358_7 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_0) / var_358_7

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_0 + var_358_7 and arg_355_1.time_ < var_358_0 + var_358_7 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play424111082 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 424111082
		arg_359_1.duration_ = 6.5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play424111083(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = "SS2403b"

			if arg_359_1.bgs_[var_362_0] == nil then
				local var_362_1 = Object.Instantiate(arg_359_1.paintGo_)

				var_362_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_362_0)
				var_362_1.name = var_362_0
				var_362_1.transform.parent = arg_359_1.stage_.transform
				var_362_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_359_1.bgs_[var_362_0] = var_362_1
			end

			local var_362_2 = 1

			if var_362_2 < arg_359_1.time_ and arg_359_1.time_ <= var_362_2 + arg_362_0 then
				local var_362_3 = manager.ui.mainCamera.transform.localPosition
				local var_362_4 = Vector3.New(0, 0, 10) + Vector3.New(var_362_3.x, var_362_3.y, 0)
				local var_362_5 = arg_359_1.bgs_.SS2403b

				var_362_5.transform.localPosition = var_362_4
				var_362_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_362_6 = var_362_5:GetComponent("SpriteRenderer")

				if var_362_6 and var_362_6.sprite then
					local var_362_7 = (var_362_5.transform.localPosition - var_362_3).z
					local var_362_8 = manager.ui.mainCameraCom_
					local var_362_9 = 2 * var_362_7 * Mathf.Tan(var_362_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_362_10 = var_362_9 * var_362_8.aspect
					local var_362_11 = var_362_6.sprite.bounds.size.x
					local var_362_12 = var_362_6.sprite.bounds.size.y
					local var_362_13 = var_362_10 / var_362_11
					local var_362_14 = var_362_9 / var_362_12
					local var_362_15 = var_362_14 < var_362_13 and var_362_13 or var_362_14

					var_362_5.transform.localScale = Vector3.New(var_362_15, var_362_15, 0)
				end

				for iter_362_0, iter_362_1 in pairs(arg_359_1.bgs_) do
					if iter_362_0 ~= "SS2403b" then
						iter_362_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_362_16 = 1.5

			if var_362_16 < arg_359_1.time_ and arg_359_1.time_ <= var_362_16 + arg_362_0 then
				arg_359_1.allBtn_.enabled = false
			end

			local var_362_17 = 0.3

			if arg_359_1.time_ >= var_362_16 + var_362_17 and arg_359_1.time_ < var_362_16 + var_362_17 + arg_362_0 then
				arg_359_1.allBtn_.enabled = true
			end

			local var_362_18 = 0

			if var_362_18 < arg_359_1.time_ and arg_359_1.time_ <= var_362_18 + arg_362_0 then
				arg_359_1.mask_.enabled = true
				arg_359_1.mask_.raycastTarget = true

				arg_359_1:SetGaussion(false)
			end

			local var_362_19 = 1

			if var_362_18 <= arg_359_1.time_ and arg_359_1.time_ < var_362_18 + var_362_19 then
				local var_362_20 = (arg_359_1.time_ - var_362_18) / var_362_19
				local var_362_21 = Color.New(1, 1, 1)

				var_362_21.a = Mathf.Lerp(0, 1, var_362_20)
				arg_359_1.mask_.color = var_362_21
			end

			if arg_359_1.time_ >= var_362_18 + var_362_19 and arg_359_1.time_ < var_362_18 + var_362_19 + arg_362_0 then
				local var_362_22 = Color.New(1, 1, 1)

				var_362_22.a = 1
				arg_359_1.mask_.color = var_362_22
			end

			local var_362_23 = 1

			if var_362_23 < arg_359_1.time_ and arg_359_1.time_ <= var_362_23 + arg_362_0 then
				arg_359_1.mask_.enabled = true
				arg_359_1.mask_.raycastTarget = true

				arg_359_1:SetGaussion(false)
			end

			local var_362_24 = 0.5

			if var_362_23 <= arg_359_1.time_ and arg_359_1.time_ < var_362_23 + var_362_24 then
				local var_362_25 = (arg_359_1.time_ - var_362_23) / var_362_24
				local var_362_26 = Color.New(1, 1, 1)

				var_362_26.a = Mathf.Lerp(1, 0, var_362_25)
				arg_359_1.mask_.color = var_362_26
			end

			if arg_359_1.time_ >= var_362_23 + var_362_24 and arg_359_1.time_ < var_362_23 + var_362_24 + arg_362_0 then
				local var_362_27 = Color.New(1, 1, 1)
				local var_362_28 = 0

				arg_359_1.mask_.enabled = false
				var_362_27.a = var_362_28
				arg_359_1.mask_.color = var_362_27
			end

			local var_362_29 = arg_359_1.bgs_.SS2403b.transform
			local var_362_30 = 1

			if var_362_30 < arg_359_1.time_ and arg_359_1.time_ <= var_362_30 + arg_362_0 then
				arg_359_1.var_.moveOldPosSS2403b = var_362_29.localPosition
			end

			local var_362_31 = 1.5

			if var_362_30 <= arg_359_1.time_ and arg_359_1.time_ < var_362_30 + var_362_31 then
				local var_362_32 = (arg_359_1.time_ - var_362_30) / var_362_31
				local var_362_33 = Vector3.New(0, 1, 10)

				var_362_29.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPosSS2403b, var_362_33, var_362_32)
			end

			if arg_359_1.time_ >= var_362_30 + var_362_31 and arg_359_1.time_ < var_362_30 + var_362_31 + arg_362_0 then
				var_362_29.localPosition = Vector3.New(0, 1, 10)
			end

			local var_362_34 = 0
			local var_362_35 = 1

			if var_362_34 < arg_359_1.time_ and arg_359_1.time_ <= var_362_34 + arg_362_0 then
				local var_362_36 = "play"
				local var_362_37 = "effect"

				arg_359_1:AudioAction(var_362_36, var_362_37, "se_story_144", "se_story_144_eject", "")
			end

			local var_362_38 = 1

			if var_362_38 < arg_359_1.time_ and arg_359_1.time_ <= var_362_38 + arg_362_0 then
				arg_359_1.allBtn_.enabled = false
			end

			local var_362_39 = 1.5

			if arg_359_1.time_ >= var_362_38 + var_362_39 and arg_359_1.time_ < var_362_38 + var_362_39 + arg_362_0 then
				arg_359_1.allBtn_.enabled = true
			end

			if arg_359_1.frameCnt_ <= 1 then
				arg_359_1.dialog_:SetActive(false)
			end

			local var_362_40 = 1.5
			local var_362_41 = 1.4

			if var_362_40 < arg_359_1.time_ and arg_359_1.time_ <= var_362_40 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0

				arg_359_1.dialog_:SetActive(true)

				arg_359_1.dialogCg_.alpha = 0

				local var_362_42 = LeanTween.value(arg_359_1.dialog_, 0, 1, 0.3)

				var_362_42:setOnUpdate(LuaHelper.FloatAction(function(arg_363_0)
					arg_359_1.dialogCg_.alpha = arg_363_0
				end))
				var_362_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_359_1.dialog_)
					var_362_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_359_1.duration_ = arg_359_1.duration_ + 0.3

				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_43 = arg_359_1:GetWordFromCfg(424111082)
				local var_362_44 = arg_359_1:FormatText(var_362_43.content)

				arg_359_1.text_.text = var_362_44

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_45 = 56
				local var_362_46 = utf8.len(var_362_44)
				local var_362_47 = var_362_45 <= 0 and var_362_41 or var_362_41 * (var_362_46 / var_362_45)

				if var_362_47 > 0 and var_362_41 < var_362_47 then
					arg_359_1.talkMaxDuration = var_362_47
					var_362_40 = var_362_40 + 0.3

					if var_362_47 + var_362_40 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_47 + var_362_40
					end
				end

				arg_359_1.text_.text = var_362_44
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_48 = var_362_40 + 0.3
			local var_362_49 = math.max(var_362_41, arg_359_1.talkMaxDuration)

			if var_362_48 <= arg_359_1.time_ and arg_359_1.time_ < var_362_48 + var_362_49 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_48) / var_362_49

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_48 + var_362_49 and arg_359_1.time_ < var_362_48 + var_362_49 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2403b",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.5,
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(1, 1, 5.6),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play424111083 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 424111083
		arg_365_1.duration_ = 1.63

		local var_365_0 = {
			zh = 1.233,
			ja = 1.633
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play424111084(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0
			local var_368_1 = 0.075

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_2 = arg_365_1:FormatText(StoryNameCfg[181].name)

				arg_365_1.leftNameTxt_.text = var_368_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_3 = arg_365_1:GetWordFromCfg(424111083)
				local var_368_4 = arg_365_1:FormatText(var_368_3.content)

				arg_365_1.text_.text = var_368_4

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111083", "story_v_out_424111.awb") ~= 0 then
					local var_368_8 = manager.audio:GetVoiceLength("story_v_out_424111", "424111083", "story_v_out_424111.awb") / 1000

					if var_368_8 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_8 + var_368_0
					end

					if var_368_3.prefab_name ~= "" and arg_365_1.actors_[var_368_3.prefab_name] ~= nil then
						local var_368_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_3.prefab_name].transform, "story_v_out_424111", "424111083", "story_v_out_424111.awb")

						arg_365_1:RecordAudio("424111083", var_368_9)
						arg_365_1:RecordAudio("424111083", var_368_9)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_424111", "424111083", "story_v_out_424111.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_424111", "424111083", "story_v_out_424111.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_10 = math.max(var_368_1, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_10 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_0) / var_368_10

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_10 and arg_365_1.time_ < var_368_0 + var_368_10 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play424111084 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 424111084
		arg_369_1.duration_ = 6.93

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play424111085(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = manager.ui.mainCamera.transform
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				local var_372_2 = arg_369_1.var_.effectshennenghongliu
				local var_372_3
				local var_372_4 = var_372_0

				if not var_372_2 then
					var_372_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_glowmask_white"), var_372_4)
					var_372_2.name = "shennenghongliu"
					arg_369_1.var_.effectshennenghongliu = var_372_2
				else
					var_372_2.transform:SetParent(var_372_4)
				end

				var_372_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_372_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_372_5 = manager.ui.mainCameraCom_
				local var_372_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_372_5.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_372_7 = var_372_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_372_8 = 15
				local var_372_9 = 2 * var_372_8 * Mathf.Tan(var_372_5.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_372_5.aspect
				local var_372_10 = 1
				local var_372_11 = 1.7777777777777777

				if var_372_11 < var_372_5.aspect then
					var_372_10 = var_372_9 / (2 * var_372_8 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_372_11)
				end

				for iter_372_0, iter_372_1 in ipairs(var_372_7) do
					local var_372_12 = iter_372_1.transform.localScale

					iter_372_1.transform.localScale = Vector3.New(var_372_12.x / var_372_6 * var_372_10, var_372_12.y / var_372_6, var_372_12.z)
				end
			end

			local var_372_13 = "STwhite"

			if arg_369_1.bgs_[var_372_13] == nil then
				local var_372_14 = Object.Instantiate(arg_369_1.paintGo_)

				var_372_14:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_372_13)
				var_372_14.name = var_372_13
				var_372_14.transform.parent = arg_369_1.stage_.transform
				var_372_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_369_1.bgs_[var_372_13] = var_372_14
			end

			local var_372_15 = 1.93333333333333

			if var_372_15 < arg_369_1.time_ and arg_369_1.time_ <= var_372_15 + arg_372_0 then
				local var_372_16 = manager.ui.mainCamera.transform.localPosition
				local var_372_17 = Vector3.New(0, 0, 10) + Vector3.New(var_372_16.x, var_372_16.y, 0)
				local var_372_18 = arg_369_1.bgs_.STwhite

				var_372_18.transform.localPosition = var_372_17
				var_372_18.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_372_19 = var_372_18:GetComponent("SpriteRenderer")

				if var_372_19 and var_372_19.sprite then
					local var_372_20 = (var_372_18.transform.localPosition - var_372_16).z
					local var_372_21 = manager.ui.mainCameraCom_
					local var_372_22 = 2 * var_372_20 * Mathf.Tan(var_372_21.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_372_23 = var_372_22 * var_372_21.aspect
					local var_372_24 = var_372_19.sprite.bounds.size.x
					local var_372_25 = var_372_19.sprite.bounds.size.y
					local var_372_26 = var_372_23 / var_372_24
					local var_372_27 = var_372_22 / var_372_25
					local var_372_28 = var_372_27 < var_372_26 and var_372_26 or var_372_27

					var_372_18.transform.localScale = Vector3.New(var_372_28, var_372_28, 0)
				end

				for iter_372_2, iter_372_3 in pairs(arg_369_1.bgs_) do
					if iter_372_2 ~= "STwhite" then
						iter_372_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_372_29 = manager.ui.mainCamera.transform
			local var_372_30 = 1.93333333333333

			if var_372_30 < arg_369_1.time_ and arg_369_1.time_ <= var_372_30 + arg_372_0 then
				local var_372_31 = arg_369_1.var_.effecthailasongbie1

				if var_372_31 then
					Object.Destroy(var_372_31)

					arg_369_1.var_.effecthailasongbie1 = nil
				end
			end

			local var_372_32 = 0
			local var_372_33 = 1

			if var_372_32 < arg_369_1.time_ and arg_369_1.time_ <= var_372_32 + arg_372_0 then
				local var_372_34 = "play"
				local var_372_35 = "effect"

				arg_369_1:AudioAction(var_372_34, var_372_35, "se_story_16", "se_story_16_energy02", "")
			end

			local var_372_36 = 1.93333333333333
			local var_372_37 = 1.55

			if var_372_36 < arg_369_1.time_ and arg_369_1.time_ <= var_372_36 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, false)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_38 = arg_369_1:GetWordFromCfg(424111084)
				local var_372_39 = arg_369_1:FormatText(var_372_38.content)

				arg_369_1.text_.text = var_372_39

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_40 = 62
				local var_372_41 = utf8.len(var_372_39)
				local var_372_42 = var_372_40 <= 0 and var_372_37 or var_372_37 * (var_372_41 / var_372_40)

				if var_372_42 > 0 and var_372_37 < var_372_42 then
					arg_369_1.talkMaxDuration = var_372_42

					if var_372_42 + var_372_36 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_42 + var_372_36
					end
				end

				arg_369_1.text_.text = var_372_39
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_43 = math.max(var_372_37, arg_369_1.talkMaxDuration)

			if var_372_36 <= arg_369_1.time_ and arg_369_1.time_ < var_372_36 + var_372_43 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_36) / var_372_43

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_36 + var_372_43 and arg_369_1.time_ < var_372_36 + var_372_43 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 15,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/UpDown_Shake",
				duration = 1.93333333333333,
				amplitudeGain = 0.3,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play424111085 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 424111085
		arg_373_1.duration_ = 9

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play424111086(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 2

			if var_376_0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_0 + arg_376_0 then
				local var_376_1 = manager.ui.mainCamera.transform.localPosition
				local var_376_2 = Vector3.New(0, 0, 10) + Vector3.New(var_376_1.x, var_376_1.y, 0)
				local var_376_3 = arg_373_1.bgs_.ST0117

				var_376_3.transform.localPosition = var_376_2
				var_376_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_376_4 = var_376_3:GetComponent("SpriteRenderer")

				if var_376_4 and var_376_4.sprite then
					local var_376_5 = (var_376_3.transform.localPosition - var_376_1).z
					local var_376_6 = manager.ui.mainCameraCom_
					local var_376_7 = 2 * var_376_5 * Mathf.Tan(var_376_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_376_8 = var_376_7 * var_376_6.aspect
					local var_376_9 = var_376_4.sprite.bounds.size.x
					local var_376_10 = var_376_4.sprite.bounds.size.y
					local var_376_11 = var_376_8 / var_376_9
					local var_376_12 = var_376_7 / var_376_10
					local var_376_13 = var_376_12 < var_376_11 and var_376_11 or var_376_12

					var_376_3.transform.localScale = Vector3.New(var_376_13, var_376_13, 0)
				end

				for iter_376_0, iter_376_1 in pairs(arg_373_1.bgs_) do
					if iter_376_0 ~= "ST0117" then
						iter_376_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_376_14 = 4

			if var_376_14 < arg_373_1.time_ and arg_373_1.time_ <= var_376_14 + arg_376_0 then
				arg_373_1.allBtn_.enabled = false
			end

			local var_376_15 = 0.3

			if arg_373_1.time_ >= var_376_14 + var_376_15 and arg_373_1.time_ < var_376_14 + var_376_15 + arg_376_0 then
				arg_373_1.allBtn_.enabled = true
			end

			local var_376_16 = 0

			if var_376_16 < arg_373_1.time_ and arg_373_1.time_ <= var_376_16 + arg_376_0 then
				arg_373_1.mask_.enabled = true
				arg_373_1.mask_.raycastTarget = true

				arg_373_1:SetGaussion(false)
			end

			local var_376_17 = 2

			if var_376_16 <= arg_373_1.time_ and arg_373_1.time_ < var_376_16 + var_376_17 then
				local var_376_18 = (arg_373_1.time_ - var_376_16) / var_376_17
				local var_376_19 = Color.New(0, 0, 0)

				var_376_19.a = Mathf.Lerp(0, 1, var_376_18)
				arg_373_1.mask_.color = var_376_19
			end

			if arg_373_1.time_ >= var_376_16 + var_376_17 and arg_373_1.time_ < var_376_16 + var_376_17 + arg_376_0 then
				local var_376_20 = Color.New(0, 0, 0)

				var_376_20.a = 1
				arg_373_1.mask_.color = var_376_20
			end

			local var_376_21 = 2

			if var_376_21 < arg_373_1.time_ and arg_373_1.time_ <= var_376_21 + arg_376_0 then
				arg_373_1.mask_.enabled = true
				arg_373_1.mask_.raycastTarget = true

				arg_373_1:SetGaussion(false)
			end

			local var_376_22 = 2

			if var_376_21 <= arg_373_1.time_ and arg_373_1.time_ < var_376_21 + var_376_22 then
				local var_376_23 = (arg_373_1.time_ - var_376_21) / var_376_22
				local var_376_24 = Color.New(0, 0, 0)

				var_376_24.a = Mathf.Lerp(1, 0, var_376_23)
				arg_373_1.mask_.color = var_376_24
			end

			if arg_373_1.time_ >= var_376_21 + var_376_22 and arg_373_1.time_ < var_376_21 + var_376_22 + arg_376_0 then
				local var_376_25 = Color.New(0, 0, 0)
				local var_376_26 = 0

				arg_373_1.mask_.enabled = false
				var_376_25.a = var_376_26
				arg_373_1.mask_.color = var_376_25
			end

			local var_376_27 = 0.2
			local var_376_28 = 0.3

			if var_376_27 < arg_373_1.time_ and arg_373_1.time_ <= var_376_27 + arg_376_0 then
				local var_376_29 = "play"
				local var_376_30 = "music"

				arg_373_1:AudioAction(var_376_29, var_376_30, "ui_battle", "ui_battle_stopbgm", "")

				local var_376_31 = ""
				local var_376_32 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_376_32 ~= "" then
					if arg_373_1.bgmTxt_.text ~= var_376_32 and arg_373_1.bgmTxt_.text ~= "" then
						if arg_373_1.bgmTxt2_.text ~= "" then
							arg_373_1.bgmTxt_.text = arg_373_1.bgmTxt2_.text
						end

						arg_373_1.bgmTxt2_.text = var_376_32

						arg_373_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_373_1.bgmTxt_.text = var_376_32
						arg_373_1.bgmTxt2_.text = var_376_32
					end

					if arg_373_1.bgmTimer then
						arg_373_1.bgmTimer:Stop()

						arg_373_1.bgmTimer = nil
					end

					if arg_373_1.settingData.show_music_name == 1 then
						arg_373_1.musicController:SetSelectedState("show")
						arg_373_1.musicAnimator_:Play("open", 0, 0)

						if arg_373_1.settingData.music_time ~= 0 then
							arg_373_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_373_1.settingData.music_time), function()
								if arg_373_1 == nil or isNil(arg_373_1.bgmTxt_) then
									return
								end

								arg_373_1.musicController:SetSelectedState("hide")
								arg_373_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_373_1.frameCnt_ <= 1 then
				arg_373_1.dialog_:SetActive(false)
			end

			local var_376_33 = 4
			local var_376_34 = 0.2

			if var_376_33 < arg_373_1.time_ and arg_373_1.time_ <= var_376_33 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0

				arg_373_1.dialog_:SetActive(true)

				arg_373_1.dialogCg_.alpha = 0

				local var_376_35 = LeanTween.value(arg_373_1.dialog_, 0, 1, 0.3)

				var_376_35:setOnUpdate(LuaHelper.FloatAction(function(arg_378_0)
					arg_373_1.dialogCg_.alpha = arg_378_0
				end))
				var_376_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_373_1.dialog_)
					var_376_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_373_1.duration_ = arg_373_1.duration_ + 0.3

				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_36 = arg_373_1:FormatText(StoryNameCfg[7].name)

				arg_373_1.leftNameTxt_.text = var_376_36

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

				local var_376_37 = arg_373_1:GetWordFromCfg(424111085)
				local var_376_38 = arg_373_1:FormatText(var_376_37.content)

				arg_373_1.text_.text = var_376_38

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_39 = 8
				local var_376_40 = utf8.len(var_376_38)
				local var_376_41 = var_376_39 <= 0 and var_376_34 or var_376_34 * (var_376_40 / var_376_39)

				if var_376_41 > 0 and var_376_34 < var_376_41 then
					arg_373_1.talkMaxDuration = var_376_41
					var_376_33 = var_376_33 + 0.3

					if var_376_41 + var_376_33 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_41 + var_376_33
					end
				end

				arg_373_1.text_.text = var_376_38
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_42 = var_376_33 + 0.3
			local var_376_43 = math.max(var_376_34, arg_373_1.talkMaxDuration)

			if var_376_42 <= arg_373_1.time_ and arg_373_1.time_ < var_376_42 + var_376_43 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_42) / var_376_43

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_42 + var_376_43 and arg_373_1.time_ < var_376_42 + var_376_43 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play424111086 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 424111086
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play424111087(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0.866666666666667
			local var_383_1 = 1

			if var_383_0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				local var_383_2 = "play"
				local var_383_3 = "effect"

				arg_380_1:AudioAction(var_383_2, var_383_3, "se_story_144", "se_story_144_gun07", "")
			end

			local var_383_4 = 0
			local var_383_5 = 1

			if var_383_4 < arg_380_1.time_ and arg_380_1.time_ <= var_383_4 + arg_383_0 then
				local var_383_6 = "play"
				local var_383_7 = "music"

				arg_380_1:AudioAction(var_383_6, var_383_7, "bgm_story_scheme_2", "bgm_story_scheme_2", "bgm_story_scheme_2.awb")

				local var_383_8 = ""
				local var_383_9 = manager.audio:GetAudioName("bgm_story_scheme_2", "bgm_story_scheme_2")

				if var_383_9 ~= "" then
					if arg_380_1.bgmTxt_.text ~= var_383_9 and arg_380_1.bgmTxt_.text ~= "" then
						if arg_380_1.bgmTxt2_.text ~= "" then
							arg_380_1.bgmTxt_.text = arg_380_1.bgmTxt2_.text
						end

						arg_380_1.bgmTxt2_.text = var_383_9

						arg_380_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_380_1.bgmTxt_.text = var_383_9
						arg_380_1.bgmTxt2_.text = var_383_9
					end

					if arg_380_1.bgmTimer then
						arg_380_1.bgmTimer:Stop()

						arg_380_1.bgmTimer = nil
					end

					if arg_380_1.settingData.show_music_name == 1 then
						arg_380_1.musicController:SetSelectedState("show")
						arg_380_1.musicAnimator_:Play("open", 0, 0)

						if arg_380_1.settingData.music_time ~= 0 then
							arg_380_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_380_1.settingData.music_time), function()
								if arg_380_1 == nil or isNil(arg_380_1.bgmTxt_) then
									return
								end

								arg_380_1.musicController:SetSelectedState("hide")
								arg_380_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_383_10 = 0
			local var_383_11 = 1.55

			if var_383_10 < arg_380_1.time_ and arg_380_1.time_ <= var_383_10 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_12 = arg_380_1:GetWordFromCfg(424111086)
				local var_383_13 = arg_380_1:FormatText(var_383_12.content)

				arg_380_1.text_.text = var_383_13

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_14 = 62
				local var_383_15 = utf8.len(var_383_13)
				local var_383_16 = var_383_14 <= 0 and var_383_11 or var_383_11 * (var_383_15 / var_383_14)

				if var_383_16 > 0 and var_383_11 < var_383_16 then
					arg_380_1.talkMaxDuration = var_383_16

					if var_383_16 + var_383_10 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_16 + var_383_10
					end
				end

				arg_380_1.text_.text = var_383_13
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_17 = math.max(var_383_11, arg_380_1.talkMaxDuration)

			if var_383_10 <= arg_380_1.time_ and arg_380_1.time_ < var_383_10 + var_383_17 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_10) / var_383_17

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_10 + var_383_17 and arg_380_1.time_ < var_383_10 + var_383_17 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play424111087 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 424111087
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play424111088(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0
			local var_388_1 = 1.325

			if var_388_0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_2 = arg_385_1:GetWordFromCfg(424111087)
				local var_388_3 = arg_385_1:FormatText(var_388_2.content)

				arg_385_1.text_.text = var_388_3

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_4 = 53
				local var_388_5 = utf8.len(var_388_3)
				local var_388_6 = var_388_4 <= 0 and var_388_1 or var_388_1 * (var_388_5 / var_388_4)

				if var_388_6 > 0 and var_388_1 < var_388_6 then
					arg_385_1.talkMaxDuration = var_388_6

					if var_388_6 + var_388_0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_6 + var_388_0
					end
				end

				arg_385_1.text_.text = var_388_3
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_7 = math.max(var_388_1, arg_385_1.talkMaxDuration)

			if var_388_0 <= arg_385_1.time_ and arg_385_1.time_ < var_388_0 + var_388_7 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_0) / var_388_7

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_0 + var_388_7 and arg_385_1.time_ < var_388_0 + var_388_7 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play424111088 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 424111088
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play424111089(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0
			local var_392_1 = 1.55

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

				local var_392_2 = arg_389_1:GetWordFromCfg(424111088)
				local var_392_3 = arg_389_1:FormatText(var_392_2.content)

				arg_389_1.text_.text = var_392_3

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_4 = 62
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
	Play424111089 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 424111089
		arg_393_1.duration_ = 2.37

		local var_393_0 = {
			zh = 1.7,
			ja = 2.366
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play424111090(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = "1194"

			if arg_393_1.actors_[var_396_0] == nil then
				local var_396_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1194")

				if not isNil(var_396_1) then
					local var_396_2 = Object.Instantiate(var_396_1, arg_393_1.canvasGo_.transform)

					var_396_2.transform:SetSiblingIndex(1)

					var_396_2.name = var_396_0
					var_396_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_393_1.actors_[var_396_0] = var_396_2

					local var_396_3 = var_396_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_393_1.isInRecall_ then
						for iter_396_0, iter_396_1 in ipairs(var_396_3) do
							iter_396_1.color = arg_393_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_396_4 = arg_393_1.actors_["1194"]
			local var_396_5 = 0

			if var_396_5 < arg_393_1.time_ and arg_393_1.time_ <= var_396_5 + arg_396_0 and not isNil(var_396_4) and arg_393_1.var_.actorSpriteComps1194 == nil then
				arg_393_1.var_.actorSpriteComps1194 = var_396_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_6 = 0.2

			if var_396_5 <= arg_393_1.time_ and arg_393_1.time_ < var_396_5 + var_396_6 and not isNil(var_396_4) then
				local var_396_7 = (arg_393_1.time_ - var_396_5) / var_396_6

				if arg_393_1.var_.actorSpriteComps1194 then
					for iter_396_2, iter_396_3 in pairs(arg_393_1.var_.actorSpriteComps1194:ToTable()) do
						if iter_396_3 then
							if arg_393_1.isInRecall_ then
								local var_396_8 = Mathf.Lerp(iter_396_3.color.r, arg_393_1.hightColor1.r, var_396_7)
								local var_396_9 = Mathf.Lerp(iter_396_3.color.g, arg_393_1.hightColor1.g, var_396_7)
								local var_396_10 = Mathf.Lerp(iter_396_3.color.b, arg_393_1.hightColor1.b, var_396_7)

								iter_396_3.color = Color.New(var_396_8, var_396_9, var_396_10)
							else
								local var_396_11 = Mathf.Lerp(iter_396_3.color.r, 1, var_396_7)

								iter_396_3.color = Color.New(var_396_11, var_396_11, var_396_11)
							end
						end
					end
				end
			end

			if arg_393_1.time_ >= var_396_5 + var_396_6 and arg_393_1.time_ < var_396_5 + var_396_6 + arg_396_0 and not isNil(var_396_4) and arg_393_1.var_.actorSpriteComps1194 then
				for iter_396_4, iter_396_5 in pairs(arg_393_1.var_.actorSpriteComps1194:ToTable()) do
					if iter_396_5 then
						if arg_393_1.isInRecall_ then
							iter_396_5.color = arg_393_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_396_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_393_1.var_.actorSpriteComps1194 = nil
			end

			local var_396_12 = arg_393_1.actors_["1194"].transform
			local var_396_13 = 0

			if var_396_13 < arg_393_1.time_ and arg_393_1.time_ <= var_396_13 + arg_396_0 then
				arg_393_1.var_.moveOldPos1194 = var_396_12.localPosition
				var_396_12.localScale = Vector3.New(1, 1, 1)

				arg_393_1:CheckSpriteTmpPos("1194", 3)

				local var_396_14 = var_396_12.childCount

				for iter_396_6 = 0, var_396_14 - 1 do
					local var_396_15 = var_396_12:GetChild(iter_396_6)

					if var_396_15.name == "split_3" or not string.find(var_396_15.name, "split") then
						var_396_15.gameObject:SetActive(true)
					else
						var_396_15.gameObject:SetActive(false)
					end
				end
			end

			local var_396_16 = 0.001

			if var_396_13 <= arg_393_1.time_ and arg_393_1.time_ < var_396_13 + var_396_16 then
				local var_396_17 = (arg_393_1.time_ - var_396_13) / var_396_16
				local var_396_18 = Vector3.New(-60, -360, -240)

				var_396_12.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1194, var_396_18, var_396_17)
			end

			if arg_393_1.time_ >= var_396_13 + var_396_16 and arg_393_1.time_ < var_396_13 + var_396_16 + arg_396_0 then
				var_396_12.localPosition = Vector3.New(-60, -360, -240)
			end

			local var_396_19 = 0
			local var_396_20 = 0.175

			if var_396_19 < arg_393_1.time_ and arg_393_1.time_ <= var_396_19 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_21 = arg_393_1:FormatText(StoryNameCfg[181].name)

				arg_393_1.leftNameTxt_.text = var_396_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_22 = arg_393_1:GetWordFromCfg(424111089)
				local var_396_23 = arg_393_1:FormatText(var_396_22.content)

				arg_393_1.text_.text = var_396_23

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_24 = 7
				local var_396_25 = utf8.len(var_396_23)
				local var_396_26 = var_396_24 <= 0 and var_396_20 or var_396_20 * (var_396_25 / var_396_24)

				if var_396_26 > 0 and var_396_20 < var_396_26 then
					arg_393_1.talkMaxDuration = var_396_26

					if var_396_26 + var_396_19 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_26 + var_396_19
					end
				end

				arg_393_1.text_.text = var_396_23
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111089", "story_v_out_424111.awb") ~= 0 then
					local var_396_27 = manager.audio:GetVoiceLength("story_v_out_424111", "424111089", "story_v_out_424111.awb") / 1000

					if var_396_27 + var_396_19 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_27 + var_396_19
					end

					if var_396_22.prefab_name ~= "" and arg_393_1.actors_[var_396_22.prefab_name] ~= nil then
						local var_396_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_22.prefab_name].transform, "story_v_out_424111", "424111089", "story_v_out_424111.awb")

						arg_393_1:RecordAudio("424111089", var_396_28)
						arg_393_1:RecordAudio("424111089", var_396_28)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_424111", "424111089", "story_v_out_424111.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_424111", "424111089", "story_v_out_424111.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_29 = math.max(var_396_20, arg_393_1.talkMaxDuration)

			if var_396_19 <= arg_393_1.time_ and arg_393_1.time_ < var_396_19 + var_396_29 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_19) / var_396_29

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_19 + var_396_29 and arg_393_1.time_ < var_396_19 + var_396_29 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play424111090 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 424111090
		arg_397_1.duration_ = 4.87

		local var_397_0 = {
			zh = 3.166,
			ja = 4.866
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
				arg_397_0:Play424111091(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["1194"]
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.actorSpriteComps1194 == nil then
				arg_397_1.var_.actorSpriteComps1194 = var_400_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_2 = 0.2

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 and not isNil(var_400_0) then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2

				if arg_397_1.var_.actorSpriteComps1194 then
					for iter_400_0, iter_400_1 in pairs(arg_397_1.var_.actorSpriteComps1194:ToTable()) do
						if iter_400_1 then
							if arg_397_1.isInRecall_ then
								local var_400_4 = Mathf.Lerp(iter_400_1.color.r, arg_397_1.hightColor2.r, var_400_3)
								local var_400_5 = Mathf.Lerp(iter_400_1.color.g, arg_397_1.hightColor2.g, var_400_3)
								local var_400_6 = Mathf.Lerp(iter_400_1.color.b, arg_397_1.hightColor2.b, var_400_3)

								iter_400_1.color = Color.New(var_400_4, var_400_5, var_400_6)
							else
								local var_400_7 = Mathf.Lerp(iter_400_1.color.r, 0.5, var_400_3)

								iter_400_1.color = Color.New(var_400_7, var_400_7, var_400_7)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.actorSpriteComps1194 then
				for iter_400_2, iter_400_3 in pairs(arg_397_1.var_.actorSpriteComps1194:ToTable()) do
					if iter_400_3 then
						if arg_397_1.isInRecall_ then
							iter_400_3.color = arg_397_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_400_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_397_1.var_.actorSpriteComps1194 = nil
			end

			local var_400_8 = 0
			local var_400_9 = 0.325

			if var_400_8 < arg_397_1.time_ and arg_397_1.time_ <= var_400_8 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_10 = arg_397_1:FormatText(StoryNameCfg[177].name)

				arg_397_1.leftNameTxt_.text = var_400_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_11 = arg_397_1:GetWordFromCfg(424111090)
				local var_400_12 = arg_397_1:FormatText(var_400_11.content)

				arg_397_1.text_.text = var_400_12

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_13 = 13
				local var_400_14 = utf8.len(var_400_12)
				local var_400_15 = var_400_13 <= 0 and var_400_9 or var_400_9 * (var_400_14 / var_400_13)

				if var_400_15 > 0 and var_400_9 < var_400_15 then
					arg_397_1.talkMaxDuration = var_400_15

					if var_400_15 + var_400_8 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_15 + var_400_8
					end
				end

				arg_397_1.text_.text = var_400_12
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111090", "story_v_out_424111.awb") ~= 0 then
					local var_400_16 = manager.audio:GetVoiceLength("story_v_out_424111", "424111090", "story_v_out_424111.awb") / 1000

					if var_400_16 + var_400_8 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_16 + var_400_8
					end

					if var_400_11.prefab_name ~= "" and arg_397_1.actors_[var_400_11.prefab_name] ~= nil then
						local var_400_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_11.prefab_name].transform, "story_v_out_424111", "424111090", "story_v_out_424111.awb")

						arg_397_1:RecordAudio("424111090", var_400_17)
						arg_397_1:RecordAudio("424111090", var_400_17)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_424111", "424111090", "story_v_out_424111.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_424111", "424111090", "story_v_out_424111.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_18 = math.max(var_400_9, arg_397_1.talkMaxDuration)

			if var_400_8 <= arg_397_1.time_ and arg_397_1.time_ < var_400_8 + var_400_18 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_8) / var_400_18

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_8 + var_400_18 and arg_397_1.time_ < var_400_8 + var_400_18 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play424111091 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 424111091
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play424111092(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0
			local var_404_1 = 0.65

			if var_404_0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_2 = arg_401_1:FormatText(StoryNameCfg[7].name)

				arg_401_1.leftNameTxt_.text = var_404_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_3 = arg_401_1:GetWordFromCfg(424111091)
				local var_404_4 = arg_401_1:FormatText(var_404_3.content)

				arg_401_1.text_.text = var_404_4

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_5 = 26
				local var_404_6 = utf8.len(var_404_4)
				local var_404_7 = var_404_5 <= 0 and var_404_1 or var_404_1 * (var_404_6 / var_404_5)

				if var_404_7 > 0 and var_404_1 < var_404_7 then
					arg_401_1.talkMaxDuration = var_404_7

					if var_404_7 + var_404_0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_7 + var_404_0
					end
				end

				arg_401_1.text_.text = var_404_4
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_8 = math.max(var_404_1, arg_401_1.talkMaxDuration)

			if var_404_0 <= arg_401_1.time_ and arg_401_1.time_ < var_404_0 + var_404_8 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_0) / var_404_8

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_0 + var_404_8 and arg_401_1.time_ < var_404_0 + var_404_8 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play424111092 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 424111092
		arg_405_1.duration_ = 1.7

		local var_405_0 = {
			zh = 1.133,
			ja = 1.7
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play424111093(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0
			local var_408_1 = 0.125

			if var_408_0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_2 = arg_405_1:FormatText(StoryNameCfg[177].name)

				arg_405_1.leftNameTxt_.text = var_408_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, true)
				arg_405_1.iconController_:SetSelectedState("hero")

				arg_405_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_405_1.callingController_:SetSelectedState("normal")

				arg_405_1.keyicon_.color = Color.New(1, 1, 1)
				arg_405_1.icon_.color = Color.New(1, 1, 1)

				local var_408_3 = arg_405_1:GetWordFromCfg(424111092)
				local var_408_4 = arg_405_1:FormatText(var_408_3.content)

				arg_405_1.text_.text = var_408_4

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_5 = 5
				local var_408_6 = utf8.len(var_408_4)
				local var_408_7 = var_408_5 <= 0 and var_408_1 or var_408_1 * (var_408_6 / var_408_5)

				if var_408_7 > 0 and var_408_1 < var_408_7 then
					arg_405_1.talkMaxDuration = var_408_7

					if var_408_7 + var_408_0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_7 + var_408_0
					end
				end

				arg_405_1.text_.text = var_408_4
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111092", "story_v_out_424111.awb") ~= 0 then
					local var_408_8 = manager.audio:GetVoiceLength("story_v_out_424111", "424111092", "story_v_out_424111.awb") / 1000

					if var_408_8 + var_408_0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_8 + var_408_0
					end

					if var_408_3.prefab_name ~= "" and arg_405_1.actors_[var_408_3.prefab_name] ~= nil then
						local var_408_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_3.prefab_name].transform, "story_v_out_424111", "424111092", "story_v_out_424111.awb")

						arg_405_1:RecordAudio("424111092", var_408_9)
						arg_405_1:RecordAudio("424111092", var_408_9)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_424111", "424111092", "story_v_out_424111.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_424111", "424111092", "story_v_out_424111.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_10 = math.max(var_408_1, arg_405_1.talkMaxDuration)

			if var_408_0 <= arg_405_1.time_ and arg_405_1.time_ < var_408_0 + var_408_10 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_0) / var_408_10

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_0 + var_408_10 and arg_405_1.time_ < var_408_0 + var_408_10 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play424111093 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 424111093
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play424111094(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0
			local var_412_1 = 0.9

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

				local var_412_3 = arg_409_1:GetWordFromCfg(424111093)
				local var_412_4 = arg_409_1:FormatText(var_412_3.content)

				arg_409_1.text_.text = var_412_4

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_5 = 36
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
	Play424111094 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 424111094
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play424111095(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["1194"].transform
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 then
				arg_413_1.var_.moveOldPos1194 = var_416_0.localPosition
				var_416_0.localScale = Vector3.New(1, 1, 1)

				arg_413_1:CheckSpriteTmpPos("1194", 7)

				local var_416_2 = var_416_0.childCount

				for iter_416_0 = 0, var_416_2 - 1 do
					local var_416_3 = var_416_0:GetChild(iter_416_0)

					if var_416_3.name == "" or not string.find(var_416_3.name, "split") then
						var_416_3.gameObject:SetActive(true)
					else
						var_416_3.gameObject:SetActive(false)
					end
				end
			end

			local var_416_4 = 0.001

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_4 then
				local var_416_5 = (arg_413_1.time_ - var_416_1) / var_416_4
				local var_416_6 = Vector3.New(0, -2000, 0)

				var_416_0.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1194, var_416_6, var_416_5)
			end

			if arg_413_1.time_ >= var_416_1 + var_416_4 and arg_413_1.time_ < var_416_1 + var_416_4 + arg_416_0 then
				var_416_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_416_7 = manager.ui.mainCamera.transform
			local var_416_8 = 0

			if var_416_8 < arg_413_1.time_ and arg_413_1.time_ <= var_416_8 + arg_416_0 then
				local var_416_9 = arg_413_1.var_.effectsaomiaoyifengming1
				local var_416_10
				local var_416_11 = var_416_7

				if not var_416_9 then
					var_416_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_keep"), var_416_11)
					var_416_9.name = "saomiaoyifengming1"
					arg_413_1.var_.effectsaomiaoyifengming1 = var_416_9
				else
					var_416_9.transform:SetParent(var_416_11)
				end

				var_416_9.transform.localPosition = Vector3.New(0, 0, -9)
				var_416_9.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_416_12 = 1.7777777777777777
				local var_416_13 = Screen.width / Screen.height
				local var_416_14 = var_416_13 / var_416_12
				local var_416_15 = Mathf.Max(var_416_12 / var_416_13, 1)

				var_416_9.transform.localScale = Vector3.New(var_416_9.transform.localScale.x * var_416_14, var_416_9.transform.localScale.y * var_416_15, var_416_9.transform.localScale.z)
			end

			local var_416_16 = 0.034
			local var_416_17 = 1

			if var_416_16 < arg_413_1.time_ and arg_413_1.time_ <= var_416_16 + arg_416_0 then
				local var_416_18 = "play"
				local var_416_19 = "effect"

				arg_413_1:AudioAction(var_416_18, var_416_19, "se_story_146", "se_story_146_alarm", "")
			end

			local var_416_20 = 0
			local var_416_21 = 1.275

			if var_416_20 < arg_413_1.time_ and arg_413_1.time_ <= var_416_20 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0

				arg_413_1.dialog_:SetActive(true)

				arg_413_1.dialogCg_.alpha = 0

				local var_416_22 = LeanTween.value(arg_413_1.dialog_, 0, 1, 0.3)

				var_416_22:setOnUpdate(LuaHelper.FloatAction(function(arg_417_0)
					arg_413_1.dialogCg_.alpha = arg_417_0
				end))
				var_416_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_413_1.dialog_)
					var_416_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_413_1.duration_ = arg_413_1.duration_ + 0.3

				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_23 = arg_413_1:GetWordFromCfg(424111094)
				local var_416_24 = arg_413_1:FormatText(var_416_23.content)

				arg_413_1.text_.text = var_416_24

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_25 = 51
				local var_416_26 = utf8.len(var_416_24)
				local var_416_27 = var_416_25 <= 0 and var_416_21 or var_416_21 * (var_416_26 / var_416_25)

				if var_416_27 > 0 and var_416_21 < var_416_27 then
					arg_413_1.talkMaxDuration = var_416_27
					var_416_20 = var_416_20 + 0.3

					if var_416_27 + var_416_20 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_27 + var_416_20
					end
				end

				arg_413_1.text_.text = var_416_24
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_28 = var_416_20 + 0.3
			local var_416_29 = math.max(var_416_21, arg_413_1.talkMaxDuration)

			if var_416_28 <= arg_413_1.time_ and arg_413_1.time_ < var_416_28 + var_416_29 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_28) / var_416_29

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_28 + var_416_29 and arg_413_1.time_ < var_416_28 + var_416_29 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194",
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
	Play424111095 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 424111095
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play424111096(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = manager.ui.mainCamera.transform
			local var_422_1 = 0

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				local var_422_2 = arg_419_1.var_.effectsaomiaoyifengming2
				local var_422_3
				local var_422_4 = var_422_0

				if not var_422_2 then
					var_422_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_out"), var_422_4)
					var_422_2.name = "saomiaoyifengming2"
					arg_419_1.var_.effectsaomiaoyifengming2 = var_422_2
				else
					var_422_2.transform:SetParent(var_422_4)
				end

				var_422_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_422_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_422_5 = manager.ui.mainCameraCom_
				local var_422_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_422_5.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_422_7 = var_422_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_422_8 = 15
				local var_422_9 = 2 * var_422_8 * Mathf.Tan(var_422_5.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_422_5.aspect
				local var_422_10 = 1
				local var_422_11 = 1.7777777777777777

				if var_422_11 < var_422_5.aspect then
					var_422_10 = var_422_9 / (2 * var_422_8 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_422_11)
				end

				for iter_422_0, iter_422_1 in ipairs(var_422_7) do
					local var_422_12 = iter_422_1.transform.localScale

					iter_422_1.transform.localScale = Vector3.New(var_422_12.x / var_422_6 * var_422_10, var_422_12.y / var_422_6, var_422_12.z)
				end
			end

			local var_422_13 = manager.ui.mainCamera.transform
			local var_422_14 = 0.2

			if var_422_14 < arg_419_1.time_ and arg_419_1.time_ <= var_422_14 + arg_422_0 then
				local var_422_15 = arg_419_1.var_.effectsaomiaoyifengming1

				if var_422_15 then
					Object.Destroy(var_422_15)

					arg_419_1.var_.effectsaomiaoyifengming1 = nil
				end
			end

			local var_422_16 = 0
			local var_422_17 = 1.025

			if var_422_16 < arg_419_1.time_ and arg_419_1.time_ <= var_422_16 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_18 = arg_419_1:FormatText(StoryNameCfg[7].name)

				arg_419_1.leftNameTxt_.text = var_422_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, true)
				arg_419_1.iconController_:SetSelectedState("hero")

				arg_419_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_419_1.callingController_:SetSelectedState("normal")

				arg_419_1.keyicon_.color = Color.New(1, 1, 1)
				arg_419_1.icon_.color = Color.New(1, 1, 1)

				local var_422_19 = arg_419_1:GetWordFromCfg(424111095)
				local var_422_20 = arg_419_1:FormatText(var_422_19.content)

				arg_419_1.text_.text = var_422_20

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_21 = 41
				local var_422_22 = utf8.len(var_422_20)
				local var_422_23 = var_422_21 <= 0 and var_422_17 or var_422_17 * (var_422_22 / var_422_21)

				if var_422_23 > 0 and var_422_17 < var_422_23 then
					arg_419_1.talkMaxDuration = var_422_23

					if var_422_23 + var_422_16 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_23 + var_422_16
					end
				end

				arg_419_1.text_.text = var_422_20
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_24 = math.max(var_422_17, arg_419_1.talkMaxDuration)

			if var_422_16 <= arg_419_1.time_ and arg_419_1.time_ < var_422_16 + var_422_24 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_16) / var_422_24

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_16 + var_422_24 and arg_419_1.time_ < var_422_16 + var_422_24 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play424111096 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 424111096
		arg_423_1.duration_ = 6.6

		local var_423_0 = {
			zh = 4.1,
			ja = 6.6
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play424111097(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0
			local var_426_1 = 0.575

			if var_426_0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_2 = arg_423_1:FormatText(StoryNameCfg[177].name)

				arg_423_1.leftNameTxt_.text = var_426_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_3 = arg_423_1:GetWordFromCfg(424111096)
				local var_426_4 = arg_423_1:FormatText(var_426_3.content)

				arg_423_1.text_.text = var_426_4

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_5 = 23
				local var_426_6 = utf8.len(var_426_4)
				local var_426_7 = var_426_5 <= 0 and var_426_1 or var_426_1 * (var_426_6 / var_426_5)

				if var_426_7 > 0 and var_426_1 < var_426_7 then
					arg_423_1.talkMaxDuration = var_426_7

					if var_426_7 + var_426_0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_7 + var_426_0
					end
				end

				arg_423_1.text_.text = var_426_4
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111096", "story_v_out_424111.awb") ~= 0 then
					local var_426_8 = manager.audio:GetVoiceLength("story_v_out_424111", "424111096", "story_v_out_424111.awb") / 1000

					if var_426_8 + var_426_0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_8 + var_426_0
					end

					if var_426_3.prefab_name ~= "" and arg_423_1.actors_[var_426_3.prefab_name] ~= nil then
						local var_426_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_3.prefab_name].transform, "story_v_out_424111", "424111096", "story_v_out_424111.awb")

						arg_423_1:RecordAudio("424111096", var_426_9)
						arg_423_1:RecordAudio("424111096", var_426_9)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_424111", "424111096", "story_v_out_424111.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_424111", "424111096", "story_v_out_424111.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_10 = math.max(var_426_1, arg_423_1.talkMaxDuration)

			if var_426_0 <= arg_423_1.time_ and arg_423_1.time_ < var_426_0 + var_426_10 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_0) / var_426_10

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_0 + var_426_10 and arg_423_1.time_ < var_426_0 + var_426_10 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play424111097 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 424111097
		arg_427_1.duration_ = 2.43

		local var_427_0 = {
			zh = 2.433,
			ja = 2
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play424111098(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0
			local var_430_1 = 0.325

			if var_430_0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_2 = arg_427_1:FormatText(StoryNameCfg[177].name)

				arg_427_1.leftNameTxt_.text = var_430_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_3 = arg_427_1:GetWordFromCfg(424111097)
				local var_430_4 = arg_427_1:FormatText(var_430_3.content)

				arg_427_1.text_.text = var_430_4

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_5 = 13
				local var_430_6 = utf8.len(var_430_4)
				local var_430_7 = var_430_5 <= 0 and var_430_1 or var_430_1 * (var_430_6 / var_430_5)

				if var_430_7 > 0 and var_430_1 < var_430_7 then
					arg_427_1.talkMaxDuration = var_430_7

					if var_430_7 + var_430_0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_7 + var_430_0
					end
				end

				arg_427_1.text_.text = var_430_4
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111097", "story_v_out_424111.awb") ~= 0 then
					local var_430_8 = manager.audio:GetVoiceLength("story_v_out_424111", "424111097", "story_v_out_424111.awb") / 1000

					if var_430_8 + var_430_0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_8 + var_430_0
					end

					if var_430_3.prefab_name ~= "" and arg_427_1.actors_[var_430_3.prefab_name] ~= nil then
						local var_430_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_3.prefab_name].transform, "story_v_out_424111", "424111097", "story_v_out_424111.awb")

						arg_427_1:RecordAudio("424111097", var_430_9)
						arg_427_1:RecordAudio("424111097", var_430_9)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_424111", "424111097", "story_v_out_424111.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_424111", "424111097", "story_v_out_424111.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_10 = math.max(var_430_1, arg_427_1.talkMaxDuration)

			if var_430_0 <= arg_427_1.time_ and arg_427_1.time_ < var_430_0 + var_430_10 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_0) / var_430_10

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_0 + var_430_10 and arg_427_1.time_ < var_430_0 + var_430_10 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play424111098 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 424111098
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play424111099(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 0
			local var_434_1 = 0.3

			if var_434_0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_2 = arg_431_1:FormatText(StoryNameCfg[7].name)

				arg_431_1.leftNameTxt_.text = var_434_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_3 = arg_431_1:GetWordFromCfg(424111098)
				local var_434_4 = arg_431_1:FormatText(var_434_3.content)

				arg_431_1.text_.text = var_434_4

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_5 = 12
				local var_434_6 = utf8.len(var_434_4)
				local var_434_7 = var_434_5 <= 0 and var_434_1 or var_434_1 * (var_434_6 / var_434_5)

				if var_434_7 > 0 and var_434_1 < var_434_7 then
					arg_431_1.talkMaxDuration = var_434_7

					if var_434_7 + var_434_0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_7 + var_434_0
					end
				end

				arg_431_1.text_.text = var_434_4
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_8 = math.max(var_434_1, arg_431_1.talkMaxDuration)

			if var_434_0 <= arg_431_1.time_ and arg_431_1.time_ < var_434_0 + var_434_8 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_0) / var_434_8

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_0 + var_434_8 and arg_431_1.time_ < var_434_0 + var_434_8 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play424111099 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 424111099
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play424111100(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = manager.ui.mainCamera.transform
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 then
				local var_438_2 = arg_435_1.var_.effectsaomiaoyifengming3
				local var_438_3
				local var_438_4 = var_438_0

				if not var_438_2 then
					var_438_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_438_4)
					var_438_2.name = "saomiaoyifengming3"
					arg_435_1.var_.effectsaomiaoyifengming3 = var_438_2
				else
					var_438_2.transform:SetParent(var_438_4)
				end

				var_438_2.transform.localPosition = Vector3.New(0, -0.28, 0)
				var_438_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_438_5 = manager.ui.mainCameraCom_
				local var_438_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_438_5.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_438_7 = var_438_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_438_8 = 15
				local var_438_9 = 2 * var_438_8 * Mathf.Tan(var_438_5.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_438_5.aspect
				local var_438_10 = 1
				local var_438_11 = 1.7777777777777777

				if var_438_11 < var_438_5.aspect then
					var_438_10 = var_438_9 / (2 * var_438_8 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_438_11)
				end

				for iter_438_0, iter_438_1 in ipairs(var_438_7) do
					local var_438_12 = iter_438_1.transform.localScale

					iter_438_1.transform.localScale = Vector3.New(var_438_12.x / var_438_6 * var_438_10, var_438_12.y / var_438_6, var_438_12.z)
				end
			end

			local var_438_13 = manager.ui.mainCamera.transform
			local var_438_14 = 2

			if var_438_14 < arg_435_1.time_ and arg_435_1.time_ <= var_438_14 + arg_438_0 then
				local var_438_15 = arg_435_1.var_.effectsaomiaoyifengming3

				if var_438_15 then
					Object.Destroy(var_438_15)

					arg_435_1.var_.effectsaomiaoyifengming3 = nil
				end
			end

			local var_438_16 = 0
			local var_438_17 = 1

			if var_438_16 < arg_435_1.time_ and arg_435_1.time_ <= var_438_16 + arg_438_0 then
				local var_438_18 = "play"
				local var_438_19 = "effect"

				arg_435_1:AudioAction(var_438_18, var_438_19, "se_story_1310", "se_story_1310_gun01", "")
			end

			local var_438_20 = 0
			local var_438_21 = 1.275

			if var_438_20 < arg_435_1.time_ and arg_435_1.time_ <= var_438_20 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0

				arg_435_1.dialog_:SetActive(true)

				arg_435_1.dialogCg_.alpha = 0

				local var_438_22 = LeanTween.value(arg_435_1.dialog_, 0, 1, 0.3)

				var_438_22:setOnUpdate(LuaHelper.FloatAction(function(arg_439_0)
					arg_435_1.dialogCg_.alpha = arg_439_0
				end))
				var_438_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_435_1.dialog_)
					var_438_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_435_1.duration_ = arg_435_1.duration_ + 0.3

				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_23 = arg_435_1:GetWordFromCfg(424111099)
				local var_438_24 = arg_435_1:FormatText(var_438_23.content)

				arg_435_1.text_.text = var_438_24

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_25 = 51
				local var_438_26 = utf8.len(var_438_24)
				local var_438_27 = var_438_25 <= 0 and var_438_21 or var_438_21 * (var_438_26 / var_438_25)

				if var_438_27 > 0 and var_438_21 < var_438_27 then
					arg_435_1.talkMaxDuration = var_438_27
					var_438_20 = var_438_20 + 0.3

					if var_438_27 + var_438_20 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_27 + var_438_20
					end
				end

				arg_435_1.text_.text = var_438_24
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_28 = var_438_20 + 0.3
			local var_438_29 = math.max(var_438_21, arg_435_1.talkMaxDuration)

			if var_438_28 <= arg_435_1.time_ and arg_435_1.time_ < var_438_28 + var_438_29 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_28) / var_438_29

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_28 + var_438_29 and arg_435_1.time_ < var_438_28 + var_438_29 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 15,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/LeftRight_Shake",
				duration = 0.3,
				amplitudeGain = 0.8,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	Play424111100 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 424111100
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play424111101(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0
			local var_444_1 = 0.5

			if var_444_0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_2 = arg_441_1:FormatText(StoryNameCfg[7].name)

				arg_441_1.leftNameTxt_.text = var_444_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, true)
				arg_441_1.iconController_:SetSelectedState("hero")

				arg_441_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_441_1.callingController_:SetSelectedState("normal")

				arg_441_1.keyicon_.color = Color.New(1, 1, 1)
				arg_441_1.icon_.color = Color.New(1, 1, 1)

				local var_444_3 = arg_441_1:GetWordFromCfg(424111100)
				local var_444_4 = arg_441_1:FormatText(var_444_3.content)

				arg_441_1.text_.text = var_444_4

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_5 = 20
				local var_444_6 = utf8.len(var_444_4)
				local var_444_7 = var_444_5 <= 0 and var_444_1 or var_444_1 * (var_444_6 / var_444_5)

				if var_444_7 > 0 and var_444_1 < var_444_7 then
					arg_441_1.talkMaxDuration = var_444_7

					if var_444_7 + var_444_0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_7 + var_444_0
					end
				end

				arg_441_1.text_.text = var_444_4
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_8 = math.max(var_444_1, arg_441_1.talkMaxDuration)

			if var_444_0 <= arg_441_1.time_ and arg_441_1.time_ < var_444_0 + var_444_8 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_0) / var_444_8

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_0 + var_444_8 and arg_441_1.time_ < var_444_0 + var_444_8 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play424111101 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 424111101
		arg_445_1.duration_ = 1.5

		local var_445_0 = {
			zh = 0.999999999999,
			ja = 1.5
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
				arg_445_0:Play424111102(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0
			local var_448_1 = 0.1

			if var_448_0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_2 = arg_445_1:FormatText(StoryNameCfg[177].name)

				arg_445_1.leftNameTxt_.text = var_448_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, true)
				arg_445_1.iconController_:SetSelectedState("hero")

				arg_445_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_445_1.callingController_:SetSelectedState("normal")

				arg_445_1.keyicon_.color = Color.New(1, 1, 1)
				arg_445_1.icon_.color = Color.New(1, 1, 1)

				local var_448_3 = arg_445_1:GetWordFromCfg(424111101)
				local var_448_4 = arg_445_1:FormatText(var_448_3.content)

				arg_445_1.text_.text = var_448_4

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111101", "story_v_out_424111.awb") ~= 0 then
					local var_448_8 = manager.audio:GetVoiceLength("story_v_out_424111", "424111101", "story_v_out_424111.awb") / 1000

					if var_448_8 + var_448_0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_8 + var_448_0
					end

					if var_448_3.prefab_name ~= "" and arg_445_1.actors_[var_448_3.prefab_name] ~= nil then
						local var_448_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_3.prefab_name].transform, "story_v_out_424111", "424111101", "story_v_out_424111.awb")

						arg_445_1:RecordAudio("424111101", var_448_9)
						arg_445_1:RecordAudio("424111101", var_448_9)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_424111", "424111101", "story_v_out_424111.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_424111", "424111101", "story_v_out_424111.awb")
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
	Play424111102 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 424111102
		arg_449_1.duration_ = 6.93

		local var_449_0 = {
			zh = 5.7,
			ja = 6.933
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
				arg_449_0:Play424111103(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = arg_449_1.actors_["10153"]
			local var_452_1 = 0

			if var_452_1 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 and not isNil(var_452_0) and arg_449_1.var_.actorSpriteComps10153 == nil then
				arg_449_1.var_.actorSpriteComps10153 = var_452_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_452_2 = 0.2

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_2 and not isNil(var_452_0) then
				local var_452_3 = (arg_449_1.time_ - var_452_1) / var_452_2

				if arg_449_1.var_.actorSpriteComps10153 then
					for iter_452_0, iter_452_1 in pairs(arg_449_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_452_1 then
							if arg_449_1.isInRecall_ then
								local var_452_4 = Mathf.Lerp(iter_452_1.color.r, arg_449_1.hightColor1.r, var_452_3)
								local var_452_5 = Mathf.Lerp(iter_452_1.color.g, arg_449_1.hightColor1.g, var_452_3)
								local var_452_6 = Mathf.Lerp(iter_452_1.color.b, arg_449_1.hightColor1.b, var_452_3)

								iter_452_1.color = Color.New(var_452_4, var_452_5, var_452_6)
							else
								local var_452_7 = Mathf.Lerp(iter_452_1.color.r, 1, var_452_3)

								iter_452_1.color = Color.New(var_452_7, var_452_7, var_452_7)
							end
						end
					end
				end
			end

			if arg_449_1.time_ >= var_452_1 + var_452_2 and arg_449_1.time_ < var_452_1 + var_452_2 + arg_452_0 and not isNil(var_452_0) and arg_449_1.var_.actorSpriteComps10153 then
				for iter_452_2, iter_452_3 in pairs(arg_449_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_452_3 then
						if arg_449_1.isInRecall_ then
							iter_452_3.color = arg_449_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_452_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_449_1.var_.actorSpriteComps10153 = nil
			end

			local var_452_8 = arg_449_1.actors_["10153"].transform
			local var_452_9 = 0

			if var_452_9 < arg_449_1.time_ and arg_449_1.time_ <= var_452_9 + arg_452_0 then
				arg_449_1.var_.moveOldPos10153 = var_452_8.localPosition
				var_452_8.localScale = Vector3.New(1, 1, 1)

				arg_449_1:CheckSpriteTmpPos("10153", 3)

				local var_452_10 = var_452_8.childCount

				for iter_452_4 = 0, var_452_10 - 1 do
					local var_452_11 = var_452_8:GetChild(iter_452_4)

					if var_452_11.name == "split_3" or not string.find(var_452_11.name, "split") then
						var_452_11.gameObject:SetActive(true)
					else
						var_452_11.gameObject:SetActive(false)
					end
				end
			end

			local var_452_12 = 0.001

			if var_452_9 <= arg_449_1.time_ and arg_449_1.time_ < var_452_9 + var_452_12 then
				local var_452_13 = (arg_449_1.time_ - var_452_9) / var_452_12
				local var_452_14 = Vector3.New(-60, -395, -330)

				var_452_8.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos10153, var_452_14, var_452_13)
			end

			if arg_449_1.time_ >= var_452_9 + var_452_12 and arg_449_1.time_ < var_452_9 + var_452_12 + arg_452_0 then
				var_452_8.localPosition = Vector3.New(-60, -395, -330)
			end

			local var_452_15 = 0
			local var_452_16 = 0.65

			if var_452_15 < arg_449_1.time_ and arg_449_1.time_ <= var_452_15 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_17 = arg_449_1:FormatText(StoryNameCfg[1387].name)

				arg_449_1.leftNameTxt_.text = var_452_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_18 = arg_449_1:GetWordFromCfg(424111102)
				local var_452_19 = arg_449_1:FormatText(var_452_18.content)

				arg_449_1.text_.text = var_452_19

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_20 = 26
				local var_452_21 = utf8.len(var_452_19)
				local var_452_22 = var_452_20 <= 0 and var_452_16 or var_452_16 * (var_452_21 / var_452_20)

				if var_452_22 > 0 and var_452_16 < var_452_22 then
					arg_449_1.talkMaxDuration = var_452_22

					if var_452_22 + var_452_15 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_22 + var_452_15
					end
				end

				arg_449_1.text_.text = var_452_19
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111102", "story_v_out_424111.awb") ~= 0 then
					local var_452_23 = manager.audio:GetVoiceLength("story_v_out_424111", "424111102", "story_v_out_424111.awb") / 1000

					if var_452_23 + var_452_15 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_23 + var_452_15
					end

					if var_452_18.prefab_name ~= "" and arg_449_1.actors_[var_452_18.prefab_name] ~= nil then
						local var_452_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_18.prefab_name].transform, "story_v_out_424111", "424111102", "story_v_out_424111.awb")

						arg_449_1:RecordAudio("424111102", var_452_24)
						arg_449_1:RecordAudio("424111102", var_452_24)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_424111", "424111102", "story_v_out_424111.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_424111", "424111102", "story_v_out_424111.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_25 = math.max(var_452_16, arg_449_1.talkMaxDuration)

			if var_452_15 <= arg_449_1.time_ and arg_449_1.time_ < var_452_15 + var_452_25 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_15) / var_452_25

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_15 + var_452_25 and arg_449_1.time_ < var_452_15 + var_452_25 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
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
	Play424111103 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 424111103
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play424111104(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = arg_453_1.actors_["10153"]
			local var_456_1 = 0

			if var_456_1 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 and not isNil(var_456_0) and arg_453_1.var_.actorSpriteComps10153 == nil then
				arg_453_1.var_.actorSpriteComps10153 = var_456_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_456_2 = 0.2

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_2 and not isNil(var_456_0) then
				local var_456_3 = (arg_453_1.time_ - var_456_1) / var_456_2

				if arg_453_1.var_.actorSpriteComps10153 then
					for iter_456_0, iter_456_1 in pairs(arg_453_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_456_1 then
							if arg_453_1.isInRecall_ then
								local var_456_4 = Mathf.Lerp(iter_456_1.color.r, arg_453_1.hightColor2.r, var_456_3)
								local var_456_5 = Mathf.Lerp(iter_456_1.color.g, arg_453_1.hightColor2.g, var_456_3)
								local var_456_6 = Mathf.Lerp(iter_456_1.color.b, arg_453_1.hightColor2.b, var_456_3)

								iter_456_1.color = Color.New(var_456_4, var_456_5, var_456_6)
							else
								local var_456_7 = Mathf.Lerp(iter_456_1.color.r, 0.5, var_456_3)

								iter_456_1.color = Color.New(var_456_7, var_456_7, var_456_7)
							end
						end
					end
				end
			end

			if arg_453_1.time_ >= var_456_1 + var_456_2 and arg_453_1.time_ < var_456_1 + var_456_2 + arg_456_0 and not isNil(var_456_0) and arg_453_1.var_.actorSpriteComps10153 then
				for iter_456_2, iter_456_3 in pairs(arg_453_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_456_3 then
						if arg_453_1.isInRecall_ then
							iter_456_3.color = arg_453_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_456_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_453_1.var_.actorSpriteComps10153 = nil
			end

			local var_456_8 = 0
			local var_456_9 = 0.875

			if var_456_8 < arg_453_1.time_ and arg_453_1.time_ <= var_456_8 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				local var_456_10 = arg_453_1:FormatText(StoryNameCfg[7].name)

				arg_453_1.leftNameTxt_.text = var_456_10

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

				local var_456_11 = arg_453_1:GetWordFromCfg(424111103)
				local var_456_12 = arg_453_1:FormatText(var_456_11.content)

				arg_453_1.text_.text = var_456_12

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_13 = 35
				local var_456_14 = utf8.len(var_456_12)
				local var_456_15 = var_456_13 <= 0 and var_456_9 or var_456_9 * (var_456_14 / var_456_13)

				if var_456_15 > 0 and var_456_9 < var_456_15 then
					arg_453_1.talkMaxDuration = var_456_15

					if var_456_15 + var_456_8 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_15 + var_456_8
					end
				end

				arg_453_1.text_.text = var_456_12
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_16 = math.max(var_456_9, arg_453_1.talkMaxDuration)

			if var_456_8 <= arg_453_1.time_ and arg_453_1.time_ < var_456_8 + var_456_16 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_8) / var_456_16

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_8 + var_456_16 and arg_453_1.time_ < var_456_8 + var_456_16 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play424111104 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 424111104
		arg_457_1.duration_ = 2.37

		local var_457_0 = {
			zh = 2,
			ja = 2.366
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
				arg_457_0:Play424111105(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0
			local var_460_1 = 0.25

			if var_460_0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				local var_460_2 = arg_457_1:FormatText(StoryNameCfg[177].name)

				arg_457_1.leftNameTxt_.text = var_460_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, true)
				arg_457_1.iconController_:SetSelectedState("hero")

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_457_1.callingController_:SetSelectedState("normal")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_3 = arg_457_1:GetWordFromCfg(424111104)
				local var_460_4 = arg_457_1:FormatText(var_460_3.content)

				arg_457_1.text_.text = var_460_4

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_5 = 10
				local var_460_6 = utf8.len(var_460_4)
				local var_460_7 = var_460_5 <= 0 and var_460_1 or var_460_1 * (var_460_6 / var_460_5)

				if var_460_7 > 0 and var_460_1 < var_460_7 then
					arg_457_1.talkMaxDuration = var_460_7

					if var_460_7 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_7 + var_460_0
					end
				end

				arg_457_1.text_.text = var_460_4
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111104", "story_v_out_424111.awb") ~= 0 then
					local var_460_8 = manager.audio:GetVoiceLength("story_v_out_424111", "424111104", "story_v_out_424111.awb") / 1000

					if var_460_8 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_8 + var_460_0
					end

					if var_460_3.prefab_name ~= "" and arg_457_1.actors_[var_460_3.prefab_name] ~= nil then
						local var_460_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_3.prefab_name].transform, "story_v_out_424111", "424111104", "story_v_out_424111.awb")

						arg_457_1:RecordAudio("424111104", var_460_9)
						arg_457_1:RecordAudio("424111104", var_460_9)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_424111", "424111104", "story_v_out_424111.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_424111", "424111104", "story_v_out_424111.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_10 = math.max(var_460_1, arg_457_1.talkMaxDuration)

			if var_460_0 <= arg_457_1.time_ and arg_457_1.time_ < var_460_0 + var_460_10 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_0) / var_460_10

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_0 + var_460_10 and arg_457_1.time_ < var_460_0 + var_460_10 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play424111105 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 424111105
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play424111106(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0
			local var_464_1 = 1.35

			if var_464_0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_2 = arg_461_1:FormatText(StoryNameCfg[7].name)

				arg_461_1.leftNameTxt_.text = var_464_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_3 = arg_461_1:GetWordFromCfg(424111105)
				local var_464_4 = arg_461_1:FormatText(var_464_3.content)

				arg_461_1.text_.text = var_464_4

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_5 = 54
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
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_8 = math.max(var_464_1, arg_461_1.talkMaxDuration)

			if var_464_0 <= arg_461_1.time_ and arg_461_1.time_ < var_464_0 + var_464_8 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_0) / var_464_8

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_0 + var_464_8 and arg_461_1.time_ < var_464_0 + var_464_8 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play424111106 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 424111106
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play424111107(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = arg_465_1.actors_["10153"].transform
			local var_468_1 = 0

			if var_468_1 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 then
				arg_465_1.var_.moveOldPos10153 = var_468_0.localPosition
				var_468_0.localScale = Vector3.New(1, 1, 1)

				arg_465_1:CheckSpriteTmpPos("10153", 7)

				local var_468_2 = var_468_0.childCount

				for iter_468_0 = 0, var_468_2 - 1 do
					local var_468_3 = var_468_0:GetChild(iter_468_0)

					if var_468_3.name == "" or not string.find(var_468_3.name, "split") then
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

				var_468_0.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos10153, var_468_6, var_468_5)
			end

			if arg_465_1.time_ >= var_468_1 + var_468_4 and arg_465_1.time_ < var_468_1 + var_468_4 + arg_468_0 then
				var_468_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_468_7 = 0
			local var_468_8 = 1.3

			if var_468_7 < arg_465_1.time_ and arg_465_1.time_ <= var_468_7 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_9 = arg_465_1:GetWordFromCfg(424111106)
				local var_468_10 = arg_465_1:FormatText(var_468_9.content)

				arg_465_1.text_.text = var_468_10

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_11 = 52
				local var_468_12 = utf8.len(var_468_10)
				local var_468_13 = var_468_11 <= 0 and var_468_8 or var_468_8 * (var_468_12 / var_468_11)

				if var_468_13 > 0 and var_468_8 < var_468_13 then
					arg_465_1.talkMaxDuration = var_468_13

					if var_468_13 + var_468_7 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_13 + var_468_7
					end
				end

				arg_465_1.text_.text = var_468_10
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_14 = math.max(var_468_8, arg_465_1.talkMaxDuration)

			if var_468_7 <= arg_465_1.time_ and arg_465_1.time_ < var_468_7 + var_468_14 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_7) / var_468_14

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_7 + var_468_14 and arg_465_1.time_ < var_468_7 + var_468_14 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
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
	Play424111107 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 424111107
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play424111108(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0
			local var_472_1 = 1.3

			if var_472_0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_2 = arg_469_1:FormatText(StoryNameCfg[7].name)

				arg_469_1.leftNameTxt_.text = var_472_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_469_1.callingController_:SetSelectedState("normal")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_3 = arg_469_1:GetWordFromCfg(424111107)
				local var_472_4 = arg_469_1:FormatText(var_472_3.content)

				arg_469_1.text_.text = var_472_4

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 52
				local var_472_6 = utf8.len(var_472_4)
				local var_472_7 = var_472_5 <= 0 and var_472_1 or var_472_1 * (var_472_6 / var_472_5)

				if var_472_7 > 0 and var_472_1 < var_472_7 then
					arg_469_1.talkMaxDuration = var_472_7

					if var_472_7 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_7 + var_472_0
					end
				end

				arg_469_1.text_.text = var_472_4
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_8 = math.max(var_472_1, arg_469_1.talkMaxDuration)

			if var_472_0 <= arg_469_1.time_ and arg_469_1.time_ < var_472_0 + var_472_8 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_0) / var_472_8

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_0 + var_472_8 and arg_469_1.time_ < var_472_0 + var_472_8 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play424111108 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 424111108
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play424111109(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0
			local var_476_1 = 1.4

			if var_476_0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_2 = arg_473_1:FormatText(StoryNameCfg[7].name)

				arg_473_1.leftNameTxt_.text = var_476_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_3 = arg_473_1:GetWordFromCfg(424111108)
				local var_476_4 = arg_473_1:FormatText(var_476_3.content)

				arg_473_1.text_.text = var_476_4

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_5 = 56
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
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_8 = math.max(var_476_1, arg_473_1.talkMaxDuration)

			if var_476_0 <= arg_473_1.time_ and arg_473_1.time_ < var_476_0 + var_476_8 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_0) / var_476_8

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_0 + var_476_8 and arg_473_1.time_ < var_476_0 + var_476_8 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play424111109 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 424111109
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play424111110(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0.3
			local var_480_1 = 1

			if var_480_0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_0 + arg_480_0 then
				local var_480_2 = "play"
				local var_480_3 = "effect"

				arg_477_1:AudioAction(var_480_2, var_480_3, "se_story_145", "se_story_145_summon_slime2", "")
			end

			local var_480_4 = 0
			local var_480_5 = 1.625

			if var_480_4 < arg_477_1.time_ and arg_477_1.time_ <= var_480_4 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, false)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_6 = arg_477_1:GetWordFromCfg(424111109)
				local var_480_7 = arg_477_1:FormatText(var_480_6.content)

				arg_477_1.text_.text = var_480_7

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_8 = 65
				local var_480_9 = utf8.len(var_480_7)
				local var_480_10 = var_480_8 <= 0 and var_480_5 or var_480_5 * (var_480_9 / var_480_8)

				if var_480_10 > 0 and var_480_5 < var_480_10 then
					arg_477_1.talkMaxDuration = var_480_10

					if var_480_10 + var_480_4 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_10 + var_480_4
					end
				end

				arg_477_1.text_.text = var_480_7
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_11 = math.max(var_480_5, arg_477_1.talkMaxDuration)

			if var_480_4 <= arg_477_1.time_ and arg_477_1.time_ < var_480_4 + var_480_11 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_4) / var_480_11

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_4 + var_480_11 and arg_477_1.time_ < var_480_4 + var_480_11 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play424111110 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 424111110
		arg_481_1.duration_ = 14.53

		local var_481_0 = {
			zh = 8.866,
			ja = 14.533
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
				arg_481_0:Play424111111(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0

			if var_484_0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_0 + arg_484_0 then
				arg_481_1.allBtn_.enabled = false
			end

			local var_484_1 = 2.46666666666667

			if arg_481_1.time_ >= var_484_0 + var_484_1 and arg_481_1.time_ < var_484_0 + var_484_1 + arg_484_0 then
				arg_481_1.allBtn_.enabled = true
			end

			local var_484_2 = 0
			local var_484_3 = 4.46666666666667

			if var_484_2 < arg_481_1.time_ and arg_481_1.time_ <= var_484_2 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_4 = arg_481_1:FormatText(StoryNameCfg[1391].name)

				arg_481_1.leftNameTxt_.text = var_484_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, true)
				arg_481_1.iconController_:SetSelectedState("hero")

				arg_481_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10155_split_6")

				arg_481_1.callingController_:SetSelectedState("normal")

				arg_481_1.keyicon_.color = Color.New(1, 1, 1)
				arg_481_1.icon_.color = Color.New(1, 1, 1)

				local var_484_5 = arg_481_1:GetWordFromCfg(424111110)
				local var_484_6 = arg_481_1:FormatText(var_484_5.content)

				arg_481_1.text_.text = var_484_6

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_7 = 36
				local var_484_8 = utf8.len(var_484_6)
				local var_484_9 = var_484_7 <= 0 and var_484_3 or var_484_3 * (var_484_8 / var_484_7)

				if var_484_9 > 0 and var_484_3 < var_484_9 then
					arg_481_1.talkMaxDuration = var_484_9

					if var_484_9 + var_484_2 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_9 + var_484_2
					end
				end

				arg_481_1.text_.text = var_484_6
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111110", "story_v_out_424111.awb") ~= 0 then
					local var_484_10 = manager.audio:GetVoiceLength("story_v_out_424111", "424111110", "story_v_out_424111.awb") / 1000

					if var_484_10 + var_484_2 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_10 + var_484_2
					end

					if var_484_5.prefab_name ~= "" and arg_481_1.actors_[var_484_5.prefab_name] ~= nil then
						local var_484_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_5.prefab_name].transform, "story_v_out_424111", "424111110", "story_v_out_424111.awb")

						arg_481_1:RecordAudio("424111110", var_484_11)
						arg_481_1:RecordAudio("424111110", var_484_11)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_424111", "424111110", "story_v_out_424111.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_424111", "424111110", "story_v_out_424111.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_12 = math.max(var_484_3, arg_481_1.talkMaxDuration)

			if var_484_2 <= arg_481_1.time_ and arg_481_1.time_ < var_484_2 + var_484_12 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_2) / var_484_12

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_2 + var_484_12 and arg_481_1.time_ < var_484_2 + var_484_12 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play424111111 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 424111111
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play424111112(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = manager.ui.mainCamera.transform
			local var_488_1 = 0

			if var_488_1 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 then
				arg_485_1.var_.shakeOldPos = var_488_0.localPosition
			end

			local var_488_2 = 1

			if var_488_1 <= arg_485_1.time_ and arg_485_1.time_ < var_488_1 + var_488_2 then
				local var_488_3 = (arg_485_1.time_ - var_488_1) / 0.066
				local var_488_4, var_488_5 = math.modf(var_488_3)

				var_488_0.localPosition = Vector3.New(var_488_5 * 0.13, var_488_5 * 0.13, var_488_5 * 0.13) + arg_485_1.var_.shakeOldPos
			end

			if arg_485_1.time_ >= var_488_1 + var_488_2 and arg_485_1.time_ < var_488_1 + var_488_2 + arg_488_0 then
				var_488_0.localPosition = arg_485_1.var_.shakeOldPos
			end

			local var_488_6 = 0

			if var_488_6 < arg_485_1.time_ and arg_485_1.time_ <= var_488_6 + arg_488_0 then
				arg_485_1.allBtn_.enabled = false
			end

			local var_488_7 = 0.5

			if arg_485_1.time_ >= var_488_6 + var_488_7 and arg_485_1.time_ < var_488_6 + var_488_7 + arg_488_0 then
				arg_485_1.allBtn_.enabled = true
			end

			local var_488_8 = 0.8
			local var_488_9 = 1

			if var_488_8 < arg_485_1.time_ and arg_485_1.time_ <= var_488_8 + arg_488_0 then
				local var_488_10 = "play"
				local var_488_11 = "effect"

				arg_485_1:AudioAction(var_488_10, var_488_11, "se_story_1310", "se_story_1310_rush", "")
			end

			local var_488_12 = 0
			local var_488_13 = 1.375

			if var_488_12 < arg_485_1.time_ and arg_485_1.time_ <= var_488_12 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0

				arg_485_1.dialog_:SetActive(true)

				arg_485_1.dialogCg_.alpha = 0

				local var_488_14 = LeanTween.value(arg_485_1.dialog_, 0, 1, 0.3)

				var_488_14:setOnUpdate(LuaHelper.FloatAction(function(arg_489_0)
					arg_485_1.dialogCg_.alpha = arg_489_0
				end))
				var_488_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_485_1.dialog_)
					var_488_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_485_1.duration_ = arg_485_1.duration_ + 0.3

				SetActive(arg_485_1.leftNameGo_, false)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_15 = arg_485_1:GetWordFromCfg(424111111)
				local var_488_16 = arg_485_1:FormatText(var_488_15.content)

				arg_485_1.text_.text = var_488_16

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_17 = 55
				local var_488_18 = utf8.len(var_488_16)
				local var_488_19 = var_488_17 <= 0 and var_488_13 or var_488_13 * (var_488_18 / var_488_17)

				if var_488_19 > 0 and var_488_13 < var_488_19 then
					arg_485_1.talkMaxDuration = var_488_19
					var_488_12 = var_488_12 + 0.3

					if var_488_19 + var_488_12 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_19 + var_488_12
					end
				end

				arg_485_1.text_.text = var_488_16
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_20 = var_488_12 + 0.3
			local var_488_21 = math.max(var_488_13, arg_485_1.talkMaxDuration)

			if var_488_20 <= arg_485_1.time_ and arg_485_1.time_ < var_488_20 + var_488_21 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_20) / var_488_21

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_20 + var_488_21 and arg_485_1.time_ < var_488_20 + var_488_21 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play424111112 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 424111112
		arg_491_1.duration_ = 5

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play424111113(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0.166666666666667
			local var_494_1 = 1

			if var_494_0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_0 + arg_494_0 then
				local var_494_2 = "play"
				local var_494_3 = "effect"

				arg_491_1:AudioAction(var_494_2, var_494_3, "se_story_146", "se_story_146_hit", "")
			end

			local var_494_4 = 0
			local var_494_5 = 1.075

			if var_494_4 < arg_491_1.time_ and arg_491_1.time_ <= var_494_4 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, false)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_6 = arg_491_1:GetWordFromCfg(424111112)
				local var_494_7 = arg_491_1:FormatText(var_494_6.content)

				arg_491_1.text_.text = var_494_7

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_8 = 43
				local var_494_9 = utf8.len(var_494_7)
				local var_494_10 = var_494_8 <= 0 and var_494_5 or var_494_5 * (var_494_9 / var_494_8)

				if var_494_10 > 0 and var_494_5 < var_494_10 then
					arg_491_1.talkMaxDuration = var_494_10

					if var_494_10 + var_494_4 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_10 + var_494_4
					end
				end

				arg_491_1.text_.text = var_494_7
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)
				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_11 = math.max(var_494_5, arg_491_1.talkMaxDuration)

			if var_494_4 <= arg_491_1.time_ and arg_491_1.time_ < var_494_4 + var_494_11 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_4) / var_494_11

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_4 + var_494_11 and arg_491_1.time_ < var_494_4 + var_494_11 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play424111113 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 424111113
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play424111114(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0
			local var_498_1 = 0.3

			if var_498_0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				local var_498_2 = arg_495_1:FormatText(StoryNameCfg[7].name)

				arg_495_1.leftNameTxt_.text = var_498_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, true)
				arg_495_1.iconController_:SetSelectedState("hero")

				arg_495_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_495_1.callingController_:SetSelectedState("normal")

				arg_495_1.keyicon_.color = Color.New(1, 1, 1)
				arg_495_1.icon_.color = Color.New(1, 1, 1)

				local var_498_3 = arg_495_1:GetWordFromCfg(424111113)
				local var_498_4 = arg_495_1:FormatText(var_498_3.content)

				arg_495_1.text_.text = var_498_4

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_5 = 12
				local var_498_6 = utf8.len(var_498_4)
				local var_498_7 = var_498_5 <= 0 and var_498_1 or var_498_1 * (var_498_6 / var_498_5)

				if var_498_7 > 0 and var_498_1 < var_498_7 then
					arg_495_1.talkMaxDuration = var_498_7

					if var_498_7 + var_498_0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_7 + var_498_0
					end
				end

				arg_495_1.text_.text = var_498_4
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_8 = math.max(var_498_1, arg_495_1.talkMaxDuration)

			if var_498_0 <= arg_495_1.time_ and arg_495_1.time_ < var_498_0 + var_498_8 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_0) / var_498_8

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_0 + var_498_8 and arg_495_1.time_ < var_498_0 + var_498_8 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play424111114 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 424111114
		arg_499_1.duration_ = 2.5

		local var_499_0 = {
			zh = 2.5,
			ja = 1.433333333332
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
			arg_499_1.auto_ = false
		end

		function arg_499_1.playNext_(arg_501_0)
			arg_499_1.onStoryFinished_()
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = arg_499_1.actors_["1194"]
			local var_502_1 = 0

			if var_502_1 < arg_499_1.time_ and arg_499_1.time_ <= var_502_1 + arg_502_0 and not isNil(var_502_0) and arg_499_1.var_.actorSpriteComps1194 == nil then
				arg_499_1.var_.actorSpriteComps1194 = var_502_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_502_2 = 0.2

			if var_502_1 <= arg_499_1.time_ and arg_499_1.time_ < var_502_1 + var_502_2 and not isNil(var_502_0) then
				local var_502_3 = (arg_499_1.time_ - var_502_1) / var_502_2

				if arg_499_1.var_.actorSpriteComps1194 then
					for iter_502_0, iter_502_1 in pairs(arg_499_1.var_.actorSpriteComps1194:ToTable()) do
						if iter_502_1 then
							if arg_499_1.isInRecall_ then
								local var_502_4 = Mathf.Lerp(iter_502_1.color.r, arg_499_1.hightColor1.r, var_502_3)
								local var_502_5 = Mathf.Lerp(iter_502_1.color.g, arg_499_1.hightColor1.g, var_502_3)
								local var_502_6 = Mathf.Lerp(iter_502_1.color.b, arg_499_1.hightColor1.b, var_502_3)

								iter_502_1.color = Color.New(var_502_4, var_502_5, var_502_6)
							else
								local var_502_7 = Mathf.Lerp(iter_502_1.color.r, 1, var_502_3)

								iter_502_1.color = Color.New(var_502_7, var_502_7, var_502_7)
							end
						end
					end
				end
			end

			if arg_499_1.time_ >= var_502_1 + var_502_2 and arg_499_1.time_ < var_502_1 + var_502_2 + arg_502_0 and not isNil(var_502_0) and arg_499_1.var_.actorSpriteComps1194 then
				for iter_502_2, iter_502_3 in pairs(arg_499_1.var_.actorSpriteComps1194:ToTable()) do
					if iter_502_3 then
						if arg_499_1.isInRecall_ then
							iter_502_3.color = arg_499_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_502_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_499_1.var_.actorSpriteComps1194 = nil
			end

			local var_502_8 = arg_499_1.actors_["1194"].transform
			local var_502_9 = 0

			if var_502_9 < arg_499_1.time_ and arg_499_1.time_ <= var_502_9 + arg_502_0 then
				arg_499_1.var_.moveOldPos1194 = var_502_8.localPosition
				var_502_8.localScale = Vector3.New(1, 1, 1)

				arg_499_1:CheckSpriteTmpPos("1194", 3)

				local var_502_10 = var_502_8.childCount

				for iter_502_4 = 0, var_502_10 - 1 do
					local var_502_11 = var_502_8:GetChild(iter_502_4)

					if var_502_11.name == "split_4" or not string.find(var_502_11.name, "split") then
						var_502_11.gameObject:SetActive(true)
					else
						var_502_11.gameObject:SetActive(false)
					end
				end
			end

			local var_502_12 = 0.001

			if var_502_9 <= arg_499_1.time_ and arg_499_1.time_ < var_502_9 + var_502_12 then
				local var_502_13 = (arg_499_1.time_ - var_502_9) / var_502_12
				local var_502_14 = Vector3.New(-60, -360, -240)

				var_502_8.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos1194, var_502_14, var_502_13)
			end

			if arg_499_1.time_ >= var_502_9 + var_502_12 and arg_499_1.time_ < var_502_9 + var_502_12 + arg_502_0 then
				var_502_8.localPosition = Vector3.New(-60, -360, -240)
			end

			local var_502_15 = arg_499_1.actors_["1194"]
			local var_502_16 = 0

			if var_502_16 < arg_499_1.time_ and arg_499_1.time_ <= var_502_16 + arg_502_0 then
				local var_502_17 = var_502_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_502_17 then
					arg_499_1.var_.alphaOldValue1194 = var_502_17.alpha
					arg_499_1.var_.characterEffect1194 = var_502_17
				end

				arg_499_1.var_.alphaOldValue1194 = 0
			end

			local var_502_18 = 0.5

			if var_502_16 <= arg_499_1.time_ and arg_499_1.time_ < var_502_16 + var_502_18 then
				local var_502_19 = (arg_499_1.time_ - var_502_16) / var_502_18
				local var_502_20 = Mathf.Lerp(arg_499_1.var_.alphaOldValue1194, 1, var_502_19)

				if arg_499_1.var_.characterEffect1194 then
					arg_499_1.var_.characterEffect1194.alpha = var_502_20
				end
			end

			if arg_499_1.time_ >= var_502_16 + var_502_18 and arg_499_1.time_ < var_502_16 + var_502_18 + arg_502_0 and arg_499_1.var_.characterEffect1194 then
				arg_499_1.var_.characterEffect1194.alpha = 1
			end

			local var_502_21 = 0
			local var_502_22 = 0.2

			if var_502_21 < arg_499_1.time_ and arg_499_1.time_ <= var_502_21 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				local var_502_23 = arg_499_1:FormatText(StoryNameCfg[181].name)

				arg_499_1.leftNameTxt_.text = var_502_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_24 = arg_499_1:GetWordFromCfg(424111114)
				local var_502_25 = arg_499_1:FormatText(var_502_24.content)

				arg_499_1.text_.text = var_502_25

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_26 = 8
				local var_502_27 = utf8.len(var_502_25)
				local var_502_28 = var_502_26 <= 0 and var_502_22 or var_502_22 * (var_502_27 / var_502_26)

				if var_502_28 > 0 and var_502_22 < var_502_28 then
					arg_499_1.talkMaxDuration = var_502_28

					if var_502_28 + var_502_21 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_28 + var_502_21
					end
				end

				arg_499_1.text_.text = var_502_25
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424111", "424111114", "story_v_out_424111.awb") ~= 0 then
					local var_502_29 = manager.audio:GetVoiceLength("story_v_out_424111", "424111114", "story_v_out_424111.awb") / 1000

					if var_502_29 + var_502_21 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_29 + var_502_21
					end

					if var_502_24.prefab_name ~= "" and arg_499_1.actors_[var_502_24.prefab_name] ~= nil then
						local var_502_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_24.prefab_name].transform, "story_v_out_424111", "424111114", "story_v_out_424111.awb")

						arg_499_1:RecordAudio("424111114", var_502_30)
						arg_499_1:RecordAudio("424111114", var_502_30)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_424111", "424111114", "story_v_out_424111.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_424111", "424111114", "story_v_out_424111.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_31 = math.max(var_502_22, arg_499_1.talkMaxDuration)

			if var_502_21 <= arg_499_1.time_ and arg_499_1.time_ < var_502_21 + var_502_31 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_21) / var_502_31

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_21 + var_502_31 and arg_499_1.time_ < var_502_21 + var_502_31 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_499_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0115a",
		"TextureConfig/Background/ST0116a",
		"TextureConfig/Background/ST0117",
		"TextureConfig/Background/SS2403",
		"TextureConfig/Background/SS2403a",
		"TextureConfig/Background/SS2403b",
		"TextureConfig/Background/STwhite"
	},
	voices = {
		"story_v_out_424111.awb"
	}
}
