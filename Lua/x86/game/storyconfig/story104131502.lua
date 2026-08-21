return {
	Play413152001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413152001
		arg_1_1.duration_ = 9.1

		local var_1_0 = {
			zh = 5.733,
			ja = 9.1
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
				arg_1_0:Play413152002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F08i"

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
				local var_4_5 = arg_1_1.bgs_.F08i

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
					if iter_4_0 ~= "F08i" then
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
			local var_4_25 = 0.433333333333333

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

			local var_4_30 = 1.26666666666667
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_36 = 2
			local var_4_37 = 0.525

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[992].name)

				arg_1_1.leftNameTxt_.text = var_4_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_40 = arg_1_1:GetWordFromCfg(413152001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 21
				local var_4_43 = utf8.len(var_4_41)
				local var_4_44 = var_4_42 <= 0 and var_4_37 or var_4_37 * (var_4_43 / var_4_42)

				if var_4_44 > 0 and var_4_37 < var_4_44 then
					arg_1_1.talkMaxDuration = var_4_44
					var_4_36 = var_4_36 + 0.3

					if var_4_44 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_41
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152001", "story_v_out_413152.awb") ~= 0 then
					local var_4_45 = manager.audio:GetVoiceLength("story_v_out_413152", "413152001", "story_v_out_413152.awb") / 1000

					if var_4_45 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_36
					end

					if var_4_40.prefab_name ~= "" and arg_1_1.actors_[var_4_40.prefab_name] ~= nil then
						local var_4_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_40.prefab_name].transform, "story_v_out_413152", "413152001", "story_v_out_413152.awb")

						arg_1_1:RecordAudio("413152001", var_4_46)
						arg_1_1:RecordAudio("413152001", var_4_46)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413152", "413152001", "story_v_out_413152.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413152", "413152001", "story_v_out_413152.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_47 = var_4_36 + 0.3
			local var_4_48 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_47 <= arg_1_1.time_ and arg_1_1.time_ < var_4_47 + var_4_48 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_47) / var_4_48

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_47 + var_4_48 and arg_1_1.time_ < var_4_47 + var_4_48 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play413152002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413152002
		arg_9_1.duration_ = 6.9

		local var_9_0 = {
			zh = 1.999999999999,
			ja = 6.9
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
				arg_9_0:Play413152003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "10094"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

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

			local var_12_4 = arg_9_1.actors_["10094"].transform
			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1.var_.moveOldPos10094 = var_12_4.localPosition
				var_12_4.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10094", 3)

				local var_12_6 = var_12_4.childCount

				for iter_12_2 = 0, var_12_6 - 1 do
					local var_12_7 = var_12_4:GetChild(iter_12_2)

					if var_12_7.name == "" or not string.find(var_12_7.name, "split") then
						var_12_7.gameObject:SetActive(true)
					else
						var_12_7.gameObject:SetActive(false)
					end
				end
			end

			local var_12_8 = 0.001

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_8 then
				local var_12_9 = (arg_9_1.time_ - var_12_5) / var_12_8
				local var_12_10 = Vector3.New(0, -340, -414)

				var_12_4.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10094, var_12_10, var_12_9)
			end

			if arg_9_1.time_ >= var_12_5 + var_12_8 and arg_9_1.time_ < var_12_5 + var_12_8 + arg_12_0 then
				var_12_4.localPosition = Vector3.New(0, -340, -414)
			end

			local var_12_11 = arg_9_1.actors_["10094"]
			local var_12_12 = 0

			if var_12_12 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.actorSpriteComps10094 == nil then
				arg_9_1.var_.actorSpriteComps10094 = var_12_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_13 = 2

			if var_12_12 <= arg_9_1.time_ and arg_9_1.time_ < var_12_12 + var_12_13 and not isNil(var_12_11) then
				local var_12_14 = (arg_9_1.time_ - var_12_12) / var_12_13

				if arg_9_1.var_.actorSpriteComps10094 then
					for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_12_4 then
							if arg_9_1.isInRecall_ then
								local var_12_15 = Mathf.Lerp(iter_12_4.color.r, arg_9_1.hightColor1.r, var_12_14)
								local var_12_16 = Mathf.Lerp(iter_12_4.color.g, arg_9_1.hightColor1.g, var_12_14)
								local var_12_17 = Mathf.Lerp(iter_12_4.color.b, arg_9_1.hightColor1.b, var_12_14)

								iter_12_4.color = Color.New(var_12_15, var_12_16, var_12_17)
							else
								local var_12_18 = Mathf.Lerp(iter_12_4.color.r, 1, var_12_14)

								iter_12_4.color = Color.New(var_12_18, var_12_18, var_12_18)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_12 + var_12_13 and arg_9_1.time_ < var_12_12 + var_12_13 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.actorSpriteComps10094 then
				for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_12_6 then
						if arg_9_1.isInRecall_ then
							iter_12_6.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10094 = nil
			end

			local var_12_19 = arg_9_1.actors_["10094"]
			local var_12_20 = 0

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				local var_12_21 = var_12_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_21 then
					arg_9_1.var_.alphaOldValue10094 = var_12_21.alpha
					arg_9_1.var_.characterEffect10094 = var_12_21
				end

				arg_9_1.var_.alphaOldValue10094 = 0
			end

			local var_12_22 = 0.5

			if var_12_20 <= arg_9_1.time_ and arg_9_1.time_ < var_12_20 + var_12_22 then
				local var_12_23 = (arg_9_1.time_ - var_12_20) / var_12_22
				local var_12_24 = Mathf.Lerp(arg_9_1.var_.alphaOldValue10094, 1, var_12_23)

				if arg_9_1.var_.characterEffect10094 then
					arg_9_1.var_.characterEffect10094.alpha = var_12_24
				end
			end

			if arg_9_1.time_ >= var_12_20 + var_12_22 and arg_9_1.time_ < var_12_20 + var_12_22 + arg_12_0 and arg_9_1.var_.characterEffect10094 then
				arg_9_1.var_.characterEffect10094.alpha = 1
			end

			local var_12_25 = 0
			local var_12_26 = 0.225

			if var_12_25 < arg_9_1.time_ and arg_9_1.time_ <= var_12_25 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_27 = arg_9_1:FormatText(StoryNameCfg[259].name)

				arg_9_1.leftNameTxt_.text = var_12_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_28 = arg_9_1:GetWordFromCfg(413152002)
				local var_12_29 = arg_9_1:FormatText(var_12_28.content)

				arg_9_1.text_.text = var_12_29

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_30 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152002", "story_v_out_413152.awb") ~= 0 then
					local var_12_33 = manager.audio:GetVoiceLength("story_v_out_413152", "413152002", "story_v_out_413152.awb") / 1000

					if var_12_33 + var_12_25 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_33 + var_12_25
					end

					if var_12_28.prefab_name ~= "" and arg_9_1.actors_[var_12_28.prefab_name] ~= nil then
						local var_12_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_28.prefab_name].transform, "story_v_out_413152", "413152002", "story_v_out_413152.awb")

						arg_9_1:RecordAudio("413152002", var_12_34)
						arg_9_1:RecordAudio("413152002", var_12_34)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_413152", "413152002", "story_v_out_413152.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_413152", "413152002", "story_v_out_413152.awb")
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
				actorName = "10094",
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
	Play413152003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413152003
		arg_13_1.duration_ = 5.57

		local var_13_0 = {
			zh = 2.5,
			ja = 5.566
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
				arg_13_0:Play413152004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10094"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos10094 = var_16_0.localPosition
				var_16_0.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10094", 3)

				local var_16_2 = var_16_0.childCount

				for iter_16_0 = 0, var_16_2 - 1 do
					local var_16_3 = var_16_0:GetChild(iter_16_0)

					if var_16_3.name == "" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_4 then
				local var_16_5 = (arg_13_1.time_ - var_16_1) / var_16_4
				local var_16_6 = Vector3.New(0, -340, -414)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10094, var_16_6, var_16_5)
			end

			if arg_13_1.time_ >= var_16_1 + var_16_4 and arg_13_1.time_ < var_16_1 + var_16_4 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_16_7 = arg_13_1.actors_["10094"]
			local var_16_8 = 0

			if var_16_8 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps10094 == nil then
				arg_13_1.var_.actorSpriteComps10094 = var_16_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_9 = 2

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_9 and not isNil(var_16_7) then
				local var_16_10 = (arg_13_1.time_ - var_16_8) / var_16_9

				if arg_13_1.var_.actorSpriteComps10094 then
					for iter_16_1, iter_16_2 in pairs(arg_13_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_16_2 then
							if arg_13_1.isInRecall_ then
								local var_16_11 = Mathf.Lerp(iter_16_2.color.r, arg_13_1.hightColor2.r, var_16_10)
								local var_16_12 = Mathf.Lerp(iter_16_2.color.g, arg_13_1.hightColor2.g, var_16_10)
								local var_16_13 = Mathf.Lerp(iter_16_2.color.b, arg_13_1.hightColor2.b, var_16_10)

								iter_16_2.color = Color.New(var_16_11, var_16_12, var_16_13)
							else
								local var_16_14 = Mathf.Lerp(iter_16_2.color.r, 0.5, var_16_10)

								iter_16_2.color = Color.New(var_16_14, var_16_14, var_16_14)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_8 + var_16_9 and arg_13_1.time_ < var_16_8 + var_16_9 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps10094 then
				for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_16_4 then
						if arg_13_1.isInRecall_ then
							iter_16_4.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10094 = nil
			end

			local var_16_15 = 0
			local var_16_16 = 0.3

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_17 = arg_13_1:FormatText(StoryNameCfg[992].name)

				arg_13_1.leftNameTxt_.text = var_16_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_18 = arg_13_1:GetWordFromCfg(413152003)
				local var_16_19 = arg_13_1:FormatText(var_16_18.content)

				arg_13_1.text_.text = var_16_19

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_20 = 12
				local var_16_21 = utf8.len(var_16_19)
				local var_16_22 = var_16_20 <= 0 and var_16_16 or var_16_16 * (var_16_21 / var_16_20)

				if var_16_22 > 0 and var_16_16 < var_16_22 then
					arg_13_1.talkMaxDuration = var_16_22

					if var_16_22 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_22 + var_16_15
					end
				end

				arg_13_1.text_.text = var_16_19
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152003", "story_v_out_413152.awb") ~= 0 then
					local var_16_23 = manager.audio:GetVoiceLength("story_v_out_413152", "413152003", "story_v_out_413152.awb") / 1000

					if var_16_23 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_23 + var_16_15
					end

					if var_16_18.prefab_name ~= "" and arg_13_1.actors_[var_16_18.prefab_name] ~= nil then
						local var_16_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_18.prefab_name].transform, "story_v_out_413152", "413152003", "story_v_out_413152.awb")

						arg_13_1:RecordAudio("413152003", var_16_24)
						arg_13_1:RecordAudio("413152003", var_16_24)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_413152", "413152003", "story_v_out_413152.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_413152", "413152003", "story_v_out_413152.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_25 = math.max(var_16_16, arg_13_1.talkMaxDuration)

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_25 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_15) / var_16_25

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_15 + var_16_25 and arg_13_1.time_ < var_16_15 + var_16_25 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play413152004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413152004
		arg_17_1.duration_ = 4

		local var_17_0 = {
			zh = 2.2,
			ja = 4
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
				arg_17_0:Play413152005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10094"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos10094 = var_20_0.localPosition
				var_20_0.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10094", 3)

				local var_20_2 = var_20_0.childCount

				for iter_20_0 = 0, var_20_2 - 1 do
					local var_20_3 = var_20_0:GetChild(iter_20_0)

					if var_20_3.name == "" or not string.find(var_20_3.name, "split") then
						var_20_3.gameObject:SetActive(true)
					else
						var_20_3.gameObject:SetActive(false)
					end
				end
			end

			local var_20_4 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_4 then
				local var_20_5 = (arg_17_1.time_ - var_20_1) / var_20_4
				local var_20_6 = Vector3.New(0, -340, -414)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10094, var_20_6, var_20_5)
			end

			if arg_17_1.time_ >= var_20_1 + var_20_4 and arg_17_1.time_ < var_20_1 + var_20_4 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_20_7 = arg_17_1.actors_["10094"]
			local var_20_8 = 0

			if var_20_8 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.actorSpriteComps10094 == nil then
				arg_17_1.var_.actorSpriteComps10094 = var_20_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_9 = 2

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_9 and not isNil(var_20_7) then
				local var_20_10 = (arg_17_1.time_ - var_20_8) / var_20_9

				if arg_17_1.var_.actorSpriteComps10094 then
					for iter_20_1, iter_20_2 in pairs(arg_17_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_20_2 then
							if arg_17_1.isInRecall_ then
								local var_20_11 = Mathf.Lerp(iter_20_2.color.r, arg_17_1.hightColor1.r, var_20_10)
								local var_20_12 = Mathf.Lerp(iter_20_2.color.g, arg_17_1.hightColor1.g, var_20_10)
								local var_20_13 = Mathf.Lerp(iter_20_2.color.b, arg_17_1.hightColor1.b, var_20_10)

								iter_20_2.color = Color.New(var_20_11, var_20_12, var_20_13)
							else
								local var_20_14 = Mathf.Lerp(iter_20_2.color.r, 1, var_20_10)

								iter_20_2.color = Color.New(var_20_14, var_20_14, var_20_14)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_8 + var_20_9 and arg_17_1.time_ < var_20_8 + var_20_9 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.actorSpriteComps10094 then
				for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_20_4 then
						if arg_17_1.isInRecall_ then
							iter_20_4.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10094 = nil
			end

			local var_20_15 = 0
			local var_20_16 = 0.2

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_17 = arg_17_1:FormatText(StoryNameCfg[259].name)

				arg_17_1.leftNameTxt_.text = var_20_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_18 = arg_17_1:GetWordFromCfg(413152004)
				local var_20_19 = arg_17_1:FormatText(var_20_18.content)

				arg_17_1.text_.text = var_20_19

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_20 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152004", "story_v_out_413152.awb") ~= 0 then
					local var_20_23 = manager.audio:GetVoiceLength("story_v_out_413152", "413152004", "story_v_out_413152.awb") / 1000

					if var_20_23 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_23 + var_20_15
					end

					if var_20_18.prefab_name ~= "" and arg_17_1.actors_[var_20_18.prefab_name] ~= nil then
						local var_20_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_18.prefab_name].transform, "story_v_out_413152", "413152004", "story_v_out_413152.awb")

						arg_17_1:RecordAudio("413152004", var_20_24)
						arg_17_1:RecordAudio("413152004", var_20_24)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413152", "413152004", "story_v_out_413152.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413152", "413152004", "story_v_out_413152.awb")
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
				actorName = "10094",
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
	Play413152005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413152005
		arg_21_1.duration_ = 8.27

		local var_21_0 = {
			zh = 5.3,
			ja = 8.266
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
				arg_21_0:Play413152006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10094"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10094 == nil then
				arg_21_1.var_.actorSpriteComps10094 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps10094 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								local var_24_4 = Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor2.r, var_24_3)
								local var_24_5 = Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor2.g, var_24_3)
								local var_24_6 = Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor2.b, var_24_3)

								iter_24_1.color = Color.New(var_24_4, var_24_5, var_24_6)
							else
								local var_24_7 = Mathf.Lerp(iter_24_1.color.r, 0.5, var_24_3)

								iter_24_1.color = Color.New(var_24_7, var_24_7, var_24_7)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10094 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10094 = nil
			end

			local var_24_8 = 0
			local var_24_9 = 0.625

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_10 = arg_21_1:FormatText(StoryNameCfg[992].name)

				arg_21_1.leftNameTxt_.text = var_24_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_11 = arg_21_1:GetWordFromCfg(413152005)
				local var_24_12 = arg_21_1:FormatText(var_24_11.content)

				arg_21_1.text_.text = var_24_12

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 25
				local var_24_14 = utf8.len(var_24_12)
				local var_24_15 = var_24_13 <= 0 and var_24_9 or var_24_9 * (var_24_14 / var_24_13)

				if var_24_15 > 0 and var_24_9 < var_24_15 then
					arg_21_1.talkMaxDuration = var_24_15

					if var_24_15 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_15 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_12
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152005", "story_v_out_413152.awb") ~= 0 then
					local var_24_16 = manager.audio:GetVoiceLength("story_v_out_413152", "413152005", "story_v_out_413152.awb") / 1000

					if var_24_16 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_16 + var_24_8
					end

					if var_24_11.prefab_name ~= "" and arg_21_1.actors_[var_24_11.prefab_name] ~= nil then
						local var_24_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_11.prefab_name].transform, "story_v_out_413152", "413152005", "story_v_out_413152.awb")

						arg_21_1:RecordAudio("413152005", var_24_17)
						arg_21_1:RecordAudio("413152005", var_24_17)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413152", "413152005", "story_v_out_413152.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413152", "413152005", "story_v_out_413152.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_18 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_18 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_18

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_18 and arg_21_1.time_ < var_24_8 + var_24_18 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play413152006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413152006
		arg_25_1.duration_ = 3

		local var_25_0 = {
			zh = 2.266,
			ja = 3
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
				arg_25_0:Play413152007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10094"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos10094 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10094", 3)

				local var_28_2 = var_28_0.childCount

				for iter_28_0 = 0, var_28_2 - 1 do
					local var_28_3 = var_28_0:GetChild(iter_28_0)

					if var_28_3.name == "" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_4 then
				local var_28_5 = (arg_25_1.time_ - var_28_1) / var_28_4
				local var_28_6 = Vector3.New(0, -340, -414)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10094, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_28_7 = arg_25_1.actors_["10094"]
			local var_28_8 = 0

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps10094 == nil then
				arg_25_1.var_.actorSpriteComps10094 = var_28_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_9 = 2

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_9 and not isNil(var_28_7) then
				local var_28_10 = (arg_25_1.time_ - var_28_8) / var_28_9

				if arg_25_1.var_.actorSpriteComps10094 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_28_2 then
							if arg_25_1.isInRecall_ then
								local var_28_11 = Mathf.Lerp(iter_28_2.color.r, arg_25_1.hightColor1.r, var_28_10)
								local var_28_12 = Mathf.Lerp(iter_28_2.color.g, arg_25_1.hightColor1.g, var_28_10)
								local var_28_13 = Mathf.Lerp(iter_28_2.color.b, arg_25_1.hightColor1.b, var_28_10)

								iter_28_2.color = Color.New(var_28_11, var_28_12, var_28_13)
							else
								local var_28_14 = Mathf.Lerp(iter_28_2.color.r, 1, var_28_10)

								iter_28_2.color = Color.New(var_28_14, var_28_14, var_28_14)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_8 + var_28_9 and arg_25_1.time_ < var_28_8 + var_28_9 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps10094 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_28_4 then
						if arg_25_1.isInRecall_ then
							iter_28_4.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10094 = nil
			end

			local var_28_15 = 0
			local var_28_16 = 0.275

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_17 = arg_25_1:FormatText(StoryNameCfg[259].name)

				arg_25_1.leftNameTxt_.text = var_28_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_18 = arg_25_1:GetWordFromCfg(413152006)
				local var_28_19 = arg_25_1:FormatText(var_28_18.content)

				arg_25_1.text_.text = var_28_19

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_20 = 11
				local var_28_21 = utf8.len(var_28_19)
				local var_28_22 = var_28_20 <= 0 and var_28_16 or var_28_16 * (var_28_21 / var_28_20)

				if var_28_22 > 0 and var_28_16 < var_28_22 then
					arg_25_1.talkMaxDuration = var_28_22

					if var_28_22 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_22 + var_28_15
					end
				end

				arg_25_1.text_.text = var_28_19
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152006", "story_v_out_413152.awb") ~= 0 then
					local var_28_23 = manager.audio:GetVoiceLength("story_v_out_413152", "413152006", "story_v_out_413152.awb") / 1000

					if var_28_23 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_23 + var_28_15
					end

					if var_28_18.prefab_name ~= "" and arg_25_1.actors_[var_28_18.prefab_name] ~= nil then
						local var_28_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_18.prefab_name].transform, "story_v_out_413152", "413152006", "story_v_out_413152.awb")

						arg_25_1:RecordAudio("413152006", var_28_24)
						arg_25_1:RecordAudio("413152006", var_28_24)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413152", "413152006", "story_v_out_413152.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413152", "413152006", "story_v_out_413152.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_25 = math.max(var_28_16, arg_25_1.talkMaxDuration)

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_25 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_15) / var_28_25

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_15 + var_28_25 and arg_25_1.time_ < var_28_15 + var_28_25 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play413152007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413152007
		arg_29_1.duration_ = 4.33

		local var_29_0 = {
			zh = 1.999999999999,
			ja = 4.333
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
				arg_29_0:Play413152008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10094"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos10094 = var_32_0.localPosition
				var_32_0.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10094", 3)

				local var_32_2 = var_32_0.childCount

				for iter_32_0 = 0, var_32_2 - 1 do
					local var_32_3 = var_32_0:GetChild(iter_32_0)

					if var_32_3.name == "" or not string.find(var_32_3.name, "split") then
						var_32_3.gameObject:SetActive(true)
					else
						var_32_3.gameObject:SetActive(false)
					end
				end
			end

			local var_32_4 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_4 then
				local var_32_5 = (arg_29_1.time_ - var_32_1) / var_32_4
				local var_32_6 = Vector3.New(0, -340, -414)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10094, var_32_6, var_32_5)
			end

			if arg_29_1.time_ >= var_32_1 + var_32_4 and arg_29_1.time_ < var_32_1 + var_32_4 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_32_7 = arg_29_1.actors_["10094"]
			local var_32_8 = 0

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.actorSpriteComps10094 == nil then
				arg_29_1.var_.actorSpriteComps10094 = var_32_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_9 = 2

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_9 and not isNil(var_32_7) then
				local var_32_10 = (arg_29_1.time_ - var_32_8) / var_32_9

				if arg_29_1.var_.actorSpriteComps10094 then
					for iter_32_1, iter_32_2 in pairs(arg_29_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_32_2 then
							if arg_29_1.isInRecall_ then
								local var_32_11 = Mathf.Lerp(iter_32_2.color.r, arg_29_1.hightColor1.r, var_32_10)
								local var_32_12 = Mathf.Lerp(iter_32_2.color.g, arg_29_1.hightColor1.g, var_32_10)
								local var_32_13 = Mathf.Lerp(iter_32_2.color.b, arg_29_1.hightColor1.b, var_32_10)

								iter_32_2.color = Color.New(var_32_11, var_32_12, var_32_13)
							else
								local var_32_14 = Mathf.Lerp(iter_32_2.color.r, 1, var_32_10)

								iter_32_2.color = Color.New(var_32_14, var_32_14, var_32_14)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_8 + var_32_9 and arg_29_1.time_ < var_32_8 + var_32_9 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.actorSpriteComps10094 then
				for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_32_4 then
						if arg_29_1.isInRecall_ then
							iter_32_4.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10094 = nil
			end

			local var_32_15 = 0
			local var_32_16 = 0.25

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_17 = arg_29_1:FormatText(StoryNameCfg[259].name)

				arg_29_1.leftNameTxt_.text = var_32_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_18 = arg_29_1:GetWordFromCfg(413152007)
				local var_32_19 = arg_29_1:FormatText(var_32_18.content)

				arg_29_1.text_.text = var_32_19

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_20 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152007", "story_v_out_413152.awb") ~= 0 then
					local var_32_23 = manager.audio:GetVoiceLength("story_v_out_413152", "413152007", "story_v_out_413152.awb") / 1000

					if var_32_23 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_23 + var_32_15
					end

					if var_32_18.prefab_name ~= "" and arg_29_1.actors_[var_32_18.prefab_name] ~= nil then
						local var_32_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_18.prefab_name].transform, "story_v_out_413152", "413152007", "story_v_out_413152.awb")

						arg_29_1:RecordAudio("413152007", var_32_24)
						arg_29_1:RecordAudio("413152007", var_32_24)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413152", "413152007", "story_v_out_413152.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413152", "413152007", "story_v_out_413152.awb")
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
				actorName = "10094",
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
	Play413152008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413152008
		arg_33_1.duration_ = 4.3

		local var_33_0 = {
			zh = 4.3,
			ja = 4.1
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
				arg_33_0:Play413152009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10094"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10094 == nil then
				arg_33_1.var_.actorSpriteComps10094 = var_36_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_2 = 2

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.actorSpriteComps10094 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10094:ToTable()) do
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

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10094 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10094 = nil
			end

			local var_36_8 = 0
			local var_36_9 = 0.45

			if var_36_8 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_10 = arg_33_1:FormatText(StoryNameCfg[992].name)

				arg_33_1.leftNameTxt_.text = var_36_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_11 = arg_33_1:GetWordFromCfg(413152008)
				local var_36_12 = arg_33_1:FormatText(var_36_11.content)

				arg_33_1.text_.text = var_36_12

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152008", "story_v_out_413152.awb") ~= 0 then
					local var_36_16 = manager.audio:GetVoiceLength("story_v_out_413152", "413152008", "story_v_out_413152.awb") / 1000

					if var_36_16 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_16 + var_36_8
					end

					if var_36_11.prefab_name ~= "" and arg_33_1.actors_[var_36_11.prefab_name] ~= nil then
						local var_36_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_11.prefab_name].transform, "story_v_out_413152", "413152008", "story_v_out_413152.awb")

						arg_33_1:RecordAudio("413152008", var_36_17)
						arg_33_1:RecordAudio("413152008", var_36_17)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_413152", "413152008", "story_v_out_413152.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_413152", "413152008", "story_v_out_413152.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_18 = math.max(var_36_9, arg_33_1.talkMaxDuration)

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_18 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_8) / var_36_18

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_8 + var_36_18 and arg_33_1.time_ < var_36_8 + var_36_18 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play413152009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 413152009
		arg_37_1.duration_ = 4

		local var_37_0 = {
			zh = 4,
			ja = 1.999999999999
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
				arg_37_0:Play413152010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10094"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos10094 = var_40_0.localPosition
				var_40_0.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10094", 3)

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
				local var_40_6 = Vector3.New(0, -340, -414)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10094, var_40_6, var_40_5)
			end

			if arg_37_1.time_ >= var_40_1 + var_40_4 and arg_37_1.time_ < var_40_1 + var_40_4 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_40_7 = arg_37_1.actors_["10094"]
			local var_40_8 = 0

			if var_40_8 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.actorSpriteComps10094 == nil then
				arg_37_1.var_.actorSpriteComps10094 = var_40_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_9 = 2

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_9 and not isNil(var_40_7) then
				local var_40_10 = (arg_37_1.time_ - var_40_8) / var_40_9

				if arg_37_1.var_.actorSpriteComps10094 then
					for iter_40_1, iter_40_2 in pairs(arg_37_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_40_2 then
							if arg_37_1.isInRecall_ then
								local var_40_11 = Mathf.Lerp(iter_40_2.color.r, arg_37_1.hightColor1.r, var_40_10)
								local var_40_12 = Mathf.Lerp(iter_40_2.color.g, arg_37_1.hightColor1.g, var_40_10)
								local var_40_13 = Mathf.Lerp(iter_40_2.color.b, arg_37_1.hightColor1.b, var_40_10)

								iter_40_2.color = Color.New(var_40_11, var_40_12, var_40_13)
							else
								local var_40_14 = Mathf.Lerp(iter_40_2.color.r, 1, var_40_10)

								iter_40_2.color = Color.New(var_40_14, var_40_14, var_40_14)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_8 + var_40_9 and arg_37_1.time_ < var_40_8 + var_40_9 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.actorSpriteComps10094 then
				for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_40_4 then
						if arg_37_1.isInRecall_ then
							iter_40_4.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10094 = nil
			end

			local var_40_15 = 0
			local var_40_16 = 0.525

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_17 = arg_37_1:FormatText(StoryNameCfg[259].name)

				arg_37_1.leftNameTxt_.text = var_40_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_18 = arg_37_1:GetWordFromCfg(413152009)
				local var_40_19 = arg_37_1:FormatText(var_40_18.content)

				arg_37_1.text_.text = var_40_19

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152009", "story_v_out_413152.awb") ~= 0 then
					local var_40_23 = manager.audio:GetVoiceLength("story_v_out_413152", "413152009", "story_v_out_413152.awb") / 1000

					if var_40_23 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_15
					end

					if var_40_18.prefab_name ~= "" and arg_37_1.actors_[var_40_18.prefab_name] ~= nil then
						local var_40_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_18.prefab_name].transform, "story_v_out_413152", "413152009", "story_v_out_413152.awb")

						arg_37_1:RecordAudio("413152009", var_40_24)
						arg_37_1:RecordAudio("413152009", var_40_24)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_413152", "413152009", "story_v_out_413152.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_413152", "413152009", "story_v_out_413152.awb")
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
				actorName = "10094",
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
	Play413152010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 413152010
		arg_41_1.duration_ = 4.53

		local var_41_0 = {
			zh = 2.4,
			ja = 4.533
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
				arg_41_0:Play413152011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10094"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos10094 = var_44_0.localPosition
				var_44_0.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10094", 3)

				local var_44_2 = var_44_0.childCount

				for iter_44_0 = 0, var_44_2 - 1 do
					local var_44_3 = var_44_0:GetChild(iter_44_0)

					if var_44_3.name == "" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_4 then
				local var_44_5 = (arg_41_1.time_ - var_44_1) / var_44_4
				local var_44_6 = Vector3.New(0, -340, -414)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10094, var_44_6, var_44_5)
			end

			if arg_41_1.time_ >= var_44_1 + var_44_4 and arg_41_1.time_ < var_44_1 + var_44_4 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_44_7 = arg_41_1.actors_["10094"]
			local var_44_8 = 0

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.actorSpriteComps10094 == nil then
				arg_41_1.var_.actorSpriteComps10094 = var_44_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_9 = 2

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_9 and not isNil(var_44_7) then
				local var_44_10 = (arg_41_1.time_ - var_44_8) / var_44_9

				if arg_41_1.var_.actorSpriteComps10094 then
					for iter_44_1, iter_44_2 in pairs(arg_41_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_44_2 then
							if arg_41_1.isInRecall_ then
								local var_44_11 = Mathf.Lerp(iter_44_2.color.r, arg_41_1.hightColor1.r, var_44_10)
								local var_44_12 = Mathf.Lerp(iter_44_2.color.g, arg_41_1.hightColor1.g, var_44_10)
								local var_44_13 = Mathf.Lerp(iter_44_2.color.b, arg_41_1.hightColor1.b, var_44_10)

								iter_44_2.color = Color.New(var_44_11, var_44_12, var_44_13)
							else
								local var_44_14 = Mathf.Lerp(iter_44_2.color.r, 1, var_44_10)

								iter_44_2.color = Color.New(var_44_14, var_44_14, var_44_14)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_8 + var_44_9 and arg_41_1.time_ < var_44_8 + var_44_9 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.actorSpriteComps10094 then
				for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_44_4 then
						if arg_41_1.isInRecall_ then
							iter_44_4.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10094 = nil
			end

			local var_44_15 = 0
			local var_44_16 = 0.25

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_17 = arg_41_1:FormatText(StoryNameCfg[259].name)

				arg_41_1.leftNameTxt_.text = var_44_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_18 = arg_41_1:GetWordFromCfg(413152010)
				local var_44_19 = arg_41_1:FormatText(var_44_18.content)

				arg_41_1.text_.text = var_44_19

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_20 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152010", "story_v_out_413152.awb") ~= 0 then
					local var_44_23 = manager.audio:GetVoiceLength("story_v_out_413152", "413152010", "story_v_out_413152.awb") / 1000

					if var_44_23 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_23 + var_44_15
					end

					if var_44_18.prefab_name ~= "" and arg_41_1.actors_[var_44_18.prefab_name] ~= nil then
						local var_44_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_18.prefab_name].transform, "story_v_out_413152", "413152010", "story_v_out_413152.awb")

						arg_41_1:RecordAudio("413152010", var_44_24)
						arg_41_1:RecordAudio("413152010", var_44_24)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_413152", "413152010", "story_v_out_413152.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_413152", "413152010", "story_v_out_413152.awb")
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
				actorName = "10094",
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
	Play413152011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 413152011
		arg_45_1.duration_ = 4.7

		local var_45_0 = {
			zh = 3.2,
			ja = 4.7
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
				arg_45_0:Play413152012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10094"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps10094 == nil then
				arg_45_1.var_.actorSpriteComps10094 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps10094 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								local var_48_4 = Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor2.r, var_48_3)
								local var_48_5 = Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor2.g, var_48_3)
								local var_48_6 = Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor2.b, var_48_3)

								iter_48_1.color = Color.New(var_48_4, var_48_5, var_48_6)
							else
								local var_48_7 = Mathf.Lerp(iter_48_1.color.r, 0.5, var_48_3)

								iter_48_1.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps10094 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10094 = nil
			end

			local var_48_8 = 0
			local var_48_9 = 0.425

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_10 = arg_45_1:FormatText(StoryNameCfg[992].name)

				arg_45_1.leftNameTxt_.text = var_48_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_11 = arg_45_1:GetWordFromCfg(413152011)
				local var_48_12 = arg_45_1:FormatText(var_48_11.content)

				arg_45_1.text_.text = var_48_12

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_13 = 17
				local var_48_14 = utf8.len(var_48_12)
				local var_48_15 = var_48_13 <= 0 and var_48_9 or var_48_9 * (var_48_14 / var_48_13)

				if var_48_15 > 0 and var_48_9 < var_48_15 then
					arg_45_1.talkMaxDuration = var_48_15

					if var_48_15 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_15 + var_48_8
					end
				end

				arg_45_1.text_.text = var_48_12
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152011", "story_v_out_413152.awb") ~= 0 then
					local var_48_16 = manager.audio:GetVoiceLength("story_v_out_413152", "413152011", "story_v_out_413152.awb") / 1000

					if var_48_16 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_16 + var_48_8
					end

					if var_48_11.prefab_name ~= "" and arg_45_1.actors_[var_48_11.prefab_name] ~= nil then
						local var_48_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_11.prefab_name].transform, "story_v_out_413152", "413152011", "story_v_out_413152.awb")

						arg_45_1:RecordAudio("413152011", var_48_17)
						arg_45_1:RecordAudio("413152011", var_48_17)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_413152", "413152011", "story_v_out_413152.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_413152", "413152011", "story_v_out_413152.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_18 = math.max(var_48_9, arg_45_1.talkMaxDuration)

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_18 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_8) / var_48_18

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_8 + var_48_18 and arg_45_1.time_ < var_48_8 + var_48_18 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play413152012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 413152012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play413152013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10094"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos10094 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10094", 7)

				local var_52_2 = var_52_0.childCount

				for iter_52_0 = 0, var_52_2 - 1 do
					local var_52_3 = var_52_0:GetChild(iter_52_0)

					if var_52_3.name == "" or not string.find(var_52_3.name, "split") then
						var_52_3.gameObject:SetActive(true)
					else
						var_52_3.gameObject:SetActive(false)
					end
				end
			end

			local var_52_4 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_4 then
				local var_52_5 = (arg_49_1.time_ - var_52_1) / var_52_4
				local var_52_6 = Vector3.New(0, -2000, 0)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10094, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_52_7 = arg_49_1.actors_["10094"]
			local var_52_8 = 0

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps10094 == nil then
				arg_49_1.var_.actorSpriteComps10094 = var_52_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_9 = 2

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_9 and not isNil(var_52_7) then
				local var_52_10 = (arg_49_1.time_ - var_52_8) / var_52_9

				if arg_49_1.var_.actorSpriteComps10094 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_52_2 then
							if arg_49_1.isInRecall_ then
								local var_52_11 = Mathf.Lerp(iter_52_2.color.r, arg_49_1.hightColor2.r, var_52_10)
								local var_52_12 = Mathf.Lerp(iter_52_2.color.g, arg_49_1.hightColor2.g, var_52_10)
								local var_52_13 = Mathf.Lerp(iter_52_2.color.b, arg_49_1.hightColor2.b, var_52_10)

								iter_52_2.color = Color.New(var_52_11, var_52_12, var_52_13)
							else
								local var_52_14 = Mathf.Lerp(iter_52_2.color.r, 0.5, var_52_10)

								iter_52_2.color = Color.New(var_52_14, var_52_14, var_52_14)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_8 + var_52_9 and arg_49_1.time_ < var_52_8 + var_52_9 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps10094 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_52_4 then
						if arg_49_1.isInRecall_ then
							iter_52_4.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10094 = nil
			end

			local var_52_15 = 0
			local var_52_16 = 1.2

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_17 = arg_49_1:GetWordFromCfg(413152012)
				local var_52_18 = arg_49_1:FormatText(var_52_17.content)

				arg_49_1.text_.text = var_52_18

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_19 = 48
				local var_52_20 = utf8.len(var_52_18)
				local var_52_21 = var_52_19 <= 0 and var_52_16 or var_52_16 * (var_52_20 / var_52_19)

				if var_52_21 > 0 and var_52_16 < var_52_21 then
					arg_49_1.talkMaxDuration = var_52_21

					if var_52_21 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_21 + var_52_15
					end
				end

				arg_49_1.text_.text = var_52_18
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_22 = math.max(var_52_16, arg_49_1.talkMaxDuration)

			if var_52_15 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_22 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_15) / var_52_22

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_15 + var_52_22 and arg_49_1.time_ < var_52_15 + var_52_22 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
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
	Play413152013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 413152013
		arg_53_1.duration_ = 7.4

		local var_53_0 = {
			zh = 5.3,
			ja = 7.4
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
				arg_53_0:Play413152014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10094"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos10094 = var_56_0.localPosition
				var_56_0.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10094", 3)

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
				local var_56_6 = Vector3.New(0, -340, -414)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10094, var_56_6, var_56_5)
			end

			if arg_53_1.time_ >= var_56_1 + var_56_4 and arg_53_1.time_ < var_56_1 + var_56_4 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_56_7 = arg_53_1.actors_["10094"]
			local var_56_8 = 0

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 and not isNil(var_56_7) and arg_53_1.var_.actorSpriteComps10094 == nil then
				arg_53_1.var_.actorSpriteComps10094 = var_56_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_9 = 2

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_9 and not isNil(var_56_7) then
				local var_56_10 = (arg_53_1.time_ - var_56_8) / var_56_9

				if arg_53_1.var_.actorSpriteComps10094 then
					for iter_56_1, iter_56_2 in pairs(arg_53_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_56_2 then
							if arg_53_1.isInRecall_ then
								local var_56_11 = Mathf.Lerp(iter_56_2.color.r, arg_53_1.hightColor1.r, var_56_10)
								local var_56_12 = Mathf.Lerp(iter_56_2.color.g, arg_53_1.hightColor1.g, var_56_10)
								local var_56_13 = Mathf.Lerp(iter_56_2.color.b, arg_53_1.hightColor1.b, var_56_10)

								iter_56_2.color = Color.New(var_56_11, var_56_12, var_56_13)
							else
								local var_56_14 = Mathf.Lerp(iter_56_2.color.r, 1, var_56_10)

								iter_56_2.color = Color.New(var_56_14, var_56_14, var_56_14)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_8 + var_56_9 and arg_53_1.time_ < var_56_8 + var_56_9 + arg_56_0 and not isNil(var_56_7) and arg_53_1.var_.actorSpriteComps10094 then
				for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_56_4 then
						if arg_53_1.isInRecall_ then
							iter_56_4.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10094 = nil
			end

			local var_56_15 = 0
			local var_56_16 = 0.575

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_17 = arg_53_1:FormatText(StoryNameCfg[259].name)

				arg_53_1.leftNameTxt_.text = var_56_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_18 = arg_53_1:GetWordFromCfg(413152013)
				local var_56_19 = arg_53_1:FormatText(var_56_18.content)

				arg_53_1.text_.text = var_56_19

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_20 = 23
				local var_56_21 = utf8.len(var_56_19)
				local var_56_22 = var_56_20 <= 0 and var_56_16 or var_56_16 * (var_56_21 / var_56_20)

				if var_56_22 > 0 and var_56_16 < var_56_22 then
					arg_53_1.talkMaxDuration = var_56_22

					if var_56_22 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_22 + var_56_15
					end
				end

				arg_53_1.text_.text = var_56_19
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152013", "story_v_out_413152.awb") ~= 0 then
					local var_56_23 = manager.audio:GetVoiceLength("story_v_out_413152", "413152013", "story_v_out_413152.awb") / 1000

					if var_56_23 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_23 + var_56_15
					end

					if var_56_18.prefab_name ~= "" and arg_53_1.actors_[var_56_18.prefab_name] ~= nil then
						local var_56_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_18.prefab_name].transform, "story_v_out_413152", "413152013", "story_v_out_413152.awb")

						arg_53_1:RecordAudio("413152013", var_56_24)
						arg_53_1:RecordAudio("413152013", var_56_24)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_413152", "413152013", "story_v_out_413152.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_413152", "413152013", "story_v_out_413152.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_25 = math.max(var_56_16, arg_53_1.talkMaxDuration)

			if var_56_15 <= arg_53_1.time_ and arg_53_1.time_ < var_56_15 + var_56_25 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_15) / var_56_25

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_15 + var_56_25 and arg_53_1.time_ < var_56_15 + var_56_25 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
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
	Play413152014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 413152014
		arg_57_1.duration_ = 4.13

		local var_57_0 = {
			zh = 3.7,
			ja = 4.133
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
				arg_57_0:Play413152015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10094"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos10094 = var_60_0.localPosition
				var_60_0.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10094", 3)

				local var_60_2 = var_60_0.childCount

				for iter_60_0 = 0, var_60_2 - 1 do
					local var_60_3 = var_60_0:GetChild(iter_60_0)

					if var_60_3.name == "" or not string.find(var_60_3.name, "split") then
						var_60_3.gameObject:SetActive(true)
					else
						var_60_3.gameObject:SetActive(false)
					end
				end
			end

			local var_60_4 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_4 then
				local var_60_5 = (arg_57_1.time_ - var_60_1) / var_60_4
				local var_60_6 = Vector3.New(0, -340, -414)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10094, var_60_6, var_60_5)
			end

			if arg_57_1.time_ >= var_60_1 + var_60_4 and arg_57_1.time_ < var_60_1 + var_60_4 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_60_7 = arg_57_1.actors_["10094"]
			local var_60_8 = 0

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 and not isNil(var_60_7) and arg_57_1.var_.actorSpriteComps10094 == nil then
				arg_57_1.var_.actorSpriteComps10094 = var_60_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_9 = 2

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_9 and not isNil(var_60_7) then
				local var_60_10 = (arg_57_1.time_ - var_60_8) / var_60_9

				if arg_57_1.var_.actorSpriteComps10094 then
					for iter_60_1, iter_60_2 in pairs(arg_57_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_60_2 then
							if arg_57_1.isInRecall_ then
								local var_60_11 = Mathf.Lerp(iter_60_2.color.r, arg_57_1.hightColor1.r, var_60_10)
								local var_60_12 = Mathf.Lerp(iter_60_2.color.g, arg_57_1.hightColor1.g, var_60_10)
								local var_60_13 = Mathf.Lerp(iter_60_2.color.b, arg_57_1.hightColor1.b, var_60_10)

								iter_60_2.color = Color.New(var_60_11, var_60_12, var_60_13)
							else
								local var_60_14 = Mathf.Lerp(iter_60_2.color.r, 1, var_60_10)

								iter_60_2.color = Color.New(var_60_14, var_60_14, var_60_14)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_8 + var_60_9 and arg_57_1.time_ < var_60_8 + var_60_9 + arg_60_0 and not isNil(var_60_7) and arg_57_1.var_.actorSpriteComps10094 then
				for iter_60_3, iter_60_4 in pairs(arg_57_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_60_4 then
						if arg_57_1.isInRecall_ then
							iter_60_4.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10094 = nil
			end

			local var_60_15 = 0
			local var_60_16 = 0.35

			if var_60_15 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_17 = arg_57_1:FormatText(StoryNameCfg[259].name)

				arg_57_1.leftNameTxt_.text = var_60_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_18 = arg_57_1:GetWordFromCfg(413152014)
				local var_60_19 = arg_57_1:FormatText(var_60_18.content)

				arg_57_1.text_.text = var_60_19

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_20 = 14
				local var_60_21 = utf8.len(var_60_19)
				local var_60_22 = var_60_20 <= 0 and var_60_16 or var_60_16 * (var_60_21 / var_60_20)

				if var_60_22 > 0 and var_60_16 < var_60_22 then
					arg_57_1.talkMaxDuration = var_60_22

					if var_60_22 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_22 + var_60_15
					end
				end

				arg_57_1.text_.text = var_60_19
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152014", "story_v_out_413152.awb") ~= 0 then
					local var_60_23 = manager.audio:GetVoiceLength("story_v_out_413152", "413152014", "story_v_out_413152.awb") / 1000

					if var_60_23 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_23 + var_60_15
					end

					if var_60_18.prefab_name ~= "" and arg_57_1.actors_[var_60_18.prefab_name] ~= nil then
						local var_60_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_18.prefab_name].transform, "story_v_out_413152", "413152014", "story_v_out_413152.awb")

						arg_57_1:RecordAudio("413152014", var_60_24)
						arg_57_1:RecordAudio("413152014", var_60_24)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_413152", "413152014", "story_v_out_413152.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_413152", "413152014", "story_v_out_413152.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_25 = math.max(var_60_16, arg_57_1.talkMaxDuration)

			if var_60_15 <= arg_57_1.time_ and arg_57_1.time_ < var_60_15 + var_60_25 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_15) / var_60_25

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_15 + var_60_25 and arg_57_1.time_ < var_60_15 + var_60_25 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
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
	Play413152015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 413152015
		arg_61_1.duration_ = 5.8

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play413152016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = "ST0603"

			if arg_61_1.bgs_[var_64_0] == nil then
				local var_64_1 = Object.Instantiate(arg_61_1.paintGo_)

				var_64_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_64_0)
				var_64_1.name = var_64_0
				var_64_1.transform.parent = arg_61_1.stage_.transform
				var_64_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.bgs_[var_64_0] = var_64_1
			end

			local var_64_2 = 2

			if var_64_2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				local var_64_3 = manager.ui.mainCamera.transform.localPosition
				local var_64_4 = Vector3.New(0, 0, 10) + Vector3.New(var_64_3.x, var_64_3.y, 0)
				local var_64_5 = arg_61_1.bgs_.ST0603

				var_64_5.transform.localPosition = var_64_4
				var_64_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_64_6 = var_64_5:GetComponent("SpriteRenderer")

				if var_64_6 and var_64_6.sprite then
					local var_64_7 = (var_64_5.transform.localPosition - var_64_3).z
					local var_64_8 = manager.ui.mainCameraCom_
					local var_64_9 = 2 * var_64_7 * Mathf.Tan(var_64_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_64_10 = var_64_9 * var_64_8.aspect
					local var_64_11 = var_64_6.sprite.bounds.size.x
					local var_64_12 = var_64_6.sprite.bounds.size.y
					local var_64_13 = var_64_10 / var_64_11
					local var_64_14 = var_64_9 / var_64_12
					local var_64_15 = var_64_14 < var_64_13 and var_64_13 or var_64_14

					var_64_5.transform.localScale = Vector3.New(var_64_15, var_64_15, 0)
				end

				for iter_64_0, iter_64_1 in pairs(arg_61_1.bgs_) do
					if iter_64_0 ~= "ST0603" then
						iter_64_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_64_16 = 3.999999999999

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.allBtn_.enabled = false
			end

			local var_64_17 = 0.3

			if arg_61_1.time_ >= var_64_16 + var_64_17 and arg_61_1.time_ < var_64_16 + var_64_17 + arg_64_0 then
				arg_61_1.allBtn_.enabled = true
			end

			local var_64_18 = 0

			if var_64_18 < arg_61_1.time_ and arg_61_1.time_ <= var_64_18 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_19 = 2

			if var_64_18 <= arg_61_1.time_ and arg_61_1.time_ < var_64_18 + var_64_19 then
				local var_64_20 = (arg_61_1.time_ - var_64_18) / var_64_19
				local var_64_21 = Color.New(0, 0, 0)

				var_64_21.a = Mathf.Lerp(0, 1, var_64_20)
				arg_61_1.mask_.color = var_64_21
			end

			if arg_61_1.time_ >= var_64_18 + var_64_19 and arg_61_1.time_ < var_64_18 + var_64_19 + arg_64_0 then
				local var_64_22 = Color.New(0, 0, 0)

				var_64_22.a = 1
				arg_61_1.mask_.color = var_64_22
			end

			local var_64_23 = 2

			if var_64_23 < arg_61_1.time_ and arg_61_1.time_ <= var_64_23 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_24 = 2

			if var_64_23 <= arg_61_1.time_ and arg_61_1.time_ < var_64_23 + var_64_24 then
				local var_64_25 = (arg_61_1.time_ - var_64_23) / var_64_24
				local var_64_26 = Color.New(0, 0, 0)

				var_64_26.a = Mathf.Lerp(1, 0, var_64_25)
				arg_61_1.mask_.color = var_64_26
			end

			if arg_61_1.time_ >= var_64_23 + var_64_24 and arg_61_1.time_ < var_64_23 + var_64_24 + arg_64_0 then
				local var_64_27 = Color.New(0, 0, 0)
				local var_64_28 = 0

				arg_61_1.mask_.enabled = false
				var_64_27.a = var_64_28
				arg_61_1.mask_.color = var_64_27
			end

			local var_64_29 = arg_61_1.actors_["10094"].transform
			local var_64_30 = 1.999999999999

			if var_64_30 < arg_61_1.time_ and arg_61_1.time_ <= var_64_30 + arg_64_0 then
				arg_61_1.var_.moveOldPos10094 = var_64_29.localPosition
				var_64_29.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10094", 7)

				local var_64_31 = var_64_29.childCount

				for iter_64_2 = 0, var_64_31 - 1 do
					local var_64_32 = var_64_29:GetChild(iter_64_2)

					if var_64_32.name == "" or not string.find(var_64_32.name, "split") then
						var_64_32.gameObject:SetActive(true)
					else
						var_64_32.gameObject:SetActive(false)
					end
				end
			end

			local var_64_33 = 0.001

			if var_64_30 <= arg_61_1.time_ and arg_61_1.time_ < var_64_30 + var_64_33 then
				local var_64_34 = (arg_61_1.time_ - var_64_30) / var_64_33
				local var_64_35 = Vector3.New(0, -2000, 0)

				var_64_29.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10094, var_64_35, var_64_34)
			end

			if arg_61_1.time_ >= var_64_30 + var_64_33 and arg_61_1.time_ < var_64_30 + var_64_33 + arg_64_0 then
				var_64_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_64_36 = "10093"

			if arg_61_1.actors_[var_64_36] == nil then
				local var_64_37 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_64_37) then
					local var_64_38 = Object.Instantiate(var_64_37, arg_61_1.canvasGo_.transform)

					var_64_38.transform:SetSiblingIndex(1)

					var_64_38.name = var_64_36
					var_64_38.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_61_1.actors_[var_64_36] = var_64_38

					local var_64_39 = var_64_38:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_61_1.isInRecall_ then
						for iter_64_3, iter_64_4 in ipairs(var_64_39) do
							iter_64_4.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_64_40 = arg_61_1.actors_["10093"].transform
			local var_64_41 = 3.8

			if var_64_41 < arg_61_1.time_ and arg_61_1.time_ <= var_64_41 + arg_64_0 then
				arg_61_1.var_.moveOldPos10093 = var_64_40.localPosition
				var_64_40.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10093", 3)

				local var_64_42 = var_64_40.childCount

				for iter_64_5 = 0, var_64_42 - 1 do
					local var_64_43 = var_64_40:GetChild(iter_64_5)

					if var_64_43.name == "split_5" or not string.find(var_64_43.name, "split") then
						var_64_43.gameObject:SetActive(true)
					else
						var_64_43.gameObject:SetActive(false)
					end
				end
			end

			local var_64_44 = 0.001

			if var_64_41 <= arg_61_1.time_ and arg_61_1.time_ < var_64_41 + var_64_44 then
				local var_64_45 = (arg_61_1.time_ - var_64_41) / var_64_44
				local var_64_46 = Vector3.New(0, -345, -245)

				var_64_40.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10093, var_64_46, var_64_45)
			end

			if arg_61_1.time_ >= var_64_41 + var_64_44 and arg_61_1.time_ < var_64_41 + var_64_44 + arg_64_0 then
				var_64_40.localPosition = Vector3.New(0, -345, -245)
			end

			local var_64_47 = arg_61_1.actors_["10093"]
			local var_64_48 = 3.8

			if var_64_48 < arg_61_1.time_ and arg_61_1.time_ <= var_64_48 + arg_64_0 and not isNil(var_64_47) and arg_61_1.var_.actorSpriteComps10093 == nil then
				arg_61_1.var_.actorSpriteComps10093 = var_64_47:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_49 = 2

			if var_64_48 <= arg_61_1.time_ and arg_61_1.time_ < var_64_48 + var_64_49 and not isNil(var_64_47) then
				local var_64_50 = (arg_61_1.time_ - var_64_48) / var_64_49

				if arg_61_1.var_.actorSpriteComps10093 then
					for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_64_7 then
							if arg_61_1.isInRecall_ then
								local var_64_51 = Mathf.Lerp(iter_64_7.color.r, arg_61_1.hightColor1.r, var_64_50)
								local var_64_52 = Mathf.Lerp(iter_64_7.color.g, arg_61_1.hightColor1.g, var_64_50)
								local var_64_53 = Mathf.Lerp(iter_64_7.color.b, arg_61_1.hightColor1.b, var_64_50)

								iter_64_7.color = Color.New(var_64_51, var_64_52, var_64_53)
							else
								local var_64_54 = Mathf.Lerp(iter_64_7.color.r, 1, var_64_50)

								iter_64_7.color = Color.New(var_64_54, var_64_54, var_64_54)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_48 + var_64_49 and arg_61_1.time_ < var_64_48 + var_64_49 + arg_64_0 and not isNil(var_64_47) and arg_61_1.var_.actorSpriteComps10093 then
				for iter_64_8, iter_64_9 in pairs(arg_61_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_64_9 then
						if arg_61_1.isInRecall_ then
							iter_64_9.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10093 = nil
			end

			local var_64_55 = arg_61_1.actors_["10093"]
			local var_64_56 = 3.8

			if var_64_56 < arg_61_1.time_ and arg_61_1.time_ <= var_64_56 + arg_64_0 then
				local var_64_57 = var_64_55:GetComponentInChildren(typeof(CanvasGroup))

				if var_64_57 then
					arg_61_1.var_.alphaOldValue10093 = var_64_57.alpha
					arg_61_1.var_.characterEffect10093 = var_64_57
				end

				arg_61_1.var_.alphaOldValue10093 = 0
			end

			local var_64_58 = 0.2

			if var_64_56 <= arg_61_1.time_ and arg_61_1.time_ < var_64_56 + var_64_58 then
				local var_64_59 = (arg_61_1.time_ - var_64_56) / var_64_58
				local var_64_60 = Mathf.Lerp(arg_61_1.var_.alphaOldValue10093, 1, var_64_59)

				if arg_61_1.var_.characterEffect10093 then
					arg_61_1.var_.characterEffect10093.alpha = var_64_60
				end
			end

			if arg_61_1.time_ >= var_64_56 + var_64_58 and arg_61_1.time_ < var_64_56 + var_64_58 + arg_64_0 and arg_61_1.var_.characterEffect10093 then
				arg_61_1.var_.characterEffect10093.alpha = 1
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_61 = 3.999999999999
			local var_64_62 = 0.075

			if var_64_61 < arg_61_1.time_ and arg_61_1.time_ <= var_64_61 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_63 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_63:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_64 = arg_61_1:FormatText(StoryNameCfg[28].name)

				arg_61_1.leftNameTxt_.text = var_64_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_65 = arg_61_1:GetWordFromCfg(413152015)
				local var_64_66 = arg_61_1:FormatText(var_64_65.content)

				arg_61_1.text_.text = var_64_66

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_67 = 3
				local var_64_68 = utf8.len(var_64_66)
				local var_64_69 = var_64_67 <= 0 and var_64_62 or var_64_62 * (var_64_68 / var_64_67)

				if var_64_69 > 0 and var_64_62 < var_64_69 then
					arg_61_1.talkMaxDuration = var_64_69
					var_64_61 = var_64_61 + 0.3

					if var_64_69 + var_64_61 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_69 + var_64_61
					end
				end

				arg_61_1.text_.text = var_64_66
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152015", "story_v_out_413152.awb") ~= 0 then
					local var_64_70 = manager.audio:GetVoiceLength("story_v_out_413152", "413152015", "story_v_out_413152.awb") / 1000

					if var_64_70 + var_64_61 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_70 + var_64_61
					end

					if var_64_65.prefab_name ~= "" and arg_61_1.actors_[var_64_65.prefab_name] ~= nil then
						local var_64_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_65.prefab_name].transform, "story_v_out_413152", "413152015", "story_v_out_413152.awb")

						arg_61_1:RecordAudio("413152015", var_64_71)
						arg_61_1:RecordAudio("413152015", var_64_71)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_413152", "413152015", "story_v_out_413152.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_413152", "413152015", "story_v_out_413152.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_72 = var_64_61 + 0.3
			local var_64_73 = math.max(var_64_62, arg_61_1.talkMaxDuration)

			if var_64_72 <= arg_61_1.time_ and arg_61_1.time_ < var_64_72 + var_64_73 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_72) / var_64_73

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_72 + var_64_73 and arg_61_1.time_ < var_64_72 + var_64_73 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play413152016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 413152016
		arg_67_1.duration_ = 3.57

		local var_67_0 = {
			zh = 2.733,
			ja = 3.566
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
				arg_67_0:Play413152017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.275

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[28].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:GetWordFromCfg(413152016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 11
				local var_70_6 = utf8.len(var_70_4)
				local var_70_7 = var_70_5 <= 0 and var_70_1 or var_70_1 * (var_70_6 / var_70_5)

				if var_70_7 > 0 and var_70_1 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152016", "story_v_out_413152.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152016", "story_v_out_413152.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_413152", "413152016", "story_v_out_413152.awb")

						arg_67_1:RecordAudio("413152016", var_70_9)
						arg_67_1:RecordAudio("413152016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_413152", "413152016", "story_v_out_413152.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_413152", "413152016", "story_v_out_413152.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_10 and arg_67_1.time_ < var_70_0 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play413152017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 413152017
		arg_71_1.duration_ = 2.57

		local var_71_0 = {
			zh = 2.566,
			ja = 1.833
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
				arg_71_0:Play413152018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 0.275

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[28].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:GetWordFromCfg(413152017)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 11
				local var_74_6 = utf8.len(var_74_4)
				local var_74_7 = var_74_5 <= 0 and var_74_1 or var_74_1 * (var_74_6 / var_74_5)

				if var_74_7 > 0 and var_74_1 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_0
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152017", "story_v_out_413152.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152017", "story_v_out_413152.awb") / 1000

					if var_74_8 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_0
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_out_413152", "413152017", "story_v_out_413152.awb")

						arg_71_1:RecordAudio("413152017", var_74_9)
						arg_71_1:RecordAudio("413152017", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_413152", "413152017", "story_v_out_413152.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_413152", "413152017", "story_v_out_413152.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_10 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_10 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_10

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_10 and arg_71_1.time_ < var_74_0 + var_74_10 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play413152018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 413152018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play413152019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["10093"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos10093 = var_78_0.localPosition
				var_78_0.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("10093", 7)

				local var_78_2 = var_78_0.childCount

				for iter_78_0 = 0, var_78_2 - 1 do
					local var_78_3 = var_78_0:GetChild(iter_78_0)

					if var_78_3.name == "" or not string.find(var_78_3.name, "split") then
						var_78_3.gameObject:SetActive(true)
					else
						var_78_3.gameObject:SetActive(false)
					end
				end
			end

			local var_78_4 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_4 then
				local var_78_5 = (arg_75_1.time_ - var_78_1) / var_78_4
				local var_78_6 = Vector3.New(0, -2000, 0)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10093, var_78_6, var_78_5)
			end

			if arg_75_1.time_ >= var_78_1 + var_78_4 and arg_75_1.time_ < var_78_1 + var_78_4 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_78_7 = arg_75_1.actors_["10093"]
			local var_78_8 = 0

			if var_78_8 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 and not isNil(var_78_7) and arg_75_1.var_.actorSpriteComps10093 == nil then
				arg_75_1.var_.actorSpriteComps10093 = var_78_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_9 = 2

			if var_78_8 <= arg_75_1.time_ and arg_75_1.time_ < var_78_8 + var_78_9 and not isNil(var_78_7) then
				local var_78_10 = (arg_75_1.time_ - var_78_8) / var_78_9

				if arg_75_1.var_.actorSpriteComps10093 then
					for iter_78_1, iter_78_2 in pairs(arg_75_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_78_2 then
							if arg_75_1.isInRecall_ then
								local var_78_11 = Mathf.Lerp(iter_78_2.color.r, arg_75_1.hightColor2.r, var_78_10)
								local var_78_12 = Mathf.Lerp(iter_78_2.color.g, arg_75_1.hightColor2.g, var_78_10)
								local var_78_13 = Mathf.Lerp(iter_78_2.color.b, arg_75_1.hightColor2.b, var_78_10)

								iter_78_2.color = Color.New(var_78_11, var_78_12, var_78_13)
							else
								local var_78_14 = Mathf.Lerp(iter_78_2.color.r, 0.5, var_78_10)

								iter_78_2.color = Color.New(var_78_14, var_78_14, var_78_14)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= var_78_8 + var_78_9 and arg_75_1.time_ < var_78_8 + var_78_9 + arg_78_0 and not isNil(var_78_7) and arg_75_1.var_.actorSpriteComps10093 then
				for iter_78_3, iter_78_4 in pairs(arg_75_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_78_4 then
						if arg_75_1.isInRecall_ then
							iter_78_4.color = arg_75_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_78_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_75_1.var_.actorSpriteComps10093 = nil
			end

			local var_78_15 = 0
			local var_78_16 = 0.85

			if var_78_15 < arg_75_1.time_ and arg_75_1.time_ <= var_78_15 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_17 = arg_75_1:GetWordFromCfg(413152018)
				local var_78_18 = arg_75_1:FormatText(var_78_17.content)

				arg_75_1.text_.text = var_78_18

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_19 = 34
				local var_78_20 = utf8.len(var_78_18)
				local var_78_21 = var_78_19 <= 0 and var_78_16 or var_78_16 * (var_78_20 / var_78_19)

				if var_78_21 > 0 and var_78_16 < var_78_21 then
					arg_75_1.talkMaxDuration = var_78_21

					if var_78_21 + var_78_15 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_21 + var_78_15
					end
				end

				arg_75_1.text_.text = var_78_18
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_22 = math.max(var_78_16, arg_75_1.talkMaxDuration)

			if var_78_15 <= arg_75_1.time_ and arg_75_1.time_ < var_78_15 + var_78_22 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_15) / var_78_22

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_15 + var_78_22 and arg_75_1.time_ < var_78_15 + var_78_22 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413152019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 413152019
		arg_79_1.duration_ = 6.17

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play413152020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = false

				arg_79_1:SetGaussion(false)
			end

			local var_82_1 = 0.4

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_1 then
				local var_82_2 = (arg_79_1.time_ - var_82_0) / var_82_1
				local var_82_3 = Color.New(1, 1, 1)

				var_82_3.a = Mathf.Lerp(1, 0, var_82_2)
				arg_79_1.mask_.color = var_82_3
			end

			if arg_79_1.time_ >= var_82_0 + var_82_1 and arg_79_1.time_ < var_82_0 + var_82_1 + arg_82_0 then
				local var_82_4 = Color.New(1, 1, 1)
				local var_82_5 = 0

				arg_79_1.mask_.enabled = false
				var_82_4.a = var_82_5
				arg_79_1.mask_.color = var_82_4
			end

			local var_82_6 = manager.ui.mainCamera.transform
			local var_82_7 = 0.3

			if var_82_7 < arg_79_1.time_ and arg_79_1.time_ <= var_82_7 + arg_82_0 then
				arg_79_1.var_.shakeOldPos = var_82_6.localPosition
			end

			local var_82_8 = 0.866666666666667

			if var_82_7 <= arg_79_1.time_ and arg_79_1.time_ < var_82_7 + var_82_8 then
				local var_82_9 = (arg_79_1.time_ - var_82_7) / 0.066
				local var_82_10, var_82_11 = math.modf(var_82_9)

				var_82_6.localPosition = Vector3.New(var_82_11 * 0.13, var_82_11 * 0.13, var_82_11 * 0.13) + arg_79_1.var_.shakeOldPos
			end

			if arg_79_1.time_ >= var_82_7 + var_82_8 and arg_79_1.time_ < var_82_7 + var_82_8 + arg_82_0 then
				var_82_6.localPosition = arg_79_1.var_.shakeOldPos
			end

			local var_82_12 = 0

			if var_82_12 < arg_79_1.time_ and arg_79_1.time_ <= var_82_12 + arg_82_0 then
				arg_79_1.allBtn_.enabled = false
			end

			local var_82_13 = 1.16666666666667

			if arg_79_1.time_ >= var_82_12 + var_82_13 and arg_79_1.time_ < var_82_12 + var_82_13 + arg_82_0 then
				arg_79_1.allBtn_.enabled = true
			end

			local var_82_14 = 0.3
			local var_82_15 = 1

			if var_82_14 < arg_79_1.time_ and arg_79_1.time_ <= var_82_14 + arg_82_0 then
				local var_82_16 = "play"
				local var_82_17 = "effect"

				arg_79_1:AudioAction(var_82_16, var_82_17, "se_story_122_03", "se_story_122_03_stonecrushing", "")
			end

			if arg_79_1.frameCnt_ <= 1 then
				arg_79_1.dialog_:SetActive(false)
			end

			local var_82_18 = 1.16666666666667
			local var_82_19 = 1.525

			if var_82_18 < arg_79_1.time_ and arg_79_1.time_ <= var_82_18 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_20 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_20:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_21 = arg_79_1:GetWordFromCfg(413152019)
				local var_82_22 = arg_79_1:FormatText(var_82_21.content)

				arg_79_1.text_.text = var_82_22

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_23 = 61
				local var_82_24 = utf8.len(var_82_22)
				local var_82_25 = var_82_23 <= 0 and var_82_19 or var_82_19 * (var_82_24 / var_82_23)

				if var_82_25 > 0 and var_82_19 < var_82_25 then
					arg_79_1.talkMaxDuration = var_82_25
					var_82_18 = var_82_18 + 0.3

					if var_82_25 + var_82_18 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_25 + var_82_18
					end
				end

				arg_79_1.text_.text = var_82_22
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_26 = var_82_18 + 0.3
			local var_82_27 = math.max(var_82_19, arg_79_1.talkMaxDuration)

			if var_82_26 <= arg_79_1.time_ and arg_79_1.time_ < var_82_26 + var_82_27 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_26) / var_82_27

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_26 + var_82_27 and arg_79_1.time_ < var_82_26 + var_82_27 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play413152020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413152020
		arg_85_1.duration_ = 20.53

		local var_85_0 = {
			zh = 12.366,
			ja = 20.533
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play413152021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = "10092_1"

			if arg_85_1.actors_[var_88_0] == nil then
				local var_88_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092_1")

				if not isNil(var_88_1) then
					local var_88_2 = Object.Instantiate(var_88_1, arg_85_1.canvasGo_.transform)

					var_88_2.transform:SetSiblingIndex(1)

					var_88_2.name = var_88_0
					var_88_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_85_1.actors_[var_88_0] = var_88_2

					local var_88_3 = var_88_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_85_1.isInRecall_ then
						for iter_88_0, iter_88_1 in ipairs(var_88_3) do
							iter_88_1.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_88_4 = arg_85_1.actors_["10092_1"].transform
			local var_88_5 = 3

			if var_88_5 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.var_.moveOldPos10092_1 = var_88_4.localPosition
				var_88_4.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10092_1", 3)

				local var_88_6 = var_88_4.childCount

				for iter_88_2 = 0, var_88_6 - 1 do
					local var_88_7 = var_88_4:GetChild(iter_88_2)

					if var_88_7.name == "split_1_1" or not string.find(var_88_7.name, "split") then
						var_88_7.gameObject:SetActive(true)
					else
						var_88_7.gameObject:SetActive(false)
					end
				end
			end

			local var_88_8 = 0.001

			if var_88_5 <= arg_85_1.time_ and arg_85_1.time_ < var_88_5 + var_88_8 then
				local var_88_9 = (arg_85_1.time_ - var_88_5) / var_88_8
				local var_88_10 = Vector3.New(0, -300, -295)

				var_88_4.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10092_1, var_88_10, var_88_9)
			end

			if arg_85_1.time_ >= var_88_5 + var_88_8 and arg_85_1.time_ < var_88_5 + var_88_8 + arg_88_0 then
				var_88_4.localPosition = Vector3.New(0, -300, -295)
			end

			local var_88_11 = arg_85_1.actors_["10092_1"]
			local var_88_12 = 3

			if var_88_12 < arg_85_1.time_ and arg_85_1.time_ <= var_88_12 + arg_88_0 and not isNil(var_88_11) and arg_85_1.var_.actorSpriteComps10092_1 == nil then
				arg_85_1.var_.actorSpriteComps10092_1 = var_88_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_13 = 2

			if var_88_12 <= arg_85_1.time_ and arg_85_1.time_ < var_88_12 + var_88_13 and not isNil(var_88_11) then
				local var_88_14 = (arg_85_1.time_ - var_88_12) / var_88_13

				if arg_85_1.var_.actorSpriteComps10092_1 then
					for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_88_4 then
							if arg_85_1.isInRecall_ then
								local var_88_15 = Mathf.Lerp(iter_88_4.color.r, arg_85_1.hightColor1.r, var_88_14)
								local var_88_16 = Mathf.Lerp(iter_88_4.color.g, arg_85_1.hightColor1.g, var_88_14)
								local var_88_17 = Mathf.Lerp(iter_88_4.color.b, arg_85_1.hightColor1.b, var_88_14)

								iter_88_4.color = Color.New(var_88_15, var_88_16, var_88_17)
							else
								local var_88_18 = Mathf.Lerp(iter_88_4.color.r, 1, var_88_14)

								iter_88_4.color = Color.New(var_88_18, var_88_18, var_88_18)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_12 + var_88_13 and arg_85_1.time_ < var_88_12 + var_88_13 + arg_88_0 and not isNil(var_88_11) and arg_85_1.var_.actorSpriteComps10092_1 then
				for iter_88_5, iter_88_6 in pairs(arg_85_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_88_6 then
						if arg_85_1.isInRecall_ then
							iter_88_6.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_88_19 = 0

			if var_88_19 < arg_85_1.time_ and arg_85_1.time_ <= var_88_19 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_20 = 1.16666666666667

			if var_88_19 <= arg_85_1.time_ and arg_85_1.time_ < var_88_19 + var_88_20 then
				local var_88_21 = (arg_85_1.time_ - var_88_19) / var_88_20
				local var_88_22 = Color.New(0, 0, 0)

				var_88_22.a = Mathf.Lerp(0, 1, var_88_21)
				arg_85_1.mask_.color = var_88_22
			end

			if arg_85_1.time_ >= var_88_19 + var_88_20 and arg_85_1.time_ < var_88_19 + var_88_20 + arg_88_0 then
				local var_88_23 = Color.New(0, 0, 0)

				var_88_23.a = 1
				arg_85_1.mask_.color = var_88_23
			end

			local var_88_24 = 1.16666666666667

			if var_88_24 < arg_85_1.time_ and arg_85_1.time_ <= var_88_24 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_25 = 2

			if var_88_24 <= arg_85_1.time_ and arg_85_1.time_ < var_88_24 + var_88_25 then
				local var_88_26 = (arg_85_1.time_ - var_88_24) / var_88_25
				local var_88_27 = Color.New(0, 0, 0)

				var_88_27.a = Mathf.Lerp(1, 0, var_88_26)
				arg_85_1.mask_.color = var_88_27
			end

			if arg_85_1.time_ >= var_88_24 + var_88_25 and arg_85_1.time_ < var_88_24 + var_88_25 + arg_88_0 then
				local var_88_28 = Color.New(0, 0, 0)
				local var_88_29 = 0

				arg_85_1.mask_.enabled = false
				var_88_28.a = var_88_29
				arg_85_1.mask_.color = var_88_28
			end

			local var_88_30 = 1.16666666666667

			if var_88_30 < arg_85_1.time_ and arg_85_1.time_ <= var_88_30 + arg_88_0 then
				local var_88_31 = manager.ui.mainCamera.transform.localPosition
				local var_88_32 = Vector3.New(0, 0, 10) + Vector3.New(var_88_31.x, var_88_31.y, 0)
				local var_88_33 = arg_85_1.bgs_.ST0603

				var_88_33.transform.localPosition = var_88_32
				var_88_33.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_88_34 = var_88_33:GetComponent("SpriteRenderer")

				if var_88_34 and var_88_34.sprite then
					local var_88_35 = (var_88_33.transform.localPosition - var_88_31).z
					local var_88_36 = manager.ui.mainCameraCom_
					local var_88_37 = 2 * var_88_35 * Mathf.Tan(var_88_36.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_88_38 = var_88_37 * var_88_36.aspect
					local var_88_39 = var_88_34.sprite.bounds.size.x
					local var_88_40 = var_88_34.sprite.bounds.size.y
					local var_88_41 = var_88_38 / var_88_39
					local var_88_42 = var_88_37 / var_88_40
					local var_88_43 = var_88_42 < var_88_41 and var_88_41 or var_88_42

					var_88_33.transform.localScale = Vector3.New(var_88_43, var_88_43, 0)
				end

				for iter_88_7, iter_88_8 in pairs(arg_85_1.bgs_) do
					if iter_88_7 ~= "ST0603" then
						iter_88_8.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_88_44 = 1.16666666666667

			arg_85_1.isInRecall_ = true

			if var_88_44 < arg_85_1.time_ and arg_85_1.time_ <= var_88_44 + arg_88_0 then
				arg_85_1.screenFilterGo_:SetActive(true)

				arg_85_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")
				arg_85_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_85_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_88_9, iter_88_10 in pairs(arg_85_1.actors_) do
					local var_88_45 = iter_88_10:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_88_11, iter_88_12 in ipairs(var_88_45) do
						if iter_88_12.color.r > 0.51 then
							iter_88_12.color = Color.New(0.82, 0.77, 0.62)
						else
							iter_88_12.color = Color.New(0.46, 0.43, 0.35)
						end
					end
				end
			end

			local var_88_46 = 0.2

			if var_88_44 <= arg_85_1.time_ and arg_85_1.time_ < var_88_44 + var_88_46 then
				local var_88_47 = (arg_85_1.time_ - var_88_44) / var_88_46

				arg_85_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_88_47)
			end

			if arg_85_1.time_ >= var_88_44 + var_88_46 and arg_85_1.time_ < var_88_44 + var_88_46 + arg_88_0 then
				arg_85_1.screenFilterEffect_.weight = 1
			end

			if arg_85_1.frameCnt_ <= 1 then
				arg_85_1.dialog_:SetActive(false)
			end

			local var_88_48 = 3
			local var_88_49 = 0.975

			if var_88_48 < arg_85_1.time_ and arg_85_1.time_ <= var_88_48 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0

				arg_85_1.dialog_:SetActive(true)

				arg_85_1.dialogCg_.alpha = 0

				local var_88_50 = LeanTween.value(arg_85_1.dialog_, 0, 1, 0.3)

				var_88_50:setOnUpdate(LuaHelper.FloatAction(function(arg_89_0)
					arg_85_1.dialogCg_.alpha = arg_89_0
				end))
				var_88_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_85_1.dialog_)
					var_88_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_85_1.duration_ = arg_85_1.duration_ + 0.3

				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_51 = arg_85_1:FormatText(StoryNameCfg[996].name)

				arg_85_1.leftNameTxt_.text = var_88_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_52 = arg_85_1:GetWordFromCfg(413152020)
				local var_88_53 = arg_85_1:FormatText(var_88_52.content)

				arg_85_1.text_.text = var_88_53

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_54 = 39
				local var_88_55 = utf8.len(var_88_53)
				local var_88_56 = var_88_54 <= 0 and var_88_49 or var_88_49 * (var_88_55 / var_88_54)

				if var_88_56 > 0 and var_88_49 < var_88_56 then
					arg_85_1.talkMaxDuration = var_88_56
					var_88_48 = var_88_48 + 0.3

					if var_88_56 + var_88_48 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_56 + var_88_48
					end
				end

				arg_85_1.text_.text = var_88_53
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152020", "story_v_out_413152.awb") ~= 0 then
					local var_88_57 = manager.audio:GetVoiceLength("story_v_out_413152", "413152020", "story_v_out_413152.awb") / 1000

					if var_88_57 + var_88_48 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_57 + var_88_48
					end

					if var_88_52.prefab_name ~= "" and arg_85_1.actors_[var_88_52.prefab_name] ~= nil then
						local var_88_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_52.prefab_name].transform, "story_v_out_413152", "413152020", "story_v_out_413152.awb")

						arg_85_1:RecordAudio("413152020", var_88_58)
						arg_85_1:RecordAudio("413152020", var_88_58)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413152", "413152020", "story_v_out_413152.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413152", "413152020", "story_v_out_413152.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_59 = var_88_48 + 0.3
			local var_88_60 = math.max(var_88_49, arg_85_1.talkMaxDuration)

			if var_88_59 <= arg_85_1.time_ and arg_85_1.time_ < var_88_59 + var_88_60 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_59) / var_88_60

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_59 + var_88_60 and arg_85_1.time_ < var_88_59 + var_88_60 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play413152021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 413152021
		arg_91_1.duration_ = 8.03

		local var_91_0 = {
			zh = 5.066,
			ja = 8.033
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play413152022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 0.475

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[996].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_3 = arg_91_1:GetWordFromCfg(413152021)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152021", "story_v_out_413152.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152021", "story_v_out_413152.awb") / 1000

					if var_94_8 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_0
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_out_413152", "413152021", "story_v_out_413152.awb")

						arg_91_1:RecordAudio("413152021", var_94_9)
						arg_91_1:RecordAudio("413152021", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_413152", "413152021", "story_v_out_413152.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_413152", "413152021", "story_v_out_413152.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_10 and arg_91_1.time_ < var_94_0 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play413152022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 413152022
		arg_95_1.duration_ = 8.3

		local var_95_0 = {
			zh = 6.966,
			ja = 8.3
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
				arg_95_0:Play413152023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["10092_1"].transform
			local var_98_1 = 1.14933333333333

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos10092_1 = var_98_0.localPosition
				var_98_0.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("10092_1", 7)

				local var_98_2 = var_98_0.childCount

				for iter_98_0 = 0, var_98_2 - 1 do
					local var_98_3 = var_98_0:GetChild(iter_98_0)

					if var_98_3.name == "" or not string.find(var_98_3.name, "split") then
						var_98_3.gameObject:SetActive(true)
					else
						var_98_3.gameObject:SetActive(false)
					end
				end
			end

			local var_98_4 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_4 then
				local var_98_5 = (arg_95_1.time_ - var_98_1) / var_98_4
				local var_98_6 = Vector3.New(0, -2000, 0)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10092_1, var_98_6, var_98_5)
			end

			if arg_95_1.time_ >= var_98_1 + var_98_4 and arg_95_1.time_ < var_98_1 + var_98_4 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_98_7 = arg_95_1.actors_["10093"].transform
			local var_98_8 = 2.03333333333333

			if var_98_8 < arg_95_1.time_ and arg_95_1.time_ <= var_98_8 + arg_98_0 then
				arg_95_1.var_.moveOldPos10093 = var_98_7.localPosition
				var_98_7.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("10093", 3)

				local var_98_9 = var_98_7.childCount

				for iter_98_1 = 0, var_98_9 - 1 do
					local var_98_10 = var_98_7:GetChild(iter_98_1)

					if var_98_10.name == "split_4" or not string.find(var_98_10.name, "split") then
						var_98_10.gameObject:SetActive(true)
					else
						var_98_10.gameObject:SetActive(false)
					end
				end
			end

			local var_98_11 = 0.001

			if var_98_8 <= arg_95_1.time_ and arg_95_1.time_ < var_98_8 + var_98_11 then
				local var_98_12 = (arg_95_1.time_ - var_98_8) / var_98_11
				local var_98_13 = Vector3.New(0, -345, -245)

				var_98_7.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10093, var_98_13, var_98_12)
			end

			if arg_95_1.time_ >= var_98_8 + var_98_11 and arg_95_1.time_ < var_98_8 + var_98_11 + arg_98_0 then
				var_98_7.localPosition = Vector3.New(0, -345, -245)
			end

			local var_98_14 = arg_95_1.actors_["10093"]
			local var_98_15 = 2.03333333333333

			if var_98_15 < arg_95_1.time_ and arg_95_1.time_ <= var_98_15 + arg_98_0 and not isNil(var_98_14) and arg_95_1.var_.actorSpriteComps10093 == nil then
				arg_95_1.var_.actorSpriteComps10093 = var_98_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_16 = 2

			if var_98_15 <= arg_95_1.time_ and arg_95_1.time_ < var_98_15 + var_98_16 and not isNil(var_98_14) then
				local var_98_17 = (arg_95_1.time_ - var_98_15) / var_98_16

				if arg_95_1.var_.actorSpriteComps10093 then
					for iter_98_2, iter_98_3 in pairs(arg_95_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_98_3 then
							if arg_95_1.isInRecall_ then
								local var_98_18 = Mathf.Lerp(iter_98_3.color.r, arg_95_1.hightColor1.r, var_98_17)
								local var_98_19 = Mathf.Lerp(iter_98_3.color.g, arg_95_1.hightColor1.g, var_98_17)
								local var_98_20 = Mathf.Lerp(iter_98_3.color.b, arg_95_1.hightColor1.b, var_98_17)

								iter_98_3.color = Color.New(var_98_18, var_98_19, var_98_20)
							else
								local var_98_21 = Mathf.Lerp(iter_98_3.color.r, 1, var_98_17)

								iter_98_3.color = Color.New(var_98_21, var_98_21, var_98_21)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= var_98_15 + var_98_16 and arg_95_1.time_ < var_98_15 + var_98_16 + arg_98_0 and not isNil(var_98_14) and arg_95_1.var_.actorSpriteComps10093 then
				for iter_98_4, iter_98_5 in pairs(arg_95_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_98_5 then
						if arg_95_1.isInRecall_ then
							iter_98_5.color = arg_95_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_98_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_95_1.var_.actorSpriteComps10093 = nil
			end

			local var_98_22 = 0

			if var_98_22 < arg_95_1.time_ and arg_95_1.time_ <= var_98_22 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_23 = 1.16666666666667

			if var_98_22 <= arg_95_1.time_ and arg_95_1.time_ < var_98_22 + var_98_23 then
				local var_98_24 = (arg_95_1.time_ - var_98_22) / var_98_23
				local var_98_25 = Color.New(0, 0, 0)

				var_98_25.a = Mathf.Lerp(0, 1, var_98_24)
				arg_95_1.mask_.color = var_98_25
			end

			if arg_95_1.time_ >= var_98_22 + var_98_23 and arg_95_1.time_ < var_98_22 + var_98_23 + arg_98_0 then
				local var_98_26 = Color.New(0, 0, 0)

				var_98_26.a = 1
				arg_95_1.mask_.color = var_98_26
			end

			local var_98_27 = 1.16666666666667

			if var_98_27 < arg_95_1.time_ and arg_95_1.time_ <= var_98_27 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_28 = 1.06666666666667

			if var_98_27 <= arg_95_1.time_ and arg_95_1.time_ < var_98_27 + var_98_28 then
				local var_98_29 = (arg_95_1.time_ - var_98_27) / var_98_28
				local var_98_30 = Color.New(0, 0, 0)

				var_98_30.a = Mathf.Lerp(1, 0, var_98_29)
				arg_95_1.mask_.color = var_98_30
			end

			if arg_95_1.time_ >= var_98_27 + var_98_28 and arg_95_1.time_ < var_98_27 + var_98_28 + arg_98_0 then
				local var_98_31 = Color.New(0, 0, 0)
				local var_98_32 = 0

				arg_95_1.mask_.enabled = false
				var_98_31.a = var_98_32
				arg_95_1.mask_.color = var_98_31
			end

			local var_98_33 = 1.16666666666667

			if var_98_33 < arg_95_1.time_ and arg_95_1.time_ <= var_98_33 + arg_98_0 then
				local var_98_34 = manager.ui.mainCamera.transform.localPosition
				local var_98_35 = Vector3.New(0, 0, 10) + Vector3.New(var_98_34.x, var_98_34.y, 0)
				local var_98_36 = arg_95_1.bgs_.ST0603

				var_98_36.transform.localPosition = var_98_35
				var_98_36.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_98_37 = var_98_36:GetComponent("SpriteRenderer")

				if var_98_37 and var_98_37.sprite then
					local var_98_38 = (var_98_36.transform.localPosition - var_98_34).z
					local var_98_39 = manager.ui.mainCameraCom_
					local var_98_40 = 2 * var_98_38 * Mathf.Tan(var_98_39.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_98_41 = var_98_40 * var_98_39.aspect
					local var_98_42 = var_98_37.sprite.bounds.size.x
					local var_98_43 = var_98_37.sprite.bounds.size.y
					local var_98_44 = var_98_41 / var_98_42
					local var_98_45 = var_98_40 / var_98_43
					local var_98_46 = var_98_45 < var_98_44 and var_98_44 or var_98_45

					var_98_36.transform.localScale = Vector3.New(var_98_46, var_98_46, 0)
				end

				for iter_98_6, iter_98_7 in pairs(arg_95_1.bgs_) do
					if iter_98_6 ~= "ST0603" then
						iter_98_7.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_98_47 = 1.16666666666667

			arg_95_1.isInRecall_ = false

			if var_98_47 < arg_95_1.time_ and arg_95_1.time_ <= var_98_47 + arg_98_0 then
				arg_95_1.screenFilterGo_:SetActive(false)

				for iter_98_8, iter_98_9 in pairs(arg_95_1.actors_) do
					local var_98_48 = iter_98_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_98_10, iter_98_11 in ipairs(var_98_48) do
						if iter_98_11.color.r > 0.51 then
							iter_98_11.color = Color.New(1, 1, 1)
						else
							iter_98_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_98_49 = 0.2

			if var_98_47 <= arg_95_1.time_ and arg_95_1.time_ < var_98_47 + var_98_49 then
				local var_98_50 = (arg_95_1.time_ - var_98_47) / var_98_49

				arg_95_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_98_50)
			end

			if arg_95_1.time_ >= var_98_47 + var_98_49 and arg_95_1.time_ < var_98_47 + var_98_49 + arg_98_0 then
				arg_95_1.screenFilterEffect_.weight = 0
			end

			if arg_95_1.frameCnt_ <= 1 then
				arg_95_1.dialog_:SetActive(false)
			end

			local var_98_51 = 2.2
			local var_98_52 = 0.5

			if var_98_51 < arg_95_1.time_ and arg_95_1.time_ <= var_98_51 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				arg_95_1.dialog_:SetActive(true)

				arg_95_1.dialogCg_.alpha = 0

				local var_98_53 = LeanTween.value(arg_95_1.dialog_, 0, 1, 0.3)

				var_98_53:setOnUpdate(LuaHelper.FloatAction(function(arg_99_0)
					arg_95_1.dialogCg_.alpha = arg_99_0
				end))
				var_98_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_95_1.dialog_)
					var_98_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_95_1.duration_ = arg_95_1.duration_ + 0.3

				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_54 = arg_95_1:FormatText(StoryNameCfg[28].name)

				arg_95_1.leftNameTxt_.text = var_98_54

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_55 = arg_95_1:GetWordFromCfg(413152022)
				local var_98_56 = arg_95_1:FormatText(var_98_55.content)

				arg_95_1.text_.text = var_98_56

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_57 = 20
				local var_98_58 = utf8.len(var_98_56)
				local var_98_59 = var_98_57 <= 0 and var_98_52 or var_98_52 * (var_98_58 / var_98_57)

				if var_98_59 > 0 and var_98_52 < var_98_59 then
					arg_95_1.talkMaxDuration = var_98_59
					var_98_51 = var_98_51 + 0.3

					if var_98_59 + var_98_51 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_59 + var_98_51
					end
				end

				arg_95_1.text_.text = var_98_56
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152022", "story_v_out_413152.awb") ~= 0 then
					local var_98_60 = manager.audio:GetVoiceLength("story_v_out_413152", "413152022", "story_v_out_413152.awb") / 1000

					if var_98_60 + var_98_51 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_60 + var_98_51
					end

					if var_98_55.prefab_name ~= "" and arg_95_1.actors_[var_98_55.prefab_name] ~= nil then
						local var_98_61 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_55.prefab_name].transform, "story_v_out_413152", "413152022", "story_v_out_413152.awb")

						arg_95_1:RecordAudio("413152022", var_98_61)
						arg_95_1:RecordAudio("413152022", var_98_61)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_413152", "413152022", "story_v_out_413152.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_413152", "413152022", "story_v_out_413152.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_62 = var_98_51 + 0.3
			local var_98_63 = math.max(var_98_52, arg_95_1.talkMaxDuration)

			if var_98_62 <= arg_95_1.time_ and arg_95_1.time_ < var_98_62 + var_98_63 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_62) / var_98_63

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_62 + var_98_63 and arg_95_1.time_ < var_98_62 + var_98_63 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.14933333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.03333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play413152023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 413152023
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play413152024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10093"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos10093 = var_104_0.localPosition
				var_104_0.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10093", 6)

				local var_104_2 = var_104_0.childCount

				for iter_104_0 = 0, var_104_2 - 1 do
					local var_104_3 = var_104_0:GetChild(iter_104_0)

					if var_104_3.name == "" or not string.find(var_104_3.name, "split") then
						var_104_3.gameObject:SetActive(true)
					else
						var_104_3.gameObject:SetActive(false)
					end
				end
			end

			local var_104_4 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_4 then
				local var_104_5 = (arg_101_1.time_ - var_104_1) / var_104_4
				local var_104_6 = Vector3.New(1500, -345, -245)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10093, var_104_6, var_104_5)
			end

			if arg_101_1.time_ >= var_104_1 + var_104_4 and arg_101_1.time_ < var_104_1 + var_104_4 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_104_7 = arg_101_1.actors_["10093"]
			local var_104_8 = 0

			if var_104_8 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.actorSpriteComps10093 == nil then
				arg_101_1.var_.actorSpriteComps10093 = var_104_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_9 = 2

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_9 and not isNil(var_104_7) then
				local var_104_10 = (arg_101_1.time_ - var_104_8) / var_104_9

				if arg_101_1.var_.actorSpriteComps10093 then
					for iter_104_1, iter_104_2 in pairs(arg_101_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_104_2 then
							if arg_101_1.isInRecall_ then
								local var_104_11 = Mathf.Lerp(iter_104_2.color.r, arg_101_1.hightColor2.r, var_104_10)
								local var_104_12 = Mathf.Lerp(iter_104_2.color.g, arg_101_1.hightColor2.g, var_104_10)
								local var_104_13 = Mathf.Lerp(iter_104_2.color.b, arg_101_1.hightColor2.b, var_104_10)

								iter_104_2.color = Color.New(var_104_11, var_104_12, var_104_13)
							else
								local var_104_14 = Mathf.Lerp(iter_104_2.color.r, 0.5, var_104_10)

								iter_104_2.color = Color.New(var_104_14, var_104_14, var_104_14)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_8 + var_104_9 and arg_101_1.time_ < var_104_8 + var_104_9 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.actorSpriteComps10093 then
				for iter_104_3, iter_104_4 in pairs(arg_101_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_104_4 then
						if arg_101_1.isInRecall_ then
							iter_104_4.color = arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_104_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10093 = nil
			end

			local var_104_15 = 0
			local var_104_16 = 1.275

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_17 = arg_101_1:GetWordFromCfg(413152023)
				local var_104_18 = arg_101_1:FormatText(var_104_17.content)

				arg_101_1.text_.text = var_104_18

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_19 = 51
				local var_104_20 = utf8.len(var_104_18)
				local var_104_21 = var_104_19 <= 0 and var_104_16 or var_104_16 * (var_104_20 / var_104_19)

				if var_104_21 > 0 and var_104_16 < var_104_21 then
					arg_101_1.talkMaxDuration = var_104_21

					if var_104_21 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_21 + var_104_15
					end
				end

				arg_101_1.text_.text = var_104_18
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_22 = math.max(var_104_16, arg_101_1.talkMaxDuration)

			if var_104_15 <= arg_101_1.time_ and arg_101_1.time_ < var_104_15 + var_104_22 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_15) / var_104_22

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_15 + var_104_22 and arg_101_1.time_ < var_104_15 + var_104_22 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play413152024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 413152024
		arg_105_1.duration_ = 9.87

		local var_105_0 = {
			zh = 9.866,
			ja = 8.133
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
				arg_105_0:Play413152025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10093"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos10093 = var_108_0.localPosition
				var_108_0.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10093", 3)

				local var_108_2 = var_108_0.childCount

				for iter_108_0 = 0, var_108_2 - 1 do
					local var_108_3 = var_108_0:GetChild(iter_108_0)

					if var_108_3.name == "split_4" or not string.find(var_108_3.name, "split") then
						var_108_3.gameObject:SetActive(true)
					else
						var_108_3.gameObject:SetActive(false)
					end
				end
			end

			local var_108_4 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_4 then
				local var_108_5 = (arg_105_1.time_ - var_108_1) / var_108_4
				local var_108_6 = Vector3.New(0, -345, -245)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10093, var_108_6, var_108_5)
			end

			if arg_105_1.time_ >= var_108_1 + var_108_4 and arg_105_1.time_ < var_108_1 + var_108_4 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_108_7 = arg_105_1.actors_["10093"]
			local var_108_8 = 0

			if var_108_8 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 and not isNil(var_108_7) and arg_105_1.var_.actorSpriteComps10093 == nil then
				arg_105_1.var_.actorSpriteComps10093 = var_108_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_9 = 2

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_9 and not isNil(var_108_7) then
				local var_108_10 = (arg_105_1.time_ - var_108_8) / var_108_9

				if arg_105_1.var_.actorSpriteComps10093 then
					for iter_108_1, iter_108_2 in pairs(arg_105_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_108_2 then
							if arg_105_1.isInRecall_ then
								local var_108_11 = Mathf.Lerp(iter_108_2.color.r, arg_105_1.hightColor1.r, var_108_10)
								local var_108_12 = Mathf.Lerp(iter_108_2.color.g, arg_105_1.hightColor1.g, var_108_10)
								local var_108_13 = Mathf.Lerp(iter_108_2.color.b, arg_105_1.hightColor1.b, var_108_10)

								iter_108_2.color = Color.New(var_108_11, var_108_12, var_108_13)
							else
								local var_108_14 = Mathf.Lerp(iter_108_2.color.r, 1, var_108_10)

								iter_108_2.color = Color.New(var_108_14, var_108_14, var_108_14)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_8 + var_108_9 and arg_105_1.time_ < var_108_8 + var_108_9 + arg_108_0 and not isNil(var_108_7) and arg_105_1.var_.actorSpriteComps10093 then
				for iter_108_3, iter_108_4 in pairs(arg_105_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_108_4 then
						if arg_105_1.isInRecall_ then
							iter_108_4.color = arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_108_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps10093 = nil
			end

			local var_108_15 = 0
			local var_108_16 = 0.625

			if var_108_15 < arg_105_1.time_ and arg_105_1.time_ <= var_108_15 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_17 = arg_105_1:FormatText(StoryNameCfg[28].name)

				arg_105_1.leftNameTxt_.text = var_108_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_18 = arg_105_1:GetWordFromCfg(413152024)
				local var_108_19 = arg_105_1:FormatText(var_108_18.content)

				arg_105_1.text_.text = var_108_19

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_20 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152024", "story_v_out_413152.awb") ~= 0 then
					local var_108_23 = manager.audio:GetVoiceLength("story_v_out_413152", "413152024", "story_v_out_413152.awb") / 1000

					if var_108_23 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_23 + var_108_15
					end

					if var_108_18.prefab_name ~= "" and arg_105_1.actors_[var_108_18.prefab_name] ~= nil then
						local var_108_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_18.prefab_name].transform, "story_v_out_413152", "413152024", "story_v_out_413152.awb")

						arg_105_1:RecordAudio("413152024", var_108_24)
						arg_105_1:RecordAudio("413152024", var_108_24)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_413152", "413152024", "story_v_out_413152.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_413152", "413152024", "story_v_out_413152.awb")
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
				actorName = "10093",
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
	Play413152025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 413152025
		arg_109_1.duration_ = 8.5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play413152026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = "F10g"

			if arg_109_1.bgs_[var_112_0] == nil then
				local var_112_1 = Object.Instantiate(arg_109_1.paintGo_)

				var_112_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_112_0)
				var_112_1.name = var_112_0
				var_112_1.transform.parent = arg_109_1.stage_.transform
				var_112_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.bgs_[var_112_0] = var_112_1
			end

			local var_112_2 = 2

			if var_112_2 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				local var_112_3 = manager.ui.mainCamera.transform.localPosition
				local var_112_4 = Vector3.New(0, 0, 10) + Vector3.New(var_112_3.x, var_112_3.y, 0)
				local var_112_5 = arg_109_1.bgs_.F10g

				var_112_5.transform.localPosition = var_112_4
				var_112_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_112_6 = var_112_5:GetComponent("SpriteRenderer")

				if var_112_6 and var_112_6.sprite then
					local var_112_7 = (var_112_5.transform.localPosition - var_112_3).z
					local var_112_8 = manager.ui.mainCameraCom_
					local var_112_9 = 2 * var_112_7 * Mathf.Tan(var_112_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_112_10 = var_112_9 * var_112_8.aspect
					local var_112_11 = var_112_6.sprite.bounds.size.x
					local var_112_12 = var_112_6.sprite.bounds.size.y
					local var_112_13 = var_112_10 / var_112_11
					local var_112_14 = var_112_9 / var_112_12
					local var_112_15 = var_112_14 < var_112_13 and var_112_13 or var_112_14

					var_112_5.transform.localScale = Vector3.New(var_112_15, var_112_15, 0)
				end

				for iter_112_0, iter_112_1 in pairs(arg_109_1.bgs_) do
					if iter_112_0 ~= "F10g" then
						iter_112_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_112_16 = 0

			if var_112_16 < arg_109_1.time_ and arg_109_1.time_ <= var_112_16 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_17 = 2

			if var_112_16 <= arg_109_1.time_ and arg_109_1.time_ < var_112_16 + var_112_17 then
				local var_112_18 = (arg_109_1.time_ - var_112_16) / var_112_17
				local var_112_19 = Color.New(0, 0, 0)

				var_112_19.a = Mathf.Lerp(0, 1, var_112_18)
				arg_109_1.mask_.color = var_112_19
			end

			if arg_109_1.time_ >= var_112_16 + var_112_17 and arg_109_1.time_ < var_112_16 + var_112_17 + arg_112_0 then
				local var_112_20 = Color.New(0, 0, 0)

				var_112_20.a = 1
				arg_109_1.mask_.color = var_112_20
			end

			local var_112_21 = 2

			if var_112_21 < arg_109_1.time_ and arg_109_1.time_ <= var_112_21 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_22 = 2

			if var_112_21 <= arg_109_1.time_ and arg_109_1.time_ < var_112_21 + var_112_22 then
				local var_112_23 = (arg_109_1.time_ - var_112_21) / var_112_22
				local var_112_24 = Color.New(0, 0, 0)

				var_112_24.a = Mathf.Lerp(1, 0, var_112_23)
				arg_109_1.mask_.color = var_112_24
			end

			if arg_109_1.time_ >= var_112_21 + var_112_22 and arg_109_1.time_ < var_112_21 + var_112_22 + arg_112_0 then
				local var_112_25 = Color.New(0, 0, 0)
				local var_112_26 = 0

				arg_109_1.mask_.enabled = false
				var_112_25.a = var_112_26
				arg_109_1.mask_.color = var_112_25
			end

			local var_112_27 = arg_109_1.actors_["10093"].transform
			local var_112_28 = 2

			if var_112_28 < arg_109_1.time_ and arg_109_1.time_ <= var_112_28 + arg_112_0 then
				arg_109_1.var_.moveOldPos10093 = var_112_27.localPosition
				var_112_27.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10093", 7)

				local var_112_29 = var_112_27.childCount

				for iter_112_2 = 0, var_112_29 - 1 do
					local var_112_30 = var_112_27:GetChild(iter_112_2)

					if var_112_30.name == "" or not string.find(var_112_30.name, "split") then
						var_112_30.gameObject:SetActive(true)
					else
						var_112_30.gameObject:SetActive(false)
					end
				end
			end

			local var_112_31 = 0.001

			if var_112_28 <= arg_109_1.time_ and arg_109_1.time_ < var_112_28 + var_112_31 then
				local var_112_32 = (arg_109_1.time_ - var_112_28) / var_112_31
				local var_112_33 = Vector3.New(0, -2000, 0)

				var_112_27.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10093, var_112_33, var_112_32)
			end

			if arg_109_1.time_ >= var_112_28 + var_112_31 and arg_109_1.time_ < var_112_28 + var_112_31 + arg_112_0 then
				var_112_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_112_34 = 2.6
			local var_112_35 = 0.899999999999999

			if var_112_34 < arg_109_1.time_ and arg_109_1.time_ <= var_112_34 + arg_112_0 then
				local var_112_36 = "play"
				local var_112_37 = "effect"

				arg_109_1:AudioAction(var_112_36, var_112_37, "se_story_10", "se_story_10_sword02", "")
			end

			local var_112_38 = manager.ui.mainCamera.transform
			local var_112_39 = 3.4

			if var_112_39 < arg_109_1.time_ and arg_109_1.time_ <= var_112_39 + arg_112_0 then
				arg_109_1.var_.shakeOldPos = var_112_38.localPosition
			end

			local var_112_40 = 0.6

			if var_112_39 <= arg_109_1.time_ and arg_109_1.time_ < var_112_39 + var_112_40 then
				local var_112_41 = (arg_109_1.time_ - var_112_39) / 0.066
				local var_112_42, var_112_43 = math.modf(var_112_41)

				var_112_38.localPosition = Vector3.New(var_112_43 * 0.13, var_112_43 * 0.13, var_112_43 * 0.13) + arg_109_1.var_.shakeOldPos
			end

			if arg_109_1.time_ >= var_112_39 + var_112_40 and arg_109_1.time_ < var_112_39 + var_112_40 + arg_112_0 then
				var_112_38.localPosition = arg_109_1.var_.shakeOldPos
			end

			local var_112_44 = 2.83333333333333
			local var_112_45 = 1

			if var_112_44 < arg_109_1.time_ and arg_109_1.time_ <= var_112_44 + arg_112_0 then
				local var_112_46 = "play"
				local var_112_47 = "effect"

				arg_109_1:AudioAction(var_112_46, var_112_47, "se_story_135_01", "se_story_135_01_scream", "")
			end

			if arg_109_1.frameCnt_ <= 1 then
				arg_109_1.dialog_:SetActive(false)
			end

			local var_112_48 = 3.5
			local var_112_49 = 0.8

			if var_112_48 < arg_109_1.time_ and arg_109_1.time_ <= var_112_48 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				arg_109_1.dialog_:SetActive(true)

				arg_109_1.dialogCg_.alpha = 0

				local var_112_50 = LeanTween.value(arg_109_1.dialog_, 0, 1, 0.3)

				var_112_50:setOnUpdate(LuaHelper.FloatAction(function(arg_113_0)
					arg_109_1.dialogCg_.alpha = arg_113_0
				end))
				var_112_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_109_1.dialog_)
					var_112_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_109_1.duration_ = arg_109_1.duration_ + 0.3

				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_51 = arg_109_1:GetWordFromCfg(413152025)
				local var_112_52 = arg_109_1:FormatText(var_112_51.content)

				arg_109_1.text_.text = var_112_52

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_53 = 32
				local var_112_54 = utf8.len(var_112_52)
				local var_112_55 = var_112_53 <= 0 and var_112_49 or var_112_49 * (var_112_54 / var_112_53)

				if var_112_55 > 0 and var_112_49 < var_112_55 then
					arg_109_1.talkMaxDuration = var_112_55
					var_112_48 = var_112_48 + 0.3

					if var_112_55 + var_112_48 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_55 + var_112_48
					end
				end

				arg_109_1.text_.text = var_112_52
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_56 = var_112_48 + 0.3
			local var_112_57 = math.max(var_112_49, arg_109_1.talkMaxDuration)

			if var_112_56 <= arg_109_1.time_ and arg_109_1.time_ < var_112_56 + var_112_57 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_56) / var_112_57

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_56 + var_112_57 and arg_109_1.time_ < var_112_56 + var_112_57 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play413152026 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 413152026
		arg_115_1.duration_ = 4.47

		local var_115_0 = {
			zh = 4.466,
			ja = 3.433
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
				arg_115_0:Play413152027(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = "10022"

			if arg_115_1.actors_[var_118_0] == nil then
				local var_118_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_118_1) then
					local var_118_2 = Object.Instantiate(var_118_1, arg_115_1.canvasGo_.transform)

					var_118_2.transform:SetSiblingIndex(1)

					var_118_2.name = var_118_0
					var_118_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_115_1.actors_[var_118_0] = var_118_2

					local var_118_3 = var_118_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_115_1.isInRecall_ then
						for iter_118_0, iter_118_1 in ipairs(var_118_3) do
							iter_118_1.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_118_4 = arg_115_1.actors_["10022"].transform
			local var_118_5 = 0

			if var_118_5 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 then
				arg_115_1.var_.moveOldPos10022 = var_118_4.localPosition
				var_118_4.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10022", 3)

				local var_118_6 = var_118_4.childCount

				for iter_118_2 = 0, var_118_6 - 1 do
					local var_118_7 = var_118_4:GetChild(iter_118_2)

					if var_118_7.name == "split_6" or not string.find(var_118_7.name, "split") then
						var_118_7.gameObject:SetActive(true)
					else
						var_118_7.gameObject:SetActive(false)
					end
				end
			end

			local var_118_8 = 0.001

			if var_118_5 <= arg_115_1.time_ and arg_115_1.time_ < var_118_5 + var_118_8 then
				local var_118_9 = (arg_115_1.time_ - var_118_5) / var_118_8
				local var_118_10 = Vector3.New(0, -315, -320)

				var_118_4.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10022, var_118_10, var_118_9)
			end

			if arg_115_1.time_ >= var_118_5 + var_118_8 and arg_115_1.time_ < var_118_5 + var_118_8 + arg_118_0 then
				var_118_4.localPosition = Vector3.New(0, -315, -320)
			end

			local var_118_11 = arg_115_1.actors_["10022"]
			local var_118_12 = 0

			if var_118_12 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 and not isNil(var_118_11) and arg_115_1.var_.actorSpriteComps10022 == nil then
				arg_115_1.var_.actorSpriteComps10022 = var_118_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_13 = 2

			if var_118_12 <= arg_115_1.time_ and arg_115_1.time_ < var_118_12 + var_118_13 and not isNil(var_118_11) then
				local var_118_14 = (arg_115_1.time_ - var_118_12) / var_118_13

				if arg_115_1.var_.actorSpriteComps10022 then
					for iter_118_3, iter_118_4 in pairs(arg_115_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_118_4 then
							if arg_115_1.isInRecall_ then
								local var_118_15 = Mathf.Lerp(iter_118_4.color.r, arg_115_1.hightColor1.r, var_118_14)
								local var_118_16 = Mathf.Lerp(iter_118_4.color.g, arg_115_1.hightColor1.g, var_118_14)
								local var_118_17 = Mathf.Lerp(iter_118_4.color.b, arg_115_1.hightColor1.b, var_118_14)

								iter_118_4.color = Color.New(var_118_15, var_118_16, var_118_17)
							else
								local var_118_18 = Mathf.Lerp(iter_118_4.color.r, 1, var_118_14)

								iter_118_4.color = Color.New(var_118_18, var_118_18, var_118_18)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_12 + var_118_13 and arg_115_1.time_ < var_118_12 + var_118_13 + arg_118_0 and not isNil(var_118_11) and arg_115_1.var_.actorSpriteComps10022 then
				for iter_118_5, iter_118_6 in pairs(arg_115_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_118_6 then
						if arg_115_1.isInRecall_ then
							iter_118_6.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_118_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps10022 = nil
			end

			local var_118_19 = 0
			local var_118_20 = 0.575

			if var_118_19 < arg_115_1.time_ and arg_115_1.time_ <= var_118_19 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_21 = arg_115_1:FormatText(StoryNameCfg[614].name)

				arg_115_1.leftNameTxt_.text = var_118_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_22 = arg_115_1:GetWordFromCfg(413152026)
				local var_118_23 = arg_115_1:FormatText(var_118_22.content)

				arg_115_1.text_.text = var_118_23

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_24 = 23
				local var_118_25 = utf8.len(var_118_23)
				local var_118_26 = var_118_24 <= 0 and var_118_20 or var_118_20 * (var_118_25 / var_118_24)

				if var_118_26 > 0 and var_118_20 < var_118_26 then
					arg_115_1.talkMaxDuration = var_118_26

					if var_118_26 + var_118_19 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_26 + var_118_19
					end
				end

				arg_115_1.text_.text = var_118_23
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152026", "story_v_out_413152.awb") ~= 0 then
					local var_118_27 = manager.audio:GetVoiceLength("story_v_out_413152", "413152026", "story_v_out_413152.awb") / 1000

					if var_118_27 + var_118_19 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_27 + var_118_19
					end

					if var_118_22.prefab_name ~= "" and arg_115_1.actors_[var_118_22.prefab_name] ~= nil then
						local var_118_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_22.prefab_name].transform, "story_v_out_413152", "413152026", "story_v_out_413152.awb")

						arg_115_1:RecordAudio("413152026", var_118_28)
						arg_115_1:RecordAudio("413152026", var_118_28)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_413152", "413152026", "story_v_out_413152.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_413152", "413152026", "story_v_out_413152.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_29 = math.max(var_118_20, arg_115_1.talkMaxDuration)

			if var_118_19 <= arg_115_1.time_ and arg_115_1.time_ < var_118_19 + var_118_29 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_19) / var_118_29

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_19 + var_118_29 and arg_115_1.time_ < var_118_19 + var_118_29 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413152027 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 413152027
		arg_119_1.duration_ = 5.7

		local var_119_0 = {
			zh = 3.9,
			ja = 5.7
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
				arg_119_0:Play413152028(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10022"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.actorSpriteComps10022 == nil then
				arg_119_1.var_.actorSpriteComps10022 = var_122_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_2 = 2

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.actorSpriteComps10022 then
					for iter_122_0, iter_122_1 in pairs(arg_119_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_122_1 then
							if arg_119_1.isInRecall_ then
								local var_122_4 = Mathf.Lerp(iter_122_1.color.r, arg_119_1.hightColor2.r, var_122_3)
								local var_122_5 = Mathf.Lerp(iter_122_1.color.g, arg_119_1.hightColor2.g, var_122_3)
								local var_122_6 = Mathf.Lerp(iter_122_1.color.b, arg_119_1.hightColor2.b, var_122_3)

								iter_122_1.color = Color.New(var_122_4, var_122_5, var_122_6)
							else
								local var_122_7 = Mathf.Lerp(iter_122_1.color.r, 0.5, var_122_3)

								iter_122_1.color = Color.New(var_122_7, var_122_7, var_122_7)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.actorSpriteComps10022 then
				for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_122_3 then
						if arg_119_1.isInRecall_ then
							iter_122_3.color = arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_122_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps10022 = nil
			end

			local var_122_8 = 0
			local var_122_9 = 1

			if var_122_8 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 then
				local var_122_10 = "play"
				local var_122_11 = "effect"

				arg_119_1:AudioAction(var_122_10, var_122_11, "se_story_135_01", "se_story_135_01_chushou01", "")
			end

			local var_122_12 = 0
			local var_122_13 = 0.5

			if var_122_12 < arg_119_1.time_ and arg_119_1.time_ <= var_122_12 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_14 = arg_119_1:FormatText(StoryNameCfg[998].name)

				arg_119_1.leftNameTxt_.text = var_122_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_15 = arg_119_1:GetWordFromCfg(413152027)
				local var_122_16 = arg_119_1:FormatText(var_122_15.content)

				arg_119_1.text_.text = var_122_16

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_17 = 20
				local var_122_18 = utf8.len(var_122_16)
				local var_122_19 = var_122_17 <= 0 and var_122_13 or var_122_13 * (var_122_18 / var_122_17)

				if var_122_19 > 0 and var_122_13 < var_122_19 then
					arg_119_1.talkMaxDuration = var_122_19

					if var_122_19 + var_122_12 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_19 + var_122_12
					end
				end

				arg_119_1.text_.text = var_122_16
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152027", "story_v_out_413152.awb") ~= 0 then
					local var_122_20 = manager.audio:GetVoiceLength("story_v_out_413152", "413152027", "story_v_out_413152.awb") / 1000

					if var_122_20 + var_122_12 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_20 + var_122_12
					end

					if var_122_15.prefab_name ~= "" and arg_119_1.actors_[var_122_15.prefab_name] ~= nil then
						local var_122_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_15.prefab_name].transform, "story_v_out_413152", "413152027", "story_v_out_413152.awb")

						arg_119_1:RecordAudio("413152027", var_122_21)
						arg_119_1:RecordAudio("413152027", var_122_21)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_413152", "413152027", "story_v_out_413152.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_413152", "413152027", "story_v_out_413152.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_22 = math.max(var_122_13, arg_119_1.talkMaxDuration)

			if var_122_12 <= arg_119_1.time_ and arg_119_1.time_ < var_122_12 + var_122_22 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_12) / var_122_22

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_12 + var_122_22 and arg_119_1.time_ < var_122_12 + var_122_22 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play413152028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 413152028
		arg_123_1.duration_ = 5.73

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play413152029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10022"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos10022 = var_126_0.localPosition
				var_126_0.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10022", 6)

				local var_126_2 = var_126_0.childCount

				for iter_126_0 = 0, var_126_2 - 1 do
					local var_126_3 = var_126_0:GetChild(iter_126_0)

					if var_126_3.name == "" or not string.find(var_126_3.name, "split") then
						var_126_3.gameObject:SetActive(true)
					else
						var_126_3.gameObject:SetActive(false)
					end
				end
			end

			local var_126_4 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_4 then
				local var_126_5 = (arg_123_1.time_ - var_126_1) / var_126_4
				local var_126_6 = Vector3.New(1500, -315, -320)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10022, var_126_6, var_126_5)
			end

			if arg_123_1.time_ >= var_126_1 + var_126_4 and arg_123_1.time_ < var_126_1 + var_126_4 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_126_7 = arg_123_1.actors_["10022"]
			local var_126_8 = 0

			if var_126_8 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 and not isNil(var_126_7) and arg_123_1.var_.actorSpriteComps10022 == nil then
				arg_123_1.var_.actorSpriteComps10022 = var_126_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_9 = 2

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_9 and not isNil(var_126_7) then
				local var_126_10 = (arg_123_1.time_ - var_126_8) / var_126_9

				if arg_123_1.var_.actorSpriteComps10022 then
					for iter_126_1, iter_126_2 in pairs(arg_123_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_126_2 then
							if arg_123_1.isInRecall_ then
								local var_126_11 = Mathf.Lerp(iter_126_2.color.r, arg_123_1.hightColor2.r, var_126_10)
								local var_126_12 = Mathf.Lerp(iter_126_2.color.g, arg_123_1.hightColor2.g, var_126_10)
								local var_126_13 = Mathf.Lerp(iter_126_2.color.b, arg_123_1.hightColor2.b, var_126_10)

								iter_126_2.color = Color.New(var_126_11, var_126_12, var_126_13)
							else
								local var_126_14 = Mathf.Lerp(iter_126_2.color.r, 0.5, var_126_10)

								iter_126_2.color = Color.New(var_126_14, var_126_14, var_126_14)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_8 + var_126_9 and arg_123_1.time_ < var_126_8 + var_126_9 + arg_126_0 and not isNil(var_126_7) and arg_123_1.var_.actorSpriteComps10022 then
				for iter_126_3, iter_126_4 in pairs(arg_123_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_126_4 then
						if arg_123_1.isInRecall_ then
							iter_126_4.color = arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_126_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps10022 = nil
			end

			local var_126_15 = manager.ui.mainCamera.transform
			local var_126_16 = 0

			if var_126_16 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 then
				arg_123_1.var_.shakeOldPos = var_126_15.localPosition
			end

			local var_126_17 = 0.533333333333333

			if var_126_16 <= arg_123_1.time_ and arg_123_1.time_ < var_126_16 + var_126_17 then
				local var_126_18 = (arg_123_1.time_ - var_126_16) / 0.066
				local var_126_19, var_126_20 = math.modf(var_126_18)

				var_126_15.localPosition = Vector3.New(var_126_20 * 0.13, var_126_20 * 0.13, var_126_20 * 0.13) + arg_123_1.var_.shakeOldPos
			end

			if arg_123_1.time_ >= var_126_16 + var_126_17 and arg_123_1.time_ < var_126_16 + var_126_17 + arg_126_0 then
				var_126_15.localPosition = arg_123_1.var_.shakeOldPos
			end

			local var_126_21 = 0

			if var_126_21 < arg_123_1.time_ and arg_123_1.time_ <= var_126_21 + arg_126_0 then
				arg_123_1.allBtn_.enabled = false
			end

			local var_126_22 = 0.533333333333333

			if arg_123_1.time_ >= var_126_21 + var_126_22 and arg_123_1.time_ < var_126_21 + var_126_22 + arg_126_0 then
				arg_123_1.allBtn_.enabled = true
			end

			if arg_123_1.frameCnt_ <= 1 then
				arg_123_1.dialog_:SetActive(false)
			end

			local var_126_23 = 0.733333333333333
			local var_126_24 = 0.975

			if var_126_23 < arg_123_1.time_ and arg_123_1.time_ <= var_126_23 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				arg_123_1.dialog_:SetActive(true)

				arg_123_1.dialogCg_.alpha = 0

				local var_126_25 = LeanTween.value(arg_123_1.dialog_, 0, 1, 0.3)

				var_126_25:setOnUpdate(LuaHelper.FloatAction(function(arg_127_0)
					arg_123_1.dialogCg_.alpha = arg_127_0
				end))
				var_126_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_123_1.dialog_)
					var_126_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_123_1.duration_ = arg_123_1.duration_ + 0.3

				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_26 = arg_123_1:GetWordFromCfg(413152028)
				local var_126_27 = arg_123_1:FormatText(var_126_26.content)

				arg_123_1.text_.text = var_126_27

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_28 = 39
				local var_126_29 = utf8.len(var_126_27)
				local var_126_30 = var_126_28 <= 0 and var_126_24 or var_126_24 * (var_126_29 / var_126_28)

				if var_126_30 > 0 and var_126_24 < var_126_30 then
					arg_123_1.talkMaxDuration = var_126_30
					var_126_23 = var_126_23 + 0.3

					if var_126_30 + var_126_23 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_30 + var_126_23
					end
				end

				arg_123_1.text_.text = var_126_27
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_31 = var_126_23 + 0.3
			local var_126_32 = math.max(var_126_24, arg_123_1.talkMaxDuration)

			if var_126_31 <= arg_123_1.time_ and arg_123_1.time_ < var_126_31 + var_126_32 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_31) / var_126_32

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_31 + var_126_32 and arg_123_1.time_ < var_126_31 + var_126_32 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play413152029 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 413152029
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play413152030(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.975

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_2 = arg_129_1:GetWordFromCfg(413152029)
				local var_132_3 = arg_129_1:FormatText(var_132_2.content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 39
				local var_132_5 = utf8.len(var_132_3)
				local var_132_6 = var_132_4 <= 0 and var_132_1 or var_132_1 * (var_132_5 / var_132_4)

				if var_132_6 > 0 and var_132_1 < var_132_6 then
					arg_129_1.talkMaxDuration = var_132_6

					if var_132_6 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_7 and arg_129_1.time_ < var_132_0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play413152030 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 413152030
		arg_133_1.duration_ = 3.7

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play413152031(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10022"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos10022 = var_136_0.localPosition
				var_136_0.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10022", 3)

				local var_136_2 = var_136_0.childCount

				for iter_136_0 = 0, var_136_2 - 1 do
					local var_136_3 = var_136_0:GetChild(iter_136_0)

					if var_136_3.name == "split_6" or not string.find(var_136_3.name, "split") then
						var_136_3.gameObject:SetActive(true)
					else
						var_136_3.gameObject:SetActive(false)
					end
				end
			end

			local var_136_4 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_4 then
				local var_136_5 = (arg_133_1.time_ - var_136_1) / var_136_4
				local var_136_6 = Vector3.New(0, -315, -320)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10022, var_136_6, var_136_5)
			end

			if arg_133_1.time_ >= var_136_1 + var_136_4 and arg_133_1.time_ < var_136_1 + var_136_4 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_136_7 = arg_133_1.actors_["10022"]
			local var_136_8 = 0

			if var_136_8 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 and not isNil(var_136_7) and arg_133_1.var_.actorSpriteComps10022 == nil then
				arg_133_1.var_.actorSpriteComps10022 = var_136_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_9 = 2

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_9 and not isNil(var_136_7) then
				local var_136_10 = (arg_133_1.time_ - var_136_8) / var_136_9

				if arg_133_1.var_.actorSpriteComps10022 then
					for iter_136_1, iter_136_2 in pairs(arg_133_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_136_2 then
							if arg_133_1.isInRecall_ then
								local var_136_11 = Mathf.Lerp(iter_136_2.color.r, arg_133_1.hightColor1.r, var_136_10)
								local var_136_12 = Mathf.Lerp(iter_136_2.color.g, arg_133_1.hightColor1.g, var_136_10)
								local var_136_13 = Mathf.Lerp(iter_136_2.color.b, arg_133_1.hightColor1.b, var_136_10)

								iter_136_2.color = Color.New(var_136_11, var_136_12, var_136_13)
							else
								local var_136_14 = Mathf.Lerp(iter_136_2.color.r, 1, var_136_10)

								iter_136_2.color = Color.New(var_136_14, var_136_14, var_136_14)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= var_136_8 + var_136_9 and arg_133_1.time_ < var_136_8 + var_136_9 + arg_136_0 and not isNil(var_136_7) and arg_133_1.var_.actorSpriteComps10022 then
				for iter_136_3, iter_136_4 in pairs(arg_133_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_136_4 then
						if arg_133_1.isInRecall_ then
							iter_136_4.color = arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_136_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps10022 = nil
			end

			local var_136_15 = 0
			local var_136_16 = 0.425

			if var_136_15 < arg_133_1.time_ and arg_133_1.time_ <= var_136_15 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_17 = arg_133_1:FormatText(StoryNameCfg[614].name)

				arg_133_1.leftNameTxt_.text = var_136_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_18 = arg_133_1:GetWordFromCfg(413152030)
				local var_136_19 = arg_133_1:FormatText(var_136_18.content)

				arg_133_1.text_.text = var_136_19

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_20 = 17
				local var_136_21 = utf8.len(var_136_19)
				local var_136_22 = var_136_20 <= 0 and var_136_16 or var_136_16 * (var_136_21 / var_136_20)

				if var_136_22 > 0 and var_136_16 < var_136_22 then
					arg_133_1.talkMaxDuration = var_136_22

					if var_136_22 + var_136_15 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_22 + var_136_15
					end
				end

				arg_133_1.text_.text = var_136_19
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152030", "story_v_out_413152.awb") ~= 0 then
					local var_136_23 = manager.audio:GetVoiceLength("story_v_out_413152", "413152030", "story_v_out_413152.awb") / 1000

					if var_136_23 + var_136_15 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_23 + var_136_15
					end

					if var_136_18.prefab_name ~= "" and arg_133_1.actors_[var_136_18.prefab_name] ~= nil then
						local var_136_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_18.prefab_name].transform, "story_v_out_413152", "413152030", "story_v_out_413152.awb")

						arg_133_1:RecordAudio("413152030", var_136_24)
						arg_133_1:RecordAudio("413152030", var_136_24)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_413152", "413152030", "story_v_out_413152.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_413152", "413152030", "story_v_out_413152.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_25 = math.max(var_136_16, arg_133_1.talkMaxDuration)

			if var_136_15 <= arg_133_1.time_ and arg_133_1.time_ < var_136_15 + var_136_25 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_15) / var_136_25

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_15 + var_136_25 and arg_133_1.time_ < var_136_15 + var_136_25 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play413152031 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 413152031
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play413152032(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10022"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos10022 = var_140_0.localPosition
				var_140_0.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10022", 6)

				local var_140_2 = var_140_0.childCount

				for iter_140_0 = 0, var_140_2 - 1 do
					local var_140_3 = var_140_0:GetChild(iter_140_0)

					if var_140_3.name == "" or not string.find(var_140_3.name, "split") then
						var_140_3.gameObject:SetActive(true)
					else
						var_140_3.gameObject:SetActive(false)
					end
				end
			end

			local var_140_4 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_4 then
				local var_140_5 = (arg_137_1.time_ - var_140_1) / var_140_4
				local var_140_6 = Vector3.New(1500, -315, -320)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10022, var_140_6, var_140_5)
			end

			if arg_137_1.time_ >= var_140_1 + var_140_4 and arg_137_1.time_ < var_140_1 + var_140_4 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_140_7 = arg_137_1.actors_["10022"]
			local var_140_8 = 0

			if var_140_8 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 and not isNil(var_140_7) and arg_137_1.var_.actorSpriteComps10022 == nil then
				arg_137_1.var_.actorSpriteComps10022 = var_140_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_9 = 2

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_9 and not isNil(var_140_7) then
				local var_140_10 = (arg_137_1.time_ - var_140_8) / var_140_9

				if arg_137_1.var_.actorSpriteComps10022 then
					for iter_140_1, iter_140_2 in pairs(arg_137_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_140_2 then
							if arg_137_1.isInRecall_ then
								local var_140_11 = Mathf.Lerp(iter_140_2.color.r, arg_137_1.hightColor2.r, var_140_10)
								local var_140_12 = Mathf.Lerp(iter_140_2.color.g, arg_137_1.hightColor2.g, var_140_10)
								local var_140_13 = Mathf.Lerp(iter_140_2.color.b, arg_137_1.hightColor2.b, var_140_10)

								iter_140_2.color = Color.New(var_140_11, var_140_12, var_140_13)
							else
								local var_140_14 = Mathf.Lerp(iter_140_2.color.r, 0.5, var_140_10)

								iter_140_2.color = Color.New(var_140_14, var_140_14, var_140_14)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_8 + var_140_9 and arg_137_1.time_ < var_140_8 + var_140_9 + arg_140_0 and not isNil(var_140_7) and arg_137_1.var_.actorSpriteComps10022 then
				for iter_140_3, iter_140_4 in pairs(arg_137_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_140_4 then
						if arg_137_1.isInRecall_ then
							iter_140_4.color = arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_140_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps10022 = nil
			end

			local var_140_15 = 0
			local var_140_16 = 0.775

			if var_140_15 < arg_137_1.time_ and arg_137_1.time_ <= var_140_15 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_17 = arg_137_1:GetWordFromCfg(413152031)
				local var_140_18 = arg_137_1:FormatText(var_140_17.content)

				arg_137_1.text_.text = var_140_18

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_19 = 31
				local var_140_20 = utf8.len(var_140_18)
				local var_140_21 = var_140_19 <= 0 and var_140_16 or var_140_16 * (var_140_20 / var_140_19)

				if var_140_21 > 0 and var_140_16 < var_140_21 then
					arg_137_1.talkMaxDuration = var_140_21

					if var_140_21 + var_140_15 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_21 + var_140_15
					end
				end

				arg_137_1.text_.text = var_140_18
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_22 = math.max(var_140_16, arg_137_1.talkMaxDuration)

			if var_140_15 <= arg_137_1.time_ and arg_137_1.time_ < var_140_15 + var_140_22 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_15) / var_140_22

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_15 + var_140_22 and arg_137_1.time_ < var_140_15 + var_140_22 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play413152032 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 413152032
		arg_141_1.duration_ = 7.2

		local var_141_0 = {
			zh = 7.2,
			ja = 7.066
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
				arg_141_0:Play413152033(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10022"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos10022 = var_144_0.localPosition
				var_144_0.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10022", 3)

				local var_144_2 = var_144_0.childCount

				for iter_144_0 = 0, var_144_2 - 1 do
					local var_144_3 = var_144_0:GetChild(iter_144_0)

					if var_144_3.name == "split_8" or not string.find(var_144_3.name, "split") then
						var_144_3.gameObject:SetActive(true)
					else
						var_144_3.gameObject:SetActive(false)
					end
				end
			end

			local var_144_4 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_4 then
				local var_144_5 = (arg_141_1.time_ - var_144_1) / var_144_4
				local var_144_6 = Vector3.New(0, -315, -320)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10022, var_144_6, var_144_5)
			end

			if arg_141_1.time_ >= var_144_1 + var_144_4 and arg_141_1.time_ < var_144_1 + var_144_4 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_144_7 = arg_141_1.actors_["10022"]
			local var_144_8 = 0

			if var_144_8 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 and not isNil(var_144_7) and arg_141_1.var_.actorSpriteComps10022 == nil then
				arg_141_1.var_.actorSpriteComps10022 = var_144_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_9 = 2

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_9 and not isNil(var_144_7) then
				local var_144_10 = (arg_141_1.time_ - var_144_8) / var_144_9

				if arg_141_1.var_.actorSpriteComps10022 then
					for iter_144_1, iter_144_2 in pairs(arg_141_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_144_2 then
							if arg_141_1.isInRecall_ then
								local var_144_11 = Mathf.Lerp(iter_144_2.color.r, arg_141_1.hightColor1.r, var_144_10)
								local var_144_12 = Mathf.Lerp(iter_144_2.color.g, arg_141_1.hightColor1.g, var_144_10)
								local var_144_13 = Mathf.Lerp(iter_144_2.color.b, arg_141_1.hightColor1.b, var_144_10)

								iter_144_2.color = Color.New(var_144_11, var_144_12, var_144_13)
							else
								local var_144_14 = Mathf.Lerp(iter_144_2.color.r, 1, var_144_10)

								iter_144_2.color = Color.New(var_144_14, var_144_14, var_144_14)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_8 + var_144_9 and arg_141_1.time_ < var_144_8 + var_144_9 + arg_144_0 and not isNil(var_144_7) and arg_141_1.var_.actorSpriteComps10022 then
				for iter_144_3, iter_144_4 in pairs(arg_141_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_144_4 then
						if arg_141_1.isInRecall_ then
							iter_144_4.color = arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_144_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10022 = nil
			end

			local var_144_15 = 0
			local var_144_16 = 0.8

			if var_144_15 < arg_141_1.time_ and arg_141_1.time_ <= var_144_15 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_17 = arg_141_1:FormatText(StoryNameCfg[614].name)

				arg_141_1.leftNameTxt_.text = var_144_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_18 = arg_141_1:GetWordFromCfg(413152032)
				local var_144_19 = arg_141_1:FormatText(var_144_18.content)

				arg_141_1.text_.text = var_144_19

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_20 = 32
				local var_144_21 = utf8.len(var_144_19)
				local var_144_22 = var_144_20 <= 0 and var_144_16 or var_144_16 * (var_144_21 / var_144_20)

				if var_144_22 > 0 and var_144_16 < var_144_22 then
					arg_141_1.talkMaxDuration = var_144_22

					if var_144_22 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_22 + var_144_15
					end
				end

				arg_141_1.text_.text = var_144_19
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152032", "story_v_out_413152.awb") ~= 0 then
					local var_144_23 = manager.audio:GetVoiceLength("story_v_out_413152", "413152032", "story_v_out_413152.awb") / 1000

					if var_144_23 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_23 + var_144_15
					end

					if var_144_18.prefab_name ~= "" and arg_141_1.actors_[var_144_18.prefab_name] ~= nil then
						local var_144_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_18.prefab_name].transform, "story_v_out_413152", "413152032", "story_v_out_413152.awb")

						arg_141_1:RecordAudio("413152032", var_144_24)
						arg_141_1:RecordAudio("413152032", var_144_24)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_413152", "413152032", "story_v_out_413152.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_413152", "413152032", "story_v_out_413152.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_25 = math.max(var_144_16, arg_141_1.talkMaxDuration)

			if var_144_15 <= arg_141_1.time_ and arg_141_1.time_ < var_144_15 + var_144_25 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_15) / var_144_25

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_15 + var_144_25 and arg_141_1.time_ < var_144_15 + var_144_25 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play413152033 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 413152033
		arg_145_1.duration_ = 5.27

		local var_145_0 = {
			zh = 4.466,
			ja = 5.266
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
				arg_145_0:Play413152034(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.4

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[614].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:GetWordFromCfg(413152033)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152033", "story_v_out_413152.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152033", "story_v_out_413152.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_413152", "413152033", "story_v_out_413152.awb")

						arg_145_1:RecordAudio("413152033", var_148_9)
						arg_145_1:RecordAudio("413152033", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_413152", "413152033", "story_v_out_413152.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_413152", "413152033", "story_v_out_413152.awb")
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
	Play413152034 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 413152034
		arg_149_1.duration_ = 8.33

		local var_149_0 = {
			zh = 6.733,
			ja = 8.333
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
				arg_149_0:Play413152035(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10022"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps10022 == nil then
				arg_149_1.var_.actorSpriteComps10022 = var_152_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_2 = 2

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.actorSpriteComps10022 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_152_1 then
							if arg_149_1.isInRecall_ then
								local var_152_4 = Mathf.Lerp(iter_152_1.color.r, arg_149_1.hightColor1.r, var_152_3)
								local var_152_5 = Mathf.Lerp(iter_152_1.color.g, arg_149_1.hightColor1.g, var_152_3)
								local var_152_6 = Mathf.Lerp(iter_152_1.color.b, arg_149_1.hightColor1.b, var_152_3)

								iter_152_1.color = Color.New(var_152_4, var_152_5, var_152_6)
							else
								local var_152_7 = Mathf.Lerp(iter_152_1.color.r, 1, var_152_3)

								iter_152_1.color = Color.New(var_152_7, var_152_7, var_152_7)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps10022 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_152_3 then
						if arg_149_1.isInRecall_ then
							iter_152_3.color = arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_152_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps10022 = nil
			end

			local var_152_8 = 0
			local var_152_9 = 0.775

			if var_152_8 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_10 = arg_149_1:FormatText(StoryNameCfg[614].name)

				arg_149_1.leftNameTxt_.text = var_152_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_11 = arg_149_1:GetWordFromCfg(413152034)
				local var_152_12 = arg_149_1:FormatText(var_152_11.content)

				arg_149_1.text_.text = var_152_12

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_13 = 31
				local var_152_14 = utf8.len(var_152_12)
				local var_152_15 = var_152_13 <= 0 and var_152_9 or var_152_9 * (var_152_14 / var_152_13)

				if var_152_15 > 0 and var_152_9 < var_152_15 then
					arg_149_1.talkMaxDuration = var_152_15

					if var_152_15 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_15 + var_152_8
					end
				end

				arg_149_1.text_.text = var_152_12
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152034", "story_v_out_413152.awb") ~= 0 then
					local var_152_16 = manager.audio:GetVoiceLength("story_v_out_413152", "413152034", "story_v_out_413152.awb") / 1000

					if var_152_16 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_16 + var_152_8
					end

					if var_152_11.prefab_name ~= "" and arg_149_1.actors_[var_152_11.prefab_name] ~= nil then
						local var_152_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_11.prefab_name].transform, "story_v_out_413152", "413152034", "story_v_out_413152.awb")

						arg_149_1:RecordAudio("413152034", var_152_17)
						arg_149_1:RecordAudio("413152034", var_152_17)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_413152", "413152034", "story_v_out_413152.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_413152", "413152034", "story_v_out_413152.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_18 = math.max(var_152_9, arg_149_1.talkMaxDuration)

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_18 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_8) / var_152_18

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_8 + var_152_18 and arg_149_1.time_ < var_152_8 + var_152_18 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play413152035 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 413152035
		arg_153_1.duration_ = 9.97

		local var_153_0 = {
			zh = 6.966,
			ja = 9.966
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
				arg_153_0:Play413152036(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10022"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps10022 == nil then
				arg_153_1.var_.actorSpriteComps10022 = var_156_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_2 = 2

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.actorSpriteComps10022 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_156_1 then
							if arg_153_1.isInRecall_ then
								local var_156_4 = Mathf.Lerp(iter_156_1.color.r, arg_153_1.hightColor1.r, var_156_3)
								local var_156_5 = Mathf.Lerp(iter_156_1.color.g, arg_153_1.hightColor1.g, var_156_3)
								local var_156_6 = Mathf.Lerp(iter_156_1.color.b, arg_153_1.hightColor1.b, var_156_3)

								iter_156_1.color = Color.New(var_156_4, var_156_5, var_156_6)
							else
								local var_156_7 = Mathf.Lerp(iter_156_1.color.r, 1, var_156_3)

								iter_156_1.color = Color.New(var_156_7, var_156_7, var_156_7)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps10022 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_156_3 then
						if arg_153_1.isInRecall_ then
							iter_156_3.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps10022 = nil
			end

			local var_156_8 = 0
			local var_156_9 = 0.75

			if var_156_8 < arg_153_1.time_ and arg_153_1.time_ <= var_156_8 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_10 = arg_153_1:FormatText(StoryNameCfg[614].name)

				arg_153_1.leftNameTxt_.text = var_156_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_11 = arg_153_1:GetWordFromCfg(413152035)
				local var_156_12 = arg_153_1:FormatText(var_156_11.content)

				arg_153_1.text_.text = var_156_12

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_13 = 30
				local var_156_14 = utf8.len(var_156_12)
				local var_156_15 = var_156_13 <= 0 and var_156_9 or var_156_9 * (var_156_14 / var_156_13)

				if var_156_15 > 0 and var_156_9 < var_156_15 then
					arg_153_1.talkMaxDuration = var_156_15

					if var_156_15 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_15 + var_156_8
					end
				end

				arg_153_1.text_.text = var_156_12
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152035", "story_v_out_413152.awb") ~= 0 then
					local var_156_16 = manager.audio:GetVoiceLength("story_v_out_413152", "413152035", "story_v_out_413152.awb") / 1000

					if var_156_16 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_16 + var_156_8
					end

					if var_156_11.prefab_name ~= "" and arg_153_1.actors_[var_156_11.prefab_name] ~= nil then
						local var_156_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_11.prefab_name].transform, "story_v_out_413152", "413152035", "story_v_out_413152.awb")

						arg_153_1:RecordAudio("413152035", var_156_17)
						arg_153_1:RecordAudio("413152035", var_156_17)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_413152", "413152035", "story_v_out_413152.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_413152", "413152035", "story_v_out_413152.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_18 = math.max(var_156_9, arg_153_1.talkMaxDuration)

			if var_156_8 <= arg_153_1.time_ and arg_153_1.time_ < var_156_8 + var_156_18 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_8) / var_156_18

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_8 + var_156_18 and arg_153_1.time_ < var_156_8 + var_156_18 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play413152036 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 413152036
		arg_157_1.duration_ = 6.6

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play413152037(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10022"].transform
			local var_160_1 = 1.366

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos10022 = var_160_0.localPosition
				var_160_0.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10022", 7)

				local var_160_2 = var_160_0.childCount

				for iter_160_0 = 0, var_160_2 - 1 do
					local var_160_3 = var_160_0:GetChild(iter_160_0)

					if var_160_3.name == "" or not string.find(var_160_3.name, "split") then
						var_160_3.gameObject:SetActive(true)
					else
						var_160_3.gameObject:SetActive(false)
					end
				end
			end

			local var_160_4 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_4 then
				local var_160_5 = (arg_157_1.time_ - var_160_1) / var_160_4
				local var_160_6 = Vector3.New(0, -2000, 0)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10022, var_160_6, var_160_5)
			end

			if arg_157_1.time_ >= var_160_1 + var_160_4 and arg_157_1.time_ < var_160_1 + var_160_4 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_160_7 = arg_157_1.actors_["10022"]
			local var_160_8 = 1.366

			if var_160_8 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.actorSpriteComps10022 == nil then
				arg_157_1.var_.actorSpriteComps10022 = var_160_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_9 = 0.034

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_9 and not isNil(var_160_7) then
				local var_160_10 = (arg_157_1.time_ - var_160_8) / var_160_9

				if arg_157_1.var_.actorSpriteComps10022 then
					for iter_160_1, iter_160_2 in pairs(arg_157_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_160_2 then
							if arg_157_1.isInRecall_ then
								local var_160_11 = Mathf.Lerp(iter_160_2.color.r, arg_157_1.hightColor2.r, var_160_10)
								local var_160_12 = Mathf.Lerp(iter_160_2.color.g, arg_157_1.hightColor2.g, var_160_10)
								local var_160_13 = Mathf.Lerp(iter_160_2.color.b, arg_157_1.hightColor2.b, var_160_10)

								iter_160_2.color = Color.New(var_160_11, var_160_12, var_160_13)
							else
								local var_160_14 = Mathf.Lerp(iter_160_2.color.r, 0.5, var_160_10)

								iter_160_2.color = Color.New(var_160_14, var_160_14, var_160_14)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_8 + var_160_9 and arg_157_1.time_ < var_160_8 + var_160_9 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.actorSpriteComps10022 then
				for iter_160_3, iter_160_4 in pairs(arg_157_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_160_4 then
						if arg_157_1.isInRecall_ then
							iter_160_4.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10022 = nil
			end

			local var_160_15 = 0

			if var_160_15 < arg_157_1.time_ and arg_157_1.time_ <= var_160_15 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_16 = 1.4

			if var_160_15 <= arg_157_1.time_ and arg_157_1.time_ < var_160_15 + var_160_16 then
				local var_160_17 = (arg_157_1.time_ - var_160_15) / var_160_16
				local var_160_18 = Color.New(1, 1, 1)

				var_160_18.a = Mathf.Lerp(0, 1, var_160_17)
				arg_157_1.mask_.color = var_160_18
			end

			if arg_157_1.time_ >= var_160_15 + var_160_16 and arg_157_1.time_ < var_160_15 + var_160_16 + arg_160_0 then
				local var_160_19 = Color.New(1, 1, 1)

				var_160_19.a = 1
				arg_157_1.mask_.color = var_160_19
			end

			local var_160_20 = 1.4

			if var_160_20 < arg_157_1.time_ and arg_157_1.time_ <= var_160_20 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_21 = 1.4

			if var_160_20 <= arg_157_1.time_ and arg_157_1.time_ < var_160_20 + var_160_21 then
				local var_160_22 = (arg_157_1.time_ - var_160_20) / var_160_21
				local var_160_23 = Color.New(1, 1, 1)

				var_160_23.a = Mathf.Lerp(1, 0, var_160_22)
				arg_157_1.mask_.color = var_160_23
			end

			if arg_157_1.time_ >= var_160_20 + var_160_21 and arg_157_1.time_ < var_160_20 + var_160_21 + arg_160_0 then
				local var_160_24 = Color.New(1, 1, 1)
				local var_160_25 = 0

				arg_157_1.mask_.enabled = false
				var_160_24.a = var_160_25
				arg_157_1.mask_.color = var_160_24
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_26 = 1.6
			local var_160_27 = 0.975

			if var_160_26 < arg_157_1.time_ and arg_157_1.time_ <= var_160_26 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				arg_157_1.dialog_:SetActive(true)

				arg_157_1.dialogCg_.alpha = 0

				local var_160_28 = LeanTween.value(arg_157_1.dialog_, 0, 1, 0.3)

				var_160_28:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_157_1.dialogCg_.alpha = arg_161_0
				end))
				var_160_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_157_1.dialog_)
					var_160_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_157_1.duration_ = arg_157_1.duration_ + 0.3

				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_29 = arg_157_1:GetWordFromCfg(413152036)
				local var_160_30 = arg_157_1:FormatText(var_160_29.content)

				arg_157_1.text_.text = var_160_30

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_31 = 39
				local var_160_32 = utf8.len(var_160_30)
				local var_160_33 = var_160_31 <= 0 and var_160_27 or var_160_27 * (var_160_32 / var_160_31)

				if var_160_33 > 0 and var_160_27 < var_160_33 then
					arg_157_1.talkMaxDuration = var_160_33
					var_160_26 = var_160_26 + 0.3

					if var_160_33 + var_160_26 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_33 + var_160_26
					end
				end

				arg_157_1.text_.text = var_160_30
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_34 = var_160_26 + 0.3
			local var_160_35 = math.max(var_160_27, arg_157_1.talkMaxDuration)

			if var_160_34 <= arg_157_1.time_ and arg_157_1.time_ < var_160_34 + var_160_35 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_34) / var_160_35

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_34 + var_160_35 and arg_157_1.time_ < var_160_34 + var_160_35 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.366,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play413152037 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 413152037
		arg_163_1.duration_ = 7

		local var_163_0 = {
			zh = 6.4,
			ja = 7
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
				arg_163_0:Play413152038(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10022"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos10022 = var_166_0.localPosition
				var_166_0.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10022", 3)

				local var_166_2 = var_166_0.childCount

				for iter_166_0 = 0, var_166_2 - 1 do
					local var_166_3 = var_166_0:GetChild(iter_166_0)

					if var_166_3.name == "split_8" or not string.find(var_166_3.name, "split") then
						var_166_3.gameObject:SetActive(true)
					else
						var_166_3.gameObject:SetActive(false)
					end
				end
			end

			local var_166_4 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_4 then
				local var_166_5 = (arg_163_1.time_ - var_166_1) / var_166_4
				local var_166_6 = Vector3.New(0, -315, -320)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10022, var_166_6, var_166_5)
			end

			if arg_163_1.time_ >= var_166_1 + var_166_4 and arg_163_1.time_ < var_166_1 + var_166_4 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_166_7 = arg_163_1.actors_["10022"]
			local var_166_8 = 0

			if var_166_8 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 and not isNil(var_166_7) and arg_163_1.var_.actorSpriteComps10022 == nil then
				arg_163_1.var_.actorSpriteComps10022 = var_166_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_9 = 2

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_9 and not isNil(var_166_7) then
				local var_166_10 = (arg_163_1.time_ - var_166_8) / var_166_9

				if arg_163_1.var_.actorSpriteComps10022 then
					for iter_166_1, iter_166_2 in pairs(arg_163_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_166_2 then
							if arg_163_1.isInRecall_ then
								local var_166_11 = Mathf.Lerp(iter_166_2.color.r, arg_163_1.hightColor1.r, var_166_10)
								local var_166_12 = Mathf.Lerp(iter_166_2.color.g, arg_163_1.hightColor1.g, var_166_10)
								local var_166_13 = Mathf.Lerp(iter_166_2.color.b, arg_163_1.hightColor1.b, var_166_10)

								iter_166_2.color = Color.New(var_166_11, var_166_12, var_166_13)
							else
								local var_166_14 = Mathf.Lerp(iter_166_2.color.r, 1, var_166_10)

								iter_166_2.color = Color.New(var_166_14, var_166_14, var_166_14)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_8 + var_166_9 and arg_163_1.time_ < var_166_8 + var_166_9 + arg_166_0 and not isNil(var_166_7) and arg_163_1.var_.actorSpriteComps10022 then
				for iter_166_3, iter_166_4 in pairs(arg_163_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_166_4 then
						if arg_163_1.isInRecall_ then
							iter_166_4.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_166_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps10022 = nil
			end

			local var_166_15 = 0
			local var_166_16 = 0.775

			if var_166_15 < arg_163_1.time_ and arg_163_1.time_ <= var_166_15 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_17 = arg_163_1:FormatText(StoryNameCfg[614].name)

				arg_163_1.leftNameTxt_.text = var_166_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_18 = arg_163_1:GetWordFromCfg(413152037)
				local var_166_19 = arg_163_1:FormatText(var_166_18.content)

				arg_163_1.text_.text = var_166_19

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_20 = 31
				local var_166_21 = utf8.len(var_166_19)
				local var_166_22 = var_166_20 <= 0 and var_166_16 or var_166_16 * (var_166_21 / var_166_20)

				if var_166_22 > 0 and var_166_16 < var_166_22 then
					arg_163_1.talkMaxDuration = var_166_22

					if var_166_22 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_22 + var_166_15
					end
				end

				arg_163_1.text_.text = var_166_19
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152037", "story_v_out_413152.awb") ~= 0 then
					local var_166_23 = manager.audio:GetVoiceLength("story_v_out_413152", "413152037", "story_v_out_413152.awb") / 1000

					if var_166_23 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_23 + var_166_15
					end

					if var_166_18.prefab_name ~= "" and arg_163_1.actors_[var_166_18.prefab_name] ~= nil then
						local var_166_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_18.prefab_name].transform, "story_v_out_413152", "413152037", "story_v_out_413152.awb")

						arg_163_1:RecordAudio("413152037", var_166_24)
						arg_163_1:RecordAudio("413152037", var_166_24)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_413152", "413152037", "story_v_out_413152.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_413152", "413152037", "story_v_out_413152.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_25 = math.max(var_166_16, arg_163_1.talkMaxDuration)

			if var_166_15 <= arg_163_1.time_ and arg_163_1.time_ < var_166_15 + var_166_25 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_15) / var_166_25

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_15 + var_166_25 and arg_163_1.time_ < var_166_15 + var_166_25 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play413152038 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 413152038
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play413152039(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10022"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos10022 = var_170_0.localPosition
				var_170_0.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10022", 6)

				local var_170_2 = var_170_0.childCount

				for iter_170_0 = 0, var_170_2 - 1 do
					local var_170_3 = var_170_0:GetChild(iter_170_0)

					if var_170_3.name == "" or not string.find(var_170_3.name, "split") then
						var_170_3.gameObject:SetActive(true)
					else
						var_170_3.gameObject:SetActive(false)
					end
				end
			end

			local var_170_4 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_4 then
				local var_170_5 = (arg_167_1.time_ - var_170_1) / var_170_4
				local var_170_6 = Vector3.New(1500, -315, -320)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10022, var_170_6, var_170_5)
			end

			if arg_167_1.time_ >= var_170_1 + var_170_4 and arg_167_1.time_ < var_170_1 + var_170_4 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_170_7 = arg_167_1.actors_["10022"]
			local var_170_8 = 0

			if var_170_8 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 and not isNil(var_170_7) and arg_167_1.var_.actorSpriteComps10022 == nil then
				arg_167_1.var_.actorSpriteComps10022 = var_170_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_9 = 2

			if var_170_8 <= arg_167_1.time_ and arg_167_1.time_ < var_170_8 + var_170_9 and not isNil(var_170_7) then
				local var_170_10 = (arg_167_1.time_ - var_170_8) / var_170_9

				if arg_167_1.var_.actorSpriteComps10022 then
					for iter_170_1, iter_170_2 in pairs(arg_167_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_170_2 then
							if arg_167_1.isInRecall_ then
								local var_170_11 = Mathf.Lerp(iter_170_2.color.r, arg_167_1.hightColor2.r, var_170_10)
								local var_170_12 = Mathf.Lerp(iter_170_2.color.g, arg_167_1.hightColor2.g, var_170_10)
								local var_170_13 = Mathf.Lerp(iter_170_2.color.b, arg_167_1.hightColor2.b, var_170_10)

								iter_170_2.color = Color.New(var_170_11, var_170_12, var_170_13)
							else
								local var_170_14 = Mathf.Lerp(iter_170_2.color.r, 0.5, var_170_10)

								iter_170_2.color = Color.New(var_170_14, var_170_14, var_170_14)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= var_170_8 + var_170_9 and arg_167_1.time_ < var_170_8 + var_170_9 + arg_170_0 and not isNil(var_170_7) and arg_167_1.var_.actorSpriteComps10022 then
				for iter_170_3, iter_170_4 in pairs(arg_167_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_170_4 then
						if arg_167_1.isInRecall_ then
							iter_170_4.color = arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_170_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps10022 = nil
			end

			local var_170_15 = 0
			local var_170_16 = 1.25

			if var_170_15 < arg_167_1.time_ and arg_167_1.time_ <= var_170_15 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_17 = arg_167_1:GetWordFromCfg(413152038)
				local var_170_18 = arg_167_1:FormatText(var_170_17.content)

				arg_167_1.text_.text = var_170_18

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_19 = 50
				local var_170_20 = utf8.len(var_170_18)
				local var_170_21 = var_170_19 <= 0 and var_170_16 or var_170_16 * (var_170_20 / var_170_19)

				if var_170_21 > 0 and var_170_16 < var_170_21 then
					arg_167_1.talkMaxDuration = var_170_21

					if var_170_21 + var_170_15 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_21 + var_170_15
					end
				end

				arg_167_1.text_.text = var_170_18
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_22 = math.max(var_170_16, arg_167_1.talkMaxDuration)

			if var_170_15 <= arg_167_1.time_ and arg_167_1.time_ < var_170_15 + var_170_22 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_15) / var_170_22

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_15 + var_170_22 and arg_167_1.time_ < var_170_15 + var_170_22 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413152039 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 413152039
		arg_171_1.duration_ = 3.57

		local var_171_0 = {
			zh = 3.366,
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
				arg_171_0:Play413152040(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10022"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos10022 = var_174_0.localPosition
				var_174_0.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10022", 3)

				local var_174_2 = var_174_0.childCount

				for iter_174_0 = 0, var_174_2 - 1 do
					local var_174_3 = var_174_0:GetChild(iter_174_0)

					if var_174_3.name == "split_2" or not string.find(var_174_3.name, "split") then
						var_174_3.gameObject:SetActive(true)
					else
						var_174_3.gameObject:SetActive(false)
					end
				end
			end

			local var_174_4 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_4 then
				local var_174_5 = (arg_171_1.time_ - var_174_1) / var_174_4
				local var_174_6 = Vector3.New(0, -315, -320)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10022, var_174_6, var_174_5)
			end

			if arg_171_1.time_ >= var_174_1 + var_174_4 and arg_171_1.time_ < var_174_1 + var_174_4 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_174_7 = arg_171_1.actors_["10022"]
			local var_174_8 = 0

			if var_174_8 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 and not isNil(var_174_7) and arg_171_1.var_.actorSpriteComps10022 == nil then
				arg_171_1.var_.actorSpriteComps10022 = var_174_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_9 = 2

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_9 and not isNil(var_174_7) then
				local var_174_10 = (arg_171_1.time_ - var_174_8) / var_174_9

				if arg_171_1.var_.actorSpriteComps10022 then
					for iter_174_1, iter_174_2 in pairs(arg_171_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_174_2 then
							if arg_171_1.isInRecall_ then
								local var_174_11 = Mathf.Lerp(iter_174_2.color.r, arg_171_1.hightColor1.r, var_174_10)
								local var_174_12 = Mathf.Lerp(iter_174_2.color.g, arg_171_1.hightColor1.g, var_174_10)
								local var_174_13 = Mathf.Lerp(iter_174_2.color.b, arg_171_1.hightColor1.b, var_174_10)

								iter_174_2.color = Color.New(var_174_11, var_174_12, var_174_13)
							else
								local var_174_14 = Mathf.Lerp(iter_174_2.color.r, 1, var_174_10)

								iter_174_2.color = Color.New(var_174_14, var_174_14, var_174_14)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= var_174_8 + var_174_9 and arg_171_1.time_ < var_174_8 + var_174_9 + arg_174_0 and not isNil(var_174_7) and arg_171_1.var_.actorSpriteComps10022 then
				for iter_174_3, iter_174_4 in pairs(arg_171_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_174_4 then
						if arg_171_1.isInRecall_ then
							iter_174_4.color = arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_174_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps10022 = nil
			end

			local var_174_15 = 0
			local var_174_16 = 0.325

			if var_174_15 < arg_171_1.time_ and arg_171_1.time_ <= var_174_15 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_17 = arg_171_1:FormatText(StoryNameCfg[614].name)

				arg_171_1.leftNameTxt_.text = var_174_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_18 = arg_171_1:GetWordFromCfg(413152039)
				local var_174_19 = arg_171_1:FormatText(var_174_18.content)

				arg_171_1.text_.text = var_174_19

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_20 = 13
				local var_174_21 = utf8.len(var_174_19)
				local var_174_22 = var_174_20 <= 0 and var_174_16 or var_174_16 * (var_174_21 / var_174_20)

				if var_174_22 > 0 and var_174_16 < var_174_22 then
					arg_171_1.talkMaxDuration = var_174_22

					if var_174_22 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_22 + var_174_15
					end
				end

				arg_171_1.text_.text = var_174_19
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152039", "story_v_out_413152.awb") ~= 0 then
					local var_174_23 = manager.audio:GetVoiceLength("story_v_out_413152", "413152039", "story_v_out_413152.awb") / 1000

					if var_174_23 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_23 + var_174_15
					end

					if var_174_18.prefab_name ~= "" and arg_171_1.actors_[var_174_18.prefab_name] ~= nil then
						local var_174_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_18.prefab_name].transform, "story_v_out_413152", "413152039", "story_v_out_413152.awb")

						arg_171_1:RecordAudio("413152039", var_174_24)
						arg_171_1:RecordAudio("413152039", var_174_24)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_413152", "413152039", "story_v_out_413152.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_413152", "413152039", "story_v_out_413152.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_25 = math.max(var_174_16, arg_171_1.talkMaxDuration)

			if var_174_15 <= arg_171_1.time_ and arg_171_1.time_ < var_174_15 + var_174_25 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_15) / var_174_25

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_15 + var_174_25 and arg_171_1.time_ < var_174_15 + var_174_25 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play413152040 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 413152040
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play413152041(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["10022"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos10022 = var_178_0.localPosition
				var_178_0.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("10022", 6)

				local var_178_2 = var_178_0.childCount

				for iter_178_0 = 0, var_178_2 - 1 do
					local var_178_3 = var_178_0:GetChild(iter_178_0)

					if var_178_3.name == "" or not string.find(var_178_3.name, "split") then
						var_178_3.gameObject:SetActive(true)
					else
						var_178_3.gameObject:SetActive(false)
					end
				end
			end

			local var_178_4 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_4 then
				local var_178_5 = (arg_175_1.time_ - var_178_1) / var_178_4
				local var_178_6 = Vector3.New(1500, -315, -320)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10022, var_178_6, var_178_5)
			end

			if arg_175_1.time_ >= var_178_1 + var_178_4 and arg_175_1.time_ < var_178_1 + var_178_4 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_178_7 = arg_175_1.actors_["10022"]
			local var_178_8 = 0

			if var_178_8 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 and not isNil(var_178_7) and arg_175_1.var_.actorSpriteComps10022 == nil then
				arg_175_1.var_.actorSpriteComps10022 = var_178_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_9 = 2

			if var_178_8 <= arg_175_1.time_ and arg_175_1.time_ < var_178_8 + var_178_9 and not isNil(var_178_7) then
				local var_178_10 = (arg_175_1.time_ - var_178_8) / var_178_9

				if arg_175_1.var_.actorSpriteComps10022 then
					for iter_178_1, iter_178_2 in pairs(arg_175_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_178_2 then
							if arg_175_1.isInRecall_ then
								local var_178_11 = Mathf.Lerp(iter_178_2.color.r, arg_175_1.hightColor2.r, var_178_10)
								local var_178_12 = Mathf.Lerp(iter_178_2.color.g, arg_175_1.hightColor2.g, var_178_10)
								local var_178_13 = Mathf.Lerp(iter_178_2.color.b, arg_175_1.hightColor2.b, var_178_10)

								iter_178_2.color = Color.New(var_178_11, var_178_12, var_178_13)
							else
								local var_178_14 = Mathf.Lerp(iter_178_2.color.r, 0.5, var_178_10)

								iter_178_2.color = Color.New(var_178_14, var_178_14, var_178_14)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= var_178_8 + var_178_9 and arg_175_1.time_ < var_178_8 + var_178_9 + arg_178_0 and not isNil(var_178_7) and arg_175_1.var_.actorSpriteComps10022 then
				for iter_178_3, iter_178_4 in pairs(arg_175_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_178_4 then
						if arg_175_1.isInRecall_ then
							iter_178_4.color = arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_178_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_175_1.var_.actorSpriteComps10022 = nil
			end

			local var_178_15 = 0
			local var_178_16 = 1

			if var_178_15 < arg_175_1.time_ and arg_175_1.time_ <= var_178_15 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_17 = arg_175_1:GetWordFromCfg(413152040)
				local var_178_18 = arg_175_1:FormatText(var_178_17.content)

				arg_175_1.text_.text = var_178_18

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_19 = 40
				local var_178_20 = utf8.len(var_178_18)
				local var_178_21 = var_178_19 <= 0 and var_178_16 or var_178_16 * (var_178_20 / var_178_19)

				if var_178_21 > 0 and var_178_16 < var_178_21 then
					arg_175_1.talkMaxDuration = var_178_21

					if var_178_21 + var_178_15 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_21 + var_178_15
					end
				end

				arg_175_1.text_.text = var_178_18
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_22 = math.max(var_178_16, arg_175_1.talkMaxDuration)

			if var_178_15 <= arg_175_1.time_ and arg_175_1.time_ < var_178_15 + var_178_22 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_15) / var_178_22

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_15 + var_178_22 and arg_175_1.time_ < var_178_15 + var_178_22 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413152041 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 413152041
		arg_179_1.duration_ = 2.9

		local var_179_0 = {
			zh = 2.9,
			ja = 2.5
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
				arg_179_0:Play413152042(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["10022"].transform
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.var_.moveOldPos10022 = var_182_0.localPosition
				var_182_0.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("10022", 3)

				local var_182_2 = var_182_0.childCount

				for iter_182_0 = 0, var_182_2 - 1 do
					local var_182_3 = var_182_0:GetChild(iter_182_0)

					if var_182_3.name == "split_6" or not string.find(var_182_3.name, "split") then
						var_182_3.gameObject:SetActive(true)
					else
						var_182_3.gameObject:SetActive(false)
					end
				end
			end

			local var_182_4 = 0.001

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_4 then
				local var_182_5 = (arg_179_1.time_ - var_182_1) / var_182_4
				local var_182_6 = Vector3.New(0, -315, -320)

				var_182_0.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10022, var_182_6, var_182_5)
			end

			if arg_179_1.time_ >= var_182_1 + var_182_4 and arg_179_1.time_ < var_182_1 + var_182_4 + arg_182_0 then
				var_182_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_182_7 = arg_179_1.actors_["10022"]
			local var_182_8 = 0

			if var_182_8 < arg_179_1.time_ and arg_179_1.time_ <= var_182_8 + arg_182_0 and not isNil(var_182_7) and arg_179_1.var_.actorSpriteComps10022 == nil then
				arg_179_1.var_.actorSpriteComps10022 = var_182_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_9 = 2

			if var_182_8 <= arg_179_1.time_ and arg_179_1.time_ < var_182_8 + var_182_9 and not isNil(var_182_7) then
				local var_182_10 = (arg_179_1.time_ - var_182_8) / var_182_9

				if arg_179_1.var_.actorSpriteComps10022 then
					for iter_182_1, iter_182_2 in pairs(arg_179_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_182_2 then
							if arg_179_1.isInRecall_ then
								local var_182_11 = Mathf.Lerp(iter_182_2.color.r, arg_179_1.hightColor1.r, var_182_10)
								local var_182_12 = Mathf.Lerp(iter_182_2.color.g, arg_179_1.hightColor1.g, var_182_10)
								local var_182_13 = Mathf.Lerp(iter_182_2.color.b, arg_179_1.hightColor1.b, var_182_10)

								iter_182_2.color = Color.New(var_182_11, var_182_12, var_182_13)
							else
								local var_182_14 = Mathf.Lerp(iter_182_2.color.r, 1, var_182_10)

								iter_182_2.color = Color.New(var_182_14, var_182_14, var_182_14)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_8 + var_182_9 and arg_179_1.time_ < var_182_8 + var_182_9 + arg_182_0 and not isNil(var_182_7) and arg_179_1.var_.actorSpriteComps10022 then
				for iter_182_3, iter_182_4 in pairs(arg_179_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_182_4 then
						if arg_179_1.isInRecall_ then
							iter_182_4.color = arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_182_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps10022 = nil
			end

			local var_182_15 = 0
			local var_182_16 = 0.275

			if var_182_15 < arg_179_1.time_ and arg_179_1.time_ <= var_182_15 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_17 = arg_179_1:FormatText(StoryNameCfg[614].name)

				arg_179_1.leftNameTxt_.text = var_182_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_18 = arg_179_1:GetWordFromCfg(413152041)
				local var_182_19 = arg_179_1:FormatText(var_182_18.content)

				arg_179_1.text_.text = var_182_19

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_20 = 11
				local var_182_21 = utf8.len(var_182_19)
				local var_182_22 = var_182_20 <= 0 and var_182_16 or var_182_16 * (var_182_21 / var_182_20)

				if var_182_22 > 0 and var_182_16 < var_182_22 then
					arg_179_1.talkMaxDuration = var_182_22

					if var_182_22 + var_182_15 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_22 + var_182_15
					end
				end

				arg_179_1.text_.text = var_182_19
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152041", "story_v_out_413152.awb") ~= 0 then
					local var_182_23 = manager.audio:GetVoiceLength("story_v_out_413152", "413152041", "story_v_out_413152.awb") / 1000

					if var_182_23 + var_182_15 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_23 + var_182_15
					end

					if var_182_18.prefab_name ~= "" and arg_179_1.actors_[var_182_18.prefab_name] ~= nil then
						local var_182_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_18.prefab_name].transform, "story_v_out_413152", "413152041", "story_v_out_413152.awb")

						arg_179_1:RecordAudio("413152041", var_182_24)
						arg_179_1:RecordAudio("413152041", var_182_24)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_413152", "413152041", "story_v_out_413152.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_413152", "413152041", "story_v_out_413152.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_25 = math.max(var_182_16, arg_179_1.talkMaxDuration)

			if var_182_15 <= arg_179_1.time_ and arg_179_1.time_ < var_182_15 + var_182_25 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_15) / var_182_25

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_15 + var_182_25 and arg_179_1.time_ < var_182_15 + var_182_25 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413152042 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 413152042
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play413152043(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["10022"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos10022 = var_186_0.localPosition
				var_186_0.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10022", 6)

				local var_186_2 = var_186_0.childCount

				for iter_186_0 = 0, var_186_2 - 1 do
					local var_186_3 = var_186_0:GetChild(iter_186_0)

					if var_186_3.name == "" or not string.find(var_186_3.name, "split") then
						var_186_3.gameObject:SetActive(true)
					else
						var_186_3.gameObject:SetActive(false)
					end
				end
			end

			local var_186_4 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_4 then
				local var_186_5 = (arg_183_1.time_ - var_186_1) / var_186_4
				local var_186_6 = Vector3.New(1500, -315, -320)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10022, var_186_6, var_186_5)
			end

			if arg_183_1.time_ >= var_186_1 + var_186_4 and arg_183_1.time_ < var_186_1 + var_186_4 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_186_7 = arg_183_1.actors_["10022"]
			local var_186_8 = 0

			if var_186_8 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 and not isNil(var_186_7) and arg_183_1.var_.actorSpriteComps10022 == nil then
				arg_183_1.var_.actorSpriteComps10022 = var_186_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_9 = 2

			if var_186_8 <= arg_183_1.time_ and arg_183_1.time_ < var_186_8 + var_186_9 and not isNil(var_186_7) then
				local var_186_10 = (arg_183_1.time_ - var_186_8) / var_186_9

				if arg_183_1.var_.actorSpriteComps10022 then
					for iter_186_1, iter_186_2 in pairs(arg_183_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_186_2 then
							if arg_183_1.isInRecall_ then
								local var_186_11 = Mathf.Lerp(iter_186_2.color.r, arg_183_1.hightColor2.r, var_186_10)
								local var_186_12 = Mathf.Lerp(iter_186_2.color.g, arg_183_1.hightColor2.g, var_186_10)
								local var_186_13 = Mathf.Lerp(iter_186_2.color.b, arg_183_1.hightColor2.b, var_186_10)

								iter_186_2.color = Color.New(var_186_11, var_186_12, var_186_13)
							else
								local var_186_14 = Mathf.Lerp(iter_186_2.color.r, 0.5, var_186_10)

								iter_186_2.color = Color.New(var_186_14, var_186_14, var_186_14)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= var_186_8 + var_186_9 and arg_183_1.time_ < var_186_8 + var_186_9 + arg_186_0 and not isNil(var_186_7) and arg_183_1.var_.actorSpriteComps10022 then
				for iter_186_3, iter_186_4 in pairs(arg_183_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_186_4 then
						if arg_183_1.isInRecall_ then
							iter_186_4.color = arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_186_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps10022 = nil
			end

			local var_186_15 = 0
			local var_186_16 = 1

			if var_186_15 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				local var_186_17 = "play"
				local var_186_18 = "effect"

				arg_183_1:AudioAction(var_186_17, var_186_18, "se_story_135_01", "se_story_135_01_chushou02", "")
			end

			local var_186_19 = 0
			local var_186_20 = 0.775

			if var_186_19 < arg_183_1.time_ and arg_183_1.time_ <= var_186_19 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_21 = arg_183_1:GetWordFromCfg(413152042)
				local var_186_22 = arg_183_1:FormatText(var_186_21.content)

				arg_183_1.text_.text = var_186_22

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_23 = 31
				local var_186_24 = utf8.len(var_186_22)
				local var_186_25 = var_186_23 <= 0 and var_186_20 or var_186_20 * (var_186_24 / var_186_23)

				if var_186_25 > 0 and var_186_20 < var_186_25 then
					arg_183_1.talkMaxDuration = var_186_25

					if var_186_25 + var_186_19 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_25 + var_186_19
					end
				end

				arg_183_1.text_.text = var_186_22
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_26 = math.max(var_186_20, arg_183_1.talkMaxDuration)

			if var_186_19 <= arg_183_1.time_ and arg_183_1.time_ < var_186_19 + var_186_26 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_19) / var_186_26

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_19 + var_186_26 and arg_183_1.time_ < var_186_19 + var_186_26 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413152043 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 413152043
		arg_187_1.duration_ = 2

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play413152044(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["10022"].transform
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.var_.moveOldPos10022 = var_190_0.localPosition
				var_190_0.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("10022", 3)

				local var_190_2 = var_190_0.childCount

				for iter_190_0 = 0, var_190_2 - 1 do
					local var_190_3 = var_190_0:GetChild(iter_190_0)

					if var_190_3.name == "split_2" or not string.find(var_190_3.name, "split") then
						var_190_3.gameObject:SetActive(true)
					else
						var_190_3.gameObject:SetActive(false)
					end
				end
			end

			local var_190_4 = 0.001

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_4 then
				local var_190_5 = (arg_187_1.time_ - var_190_1) / var_190_4
				local var_190_6 = Vector3.New(0, -315, -320)

				var_190_0.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10022, var_190_6, var_190_5)
			end

			if arg_187_1.time_ >= var_190_1 + var_190_4 and arg_187_1.time_ < var_190_1 + var_190_4 + arg_190_0 then
				var_190_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_190_7 = arg_187_1.actors_["10022"]
			local var_190_8 = 0

			if var_190_8 < arg_187_1.time_ and arg_187_1.time_ <= var_190_8 + arg_190_0 and not isNil(var_190_7) and arg_187_1.var_.actorSpriteComps10022 == nil then
				arg_187_1.var_.actorSpriteComps10022 = var_190_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_9 = 2

			if var_190_8 <= arg_187_1.time_ and arg_187_1.time_ < var_190_8 + var_190_9 and not isNil(var_190_7) then
				local var_190_10 = (arg_187_1.time_ - var_190_8) / var_190_9

				if arg_187_1.var_.actorSpriteComps10022 then
					for iter_190_1, iter_190_2 in pairs(arg_187_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_190_2 then
							if arg_187_1.isInRecall_ then
								local var_190_11 = Mathf.Lerp(iter_190_2.color.r, arg_187_1.hightColor1.r, var_190_10)
								local var_190_12 = Mathf.Lerp(iter_190_2.color.g, arg_187_1.hightColor1.g, var_190_10)
								local var_190_13 = Mathf.Lerp(iter_190_2.color.b, arg_187_1.hightColor1.b, var_190_10)

								iter_190_2.color = Color.New(var_190_11, var_190_12, var_190_13)
							else
								local var_190_14 = Mathf.Lerp(iter_190_2.color.r, 1, var_190_10)

								iter_190_2.color = Color.New(var_190_14, var_190_14, var_190_14)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= var_190_8 + var_190_9 and arg_187_1.time_ < var_190_8 + var_190_9 + arg_190_0 and not isNil(var_190_7) and arg_187_1.var_.actorSpriteComps10022 then
				for iter_190_3, iter_190_4 in pairs(arg_187_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_190_4 then
						if arg_187_1.isInRecall_ then
							iter_190_4.color = arg_187_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_190_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_187_1.var_.actorSpriteComps10022 = nil
			end

			local var_190_15 = 0
			local var_190_16 = 0.1

			if var_190_15 < arg_187_1.time_ and arg_187_1.time_ <= var_190_15 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_17 = arg_187_1:FormatText(StoryNameCfg[614].name)

				arg_187_1.leftNameTxt_.text = var_190_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_18 = arg_187_1:GetWordFromCfg(413152043)
				local var_190_19 = arg_187_1:FormatText(var_190_18.content)

				arg_187_1.text_.text = var_190_19

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_20 = 4
				local var_190_21 = utf8.len(var_190_19)
				local var_190_22 = var_190_20 <= 0 and var_190_16 or var_190_16 * (var_190_21 / var_190_20)

				if var_190_22 > 0 and var_190_16 < var_190_22 then
					arg_187_1.talkMaxDuration = var_190_22

					if var_190_22 + var_190_15 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_22 + var_190_15
					end
				end

				arg_187_1.text_.text = var_190_19
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152043", "story_v_out_413152.awb") ~= 0 then
					local var_190_23 = manager.audio:GetVoiceLength("story_v_out_413152", "413152043", "story_v_out_413152.awb") / 1000

					if var_190_23 + var_190_15 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_23 + var_190_15
					end

					if var_190_18.prefab_name ~= "" and arg_187_1.actors_[var_190_18.prefab_name] ~= nil then
						local var_190_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_18.prefab_name].transform, "story_v_out_413152", "413152043", "story_v_out_413152.awb")

						arg_187_1:RecordAudio("413152043", var_190_24)
						arg_187_1:RecordAudio("413152043", var_190_24)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_413152", "413152043", "story_v_out_413152.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_413152", "413152043", "story_v_out_413152.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_25 = math.max(var_190_16, arg_187_1.talkMaxDuration)

			if var_190_15 <= arg_187_1.time_ and arg_187_1.time_ < var_190_15 + var_190_25 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_15) / var_190_25

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_15 + var_190_25 and arg_187_1.time_ < var_190_15 + var_190_25 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413152044 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 413152044
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play413152045(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["10022"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos10022 = var_194_0.localPosition
				var_194_0.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("10022", 6)

				local var_194_2 = var_194_0.childCount

				for iter_194_0 = 0, var_194_2 - 1 do
					local var_194_3 = var_194_0:GetChild(iter_194_0)

					if var_194_3.name == "" or not string.find(var_194_3.name, "split") then
						var_194_3.gameObject:SetActive(true)
					else
						var_194_3.gameObject:SetActive(false)
					end
				end
			end

			local var_194_4 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_4 then
				local var_194_5 = (arg_191_1.time_ - var_194_1) / var_194_4
				local var_194_6 = Vector3.New(1500, -315, -320)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10022, var_194_6, var_194_5)
			end

			if arg_191_1.time_ >= var_194_1 + var_194_4 and arg_191_1.time_ < var_194_1 + var_194_4 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_194_7 = arg_191_1.actors_["10022"]
			local var_194_8 = 0

			if var_194_8 < arg_191_1.time_ and arg_191_1.time_ <= var_194_8 + arg_194_0 and not isNil(var_194_7) and arg_191_1.var_.actorSpriteComps10022 == nil then
				arg_191_1.var_.actorSpriteComps10022 = var_194_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_9 = 2

			if var_194_8 <= arg_191_1.time_ and arg_191_1.time_ < var_194_8 + var_194_9 and not isNil(var_194_7) then
				local var_194_10 = (arg_191_1.time_ - var_194_8) / var_194_9

				if arg_191_1.var_.actorSpriteComps10022 then
					for iter_194_1, iter_194_2 in pairs(arg_191_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_194_2 then
							if arg_191_1.isInRecall_ then
								local var_194_11 = Mathf.Lerp(iter_194_2.color.r, arg_191_1.hightColor2.r, var_194_10)
								local var_194_12 = Mathf.Lerp(iter_194_2.color.g, arg_191_1.hightColor2.g, var_194_10)
								local var_194_13 = Mathf.Lerp(iter_194_2.color.b, arg_191_1.hightColor2.b, var_194_10)

								iter_194_2.color = Color.New(var_194_11, var_194_12, var_194_13)
							else
								local var_194_14 = Mathf.Lerp(iter_194_2.color.r, 0.5, var_194_10)

								iter_194_2.color = Color.New(var_194_14, var_194_14, var_194_14)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= var_194_8 + var_194_9 and arg_191_1.time_ < var_194_8 + var_194_9 + arg_194_0 and not isNil(var_194_7) and arg_191_1.var_.actorSpriteComps10022 then
				for iter_194_3, iter_194_4 in pairs(arg_191_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_194_4 then
						if arg_191_1.isInRecall_ then
							iter_194_4.color = arg_191_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_194_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_191_1.var_.actorSpriteComps10022 = nil
			end

			local var_194_15 = 0
			local var_194_16 = 0.7

			if var_194_15 < arg_191_1.time_ and arg_191_1.time_ <= var_194_15 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_17 = arg_191_1:GetWordFromCfg(413152044)
				local var_194_18 = arg_191_1:FormatText(var_194_17.content)

				arg_191_1.text_.text = var_194_18

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_19 = 28
				local var_194_20 = utf8.len(var_194_18)
				local var_194_21 = var_194_19 <= 0 and var_194_16 or var_194_16 * (var_194_20 / var_194_19)

				if var_194_21 > 0 and var_194_16 < var_194_21 then
					arg_191_1.talkMaxDuration = var_194_21

					if var_194_21 + var_194_15 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_21 + var_194_15
					end
				end

				arg_191_1.text_.text = var_194_18
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_22 = math.max(var_194_16, arg_191_1.talkMaxDuration)

			if var_194_15 <= arg_191_1.time_ and arg_191_1.time_ < var_194_15 + var_194_22 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_15) / var_194_22

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_15 + var_194_22 and arg_191_1.time_ < var_194_15 + var_194_22 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413152045 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 413152045
		arg_195_1.duration_ = 6

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play413152046(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = manager.ui.mainCamera.transform
			local var_198_1 = 0.333333333333333

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.shakeOldPos = var_198_0.localPosition
			end

			local var_198_2 = 0.5

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / 0.066
				local var_198_4, var_198_5 = math.modf(var_198_3)

				var_198_0.localPosition = Vector3.New(var_198_5 * 0.13, var_198_5 * 0.13, var_198_5 * 0.13) + arg_195_1.var_.shakeOldPos
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 then
				var_198_0.localPosition = arg_195_1.var_.shakeOldPos
			end

			local var_198_6 = 0

			if var_198_6 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.mask_.enabled = true
				arg_195_1.mask_.raycastTarget = false

				arg_195_1:SetGaussion(false)
			end

			local var_198_7 = 0.333333333333333

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_7 then
				local var_198_8 = (arg_195_1.time_ - var_198_6) / var_198_7
				local var_198_9 = Color.New(1, 1, 1)

				var_198_9.a = Mathf.Lerp(1, 0, var_198_8)
				arg_195_1.mask_.color = var_198_9
			end

			if arg_195_1.time_ >= var_198_6 + var_198_7 and arg_195_1.time_ < var_198_6 + var_198_7 + arg_198_0 then
				local var_198_10 = Color.New(1, 1, 1)
				local var_198_11 = 0

				arg_195_1.mask_.enabled = false
				var_198_10.a = var_198_11
				arg_195_1.mask_.color = var_198_10
			end

			local var_198_12 = 0
			local var_198_13 = 1

			if var_198_12 < arg_195_1.time_ and arg_195_1.time_ <= var_198_12 + arg_198_0 then
				local var_198_14 = "play"
				local var_198_15 = "effect"

				arg_195_1:AudioAction(var_198_14, var_198_15, "se_story_122_03", "se_story_122_03_arrow2", "")
			end

			if arg_195_1.frameCnt_ <= 1 then
				arg_195_1.dialog_:SetActive(false)
			end

			local var_198_16 = 1
			local var_198_17 = 0.925

			if var_198_16 < arg_195_1.time_ and arg_195_1.time_ <= var_198_16 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0

				arg_195_1.dialog_:SetActive(true)

				arg_195_1.dialogCg_.alpha = 0

				local var_198_18 = LeanTween.value(arg_195_1.dialog_, 0, 1, 0.3)

				var_198_18:setOnUpdate(LuaHelper.FloatAction(function(arg_199_0)
					arg_195_1.dialogCg_.alpha = arg_199_0
				end))
				var_198_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_195_1.dialog_)
					var_198_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_195_1.duration_ = arg_195_1.duration_ + 0.3

				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_19 = arg_195_1:GetWordFromCfg(413152045)
				local var_198_20 = arg_195_1:FormatText(var_198_19.content)

				arg_195_1.text_.text = var_198_20

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_21 = 37
				local var_198_22 = utf8.len(var_198_20)
				local var_198_23 = var_198_21 <= 0 and var_198_17 or var_198_17 * (var_198_22 / var_198_21)

				if var_198_23 > 0 and var_198_17 < var_198_23 then
					arg_195_1.talkMaxDuration = var_198_23
					var_198_16 = var_198_16 + 0.3

					if var_198_23 + var_198_16 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_23 + var_198_16
					end
				end

				arg_195_1.text_.text = var_198_20
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_24 = var_198_16 + 0.3
			local var_198_25 = math.max(var_198_17, arg_195_1.talkMaxDuration)

			if var_198_24 <= arg_195_1.time_ and arg_195_1.time_ < var_198_24 + var_198_25 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_24) / var_198_25

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_24 + var_198_25 and arg_195_1.time_ < var_198_24 + var_198_25 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play413152046 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 413152046
		arg_201_1.duration_ = 3.8

		local var_201_0 = {
			zh = 3.8,
			ja = 2.5
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play413152047(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.475

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[28].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10093_split_3")

				arg_201_1.callingController_:SetSelectedState("calling")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:GetWordFromCfg(413152046)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 19
				local var_204_6 = utf8.len(var_204_4)
				local var_204_7 = var_204_5 <= 0 and var_204_1 or var_204_1 * (var_204_6 / var_204_5)

				if var_204_7 > 0 and var_204_1 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_4
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152046", "story_v_out_413152.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152046", "story_v_out_413152.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_413152", "413152046", "story_v_out_413152.awb")

						arg_201_1:RecordAudio("413152046", var_204_9)
						arg_201_1:RecordAudio("413152046", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_413152", "413152046", "story_v_out_413152.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_413152", "413152046", "story_v_out_413152.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_10 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_10 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_10

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_10 and arg_201_1.time_ < var_204_0 + var_204_10 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play413152047 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 413152047
		arg_205_1.duration_ = 2.7

		local var_205_0 = {
			zh = 2.7,
			ja = 1.933
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play413152048(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.3

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_2 = arg_205_1:FormatText(StoryNameCfg[28].name)

				arg_205_1.leftNameTxt_.text = var_208_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10093_split_1")

				arg_205_1.callingController_:SetSelectedState("calling")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_3 = arg_205_1:GetWordFromCfg(413152047)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 12
				local var_208_6 = utf8.len(var_208_4)
				local var_208_7 = var_208_5 <= 0 and var_208_1 or var_208_1 * (var_208_6 / var_208_5)

				if var_208_7 > 0 and var_208_1 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_4
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152047", "story_v_out_413152.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152047", "story_v_out_413152.awb") / 1000

					if var_208_8 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_0
					end

					if var_208_3.prefab_name ~= "" and arg_205_1.actors_[var_208_3.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_3.prefab_name].transform, "story_v_out_413152", "413152047", "story_v_out_413152.awb")

						arg_205_1:RecordAudio("413152047", var_208_9)
						arg_205_1:RecordAudio("413152047", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_413152", "413152047", "story_v_out_413152.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_413152", "413152047", "story_v_out_413152.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_10 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_10 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_10

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_10 and arg_205_1.time_ < var_208_0 + var_208_10 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play413152048 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 413152048
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play413152049(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["10093"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos10093 = var_212_0.localPosition
				var_212_0.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10093", 6)

				local var_212_2 = var_212_0.childCount

				for iter_212_0 = 0, var_212_2 - 1 do
					local var_212_3 = var_212_0:GetChild(iter_212_0)

					if var_212_3.name == "" or not string.find(var_212_3.name, "split") then
						var_212_3.gameObject:SetActive(true)
					else
						var_212_3.gameObject:SetActive(false)
					end
				end
			end

			local var_212_4 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_4 then
				local var_212_5 = (arg_209_1.time_ - var_212_1) / var_212_4
				local var_212_6 = Vector3.New(1500, -345, -245)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10093, var_212_6, var_212_5)
			end

			if arg_209_1.time_ >= var_212_1 + var_212_4 and arg_209_1.time_ < var_212_1 + var_212_4 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_212_7 = 0
			local var_212_8 = 0.975

			if var_212_7 < arg_209_1.time_ and arg_209_1.time_ <= var_212_7 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_9 = arg_209_1:GetWordFromCfg(413152048)
				local var_212_10 = arg_209_1:FormatText(var_212_9.content)

				arg_209_1.text_.text = var_212_10

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_11 = 39
				local var_212_12 = utf8.len(var_212_10)
				local var_212_13 = var_212_11 <= 0 and var_212_8 or var_212_8 * (var_212_12 / var_212_11)

				if var_212_13 > 0 and var_212_8 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_7 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_7
					end
				end

				arg_209_1.text_.text = var_212_10
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_14 = math.max(var_212_8, arg_209_1.talkMaxDuration)

			if var_212_7 <= arg_209_1.time_ and arg_209_1.time_ < var_212_7 + var_212_14 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_7) / var_212_14

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_7 + var_212_14 and arg_209_1.time_ < var_212_7 + var_212_14 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play413152049 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 413152049
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play413152050(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.975

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_2 = arg_213_1:GetWordFromCfg(413152049)
				local var_216_3 = arg_213_1:FormatText(var_216_2.content)

				arg_213_1.text_.text = var_216_3

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 39
				local var_216_5 = utf8.len(var_216_3)
				local var_216_6 = var_216_4 <= 0 and var_216_1 or var_216_1 * (var_216_5 / var_216_4)

				if var_216_6 > 0 and var_216_1 < var_216_6 then
					arg_213_1.talkMaxDuration = var_216_6

					if var_216_6 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_6 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_3
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_7 and arg_213_1.time_ < var_216_0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play413152050 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 413152050
		arg_217_1.duration_ = 7.7

		local var_217_0 = {
			zh = 7.7,
			ja = 6.516666666666
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play413152051(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = "SS1310"

			if arg_217_1.bgs_[var_220_0] == nil then
				local var_220_1 = Object.Instantiate(arg_217_1.paintGo_)

				var_220_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_220_0)
				var_220_1.name = var_220_0
				var_220_1.transform.parent = arg_217_1.stage_.transform
				var_220_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_217_1.bgs_[var_220_0] = var_220_1
			end

			local var_220_2 = 1.96666666666667

			if var_220_2 < arg_217_1.time_ and arg_217_1.time_ <= var_220_2 + arg_220_0 then
				local var_220_3 = manager.ui.mainCamera.transform.localPosition
				local var_220_4 = Vector3.New(0, 0, 10) + Vector3.New(var_220_3.x, var_220_3.y, 0)
				local var_220_5 = arg_217_1.bgs_.SS1310

				var_220_5.transform.localPosition = var_220_4
				var_220_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_220_6 = var_220_5:GetComponent("SpriteRenderer")

				if var_220_6 and var_220_6.sprite then
					local var_220_7 = (var_220_5.transform.localPosition - var_220_3).z
					local var_220_8 = manager.ui.mainCameraCom_
					local var_220_9 = 2 * var_220_7 * Mathf.Tan(var_220_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_220_10 = var_220_9 * var_220_8.aspect
					local var_220_11 = var_220_6.sprite.bounds.size.x
					local var_220_12 = var_220_6.sprite.bounds.size.y
					local var_220_13 = var_220_10 / var_220_11
					local var_220_14 = var_220_9 / var_220_12
					local var_220_15 = var_220_14 < var_220_13 and var_220_13 or var_220_14

					var_220_5.transform.localScale = Vector3.New(var_220_15, var_220_15, 0)
				end

				for iter_220_0, iter_220_1 in pairs(arg_217_1.bgs_) do
					if iter_220_0 ~= "SS1310" then
						iter_220_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_220_16 = 4

			if var_220_16 < arg_217_1.time_ and arg_217_1.time_ <= var_220_16 + arg_220_0 then
				arg_217_1.allBtn_.enabled = false
			end

			local var_220_17 = 0.3

			if arg_217_1.time_ >= var_220_16 + var_220_17 and arg_217_1.time_ < var_220_16 + var_220_17 + arg_220_0 then
				arg_217_1.allBtn_.enabled = true
			end

			local var_220_18 = 0

			if var_220_18 < arg_217_1.time_ and arg_217_1.time_ <= var_220_18 + arg_220_0 then
				arg_217_1.mask_.enabled = true
				arg_217_1.mask_.raycastTarget = true

				arg_217_1:SetGaussion(false)
			end

			local var_220_19 = 2

			if var_220_18 <= arg_217_1.time_ and arg_217_1.time_ < var_220_18 + var_220_19 then
				local var_220_20 = (arg_217_1.time_ - var_220_18) / var_220_19
				local var_220_21 = Color.New(0, 0, 0)

				var_220_21.a = Mathf.Lerp(0, 1, var_220_20)
				arg_217_1.mask_.color = var_220_21
			end

			if arg_217_1.time_ >= var_220_18 + var_220_19 and arg_217_1.time_ < var_220_18 + var_220_19 + arg_220_0 then
				local var_220_22 = Color.New(0, 0, 0)

				var_220_22.a = 1
				arg_217_1.mask_.color = var_220_22
			end

			local var_220_23 = 2

			if var_220_23 < arg_217_1.time_ and arg_217_1.time_ <= var_220_23 + arg_220_0 then
				arg_217_1.mask_.enabled = true
				arg_217_1.mask_.raycastTarget = true

				arg_217_1:SetGaussion(false)
			end

			local var_220_24 = 2

			if var_220_23 <= arg_217_1.time_ and arg_217_1.time_ < var_220_23 + var_220_24 then
				local var_220_25 = (arg_217_1.time_ - var_220_23) / var_220_24
				local var_220_26 = Color.New(0, 0, 0)

				var_220_26.a = Mathf.Lerp(1, 0, var_220_25)
				arg_217_1.mask_.color = var_220_26
			end

			if arg_217_1.time_ >= var_220_23 + var_220_24 and arg_217_1.time_ < var_220_23 + var_220_24 + arg_220_0 then
				local var_220_27 = Color.New(0, 0, 0)
				local var_220_28 = 0

				arg_217_1.mask_.enabled = false
				var_220_27.a = var_220_28
				arg_217_1.mask_.color = var_220_27
			end

			local var_220_29 = arg_217_1.bgs_.SS1310.transform
			local var_220_30 = 2

			if var_220_30 < arg_217_1.time_ and arg_217_1.time_ <= var_220_30 + arg_220_0 then
				arg_217_1.var_.moveOldPosSS1310 = var_220_29.localPosition
			end

			local var_220_31 = 0.001

			if var_220_30 <= arg_217_1.time_ and arg_217_1.time_ < var_220_30 + var_220_31 then
				local var_220_32 = (arg_217_1.time_ - var_220_30) / var_220_31
				local var_220_33 = Vector3.New(0, 1, 9.5)

				var_220_29.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPosSS1310, var_220_33, var_220_32)
			end

			if arg_217_1.time_ >= var_220_30 + var_220_31 and arg_217_1.time_ < var_220_30 + var_220_31 + arg_220_0 then
				var_220_29.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_220_34 = arg_217_1.bgs_.SS1310.transform
			local var_220_35 = 2.01666666666667

			if var_220_35 < arg_217_1.time_ and arg_217_1.time_ <= var_220_35 + arg_220_0 then
				arg_217_1.var_.moveOldPosSS1310 = var_220_34.localPosition
			end

			local var_220_36 = 4.5

			if var_220_35 <= arg_217_1.time_ and arg_217_1.time_ < var_220_35 + var_220_36 then
				local var_220_37 = (arg_217_1.time_ - var_220_35) / var_220_36
				local var_220_38 = Vector3.New(0, 1, 10)

				var_220_34.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPosSS1310, var_220_38, var_220_37)
			end

			if arg_217_1.time_ >= var_220_35 + var_220_36 and arg_217_1.time_ < var_220_35 + var_220_36 + arg_220_0 then
				var_220_34.localPosition = Vector3.New(0, 1, 10)
			end

			local var_220_39 = 4

			if var_220_39 < arg_217_1.time_ and arg_217_1.time_ <= var_220_39 + arg_220_0 then
				arg_217_1.allBtn_.enabled = false
			end

			local var_220_40 = 2.51666666666667

			if arg_217_1.time_ >= var_220_39 + var_220_40 and arg_217_1.time_ < var_220_39 + var_220_40 + arg_220_0 then
				arg_217_1.allBtn_.enabled = true
			end

			if arg_217_1.frameCnt_ <= 1 then
				arg_217_1.dialog_:SetActive(false)
			end

			local var_220_41 = 4
			local var_220_42 = 0.35

			if var_220_41 < arg_217_1.time_ and arg_217_1.time_ <= var_220_41 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0

				arg_217_1.dialog_:SetActive(true)

				arg_217_1.dialogCg_.alpha = 0

				local var_220_43 = LeanTween.value(arg_217_1.dialog_, 0, 1, 0.3)

				var_220_43:setOnUpdate(LuaHelper.FloatAction(function(arg_221_0)
					arg_217_1.dialogCg_.alpha = arg_221_0
				end))
				var_220_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_217_1.dialog_)
					var_220_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_217_1.duration_ = arg_217_1.duration_ + 0.3

				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_44 = arg_217_1:FormatText(StoryNameCfg[28].name)

				arg_217_1.leftNameTxt_.text = var_220_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_45 = arg_217_1:GetWordFromCfg(413152050)
				local var_220_46 = arg_217_1:FormatText(var_220_45.content)

				arg_217_1.text_.text = var_220_46

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_47 = 14
				local var_220_48 = utf8.len(var_220_46)
				local var_220_49 = var_220_47 <= 0 and var_220_42 or var_220_42 * (var_220_48 / var_220_47)

				if var_220_49 > 0 and var_220_42 < var_220_49 then
					arg_217_1.talkMaxDuration = var_220_49
					var_220_41 = var_220_41 + 0.3

					if var_220_49 + var_220_41 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_49 + var_220_41
					end
				end

				arg_217_1.text_.text = var_220_46
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152050", "story_v_out_413152.awb") ~= 0 then
					local var_220_50 = manager.audio:GetVoiceLength("story_v_out_413152", "413152050", "story_v_out_413152.awb") / 1000

					if var_220_50 + var_220_41 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_50 + var_220_41
					end

					if var_220_45.prefab_name ~= "" and arg_217_1.actors_[var_220_45.prefab_name] ~= nil then
						local var_220_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_45.prefab_name].transform, "story_v_out_413152", "413152050", "story_v_out_413152.awb")

						arg_217_1:RecordAudio("413152050", var_220_51)
						arg_217_1:RecordAudio("413152050", var_220_51)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_413152", "413152050", "story_v_out_413152.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_413152", "413152050", "story_v_out_413152.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_52 = var_220_41 + 0.3
			local var_220_53 = math.max(var_220_42, arg_217_1.talkMaxDuration)

			if var_220_52 <= arg_217_1.time_ and arg_217_1.time_ < var_220_52 + var_220_53 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_52) / var_220_53

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_52 + var_220_53 and arg_217_1.time_ < var_220_52 + var_220_53 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1310",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1310",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play413152051 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 413152051
		arg_223_1.duration_ = 3.47

		local var_223_0 = {
			zh = 3.466,
			ja = 3.3
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
				arg_223_0:Play413152052(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 0.425

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_2 = arg_223_1:FormatText(StoryNameCfg[614].name)

				arg_223_1.leftNameTxt_.text = var_226_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_3 = arg_223_1:GetWordFromCfg(413152051)
				local var_226_4 = arg_223_1:FormatText(var_226_3.content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 17
				local var_226_6 = utf8.len(var_226_4)
				local var_226_7 = var_226_5 <= 0 and var_226_1 or var_226_1 * (var_226_6 / var_226_5)

				if var_226_7 > 0 and var_226_1 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_4
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152051", "story_v_out_413152.awb") ~= 0 then
					local var_226_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152051", "story_v_out_413152.awb") / 1000

					if var_226_8 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_8 + var_226_0
					end

					if var_226_3.prefab_name ~= "" and arg_223_1.actors_[var_226_3.prefab_name] ~= nil then
						local var_226_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_3.prefab_name].transform, "story_v_out_413152", "413152051", "story_v_out_413152.awb")

						arg_223_1:RecordAudio("413152051", var_226_9)
						arg_223_1:RecordAudio("413152051", var_226_9)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_413152", "413152051", "story_v_out_413152.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_413152", "413152051", "story_v_out_413152.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_10 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_10 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_10

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_10 and arg_223_1.time_ < var_226_0 + var_226_10 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play413152052 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 413152052
		arg_227_1.duration_ = 8

		local var_227_0 = {
			zh = 4.2,
			ja = 8
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
				arg_227_0:Play413152053(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 0.525

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_2 = arg_227_1:FormatText(StoryNameCfg[614].name)

				arg_227_1.leftNameTxt_.text = var_230_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_3 = arg_227_1:GetWordFromCfg(413152052)
				local var_230_4 = arg_227_1:FormatText(var_230_3.content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 21
				local var_230_6 = utf8.len(var_230_4)
				local var_230_7 = var_230_5 <= 0 and var_230_1 or var_230_1 * (var_230_6 / var_230_5)

				if var_230_7 > 0 and var_230_1 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_4
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152052", "story_v_out_413152.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152052", "story_v_out_413152.awb") / 1000

					if var_230_8 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_0
					end

					if var_230_3.prefab_name ~= "" and arg_227_1.actors_[var_230_3.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_3.prefab_name].transform, "story_v_out_413152", "413152052", "story_v_out_413152.awb")

						arg_227_1:RecordAudio("413152052", var_230_9)
						arg_227_1:RecordAudio("413152052", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_413152", "413152052", "story_v_out_413152.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_413152", "413152052", "story_v_out_413152.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_10 and arg_227_1.time_ < var_230_0 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play413152053 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 413152053
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play413152054(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 1.3

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_2 = arg_231_1:GetWordFromCfg(413152053)
				local var_234_3 = arg_231_1:FormatText(var_234_2.content)

				arg_231_1.text_.text = var_234_3

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_4 = 52
				local var_234_5 = utf8.len(var_234_3)
				local var_234_6 = var_234_4 <= 0 and var_234_1 or var_234_1 * (var_234_5 / var_234_4)

				if var_234_6 > 0 and var_234_1 < var_234_6 then
					arg_231_1.talkMaxDuration = var_234_6

					if var_234_6 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_6 + var_234_0
					end
				end

				arg_231_1.text_.text = var_234_3
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_7 = math.max(var_234_1, arg_231_1.talkMaxDuration)

			if var_234_0 <= arg_231_1.time_ and arg_231_1.time_ < var_234_0 + var_234_7 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_0) / var_234_7

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_0 + var_234_7 and arg_231_1.time_ < var_234_0 + var_234_7 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play413152054 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 413152054
		arg_235_1.duration_ = 3.97

		local var_235_0 = {
			zh = 3.666,
			ja = 3.966
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
				arg_235_0:Play413152055(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0
			local var_238_1 = 0.433333333333333

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				local var_238_2 = "play"
				local var_238_3 = "music"

				arg_235_1:AudioAction(var_238_2, var_238_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_238_4 = ""
				local var_238_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_238_5 ~= "" then
					if arg_235_1.bgmTxt_.text ~= var_238_5 and arg_235_1.bgmTxt_.text ~= "" then
						if arg_235_1.bgmTxt2_.text ~= "" then
							arg_235_1.bgmTxt_.text = arg_235_1.bgmTxt2_.text
						end

						arg_235_1.bgmTxt2_.text = var_238_5

						arg_235_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_235_1.bgmTxt_.text = var_238_5
						arg_235_1.bgmTxt2_.text = var_238_5
					end

					if arg_235_1.bgmTimer then
						arg_235_1.bgmTimer:Stop()

						arg_235_1.bgmTimer = nil
					end

					if arg_235_1.settingData.show_music_name == 1 then
						arg_235_1.musicController:SetSelectedState("show")
						arg_235_1.musicAnimator_:Play("open", 0, 0)

						if arg_235_1.settingData.music_time ~= 0 then
							arg_235_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_235_1.settingData.music_time), function()
								if arg_235_1 == nil or isNil(arg_235_1.bgmTxt_) then
									return
								end

								arg_235_1.musicController:SetSelectedState("hide")
								arg_235_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_238_6 = 0
			local var_238_7 = 0.325

			if var_238_6 < arg_235_1.time_ and arg_235_1.time_ <= var_238_6 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_8 = arg_235_1:FormatText(StoryNameCfg[614].name)

				arg_235_1.leftNameTxt_.text = var_238_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_9 = arg_235_1:GetWordFromCfg(413152054)
				local var_238_10 = arg_235_1:FormatText(var_238_9.content)

				arg_235_1.text_.text = var_238_10

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_11 = 13
				local var_238_12 = utf8.len(var_238_10)
				local var_238_13 = var_238_11 <= 0 and var_238_7 or var_238_7 * (var_238_12 / var_238_11)

				if var_238_13 > 0 and var_238_7 < var_238_13 then
					arg_235_1.talkMaxDuration = var_238_13

					if var_238_13 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_13 + var_238_6
					end
				end

				arg_235_1.text_.text = var_238_10
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152054", "story_v_out_413152.awb") ~= 0 then
					local var_238_14 = manager.audio:GetVoiceLength("story_v_out_413152", "413152054", "story_v_out_413152.awb") / 1000

					if var_238_14 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_14 + var_238_6
					end

					if var_238_9.prefab_name ~= "" and arg_235_1.actors_[var_238_9.prefab_name] ~= nil then
						local var_238_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_9.prefab_name].transform, "story_v_out_413152", "413152054", "story_v_out_413152.awb")

						arg_235_1:RecordAudio("413152054", var_238_15)
						arg_235_1:RecordAudio("413152054", var_238_15)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_413152", "413152054", "story_v_out_413152.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_413152", "413152054", "story_v_out_413152.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_16 = math.max(var_238_7, arg_235_1.talkMaxDuration)

			if var_238_6 <= arg_235_1.time_ and arg_235_1.time_ < var_238_6 + var_238_16 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_6) / var_238_16

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_6 + var_238_16 and arg_235_1.time_ < var_238_6 + var_238_16 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play413152055 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 413152055
		arg_240_1.duration_ = 6.87

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play413152056(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.bgs_.SS1310.transform
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1.var_.moveOldPosSS1310 = var_243_0.localPosition
			end

			local var_243_2 = 0.001

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2
				local var_243_4 = Vector3.New(0, 1, 10)

				var_243_0.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPosSS1310, var_243_4, var_243_3)
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 then
				var_243_0.localPosition = Vector3.New(0, 1, 10)
			end

			local var_243_5 = arg_240_1.bgs_.SS1310.transform
			local var_243_6 = 0.034

			if var_243_6 < arg_240_1.time_ and arg_240_1.time_ <= var_243_6 + arg_243_0 then
				arg_240_1.var_.moveOldPosSS1310 = var_243_5.localPosition
			end

			local var_243_7 = 3.566

			if var_243_6 <= arg_240_1.time_ and arg_240_1.time_ < var_243_6 + var_243_7 then
				local var_243_8 = (arg_240_1.time_ - var_243_6) / var_243_7
				local var_243_9 = Vector3.New(0, 1, 9)

				var_243_5.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPosSS1310, var_243_9, var_243_8)
			end

			if arg_240_1.time_ >= var_243_6 + var_243_7 and arg_240_1.time_ < var_243_6 + var_243_7 + arg_243_0 then
				var_243_5.localPosition = Vector3.New(0, 1, 9)
			end

			local var_243_10 = 0

			if var_243_10 < arg_240_1.time_ and arg_240_1.time_ <= var_243_10 + arg_243_0 then
				arg_240_1.mask_.enabled = true
				arg_240_1.mask_.raycastTarget = true

				arg_240_1:SetGaussion(false)
			end

			local var_243_11 = 1

			if var_243_10 <= arg_240_1.time_ and arg_240_1.time_ < var_243_10 + var_243_11 then
				local var_243_12 = (arg_240_1.time_ - var_243_10) / var_243_11
				local var_243_13 = Color.New(1, 1, 1)

				var_243_13.a = Mathf.Lerp(1, 0, var_243_12)
				arg_240_1.mask_.color = var_243_13
			end

			if arg_240_1.time_ >= var_243_10 + var_243_11 and arg_240_1.time_ < var_243_10 + var_243_11 + arg_243_0 then
				local var_243_14 = Color.New(1, 1, 1)
				local var_243_15 = 0

				arg_240_1.mask_.enabled = false
				var_243_14.a = var_243_15
				arg_240_1.mask_.color = var_243_14
			end

			local var_243_16 = 1

			if var_243_16 < arg_240_1.time_ and arg_240_1.time_ <= var_243_16 + arg_243_0 then
				arg_240_1.allBtn_.enabled = false
			end

			local var_243_17 = 2.6

			if arg_240_1.time_ >= var_243_16 + var_243_17 and arg_240_1.time_ < var_243_16 + var_243_17 + arg_243_0 then
				arg_240_1.allBtn_.enabled = true
			end

			local var_243_18 = 0.266666666666667
			local var_243_19 = 1

			if var_243_18 < arg_240_1.time_ and arg_240_1.time_ <= var_243_18 + arg_243_0 then
				local var_243_20 = "play"
				local var_243_21 = "effect"

				arg_240_1:AudioAction(var_243_20, var_243_21, "se_story_122_03", "se_story_122_03_swordlight", "")
			end

			local var_243_22 = 0.8
			local var_243_23 = 1

			if var_243_22 < arg_240_1.time_ and arg_240_1.time_ <= var_243_22 + arg_243_0 then
				local var_243_24 = "play"
				local var_243_25 = "effect"

				arg_240_1:AudioAction(var_243_24, var_243_25, "se_story_123_01", "se_story_123_01_crake", "")
			end

			local var_243_26 = 0.866666666666667
			local var_243_27 = 1

			if var_243_26 < arg_240_1.time_ and arg_240_1.time_ <= var_243_26 + arg_243_0 then
				local var_243_28 = "play"
				local var_243_29 = "effect"

				arg_240_1:AudioAction(var_243_28, var_243_29, "se_story_123_01", "se_story_123_01_statue", "")
			end

			if arg_240_1.frameCnt_ <= 1 then
				arg_240_1.dialog_:SetActive(false)
			end

			local var_243_30 = 1.86666666666667
			local var_243_31 = 1.375

			if var_243_30 < arg_240_1.time_ and arg_240_1.time_ <= var_243_30 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0

				arg_240_1.dialog_:SetActive(true)

				arg_240_1.dialogCg_.alpha = 0

				local var_243_32 = LeanTween.value(arg_240_1.dialog_, 0, 1, 0.3)

				var_243_32:setOnUpdate(LuaHelper.FloatAction(function(arg_244_0)
					arg_240_1.dialogCg_.alpha = arg_244_0
				end))
				var_243_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_240_1.dialog_)
					var_243_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_240_1.duration_ = arg_240_1.duration_ + 0.3

				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_33 = arg_240_1:GetWordFromCfg(413152055)
				local var_243_34 = arg_240_1:FormatText(var_243_33.content)

				arg_240_1.text_.text = var_243_34

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_35 = 55
				local var_243_36 = utf8.len(var_243_34)
				local var_243_37 = var_243_35 <= 0 and var_243_31 or var_243_31 * (var_243_36 / var_243_35)

				if var_243_37 > 0 and var_243_31 < var_243_37 then
					arg_240_1.talkMaxDuration = var_243_37
					var_243_30 = var_243_30 + 0.3

					if var_243_37 + var_243_30 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_37 + var_243_30
					end
				end

				arg_240_1.text_.text = var_243_34
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_38 = var_243_30 + 0.3
			local var_243_39 = math.max(var_243_31, arg_240_1.talkMaxDuration)

			if var_243_38 <= arg_240_1.time_ and arg_240_1.time_ < var_243_38 + var_243_39 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_38) / var_243_39

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_38 + var_243_39 and arg_240_1.time_ < var_243_38 + var_243_39 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1310",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1310",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.566,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play413152056 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 413152056
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play413152057(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0
			local var_249_1 = 0.975

			if var_249_0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_2 = arg_246_1:GetWordFromCfg(413152056)
				local var_249_3 = arg_246_1:FormatText(var_249_2.content)

				arg_246_1.text_.text = var_249_3

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_4 = 39
				local var_249_5 = utf8.len(var_249_3)
				local var_249_6 = var_249_4 <= 0 and var_249_1 or var_249_1 * (var_249_5 / var_249_4)

				if var_249_6 > 0 and var_249_1 < var_249_6 then
					arg_246_1.talkMaxDuration = var_249_6

					if var_249_6 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_6 + var_249_0
					end
				end

				arg_246_1.text_.text = var_249_3
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_7 = math.max(var_249_1, arg_246_1.talkMaxDuration)

			if var_249_0 <= arg_246_1.time_ and arg_246_1.time_ < var_249_0 + var_249_7 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_0) / var_249_7

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_0 + var_249_7 and arg_246_1.time_ < var_249_0 + var_249_7 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play413152057 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 413152057
		arg_250_1.duration_ = 11

		local var_250_0 = {
			zh = 7.866,
			ja = 11
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play413152058(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 2

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				local var_253_1 = manager.ui.mainCamera.transform.localPosition
				local var_253_2 = Vector3.New(0, 0, 10) + Vector3.New(var_253_1.x, var_253_1.y, 0)
				local var_253_3 = arg_250_1.bgs_.F10g

				var_253_3.transform.localPosition = var_253_2
				var_253_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_253_4 = var_253_3:GetComponent("SpriteRenderer")

				if var_253_4 and var_253_4.sprite then
					local var_253_5 = (var_253_3.transform.localPosition - var_253_1).z
					local var_253_6 = manager.ui.mainCameraCom_
					local var_253_7 = 2 * var_253_5 * Mathf.Tan(var_253_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_253_8 = var_253_7 * var_253_6.aspect
					local var_253_9 = var_253_4.sprite.bounds.size.x
					local var_253_10 = var_253_4.sprite.bounds.size.y
					local var_253_11 = var_253_8 / var_253_9
					local var_253_12 = var_253_7 / var_253_10
					local var_253_13 = var_253_12 < var_253_11 and var_253_11 or var_253_12

					var_253_3.transform.localScale = Vector3.New(var_253_13, var_253_13, 0)
				end

				for iter_253_0, iter_253_1 in pairs(arg_250_1.bgs_) do
					if iter_253_0 ~= "F10g" then
						iter_253_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_253_14 = 0

			if var_253_14 < arg_250_1.time_ and arg_250_1.time_ <= var_253_14 + arg_253_0 then
				arg_250_1.mask_.enabled = true
				arg_250_1.mask_.raycastTarget = true

				arg_250_1:SetGaussion(false)
			end

			local var_253_15 = 2

			if var_253_14 <= arg_250_1.time_ and arg_250_1.time_ < var_253_14 + var_253_15 then
				local var_253_16 = (arg_250_1.time_ - var_253_14) / var_253_15
				local var_253_17 = Color.New(0, 0, 0)

				var_253_17.a = Mathf.Lerp(0, 1, var_253_16)
				arg_250_1.mask_.color = var_253_17
			end

			if arg_250_1.time_ >= var_253_14 + var_253_15 and arg_250_1.time_ < var_253_14 + var_253_15 + arg_253_0 then
				local var_253_18 = Color.New(0, 0, 0)

				var_253_18.a = 1
				arg_250_1.mask_.color = var_253_18
			end

			local var_253_19 = 2

			if var_253_19 < arg_250_1.time_ and arg_250_1.time_ <= var_253_19 + arg_253_0 then
				arg_250_1.mask_.enabled = true
				arg_250_1.mask_.raycastTarget = true

				arg_250_1:SetGaussion(false)
			end

			local var_253_20 = 2

			if var_253_19 <= arg_250_1.time_ and arg_250_1.time_ < var_253_19 + var_253_20 then
				local var_253_21 = (arg_250_1.time_ - var_253_19) / var_253_20
				local var_253_22 = Color.New(0, 0, 0)

				var_253_22.a = Mathf.Lerp(1, 0, var_253_21)
				arg_250_1.mask_.color = var_253_22
			end

			if arg_250_1.time_ >= var_253_19 + var_253_20 and arg_250_1.time_ < var_253_19 + var_253_20 + arg_253_0 then
				local var_253_23 = Color.New(0, 0, 0)
				local var_253_24 = 0

				arg_250_1.mask_.enabled = false
				var_253_23.a = var_253_24
				arg_250_1.mask_.color = var_253_23
			end

			local var_253_25 = 0
			local var_253_26 = 0.433333333333333

			if var_253_25 < arg_250_1.time_ and arg_250_1.time_ <= var_253_25 + arg_253_0 then
				local var_253_27 = "play"
				local var_253_28 = "music"

				arg_250_1:AudioAction(var_253_27, var_253_28, "ui_battle", "ui_battle_stopbgm", "")

				local var_253_29 = ""
				local var_253_30 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_253_30 ~= "" then
					if arg_250_1.bgmTxt_.text ~= var_253_30 and arg_250_1.bgmTxt_.text ~= "" then
						if arg_250_1.bgmTxt2_.text ~= "" then
							arg_250_1.bgmTxt_.text = arg_250_1.bgmTxt2_.text
						end

						arg_250_1.bgmTxt2_.text = var_253_30

						arg_250_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_250_1.bgmTxt_.text = var_253_30
						arg_250_1.bgmTxt2_.text = var_253_30
					end

					if arg_250_1.bgmTimer then
						arg_250_1.bgmTimer:Stop()

						arg_250_1.bgmTimer = nil
					end

					if arg_250_1.settingData.show_music_name == 1 then
						arg_250_1.musicController:SetSelectedState("show")
						arg_250_1.musicAnimator_:Play("open", 0, 0)

						if arg_250_1.settingData.music_time ~= 0 then
							arg_250_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_250_1.settingData.music_time), function()
								if arg_250_1 == nil or isNil(arg_250_1.bgmTxt_) then
									return
								end

								arg_250_1.musicController:SetSelectedState("hide")
								arg_250_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_253_31 = 1.26666666666667
			local var_253_32 = 1

			if var_253_31 < arg_250_1.time_ and arg_250_1.time_ <= var_253_31 + arg_253_0 then
				local var_253_33 = "play"
				local var_253_34 = "music"

				arg_250_1:AudioAction(var_253_33, var_253_34, "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_253_35 = ""
				local var_253_36 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if var_253_36 ~= "" then
					if arg_250_1.bgmTxt_.text ~= var_253_36 and arg_250_1.bgmTxt_.text ~= "" then
						if arg_250_1.bgmTxt2_.text ~= "" then
							arg_250_1.bgmTxt_.text = arg_250_1.bgmTxt2_.text
						end

						arg_250_1.bgmTxt2_.text = var_253_36

						arg_250_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_250_1.bgmTxt_.text = var_253_36
						arg_250_1.bgmTxt2_.text = var_253_36
					end

					if arg_250_1.bgmTimer then
						arg_250_1.bgmTimer:Stop()

						arg_250_1.bgmTimer = nil
					end

					if arg_250_1.settingData.show_music_name == 1 then
						arg_250_1.musicController:SetSelectedState("show")
						arg_250_1.musicAnimator_:Play("open", 0, 0)

						if arg_250_1.settingData.music_time ~= 0 then
							arg_250_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_250_1.settingData.music_time), function()
								if arg_250_1 == nil or isNil(arg_250_1.bgmTxt_) then
									return
								end

								arg_250_1.musicController:SetSelectedState("hide")
								arg_250_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_250_1.frameCnt_ <= 1 then
				arg_250_1.dialog_:SetActive(false)
			end

			local var_253_37 = 4
			local var_253_38 = 0.525

			if var_253_37 < arg_250_1.time_ and arg_250_1.time_ <= var_253_37 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0

				arg_250_1.dialog_:SetActive(true)

				arg_250_1.dialogCg_.alpha = 0

				local var_253_39 = LeanTween.value(arg_250_1.dialog_, 0, 1, 0.3)

				var_253_39:setOnUpdate(LuaHelper.FloatAction(function(arg_256_0)
					arg_250_1.dialogCg_.alpha = arg_256_0
				end))
				var_253_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_250_1.dialog_)
					var_253_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_250_1.duration_ = arg_250_1.duration_ + 0.3

				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_40 = arg_250_1:FormatText(StoryNameCfg[998].name)

				arg_250_1.leftNameTxt_.text = var_253_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_41 = arg_250_1:GetWordFromCfg(413152057)
				local var_253_42 = arg_250_1:FormatText(var_253_41.content)

				arg_250_1.text_.text = var_253_42

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_43 = 19
				local var_253_44 = utf8.len(var_253_42)
				local var_253_45 = var_253_43 <= 0 and var_253_38 or var_253_38 * (var_253_44 / var_253_43)

				if var_253_45 > 0 and var_253_38 < var_253_45 then
					arg_250_1.talkMaxDuration = var_253_45
					var_253_37 = var_253_37 + 0.3

					if var_253_45 + var_253_37 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_45 + var_253_37
					end
				end

				arg_250_1.text_.text = var_253_42
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152057", "story_v_out_413152.awb") ~= 0 then
					local var_253_46 = manager.audio:GetVoiceLength("story_v_out_413152", "413152057", "story_v_out_413152.awb") / 1000

					if var_253_46 + var_253_37 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_46 + var_253_37
					end

					if var_253_41.prefab_name ~= "" and arg_250_1.actors_[var_253_41.prefab_name] ~= nil then
						local var_253_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_41.prefab_name].transform, "story_v_out_413152", "413152057", "story_v_out_413152.awb")

						arg_250_1:RecordAudio("413152057", var_253_47)
						arg_250_1:RecordAudio("413152057", var_253_47)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_413152", "413152057", "story_v_out_413152.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_413152", "413152057", "story_v_out_413152.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_48 = var_253_37 + 0.3
			local var_253_49 = math.max(var_253_38, arg_250_1.talkMaxDuration)

			if var_253_48 <= arg_250_1.time_ and arg_250_1.time_ < var_253_48 + var_253_49 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_48) / var_253_49

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_48 + var_253_49 and arg_250_1.time_ < var_253_48 + var_253_49 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play413152058 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 413152058
		arg_258_1.duration_ = 4.47

		local var_258_0 = {
			zh = 3.766,
			ja = 4.466
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
				arg_258_0:Play413152059(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0
			local var_261_1 = 0.375

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_2 = arg_258_1:FormatText(StoryNameCfg[998].name)

				arg_258_1.leftNameTxt_.text = var_261_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_3 = arg_258_1:GetWordFromCfg(413152058)
				local var_261_4 = arg_258_1:FormatText(var_261_3.content)

				arg_258_1.text_.text = var_261_4

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_5 = 15
				local var_261_6 = utf8.len(var_261_4)
				local var_261_7 = var_261_5 <= 0 and var_261_1 or var_261_1 * (var_261_6 / var_261_5)

				if var_261_7 > 0 and var_261_1 < var_261_7 then
					arg_258_1.talkMaxDuration = var_261_7

					if var_261_7 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_7 + var_261_0
					end
				end

				arg_258_1.text_.text = var_261_4
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152058", "story_v_out_413152.awb") ~= 0 then
					local var_261_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152058", "story_v_out_413152.awb") / 1000

					if var_261_8 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_8 + var_261_0
					end

					if var_261_3.prefab_name ~= "" and arg_258_1.actors_[var_261_3.prefab_name] ~= nil then
						local var_261_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_3.prefab_name].transform, "story_v_out_413152", "413152058", "story_v_out_413152.awb")

						arg_258_1:RecordAudio("413152058", var_261_9)
						arg_258_1:RecordAudio("413152058", var_261_9)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_413152", "413152058", "story_v_out_413152.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_413152", "413152058", "story_v_out_413152.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_10 = math.max(var_261_1, arg_258_1.talkMaxDuration)

			if var_261_0 <= arg_258_1.time_ and arg_258_1.time_ < var_261_0 + var_261_10 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_0) / var_261_10

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_0 + var_261_10 and arg_258_1.time_ < var_261_0 + var_261_10 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play413152059 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 413152059
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play413152060(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0
			local var_265_1 = 0.65

			if var_265_0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_2 = arg_262_1:GetWordFromCfg(413152059)
				local var_265_3 = arg_262_1:FormatText(var_265_2.content)

				arg_262_1.text_.text = var_265_3

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_4 = 26
				local var_265_5 = utf8.len(var_265_3)
				local var_265_6 = var_265_4 <= 0 and var_265_1 or var_265_1 * (var_265_5 / var_265_4)

				if var_265_6 > 0 and var_265_1 < var_265_6 then
					arg_262_1.talkMaxDuration = var_265_6

					if var_265_6 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_6 + var_265_0
					end
				end

				arg_262_1.text_.text = var_265_3
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_7 = math.max(var_265_1, arg_262_1.talkMaxDuration)

			if var_265_0 <= arg_262_1.time_ and arg_262_1.time_ < var_265_0 + var_265_7 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_0) / var_265_7

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_0 + var_265_7 and arg_262_1.time_ < var_265_0 + var_265_7 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play413152060 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 413152060
		arg_266_1.duration_ = 12.93

		local var_266_0 = {
			zh = 11.266,
			ja = 12.933
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play413152061(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0
			local var_269_1 = 0.775

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_2 = arg_266_1:FormatText(StoryNameCfg[614].name)

				arg_266_1.leftNameTxt_.text = var_269_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_4")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_3 = arg_266_1:GetWordFromCfg(413152060)
				local var_269_4 = arg_266_1:FormatText(var_269_3.content)

				arg_266_1.text_.text = var_269_4

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 31
				local var_269_6 = utf8.len(var_269_4)
				local var_269_7 = var_269_5 <= 0 and var_269_1 or var_269_1 * (var_269_6 / var_269_5)

				if var_269_7 > 0 and var_269_1 < var_269_7 then
					arg_266_1.talkMaxDuration = var_269_7

					if var_269_7 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_7 + var_269_0
					end
				end

				arg_266_1.text_.text = var_269_4
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152060", "story_v_out_413152.awb") ~= 0 then
					local var_269_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152060", "story_v_out_413152.awb") / 1000

					if var_269_8 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_8 + var_269_0
					end

					if var_269_3.prefab_name ~= "" and arg_266_1.actors_[var_269_3.prefab_name] ~= nil then
						local var_269_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_3.prefab_name].transform, "story_v_out_413152", "413152060", "story_v_out_413152.awb")

						arg_266_1:RecordAudio("413152060", var_269_9)
						arg_266_1:RecordAudio("413152060", var_269_9)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_413152", "413152060", "story_v_out_413152.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_413152", "413152060", "story_v_out_413152.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_10 = math.max(var_269_1, arg_266_1.talkMaxDuration)

			if var_269_0 <= arg_266_1.time_ and arg_266_1.time_ < var_269_0 + var_269_10 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_0) / var_269_10

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_0 + var_269_10 and arg_266_1.time_ < var_269_0 + var_269_10 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play413152061 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 413152061
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play413152062(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 0.8

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_2 = arg_270_1:GetWordFromCfg(413152061)
				local var_273_3 = arg_270_1:FormatText(var_273_2.content)

				arg_270_1.text_.text = var_273_3

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_4 = 32
				local var_273_5 = utf8.len(var_273_3)
				local var_273_6 = var_273_4 <= 0 and var_273_1 or var_273_1 * (var_273_5 / var_273_4)

				if var_273_6 > 0 and var_273_1 < var_273_6 then
					arg_270_1.talkMaxDuration = var_273_6

					if var_273_6 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_6 + var_273_0
					end
				end

				arg_270_1.text_.text = var_273_3
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_7 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_7 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_7

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_7 and arg_270_1.time_ < var_273_0 + var_273_7 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play413152062 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 413152062
		arg_274_1.duration_ = 8.87

		local var_274_0 = {
			zh = 5.166,
			ja = 8.866
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
				arg_274_0:Play413152063(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0
			local var_277_1 = 0.5

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_2 = arg_274_1:FormatText(StoryNameCfg[614].name)

				arg_274_1.leftNameTxt_.text = var_277_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_8")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_3 = arg_274_1:GetWordFromCfg(413152062)
				local var_277_4 = arg_274_1:FormatText(var_277_3.content)

				arg_274_1.text_.text = var_277_4

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 20
				local var_277_6 = utf8.len(var_277_4)
				local var_277_7 = var_277_5 <= 0 and var_277_1 or var_277_1 * (var_277_6 / var_277_5)

				if var_277_7 > 0 and var_277_1 < var_277_7 then
					arg_274_1.talkMaxDuration = var_277_7

					if var_277_7 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_7 + var_277_0
					end
				end

				arg_274_1.text_.text = var_277_4
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152062", "story_v_out_413152.awb") ~= 0 then
					local var_277_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152062", "story_v_out_413152.awb") / 1000

					if var_277_8 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_8 + var_277_0
					end

					if var_277_3.prefab_name ~= "" and arg_274_1.actors_[var_277_3.prefab_name] ~= nil then
						local var_277_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_3.prefab_name].transform, "story_v_out_413152", "413152062", "story_v_out_413152.awb")

						arg_274_1:RecordAudio("413152062", var_277_9)
						arg_274_1:RecordAudio("413152062", var_277_9)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_413152", "413152062", "story_v_out_413152.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_413152", "413152062", "story_v_out_413152.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_10 = math.max(var_277_1, arg_274_1.talkMaxDuration)

			if var_277_0 <= arg_274_1.time_ and arg_274_1.time_ < var_277_0 + var_277_10 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_0) / var_277_10

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_0 + var_277_10 and arg_274_1.time_ < var_277_0 + var_277_10 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play413152063 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 413152063
		arg_278_1.duration_ = 4.53

		local var_278_0 = {
			zh = 4.533,
			ja = 3.833
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
				arg_278_0:Play413152064(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 0.35

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_2 = arg_278_1:FormatText(StoryNameCfg[614].name)

				arg_278_1.leftNameTxt_.text = var_281_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_3 = arg_278_1:GetWordFromCfg(413152063)
				local var_281_4 = arg_278_1:FormatText(var_281_3.content)

				arg_278_1.text_.text = var_281_4

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 14
				local var_281_6 = utf8.len(var_281_4)
				local var_281_7 = var_281_5 <= 0 and var_281_1 or var_281_1 * (var_281_6 / var_281_5)

				if var_281_7 > 0 and var_281_1 < var_281_7 then
					arg_278_1.talkMaxDuration = var_281_7

					if var_281_7 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_7 + var_281_0
					end
				end

				arg_278_1.text_.text = var_281_4
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152063", "story_v_out_413152.awb") ~= 0 then
					local var_281_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152063", "story_v_out_413152.awb") / 1000

					if var_281_8 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_8 + var_281_0
					end

					if var_281_3.prefab_name ~= "" and arg_278_1.actors_[var_281_3.prefab_name] ~= nil then
						local var_281_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_3.prefab_name].transform, "story_v_out_413152", "413152063", "story_v_out_413152.awb")

						arg_278_1:RecordAudio("413152063", var_281_9)
						arg_278_1:RecordAudio("413152063", var_281_9)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_413152", "413152063", "story_v_out_413152.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_413152", "413152063", "story_v_out_413152.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_10 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_10 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_10

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_10 and arg_278_1.time_ < var_281_0 + var_281_10 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play413152064 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 413152064
		arg_282_1.duration_ = 2.57

		local var_282_0 = {
			zh = 1.233,
			ja = 2.566
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
				arg_282_0:Play413152065(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0
			local var_285_1 = 0.125

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_2 = arg_282_1:FormatText(StoryNameCfg[28].name)

				arg_282_1.leftNameTxt_.text = var_285_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_3 = arg_282_1:GetWordFromCfg(413152064)
				local var_285_4 = arg_282_1:FormatText(var_285_3.content)

				arg_282_1.text_.text = var_285_4

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_5 = 5
				local var_285_6 = utf8.len(var_285_4)
				local var_285_7 = var_285_5 <= 0 and var_285_1 or var_285_1 * (var_285_6 / var_285_5)

				if var_285_7 > 0 and var_285_1 < var_285_7 then
					arg_282_1.talkMaxDuration = var_285_7

					if var_285_7 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_7 + var_285_0
					end
				end

				arg_282_1.text_.text = var_285_4
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152064", "story_v_out_413152.awb") ~= 0 then
					local var_285_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152064", "story_v_out_413152.awb") / 1000

					if var_285_8 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_8 + var_285_0
					end

					if var_285_3.prefab_name ~= "" and arg_282_1.actors_[var_285_3.prefab_name] ~= nil then
						local var_285_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_3.prefab_name].transform, "story_v_out_413152", "413152064", "story_v_out_413152.awb")

						arg_282_1:RecordAudio("413152064", var_285_9)
						arg_282_1:RecordAudio("413152064", var_285_9)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_413152", "413152064", "story_v_out_413152.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_413152", "413152064", "story_v_out_413152.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_10 = math.max(var_285_1, arg_282_1.talkMaxDuration)

			if var_285_0 <= arg_282_1.time_ and arg_282_1.time_ < var_285_0 + var_285_10 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_0) / var_285_10

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_0 + var_285_10 and arg_282_1.time_ < var_285_0 + var_285_10 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play413152065 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 413152065
		arg_286_1.duration_ = 3.77

		local var_286_0 = {
			zh = 3.2,
			ja = 3.766
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
				arg_286_0:Play413152066(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0
			local var_289_1 = 0.225

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_2 = arg_286_1:FormatText(StoryNameCfg[614].name)

				arg_286_1.leftNameTxt_.text = var_289_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_3 = arg_286_1:GetWordFromCfg(413152065)
				local var_289_4 = arg_286_1:FormatText(var_289_3.content)

				arg_286_1.text_.text = var_289_4

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 9
				local var_289_6 = utf8.len(var_289_4)
				local var_289_7 = var_289_5 <= 0 and var_289_1 or var_289_1 * (var_289_6 / var_289_5)

				if var_289_7 > 0 and var_289_1 < var_289_7 then
					arg_286_1.talkMaxDuration = var_289_7

					if var_289_7 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_7 + var_289_0
					end
				end

				arg_286_1.text_.text = var_289_4
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152065", "story_v_out_413152.awb") ~= 0 then
					local var_289_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152065", "story_v_out_413152.awb") / 1000

					if var_289_8 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_8 + var_289_0
					end

					if var_289_3.prefab_name ~= "" and arg_286_1.actors_[var_289_3.prefab_name] ~= nil then
						local var_289_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_3.prefab_name].transform, "story_v_out_413152", "413152065", "story_v_out_413152.awb")

						arg_286_1:RecordAudio("413152065", var_289_9)
						arg_286_1:RecordAudio("413152065", var_289_9)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_413152", "413152065", "story_v_out_413152.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_413152", "413152065", "story_v_out_413152.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_10 = math.max(var_289_1, arg_286_1.talkMaxDuration)

			if var_289_0 <= arg_286_1.time_ and arg_286_1.time_ < var_289_0 + var_289_10 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_0) / var_289_10

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_0 + var_289_10 and arg_286_1.time_ < var_289_0 + var_289_10 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play413152066 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 413152066
		arg_290_1.duration_ = 6.3

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play413152067(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.mask_.enabled = true
				arg_290_1.mask_.raycastTarget = true

				arg_290_1:SetGaussion(false)
			end

			local var_293_1 = 0.366666666666667

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_1 then
				local var_293_2 = (arg_290_1.time_ - var_293_0) / var_293_1
				local var_293_3 = Color.New(1, 0, 0)

				var_293_3.a = Mathf.Lerp(0, 1, var_293_2)
				arg_290_1.mask_.color = var_293_3
			end

			if arg_290_1.time_ >= var_293_0 + var_293_1 and arg_290_1.time_ < var_293_0 + var_293_1 + arg_293_0 then
				local var_293_4 = Color.New(1, 0, 0)

				var_293_4.a = 1
				arg_290_1.mask_.color = var_293_4
			end

			local var_293_5 = 0.366666666666667

			if var_293_5 < arg_290_1.time_ and arg_290_1.time_ <= var_293_5 + arg_293_0 then
				arg_290_1.mask_.enabled = true
				arg_290_1.mask_.raycastTarget = true

				arg_290_1:SetGaussion(false)
			end

			local var_293_6 = 0.633333333333333

			if var_293_5 <= arg_290_1.time_ and arg_290_1.time_ < var_293_5 + var_293_6 then
				local var_293_7 = (arg_290_1.time_ - var_293_5) / var_293_6
				local var_293_8 = Color.New(1, 0, 0)

				var_293_8.a = Mathf.Lerp(1, 0, var_293_7)
				arg_290_1.mask_.color = var_293_8
			end

			if arg_290_1.time_ >= var_293_5 + var_293_6 and arg_290_1.time_ < var_293_5 + var_293_6 + arg_293_0 then
				local var_293_9 = Color.New(1, 0, 0)
				local var_293_10 = 0

				arg_290_1.mask_.enabled = false
				var_293_9.a = var_293_10
				arg_290_1.mask_.color = var_293_9
			end

			if arg_290_1.frameCnt_ <= 1 then
				arg_290_1.dialog_:SetActive(false)
			end

			local var_293_11 = 1.3
			local var_293_12 = 1.075

			if var_293_11 < arg_290_1.time_ and arg_290_1.time_ <= var_293_11 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0

				arg_290_1.dialog_:SetActive(true)

				arg_290_1.dialogCg_.alpha = 0

				local var_293_13 = LeanTween.value(arg_290_1.dialog_, 0, 1, 0.3)

				var_293_13:setOnUpdate(LuaHelper.FloatAction(function(arg_294_0)
					arg_290_1.dialogCg_.alpha = arg_294_0
				end))
				var_293_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_290_1.dialog_)
					var_293_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_290_1.duration_ = arg_290_1.duration_ + 0.3

				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_14 = arg_290_1:GetWordFromCfg(413152066)
				local var_293_15 = arg_290_1:FormatText(var_293_14.content)

				arg_290_1.text_.text = var_293_15

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_16 = 43
				local var_293_17 = utf8.len(var_293_15)
				local var_293_18 = var_293_16 <= 0 and var_293_12 or var_293_12 * (var_293_17 / var_293_16)

				if var_293_18 > 0 and var_293_12 < var_293_18 then
					arg_290_1.talkMaxDuration = var_293_18
					var_293_11 = var_293_11 + 0.3

					if var_293_18 + var_293_11 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_18 + var_293_11
					end
				end

				arg_290_1.text_.text = var_293_15
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_19 = var_293_11 + 0.3
			local var_293_20 = math.max(var_293_12, arg_290_1.talkMaxDuration)

			if var_293_19 <= arg_290_1.time_ and arg_290_1.time_ < var_293_19 + var_293_20 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_19) / var_293_20

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_19 + var_293_20 and arg_290_1.time_ < var_293_19 + var_293_20 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play413152067 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 413152067
		arg_296_1.duration_ = 4.6

		local var_296_0 = {
			zh = 2.933,
			ja = 4.6
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play413152068(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0
			local var_299_1 = 0.275

			if var_299_0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_0 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_2 = arg_296_1:FormatText(StoryNameCfg[614].name)

				arg_296_1.leftNameTxt_.text = var_299_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, true)
				arg_296_1.iconController_:SetSelectedState("hero")

				arg_296_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_3")

				arg_296_1.callingController_:SetSelectedState("normal")

				arg_296_1.keyicon_.color = Color.New(1, 1, 1)
				arg_296_1.icon_.color = Color.New(1, 1, 1)

				local var_299_3 = arg_296_1:GetWordFromCfg(413152067)
				local var_299_4 = arg_296_1:FormatText(var_299_3.content)

				arg_296_1.text_.text = var_299_4

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_5 = 11
				local var_299_6 = utf8.len(var_299_4)
				local var_299_7 = var_299_5 <= 0 and var_299_1 or var_299_1 * (var_299_6 / var_299_5)

				if var_299_7 > 0 and var_299_1 < var_299_7 then
					arg_296_1.talkMaxDuration = var_299_7

					if var_299_7 + var_299_0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_7 + var_299_0
					end
				end

				arg_296_1.text_.text = var_299_4
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152067", "story_v_out_413152.awb") ~= 0 then
					local var_299_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152067", "story_v_out_413152.awb") / 1000

					if var_299_8 + var_299_0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_8 + var_299_0
					end

					if var_299_3.prefab_name ~= "" and arg_296_1.actors_[var_299_3.prefab_name] ~= nil then
						local var_299_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_3.prefab_name].transform, "story_v_out_413152", "413152067", "story_v_out_413152.awb")

						arg_296_1:RecordAudio("413152067", var_299_9)
						arg_296_1:RecordAudio("413152067", var_299_9)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_413152", "413152067", "story_v_out_413152.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_413152", "413152067", "story_v_out_413152.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_10 = math.max(var_299_1, arg_296_1.talkMaxDuration)

			if var_299_0 <= arg_296_1.time_ and arg_296_1.time_ < var_299_0 + var_299_10 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_0) / var_299_10

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_0 + var_299_10 and arg_296_1.time_ < var_299_0 + var_299_10 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play413152068 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 413152068
		arg_300_1.duration_ = 10.17

		local var_300_0 = {
			zh = 8.133,
			ja = 10.166
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play413152069(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0
			local var_303_1 = 0.8

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_2 = arg_300_1:FormatText(StoryNameCfg[614].name)

				arg_300_1.leftNameTxt_.text = var_303_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_3")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_3 = arg_300_1:GetWordFromCfg(413152068)
				local var_303_4 = arg_300_1:FormatText(var_303_3.content)

				arg_300_1.text_.text = var_303_4

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_5 = 32
				local var_303_6 = utf8.len(var_303_4)
				local var_303_7 = var_303_5 <= 0 and var_303_1 or var_303_1 * (var_303_6 / var_303_5)

				if var_303_7 > 0 and var_303_1 < var_303_7 then
					arg_300_1.talkMaxDuration = var_303_7

					if var_303_7 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_7 + var_303_0
					end
				end

				arg_300_1.text_.text = var_303_4
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152068", "story_v_out_413152.awb") ~= 0 then
					local var_303_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152068", "story_v_out_413152.awb") / 1000

					if var_303_8 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_8 + var_303_0
					end

					if var_303_3.prefab_name ~= "" and arg_300_1.actors_[var_303_3.prefab_name] ~= nil then
						local var_303_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_3.prefab_name].transform, "story_v_out_413152", "413152068", "story_v_out_413152.awb")

						arg_300_1:RecordAudio("413152068", var_303_9)
						arg_300_1:RecordAudio("413152068", var_303_9)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_413152", "413152068", "story_v_out_413152.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_413152", "413152068", "story_v_out_413152.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_10 = math.max(var_303_1, arg_300_1.talkMaxDuration)

			if var_303_0 <= arg_300_1.time_ and arg_300_1.time_ < var_303_0 + var_303_10 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_0) / var_303_10

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_0 + var_303_10 and arg_300_1.time_ < var_303_0 + var_303_10 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play413152069 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 413152069
		arg_304_1.duration_ = 4.57

		local var_304_0 = {
			zh = 4.1,
			ja = 4.566
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play413152070(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0
			local var_307_1 = 0.4

			if var_307_0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_2 = arg_304_1:FormatText(StoryNameCfg[259].name)

				arg_304_1.leftNameTxt_.text = var_307_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10094_split_1")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_3 = arg_304_1:GetWordFromCfg(413152069)
				local var_307_4 = arg_304_1:FormatText(var_307_3.content)

				arg_304_1.text_.text = var_307_4

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_5 = 16
				local var_307_6 = utf8.len(var_307_4)
				local var_307_7 = var_307_5 <= 0 and var_307_1 or var_307_1 * (var_307_6 / var_307_5)

				if var_307_7 > 0 and var_307_1 < var_307_7 then
					arg_304_1.talkMaxDuration = var_307_7

					if var_307_7 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_7 + var_307_0
					end
				end

				arg_304_1.text_.text = var_307_4
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152069", "story_v_out_413152.awb") ~= 0 then
					local var_307_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152069", "story_v_out_413152.awb") / 1000

					if var_307_8 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_8 + var_307_0
					end

					if var_307_3.prefab_name ~= "" and arg_304_1.actors_[var_307_3.prefab_name] ~= nil then
						local var_307_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_3.prefab_name].transform, "story_v_out_413152", "413152069", "story_v_out_413152.awb")

						arg_304_1:RecordAudio("413152069", var_307_9)
						arg_304_1:RecordAudio("413152069", var_307_9)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_413152", "413152069", "story_v_out_413152.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_413152", "413152069", "story_v_out_413152.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_10 = math.max(var_307_1, arg_304_1.talkMaxDuration)

			if var_307_0 <= arg_304_1.time_ and arg_304_1.time_ < var_307_0 + var_307_10 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_0) / var_307_10

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_0 + var_307_10 and arg_304_1.time_ < var_307_0 + var_307_10 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play413152070 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 413152070
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play413152071(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0
			local var_311_1 = 1.1

			if var_311_0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_2 = arg_308_1:GetWordFromCfg(413152070)
				local var_311_3 = arg_308_1:FormatText(var_311_2.content)

				arg_308_1.text_.text = var_311_3

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_4 = 44
				local var_311_5 = utf8.len(var_311_3)
				local var_311_6 = var_311_4 <= 0 and var_311_1 or var_311_1 * (var_311_5 / var_311_4)

				if var_311_6 > 0 and var_311_1 < var_311_6 then
					arg_308_1.talkMaxDuration = var_311_6

					if var_311_6 + var_311_0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_6 + var_311_0
					end
				end

				arg_308_1.text_.text = var_311_3
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_7 = math.max(var_311_1, arg_308_1.talkMaxDuration)

			if var_311_0 <= arg_308_1.time_ and arg_308_1.time_ < var_311_0 + var_311_7 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_0) / var_311_7

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_0 + var_311_7 and arg_308_1.time_ < var_311_0 + var_311_7 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play413152071 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 413152071
		arg_312_1.duration_ = 5.5

		local var_312_0 = {
			zh = 3.2,
			ja = 5.5
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play413152072(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["10094"].transform
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 then
				arg_312_1.var_.moveOldPos10094 = var_315_0.localPosition
				var_315_0.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("10094", 3)

				local var_315_2 = var_315_0.childCount

				for iter_315_0 = 0, var_315_2 - 1 do
					local var_315_3 = var_315_0:GetChild(iter_315_0)

					if var_315_3.name == "" or not string.find(var_315_3.name, "split") then
						var_315_3.gameObject:SetActive(true)
					else
						var_315_3.gameObject:SetActive(false)
					end
				end
			end

			local var_315_4 = 0.001

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_4 then
				local var_315_5 = (arg_312_1.time_ - var_315_1) / var_315_4
				local var_315_6 = Vector3.New(0, -340, -414)

				var_315_0.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos10094, var_315_6, var_315_5)
			end

			if arg_312_1.time_ >= var_315_1 + var_315_4 and arg_312_1.time_ < var_315_1 + var_315_4 + arg_315_0 then
				var_315_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_315_7 = arg_312_1.actors_["10094"]
			local var_315_8 = 0

			if var_315_8 < arg_312_1.time_ and arg_312_1.time_ <= var_315_8 + arg_315_0 and not isNil(var_315_7) and arg_312_1.var_.actorSpriteComps10094 == nil then
				arg_312_1.var_.actorSpriteComps10094 = var_315_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_9 = 2

			if var_315_8 <= arg_312_1.time_ and arg_312_1.time_ < var_315_8 + var_315_9 and not isNil(var_315_7) then
				local var_315_10 = (arg_312_1.time_ - var_315_8) / var_315_9

				if arg_312_1.var_.actorSpriteComps10094 then
					for iter_315_1, iter_315_2 in pairs(arg_312_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_315_2 then
							if arg_312_1.isInRecall_ then
								local var_315_11 = Mathf.Lerp(iter_315_2.color.r, arg_312_1.hightColor1.r, var_315_10)
								local var_315_12 = Mathf.Lerp(iter_315_2.color.g, arg_312_1.hightColor1.g, var_315_10)
								local var_315_13 = Mathf.Lerp(iter_315_2.color.b, arg_312_1.hightColor1.b, var_315_10)

								iter_315_2.color = Color.New(var_315_11, var_315_12, var_315_13)
							else
								local var_315_14 = Mathf.Lerp(iter_315_2.color.r, 1, var_315_10)

								iter_315_2.color = Color.New(var_315_14, var_315_14, var_315_14)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= var_315_8 + var_315_9 and arg_312_1.time_ < var_315_8 + var_315_9 + arg_315_0 and not isNil(var_315_7) and arg_312_1.var_.actorSpriteComps10094 then
				for iter_315_3, iter_315_4 in pairs(arg_312_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_315_4 then
						if arg_312_1.isInRecall_ then
							iter_315_4.color = arg_312_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_315_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_312_1.var_.actorSpriteComps10094 = nil
			end

			local var_315_15 = arg_312_1.actors_["10094"]
			local var_315_16 = 0

			if var_315_16 < arg_312_1.time_ and arg_312_1.time_ <= var_315_16 + arg_315_0 then
				local var_315_17 = var_315_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_315_17 then
					arg_312_1.var_.alphaOldValue10094 = var_315_17.alpha
					arg_312_1.var_.characterEffect10094 = var_315_17
				end

				arg_312_1.var_.alphaOldValue10094 = 0
			end

			local var_315_18 = 0.5

			if var_315_16 <= arg_312_1.time_ and arg_312_1.time_ < var_315_16 + var_315_18 then
				local var_315_19 = (arg_312_1.time_ - var_315_16) / var_315_18
				local var_315_20 = Mathf.Lerp(arg_312_1.var_.alphaOldValue10094, 1, var_315_19)

				if arg_312_1.var_.characterEffect10094 then
					arg_312_1.var_.characterEffect10094.alpha = var_315_20
				end
			end

			if arg_312_1.time_ >= var_315_16 + var_315_18 and arg_312_1.time_ < var_315_16 + var_315_18 + arg_315_0 and arg_312_1.var_.characterEffect10094 then
				arg_312_1.var_.characterEffect10094.alpha = 1
			end

			local var_315_21 = 0
			local var_315_22 = 0.3

			if var_315_21 < arg_312_1.time_ and arg_312_1.time_ <= var_315_21 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_23 = arg_312_1:FormatText(StoryNameCfg[259].name)

				arg_312_1.leftNameTxt_.text = var_315_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_24 = arg_312_1:GetWordFromCfg(413152071)
				local var_315_25 = arg_312_1:FormatText(var_315_24.content)

				arg_312_1.text_.text = var_315_25

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_26 = 12
				local var_315_27 = utf8.len(var_315_25)
				local var_315_28 = var_315_26 <= 0 and var_315_22 or var_315_22 * (var_315_27 / var_315_26)

				if var_315_28 > 0 and var_315_22 < var_315_28 then
					arg_312_1.talkMaxDuration = var_315_28

					if var_315_28 + var_315_21 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_28 + var_315_21
					end
				end

				arg_312_1.text_.text = var_315_25
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152071", "story_v_out_413152.awb") ~= 0 then
					local var_315_29 = manager.audio:GetVoiceLength("story_v_out_413152", "413152071", "story_v_out_413152.awb") / 1000

					if var_315_29 + var_315_21 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_29 + var_315_21
					end

					if var_315_24.prefab_name ~= "" and arg_312_1.actors_[var_315_24.prefab_name] ~= nil then
						local var_315_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_24.prefab_name].transform, "story_v_out_413152", "413152071", "story_v_out_413152.awb")

						arg_312_1:RecordAudio("413152071", var_315_30)
						arg_312_1:RecordAudio("413152071", var_315_30)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_413152", "413152071", "story_v_out_413152.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_413152", "413152071", "story_v_out_413152.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_31 = math.max(var_315_22, arg_312_1.talkMaxDuration)

			if var_315_21 <= arg_312_1.time_ and arg_312_1.time_ < var_315_21 + var_315_31 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_21) / var_315_31

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_21 + var_315_31 and arg_312_1.time_ < var_315_21 + var_315_31 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play413152072 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 413152072
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play413152073(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["10094"].transform
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 then
				arg_316_1.var_.moveOldPos10094 = var_319_0.localPosition
				var_319_0.localScale = Vector3.New(1, 1, 1)

				arg_316_1:CheckSpriteTmpPos("10094", 6)

				local var_319_2 = var_319_0.childCount

				for iter_319_0 = 0, var_319_2 - 1 do
					local var_319_3 = var_319_0:GetChild(iter_319_0)

					if var_319_3.name == "" or not string.find(var_319_3.name, "split") then
						var_319_3.gameObject:SetActive(true)
					else
						var_319_3.gameObject:SetActive(false)
					end
				end
			end

			local var_319_4 = 0.001

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_4 then
				local var_319_5 = (arg_316_1.time_ - var_319_1) / var_319_4
				local var_319_6 = Vector3.New(1500, -340, -414)

				var_319_0.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos10094, var_319_6, var_319_5)
			end

			if arg_316_1.time_ >= var_319_1 + var_319_4 and arg_316_1.time_ < var_319_1 + var_319_4 + arg_319_0 then
				var_319_0.localPosition = Vector3.New(1500, -340, -414)
			end

			local var_319_7 = 0
			local var_319_8 = 1.05

			if var_319_7 < arg_316_1.time_ and arg_316_1.time_ <= var_319_7 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_9 = arg_316_1:GetWordFromCfg(413152072)
				local var_319_10 = arg_316_1:FormatText(var_319_9.content)

				arg_316_1.text_.text = var_319_10

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_11 = 42
				local var_319_12 = utf8.len(var_319_10)
				local var_319_13 = var_319_11 <= 0 and var_319_8 or var_319_8 * (var_319_12 / var_319_11)

				if var_319_13 > 0 and var_319_8 < var_319_13 then
					arg_316_1.talkMaxDuration = var_319_13

					if var_319_13 + var_319_7 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_13 + var_319_7
					end
				end

				arg_316_1.text_.text = var_319_10
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_14 = math.max(var_319_8, arg_316_1.talkMaxDuration)

			if var_319_7 <= arg_316_1.time_ and arg_316_1.time_ < var_319_7 + var_319_14 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_7) / var_319_14

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_7 + var_319_14 and arg_316_1.time_ < var_319_7 + var_319_14 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play413152073 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 413152073
		arg_320_1.duration_ = 5.27

		local var_320_0 = {
			zh = 5.266,
			ja = 4.266
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play413152074(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0
			local var_323_1 = 0.35

			if var_323_0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_2 = arg_320_1:FormatText(StoryNameCfg[614].name)

				arg_320_1.leftNameTxt_.text = var_323_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_1")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_3 = arg_320_1:GetWordFromCfg(413152073)
				local var_323_4 = arg_320_1:FormatText(var_323_3.content)

				arg_320_1.text_.text = var_323_4

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_5 = 14
				local var_323_6 = utf8.len(var_323_4)
				local var_323_7 = var_323_5 <= 0 and var_323_1 or var_323_1 * (var_323_6 / var_323_5)

				if var_323_7 > 0 and var_323_1 < var_323_7 then
					arg_320_1.talkMaxDuration = var_323_7

					if var_323_7 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_7 + var_323_0
					end
				end

				arg_320_1.text_.text = var_323_4
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152073", "story_v_out_413152.awb") ~= 0 then
					local var_323_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152073", "story_v_out_413152.awb") / 1000

					if var_323_8 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_8 + var_323_0
					end

					if var_323_3.prefab_name ~= "" and arg_320_1.actors_[var_323_3.prefab_name] ~= nil then
						local var_323_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_3.prefab_name].transform, "story_v_out_413152", "413152073", "story_v_out_413152.awb")

						arg_320_1:RecordAudio("413152073", var_323_9)
						arg_320_1:RecordAudio("413152073", var_323_9)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_413152", "413152073", "story_v_out_413152.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_413152", "413152073", "story_v_out_413152.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_10 = math.max(var_323_1, arg_320_1.talkMaxDuration)

			if var_323_0 <= arg_320_1.time_ and arg_320_1.time_ < var_323_0 + var_323_10 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_0) / var_323_10

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_0 + var_323_10 and arg_320_1.time_ < var_323_0 + var_323_10 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play413152074 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 413152074
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play413152075(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0
			local var_327_1 = 0.875

			if var_327_0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_2 = arg_324_1:GetWordFromCfg(413152074)
				local var_327_3 = arg_324_1:FormatText(var_327_2.content)

				arg_324_1.text_.text = var_327_3

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_4 = 35
				local var_327_5 = utf8.len(var_327_3)
				local var_327_6 = var_327_4 <= 0 and var_327_1 or var_327_1 * (var_327_5 / var_327_4)

				if var_327_6 > 0 and var_327_1 < var_327_6 then
					arg_324_1.talkMaxDuration = var_327_6

					if var_327_6 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_6 + var_327_0
					end
				end

				arg_324_1.text_.text = var_327_3
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_7 = math.max(var_327_1, arg_324_1.talkMaxDuration)

			if var_327_0 <= arg_324_1.time_ and arg_324_1.time_ < var_327_0 + var_327_7 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_0) / var_327_7

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_0 + var_327_7 and arg_324_1.time_ < var_327_0 + var_327_7 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play413152075 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 413152075
		arg_328_1.duration_ = 3.1

		local var_328_0 = {
			zh = 3.1,
			ja = 3
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play413152076(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0
			local var_331_1 = 0.125

			if var_331_0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_2 = arg_328_1:FormatText(StoryNameCfg[36].name)

				arg_328_1.leftNameTxt_.text = var_331_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_3 = arg_328_1:GetWordFromCfg(413152075)
				local var_331_4 = arg_328_1:FormatText(var_331_3.content)

				arg_328_1.text_.text = var_331_4

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_5 = 5
				local var_331_6 = utf8.len(var_331_4)
				local var_331_7 = var_331_5 <= 0 and var_331_1 or var_331_1 * (var_331_6 / var_331_5)

				if var_331_7 > 0 and var_331_1 < var_331_7 then
					arg_328_1.talkMaxDuration = var_331_7

					if var_331_7 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_7 + var_331_0
					end
				end

				arg_328_1.text_.text = var_331_4
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152075", "story_v_out_413152.awb") ~= 0 then
					local var_331_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152075", "story_v_out_413152.awb") / 1000

					if var_331_8 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_8 + var_331_0
					end

					if var_331_3.prefab_name ~= "" and arg_328_1.actors_[var_331_3.prefab_name] ~= nil then
						local var_331_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_3.prefab_name].transform, "story_v_out_413152", "413152075", "story_v_out_413152.awb")

						arg_328_1:RecordAudio("413152075", var_331_9)
						arg_328_1:RecordAudio("413152075", var_331_9)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_413152", "413152075", "story_v_out_413152.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_413152", "413152075", "story_v_out_413152.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_10 = math.max(var_331_1, arg_328_1.talkMaxDuration)

			if var_331_0 <= arg_328_1.time_ and arg_328_1.time_ < var_331_0 + var_331_10 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_0) / var_331_10

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_0 + var_331_10 and arg_328_1.time_ < var_331_0 + var_331_10 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play413152076 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 413152076
		arg_332_1.duration_ = 5.23

		local var_332_0 = {
			zh = 3.6,
			ja = 5.233
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play413152077(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0
			local var_335_1 = 0.2

			if var_335_0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_0 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_2 = arg_332_1:FormatText(StoryNameCfg[36].name)

				arg_332_1.leftNameTxt_.text = var_335_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, true)
				arg_332_1.iconController_:SetSelectedState("hero")

				arg_332_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_332_1.callingController_:SetSelectedState("normal")

				arg_332_1.keyicon_.color = Color.New(1, 1, 1)
				arg_332_1.icon_.color = Color.New(1, 1, 1)

				local var_335_3 = arg_332_1:GetWordFromCfg(413152076)
				local var_335_4 = arg_332_1:FormatText(var_335_3.content)

				arg_332_1.text_.text = var_335_4

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_5 = 8
				local var_335_6 = utf8.len(var_335_4)
				local var_335_7 = var_335_5 <= 0 and var_335_1 or var_335_1 * (var_335_6 / var_335_5)

				if var_335_7 > 0 and var_335_1 < var_335_7 then
					arg_332_1.talkMaxDuration = var_335_7

					if var_335_7 + var_335_0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_7 + var_335_0
					end
				end

				arg_332_1.text_.text = var_335_4
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152076", "story_v_out_413152.awb") ~= 0 then
					local var_335_8 = manager.audio:GetVoiceLength("story_v_out_413152", "413152076", "story_v_out_413152.awb") / 1000

					if var_335_8 + var_335_0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_8 + var_335_0
					end

					if var_335_3.prefab_name ~= "" and arg_332_1.actors_[var_335_3.prefab_name] ~= nil then
						local var_335_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_3.prefab_name].transform, "story_v_out_413152", "413152076", "story_v_out_413152.awb")

						arg_332_1:RecordAudio("413152076", var_335_9)
						arg_332_1:RecordAudio("413152076", var_335_9)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_413152", "413152076", "story_v_out_413152.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_413152", "413152076", "story_v_out_413152.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_10 = math.max(var_335_1, arg_332_1.talkMaxDuration)

			if var_335_0 <= arg_332_1.time_ and arg_332_1.time_ < var_335_0 + var_335_10 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_0) / var_335_10

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_0 + var_335_10 and arg_332_1.time_ < var_335_0 + var_335_10 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play413152077 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 413152077
		arg_336_1.duration_ = 1.6

		local var_336_0 = {
			zh = 1.26633333333333,
			ja = 1.59933333333333
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
			arg_336_1.auto_ = false
		end

		function arg_336_1.playNext_(arg_338_0)
			arg_336_1.onStoryFinished_()
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0

			if var_339_0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_0 + arg_339_0 then
				arg_336_1.allBtn_.enabled = false
			end

			local var_339_1 = 0.133333333333333

			if arg_336_1.time_ >= var_339_0 + var_339_1 and arg_336_1.time_ < var_339_0 + var_339_1 + arg_339_0 then
				arg_336_1.allBtn_.enabled = true
			end

			local var_339_2 = 0.133333333333333
			local var_339_3 = 0.133333333333333

			if var_339_2 < arg_336_1.time_ and arg_336_1.time_ <= var_339_2 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_4 = arg_336_1:FormatText(StoryNameCfg[614].name)

				arg_336_1.leftNameTxt_.text = var_339_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_5 = arg_336_1:GetWordFromCfg(413152077)
				local var_339_6 = arg_336_1:FormatText(var_339_5.content)

				arg_336_1.text_.text = var_339_6

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_7 = 6
				local var_339_8 = utf8.len(var_339_6)
				local var_339_9 = var_339_7 <= 0 and var_339_3 or var_339_3 * (var_339_8 / var_339_7)

				if var_339_9 > 0 and var_339_3 < var_339_9 then
					arg_336_1.talkMaxDuration = var_339_9

					if var_339_9 + var_339_2 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_9 + var_339_2
					end
				end

				arg_336_1.text_.text = var_339_6
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413152", "413152077", "story_v_out_413152.awb") ~= 0 then
					local var_339_10 = manager.audio:GetVoiceLength("story_v_out_413152", "413152077", "story_v_out_413152.awb") / 1000

					if var_339_10 + var_339_2 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_10 + var_339_2
					end

					if var_339_5.prefab_name ~= "" and arg_336_1.actors_[var_339_5.prefab_name] ~= nil then
						local var_339_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_5.prefab_name].transform, "story_v_out_413152", "413152077", "story_v_out_413152.awb")

						arg_336_1:RecordAudio("413152077", var_339_11)
						arg_336_1:RecordAudio("413152077", var_339_11)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_413152", "413152077", "story_v_out_413152.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_413152", "413152077", "story_v_out_413152.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_12 = math.max(var_339_3, arg_336_1.talkMaxDuration)

			if var_339_2 <= arg_336_1.time_ and arg_336_1.time_ < var_339_2 + var_339_12 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_2) / var_339_12

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_2 + var_339_12 and arg_336_1.time_ < var_339_2 + var_339_12 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F08i",
		"TextureConfig/Background/ST0603",
		"TextureConfig/Background/F10g",
		"TextureConfig/Background/SS1310"
	},
	voices = {
		"story_v_out_413152.awb"
	}
}
