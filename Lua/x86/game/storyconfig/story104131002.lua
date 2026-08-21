return {
	Play413102001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413102001
		arg_1_1.duration_ = 13.27

		local var_1_0 = {
			zh = 13.266,
			ja = 9.5
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
				arg_1_0:Play413102002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F10g"

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
				local var_4_5 = arg_1_1.bgs_.F10g

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
					if iter_4_0 ~= "F10g" then
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

			local var_4_24 = "10097"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10097")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(var_4_25, arg_1_1.canvasGo_.transform)

					var_4_26.transform:SetSiblingIndex(1)

					var_4_26.name = var_4_24
					var_4_26.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_24] = var_4_26

					local var_4_27 = var_4_26:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs(var_4_27) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_28 = arg_1_1.actors_["10097"].transform
			local var_4_29 = 1.73333333333333

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.var_.moveOldPos10097 = var_4_28.localPosition
				var_4_28.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10097", 3)

				local var_4_30 = var_4_28.childCount

				for iter_4_4 = 0, var_4_30 - 1 do
					local var_4_31 = var_4_28:GetChild(iter_4_4)

					if var_4_31.name == "split_3" or not string.find(var_4_31.name, "split") then
						var_4_31.gameObject:SetActive(true)
					else
						var_4_31.gameObject:SetActive(false)
					end
				end
			end

			local var_4_32 = 0.001

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_29) / var_4_32
				local var_4_34 = Vector3.New(0, -350, -180)

				var_4_28.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10097, var_4_34, var_4_33)
			end

			if arg_1_1.time_ >= var_4_29 + var_4_32 and arg_1_1.time_ < var_4_29 + var_4_32 + arg_4_0 then
				var_4_28.localPosition = Vector3.New(0, -350, -180)
			end

			local var_4_35 = arg_1_1.actors_["10097"]
			local var_4_36 = 1.73333333333333

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 and not isNil(var_4_35) and arg_1_1.var_.actorSpriteComps10097 == nil then
				arg_1_1.var_.actorSpriteComps10097 = var_4_35:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_37 = 2

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 and not isNil(var_4_35) then
				local var_4_38 = (arg_1_1.time_ - var_4_36) / var_4_37

				if arg_1_1.var_.actorSpriteComps10097 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								local var_4_39 = Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, var_4_38)
								local var_4_40 = Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, var_4_38)
								local var_4_41 = Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, var_4_38)

								iter_4_6.color = Color.New(var_4_39, var_4_40, var_4_41)
							else
								local var_4_42 = Mathf.Lerp(iter_4_6.color.r, 1, var_4_38)

								iter_4_6.color = Color.New(var_4_42, var_4_42, var_4_42)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 and not isNil(var_4_35) and arg_1_1.var_.actorSpriteComps10097 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_4_8 then
						if arg_1_1.isInRecall_ then
							iter_4_8.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10097 = nil
			end

			local var_4_43 = arg_1_1.actors_["10097"]
			local var_4_44 = 1.73333333333333

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue10097 = var_4_45.alpha
					arg_1_1.var_.characterEffect10097 = var_4_45
				end

				arg_1_1.var_.alphaOldValue10097 = 0
			end

			local var_4_46 = 0.3

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_44) / var_4_46
				local var_4_48 = Mathf.Lerp(arg_1_1.var_.alphaOldValue10097, 1, var_4_47)

				if arg_1_1.var_.characterEffect10097 then
					arg_1_1.var_.characterEffect10097.alpha = var_4_48
				end
			end

			if arg_1_1.time_ >= var_4_44 + var_4_46 and arg_1_1.time_ < var_4_44 + var_4_46 + arg_4_0 and arg_1_1.var_.characterEffect10097 then
				arg_1_1.var_.characterEffect10097.alpha = 1
			end

			local var_4_49 = 0
			local var_4_50 = 0.433333333333333

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "music"

				arg_1_1:AudioAction(var_4_51, var_4_52, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_53 = ""
				local var_4_54 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_54 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_54 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_54

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_54
						arg_1_1.bgmTxt2_.text = var_4_54
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

			local var_4_55 = 1.26666666666667
			local var_4_56 = 1

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				local var_4_57 = "play"
				local var_4_58 = "music"

				arg_1_1:AudioAction(var_4_57, var_4_58, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_59 = ""
				local var_4_60 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if var_4_60 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_60 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_60

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_60
						arg_1_1.bgmTxt2_.text = var_4_60
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

			local var_4_61 = 2
			local var_4_62 = 0.4

			if var_4_61 < arg_1_1.time_ and arg_1_1.time_ <= var_4_61 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_63 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_63:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_64 = arg_1_1:FormatText(StoryNameCfg[1001].name)

				arg_1_1.leftNameTxt_.text = var_4_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_65 = arg_1_1:GetWordFromCfg(413102001)
				local var_4_66 = arg_1_1:FormatText(var_4_65.content)

				arg_1_1.text_.text = var_4_66

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_67 = 16
				local var_4_68 = utf8.len(var_4_66)
				local var_4_69 = var_4_67 <= 0 and var_4_62 or var_4_62 * (var_4_68 / var_4_67)

				if var_4_69 > 0 and var_4_62 < var_4_69 then
					arg_1_1.talkMaxDuration = var_4_69
					var_4_61 = var_4_61 + 0.3

					if var_4_69 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_69 + var_4_61
					end
				end

				arg_1_1.text_.text = var_4_66
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102001", "story_v_out_413102.awb") ~= 0 then
					local var_4_70 = manager.audio:GetVoiceLength("story_v_out_413102", "413102001", "story_v_out_413102.awb") / 1000

					if var_4_70 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_70 + var_4_61
					end

					if var_4_65.prefab_name ~= "" and arg_1_1.actors_[var_4_65.prefab_name] ~= nil then
						local var_4_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_65.prefab_name].transform, "story_v_out_413102", "413102001", "story_v_out_413102.awb")

						arg_1_1:RecordAudio("413102001", var_4_71)
						arg_1_1:RecordAudio("413102001", var_4_71)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413102", "413102001", "story_v_out_413102.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413102", "413102001", "story_v_out_413102.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_72 = var_4_61 + 0.3
			local var_4_73 = math.max(var_4_62, arg_1_1.talkMaxDuration)

			if var_4_72 <= arg_1_1.time_ and arg_1_1.time_ < var_4_72 + var_4_73 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_72) / var_4_73

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_72 + var_4_73 and arg_1_1.time_ < var_4_72 + var_4_73 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play413102002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413102002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play413102003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["10097"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos10097 = var_12_0.localPosition
				var_12_0.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10097", 7)

				local var_12_2 = var_12_0.childCount

				for iter_12_0 = 0, var_12_2 - 1 do
					local var_12_3 = var_12_0:GetChild(iter_12_0)

					if var_12_3.name == "" or not string.find(var_12_3.name, "split") then
						var_12_3.gameObject:SetActive(true)
					else
						var_12_3.gameObject:SetActive(false)
					end
				end
			end

			local var_12_4 = 0.001

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_4 then
				local var_12_5 = (arg_9_1.time_ - var_12_1) / var_12_4
				local var_12_6 = Vector3.New(0, -2000, -180)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10097, var_12_6, var_12_5)
			end

			if arg_9_1.time_ >= var_12_1 + var_12_4 and arg_9_1.time_ < var_12_1 + var_12_4 + arg_12_0 then
				var_12_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_12_7 = arg_9_1.actors_["10097"]
			local var_12_8 = 0

			if var_12_8 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.actorSpriteComps10097 == nil then
				arg_9_1.var_.actorSpriteComps10097 = var_12_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_9 = 2

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_9 and not isNil(var_12_7) then
				local var_12_10 = (arg_9_1.time_ - var_12_8) / var_12_9

				if arg_9_1.var_.actorSpriteComps10097 then
					for iter_12_1, iter_12_2 in pairs(arg_9_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_12_2 then
							if arg_9_1.isInRecall_ then
								local var_12_11 = Mathf.Lerp(iter_12_2.color.r, arg_9_1.hightColor2.r, var_12_10)
								local var_12_12 = Mathf.Lerp(iter_12_2.color.g, arg_9_1.hightColor2.g, var_12_10)
								local var_12_13 = Mathf.Lerp(iter_12_2.color.b, arg_9_1.hightColor2.b, var_12_10)

								iter_12_2.color = Color.New(var_12_11, var_12_12, var_12_13)
							else
								local var_12_14 = Mathf.Lerp(iter_12_2.color.r, 0.5, var_12_10)

								iter_12_2.color = Color.New(var_12_14, var_12_14, var_12_14)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_8 + var_12_9 and arg_9_1.time_ < var_12_8 + var_12_9 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.actorSpriteComps10097 then
				for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_12_4 then
						if arg_9_1.isInRecall_ then
							iter_12_4.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10097 = nil
			end

			local var_12_15 = 0
			local var_12_16 = 0.5

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_17 = arg_9_1:GetWordFromCfg(413102002)
				local var_12_18 = arg_9_1:FormatText(var_12_17.content)

				arg_9_1.text_.text = var_12_18

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_19 = 20
				local var_12_20 = utf8.len(var_12_18)
				local var_12_21 = var_12_19 <= 0 and var_12_16 or var_12_16 * (var_12_20 / var_12_19)

				if var_12_21 > 0 and var_12_16 < var_12_21 then
					arg_9_1.talkMaxDuration = var_12_21

					if var_12_21 + var_12_15 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_21 + var_12_15
					end
				end

				arg_9_1.text_.text = var_12_18
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_22 = math.max(var_12_16, arg_9_1.talkMaxDuration)

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_22 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_15) / var_12_22

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_15 + var_12_22 and arg_9_1.time_ < var_12_15 + var_12_22 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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
	Play413102003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413102003
		arg_13_1.duration_ = 10.4

		local var_13_0 = {
			zh = 8.633,
			ja = 10.4
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
				arg_13_0:Play413102004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10097"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos10097 = var_16_0.localPosition
				var_16_0.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10097", 7)

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
				local var_16_6 = Vector3.New(0, -2000, -180)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10097, var_16_6, var_16_5)
			end

			if arg_13_1.time_ >= var_16_1 + var_16_4 and arg_13_1.time_ < var_16_1 + var_16_4 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_16_7 = "10096"

			if arg_13_1.actors_[var_16_7] == nil then
				local var_16_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10096")

				if not isNil(var_16_8) then
					local var_16_9 = Object.Instantiate(var_16_8, arg_13_1.canvasGo_.transform)

					var_16_9.transform:SetSiblingIndex(1)

					var_16_9.name = var_16_7
					var_16_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_[var_16_7] = var_16_9

					local var_16_10 = var_16_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_13_1.isInRecall_ then
						for iter_16_1, iter_16_2 in ipairs(var_16_10) do
							iter_16_2.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_11 = arg_13_1.actors_["10096"].transform
			local var_16_12 = 0

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.var_.moveOldPos10096 = var_16_11.localPosition
				var_16_11.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10096", 3)

				local var_16_13 = var_16_11.childCount

				for iter_16_3 = 0, var_16_13 - 1 do
					local var_16_14 = var_16_11:GetChild(iter_16_3)

					if var_16_14.name == "" or not string.find(var_16_14.name, "split") then
						var_16_14.gameObject:SetActive(true)
					else
						var_16_14.gameObject:SetActive(false)
					end
				end
			end

			local var_16_15 = 0.001

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_15 then
				local var_16_16 = (arg_13_1.time_ - var_16_12) / var_16_15
				local var_16_17 = Vector3.New(0, -350, -210)

				var_16_11.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10096, var_16_17, var_16_16)
			end

			if arg_13_1.time_ >= var_16_12 + var_16_15 and arg_13_1.time_ < var_16_12 + var_16_15 + arg_16_0 then
				var_16_11.localPosition = Vector3.New(0, -350, -210)
			end

			local var_16_18 = arg_13_1.actors_["10097"]
			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 and not isNil(var_16_18) and arg_13_1.var_.actorSpriteComps10097 == nil then
				arg_13_1.var_.actorSpriteComps10097 = var_16_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_20 = 2

			if var_16_19 <= arg_13_1.time_ and arg_13_1.time_ < var_16_19 + var_16_20 and not isNil(var_16_18) then
				local var_16_21 = (arg_13_1.time_ - var_16_19) / var_16_20

				if arg_13_1.var_.actorSpriteComps10097 then
					for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_16_5 then
							if arg_13_1.isInRecall_ then
								local var_16_22 = Mathf.Lerp(iter_16_5.color.r, arg_13_1.hightColor2.r, var_16_21)
								local var_16_23 = Mathf.Lerp(iter_16_5.color.g, arg_13_1.hightColor2.g, var_16_21)
								local var_16_24 = Mathf.Lerp(iter_16_5.color.b, arg_13_1.hightColor2.b, var_16_21)

								iter_16_5.color = Color.New(var_16_22, var_16_23, var_16_24)
							else
								local var_16_25 = Mathf.Lerp(iter_16_5.color.r, 0.5, var_16_21)

								iter_16_5.color = Color.New(var_16_25, var_16_25, var_16_25)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_19 + var_16_20 and arg_13_1.time_ < var_16_19 + var_16_20 + arg_16_0 and not isNil(var_16_18) and arg_13_1.var_.actorSpriteComps10097 then
				for iter_16_6, iter_16_7 in pairs(arg_13_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_16_7 then
						if arg_13_1.isInRecall_ then
							iter_16_7.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10097 = nil
			end

			local var_16_26 = arg_13_1.actors_["10096"]
			local var_16_27 = 0

			if var_16_27 < arg_13_1.time_ and arg_13_1.time_ <= var_16_27 + arg_16_0 and not isNil(var_16_26) and arg_13_1.var_.actorSpriteComps10096 == nil then
				arg_13_1.var_.actorSpriteComps10096 = var_16_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_28 = 2

			if var_16_27 <= arg_13_1.time_ and arg_13_1.time_ < var_16_27 + var_16_28 and not isNil(var_16_26) then
				local var_16_29 = (arg_13_1.time_ - var_16_27) / var_16_28

				if arg_13_1.var_.actorSpriteComps10096 then
					for iter_16_8, iter_16_9 in pairs(arg_13_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_16_9 then
							if arg_13_1.isInRecall_ then
								local var_16_30 = Mathf.Lerp(iter_16_9.color.r, arg_13_1.hightColor1.r, var_16_29)
								local var_16_31 = Mathf.Lerp(iter_16_9.color.g, arg_13_1.hightColor1.g, var_16_29)
								local var_16_32 = Mathf.Lerp(iter_16_9.color.b, arg_13_1.hightColor1.b, var_16_29)

								iter_16_9.color = Color.New(var_16_30, var_16_31, var_16_32)
							else
								local var_16_33 = Mathf.Lerp(iter_16_9.color.r, 1, var_16_29)

								iter_16_9.color = Color.New(var_16_33, var_16_33, var_16_33)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_27 + var_16_28 and arg_13_1.time_ < var_16_27 + var_16_28 + arg_16_0 and not isNil(var_16_26) and arg_13_1.var_.actorSpriteComps10096 then
				for iter_16_10, iter_16_11 in pairs(arg_13_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_16_11 then
						if arg_13_1.isInRecall_ then
							iter_16_11.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_11.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10096 = nil
			end

			local var_16_34 = 0
			local var_16_35 = 0.75

			if var_16_34 < arg_13_1.time_ and arg_13_1.time_ <= var_16_34 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_36 = arg_13_1:FormatText(StoryNameCfg[36].name)

				arg_13_1.leftNameTxt_.text = var_16_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_37 = arg_13_1:GetWordFromCfg(413102003)
				local var_16_38 = arg_13_1:FormatText(var_16_37.content)

				arg_13_1.text_.text = var_16_38

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_39 = 30
				local var_16_40 = utf8.len(var_16_38)
				local var_16_41 = var_16_39 <= 0 and var_16_35 or var_16_35 * (var_16_40 / var_16_39)

				if var_16_41 > 0 and var_16_35 < var_16_41 then
					arg_13_1.talkMaxDuration = var_16_41

					if var_16_41 + var_16_34 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_41 + var_16_34
					end
				end

				arg_13_1.text_.text = var_16_38
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102003", "story_v_out_413102.awb") ~= 0 then
					local var_16_42 = manager.audio:GetVoiceLength("story_v_out_413102", "413102003", "story_v_out_413102.awb") / 1000

					if var_16_42 + var_16_34 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_42 + var_16_34
					end

					if var_16_37.prefab_name ~= "" and arg_13_1.actors_[var_16_37.prefab_name] ~= nil then
						local var_16_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_37.prefab_name].transform, "story_v_out_413102", "413102003", "story_v_out_413102.awb")

						arg_13_1:RecordAudio("413102003", var_16_43)
						arg_13_1:RecordAudio("413102003", var_16_43)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_413102", "413102003", "story_v_out_413102.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_413102", "413102003", "story_v_out_413102.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_44 = math.max(var_16_35, arg_13_1.talkMaxDuration)

			if var_16_34 <= arg_13_1.time_ and arg_13_1.time_ < var_16_34 + var_16_44 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_34) / var_16_44

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_34 + var_16_44 and arg_13_1.time_ < var_16_34 + var_16_44 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
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
	Play413102004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413102004
		arg_17_1.duration_ = 9.63

		local var_17_0 = {
			zh = 5.566,
			ja = 9.633
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
				arg_17_0:Play413102005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10097"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos10097 = var_20_0.localPosition
				var_20_0.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10097", 2)

				local var_20_2 = var_20_0.childCount

				for iter_20_0 = 0, var_20_2 - 1 do
					local var_20_3 = var_20_0:GetChild(iter_20_0)

					if var_20_3.name == "split_3" or not string.find(var_20_3.name, "split") then
						var_20_3.gameObject:SetActive(true)
					else
						var_20_3.gameObject:SetActive(false)
					end
				end
			end

			local var_20_4 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_4 then
				local var_20_5 = (arg_17_1.time_ - var_20_1) / var_20_4
				local var_20_6 = Vector3.New(-390, -350, -180)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10097, var_20_6, var_20_5)
			end

			if arg_17_1.time_ >= var_20_1 + var_20_4 and arg_17_1.time_ < var_20_1 + var_20_4 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_20_7 = arg_17_1.actors_["10096"].transform
			local var_20_8 = 0

			if var_20_8 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.var_.moveOldPos10096 = var_20_7.localPosition
				var_20_7.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10096", 4)

				local var_20_9 = var_20_7.childCount

				for iter_20_1 = 0, var_20_9 - 1 do
					local var_20_10 = var_20_7:GetChild(iter_20_1)

					if var_20_10.name == "" or not string.find(var_20_10.name, "split") then
						var_20_10.gameObject:SetActive(true)
					else
						var_20_10.gameObject:SetActive(false)
					end
				end
			end

			local var_20_11 = 0.001

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_11 then
				local var_20_12 = (arg_17_1.time_ - var_20_8) / var_20_11
				local var_20_13 = Vector3.New(390, -350, -210)

				var_20_7.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10096, var_20_13, var_20_12)
			end

			if arg_17_1.time_ >= var_20_8 + var_20_11 and arg_17_1.time_ < var_20_8 + var_20_11 + arg_20_0 then
				var_20_7.localPosition = Vector3.New(390, -350, -210)
			end

			local var_20_14 = arg_17_1.actors_["10097"]
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.actorSpriteComps10097 == nil then
				arg_17_1.var_.actorSpriteComps10097 = var_20_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_16 = 2

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 and not isNil(var_20_14) then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16

				if arg_17_1.var_.actorSpriteComps10097 then
					for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_20_3 then
							if arg_17_1.isInRecall_ then
								local var_20_18 = Mathf.Lerp(iter_20_3.color.r, arg_17_1.hightColor1.r, var_20_17)
								local var_20_19 = Mathf.Lerp(iter_20_3.color.g, arg_17_1.hightColor1.g, var_20_17)
								local var_20_20 = Mathf.Lerp(iter_20_3.color.b, arg_17_1.hightColor1.b, var_20_17)

								iter_20_3.color = Color.New(var_20_18, var_20_19, var_20_20)
							else
								local var_20_21 = Mathf.Lerp(iter_20_3.color.r, 1, var_20_17)

								iter_20_3.color = Color.New(var_20_21, var_20_21, var_20_21)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.actorSpriteComps10097 then
				for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_20_5 then
						if arg_17_1.isInRecall_ then
							iter_20_5.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10097 = nil
			end

			local var_20_22 = arg_17_1.actors_["10096"]
			local var_20_23 = 0

			if var_20_23 < arg_17_1.time_ and arg_17_1.time_ <= var_20_23 + arg_20_0 and not isNil(var_20_22) and arg_17_1.var_.actorSpriteComps10096 == nil then
				arg_17_1.var_.actorSpriteComps10096 = var_20_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_24 = 2

			if var_20_23 <= arg_17_1.time_ and arg_17_1.time_ < var_20_23 + var_20_24 and not isNil(var_20_22) then
				local var_20_25 = (arg_17_1.time_ - var_20_23) / var_20_24

				if arg_17_1.var_.actorSpriteComps10096 then
					for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_20_7 then
							if arg_17_1.isInRecall_ then
								local var_20_26 = Mathf.Lerp(iter_20_7.color.r, arg_17_1.hightColor2.r, var_20_25)
								local var_20_27 = Mathf.Lerp(iter_20_7.color.g, arg_17_1.hightColor2.g, var_20_25)
								local var_20_28 = Mathf.Lerp(iter_20_7.color.b, arg_17_1.hightColor2.b, var_20_25)

								iter_20_7.color = Color.New(var_20_26, var_20_27, var_20_28)
							else
								local var_20_29 = Mathf.Lerp(iter_20_7.color.r, 0.5, var_20_25)

								iter_20_7.color = Color.New(var_20_29, var_20_29, var_20_29)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_23 + var_20_24 and arg_17_1.time_ < var_20_23 + var_20_24 + arg_20_0 and not isNil(var_20_22) and arg_17_1.var_.actorSpriteComps10096 then
				for iter_20_8, iter_20_9 in pairs(arg_17_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_20_9 then
						if arg_17_1.isInRecall_ then
							iter_20_9.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10096 = nil
			end

			local var_20_30 = 0
			local var_20_31 = 0.425

			if var_20_30 < arg_17_1.time_ and arg_17_1.time_ <= var_20_30 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_32 = arg_17_1:FormatText(StoryNameCfg[1001].name)

				arg_17_1.leftNameTxt_.text = var_20_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_33 = arg_17_1:GetWordFromCfg(413102004)
				local var_20_34 = arg_17_1:FormatText(var_20_33.content)

				arg_17_1.text_.text = var_20_34

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_35 = 17
				local var_20_36 = utf8.len(var_20_34)
				local var_20_37 = var_20_35 <= 0 and var_20_31 or var_20_31 * (var_20_36 / var_20_35)

				if var_20_37 > 0 and var_20_31 < var_20_37 then
					arg_17_1.talkMaxDuration = var_20_37

					if var_20_37 + var_20_30 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_37 + var_20_30
					end
				end

				arg_17_1.text_.text = var_20_34
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102004", "story_v_out_413102.awb") ~= 0 then
					local var_20_38 = manager.audio:GetVoiceLength("story_v_out_413102", "413102004", "story_v_out_413102.awb") / 1000

					if var_20_38 + var_20_30 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_38 + var_20_30
					end

					if var_20_33.prefab_name ~= "" and arg_17_1.actors_[var_20_33.prefab_name] ~= nil then
						local var_20_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_33.prefab_name].transform, "story_v_out_413102", "413102004", "story_v_out_413102.awb")

						arg_17_1:RecordAudio("413102004", var_20_39)
						arg_17_1:RecordAudio("413102004", var_20_39)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413102", "413102004", "story_v_out_413102.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413102", "413102004", "story_v_out_413102.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_40 = math.max(var_20_31, arg_17_1.talkMaxDuration)

			if var_20_30 <= arg_17_1.time_ and arg_17_1.time_ < var_20_30 + var_20_40 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_30) / var_20_40

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_30 + var_20_40 and arg_17_1.time_ < var_20_30 + var_20_40 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
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
	Play413102005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413102005
		arg_21_1.duration_ = 4.27

		local var_21_0 = {
			zh = 4.266,
			ja = 2.8
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
				arg_21_0:Play413102006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10097"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos10097 = var_24_0.localPosition
				var_24_0.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10097", 2)

				local var_24_2 = var_24_0.childCount

				for iter_24_0 = 0, var_24_2 - 1 do
					local var_24_3 = var_24_0:GetChild(iter_24_0)

					if var_24_3.name == "" or not string.find(var_24_3.name, "split") then
						var_24_3.gameObject:SetActive(true)
					else
						var_24_3.gameObject:SetActive(false)
					end
				end
			end

			local var_24_4 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_4 then
				local var_24_5 = (arg_21_1.time_ - var_24_1) / var_24_4
				local var_24_6 = Vector3.New(-390, -350, -180)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10097, var_24_6, var_24_5)
			end

			if arg_21_1.time_ >= var_24_1 + var_24_4 and arg_21_1.time_ < var_24_1 + var_24_4 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_24_7 = arg_21_1.actors_["10096"].transform
			local var_24_8 = 0

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.var_.moveOldPos10096 = var_24_7.localPosition
				var_24_7.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10096", 4)

				local var_24_9 = var_24_7.childCount

				for iter_24_1 = 0, var_24_9 - 1 do
					local var_24_10 = var_24_7:GetChild(iter_24_1)

					if var_24_10.name == "" or not string.find(var_24_10.name, "split") then
						var_24_10.gameObject:SetActive(true)
					else
						var_24_10.gameObject:SetActive(false)
					end
				end
			end

			local var_24_11 = 0.001

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_11 then
				local var_24_12 = (arg_21_1.time_ - var_24_8) / var_24_11
				local var_24_13 = Vector3.New(390, -350, -210)

				var_24_7.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10096, var_24_13, var_24_12)
			end

			if arg_21_1.time_ >= var_24_8 + var_24_11 and arg_21_1.time_ < var_24_8 + var_24_11 + arg_24_0 then
				var_24_7.localPosition = Vector3.New(390, -350, -210)
			end

			local var_24_14 = arg_21_1.actors_["10097"]
			local var_24_15 = 0

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.actorSpriteComps10097 == nil then
				arg_21_1.var_.actorSpriteComps10097 = var_24_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_16 = 2

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_16 and not isNil(var_24_14) then
				local var_24_17 = (arg_21_1.time_ - var_24_15) / var_24_16

				if arg_21_1.var_.actorSpriteComps10097 then
					for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_24_3 then
							if arg_21_1.isInRecall_ then
								local var_24_18 = Mathf.Lerp(iter_24_3.color.r, arg_21_1.hightColor2.r, var_24_17)
								local var_24_19 = Mathf.Lerp(iter_24_3.color.g, arg_21_1.hightColor2.g, var_24_17)
								local var_24_20 = Mathf.Lerp(iter_24_3.color.b, arg_21_1.hightColor2.b, var_24_17)

								iter_24_3.color = Color.New(var_24_18, var_24_19, var_24_20)
							else
								local var_24_21 = Mathf.Lerp(iter_24_3.color.r, 0.5, var_24_17)

								iter_24_3.color = Color.New(var_24_21, var_24_21, var_24_21)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_15 + var_24_16 and arg_21_1.time_ < var_24_15 + var_24_16 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.actorSpriteComps10097 then
				for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_24_5 then
						if arg_21_1.isInRecall_ then
							iter_24_5.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10097 = nil
			end

			local var_24_22 = arg_21_1.actors_["10096"]
			local var_24_23 = 0

			if var_24_23 < arg_21_1.time_ and arg_21_1.time_ <= var_24_23 + arg_24_0 and not isNil(var_24_22) and arg_21_1.var_.actorSpriteComps10096 == nil then
				arg_21_1.var_.actorSpriteComps10096 = var_24_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_24 = 2

			if var_24_23 <= arg_21_1.time_ and arg_21_1.time_ < var_24_23 + var_24_24 and not isNil(var_24_22) then
				local var_24_25 = (arg_21_1.time_ - var_24_23) / var_24_24

				if arg_21_1.var_.actorSpriteComps10096 then
					for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_24_7 then
							if arg_21_1.isInRecall_ then
								local var_24_26 = Mathf.Lerp(iter_24_7.color.r, arg_21_1.hightColor1.r, var_24_25)
								local var_24_27 = Mathf.Lerp(iter_24_7.color.g, arg_21_1.hightColor1.g, var_24_25)
								local var_24_28 = Mathf.Lerp(iter_24_7.color.b, arg_21_1.hightColor1.b, var_24_25)

								iter_24_7.color = Color.New(var_24_26, var_24_27, var_24_28)
							else
								local var_24_29 = Mathf.Lerp(iter_24_7.color.r, 1, var_24_25)

								iter_24_7.color = Color.New(var_24_29, var_24_29, var_24_29)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_23 + var_24_24 and arg_21_1.time_ < var_24_23 + var_24_24 + arg_24_0 and not isNil(var_24_22) and arg_21_1.var_.actorSpriteComps10096 then
				for iter_24_8, iter_24_9 in pairs(arg_21_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_24_9 then
						if arg_21_1.isInRecall_ then
							iter_24_9.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10096 = nil
			end

			local var_24_30 = 0
			local var_24_31 = 0.275

			if var_24_30 < arg_21_1.time_ and arg_21_1.time_ <= var_24_30 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_32 = arg_21_1:FormatText(StoryNameCfg[36].name)

				arg_21_1.leftNameTxt_.text = var_24_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_33 = arg_21_1:GetWordFromCfg(413102005)
				local var_24_34 = arg_21_1:FormatText(var_24_33.content)

				arg_21_1.text_.text = var_24_34

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_35 = 11
				local var_24_36 = utf8.len(var_24_34)
				local var_24_37 = var_24_35 <= 0 and var_24_31 or var_24_31 * (var_24_36 / var_24_35)

				if var_24_37 > 0 and var_24_31 < var_24_37 then
					arg_21_1.talkMaxDuration = var_24_37

					if var_24_37 + var_24_30 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_37 + var_24_30
					end
				end

				arg_21_1.text_.text = var_24_34
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102005", "story_v_out_413102.awb") ~= 0 then
					local var_24_38 = manager.audio:GetVoiceLength("story_v_out_413102", "413102005", "story_v_out_413102.awb") / 1000

					if var_24_38 + var_24_30 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_38 + var_24_30
					end

					if var_24_33.prefab_name ~= "" and arg_21_1.actors_[var_24_33.prefab_name] ~= nil then
						local var_24_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_33.prefab_name].transform, "story_v_out_413102", "413102005", "story_v_out_413102.awb")

						arg_21_1:RecordAudio("413102005", var_24_39)
						arg_21_1:RecordAudio("413102005", var_24_39)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413102", "413102005", "story_v_out_413102.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413102", "413102005", "story_v_out_413102.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_40 = math.max(var_24_31, arg_21_1.talkMaxDuration)

			if var_24_30 <= arg_21_1.time_ and arg_21_1.time_ < var_24_30 + var_24_40 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_30) / var_24_40

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_30 + var_24_40 and arg_21_1.time_ < var_24_30 + var_24_40 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
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
	Play413102006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413102006
		arg_25_1.duration_ = 13.53

		local var_25_0 = {
			zh = 10.433,
			ja = 13.533
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
				arg_25_0:Play413102007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10097"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos10097 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10097", 2)

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
				local var_28_6 = Vector3.New(-390, -350, -180)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10097, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_28_7 = arg_25_1.actors_["10096"].transform
			local var_28_8 = 0

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.var_.moveOldPos10096 = var_28_7.localPosition
				var_28_7.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10096", 4)

				local var_28_9 = var_28_7.childCount

				for iter_28_1 = 0, var_28_9 - 1 do
					local var_28_10 = var_28_7:GetChild(iter_28_1)

					if var_28_10.name == "" or not string.find(var_28_10.name, "split") then
						var_28_10.gameObject:SetActive(true)
					else
						var_28_10.gameObject:SetActive(false)
					end
				end
			end

			local var_28_11 = 0.001

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_11 then
				local var_28_12 = (arg_25_1.time_ - var_28_8) / var_28_11
				local var_28_13 = Vector3.New(390, -350, -210)

				var_28_7.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10096, var_28_13, var_28_12)
			end

			if arg_25_1.time_ >= var_28_8 + var_28_11 and arg_25_1.time_ < var_28_8 + var_28_11 + arg_28_0 then
				var_28_7.localPosition = Vector3.New(390, -350, -210)
			end

			local var_28_14 = arg_25_1.actors_["10097"]
			local var_28_15 = 0

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.actorSpriteComps10097 == nil then
				arg_25_1.var_.actorSpriteComps10097 = var_28_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_16 = 2

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_16 and not isNil(var_28_14) then
				local var_28_17 = (arg_25_1.time_ - var_28_15) / var_28_16

				if arg_25_1.var_.actorSpriteComps10097 then
					for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_28_3 then
							if arg_25_1.isInRecall_ then
								local var_28_18 = Mathf.Lerp(iter_28_3.color.r, arg_25_1.hightColor2.r, var_28_17)
								local var_28_19 = Mathf.Lerp(iter_28_3.color.g, arg_25_1.hightColor2.g, var_28_17)
								local var_28_20 = Mathf.Lerp(iter_28_3.color.b, arg_25_1.hightColor2.b, var_28_17)

								iter_28_3.color = Color.New(var_28_18, var_28_19, var_28_20)
							else
								local var_28_21 = Mathf.Lerp(iter_28_3.color.r, 0.5, var_28_17)

								iter_28_3.color = Color.New(var_28_21, var_28_21, var_28_21)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_15 + var_28_16 and arg_25_1.time_ < var_28_15 + var_28_16 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.actorSpriteComps10097 then
				for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_28_5 then
						if arg_25_1.isInRecall_ then
							iter_28_5.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10097 = nil
			end

			local var_28_22 = arg_25_1.actors_["10096"]
			local var_28_23 = 0

			if var_28_23 < arg_25_1.time_ and arg_25_1.time_ <= var_28_23 + arg_28_0 and not isNil(var_28_22) and arg_25_1.var_.actorSpriteComps10096 == nil then
				arg_25_1.var_.actorSpriteComps10096 = var_28_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_24 = 2

			if var_28_23 <= arg_25_1.time_ and arg_25_1.time_ < var_28_23 + var_28_24 and not isNil(var_28_22) then
				local var_28_25 = (arg_25_1.time_ - var_28_23) / var_28_24

				if arg_25_1.var_.actorSpriteComps10096 then
					for iter_28_6, iter_28_7 in pairs(arg_25_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_28_7 then
							if arg_25_1.isInRecall_ then
								local var_28_26 = Mathf.Lerp(iter_28_7.color.r, arg_25_1.hightColor1.r, var_28_25)
								local var_28_27 = Mathf.Lerp(iter_28_7.color.g, arg_25_1.hightColor1.g, var_28_25)
								local var_28_28 = Mathf.Lerp(iter_28_7.color.b, arg_25_1.hightColor1.b, var_28_25)

								iter_28_7.color = Color.New(var_28_26, var_28_27, var_28_28)
							else
								local var_28_29 = Mathf.Lerp(iter_28_7.color.r, 1, var_28_25)

								iter_28_7.color = Color.New(var_28_29, var_28_29, var_28_29)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_23 + var_28_24 and arg_25_1.time_ < var_28_23 + var_28_24 + arg_28_0 and not isNil(var_28_22) and arg_25_1.var_.actorSpriteComps10096 then
				for iter_28_8, iter_28_9 in pairs(arg_25_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_28_9 then
						if arg_25_1.isInRecall_ then
							iter_28_9.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10096 = nil
			end

			local var_28_30 = 0
			local var_28_31 = 0.725

			if var_28_30 < arg_25_1.time_ and arg_25_1.time_ <= var_28_30 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_32 = arg_25_1:FormatText(StoryNameCfg[36].name)

				arg_25_1.leftNameTxt_.text = var_28_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_33 = arg_25_1:GetWordFromCfg(413102006)
				local var_28_34 = arg_25_1:FormatText(var_28_33.content)

				arg_25_1.text_.text = var_28_34

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_35 = 29
				local var_28_36 = utf8.len(var_28_34)
				local var_28_37 = var_28_35 <= 0 and var_28_31 or var_28_31 * (var_28_36 / var_28_35)

				if var_28_37 > 0 and var_28_31 < var_28_37 then
					arg_25_1.talkMaxDuration = var_28_37

					if var_28_37 + var_28_30 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_37 + var_28_30
					end
				end

				arg_25_1.text_.text = var_28_34
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102006", "story_v_out_413102.awb") ~= 0 then
					local var_28_38 = manager.audio:GetVoiceLength("story_v_out_413102", "413102006", "story_v_out_413102.awb") / 1000

					if var_28_38 + var_28_30 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_38 + var_28_30
					end

					if var_28_33.prefab_name ~= "" and arg_25_1.actors_[var_28_33.prefab_name] ~= nil then
						local var_28_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_33.prefab_name].transform, "story_v_out_413102", "413102006", "story_v_out_413102.awb")

						arg_25_1:RecordAudio("413102006", var_28_39)
						arg_25_1:RecordAudio("413102006", var_28_39)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413102", "413102006", "story_v_out_413102.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413102", "413102006", "story_v_out_413102.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_40 = math.max(var_28_31, arg_25_1.talkMaxDuration)

			if var_28_30 <= arg_25_1.time_ and arg_25_1.time_ < var_28_30 + var_28_40 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_30) / var_28_40

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_30 + var_28_40 and arg_25_1.time_ < var_28_30 + var_28_40 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
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
	Play413102007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413102007
		arg_29_1.duration_ = 9.1

		local var_29_0 = {
			zh = 3.8,
			ja = 9.1
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
				arg_29_0:Play413102008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10097"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos10097 = var_32_0.localPosition
				var_32_0.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10097", 2)

				local var_32_2 = var_32_0.childCount

				for iter_32_0 = 0, var_32_2 - 1 do
					local var_32_3 = var_32_0:GetChild(iter_32_0)

					if var_32_3.name == "split_2" or not string.find(var_32_3.name, "split") then
						var_32_3.gameObject:SetActive(true)
					else
						var_32_3.gameObject:SetActive(false)
					end
				end
			end

			local var_32_4 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_4 then
				local var_32_5 = (arg_29_1.time_ - var_32_1) / var_32_4
				local var_32_6 = Vector3.New(-390, -350, -180)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10097, var_32_6, var_32_5)
			end

			if arg_29_1.time_ >= var_32_1 + var_32_4 and arg_29_1.time_ < var_32_1 + var_32_4 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_32_7 = arg_29_1.actors_["10096"].transform
			local var_32_8 = 0

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.var_.moveOldPos10096 = var_32_7.localPosition
				var_32_7.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10096", 4)

				local var_32_9 = var_32_7.childCount

				for iter_32_1 = 0, var_32_9 - 1 do
					local var_32_10 = var_32_7:GetChild(iter_32_1)

					if var_32_10.name == "" or not string.find(var_32_10.name, "split") then
						var_32_10.gameObject:SetActive(true)
					else
						var_32_10.gameObject:SetActive(false)
					end
				end
			end

			local var_32_11 = 0.001

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_11 then
				local var_32_12 = (arg_29_1.time_ - var_32_8) / var_32_11
				local var_32_13 = Vector3.New(390, -350, -210)

				var_32_7.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10096, var_32_13, var_32_12)
			end

			if arg_29_1.time_ >= var_32_8 + var_32_11 and arg_29_1.time_ < var_32_8 + var_32_11 + arg_32_0 then
				var_32_7.localPosition = Vector3.New(390, -350, -210)
			end

			local var_32_14 = arg_29_1.actors_["10097"]
			local var_32_15 = 0

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.actorSpriteComps10097 == nil then
				arg_29_1.var_.actorSpriteComps10097 = var_32_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_16 = 2

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_16 and not isNil(var_32_14) then
				local var_32_17 = (arg_29_1.time_ - var_32_15) / var_32_16

				if arg_29_1.var_.actorSpriteComps10097 then
					for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_32_3 then
							if arg_29_1.isInRecall_ then
								local var_32_18 = Mathf.Lerp(iter_32_3.color.r, arg_29_1.hightColor1.r, var_32_17)
								local var_32_19 = Mathf.Lerp(iter_32_3.color.g, arg_29_1.hightColor1.g, var_32_17)
								local var_32_20 = Mathf.Lerp(iter_32_3.color.b, arg_29_1.hightColor1.b, var_32_17)

								iter_32_3.color = Color.New(var_32_18, var_32_19, var_32_20)
							else
								local var_32_21 = Mathf.Lerp(iter_32_3.color.r, 1, var_32_17)

								iter_32_3.color = Color.New(var_32_21, var_32_21, var_32_21)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_15 + var_32_16 and arg_29_1.time_ < var_32_15 + var_32_16 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.actorSpriteComps10097 then
				for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_32_5 then
						if arg_29_1.isInRecall_ then
							iter_32_5.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10097 = nil
			end

			local var_32_22 = arg_29_1.actors_["10096"]
			local var_32_23 = 0

			if var_32_23 < arg_29_1.time_ and arg_29_1.time_ <= var_32_23 + arg_32_0 and not isNil(var_32_22) and arg_29_1.var_.actorSpriteComps10096 == nil then
				arg_29_1.var_.actorSpriteComps10096 = var_32_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_24 = 2

			if var_32_23 <= arg_29_1.time_ and arg_29_1.time_ < var_32_23 + var_32_24 and not isNil(var_32_22) then
				local var_32_25 = (arg_29_1.time_ - var_32_23) / var_32_24

				if arg_29_1.var_.actorSpriteComps10096 then
					for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_32_7 then
							if arg_29_1.isInRecall_ then
								local var_32_26 = Mathf.Lerp(iter_32_7.color.r, arg_29_1.hightColor2.r, var_32_25)
								local var_32_27 = Mathf.Lerp(iter_32_7.color.g, arg_29_1.hightColor2.g, var_32_25)
								local var_32_28 = Mathf.Lerp(iter_32_7.color.b, arg_29_1.hightColor2.b, var_32_25)

								iter_32_7.color = Color.New(var_32_26, var_32_27, var_32_28)
							else
								local var_32_29 = Mathf.Lerp(iter_32_7.color.r, 0.5, var_32_25)

								iter_32_7.color = Color.New(var_32_29, var_32_29, var_32_29)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_23 + var_32_24 and arg_29_1.time_ < var_32_23 + var_32_24 + arg_32_0 and not isNil(var_32_22) and arg_29_1.var_.actorSpriteComps10096 then
				for iter_32_8, iter_32_9 in pairs(arg_29_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_32_9 then
						if arg_29_1.isInRecall_ then
							iter_32_9.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10096 = nil
			end

			local var_32_30 = 0
			local var_32_31 = 0.325

			if var_32_30 < arg_29_1.time_ and arg_29_1.time_ <= var_32_30 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_32 = arg_29_1:FormatText(StoryNameCfg[1001].name)

				arg_29_1.leftNameTxt_.text = var_32_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_33 = arg_29_1:GetWordFromCfg(413102007)
				local var_32_34 = arg_29_1:FormatText(var_32_33.content)

				arg_29_1.text_.text = var_32_34

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_35 = 13
				local var_32_36 = utf8.len(var_32_34)
				local var_32_37 = var_32_35 <= 0 and var_32_31 or var_32_31 * (var_32_36 / var_32_35)

				if var_32_37 > 0 and var_32_31 < var_32_37 then
					arg_29_1.talkMaxDuration = var_32_37

					if var_32_37 + var_32_30 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_37 + var_32_30
					end
				end

				arg_29_1.text_.text = var_32_34
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102007", "story_v_out_413102.awb") ~= 0 then
					local var_32_38 = manager.audio:GetVoiceLength("story_v_out_413102", "413102007", "story_v_out_413102.awb") / 1000

					if var_32_38 + var_32_30 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_38 + var_32_30
					end

					if var_32_33.prefab_name ~= "" and arg_29_1.actors_[var_32_33.prefab_name] ~= nil then
						local var_32_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_33.prefab_name].transform, "story_v_out_413102", "413102007", "story_v_out_413102.awb")

						arg_29_1:RecordAudio("413102007", var_32_39)
						arg_29_1:RecordAudio("413102007", var_32_39)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413102", "413102007", "story_v_out_413102.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413102", "413102007", "story_v_out_413102.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_40 = math.max(var_32_31, arg_29_1.talkMaxDuration)

			if var_32_30 <= arg_29_1.time_ and arg_29_1.time_ < var_32_30 + var_32_40 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_30) / var_32_40

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_30 + var_32_40 and arg_29_1.time_ < var_32_30 + var_32_40 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
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
	Play413102008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413102008
		arg_33_1.duration_ = 6.03

		local var_33_0 = {
			zh = 3.4,
			ja = 6.033
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
				arg_33_0:Play413102009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10096"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos10096 = var_36_0.localPosition
				var_36_0.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10096", 4)

				local var_36_2 = var_36_0.childCount

				for iter_36_0 = 0, var_36_2 - 1 do
					local var_36_3 = var_36_0:GetChild(iter_36_0)

					if var_36_3.name == "" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_4 then
				local var_36_5 = (arg_33_1.time_ - var_36_1) / var_36_4
				local var_36_6 = Vector3.New(390, -350, -210)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10096, var_36_6, var_36_5)
			end

			if arg_33_1.time_ >= var_36_1 + var_36_4 and arg_33_1.time_ < var_36_1 + var_36_4 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(390, -350, -210)
			end

			local var_36_7 = arg_33_1.actors_["10097"]
			local var_36_8 = 0

			if var_36_8 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps10097 == nil then
				arg_33_1.var_.actorSpriteComps10097 = var_36_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_9 = 2

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_9 and not isNil(var_36_7) then
				local var_36_10 = (arg_33_1.time_ - var_36_8) / var_36_9

				if arg_33_1.var_.actorSpriteComps10097 then
					for iter_36_1, iter_36_2 in pairs(arg_33_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_36_2 then
							if arg_33_1.isInRecall_ then
								local var_36_11 = Mathf.Lerp(iter_36_2.color.r, arg_33_1.hightColor2.r, var_36_10)
								local var_36_12 = Mathf.Lerp(iter_36_2.color.g, arg_33_1.hightColor2.g, var_36_10)
								local var_36_13 = Mathf.Lerp(iter_36_2.color.b, arg_33_1.hightColor2.b, var_36_10)

								iter_36_2.color = Color.New(var_36_11, var_36_12, var_36_13)
							else
								local var_36_14 = Mathf.Lerp(iter_36_2.color.r, 0.5, var_36_10)

								iter_36_2.color = Color.New(var_36_14, var_36_14, var_36_14)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_8 + var_36_9 and arg_33_1.time_ < var_36_8 + var_36_9 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps10097 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_36_4 then
						if arg_33_1.isInRecall_ then
							iter_36_4.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10097 = nil
			end

			local var_36_15 = arg_33_1.actors_["10096"]
			local var_36_16 = 0

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.actorSpriteComps10096 == nil then
				arg_33_1.var_.actorSpriteComps10096 = var_36_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_17 = 2

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_17 and not isNil(var_36_15) then
				local var_36_18 = (arg_33_1.time_ - var_36_16) / var_36_17

				if arg_33_1.var_.actorSpriteComps10096 then
					for iter_36_5, iter_36_6 in pairs(arg_33_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_36_6 then
							if arg_33_1.isInRecall_ then
								local var_36_19 = Mathf.Lerp(iter_36_6.color.r, arg_33_1.hightColor1.r, var_36_18)
								local var_36_20 = Mathf.Lerp(iter_36_6.color.g, arg_33_1.hightColor1.g, var_36_18)
								local var_36_21 = Mathf.Lerp(iter_36_6.color.b, arg_33_1.hightColor1.b, var_36_18)

								iter_36_6.color = Color.New(var_36_19, var_36_20, var_36_21)
							else
								local var_36_22 = Mathf.Lerp(iter_36_6.color.r, 1, var_36_18)

								iter_36_6.color = Color.New(var_36_22, var_36_22, var_36_22)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_16 + var_36_17 and arg_33_1.time_ < var_36_16 + var_36_17 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.actorSpriteComps10096 then
				for iter_36_7, iter_36_8 in pairs(arg_33_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_36_8 then
						if arg_33_1.isInRecall_ then
							iter_36_8.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10096 = nil
			end

			local var_36_23 = 0
			local var_36_24 = 0.275

			if var_36_23 < arg_33_1.time_ and arg_33_1.time_ <= var_36_23 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_25 = arg_33_1:FormatText(StoryNameCfg[36].name)

				arg_33_1.leftNameTxt_.text = var_36_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_26 = arg_33_1:GetWordFromCfg(413102008)
				local var_36_27 = arg_33_1:FormatText(var_36_26.content)

				arg_33_1.text_.text = var_36_27

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_28 = 11
				local var_36_29 = utf8.len(var_36_27)
				local var_36_30 = var_36_28 <= 0 and var_36_24 or var_36_24 * (var_36_29 / var_36_28)

				if var_36_30 > 0 and var_36_24 < var_36_30 then
					arg_33_1.talkMaxDuration = var_36_30

					if var_36_30 + var_36_23 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_30 + var_36_23
					end
				end

				arg_33_1.text_.text = var_36_27
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102008", "story_v_out_413102.awb") ~= 0 then
					local var_36_31 = manager.audio:GetVoiceLength("story_v_out_413102", "413102008", "story_v_out_413102.awb") / 1000

					if var_36_31 + var_36_23 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_31 + var_36_23
					end

					if var_36_26.prefab_name ~= "" and arg_33_1.actors_[var_36_26.prefab_name] ~= nil then
						local var_36_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_26.prefab_name].transform, "story_v_out_413102", "413102008", "story_v_out_413102.awb")

						arg_33_1:RecordAudio("413102008", var_36_32)
						arg_33_1:RecordAudio("413102008", var_36_32)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_413102", "413102008", "story_v_out_413102.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_413102", "413102008", "story_v_out_413102.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_33 = math.max(var_36_24, arg_33_1.talkMaxDuration)

			if var_36_23 <= arg_33_1.time_ and arg_33_1.time_ < var_36_23 + var_36_33 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_23) / var_36_33

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_23 + var_36_33 and arg_33_1.time_ < var_36_23 + var_36_33 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play413102009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 413102009
		arg_37_1.duration_ = 23.07

		local var_37_0 = {
			zh = 9.3,
			ja = 23.066
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
				arg_37_0:Play413102010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10097"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps10097 == nil then
				arg_37_1.var_.actorSpriteComps10097 = var_40_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_2 = 2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.actorSpriteComps10097 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_40_1 then
							if arg_37_1.isInRecall_ then
								local var_40_4 = Mathf.Lerp(iter_40_1.color.r, arg_37_1.hightColor2.r, var_40_3)
								local var_40_5 = Mathf.Lerp(iter_40_1.color.g, arg_37_1.hightColor2.g, var_40_3)
								local var_40_6 = Mathf.Lerp(iter_40_1.color.b, arg_37_1.hightColor2.b, var_40_3)

								iter_40_1.color = Color.New(var_40_4, var_40_5, var_40_6)
							else
								local var_40_7 = Mathf.Lerp(iter_40_1.color.r, 0.5, var_40_3)

								iter_40_1.color = Color.New(var_40_7, var_40_7, var_40_7)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps10097 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_40_3 then
						if arg_37_1.isInRecall_ then
							iter_40_3.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10097 = nil
			end

			local var_40_8 = arg_37_1.actors_["10096"]
			local var_40_9 = 0

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps10096 == nil then
				arg_37_1.var_.actorSpriteComps10096 = var_40_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_10 = 2

			if var_40_9 <= arg_37_1.time_ and arg_37_1.time_ < var_40_9 + var_40_10 and not isNil(var_40_8) then
				local var_40_11 = (arg_37_1.time_ - var_40_9) / var_40_10

				if arg_37_1.var_.actorSpriteComps10096 then
					for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_40_5 then
							if arg_37_1.isInRecall_ then
								local var_40_12 = Mathf.Lerp(iter_40_5.color.r, arg_37_1.hightColor1.r, var_40_11)
								local var_40_13 = Mathf.Lerp(iter_40_5.color.g, arg_37_1.hightColor1.g, var_40_11)
								local var_40_14 = Mathf.Lerp(iter_40_5.color.b, arg_37_1.hightColor1.b, var_40_11)

								iter_40_5.color = Color.New(var_40_12, var_40_13, var_40_14)
							else
								local var_40_15 = Mathf.Lerp(iter_40_5.color.r, 1, var_40_11)

								iter_40_5.color = Color.New(var_40_15, var_40_15, var_40_15)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_9 + var_40_10 and arg_37_1.time_ < var_40_9 + var_40_10 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps10096 then
				for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_40_7 then
						if arg_37_1.isInRecall_ then
							iter_40_7.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10096 = nil
			end

			local var_40_16 = 0
			local var_40_17 = 0.625

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_18 = arg_37_1:FormatText(StoryNameCfg[36].name)

				arg_37_1.leftNameTxt_.text = var_40_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_19 = arg_37_1:GetWordFromCfg(413102009)
				local var_40_20 = arg_37_1:FormatText(var_40_19.content)

				arg_37_1.text_.text = var_40_20

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_21 = 25
				local var_40_22 = utf8.len(var_40_20)
				local var_40_23 = var_40_21 <= 0 and var_40_17 or var_40_17 * (var_40_22 / var_40_21)

				if var_40_23 > 0 and var_40_17 < var_40_23 then
					arg_37_1.talkMaxDuration = var_40_23

					if var_40_23 + var_40_16 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_16
					end
				end

				arg_37_1.text_.text = var_40_20
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102009", "story_v_out_413102.awb") ~= 0 then
					local var_40_24 = manager.audio:GetVoiceLength("story_v_out_413102", "413102009", "story_v_out_413102.awb") / 1000

					if var_40_24 + var_40_16 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_24 + var_40_16
					end

					if var_40_19.prefab_name ~= "" and arg_37_1.actors_[var_40_19.prefab_name] ~= nil then
						local var_40_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_19.prefab_name].transform, "story_v_out_413102", "413102009", "story_v_out_413102.awb")

						arg_37_1:RecordAudio("413102009", var_40_25)
						arg_37_1:RecordAudio("413102009", var_40_25)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_413102", "413102009", "story_v_out_413102.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_413102", "413102009", "story_v_out_413102.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_26 = math.max(var_40_17, arg_37_1.talkMaxDuration)

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_26 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_16) / var_40_26

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_16 + var_40_26 and arg_37_1.time_ < var_40_16 + var_40_26 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play413102010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 413102010
		arg_41_1.duration_ = 6.24

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play413102011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10097"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos10097 = var_44_0.localPosition
				var_44_0.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10097", 6)

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
				local var_44_6 = Vector3.New(1500, -350, -180)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10097, var_44_6, var_44_5)
			end

			if arg_41_1.time_ >= var_44_1 + var_44_4 and arg_41_1.time_ < var_44_1 + var_44_4 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(1500, -350, -180)
			end

			local var_44_7 = arg_41_1.actors_["10096"].transform
			local var_44_8 = 0

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.var_.moveOldPos10096 = var_44_7.localPosition
				var_44_7.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10096", 6)

				local var_44_9 = var_44_7.childCount

				for iter_44_1 = 0, var_44_9 - 1 do
					local var_44_10 = var_44_7:GetChild(iter_44_1)

					if var_44_10.name == "" or not string.find(var_44_10.name, "split") then
						var_44_10.gameObject:SetActive(true)
					else
						var_44_10.gameObject:SetActive(false)
					end
				end
			end

			local var_44_11 = 0.001

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_11 then
				local var_44_12 = (arg_41_1.time_ - var_44_8) / var_44_11
				local var_44_13 = Vector3.New(1500, -350, -210)

				var_44_7.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10096, var_44_13, var_44_12)
			end

			if arg_41_1.time_ >= var_44_8 + var_44_11 and arg_41_1.time_ < var_44_8 + var_44_11 + arg_44_0 then
				var_44_7.localPosition = Vector3.New(1500, -350, -210)
			end

			local var_44_14 = 0

			if var_44_14 < arg_41_1.time_ and arg_41_1.time_ <= var_44_14 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_15 = 1.1

			if var_44_14 <= arg_41_1.time_ and arg_41_1.time_ < var_44_14 + var_44_15 then
				local var_44_16 = (arg_41_1.time_ - var_44_14) / var_44_15
				local var_44_17 = Color.New(0, 0, 0)

				var_44_17.a = Mathf.Lerp(1, 0, var_44_16)
				arg_41_1.mask_.color = var_44_17
			end

			if arg_41_1.time_ >= var_44_14 + var_44_15 and arg_41_1.time_ < var_44_14 + var_44_15 + arg_44_0 then
				local var_44_18 = Color.New(0, 0, 0)
				local var_44_19 = 0

				arg_41_1.mask_.enabled = false
				var_44_18.a = var_44_19
				arg_41_1.mask_.color = var_44_18
			end

			local var_44_20 = manager.ui.mainCamera.transform
			local var_44_21 = 0.266666666666667

			if var_44_21 < arg_41_1.time_ and arg_41_1.time_ <= var_44_21 + arg_44_0 then
				local var_44_22 = arg_41_1.var_.effect123123
				local var_44_23
				local var_44_24 = var_44_20

				if not var_44_22 then
					var_44_22 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_44_24)
					var_44_22.name = "123"
					arg_41_1.var_.effect123123 = var_44_22
				else
					var_44_22.transform:SetParent(var_44_24)
				end

				var_44_22.transform.localPosition = Vector3.New(0, 0, 0)
				var_44_22.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_44_25 = manager.ui.mainCamera.transform
			local var_44_26 = 1.24166666666667

			if var_44_26 < arg_41_1.time_ and arg_41_1.time_ <= var_44_26 + arg_44_0 then
				local var_44_27 = arg_41_1.var_.effect123123

				if var_44_27 then
					Object.Destroy(var_44_27)

					arg_41_1.var_.effect123123 = nil
				end
			end

			if arg_41_1.frameCnt_ <= 1 then
				arg_41_1.dialog_:SetActive(false)
			end

			local var_44_28 = 1.24166666666667
			local var_44_29 = 0.875

			if var_44_28 < arg_41_1.time_ and arg_41_1.time_ <= var_44_28 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_30 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_30:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_31 = arg_41_1:GetWordFromCfg(413102010)
				local var_44_32 = arg_41_1:FormatText(var_44_31.content)

				arg_41_1.text_.text = var_44_32

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_33 = 35
				local var_44_34 = utf8.len(var_44_32)
				local var_44_35 = var_44_33 <= 0 and var_44_29 or var_44_29 * (var_44_34 / var_44_33)

				if var_44_35 > 0 and var_44_29 < var_44_35 then
					arg_41_1.talkMaxDuration = var_44_35
					var_44_28 = var_44_28 + 0.3

					if var_44_35 + var_44_28 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_35 + var_44_28
					end
				end

				arg_41_1.text_.text = var_44_32
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_36 = var_44_28 + 0.3
			local var_44_37 = math.max(var_44_29, arg_41_1.talkMaxDuration)

			if var_44_36 <= arg_41_1.time_ and arg_41_1.time_ < var_44_36 + var_44_37 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_36) / var_44_37

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_36 + var_44_37 and arg_41_1.time_ < var_44_36 + var_44_37 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
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
	Play413102011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 413102011
		arg_47_1.duration_ = 9.37

		local var_47_0 = {
			zh = 9.366,
			ja = 4.966
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
				arg_47_0:Play413102012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["10097"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos10097 = var_50_0.localPosition
				var_50_0.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("10097", 2)

				local var_50_2 = var_50_0.childCount

				for iter_50_0 = 0, var_50_2 - 1 do
					local var_50_3 = var_50_0:GetChild(iter_50_0)

					if var_50_3.name == "split_3" or not string.find(var_50_3.name, "split") then
						var_50_3.gameObject:SetActive(true)
					else
						var_50_3.gameObject:SetActive(false)
					end
				end
			end

			local var_50_4 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_4 then
				local var_50_5 = (arg_47_1.time_ - var_50_1) / var_50_4
				local var_50_6 = Vector3.New(-390, -350, -180)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10097, var_50_6, var_50_5)
			end

			if arg_47_1.time_ >= var_50_1 + var_50_4 and arg_47_1.time_ < var_50_1 + var_50_4 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_50_7 = arg_47_1.actors_["10097"]
			local var_50_8 = 0

			if var_50_8 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 and not isNil(var_50_7) and arg_47_1.var_.actorSpriteComps10097 == nil then
				arg_47_1.var_.actorSpriteComps10097 = var_50_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_9 = 2

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_9 and not isNil(var_50_7) then
				local var_50_10 = (arg_47_1.time_ - var_50_8) / var_50_9

				if arg_47_1.var_.actorSpriteComps10097 then
					for iter_50_1, iter_50_2 in pairs(arg_47_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_50_2 then
							if arg_47_1.isInRecall_ then
								local var_50_11 = Mathf.Lerp(iter_50_2.color.r, arg_47_1.hightColor1.r, var_50_10)
								local var_50_12 = Mathf.Lerp(iter_50_2.color.g, arg_47_1.hightColor1.g, var_50_10)
								local var_50_13 = Mathf.Lerp(iter_50_2.color.b, arg_47_1.hightColor1.b, var_50_10)

								iter_50_2.color = Color.New(var_50_11, var_50_12, var_50_13)
							else
								local var_50_14 = Mathf.Lerp(iter_50_2.color.r, 1, var_50_10)

								iter_50_2.color = Color.New(var_50_14, var_50_14, var_50_14)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= var_50_8 + var_50_9 and arg_47_1.time_ < var_50_8 + var_50_9 + arg_50_0 and not isNil(var_50_7) and arg_47_1.var_.actorSpriteComps10097 then
				for iter_50_3, iter_50_4 in pairs(arg_47_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_50_4 then
						if arg_47_1.isInRecall_ then
							iter_50_4.color = arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_50_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_47_1.var_.actorSpriteComps10097 = nil
			end

			local var_50_15 = arg_47_1.actors_["10096"]
			local var_50_16 = 0

			if var_50_16 < arg_47_1.time_ and arg_47_1.time_ <= var_50_16 + arg_50_0 and not isNil(var_50_15) and arg_47_1.var_.actorSpriteComps10096 == nil then
				arg_47_1.var_.actorSpriteComps10096 = var_50_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_17 = 2

			if var_50_16 <= arg_47_1.time_ and arg_47_1.time_ < var_50_16 + var_50_17 and not isNil(var_50_15) then
				local var_50_18 = (arg_47_1.time_ - var_50_16) / var_50_17

				if arg_47_1.var_.actorSpriteComps10096 then
					for iter_50_5, iter_50_6 in pairs(arg_47_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_50_6 then
							if arg_47_1.isInRecall_ then
								local var_50_19 = Mathf.Lerp(iter_50_6.color.r, arg_47_1.hightColor2.r, var_50_18)
								local var_50_20 = Mathf.Lerp(iter_50_6.color.g, arg_47_1.hightColor2.g, var_50_18)
								local var_50_21 = Mathf.Lerp(iter_50_6.color.b, arg_47_1.hightColor2.b, var_50_18)

								iter_50_6.color = Color.New(var_50_19, var_50_20, var_50_21)
							else
								local var_50_22 = Mathf.Lerp(iter_50_6.color.r, 0.5, var_50_18)

								iter_50_6.color = Color.New(var_50_22, var_50_22, var_50_22)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= var_50_16 + var_50_17 and arg_47_1.time_ < var_50_16 + var_50_17 + arg_50_0 and not isNil(var_50_15) and arg_47_1.var_.actorSpriteComps10096 then
				for iter_50_7, iter_50_8 in pairs(arg_47_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_50_8 then
						if arg_47_1.isInRecall_ then
							iter_50_8.color = arg_47_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_50_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_47_1.var_.actorSpriteComps10096 = nil
			end

			local var_50_23 = 0
			local var_50_24 = 0.425

			if var_50_23 < arg_47_1.time_ and arg_47_1.time_ <= var_50_23 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_25 = arg_47_1:FormatText(StoryNameCfg[1001].name)

				arg_47_1.leftNameTxt_.text = var_50_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_26 = arg_47_1:GetWordFromCfg(413102011)
				local var_50_27 = arg_47_1:FormatText(var_50_26.content)

				arg_47_1.text_.text = var_50_27

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_28 = 17
				local var_50_29 = utf8.len(var_50_27)
				local var_50_30 = var_50_28 <= 0 and var_50_24 or var_50_24 * (var_50_29 / var_50_28)

				if var_50_30 > 0 and var_50_24 < var_50_30 then
					arg_47_1.talkMaxDuration = var_50_30

					if var_50_30 + var_50_23 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_30 + var_50_23
					end
				end

				arg_47_1.text_.text = var_50_27
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102011", "story_v_out_413102.awb") ~= 0 then
					local var_50_31 = manager.audio:GetVoiceLength("story_v_out_413102", "413102011", "story_v_out_413102.awb") / 1000

					if var_50_31 + var_50_23 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_31 + var_50_23
					end

					if var_50_26.prefab_name ~= "" and arg_47_1.actors_[var_50_26.prefab_name] ~= nil then
						local var_50_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_26.prefab_name].transform, "story_v_out_413102", "413102011", "story_v_out_413102.awb")

						arg_47_1:RecordAudio("413102011", var_50_32)
						arg_47_1:RecordAudio("413102011", var_50_32)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_413102", "413102011", "story_v_out_413102.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_413102", "413102011", "story_v_out_413102.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_33 = math.max(var_50_24, arg_47_1.talkMaxDuration)

			if var_50_23 <= arg_47_1.time_ and arg_47_1.time_ < var_50_23 + var_50_33 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_23) / var_50_33

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_23 + var_50_33 and arg_47_1.time_ < var_50_23 + var_50_33 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play413102012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 413102012
		arg_51_1.duration_ = 5.87

		local var_51_0 = {
			zh = 5.6,
			ja = 5.866
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
				arg_51_0:Play413102013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["10097"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.actorSpriteComps10097 == nil then
				arg_51_1.var_.actorSpriteComps10097 = var_54_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_2 = 2

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.actorSpriteComps10097 then
					for iter_54_0, iter_54_1 in pairs(arg_51_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_54_1 then
							if arg_51_1.isInRecall_ then
								local var_54_4 = Mathf.Lerp(iter_54_1.color.r, arg_51_1.hightColor2.r, var_54_3)
								local var_54_5 = Mathf.Lerp(iter_54_1.color.g, arg_51_1.hightColor2.g, var_54_3)
								local var_54_6 = Mathf.Lerp(iter_54_1.color.b, arg_51_1.hightColor2.b, var_54_3)

								iter_54_1.color = Color.New(var_54_4, var_54_5, var_54_6)
							else
								local var_54_7 = Mathf.Lerp(iter_54_1.color.r, 0.5, var_54_3)

								iter_54_1.color = Color.New(var_54_7, var_54_7, var_54_7)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.actorSpriteComps10097 then
				for iter_54_2, iter_54_3 in pairs(arg_51_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_54_3 then
						if arg_51_1.isInRecall_ then
							iter_54_3.color = arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_54_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_51_1.var_.actorSpriteComps10097 = nil
			end

			local var_54_8 = arg_51_1.actors_["10096"]
			local var_54_9 = 0

			if var_54_9 < arg_51_1.time_ and arg_51_1.time_ <= var_54_9 + arg_54_0 and not isNil(var_54_8) and arg_51_1.var_.actorSpriteComps10096 == nil then
				arg_51_1.var_.actorSpriteComps10096 = var_54_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_10 = 2

			if var_54_9 <= arg_51_1.time_ and arg_51_1.time_ < var_54_9 + var_54_10 and not isNil(var_54_8) then
				local var_54_11 = (arg_51_1.time_ - var_54_9) / var_54_10

				if arg_51_1.var_.actorSpriteComps10096 then
					for iter_54_4, iter_54_5 in pairs(arg_51_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_54_5 then
							if arg_51_1.isInRecall_ then
								local var_54_12 = Mathf.Lerp(iter_54_5.color.r, arg_51_1.hightColor1.r, var_54_11)
								local var_54_13 = Mathf.Lerp(iter_54_5.color.g, arg_51_1.hightColor1.g, var_54_11)
								local var_54_14 = Mathf.Lerp(iter_54_5.color.b, arg_51_1.hightColor1.b, var_54_11)

								iter_54_5.color = Color.New(var_54_12, var_54_13, var_54_14)
							else
								local var_54_15 = Mathf.Lerp(iter_54_5.color.r, 1, var_54_11)

								iter_54_5.color = Color.New(var_54_15, var_54_15, var_54_15)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= var_54_9 + var_54_10 and arg_51_1.time_ < var_54_9 + var_54_10 + arg_54_0 and not isNil(var_54_8) and arg_51_1.var_.actorSpriteComps10096 then
				for iter_54_6, iter_54_7 in pairs(arg_51_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_54_7 then
						if arg_51_1.isInRecall_ then
							iter_54_7.color = arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_54_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_51_1.var_.actorSpriteComps10096 = nil
			end

			local var_54_16 = arg_51_1.actors_["10096"].transform
			local var_54_17 = 0

			if var_54_17 < arg_51_1.time_ and arg_51_1.time_ <= var_54_17 + arg_54_0 then
				arg_51_1.var_.moveOldPos10096 = var_54_16.localPosition
				var_54_16.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("10096", 4)

				local var_54_18 = var_54_16.childCount

				for iter_54_8 = 0, var_54_18 - 1 do
					local var_54_19 = var_54_16:GetChild(iter_54_8)

					if var_54_19.name == "" or not string.find(var_54_19.name, "split") then
						var_54_19.gameObject:SetActive(true)
					else
						var_54_19.gameObject:SetActive(false)
					end
				end
			end

			local var_54_20 = 0.001

			if var_54_17 <= arg_51_1.time_ and arg_51_1.time_ < var_54_17 + var_54_20 then
				local var_54_21 = (arg_51_1.time_ - var_54_17) / var_54_20
				local var_54_22 = Vector3.New(390, -350, -210)

				var_54_16.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10096, var_54_22, var_54_21)
			end

			if arg_51_1.time_ >= var_54_17 + var_54_20 and arg_51_1.time_ < var_54_17 + var_54_20 + arg_54_0 then
				var_54_16.localPosition = Vector3.New(390, -350, -210)
			end

			local var_54_23 = 0
			local var_54_24 = 0.25

			if var_54_23 < arg_51_1.time_ and arg_51_1.time_ <= var_54_23 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_25 = arg_51_1:FormatText(StoryNameCfg[36].name)

				arg_51_1.leftNameTxt_.text = var_54_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_26 = arg_51_1:GetWordFromCfg(413102012)
				local var_54_27 = arg_51_1:FormatText(var_54_26.content)

				arg_51_1.text_.text = var_54_27

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_28 = 10
				local var_54_29 = utf8.len(var_54_27)
				local var_54_30 = var_54_28 <= 0 and var_54_24 or var_54_24 * (var_54_29 / var_54_28)

				if var_54_30 > 0 and var_54_24 < var_54_30 then
					arg_51_1.talkMaxDuration = var_54_30

					if var_54_30 + var_54_23 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_30 + var_54_23
					end
				end

				arg_51_1.text_.text = var_54_27
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102012", "story_v_out_413102.awb") ~= 0 then
					local var_54_31 = manager.audio:GetVoiceLength("story_v_out_413102", "413102012", "story_v_out_413102.awb") / 1000

					if var_54_31 + var_54_23 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_31 + var_54_23
					end

					if var_54_26.prefab_name ~= "" and arg_51_1.actors_[var_54_26.prefab_name] ~= nil then
						local var_54_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_26.prefab_name].transform, "story_v_out_413102", "413102012", "story_v_out_413102.awb")

						arg_51_1:RecordAudio("413102012", var_54_32)
						arg_51_1:RecordAudio("413102012", var_54_32)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_413102", "413102012", "story_v_out_413102.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_413102", "413102012", "story_v_out_413102.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_33 = math.max(var_54_24, arg_51_1.talkMaxDuration)

			if var_54_23 <= arg_51_1.time_ and arg_51_1.time_ < var_54_23 + var_54_33 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_23) / var_54_33

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_23 + var_54_33 and arg_51_1.time_ < var_54_23 + var_54_33 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play413102013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 413102013
		arg_55_1.duration_ = 5.67

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play413102014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["10097"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos10097 = var_58_0.localPosition
				var_58_0.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("10097", 6)

				local var_58_2 = var_58_0.childCount

				for iter_58_0 = 0, var_58_2 - 1 do
					local var_58_3 = var_58_0:GetChild(iter_58_0)

					if var_58_3.name == "" or not string.find(var_58_3.name, "split") then
						var_58_3.gameObject:SetActive(true)
					else
						var_58_3.gameObject:SetActive(false)
					end
				end
			end

			local var_58_4 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_4 then
				local var_58_5 = (arg_55_1.time_ - var_58_1) / var_58_4
				local var_58_6 = Vector3.New(1500, -350, -180)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10097, var_58_6, var_58_5)
			end

			if arg_55_1.time_ >= var_58_1 + var_58_4 and arg_55_1.time_ < var_58_1 + var_58_4 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(1500, -350, -180)
			end

			local var_58_7 = arg_55_1.actors_["10096"].transform
			local var_58_8 = 0

			if var_58_8 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 then
				arg_55_1.var_.moveOldPos10096 = var_58_7.localPosition
				var_58_7.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("10096", 6)

				local var_58_9 = var_58_7.childCount

				for iter_58_1 = 0, var_58_9 - 1 do
					local var_58_10 = var_58_7:GetChild(iter_58_1)

					if var_58_10.name == "" or not string.find(var_58_10.name, "split") then
						var_58_10.gameObject:SetActive(true)
					else
						var_58_10.gameObject:SetActive(false)
					end
				end
			end

			local var_58_11 = 0.001

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_11 then
				local var_58_12 = (arg_55_1.time_ - var_58_8) / var_58_11
				local var_58_13 = Vector3.New(1500, -350, -210)

				var_58_7.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10096, var_58_13, var_58_12)
			end

			if arg_55_1.time_ >= var_58_8 + var_58_11 and arg_55_1.time_ < var_58_8 + var_58_11 + arg_58_0 then
				var_58_7.localPosition = Vector3.New(1500, -350, -210)
			end

			local var_58_14 = arg_55_1.actors_["10097"]
			local var_58_15 = 0

			if var_58_15 < arg_55_1.time_ and arg_55_1.time_ <= var_58_15 + arg_58_0 and not isNil(var_58_14) and arg_55_1.var_.actorSpriteComps10097 == nil then
				arg_55_1.var_.actorSpriteComps10097 = var_58_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_16 = 2

			if var_58_15 <= arg_55_1.time_ and arg_55_1.time_ < var_58_15 + var_58_16 and not isNil(var_58_14) then
				local var_58_17 = (arg_55_1.time_ - var_58_15) / var_58_16

				if arg_55_1.var_.actorSpriteComps10097 then
					for iter_58_2, iter_58_3 in pairs(arg_55_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_58_3 then
							if arg_55_1.isInRecall_ then
								local var_58_18 = Mathf.Lerp(iter_58_3.color.r, arg_55_1.hightColor2.r, var_58_17)
								local var_58_19 = Mathf.Lerp(iter_58_3.color.g, arg_55_1.hightColor2.g, var_58_17)
								local var_58_20 = Mathf.Lerp(iter_58_3.color.b, arg_55_1.hightColor2.b, var_58_17)

								iter_58_3.color = Color.New(var_58_18, var_58_19, var_58_20)
							else
								local var_58_21 = Mathf.Lerp(iter_58_3.color.r, 0.5, var_58_17)

								iter_58_3.color = Color.New(var_58_21, var_58_21, var_58_21)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= var_58_15 + var_58_16 and arg_55_1.time_ < var_58_15 + var_58_16 + arg_58_0 and not isNil(var_58_14) and arg_55_1.var_.actorSpriteComps10097 then
				for iter_58_4, iter_58_5 in pairs(arg_55_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_58_5 then
						if arg_55_1.isInRecall_ then
							iter_58_5.color = arg_55_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_58_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_55_1.var_.actorSpriteComps10097 = nil
			end

			local var_58_22 = arg_55_1.actors_["10096"]
			local var_58_23 = 0

			if var_58_23 < arg_55_1.time_ and arg_55_1.time_ <= var_58_23 + arg_58_0 and not isNil(var_58_22) and arg_55_1.var_.actorSpriteComps10096 == nil then
				arg_55_1.var_.actorSpriteComps10096 = var_58_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_24 = 2

			if var_58_23 <= arg_55_1.time_ and arg_55_1.time_ < var_58_23 + var_58_24 and not isNil(var_58_22) then
				local var_58_25 = (arg_55_1.time_ - var_58_23) / var_58_24

				if arg_55_1.var_.actorSpriteComps10096 then
					for iter_58_6, iter_58_7 in pairs(arg_55_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_58_7 then
							if arg_55_1.isInRecall_ then
								local var_58_26 = Mathf.Lerp(iter_58_7.color.r, arg_55_1.hightColor2.r, var_58_25)
								local var_58_27 = Mathf.Lerp(iter_58_7.color.g, arg_55_1.hightColor2.g, var_58_25)
								local var_58_28 = Mathf.Lerp(iter_58_7.color.b, arg_55_1.hightColor2.b, var_58_25)

								iter_58_7.color = Color.New(var_58_26, var_58_27, var_58_28)
							else
								local var_58_29 = Mathf.Lerp(iter_58_7.color.r, 0.5, var_58_25)

								iter_58_7.color = Color.New(var_58_29, var_58_29, var_58_29)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= var_58_23 + var_58_24 and arg_55_1.time_ < var_58_23 + var_58_24 + arg_58_0 and not isNil(var_58_22) and arg_55_1.var_.actorSpriteComps10096 then
				for iter_58_8, iter_58_9 in pairs(arg_55_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_58_9 then
						if arg_55_1.isInRecall_ then
							iter_58_9.color = arg_55_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_58_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_55_1.var_.actorSpriteComps10096 = nil
			end

			local var_58_30 = manager.ui.mainCamera.transform
			local var_58_31 = 0

			if var_58_31 < arg_55_1.time_ and arg_55_1.time_ <= var_58_31 + arg_58_0 then
				local var_58_32 = arg_55_1.var_.effect234
				local var_58_33
				local var_58_34 = var_58_30

				if not var_58_32 then
					var_58_32 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_red"), var_58_34)
					var_58_32.name = "234"
					arg_55_1.var_.effect234 = var_58_32
				else
					var_58_32.transform:SetParent(var_58_34)
				end

				var_58_32.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_58_32.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_58_35 = manager.ui.mainCamera.transform
			local var_58_36 = 1

			if var_58_36 < arg_55_1.time_ and arg_55_1.time_ <= var_58_36 + arg_58_0 then
				local var_58_37 = arg_55_1.var_.effect234

				if var_58_37 then
					Object.Destroy(var_58_37)

					arg_55_1.var_.effect234 = nil
				end
			end

			local var_58_38 = 0

			if var_58_38 < arg_55_1.time_ and arg_55_1.time_ <= var_58_38 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_39 = 0.366666666666667

			if var_58_38 <= arg_55_1.time_ and arg_55_1.time_ < var_58_38 + var_58_39 then
				local var_58_40 = (arg_55_1.time_ - var_58_38) / var_58_39
				local var_58_41 = Color.New(1, 1, 1)

				var_58_41.a = Mathf.Lerp(1, 0, var_58_40)
				arg_55_1.mask_.color = var_58_41
			end

			if arg_55_1.time_ >= var_58_38 + var_58_39 and arg_55_1.time_ < var_58_38 + var_58_39 + arg_58_0 then
				local var_58_42 = Color.New(1, 1, 1)
				local var_58_43 = 0

				arg_55_1.mask_.enabled = false
				var_58_42.a = var_58_43
				arg_55_1.mask_.color = var_58_42
			end

			if arg_55_1.frameCnt_ <= 1 then
				arg_55_1.dialog_:SetActive(false)
			end

			local var_58_44 = 0.666666666666667
			local var_58_45 = 1.2

			if var_58_44 < arg_55_1.time_ and arg_55_1.time_ <= var_58_44 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0

				arg_55_1.dialog_:SetActive(true)

				arg_55_1.dialogCg_.alpha = 0

				local var_58_46 = LeanTween.value(arg_55_1.dialog_, 0, 1, 0.3)

				var_58_46:setOnUpdate(LuaHelper.FloatAction(function(arg_59_0)
					arg_55_1.dialogCg_.alpha = arg_59_0
				end))
				var_58_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_55_1.dialog_)
					var_58_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_55_1.duration_ = arg_55_1.duration_ + 0.3

				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_47 = arg_55_1:GetWordFromCfg(413102013)
				local var_58_48 = arg_55_1:FormatText(var_58_47.content)

				arg_55_1.text_.text = var_58_48

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_49 = 48
				local var_58_50 = utf8.len(var_58_48)
				local var_58_51 = var_58_49 <= 0 and var_58_45 or var_58_45 * (var_58_50 / var_58_49)

				if var_58_51 > 0 and var_58_45 < var_58_51 then
					arg_55_1.talkMaxDuration = var_58_51
					var_58_44 = var_58_44 + 0.3

					if var_58_51 + var_58_44 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_51 + var_58_44
					end
				end

				arg_55_1.text_.text = var_58_48
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_52 = var_58_44 + 0.3
			local var_58_53 = math.max(var_58_45, arg_55_1.talkMaxDuration)

			if var_58_52 <= arg_55_1.time_ and arg_55_1.time_ < var_58_52 + var_58_53 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_52) / var_58_53

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_52 + var_58_53 and arg_55_1.time_ < var_58_52 + var_58_53 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play413102014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 413102014
		arg_61_1.duration_ = 7.8

		local var_61_0 = {
			zh = 6.966,
			ja = 7.8
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
				arg_61_0:Play413102015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10096"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos10096 = var_64_0.localPosition
				var_64_0.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10096", 3)

				local var_64_2 = var_64_0.childCount

				for iter_64_0 = 0, var_64_2 - 1 do
					local var_64_3 = var_64_0:GetChild(iter_64_0)

					if var_64_3.name == "" or not string.find(var_64_3.name, "split") then
						var_64_3.gameObject:SetActive(true)
					else
						var_64_3.gameObject:SetActive(false)
					end
				end
			end

			local var_64_4 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_4 then
				local var_64_5 = (arg_61_1.time_ - var_64_1) / var_64_4
				local var_64_6 = Vector3.New(0, -350, -210)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10096, var_64_6, var_64_5)
			end

			if arg_61_1.time_ >= var_64_1 + var_64_4 and arg_61_1.time_ < var_64_1 + var_64_4 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0, -350, -210)
			end

			local var_64_7 = arg_61_1.actors_["10096"]
			local var_64_8 = 0

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 and not isNil(var_64_7) and arg_61_1.var_.actorSpriteComps10096 == nil then
				arg_61_1.var_.actorSpriteComps10096 = var_64_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_9 = 2

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_9 and not isNil(var_64_7) then
				local var_64_10 = (arg_61_1.time_ - var_64_8) / var_64_9

				if arg_61_1.var_.actorSpriteComps10096 then
					for iter_64_1, iter_64_2 in pairs(arg_61_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_64_2 then
							if arg_61_1.isInRecall_ then
								local var_64_11 = Mathf.Lerp(iter_64_2.color.r, arg_61_1.hightColor1.r, var_64_10)
								local var_64_12 = Mathf.Lerp(iter_64_2.color.g, arg_61_1.hightColor1.g, var_64_10)
								local var_64_13 = Mathf.Lerp(iter_64_2.color.b, arg_61_1.hightColor1.b, var_64_10)

								iter_64_2.color = Color.New(var_64_11, var_64_12, var_64_13)
							else
								local var_64_14 = Mathf.Lerp(iter_64_2.color.r, 1, var_64_10)

								iter_64_2.color = Color.New(var_64_14, var_64_14, var_64_14)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_8 + var_64_9 and arg_61_1.time_ < var_64_8 + var_64_9 + arg_64_0 and not isNil(var_64_7) and arg_61_1.var_.actorSpriteComps10096 then
				for iter_64_3, iter_64_4 in pairs(arg_61_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_64_4 then
						if arg_61_1.isInRecall_ then
							iter_64_4.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10096 = nil
			end

			local var_64_15 = 0
			local var_64_16 = 0.425

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_17 = arg_61_1:FormatText(StoryNameCfg[36].name)

				arg_61_1.leftNameTxt_.text = var_64_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_18 = arg_61_1:GetWordFromCfg(413102014)
				local var_64_19 = arg_61_1:FormatText(var_64_18.content)

				arg_61_1.text_.text = var_64_19

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_20 = 17
				local var_64_21 = utf8.len(var_64_19)
				local var_64_22 = var_64_20 <= 0 and var_64_16 or var_64_16 * (var_64_21 / var_64_20)

				if var_64_22 > 0 and var_64_16 < var_64_22 then
					arg_61_1.talkMaxDuration = var_64_22

					if var_64_22 + var_64_15 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_22 + var_64_15
					end
				end

				arg_61_1.text_.text = var_64_19
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102014", "story_v_out_413102.awb") ~= 0 then
					local var_64_23 = manager.audio:GetVoiceLength("story_v_out_413102", "413102014", "story_v_out_413102.awb") / 1000

					if var_64_23 + var_64_15 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_23 + var_64_15
					end

					if var_64_18.prefab_name ~= "" and arg_61_1.actors_[var_64_18.prefab_name] ~= nil then
						local var_64_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_18.prefab_name].transform, "story_v_out_413102", "413102014", "story_v_out_413102.awb")

						arg_61_1:RecordAudio("413102014", var_64_24)
						arg_61_1:RecordAudio("413102014", var_64_24)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_413102", "413102014", "story_v_out_413102.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_413102", "413102014", "story_v_out_413102.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_25 = math.max(var_64_16, arg_61_1.talkMaxDuration)

			if var_64_15 <= arg_61_1.time_ and arg_61_1.time_ < var_64_15 + var_64_25 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_15) / var_64_25

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_15 + var_64_25 and arg_61_1.time_ < var_64_15 + var_64_25 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play413102015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 413102015
		arg_65_1.duration_ = 9.13

		local var_65_0 = {
			zh = 4.433,
			ja = 9.133
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
				arg_65_0:Play413102016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10096"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos10096 = var_68_0.localPosition
				var_68_0.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10096", 3)

				local var_68_2 = var_68_0.childCount

				for iter_68_0 = 0, var_68_2 - 1 do
					local var_68_3 = var_68_0:GetChild(iter_68_0)

					if var_68_3.name == "" or not string.find(var_68_3.name, "split") then
						var_68_3.gameObject:SetActive(true)
					else
						var_68_3.gameObject:SetActive(false)
					end
				end
			end

			local var_68_4 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_4 then
				local var_68_5 = (arg_65_1.time_ - var_68_1) / var_68_4
				local var_68_6 = Vector3.New(0, -350, -210)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10096, var_68_6, var_68_5)
			end

			if arg_65_1.time_ >= var_68_1 + var_68_4 and arg_65_1.time_ < var_68_1 + var_68_4 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0, -350, -210)
			end

			local var_68_7 = arg_65_1.actors_["10096"]
			local var_68_8 = 0

			if var_68_8 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.actorSpriteComps10096 == nil then
				arg_65_1.var_.actorSpriteComps10096 = var_68_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_9 = 2

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_9 and not isNil(var_68_7) then
				local var_68_10 = (arg_65_1.time_ - var_68_8) / var_68_9

				if arg_65_1.var_.actorSpriteComps10096 then
					for iter_68_1, iter_68_2 in pairs(arg_65_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_68_2 then
							if arg_65_1.isInRecall_ then
								local var_68_11 = Mathf.Lerp(iter_68_2.color.r, arg_65_1.hightColor1.r, var_68_10)
								local var_68_12 = Mathf.Lerp(iter_68_2.color.g, arg_65_1.hightColor1.g, var_68_10)
								local var_68_13 = Mathf.Lerp(iter_68_2.color.b, arg_65_1.hightColor1.b, var_68_10)

								iter_68_2.color = Color.New(var_68_11, var_68_12, var_68_13)
							else
								local var_68_14 = Mathf.Lerp(iter_68_2.color.r, 1, var_68_10)

								iter_68_2.color = Color.New(var_68_14, var_68_14, var_68_14)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_8 + var_68_9 and arg_65_1.time_ < var_68_8 + var_68_9 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.actorSpriteComps10096 then
				for iter_68_3, iter_68_4 in pairs(arg_65_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_68_4 then
						if arg_65_1.isInRecall_ then
							iter_68_4.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10096 = nil
			end

			local var_68_15 = 0
			local var_68_16 = 0.375

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_17 = arg_65_1:FormatText(StoryNameCfg[36].name)

				arg_65_1.leftNameTxt_.text = var_68_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_18 = arg_65_1:GetWordFromCfg(413102015)
				local var_68_19 = arg_65_1:FormatText(var_68_18.content)

				arg_65_1.text_.text = var_68_19

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_20 = 15
				local var_68_21 = utf8.len(var_68_19)
				local var_68_22 = var_68_20 <= 0 and var_68_16 or var_68_16 * (var_68_21 / var_68_20)

				if var_68_22 > 0 and var_68_16 < var_68_22 then
					arg_65_1.talkMaxDuration = var_68_22

					if var_68_22 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_22 + var_68_15
					end
				end

				arg_65_1.text_.text = var_68_19
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102015", "story_v_out_413102.awb") ~= 0 then
					local var_68_23 = manager.audio:GetVoiceLength("story_v_out_413102", "413102015", "story_v_out_413102.awb") / 1000

					if var_68_23 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_23 + var_68_15
					end

					if var_68_18.prefab_name ~= "" and arg_65_1.actors_[var_68_18.prefab_name] ~= nil then
						local var_68_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_18.prefab_name].transform, "story_v_out_413102", "413102015", "story_v_out_413102.awb")

						arg_65_1:RecordAudio("413102015", var_68_24)
						arg_65_1:RecordAudio("413102015", var_68_24)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_413102", "413102015", "story_v_out_413102.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_413102", "413102015", "story_v_out_413102.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_25 = math.max(var_68_16, arg_65_1.talkMaxDuration)

			if var_68_15 <= arg_65_1.time_ and arg_65_1.time_ < var_68_15 + var_68_25 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_15) / var_68_25

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_15 + var_68_25 and arg_65_1.time_ < var_68_15 + var_68_25 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play413102016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 413102016
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play413102017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10096"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos10096 = var_72_0.localPosition
				var_72_0.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10096", 6)

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
				local var_72_6 = Vector3.New(1500, -350, -210)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10096, var_72_6, var_72_5)
			end

			if arg_69_1.time_ >= var_72_1 + var_72_4 and arg_69_1.time_ < var_72_1 + var_72_4 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(1500, -350, -210)
			end

			local var_72_7 = arg_69_1.actors_["10096"]
			local var_72_8 = 0

			if var_72_8 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.actorSpriteComps10096 == nil then
				arg_69_1.var_.actorSpriteComps10096 = var_72_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_9 = 2

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_9 and not isNil(var_72_7) then
				local var_72_10 = (arg_69_1.time_ - var_72_8) / var_72_9

				if arg_69_1.var_.actorSpriteComps10096 then
					for iter_72_1, iter_72_2 in pairs(arg_69_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_72_2 then
							if arg_69_1.isInRecall_ then
								local var_72_11 = Mathf.Lerp(iter_72_2.color.r, arg_69_1.hightColor2.r, var_72_10)
								local var_72_12 = Mathf.Lerp(iter_72_2.color.g, arg_69_1.hightColor2.g, var_72_10)
								local var_72_13 = Mathf.Lerp(iter_72_2.color.b, arg_69_1.hightColor2.b, var_72_10)

								iter_72_2.color = Color.New(var_72_11, var_72_12, var_72_13)
							else
								local var_72_14 = Mathf.Lerp(iter_72_2.color.r, 0.5, var_72_10)

								iter_72_2.color = Color.New(var_72_14, var_72_14, var_72_14)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_8 + var_72_9 and arg_69_1.time_ < var_72_8 + var_72_9 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.actorSpriteComps10096 then
				for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_72_4 then
						if arg_69_1.isInRecall_ then
							iter_72_4.color = arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_72_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10096 = nil
			end

			local var_72_15 = 0
			local var_72_16 = 1.25

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_17 = arg_69_1:GetWordFromCfg(413102016)
				local var_72_18 = arg_69_1:FormatText(var_72_17.content)

				arg_69_1.text_.text = var_72_18

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_19 = 50
				local var_72_20 = utf8.len(var_72_18)
				local var_72_21 = var_72_19 <= 0 and var_72_16 or var_72_16 * (var_72_20 / var_72_19)

				if var_72_21 > 0 and var_72_16 < var_72_21 then
					arg_69_1.talkMaxDuration = var_72_21

					if var_72_21 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_21 + var_72_15
					end
				end

				arg_69_1.text_.text = var_72_18
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_22 = math.max(var_72_16, arg_69_1.talkMaxDuration)

			if var_72_15 <= arg_69_1.time_ and arg_69_1.time_ < var_72_15 + var_72_22 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_15) / var_72_22

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_15 + var_72_22 and arg_69_1.time_ < var_72_15 + var_72_22 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
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
	Play413102017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 413102017
		arg_73_1.duration_ = 11.67

		local var_73_0 = {
			zh = 6.7,
			ja = 11.666
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
				arg_73_0:Play413102018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10096"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos10096 = var_76_0.localPosition
				var_76_0.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10096", 3)

				local var_76_2 = var_76_0.childCount

				for iter_76_0 = 0, var_76_2 - 1 do
					local var_76_3 = var_76_0:GetChild(iter_76_0)

					if var_76_3.name == "" or not string.find(var_76_3.name, "split") then
						var_76_3.gameObject:SetActive(true)
					else
						var_76_3.gameObject:SetActive(false)
					end
				end
			end

			local var_76_4 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_4 then
				local var_76_5 = (arg_73_1.time_ - var_76_1) / var_76_4
				local var_76_6 = Vector3.New(0, -350, -210)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10096, var_76_6, var_76_5)
			end

			if arg_73_1.time_ >= var_76_1 + var_76_4 and arg_73_1.time_ < var_76_1 + var_76_4 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(0, -350, -210)
			end

			local var_76_7 = arg_73_1.actors_["10096"]
			local var_76_8 = 0

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.actorSpriteComps10096 == nil then
				arg_73_1.var_.actorSpriteComps10096 = var_76_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_9 = 2

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_9 and not isNil(var_76_7) then
				local var_76_10 = (arg_73_1.time_ - var_76_8) / var_76_9

				if arg_73_1.var_.actorSpriteComps10096 then
					for iter_76_1, iter_76_2 in pairs(arg_73_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_76_2 then
							if arg_73_1.isInRecall_ then
								local var_76_11 = Mathf.Lerp(iter_76_2.color.r, arg_73_1.hightColor1.r, var_76_10)
								local var_76_12 = Mathf.Lerp(iter_76_2.color.g, arg_73_1.hightColor1.g, var_76_10)
								local var_76_13 = Mathf.Lerp(iter_76_2.color.b, arg_73_1.hightColor1.b, var_76_10)

								iter_76_2.color = Color.New(var_76_11, var_76_12, var_76_13)
							else
								local var_76_14 = Mathf.Lerp(iter_76_2.color.r, 1, var_76_10)

								iter_76_2.color = Color.New(var_76_14, var_76_14, var_76_14)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_8 + var_76_9 and arg_73_1.time_ < var_76_8 + var_76_9 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.actorSpriteComps10096 then
				for iter_76_3, iter_76_4 in pairs(arg_73_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_76_4 then
						if arg_73_1.isInRecall_ then
							iter_76_4.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10096 = nil
			end

			local var_76_15 = 0
			local var_76_16 = 0.425

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_17 = arg_73_1:FormatText(StoryNameCfg[36].name)

				arg_73_1.leftNameTxt_.text = var_76_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_18 = arg_73_1:GetWordFromCfg(413102017)
				local var_76_19 = arg_73_1:FormatText(var_76_18.content)

				arg_73_1.text_.text = var_76_19

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_20 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102017", "story_v_out_413102.awb") ~= 0 then
					local var_76_23 = manager.audio:GetVoiceLength("story_v_out_413102", "413102017", "story_v_out_413102.awb") / 1000

					if var_76_23 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_23 + var_76_15
					end

					if var_76_18.prefab_name ~= "" and arg_73_1.actors_[var_76_18.prefab_name] ~= nil then
						local var_76_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_18.prefab_name].transform, "story_v_out_413102", "413102017", "story_v_out_413102.awb")

						arg_73_1:RecordAudio("413102017", var_76_24)
						arg_73_1:RecordAudio("413102017", var_76_24)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_413102", "413102017", "story_v_out_413102.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_413102", "413102017", "story_v_out_413102.awb")
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
				actorName = "10096",
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
	Play413102018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413102018
		arg_77_1.duration_ = 8.23

		local var_77_0 = {
			zh = 5,
			ja = 8.233
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
				arg_77_0:Play413102019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10096"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos10096 = var_80_0.localPosition
				var_80_0.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10096", 3)

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
				local var_80_6 = Vector3.New(0, -350, -210)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10096, var_80_6, var_80_5)
			end

			if arg_77_1.time_ >= var_80_1 + var_80_4 and arg_77_1.time_ < var_80_1 + var_80_4 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0, -350, -210)
			end

			local var_80_7 = arg_77_1.actors_["10096"]
			local var_80_8 = 0

			if var_80_8 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps10096 == nil then
				arg_77_1.var_.actorSpriteComps10096 = var_80_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_9 = 2

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_9 and not isNil(var_80_7) then
				local var_80_10 = (arg_77_1.time_ - var_80_8) / var_80_9

				if arg_77_1.var_.actorSpriteComps10096 then
					for iter_80_1, iter_80_2 in pairs(arg_77_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_80_2 then
							if arg_77_1.isInRecall_ then
								local var_80_11 = Mathf.Lerp(iter_80_2.color.r, arg_77_1.hightColor1.r, var_80_10)
								local var_80_12 = Mathf.Lerp(iter_80_2.color.g, arg_77_1.hightColor1.g, var_80_10)
								local var_80_13 = Mathf.Lerp(iter_80_2.color.b, arg_77_1.hightColor1.b, var_80_10)

								iter_80_2.color = Color.New(var_80_11, var_80_12, var_80_13)
							else
								local var_80_14 = Mathf.Lerp(iter_80_2.color.r, 1, var_80_10)

								iter_80_2.color = Color.New(var_80_14, var_80_14, var_80_14)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_8 + var_80_9 and arg_77_1.time_ < var_80_8 + var_80_9 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps10096 then
				for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_80_4 then
						if arg_77_1.isInRecall_ then
							iter_80_4.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10096 = nil
			end

			local var_80_15 = 0
			local var_80_16 = 0.3

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_17 = arg_77_1:FormatText(StoryNameCfg[36].name)

				arg_77_1.leftNameTxt_.text = var_80_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_18 = arg_77_1:GetWordFromCfg(413102018)
				local var_80_19 = arg_77_1:FormatText(var_80_18.content)

				arg_77_1.text_.text = var_80_19

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_20 = 12
				local var_80_21 = utf8.len(var_80_19)
				local var_80_22 = var_80_20 <= 0 and var_80_16 or var_80_16 * (var_80_21 / var_80_20)

				if var_80_22 > 0 and var_80_16 < var_80_22 then
					arg_77_1.talkMaxDuration = var_80_22

					if var_80_22 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_22 + var_80_15
					end
				end

				arg_77_1.text_.text = var_80_19
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102018", "story_v_out_413102.awb") ~= 0 then
					local var_80_23 = manager.audio:GetVoiceLength("story_v_out_413102", "413102018", "story_v_out_413102.awb") / 1000

					if var_80_23 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_23 + var_80_15
					end

					if var_80_18.prefab_name ~= "" and arg_77_1.actors_[var_80_18.prefab_name] ~= nil then
						local var_80_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_18.prefab_name].transform, "story_v_out_413102", "413102018", "story_v_out_413102.awb")

						arg_77_1:RecordAudio("413102018", var_80_24)
						arg_77_1:RecordAudio("413102018", var_80_24)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413102", "413102018", "story_v_out_413102.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413102", "413102018", "story_v_out_413102.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_25 = math.max(var_80_16, arg_77_1.talkMaxDuration)

			if var_80_15 <= arg_77_1.time_ and arg_77_1.time_ < var_80_15 + var_80_25 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_15) / var_80_25

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_15 + var_80_25 and arg_77_1.time_ < var_80_15 + var_80_25 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play413102019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 413102019
		arg_81_1.duration_ = 9.77

		local var_81_0 = {
			zh = 9.766,
			ja = 8.033
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
				arg_81_0:Play413102020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10096"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos10096 = var_84_0.localPosition
				var_84_0.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10096", 3)

				local var_84_2 = var_84_0.childCount

				for iter_84_0 = 0, var_84_2 - 1 do
					local var_84_3 = var_84_0:GetChild(iter_84_0)

					if var_84_3.name == "" or not string.find(var_84_3.name, "split") then
						var_84_3.gameObject:SetActive(true)
					else
						var_84_3.gameObject:SetActive(false)
					end
				end
			end

			local var_84_4 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_4 then
				local var_84_5 = (arg_81_1.time_ - var_84_1) / var_84_4
				local var_84_6 = Vector3.New(0, -350, -210)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10096, var_84_6, var_84_5)
			end

			if arg_81_1.time_ >= var_84_1 + var_84_4 and arg_81_1.time_ < var_84_1 + var_84_4 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0, -350, -210)
			end

			local var_84_7 = arg_81_1.actors_["10096"]
			local var_84_8 = 0

			if var_84_8 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 and not isNil(var_84_7) and arg_81_1.var_.actorSpriteComps10096 == nil then
				arg_81_1.var_.actorSpriteComps10096 = var_84_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_9 = 2

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_9 and not isNil(var_84_7) then
				local var_84_10 = (arg_81_1.time_ - var_84_8) / var_84_9

				if arg_81_1.var_.actorSpriteComps10096 then
					for iter_84_1, iter_84_2 in pairs(arg_81_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_84_2 then
							if arg_81_1.isInRecall_ then
								local var_84_11 = Mathf.Lerp(iter_84_2.color.r, arg_81_1.hightColor2.r, var_84_10)
								local var_84_12 = Mathf.Lerp(iter_84_2.color.g, arg_81_1.hightColor2.g, var_84_10)
								local var_84_13 = Mathf.Lerp(iter_84_2.color.b, arg_81_1.hightColor2.b, var_84_10)

								iter_84_2.color = Color.New(var_84_11, var_84_12, var_84_13)
							else
								local var_84_14 = Mathf.Lerp(iter_84_2.color.r, 0.5, var_84_10)

								iter_84_2.color = Color.New(var_84_14, var_84_14, var_84_14)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_8 + var_84_9 and arg_81_1.time_ < var_84_8 + var_84_9 + arg_84_0 and not isNil(var_84_7) and arg_81_1.var_.actorSpriteComps10096 then
				for iter_84_3, iter_84_4 in pairs(arg_81_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_84_4 then
						if arg_81_1.isInRecall_ then
							iter_84_4.color = arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_84_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps10096 = nil
			end

			local var_84_15 = 0
			local var_84_16 = 0.375

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_17 = arg_81_1:FormatText(StoryNameCfg[1001].name)

				arg_81_1.leftNameTxt_.text = var_84_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10097_split_4")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_18 = arg_81_1:GetWordFromCfg(413102019)
				local var_84_19 = arg_81_1:FormatText(var_84_18.content)

				arg_81_1.text_.text = var_84_19

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_20 = 15
				local var_84_21 = utf8.len(var_84_19)
				local var_84_22 = var_84_20 <= 0 and var_84_16 or var_84_16 * (var_84_21 / var_84_20)

				if var_84_22 > 0 and var_84_16 < var_84_22 then
					arg_81_1.talkMaxDuration = var_84_22

					if var_84_22 + var_84_15 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_22 + var_84_15
					end
				end

				arg_81_1.text_.text = var_84_19
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102019", "story_v_out_413102.awb") ~= 0 then
					local var_84_23 = manager.audio:GetVoiceLength("story_v_out_413102", "413102019", "story_v_out_413102.awb") / 1000

					if var_84_23 + var_84_15 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_23 + var_84_15
					end

					if var_84_18.prefab_name ~= "" and arg_81_1.actors_[var_84_18.prefab_name] ~= nil then
						local var_84_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_18.prefab_name].transform, "story_v_out_413102", "413102019", "story_v_out_413102.awb")

						arg_81_1:RecordAudio("413102019", var_84_24)
						arg_81_1:RecordAudio("413102019", var_84_24)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_413102", "413102019", "story_v_out_413102.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_413102", "413102019", "story_v_out_413102.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_25 = math.max(var_84_16, arg_81_1.talkMaxDuration)

			if var_84_15 <= arg_81_1.time_ and arg_81_1.time_ < var_84_15 + var_84_25 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_15) / var_84_25

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_15 + var_84_25 and arg_81_1.time_ < var_84_15 + var_84_25 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
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
	Play413102020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413102020
		arg_85_1.duration_ = 10.67

		local var_85_0 = {
			zh = 8.1,
			ja = 10.666
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
				arg_85_0:Play413102021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10096"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10096 == nil then
				arg_85_1.var_.actorSpriteComps10096 = var_88_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_2 = 2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.actorSpriteComps10096 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps10096:ToTable()) do
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

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10096 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_88_3 then
						if arg_85_1.isInRecall_ then
							iter_88_3.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10096 = nil
			end

			local var_88_8 = 0
			local var_88_9 = 0.525

			if var_88_8 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_10 = arg_85_1:FormatText(StoryNameCfg[36].name)

				arg_85_1.leftNameTxt_.text = var_88_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_11 = arg_85_1:GetWordFromCfg(413102020)
				local var_88_12 = arg_85_1:FormatText(var_88_11.content)

				arg_85_1.text_.text = var_88_12

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 21
				local var_88_14 = utf8.len(var_88_12)
				local var_88_15 = var_88_13 <= 0 and var_88_9 or var_88_9 * (var_88_14 / var_88_13)

				if var_88_15 > 0 and var_88_9 < var_88_15 then
					arg_85_1.talkMaxDuration = var_88_15

					if var_88_15 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_15 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_12
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102020", "story_v_out_413102.awb") ~= 0 then
					local var_88_16 = manager.audio:GetVoiceLength("story_v_out_413102", "413102020", "story_v_out_413102.awb") / 1000

					if var_88_16 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_16 + var_88_8
					end

					if var_88_11.prefab_name ~= "" and arg_85_1.actors_[var_88_11.prefab_name] ~= nil then
						local var_88_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_11.prefab_name].transform, "story_v_out_413102", "413102020", "story_v_out_413102.awb")

						arg_85_1:RecordAudio("413102020", var_88_17)
						arg_85_1:RecordAudio("413102020", var_88_17)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413102", "413102020", "story_v_out_413102.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413102", "413102020", "story_v_out_413102.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_18 = math.max(var_88_9, arg_85_1.talkMaxDuration)

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_18 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_8) / var_88_18

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_8 + var_88_18 and arg_85_1.time_ < var_88_8 + var_88_18 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play413102021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 413102021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play413102022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10097"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos10097 = var_92_0.localPosition
				var_92_0.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10097", 6)

				local var_92_2 = var_92_0.childCount

				for iter_92_0 = 0, var_92_2 - 1 do
					local var_92_3 = var_92_0:GetChild(iter_92_0)

					if var_92_3.name == "" or not string.find(var_92_3.name, "split") then
						var_92_3.gameObject:SetActive(true)
					else
						var_92_3.gameObject:SetActive(false)
					end
				end
			end

			local var_92_4 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_4 then
				local var_92_5 = (arg_89_1.time_ - var_92_1) / var_92_4
				local var_92_6 = Vector3.New(1500, -350, -180)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10097, var_92_6, var_92_5)
			end

			if arg_89_1.time_ >= var_92_1 + var_92_4 and arg_89_1.time_ < var_92_1 + var_92_4 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(1500, -350, -180)
			end

			local var_92_7 = arg_89_1.actors_["10096"].transform
			local var_92_8 = 0

			if var_92_8 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.var_.moveOldPos10096 = var_92_7.localPosition
				var_92_7.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10096", 6)

				local var_92_9 = var_92_7.childCount

				for iter_92_1 = 0, var_92_9 - 1 do
					local var_92_10 = var_92_7:GetChild(iter_92_1)

					if var_92_10.name == "" or not string.find(var_92_10.name, "split") then
						var_92_10.gameObject:SetActive(true)
					else
						var_92_10.gameObject:SetActive(false)
					end
				end
			end

			local var_92_11 = 0.001

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_11 then
				local var_92_12 = (arg_89_1.time_ - var_92_8) / var_92_11
				local var_92_13 = Vector3.New(1500, -350, -210)

				var_92_7.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10096, var_92_13, var_92_12)
			end

			if arg_89_1.time_ >= var_92_8 + var_92_11 and arg_89_1.time_ < var_92_8 + var_92_11 + arg_92_0 then
				var_92_7.localPosition = Vector3.New(1500, -350, -210)
			end

			local var_92_14 = arg_89_1.actors_["10097"]
			local var_92_15 = 0

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 and not isNil(var_92_14) and arg_89_1.var_.actorSpriteComps10097 == nil then
				arg_89_1.var_.actorSpriteComps10097 = var_92_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_16 = 2

			if var_92_15 <= arg_89_1.time_ and arg_89_1.time_ < var_92_15 + var_92_16 and not isNil(var_92_14) then
				local var_92_17 = (arg_89_1.time_ - var_92_15) / var_92_16

				if arg_89_1.var_.actorSpriteComps10097 then
					for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_92_3 then
							if arg_89_1.isInRecall_ then
								local var_92_18 = Mathf.Lerp(iter_92_3.color.r, arg_89_1.hightColor2.r, var_92_17)
								local var_92_19 = Mathf.Lerp(iter_92_3.color.g, arg_89_1.hightColor2.g, var_92_17)
								local var_92_20 = Mathf.Lerp(iter_92_3.color.b, arg_89_1.hightColor2.b, var_92_17)

								iter_92_3.color = Color.New(var_92_18, var_92_19, var_92_20)
							else
								local var_92_21 = Mathf.Lerp(iter_92_3.color.r, 0.5, var_92_17)

								iter_92_3.color = Color.New(var_92_21, var_92_21, var_92_21)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_15 + var_92_16 and arg_89_1.time_ < var_92_15 + var_92_16 + arg_92_0 and not isNil(var_92_14) and arg_89_1.var_.actorSpriteComps10097 then
				for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_92_5 then
						if arg_89_1.isInRecall_ then
							iter_92_5.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10097 = nil
			end

			local var_92_22 = arg_89_1.actors_["10096"]
			local var_92_23 = 0

			if var_92_23 < arg_89_1.time_ and arg_89_1.time_ <= var_92_23 + arg_92_0 and not isNil(var_92_22) and arg_89_1.var_.actorSpriteComps10096 == nil then
				arg_89_1.var_.actorSpriteComps10096 = var_92_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_24 = 2

			if var_92_23 <= arg_89_1.time_ and arg_89_1.time_ < var_92_23 + var_92_24 and not isNil(var_92_22) then
				local var_92_25 = (arg_89_1.time_ - var_92_23) / var_92_24

				if arg_89_1.var_.actorSpriteComps10096 then
					for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_92_7 then
							if arg_89_1.isInRecall_ then
								local var_92_26 = Mathf.Lerp(iter_92_7.color.r, arg_89_1.hightColor2.r, var_92_25)
								local var_92_27 = Mathf.Lerp(iter_92_7.color.g, arg_89_1.hightColor2.g, var_92_25)
								local var_92_28 = Mathf.Lerp(iter_92_7.color.b, arg_89_1.hightColor2.b, var_92_25)

								iter_92_7.color = Color.New(var_92_26, var_92_27, var_92_28)
							else
								local var_92_29 = Mathf.Lerp(iter_92_7.color.r, 0.5, var_92_25)

								iter_92_7.color = Color.New(var_92_29, var_92_29, var_92_29)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_23 + var_92_24 and arg_89_1.time_ < var_92_23 + var_92_24 + arg_92_0 and not isNil(var_92_22) and arg_89_1.var_.actorSpriteComps10096 then
				for iter_92_8, iter_92_9 in pairs(arg_89_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_92_9 then
						if arg_89_1.isInRecall_ then
							iter_92_9.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10096 = nil
			end

			local var_92_30 = 0
			local var_92_31 = 0.975

			if var_92_30 < arg_89_1.time_ and arg_89_1.time_ <= var_92_30 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_32 = arg_89_1:GetWordFromCfg(413102021)
				local var_92_33 = arg_89_1:FormatText(var_92_32.content)

				arg_89_1.text_.text = var_92_33

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_34 = 39
				local var_92_35 = utf8.len(var_92_33)
				local var_92_36 = var_92_34 <= 0 and var_92_31 or var_92_31 * (var_92_35 / var_92_34)

				if var_92_36 > 0 and var_92_31 < var_92_36 then
					arg_89_1.talkMaxDuration = var_92_36

					if var_92_36 + var_92_30 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_36 + var_92_30
					end
				end

				arg_89_1.text_.text = var_92_33
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_37 = math.max(var_92_31, arg_89_1.talkMaxDuration)

			if var_92_30 <= arg_89_1.time_ and arg_89_1.time_ < var_92_30 + var_92_37 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_30) / var_92_37

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_30 + var_92_37 and arg_89_1.time_ < var_92_30 + var_92_37 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
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
	Play413102022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413102022
		arg_93_1.duration_ = 8.4

		local var_93_0 = {
			zh = 3.033,
			ja = 8.4
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
				arg_93_0:Play413102023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.15

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

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:GetWordFromCfg(413102022)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102022", "story_v_out_413102.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_413102", "413102022", "story_v_out_413102.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_413102", "413102022", "story_v_out_413102.awb")

						arg_93_1:RecordAudio("413102022", var_96_9)
						arg_93_1:RecordAudio("413102022", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_413102", "413102022", "story_v_out_413102.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_413102", "413102022", "story_v_out_413102.awb")
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
	Play413102023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413102023
		arg_97_1.duration_ = 7.4

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play413102024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = "F09f"

			if arg_97_1.bgs_[var_100_0] == nil then
				local var_100_1 = Object.Instantiate(arg_97_1.paintGo_)

				var_100_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_100_0)
				var_100_1.name = var_100_0
				var_100_1.transform.parent = arg_97_1.stage_.transform
				var_100_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_97_1.bgs_[var_100_0] = var_100_1
			end

			local var_100_2 = 2

			if var_100_2 < arg_97_1.time_ and arg_97_1.time_ <= var_100_2 + arg_100_0 then
				local var_100_3 = manager.ui.mainCamera.transform.localPosition
				local var_100_4 = Vector3.New(0, 0, 10) + Vector3.New(var_100_3.x, var_100_3.y, 0)
				local var_100_5 = arg_97_1.bgs_.F09f

				var_100_5.transform.localPosition = var_100_4
				var_100_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_100_6 = var_100_5:GetComponent("SpriteRenderer")

				if var_100_6 and var_100_6.sprite then
					local var_100_7 = (var_100_5.transform.localPosition - var_100_3).z
					local var_100_8 = manager.ui.mainCameraCom_
					local var_100_9 = 2 * var_100_7 * Mathf.Tan(var_100_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_100_10 = var_100_9 * var_100_8.aspect
					local var_100_11 = var_100_6.sprite.bounds.size.x
					local var_100_12 = var_100_6.sprite.bounds.size.y
					local var_100_13 = var_100_10 / var_100_11
					local var_100_14 = var_100_9 / var_100_12
					local var_100_15 = var_100_14 < var_100_13 and var_100_13 or var_100_14

					var_100_5.transform.localScale = Vector3.New(var_100_15, var_100_15, 0)
				end

				for iter_100_0, iter_100_1 in pairs(arg_97_1.bgs_) do
					if iter_100_0 ~= "F09f" then
						iter_100_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_100_16 = 3.96666666666533

			if var_100_16 < arg_97_1.time_ and arg_97_1.time_ <= var_100_16 + arg_100_0 then
				arg_97_1.allBtn_.enabled = false
			end

			local var_100_17 = 0.3

			if arg_97_1.time_ >= var_100_16 + var_100_17 and arg_97_1.time_ < var_100_16 + var_100_17 + arg_100_0 then
				arg_97_1.allBtn_.enabled = true
			end

			local var_100_18 = 0

			if var_100_18 < arg_97_1.time_ and arg_97_1.time_ <= var_100_18 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = true

				arg_97_1:SetGaussion(false)
			end

			local var_100_19 = 2

			if var_100_18 <= arg_97_1.time_ and arg_97_1.time_ < var_100_18 + var_100_19 then
				local var_100_20 = (arg_97_1.time_ - var_100_18) / var_100_19
				local var_100_21 = Color.New(0, 0, 0)

				var_100_21.a = Mathf.Lerp(0, 1, var_100_20)
				arg_97_1.mask_.color = var_100_21
			end

			if arg_97_1.time_ >= var_100_18 + var_100_19 and arg_97_1.time_ < var_100_18 + var_100_19 + arg_100_0 then
				local var_100_22 = Color.New(0, 0, 0)

				var_100_22.a = 1
				arg_97_1.mask_.color = var_100_22
			end

			local var_100_23 = 2

			if var_100_23 < arg_97_1.time_ and arg_97_1.time_ <= var_100_23 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = true

				arg_97_1:SetGaussion(false)
			end

			local var_100_24 = 2

			if var_100_23 <= arg_97_1.time_ and arg_97_1.time_ < var_100_23 + var_100_24 then
				local var_100_25 = (arg_97_1.time_ - var_100_23) / var_100_24
				local var_100_26 = Color.New(0, 0, 0)

				var_100_26.a = Mathf.Lerp(1, 0, var_100_25)
				arg_97_1.mask_.color = var_100_26
			end

			if arg_97_1.time_ >= var_100_23 + var_100_24 and arg_97_1.time_ < var_100_23 + var_100_24 + arg_100_0 then
				local var_100_27 = Color.New(0, 0, 0)
				local var_100_28 = 0

				arg_97_1.mask_.enabled = false
				var_100_27.a = var_100_28
				arg_97_1.mask_.color = var_100_27
			end

			local var_100_29 = "10095"

			if arg_97_1.actors_[var_100_29] == nil then
				local var_100_30 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10095")

				if not isNil(var_100_30) then
					local var_100_31 = Object.Instantiate(var_100_30, arg_97_1.canvasGo_.transform)

					var_100_31.transform:SetSiblingIndex(1)

					var_100_31.name = var_100_29
					var_100_31.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_97_1.actors_[var_100_29] = var_100_31

					local var_100_32 = var_100_31:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_97_1.isInRecall_ then
						for iter_100_2, iter_100_3 in ipairs(var_100_32) do
							iter_100_3.color = arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_100_33 = arg_97_1.actors_["10095"].transform
			local var_100_34 = 3.733333333332

			if var_100_34 < arg_97_1.time_ and arg_97_1.time_ <= var_100_34 + arg_100_0 then
				arg_97_1.var_.moveOldPos10095 = var_100_33.localPosition
				var_100_33.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10095", 3)

				local var_100_35 = var_100_33.childCount

				for iter_100_4 = 0, var_100_35 - 1 do
					local var_100_36 = var_100_33:GetChild(iter_100_4)

					if var_100_36.name == "split_1_1" or not string.find(var_100_36.name, "split") then
						var_100_36.gameObject:SetActive(true)
					else
						var_100_36.gameObject:SetActive(false)
					end
				end
			end

			local var_100_37 = 0.001

			if var_100_34 <= arg_97_1.time_ and arg_97_1.time_ < var_100_34 + var_100_37 then
				local var_100_38 = (arg_97_1.time_ - var_100_34) / var_100_37
				local var_100_39 = Vector3.New(0, -405, -10)

				var_100_33.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10095, var_100_39, var_100_38)
			end

			if arg_97_1.time_ >= var_100_34 + var_100_37 and arg_97_1.time_ < var_100_34 + var_100_37 + arg_100_0 then
				var_100_33.localPosition = Vector3.New(0, -405, -10)
			end

			local var_100_40 = arg_97_1.actors_["10095"]
			local var_100_41 = 3.733333333332

			if var_100_41 < arg_97_1.time_ and arg_97_1.time_ <= var_100_41 + arg_100_0 then
				local var_100_42 = var_100_40:GetComponentInChildren(typeof(CanvasGroup))

				if var_100_42 then
					arg_97_1.var_.alphaOldValue10095 = var_100_42.alpha
					arg_97_1.var_.characterEffect10095 = var_100_42
				end

				arg_97_1.var_.alphaOldValue10095 = 0
			end

			local var_100_43 = 0.233333333333333

			if var_100_41 <= arg_97_1.time_ and arg_97_1.time_ < var_100_41 + var_100_43 then
				local var_100_44 = (arg_97_1.time_ - var_100_41) / var_100_43
				local var_100_45 = Mathf.Lerp(arg_97_1.var_.alphaOldValue10095, 1, var_100_44)

				if arg_97_1.var_.characterEffect10095 then
					arg_97_1.var_.characterEffect10095.alpha = var_100_45
				end
			end

			if arg_97_1.time_ >= var_100_41 + var_100_43 and arg_97_1.time_ < var_100_41 + var_100_43 + arg_100_0 and arg_97_1.var_.characterEffect10095 then
				arg_97_1.var_.characterEffect10095.alpha = 1
			end

			local var_100_46 = arg_97_1.actors_["10095"]
			local var_100_47 = 3.733333333332

			if var_100_47 < arg_97_1.time_ and arg_97_1.time_ <= var_100_47 + arg_100_0 and not isNil(var_100_46) and arg_97_1.var_.actorSpriteComps10095 == nil then
				arg_97_1.var_.actorSpriteComps10095 = var_100_46:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_48 = 2

			if var_100_47 <= arg_97_1.time_ and arg_97_1.time_ < var_100_47 + var_100_48 and not isNil(var_100_46) then
				local var_100_49 = (arg_97_1.time_ - var_100_47) / var_100_48

				if arg_97_1.var_.actorSpriteComps10095 then
					for iter_100_5, iter_100_6 in pairs(arg_97_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_100_6 then
							if arg_97_1.isInRecall_ then
								local var_100_50 = Mathf.Lerp(iter_100_6.color.r, arg_97_1.hightColor1.r, var_100_49)
								local var_100_51 = Mathf.Lerp(iter_100_6.color.g, arg_97_1.hightColor1.g, var_100_49)
								local var_100_52 = Mathf.Lerp(iter_100_6.color.b, arg_97_1.hightColor1.b, var_100_49)

								iter_100_6.color = Color.New(var_100_50, var_100_51, var_100_52)
							else
								local var_100_53 = Mathf.Lerp(iter_100_6.color.r, 1, var_100_49)

								iter_100_6.color = Color.New(var_100_53, var_100_53, var_100_53)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_47 + var_100_48 and arg_97_1.time_ < var_100_47 + var_100_48 + arg_100_0 and not isNil(var_100_46) and arg_97_1.var_.actorSpriteComps10095 then
				for iter_100_7, iter_100_8 in pairs(arg_97_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_100_8 then
						if arg_97_1.isInRecall_ then
							iter_100_8.color = arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_100_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10095 = nil
			end

			if arg_97_1.frameCnt_ <= 1 then
				arg_97_1.dialog_:SetActive(false)
			end

			local var_100_54 = 4.23333333333333
			local var_100_55 = 0.25

			if var_100_54 < arg_97_1.time_ and arg_97_1.time_ <= var_100_54 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0

				arg_97_1.dialog_:SetActive(true)

				arg_97_1.dialogCg_.alpha = 0

				local var_100_56 = LeanTween.value(arg_97_1.dialog_, 0, 1, 0.3)

				var_100_56:setOnUpdate(LuaHelper.FloatAction(function(arg_101_0)
					arg_97_1.dialogCg_.alpha = arg_101_0
				end))
				var_100_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_97_1.dialog_)
					var_100_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_97_1.duration_ = arg_97_1.duration_ + 0.3

				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_57 = arg_97_1:FormatText(StoryNameCfg[1002].name)

				arg_97_1.leftNameTxt_.text = var_100_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_58 = arg_97_1:GetWordFromCfg(413102023)
				local var_100_59 = arg_97_1:FormatText(var_100_58.content)

				arg_97_1.text_.text = var_100_59

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_60 = 10
				local var_100_61 = utf8.len(var_100_59)
				local var_100_62 = var_100_60 <= 0 and var_100_55 or var_100_55 * (var_100_61 / var_100_60)

				if var_100_62 > 0 and var_100_55 < var_100_62 then
					arg_97_1.talkMaxDuration = var_100_62
					var_100_54 = var_100_54 + 0.3

					if var_100_62 + var_100_54 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_62 + var_100_54
					end
				end

				arg_97_1.text_.text = var_100_59
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102023", "story_v_out_413102.awb") ~= 0 then
					local var_100_63 = manager.audio:GetVoiceLength("story_v_out_413102", "413102023", "story_v_out_413102.awb") / 1000

					if var_100_63 + var_100_54 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_63 + var_100_54
					end

					if var_100_58.prefab_name ~= "" and arg_97_1.actors_[var_100_58.prefab_name] ~= nil then
						local var_100_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_58.prefab_name].transform, "story_v_out_413102", "413102023", "story_v_out_413102.awb")

						arg_97_1:RecordAudio("413102023", var_100_64)
						arg_97_1:RecordAudio("413102023", var_100_64)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_413102", "413102023", "story_v_out_413102.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_413102", "413102023", "story_v_out_413102.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_65 = var_100_54 + 0.3
			local var_100_66 = math.max(var_100_55, arg_97_1.talkMaxDuration)

			if var_100_65 <= arg_97_1.time_ and arg_97_1.time_ < var_100_65 + var_100_66 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_65) / var_100_66

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_65 + var_100_66 and arg_97_1.time_ < var_100_65 + var_100_66 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.733333333332,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play413102024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 413102024
		arg_103_1.duration_ = 3.6

		local var_103_0 = {
			zh = 3.6,
			ja = 3.4
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
				arg_103_0:Play413102025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["10095"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.actorSpriteComps10095 == nil then
				arg_103_1.var_.actorSpriteComps10095 = var_106_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_2 = 2

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.actorSpriteComps10095 then
					for iter_106_0, iter_106_1 in pairs(arg_103_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_106_1 then
							if arg_103_1.isInRecall_ then
								local var_106_4 = Mathf.Lerp(iter_106_1.color.r, arg_103_1.hightColor2.r, var_106_3)
								local var_106_5 = Mathf.Lerp(iter_106_1.color.g, arg_103_1.hightColor2.g, var_106_3)
								local var_106_6 = Mathf.Lerp(iter_106_1.color.b, arg_103_1.hightColor2.b, var_106_3)

								iter_106_1.color = Color.New(var_106_4, var_106_5, var_106_6)
							else
								local var_106_7 = Mathf.Lerp(iter_106_1.color.r, 0.5, var_106_3)

								iter_106_1.color = Color.New(var_106_7, var_106_7, var_106_7)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.actorSpriteComps10095 then
				for iter_106_2, iter_106_3 in pairs(arg_103_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_106_3 then
						if arg_103_1.isInRecall_ then
							iter_106_3.color = arg_103_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_106_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_103_1.var_.actorSpriteComps10095 = nil
			end

			local var_106_8 = 0
			local var_106_9 = 0.3

			if var_106_8 < arg_103_1.time_ and arg_103_1.time_ <= var_106_8 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_10 = arg_103_1:FormatText(StoryNameCfg[36].name)

				arg_103_1.leftNameTxt_.text = var_106_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2123")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_11 = arg_103_1:GetWordFromCfg(413102024)
				local var_106_12 = arg_103_1:FormatText(var_106_11.content)

				arg_103_1.text_.text = var_106_12

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_13 = 12
				local var_106_14 = utf8.len(var_106_12)
				local var_106_15 = var_106_13 <= 0 and var_106_9 or var_106_9 * (var_106_14 / var_106_13)

				if var_106_15 > 0 and var_106_9 < var_106_15 then
					arg_103_1.talkMaxDuration = var_106_15

					if var_106_15 + var_106_8 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_15 + var_106_8
					end
				end

				arg_103_1.text_.text = var_106_12
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102024", "story_v_out_413102.awb") ~= 0 then
					local var_106_16 = manager.audio:GetVoiceLength("story_v_out_413102", "413102024", "story_v_out_413102.awb") / 1000

					if var_106_16 + var_106_8 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_16 + var_106_8
					end

					if var_106_11.prefab_name ~= "" and arg_103_1.actors_[var_106_11.prefab_name] ~= nil then
						local var_106_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_11.prefab_name].transform, "story_v_out_413102", "413102024", "story_v_out_413102.awb")

						arg_103_1:RecordAudio("413102024", var_106_17)
						arg_103_1:RecordAudio("413102024", var_106_17)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_413102", "413102024", "story_v_out_413102.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_413102", "413102024", "story_v_out_413102.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_18 = math.max(var_106_9, arg_103_1.talkMaxDuration)

			if var_106_8 <= arg_103_1.time_ and arg_103_1.time_ < var_106_8 + var_106_18 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_8) / var_106_18

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_8 + var_106_18 and arg_103_1.time_ < var_106_8 + var_106_18 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play413102025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 413102025
		arg_107_1.duration_ = 9.8

		local var_107_0 = {
			zh = 8.5,
			ja = 9.8
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
				arg_107_0:Play413102026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10095"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos10095 = var_110_0.localPosition
				var_110_0.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("10095", 3)

				local var_110_2 = var_110_0.childCount

				for iter_110_0 = 0, var_110_2 - 1 do
					local var_110_3 = var_110_0:GetChild(iter_110_0)

					if var_110_3.name == "split_1_1" or not string.find(var_110_3.name, "split") then
						var_110_3.gameObject:SetActive(true)
					else
						var_110_3.gameObject:SetActive(false)
					end
				end
			end

			local var_110_4 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_4 then
				local var_110_5 = (arg_107_1.time_ - var_110_1) / var_110_4
				local var_110_6 = Vector3.New(0, -405, -10)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10095, var_110_6, var_110_5)
			end

			if arg_107_1.time_ >= var_110_1 + var_110_4 and arg_107_1.time_ < var_110_1 + var_110_4 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(0, -405, -10)
			end

			local var_110_7 = arg_107_1.actors_["10095"]
			local var_110_8 = 0

			if var_110_8 < arg_107_1.time_ and arg_107_1.time_ <= var_110_8 + arg_110_0 and not isNil(var_110_7) and arg_107_1.var_.actorSpriteComps10095 == nil then
				arg_107_1.var_.actorSpriteComps10095 = var_110_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_9 = 2

			if var_110_8 <= arg_107_1.time_ and arg_107_1.time_ < var_110_8 + var_110_9 and not isNil(var_110_7) then
				local var_110_10 = (arg_107_1.time_ - var_110_8) / var_110_9

				if arg_107_1.var_.actorSpriteComps10095 then
					for iter_110_1, iter_110_2 in pairs(arg_107_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_110_2 then
							if arg_107_1.isInRecall_ then
								local var_110_11 = Mathf.Lerp(iter_110_2.color.r, arg_107_1.hightColor1.r, var_110_10)
								local var_110_12 = Mathf.Lerp(iter_110_2.color.g, arg_107_1.hightColor1.g, var_110_10)
								local var_110_13 = Mathf.Lerp(iter_110_2.color.b, arg_107_1.hightColor1.b, var_110_10)

								iter_110_2.color = Color.New(var_110_11, var_110_12, var_110_13)
							else
								local var_110_14 = Mathf.Lerp(iter_110_2.color.r, 1, var_110_10)

								iter_110_2.color = Color.New(var_110_14, var_110_14, var_110_14)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= var_110_8 + var_110_9 and arg_107_1.time_ < var_110_8 + var_110_9 + arg_110_0 and not isNil(var_110_7) and arg_107_1.var_.actorSpriteComps10095 then
				for iter_110_3, iter_110_4 in pairs(arg_107_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_110_4 then
						if arg_107_1.isInRecall_ then
							iter_110_4.color = arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_110_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps10095 = nil
			end

			local var_110_15 = 0
			local var_110_16 = 0.75

			if var_110_15 < arg_107_1.time_ and arg_107_1.time_ <= var_110_15 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_17 = arg_107_1:FormatText(StoryNameCfg[1002].name)

				arg_107_1.leftNameTxt_.text = var_110_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_18 = arg_107_1:GetWordFromCfg(413102025)
				local var_110_19 = arg_107_1:FormatText(var_110_18.content)

				arg_107_1.text_.text = var_110_19

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_20 = 30
				local var_110_21 = utf8.len(var_110_19)
				local var_110_22 = var_110_20 <= 0 and var_110_16 or var_110_16 * (var_110_21 / var_110_20)

				if var_110_22 > 0 and var_110_16 < var_110_22 then
					arg_107_1.talkMaxDuration = var_110_22

					if var_110_22 + var_110_15 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_22 + var_110_15
					end
				end

				arg_107_1.text_.text = var_110_19
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102025", "story_v_out_413102.awb") ~= 0 then
					local var_110_23 = manager.audio:GetVoiceLength("story_v_out_413102", "413102025", "story_v_out_413102.awb") / 1000

					if var_110_23 + var_110_15 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_23 + var_110_15
					end

					if var_110_18.prefab_name ~= "" and arg_107_1.actors_[var_110_18.prefab_name] ~= nil then
						local var_110_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_18.prefab_name].transform, "story_v_out_413102", "413102025", "story_v_out_413102.awb")

						arg_107_1:RecordAudio("413102025", var_110_24)
						arg_107_1:RecordAudio("413102025", var_110_24)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_413102", "413102025", "story_v_out_413102.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_413102", "413102025", "story_v_out_413102.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_25 = math.max(var_110_16, arg_107_1.talkMaxDuration)

			if var_110_15 <= arg_107_1.time_ and arg_107_1.time_ < var_110_15 + var_110_25 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_15) / var_110_25

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_15 + var_110_25 and arg_107_1.time_ < var_110_15 + var_110_25 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
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
	Play413102026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 413102026
		arg_111_1.duration_ = 11

		local var_111_0 = {
			zh = 5.3,
			ja = 11
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
				arg_111_0:Play413102027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.55

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[1002].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_3 = arg_111_1:GetWordFromCfg(413102026)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102026", "story_v_out_413102.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_413102", "413102026", "story_v_out_413102.awb") / 1000

					if var_114_8 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_0
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_out_413102", "413102026", "story_v_out_413102.awb")

						arg_111_1:RecordAudio("413102026", var_114_9)
						arg_111_1:RecordAudio("413102026", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_413102", "413102026", "story_v_out_413102.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_413102", "413102026", "story_v_out_413102.awb")
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
	Play413102027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 413102027
		arg_115_1.duration_ = 10.5

		local var_115_0 = {
			zh = 6.933,
			ja = 10.5
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
				arg_115_0:Play413102028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["10095"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos10095 = var_118_0.localPosition
				var_118_0.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10095", 3)

				local var_118_2 = var_118_0.childCount

				for iter_118_0 = 0, var_118_2 - 1 do
					local var_118_3 = var_118_0:GetChild(iter_118_0)

					if var_118_3.name == "" or not string.find(var_118_3.name, "split") then
						var_118_3.gameObject:SetActive(true)
					else
						var_118_3.gameObject:SetActive(false)
					end
				end
			end

			local var_118_4 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_4 then
				local var_118_5 = (arg_115_1.time_ - var_118_1) / var_118_4
				local var_118_6 = Vector3.New(0, -405, -10)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10095, var_118_6, var_118_5)
			end

			if arg_115_1.time_ >= var_118_1 + var_118_4 and arg_115_1.time_ < var_118_1 + var_118_4 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(0, -405, -10)
			end

			local var_118_7 = arg_115_1.actors_["10095"]
			local var_118_8 = 0

			if var_118_8 < arg_115_1.time_ and arg_115_1.time_ <= var_118_8 + arg_118_0 and not isNil(var_118_7) and arg_115_1.var_.actorSpriteComps10095 == nil then
				arg_115_1.var_.actorSpriteComps10095 = var_118_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_9 = 2

			if var_118_8 <= arg_115_1.time_ and arg_115_1.time_ < var_118_8 + var_118_9 and not isNil(var_118_7) then
				local var_118_10 = (arg_115_1.time_ - var_118_8) / var_118_9

				if arg_115_1.var_.actorSpriteComps10095 then
					for iter_118_1, iter_118_2 in pairs(arg_115_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_118_2 then
							if arg_115_1.isInRecall_ then
								local var_118_11 = Mathf.Lerp(iter_118_2.color.r, arg_115_1.hightColor1.r, var_118_10)
								local var_118_12 = Mathf.Lerp(iter_118_2.color.g, arg_115_1.hightColor1.g, var_118_10)
								local var_118_13 = Mathf.Lerp(iter_118_2.color.b, arg_115_1.hightColor1.b, var_118_10)

								iter_118_2.color = Color.New(var_118_11, var_118_12, var_118_13)
							else
								local var_118_14 = Mathf.Lerp(iter_118_2.color.r, 1, var_118_10)

								iter_118_2.color = Color.New(var_118_14, var_118_14, var_118_14)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_8 + var_118_9 and arg_115_1.time_ < var_118_8 + var_118_9 + arg_118_0 and not isNil(var_118_7) and arg_115_1.var_.actorSpriteComps10095 then
				for iter_118_3, iter_118_4 in pairs(arg_115_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_118_4 then
						if arg_115_1.isInRecall_ then
							iter_118_4.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_118_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps10095 = nil
			end

			local var_118_15 = 0
			local var_118_16 = 0.6

			if var_118_15 < arg_115_1.time_ and arg_115_1.time_ <= var_118_15 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_17 = arg_115_1:FormatText(StoryNameCfg[1002].name)

				arg_115_1.leftNameTxt_.text = var_118_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_18 = arg_115_1:GetWordFromCfg(413102027)
				local var_118_19 = arg_115_1:FormatText(var_118_18.content)

				arg_115_1.text_.text = var_118_19

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_20 = 24
				local var_118_21 = utf8.len(var_118_19)
				local var_118_22 = var_118_20 <= 0 and var_118_16 or var_118_16 * (var_118_21 / var_118_20)

				if var_118_22 > 0 and var_118_16 < var_118_22 then
					arg_115_1.talkMaxDuration = var_118_22

					if var_118_22 + var_118_15 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_22 + var_118_15
					end
				end

				arg_115_1.text_.text = var_118_19
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102027", "story_v_out_413102.awb") ~= 0 then
					local var_118_23 = manager.audio:GetVoiceLength("story_v_out_413102", "413102027", "story_v_out_413102.awb") / 1000

					if var_118_23 + var_118_15 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_23 + var_118_15
					end

					if var_118_18.prefab_name ~= "" and arg_115_1.actors_[var_118_18.prefab_name] ~= nil then
						local var_118_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_18.prefab_name].transform, "story_v_out_413102", "413102027", "story_v_out_413102.awb")

						arg_115_1:RecordAudio("413102027", var_118_24)
						arg_115_1:RecordAudio("413102027", var_118_24)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_413102", "413102027", "story_v_out_413102.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_413102", "413102027", "story_v_out_413102.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_25 = math.max(var_118_16, arg_115_1.talkMaxDuration)

			if var_118_15 <= arg_115_1.time_ and arg_115_1.time_ < var_118_15 + var_118_25 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_15) / var_118_25

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_15 + var_118_25 and arg_115_1.time_ < var_118_15 + var_118_25 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
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
	Play413102028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 413102028
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play413102029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10095"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos10095 = var_122_0.localPosition
				var_122_0.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10095", 6)

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
				local var_122_6 = Vector3.New(1500, -405, -10)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10095, var_122_6, var_122_5)
			end

			if arg_119_1.time_ >= var_122_1 + var_122_4 and arg_119_1.time_ < var_122_1 + var_122_4 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(1500, -405, -10)
			end

			local var_122_7 = arg_119_1.actors_["10095"]
			local var_122_8 = 0

			if var_122_8 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 and not isNil(var_122_7) and arg_119_1.var_.actorSpriteComps10095 == nil then
				arg_119_1.var_.actorSpriteComps10095 = var_122_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_9 = 2

			if var_122_8 <= arg_119_1.time_ and arg_119_1.time_ < var_122_8 + var_122_9 and not isNil(var_122_7) then
				local var_122_10 = (arg_119_1.time_ - var_122_8) / var_122_9

				if arg_119_1.var_.actorSpriteComps10095 then
					for iter_122_1, iter_122_2 in pairs(arg_119_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_122_2 then
							if arg_119_1.isInRecall_ then
								local var_122_11 = Mathf.Lerp(iter_122_2.color.r, arg_119_1.hightColor2.r, var_122_10)
								local var_122_12 = Mathf.Lerp(iter_122_2.color.g, arg_119_1.hightColor2.g, var_122_10)
								local var_122_13 = Mathf.Lerp(iter_122_2.color.b, arg_119_1.hightColor2.b, var_122_10)

								iter_122_2.color = Color.New(var_122_11, var_122_12, var_122_13)
							else
								local var_122_14 = Mathf.Lerp(iter_122_2.color.r, 0.5, var_122_10)

								iter_122_2.color = Color.New(var_122_14, var_122_14, var_122_14)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_8 + var_122_9 and arg_119_1.time_ < var_122_8 + var_122_9 + arg_122_0 and not isNil(var_122_7) and arg_119_1.var_.actorSpriteComps10095 then
				for iter_122_3, iter_122_4 in pairs(arg_119_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_122_4 then
						if arg_119_1.isInRecall_ then
							iter_122_4.color = arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_122_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps10095 = nil
			end

			local var_122_15 = 0
			local var_122_16 = 1.275

			if var_122_15 < arg_119_1.time_ and arg_119_1.time_ <= var_122_15 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_17 = arg_119_1:GetWordFromCfg(413102028)
				local var_122_18 = arg_119_1:FormatText(var_122_17.content)

				arg_119_1.text_.text = var_122_18

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_19 = 51
				local var_122_20 = utf8.len(var_122_18)
				local var_122_21 = var_122_19 <= 0 and var_122_16 or var_122_16 * (var_122_20 / var_122_19)

				if var_122_21 > 0 and var_122_16 < var_122_21 then
					arg_119_1.talkMaxDuration = var_122_21

					if var_122_21 + var_122_15 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_21 + var_122_15
					end
				end

				arg_119_1.text_.text = var_122_18
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_22 = math.max(var_122_16, arg_119_1.talkMaxDuration)

			if var_122_15 <= arg_119_1.time_ and arg_119_1.time_ < var_122_15 + var_122_22 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_15) / var_122_22

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_15 + var_122_22 and arg_119_1.time_ < var_122_15 + var_122_22 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
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
	Play413102029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 413102029
		arg_123_1.duration_ = 11.3

		local var_123_0 = {
			zh = 7.6,
			ja = 11.3
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
				arg_123_0:Play413102030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.475

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_2 = arg_123_1:FormatText(StoryNameCfg[36].name)

				arg_123_1.leftNameTxt_.text = var_126_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2123")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_3 = arg_123_1:GetWordFromCfg(413102029)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 19
				local var_126_6 = utf8.len(var_126_4)
				local var_126_7 = var_126_5 <= 0 and var_126_1 or var_126_1 * (var_126_6 / var_126_5)

				if var_126_7 > 0 and var_126_1 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102029", "story_v_out_413102.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_413102", "413102029", "story_v_out_413102.awb") / 1000

					if var_126_8 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_0
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_413102", "413102029", "story_v_out_413102.awb")

						arg_123_1:RecordAudio("413102029", var_126_9)
						arg_123_1:RecordAudio("413102029", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_413102", "413102029", "story_v_out_413102.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_413102", "413102029", "story_v_out_413102.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_10 and arg_123_1.time_ < var_126_0 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play413102030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 413102030
		arg_127_1.duration_ = 5.63

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play413102031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = manager.ui.mainCamera.transform
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.shakeOldPos = var_130_0.localPosition
			end

			local var_130_2 = 0.4

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / 0.066
				local var_130_4, var_130_5 = math.modf(var_130_3)

				var_130_0.localPosition = Vector3.New(var_130_5 * 0.13, var_130_5 * 0.13, var_130_5 * 0.13) + arg_127_1.var_.shakeOldPos
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 then
				var_130_0.localPosition = arg_127_1.var_.shakeOldPos
			end

			local var_130_6 = 0
			local var_130_7 = 1

			if var_130_6 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				local var_130_8 = "play"
				local var_130_9 = "effect"

				arg_127_1:AudioAction(var_130_8, var_130_9, "se_story_7", "se_story_7_shock", "")
			end

			if arg_127_1.frameCnt_ <= 1 then
				arg_127_1.dialog_:SetActive(false)
			end

			local var_130_10 = 0.633333333333333
			local var_130_11 = 1.15

			if var_130_10 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				arg_127_1.dialog_:SetActive(true)

				arg_127_1.dialogCg_.alpha = 0

				local var_130_12 = LeanTween.value(arg_127_1.dialog_, 0, 1, 0.3)

				var_130_12:setOnUpdate(LuaHelper.FloatAction(function(arg_131_0)
					arg_127_1.dialogCg_.alpha = arg_131_0
				end))
				var_130_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_127_1.dialog_)
					var_130_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_127_1.duration_ = arg_127_1.duration_ + 0.3

				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_13 = arg_127_1:GetWordFromCfg(413102030)
				local var_130_14 = arg_127_1:FormatText(var_130_13.content)

				arg_127_1.text_.text = var_130_14

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_15 = 46
				local var_130_16 = utf8.len(var_130_14)
				local var_130_17 = var_130_15 <= 0 and var_130_11 or var_130_11 * (var_130_16 / var_130_15)

				if var_130_17 > 0 and var_130_11 < var_130_17 then
					arg_127_1.talkMaxDuration = var_130_17
					var_130_10 = var_130_10 + 0.3

					if var_130_17 + var_130_10 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_17 + var_130_10
					end
				end

				arg_127_1.text_.text = var_130_14
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_18 = var_130_10 + 0.3
			local var_130_19 = math.max(var_130_11, arg_127_1.talkMaxDuration)

			if var_130_18 <= arg_127_1.time_ and arg_127_1.time_ < var_130_18 + var_130_19 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_18) / var_130_19

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_18 + var_130_19 and arg_127_1.time_ < var_130_18 + var_130_19 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play413102031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 413102031
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play413102032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 1.25

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

				local var_136_2 = arg_133_1:GetWordFromCfg(413102031)
				local var_136_3 = arg_133_1:FormatText(var_136_2.content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 50
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
	Play413102032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 413102032
		arg_137_1.duration_ = 11.63

		local var_137_0 = {
			zh = 11.633,
			ja = 10
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
				arg_137_0:Play413102033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10095"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos10095 = var_140_0.localPosition
				var_140_0.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10095", 3)

				local var_140_2 = var_140_0.childCount

				for iter_140_0 = 0, var_140_2 - 1 do
					local var_140_3 = var_140_0:GetChild(iter_140_0)

					if var_140_3.name == "split_1_6" or not string.find(var_140_3.name, "split") then
						var_140_3.gameObject:SetActive(true)
					else
						var_140_3.gameObject:SetActive(false)
					end
				end
			end

			local var_140_4 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_4 then
				local var_140_5 = (arg_137_1.time_ - var_140_1) / var_140_4
				local var_140_6 = Vector3.New(0, -405, -10)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10095, var_140_6, var_140_5)
			end

			if arg_137_1.time_ >= var_140_1 + var_140_4 and arg_137_1.time_ < var_140_1 + var_140_4 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0, -405, -10)
			end

			local var_140_7 = arg_137_1.actors_["10095"]
			local var_140_8 = 0

			if var_140_8 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 and not isNil(var_140_7) and arg_137_1.var_.actorSpriteComps10095 == nil then
				arg_137_1.var_.actorSpriteComps10095 = var_140_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_9 = 2

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_9 and not isNil(var_140_7) then
				local var_140_10 = (arg_137_1.time_ - var_140_8) / var_140_9

				if arg_137_1.var_.actorSpriteComps10095 then
					for iter_140_1, iter_140_2 in pairs(arg_137_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_140_2 then
							if arg_137_1.isInRecall_ then
								local var_140_11 = Mathf.Lerp(iter_140_2.color.r, arg_137_1.hightColor1.r, var_140_10)
								local var_140_12 = Mathf.Lerp(iter_140_2.color.g, arg_137_1.hightColor1.g, var_140_10)
								local var_140_13 = Mathf.Lerp(iter_140_2.color.b, arg_137_1.hightColor1.b, var_140_10)

								iter_140_2.color = Color.New(var_140_11, var_140_12, var_140_13)
							else
								local var_140_14 = Mathf.Lerp(iter_140_2.color.r, 1, var_140_10)

								iter_140_2.color = Color.New(var_140_14, var_140_14, var_140_14)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_8 + var_140_9 and arg_137_1.time_ < var_140_8 + var_140_9 + arg_140_0 and not isNil(var_140_7) and arg_137_1.var_.actorSpriteComps10095 then
				for iter_140_3, iter_140_4 in pairs(arg_137_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_140_4 then
						if arg_137_1.isInRecall_ then
							iter_140_4.color = arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_140_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps10095 = nil
			end

			local var_140_15 = 0
			local var_140_16 = 0.75

			if var_140_15 < arg_137_1.time_ and arg_137_1.time_ <= var_140_15 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_17 = arg_137_1:FormatText(StoryNameCfg[1002].name)

				arg_137_1.leftNameTxt_.text = var_140_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_18 = arg_137_1:GetWordFromCfg(413102032)
				local var_140_19 = arg_137_1:FormatText(var_140_18.content)

				arg_137_1.text_.text = var_140_19

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_20 = 30
				local var_140_21 = utf8.len(var_140_19)
				local var_140_22 = var_140_20 <= 0 and var_140_16 or var_140_16 * (var_140_21 / var_140_20)

				if var_140_22 > 0 and var_140_16 < var_140_22 then
					arg_137_1.talkMaxDuration = var_140_22

					if var_140_22 + var_140_15 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_22 + var_140_15
					end
				end

				arg_137_1.text_.text = var_140_19
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102032", "story_v_out_413102.awb") ~= 0 then
					local var_140_23 = manager.audio:GetVoiceLength("story_v_out_413102", "413102032", "story_v_out_413102.awb") / 1000

					if var_140_23 + var_140_15 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_23 + var_140_15
					end

					if var_140_18.prefab_name ~= "" and arg_137_1.actors_[var_140_18.prefab_name] ~= nil then
						local var_140_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_18.prefab_name].transform, "story_v_out_413102", "413102032", "story_v_out_413102.awb")

						arg_137_1:RecordAudio("413102032", var_140_24)
						arg_137_1:RecordAudio("413102032", var_140_24)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_413102", "413102032", "story_v_out_413102.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_413102", "413102032", "story_v_out_413102.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_25 = math.max(var_140_16, arg_137_1.talkMaxDuration)

			if var_140_15 <= arg_137_1.time_ and arg_137_1.time_ < var_140_15 + var_140_25 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_15) / var_140_25

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_15 + var_140_25 and arg_137_1.time_ < var_140_15 + var_140_25 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
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
	Play413102033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 413102033
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play413102034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10095"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos10095 = var_144_0.localPosition
				var_144_0.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10095", 7)

				local var_144_2 = var_144_0.childCount

				for iter_144_0 = 0, var_144_2 - 1 do
					local var_144_3 = var_144_0:GetChild(iter_144_0)

					if var_144_3.name == "split_1_1" or not string.find(var_144_3.name, "split") then
						var_144_3.gameObject:SetActive(true)
					else
						var_144_3.gameObject:SetActive(false)
					end
				end
			end

			local var_144_4 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_4 then
				local var_144_5 = (arg_141_1.time_ - var_144_1) / var_144_4
				local var_144_6 = Vector3.New(0, -2000, 0)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10095, var_144_6, var_144_5)
			end

			if arg_141_1.time_ >= var_144_1 + var_144_4 and arg_141_1.time_ < var_144_1 + var_144_4 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_144_7 = 0
			local var_144_8 = 1.775

			if var_144_7 < arg_141_1.time_ and arg_141_1.time_ <= var_144_7 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_9 = arg_141_1:GetWordFromCfg(413102033)
				local var_144_10 = arg_141_1:FormatText(var_144_9.content)

				arg_141_1.text_.text = var_144_10

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_11 = 71
				local var_144_12 = utf8.len(var_144_10)
				local var_144_13 = var_144_11 <= 0 and var_144_8 or var_144_8 * (var_144_12 / var_144_11)

				if var_144_13 > 0 and var_144_8 < var_144_13 then
					arg_141_1.talkMaxDuration = var_144_13

					if var_144_13 + var_144_7 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_13 + var_144_7
					end
				end

				arg_141_1.text_.text = var_144_10
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_14 = math.max(var_144_8, arg_141_1.talkMaxDuration)

			if var_144_7 <= arg_141_1.time_ and arg_141_1.time_ < var_144_7 + var_144_14 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_7) / var_144_14

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_7 + var_144_14 and arg_141_1.time_ < var_144_7 + var_144_14 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
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
	Play413102034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 413102034
		arg_145_1.duration_ = 8.3

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play413102035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = "SS1307"

			if arg_145_1.bgs_[var_148_0] == nil then
				local var_148_1 = Object.Instantiate(arg_145_1.paintGo_)

				var_148_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_148_0)
				var_148_1.name = var_148_0
				var_148_1.transform.parent = arg_145_1.stage_.transform
				var_148_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.bgs_[var_148_0] = var_148_1
			end

			local var_148_2 = 1.3

			if var_148_2 < arg_145_1.time_ and arg_145_1.time_ <= var_148_2 + arg_148_0 then
				local var_148_3 = manager.ui.mainCamera.transform.localPosition
				local var_148_4 = Vector3.New(0, 0, 10) + Vector3.New(var_148_3.x, var_148_3.y, 0)
				local var_148_5 = arg_145_1.bgs_.SS1307

				var_148_5.transform.localPosition = var_148_4
				var_148_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_148_6 = var_148_5:GetComponent("SpriteRenderer")

				if var_148_6 and var_148_6.sprite then
					local var_148_7 = (var_148_5.transform.localPosition - var_148_3).z
					local var_148_8 = manager.ui.mainCameraCom_
					local var_148_9 = 2 * var_148_7 * Mathf.Tan(var_148_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_148_10 = var_148_9 * var_148_8.aspect
					local var_148_11 = var_148_6.sprite.bounds.size.x
					local var_148_12 = var_148_6.sprite.bounds.size.y
					local var_148_13 = var_148_10 / var_148_11
					local var_148_14 = var_148_9 / var_148_12
					local var_148_15 = var_148_14 < var_148_13 and var_148_13 or var_148_14

					var_148_5.transform.localScale = Vector3.New(var_148_15, var_148_15, 0)
				end

				for iter_148_0, iter_148_1 in pairs(arg_145_1.bgs_) do
					if iter_148_0 ~= "SS1307" then
						iter_148_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_148_16 = 0

			if var_148_16 < arg_145_1.time_ and arg_145_1.time_ <= var_148_16 + arg_148_0 then
				arg_145_1.allBtn_.enabled = false
			end

			local var_148_17 = 0.3

			if arg_145_1.time_ >= var_148_16 + var_148_17 and arg_145_1.time_ < var_148_16 + var_148_17 + arg_148_0 then
				arg_145_1.allBtn_.enabled = true
			end

			local var_148_18 = 0

			if var_148_18 < arg_145_1.time_ and arg_145_1.time_ <= var_148_18 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_19 = 1.3

			if var_148_18 <= arg_145_1.time_ and arg_145_1.time_ < var_148_18 + var_148_19 then
				local var_148_20 = (arg_145_1.time_ - var_148_18) / var_148_19
				local var_148_21 = Color.New(0, 0, 0)

				var_148_21.a = Mathf.Lerp(0, 1, var_148_20)
				arg_145_1.mask_.color = var_148_21
			end

			if arg_145_1.time_ >= var_148_18 + var_148_19 and arg_145_1.time_ < var_148_18 + var_148_19 + arg_148_0 then
				local var_148_22 = Color.New(0, 0, 0)

				var_148_22.a = 1
				arg_145_1.mask_.color = var_148_22
			end

			local var_148_23 = 1.3

			if var_148_23 < arg_145_1.time_ and arg_145_1.time_ <= var_148_23 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_24 = 2

			if var_148_23 <= arg_145_1.time_ and arg_145_1.time_ < var_148_23 + var_148_24 then
				local var_148_25 = (arg_145_1.time_ - var_148_23) / var_148_24
				local var_148_26 = Color.New(0, 0, 0)

				var_148_26.a = Mathf.Lerp(1, 0, var_148_25)
				arg_145_1.mask_.color = var_148_26
			end

			if arg_145_1.time_ >= var_148_23 + var_148_24 and arg_145_1.time_ < var_148_23 + var_148_24 + arg_148_0 then
				local var_148_27 = Color.New(0, 0, 0)
				local var_148_28 = 0

				arg_145_1.mask_.enabled = false
				var_148_27.a = var_148_28
				arg_145_1.mask_.color = var_148_27
			end

			local var_148_29 = arg_145_1.bgs_.SS1307.transform
			local var_148_30 = 1.3

			if var_148_30 < arg_145_1.time_ and arg_145_1.time_ <= var_148_30 + arg_148_0 then
				arg_145_1.var_.moveOldPosSS1307 = var_148_29.localPosition
			end

			local var_148_31 = 0.001

			if var_148_30 <= arg_145_1.time_ and arg_145_1.time_ < var_148_30 + var_148_31 then
				local var_148_32 = (arg_145_1.time_ - var_148_30) / var_148_31
				local var_148_33 = Vector3.New(-3, 1.8, 1.5)

				var_148_29.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPosSS1307, var_148_33, var_148_32)
			end

			if arg_145_1.time_ >= var_148_30 + var_148_31 and arg_145_1.time_ < var_148_30 + var_148_31 + arg_148_0 then
				var_148_29.localPosition = Vector3.New(-3, 1.8, 1.5)
			end

			local var_148_34 = arg_145_1.bgs_.SS1307.transform
			local var_148_35 = 1.31666666666667

			if var_148_35 < arg_145_1.time_ and arg_145_1.time_ <= var_148_35 + arg_148_0 then
				arg_145_1.var_.moveOldPosSS1307 = var_148_34.localPosition
			end

			local var_148_36 = 3.5

			if var_148_35 <= arg_145_1.time_ and arg_145_1.time_ < var_148_35 + var_148_36 then
				local var_148_37 = (arg_145_1.time_ - var_148_35) / var_148_36
				local var_148_38 = Vector3.New(-3, 1.5, 1)

				var_148_34.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPosSS1307, var_148_38, var_148_37)
			end

			if arg_145_1.time_ >= var_148_35 + var_148_36 and arg_145_1.time_ < var_148_35 + var_148_36 + arg_148_0 then
				var_148_34.localPosition = Vector3.New(-3, 1.5, 1)
			end

			local var_148_39 = manager.ui.mainCamera.transform
			local var_148_40 = 1.3

			if var_148_40 < arg_145_1.time_ and arg_145_1.time_ <= var_148_40 + arg_148_0 then
				arg_145_1.var_.shakeOldPos = var_148_39.localPosition
			end

			local var_148_41 = 1.5

			if var_148_40 <= arg_145_1.time_ and arg_145_1.time_ < var_148_40 + var_148_41 then
				local var_148_42 = (arg_145_1.time_ - var_148_40) / 0.066
				local var_148_43, var_148_44 = math.modf(var_148_42)

				var_148_39.localPosition = Vector3.New(var_148_44 * 0.13, var_148_44 * 0.13, var_148_44 * 0.13) + arg_145_1.var_.shakeOldPos
			end

			if arg_145_1.time_ >= var_148_40 + var_148_41 and arg_145_1.time_ < var_148_40 + var_148_41 + arg_148_0 then
				var_148_39.localPosition = arg_145_1.var_.shakeOldPos
			end

			local var_148_45 = 2.8

			if var_148_45 < arg_145_1.time_ and arg_145_1.time_ <= var_148_45 + arg_148_0 then
				arg_145_1.allBtn_.enabled = false
			end

			local var_148_46 = 2

			if arg_145_1.time_ >= var_148_45 + var_148_46 and arg_145_1.time_ < var_148_45 + var_148_46 + arg_148_0 then
				arg_145_1.allBtn_.enabled = true
			end

			if arg_145_1.frameCnt_ <= 1 then
				arg_145_1.dialog_:SetActive(false)
			end

			local var_148_47 = 3.3
			local var_148_48 = 1.5

			if var_148_47 < arg_145_1.time_ and arg_145_1.time_ <= var_148_47 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				arg_145_1.dialog_:SetActive(true)

				arg_145_1.dialogCg_.alpha = 0

				local var_148_49 = LeanTween.value(arg_145_1.dialog_, 0, 1, 0.3)

				var_148_49:setOnUpdate(LuaHelper.FloatAction(function(arg_149_0)
					arg_145_1.dialogCg_.alpha = arg_149_0
				end))
				var_148_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_145_1.dialog_)
					var_148_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_145_1.duration_ = arg_145_1.duration_ + 0.3

				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_50 = arg_145_1:GetWordFromCfg(413102034)
				local var_148_51 = arg_145_1:FormatText(var_148_50.content)

				arg_145_1.text_.text = var_148_51

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_52 = 60
				local var_148_53 = utf8.len(var_148_51)
				local var_148_54 = var_148_52 <= 0 and var_148_48 or var_148_48 * (var_148_53 / var_148_52)

				if var_148_54 > 0 and var_148_48 < var_148_54 then
					arg_145_1.talkMaxDuration = var_148_54
					var_148_47 = var_148_47 + 0.3

					if var_148_54 + var_148_47 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_54 + var_148_47
					end
				end

				arg_145_1.text_.text = var_148_51
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_55 = var_148_47 + 0.3
			local var_148_56 = math.max(var_148_48, arg_145_1.talkMaxDuration)

			if var_148_55 <= arg_145_1.time_ and arg_145_1.time_ < var_148_55 + var_148_56 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_55) / var_148_56

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_55 + var_148_56 and arg_145_1.time_ < var_148_55 + var_148_56 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1307",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1307",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 1.31666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play413102035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 413102035
		arg_151_1.duration_ = 6.43

		local var_151_0 = {
			zh = 6.433,
			ja = 5.3
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
				arg_151_0:Play413102036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.mask_.enabled = true
				arg_151_1.mask_.raycastTarget = true

				arg_151_1:SetGaussion(false)
			end

			local var_154_1 = 1.3

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_1 then
				local var_154_2 = (arg_151_1.time_ - var_154_0) / var_154_1
				local var_154_3 = Color.New(0, 0, 0)

				var_154_3.a = Mathf.Lerp(0, 1, var_154_2)
				arg_151_1.mask_.color = var_154_3
			end

			if arg_151_1.time_ >= var_154_0 + var_154_1 and arg_151_1.time_ < var_154_0 + var_154_1 + arg_154_0 then
				local var_154_4 = Color.New(0, 0, 0)

				var_154_4.a = 1
				arg_151_1.mask_.color = var_154_4
			end

			local var_154_5 = 1.3

			if var_154_5 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1.mask_.enabled = true
				arg_151_1.mask_.raycastTarget = true

				arg_151_1:SetGaussion(false)
			end

			local var_154_6 = 2

			if var_154_5 <= arg_151_1.time_ and arg_151_1.time_ < var_154_5 + var_154_6 then
				local var_154_7 = (arg_151_1.time_ - var_154_5) / var_154_6
				local var_154_8 = Color.New(0, 0, 0)

				var_154_8.a = Mathf.Lerp(1, 0, var_154_7)
				arg_151_1.mask_.color = var_154_8
			end

			if arg_151_1.time_ >= var_154_5 + var_154_6 and arg_151_1.time_ < var_154_5 + var_154_6 + arg_154_0 then
				local var_154_9 = Color.New(0, 0, 0)
				local var_154_10 = 0

				arg_151_1.mask_.enabled = false
				var_154_9.a = var_154_10
				arg_151_1.mask_.color = var_154_9
			end

			local var_154_11 = arg_151_1.bgs_.SS1307.transform
			local var_154_12 = 1.3

			if var_154_12 < arg_151_1.time_ and arg_151_1.time_ <= var_154_12 + arg_154_0 then
				arg_151_1.var_.moveOldPosSS1307 = var_154_11.localPosition
			end

			local var_154_13 = 0.001

			if var_154_12 <= arg_151_1.time_ and arg_151_1.time_ < var_154_12 + var_154_13 then
				local var_154_14 = (arg_151_1.time_ - var_154_12) / var_154_13
				local var_154_15 = Vector3.New(0, 1, 9.5)

				var_154_11.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPosSS1307, var_154_15, var_154_14)
			end

			if arg_151_1.time_ >= var_154_12 + var_154_13 and arg_151_1.time_ < var_154_12 + var_154_13 + arg_154_0 then
				var_154_11.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_154_16 = arg_151_1.bgs_.SS1307.transform
			local var_154_17 = 1.31666666666667

			if var_154_17 < arg_151_1.time_ and arg_151_1.time_ <= var_154_17 + arg_154_0 then
				arg_151_1.var_.moveOldPosSS1307 = var_154_16.localPosition
			end

			local var_154_18 = 3.5

			if var_154_17 <= arg_151_1.time_ and arg_151_1.time_ < var_154_17 + var_154_18 then
				local var_154_19 = (arg_151_1.time_ - var_154_17) / var_154_18
				local var_154_20 = Vector3.New(0, 1, 10)

				var_154_16.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPosSS1307, var_154_20, var_154_19)
			end

			if arg_151_1.time_ >= var_154_17 + var_154_18 and arg_151_1.time_ < var_154_17 + var_154_18 + arg_154_0 then
				var_154_16.localPosition = Vector3.New(0, 1, 10)
			end

			local var_154_21 = manager.ui.mainCamera.transform
			local var_154_22 = 1.3

			if var_154_22 < arg_151_1.time_ and arg_151_1.time_ <= var_154_22 + arg_154_0 then
				local var_154_23 = arg_151_1.var_.effectshuidi1
				local var_154_24
				local var_154_25 = var_154_21

				if not var_154_23 then
					var_154_23 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), var_154_25)
					var_154_23.name = "shuidi1"
					arg_151_1.var_.effectshuidi1 = var_154_23
				else
					var_154_23.transform:SetParent(var_154_25)
				end

				var_154_23.transform.localPosition = Vector3.New(0, 0, 0)
				var_154_23.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_151_1.frameCnt_ <= 1 then
				arg_151_1.dialog_:SetActive(false)
			end

			local var_154_26 = 2.9
			local var_154_27 = 0.4

			if var_154_26 < arg_151_1.time_ and arg_151_1.time_ <= var_154_26 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0

				arg_151_1.dialog_:SetActive(true)

				arg_151_1.dialogCg_.alpha = 0

				local var_154_28 = LeanTween.value(arg_151_1.dialog_, 0, 1, 0.3)

				var_154_28:setOnUpdate(LuaHelper.FloatAction(function(arg_155_0)
					arg_151_1.dialogCg_.alpha = arg_155_0
				end))
				var_154_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_151_1.dialog_)
					var_154_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_151_1.duration_ = arg_151_1.duration_ + 0.3

				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_29 = arg_151_1:FormatText(StoryNameCfg[259].name)

				arg_151_1.leftNameTxt_.text = var_154_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_30 = arg_151_1:GetWordFromCfg(413102035)
				local var_154_31 = arg_151_1:FormatText(var_154_30.content)

				arg_151_1.text_.text = var_154_31

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_32 = 16
				local var_154_33 = utf8.len(var_154_31)
				local var_154_34 = var_154_32 <= 0 and var_154_27 or var_154_27 * (var_154_33 / var_154_32)

				if var_154_34 > 0 and var_154_27 < var_154_34 then
					arg_151_1.talkMaxDuration = var_154_34
					var_154_26 = var_154_26 + 0.3

					if var_154_34 + var_154_26 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_34 + var_154_26
					end
				end

				arg_151_1.text_.text = var_154_31
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102035", "story_v_out_413102.awb") ~= 0 then
					local var_154_35 = manager.audio:GetVoiceLength("story_v_out_413102", "413102035", "story_v_out_413102.awb") / 1000

					if var_154_35 + var_154_26 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_35 + var_154_26
					end

					if var_154_30.prefab_name ~= "" and arg_151_1.actors_[var_154_30.prefab_name] ~= nil then
						local var_154_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_30.prefab_name].transform, "story_v_out_413102", "413102035", "story_v_out_413102.awb")

						arg_151_1:RecordAudio("413102035", var_154_36)
						arg_151_1:RecordAudio("413102035", var_154_36)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_413102", "413102035", "story_v_out_413102.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_413102", "413102035", "story_v_out_413102.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_37 = var_154_26 + 0.3
			local var_154_38 = math.max(var_154_27, arg_151_1.talkMaxDuration)

			if var_154_37 <= arg_151_1.time_ and arg_151_1.time_ < var_154_37 + var_154_38 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_37) / var_154_38

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_37 + var_154_38 and arg_151_1.time_ < var_154_37 + var_154_38 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1307",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1307",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 1.31666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play413102036 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 413102036
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play413102037(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 1

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				local var_160_2 = "play"
				local var_160_3 = "effect"

				arg_157_1:AudioAction(var_160_2, var_160_3, "se_story_side_1094", "se_story_1094_heartbeat", "")
			end

			local var_160_4 = 0
			local var_160_5 = 1.525

			if var_160_4 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:GetWordFromCfg(413102036)
				local var_160_7 = arg_157_1:FormatText(var_160_6.content)

				arg_157_1.text_.text = var_160_7

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_8 = 61
				local var_160_9 = utf8.len(var_160_7)
				local var_160_10 = var_160_8 <= 0 and var_160_5 or var_160_5 * (var_160_9 / var_160_8)

				if var_160_10 > 0 and var_160_5 < var_160_10 then
					arg_157_1.talkMaxDuration = var_160_10

					if var_160_10 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_7
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_11 = math.max(var_160_5, arg_157_1.talkMaxDuration)

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_11 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_4) / var_160_11

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_4 + var_160_11 and arg_157_1.time_ < var_160_4 + var_160_11 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play413102037 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 413102037
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play413102038(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.9

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_2 = arg_161_1:GetWordFromCfg(413102037)
				local var_164_3 = arg_161_1:FormatText(var_164_2.content)

				arg_161_1.text_.text = var_164_3

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 36
				local var_164_5 = utf8.len(var_164_3)
				local var_164_6 = var_164_4 <= 0 and var_164_1 or var_164_1 * (var_164_5 / var_164_4)

				if var_164_6 > 0 and var_164_1 < var_164_6 then
					arg_161_1.talkMaxDuration = var_164_6

					if var_164_6 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_6 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_3
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_7 and arg_161_1.time_ < var_164_0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play413102038 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 413102038
		arg_165_1.duration_ = 3.97

		local var_165_0 = {
			zh = 3.8,
			ja = 3.966
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
				arg_165_0:Play413102039(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.325

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[259].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:GetWordFromCfg(413102038)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 13
				local var_168_6 = utf8.len(var_168_4)
				local var_168_7 = var_168_5 <= 0 and var_168_1 or var_168_1 * (var_168_6 / var_168_5)

				if var_168_7 > 0 and var_168_1 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102038", "story_v_out_413102.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_413102", "413102038", "story_v_out_413102.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_413102", "413102038", "story_v_out_413102.awb")

						arg_165_1:RecordAudio("413102038", var_168_9)
						arg_165_1:RecordAudio("413102038", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_413102", "413102038", "story_v_out_413102.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_413102", "413102038", "story_v_out_413102.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_10 and arg_165_1.time_ < var_168_0 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play413102039 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 413102039
		arg_169_1.duration_ = 6.46

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play413102040(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.bgs_.SS1307.transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPosSS1307 = var_172_0.localPosition
			end

			local var_172_2 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2
				local var_172_4 = Vector3.New(0, 1, 10)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPosSS1307, var_172_4, var_172_3)
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(0, 1, 10)
			end

			local var_172_5 = arg_169_1.bgs_.SS1307.transform
			local var_172_6 = 0.034

			if var_172_6 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.var_.moveOldPosSS1307 = var_172_5.localPosition
			end

			local var_172_7 = 2.49933333333333

			if var_172_6 <= arg_169_1.time_ and arg_169_1.time_ < var_172_6 + var_172_7 then
				local var_172_8 = (arg_169_1.time_ - var_172_6) / var_172_7
				local var_172_9 = Vector3.New(0, 1, 8.5)

				var_172_5.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPosSS1307, var_172_9, var_172_8)
			end

			if arg_169_1.time_ >= var_172_6 + var_172_7 and arg_169_1.time_ < var_172_6 + var_172_7 + arg_172_0 then
				var_172_5.localPosition = Vector3.New(0, 1, 8.5)
			end

			local var_172_10 = 0

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_11 = 1

			if var_172_10 <= arg_169_1.time_ and arg_169_1.time_ < var_172_10 + var_172_11 then
				local var_172_12 = (arg_169_1.time_ - var_172_10) / var_172_11
				local var_172_13 = Color.New(1, 1, 1)

				var_172_13.a = Mathf.Lerp(1, 0, var_172_12)
				arg_169_1.mask_.color = var_172_13
			end

			if arg_169_1.time_ >= var_172_10 + var_172_11 and arg_169_1.time_ < var_172_10 + var_172_11 + arg_172_0 then
				local var_172_14 = Color.New(1, 1, 1)
				local var_172_15 = 0

				arg_169_1.mask_.enabled = false
				var_172_14.a = var_172_15
				arg_169_1.mask_.color = var_172_14
			end

			local var_172_16 = 0
			local var_172_17 = 1

			if var_172_16 < arg_169_1.time_ and arg_169_1.time_ <= var_172_16 + arg_172_0 then
				local var_172_18 = "play"
				local var_172_19 = "effect"

				arg_169_1:AudioAction(var_172_18, var_172_19, "se_story_8", "se_story_8_water03", "")
			end

			local var_172_20 = manager.ui.mainCamera.transform
			local var_172_21 = 0

			if var_172_21 < arg_169_1.time_ and arg_169_1.time_ <= var_172_21 + arg_172_0 then
				local var_172_22 = arg_169_1.var_.effectshuidi1

				if var_172_22 then
					Object.Destroy(var_172_22)

					arg_169_1.var_.effectshuidi1 = nil
				end
			end

			if arg_169_1.frameCnt_ <= 1 then
				arg_169_1.dialog_:SetActive(false)
			end

			local var_172_23 = 1.45833333333333
			local var_172_24 = 1.075

			if var_172_23 < arg_169_1.time_ and arg_169_1.time_ <= var_172_23 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				arg_169_1.dialog_:SetActive(true)

				arg_169_1.dialogCg_.alpha = 0

				local var_172_25 = LeanTween.value(arg_169_1.dialog_, 0, 1, 0.3)

				var_172_25:setOnUpdate(LuaHelper.FloatAction(function(arg_173_0)
					arg_169_1.dialogCg_.alpha = arg_173_0
				end))
				var_172_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_169_1.dialog_)
					var_172_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_169_1.duration_ = arg_169_1.duration_ + 0.3

				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_26 = arg_169_1:GetWordFromCfg(413102039)
				local var_172_27 = arg_169_1:FormatText(var_172_26.content)

				arg_169_1.text_.text = var_172_27

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_28 = 43
				local var_172_29 = utf8.len(var_172_27)
				local var_172_30 = var_172_28 <= 0 and var_172_24 or var_172_24 * (var_172_29 / var_172_28)

				if var_172_30 > 0 and var_172_24 < var_172_30 then
					arg_169_1.talkMaxDuration = var_172_30
					var_172_23 = var_172_23 + 0.3

					if var_172_30 + var_172_23 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_30 + var_172_23
					end
				end

				arg_169_1.text_.text = var_172_27
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_31 = var_172_23 + 0.3
			local var_172_32 = math.max(var_172_24, arg_169_1.talkMaxDuration)

			if var_172_31 <= arg_169_1.time_ and arg_169_1.time_ < var_172_31 + var_172_32 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_31) / var_172_32

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_31 + var_172_32 and arg_169_1.time_ < var_172_31 + var_172_32 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1307",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1307",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.49933333333333,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play413102040 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 413102040
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play413102041(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 1.4

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_2 = arg_175_1:GetWordFromCfg(413102040)
				local var_178_3 = arg_175_1:FormatText(var_178_2.content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 56
				local var_178_5 = utf8.len(var_178_3)
				local var_178_6 = var_178_4 <= 0 and var_178_1 or var_178_1 * (var_178_5 / var_178_4)

				if var_178_6 > 0 and var_178_1 < var_178_6 then
					arg_175_1.talkMaxDuration = var_178_6

					if var_178_6 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_6 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_3
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_7 and arg_175_1.time_ < var_178_0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play413102041 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 413102041
		arg_179_1.duration_ = 1.5

		local var_179_0 = {
			zh = 1.5,
			ja = 1.133
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
				arg_179_0:Play413102042(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.125

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[259].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_3 = arg_179_1:GetWordFromCfg(413102041)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102041", "story_v_out_413102.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_out_413102", "413102041", "story_v_out_413102.awb") / 1000

					if var_182_8 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_0
					end

					if var_182_3.prefab_name ~= "" and arg_179_1.actors_[var_182_3.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_3.prefab_name].transform, "story_v_out_413102", "413102041", "story_v_out_413102.awb")

						arg_179_1:RecordAudio("413102041", var_182_9)
						arg_179_1:RecordAudio("413102041", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_413102", "413102041", "story_v_out_413102.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_413102", "413102041", "story_v_out_413102.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_10 and arg_179_1.time_ < var_182_0 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play413102042 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 413102042
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play413102043(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 1.375

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_2 = arg_183_1:GetWordFromCfg(413102042)
				local var_186_3 = arg_183_1:FormatText(var_186_2.content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 55
				local var_186_5 = utf8.len(var_186_3)
				local var_186_6 = var_186_4 <= 0 and var_186_1 or var_186_1 * (var_186_5 / var_186_4)

				if var_186_6 > 0 and var_186_1 < var_186_6 then
					arg_183_1.talkMaxDuration = var_186_6

					if var_186_6 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_6 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_7 and arg_183_1.time_ < var_186_0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play413102043 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 413102043
		arg_187_1.duration_ = 8.23

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play413102044(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 1.5

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				local var_190_1 = manager.ui.mainCamera.transform.localPosition
				local var_190_2 = Vector3.New(0, 0, 10) + Vector3.New(var_190_1.x, var_190_1.y, 0)
				local var_190_3 = arg_187_1.bgs_.F09f

				var_190_3.transform.localPosition = var_190_2
				var_190_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_190_4 = var_190_3:GetComponent("SpriteRenderer")

				if var_190_4 and var_190_4.sprite then
					local var_190_5 = (var_190_3.transform.localPosition - var_190_1).z
					local var_190_6 = manager.ui.mainCameraCom_
					local var_190_7 = 2 * var_190_5 * Mathf.Tan(var_190_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_190_8 = var_190_7 * var_190_6.aspect
					local var_190_9 = var_190_4.sprite.bounds.size.x
					local var_190_10 = var_190_4.sprite.bounds.size.y
					local var_190_11 = var_190_8 / var_190_9
					local var_190_12 = var_190_7 / var_190_10
					local var_190_13 = var_190_12 < var_190_11 and var_190_11 or var_190_12

					var_190_3.transform.localScale = Vector3.New(var_190_13, var_190_13, 0)
				end

				for iter_190_0, iter_190_1 in pairs(arg_187_1.bgs_) do
					if iter_190_0 ~= "F09f" then
						iter_190_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_190_14 = 3.23333333333333

			if var_190_14 < arg_187_1.time_ and arg_187_1.time_ <= var_190_14 + arg_190_0 then
				arg_187_1.allBtn_.enabled = false
			end

			local var_190_15 = 0.3

			if arg_187_1.time_ >= var_190_14 + var_190_15 and arg_187_1.time_ < var_190_14 + var_190_15 + arg_190_0 then
				arg_187_1.allBtn_.enabled = true
			end

			local var_190_16 = 0

			if var_190_16 < arg_187_1.time_ and arg_187_1.time_ <= var_190_16 + arg_190_0 then
				arg_187_1.mask_.enabled = true
				arg_187_1.mask_.raycastTarget = true

				arg_187_1:SetGaussion(false)
			end

			local var_190_17 = 1.5

			if var_190_16 <= arg_187_1.time_ and arg_187_1.time_ < var_190_16 + var_190_17 then
				local var_190_18 = (arg_187_1.time_ - var_190_16) / var_190_17
				local var_190_19 = Color.New(0, 0, 0)

				var_190_19.a = Mathf.Lerp(0, 1, var_190_18)
				arg_187_1.mask_.color = var_190_19
			end

			if arg_187_1.time_ >= var_190_16 + var_190_17 and arg_187_1.time_ < var_190_16 + var_190_17 + arg_190_0 then
				local var_190_20 = Color.New(0, 0, 0)

				var_190_20.a = 1
				arg_187_1.mask_.color = var_190_20
			end

			local var_190_21 = 1.5

			if var_190_21 < arg_187_1.time_ and arg_187_1.time_ <= var_190_21 + arg_190_0 then
				arg_187_1.mask_.enabled = true
				arg_187_1.mask_.raycastTarget = true

				arg_187_1:SetGaussion(false)
			end

			local var_190_22 = 1.9

			if var_190_21 <= arg_187_1.time_ and arg_187_1.time_ < var_190_21 + var_190_22 then
				local var_190_23 = (arg_187_1.time_ - var_190_21) / var_190_22
				local var_190_24 = Color.New(0, 0, 0)

				var_190_24.a = Mathf.Lerp(1, 0, var_190_23)
				arg_187_1.mask_.color = var_190_24
			end

			if arg_187_1.time_ >= var_190_21 + var_190_22 and arg_187_1.time_ < var_190_21 + var_190_22 + arg_190_0 then
				local var_190_25 = Color.New(0, 0, 0)
				local var_190_26 = 0

				arg_187_1.mask_.enabled = false
				var_190_25.a = var_190_26
				arg_187_1.mask_.color = var_190_25
			end

			local var_190_27 = 1.13333333333333
			local var_190_28 = 1

			if var_190_27 < arg_187_1.time_ and arg_187_1.time_ <= var_190_27 + arg_190_0 then
				local var_190_29 = "stop"
				local var_190_30 = "effect"

				arg_187_1:AudioAction(var_190_29, var_190_30, "se_story_side_1094", "se_story_1094_heartbeat", "")
			end

			if arg_187_1.frameCnt_ <= 1 then
				arg_187_1.dialog_:SetActive(false)
			end

			local var_190_31 = 3.23333333333333
			local var_190_32 = 0.7

			if var_190_31 < arg_187_1.time_ and arg_187_1.time_ <= var_190_31 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0

				arg_187_1.dialog_:SetActive(true)

				arg_187_1.dialogCg_.alpha = 0

				local var_190_33 = LeanTween.value(arg_187_1.dialog_, 0, 1, 0.3)

				var_190_33:setOnUpdate(LuaHelper.FloatAction(function(arg_191_0)
					arg_187_1.dialogCg_.alpha = arg_191_0
				end))
				var_190_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_187_1.dialog_)
					var_190_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_187_1.duration_ = arg_187_1.duration_ + 0.3

				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_34 = arg_187_1:GetWordFromCfg(413102043)
				local var_190_35 = arg_187_1:FormatText(var_190_34.content)

				arg_187_1.text_.text = var_190_35

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_36 = 28
				local var_190_37 = utf8.len(var_190_35)
				local var_190_38 = var_190_36 <= 0 and var_190_32 or var_190_32 * (var_190_37 / var_190_36)

				if var_190_38 > 0 and var_190_32 < var_190_38 then
					arg_187_1.talkMaxDuration = var_190_38
					var_190_31 = var_190_31 + 0.3

					if var_190_38 + var_190_31 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_38 + var_190_31
					end
				end

				arg_187_1.text_.text = var_190_35
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_39 = var_190_31 + 0.3
			local var_190_40 = math.max(var_190_32, arg_187_1.talkMaxDuration)

			if var_190_39 <= arg_187_1.time_ and arg_187_1.time_ < var_190_39 + var_190_40 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_39) / var_190_40

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_39 + var_190_40 and arg_187_1.time_ < var_190_39 + var_190_40 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play413102044 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 413102044
		arg_193_1.duration_ = 16.03

		local var_193_0 = {
			zh = 9,
			ja = 16.033
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play413102045(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10096"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos10096 = var_196_0.localPosition
				var_196_0.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10096", 3)

				local var_196_2 = var_196_0.childCount

				for iter_196_0 = 0, var_196_2 - 1 do
					local var_196_3 = var_196_0:GetChild(iter_196_0)

					if var_196_3.name == "" or not string.find(var_196_3.name, "split") then
						var_196_3.gameObject:SetActive(true)
					else
						var_196_3.gameObject:SetActive(false)
					end
				end
			end

			local var_196_4 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_4 then
				local var_196_5 = (arg_193_1.time_ - var_196_1) / var_196_4
				local var_196_6 = Vector3.New(0, -350, -210)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10096, var_196_6, var_196_5)
			end

			if arg_193_1.time_ >= var_196_1 + var_196_4 and arg_193_1.time_ < var_196_1 + var_196_4 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(0, -350, -210)
			end

			local var_196_7 = arg_193_1.actors_["10096"]
			local var_196_8 = 0

			if var_196_8 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 and not isNil(var_196_7) and arg_193_1.var_.actorSpriteComps10096 == nil then
				arg_193_1.var_.actorSpriteComps10096 = var_196_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_9 = 2

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_9 and not isNil(var_196_7) then
				local var_196_10 = (arg_193_1.time_ - var_196_8) / var_196_9

				if arg_193_1.var_.actorSpriteComps10096 then
					for iter_196_1, iter_196_2 in pairs(arg_193_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_196_2 then
							if arg_193_1.isInRecall_ then
								local var_196_11 = Mathf.Lerp(iter_196_2.color.r, arg_193_1.hightColor1.r, var_196_10)
								local var_196_12 = Mathf.Lerp(iter_196_2.color.g, arg_193_1.hightColor1.g, var_196_10)
								local var_196_13 = Mathf.Lerp(iter_196_2.color.b, arg_193_1.hightColor1.b, var_196_10)

								iter_196_2.color = Color.New(var_196_11, var_196_12, var_196_13)
							else
								local var_196_14 = Mathf.Lerp(iter_196_2.color.r, 1, var_196_10)

								iter_196_2.color = Color.New(var_196_14, var_196_14, var_196_14)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_8 + var_196_9 and arg_193_1.time_ < var_196_8 + var_196_9 + arg_196_0 and not isNil(var_196_7) and arg_193_1.var_.actorSpriteComps10096 then
				for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_196_4 then
						if arg_193_1.isInRecall_ then
							iter_196_4.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_196_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10096 = nil
			end

			local var_196_15 = 0
			local var_196_16 = 0.575

			if var_196_15 < arg_193_1.time_ and arg_193_1.time_ <= var_196_15 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_17 = arg_193_1:FormatText(StoryNameCfg[36].name)

				arg_193_1.leftNameTxt_.text = var_196_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_18 = arg_193_1:GetWordFromCfg(413102044)
				local var_196_19 = arg_193_1:FormatText(var_196_18.content)

				arg_193_1.text_.text = var_196_19

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_20 = 23
				local var_196_21 = utf8.len(var_196_19)
				local var_196_22 = var_196_20 <= 0 and var_196_16 or var_196_16 * (var_196_21 / var_196_20)

				if var_196_22 > 0 and var_196_16 < var_196_22 then
					arg_193_1.talkMaxDuration = var_196_22

					if var_196_22 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_22 + var_196_15
					end
				end

				arg_193_1.text_.text = var_196_19
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102044", "story_v_out_413102.awb") ~= 0 then
					local var_196_23 = manager.audio:GetVoiceLength("story_v_out_413102", "413102044", "story_v_out_413102.awb") / 1000

					if var_196_23 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_23 + var_196_15
					end

					if var_196_18.prefab_name ~= "" and arg_193_1.actors_[var_196_18.prefab_name] ~= nil then
						local var_196_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_18.prefab_name].transform, "story_v_out_413102", "413102044", "story_v_out_413102.awb")

						arg_193_1:RecordAudio("413102044", var_196_24)
						arg_193_1:RecordAudio("413102044", var_196_24)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_413102", "413102044", "story_v_out_413102.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_413102", "413102044", "story_v_out_413102.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_25 = math.max(var_196_16, arg_193_1.talkMaxDuration)

			if var_196_15 <= arg_193_1.time_ and arg_193_1.time_ < var_196_15 + var_196_25 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_15) / var_196_25

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_15 + var_196_25 and arg_193_1.time_ < var_196_15 + var_196_25 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play413102045 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 413102045
		arg_197_1.duration_ = 3.3

		local var_197_0 = {
			zh = 3.3,
			ja = 2.966
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play413102046(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = "10094"

			if arg_197_1.actors_[var_200_0] == nil then
				local var_200_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_200_1) then
					local var_200_2 = Object.Instantiate(var_200_1, arg_197_1.canvasGo_.transform)

					var_200_2.transform:SetSiblingIndex(1)

					var_200_2.name = var_200_0
					var_200_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_197_1.actors_[var_200_0] = var_200_2

					local var_200_3 = var_200_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_197_1.isInRecall_ then
						for iter_200_0, iter_200_1 in ipairs(var_200_3) do
							iter_200_1.color = arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_200_4 = arg_197_1.actors_["10094"].transform
			local var_200_5 = 0

			if var_200_5 < arg_197_1.time_ and arg_197_1.time_ <= var_200_5 + arg_200_0 then
				arg_197_1.var_.moveOldPos10094 = var_200_4.localPosition
				var_200_4.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("10094", 3)

				local var_200_6 = var_200_4.childCount

				for iter_200_2 = 0, var_200_6 - 1 do
					local var_200_7 = var_200_4:GetChild(iter_200_2)

					if var_200_7.name == "split_1" or not string.find(var_200_7.name, "split") then
						var_200_7.gameObject:SetActive(true)
					else
						var_200_7.gameObject:SetActive(false)
					end
				end
			end

			local var_200_8 = 0.001

			if var_200_5 <= arg_197_1.time_ and arg_197_1.time_ < var_200_5 + var_200_8 then
				local var_200_9 = (arg_197_1.time_ - var_200_5) / var_200_8
				local var_200_10 = Vector3.New(0, -340, -414)

				var_200_4.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10094, var_200_10, var_200_9)
			end

			if arg_197_1.time_ >= var_200_5 + var_200_8 and arg_197_1.time_ < var_200_5 + var_200_8 + arg_200_0 then
				var_200_4.localPosition = Vector3.New(0, -340, -414)
			end

			local var_200_11 = arg_197_1.actors_["10096"].transform
			local var_200_12 = 0

			if var_200_12 < arg_197_1.time_ and arg_197_1.time_ <= var_200_12 + arg_200_0 then
				arg_197_1.var_.moveOldPos10096 = var_200_11.localPosition
				var_200_11.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("10096", 7)

				local var_200_13 = var_200_11.childCount

				for iter_200_3 = 0, var_200_13 - 1 do
					local var_200_14 = var_200_11:GetChild(iter_200_3)

					if var_200_14.name == "" or not string.find(var_200_14.name, "split") then
						var_200_14.gameObject:SetActive(true)
					else
						var_200_14.gameObject:SetActive(false)
					end
				end
			end

			local var_200_15 = 0.001

			if var_200_12 <= arg_197_1.time_ and arg_197_1.time_ < var_200_12 + var_200_15 then
				local var_200_16 = (arg_197_1.time_ - var_200_12) / var_200_15
				local var_200_17 = Vector3.New(0, -2000, 0)

				var_200_11.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10096, var_200_17, var_200_16)
			end

			if arg_197_1.time_ >= var_200_12 + var_200_15 and arg_197_1.time_ < var_200_12 + var_200_15 + arg_200_0 then
				var_200_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_200_18 = arg_197_1.actors_["10094"]
			local var_200_19 = 0

			if var_200_19 < arg_197_1.time_ and arg_197_1.time_ <= var_200_19 + arg_200_0 and not isNil(var_200_18) and arg_197_1.var_.actorSpriteComps10094 == nil then
				arg_197_1.var_.actorSpriteComps10094 = var_200_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_20 = 2

			if var_200_19 <= arg_197_1.time_ and arg_197_1.time_ < var_200_19 + var_200_20 and not isNil(var_200_18) then
				local var_200_21 = (arg_197_1.time_ - var_200_19) / var_200_20

				if arg_197_1.var_.actorSpriteComps10094 then
					for iter_200_4, iter_200_5 in pairs(arg_197_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_200_5 then
							if arg_197_1.isInRecall_ then
								local var_200_22 = Mathf.Lerp(iter_200_5.color.r, arg_197_1.hightColor1.r, var_200_21)
								local var_200_23 = Mathf.Lerp(iter_200_5.color.g, arg_197_1.hightColor1.g, var_200_21)
								local var_200_24 = Mathf.Lerp(iter_200_5.color.b, arg_197_1.hightColor1.b, var_200_21)

								iter_200_5.color = Color.New(var_200_22, var_200_23, var_200_24)
							else
								local var_200_25 = Mathf.Lerp(iter_200_5.color.r, 1, var_200_21)

								iter_200_5.color = Color.New(var_200_25, var_200_25, var_200_25)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_19 + var_200_20 and arg_197_1.time_ < var_200_19 + var_200_20 + arg_200_0 and not isNil(var_200_18) and arg_197_1.var_.actorSpriteComps10094 then
				for iter_200_6, iter_200_7 in pairs(arg_197_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_200_7 then
						if arg_197_1.isInRecall_ then
							iter_200_7.color = arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_200_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps10094 = nil
			end

			local var_200_26 = arg_197_1.actors_["10096"]
			local var_200_27 = 0

			if var_200_27 < arg_197_1.time_ and arg_197_1.time_ <= var_200_27 + arg_200_0 and not isNil(var_200_26) and arg_197_1.var_.actorSpriteComps10096 == nil then
				arg_197_1.var_.actorSpriteComps10096 = var_200_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_28 = 2

			if var_200_27 <= arg_197_1.time_ and arg_197_1.time_ < var_200_27 + var_200_28 and not isNil(var_200_26) then
				local var_200_29 = (arg_197_1.time_ - var_200_27) / var_200_28

				if arg_197_1.var_.actorSpriteComps10096 then
					for iter_200_8, iter_200_9 in pairs(arg_197_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_200_9 then
							if arg_197_1.isInRecall_ then
								local var_200_30 = Mathf.Lerp(iter_200_9.color.r, arg_197_1.hightColor2.r, var_200_29)
								local var_200_31 = Mathf.Lerp(iter_200_9.color.g, arg_197_1.hightColor2.g, var_200_29)
								local var_200_32 = Mathf.Lerp(iter_200_9.color.b, arg_197_1.hightColor2.b, var_200_29)

								iter_200_9.color = Color.New(var_200_30, var_200_31, var_200_32)
							else
								local var_200_33 = Mathf.Lerp(iter_200_9.color.r, 0.5, var_200_29)

								iter_200_9.color = Color.New(var_200_33, var_200_33, var_200_33)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_27 + var_200_28 and arg_197_1.time_ < var_200_27 + var_200_28 + arg_200_0 and not isNil(var_200_26) and arg_197_1.var_.actorSpriteComps10096 then
				for iter_200_10, iter_200_11 in pairs(arg_197_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_200_11 then
						if arg_197_1.isInRecall_ then
							iter_200_11.color = arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_200_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps10096 = nil
			end

			local var_200_34 = 0
			local var_200_35 = 0.4

			if var_200_34 < arg_197_1.time_ and arg_197_1.time_ <= var_200_34 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_36 = arg_197_1:FormatText(StoryNameCfg[259].name)

				arg_197_1.leftNameTxt_.text = var_200_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_37 = arg_197_1:GetWordFromCfg(413102045)
				local var_200_38 = arg_197_1:FormatText(var_200_37.content)

				arg_197_1.text_.text = var_200_38

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_39 = 16
				local var_200_40 = utf8.len(var_200_38)
				local var_200_41 = var_200_39 <= 0 and var_200_35 or var_200_35 * (var_200_40 / var_200_39)

				if var_200_41 > 0 and var_200_35 < var_200_41 then
					arg_197_1.talkMaxDuration = var_200_41

					if var_200_41 + var_200_34 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_41 + var_200_34
					end
				end

				arg_197_1.text_.text = var_200_38
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102045", "story_v_out_413102.awb") ~= 0 then
					local var_200_42 = manager.audio:GetVoiceLength("story_v_out_413102", "413102045", "story_v_out_413102.awb") / 1000

					if var_200_42 + var_200_34 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_42 + var_200_34
					end

					if var_200_37.prefab_name ~= "" and arg_197_1.actors_[var_200_37.prefab_name] ~= nil then
						local var_200_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_37.prefab_name].transform, "story_v_out_413102", "413102045", "story_v_out_413102.awb")

						arg_197_1:RecordAudio("413102045", var_200_43)
						arg_197_1:RecordAudio("413102045", var_200_43)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_413102", "413102045", "story_v_out_413102.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_413102", "413102045", "story_v_out_413102.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_44 = math.max(var_200_35, arg_197_1.talkMaxDuration)

			if var_200_34 <= arg_197_1.time_ and arg_197_1.time_ < var_200_34 + var_200_44 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_34) / var_200_44

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_34 + var_200_44 and arg_197_1.time_ < var_200_34 + var_200_44 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play413102046 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 413102046
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play413102047(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["10094"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos10094 = var_204_0.localPosition
				var_204_0.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10094", 7)

				local var_204_2 = var_204_0.childCount

				for iter_204_0 = 0, var_204_2 - 1 do
					local var_204_3 = var_204_0:GetChild(iter_204_0)

					if var_204_3.name == "" or not string.find(var_204_3.name, "split") then
						var_204_3.gameObject:SetActive(true)
					else
						var_204_3.gameObject:SetActive(false)
					end
				end
			end

			local var_204_4 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_4 then
				local var_204_5 = (arg_201_1.time_ - var_204_1) / var_204_4
				local var_204_6 = Vector3.New(0, -2000, 0)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10094, var_204_6, var_204_5)
			end

			if arg_201_1.time_ >= var_204_1 + var_204_4 and arg_201_1.time_ < var_204_1 + var_204_4 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_204_7 = 0
			local var_204_8 = 0.95

			if var_204_7 < arg_201_1.time_ and arg_201_1.time_ <= var_204_7 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_9 = arg_201_1:GetWordFromCfg(413102046)
				local var_204_10 = arg_201_1:FormatText(var_204_9.content)

				arg_201_1.text_.text = var_204_10

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_11 = 38
				local var_204_12 = utf8.len(var_204_10)
				local var_204_13 = var_204_11 <= 0 and var_204_8 or var_204_8 * (var_204_12 / var_204_11)

				if var_204_13 > 0 and var_204_8 < var_204_13 then
					arg_201_1.talkMaxDuration = var_204_13

					if var_204_13 + var_204_7 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_13 + var_204_7
					end
				end

				arg_201_1.text_.text = var_204_10
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_14 = math.max(var_204_8, arg_201_1.talkMaxDuration)

			if var_204_7 <= arg_201_1.time_ and arg_201_1.time_ < var_204_7 + var_204_14 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_7) / var_204_14

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_7 + var_204_14 and arg_201_1.time_ < var_204_7 + var_204_14 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
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

		arg_201_1:InitPlayNodeList()
	end,
	Play413102047 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 413102047
		arg_205_1.duration_ = 6.23

		local var_205_0 = {
			zh = 3.2,
			ja = 6.233
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
				arg_205_0:Play413102048(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["10094"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos10094 = var_208_0.localPosition
				var_208_0.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10094", 3)

				local var_208_2 = var_208_0.childCount

				for iter_208_0 = 0, var_208_2 - 1 do
					local var_208_3 = var_208_0:GetChild(iter_208_0)

					if var_208_3.name == "" or not string.find(var_208_3.name, "split") then
						var_208_3.gameObject:SetActive(true)
					else
						var_208_3.gameObject:SetActive(false)
					end
				end
			end

			local var_208_4 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_4 then
				local var_208_5 = (arg_205_1.time_ - var_208_1) / var_208_4
				local var_208_6 = Vector3.New(0, -340, -414)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10094, var_208_6, var_208_5)
			end

			if arg_205_1.time_ >= var_208_1 + var_208_4 and arg_205_1.time_ < var_208_1 + var_208_4 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_208_7 = arg_205_1.actors_["10094"]
			local var_208_8 = 0

			if var_208_8 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 and not isNil(var_208_7) and arg_205_1.var_.actorSpriteComps10094 == nil then
				arg_205_1.var_.actorSpriteComps10094 = var_208_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_9 = 2

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_9 and not isNil(var_208_7) then
				local var_208_10 = (arg_205_1.time_ - var_208_8) / var_208_9

				if arg_205_1.var_.actorSpriteComps10094 then
					for iter_208_1, iter_208_2 in pairs(arg_205_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_208_2 then
							if arg_205_1.isInRecall_ then
								local var_208_11 = Mathf.Lerp(iter_208_2.color.r, arg_205_1.hightColor1.r, var_208_10)
								local var_208_12 = Mathf.Lerp(iter_208_2.color.g, arg_205_1.hightColor1.g, var_208_10)
								local var_208_13 = Mathf.Lerp(iter_208_2.color.b, arg_205_1.hightColor1.b, var_208_10)

								iter_208_2.color = Color.New(var_208_11, var_208_12, var_208_13)
							else
								local var_208_14 = Mathf.Lerp(iter_208_2.color.r, 1, var_208_10)

								iter_208_2.color = Color.New(var_208_14, var_208_14, var_208_14)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_8 + var_208_9 and arg_205_1.time_ < var_208_8 + var_208_9 + arg_208_0 and not isNil(var_208_7) and arg_205_1.var_.actorSpriteComps10094 then
				for iter_208_3, iter_208_4 in pairs(arg_205_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_208_4 then
						if arg_205_1.isInRecall_ then
							iter_208_4.color = arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_208_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps10094 = nil
			end

			local var_208_15 = 0
			local var_208_16 = 0.3

			if var_208_15 < arg_205_1.time_ and arg_205_1.time_ <= var_208_15 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_17 = arg_205_1:FormatText(StoryNameCfg[259].name)

				arg_205_1.leftNameTxt_.text = var_208_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_18 = arg_205_1:GetWordFromCfg(413102047)
				local var_208_19 = arg_205_1:FormatText(var_208_18.content)

				arg_205_1.text_.text = var_208_19

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_20 = 12
				local var_208_21 = utf8.len(var_208_19)
				local var_208_22 = var_208_20 <= 0 and var_208_16 or var_208_16 * (var_208_21 / var_208_20)

				if var_208_22 > 0 and var_208_16 < var_208_22 then
					arg_205_1.talkMaxDuration = var_208_22

					if var_208_22 + var_208_15 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_22 + var_208_15
					end
				end

				arg_205_1.text_.text = var_208_19
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102047", "story_v_out_413102.awb") ~= 0 then
					local var_208_23 = manager.audio:GetVoiceLength("story_v_out_413102", "413102047", "story_v_out_413102.awb") / 1000

					if var_208_23 + var_208_15 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_23 + var_208_15
					end

					if var_208_18.prefab_name ~= "" and arg_205_1.actors_[var_208_18.prefab_name] ~= nil then
						local var_208_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_18.prefab_name].transform, "story_v_out_413102", "413102047", "story_v_out_413102.awb")

						arg_205_1:RecordAudio("413102047", var_208_24)
						arg_205_1:RecordAudio("413102047", var_208_24)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_413102", "413102047", "story_v_out_413102.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_413102", "413102047", "story_v_out_413102.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_25 = math.max(var_208_16, arg_205_1.talkMaxDuration)

			if var_208_15 <= arg_205_1.time_ and arg_205_1.time_ < var_208_15 + var_208_25 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_15) / var_208_25

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_15 + var_208_25 and arg_205_1.time_ < var_208_15 + var_208_25 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
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

		arg_205_1:InitPlayNodeList()
	end,
	Play413102048 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 413102048
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play413102049(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["10094"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos10094 = var_212_0.localPosition
				var_212_0.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10094", 7)

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
				local var_212_6 = Vector3.New(0, -2000, 0)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10094, var_212_6, var_212_5)
			end

			if arg_209_1.time_ >= var_212_1 + var_212_4 and arg_209_1.time_ < var_212_1 + var_212_4 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_212_7 = arg_209_1.actors_["10094"]
			local var_212_8 = 0

			if var_212_8 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 and not isNil(var_212_7) and arg_209_1.var_.actorSpriteComps10094 == nil then
				arg_209_1.var_.actorSpriteComps10094 = var_212_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_9 = 2

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_9 and not isNil(var_212_7) then
				local var_212_10 = (arg_209_1.time_ - var_212_8) / var_212_9

				if arg_209_1.var_.actorSpriteComps10094 then
					for iter_212_1, iter_212_2 in pairs(arg_209_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_212_2 then
							if arg_209_1.isInRecall_ then
								local var_212_11 = Mathf.Lerp(iter_212_2.color.r, arg_209_1.hightColor2.r, var_212_10)
								local var_212_12 = Mathf.Lerp(iter_212_2.color.g, arg_209_1.hightColor2.g, var_212_10)
								local var_212_13 = Mathf.Lerp(iter_212_2.color.b, arg_209_1.hightColor2.b, var_212_10)

								iter_212_2.color = Color.New(var_212_11, var_212_12, var_212_13)
							else
								local var_212_14 = Mathf.Lerp(iter_212_2.color.r, 0.5, var_212_10)

								iter_212_2.color = Color.New(var_212_14, var_212_14, var_212_14)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_8 + var_212_9 and arg_209_1.time_ < var_212_8 + var_212_9 + arg_212_0 and not isNil(var_212_7) and arg_209_1.var_.actorSpriteComps10094 then
				for iter_212_3, iter_212_4 in pairs(arg_209_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_212_4 then
						if arg_209_1.isInRecall_ then
							iter_212_4.color = arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_212_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps10094 = nil
			end

			local var_212_15 = 0
			local var_212_16 = 1.075

			if var_212_15 < arg_209_1.time_ and arg_209_1.time_ <= var_212_15 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_17 = arg_209_1:GetWordFromCfg(413102048)
				local var_212_18 = arg_209_1:FormatText(var_212_17.content)

				arg_209_1.text_.text = var_212_18

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_19 = 43
				local var_212_20 = utf8.len(var_212_18)
				local var_212_21 = var_212_19 <= 0 and var_212_16 or var_212_16 * (var_212_20 / var_212_19)

				if var_212_21 > 0 and var_212_16 < var_212_21 then
					arg_209_1.talkMaxDuration = var_212_21

					if var_212_21 + var_212_15 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_21 + var_212_15
					end
				end

				arg_209_1.text_.text = var_212_18
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_22 = math.max(var_212_16, arg_209_1.talkMaxDuration)

			if var_212_15 <= arg_209_1.time_ and arg_209_1.time_ < var_212_15 + var_212_22 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_15) / var_212_22

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_15 + var_212_22 and arg_209_1.time_ < var_212_15 + var_212_22 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
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

		arg_209_1:InitPlayNodeList()
	end,
	Play413102049 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 413102049
		arg_213_1.duration_ = 15.93

		local var_213_0 = {
			zh = 8.066,
			ja = 15.933
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play413102050(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["10096"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos10096 = var_216_0.localPosition
				var_216_0.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("10096", 3)

				local var_216_2 = var_216_0.childCount

				for iter_216_0 = 0, var_216_2 - 1 do
					local var_216_3 = var_216_0:GetChild(iter_216_0)

					if var_216_3.name == "" or not string.find(var_216_3.name, "split") then
						var_216_3.gameObject:SetActive(true)
					else
						var_216_3.gameObject:SetActive(false)
					end
				end
			end

			local var_216_4 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_4 then
				local var_216_5 = (arg_213_1.time_ - var_216_1) / var_216_4
				local var_216_6 = Vector3.New(0, -350, -210)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10096, var_216_6, var_216_5)
			end

			if arg_213_1.time_ >= var_216_1 + var_216_4 and arg_213_1.time_ < var_216_1 + var_216_4 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(0, -350, -210)
			end

			local var_216_7 = arg_213_1.actors_["10096"]
			local var_216_8 = 0

			if var_216_8 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 and not isNil(var_216_7) and arg_213_1.var_.actorSpriteComps10096 == nil then
				arg_213_1.var_.actorSpriteComps10096 = var_216_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_9 = 2

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_9 and not isNil(var_216_7) then
				local var_216_10 = (arg_213_1.time_ - var_216_8) / var_216_9

				if arg_213_1.var_.actorSpriteComps10096 then
					for iter_216_1, iter_216_2 in pairs(arg_213_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_216_2 then
							if arg_213_1.isInRecall_ then
								local var_216_11 = Mathf.Lerp(iter_216_2.color.r, arg_213_1.hightColor1.r, var_216_10)
								local var_216_12 = Mathf.Lerp(iter_216_2.color.g, arg_213_1.hightColor1.g, var_216_10)
								local var_216_13 = Mathf.Lerp(iter_216_2.color.b, arg_213_1.hightColor1.b, var_216_10)

								iter_216_2.color = Color.New(var_216_11, var_216_12, var_216_13)
							else
								local var_216_14 = Mathf.Lerp(iter_216_2.color.r, 1, var_216_10)

								iter_216_2.color = Color.New(var_216_14, var_216_14, var_216_14)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_8 + var_216_9 and arg_213_1.time_ < var_216_8 + var_216_9 + arg_216_0 and not isNil(var_216_7) and arg_213_1.var_.actorSpriteComps10096 then
				for iter_216_3, iter_216_4 in pairs(arg_213_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_216_4 then
						if arg_213_1.isInRecall_ then
							iter_216_4.color = arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_216_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps10096 = nil
			end

			local var_216_15 = 0
			local var_216_16 = 0.575

			if var_216_15 < arg_213_1.time_ and arg_213_1.time_ <= var_216_15 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_17 = arg_213_1:FormatText(StoryNameCfg[36].name)

				arg_213_1.leftNameTxt_.text = var_216_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_18 = arg_213_1:GetWordFromCfg(413102049)
				local var_216_19 = arg_213_1:FormatText(var_216_18.content)

				arg_213_1.text_.text = var_216_19

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_20 = 23
				local var_216_21 = utf8.len(var_216_19)
				local var_216_22 = var_216_20 <= 0 and var_216_16 or var_216_16 * (var_216_21 / var_216_20)

				if var_216_22 > 0 and var_216_16 < var_216_22 then
					arg_213_1.talkMaxDuration = var_216_22

					if var_216_22 + var_216_15 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_22 + var_216_15
					end
				end

				arg_213_1.text_.text = var_216_19
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102049", "story_v_out_413102.awb") ~= 0 then
					local var_216_23 = manager.audio:GetVoiceLength("story_v_out_413102", "413102049", "story_v_out_413102.awb") / 1000

					if var_216_23 + var_216_15 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_23 + var_216_15
					end

					if var_216_18.prefab_name ~= "" and arg_213_1.actors_[var_216_18.prefab_name] ~= nil then
						local var_216_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_18.prefab_name].transform, "story_v_out_413102", "413102049", "story_v_out_413102.awb")

						arg_213_1:RecordAudio("413102049", var_216_24)
						arg_213_1:RecordAudio("413102049", var_216_24)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_413102", "413102049", "story_v_out_413102.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_413102", "413102049", "story_v_out_413102.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_25 = math.max(var_216_16, arg_213_1.talkMaxDuration)

			if var_216_15 <= arg_213_1.time_ and arg_213_1.time_ < var_216_15 + var_216_25 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_15) / var_216_25

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_15 + var_216_25 and arg_213_1.time_ < var_216_15 + var_216_25 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play413102050 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 413102050
		arg_217_1.duration_ = 12.97

		local var_217_0 = {
			zh = 4.933,
			ja = 12.966
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
				arg_217_0:Play413102051(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["10096"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos10096 = var_220_0.localPosition
				var_220_0.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("10096", 3)

				local var_220_2 = var_220_0.childCount

				for iter_220_0 = 0, var_220_2 - 1 do
					local var_220_3 = var_220_0:GetChild(iter_220_0)

					if var_220_3.name == "" or not string.find(var_220_3.name, "split") then
						var_220_3.gameObject:SetActive(true)
					else
						var_220_3.gameObject:SetActive(false)
					end
				end
			end

			local var_220_4 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_4 then
				local var_220_5 = (arg_217_1.time_ - var_220_1) / var_220_4
				local var_220_6 = Vector3.New(0, -350, -210)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10096, var_220_6, var_220_5)
			end

			if arg_217_1.time_ >= var_220_1 + var_220_4 and arg_217_1.time_ < var_220_1 + var_220_4 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(0, -350, -210)
			end

			local var_220_7 = arg_217_1.actors_["10096"]
			local var_220_8 = 0

			if var_220_8 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 and not isNil(var_220_7) and arg_217_1.var_.actorSpriteComps10096 == nil then
				arg_217_1.var_.actorSpriteComps10096 = var_220_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_9 = 2

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_9 and not isNil(var_220_7) then
				local var_220_10 = (arg_217_1.time_ - var_220_8) / var_220_9

				if arg_217_1.var_.actorSpriteComps10096 then
					for iter_220_1, iter_220_2 in pairs(arg_217_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_220_2 then
							if arg_217_1.isInRecall_ then
								local var_220_11 = Mathf.Lerp(iter_220_2.color.r, arg_217_1.hightColor1.r, var_220_10)
								local var_220_12 = Mathf.Lerp(iter_220_2.color.g, arg_217_1.hightColor1.g, var_220_10)
								local var_220_13 = Mathf.Lerp(iter_220_2.color.b, arg_217_1.hightColor1.b, var_220_10)

								iter_220_2.color = Color.New(var_220_11, var_220_12, var_220_13)
							else
								local var_220_14 = Mathf.Lerp(iter_220_2.color.r, 1, var_220_10)

								iter_220_2.color = Color.New(var_220_14, var_220_14, var_220_14)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= var_220_8 + var_220_9 and arg_217_1.time_ < var_220_8 + var_220_9 + arg_220_0 and not isNil(var_220_7) and arg_217_1.var_.actorSpriteComps10096 then
				for iter_220_3, iter_220_4 in pairs(arg_217_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_220_4 then
						if arg_217_1.isInRecall_ then
							iter_220_4.color = arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_220_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps10096 = nil
			end

			local var_220_15 = 0
			local var_220_16 = 0.425

			if var_220_15 < arg_217_1.time_ and arg_217_1.time_ <= var_220_15 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_17 = arg_217_1:FormatText(StoryNameCfg[36].name)

				arg_217_1.leftNameTxt_.text = var_220_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_18 = arg_217_1:GetWordFromCfg(413102050)
				local var_220_19 = arg_217_1:FormatText(var_220_18.content)

				arg_217_1.text_.text = var_220_19

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_20 = 17
				local var_220_21 = utf8.len(var_220_19)
				local var_220_22 = var_220_20 <= 0 and var_220_16 or var_220_16 * (var_220_21 / var_220_20)

				if var_220_22 > 0 and var_220_16 < var_220_22 then
					arg_217_1.talkMaxDuration = var_220_22

					if var_220_22 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_22 + var_220_15
					end
				end

				arg_217_1.text_.text = var_220_19
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102050", "story_v_out_413102.awb") ~= 0 then
					local var_220_23 = manager.audio:GetVoiceLength("story_v_out_413102", "413102050", "story_v_out_413102.awb") / 1000

					if var_220_23 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_23 + var_220_15
					end

					if var_220_18.prefab_name ~= "" and arg_217_1.actors_[var_220_18.prefab_name] ~= nil then
						local var_220_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_18.prefab_name].transform, "story_v_out_413102", "413102050", "story_v_out_413102.awb")

						arg_217_1:RecordAudio("413102050", var_220_24)
						arg_217_1:RecordAudio("413102050", var_220_24)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_413102", "413102050", "story_v_out_413102.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_413102", "413102050", "story_v_out_413102.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_25 = math.max(var_220_16, arg_217_1.talkMaxDuration)

			if var_220_15 <= arg_217_1.time_ and arg_217_1.time_ < var_220_15 + var_220_25 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_15) / var_220_25

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_15 + var_220_25 and arg_217_1.time_ < var_220_15 + var_220_25 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play413102051 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 413102051
		arg_221_1.duration_ = 2.6

		local var_221_0 = {
			zh = 1.999999999999,
			ja = 2.6
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
				arg_221_0:Play413102052(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10096"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos10096 = var_224_0.localPosition
				var_224_0.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10096", 2)

				local var_224_2 = var_224_0.childCount

				for iter_224_0 = 0, var_224_2 - 1 do
					local var_224_3 = var_224_0:GetChild(iter_224_0)

					if var_224_3.name == "" or not string.find(var_224_3.name, "split") then
						var_224_3.gameObject:SetActive(true)
					else
						var_224_3.gameObject:SetActive(false)
					end
				end
			end

			local var_224_4 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_4 then
				local var_224_5 = (arg_221_1.time_ - var_224_1) / var_224_4
				local var_224_6 = Vector3.New(-390, -350, -210)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10096, var_224_6, var_224_5)
			end

			if arg_221_1.time_ >= var_224_1 + var_224_4 and arg_221_1.time_ < var_224_1 + var_224_4 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_224_7 = arg_221_1.actors_["10094"].transform
			local var_224_8 = 0

			if var_224_8 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 then
				arg_221_1.var_.moveOldPos10094 = var_224_7.localPosition
				var_224_7.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10094", 4)

				local var_224_9 = var_224_7.childCount

				for iter_224_1 = 0, var_224_9 - 1 do
					local var_224_10 = var_224_7:GetChild(iter_224_1)

					if var_224_10.name == "" or not string.find(var_224_10.name, "split") then
						var_224_10.gameObject:SetActive(true)
					else
						var_224_10.gameObject:SetActive(false)
					end
				end
			end

			local var_224_11 = 0.001

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_11 then
				local var_224_12 = (arg_221_1.time_ - var_224_8) / var_224_11
				local var_224_13 = Vector3.New(390, -340, -414)

				var_224_7.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10094, var_224_13, var_224_12)
			end

			if arg_221_1.time_ >= var_224_8 + var_224_11 and arg_221_1.time_ < var_224_8 + var_224_11 + arg_224_0 then
				var_224_7.localPosition = Vector3.New(390, -340, -414)
			end

			local var_224_14 = arg_221_1.actors_["10096"]
			local var_224_15 = 0

			if var_224_15 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 and not isNil(var_224_14) and arg_221_1.var_.actorSpriteComps10096 == nil then
				arg_221_1.var_.actorSpriteComps10096 = var_224_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_16 = 2

			if var_224_15 <= arg_221_1.time_ and arg_221_1.time_ < var_224_15 + var_224_16 and not isNil(var_224_14) then
				local var_224_17 = (arg_221_1.time_ - var_224_15) / var_224_16

				if arg_221_1.var_.actorSpriteComps10096 then
					for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_224_3 then
							if arg_221_1.isInRecall_ then
								local var_224_18 = Mathf.Lerp(iter_224_3.color.r, arg_221_1.hightColor2.r, var_224_17)
								local var_224_19 = Mathf.Lerp(iter_224_3.color.g, arg_221_1.hightColor2.g, var_224_17)
								local var_224_20 = Mathf.Lerp(iter_224_3.color.b, arg_221_1.hightColor2.b, var_224_17)

								iter_224_3.color = Color.New(var_224_18, var_224_19, var_224_20)
							else
								local var_224_21 = Mathf.Lerp(iter_224_3.color.r, 0.5, var_224_17)

								iter_224_3.color = Color.New(var_224_21, var_224_21, var_224_21)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_15 + var_224_16 and arg_221_1.time_ < var_224_15 + var_224_16 + arg_224_0 and not isNil(var_224_14) and arg_221_1.var_.actorSpriteComps10096 then
				for iter_224_4, iter_224_5 in pairs(arg_221_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_224_5 then
						if arg_221_1.isInRecall_ then
							iter_224_5.color = arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_224_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps10096 = nil
			end

			local var_224_22 = arg_221_1.actors_["10094"]
			local var_224_23 = 0

			if var_224_23 < arg_221_1.time_ and arg_221_1.time_ <= var_224_23 + arg_224_0 and not isNil(var_224_22) and arg_221_1.var_.actorSpriteComps10094 == nil then
				arg_221_1.var_.actorSpriteComps10094 = var_224_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_24 = 2

			if var_224_23 <= arg_221_1.time_ and arg_221_1.time_ < var_224_23 + var_224_24 and not isNil(var_224_22) then
				local var_224_25 = (arg_221_1.time_ - var_224_23) / var_224_24

				if arg_221_1.var_.actorSpriteComps10094 then
					for iter_224_6, iter_224_7 in pairs(arg_221_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_224_7 then
							if arg_221_1.isInRecall_ then
								local var_224_26 = Mathf.Lerp(iter_224_7.color.r, arg_221_1.hightColor1.r, var_224_25)
								local var_224_27 = Mathf.Lerp(iter_224_7.color.g, arg_221_1.hightColor1.g, var_224_25)
								local var_224_28 = Mathf.Lerp(iter_224_7.color.b, arg_221_1.hightColor1.b, var_224_25)

								iter_224_7.color = Color.New(var_224_26, var_224_27, var_224_28)
							else
								local var_224_29 = Mathf.Lerp(iter_224_7.color.r, 1, var_224_25)

								iter_224_7.color = Color.New(var_224_29, var_224_29, var_224_29)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_23 + var_224_24 and arg_221_1.time_ < var_224_23 + var_224_24 + arg_224_0 and not isNil(var_224_22) and arg_221_1.var_.actorSpriteComps10094 then
				for iter_224_8, iter_224_9 in pairs(arg_221_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_224_9 then
						if arg_221_1.isInRecall_ then
							iter_224_9.color = arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_224_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps10094 = nil
			end

			local var_224_30 = 0
			local var_224_31 = 0.225

			if var_224_30 < arg_221_1.time_ and arg_221_1.time_ <= var_224_30 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_32 = arg_221_1:FormatText(StoryNameCfg[259].name)

				arg_221_1.leftNameTxt_.text = var_224_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_33 = arg_221_1:GetWordFromCfg(413102051)
				local var_224_34 = arg_221_1:FormatText(var_224_33.content)

				arg_221_1.text_.text = var_224_34

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_35 = 9
				local var_224_36 = utf8.len(var_224_34)
				local var_224_37 = var_224_35 <= 0 and var_224_31 or var_224_31 * (var_224_36 / var_224_35)

				if var_224_37 > 0 and var_224_31 < var_224_37 then
					arg_221_1.talkMaxDuration = var_224_37

					if var_224_37 + var_224_30 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_37 + var_224_30
					end
				end

				arg_221_1.text_.text = var_224_34
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102051", "story_v_out_413102.awb") ~= 0 then
					local var_224_38 = manager.audio:GetVoiceLength("story_v_out_413102", "413102051", "story_v_out_413102.awb") / 1000

					if var_224_38 + var_224_30 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_38 + var_224_30
					end

					if var_224_33.prefab_name ~= "" and arg_221_1.actors_[var_224_33.prefab_name] ~= nil then
						local var_224_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_33.prefab_name].transform, "story_v_out_413102", "413102051", "story_v_out_413102.awb")

						arg_221_1:RecordAudio("413102051", var_224_39)
						arg_221_1:RecordAudio("413102051", var_224_39)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_413102", "413102051", "story_v_out_413102.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_413102", "413102051", "story_v_out_413102.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_40 = math.max(var_224_31, arg_221_1.talkMaxDuration)

			if var_224_30 <= arg_221_1.time_ and arg_221_1.time_ < var_224_30 + var_224_40 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_30) / var_224_40

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_30 + var_224_40 and arg_221_1.time_ < var_224_30 + var_224_40 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_221_1:InitPlayNodeList()
	end,
	Play413102052 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 413102052
		arg_225_1.duration_ = 7.6

		local var_225_0 = {
			zh = 2.633,
			ja = 7.6
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play413102053(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.35

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_2 = arg_225_1:FormatText(StoryNameCfg[259].name)

				arg_225_1.leftNameTxt_.text = var_228_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_3 = arg_225_1:GetWordFromCfg(413102052)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 14
				local var_228_6 = utf8.len(var_228_4)
				local var_228_7 = var_228_5 <= 0 and var_228_1 or var_228_1 * (var_228_6 / var_228_5)

				if var_228_7 > 0 and var_228_1 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102052", "story_v_out_413102.awb") ~= 0 then
					local var_228_8 = manager.audio:GetVoiceLength("story_v_out_413102", "413102052", "story_v_out_413102.awb") / 1000

					if var_228_8 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_0
					end

					if var_228_3.prefab_name ~= "" and arg_225_1.actors_[var_228_3.prefab_name] ~= nil then
						local var_228_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_3.prefab_name].transform, "story_v_out_413102", "413102052", "story_v_out_413102.awb")

						arg_225_1:RecordAudio("413102052", var_228_9)
						arg_225_1:RecordAudio("413102052", var_228_9)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_413102", "413102052", "story_v_out_413102.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_413102", "413102052", "story_v_out_413102.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_10 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_10 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_10

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_10 and arg_225_1.time_ < var_228_0 + var_228_10 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play413102053 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 413102053
		arg_229_1.duration_ = 4.6

		local var_229_0 = {
			zh = 1.999999999999,
			ja = 4.6
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play413102054(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["10094"].transform
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.var_.moveOldPos10094 = var_232_0.localPosition
				var_232_0.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("10094", 4)

				local var_232_2 = var_232_0.childCount

				for iter_232_0 = 0, var_232_2 - 1 do
					local var_232_3 = var_232_0:GetChild(iter_232_0)

					if var_232_3.name == "" or not string.find(var_232_3.name, "split") then
						var_232_3.gameObject:SetActive(true)
					else
						var_232_3.gameObject:SetActive(false)
					end
				end
			end

			local var_232_4 = 0.001

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_4 then
				local var_232_5 = (arg_229_1.time_ - var_232_1) / var_232_4
				local var_232_6 = Vector3.New(390, -340, -414)

				var_232_0.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10094, var_232_6, var_232_5)
			end

			if arg_229_1.time_ >= var_232_1 + var_232_4 and arg_229_1.time_ < var_232_1 + var_232_4 + arg_232_0 then
				var_232_0.localPosition = Vector3.New(390, -340, -414)
			end

			local var_232_7 = arg_229_1.actors_["10094"]
			local var_232_8 = 0

			if var_232_8 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 and not isNil(var_232_7) and arg_229_1.var_.actorSpriteComps10094 == nil then
				arg_229_1.var_.actorSpriteComps10094 = var_232_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_9 = 2

			if var_232_8 <= arg_229_1.time_ and arg_229_1.time_ < var_232_8 + var_232_9 and not isNil(var_232_7) then
				local var_232_10 = (arg_229_1.time_ - var_232_8) / var_232_9

				if arg_229_1.var_.actorSpriteComps10094 then
					for iter_232_1, iter_232_2 in pairs(arg_229_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_232_2 then
							if arg_229_1.isInRecall_ then
								local var_232_11 = Mathf.Lerp(iter_232_2.color.r, arg_229_1.hightColor1.r, var_232_10)
								local var_232_12 = Mathf.Lerp(iter_232_2.color.g, arg_229_1.hightColor1.g, var_232_10)
								local var_232_13 = Mathf.Lerp(iter_232_2.color.b, arg_229_1.hightColor1.b, var_232_10)

								iter_232_2.color = Color.New(var_232_11, var_232_12, var_232_13)
							else
								local var_232_14 = Mathf.Lerp(iter_232_2.color.r, 1, var_232_10)

								iter_232_2.color = Color.New(var_232_14, var_232_14, var_232_14)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= var_232_8 + var_232_9 and arg_229_1.time_ < var_232_8 + var_232_9 + arg_232_0 and not isNil(var_232_7) and arg_229_1.var_.actorSpriteComps10094 then
				for iter_232_3, iter_232_4 in pairs(arg_229_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_232_4 then
						if arg_229_1.isInRecall_ then
							iter_232_4.color = arg_229_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_232_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps10094 = nil
			end

			local var_232_15 = 0
			local var_232_16 = 0.25

			if var_232_15 < arg_229_1.time_ and arg_229_1.time_ <= var_232_15 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_17 = arg_229_1:FormatText(StoryNameCfg[259].name)

				arg_229_1.leftNameTxt_.text = var_232_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_18 = arg_229_1:GetWordFromCfg(413102053)
				local var_232_19 = arg_229_1:FormatText(var_232_18.content)

				arg_229_1.text_.text = var_232_19

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_20 = 10
				local var_232_21 = utf8.len(var_232_19)
				local var_232_22 = var_232_20 <= 0 and var_232_16 or var_232_16 * (var_232_21 / var_232_20)

				if var_232_22 > 0 and var_232_16 < var_232_22 then
					arg_229_1.talkMaxDuration = var_232_22

					if var_232_22 + var_232_15 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_22 + var_232_15
					end
				end

				arg_229_1.text_.text = var_232_19
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102053", "story_v_out_413102.awb") ~= 0 then
					local var_232_23 = manager.audio:GetVoiceLength("story_v_out_413102", "413102053", "story_v_out_413102.awb") / 1000

					if var_232_23 + var_232_15 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_23 + var_232_15
					end

					if var_232_18.prefab_name ~= "" and arg_229_1.actors_[var_232_18.prefab_name] ~= nil then
						local var_232_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_18.prefab_name].transform, "story_v_out_413102", "413102053", "story_v_out_413102.awb")

						arg_229_1:RecordAudio("413102053", var_232_24)
						arg_229_1:RecordAudio("413102053", var_232_24)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_413102", "413102053", "story_v_out_413102.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_413102", "413102053", "story_v_out_413102.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_25 = math.max(var_232_16, arg_229_1.talkMaxDuration)

			if var_232_15 <= arg_229_1.time_ and arg_229_1.time_ < var_232_15 + var_232_25 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_15) / var_232_25

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_15 + var_232_25 and arg_229_1.time_ < var_232_15 + var_232_25 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
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

		arg_229_1:InitPlayNodeList()
	end,
	Play413102054 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 413102054
		arg_233_1.duration_ = 15.77

		local var_233_0 = {
			zh = 8.233,
			ja = 15.766
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play413102055(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["10096"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos10096 = var_236_0.localPosition
				var_236_0.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("10096", 2)

				local var_236_2 = var_236_0.childCount

				for iter_236_0 = 0, var_236_2 - 1 do
					local var_236_3 = var_236_0:GetChild(iter_236_0)

					if var_236_3.name == "" or not string.find(var_236_3.name, "split") then
						var_236_3.gameObject:SetActive(true)
					else
						var_236_3.gameObject:SetActive(false)
					end
				end
			end

			local var_236_4 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_4 then
				local var_236_5 = (arg_233_1.time_ - var_236_1) / var_236_4
				local var_236_6 = Vector3.New(-390, -350, -210)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10096, var_236_6, var_236_5)
			end

			if arg_233_1.time_ >= var_236_1 + var_236_4 and arg_233_1.time_ < var_236_1 + var_236_4 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_236_7 = arg_233_1.actors_["10094"].transform
			local var_236_8 = 0

			if var_236_8 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 then
				arg_233_1.var_.moveOldPos10094 = var_236_7.localPosition
				var_236_7.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("10094", 4)

				local var_236_9 = var_236_7.childCount

				for iter_236_1 = 0, var_236_9 - 1 do
					local var_236_10 = var_236_7:GetChild(iter_236_1)

					if var_236_10.name == "" or not string.find(var_236_10.name, "split") then
						var_236_10.gameObject:SetActive(true)
					else
						var_236_10.gameObject:SetActive(false)
					end
				end
			end

			local var_236_11 = 0.001

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_11 then
				local var_236_12 = (arg_233_1.time_ - var_236_8) / var_236_11
				local var_236_13 = Vector3.New(390, -340, -414)

				var_236_7.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10094, var_236_13, var_236_12)
			end

			if arg_233_1.time_ >= var_236_8 + var_236_11 and arg_233_1.time_ < var_236_8 + var_236_11 + arg_236_0 then
				var_236_7.localPosition = Vector3.New(390, -340, -414)
			end

			local var_236_14 = arg_233_1.actors_["10096"]
			local var_236_15 = 0

			if var_236_15 < arg_233_1.time_ and arg_233_1.time_ <= var_236_15 + arg_236_0 and not isNil(var_236_14) and arg_233_1.var_.actorSpriteComps10096 == nil then
				arg_233_1.var_.actorSpriteComps10096 = var_236_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_16 = 2

			if var_236_15 <= arg_233_1.time_ and arg_233_1.time_ < var_236_15 + var_236_16 and not isNil(var_236_14) then
				local var_236_17 = (arg_233_1.time_ - var_236_15) / var_236_16

				if arg_233_1.var_.actorSpriteComps10096 then
					for iter_236_2, iter_236_3 in pairs(arg_233_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_236_3 then
							if arg_233_1.isInRecall_ then
								local var_236_18 = Mathf.Lerp(iter_236_3.color.r, arg_233_1.hightColor1.r, var_236_17)
								local var_236_19 = Mathf.Lerp(iter_236_3.color.g, arg_233_1.hightColor1.g, var_236_17)
								local var_236_20 = Mathf.Lerp(iter_236_3.color.b, arg_233_1.hightColor1.b, var_236_17)

								iter_236_3.color = Color.New(var_236_18, var_236_19, var_236_20)
							else
								local var_236_21 = Mathf.Lerp(iter_236_3.color.r, 1, var_236_17)

								iter_236_3.color = Color.New(var_236_21, var_236_21, var_236_21)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= var_236_15 + var_236_16 and arg_233_1.time_ < var_236_15 + var_236_16 + arg_236_0 and not isNil(var_236_14) and arg_233_1.var_.actorSpriteComps10096 then
				for iter_236_4, iter_236_5 in pairs(arg_233_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_236_5 then
						if arg_233_1.isInRecall_ then
							iter_236_5.color = arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_236_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps10096 = nil
			end

			local var_236_22 = arg_233_1.actors_["10094"]
			local var_236_23 = 0

			if var_236_23 < arg_233_1.time_ and arg_233_1.time_ <= var_236_23 + arg_236_0 and not isNil(var_236_22) and arg_233_1.var_.actorSpriteComps10094 == nil then
				arg_233_1.var_.actorSpriteComps10094 = var_236_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_24 = 2

			if var_236_23 <= arg_233_1.time_ and arg_233_1.time_ < var_236_23 + var_236_24 and not isNil(var_236_22) then
				local var_236_25 = (arg_233_1.time_ - var_236_23) / var_236_24

				if arg_233_1.var_.actorSpriteComps10094 then
					for iter_236_6, iter_236_7 in pairs(arg_233_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_236_7 then
							if arg_233_1.isInRecall_ then
								local var_236_26 = Mathf.Lerp(iter_236_7.color.r, arg_233_1.hightColor2.r, var_236_25)
								local var_236_27 = Mathf.Lerp(iter_236_7.color.g, arg_233_1.hightColor2.g, var_236_25)
								local var_236_28 = Mathf.Lerp(iter_236_7.color.b, arg_233_1.hightColor2.b, var_236_25)

								iter_236_7.color = Color.New(var_236_26, var_236_27, var_236_28)
							else
								local var_236_29 = Mathf.Lerp(iter_236_7.color.r, 0.5, var_236_25)

								iter_236_7.color = Color.New(var_236_29, var_236_29, var_236_29)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= var_236_23 + var_236_24 and arg_233_1.time_ < var_236_23 + var_236_24 + arg_236_0 and not isNil(var_236_22) and arg_233_1.var_.actorSpriteComps10094 then
				for iter_236_8, iter_236_9 in pairs(arg_233_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_236_9 then
						if arg_233_1.isInRecall_ then
							iter_236_9.color = arg_233_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_236_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps10094 = nil
			end

			local var_236_30 = 0
			local var_236_31 = 0.6

			if var_236_30 < arg_233_1.time_ and arg_233_1.time_ <= var_236_30 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_32 = arg_233_1:FormatText(StoryNameCfg[36].name)

				arg_233_1.leftNameTxt_.text = var_236_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_33 = arg_233_1:GetWordFromCfg(413102054)
				local var_236_34 = arg_233_1:FormatText(var_236_33.content)

				arg_233_1.text_.text = var_236_34

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_35 = 24
				local var_236_36 = utf8.len(var_236_34)
				local var_236_37 = var_236_35 <= 0 and var_236_31 or var_236_31 * (var_236_36 / var_236_35)

				if var_236_37 > 0 and var_236_31 < var_236_37 then
					arg_233_1.talkMaxDuration = var_236_37

					if var_236_37 + var_236_30 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_37 + var_236_30
					end
				end

				arg_233_1.text_.text = var_236_34
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102054", "story_v_out_413102.awb") ~= 0 then
					local var_236_38 = manager.audio:GetVoiceLength("story_v_out_413102", "413102054", "story_v_out_413102.awb") / 1000

					if var_236_38 + var_236_30 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_38 + var_236_30
					end

					if var_236_33.prefab_name ~= "" and arg_233_1.actors_[var_236_33.prefab_name] ~= nil then
						local var_236_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_33.prefab_name].transform, "story_v_out_413102", "413102054", "story_v_out_413102.awb")

						arg_233_1:RecordAudio("413102054", var_236_39)
						arg_233_1:RecordAudio("413102054", var_236_39)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_413102", "413102054", "story_v_out_413102.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_413102", "413102054", "story_v_out_413102.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_40 = math.max(var_236_31, arg_233_1.talkMaxDuration)

			if var_236_30 <= arg_233_1.time_ and arg_233_1.time_ < var_236_30 + var_236_40 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_30) / var_236_40

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_30 + var_236_40 and arg_233_1.time_ < var_236_30 + var_236_40 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_233_1:InitPlayNodeList()
	end,
	Play413102055 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 413102055
		arg_237_1.duration_ = 4.63

		local var_237_0 = {
			zh = 4.633,
			ja = 3.5
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
				arg_237_0:Play413102056(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["10096"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos10096 = var_240_0.localPosition
				var_240_0.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("10096", 2)

				local var_240_2 = var_240_0.childCount

				for iter_240_0 = 0, var_240_2 - 1 do
					local var_240_3 = var_240_0:GetChild(iter_240_0)

					if var_240_3.name == "" or not string.find(var_240_3.name, "split") then
						var_240_3.gameObject:SetActive(true)
					else
						var_240_3.gameObject:SetActive(false)
					end
				end
			end

			local var_240_4 = 0.001

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_4 then
				local var_240_5 = (arg_237_1.time_ - var_240_1) / var_240_4
				local var_240_6 = Vector3.New(-390, -350, -210)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10096, var_240_6, var_240_5)
			end

			if arg_237_1.time_ >= var_240_1 + var_240_4 and arg_237_1.time_ < var_240_1 + var_240_4 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_240_7 = arg_237_1.actors_["10094"].transform
			local var_240_8 = 0

			if var_240_8 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 then
				arg_237_1.var_.moveOldPos10094 = var_240_7.localPosition
				var_240_7.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("10094", 4)

				local var_240_9 = var_240_7.childCount

				for iter_240_1 = 0, var_240_9 - 1 do
					local var_240_10 = var_240_7:GetChild(iter_240_1)

					if var_240_10.name == "" or not string.find(var_240_10.name, "split") then
						var_240_10.gameObject:SetActive(true)
					else
						var_240_10.gameObject:SetActive(false)
					end
				end
			end

			local var_240_11 = 0.001

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_11 then
				local var_240_12 = (arg_237_1.time_ - var_240_8) / var_240_11
				local var_240_13 = Vector3.New(390, -340, -414)

				var_240_7.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10094, var_240_13, var_240_12)
			end

			if arg_237_1.time_ >= var_240_8 + var_240_11 and arg_237_1.time_ < var_240_8 + var_240_11 + arg_240_0 then
				var_240_7.localPosition = Vector3.New(390, -340, -414)
			end

			local var_240_14 = arg_237_1.actors_["10096"]
			local var_240_15 = 0

			if var_240_15 < arg_237_1.time_ and arg_237_1.time_ <= var_240_15 + arg_240_0 and not isNil(var_240_14) and arg_237_1.var_.actorSpriteComps10096 == nil then
				arg_237_1.var_.actorSpriteComps10096 = var_240_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_16 = 2

			if var_240_15 <= arg_237_1.time_ and arg_237_1.time_ < var_240_15 + var_240_16 and not isNil(var_240_14) then
				local var_240_17 = (arg_237_1.time_ - var_240_15) / var_240_16

				if arg_237_1.var_.actorSpriteComps10096 then
					for iter_240_2, iter_240_3 in pairs(arg_237_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_240_3 then
							if arg_237_1.isInRecall_ then
								local var_240_18 = Mathf.Lerp(iter_240_3.color.r, arg_237_1.hightColor2.r, var_240_17)
								local var_240_19 = Mathf.Lerp(iter_240_3.color.g, arg_237_1.hightColor2.g, var_240_17)
								local var_240_20 = Mathf.Lerp(iter_240_3.color.b, arg_237_1.hightColor2.b, var_240_17)

								iter_240_3.color = Color.New(var_240_18, var_240_19, var_240_20)
							else
								local var_240_21 = Mathf.Lerp(iter_240_3.color.r, 0.5, var_240_17)

								iter_240_3.color = Color.New(var_240_21, var_240_21, var_240_21)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= var_240_15 + var_240_16 and arg_237_1.time_ < var_240_15 + var_240_16 + arg_240_0 and not isNil(var_240_14) and arg_237_1.var_.actorSpriteComps10096 then
				for iter_240_4, iter_240_5 in pairs(arg_237_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_240_5 then
						if arg_237_1.isInRecall_ then
							iter_240_5.color = arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_240_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps10096 = nil
			end

			local var_240_22 = arg_237_1.actors_["10094"]
			local var_240_23 = 0

			if var_240_23 < arg_237_1.time_ and arg_237_1.time_ <= var_240_23 + arg_240_0 and not isNil(var_240_22) and arg_237_1.var_.actorSpriteComps10094 == nil then
				arg_237_1.var_.actorSpriteComps10094 = var_240_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_24 = 2

			if var_240_23 <= arg_237_1.time_ and arg_237_1.time_ < var_240_23 + var_240_24 and not isNil(var_240_22) then
				local var_240_25 = (arg_237_1.time_ - var_240_23) / var_240_24

				if arg_237_1.var_.actorSpriteComps10094 then
					for iter_240_6, iter_240_7 in pairs(arg_237_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_240_7 then
							if arg_237_1.isInRecall_ then
								local var_240_26 = Mathf.Lerp(iter_240_7.color.r, arg_237_1.hightColor1.r, var_240_25)
								local var_240_27 = Mathf.Lerp(iter_240_7.color.g, arg_237_1.hightColor1.g, var_240_25)
								local var_240_28 = Mathf.Lerp(iter_240_7.color.b, arg_237_1.hightColor1.b, var_240_25)

								iter_240_7.color = Color.New(var_240_26, var_240_27, var_240_28)
							else
								local var_240_29 = Mathf.Lerp(iter_240_7.color.r, 1, var_240_25)

								iter_240_7.color = Color.New(var_240_29, var_240_29, var_240_29)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= var_240_23 + var_240_24 and arg_237_1.time_ < var_240_23 + var_240_24 + arg_240_0 and not isNil(var_240_22) and arg_237_1.var_.actorSpriteComps10094 then
				for iter_240_8, iter_240_9 in pairs(arg_237_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_240_9 then
						if arg_237_1.isInRecall_ then
							iter_240_9.color = arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_240_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps10094 = nil
			end

			local var_240_30 = 0
			local var_240_31 = 0.475

			if var_240_30 < arg_237_1.time_ and arg_237_1.time_ <= var_240_30 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_32 = arg_237_1:FormatText(StoryNameCfg[259].name)

				arg_237_1.leftNameTxt_.text = var_240_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_33 = arg_237_1:GetWordFromCfg(413102055)
				local var_240_34 = arg_237_1:FormatText(var_240_33.content)

				arg_237_1.text_.text = var_240_34

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_35 = 19
				local var_240_36 = utf8.len(var_240_34)
				local var_240_37 = var_240_35 <= 0 and var_240_31 or var_240_31 * (var_240_36 / var_240_35)

				if var_240_37 > 0 and var_240_31 < var_240_37 then
					arg_237_1.talkMaxDuration = var_240_37

					if var_240_37 + var_240_30 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_37 + var_240_30
					end
				end

				arg_237_1.text_.text = var_240_34
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102055", "story_v_out_413102.awb") ~= 0 then
					local var_240_38 = manager.audio:GetVoiceLength("story_v_out_413102", "413102055", "story_v_out_413102.awb") / 1000

					if var_240_38 + var_240_30 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_38 + var_240_30
					end

					if var_240_33.prefab_name ~= "" and arg_237_1.actors_[var_240_33.prefab_name] ~= nil then
						local var_240_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_33.prefab_name].transform, "story_v_out_413102", "413102055", "story_v_out_413102.awb")

						arg_237_1:RecordAudio("413102055", var_240_39)
						arg_237_1:RecordAudio("413102055", var_240_39)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_413102", "413102055", "story_v_out_413102.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_413102", "413102055", "story_v_out_413102.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_40 = math.max(var_240_31, arg_237_1.talkMaxDuration)

			if var_240_30 <= arg_237_1.time_ and arg_237_1.time_ < var_240_30 + var_240_40 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_30) / var_240_40

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_30 + var_240_40 and arg_237_1.time_ < var_240_30 + var_240_40 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_237_1:InitPlayNodeList()
	end,
	Play413102056 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 413102056
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play413102057(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["10096"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos10096 = var_244_0.localPosition
				var_244_0.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("10096", 6)

				local var_244_2 = var_244_0.childCount

				for iter_244_0 = 0, var_244_2 - 1 do
					local var_244_3 = var_244_0:GetChild(iter_244_0)

					if var_244_3.name == "" or not string.find(var_244_3.name, "split") then
						var_244_3.gameObject:SetActive(true)
					else
						var_244_3.gameObject:SetActive(false)
					end
				end
			end

			local var_244_4 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_4 then
				local var_244_5 = (arg_241_1.time_ - var_244_1) / var_244_4
				local var_244_6 = Vector3.New(1500, -350, -210)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10096, var_244_6, var_244_5)
			end

			if arg_241_1.time_ >= var_244_1 + var_244_4 and arg_241_1.time_ < var_244_1 + var_244_4 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(1500, -350, -210)
			end

			local var_244_7 = arg_241_1.actors_["10094"].transform
			local var_244_8 = 0

			if var_244_8 < arg_241_1.time_ and arg_241_1.time_ <= var_244_8 + arg_244_0 then
				arg_241_1.var_.moveOldPos10094 = var_244_7.localPosition
				var_244_7.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("10094", 6)

				local var_244_9 = var_244_7.childCount

				for iter_244_1 = 0, var_244_9 - 1 do
					local var_244_10 = var_244_7:GetChild(iter_244_1)

					if var_244_10.name == "" or not string.find(var_244_10.name, "split") then
						var_244_10.gameObject:SetActive(true)
					else
						var_244_10.gameObject:SetActive(false)
					end
				end
			end

			local var_244_11 = 0.001

			if var_244_8 <= arg_241_1.time_ and arg_241_1.time_ < var_244_8 + var_244_11 then
				local var_244_12 = (arg_241_1.time_ - var_244_8) / var_244_11
				local var_244_13 = Vector3.New(1500, -340, -414)

				var_244_7.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10094, var_244_13, var_244_12)
			end

			if arg_241_1.time_ >= var_244_8 + var_244_11 and arg_241_1.time_ < var_244_8 + var_244_11 + arg_244_0 then
				var_244_7.localPosition = Vector3.New(1500, -340, -414)
			end

			local var_244_14 = arg_241_1.actors_["10096"]
			local var_244_15 = 0

			if var_244_15 < arg_241_1.time_ and arg_241_1.time_ <= var_244_15 + arg_244_0 and not isNil(var_244_14) and arg_241_1.var_.actorSpriteComps10096 == nil then
				arg_241_1.var_.actorSpriteComps10096 = var_244_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_16 = 2

			if var_244_15 <= arg_241_1.time_ and arg_241_1.time_ < var_244_15 + var_244_16 and not isNil(var_244_14) then
				local var_244_17 = (arg_241_1.time_ - var_244_15) / var_244_16

				if arg_241_1.var_.actorSpriteComps10096 then
					for iter_244_2, iter_244_3 in pairs(arg_241_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_244_3 then
							if arg_241_1.isInRecall_ then
								local var_244_18 = Mathf.Lerp(iter_244_3.color.r, arg_241_1.hightColor2.r, var_244_17)
								local var_244_19 = Mathf.Lerp(iter_244_3.color.g, arg_241_1.hightColor2.g, var_244_17)
								local var_244_20 = Mathf.Lerp(iter_244_3.color.b, arg_241_1.hightColor2.b, var_244_17)

								iter_244_3.color = Color.New(var_244_18, var_244_19, var_244_20)
							else
								local var_244_21 = Mathf.Lerp(iter_244_3.color.r, 0.5, var_244_17)

								iter_244_3.color = Color.New(var_244_21, var_244_21, var_244_21)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= var_244_15 + var_244_16 and arg_241_1.time_ < var_244_15 + var_244_16 + arg_244_0 and not isNil(var_244_14) and arg_241_1.var_.actorSpriteComps10096 then
				for iter_244_4, iter_244_5 in pairs(arg_241_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_244_5 then
						if arg_241_1.isInRecall_ then
							iter_244_5.color = arg_241_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_244_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_241_1.var_.actorSpriteComps10096 = nil
			end

			local var_244_22 = arg_241_1.actors_["10094"]
			local var_244_23 = 0

			if var_244_23 < arg_241_1.time_ and arg_241_1.time_ <= var_244_23 + arg_244_0 and not isNil(var_244_22) and arg_241_1.var_.actorSpriteComps10094 == nil then
				arg_241_1.var_.actorSpriteComps10094 = var_244_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_24 = 2

			if var_244_23 <= arg_241_1.time_ and arg_241_1.time_ < var_244_23 + var_244_24 and not isNil(var_244_22) then
				local var_244_25 = (arg_241_1.time_ - var_244_23) / var_244_24

				if arg_241_1.var_.actorSpriteComps10094 then
					for iter_244_6, iter_244_7 in pairs(arg_241_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_244_7 then
							if arg_241_1.isInRecall_ then
								local var_244_26 = Mathf.Lerp(iter_244_7.color.r, arg_241_1.hightColor2.r, var_244_25)
								local var_244_27 = Mathf.Lerp(iter_244_7.color.g, arg_241_1.hightColor2.g, var_244_25)
								local var_244_28 = Mathf.Lerp(iter_244_7.color.b, arg_241_1.hightColor2.b, var_244_25)

								iter_244_7.color = Color.New(var_244_26, var_244_27, var_244_28)
							else
								local var_244_29 = Mathf.Lerp(iter_244_7.color.r, 0.5, var_244_25)

								iter_244_7.color = Color.New(var_244_29, var_244_29, var_244_29)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= var_244_23 + var_244_24 and arg_241_1.time_ < var_244_23 + var_244_24 + arg_244_0 and not isNil(var_244_22) and arg_241_1.var_.actorSpriteComps10094 then
				for iter_244_8, iter_244_9 in pairs(arg_241_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_244_9 then
						if arg_241_1.isInRecall_ then
							iter_244_9.color = arg_241_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_244_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_241_1.var_.actorSpriteComps10094 = nil
			end

			local var_244_30 = 0
			local var_244_31 = 0.85

			if var_244_30 < arg_241_1.time_ and arg_241_1.time_ <= var_244_30 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_32 = arg_241_1:GetWordFromCfg(413102056)
				local var_244_33 = arg_241_1:FormatText(var_244_32.content)

				arg_241_1.text_.text = var_244_33

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_34 = 34
				local var_244_35 = utf8.len(var_244_33)
				local var_244_36 = var_244_34 <= 0 and var_244_31 or var_244_31 * (var_244_35 / var_244_34)

				if var_244_36 > 0 and var_244_31 < var_244_36 then
					arg_241_1.talkMaxDuration = var_244_36

					if var_244_36 + var_244_30 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_36 + var_244_30
					end
				end

				arg_241_1.text_.text = var_244_33
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_37 = math.max(var_244_31, arg_241_1.talkMaxDuration)

			if var_244_30 <= arg_241_1.time_ and arg_241_1.time_ < var_244_30 + var_244_37 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_30) / var_244_37

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_30 + var_244_37 and arg_241_1.time_ < var_244_30 + var_244_37 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_241_1:InitPlayNodeList()
	end,
	Play413102057 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 413102057
		arg_245_1.duration_ = 4.3

		local var_245_0 = {
			zh = 1.999999999999,
			ja = 4.3
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play413102058(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["10096"].transform
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.var_.moveOldPos10096 = var_248_0.localPosition
				var_248_0.localScale = Vector3.New(1, 1, 1)

				arg_245_1:CheckSpriteTmpPos("10096", 3)

				local var_248_2 = var_248_0.childCount

				for iter_248_0 = 0, var_248_2 - 1 do
					local var_248_3 = var_248_0:GetChild(iter_248_0)

					if var_248_3.name == "" or not string.find(var_248_3.name, "split") then
						var_248_3.gameObject:SetActive(true)
					else
						var_248_3.gameObject:SetActive(false)
					end
				end
			end

			local var_248_4 = 0.001

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_4 then
				local var_248_5 = (arg_245_1.time_ - var_248_1) / var_248_4
				local var_248_6 = Vector3.New(0, -350, -210)

				var_248_0.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos10096, var_248_6, var_248_5)
			end

			if arg_245_1.time_ >= var_248_1 + var_248_4 and arg_245_1.time_ < var_248_1 + var_248_4 + arg_248_0 then
				var_248_0.localPosition = Vector3.New(0, -350, -210)
			end

			local var_248_7 = arg_245_1.actors_["10096"]
			local var_248_8 = 0

			if var_248_8 < arg_245_1.time_ and arg_245_1.time_ <= var_248_8 + arg_248_0 and not isNil(var_248_7) and arg_245_1.var_.actorSpriteComps10096 == nil then
				arg_245_1.var_.actorSpriteComps10096 = var_248_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_9 = 2

			if var_248_8 <= arg_245_1.time_ and arg_245_1.time_ < var_248_8 + var_248_9 and not isNil(var_248_7) then
				local var_248_10 = (arg_245_1.time_ - var_248_8) / var_248_9

				if arg_245_1.var_.actorSpriteComps10096 then
					for iter_248_1, iter_248_2 in pairs(arg_245_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_248_2 then
							if arg_245_1.isInRecall_ then
								local var_248_11 = Mathf.Lerp(iter_248_2.color.r, arg_245_1.hightColor1.r, var_248_10)
								local var_248_12 = Mathf.Lerp(iter_248_2.color.g, arg_245_1.hightColor1.g, var_248_10)
								local var_248_13 = Mathf.Lerp(iter_248_2.color.b, arg_245_1.hightColor1.b, var_248_10)

								iter_248_2.color = Color.New(var_248_11, var_248_12, var_248_13)
							else
								local var_248_14 = Mathf.Lerp(iter_248_2.color.r, 1, var_248_10)

								iter_248_2.color = Color.New(var_248_14, var_248_14, var_248_14)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= var_248_8 + var_248_9 and arg_245_1.time_ < var_248_8 + var_248_9 + arg_248_0 and not isNil(var_248_7) and arg_245_1.var_.actorSpriteComps10096 then
				for iter_248_3, iter_248_4 in pairs(arg_245_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_248_4 then
						if arg_245_1.isInRecall_ then
							iter_248_4.color = arg_245_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_248_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_245_1.var_.actorSpriteComps10096 = nil
			end

			local var_248_15 = 0
			local var_248_16 = 0.125

			if var_248_15 < arg_245_1.time_ and arg_245_1.time_ <= var_248_15 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_17 = arg_245_1:FormatText(StoryNameCfg[36].name)

				arg_245_1.leftNameTxt_.text = var_248_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_18 = arg_245_1:GetWordFromCfg(413102057)
				local var_248_19 = arg_245_1:FormatText(var_248_18.content)

				arg_245_1.text_.text = var_248_19

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_20 = 5
				local var_248_21 = utf8.len(var_248_19)
				local var_248_22 = var_248_20 <= 0 and var_248_16 or var_248_16 * (var_248_21 / var_248_20)

				if var_248_22 > 0 and var_248_16 < var_248_22 then
					arg_245_1.talkMaxDuration = var_248_22

					if var_248_22 + var_248_15 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_22 + var_248_15
					end
				end

				arg_245_1.text_.text = var_248_19
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102057", "story_v_out_413102.awb") ~= 0 then
					local var_248_23 = manager.audio:GetVoiceLength("story_v_out_413102", "413102057", "story_v_out_413102.awb") / 1000

					if var_248_23 + var_248_15 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_23 + var_248_15
					end

					if var_248_18.prefab_name ~= "" and arg_245_1.actors_[var_248_18.prefab_name] ~= nil then
						local var_248_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_18.prefab_name].transform, "story_v_out_413102", "413102057", "story_v_out_413102.awb")

						arg_245_1:RecordAudio("413102057", var_248_24)
						arg_245_1:RecordAudio("413102057", var_248_24)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_413102", "413102057", "story_v_out_413102.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_413102", "413102057", "story_v_out_413102.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_25 = math.max(var_248_16, arg_245_1.talkMaxDuration)

			if var_248_15 <= arg_245_1.time_ and arg_245_1.time_ < var_248_15 + var_248_25 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_15) / var_248_25

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_15 + var_248_25 and arg_245_1.time_ < var_248_15 + var_248_25 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play413102058 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 413102058
		arg_249_1.duration_ = 5.43

		local var_249_0 = {
			zh = 4.1,
			ja = 5.433
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play413102059(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["10096"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos10096 = var_252_0.localPosition
				var_252_0.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("10096", 3)

				local var_252_2 = var_252_0.childCount

				for iter_252_0 = 0, var_252_2 - 1 do
					local var_252_3 = var_252_0:GetChild(iter_252_0)

					if var_252_3.name == "" or not string.find(var_252_3.name, "split") then
						var_252_3.gameObject:SetActive(true)
					else
						var_252_3.gameObject:SetActive(false)
					end
				end
			end

			local var_252_4 = 0.001

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_4 then
				local var_252_5 = (arg_249_1.time_ - var_252_1) / var_252_4
				local var_252_6 = Vector3.New(0, -350, -210)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10096, var_252_6, var_252_5)
			end

			if arg_249_1.time_ >= var_252_1 + var_252_4 and arg_249_1.time_ < var_252_1 + var_252_4 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(0, -350, -210)
			end

			local var_252_7 = arg_249_1.actors_["10096"]
			local var_252_8 = 0

			if var_252_8 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 and not isNil(var_252_7) and arg_249_1.var_.actorSpriteComps10096 == nil then
				arg_249_1.var_.actorSpriteComps10096 = var_252_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_9 = 2

			if var_252_8 <= arg_249_1.time_ and arg_249_1.time_ < var_252_8 + var_252_9 and not isNil(var_252_7) then
				local var_252_10 = (arg_249_1.time_ - var_252_8) / var_252_9

				if arg_249_1.var_.actorSpriteComps10096 then
					for iter_252_1, iter_252_2 in pairs(arg_249_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_252_2 then
							if arg_249_1.isInRecall_ then
								local var_252_11 = Mathf.Lerp(iter_252_2.color.r, arg_249_1.hightColor1.r, var_252_10)
								local var_252_12 = Mathf.Lerp(iter_252_2.color.g, arg_249_1.hightColor1.g, var_252_10)
								local var_252_13 = Mathf.Lerp(iter_252_2.color.b, arg_249_1.hightColor1.b, var_252_10)

								iter_252_2.color = Color.New(var_252_11, var_252_12, var_252_13)
							else
								local var_252_14 = Mathf.Lerp(iter_252_2.color.r, 1, var_252_10)

								iter_252_2.color = Color.New(var_252_14, var_252_14, var_252_14)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= var_252_8 + var_252_9 and arg_249_1.time_ < var_252_8 + var_252_9 + arg_252_0 and not isNil(var_252_7) and arg_249_1.var_.actorSpriteComps10096 then
				for iter_252_3, iter_252_4 in pairs(arg_249_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_252_4 then
						if arg_249_1.isInRecall_ then
							iter_252_4.color = arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_252_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps10096 = nil
			end

			local var_252_15 = 0
			local var_252_16 = 0.275

			if var_252_15 < arg_249_1.time_ and arg_249_1.time_ <= var_252_15 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_17 = arg_249_1:FormatText(StoryNameCfg[36].name)

				arg_249_1.leftNameTxt_.text = var_252_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_18 = arg_249_1:GetWordFromCfg(413102058)
				local var_252_19 = arg_249_1:FormatText(var_252_18.content)

				arg_249_1.text_.text = var_252_19

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_20 = 11
				local var_252_21 = utf8.len(var_252_19)
				local var_252_22 = var_252_20 <= 0 and var_252_16 or var_252_16 * (var_252_21 / var_252_20)

				if var_252_22 > 0 and var_252_16 < var_252_22 then
					arg_249_1.talkMaxDuration = var_252_22

					if var_252_22 + var_252_15 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_22 + var_252_15
					end
				end

				arg_249_1.text_.text = var_252_19
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102058", "story_v_out_413102.awb") ~= 0 then
					local var_252_23 = manager.audio:GetVoiceLength("story_v_out_413102", "413102058", "story_v_out_413102.awb") / 1000

					if var_252_23 + var_252_15 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_23 + var_252_15
					end

					if var_252_18.prefab_name ~= "" and arg_249_1.actors_[var_252_18.prefab_name] ~= nil then
						local var_252_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_18.prefab_name].transform, "story_v_out_413102", "413102058", "story_v_out_413102.awb")

						arg_249_1:RecordAudio("413102058", var_252_24)
						arg_249_1:RecordAudio("413102058", var_252_24)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_413102", "413102058", "story_v_out_413102.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_413102", "413102058", "story_v_out_413102.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_25 = math.max(var_252_16, arg_249_1.talkMaxDuration)

			if var_252_15 <= arg_249_1.time_ and arg_249_1.time_ < var_252_15 + var_252_25 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_15) / var_252_25

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_15 + var_252_25 and arg_249_1.time_ < var_252_15 + var_252_25 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play413102059 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 413102059
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play413102060(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["10096"].transform
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.var_.moveOldPos10096 = var_256_0.localPosition
				var_256_0.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("10096", 6)

				local var_256_2 = var_256_0.childCount

				for iter_256_0 = 0, var_256_2 - 1 do
					local var_256_3 = var_256_0:GetChild(iter_256_0)

					if var_256_3.name == "" or not string.find(var_256_3.name, "split") then
						var_256_3.gameObject:SetActive(true)
					else
						var_256_3.gameObject:SetActive(false)
					end
				end
			end

			local var_256_4 = 0.001

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_4 then
				local var_256_5 = (arg_253_1.time_ - var_256_1) / var_256_4
				local var_256_6 = Vector3.New(1500, -350, -210)

				var_256_0.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10096, var_256_6, var_256_5)
			end

			if arg_253_1.time_ >= var_256_1 + var_256_4 and arg_253_1.time_ < var_256_1 + var_256_4 + arg_256_0 then
				var_256_0.localPosition = Vector3.New(1500, -350, -210)
			end

			local var_256_7 = arg_253_1.actors_["10096"]
			local var_256_8 = 0

			if var_256_8 < arg_253_1.time_ and arg_253_1.time_ <= var_256_8 + arg_256_0 and not isNil(var_256_7) and arg_253_1.var_.actorSpriteComps10096 == nil then
				arg_253_1.var_.actorSpriteComps10096 = var_256_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_9 = 2

			if var_256_8 <= arg_253_1.time_ and arg_253_1.time_ < var_256_8 + var_256_9 and not isNil(var_256_7) then
				local var_256_10 = (arg_253_1.time_ - var_256_8) / var_256_9

				if arg_253_1.var_.actorSpriteComps10096 then
					for iter_256_1, iter_256_2 in pairs(arg_253_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_256_2 then
							if arg_253_1.isInRecall_ then
								local var_256_11 = Mathf.Lerp(iter_256_2.color.r, arg_253_1.hightColor2.r, var_256_10)
								local var_256_12 = Mathf.Lerp(iter_256_2.color.g, arg_253_1.hightColor2.g, var_256_10)
								local var_256_13 = Mathf.Lerp(iter_256_2.color.b, arg_253_1.hightColor2.b, var_256_10)

								iter_256_2.color = Color.New(var_256_11, var_256_12, var_256_13)
							else
								local var_256_14 = Mathf.Lerp(iter_256_2.color.r, 0.5, var_256_10)

								iter_256_2.color = Color.New(var_256_14, var_256_14, var_256_14)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_8 + var_256_9 and arg_253_1.time_ < var_256_8 + var_256_9 + arg_256_0 and not isNil(var_256_7) and arg_253_1.var_.actorSpriteComps10096 then
				for iter_256_3, iter_256_4 in pairs(arg_253_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_256_4 then
						if arg_253_1.isInRecall_ then
							iter_256_4.color = arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_256_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps10096 = nil
			end

			local var_256_15 = 0
			local var_256_16 = 0.925

			if var_256_15 < arg_253_1.time_ and arg_253_1.time_ <= var_256_15 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_17 = arg_253_1:GetWordFromCfg(413102059)
				local var_256_18 = arg_253_1:FormatText(var_256_17.content)

				arg_253_1.text_.text = var_256_18

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_19 = 37
				local var_256_20 = utf8.len(var_256_18)
				local var_256_21 = var_256_19 <= 0 and var_256_16 or var_256_16 * (var_256_20 / var_256_19)

				if var_256_21 > 0 and var_256_16 < var_256_21 then
					arg_253_1.talkMaxDuration = var_256_21

					if var_256_21 + var_256_15 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_21 + var_256_15
					end
				end

				arg_253_1.text_.text = var_256_18
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_22 = math.max(var_256_16, arg_253_1.talkMaxDuration)

			if var_256_15 <= arg_253_1.time_ and arg_253_1.time_ < var_256_15 + var_256_22 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_15) / var_256_22

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_15 + var_256_22 and arg_253_1.time_ < var_256_15 + var_256_22 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play413102060 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 413102060
		arg_257_1.duration_ = 2

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play413102061(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["10094"].transform
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.var_.moveOldPos10094 = var_260_0.localPosition
				var_260_0.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("10094", 3)

				local var_260_2 = var_260_0.childCount

				for iter_260_0 = 0, var_260_2 - 1 do
					local var_260_3 = var_260_0:GetChild(iter_260_0)

					if var_260_3.name == "split_2" or not string.find(var_260_3.name, "split") then
						var_260_3.gameObject:SetActive(true)
					else
						var_260_3.gameObject:SetActive(false)
					end
				end
			end

			local var_260_4 = 0.001

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_4 then
				local var_260_5 = (arg_257_1.time_ - var_260_1) / var_260_4
				local var_260_6 = Vector3.New(0, -340, -414)

				var_260_0.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos10094, var_260_6, var_260_5)
			end

			if arg_257_1.time_ >= var_260_1 + var_260_4 and arg_257_1.time_ < var_260_1 + var_260_4 + arg_260_0 then
				var_260_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_260_7 = arg_257_1.actors_["10094"]
			local var_260_8 = 0

			if var_260_8 < arg_257_1.time_ and arg_257_1.time_ <= var_260_8 + arg_260_0 and not isNil(var_260_7) and arg_257_1.var_.actorSpriteComps10094 == nil then
				arg_257_1.var_.actorSpriteComps10094 = var_260_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_9 = 2

			if var_260_8 <= arg_257_1.time_ and arg_257_1.time_ < var_260_8 + var_260_9 and not isNil(var_260_7) then
				local var_260_10 = (arg_257_1.time_ - var_260_8) / var_260_9

				if arg_257_1.var_.actorSpriteComps10094 then
					for iter_260_1, iter_260_2 in pairs(arg_257_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_260_2 then
							if arg_257_1.isInRecall_ then
								local var_260_11 = Mathf.Lerp(iter_260_2.color.r, arg_257_1.hightColor1.r, var_260_10)
								local var_260_12 = Mathf.Lerp(iter_260_2.color.g, arg_257_1.hightColor1.g, var_260_10)
								local var_260_13 = Mathf.Lerp(iter_260_2.color.b, arg_257_1.hightColor1.b, var_260_10)

								iter_260_2.color = Color.New(var_260_11, var_260_12, var_260_13)
							else
								local var_260_14 = Mathf.Lerp(iter_260_2.color.r, 1, var_260_10)

								iter_260_2.color = Color.New(var_260_14, var_260_14, var_260_14)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= var_260_8 + var_260_9 and arg_257_1.time_ < var_260_8 + var_260_9 + arg_260_0 and not isNil(var_260_7) and arg_257_1.var_.actorSpriteComps10094 then
				for iter_260_3, iter_260_4 in pairs(arg_257_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_260_4 then
						if arg_257_1.isInRecall_ then
							iter_260_4.color = arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_260_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps10094 = nil
			end

			local var_260_15 = 0
			local var_260_16 = 0.15

			if var_260_15 < arg_257_1.time_ and arg_257_1.time_ <= var_260_15 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_17 = arg_257_1:FormatText(StoryNameCfg[259].name)

				arg_257_1.leftNameTxt_.text = var_260_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_18 = arg_257_1:GetWordFromCfg(413102060)
				local var_260_19 = arg_257_1:FormatText(var_260_18.content)

				arg_257_1.text_.text = var_260_19

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_20 = 6
				local var_260_21 = utf8.len(var_260_19)
				local var_260_22 = var_260_20 <= 0 and var_260_16 or var_260_16 * (var_260_21 / var_260_20)

				if var_260_22 > 0 and var_260_16 < var_260_22 then
					arg_257_1.talkMaxDuration = var_260_22

					if var_260_22 + var_260_15 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_22 + var_260_15
					end
				end

				arg_257_1.text_.text = var_260_19
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102060", "story_v_out_413102.awb") ~= 0 then
					local var_260_23 = manager.audio:GetVoiceLength("story_v_out_413102", "413102060", "story_v_out_413102.awb") / 1000

					if var_260_23 + var_260_15 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_23 + var_260_15
					end

					if var_260_18.prefab_name ~= "" and arg_257_1.actors_[var_260_18.prefab_name] ~= nil then
						local var_260_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_18.prefab_name].transform, "story_v_out_413102", "413102060", "story_v_out_413102.awb")

						arg_257_1:RecordAudio("413102060", var_260_24)
						arg_257_1:RecordAudio("413102060", var_260_24)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_413102", "413102060", "story_v_out_413102.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_413102", "413102060", "story_v_out_413102.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_25 = math.max(var_260_16, arg_257_1.talkMaxDuration)

			if var_260_15 <= arg_257_1.time_ and arg_257_1.time_ < var_260_15 + var_260_25 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_15) / var_260_25

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_15 + var_260_25 and arg_257_1.time_ < var_260_15 + var_260_25 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
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

		arg_257_1:InitPlayNodeList()
	end,
	Play413102061 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 413102061
		arg_261_1.duration_ = 3.1

		local var_261_0 = {
			zh = 1.4,
			ja = 3.1
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
			arg_261_1.auto_ = false
		end

		function arg_261_1.playNext_(arg_263_0)
			arg_261_1.onStoryFinished_()
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.15

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_2 = arg_261_1:FormatText(StoryNameCfg[259].name)

				arg_261_1.leftNameTxt_.text = var_264_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_3 = arg_261_1:GetWordFromCfg(413102061)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 6
				local var_264_6 = utf8.len(var_264_4)
				local var_264_7 = var_264_5 <= 0 and var_264_1 or var_264_1 * (var_264_6 / var_264_5)

				if var_264_7 > 0 and var_264_1 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_4
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413102", "413102061", "story_v_out_413102.awb") ~= 0 then
					local var_264_8 = manager.audio:GetVoiceLength("story_v_out_413102", "413102061", "story_v_out_413102.awb") / 1000

					if var_264_8 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_8 + var_264_0
					end

					if var_264_3.prefab_name ~= "" and arg_261_1.actors_[var_264_3.prefab_name] ~= nil then
						local var_264_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_3.prefab_name].transform, "story_v_out_413102", "413102061", "story_v_out_413102.awb")

						arg_261_1:RecordAudio("413102061", var_264_9)
						arg_261_1:RecordAudio("413102061", var_264_9)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_413102", "413102061", "story_v_out_413102.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_413102", "413102061", "story_v_out_413102.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_10 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_10 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_10

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_10 and arg_261_1.time_ < var_264_0 + var_264_10 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F10g",
		"TextureConfig/Background/F09f",
		"TextureConfig/Background/SS1307"
	},
	voices = {
		"story_v_out_413102.awb"
	}
}
