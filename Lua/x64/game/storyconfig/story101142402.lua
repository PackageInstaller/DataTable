return {
	Play114242001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114242001
		arg_1_1.duration_ = 11.83

		local var_1_0 = {
			ja = 8.632999999999,
			ko = 11.765999999999,
			zh = 11.132999999999,
			en = 11.832999999999
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
				arg_1_0:Play114242002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "10018"

			if arg_1_1.actors_[var_4_0] == nil then
				local var_4_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10018")

				if not isNil(var_4_1) then
					local var_4_2 = Object.Instantiate(var_4_1, arg_1_1.canvasGo_.transform)

					var_4_2.transform:SetSiblingIndex(1)

					var_4_2.name = var_4_0
					var_4_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_0] = var_4_2

					local var_4_3 = var_4_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_1_1.isInRecall_ then
						for iter_4_0, iter_4_1 in ipairs(var_4_3) do
							iter_4_1.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_4 = arg_1_1.actors_["10018"].transform
			local var_4_5 = 1.8

			if var_4_5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.var_.moveOldPos10018 = var_4_4.localPosition
				var_4_4.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10018", 2)

				local var_4_6 = var_4_4.childCount

				for iter_4_2 = 0, var_4_6 - 1 do
					local var_4_7 = var_4_4:GetChild(iter_4_2)

					if var_4_7.name == "split_2" or not string.find(var_4_7.name, "split") then
						var_4_7.gameObject:SetActive(true)
					else
						var_4_7.gameObject:SetActive(false)
					end
				end
			end

			local var_4_8 = 0.001

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_8 then
				local var_4_9 = (arg_1_1.time_ - var_4_5) / var_4_8
				local var_4_10 = Vector3.New(-390, -350, -180)

				var_4_4.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10018, var_4_10, var_4_9)
			end

			if arg_1_1.time_ >= var_4_5 + var_4_8 and arg_1_1.time_ < var_4_5 + var_4_8 + arg_4_0 then
				var_4_4.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_4_11 = arg_1_1.actors_["10018"]
			local var_4_12 = 1.8

			if var_4_12 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 and not isNil(var_4_11) and arg_1_1.var_.actorSpriteComps10018 == nil then
				arg_1_1.var_.actorSpriteComps10018 = var_4_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.034

			if var_4_12 <= arg_1_1.time_ and arg_1_1.time_ < var_4_12 + var_4_13 and not isNil(var_4_11) then
				local var_4_14 = (arg_1_1.time_ - var_4_12) / var_4_13

				if arg_1_1.var_.actorSpriteComps10018 then
					for iter_4_3, iter_4_4 in pairs(arg_1_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_4_4 then
							if arg_1_1.isInRecall_ then
								local var_4_15 = Mathf.Lerp(iter_4_4.color.r, arg_1_1.hightColor1.r, var_4_14)
								local var_4_16 = Mathf.Lerp(iter_4_4.color.g, arg_1_1.hightColor1.g, var_4_14)
								local var_4_17 = Mathf.Lerp(iter_4_4.color.b, arg_1_1.hightColor1.b, var_4_14)

								iter_4_4.color = Color.New(var_4_15, var_4_16, var_4_17)
							else
								local var_4_18 = Mathf.Lerp(iter_4_4.color.r, 1, var_4_14)

								iter_4_4.color = Color.New(var_4_18, var_4_18, var_4_18)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_12 + var_4_13 and arg_1_1.time_ < var_4_12 + var_4_13 + arg_4_0 and not isNil(var_4_11) and arg_1_1.var_.actorSpriteComps10018 then
				for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_4_6 then
						if arg_1_1.isInRecall_ then
							iter_4_6.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10018 = nil
			end

			local var_4_19 = "ST25"

			if arg_1_1.bgs_[var_4_19] == nil then
				local var_4_20 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_19)
				var_4_20.name = var_4_19
				var_4_20.transform.parent = arg_1_1.stage_.transform
				var_4_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_19] = var_4_20
			end

			local var_4_21 = 0

			if var_4_21 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				local var_4_22 = manager.ui.mainCamera.transform.localPosition
				local var_4_23 = Vector3.New(0, 0, 10) + Vector3.New(var_4_22.x, var_4_22.y, 0)
				local var_4_24 = arg_1_1.bgs_.ST25

				var_4_24.transform.localPosition = var_4_23
				var_4_24.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_25 = var_4_24:GetComponent("SpriteRenderer")

				if var_4_25 and var_4_25.sprite then
					local var_4_26 = (var_4_24.transform.localPosition - var_4_22).z
					local var_4_27 = manager.ui.mainCameraCom_
					local var_4_28 = 2 * var_4_26 * Mathf.Tan(var_4_27.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_29 = var_4_28 * var_4_27.aspect
					local var_4_30 = var_4_25.sprite.bounds.size.x
					local var_4_31 = var_4_25.sprite.bounds.size.y
					local var_4_32 = var_4_29 / var_4_30
					local var_4_33 = var_4_28 / var_4_31
					local var_4_34 = var_4_33 < var_4_32 and var_4_32 or var_4_33

					var_4_24.transform.localScale = Vector3.New(var_4_34, var_4_34, 0)
				end

				for iter_4_7, iter_4_8 in pairs(arg_1_1.bgs_) do
					if iter_4_7 ~= "ST25" then
						iter_4_8.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_35 = 0

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_36 = 2

			if var_4_35 <= arg_1_1.time_ and arg_1_1.time_ < var_4_35 + var_4_36 then
				local var_4_37 = (arg_1_1.time_ - var_4_35) / var_4_36
				local var_4_38 = Color.New(0, 0, 0)

				var_4_38.a = Mathf.Lerp(1, 0, var_4_37)
				arg_1_1.mask_.color = var_4_38
			end

			if arg_1_1.time_ >= var_4_35 + var_4_36 and arg_1_1.time_ < var_4_35 + var_4_36 + arg_4_0 then
				local var_4_39 = Color.New(0, 0, 0)
				local var_4_40 = 0

				arg_1_1.mask_.enabled = false
				var_4_39.a = var_4_40
				arg_1_1.mask_.color = var_4_39
			end

			local var_4_41 = arg_1_1.actors_["10018"]
			local var_4_42 = 1.8

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_43 = var_4_41:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_43 then
					arg_1_1.var_.alphaOldValue10018 = var_4_43.alpha
					arg_1_1.var_.characterEffect10018 = var_4_43
				end

				arg_1_1.var_.alphaOldValue10018 = 0
			end

			local var_4_44 = 0.5

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_44 then
				local var_4_45 = (arg_1_1.time_ - var_4_42) / var_4_44
				local var_4_46 = Mathf.Lerp(arg_1_1.var_.alphaOldValue10018, 1, var_4_45)

				if arg_1_1.var_.characterEffect10018 then
					arg_1_1.var_.characterEffect10018.alpha = var_4_46
				end
			end

			if arg_1_1.time_ >= var_4_42 + var_4_44 and arg_1_1.time_ < var_4_42 + var_4_44 + arg_4_0 and arg_1_1.var_.characterEffect10018 then
				arg_1_1.var_.characterEffect10018.alpha = 1
			end

			local var_4_47 = 0
			local var_4_48 = 1

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_49 = "play"
				local var_4_50 = "music"

				arg_1_1:AudioAction(var_4_49, var_4_50, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_51 = ""
				local var_4_52 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_52 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_52 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_52

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_52
						arg_1_1.bgmTxt2_.text = var_4_52
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

			local var_4_53 = 2
			local var_4_54 = 1.5

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				local var_4_55 = "play"
				local var_4_56 = "music"

				arg_1_1:AudioAction(var_4_55, var_4_56, "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor.awb")

				local var_4_57 = ""
				local var_4_58 = manager.audio:GetAudioName("bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor")

				if var_4_58 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_58 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_58

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_58
						arg_1_1.bgmTxt2_.text = var_4_58
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

			local var_4_59 = 1.999999999999
			local var_4_60 = 1.1

			if var_4_59 < arg_1_1.time_ and arg_1_1.time_ <= var_4_59 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_61 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_61:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_62 = arg_1_1:FormatText(StoryNameCfg[257].name)

				arg_1_1.leftNameTxt_.text = var_4_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_63 = arg_1_1:GetWordFromCfg(114242001)
				local var_4_64 = arg_1_1:FormatText(var_4_63.content)

				arg_1_1.text_.text = var_4_64

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_65 = 44
				local var_4_66 = utf8.len(var_4_64)
				local var_4_67 = var_4_65 <= 0 and var_4_60 or var_4_60 * (var_4_66 / var_4_65)

				if var_4_67 > 0 and var_4_60 < var_4_67 then
					arg_1_1.talkMaxDuration = var_4_67
					var_4_59 = var_4_59 + 0.3

					if var_4_67 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_67 + var_4_59
					end
				end

				arg_1_1.text_.text = var_4_64
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242001", "story_v_out_114242.awb") ~= 0 then
					local var_4_68 = manager.audio:GetVoiceLength("story_v_out_114242", "114242001", "story_v_out_114242.awb") / 1000

					if var_4_68 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_68 + var_4_59
					end

					if var_4_63.prefab_name ~= "" and arg_1_1.actors_[var_4_63.prefab_name] ~= nil then
						local var_4_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_63.prefab_name].transform, "story_v_out_114242", "114242001", "story_v_out_114242.awb")

						arg_1_1:RecordAudio("114242001", var_4_69)
						arg_1_1:RecordAudio("114242001", var_4_69)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_114242", "114242001", "story_v_out_114242.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_114242", "114242001", "story_v_out_114242.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_70 = var_4_59 + 0.3
			local var_4_71 = math.max(var_4_60, arg_1_1.talkMaxDuration)

			if var_4_70 <= arg_1_1.time_ and arg_1_1.time_ < var_4_70 + var_4_71 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_70) / var_4_71

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_70 + var_4_71 and arg_1_1.time_ < var_4_70 + var_4_71 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play114242002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114242002
		arg_9_1.duration_ = 6.43

		local var_9_0 = {
			ja = 4.666,
			ko = 5.1,
			zh = 6.433,
			en = 4.333
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
				arg_9_0:Play114242003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "10015"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10015")

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

			local var_12_4 = arg_9_1.actors_["10015"].transform
			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1.var_.moveOldPos10015 = var_12_4.localPosition
				var_12_4.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10015", 4)

				local var_12_6 = var_12_4.childCount

				for iter_12_2 = 0, var_12_6 - 1 do
					local var_12_7 = var_12_4:GetChild(iter_12_2)

					if var_12_7.name == "split_5" or not string.find(var_12_7.name, "split") then
						var_12_7.gameObject:SetActive(true)
					else
						var_12_7.gameObject:SetActive(false)
					end
				end
			end

			local var_12_8 = 0.001

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_8 then
				local var_12_9 = (arg_9_1.time_ - var_12_5) / var_12_8
				local var_12_10 = Vector3.New(390, -350, -180)

				var_12_4.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10015, var_12_10, var_12_9)
			end

			if arg_9_1.time_ >= var_12_5 + var_12_8 and arg_9_1.time_ < var_12_5 + var_12_8 + arg_12_0 then
				var_12_4.localPosition = Vector3.New(390, -350, -180)
			end

			local var_12_11 = arg_9_1.actors_["10018"]
			local var_12_12 = 0

			if var_12_12 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.actorSpriteComps10018 == nil then
				arg_9_1.var_.actorSpriteComps10018 = var_12_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_13 = 0.034

			if var_12_12 <= arg_9_1.time_ and arg_9_1.time_ < var_12_12 + var_12_13 and not isNil(var_12_11) then
				local var_12_14 = (arg_9_1.time_ - var_12_12) / var_12_13

				if arg_9_1.var_.actorSpriteComps10018 then
					for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_12_4 then
							if arg_9_1.isInRecall_ then
								local var_12_15 = Mathf.Lerp(iter_12_4.color.r, arg_9_1.hightColor2.r, var_12_14)
								local var_12_16 = Mathf.Lerp(iter_12_4.color.g, arg_9_1.hightColor2.g, var_12_14)
								local var_12_17 = Mathf.Lerp(iter_12_4.color.b, arg_9_1.hightColor2.b, var_12_14)

								iter_12_4.color = Color.New(var_12_15, var_12_16, var_12_17)
							else
								local var_12_18 = Mathf.Lerp(iter_12_4.color.r, 0.5, var_12_14)

								iter_12_4.color = Color.New(var_12_18, var_12_18, var_12_18)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_12 + var_12_13 and arg_9_1.time_ < var_12_12 + var_12_13 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.actorSpriteComps10018 then
				for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_12_6 then
						if arg_9_1.isInRecall_ then
							iter_12_6.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10018 = nil
			end

			local var_12_19 = arg_9_1.actors_["10015"]
			local var_12_20 = 0

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 and not isNil(var_12_19) and arg_9_1.var_.actorSpriteComps10015 == nil then
				arg_9_1.var_.actorSpriteComps10015 = var_12_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_21 = 0.034

			if var_12_20 <= arg_9_1.time_ and arg_9_1.time_ < var_12_20 + var_12_21 and not isNil(var_12_19) then
				local var_12_22 = (arg_9_1.time_ - var_12_20) / var_12_21

				if arg_9_1.var_.actorSpriteComps10015 then
					for iter_12_7, iter_12_8 in pairs(arg_9_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_12_8 then
							if arg_9_1.isInRecall_ then
								local var_12_23 = Mathf.Lerp(iter_12_8.color.r, arg_9_1.hightColor1.r, var_12_22)
								local var_12_24 = Mathf.Lerp(iter_12_8.color.g, arg_9_1.hightColor1.g, var_12_22)
								local var_12_25 = Mathf.Lerp(iter_12_8.color.b, arg_9_1.hightColor1.b, var_12_22)

								iter_12_8.color = Color.New(var_12_23, var_12_24, var_12_25)
							else
								local var_12_26 = Mathf.Lerp(iter_12_8.color.r, 1, var_12_22)

								iter_12_8.color = Color.New(var_12_26, var_12_26, var_12_26)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_20 + var_12_21 and arg_9_1.time_ < var_12_20 + var_12_21 + arg_12_0 and not isNil(var_12_19) and arg_9_1.var_.actorSpriteComps10015 then
				for iter_12_9, iter_12_10 in pairs(arg_9_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_12_10 then
						if arg_9_1.isInRecall_ then
							iter_12_10.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_10.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10015 = nil
			end

			local var_12_27 = arg_9_1.actors_["10015"]
			local var_12_28 = 0

			if var_12_28 < arg_9_1.time_ and arg_9_1.time_ <= var_12_28 + arg_12_0 then
				local var_12_29 = var_12_27:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_29 then
					arg_9_1.var_.alphaOldValue10015 = var_12_29.alpha
					arg_9_1.var_.characterEffect10015 = var_12_29
				end

				arg_9_1.var_.alphaOldValue10015 = 0
			end

			local var_12_30 = 0.5

			if var_12_28 <= arg_9_1.time_ and arg_9_1.time_ < var_12_28 + var_12_30 then
				local var_12_31 = (arg_9_1.time_ - var_12_28) / var_12_30
				local var_12_32 = Mathf.Lerp(arg_9_1.var_.alphaOldValue10015, 1, var_12_31)

				if arg_9_1.var_.characterEffect10015 then
					arg_9_1.var_.characterEffect10015.alpha = var_12_32
				end
			end

			if arg_9_1.time_ >= var_12_28 + var_12_30 and arg_9_1.time_ < var_12_28 + var_12_30 + arg_12_0 and arg_9_1.var_.characterEffect10015 then
				arg_9_1.var_.characterEffect10015.alpha = 1
			end

			local var_12_33 = 0
			local var_12_34 = 0.65

			if var_12_33 < arg_9_1.time_ and arg_9_1.time_ <= var_12_33 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_35 = arg_9_1:FormatText(StoryNameCfg[208].name)

				arg_9_1.leftNameTxt_.text = var_12_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_36 = arg_9_1:GetWordFromCfg(114242002)
				local var_12_37 = arg_9_1:FormatText(var_12_36.content)

				arg_9_1.text_.text = var_12_37

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_38 = 26
				local var_12_39 = utf8.len(var_12_37)
				local var_12_40 = var_12_38 <= 0 and var_12_34 or var_12_34 * (var_12_39 / var_12_38)

				if var_12_40 > 0 and var_12_34 < var_12_40 then
					arg_9_1.talkMaxDuration = var_12_40

					if var_12_40 + var_12_33 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_40 + var_12_33
					end
				end

				arg_9_1.text_.text = var_12_37
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242002", "story_v_out_114242.awb") ~= 0 then
					local var_12_41 = manager.audio:GetVoiceLength("story_v_out_114242", "114242002", "story_v_out_114242.awb") / 1000

					if var_12_41 + var_12_33 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_41 + var_12_33
					end

					if var_12_36.prefab_name ~= "" and arg_9_1.actors_[var_12_36.prefab_name] ~= nil then
						local var_12_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_36.prefab_name].transform, "story_v_out_114242", "114242002", "story_v_out_114242.awb")

						arg_9_1:RecordAudio("114242002", var_12_42)
						arg_9_1:RecordAudio("114242002", var_12_42)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_114242", "114242002", "story_v_out_114242.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_114242", "114242002", "story_v_out_114242.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_43 = math.max(var_12_34, arg_9_1.talkMaxDuration)

			if var_12_33 <= arg_9_1.time_ and arg_9_1.time_ < var_12_33 + var_12_43 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_33) / var_12_43

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_33 + var_12_43 and arg_9_1.time_ < var_12_33 + var_12_43 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
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
	Play114242003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114242003
		arg_13_1.duration_ = 13.63

		local var_13_0 = {
			ja = 13.633,
			ko = 11.733,
			zh = 13.133,
			en = 9.633
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
				arg_13_0:Play114242004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10018"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps10018 == nil then
				arg_13_1.var_.actorSpriteComps10018 = var_16_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_2 = 0.034

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.actorSpriteComps10018 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_16_1 then
							if arg_13_1.isInRecall_ then
								local var_16_4 = Mathf.Lerp(iter_16_1.color.r, arg_13_1.hightColor1.r, var_16_3)
								local var_16_5 = Mathf.Lerp(iter_16_1.color.g, arg_13_1.hightColor1.g, var_16_3)
								local var_16_6 = Mathf.Lerp(iter_16_1.color.b, arg_13_1.hightColor1.b, var_16_3)

								iter_16_1.color = Color.New(var_16_4, var_16_5, var_16_6)
							else
								local var_16_7 = Mathf.Lerp(iter_16_1.color.r, 1, var_16_3)

								iter_16_1.color = Color.New(var_16_7, var_16_7, var_16_7)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps10018 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_16_3 then
						if arg_13_1.isInRecall_ then
							iter_16_3.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10018 = nil
			end

			local var_16_8 = arg_13_1.actors_["10015"]
			local var_16_9 = 0

			if var_16_9 < arg_13_1.time_ and arg_13_1.time_ <= var_16_9 + arg_16_0 and not isNil(var_16_8) and arg_13_1.var_.actorSpriteComps10015 == nil then
				arg_13_1.var_.actorSpriteComps10015 = var_16_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_10 = 0.034

			if var_16_9 <= arg_13_1.time_ and arg_13_1.time_ < var_16_9 + var_16_10 and not isNil(var_16_8) then
				local var_16_11 = (arg_13_1.time_ - var_16_9) / var_16_10

				if arg_13_1.var_.actorSpriteComps10015 then
					for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_16_5 then
							if arg_13_1.isInRecall_ then
								local var_16_12 = Mathf.Lerp(iter_16_5.color.r, arg_13_1.hightColor2.r, var_16_11)
								local var_16_13 = Mathf.Lerp(iter_16_5.color.g, arg_13_1.hightColor2.g, var_16_11)
								local var_16_14 = Mathf.Lerp(iter_16_5.color.b, arg_13_1.hightColor2.b, var_16_11)

								iter_16_5.color = Color.New(var_16_12, var_16_13, var_16_14)
							else
								local var_16_15 = Mathf.Lerp(iter_16_5.color.r, 0.5, var_16_11)

								iter_16_5.color = Color.New(var_16_15, var_16_15, var_16_15)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_9 + var_16_10 and arg_13_1.time_ < var_16_9 + var_16_10 + arg_16_0 and not isNil(var_16_8) and arg_13_1.var_.actorSpriteComps10015 then
				for iter_16_6, iter_16_7 in pairs(arg_13_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_16_7 then
						if arg_13_1.isInRecall_ then
							iter_16_7.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10015 = nil
			end

			local var_16_16 = arg_13_1.actors_["10018"].transform
			local var_16_17 = 0

			if var_16_17 < arg_13_1.time_ and arg_13_1.time_ <= var_16_17 + arg_16_0 then
				arg_13_1.var_.moveOldPos10018 = var_16_16.localPosition
				var_16_16.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10018", 2)

				local var_16_18 = var_16_16.childCount

				for iter_16_8 = 0, var_16_18 - 1 do
					local var_16_19 = var_16_16:GetChild(iter_16_8)

					if var_16_19.name == "split_1" or not string.find(var_16_19.name, "split") then
						var_16_19.gameObject:SetActive(true)
					else
						var_16_19.gameObject:SetActive(false)
					end
				end
			end

			local var_16_20 = 0.001

			if var_16_17 <= arg_13_1.time_ and arg_13_1.time_ < var_16_17 + var_16_20 then
				local var_16_21 = (arg_13_1.time_ - var_16_17) / var_16_20
				local var_16_22 = Vector3.New(-390, -350, -180)

				var_16_16.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10018, var_16_22, var_16_21)
			end

			if arg_13_1.time_ >= var_16_17 + var_16_20 and arg_13_1.time_ < var_16_17 + var_16_20 + arg_16_0 then
				var_16_16.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_16_23 = 0
			local var_16_24 = 1.125

			if var_16_23 < arg_13_1.time_ and arg_13_1.time_ <= var_16_23 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_25 = arg_13_1:FormatText(StoryNameCfg[257].name)

				arg_13_1.leftNameTxt_.text = var_16_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_26 = arg_13_1:GetWordFromCfg(114242003)
				local var_16_27 = arg_13_1:FormatText(var_16_26.content)

				arg_13_1.text_.text = var_16_27

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_28 = 45
				local var_16_29 = utf8.len(var_16_27)
				local var_16_30 = var_16_28 <= 0 and var_16_24 or var_16_24 * (var_16_29 / var_16_28)

				if var_16_30 > 0 and var_16_24 < var_16_30 then
					arg_13_1.talkMaxDuration = var_16_30

					if var_16_30 + var_16_23 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_30 + var_16_23
					end
				end

				arg_13_1.text_.text = var_16_27
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242003", "story_v_out_114242.awb") ~= 0 then
					local var_16_31 = manager.audio:GetVoiceLength("story_v_out_114242", "114242003", "story_v_out_114242.awb") / 1000

					if var_16_31 + var_16_23 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_31 + var_16_23
					end

					if var_16_26.prefab_name ~= "" and arg_13_1.actors_[var_16_26.prefab_name] ~= nil then
						local var_16_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_26.prefab_name].transform, "story_v_out_114242", "114242003", "story_v_out_114242.awb")

						arg_13_1:RecordAudio("114242003", var_16_32)
						arg_13_1:RecordAudio("114242003", var_16_32)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_114242", "114242003", "story_v_out_114242.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_114242", "114242003", "story_v_out_114242.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_33 = math.max(var_16_24, arg_13_1.talkMaxDuration)

			if var_16_23 <= arg_13_1.time_ and arg_13_1.time_ < var_16_23 + var_16_33 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_23) / var_16_33

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_23 + var_16_33 and arg_13_1.time_ < var_16_23 + var_16_33 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
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
	Play114242004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114242004
		arg_17_1.duration_ = 7.9

		local var_17_0 = {
			ja = 7.4,
			ko = 7.5,
			zh = 7.9,
			en = 6.033
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
				arg_17_0:Play114242005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.9

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[257].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:GetWordFromCfg(114242004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242004", "story_v_out_114242.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_114242", "114242004", "story_v_out_114242.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_114242", "114242004", "story_v_out_114242.awb")

						arg_17_1:RecordAudio("114242004", var_20_9)
						arg_17_1:RecordAudio("114242004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_114242", "114242004", "story_v_out_114242.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_114242", "114242004", "story_v_out_114242.awb")
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
	Play114242005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114242005
		arg_21_1.duration_ = 4.13

		local var_21_0 = {
			ja = 2.266,
			ko = 4.133,
			zh = 3.433,
			en = 2.7
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
				arg_21_0:Play114242006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10018"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10018 == nil then
				arg_21_1.var_.actorSpriteComps10018 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.034

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps10018 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10018 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10018 = nil
			end

			local var_24_8 = arg_21_1.actors_["10015"]
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10015 == nil then
				arg_21_1.var_.actorSpriteComps10015 = var_24_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_10 = 0.034

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_10 and not isNil(var_24_8) then
				local var_24_11 = (arg_21_1.time_ - var_24_9) / var_24_10

				if arg_21_1.var_.actorSpriteComps10015 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_24_5 then
							if arg_21_1.isInRecall_ then
								local var_24_12 = Mathf.Lerp(iter_24_5.color.r, arg_21_1.hightColor1.r, var_24_11)
								local var_24_13 = Mathf.Lerp(iter_24_5.color.g, arg_21_1.hightColor1.g, var_24_11)
								local var_24_14 = Mathf.Lerp(iter_24_5.color.b, arg_21_1.hightColor1.b, var_24_11)

								iter_24_5.color = Color.New(var_24_12, var_24_13, var_24_14)
							else
								local var_24_15 = Mathf.Lerp(iter_24_5.color.r, 1, var_24_11)

								iter_24_5.color = Color.New(var_24_15, var_24_15, var_24_15)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_9 + var_24_10 and arg_21_1.time_ < var_24_9 + var_24_10 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10015 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_24_7 then
						if arg_21_1.isInRecall_ then
							iter_24_7.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10015 = nil
			end

			local var_24_16 = 0
			local var_24_17 = 0.4

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_18 = arg_21_1:FormatText(StoryNameCfg[208].name)

				arg_21_1.leftNameTxt_.text = var_24_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_19 = arg_21_1:GetWordFromCfg(114242005)
				local var_24_20 = arg_21_1:FormatText(var_24_19.content)

				arg_21_1.text_.text = var_24_20

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_21 = 16
				local var_24_22 = utf8.len(var_24_20)
				local var_24_23 = var_24_21 <= 0 and var_24_17 or var_24_17 * (var_24_22 / var_24_21)

				if var_24_23 > 0 and var_24_17 < var_24_23 then
					arg_21_1.talkMaxDuration = var_24_23

					if var_24_23 + var_24_16 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_16
					end
				end

				arg_21_1.text_.text = var_24_20
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242005", "story_v_out_114242.awb") ~= 0 then
					local var_24_24 = manager.audio:GetVoiceLength("story_v_out_114242", "114242005", "story_v_out_114242.awb") / 1000

					if var_24_24 + var_24_16 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_24 + var_24_16
					end

					if var_24_19.prefab_name ~= "" and arg_21_1.actors_[var_24_19.prefab_name] ~= nil then
						local var_24_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_19.prefab_name].transform, "story_v_out_114242", "114242005", "story_v_out_114242.awb")

						arg_21_1:RecordAudio("114242005", var_24_25)
						arg_21_1:RecordAudio("114242005", var_24_25)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_114242", "114242005", "story_v_out_114242.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_114242", "114242005", "story_v_out_114242.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_26 = math.max(var_24_17, arg_21_1.talkMaxDuration)

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_26 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_16) / var_24_26

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_16 + var_24_26 and arg_21_1.time_ < var_24_16 + var_24_26 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play114242006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114242006
		arg_25_1.duration_ = 12.1

		local var_25_0 = {
			ja = 10.966,
			ko = 11.666,
			zh = 11.033,
			en = 12.1
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
				arg_25_0:Play114242007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10018"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps10018 == nil then
				arg_25_1.var_.actorSpriteComps10018 = var_28_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_2 = 0.034

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.actorSpriteComps10018 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_28_1 then
							if arg_25_1.isInRecall_ then
								local var_28_4 = Mathf.Lerp(iter_28_1.color.r, arg_25_1.hightColor1.r, var_28_3)
								local var_28_5 = Mathf.Lerp(iter_28_1.color.g, arg_25_1.hightColor1.g, var_28_3)
								local var_28_6 = Mathf.Lerp(iter_28_1.color.b, arg_25_1.hightColor1.b, var_28_3)

								iter_28_1.color = Color.New(var_28_4, var_28_5, var_28_6)
							else
								local var_28_7 = Mathf.Lerp(iter_28_1.color.r, 1, var_28_3)

								iter_28_1.color = Color.New(var_28_7, var_28_7, var_28_7)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps10018 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_28_3 then
						if arg_25_1.isInRecall_ then
							iter_28_3.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10018 = nil
			end

			local var_28_8 = arg_25_1.actors_["10015"]
			local var_28_9 = 0

			if var_28_9 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.actorSpriteComps10015 == nil then
				arg_25_1.var_.actorSpriteComps10015 = var_28_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_10 = 0.034

			if var_28_9 <= arg_25_1.time_ and arg_25_1.time_ < var_28_9 + var_28_10 and not isNil(var_28_8) then
				local var_28_11 = (arg_25_1.time_ - var_28_9) / var_28_10

				if arg_25_1.var_.actorSpriteComps10015 then
					for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_28_5 then
							if arg_25_1.isInRecall_ then
								local var_28_12 = Mathf.Lerp(iter_28_5.color.r, arg_25_1.hightColor2.r, var_28_11)
								local var_28_13 = Mathf.Lerp(iter_28_5.color.g, arg_25_1.hightColor2.g, var_28_11)
								local var_28_14 = Mathf.Lerp(iter_28_5.color.b, arg_25_1.hightColor2.b, var_28_11)

								iter_28_5.color = Color.New(var_28_12, var_28_13, var_28_14)
							else
								local var_28_15 = Mathf.Lerp(iter_28_5.color.r, 0.5, var_28_11)

								iter_28_5.color = Color.New(var_28_15, var_28_15, var_28_15)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_9 + var_28_10 and arg_25_1.time_ < var_28_9 + var_28_10 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.actorSpriteComps10015 then
				for iter_28_6, iter_28_7 in pairs(arg_25_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_28_7 then
						if arg_25_1.isInRecall_ then
							iter_28_7.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10015 = nil
			end

			local var_28_16 = 0
			local var_28_17 = 1.15

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_18 = arg_25_1:FormatText(StoryNameCfg[257].name)

				arg_25_1.leftNameTxt_.text = var_28_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_19 = arg_25_1:GetWordFromCfg(114242006)
				local var_28_20 = arg_25_1:FormatText(var_28_19.content)

				arg_25_1.text_.text = var_28_20

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_21 = 46
				local var_28_22 = utf8.len(var_28_20)
				local var_28_23 = var_28_21 <= 0 and var_28_17 or var_28_17 * (var_28_22 / var_28_21)

				if var_28_23 > 0 and var_28_17 < var_28_23 then
					arg_25_1.talkMaxDuration = var_28_23

					if var_28_23 + var_28_16 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_23 + var_28_16
					end
				end

				arg_25_1.text_.text = var_28_20
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242006", "story_v_out_114242.awb") ~= 0 then
					local var_28_24 = manager.audio:GetVoiceLength("story_v_out_114242", "114242006", "story_v_out_114242.awb") / 1000

					if var_28_24 + var_28_16 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_24 + var_28_16
					end

					if var_28_19.prefab_name ~= "" and arg_25_1.actors_[var_28_19.prefab_name] ~= nil then
						local var_28_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_19.prefab_name].transform, "story_v_out_114242", "114242006", "story_v_out_114242.awb")

						arg_25_1:RecordAudio("114242006", var_28_25)
						arg_25_1:RecordAudio("114242006", var_28_25)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_114242", "114242006", "story_v_out_114242.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_114242", "114242006", "story_v_out_114242.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_26 = math.max(var_28_17, arg_25_1.talkMaxDuration)

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_26 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_16) / var_28_26

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_16 + var_28_26 and arg_25_1.time_ < var_28_16 + var_28_26 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play114242007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 114242007
		arg_29_1.duration_ = 5.2

		local var_29_0 = {
			ja = 5.2,
			ko = 4.6,
			zh = 4.166,
			en = 4.066
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
				arg_29_0:Play114242008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10018"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10018 == nil then
				arg_29_1.var_.actorSpriteComps10018 = var_32_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_2 = 0.034

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.actorSpriteComps10018 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								local var_32_4 = Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor2.r, var_32_3)
								local var_32_5 = Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor2.g, var_32_3)
								local var_32_6 = Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor2.b, var_32_3)

								iter_32_1.color = Color.New(var_32_4, var_32_5, var_32_6)
							else
								local var_32_7 = Mathf.Lerp(iter_32_1.color.r, 0.5, var_32_3)

								iter_32_1.color = Color.New(var_32_7, var_32_7, var_32_7)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10018 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_32_3 then
						if arg_29_1.isInRecall_ then
							iter_32_3.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10018 = nil
			end

			local var_32_8 = arg_29_1.actors_["10015"]
			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10015 == nil then
				arg_29_1.var_.actorSpriteComps10015 = var_32_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_10 = 0.034

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_10 and not isNil(var_32_8) then
				local var_32_11 = (arg_29_1.time_ - var_32_9) / var_32_10

				if arg_29_1.var_.actorSpriteComps10015 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_32_5 then
							if arg_29_1.isInRecall_ then
								local var_32_12 = Mathf.Lerp(iter_32_5.color.r, arg_29_1.hightColor1.r, var_32_11)
								local var_32_13 = Mathf.Lerp(iter_32_5.color.g, arg_29_1.hightColor1.g, var_32_11)
								local var_32_14 = Mathf.Lerp(iter_32_5.color.b, arg_29_1.hightColor1.b, var_32_11)

								iter_32_5.color = Color.New(var_32_12, var_32_13, var_32_14)
							else
								local var_32_15 = Mathf.Lerp(iter_32_5.color.r, 1, var_32_11)

								iter_32_5.color = Color.New(var_32_15, var_32_15, var_32_15)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_9 + var_32_10 and arg_29_1.time_ < var_32_9 + var_32_10 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10015 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_32_7 then
						if arg_29_1.isInRecall_ then
							iter_32_7.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10015 = nil
			end

			local var_32_16 = 0
			local var_32_17 = 0.325

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_18 = arg_29_1:FormatText(StoryNameCfg[208].name)

				arg_29_1.leftNameTxt_.text = var_32_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_19 = arg_29_1:GetWordFromCfg(114242007)
				local var_32_20 = arg_29_1:FormatText(var_32_19.content)

				arg_29_1.text_.text = var_32_20

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_21 = 13
				local var_32_22 = utf8.len(var_32_20)
				local var_32_23 = var_32_21 <= 0 and var_32_17 or var_32_17 * (var_32_22 / var_32_21)

				if var_32_23 > 0 and var_32_17 < var_32_23 then
					arg_29_1.talkMaxDuration = var_32_23

					if var_32_23 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_23 + var_32_16
					end
				end

				arg_29_1.text_.text = var_32_20
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242007", "story_v_out_114242.awb") ~= 0 then
					local var_32_24 = manager.audio:GetVoiceLength("story_v_out_114242", "114242007", "story_v_out_114242.awb") / 1000

					if var_32_24 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_24 + var_32_16
					end

					if var_32_19.prefab_name ~= "" and arg_29_1.actors_[var_32_19.prefab_name] ~= nil then
						local var_32_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_19.prefab_name].transform, "story_v_out_114242", "114242007", "story_v_out_114242.awb")

						arg_29_1:RecordAudio("114242007", var_32_25)
						arg_29_1:RecordAudio("114242007", var_32_25)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_114242", "114242007", "story_v_out_114242.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_114242", "114242007", "story_v_out_114242.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_26 = math.max(var_32_17, arg_29_1.talkMaxDuration)

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_26 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_16) / var_32_26

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_16 + var_32_26 and arg_29_1.time_ < var_32_16 + var_32_26 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play114242008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 114242008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play114242009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10015"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10015 == nil then
				arg_33_1.var_.actorSpriteComps10015 = var_36_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_2 = 0.034

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.actorSpriteComps10015 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10015 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10015 = nil
			end

			local var_36_8 = 0
			local var_36_9 = 0.575

			if var_36_8 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_10 = arg_33_1:GetWordFromCfg(114242008)
				local var_36_11 = arg_33_1:FormatText(var_36_10.content)

				arg_33_1.text_.text = var_36_11

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_12 = 23
				local var_36_13 = utf8.len(var_36_11)
				local var_36_14 = var_36_12 <= 0 and var_36_9 or var_36_9 * (var_36_13 / var_36_12)

				if var_36_14 > 0 and var_36_9 < var_36_14 then
					arg_33_1.talkMaxDuration = var_36_14

					if var_36_14 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_11
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_15 = math.max(var_36_9, arg_33_1.talkMaxDuration)

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_15 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_8) / var_36_15

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_8 + var_36_15 and arg_33_1.time_ < var_36_8 + var_36_15 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play114242009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 114242009
		arg_37_1.duration_ = 4

		local var_37_0 = {
			ja = 3.233,
			ko = 4,
			zh = 3.466,
			en = 2.6
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
				arg_37_0:Play114242010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10015"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps10015 == nil then
				arg_37_1.var_.actorSpriteComps10015 = var_40_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_2 = 0.034

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.actorSpriteComps10015 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps10015 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_40_3 then
						if arg_37_1.isInRecall_ then
							iter_40_3.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10015 = nil
			end

			local var_40_8 = arg_37_1.actors_["10015"].transform
			local var_40_9 = 0

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 then
				arg_37_1.var_.moveOldPos10015 = var_40_8.localPosition
				var_40_8.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10015", 4)

				local var_40_10 = var_40_8.childCount

				for iter_40_4 = 0, var_40_10 - 1 do
					local var_40_11 = var_40_8:GetChild(iter_40_4)

					if var_40_11.name == "split_1" or not string.find(var_40_11.name, "split") then
						var_40_11.gameObject:SetActive(true)
					else
						var_40_11.gameObject:SetActive(false)
					end
				end
			end

			local var_40_12 = 0.001

			if var_40_9 <= arg_37_1.time_ and arg_37_1.time_ < var_40_9 + var_40_12 then
				local var_40_13 = (arg_37_1.time_ - var_40_9) / var_40_12
				local var_40_14 = Vector3.New(390, -350, -180)

				var_40_8.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10015, var_40_14, var_40_13)
			end

			if arg_37_1.time_ >= var_40_9 + var_40_12 and arg_37_1.time_ < var_40_9 + var_40_12 + arg_40_0 then
				var_40_8.localPosition = Vector3.New(390, -350, -180)
			end

			local var_40_15 = 0
			local var_40_16 = 0.325

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_17 = arg_37_1:FormatText(StoryNameCfg[208].name)

				arg_37_1.leftNameTxt_.text = var_40_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_18 = arg_37_1:GetWordFromCfg(114242009)
				local var_40_19 = arg_37_1:FormatText(var_40_18.content)

				arg_37_1.text_.text = var_40_19

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242009", "story_v_out_114242.awb") ~= 0 then
					local var_40_23 = manager.audio:GetVoiceLength("story_v_out_114242", "114242009", "story_v_out_114242.awb") / 1000

					if var_40_23 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_15
					end

					if var_40_18.prefab_name ~= "" and arg_37_1.actors_[var_40_18.prefab_name] ~= nil then
						local var_40_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_18.prefab_name].transform, "story_v_out_114242", "114242009", "story_v_out_114242.awb")

						arg_37_1:RecordAudio("114242009", var_40_24)
						arg_37_1:RecordAudio("114242009", var_40_24)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_114242", "114242009", "story_v_out_114242.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_114242", "114242009", "story_v_out_114242.awb")
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
				actorName = "10015",
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
	Play114242010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 114242010
		arg_41_1.duration_ = 2.83

		local var_41_0 = {
			ja = 2.5,
			ko = 2.833,
			zh = 2.333,
			en = 2.066
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
				arg_41_0:Play114242011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10018"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10018 == nil then
				arg_41_1.var_.actorSpriteComps10018 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.034

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps10018 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10018 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10018 = nil
			end

			local var_44_8 = arg_41_1.actors_["10015"]
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10015 == nil then
				arg_41_1.var_.actorSpriteComps10015 = var_44_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_10 = 0.034

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_10 and not isNil(var_44_8) then
				local var_44_11 = (arg_41_1.time_ - var_44_9) / var_44_10

				if arg_41_1.var_.actorSpriteComps10015 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_41_1.time_ >= var_44_9 + var_44_10 and arg_41_1.time_ < var_44_9 + var_44_10 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10015 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_44_7 then
						if arg_41_1.isInRecall_ then
							iter_44_7.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10015 = nil
			end

			local var_44_16 = 0
			local var_44_17 = 0.175

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_18 = arg_41_1:FormatText(StoryNameCfg[257].name)

				arg_41_1.leftNameTxt_.text = var_44_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_19 = arg_41_1:GetWordFromCfg(114242010)
				local var_44_20 = arg_41_1:FormatText(var_44_19.content)

				arg_41_1.text_.text = var_44_20

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_21 = 7
				local var_44_22 = utf8.len(var_44_20)
				local var_44_23 = var_44_21 <= 0 and var_44_17 or var_44_17 * (var_44_22 / var_44_21)

				if var_44_23 > 0 and var_44_17 < var_44_23 then
					arg_41_1.talkMaxDuration = var_44_23

					if var_44_23 + var_44_16 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_23 + var_44_16
					end
				end

				arg_41_1.text_.text = var_44_20
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242010", "story_v_out_114242.awb") ~= 0 then
					local var_44_24 = manager.audio:GetVoiceLength("story_v_out_114242", "114242010", "story_v_out_114242.awb") / 1000

					if var_44_24 + var_44_16 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_24 + var_44_16
					end

					if var_44_19.prefab_name ~= "" and arg_41_1.actors_[var_44_19.prefab_name] ~= nil then
						local var_44_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_19.prefab_name].transform, "story_v_out_114242", "114242010", "story_v_out_114242.awb")

						arg_41_1:RecordAudio("114242010", var_44_25)
						arg_41_1:RecordAudio("114242010", var_44_25)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_114242", "114242010", "story_v_out_114242.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_114242", "114242010", "story_v_out_114242.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_26 = math.max(var_44_17, arg_41_1.talkMaxDuration)

			if var_44_16 <= arg_41_1.time_ and arg_41_1.time_ < var_44_16 + var_44_26 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_16) / var_44_26

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_16 + var_44_26 and arg_41_1.time_ < var_44_16 + var_44_26 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play114242011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 114242011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play114242012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10018"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps10018 == nil then
				arg_45_1.var_.actorSpriteComps10018 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 0.034

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps10018 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps10018 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10018 = nil
			end

			local var_48_8 = 0
			local var_48_9 = 0.6

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_10 = arg_45_1:GetWordFromCfg(114242011)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_12 = 24
				local var_48_13 = utf8.len(var_48_11)
				local var_48_14 = var_48_12 <= 0 and var_48_9 or var_48_9 * (var_48_13 / var_48_12)

				if var_48_14 > 0 and var_48_9 < var_48_14 then
					arg_45_1.talkMaxDuration = var_48_14

					if var_48_14 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_8
					end
				end

				arg_45_1.text_.text = var_48_11
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_15 = math.max(var_48_9, arg_45_1.talkMaxDuration)

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_15 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_8) / var_48_15

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_8 + var_48_15 and arg_45_1.time_ < var_48_8 + var_48_15 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play114242012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 114242012
		arg_49_1.duration_ = 5.9

		local var_49_0 = {
			ja = 5.9,
			ko = 5.533,
			zh = 4.5,
			en = 4.966
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
				arg_49_0:Play114242013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10018"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10018 == nil then
				arg_49_1.var_.actorSpriteComps10018 = var_52_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_2 = 0.034

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.actorSpriteComps10018 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10018 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_52_3 then
						if arg_49_1.isInRecall_ then
							iter_52_3.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10018 = nil
			end

			local var_52_8 = 0
			local var_52_9 = 0.65

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_10 = arg_49_1:FormatText(StoryNameCfg[257].name)

				arg_49_1.leftNameTxt_.text = var_52_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_11 = arg_49_1:GetWordFromCfg(114242012)
				local var_52_12 = arg_49_1:FormatText(var_52_11.content)

				arg_49_1.text_.text = var_52_12

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_13 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242012", "story_v_out_114242.awb") ~= 0 then
					local var_52_16 = manager.audio:GetVoiceLength("story_v_out_114242", "114242012", "story_v_out_114242.awb") / 1000

					if var_52_16 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_16 + var_52_8
					end

					if var_52_11.prefab_name ~= "" and arg_49_1.actors_[var_52_11.prefab_name] ~= nil then
						local var_52_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_11.prefab_name].transform, "story_v_out_114242", "114242012", "story_v_out_114242.awb")

						arg_49_1:RecordAudio("114242012", var_52_17)
						arg_49_1:RecordAudio("114242012", var_52_17)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_114242", "114242012", "story_v_out_114242.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_114242", "114242012", "story_v_out_114242.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_18 = math.max(var_52_9, arg_49_1.talkMaxDuration)

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_18 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_8) / var_52_18

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_8 + var_52_18 and arg_49_1.time_ < var_52_8 + var_52_18 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play114242013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 114242013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play114242014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10018"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps10018 == nil then
				arg_53_1.var_.actorSpriteComps10018 = var_56_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_2 = 0.034

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.actorSpriteComps10018 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								local var_56_4 = Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor2.r, var_56_3)
								local var_56_5 = Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor2.g, var_56_3)
								local var_56_6 = Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor2.b, var_56_3)

								iter_56_1.color = Color.New(var_56_4, var_56_5, var_56_6)
							else
								local var_56_7 = Mathf.Lerp(iter_56_1.color.r, 0.5, var_56_3)

								iter_56_1.color = Color.New(var_56_7, var_56_7, var_56_7)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps10018 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_56_3 then
						if arg_53_1.isInRecall_ then
							iter_56_3.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10018 = nil
			end

			local var_56_8 = 0
			local var_56_9 = 1.325

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_10 = arg_53_1:GetWordFromCfg(114242013)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_12 = 53
				local var_56_13 = utf8.len(var_56_11)
				local var_56_14 = var_56_12 <= 0 and var_56_9 or var_56_9 * (var_56_13 / var_56_12)

				if var_56_14 > 0 and var_56_9 < var_56_14 then
					arg_53_1.talkMaxDuration = var_56_14

					if var_56_14 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_15 = math.max(var_56_9, arg_53_1.talkMaxDuration)

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_15 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_8) / var_56_15

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_8 + var_56_15 and arg_53_1.time_ < var_56_8 + var_56_15 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play114242014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 114242014
		arg_57_1.duration_ = 4.9

		local var_57_0 = {
			ja = 3.966,
			ko = 4.9,
			zh = 4,
			en = 2.866
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
				arg_57_0:Play114242015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10015"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10015 == nil then
				arg_57_1.var_.actorSpriteComps10015 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 0.034

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps10015 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10015 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10015 = nil
			end

			local var_60_8 = 0
			local var_60_9 = 0.325

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_10 = arg_57_1:FormatText(StoryNameCfg[208].name)

				arg_57_1.leftNameTxt_.text = var_60_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_11 = arg_57_1:GetWordFromCfg(114242014)
				local var_60_12 = arg_57_1:FormatText(var_60_11.content)

				arg_57_1.text_.text = var_60_12

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 13
				local var_60_14 = utf8.len(var_60_12)
				local var_60_15 = var_60_13 <= 0 and var_60_9 or var_60_9 * (var_60_14 / var_60_13)

				if var_60_15 > 0 and var_60_9 < var_60_15 then
					arg_57_1.talkMaxDuration = var_60_15

					if var_60_15 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_15 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_12
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242014", "story_v_out_114242.awb") ~= 0 then
					local var_60_16 = manager.audio:GetVoiceLength("story_v_out_114242", "114242014", "story_v_out_114242.awb") / 1000

					if var_60_16 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_16 + var_60_8
					end

					if var_60_11.prefab_name ~= "" and arg_57_1.actors_[var_60_11.prefab_name] ~= nil then
						local var_60_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_11.prefab_name].transform, "story_v_out_114242", "114242014", "story_v_out_114242.awb")

						arg_57_1:RecordAudio("114242014", var_60_17)
						arg_57_1:RecordAudio("114242014", var_60_17)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_114242", "114242014", "story_v_out_114242.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_114242", "114242014", "story_v_out_114242.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_18 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_18 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_18

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_18 and arg_57_1.time_ < var_60_8 + var_60_18 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play114242015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 114242015
		arg_61_1.duration_ = 12.07

		local var_61_0 = {
			ja = 9.533,
			ko = 12.066,
			zh = 11.866,
			en = 11.366
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
				arg_61_0:Play114242016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = "F01a"

			if arg_61_1.bgs_[var_64_0] == nil then
				local var_64_1 = Object.Instantiate(arg_61_1.paintGo_)

				var_64_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_64_0)
				var_64_1.name = var_64_0
				var_64_1.transform.parent = arg_61_1.stage_.transform
				var_64_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.bgs_[var_64_0] = var_64_1
			end

			local var_64_2 = 0

			if var_64_2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				local var_64_3 = manager.ui.mainCamera.transform.localPosition
				local var_64_4 = Vector3.New(0, 0, 10) + Vector3.New(var_64_3.x, var_64_3.y, 0)
				local var_64_5 = arg_61_1.bgs_.F01a

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
					if iter_64_0 ~= "F01a" then
						iter_64_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_64_16 = 0

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_17 = 2

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_17 then
				local var_64_18 = (arg_61_1.time_ - var_64_16) / var_64_17
				local var_64_19 = Color.New(1, 1, 1)

				var_64_19.a = Mathf.Lerp(1, 0, var_64_18)
				arg_61_1.mask_.color = var_64_19
			end

			if arg_61_1.time_ >= var_64_16 + var_64_17 and arg_61_1.time_ < var_64_16 + var_64_17 + arg_64_0 then
				local var_64_20 = Color.New(1, 1, 1)
				local var_64_21 = 0

				arg_61_1.mask_.enabled = false
				var_64_20.a = var_64_21
				arg_61_1.mask_.color = var_64_20
			end

			local var_64_22 = arg_61_1.actors_["10018"].transform
			local var_64_23 = 0

			if var_64_23 < arg_61_1.time_ and arg_61_1.time_ <= var_64_23 + arg_64_0 then
				arg_61_1.var_.moveOldPos10018 = var_64_22.localPosition
				var_64_22.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10018", 7)

				local var_64_24 = var_64_22.childCount

				for iter_64_2 = 0, var_64_24 - 1 do
					local var_64_25 = var_64_22:GetChild(iter_64_2)

					if var_64_25.name == "split_1" or not string.find(var_64_25.name, "split") then
						var_64_25.gameObject:SetActive(true)
					else
						var_64_25.gameObject:SetActive(false)
					end
				end
			end

			local var_64_26 = 0.001

			if var_64_23 <= arg_61_1.time_ and arg_61_1.time_ < var_64_23 + var_64_26 then
				local var_64_27 = (arg_61_1.time_ - var_64_23) / var_64_26
				local var_64_28 = Vector3.New(0, -2000, -180)

				var_64_22.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10018, var_64_28, var_64_27)
			end

			if arg_61_1.time_ >= var_64_23 + var_64_26 and arg_61_1.time_ < var_64_23 + var_64_26 + arg_64_0 then
				var_64_22.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_64_29 = arg_61_1.actors_["10015"].transform
			local var_64_30 = 0

			if var_64_30 < arg_61_1.time_ and arg_61_1.time_ <= var_64_30 + arg_64_0 then
				arg_61_1.var_.moveOldPos10015 = var_64_29.localPosition
				var_64_29.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10015", 7)

				local var_64_31 = var_64_29.childCount

				for iter_64_3 = 0, var_64_31 - 1 do
					local var_64_32 = var_64_29:GetChild(iter_64_3)

					if var_64_32.name == "split_1" or not string.find(var_64_32.name, "split") then
						var_64_32.gameObject:SetActive(true)
					else
						var_64_32.gameObject:SetActive(false)
					end
				end
			end

			local var_64_33 = 0.001

			if var_64_30 <= arg_61_1.time_ and arg_61_1.time_ < var_64_30 + var_64_33 then
				local var_64_34 = (arg_61_1.time_ - var_64_30) / var_64_33
				local var_64_35 = Vector3.New(0, -2000, 450)

				var_64_29.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10015, var_64_35, var_64_34)
			end

			if arg_61_1.time_ >= var_64_30 + var_64_33 and arg_61_1.time_ < var_64_30 + var_64_33 + arg_64_0 then
				var_64_29.localPosition = Vector3.New(0, -2000, 450)
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_36 = 2
			local var_64_37 = 1.175

			if var_64_36 < arg_61_1.time_ and arg_61_1.time_ <= var_64_36 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_38 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_38:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_39 = arg_61_1:FormatText(StoryNameCfg[258].name)

				arg_61_1.leftNameTxt_.text = var_64_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10018")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_40 = arg_61_1:GetWordFromCfg(114242015)
				local var_64_41 = arg_61_1:FormatText(var_64_40.content)

				arg_61_1.text_.text = var_64_41

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_42 = 46
				local var_64_43 = utf8.len(var_64_41)
				local var_64_44 = var_64_42 <= 0 and var_64_37 or var_64_37 * (var_64_43 / var_64_42)

				if var_64_44 > 0 and var_64_37 < var_64_44 then
					arg_61_1.talkMaxDuration = var_64_44
					var_64_36 = var_64_36 + 0.3

					if var_64_44 + var_64_36 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_44 + var_64_36
					end
				end

				arg_61_1.text_.text = var_64_41
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242015", "story_v_out_114242.awb") ~= 0 then
					local var_64_45 = manager.audio:GetVoiceLength("story_v_out_114242", "114242015", "story_v_out_114242.awb") / 1000

					if var_64_45 + var_64_36 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_45 + var_64_36
					end

					if var_64_40.prefab_name ~= "" and arg_61_1.actors_[var_64_40.prefab_name] ~= nil then
						local var_64_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_40.prefab_name].transform, "story_v_out_114242", "114242015", "story_v_out_114242.awb")

						arg_61_1:RecordAudio("114242015", var_64_46)
						arg_61_1:RecordAudio("114242015", var_64_46)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_114242", "114242015", "story_v_out_114242.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_114242", "114242015", "story_v_out_114242.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_47 = var_64_36 + 0.3
			local var_64_48 = math.max(var_64_37, arg_61_1.talkMaxDuration)

			if var_64_47 <= arg_61_1.time_ and arg_61_1.time_ < var_64_47 + var_64_48 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_47) / var_64_48

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_47 + var_64_48 and arg_61_1.time_ < var_64_47 + var_64_48 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10015",
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
	Play114242016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 114242016
		arg_67_1.duration_ = 1.57

		local var_67_0 = {
			ja = 1.4,
			ko = 0.999999999999,
			zh = 1.133,
			en = 1.566
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
				arg_67_0:Play114242017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.075

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[205].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_104201")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:GetWordFromCfg(114242016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242016", "story_v_out_114242.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_114242", "114242016", "story_v_out_114242.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_114242", "114242016", "story_v_out_114242.awb")

						arg_67_1:RecordAudio("114242016", var_70_9)
						arg_67_1:RecordAudio("114242016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_114242", "114242016", "story_v_out_114242.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_114242", "114242016", "story_v_out_114242.awb")
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
	Play114242017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 114242017
		arg_71_1.duration_ = 1.83

		local var_71_0 = {
			ja = 1.833,
			ko = 1.5,
			zh = 1.6,
			en = 1.133
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
				arg_71_0:Play114242018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 0.1

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[258].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10018")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_3 = arg_71_1:GetWordFromCfg(114242017)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242017", "story_v_out_114242.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_114242", "114242017", "story_v_out_114242.awb") / 1000

					if var_74_8 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_0
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_out_114242", "114242017", "story_v_out_114242.awb")

						arg_71_1:RecordAudio("114242017", var_74_9)
						arg_71_1:RecordAudio("114242017", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_114242", "114242017", "story_v_out_114242.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_114242", "114242017", "story_v_out_114242.awb")
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
	Play114242018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 114242018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play114242019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 1.025

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

				local var_78_2 = arg_75_1:GetWordFromCfg(114242018)
				local var_78_3 = arg_75_1:FormatText(var_78_2.content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 41
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
	Play114242019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 114242019
		arg_79_1.duration_ = 6.5

		local var_79_0 = {
			ja = 6.5,
			ko = 4.633,
			zh = 5.4,
			en = 3.533
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
				arg_79_0:Play114242020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["10018"].transform
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos10018 = var_82_0.localPosition
				var_82_0.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("10018", 2)

				local var_82_2 = var_82_0.childCount

				for iter_82_0 = 0, var_82_2 - 1 do
					local var_82_3 = var_82_0:GetChild(iter_82_0)

					if var_82_3.name == "split_1" or not string.find(var_82_3.name, "split") then
						var_82_3.gameObject:SetActive(true)
					else
						var_82_3.gameObject:SetActive(false)
					end
				end
			end

			local var_82_4 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_4 then
				local var_82_5 = (arg_79_1.time_ - var_82_1) / var_82_4
				local var_82_6 = Vector3.New(-390, -350, -180)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10018, var_82_6, var_82_5)
			end

			if arg_79_1.time_ >= var_82_1 + var_82_4 and arg_79_1.time_ < var_82_1 + var_82_4 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_82_7 = arg_79_1.actors_["10018"]
			local var_82_8 = 0

			if var_82_8 < arg_79_1.time_ and arg_79_1.time_ <= var_82_8 + arg_82_0 and not isNil(var_82_7) and arg_79_1.var_.actorSpriteComps10018 == nil then
				arg_79_1.var_.actorSpriteComps10018 = var_82_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_9 = 0.034

			if var_82_8 <= arg_79_1.time_ and arg_79_1.time_ < var_82_8 + var_82_9 and not isNil(var_82_7) then
				local var_82_10 = (arg_79_1.time_ - var_82_8) / var_82_9

				if arg_79_1.var_.actorSpriteComps10018 then
					for iter_82_1, iter_82_2 in pairs(arg_79_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_82_2 then
							if arg_79_1.isInRecall_ then
								local var_82_11 = Mathf.Lerp(iter_82_2.color.r, arg_79_1.hightColor1.r, var_82_10)
								local var_82_12 = Mathf.Lerp(iter_82_2.color.g, arg_79_1.hightColor1.g, var_82_10)
								local var_82_13 = Mathf.Lerp(iter_82_2.color.b, arg_79_1.hightColor1.b, var_82_10)

								iter_82_2.color = Color.New(var_82_11, var_82_12, var_82_13)
							else
								local var_82_14 = Mathf.Lerp(iter_82_2.color.r, 1, var_82_10)

								iter_82_2.color = Color.New(var_82_14, var_82_14, var_82_14)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= var_82_8 + var_82_9 and arg_79_1.time_ < var_82_8 + var_82_9 + arg_82_0 and not isNil(var_82_7) and arg_79_1.var_.actorSpriteComps10018 then
				for iter_82_3, iter_82_4 in pairs(arg_79_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_82_4 then
						if arg_79_1.isInRecall_ then
							iter_82_4.color = arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_82_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_79_1.var_.actorSpriteComps10018 = nil
			end

			local var_82_15 = arg_79_1.actors_["10018"]
			local var_82_16 = 0

			if var_82_16 < arg_79_1.time_ and arg_79_1.time_ <= var_82_16 + arg_82_0 then
				local var_82_17 = var_82_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_82_17 then
					arg_79_1.var_.alphaOldValue10018 = var_82_17.alpha
					arg_79_1.var_.characterEffect10018 = var_82_17
				end

				arg_79_1.var_.alphaOldValue10018 = 0
			end

			local var_82_18 = 0.5

			if var_82_16 <= arg_79_1.time_ and arg_79_1.time_ < var_82_16 + var_82_18 then
				local var_82_19 = (arg_79_1.time_ - var_82_16) / var_82_18
				local var_82_20 = Mathf.Lerp(arg_79_1.var_.alphaOldValue10018, 1, var_82_19)

				if arg_79_1.var_.characterEffect10018 then
					arg_79_1.var_.characterEffect10018.alpha = var_82_20
				end
			end

			if arg_79_1.time_ >= var_82_16 + var_82_18 and arg_79_1.time_ < var_82_16 + var_82_18 + arg_82_0 and arg_79_1.var_.characterEffect10018 then
				arg_79_1.var_.characterEffect10018.alpha = 1
			end

			local var_82_21 = 0
			local var_82_22 = 0.575

			if var_82_21 < arg_79_1.time_ and arg_79_1.time_ <= var_82_21 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_23 = arg_79_1:FormatText(StoryNameCfg[258].name)

				arg_79_1.leftNameTxt_.text = var_82_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_24 = arg_79_1:GetWordFromCfg(114242019)
				local var_82_25 = arg_79_1:FormatText(var_82_24.content)

				arg_79_1.text_.text = var_82_25

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_26 = 23
				local var_82_27 = utf8.len(var_82_25)
				local var_82_28 = var_82_26 <= 0 and var_82_22 or var_82_22 * (var_82_27 / var_82_26)

				if var_82_28 > 0 and var_82_22 < var_82_28 then
					arg_79_1.talkMaxDuration = var_82_28

					if var_82_28 + var_82_21 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_28 + var_82_21
					end
				end

				arg_79_1.text_.text = var_82_25
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242019", "story_v_out_114242.awb") ~= 0 then
					local var_82_29 = manager.audio:GetVoiceLength("story_v_out_114242", "114242019", "story_v_out_114242.awb") / 1000

					if var_82_29 + var_82_21 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_29 + var_82_21
					end

					if var_82_24.prefab_name ~= "" and arg_79_1.actors_[var_82_24.prefab_name] ~= nil then
						local var_82_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_24.prefab_name].transform, "story_v_out_114242", "114242019", "story_v_out_114242.awb")

						arg_79_1:RecordAudio("114242019", var_82_30)
						arg_79_1:RecordAudio("114242019", var_82_30)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_114242", "114242019", "story_v_out_114242.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_114242", "114242019", "story_v_out_114242.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_31 = math.max(var_82_22, arg_79_1.talkMaxDuration)

			if var_82_21 <= arg_79_1.time_ and arg_79_1.time_ < var_82_21 + var_82_31 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_21) / var_82_31

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_21 + var_82_31 and arg_79_1.time_ < var_82_21 + var_82_31 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
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
	Play114242020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 114242020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play114242021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["10018"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.actorSpriteComps10018 == nil then
				arg_83_1.var_.actorSpriteComps10018 = var_86_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_2 = 0.034

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.actorSpriteComps10018 then
					for iter_86_0, iter_86_1 in pairs(arg_83_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.actorSpriteComps10018 then
				for iter_86_2, iter_86_3 in pairs(arg_83_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_86_3 then
						if arg_83_1.isInRecall_ then
							iter_86_3.color = arg_83_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_86_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_83_1.var_.actorSpriteComps10018 = nil
			end

			local var_86_8 = 0
			local var_86_9 = 1.625

			if var_86_8 < arg_83_1.time_ and arg_83_1.time_ <= var_86_8 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_10 = arg_83_1:GetWordFromCfg(114242020)
				local var_86_11 = arg_83_1:FormatText(var_86_10.content)

				arg_83_1.text_.text = var_86_11

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_12 = 64
				local var_86_13 = utf8.len(var_86_11)
				local var_86_14 = var_86_12 <= 0 and var_86_9 or var_86_9 * (var_86_13 / var_86_12)

				if var_86_14 > 0 and var_86_9 < var_86_14 then
					arg_83_1.talkMaxDuration = var_86_14

					if var_86_14 + var_86_8 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_14 + var_86_8
					end
				end

				arg_83_1.text_.text = var_86_11
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_15 = math.max(var_86_9, arg_83_1.talkMaxDuration)

			if var_86_8 <= arg_83_1.time_ and arg_83_1.time_ < var_86_8 + var_86_15 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_8) / var_86_15

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_8 + var_86_15 and arg_83_1.time_ < var_86_8 + var_86_15 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play114242021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 114242021
		arg_87_1.duration_ = 16.77

		local var_87_0 = {
			ja = 7.866,
			ko = 10.266,
			zh = 16.766,
			en = 11.8
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play114242022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = "104201_1"

			if arg_87_1.actors_[var_90_0] == nil then
				local var_90_1 = Object.Instantiate(arg_87_1.imageGo_, arg_87_1.canvasGo_.transform)

				var_90_1.transform:SetSiblingIndex(1)

				var_90_1.name = var_90_0

				local var_90_2 = var_90_1:GetComponent(typeof(Image))

				var_90_2.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "104201_1")

				var_90_2:SetNativeSize()

				var_90_1.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_87_1.actors_[var_90_0] = var_90_1
			end

			local var_90_3 = arg_87_1.actors_["104201_1"].transform
			local var_90_4 = 0

			if var_90_4 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.var_.moveOldPos104201_1 = var_90_3.localPosition
				var_90_3.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("104201_1", 4)
			end

			local var_90_5 = 0.001

			if var_90_4 <= arg_87_1.time_ and arg_87_1.time_ < var_90_4 + var_90_5 then
				local var_90_6 = (arg_87_1.time_ - var_90_4) / var_90_5
				local var_90_7 = Vector3.New(390, -350, -180)

				var_90_3.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos104201_1, var_90_7, var_90_6)
			end

			if arg_87_1.time_ >= var_90_4 + var_90_5 and arg_87_1.time_ < var_90_4 + var_90_5 + arg_90_0 then
				var_90_3.localPosition = Vector3.New(390, -350, -180)
			end

			local var_90_8 = arg_87_1.actors_["104201_1"]
			local var_90_9 = 0

			if var_90_9 < arg_87_1.time_ and arg_87_1.time_ <= var_90_9 + arg_90_0 and not isNil(var_90_8) then
				local var_90_10 = var_90_8:GetComponent("Image")

				if var_90_10 then
					arg_87_1.var_.highlightMatValue104201_1 = var_90_10
				end
			end

			local var_90_11 = 0.034

			if var_90_9 <= arg_87_1.time_ and arg_87_1.time_ < var_90_9 + var_90_11 and not isNil(var_90_8) then
				local var_90_12 = (arg_87_1.time_ - var_90_9) / var_90_11

				if arg_87_1.var_.highlightMatValue104201_1 then
					local var_90_13 = Mathf.Lerp(0.5, 1, var_90_12)
					local var_90_14 = arg_87_1.var_.highlightMatValue104201_1
					local var_90_15 = var_90_14.color

					var_90_15.r = var_90_13
					var_90_15.g = var_90_13
					var_90_15.b = var_90_13
					var_90_14.color = var_90_15
				end
			end

			if arg_87_1.time_ >= var_90_9 + var_90_11 and arg_87_1.time_ < var_90_9 + var_90_11 + arg_90_0 and not isNil(var_90_8) and arg_87_1.var_.highlightMatValue104201_1 then
				local var_90_16 = 1

				var_90_8.transform:SetSiblingIndex(1)

				local var_90_17 = arg_87_1.var_.highlightMatValue104201_1
				local var_90_18 = var_90_17.color

				var_90_18.r = var_90_16
				var_90_18.g = var_90_16
				var_90_18.b = var_90_16
				var_90_17.color = var_90_18
			end

			local var_90_19 = "104201"

			if arg_87_1.actors_[var_90_19] == nil then
				local var_90_20 = Object.Instantiate(arg_87_1.imageGo_, arg_87_1.canvasGo_.transform)

				var_90_20.transform:SetSiblingIndex(1)

				var_90_20.name = var_90_19

				local var_90_21 = var_90_20:GetComponent(typeof(Image))

				var_90_21.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "104201")

				var_90_21:SetNativeSize()

				var_90_20.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_87_1.actors_[var_90_19] = var_90_20
			end

			local var_90_22 = arg_87_1.actors_["104201"]
			local var_90_23 = 0

			if var_90_23 < arg_87_1.time_ and arg_87_1.time_ <= var_90_23 + arg_90_0 then
				local var_90_24 = var_90_22:GetComponent("Image")

				if var_90_24 then
					arg_87_1.var_.alphaMatValue104201 = var_90_24
					arg_87_1.var_.alphaOldValue104201 = var_90_24.color.a
				end

				arg_87_1.var_.alphaOldValue104201 = 0
			end

			local var_90_25 = 0.5

			if var_90_23 <= arg_87_1.time_ and arg_87_1.time_ < var_90_23 + var_90_25 then
				local var_90_26 = (arg_87_1.time_ - var_90_23) / var_90_25
				local var_90_27 = Mathf.Lerp(arg_87_1.var_.alphaOldValue104201, 1, var_90_26)

				if arg_87_1.var_.alphaMatValue104201 then
					local var_90_28 = arg_87_1.var_.alphaMatValue104201.color

					var_90_28.a = var_90_27
					arg_87_1.var_.alphaMatValue104201.color = var_90_28
				end
			end

			if arg_87_1.time_ >= var_90_23 + var_90_25 and arg_87_1.time_ < var_90_23 + var_90_25 + arg_90_0 and arg_87_1.var_.alphaMatValue104201 then
				local var_90_29 = arg_87_1.var_.alphaMatValue104201
				local var_90_30 = var_90_29.color

				var_90_30.a = 1
				var_90_29.color = var_90_30
			end

			local var_90_31 = 0
			local var_90_32 = 1.775

			if var_90_31 < arg_87_1.time_ and arg_87_1.time_ <= var_90_31 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_33 = arg_87_1:FormatText(StoryNameCfg[205].name)

				arg_87_1.leftNameTxt_.text = var_90_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_34 = arg_87_1:GetWordFromCfg(114242021)
				local var_90_35 = arg_87_1:FormatText(var_90_34.content)

				arg_87_1.text_.text = var_90_35

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_36 = 70
				local var_90_37 = utf8.len(var_90_35)
				local var_90_38 = var_90_36 <= 0 and var_90_32 or var_90_32 * (var_90_37 / var_90_36)

				if var_90_38 > 0 and var_90_32 < var_90_38 then
					arg_87_1.talkMaxDuration = var_90_38

					if var_90_38 + var_90_31 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_38 + var_90_31
					end
				end

				arg_87_1.text_.text = var_90_35
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242021", "story_v_out_114242.awb") ~= 0 then
					local var_90_39 = manager.audio:GetVoiceLength("story_v_out_114242", "114242021", "story_v_out_114242.awb") / 1000

					if var_90_39 + var_90_31 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_39 + var_90_31
					end

					if var_90_34.prefab_name ~= "" and arg_87_1.actors_[var_90_34.prefab_name] ~= nil then
						local var_90_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_34.prefab_name].transform, "story_v_out_114242", "114242021", "story_v_out_114242.awb")

						arg_87_1:RecordAudio("114242021", var_90_40)
						arg_87_1:RecordAudio("114242021", var_90_40)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_114242", "114242021", "story_v_out_114242.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_114242", "114242021", "story_v_out_114242.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_41 = math.max(var_90_32, arg_87_1.talkMaxDuration)

			if var_90_31 <= arg_87_1.time_ and arg_87_1.time_ < var_90_31 + var_90_41 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_31) / var_90_41

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_31 + var_90_41 and arg_87_1.time_ < var_90_31 + var_90_41 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104201_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play114242022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 114242022
		arg_91_1.duration_ = 18.53

		local var_91_0 = {
			ja = 13.333,
			ko = 11.7,
			zh = 16.6,
			en = 18.533
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
				arg_91_0:Play114242023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["10018"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.actorSpriteComps10018 == nil then
				arg_91_1.var_.actorSpriteComps10018 = var_94_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_2 = 0.034

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.actorSpriteComps10018 then
					for iter_94_0, iter_94_1 in pairs(arg_91_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_94_1 then
							if arg_91_1.isInRecall_ then
								local var_94_4 = Mathf.Lerp(iter_94_1.color.r, arg_91_1.hightColor1.r, var_94_3)
								local var_94_5 = Mathf.Lerp(iter_94_1.color.g, arg_91_1.hightColor1.g, var_94_3)
								local var_94_6 = Mathf.Lerp(iter_94_1.color.b, arg_91_1.hightColor1.b, var_94_3)

								iter_94_1.color = Color.New(var_94_4, var_94_5, var_94_6)
							else
								local var_94_7 = Mathf.Lerp(iter_94_1.color.r, 1, var_94_3)

								iter_94_1.color = Color.New(var_94_7, var_94_7, var_94_7)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.actorSpriteComps10018 then
				for iter_94_2, iter_94_3 in pairs(arg_91_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_94_3 then
						if arg_91_1.isInRecall_ then
							iter_94_3.color = arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_94_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps10018 = nil
			end

			local var_94_8 = arg_91_1.actors_["104201_1"]
			local var_94_9 = 0

			if var_94_9 < arg_91_1.time_ and arg_91_1.time_ <= var_94_9 + arg_94_0 and not isNil(var_94_8) then
				local var_94_10 = var_94_8:GetComponent("Image")

				if var_94_10 then
					arg_91_1.var_.highlightMatValue104201_1 = var_94_10
				end
			end

			local var_94_11 = 0.034

			if var_94_9 <= arg_91_1.time_ and arg_91_1.time_ < var_94_9 + var_94_11 and not isNil(var_94_8) then
				local var_94_12 = (arg_91_1.time_ - var_94_9) / var_94_11

				if arg_91_1.var_.highlightMatValue104201_1 then
					local var_94_13 = Mathf.Lerp(1, 0.5, var_94_12)
					local var_94_14 = arg_91_1.var_.highlightMatValue104201_1
					local var_94_15 = var_94_14.color

					var_94_15.r = var_94_13
					var_94_15.g = var_94_13
					var_94_15.b = var_94_13
					var_94_14.color = var_94_15
				end
			end

			if arg_91_1.time_ >= var_94_9 + var_94_11 and arg_91_1.time_ < var_94_9 + var_94_11 + arg_94_0 and not isNil(var_94_8) and arg_91_1.var_.highlightMatValue104201_1 then
				local var_94_16 = 0.5
				local var_94_17 = arg_91_1.var_.highlightMatValue104201_1
				local var_94_18 = var_94_17.color

				var_94_18.r = var_94_16
				var_94_18.g = var_94_16
				var_94_18.b = var_94_16
				var_94_17.color = var_94_18
			end

			local var_94_19 = 0
			local var_94_20 = 2.05

			if var_94_19 < arg_91_1.time_ and arg_91_1.time_ <= var_94_19 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_21 = arg_91_1:FormatText(StoryNameCfg[258].name)

				arg_91_1.leftNameTxt_.text = var_94_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_22 = arg_91_1:GetWordFromCfg(114242022)
				local var_94_23 = arg_91_1:FormatText(var_94_22.content)

				arg_91_1.text_.text = var_94_23

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_24 = 79
				local var_94_25 = utf8.len(var_94_23)
				local var_94_26 = var_94_24 <= 0 and var_94_20 or var_94_20 * (var_94_25 / var_94_24)

				if var_94_26 > 0 and var_94_20 < var_94_26 then
					arg_91_1.talkMaxDuration = var_94_26

					if var_94_26 + var_94_19 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_26 + var_94_19
					end
				end

				arg_91_1.text_.text = var_94_23
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242022", "story_v_out_114242.awb") ~= 0 then
					local var_94_27 = manager.audio:GetVoiceLength("story_v_out_114242", "114242022", "story_v_out_114242.awb") / 1000

					if var_94_27 + var_94_19 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_27 + var_94_19
					end

					if var_94_22.prefab_name ~= "" and arg_91_1.actors_[var_94_22.prefab_name] ~= nil then
						local var_94_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_22.prefab_name].transform, "story_v_out_114242", "114242022", "story_v_out_114242.awb")

						arg_91_1:RecordAudio("114242022", var_94_28)
						arg_91_1:RecordAudio("114242022", var_94_28)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_114242", "114242022", "story_v_out_114242.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_114242", "114242022", "story_v_out_114242.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_29 = math.max(var_94_20, arg_91_1.talkMaxDuration)

			if var_94_19 <= arg_91_1.time_ and arg_91_1.time_ < var_94_19 + var_94_29 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_19) / var_94_29

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_19 + var_94_29 and arg_91_1.time_ < var_94_19 + var_94_29 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play114242023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 114242023
		arg_95_1.duration_ = 13.7

		local var_95_0 = {
			ja = 13.7,
			ko = 7.6,
			zh = 9.266,
			en = 10.633
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
				arg_95_0:Play114242024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["10018"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.actorSpriteComps10018 == nil then
				arg_95_1.var_.actorSpriteComps10018 = var_98_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_2 = 0.034

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.actorSpriteComps10018 then
					for iter_98_0, iter_98_1 in pairs(arg_95_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_98_1 then
							if arg_95_1.isInRecall_ then
								local var_98_4 = Mathf.Lerp(iter_98_1.color.r, arg_95_1.hightColor2.r, var_98_3)
								local var_98_5 = Mathf.Lerp(iter_98_1.color.g, arg_95_1.hightColor2.g, var_98_3)
								local var_98_6 = Mathf.Lerp(iter_98_1.color.b, arg_95_1.hightColor2.b, var_98_3)

								iter_98_1.color = Color.New(var_98_4, var_98_5, var_98_6)
							else
								local var_98_7 = Mathf.Lerp(iter_98_1.color.r, 0.5, var_98_3)

								iter_98_1.color = Color.New(var_98_7, var_98_7, var_98_7)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.actorSpriteComps10018 then
				for iter_98_2, iter_98_3 in pairs(arg_95_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_98_3 then
						if arg_95_1.isInRecall_ then
							iter_98_3.color = arg_95_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_98_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_95_1.var_.actorSpriteComps10018 = nil
			end

			local var_98_8 = arg_95_1.actors_["104201_1"]
			local var_98_9 = 0

			if var_98_9 < arg_95_1.time_ and arg_95_1.time_ <= var_98_9 + arg_98_0 and not isNil(var_98_8) then
				local var_98_10 = var_98_8:GetComponent("Image")

				if var_98_10 then
					arg_95_1.var_.highlightMatValue104201_1 = var_98_10
				end
			end

			local var_98_11 = 0.034

			if var_98_9 <= arg_95_1.time_ and arg_95_1.time_ < var_98_9 + var_98_11 and not isNil(var_98_8) then
				local var_98_12 = (arg_95_1.time_ - var_98_9) / var_98_11

				if arg_95_1.var_.highlightMatValue104201_1 then
					local var_98_13 = Mathf.Lerp(0.5, 1, var_98_12)
					local var_98_14 = arg_95_1.var_.highlightMatValue104201_1
					local var_98_15 = var_98_14.color

					var_98_15.r = var_98_13
					var_98_15.g = var_98_13
					var_98_15.b = var_98_13
					var_98_14.color = var_98_15
				end
			end

			if arg_95_1.time_ >= var_98_9 + var_98_11 and arg_95_1.time_ < var_98_9 + var_98_11 + arg_98_0 and not isNil(var_98_8) and arg_95_1.var_.highlightMatValue104201_1 then
				local var_98_16 = 1

				var_98_8.transform:SetSiblingIndex(1)

				local var_98_17 = arg_95_1.var_.highlightMatValue104201_1
				local var_98_18 = var_98_17.color

				var_98_18.r = var_98_16
				var_98_18.g = var_98_16
				var_98_18.b = var_98_16
				var_98_17.color = var_98_18
			end

			local var_98_19 = 0
			local var_98_20 = 0.825

			if var_98_19 < arg_95_1.time_ and arg_95_1.time_ <= var_98_19 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_21 = arg_95_1:FormatText(StoryNameCfg[205].name)

				arg_95_1.leftNameTxt_.text = var_98_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_22 = arg_95_1:GetWordFromCfg(114242023)
				local var_98_23 = arg_95_1:FormatText(var_98_22.content)

				arg_95_1.text_.text = var_98_23

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_24 = 33
				local var_98_25 = utf8.len(var_98_23)
				local var_98_26 = var_98_24 <= 0 and var_98_20 or var_98_20 * (var_98_25 / var_98_24)

				if var_98_26 > 0 and var_98_20 < var_98_26 then
					arg_95_1.talkMaxDuration = var_98_26

					if var_98_26 + var_98_19 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_26 + var_98_19
					end
				end

				arg_95_1.text_.text = var_98_23
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242023", "story_v_out_114242.awb") ~= 0 then
					local var_98_27 = manager.audio:GetVoiceLength("story_v_out_114242", "114242023", "story_v_out_114242.awb") / 1000

					if var_98_27 + var_98_19 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_27 + var_98_19
					end

					if var_98_22.prefab_name ~= "" and arg_95_1.actors_[var_98_22.prefab_name] ~= nil then
						local var_98_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_22.prefab_name].transform, "story_v_out_114242", "114242023", "story_v_out_114242.awb")

						arg_95_1:RecordAudio("114242023", var_98_28)
						arg_95_1:RecordAudio("114242023", var_98_28)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_114242", "114242023", "story_v_out_114242.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_114242", "114242023", "story_v_out_114242.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_29 = math.max(var_98_20, arg_95_1.talkMaxDuration)

			if var_98_19 <= arg_95_1.time_ and arg_95_1.time_ < var_98_19 + var_98_29 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_19) / var_98_29

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_19 + var_98_29 and arg_95_1.time_ < var_98_19 + var_98_29 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play114242024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 114242024
		arg_99_1.duration_ = 10.03

		local var_99_0 = {
			ja = 10.033,
			ko = 7.566,
			zh = 9.066,
			en = 8.333
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play114242025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["10018"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.actorSpriteComps10018 == nil then
				arg_99_1.var_.actorSpriteComps10018 = var_102_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_2 = 0.034

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.actorSpriteComps10018 then
					for iter_102_0, iter_102_1 in pairs(arg_99_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_102_1 then
							if arg_99_1.isInRecall_ then
								local var_102_4 = Mathf.Lerp(iter_102_1.color.r, arg_99_1.hightColor1.r, var_102_3)
								local var_102_5 = Mathf.Lerp(iter_102_1.color.g, arg_99_1.hightColor1.g, var_102_3)
								local var_102_6 = Mathf.Lerp(iter_102_1.color.b, arg_99_1.hightColor1.b, var_102_3)

								iter_102_1.color = Color.New(var_102_4, var_102_5, var_102_6)
							else
								local var_102_7 = Mathf.Lerp(iter_102_1.color.r, 1, var_102_3)

								iter_102_1.color = Color.New(var_102_7, var_102_7, var_102_7)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.actorSpriteComps10018 then
				for iter_102_2, iter_102_3 in pairs(arg_99_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_102_3 then
						if arg_99_1.isInRecall_ then
							iter_102_3.color = arg_99_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_102_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_99_1.var_.actorSpriteComps10018 = nil
			end

			local var_102_8 = arg_99_1.actors_["104201_1"]
			local var_102_9 = 0

			if var_102_9 < arg_99_1.time_ and arg_99_1.time_ <= var_102_9 + arg_102_0 and not isNil(var_102_8) then
				local var_102_10 = var_102_8:GetComponent("Image")

				if var_102_10 then
					arg_99_1.var_.highlightMatValue104201_1 = var_102_10
				end
			end

			local var_102_11 = 0.034

			if var_102_9 <= arg_99_1.time_ and arg_99_1.time_ < var_102_9 + var_102_11 and not isNil(var_102_8) then
				local var_102_12 = (arg_99_1.time_ - var_102_9) / var_102_11

				if arg_99_1.var_.highlightMatValue104201_1 then
					local var_102_13 = Mathf.Lerp(1, 0.5, var_102_12)
					local var_102_14 = arg_99_1.var_.highlightMatValue104201_1
					local var_102_15 = var_102_14.color

					var_102_15.r = var_102_13
					var_102_15.g = var_102_13
					var_102_15.b = var_102_13
					var_102_14.color = var_102_15
				end
			end

			if arg_99_1.time_ >= var_102_9 + var_102_11 and arg_99_1.time_ < var_102_9 + var_102_11 + arg_102_0 and not isNil(var_102_8) and arg_99_1.var_.highlightMatValue104201_1 then
				local var_102_16 = 0.5
				local var_102_17 = arg_99_1.var_.highlightMatValue104201_1
				local var_102_18 = var_102_17.color

				var_102_18.r = var_102_16
				var_102_18.g = var_102_16
				var_102_18.b = var_102_16
				var_102_17.color = var_102_18
			end

			local var_102_19 = 0
			local var_102_20 = 0.875

			if var_102_19 < arg_99_1.time_ and arg_99_1.time_ <= var_102_19 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_21 = arg_99_1:FormatText(StoryNameCfg[258].name)

				arg_99_1.leftNameTxt_.text = var_102_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_22 = arg_99_1:GetWordFromCfg(114242024)
				local var_102_23 = arg_99_1:FormatText(var_102_22.content)

				arg_99_1.text_.text = var_102_23

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_24 = 35
				local var_102_25 = utf8.len(var_102_23)
				local var_102_26 = var_102_24 <= 0 and var_102_20 or var_102_20 * (var_102_25 / var_102_24)

				if var_102_26 > 0 and var_102_20 < var_102_26 then
					arg_99_1.talkMaxDuration = var_102_26

					if var_102_26 + var_102_19 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_26 + var_102_19
					end
				end

				arg_99_1.text_.text = var_102_23
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242024", "story_v_out_114242.awb") ~= 0 then
					local var_102_27 = manager.audio:GetVoiceLength("story_v_out_114242", "114242024", "story_v_out_114242.awb") / 1000

					if var_102_27 + var_102_19 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_27 + var_102_19
					end

					if var_102_22.prefab_name ~= "" and arg_99_1.actors_[var_102_22.prefab_name] ~= nil then
						local var_102_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_22.prefab_name].transform, "story_v_out_114242", "114242024", "story_v_out_114242.awb")

						arg_99_1:RecordAudio("114242024", var_102_28)
						arg_99_1:RecordAudio("114242024", var_102_28)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_114242", "114242024", "story_v_out_114242.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_114242", "114242024", "story_v_out_114242.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_29 = math.max(var_102_20, arg_99_1.talkMaxDuration)

			if var_102_19 <= arg_99_1.time_ and arg_99_1.time_ < var_102_19 + var_102_29 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_19) / var_102_29

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_19 + var_102_29 and arg_99_1.time_ < var_102_19 + var_102_29 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play114242025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 114242025
		arg_103_1.duration_ = 10.67

		local var_103_0 = {
			ja = 10.666,
			ko = 6.8,
			zh = 9.7,
			en = 8.4
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
				arg_103_0:Play114242026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["10018"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.actorSpriteComps10018 == nil then
				arg_103_1.var_.actorSpriteComps10018 = var_106_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_2 = 0.034

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.actorSpriteComps10018 then
					for iter_106_0, iter_106_1 in pairs(arg_103_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.actorSpriteComps10018 then
				for iter_106_2, iter_106_3 in pairs(arg_103_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_106_3 then
						if arg_103_1.isInRecall_ then
							iter_106_3.color = arg_103_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_106_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_103_1.var_.actorSpriteComps10018 = nil
			end

			local var_106_8 = arg_103_1.actors_["104201_1"]
			local var_106_9 = 0

			if var_106_9 < arg_103_1.time_ and arg_103_1.time_ <= var_106_9 + arg_106_0 and not isNil(var_106_8) then
				local var_106_10 = var_106_8:GetComponent("Image")

				if var_106_10 then
					arg_103_1.var_.highlightMatValue104201_1 = var_106_10
				end
			end

			local var_106_11 = 0.034

			if var_106_9 <= arg_103_1.time_ and arg_103_1.time_ < var_106_9 + var_106_11 and not isNil(var_106_8) then
				local var_106_12 = (arg_103_1.time_ - var_106_9) / var_106_11

				if arg_103_1.var_.highlightMatValue104201_1 then
					local var_106_13 = Mathf.Lerp(0.5, 1, var_106_12)
					local var_106_14 = arg_103_1.var_.highlightMatValue104201_1
					local var_106_15 = var_106_14.color

					var_106_15.r = var_106_13
					var_106_15.g = var_106_13
					var_106_15.b = var_106_13
					var_106_14.color = var_106_15
				end
			end

			if arg_103_1.time_ >= var_106_9 + var_106_11 and arg_103_1.time_ < var_106_9 + var_106_11 + arg_106_0 and not isNil(var_106_8) and arg_103_1.var_.highlightMatValue104201_1 then
				local var_106_16 = 1

				var_106_8.transform:SetSiblingIndex(1)

				local var_106_17 = arg_103_1.var_.highlightMatValue104201_1
				local var_106_18 = var_106_17.color

				var_106_18.r = var_106_16
				var_106_18.g = var_106_16
				var_106_18.b = var_106_16
				var_106_17.color = var_106_18
			end

			local var_106_19 = 0
			local var_106_20 = 0.875

			if var_106_19 < arg_103_1.time_ and arg_103_1.time_ <= var_106_19 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_21 = arg_103_1:FormatText(StoryNameCfg[205].name)

				arg_103_1.leftNameTxt_.text = var_106_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_22 = arg_103_1:GetWordFromCfg(114242025)
				local var_106_23 = arg_103_1:FormatText(var_106_22.content)

				arg_103_1.text_.text = var_106_23

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_24 = 35
				local var_106_25 = utf8.len(var_106_23)
				local var_106_26 = var_106_24 <= 0 and var_106_20 or var_106_20 * (var_106_25 / var_106_24)

				if var_106_26 > 0 and var_106_20 < var_106_26 then
					arg_103_1.talkMaxDuration = var_106_26

					if var_106_26 + var_106_19 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_26 + var_106_19
					end
				end

				arg_103_1.text_.text = var_106_23
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242025", "story_v_out_114242.awb") ~= 0 then
					local var_106_27 = manager.audio:GetVoiceLength("story_v_out_114242", "114242025", "story_v_out_114242.awb") / 1000

					if var_106_27 + var_106_19 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_27 + var_106_19
					end

					if var_106_22.prefab_name ~= "" and arg_103_1.actors_[var_106_22.prefab_name] ~= nil then
						local var_106_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_22.prefab_name].transform, "story_v_out_114242", "114242025", "story_v_out_114242.awb")

						arg_103_1:RecordAudio("114242025", var_106_28)
						arg_103_1:RecordAudio("114242025", var_106_28)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_114242", "114242025", "story_v_out_114242.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_114242", "114242025", "story_v_out_114242.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_29 = math.max(var_106_20, arg_103_1.talkMaxDuration)

			if var_106_19 <= arg_103_1.time_ and arg_103_1.time_ < var_106_19 + var_106_29 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_19) / var_106_29

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_19 + var_106_29 and arg_103_1.time_ < var_106_19 + var_106_29 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play114242026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 114242026
		arg_107_1.duration_ = 4.23

		local var_107_0 = {
			ja = 3.5,
			ko = 3.733,
			zh = 4.233,
			en = 4.133
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
				arg_107_0:Play114242027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10018"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps10018 == nil then
				arg_107_1.var_.actorSpriteComps10018 = var_110_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_2 = 0.034

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.actorSpriteComps10018 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps10018 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_110_3 then
						if arg_107_1.isInRecall_ then
							iter_110_3.color = arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_110_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps10018 = nil
			end

			local var_110_8 = arg_107_1.actors_["104201_1"]
			local var_110_9 = 0

			if var_110_9 < arg_107_1.time_ and arg_107_1.time_ <= var_110_9 + arg_110_0 and not isNil(var_110_8) then
				local var_110_10 = var_110_8:GetComponent("Image")

				if var_110_10 then
					arg_107_1.var_.highlightMatValue104201_1 = var_110_10
				end
			end

			local var_110_11 = 0.034

			if var_110_9 <= arg_107_1.time_ and arg_107_1.time_ < var_110_9 + var_110_11 and not isNil(var_110_8) then
				local var_110_12 = (arg_107_1.time_ - var_110_9) / var_110_11

				if arg_107_1.var_.highlightMatValue104201_1 then
					local var_110_13 = Mathf.Lerp(1, 0.5, var_110_12)
					local var_110_14 = arg_107_1.var_.highlightMatValue104201_1
					local var_110_15 = var_110_14.color

					var_110_15.r = var_110_13
					var_110_15.g = var_110_13
					var_110_15.b = var_110_13
					var_110_14.color = var_110_15
				end
			end

			if arg_107_1.time_ >= var_110_9 + var_110_11 and arg_107_1.time_ < var_110_9 + var_110_11 + arg_110_0 and not isNil(var_110_8) and arg_107_1.var_.highlightMatValue104201_1 then
				local var_110_16 = 0.5
				local var_110_17 = arg_107_1.var_.highlightMatValue104201_1
				local var_110_18 = var_110_17.color

				var_110_18.r = var_110_16
				var_110_18.g = var_110_16
				var_110_18.b = var_110_16
				var_110_17.color = var_110_18
			end

			local var_110_19 = 0
			local var_110_20 = 0.45

			if var_110_19 < arg_107_1.time_ and arg_107_1.time_ <= var_110_19 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_21 = arg_107_1:FormatText(StoryNameCfg[258].name)

				arg_107_1.leftNameTxt_.text = var_110_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_22 = arg_107_1:GetWordFromCfg(114242026)
				local var_110_23 = arg_107_1:FormatText(var_110_22.content)

				arg_107_1.text_.text = var_110_23

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_24 = 18
				local var_110_25 = utf8.len(var_110_23)
				local var_110_26 = var_110_24 <= 0 and var_110_20 or var_110_20 * (var_110_25 / var_110_24)

				if var_110_26 > 0 and var_110_20 < var_110_26 then
					arg_107_1.talkMaxDuration = var_110_26

					if var_110_26 + var_110_19 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_26 + var_110_19
					end
				end

				arg_107_1.text_.text = var_110_23
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242026", "story_v_out_114242.awb") ~= 0 then
					local var_110_27 = manager.audio:GetVoiceLength("story_v_out_114242", "114242026", "story_v_out_114242.awb") / 1000

					if var_110_27 + var_110_19 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_27 + var_110_19
					end

					if var_110_22.prefab_name ~= "" and arg_107_1.actors_[var_110_22.prefab_name] ~= nil then
						local var_110_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_22.prefab_name].transform, "story_v_out_114242", "114242026", "story_v_out_114242.awb")

						arg_107_1:RecordAudio("114242026", var_110_28)
						arg_107_1:RecordAudio("114242026", var_110_28)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_114242", "114242026", "story_v_out_114242.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_114242", "114242026", "story_v_out_114242.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_29 = math.max(var_110_20, arg_107_1.talkMaxDuration)

			if var_110_19 <= arg_107_1.time_ and arg_107_1.time_ < var_110_19 + var_110_29 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_19) / var_110_29

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_19 + var_110_29 and arg_107_1.time_ < var_110_19 + var_110_29 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play114242027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 114242027
		arg_111_1.duration_ = 15.9

		local var_111_0 = {
			ja = 15.9,
			ko = 11.9,
			zh = 11.2,
			en = 15.2
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
				arg_111_0:Play114242028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["10018"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.actorSpriteComps10018 == nil then
				arg_111_1.var_.actorSpriteComps10018 = var_114_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_2 = 0.034

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.actorSpriteComps10018 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_114_1 then
							if arg_111_1.isInRecall_ then
								local var_114_4 = Mathf.Lerp(iter_114_1.color.r, arg_111_1.hightColor2.r, var_114_3)
								local var_114_5 = Mathf.Lerp(iter_114_1.color.g, arg_111_1.hightColor2.g, var_114_3)
								local var_114_6 = Mathf.Lerp(iter_114_1.color.b, arg_111_1.hightColor2.b, var_114_3)

								iter_114_1.color = Color.New(var_114_4, var_114_5, var_114_6)
							else
								local var_114_7 = Mathf.Lerp(iter_114_1.color.r, 0.5, var_114_3)

								iter_114_1.color = Color.New(var_114_7, var_114_7, var_114_7)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.actorSpriteComps10018 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_114_3 then
						if arg_111_1.isInRecall_ then
							iter_114_3.color = arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_114_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps10018 = nil
			end

			local var_114_8 = arg_111_1.actors_["104201_1"]
			local var_114_9 = 0

			if var_114_9 < arg_111_1.time_ and arg_111_1.time_ <= var_114_9 + arg_114_0 and not isNil(var_114_8) then
				local var_114_10 = var_114_8:GetComponent("Image")

				if var_114_10 then
					arg_111_1.var_.highlightMatValue104201_1 = var_114_10
				end
			end

			local var_114_11 = 0.034

			if var_114_9 <= arg_111_1.time_ and arg_111_1.time_ < var_114_9 + var_114_11 and not isNil(var_114_8) then
				local var_114_12 = (arg_111_1.time_ - var_114_9) / var_114_11

				if arg_111_1.var_.highlightMatValue104201_1 then
					local var_114_13 = Mathf.Lerp(0.5, 1, var_114_12)
					local var_114_14 = arg_111_1.var_.highlightMatValue104201_1
					local var_114_15 = var_114_14.color

					var_114_15.r = var_114_13
					var_114_15.g = var_114_13
					var_114_15.b = var_114_13
					var_114_14.color = var_114_15
				end
			end

			if arg_111_1.time_ >= var_114_9 + var_114_11 and arg_111_1.time_ < var_114_9 + var_114_11 + arg_114_0 and not isNil(var_114_8) and arg_111_1.var_.highlightMatValue104201_1 then
				local var_114_16 = 1

				var_114_8.transform:SetSiblingIndex(1)

				local var_114_17 = arg_111_1.var_.highlightMatValue104201_1
				local var_114_18 = var_114_17.color

				var_114_18.r = var_114_16
				var_114_18.g = var_114_16
				var_114_18.b = var_114_16
				var_114_17.color = var_114_18
			end

			local var_114_19 = 0
			local var_114_20 = 1.25

			if var_114_19 < arg_111_1.time_ and arg_111_1.time_ <= var_114_19 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_21 = arg_111_1:FormatText(StoryNameCfg[205].name)

				arg_111_1.leftNameTxt_.text = var_114_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_22 = arg_111_1:GetWordFromCfg(114242027)
				local var_114_23 = arg_111_1:FormatText(var_114_22.content)

				arg_111_1.text_.text = var_114_23

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_24 = 50
				local var_114_25 = utf8.len(var_114_23)
				local var_114_26 = var_114_24 <= 0 and var_114_20 or var_114_20 * (var_114_25 / var_114_24)

				if var_114_26 > 0 and var_114_20 < var_114_26 then
					arg_111_1.talkMaxDuration = var_114_26

					if var_114_26 + var_114_19 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_26 + var_114_19
					end
				end

				arg_111_1.text_.text = var_114_23
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242027", "story_v_out_114242.awb") ~= 0 then
					local var_114_27 = manager.audio:GetVoiceLength("story_v_out_114242", "114242027", "story_v_out_114242.awb") / 1000

					if var_114_27 + var_114_19 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_27 + var_114_19
					end

					if var_114_22.prefab_name ~= "" and arg_111_1.actors_[var_114_22.prefab_name] ~= nil then
						local var_114_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_22.prefab_name].transform, "story_v_out_114242", "114242027", "story_v_out_114242.awb")

						arg_111_1:RecordAudio("114242027", var_114_28)
						arg_111_1:RecordAudio("114242027", var_114_28)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_114242", "114242027", "story_v_out_114242.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_114242", "114242027", "story_v_out_114242.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_29 = math.max(var_114_20, arg_111_1.talkMaxDuration)

			if var_114_19 <= arg_111_1.time_ and arg_111_1.time_ < var_114_19 + var_114_29 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_19) / var_114_29

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_19 + var_114_29 and arg_111_1.time_ < var_114_19 + var_114_29 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play114242028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 114242028
		arg_115_1.duration_ = 5.87

		local var_115_0 = {
			ja = 3.766,
			ko = 5.866,
			zh = 5.5,
			en = 4.033
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
				arg_115_0:Play114242029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["10018"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.actorSpriteComps10018 == nil then
				arg_115_1.var_.actorSpriteComps10018 = var_118_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_2 = 0.034

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.actorSpriteComps10018 then
					for iter_118_0, iter_118_1 in pairs(arg_115_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_118_1 then
							if arg_115_1.isInRecall_ then
								local var_118_4 = Mathf.Lerp(iter_118_1.color.r, arg_115_1.hightColor1.r, var_118_3)
								local var_118_5 = Mathf.Lerp(iter_118_1.color.g, arg_115_1.hightColor1.g, var_118_3)
								local var_118_6 = Mathf.Lerp(iter_118_1.color.b, arg_115_1.hightColor1.b, var_118_3)

								iter_118_1.color = Color.New(var_118_4, var_118_5, var_118_6)
							else
								local var_118_7 = Mathf.Lerp(iter_118_1.color.r, 1, var_118_3)

								iter_118_1.color = Color.New(var_118_7, var_118_7, var_118_7)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.actorSpriteComps10018 then
				for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_118_3 then
						if arg_115_1.isInRecall_ then
							iter_118_3.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_118_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps10018 = nil
			end

			local var_118_8 = arg_115_1.actors_["104201_1"]
			local var_118_9 = 0

			if var_118_9 < arg_115_1.time_ and arg_115_1.time_ <= var_118_9 + arg_118_0 and not isNil(var_118_8) then
				local var_118_10 = var_118_8:GetComponent("Image")

				if var_118_10 then
					arg_115_1.var_.highlightMatValue104201_1 = var_118_10
				end
			end

			local var_118_11 = 0.034

			if var_118_9 <= arg_115_1.time_ and arg_115_1.time_ < var_118_9 + var_118_11 and not isNil(var_118_8) then
				local var_118_12 = (arg_115_1.time_ - var_118_9) / var_118_11

				if arg_115_1.var_.highlightMatValue104201_1 then
					local var_118_13 = Mathf.Lerp(1, 0.5, var_118_12)
					local var_118_14 = arg_115_1.var_.highlightMatValue104201_1
					local var_118_15 = var_118_14.color

					var_118_15.r = var_118_13
					var_118_15.g = var_118_13
					var_118_15.b = var_118_13
					var_118_14.color = var_118_15
				end
			end

			if arg_115_1.time_ >= var_118_9 + var_118_11 and arg_115_1.time_ < var_118_9 + var_118_11 + arg_118_0 and not isNil(var_118_8) and arg_115_1.var_.highlightMatValue104201_1 then
				local var_118_16 = 0.5
				local var_118_17 = arg_115_1.var_.highlightMatValue104201_1
				local var_118_18 = var_118_17.color

				var_118_18.r = var_118_16
				var_118_18.g = var_118_16
				var_118_18.b = var_118_16
				var_118_17.color = var_118_18
			end

			local var_118_19 = 0
			local var_118_20 = 0.525

			if var_118_19 < arg_115_1.time_ and arg_115_1.time_ <= var_118_19 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_21 = arg_115_1:FormatText(StoryNameCfg[258].name)

				arg_115_1.leftNameTxt_.text = var_118_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_22 = arg_115_1:GetWordFromCfg(114242028)
				local var_118_23 = arg_115_1:FormatText(var_118_22.content)

				arg_115_1.text_.text = var_118_23

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_24 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242028", "story_v_out_114242.awb") ~= 0 then
					local var_118_27 = manager.audio:GetVoiceLength("story_v_out_114242", "114242028", "story_v_out_114242.awb") / 1000

					if var_118_27 + var_118_19 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_27 + var_118_19
					end

					if var_118_22.prefab_name ~= "" and arg_115_1.actors_[var_118_22.prefab_name] ~= nil then
						local var_118_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_22.prefab_name].transform, "story_v_out_114242", "114242028", "story_v_out_114242.awb")

						arg_115_1:RecordAudio("114242028", var_118_28)
						arg_115_1:RecordAudio("114242028", var_118_28)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_114242", "114242028", "story_v_out_114242.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_114242", "114242028", "story_v_out_114242.awb")
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

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play114242029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 114242029
		arg_119_1.duration_ = 14.83

		local var_119_0 = {
			ja = 14.833,
			ko = 10.9,
			zh = 13.766,
			en = 13.9
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
				arg_119_0:Play114242030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10018"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.actorSpriteComps10018 == nil then
				arg_119_1.var_.actorSpriteComps10018 = var_122_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_2 = 0.034

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.actorSpriteComps10018 then
					for iter_122_0, iter_122_1 in pairs(arg_119_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_122_1 then
							if arg_119_1.isInRecall_ then
								local var_122_4 = Mathf.Lerp(iter_122_1.color.r, arg_119_1.hightColor1.r, var_122_3)
								local var_122_5 = Mathf.Lerp(iter_122_1.color.g, arg_119_1.hightColor1.g, var_122_3)
								local var_122_6 = Mathf.Lerp(iter_122_1.color.b, arg_119_1.hightColor1.b, var_122_3)

								iter_122_1.color = Color.New(var_122_4, var_122_5, var_122_6)
							else
								local var_122_7 = Mathf.Lerp(iter_122_1.color.r, 1, var_122_3)

								iter_122_1.color = Color.New(var_122_7, var_122_7, var_122_7)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.actorSpriteComps10018 then
				for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_122_3 then
						if arg_119_1.isInRecall_ then
							iter_122_3.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_122_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps10018 = nil
			end

			local var_122_8 = 0
			local var_122_9 = 1.325

			if var_122_8 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_10 = arg_119_1:FormatText(StoryNameCfg[258].name)

				arg_119_1.leftNameTxt_.text = var_122_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_11 = arg_119_1:GetWordFromCfg(114242029)
				local var_122_12 = arg_119_1:FormatText(var_122_11.content)

				arg_119_1.text_.text = var_122_12

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_13 = 53
				local var_122_14 = utf8.len(var_122_12)
				local var_122_15 = var_122_13 <= 0 and var_122_9 or var_122_9 * (var_122_14 / var_122_13)

				if var_122_15 > 0 and var_122_9 < var_122_15 then
					arg_119_1.talkMaxDuration = var_122_15

					if var_122_15 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_15 + var_122_8
					end
				end

				arg_119_1.text_.text = var_122_12
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242029", "story_v_out_114242.awb") ~= 0 then
					local var_122_16 = manager.audio:GetVoiceLength("story_v_out_114242", "114242029", "story_v_out_114242.awb") / 1000

					if var_122_16 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_16 + var_122_8
					end

					if var_122_11.prefab_name ~= "" and arg_119_1.actors_[var_122_11.prefab_name] ~= nil then
						local var_122_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_11.prefab_name].transform, "story_v_out_114242", "114242029", "story_v_out_114242.awb")

						arg_119_1:RecordAudio("114242029", var_122_17)
						arg_119_1:RecordAudio("114242029", var_122_17)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_114242", "114242029", "story_v_out_114242.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_114242", "114242029", "story_v_out_114242.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_18 = math.max(var_122_9, arg_119_1.talkMaxDuration)

			if var_122_8 <= arg_119_1.time_ and arg_119_1.time_ < var_122_8 + var_122_18 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_8) / var_122_18

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_8 + var_122_18 and arg_119_1.time_ < var_122_8 + var_122_18 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play114242030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 114242030
		arg_123_1.duration_ = 3.7

		local var_123_0 = {
			ja = 3.7,
			ko = 2.866,
			zh = 3.1,
			en = 3.6
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
				arg_123_0:Play114242031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10018"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps10018 == nil then
				arg_123_1.var_.actorSpriteComps10018 = var_126_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_2 = 0.034

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.actorSpriteComps10018 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_126_1 then
							if arg_123_1.isInRecall_ then
								local var_126_4 = Mathf.Lerp(iter_126_1.color.r, arg_123_1.hightColor2.r, var_126_3)
								local var_126_5 = Mathf.Lerp(iter_126_1.color.g, arg_123_1.hightColor2.g, var_126_3)
								local var_126_6 = Mathf.Lerp(iter_126_1.color.b, arg_123_1.hightColor2.b, var_126_3)

								iter_126_1.color = Color.New(var_126_4, var_126_5, var_126_6)
							else
								local var_126_7 = Mathf.Lerp(iter_126_1.color.r, 0.5, var_126_3)

								iter_126_1.color = Color.New(var_126_7, var_126_7, var_126_7)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps10018 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_126_3 then
						if arg_123_1.isInRecall_ then
							iter_126_3.color = arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_126_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps10018 = nil
			end

			local var_126_8 = arg_123_1.actors_["104201_1"]
			local var_126_9 = 0

			if var_126_9 < arg_123_1.time_ and arg_123_1.time_ <= var_126_9 + arg_126_0 and not isNil(var_126_8) then
				local var_126_10 = var_126_8:GetComponent("Image")

				if var_126_10 then
					arg_123_1.var_.highlightMatValue104201_1 = var_126_10
				end
			end

			local var_126_11 = 0.034

			if var_126_9 <= arg_123_1.time_ and arg_123_1.time_ < var_126_9 + var_126_11 and not isNil(var_126_8) then
				local var_126_12 = (arg_123_1.time_ - var_126_9) / var_126_11

				if arg_123_1.var_.highlightMatValue104201_1 then
					local var_126_13 = Mathf.Lerp(0.5, 1, var_126_12)
					local var_126_14 = arg_123_1.var_.highlightMatValue104201_1
					local var_126_15 = var_126_14.color

					var_126_15.r = var_126_13
					var_126_15.g = var_126_13
					var_126_15.b = var_126_13
					var_126_14.color = var_126_15
				end
			end

			if arg_123_1.time_ >= var_126_9 + var_126_11 and arg_123_1.time_ < var_126_9 + var_126_11 + arg_126_0 and not isNil(var_126_8) and arg_123_1.var_.highlightMatValue104201_1 then
				local var_126_16 = 1

				var_126_8.transform:SetSiblingIndex(1)

				local var_126_17 = arg_123_1.var_.highlightMatValue104201_1
				local var_126_18 = var_126_17.color

				var_126_18.r = var_126_16
				var_126_18.g = var_126_16
				var_126_18.b = var_126_16
				var_126_17.color = var_126_18
			end

			local var_126_19 = 0
			local var_126_20 = 0.25

			if var_126_19 < arg_123_1.time_ and arg_123_1.time_ <= var_126_19 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_21 = arg_123_1:FormatText(StoryNameCfg[205].name)

				arg_123_1.leftNameTxt_.text = var_126_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_22 = arg_123_1:GetWordFromCfg(114242030)
				local var_126_23 = arg_123_1:FormatText(var_126_22.content)

				arg_123_1.text_.text = var_126_23

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_24 = 10
				local var_126_25 = utf8.len(var_126_23)
				local var_126_26 = var_126_24 <= 0 and var_126_20 or var_126_20 * (var_126_25 / var_126_24)

				if var_126_26 > 0 and var_126_20 < var_126_26 then
					arg_123_1.talkMaxDuration = var_126_26

					if var_126_26 + var_126_19 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_26 + var_126_19
					end
				end

				arg_123_1.text_.text = var_126_23
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242030", "story_v_out_114242.awb") ~= 0 then
					local var_126_27 = manager.audio:GetVoiceLength("story_v_out_114242", "114242030", "story_v_out_114242.awb") / 1000

					if var_126_27 + var_126_19 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_27 + var_126_19
					end

					if var_126_22.prefab_name ~= "" and arg_123_1.actors_[var_126_22.prefab_name] ~= nil then
						local var_126_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_22.prefab_name].transform, "story_v_out_114242", "114242030", "story_v_out_114242.awb")

						arg_123_1:RecordAudio("114242030", var_126_28)
						arg_123_1:RecordAudio("114242030", var_126_28)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_114242", "114242030", "story_v_out_114242.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_114242", "114242030", "story_v_out_114242.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_29 = math.max(var_126_20, arg_123_1.talkMaxDuration)

			if var_126_19 <= arg_123_1.time_ and arg_123_1.time_ < var_126_19 + var_126_29 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_19) / var_126_29

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_19 + var_126_29 and arg_123_1.time_ < var_126_19 + var_126_29 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play114242031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 114242031
		arg_127_1.duration_ = 15.27

		local var_127_0 = {
			ja = 9.333,
			ko = 10.433,
			zh = 15.266,
			en = 14.133
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
				arg_127_0:Play114242032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10018"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps10018 == nil then
				arg_127_1.var_.actorSpriteComps10018 = var_130_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_2 = 0.034

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.actorSpriteComps10018 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_130_1 then
							if arg_127_1.isInRecall_ then
								local var_130_4 = Mathf.Lerp(iter_130_1.color.r, arg_127_1.hightColor1.r, var_130_3)
								local var_130_5 = Mathf.Lerp(iter_130_1.color.g, arg_127_1.hightColor1.g, var_130_3)
								local var_130_6 = Mathf.Lerp(iter_130_1.color.b, arg_127_1.hightColor1.b, var_130_3)

								iter_130_1.color = Color.New(var_130_4, var_130_5, var_130_6)
							else
								local var_130_7 = Mathf.Lerp(iter_130_1.color.r, 1, var_130_3)

								iter_130_1.color = Color.New(var_130_7, var_130_7, var_130_7)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps10018 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_130_3 then
						if arg_127_1.isInRecall_ then
							iter_130_3.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_130_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps10018 = nil
			end

			local var_130_8 = arg_127_1.actors_["104201_1"]
			local var_130_9 = 0

			if var_130_9 < arg_127_1.time_ and arg_127_1.time_ <= var_130_9 + arg_130_0 and not isNil(var_130_8) then
				local var_130_10 = var_130_8:GetComponent("Image")

				if var_130_10 then
					arg_127_1.var_.highlightMatValue104201_1 = var_130_10
				end
			end

			local var_130_11 = 0.034

			if var_130_9 <= arg_127_1.time_ and arg_127_1.time_ < var_130_9 + var_130_11 and not isNil(var_130_8) then
				local var_130_12 = (arg_127_1.time_ - var_130_9) / var_130_11

				if arg_127_1.var_.highlightMatValue104201_1 then
					local var_130_13 = Mathf.Lerp(1, 0.5, var_130_12)
					local var_130_14 = arg_127_1.var_.highlightMatValue104201_1
					local var_130_15 = var_130_14.color

					var_130_15.r = var_130_13
					var_130_15.g = var_130_13
					var_130_15.b = var_130_13
					var_130_14.color = var_130_15
				end
			end

			if arg_127_1.time_ >= var_130_9 + var_130_11 and arg_127_1.time_ < var_130_9 + var_130_11 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.highlightMatValue104201_1 then
				local var_130_16 = 0.5
				local var_130_17 = arg_127_1.var_.highlightMatValue104201_1
				local var_130_18 = var_130_17.color

				var_130_18.r = var_130_16
				var_130_18.g = var_130_16
				var_130_18.b = var_130_16
				var_130_17.color = var_130_18
			end

			local var_130_19 = 0
			local var_130_20 = 1.475

			if var_130_19 < arg_127_1.time_ and arg_127_1.time_ <= var_130_19 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_21 = arg_127_1:FormatText(StoryNameCfg[258].name)

				arg_127_1.leftNameTxt_.text = var_130_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_22 = arg_127_1:GetWordFromCfg(114242031)
				local var_130_23 = arg_127_1:FormatText(var_130_22.content)

				arg_127_1.text_.text = var_130_23

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_24 = 59
				local var_130_25 = utf8.len(var_130_23)
				local var_130_26 = var_130_24 <= 0 and var_130_20 or var_130_20 * (var_130_25 / var_130_24)

				if var_130_26 > 0 and var_130_20 < var_130_26 then
					arg_127_1.talkMaxDuration = var_130_26

					if var_130_26 + var_130_19 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_26 + var_130_19
					end
				end

				arg_127_1.text_.text = var_130_23
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242031", "story_v_out_114242.awb") ~= 0 then
					local var_130_27 = manager.audio:GetVoiceLength("story_v_out_114242", "114242031", "story_v_out_114242.awb") / 1000

					if var_130_27 + var_130_19 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_27 + var_130_19
					end

					if var_130_22.prefab_name ~= "" and arg_127_1.actors_[var_130_22.prefab_name] ~= nil then
						local var_130_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_22.prefab_name].transform, "story_v_out_114242", "114242031", "story_v_out_114242.awb")

						arg_127_1:RecordAudio("114242031", var_130_28)
						arg_127_1:RecordAudio("114242031", var_130_28)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_114242", "114242031", "story_v_out_114242.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_114242", "114242031", "story_v_out_114242.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_29 = math.max(var_130_20, arg_127_1.talkMaxDuration)

			if var_130_19 <= arg_127_1.time_ and arg_127_1.time_ < var_130_19 + var_130_29 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_19) / var_130_29

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_19 + var_130_29 and arg_127_1.time_ < var_130_19 + var_130_29 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play114242032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 114242032
		arg_131_1.duration_ = 9.23

		local var_131_0 = {
			ja = 3.766,
			ko = 4.5,
			zh = 5.6,
			en = 9.233
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
				arg_131_0:Play114242033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10018"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps10018 == nil then
				arg_131_1.var_.actorSpriteComps10018 = var_134_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_2 = 0.034

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.actorSpriteComps10018 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_134_1 then
							if arg_131_1.isInRecall_ then
								local var_134_4 = Mathf.Lerp(iter_134_1.color.r, arg_131_1.hightColor2.r, var_134_3)
								local var_134_5 = Mathf.Lerp(iter_134_1.color.g, arg_131_1.hightColor2.g, var_134_3)
								local var_134_6 = Mathf.Lerp(iter_134_1.color.b, arg_131_1.hightColor2.b, var_134_3)

								iter_134_1.color = Color.New(var_134_4, var_134_5, var_134_6)
							else
								local var_134_7 = Mathf.Lerp(iter_134_1.color.r, 0.5, var_134_3)

								iter_134_1.color = Color.New(var_134_7, var_134_7, var_134_7)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps10018 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_134_3 then
						if arg_131_1.isInRecall_ then
							iter_134_3.color = arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_134_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps10018 = nil
			end

			local var_134_8 = arg_131_1.actors_["104201_1"]
			local var_134_9 = 0

			if var_134_9 < arg_131_1.time_ and arg_131_1.time_ <= var_134_9 + arg_134_0 and not isNil(var_134_8) then
				local var_134_10 = var_134_8:GetComponent("Image")

				if var_134_10 then
					arg_131_1.var_.highlightMatValue104201_1 = var_134_10
				end
			end

			local var_134_11 = 0.034

			if var_134_9 <= arg_131_1.time_ and arg_131_1.time_ < var_134_9 + var_134_11 and not isNil(var_134_8) then
				local var_134_12 = (arg_131_1.time_ - var_134_9) / var_134_11

				if arg_131_1.var_.highlightMatValue104201_1 then
					local var_134_13 = Mathf.Lerp(0.5, 1, var_134_12)
					local var_134_14 = arg_131_1.var_.highlightMatValue104201_1
					local var_134_15 = var_134_14.color

					var_134_15.r = var_134_13
					var_134_15.g = var_134_13
					var_134_15.b = var_134_13
					var_134_14.color = var_134_15
				end
			end

			if arg_131_1.time_ >= var_134_9 + var_134_11 and arg_131_1.time_ < var_134_9 + var_134_11 + arg_134_0 and not isNil(var_134_8) and arg_131_1.var_.highlightMatValue104201_1 then
				local var_134_16 = 1

				var_134_8.transform:SetSiblingIndex(1)

				local var_134_17 = arg_131_1.var_.highlightMatValue104201_1
				local var_134_18 = var_134_17.color

				var_134_18.r = var_134_16
				var_134_18.g = var_134_16
				var_134_18.b = var_134_16
				var_134_17.color = var_134_18
			end

			local var_134_19 = 0
			local var_134_20 = 0.575

			if var_134_19 < arg_131_1.time_ and arg_131_1.time_ <= var_134_19 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_21 = arg_131_1:FormatText(StoryNameCfg[205].name)

				arg_131_1.leftNameTxt_.text = var_134_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_22 = arg_131_1:GetWordFromCfg(114242032)
				local var_134_23 = arg_131_1:FormatText(var_134_22.content)

				arg_131_1.text_.text = var_134_23

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_24 = 23
				local var_134_25 = utf8.len(var_134_23)
				local var_134_26 = var_134_24 <= 0 and var_134_20 or var_134_20 * (var_134_25 / var_134_24)

				if var_134_26 > 0 and var_134_20 < var_134_26 then
					arg_131_1.talkMaxDuration = var_134_26

					if var_134_26 + var_134_19 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_26 + var_134_19
					end
				end

				arg_131_1.text_.text = var_134_23
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242032", "story_v_out_114242.awb") ~= 0 then
					local var_134_27 = manager.audio:GetVoiceLength("story_v_out_114242", "114242032", "story_v_out_114242.awb") / 1000

					if var_134_27 + var_134_19 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_27 + var_134_19
					end

					if var_134_22.prefab_name ~= "" and arg_131_1.actors_[var_134_22.prefab_name] ~= nil then
						local var_134_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_22.prefab_name].transform, "story_v_out_114242", "114242032", "story_v_out_114242.awb")

						arg_131_1:RecordAudio("114242032", var_134_28)
						arg_131_1:RecordAudio("114242032", var_134_28)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_114242", "114242032", "story_v_out_114242.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_114242", "114242032", "story_v_out_114242.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_29 = math.max(var_134_20, arg_131_1.talkMaxDuration)

			if var_134_19 <= arg_131_1.time_ and arg_131_1.time_ < var_134_19 + var_134_29 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_19) / var_134_29

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_19 + var_134_29 and arg_131_1.time_ < var_134_19 + var_134_29 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play114242033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 114242033
		arg_135_1.duration_ = 9

		local var_135_0 = {
			ja = 9,
			ko = 5.233,
			zh = 7.4,
			en = 5.733
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
				arg_135_0:Play114242034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10018"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.actorSpriteComps10018 == nil then
				arg_135_1.var_.actorSpriteComps10018 = var_138_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_2 = 0.034

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.actorSpriteComps10018 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_138_1 then
							if arg_135_1.isInRecall_ then
								local var_138_4 = Mathf.Lerp(iter_138_1.color.r, arg_135_1.hightColor1.r, var_138_3)
								local var_138_5 = Mathf.Lerp(iter_138_1.color.g, arg_135_1.hightColor1.g, var_138_3)
								local var_138_6 = Mathf.Lerp(iter_138_1.color.b, arg_135_1.hightColor1.b, var_138_3)

								iter_138_1.color = Color.New(var_138_4, var_138_5, var_138_6)
							else
								local var_138_7 = Mathf.Lerp(iter_138_1.color.r, 1, var_138_3)

								iter_138_1.color = Color.New(var_138_7, var_138_7, var_138_7)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.actorSpriteComps10018 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_138_3 then
						if arg_135_1.isInRecall_ then
							iter_138_3.color = arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_138_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps10018 = nil
			end

			local var_138_8 = arg_135_1.actors_["104201_1"]
			local var_138_9 = 0

			if var_138_9 < arg_135_1.time_ and arg_135_1.time_ <= var_138_9 + arg_138_0 and not isNil(var_138_8) then
				local var_138_10 = var_138_8:GetComponent("Image")

				if var_138_10 then
					arg_135_1.var_.highlightMatValue104201_1 = var_138_10
				end
			end

			local var_138_11 = 0.034

			if var_138_9 <= arg_135_1.time_ and arg_135_1.time_ < var_138_9 + var_138_11 and not isNil(var_138_8) then
				local var_138_12 = (arg_135_1.time_ - var_138_9) / var_138_11

				if arg_135_1.var_.highlightMatValue104201_1 then
					local var_138_13 = Mathf.Lerp(1, 0.5, var_138_12)
					local var_138_14 = arg_135_1.var_.highlightMatValue104201_1
					local var_138_15 = var_138_14.color

					var_138_15.r = var_138_13
					var_138_15.g = var_138_13
					var_138_15.b = var_138_13
					var_138_14.color = var_138_15
				end
			end

			if arg_135_1.time_ >= var_138_9 + var_138_11 and arg_135_1.time_ < var_138_9 + var_138_11 + arg_138_0 and not isNil(var_138_8) and arg_135_1.var_.highlightMatValue104201_1 then
				local var_138_16 = 0.5
				local var_138_17 = arg_135_1.var_.highlightMatValue104201_1
				local var_138_18 = var_138_17.color

				var_138_18.r = var_138_16
				var_138_18.g = var_138_16
				var_138_18.b = var_138_16
				var_138_17.color = var_138_18
			end

			local var_138_19 = 0
			local var_138_20 = 0.65

			if var_138_19 < arg_135_1.time_ and arg_135_1.time_ <= var_138_19 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_21 = arg_135_1:FormatText(StoryNameCfg[258].name)

				arg_135_1.leftNameTxt_.text = var_138_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_22 = arg_135_1:GetWordFromCfg(114242033)
				local var_138_23 = arg_135_1:FormatText(var_138_22.content)

				arg_135_1.text_.text = var_138_23

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_24 = 26
				local var_138_25 = utf8.len(var_138_23)
				local var_138_26 = var_138_24 <= 0 and var_138_20 or var_138_20 * (var_138_25 / var_138_24)

				if var_138_26 > 0 and var_138_20 < var_138_26 then
					arg_135_1.talkMaxDuration = var_138_26

					if var_138_26 + var_138_19 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_26 + var_138_19
					end
				end

				arg_135_1.text_.text = var_138_23
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242033", "story_v_out_114242.awb") ~= 0 then
					local var_138_27 = manager.audio:GetVoiceLength("story_v_out_114242", "114242033", "story_v_out_114242.awb") / 1000

					if var_138_27 + var_138_19 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_27 + var_138_19
					end

					if var_138_22.prefab_name ~= "" and arg_135_1.actors_[var_138_22.prefab_name] ~= nil then
						local var_138_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_22.prefab_name].transform, "story_v_out_114242", "114242033", "story_v_out_114242.awb")

						arg_135_1:RecordAudio("114242033", var_138_28)
						arg_135_1:RecordAudio("114242033", var_138_28)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_114242", "114242033", "story_v_out_114242.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_114242", "114242033", "story_v_out_114242.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_29 = math.max(var_138_20, arg_135_1.talkMaxDuration)

			if var_138_19 <= arg_135_1.time_ and arg_135_1.time_ < var_138_19 + var_138_29 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_19) / var_138_29

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_19 + var_138_29 and arg_135_1.time_ < var_138_19 + var_138_29 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play114242034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 114242034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play114242035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10018"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps10018 == nil then
				arg_139_1.var_.actorSpriteComps10018 = var_142_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_2 = 0.034

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.actorSpriteComps10018 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								local var_142_4 = Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor2.r, var_142_3)
								local var_142_5 = Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor2.g, var_142_3)
								local var_142_6 = Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor2.b, var_142_3)

								iter_142_1.color = Color.New(var_142_4, var_142_5, var_142_6)
							else
								local var_142_7 = Mathf.Lerp(iter_142_1.color.r, 0.5, var_142_3)

								iter_142_1.color = Color.New(var_142_7, var_142_7, var_142_7)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps10018 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_142_3 then
						if arg_139_1.isInRecall_ then
							iter_142_3.color = arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_142_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps10018 = nil
			end

			local var_142_8 = 0
			local var_142_9 = 0.65

			if var_142_8 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_10 = arg_139_1:GetWordFromCfg(114242034)
				local var_142_11 = arg_139_1:FormatText(var_142_10.content)

				arg_139_1.text_.text = var_142_11

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_12 = 26
				local var_142_13 = utf8.len(var_142_11)
				local var_142_14 = var_142_12 <= 0 and var_142_9 or var_142_9 * (var_142_13 / var_142_12)

				if var_142_14 > 0 and var_142_9 < var_142_14 then
					arg_139_1.talkMaxDuration = var_142_14

					if var_142_14 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_8
					end
				end

				arg_139_1.text_.text = var_142_11
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_15 = math.max(var_142_9, arg_139_1.talkMaxDuration)

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_15 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_8) / var_142_15

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_8 + var_142_15 and arg_139_1.time_ < var_142_8 + var_142_15 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play114242035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 114242035
		arg_143_1.duration_ = 3.1

		local var_143_0 = {
			ja = 2.933,
			ko = 3.1,
			zh = 2.233,
			en = 2.466
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
				arg_143_0:Play114242036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["10018"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.actorSpriteComps10018 == nil then
				arg_143_1.var_.actorSpriteComps10018 = var_146_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_2 = 0.034

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.actorSpriteComps10018 then
					for iter_146_0, iter_146_1 in pairs(arg_143_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.actorSpriteComps10018 then
				for iter_146_2, iter_146_3 in pairs(arg_143_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_146_3 then
						if arg_143_1.isInRecall_ then
							iter_146_3.color = arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_146_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps10018 = nil
			end

			local var_146_8 = 0
			local var_146_9 = 0.3

			if var_146_8 < arg_143_1.time_ and arg_143_1.time_ <= var_146_8 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_10 = arg_143_1:FormatText(StoryNameCfg[258].name)

				arg_143_1.leftNameTxt_.text = var_146_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_11 = arg_143_1:GetWordFromCfg(114242035)
				local var_146_12 = arg_143_1:FormatText(var_146_11.content)

				arg_143_1.text_.text = var_146_12

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_13 = 12
				local var_146_14 = utf8.len(var_146_12)
				local var_146_15 = var_146_13 <= 0 and var_146_9 or var_146_9 * (var_146_14 / var_146_13)

				if var_146_15 > 0 and var_146_9 < var_146_15 then
					arg_143_1.talkMaxDuration = var_146_15

					if var_146_15 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_15 + var_146_8
					end
				end

				arg_143_1.text_.text = var_146_12
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242035", "story_v_out_114242.awb") ~= 0 then
					local var_146_16 = manager.audio:GetVoiceLength("story_v_out_114242", "114242035", "story_v_out_114242.awb") / 1000

					if var_146_16 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_16 + var_146_8
					end

					if var_146_11.prefab_name ~= "" and arg_143_1.actors_[var_146_11.prefab_name] ~= nil then
						local var_146_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_11.prefab_name].transform, "story_v_out_114242", "114242035", "story_v_out_114242.awb")

						arg_143_1:RecordAudio("114242035", var_146_17)
						arg_143_1:RecordAudio("114242035", var_146_17)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_114242", "114242035", "story_v_out_114242.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_114242", "114242035", "story_v_out_114242.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_18 = math.max(var_146_9, arg_143_1.talkMaxDuration)

			if var_146_8 <= arg_143_1.time_ and arg_143_1.time_ < var_146_8 + var_146_18 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_8) / var_146_18

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_8 + var_146_18 and arg_143_1.time_ < var_146_8 + var_146_18 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play114242036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 114242036
		arg_147_1.duration_ = 15.57

		local var_147_0 = {
			ja = 14.8,
			ko = 13.7,
			zh = 15.566,
			en = 12.533
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
				arg_147_0:Play114242037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 1.8

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[258].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:GetWordFromCfg(114242036)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 72
				local var_150_6 = utf8.len(var_150_4)
				local var_150_7 = var_150_5 <= 0 and var_150_1 or var_150_1 * (var_150_6 / var_150_5)

				if var_150_7 > 0 and var_150_1 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_4
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242036", "story_v_out_114242.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_114242", "114242036", "story_v_out_114242.awb") / 1000

					if var_150_8 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_0
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_114242", "114242036", "story_v_out_114242.awb")

						arg_147_1:RecordAudio("114242036", var_150_9)
						arg_147_1:RecordAudio("114242036", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_114242", "114242036", "story_v_out_114242.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_114242", "114242036", "story_v_out_114242.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_10 and arg_147_1.time_ < var_150_0 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play114242037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 114242037
		arg_151_1.duration_ = 16.5

		local var_151_0 = {
			ja = 16.5,
			ko = 13.8,
			zh = 14.033,
			en = 15.333
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
				arg_151_0:Play114242038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10018"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps10018 == nil then
				arg_151_1.var_.actorSpriteComps10018 = var_154_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_2 = 0.034

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.actorSpriteComps10018 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								local var_154_4 = Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor2.r, var_154_3)
								local var_154_5 = Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor2.g, var_154_3)
								local var_154_6 = Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor2.b, var_154_3)

								iter_154_1.color = Color.New(var_154_4, var_154_5, var_154_6)
							else
								local var_154_7 = Mathf.Lerp(iter_154_1.color.r, 0.5, var_154_3)

								iter_154_1.color = Color.New(var_154_7, var_154_7, var_154_7)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps10018 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_154_3 then
						if arg_151_1.isInRecall_ then
							iter_154_3.color = arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_154_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps10018 = nil
			end

			local var_154_8 = arg_151_1.actors_["104201_1"]
			local var_154_9 = 0

			if var_154_9 < arg_151_1.time_ and arg_151_1.time_ <= var_154_9 + arg_154_0 and not isNil(var_154_8) then
				local var_154_10 = var_154_8:GetComponent("Image")

				if var_154_10 then
					arg_151_1.var_.highlightMatValue104201_1 = var_154_10
				end
			end

			local var_154_11 = 0.034

			if var_154_9 <= arg_151_1.time_ and arg_151_1.time_ < var_154_9 + var_154_11 and not isNil(var_154_8) then
				local var_154_12 = (arg_151_1.time_ - var_154_9) / var_154_11

				if arg_151_1.var_.highlightMatValue104201_1 then
					local var_154_13 = Mathf.Lerp(0.5, 1, var_154_12)
					local var_154_14 = arg_151_1.var_.highlightMatValue104201_1
					local var_154_15 = var_154_14.color

					var_154_15.r = var_154_13
					var_154_15.g = var_154_13
					var_154_15.b = var_154_13
					var_154_14.color = var_154_15
				end
			end

			if arg_151_1.time_ >= var_154_9 + var_154_11 and arg_151_1.time_ < var_154_9 + var_154_11 + arg_154_0 and not isNil(var_154_8) and arg_151_1.var_.highlightMatValue104201_1 then
				local var_154_16 = 1

				var_154_8.transform:SetSiblingIndex(1)

				local var_154_17 = arg_151_1.var_.highlightMatValue104201_1
				local var_154_18 = var_154_17.color

				var_154_18.r = var_154_16
				var_154_18.g = var_154_16
				var_154_18.b = var_154_16
				var_154_17.color = var_154_18
			end

			local var_154_19 = 0
			local var_154_20 = 1.55

			if var_154_19 < arg_151_1.time_ and arg_151_1.time_ <= var_154_19 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_21 = arg_151_1:FormatText(StoryNameCfg[205].name)

				arg_151_1.leftNameTxt_.text = var_154_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_22 = arg_151_1:GetWordFromCfg(114242037)
				local var_154_23 = arg_151_1:FormatText(var_154_22.content)

				arg_151_1.text_.text = var_154_23

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_24 = 62
				local var_154_25 = utf8.len(var_154_23)
				local var_154_26 = var_154_24 <= 0 and var_154_20 or var_154_20 * (var_154_25 / var_154_24)

				if var_154_26 > 0 and var_154_20 < var_154_26 then
					arg_151_1.talkMaxDuration = var_154_26

					if var_154_26 + var_154_19 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_26 + var_154_19
					end
				end

				arg_151_1.text_.text = var_154_23
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242037", "story_v_out_114242.awb") ~= 0 then
					local var_154_27 = manager.audio:GetVoiceLength("story_v_out_114242", "114242037", "story_v_out_114242.awb") / 1000

					if var_154_27 + var_154_19 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_27 + var_154_19
					end

					if var_154_22.prefab_name ~= "" and arg_151_1.actors_[var_154_22.prefab_name] ~= nil then
						local var_154_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_22.prefab_name].transform, "story_v_out_114242", "114242037", "story_v_out_114242.awb")

						arg_151_1:RecordAudio("114242037", var_154_28)
						arg_151_1:RecordAudio("114242037", var_154_28)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_114242", "114242037", "story_v_out_114242.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_114242", "114242037", "story_v_out_114242.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_29 = math.max(var_154_20, arg_151_1.talkMaxDuration)

			if var_154_19 <= arg_151_1.time_ and arg_151_1.time_ < var_154_19 + var_154_29 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_19) / var_154_29

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_19 + var_154_29 and arg_151_1.time_ < var_154_19 + var_154_29 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play114242038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 114242038
		arg_155_1.duration_ = 15.1

		local var_155_0 = {
			ja = 10.233,
			ko = 11.9,
			zh = 15.1,
			en = 12.666
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
				arg_155_0:Play114242039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10018"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.actorSpriteComps10018 == nil then
				arg_155_1.var_.actorSpriteComps10018 = var_158_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_2 = 0.034

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.actorSpriteComps10018 then
					for iter_158_0, iter_158_1 in pairs(arg_155_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.actorSpriteComps10018 then
				for iter_158_2, iter_158_3 in pairs(arg_155_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_158_3 then
						if arg_155_1.isInRecall_ then
							iter_158_3.color = arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_158_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps10018 = nil
			end

			local var_158_8 = arg_155_1.actors_["104201_1"]
			local var_158_9 = 0

			if var_158_9 < arg_155_1.time_ and arg_155_1.time_ <= var_158_9 + arg_158_0 and not isNil(var_158_8) then
				local var_158_10 = var_158_8:GetComponent("Image")

				if var_158_10 then
					arg_155_1.var_.highlightMatValue104201_1 = var_158_10
				end
			end

			local var_158_11 = 0.034

			if var_158_9 <= arg_155_1.time_ and arg_155_1.time_ < var_158_9 + var_158_11 and not isNil(var_158_8) then
				local var_158_12 = (arg_155_1.time_ - var_158_9) / var_158_11

				if arg_155_1.var_.highlightMatValue104201_1 then
					local var_158_13 = Mathf.Lerp(1, 0.5, var_158_12)
					local var_158_14 = arg_155_1.var_.highlightMatValue104201_1
					local var_158_15 = var_158_14.color

					var_158_15.r = var_158_13
					var_158_15.g = var_158_13
					var_158_15.b = var_158_13
					var_158_14.color = var_158_15
				end
			end

			if arg_155_1.time_ >= var_158_9 + var_158_11 and arg_155_1.time_ < var_158_9 + var_158_11 + arg_158_0 and not isNil(var_158_8) and arg_155_1.var_.highlightMatValue104201_1 then
				local var_158_16 = 0.5
				local var_158_17 = arg_155_1.var_.highlightMatValue104201_1
				local var_158_18 = var_158_17.color

				var_158_18.r = var_158_16
				var_158_18.g = var_158_16
				var_158_18.b = var_158_16
				var_158_17.color = var_158_18
			end

			local var_158_19 = 0
			local var_158_20 = 1.525

			if var_158_19 < arg_155_1.time_ and arg_155_1.time_ <= var_158_19 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_21 = arg_155_1:FormatText(StoryNameCfg[258].name)

				arg_155_1.leftNameTxt_.text = var_158_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_22 = arg_155_1:GetWordFromCfg(114242038)
				local var_158_23 = arg_155_1:FormatText(var_158_22.content)

				arg_155_1.text_.text = var_158_23

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_24 = 62
				local var_158_25 = utf8.len(var_158_23)
				local var_158_26 = var_158_24 <= 0 and var_158_20 or var_158_20 * (var_158_25 / var_158_24)

				if var_158_26 > 0 and var_158_20 < var_158_26 then
					arg_155_1.talkMaxDuration = var_158_26

					if var_158_26 + var_158_19 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_26 + var_158_19
					end
				end

				arg_155_1.text_.text = var_158_23
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242038", "story_v_out_114242.awb") ~= 0 then
					local var_158_27 = manager.audio:GetVoiceLength("story_v_out_114242", "114242038", "story_v_out_114242.awb") / 1000

					if var_158_27 + var_158_19 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_27 + var_158_19
					end

					if var_158_22.prefab_name ~= "" and arg_155_1.actors_[var_158_22.prefab_name] ~= nil then
						local var_158_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_22.prefab_name].transform, "story_v_out_114242", "114242038", "story_v_out_114242.awb")

						arg_155_1:RecordAudio("114242038", var_158_28)
						arg_155_1:RecordAudio("114242038", var_158_28)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_114242", "114242038", "story_v_out_114242.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_114242", "114242038", "story_v_out_114242.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_29 = math.max(var_158_20, arg_155_1.talkMaxDuration)

			if var_158_19 <= arg_155_1.time_ and arg_155_1.time_ < var_158_19 + var_158_29 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_19) / var_158_29

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_19 + var_158_29 and arg_155_1.time_ < var_158_19 + var_158_29 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play114242039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 114242039
		arg_159_1.duration_ = 2.27

		local var_159_0 = {
			ja = 1.066,
			ko = 1.3,
			zh = 2.266,
			en = 1
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play114242040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10018"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.actorSpriteComps10018 == nil then
				arg_159_1.var_.actorSpriteComps10018 = var_162_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_2 = 0.034

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.actorSpriteComps10018 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.actorSpriteComps10018 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_162_3 then
						if arg_159_1.isInRecall_ then
							iter_162_3.color = arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_162_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_159_1.var_.actorSpriteComps10018 = nil
			end

			local var_162_8 = arg_159_1.actors_["104201_1"]
			local var_162_9 = 0

			if var_162_9 < arg_159_1.time_ and arg_159_1.time_ <= var_162_9 + arg_162_0 and not isNil(var_162_8) then
				local var_162_10 = var_162_8:GetComponent("Image")

				if var_162_10 then
					arg_159_1.var_.highlightMatValue104201_1 = var_162_10
				end
			end

			local var_162_11 = 0.034

			if var_162_9 <= arg_159_1.time_ and arg_159_1.time_ < var_162_9 + var_162_11 and not isNil(var_162_8) then
				local var_162_12 = (arg_159_1.time_ - var_162_9) / var_162_11

				if arg_159_1.var_.highlightMatValue104201_1 then
					local var_162_13 = Mathf.Lerp(0.5, 1, var_162_12)
					local var_162_14 = arg_159_1.var_.highlightMatValue104201_1
					local var_162_15 = var_162_14.color

					var_162_15.r = var_162_13
					var_162_15.g = var_162_13
					var_162_15.b = var_162_13
					var_162_14.color = var_162_15
				end
			end

			if arg_159_1.time_ >= var_162_9 + var_162_11 and arg_159_1.time_ < var_162_9 + var_162_11 + arg_162_0 and not isNil(var_162_8) and arg_159_1.var_.highlightMatValue104201_1 then
				local var_162_16 = 1

				var_162_8.transform:SetSiblingIndex(1)

				local var_162_17 = arg_159_1.var_.highlightMatValue104201_1
				local var_162_18 = var_162_17.color

				var_162_18.r = var_162_16
				var_162_18.g = var_162_16
				var_162_18.b = var_162_16
				var_162_17.color = var_162_18
			end

			local var_162_19 = 0
			local var_162_20 = 0.05

			if var_162_19 < arg_159_1.time_ and arg_159_1.time_ <= var_162_19 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_21 = arg_159_1:FormatText(StoryNameCfg[205].name)

				arg_159_1.leftNameTxt_.text = var_162_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_22 = arg_159_1:GetWordFromCfg(114242039)
				local var_162_23 = arg_159_1:FormatText(var_162_22.content)

				arg_159_1.text_.text = var_162_23

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_24 = 2
				local var_162_25 = utf8.len(var_162_23)
				local var_162_26 = var_162_24 <= 0 and var_162_20 or var_162_20 * (var_162_25 / var_162_24)

				if var_162_26 > 0 and var_162_20 < var_162_26 then
					arg_159_1.talkMaxDuration = var_162_26

					if var_162_26 + var_162_19 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_26 + var_162_19
					end
				end

				arg_159_1.text_.text = var_162_23
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242039", "story_v_out_114242.awb") ~= 0 then
					local var_162_27 = manager.audio:GetVoiceLength("story_v_out_114242", "114242039", "story_v_out_114242.awb") / 1000

					if var_162_27 + var_162_19 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_27 + var_162_19
					end

					if var_162_22.prefab_name ~= "" and arg_159_1.actors_[var_162_22.prefab_name] ~= nil then
						local var_162_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_22.prefab_name].transform, "story_v_out_114242", "114242039", "story_v_out_114242.awb")

						arg_159_1:RecordAudio("114242039", var_162_28)
						arg_159_1:RecordAudio("114242039", var_162_28)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_114242", "114242039", "story_v_out_114242.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_114242", "114242039", "story_v_out_114242.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_29 = math.max(var_162_20, arg_159_1.talkMaxDuration)

			if var_162_19 <= arg_159_1.time_ and arg_159_1.time_ < var_162_19 + var_162_29 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_19) / var_162_29

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_19 + var_162_29 and arg_159_1.time_ < var_162_19 + var_162_29 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play114242040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 114242040
		arg_163_1.duration_ = 13.37

		local var_163_0 = {
			ja = 6.033,
			ko = 8.533,
			zh = 8.7,
			en = 13.366
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
				arg_163_0:Play114242041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10018"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.actorSpriteComps10018 == nil then
				arg_163_1.var_.actorSpriteComps10018 = var_166_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_2 = 0.034

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.actorSpriteComps10018 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.actorSpriteComps10018 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_166_3 then
						if arg_163_1.isInRecall_ then
							iter_166_3.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_166_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps10018 = nil
			end

			local var_166_8 = arg_163_1.actors_["104201_1"]
			local var_166_9 = 0

			if var_166_9 < arg_163_1.time_ and arg_163_1.time_ <= var_166_9 + arg_166_0 and not isNil(var_166_8) then
				local var_166_10 = var_166_8:GetComponent("Image")

				if var_166_10 then
					arg_163_1.var_.highlightMatValue104201_1 = var_166_10
				end
			end

			local var_166_11 = 0.034

			if var_166_9 <= arg_163_1.time_ and arg_163_1.time_ < var_166_9 + var_166_11 and not isNil(var_166_8) then
				local var_166_12 = (arg_163_1.time_ - var_166_9) / var_166_11

				if arg_163_1.var_.highlightMatValue104201_1 then
					local var_166_13 = Mathf.Lerp(1, 0.5, var_166_12)
					local var_166_14 = arg_163_1.var_.highlightMatValue104201_1
					local var_166_15 = var_166_14.color

					var_166_15.r = var_166_13
					var_166_15.g = var_166_13
					var_166_15.b = var_166_13
					var_166_14.color = var_166_15
				end
			end

			if arg_163_1.time_ >= var_166_9 + var_166_11 and arg_163_1.time_ < var_166_9 + var_166_11 + arg_166_0 and not isNil(var_166_8) and arg_163_1.var_.highlightMatValue104201_1 then
				local var_166_16 = 0.5
				local var_166_17 = arg_163_1.var_.highlightMatValue104201_1
				local var_166_18 = var_166_17.color

				var_166_18.r = var_166_16
				var_166_18.g = var_166_16
				var_166_18.b = var_166_16
				var_166_17.color = var_166_18
			end

			local var_166_19 = 0
			local var_166_20 = 1.075

			if var_166_19 < arg_163_1.time_ and arg_163_1.time_ <= var_166_19 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_21 = arg_163_1:FormatText(StoryNameCfg[258].name)

				arg_163_1.leftNameTxt_.text = var_166_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_22 = arg_163_1:GetWordFromCfg(114242040)
				local var_166_23 = arg_163_1:FormatText(var_166_22.content)

				arg_163_1.text_.text = var_166_23

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_24 = 43
				local var_166_25 = utf8.len(var_166_23)
				local var_166_26 = var_166_24 <= 0 and var_166_20 or var_166_20 * (var_166_25 / var_166_24)

				if var_166_26 > 0 and var_166_20 < var_166_26 then
					arg_163_1.talkMaxDuration = var_166_26

					if var_166_26 + var_166_19 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_26 + var_166_19
					end
				end

				arg_163_1.text_.text = var_166_23
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242040", "story_v_out_114242.awb") ~= 0 then
					local var_166_27 = manager.audio:GetVoiceLength("story_v_out_114242", "114242040", "story_v_out_114242.awb") / 1000

					if var_166_27 + var_166_19 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_27 + var_166_19
					end

					if var_166_22.prefab_name ~= "" and arg_163_1.actors_[var_166_22.prefab_name] ~= nil then
						local var_166_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_22.prefab_name].transform, "story_v_out_114242", "114242040", "story_v_out_114242.awb")

						arg_163_1:RecordAudio("114242040", var_166_28)
						arg_163_1:RecordAudio("114242040", var_166_28)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_114242", "114242040", "story_v_out_114242.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_114242", "114242040", "story_v_out_114242.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_29 = math.max(var_166_20, arg_163_1.talkMaxDuration)

			if var_166_19 <= arg_163_1.time_ and arg_163_1.time_ < var_166_19 + var_166_29 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_19) / var_166_29

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_19 + var_166_29 and arg_163_1.time_ < var_166_19 + var_166_29 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play114242041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 114242041
		arg_167_1.duration_ = 3.4

		local var_167_0 = {
			ja = 3.4,
			ko = 2.833,
			zh = 3.3,
			en = 2.866
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
				arg_167_0:Play114242042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10018"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps10018 == nil then
				arg_167_1.var_.actorSpriteComps10018 = var_170_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_2 = 0.034

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.actorSpriteComps10018 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_170_1 then
							if arg_167_1.isInRecall_ then
								local var_170_4 = Mathf.Lerp(iter_170_1.color.r, arg_167_1.hightColor2.r, var_170_3)
								local var_170_5 = Mathf.Lerp(iter_170_1.color.g, arg_167_1.hightColor2.g, var_170_3)
								local var_170_6 = Mathf.Lerp(iter_170_1.color.b, arg_167_1.hightColor2.b, var_170_3)

								iter_170_1.color = Color.New(var_170_4, var_170_5, var_170_6)
							else
								local var_170_7 = Mathf.Lerp(iter_170_1.color.r, 0.5, var_170_3)

								iter_170_1.color = Color.New(var_170_7, var_170_7, var_170_7)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps10018 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_170_3 then
						if arg_167_1.isInRecall_ then
							iter_170_3.color = arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_170_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps10018 = nil
			end

			local var_170_8 = arg_167_1.actors_["104201_1"]
			local var_170_9 = 0

			if var_170_9 < arg_167_1.time_ and arg_167_1.time_ <= var_170_9 + arg_170_0 and not isNil(var_170_8) then
				local var_170_10 = var_170_8:GetComponent("Image")

				if var_170_10 then
					arg_167_1.var_.highlightMatValue104201_1 = var_170_10
				end
			end

			local var_170_11 = 0.034

			if var_170_9 <= arg_167_1.time_ and arg_167_1.time_ < var_170_9 + var_170_11 and not isNil(var_170_8) then
				local var_170_12 = (arg_167_1.time_ - var_170_9) / var_170_11

				if arg_167_1.var_.highlightMatValue104201_1 then
					local var_170_13 = Mathf.Lerp(0.5, 1, var_170_12)
					local var_170_14 = arg_167_1.var_.highlightMatValue104201_1
					local var_170_15 = var_170_14.color

					var_170_15.r = var_170_13
					var_170_15.g = var_170_13
					var_170_15.b = var_170_13
					var_170_14.color = var_170_15
				end
			end

			if arg_167_1.time_ >= var_170_9 + var_170_11 and arg_167_1.time_ < var_170_9 + var_170_11 + arg_170_0 and not isNil(var_170_8) and arg_167_1.var_.highlightMatValue104201_1 then
				local var_170_16 = 1

				var_170_8.transform:SetSiblingIndex(1)

				local var_170_17 = arg_167_1.var_.highlightMatValue104201_1
				local var_170_18 = var_170_17.color

				var_170_18.r = var_170_16
				var_170_18.g = var_170_16
				var_170_18.b = var_170_16
				var_170_17.color = var_170_18
			end

			local var_170_19 = 0
			local var_170_20 = 0.225

			if var_170_19 < arg_167_1.time_ and arg_167_1.time_ <= var_170_19 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_21 = arg_167_1:FormatText(StoryNameCfg[205].name)

				arg_167_1.leftNameTxt_.text = var_170_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_22 = arg_167_1:GetWordFromCfg(114242041)
				local var_170_23 = arg_167_1:FormatText(var_170_22.content)

				arg_167_1.text_.text = var_170_23

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_24 = 9
				local var_170_25 = utf8.len(var_170_23)
				local var_170_26 = var_170_24 <= 0 and var_170_20 or var_170_20 * (var_170_25 / var_170_24)

				if var_170_26 > 0 and var_170_20 < var_170_26 then
					arg_167_1.talkMaxDuration = var_170_26

					if var_170_26 + var_170_19 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_26 + var_170_19
					end
				end

				arg_167_1.text_.text = var_170_23
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242041", "story_v_out_114242.awb") ~= 0 then
					local var_170_27 = manager.audio:GetVoiceLength("story_v_out_114242", "114242041", "story_v_out_114242.awb") / 1000

					if var_170_27 + var_170_19 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_27 + var_170_19
					end

					if var_170_22.prefab_name ~= "" and arg_167_1.actors_[var_170_22.prefab_name] ~= nil then
						local var_170_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_22.prefab_name].transform, "story_v_out_114242", "114242041", "story_v_out_114242.awb")

						arg_167_1:RecordAudio("114242041", var_170_28)
						arg_167_1:RecordAudio("114242041", var_170_28)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_114242", "114242041", "story_v_out_114242.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_114242", "114242041", "story_v_out_114242.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_29 = math.max(var_170_20, arg_167_1.talkMaxDuration)

			if var_170_19 <= arg_167_1.time_ and arg_167_1.time_ < var_170_19 + var_170_29 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_19) / var_170_29

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_19 + var_170_29 and arg_167_1.time_ < var_170_19 + var_170_29 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play114242042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 114242042
		arg_171_1.duration_ = 7.9

		local var_171_0 = {
			ja = 7.9,
			ko = 6.966,
			zh = 6.833,
			en = 7.566
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
				arg_171_0:Play114242043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10018"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.actorSpriteComps10018 == nil then
				arg_171_1.var_.actorSpriteComps10018 = var_174_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_2 = 0.034

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.actorSpriteComps10018 then
					for iter_174_0, iter_174_1 in pairs(arg_171_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_174_1 then
							if arg_171_1.isInRecall_ then
								local var_174_4 = Mathf.Lerp(iter_174_1.color.r, arg_171_1.hightColor1.r, var_174_3)
								local var_174_5 = Mathf.Lerp(iter_174_1.color.g, arg_171_1.hightColor1.g, var_174_3)
								local var_174_6 = Mathf.Lerp(iter_174_1.color.b, arg_171_1.hightColor1.b, var_174_3)

								iter_174_1.color = Color.New(var_174_4, var_174_5, var_174_6)
							else
								local var_174_7 = Mathf.Lerp(iter_174_1.color.r, 1, var_174_3)

								iter_174_1.color = Color.New(var_174_7, var_174_7, var_174_7)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.actorSpriteComps10018 then
				for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_174_3 then
						if arg_171_1.isInRecall_ then
							iter_174_3.color = arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_174_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps10018 = nil
			end

			local var_174_8 = arg_171_1.actors_["104201_1"]
			local var_174_9 = 0

			if var_174_9 < arg_171_1.time_ and arg_171_1.time_ <= var_174_9 + arg_174_0 and not isNil(var_174_8) then
				local var_174_10 = var_174_8:GetComponent("Image")

				if var_174_10 then
					arg_171_1.var_.highlightMatValue104201_1 = var_174_10
				end
			end

			local var_174_11 = 0.034

			if var_174_9 <= arg_171_1.time_ and arg_171_1.time_ < var_174_9 + var_174_11 and not isNil(var_174_8) then
				local var_174_12 = (arg_171_1.time_ - var_174_9) / var_174_11

				if arg_171_1.var_.highlightMatValue104201_1 then
					local var_174_13 = Mathf.Lerp(1, 0.5, var_174_12)
					local var_174_14 = arg_171_1.var_.highlightMatValue104201_1
					local var_174_15 = var_174_14.color

					var_174_15.r = var_174_13
					var_174_15.g = var_174_13
					var_174_15.b = var_174_13
					var_174_14.color = var_174_15
				end
			end

			if arg_171_1.time_ >= var_174_9 + var_174_11 and arg_171_1.time_ < var_174_9 + var_174_11 + arg_174_0 and not isNil(var_174_8) and arg_171_1.var_.highlightMatValue104201_1 then
				local var_174_16 = 0.5
				local var_174_17 = arg_171_1.var_.highlightMatValue104201_1
				local var_174_18 = var_174_17.color

				var_174_18.r = var_174_16
				var_174_18.g = var_174_16
				var_174_18.b = var_174_16
				var_174_17.color = var_174_18
			end

			local var_174_19 = 0
			local var_174_20 = 0.825

			if var_174_19 < arg_171_1.time_ and arg_171_1.time_ <= var_174_19 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_21 = arg_171_1:FormatText(StoryNameCfg[258].name)

				arg_171_1.leftNameTxt_.text = var_174_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_22 = arg_171_1:GetWordFromCfg(114242042)
				local var_174_23 = arg_171_1:FormatText(var_174_22.content)

				arg_171_1.text_.text = var_174_23

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_24 = 33
				local var_174_25 = utf8.len(var_174_23)
				local var_174_26 = var_174_24 <= 0 and var_174_20 or var_174_20 * (var_174_25 / var_174_24)

				if var_174_26 > 0 and var_174_20 < var_174_26 then
					arg_171_1.talkMaxDuration = var_174_26

					if var_174_26 + var_174_19 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_26 + var_174_19
					end
				end

				arg_171_1.text_.text = var_174_23
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242042", "story_v_out_114242.awb") ~= 0 then
					local var_174_27 = manager.audio:GetVoiceLength("story_v_out_114242", "114242042", "story_v_out_114242.awb") / 1000

					if var_174_27 + var_174_19 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_27 + var_174_19
					end

					if var_174_22.prefab_name ~= "" and arg_171_1.actors_[var_174_22.prefab_name] ~= nil then
						local var_174_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_22.prefab_name].transform, "story_v_out_114242", "114242042", "story_v_out_114242.awb")

						arg_171_1:RecordAudio("114242042", var_174_28)
						arg_171_1:RecordAudio("114242042", var_174_28)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_114242", "114242042", "story_v_out_114242.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_114242", "114242042", "story_v_out_114242.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_29 = math.max(var_174_20, arg_171_1.talkMaxDuration)

			if var_174_19 <= arg_171_1.time_ and arg_171_1.time_ < var_174_19 + var_174_29 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_19) / var_174_29

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_19 + var_174_29 and arg_171_1.time_ < var_174_19 + var_174_29 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play114242043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 114242043
		arg_175_1.duration_ = 7

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play114242044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				local var_178_1 = manager.ui.mainCamera.transform.localPosition
				local var_178_2 = Vector3.New(0, 0, 10) + Vector3.New(var_178_1.x, var_178_1.y, 0)
				local var_178_3 = arg_175_1.bgs_.ST25

				var_178_3.transform.localPosition = var_178_2
				var_178_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_178_4 = var_178_3:GetComponent("SpriteRenderer")

				if var_178_4 and var_178_4.sprite then
					local var_178_5 = (var_178_3.transform.localPosition - var_178_1).z
					local var_178_6 = manager.ui.mainCameraCom_
					local var_178_7 = 2 * var_178_5 * Mathf.Tan(var_178_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_178_8 = var_178_7 * var_178_6.aspect
					local var_178_9 = var_178_4.sprite.bounds.size.x
					local var_178_10 = var_178_4.sprite.bounds.size.y
					local var_178_11 = var_178_8 / var_178_9
					local var_178_12 = var_178_7 / var_178_10
					local var_178_13 = var_178_12 < var_178_11 and var_178_11 or var_178_12

					var_178_3.transform.localScale = Vector3.New(var_178_13, var_178_13, 0)
				end

				for iter_178_0, iter_178_1 in pairs(arg_175_1.bgs_) do
					if iter_178_0 ~= "ST25" then
						iter_178_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_178_14 = 0

			if var_178_14 < arg_175_1.time_ and arg_175_1.time_ <= var_178_14 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_15 = 2

			if var_178_14 <= arg_175_1.time_ and arg_175_1.time_ < var_178_14 + var_178_15 then
				local var_178_16 = (arg_175_1.time_ - var_178_14) / var_178_15
				local var_178_17 = Color.New(1, 1, 1)

				var_178_17.a = Mathf.Lerp(1, 0, var_178_16)
				arg_175_1.mask_.color = var_178_17
			end

			if arg_175_1.time_ >= var_178_14 + var_178_15 and arg_175_1.time_ < var_178_14 + var_178_15 + arg_178_0 then
				local var_178_18 = Color.New(1, 1, 1)
				local var_178_19 = 0

				arg_175_1.mask_.enabled = false
				var_178_18.a = var_178_19
				arg_175_1.mask_.color = var_178_18
			end

			local var_178_20 = arg_175_1.actors_["10018"].transform
			local var_178_21 = 0

			if var_178_21 < arg_175_1.time_ and arg_175_1.time_ <= var_178_21 + arg_178_0 then
				arg_175_1.var_.moveOldPos10018 = var_178_20.localPosition
				var_178_20.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("10018", 7)

				local var_178_22 = var_178_20.childCount

				for iter_178_2 = 0, var_178_22 - 1 do
					local var_178_23 = var_178_20:GetChild(iter_178_2)

					if var_178_23.name == "split_1" or not string.find(var_178_23.name, "split") then
						var_178_23.gameObject:SetActive(true)
					else
						var_178_23.gameObject:SetActive(false)
					end
				end
			end

			local var_178_24 = 0.001

			if var_178_21 <= arg_175_1.time_ and arg_175_1.time_ < var_178_21 + var_178_24 then
				local var_178_25 = (arg_175_1.time_ - var_178_21) / var_178_24
				local var_178_26 = Vector3.New(0, -2000, -180)

				var_178_20.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10018, var_178_26, var_178_25)
			end

			if arg_175_1.time_ >= var_178_21 + var_178_24 and arg_175_1.time_ < var_178_21 + var_178_24 + arg_178_0 then
				var_178_20.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_178_27 = arg_175_1.actors_["104201_1"].transform
			local var_178_28 = 0

			if var_178_28 < arg_175_1.time_ and arg_175_1.time_ <= var_178_28 + arg_178_0 then
				arg_175_1.var_.moveOldPos104201_1 = var_178_27.localPosition
				var_178_27.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("104201_1", 7)
			end

			local var_178_29 = 0.001

			if var_178_28 <= arg_175_1.time_ and arg_175_1.time_ < var_178_28 + var_178_29 then
				local var_178_30 = (arg_175_1.time_ - var_178_28) / var_178_29
				local var_178_31 = Vector3.New(0, -2000, -180)

				var_178_27.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos104201_1, var_178_31, var_178_30)
			end

			if arg_175_1.time_ >= var_178_28 + var_178_29 and arg_175_1.time_ < var_178_28 + var_178_29 + arg_178_0 then
				var_178_27.localPosition = Vector3.New(0, -2000, -180)
			end

			if arg_175_1.frameCnt_ <= 1 then
				arg_175_1.dialog_:SetActive(false)
			end

			local var_178_32 = 2
			local var_178_33 = 0.05

			if var_178_32 < arg_175_1.time_ and arg_175_1.time_ <= var_178_32 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				arg_175_1.dialog_:SetActive(true)

				arg_175_1.dialogCg_.alpha = 0

				local var_178_34 = LeanTween.value(arg_175_1.dialog_, 0, 1, 0.3)

				var_178_34:setOnUpdate(LuaHelper.FloatAction(function(arg_179_0)
					arg_175_1.dialogCg_.alpha = arg_179_0
				end))
				var_178_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_175_1.dialog_)
					var_178_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_175_1.duration_ = arg_175_1.duration_ + 0.3

				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_35 = arg_175_1:GetWordFromCfg(114242043)
				local var_178_36 = arg_175_1:FormatText(var_178_35.content)

				arg_175_1.text_.text = var_178_36

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_37 = 2
				local var_178_38 = utf8.len(var_178_36)
				local var_178_39 = var_178_37 <= 0 and var_178_33 or var_178_33 * (var_178_38 / var_178_37)

				if var_178_39 > 0 and var_178_33 < var_178_39 then
					arg_175_1.talkMaxDuration = var_178_39
					var_178_32 = var_178_32 + 0.3

					if var_178_39 + var_178_32 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_39 + var_178_32
					end
				end

				arg_175_1.text_.text = var_178_36
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_40 = var_178_32 + 0.3
			local var_178_41 = math.max(var_178_33, arg_175_1.talkMaxDuration)

			if var_178_40 <= arg_175_1.time_ and arg_175_1.time_ < var_178_40 + var_178_41 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_40) / var_178_41

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_40 + var_178_41 and arg_175_1.time_ < var_178_40 + var_178_41 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104201_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play114242044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 114242044
		arg_181_1.duration_ = 3

		local var_181_0 = {
			ja = 2.9,
			ko = 2.233,
			zh = 3,
			en = 2.3
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
				arg_181_0:Play114242045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10015"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos10015 = var_184_0.localPosition
				var_184_0.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10015", 4)

				local var_184_2 = var_184_0.childCount

				for iter_184_0 = 0, var_184_2 - 1 do
					local var_184_3 = var_184_0:GetChild(iter_184_0)

					if var_184_3.name == "split_1" or not string.find(var_184_3.name, "split") then
						var_184_3.gameObject:SetActive(true)
					else
						var_184_3.gameObject:SetActive(false)
					end
				end
			end

			local var_184_4 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_4 then
				local var_184_5 = (arg_181_1.time_ - var_184_1) / var_184_4
				local var_184_6 = Vector3.New(390, -350, -180)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10015, var_184_6, var_184_5)
			end

			if arg_181_1.time_ >= var_184_1 + var_184_4 and arg_181_1.time_ < var_184_1 + var_184_4 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_184_7 = arg_181_1.actors_["10015"]
			local var_184_8 = 0

			if var_184_8 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 and not isNil(var_184_7) and arg_181_1.var_.actorSpriteComps10015 == nil then
				arg_181_1.var_.actorSpriteComps10015 = var_184_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_9 = 0.034

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_9 and not isNil(var_184_7) then
				local var_184_10 = (arg_181_1.time_ - var_184_8) / var_184_9

				if arg_181_1.var_.actorSpriteComps10015 then
					for iter_184_1, iter_184_2 in pairs(arg_181_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_184_2 then
							if arg_181_1.isInRecall_ then
								local var_184_11 = Mathf.Lerp(iter_184_2.color.r, arg_181_1.hightColor1.r, var_184_10)
								local var_184_12 = Mathf.Lerp(iter_184_2.color.g, arg_181_1.hightColor1.g, var_184_10)
								local var_184_13 = Mathf.Lerp(iter_184_2.color.b, arg_181_1.hightColor1.b, var_184_10)

								iter_184_2.color = Color.New(var_184_11, var_184_12, var_184_13)
							else
								local var_184_14 = Mathf.Lerp(iter_184_2.color.r, 1, var_184_10)

								iter_184_2.color = Color.New(var_184_14, var_184_14, var_184_14)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_8 + var_184_9 and arg_181_1.time_ < var_184_8 + var_184_9 + arg_184_0 and not isNil(var_184_7) and arg_181_1.var_.actorSpriteComps10015 then
				for iter_184_3, iter_184_4 in pairs(arg_181_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_184_4 then
						if arg_181_1.isInRecall_ then
							iter_184_4.color = arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_184_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps10015 = nil
			end

			local var_184_15 = arg_181_1.actors_["10015"]
			local var_184_16 = 0

			if var_184_16 < arg_181_1.time_ and arg_181_1.time_ <= var_184_16 + arg_184_0 then
				local var_184_17 = var_184_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_184_17 then
					arg_181_1.var_.alphaOldValue10015 = var_184_17.alpha
					arg_181_1.var_.characterEffect10015 = var_184_17
				end

				arg_181_1.var_.alphaOldValue10015 = 0
			end

			local var_184_18 = 0.5

			if var_184_16 <= arg_181_1.time_ and arg_181_1.time_ < var_184_16 + var_184_18 then
				local var_184_19 = (arg_181_1.time_ - var_184_16) / var_184_18
				local var_184_20 = Mathf.Lerp(arg_181_1.var_.alphaOldValue10015, 1, var_184_19)

				if arg_181_1.var_.characterEffect10015 then
					arg_181_1.var_.characterEffect10015.alpha = var_184_20
				end
			end

			if arg_181_1.time_ >= var_184_16 + var_184_18 and arg_181_1.time_ < var_184_16 + var_184_18 + arg_184_0 and arg_181_1.var_.characterEffect10015 then
				arg_181_1.var_.characterEffect10015.alpha = 1
			end

			local var_184_21 = 0
			local var_184_22 = 0.3

			if var_184_21 < arg_181_1.time_ and arg_181_1.time_ <= var_184_21 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_23 = arg_181_1:FormatText(StoryNameCfg[208].name)

				arg_181_1.leftNameTxt_.text = var_184_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_24 = arg_181_1:GetWordFromCfg(114242044)
				local var_184_25 = arg_181_1:FormatText(var_184_24.content)

				arg_181_1.text_.text = var_184_25

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_26 = 12
				local var_184_27 = utf8.len(var_184_25)
				local var_184_28 = var_184_26 <= 0 and var_184_22 or var_184_22 * (var_184_27 / var_184_26)

				if var_184_28 > 0 and var_184_22 < var_184_28 then
					arg_181_1.talkMaxDuration = var_184_28

					if var_184_28 + var_184_21 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_28 + var_184_21
					end
				end

				arg_181_1.text_.text = var_184_25
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242044", "story_v_out_114242.awb") ~= 0 then
					local var_184_29 = manager.audio:GetVoiceLength("story_v_out_114242", "114242044", "story_v_out_114242.awb") / 1000

					if var_184_29 + var_184_21 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_29 + var_184_21
					end

					if var_184_24.prefab_name ~= "" and arg_181_1.actors_[var_184_24.prefab_name] ~= nil then
						local var_184_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_24.prefab_name].transform, "story_v_out_114242", "114242044", "story_v_out_114242.awb")

						arg_181_1:RecordAudio("114242044", var_184_30)
						arg_181_1:RecordAudio("114242044", var_184_30)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_114242", "114242044", "story_v_out_114242.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_114242", "114242044", "story_v_out_114242.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_31 = math.max(var_184_22, arg_181_1.talkMaxDuration)

			if var_184_21 <= arg_181_1.time_ and arg_181_1.time_ < var_184_21 + var_184_31 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_21) / var_184_31

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_21 + var_184_31 and arg_181_1.time_ < var_184_21 + var_184_31 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
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
	Play114242045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 114242045
		arg_185_1.duration_ = 3.5

		local var_185_0 = {
			ja = 2.3,
			ko = 3.466,
			zh = 3.5,
			en = 3.3
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
				arg_185_0:Play114242046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10018"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos10018 = var_188_0.localPosition
				var_188_0.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("10018", 2)

				local var_188_2 = var_188_0.childCount

				for iter_188_0 = 0, var_188_2 - 1 do
					local var_188_3 = var_188_0:GetChild(iter_188_0)

					if var_188_3.name == "split_2" or not string.find(var_188_3.name, "split") then
						var_188_3.gameObject:SetActive(true)
					else
						var_188_3.gameObject:SetActive(false)
					end
				end
			end

			local var_188_4 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_4 then
				local var_188_5 = (arg_185_1.time_ - var_188_1) / var_188_4
				local var_188_6 = Vector3.New(-390, -350, -180)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10018, var_188_6, var_188_5)
			end

			if arg_185_1.time_ >= var_188_1 + var_188_4 and arg_185_1.time_ < var_188_1 + var_188_4 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_188_7 = arg_185_1.actors_["10015"]
			local var_188_8 = 0

			if var_188_8 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 and not isNil(var_188_7) and arg_185_1.var_.actorSpriteComps10015 == nil then
				arg_185_1.var_.actorSpriteComps10015 = var_188_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_9 = 0.034

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_9 and not isNil(var_188_7) then
				local var_188_10 = (arg_185_1.time_ - var_188_8) / var_188_9

				if arg_185_1.var_.actorSpriteComps10015 then
					for iter_188_1, iter_188_2 in pairs(arg_185_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_188_2 then
							if arg_185_1.isInRecall_ then
								local var_188_11 = Mathf.Lerp(iter_188_2.color.r, arg_185_1.hightColor2.r, var_188_10)
								local var_188_12 = Mathf.Lerp(iter_188_2.color.g, arg_185_1.hightColor2.g, var_188_10)
								local var_188_13 = Mathf.Lerp(iter_188_2.color.b, arg_185_1.hightColor2.b, var_188_10)

								iter_188_2.color = Color.New(var_188_11, var_188_12, var_188_13)
							else
								local var_188_14 = Mathf.Lerp(iter_188_2.color.r, 0.5, var_188_10)

								iter_188_2.color = Color.New(var_188_14, var_188_14, var_188_14)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_8 + var_188_9 and arg_185_1.time_ < var_188_8 + var_188_9 + arg_188_0 and not isNil(var_188_7) and arg_185_1.var_.actorSpriteComps10015 then
				for iter_188_3, iter_188_4 in pairs(arg_185_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_188_4 then
						if arg_185_1.isInRecall_ then
							iter_188_4.color = arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_188_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps10015 = nil
			end

			local var_188_15 = arg_185_1.actors_["10018"]
			local var_188_16 = 0

			if var_188_16 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 and not isNil(var_188_15) and arg_185_1.var_.actorSpriteComps10018 == nil then
				arg_185_1.var_.actorSpriteComps10018 = var_188_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_17 = 0.034

			if var_188_16 <= arg_185_1.time_ and arg_185_1.time_ < var_188_16 + var_188_17 and not isNil(var_188_15) then
				local var_188_18 = (arg_185_1.time_ - var_188_16) / var_188_17

				if arg_185_1.var_.actorSpriteComps10018 then
					for iter_188_5, iter_188_6 in pairs(arg_185_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_188_6 then
							if arg_185_1.isInRecall_ then
								local var_188_19 = Mathf.Lerp(iter_188_6.color.r, arg_185_1.hightColor1.r, var_188_18)
								local var_188_20 = Mathf.Lerp(iter_188_6.color.g, arg_185_1.hightColor1.g, var_188_18)
								local var_188_21 = Mathf.Lerp(iter_188_6.color.b, arg_185_1.hightColor1.b, var_188_18)

								iter_188_6.color = Color.New(var_188_19, var_188_20, var_188_21)
							else
								local var_188_22 = Mathf.Lerp(iter_188_6.color.r, 1, var_188_18)

								iter_188_6.color = Color.New(var_188_22, var_188_22, var_188_22)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_16 + var_188_17 and arg_185_1.time_ < var_188_16 + var_188_17 + arg_188_0 and not isNil(var_188_15) and arg_185_1.var_.actorSpriteComps10018 then
				for iter_188_7, iter_188_8 in pairs(arg_185_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_188_8 then
						if arg_185_1.isInRecall_ then
							iter_188_8.color = arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_188_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps10018 = nil
			end

			local var_188_23 = arg_185_1.actors_["10018"]
			local var_188_24 = 0

			if var_188_24 < arg_185_1.time_ and arg_185_1.time_ <= var_188_24 + arg_188_0 then
				local var_188_25 = var_188_23:GetComponentInChildren(typeof(CanvasGroup))

				if var_188_25 then
					arg_185_1.var_.alphaOldValue10018 = var_188_25.alpha
					arg_185_1.var_.characterEffect10018 = var_188_25
				end

				arg_185_1.var_.alphaOldValue10018 = 0
			end

			local var_188_26 = 0.5

			if var_188_24 <= arg_185_1.time_ and arg_185_1.time_ < var_188_24 + var_188_26 then
				local var_188_27 = (arg_185_1.time_ - var_188_24) / var_188_26
				local var_188_28 = Mathf.Lerp(arg_185_1.var_.alphaOldValue10018, 1, var_188_27)

				if arg_185_1.var_.characterEffect10018 then
					arg_185_1.var_.characterEffect10018.alpha = var_188_28
				end
			end

			if arg_185_1.time_ >= var_188_24 + var_188_26 and arg_185_1.time_ < var_188_24 + var_188_26 + arg_188_0 and arg_185_1.var_.characterEffect10018 then
				arg_185_1.var_.characterEffect10018.alpha = 1
			end

			local var_188_29 = 0
			local var_188_30 = 0.15

			if var_188_29 < arg_185_1.time_ and arg_185_1.time_ <= var_188_29 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_31 = arg_185_1:FormatText(StoryNameCfg[257].name)

				arg_185_1.leftNameTxt_.text = var_188_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_32 = arg_185_1:GetWordFromCfg(114242045)
				local var_188_33 = arg_185_1:FormatText(var_188_32.content)

				arg_185_1.text_.text = var_188_33

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_34 = 6
				local var_188_35 = utf8.len(var_188_33)
				local var_188_36 = var_188_34 <= 0 and var_188_30 or var_188_30 * (var_188_35 / var_188_34)

				if var_188_36 > 0 and var_188_30 < var_188_36 then
					arg_185_1.talkMaxDuration = var_188_36

					if var_188_36 + var_188_29 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_36 + var_188_29
					end
				end

				arg_185_1.text_.text = var_188_33
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242045", "story_v_out_114242.awb") ~= 0 then
					local var_188_37 = manager.audio:GetVoiceLength("story_v_out_114242", "114242045", "story_v_out_114242.awb") / 1000

					if var_188_37 + var_188_29 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_37 + var_188_29
					end

					if var_188_32.prefab_name ~= "" and arg_185_1.actors_[var_188_32.prefab_name] ~= nil then
						local var_188_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_32.prefab_name].transform, "story_v_out_114242", "114242045", "story_v_out_114242.awb")

						arg_185_1:RecordAudio("114242045", var_188_38)
						arg_185_1:RecordAudio("114242045", var_188_38)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_114242", "114242045", "story_v_out_114242.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_114242", "114242045", "story_v_out_114242.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_39 = math.max(var_188_30, arg_185_1.talkMaxDuration)

			if var_188_29 <= arg_185_1.time_ and arg_185_1.time_ < var_188_29 + var_188_39 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_29) / var_188_39

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_29 + var_188_39 and arg_185_1.time_ < var_188_29 + var_188_39 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play114242046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 114242046
		arg_189_1.duration_ = 1.9

		local var_189_0 = {
			ja = 0.999999999999,
			ko = 1.433,
			zh = 1.9,
			en = 1.233
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play114242047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10015"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.actorSpriteComps10015 == nil then
				arg_189_1.var_.actorSpriteComps10015 = var_192_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_2 = 0.034

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.actorSpriteComps10015 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_192_1 then
							if arg_189_1.isInRecall_ then
								local var_192_4 = Mathf.Lerp(iter_192_1.color.r, arg_189_1.hightColor1.r, var_192_3)
								local var_192_5 = Mathf.Lerp(iter_192_1.color.g, arg_189_1.hightColor1.g, var_192_3)
								local var_192_6 = Mathf.Lerp(iter_192_1.color.b, arg_189_1.hightColor1.b, var_192_3)

								iter_192_1.color = Color.New(var_192_4, var_192_5, var_192_6)
							else
								local var_192_7 = Mathf.Lerp(iter_192_1.color.r, 1, var_192_3)

								iter_192_1.color = Color.New(var_192_7, var_192_7, var_192_7)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.actorSpriteComps10015 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_192_3 then
						if arg_189_1.isInRecall_ then
							iter_192_3.color = arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_192_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps10015 = nil
			end

			local var_192_8 = arg_189_1.actors_["10018"]
			local var_192_9 = 0

			if var_192_9 < arg_189_1.time_ and arg_189_1.time_ <= var_192_9 + arg_192_0 and not isNil(var_192_8) and arg_189_1.var_.actorSpriteComps10018 == nil then
				arg_189_1.var_.actorSpriteComps10018 = var_192_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_10 = 0.034

			if var_192_9 <= arg_189_1.time_ and arg_189_1.time_ < var_192_9 + var_192_10 and not isNil(var_192_8) then
				local var_192_11 = (arg_189_1.time_ - var_192_9) / var_192_10

				if arg_189_1.var_.actorSpriteComps10018 then
					for iter_192_4, iter_192_5 in pairs(arg_189_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_192_5 then
							if arg_189_1.isInRecall_ then
								local var_192_12 = Mathf.Lerp(iter_192_5.color.r, arg_189_1.hightColor2.r, var_192_11)
								local var_192_13 = Mathf.Lerp(iter_192_5.color.g, arg_189_1.hightColor2.g, var_192_11)
								local var_192_14 = Mathf.Lerp(iter_192_5.color.b, arg_189_1.hightColor2.b, var_192_11)

								iter_192_5.color = Color.New(var_192_12, var_192_13, var_192_14)
							else
								local var_192_15 = Mathf.Lerp(iter_192_5.color.r, 0.5, var_192_11)

								iter_192_5.color = Color.New(var_192_15, var_192_15, var_192_15)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_9 + var_192_10 and arg_189_1.time_ < var_192_9 + var_192_10 + arg_192_0 and not isNil(var_192_8) and arg_189_1.var_.actorSpriteComps10018 then
				for iter_192_6, iter_192_7 in pairs(arg_189_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_192_7 then
						if arg_189_1.isInRecall_ then
							iter_192_7.color = arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_192_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps10018 = nil
			end

			local var_192_16 = arg_189_1.actors_["10015"].transform
			local var_192_17 = 0

			if var_192_17 < arg_189_1.time_ and arg_189_1.time_ <= var_192_17 + arg_192_0 then
				arg_189_1.var_.moveOldPos10015 = var_192_16.localPosition
				var_192_16.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10015", 4)

				local var_192_18 = var_192_16.childCount

				for iter_192_8 = 0, var_192_18 - 1 do
					local var_192_19 = var_192_16:GetChild(iter_192_8)

					if var_192_19.name == "split_5" or not string.find(var_192_19.name, "split") then
						var_192_19.gameObject:SetActive(true)
					else
						var_192_19.gameObject:SetActive(false)
					end
				end
			end

			local var_192_20 = 0.001

			if var_192_17 <= arg_189_1.time_ and arg_189_1.time_ < var_192_17 + var_192_20 then
				local var_192_21 = (arg_189_1.time_ - var_192_17) / var_192_20
				local var_192_22 = Vector3.New(390, -350, -180)

				var_192_16.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10015, var_192_22, var_192_21)
			end

			if arg_189_1.time_ >= var_192_17 + var_192_20 and arg_189_1.time_ < var_192_17 + var_192_20 + arg_192_0 then
				var_192_16.localPosition = Vector3.New(390, -350, -180)
			end

			local var_192_23 = 0
			local var_192_24 = 0.075

			if var_192_23 < arg_189_1.time_ and arg_189_1.time_ <= var_192_23 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_25 = arg_189_1:FormatText(StoryNameCfg[208].name)

				arg_189_1.leftNameTxt_.text = var_192_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_26 = arg_189_1:GetWordFromCfg(114242046)
				local var_192_27 = arg_189_1:FormatText(var_192_26.content)

				arg_189_1.text_.text = var_192_27

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_28 = 3
				local var_192_29 = utf8.len(var_192_27)
				local var_192_30 = var_192_28 <= 0 and var_192_24 or var_192_24 * (var_192_29 / var_192_28)

				if var_192_30 > 0 and var_192_24 < var_192_30 then
					arg_189_1.talkMaxDuration = var_192_30

					if var_192_30 + var_192_23 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_30 + var_192_23
					end
				end

				arg_189_1.text_.text = var_192_27
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242046", "story_v_out_114242.awb") ~= 0 then
					local var_192_31 = manager.audio:GetVoiceLength("story_v_out_114242", "114242046", "story_v_out_114242.awb") / 1000

					if var_192_31 + var_192_23 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_31 + var_192_23
					end

					if var_192_26.prefab_name ~= "" and arg_189_1.actors_[var_192_26.prefab_name] ~= nil then
						local var_192_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_26.prefab_name].transform, "story_v_out_114242", "114242046", "story_v_out_114242.awb")

						arg_189_1:RecordAudio("114242046", var_192_32)
						arg_189_1:RecordAudio("114242046", var_192_32)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_114242", "114242046", "story_v_out_114242.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_114242", "114242046", "story_v_out_114242.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_33 = math.max(var_192_24, arg_189_1.talkMaxDuration)

			if var_192_23 <= arg_189_1.time_ and arg_189_1.time_ < var_192_23 + var_192_33 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_23) / var_192_33

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_23 + var_192_33 and arg_189_1.time_ < var_192_23 + var_192_33 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
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
	Play114242047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 114242047
		arg_193_1.duration_ = 10.6

		local var_193_0 = {
			ja = 8.3,
			ko = 8.9,
			zh = 10.6,
			en = 8.633
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
				arg_193_0:Play114242048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10015"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps10015 == nil then
				arg_193_1.var_.actorSpriteComps10015 = var_196_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_2 = 0.034

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.actorSpriteComps10015 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_196_1 then
							if arg_193_1.isInRecall_ then
								local var_196_4 = Mathf.Lerp(iter_196_1.color.r, arg_193_1.hightColor2.r, var_196_3)
								local var_196_5 = Mathf.Lerp(iter_196_1.color.g, arg_193_1.hightColor2.g, var_196_3)
								local var_196_6 = Mathf.Lerp(iter_196_1.color.b, arg_193_1.hightColor2.b, var_196_3)

								iter_196_1.color = Color.New(var_196_4, var_196_5, var_196_6)
							else
								local var_196_7 = Mathf.Lerp(iter_196_1.color.r, 0.5, var_196_3)

								iter_196_1.color = Color.New(var_196_7, var_196_7, var_196_7)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps10015 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_196_3 then
						if arg_193_1.isInRecall_ then
							iter_196_3.color = arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_196_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10015 = nil
			end

			local var_196_8 = arg_193_1.actors_["10018"]
			local var_196_9 = 0

			if var_196_9 < arg_193_1.time_ and arg_193_1.time_ <= var_196_9 + arg_196_0 and not isNil(var_196_8) and arg_193_1.var_.actorSpriteComps10018 == nil then
				arg_193_1.var_.actorSpriteComps10018 = var_196_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_10 = 0.034

			if var_196_9 <= arg_193_1.time_ and arg_193_1.time_ < var_196_9 + var_196_10 and not isNil(var_196_8) then
				local var_196_11 = (arg_193_1.time_ - var_196_9) / var_196_10

				if arg_193_1.var_.actorSpriteComps10018 then
					for iter_196_4, iter_196_5 in pairs(arg_193_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_196_5 then
							if arg_193_1.isInRecall_ then
								local var_196_12 = Mathf.Lerp(iter_196_5.color.r, arg_193_1.hightColor1.r, var_196_11)
								local var_196_13 = Mathf.Lerp(iter_196_5.color.g, arg_193_1.hightColor1.g, var_196_11)
								local var_196_14 = Mathf.Lerp(iter_196_5.color.b, arg_193_1.hightColor1.b, var_196_11)

								iter_196_5.color = Color.New(var_196_12, var_196_13, var_196_14)
							else
								local var_196_15 = Mathf.Lerp(iter_196_5.color.r, 1, var_196_11)

								iter_196_5.color = Color.New(var_196_15, var_196_15, var_196_15)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_9 + var_196_10 and arg_193_1.time_ < var_196_9 + var_196_10 + arg_196_0 and not isNil(var_196_8) and arg_193_1.var_.actorSpriteComps10018 then
				for iter_196_6, iter_196_7 in pairs(arg_193_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_196_7 then
						if arg_193_1.isInRecall_ then
							iter_196_7.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_196_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10018 = nil
			end

			local var_196_16 = arg_193_1.actors_["10018"].transform
			local var_196_17 = 0

			if var_196_17 < arg_193_1.time_ and arg_193_1.time_ <= var_196_17 + arg_196_0 then
				arg_193_1.var_.moveOldPos10018 = var_196_16.localPosition
				var_196_16.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10018", 2)

				local var_196_18 = var_196_16.childCount

				for iter_196_8 = 0, var_196_18 - 1 do
					local var_196_19 = var_196_16:GetChild(iter_196_8)

					if var_196_19.name == "split_1" or not string.find(var_196_19.name, "split") then
						var_196_19.gameObject:SetActive(true)
					else
						var_196_19.gameObject:SetActive(false)
					end
				end
			end

			local var_196_20 = 0.001

			if var_196_17 <= arg_193_1.time_ and arg_193_1.time_ < var_196_17 + var_196_20 then
				local var_196_21 = (arg_193_1.time_ - var_196_17) / var_196_20
				local var_196_22 = Vector3.New(-390, -350, -180)

				var_196_16.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10018, var_196_22, var_196_21)
			end

			if arg_193_1.time_ >= var_196_17 + var_196_20 and arg_193_1.time_ < var_196_17 + var_196_20 + arg_196_0 then
				var_196_16.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_196_23 = 0
			local var_196_24 = 1.025

			if var_196_23 < arg_193_1.time_ and arg_193_1.time_ <= var_196_23 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_25 = arg_193_1:FormatText(StoryNameCfg[257].name)

				arg_193_1.leftNameTxt_.text = var_196_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_26 = arg_193_1:GetWordFromCfg(114242047)
				local var_196_27 = arg_193_1:FormatText(var_196_26.content)

				arg_193_1.text_.text = var_196_27

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_28 = 41
				local var_196_29 = utf8.len(var_196_27)
				local var_196_30 = var_196_28 <= 0 and var_196_24 or var_196_24 * (var_196_29 / var_196_28)

				if var_196_30 > 0 and var_196_24 < var_196_30 then
					arg_193_1.talkMaxDuration = var_196_30

					if var_196_30 + var_196_23 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_30 + var_196_23
					end
				end

				arg_193_1.text_.text = var_196_27
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242047", "story_v_out_114242.awb") ~= 0 then
					local var_196_31 = manager.audio:GetVoiceLength("story_v_out_114242", "114242047", "story_v_out_114242.awb") / 1000

					if var_196_31 + var_196_23 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_31 + var_196_23
					end

					if var_196_26.prefab_name ~= "" and arg_193_1.actors_[var_196_26.prefab_name] ~= nil then
						local var_196_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_26.prefab_name].transform, "story_v_out_114242", "114242047", "story_v_out_114242.awb")

						arg_193_1:RecordAudio("114242047", var_196_32)
						arg_193_1:RecordAudio("114242047", var_196_32)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_114242", "114242047", "story_v_out_114242.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_114242", "114242047", "story_v_out_114242.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_33 = math.max(var_196_24, arg_193_1.talkMaxDuration)

			if var_196_23 <= arg_193_1.time_ and arg_193_1.time_ < var_196_23 + var_196_33 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_23) / var_196_33

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_23 + var_196_33 and arg_193_1.time_ < var_196_23 + var_196_33 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
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
	Play114242048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 114242048
		arg_197_1.duration_ = 6.97

		local var_197_0 = {
			ja = 6.8,
			ko = 5.5,
			zh = 6.533,
			en = 6.966
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
				arg_197_0:Play114242049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["10018"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.actorSpriteComps10018 == nil then
				arg_197_1.var_.actorSpriteComps10018 = var_200_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_2 = 0.034

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.actorSpriteComps10018 then
					for iter_200_0, iter_200_1 in pairs(arg_197_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_200_1 then
							if arg_197_1.isInRecall_ then
								local var_200_4 = Mathf.Lerp(iter_200_1.color.r, arg_197_1.hightColor2.r, var_200_3)
								local var_200_5 = Mathf.Lerp(iter_200_1.color.g, arg_197_1.hightColor2.g, var_200_3)
								local var_200_6 = Mathf.Lerp(iter_200_1.color.b, arg_197_1.hightColor2.b, var_200_3)

								iter_200_1.color = Color.New(var_200_4, var_200_5, var_200_6)
							else
								local var_200_7 = Mathf.Lerp(iter_200_1.color.r, 0.5, var_200_3)

								iter_200_1.color = Color.New(var_200_7, var_200_7, var_200_7)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.actorSpriteComps10018 then
				for iter_200_2, iter_200_3 in pairs(arg_197_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_200_3 then
						if arg_197_1.isInRecall_ then
							iter_200_3.color = arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_200_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps10018 = nil
			end

			local var_200_8 = arg_197_1.actors_["10015"]
			local var_200_9 = 0

			if var_200_9 < arg_197_1.time_ and arg_197_1.time_ <= var_200_9 + arg_200_0 and not isNil(var_200_8) and arg_197_1.var_.actorSpriteComps10015 == nil then
				arg_197_1.var_.actorSpriteComps10015 = var_200_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_10 = 0.034

			if var_200_9 <= arg_197_1.time_ and arg_197_1.time_ < var_200_9 + var_200_10 and not isNil(var_200_8) then
				local var_200_11 = (arg_197_1.time_ - var_200_9) / var_200_10

				if arg_197_1.var_.actorSpriteComps10015 then
					for iter_200_4, iter_200_5 in pairs(arg_197_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_200_5 then
							if arg_197_1.isInRecall_ then
								local var_200_12 = Mathf.Lerp(iter_200_5.color.r, arg_197_1.hightColor1.r, var_200_11)
								local var_200_13 = Mathf.Lerp(iter_200_5.color.g, arg_197_1.hightColor1.g, var_200_11)
								local var_200_14 = Mathf.Lerp(iter_200_5.color.b, arg_197_1.hightColor1.b, var_200_11)

								iter_200_5.color = Color.New(var_200_12, var_200_13, var_200_14)
							else
								local var_200_15 = Mathf.Lerp(iter_200_5.color.r, 1, var_200_11)

								iter_200_5.color = Color.New(var_200_15, var_200_15, var_200_15)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_9 + var_200_10 and arg_197_1.time_ < var_200_9 + var_200_10 + arg_200_0 and not isNil(var_200_8) and arg_197_1.var_.actorSpriteComps10015 then
				for iter_200_6, iter_200_7 in pairs(arg_197_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_200_7 then
						if arg_197_1.isInRecall_ then
							iter_200_7.color = arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_200_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps10015 = nil
			end

			local var_200_16 = 0
			local var_200_17 = 0.675

			if var_200_16 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_18 = arg_197_1:FormatText(StoryNameCfg[208].name)

				arg_197_1.leftNameTxt_.text = var_200_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_19 = arg_197_1:GetWordFromCfg(114242048)
				local var_200_20 = arg_197_1:FormatText(var_200_19.content)

				arg_197_1.text_.text = var_200_20

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_21 = 27
				local var_200_22 = utf8.len(var_200_20)
				local var_200_23 = var_200_21 <= 0 and var_200_17 or var_200_17 * (var_200_22 / var_200_21)

				if var_200_23 > 0 and var_200_17 < var_200_23 then
					arg_197_1.talkMaxDuration = var_200_23

					if var_200_23 + var_200_16 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_23 + var_200_16
					end
				end

				arg_197_1.text_.text = var_200_20
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242048", "story_v_out_114242.awb") ~= 0 then
					local var_200_24 = manager.audio:GetVoiceLength("story_v_out_114242", "114242048", "story_v_out_114242.awb") / 1000

					if var_200_24 + var_200_16 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_24 + var_200_16
					end

					if var_200_19.prefab_name ~= "" and arg_197_1.actors_[var_200_19.prefab_name] ~= nil then
						local var_200_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_19.prefab_name].transform, "story_v_out_114242", "114242048", "story_v_out_114242.awb")

						arg_197_1:RecordAudio("114242048", var_200_25)
						arg_197_1:RecordAudio("114242048", var_200_25)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_114242", "114242048", "story_v_out_114242.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_114242", "114242048", "story_v_out_114242.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_26 = math.max(var_200_17, arg_197_1.talkMaxDuration)

			if var_200_16 <= arg_197_1.time_ and arg_197_1.time_ < var_200_16 + var_200_26 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_16) / var_200_26

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_16 + var_200_26 and arg_197_1.time_ < var_200_16 + var_200_26 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play114242049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 114242049
		arg_201_1.duration_ = 9.27

		local var_201_0 = {
			ja = 6.332999999999,
			ko = 7.999999999999,
			zh = 9.265999999999,
			en = 7.532999999999
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
				arg_201_0:Play114242050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				local var_204_1 = manager.ui.mainCamera.transform.localPosition
				local var_204_2 = Vector3.New(0, 0, 10) + Vector3.New(var_204_1.x, var_204_1.y, 0)
				local var_204_3 = arg_201_1.bgs_.F01a

				var_204_3.transform.localPosition = var_204_2
				var_204_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_204_4 = var_204_3:GetComponent("SpriteRenderer")

				if var_204_4 and var_204_4.sprite then
					local var_204_5 = (var_204_3.transform.localPosition - var_204_1).z
					local var_204_6 = manager.ui.mainCameraCom_
					local var_204_7 = 2 * var_204_5 * Mathf.Tan(var_204_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_204_8 = var_204_7 * var_204_6.aspect
					local var_204_9 = var_204_4.sprite.bounds.size.x
					local var_204_10 = var_204_4.sprite.bounds.size.y
					local var_204_11 = var_204_8 / var_204_9
					local var_204_12 = var_204_7 / var_204_10
					local var_204_13 = var_204_12 < var_204_11 and var_204_11 or var_204_12

					var_204_3.transform.localScale = Vector3.New(var_204_13, var_204_13, 0)
				end

				for iter_204_0, iter_204_1 in pairs(arg_201_1.bgs_) do
					if iter_204_0 ~= "F01a" then
						iter_204_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_204_14 = arg_201_1.actors_["10015"].transform
			local var_204_15 = 0

			if var_204_15 < arg_201_1.time_ and arg_201_1.time_ <= var_204_15 + arg_204_0 then
				arg_201_1.var_.moveOldPos10015 = var_204_14.localPosition
				var_204_14.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10015", 7)

				local var_204_16 = var_204_14.childCount

				for iter_204_2 = 0, var_204_16 - 1 do
					local var_204_17 = var_204_14:GetChild(iter_204_2)

					if var_204_17.name == "split_5" or not string.find(var_204_17.name, "split") then
						var_204_17.gameObject:SetActive(true)
					else
						var_204_17.gameObject:SetActive(false)
					end
				end
			end

			local var_204_18 = 0.001

			if var_204_15 <= arg_201_1.time_ and arg_201_1.time_ < var_204_15 + var_204_18 then
				local var_204_19 = (arg_201_1.time_ - var_204_15) / var_204_18
				local var_204_20 = Vector3.New(0, -2000, 450)

				var_204_14.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10015, var_204_20, var_204_19)
			end

			if arg_201_1.time_ >= var_204_15 + var_204_18 and arg_201_1.time_ < var_204_15 + var_204_18 + arg_204_0 then
				var_204_14.localPosition = Vector3.New(0, -2000, 450)
			end

			local var_204_21 = arg_201_1.actors_["10018"].transform
			local var_204_22 = 0

			if var_204_22 < arg_201_1.time_ and arg_201_1.time_ <= var_204_22 + arg_204_0 then
				arg_201_1.var_.moveOldPos10018 = var_204_21.localPosition
				var_204_21.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10018", 7)

				local var_204_23 = var_204_21.childCount

				for iter_204_3 = 0, var_204_23 - 1 do
					local var_204_24 = var_204_21:GetChild(iter_204_3)

					if var_204_24.name == "split_1" or not string.find(var_204_24.name, "split") then
						var_204_24.gameObject:SetActive(true)
					else
						var_204_24.gameObject:SetActive(false)
					end
				end
			end

			local var_204_25 = 0.001

			if var_204_22 <= arg_201_1.time_ and arg_201_1.time_ < var_204_22 + var_204_25 then
				local var_204_26 = (arg_201_1.time_ - var_204_22) / var_204_25
				local var_204_27 = Vector3.New(0, -2000, -180)

				var_204_21.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10018, var_204_27, var_204_26)
			end

			if arg_201_1.time_ >= var_204_22 + var_204_25 and arg_201_1.time_ < var_204_22 + var_204_25 + arg_204_0 then
				var_204_21.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_204_28 = 0

			if var_204_28 < arg_201_1.time_ and arg_201_1.time_ <= var_204_28 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_29 = 2

			if var_204_28 <= arg_201_1.time_ and arg_201_1.time_ < var_204_28 + var_204_29 then
				local var_204_30 = (arg_201_1.time_ - var_204_28) / var_204_29
				local var_204_31 = Color.New(1, 1, 1)

				var_204_31.a = Mathf.Lerp(1, 0, var_204_30)
				arg_201_1.mask_.color = var_204_31
			end

			if arg_201_1.time_ >= var_204_28 + var_204_29 and arg_201_1.time_ < var_204_28 + var_204_29 + arg_204_0 then
				local var_204_32 = Color.New(1, 1, 1)
				local var_204_33 = 0

				arg_201_1.mask_.enabled = false
				var_204_32.a = var_204_33
				arg_201_1.mask_.color = var_204_32
			end

			local var_204_34 = 2

			if var_204_34 < arg_201_1.time_ and arg_201_1.time_ <= var_204_34 + arg_204_0 then
				arg_201_1.var_.shakeOldPos = var_204_21.localPosition
			end

			local var_204_35 = 0.6

			if var_204_34 <= arg_201_1.time_ and arg_201_1.time_ < var_204_34 + var_204_35 then
				local var_204_36 = (arg_201_1.time_ - var_204_34) / 0
				local var_204_37, var_204_38 = math.modf(var_204_36)

				var_204_21.localPosition = Vector3.New(var_204_38 * 0, var_204_38 * 0, var_204_38 * 0) + arg_201_1.var_.shakeOldPos
			end

			if arg_201_1.time_ >= var_204_34 + var_204_35 and arg_201_1.time_ < var_204_34 + var_204_35 + arg_204_0 then
				var_204_21.localPosition = arg_201_1.var_.shakeOldPos
			end

			if arg_201_1.frameCnt_ <= 1 then
				arg_201_1.dialog_:SetActive(false)
			end

			local var_204_39 = 1.999999999999
			local var_204_40 = 0.475

			if var_204_39 < arg_201_1.time_ and arg_201_1.time_ <= var_204_39 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0

				arg_201_1.dialog_:SetActive(true)

				arg_201_1.dialogCg_.alpha = 0

				local var_204_41 = LeanTween.value(arg_201_1.dialog_, 0, 1, 0.3)

				var_204_41:setOnUpdate(LuaHelper.FloatAction(function(arg_205_0)
					arg_201_1.dialogCg_.alpha = arg_205_0
				end))
				var_204_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_201_1.dialog_)
					var_204_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_201_1.duration_ = arg_201_1.duration_ + 0.3

				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_42 = arg_201_1:FormatText(StoryNameCfg[257].name)

				arg_201_1.leftNameTxt_.text = var_204_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10018")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_43 = arg_201_1:GetWordFromCfg(114242049)
				local var_204_44 = arg_201_1:FormatText(var_204_43.content)

				arg_201_1.text_.text = var_204_44

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_45 = 19
				local var_204_46 = utf8.len(var_204_44)
				local var_204_47 = var_204_45 <= 0 and var_204_40 or var_204_40 * (var_204_46 / var_204_45)

				if var_204_47 > 0 and var_204_40 < var_204_47 then
					arg_201_1.talkMaxDuration = var_204_47
					var_204_39 = var_204_39 + 0.3

					if var_204_47 + var_204_39 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_47 + var_204_39
					end
				end

				arg_201_1.text_.text = var_204_44
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242049", "story_v_out_114242.awb") ~= 0 then
					local var_204_48 = manager.audio:GetVoiceLength("story_v_out_114242", "114242049", "story_v_out_114242.awb") / 1000

					if var_204_48 + var_204_39 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_48 + var_204_39
					end

					if var_204_43.prefab_name ~= "" and arg_201_1.actors_[var_204_43.prefab_name] ~= nil then
						local var_204_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_43.prefab_name].transform, "story_v_out_114242", "114242049", "story_v_out_114242.awb")

						arg_201_1:RecordAudio("114242049", var_204_49)
						arg_201_1:RecordAudio("114242049", var_204_49)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_114242", "114242049", "story_v_out_114242.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_114242", "114242049", "story_v_out_114242.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_50 = var_204_39 + 0.3
			local var_204_51 = math.max(var_204_40, arg_201_1.talkMaxDuration)

			if var_204_50 <= arg_201_1.time_ and arg_201_1.time_ < var_204_50 + var_204_51 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_50) / var_204_51

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_50 + var_204_51 and arg_201_1.time_ < var_204_50 + var_204_51 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10018",
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
	Play114242050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 114242050
		arg_207_1.duration_ = 5.3

		local var_207_0 = {
			ja = 3.566,
			ko = 5.066,
			zh = 5.3,
			en = 3.933
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
				arg_207_0:Play114242051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["10018"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos10018 = var_210_0.localPosition
				var_210_0.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("10018", 3)

				local var_210_2 = var_210_0.childCount

				for iter_210_0 = 0, var_210_2 - 1 do
					local var_210_3 = var_210_0:GetChild(iter_210_0)

					if var_210_3.name == "split_5" or not string.find(var_210_3.name, "split") then
						var_210_3.gameObject:SetActive(true)
					else
						var_210_3.gameObject:SetActive(false)
					end
				end
			end

			local var_210_4 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_4 then
				local var_210_5 = (arg_207_1.time_ - var_210_1) / var_210_4
				local var_210_6 = Vector3.New(0, -350, -180)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10018, var_210_6, var_210_5)
			end

			if arg_207_1.time_ >= var_210_1 + var_210_4 and arg_207_1.time_ < var_210_1 + var_210_4 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_210_7 = arg_207_1.actors_["10018"]
			local var_210_8 = 0

			if var_210_8 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 and not isNil(var_210_7) and arg_207_1.var_.actorSpriteComps10018 == nil then
				arg_207_1.var_.actorSpriteComps10018 = var_210_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_9 = 0.034

			if var_210_8 <= arg_207_1.time_ and arg_207_1.time_ < var_210_8 + var_210_9 and not isNil(var_210_7) then
				local var_210_10 = (arg_207_1.time_ - var_210_8) / var_210_9

				if arg_207_1.var_.actorSpriteComps10018 then
					for iter_210_1, iter_210_2 in pairs(arg_207_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_210_2 then
							if arg_207_1.isInRecall_ then
								local var_210_11 = Mathf.Lerp(iter_210_2.color.r, arg_207_1.hightColor1.r, var_210_10)
								local var_210_12 = Mathf.Lerp(iter_210_2.color.g, arg_207_1.hightColor1.g, var_210_10)
								local var_210_13 = Mathf.Lerp(iter_210_2.color.b, arg_207_1.hightColor1.b, var_210_10)

								iter_210_2.color = Color.New(var_210_11, var_210_12, var_210_13)
							else
								local var_210_14 = Mathf.Lerp(iter_210_2.color.r, 1, var_210_10)

								iter_210_2.color = Color.New(var_210_14, var_210_14, var_210_14)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= var_210_8 + var_210_9 and arg_207_1.time_ < var_210_8 + var_210_9 + arg_210_0 and not isNil(var_210_7) and arg_207_1.var_.actorSpriteComps10018 then
				for iter_210_3, iter_210_4 in pairs(arg_207_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_210_4 then
						if arg_207_1.isInRecall_ then
							iter_210_4.color = arg_207_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_210_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_207_1.var_.actorSpriteComps10018 = nil
			end

			local var_210_15 = arg_207_1.actors_["10018"]
			local var_210_16 = 0

			if var_210_16 < arg_207_1.time_ and arg_207_1.time_ <= var_210_16 + arg_210_0 then
				local var_210_17 = var_210_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_210_17 then
					arg_207_1.var_.alphaOldValue10018 = var_210_17.alpha
					arg_207_1.var_.characterEffect10018 = var_210_17
				end

				arg_207_1.var_.alphaOldValue10018 = 0
			end

			local var_210_18 = 0.5

			if var_210_16 <= arg_207_1.time_ and arg_207_1.time_ < var_210_16 + var_210_18 then
				local var_210_19 = (arg_207_1.time_ - var_210_16) / var_210_18
				local var_210_20 = Mathf.Lerp(arg_207_1.var_.alphaOldValue10018, 1, var_210_19)

				if arg_207_1.var_.characterEffect10018 then
					arg_207_1.var_.characterEffect10018.alpha = var_210_20
				end
			end

			if arg_207_1.time_ >= var_210_16 + var_210_18 and arg_207_1.time_ < var_210_16 + var_210_18 + arg_210_0 and arg_207_1.var_.characterEffect10018 then
				arg_207_1.var_.characterEffect10018.alpha = 1
			end

			local var_210_21 = 0
			local var_210_22 = 0.475

			if var_210_21 < arg_207_1.time_ and arg_207_1.time_ <= var_210_21 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_23 = arg_207_1:FormatText(StoryNameCfg[257].name)

				arg_207_1.leftNameTxt_.text = var_210_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_24 = arg_207_1:GetWordFromCfg(114242050)
				local var_210_25 = arg_207_1:FormatText(var_210_24.content)

				arg_207_1.text_.text = var_210_25

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_26 = 19
				local var_210_27 = utf8.len(var_210_25)
				local var_210_28 = var_210_26 <= 0 and var_210_22 or var_210_22 * (var_210_27 / var_210_26)

				if var_210_28 > 0 and var_210_22 < var_210_28 then
					arg_207_1.talkMaxDuration = var_210_28

					if var_210_28 + var_210_21 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_28 + var_210_21
					end
				end

				arg_207_1.text_.text = var_210_25
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242050", "story_v_out_114242.awb") ~= 0 then
					local var_210_29 = manager.audio:GetVoiceLength("story_v_out_114242", "114242050", "story_v_out_114242.awb") / 1000

					if var_210_29 + var_210_21 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_29 + var_210_21
					end

					if var_210_24.prefab_name ~= "" and arg_207_1.actors_[var_210_24.prefab_name] ~= nil then
						local var_210_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_24.prefab_name].transform, "story_v_out_114242", "114242050", "story_v_out_114242.awb")

						arg_207_1:RecordAudio("114242050", var_210_30)
						arg_207_1:RecordAudio("114242050", var_210_30)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_114242", "114242050", "story_v_out_114242.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_114242", "114242050", "story_v_out_114242.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_31 = math.max(var_210_22, arg_207_1.talkMaxDuration)

			if var_210_21 <= arg_207_1.time_ and arg_207_1.time_ < var_210_21 + var_210_31 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_21) / var_210_31

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_21 + var_210_31 and arg_207_1.time_ < var_210_21 + var_210_31 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play114242051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 114242051
		arg_211_1.duration_ = 4.83

		local var_211_0 = {
			ja = 3.766,
			ko = 4.833,
			zh = 4.6,
			en = 4.3
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play114242052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["10018"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.actorSpriteComps10018 == nil then
				arg_211_1.var_.actorSpriteComps10018 = var_214_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_2 = 0.034

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.actorSpriteComps10018 then
					for iter_214_0, iter_214_1 in pairs(arg_211_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_214_1 then
							if arg_211_1.isInRecall_ then
								local var_214_4 = Mathf.Lerp(iter_214_1.color.r, arg_211_1.hightColor2.r, var_214_3)
								local var_214_5 = Mathf.Lerp(iter_214_1.color.g, arg_211_1.hightColor2.g, var_214_3)
								local var_214_6 = Mathf.Lerp(iter_214_1.color.b, arg_211_1.hightColor2.b, var_214_3)

								iter_214_1.color = Color.New(var_214_4, var_214_5, var_214_6)
							else
								local var_214_7 = Mathf.Lerp(iter_214_1.color.r, 0.5, var_214_3)

								iter_214_1.color = Color.New(var_214_7, var_214_7, var_214_7)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.actorSpriteComps10018 then
				for iter_214_2, iter_214_3 in pairs(arg_211_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_214_3 then
						if arg_211_1.isInRecall_ then
							iter_214_3.color = arg_211_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_214_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_211_1.var_.actorSpriteComps10018 = nil
			end

			local var_214_8 = 0
			local var_214_9 = 0.475

			if var_214_8 < arg_211_1.time_ and arg_211_1.time_ <= var_214_8 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_10 = arg_211_1:FormatText(StoryNameCfg[214].name)

				arg_211_1.leftNameTxt_.text = var_214_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6046")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_11 = arg_211_1:GetWordFromCfg(114242051)
				local var_214_12 = arg_211_1:FormatText(var_214_11.content)

				arg_211_1.text_.text = var_214_12

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_13 = 19
				local var_214_14 = utf8.len(var_214_12)
				local var_214_15 = var_214_13 <= 0 and var_214_9 or var_214_9 * (var_214_14 / var_214_13)

				if var_214_15 > 0 and var_214_9 < var_214_15 then
					arg_211_1.talkMaxDuration = var_214_15

					if var_214_15 + var_214_8 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_15 + var_214_8
					end
				end

				arg_211_1.text_.text = var_214_12
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242051", "story_v_out_114242.awb") ~= 0 then
					local var_214_16 = manager.audio:GetVoiceLength("story_v_out_114242", "114242051", "story_v_out_114242.awb") / 1000

					if var_214_16 + var_214_8 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_16 + var_214_8
					end

					if var_214_11.prefab_name ~= "" and arg_211_1.actors_[var_214_11.prefab_name] ~= nil then
						local var_214_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_11.prefab_name].transform, "story_v_out_114242", "114242051", "story_v_out_114242.awb")

						arg_211_1:RecordAudio("114242051", var_214_17)
						arg_211_1:RecordAudio("114242051", var_214_17)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_114242", "114242051", "story_v_out_114242.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_114242", "114242051", "story_v_out_114242.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_18 = math.max(var_214_9, arg_211_1.talkMaxDuration)

			if var_214_8 <= arg_211_1.time_ and arg_211_1.time_ < var_214_8 + var_214_18 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_8) / var_214_18

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_8 + var_214_18 and arg_211_1.time_ < var_214_8 + var_214_18 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play114242052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 114242052
		arg_215_1.duration_ = 3.57

		local var_215_0 = {
			ja = 3.533,
			ko = 3.566,
			zh = 2.866,
			en = 3.366
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
				arg_215_0:Play114242053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 0.225

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_2 = arg_215_1:FormatText(StoryNameCfg[215].name)

				arg_215_1.leftNameTxt_.text = var_218_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6045")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_3 = arg_215_1:GetWordFromCfg(114242052)
				local var_218_4 = arg_215_1:FormatText(var_218_3.content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 9
				local var_218_6 = utf8.len(var_218_4)
				local var_218_7 = var_218_5 <= 0 and var_218_1 or var_218_1 * (var_218_6 / var_218_5)

				if var_218_7 > 0 and var_218_1 < var_218_7 then
					arg_215_1.talkMaxDuration = var_218_7

					if var_218_7 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_7 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_4
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242052", "story_v_out_114242.awb") ~= 0 then
					local var_218_8 = manager.audio:GetVoiceLength("story_v_out_114242", "114242052", "story_v_out_114242.awb") / 1000

					if var_218_8 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_8 + var_218_0
					end

					if var_218_3.prefab_name ~= "" and arg_215_1.actors_[var_218_3.prefab_name] ~= nil then
						local var_218_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_3.prefab_name].transform, "story_v_out_114242", "114242052", "story_v_out_114242.awb")

						arg_215_1:RecordAudio("114242052", var_218_9)
						arg_215_1:RecordAudio("114242052", var_218_9)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_114242", "114242052", "story_v_out_114242.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_114242", "114242052", "story_v_out_114242.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_10 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_10 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_10

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_10 and arg_215_1.time_ < var_218_0 + var_218_10 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play114242053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 114242053
		arg_219_1.duration_ = 3.03

		local var_219_0 = {
			ja = 3.033,
			ko = 2.033,
			zh = 2.433,
			en = 2.033
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
				arg_219_0:Play114242054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 0.175

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_2 = arg_219_1:FormatText(StoryNameCfg[233].name)

				arg_219_1.leftNameTxt_.text = var_222_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_3 = arg_219_1:GetWordFromCfg(114242053)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 7
				local var_222_6 = utf8.len(var_222_4)
				local var_222_7 = var_222_5 <= 0 and var_222_1 or var_222_1 * (var_222_6 / var_222_5)

				if var_222_7 > 0 and var_222_1 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_4
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242053", "story_v_out_114242.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_114242", "114242053", "story_v_out_114242.awb") / 1000

					if var_222_8 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_0
					end

					if var_222_3.prefab_name ~= "" and arg_219_1.actors_[var_222_3.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_3.prefab_name].transform, "story_v_out_114242", "114242053", "story_v_out_114242.awb")

						arg_219_1:RecordAudio("114242053", var_222_9)
						arg_219_1:RecordAudio("114242053", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_114242", "114242053", "story_v_out_114242.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_114242", "114242053", "story_v_out_114242.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_10 and arg_219_1.time_ < var_222_0 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play114242054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 114242054
		arg_223_1.duration_ = 12.73

		local var_223_0 = {
			ja = 9.266,
			ko = 10.433,
			zh = 12.733,
			en = 10.566
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
				arg_223_0:Play114242055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["10018"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.actorSpriteComps10018 == nil then
				arg_223_1.var_.actorSpriteComps10018 = var_226_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_2 = 0.034

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.actorSpriteComps10018 then
					for iter_226_0, iter_226_1 in pairs(arg_223_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.actorSpriteComps10018 then
				for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_226_3 then
						if arg_223_1.isInRecall_ then
							iter_226_3.color = arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_226_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_223_1.var_.actorSpriteComps10018 = nil
			end

			local var_226_8 = arg_223_1.actors_["10018"].transform
			local var_226_9 = 0

			if var_226_9 < arg_223_1.time_ and arg_223_1.time_ <= var_226_9 + arg_226_0 then
				arg_223_1.var_.moveOldPos10018 = var_226_8.localPosition
				var_226_8.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("10018", 3)

				local var_226_10 = var_226_8.childCount

				for iter_226_4 = 0, var_226_10 - 1 do
					local var_226_11 = var_226_8:GetChild(iter_226_4)

					if var_226_11.name == "split_1" or not string.find(var_226_11.name, "split") then
						var_226_11.gameObject:SetActive(true)
					else
						var_226_11.gameObject:SetActive(false)
					end
				end
			end

			local var_226_12 = 0.001

			if var_226_9 <= arg_223_1.time_ and arg_223_1.time_ < var_226_9 + var_226_12 then
				local var_226_13 = (arg_223_1.time_ - var_226_9) / var_226_12
				local var_226_14 = Vector3.New(0, -350, -180)

				var_226_8.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10018, var_226_14, var_226_13)
			end

			if arg_223_1.time_ >= var_226_9 + var_226_12 and arg_223_1.time_ < var_226_9 + var_226_12 + arg_226_0 then
				var_226_8.localPosition = Vector3.New(0, -350, -180)
			end

			local var_226_15 = 0
			local var_226_16 = 1.15

			if var_226_15 < arg_223_1.time_ and arg_223_1.time_ <= var_226_15 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_17 = arg_223_1:FormatText(StoryNameCfg[257].name)

				arg_223_1.leftNameTxt_.text = var_226_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_18 = arg_223_1:GetWordFromCfg(114242054)
				local var_226_19 = arg_223_1:FormatText(var_226_18.content)

				arg_223_1.text_.text = var_226_19

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_20 = 46
				local var_226_21 = utf8.len(var_226_19)
				local var_226_22 = var_226_20 <= 0 and var_226_16 or var_226_16 * (var_226_21 / var_226_20)

				if var_226_22 > 0 and var_226_16 < var_226_22 then
					arg_223_1.talkMaxDuration = var_226_22

					if var_226_22 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_22 + var_226_15
					end
				end

				arg_223_1.text_.text = var_226_19
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242054", "story_v_out_114242.awb") ~= 0 then
					local var_226_23 = manager.audio:GetVoiceLength("story_v_out_114242", "114242054", "story_v_out_114242.awb") / 1000

					if var_226_23 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_23 + var_226_15
					end

					if var_226_18.prefab_name ~= "" and arg_223_1.actors_[var_226_18.prefab_name] ~= nil then
						local var_226_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_18.prefab_name].transform, "story_v_out_114242", "114242054", "story_v_out_114242.awb")

						arg_223_1:RecordAudio("114242054", var_226_24)
						arg_223_1:RecordAudio("114242054", var_226_24)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_114242", "114242054", "story_v_out_114242.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_114242", "114242054", "story_v_out_114242.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_25 = math.max(var_226_16, arg_223_1.talkMaxDuration)

			if var_226_15 <= arg_223_1.time_ and arg_223_1.time_ < var_226_15 + var_226_25 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_15) / var_226_25

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_15 + var_226_25 and arg_223_1.time_ < var_226_15 + var_226_25 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
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
	Play114242055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 114242055
		arg_227_1.duration_ = 4.9

		local var_227_0 = {
			ja = 3.9,
			ko = 4.9,
			zh = 4.166,
			en = 3.8
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
				arg_227_0:Play114242056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 0.45

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_2 = arg_227_1:FormatText(StoryNameCfg[257].name)

				arg_227_1.leftNameTxt_.text = var_230_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_3 = arg_227_1:GetWordFromCfg(114242055)
				local var_230_4 = arg_227_1:FormatText(var_230_3.content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242055", "story_v_out_114242.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_114242", "114242055", "story_v_out_114242.awb") / 1000

					if var_230_8 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_0
					end

					if var_230_3.prefab_name ~= "" and arg_227_1.actors_[var_230_3.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_3.prefab_name].transform, "story_v_out_114242", "114242055", "story_v_out_114242.awb")

						arg_227_1:RecordAudio("114242055", var_230_9)
						arg_227_1:RecordAudio("114242055", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_114242", "114242055", "story_v_out_114242.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_114242", "114242055", "story_v_out_114242.awb")
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
	Play114242056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 114242056
		arg_231_1.duration_ = 1.37

		local var_231_0 = {
			ja = 1.366,
			ko = 1.1,
			zh = 0.999999999999,
			en = 1.066
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
				arg_231_0:Play114242057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["10018"].transform
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.var_.moveOldPos10018 = var_234_0.localPosition
				var_234_0.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("10018", 2)

				local var_234_2 = var_234_0.childCount

				for iter_234_0 = 0, var_234_2 - 1 do
					local var_234_3 = var_234_0:GetChild(iter_234_0)

					if var_234_3.name == "split_1" or not string.find(var_234_3.name, "split") then
						var_234_3.gameObject:SetActive(true)
					else
						var_234_3.gameObject:SetActive(false)
					end
				end
			end

			local var_234_4 = 0.001

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_4 then
				local var_234_5 = (arg_231_1.time_ - var_234_1) / var_234_4
				local var_234_6 = Vector3.New(-390, -350, -180)

				var_234_0.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10018, var_234_6, var_234_5)
			end

			if arg_231_1.time_ >= var_234_1 + var_234_4 and arg_231_1.time_ < var_234_1 + var_234_4 + arg_234_0 then
				var_234_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_234_7 = arg_231_1.actors_["104201_1"].transform
			local var_234_8 = 0

			if var_234_8 < arg_231_1.time_ and arg_231_1.time_ <= var_234_8 + arg_234_0 then
				arg_231_1.var_.moveOldPos104201_1 = var_234_7.localPosition
				var_234_7.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("104201_1", 4)
			end

			local var_234_9 = 0.001

			if var_234_8 <= arg_231_1.time_ and arg_231_1.time_ < var_234_8 + var_234_9 then
				local var_234_10 = (arg_231_1.time_ - var_234_8) / var_234_9
				local var_234_11 = Vector3.New(390, -350, -180)

				var_234_7.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos104201_1, var_234_11, var_234_10)
			end

			if arg_231_1.time_ >= var_234_8 + var_234_9 and arg_231_1.time_ < var_234_8 + var_234_9 + arg_234_0 then
				var_234_7.localPosition = Vector3.New(390, -350, -180)
			end

			local var_234_12 = arg_231_1.actors_["10018"]
			local var_234_13 = 0

			if var_234_13 < arg_231_1.time_ and arg_231_1.time_ <= var_234_13 + arg_234_0 and not isNil(var_234_12) and arg_231_1.var_.actorSpriteComps10018 == nil then
				arg_231_1.var_.actorSpriteComps10018 = var_234_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_14 = 0.034

			if var_234_13 <= arg_231_1.time_ and arg_231_1.time_ < var_234_13 + var_234_14 and not isNil(var_234_12) then
				local var_234_15 = (arg_231_1.time_ - var_234_13) / var_234_14

				if arg_231_1.var_.actorSpriteComps10018 then
					for iter_234_1, iter_234_2 in pairs(arg_231_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_234_2 then
							if arg_231_1.isInRecall_ then
								local var_234_16 = Mathf.Lerp(iter_234_2.color.r, arg_231_1.hightColor2.r, var_234_15)
								local var_234_17 = Mathf.Lerp(iter_234_2.color.g, arg_231_1.hightColor2.g, var_234_15)
								local var_234_18 = Mathf.Lerp(iter_234_2.color.b, arg_231_1.hightColor2.b, var_234_15)

								iter_234_2.color = Color.New(var_234_16, var_234_17, var_234_18)
							else
								local var_234_19 = Mathf.Lerp(iter_234_2.color.r, 0.5, var_234_15)

								iter_234_2.color = Color.New(var_234_19, var_234_19, var_234_19)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= var_234_13 + var_234_14 and arg_231_1.time_ < var_234_13 + var_234_14 + arg_234_0 and not isNil(var_234_12) and arg_231_1.var_.actorSpriteComps10018 then
				for iter_234_3, iter_234_4 in pairs(arg_231_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_234_4 then
						if arg_231_1.isInRecall_ then
							iter_234_4.color = arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_234_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps10018 = nil
			end

			local var_234_20 = arg_231_1.actors_["104201_1"]
			local var_234_21 = 0

			if var_234_21 < arg_231_1.time_ and arg_231_1.time_ <= var_234_21 + arg_234_0 and not isNil(var_234_20) then
				local var_234_22 = var_234_20:GetComponent("Image")

				if var_234_22 then
					arg_231_1.var_.highlightMatValue104201_1 = var_234_22
				end
			end

			local var_234_23 = 0.034

			if var_234_21 <= arg_231_1.time_ and arg_231_1.time_ < var_234_21 + var_234_23 and not isNil(var_234_20) then
				local var_234_24 = (arg_231_1.time_ - var_234_21) / var_234_23

				if arg_231_1.var_.highlightMatValue104201_1 then
					local var_234_25 = Mathf.Lerp(0.5, 1, var_234_24)
					local var_234_26 = arg_231_1.var_.highlightMatValue104201_1
					local var_234_27 = var_234_26.color

					var_234_27.r = var_234_25
					var_234_27.g = var_234_25
					var_234_27.b = var_234_25
					var_234_26.color = var_234_27
				end
			end

			if arg_231_1.time_ >= var_234_21 + var_234_23 and arg_231_1.time_ < var_234_21 + var_234_23 + arg_234_0 and not isNil(var_234_20) and arg_231_1.var_.highlightMatValue104201_1 then
				local var_234_28 = 1

				var_234_20.transform:SetSiblingIndex(1)

				local var_234_29 = arg_231_1.var_.highlightMatValue104201_1
				local var_234_30 = var_234_29.color

				var_234_30.r = var_234_28
				var_234_30.g = var_234_28
				var_234_30.b = var_234_28
				var_234_29.color = var_234_30
			end

			local var_234_31 = arg_231_1.actors_["10018"]
			local var_234_32 = 0

			if var_234_32 < arg_231_1.time_ and arg_231_1.time_ <= var_234_32 + arg_234_0 then
				local var_234_33 = var_234_31:GetComponentInChildren(typeof(CanvasGroup))

				if var_234_33 then
					arg_231_1.var_.alphaOldValue10018 = var_234_33.alpha
					arg_231_1.var_.characterEffect10018 = var_234_33
				end

				arg_231_1.var_.alphaOldValue10018 = 0
			end

			local var_234_34 = 0.5

			if var_234_32 <= arg_231_1.time_ and arg_231_1.time_ < var_234_32 + var_234_34 then
				local var_234_35 = (arg_231_1.time_ - var_234_32) / var_234_34
				local var_234_36 = Mathf.Lerp(arg_231_1.var_.alphaOldValue10018, 1, var_234_35)

				if arg_231_1.var_.characterEffect10018 then
					arg_231_1.var_.characterEffect10018.alpha = var_234_36
				end
			end

			if arg_231_1.time_ >= var_234_32 + var_234_34 and arg_231_1.time_ < var_234_32 + var_234_34 + arg_234_0 and arg_231_1.var_.characterEffect10018 then
				arg_231_1.var_.characterEffect10018.alpha = 1
			end

			local var_234_37 = arg_231_1.actors_["104201_1"]
			local var_234_38 = 0

			if var_234_38 < arg_231_1.time_ and arg_231_1.time_ <= var_234_38 + arg_234_0 then
				local var_234_39 = var_234_37:GetComponent("Image")

				if var_234_39 then
					arg_231_1.var_.alphaMatValue104201_1 = var_234_39
					arg_231_1.var_.alphaOldValue104201_1 = var_234_39.color.a
				end

				arg_231_1.var_.alphaOldValue104201_1 = 0
			end

			local var_234_40 = 0.5

			if var_234_38 <= arg_231_1.time_ and arg_231_1.time_ < var_234_38 + var_234_40 then
				local var_234_41 = (arg_231_1.time_ - var_234_38) / var_234_40
				local var_234_42 = Mathf.Lerp(arg_231_1.var_.alphaOldValue104201_1, 1, var_234_41)

				if arg_231_1.var_.alphaMatValue104201_1 then
					local var_234_43 = arg_231_1.var_.alphaMatValue104201_1.color

					var_234_43.a = var_234_42
					arg_231_1.var_.alphaMatValue104201_1.color = var_234_43
				end
			end

			if arg_231_1.time_ >= var_234_38 + var_234_40 and arg_231_1.time_ < var_234_38 + var_234_40 + arg_234_0 and arg_231_1.var_.alphaMatValue104201_1 then
				local var_234_44 = arg_231_1.var_.alphaMatValue104201_1
				local var_234_45 = var_234_44.color

				var_234_45.a = 1
				var_234_44.color = var_234_45
			end

			local var_234_46 = 0
			local var_234_47 = 0.075

			if var_234_46 < arg_231_1.time_ and arg_231_1.time_ <= var_234_46 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_48 = arg_231_1:FormatText(StoryNameCfg[205].name)

				arg_231_1.leftNameTxt_.text = var_234_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_49 = arg_231_1:GetWordFromCfg(114242056)
				local var_234_50 = arg_231_1:FormatText(var_234_49.content)

				arg_231_1.text_.text = var_234_50

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_51 = 3
				local var_234_52 = utf8.len(var_234_50)
				local var_234_53 = var_234_51 <= 0 and var_234_47 or var_234_47 * (var_234_52 / var_234_51)

				if var_234_53 > 0 and var_234_47 < var_234_53 then
					arg_231_1.talkMaxDuration = var_234_53

					if var_234_53 + var_234_46 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_53 + var_234_46
					end
				end

				arg_231_1.text_.text = var_234_50
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242056", "story_v_out_114242.awb") ~= 0 then
					local var_234_54 = manager.audio:GetVoiceLength("story_v_out_114242", "114242056", "story_v_out_114242.awb") / 1000

					if var_234_54 + var_234_46 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_54 + var_234_46
					end

					if var_234_49.prefab_name ~= "" and arg_231_1.actors_[var_234_49.prefab_name] ~= nil then
						local var_234_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_49.prefab_name].transform, "story_v_out_114242", "114242056", "story_v_out_114242.awb")

						arg_231_1:RecordAudio("114242056", var_234_55)
						arg_231_1:RecordAudio("114242056", var_234_55)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_114242", "114242056", "story_v_out_114242.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_114242", "114242056", "story_v_out_114242.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_56 = math.max(var_234_47, arg_231_1.talkMaxDuration)

			if var_234_46 <= arg_231_1.time_ and arg_231_1.time_ < var_234_46 + var_234_56 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_46) / var_234_56

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_46 + var_234_56 and arg_231_1.time_ < var_234_46 + var_234_56 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104201_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play114242057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 114242057
		arg_235_1.duration_ = 1

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play114242058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["10018"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps10018 == nil then
				arg_235_1.var_.actorSpriteComps10018 = var_238_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_2 = 0.034

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.actorSpriteComps10018 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps10018 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_238_3 then
						if arg_235_1.isInRecall_ then
							iter_238_3.color = arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_238_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps10018 = nil
			end

			local var_238_8 = arg_235_1.actors_["104201_1"]
			local var_238_9 = 0

			if var_238_9 < arg_235_1.time_ and arg_235_1.time_ <= var_238_9 + arg_238_0 and not isNil(var_238_8) then
				local var_238_10 = var_238_8:GetComponent("Image")

				if var_238_10 then
					arg_235_1.var_.highlightMatValue104201_1 = var_238_10
				end
			end

			local var_238_11 = 0.034

			if var_238_9 <= arg_235_1.time_ and arg_235_1.time_ < var_238_9 + var_238_11 and not isNil(var_238_8) then
				local var_238_12 = (arg_235_1.time_ - var_238_9) / var_238_11

				if arg_235_1.var_.highlightMatValue104201_1 then
					local var_238_13 = Mathf.Lerp(1, 0.5, var_238_12)
					local var_238_14 = arg_235_1.var_.highlightMatValue104201_1
					local var_238_15 = var_238_14.color

					var_238_15.r = var_238_13
					var_238_15.g = var_238_13
					var_238_15.b = var_238_13
					var_238_14.color = var_238_15
				end
			end

			if arg_235_1.time_ >= var_238_9 + var_238_11 and arg_235_1.time_ < var_238_9 + var_238_11 + arg_238_0 and not isNil(var_238_8) and arg_235_1.var_.highlightMatValue104201_1 then
				local var_238_16 = 0.5
				local var_238_17 = arg_235_1.var_.highlightMatValue104201_1
				local var_238_18 = var_238_17.color

				var_238_18.r = var_238_16
				var_238_18.g = var_238_16
				var_238_18.b = var_238_16
				var_238_17.color = var_238_18
			end

			local var_238_19 = 0
			local var_238_20 = 0.05

			if var_238_19 < arg_235_1.time_ and arg_235_1.time_ <= var_238_19 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_21 = arg_235_1:FormatText(StoryNameCfg[258].name)

				arg_235_1.leftNameTxt_.text = var_238_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_22 = arg_235_1:GetWordFromCfg(114242057)
				local var_238_23 = arg_235_1:FormatText(var_238_22.content)

				arg_235_1.text_.text = var_238_23

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_24 = 2
				local var_238_25 = utf8.len(var_238_23)
				local var_238_26 = var_238_24 <= 0 and var_238_20 or var_238_20 * (var_238_25 / var_238_24)

				if var_238_26 > 0 and var_238_20 < var_238_26 then
					arg_235_1.talkMaxDuration = var_238_26

					if var_238_26 + var_238_19 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_26 + var_238_19
					end
				end

				arg_235_1.text_.text = var_238_23
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242057", "story_v_out_114242.awb") ~= 0 then
					local var_238_27 = manager.audio:GetVoiceLength("story_v_out_114242", "114242057", "story_v_out_114242.awb") / 1000

					if var_238_27 + var_238_19 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_27 + var_238_19
					end

					if var_238_22.prefab_name ~= "" and arg_235_1.actors_[var_238_22.prefab_name] ~= nil then
						local var_238_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_22.prefab_name].transform, "story_v_out_114242", "114242057", "story_v_out_114242.awb")

						arg_235_1:RecordAudio("114242057", var_238_28)
						arg_235_1:RecordAudio("114242057", var_238_28)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_114242", "114242057", "story_v_out_114242.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_114242", "114242057", "story_v_out_114242.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_29 = math.max(var_238_20, arg_235_1.talkMaxDuration)

			if var_238_19 <= arg_235_1.time_ and arg_235_1.time_ < var_238_19 + var_238_29 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_19) / var_238_29

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_19 + var_238_29 and arg_235_1.time_ < var_238_19 + var_238_29 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play114242058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 114242058
		arg_239_1.duration_ = 7.33

		local var_239_0 = {
			ja = 6.533,
			ko = 5.633,
			zh = 7.333,
			en = 6.4
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play114242059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["10018"]
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.actorSpriteComps10018 == nil then
				arg_239_1.var_.actorSpriteComps10018 = var_242_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_2 = 0.034

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 and not isNil(var_242_0) then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2

				if arg_239_1.var_.actorSpriteComps10018 then
					for iter_242_0, iter_242_1 in pairs(arg_239_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_242_1 then
							if arg_239_1.isInRecall_ then
								local var_242_4 = Mathf.Lerp(iter_242_1.color.r, arg_239_1.hightColor2.r, var_242_3)
								local var_242_5 = Mathf.Lerp(iter_242_1.color.g, arg_239_1.hightColor2.g, var_242_3)
								local var_242_6 = Mathf.Lerp(iter_242_1.color.b, arg_239_1.hightColor2.b, var_242_3)

								iter_242_1.color = Color.New(var_242_4, var_242_5, var_242_6)
							else
								local var_242_7 = Mathf.Lerp(iter_242_1.color.r, 0.5, var_242_3)

								iter_242_1.color = Color.New(var_242_7, var_242_7, var_242_7)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.actorSpriteComps10018 then
				for iter_242_2, iter_242_3 in pairs(arg_239_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_242_3 then
						if arg_239_1.isInRecall_ then
							iter_242_3.color = arg_239_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_242_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_239_1.var_.actorSpriteComps10018 = nil
			end

			local var_242_8 = arg_239_1.actors_["104201_1"]
			local var_242_9 = 0

			if var_242_9 < arg_239_1.time_ and arg_239_1.time_ <= var_242_9 + arg_242_0 and not isNil(var_242_8) then
				local var_242_10 = var_242_8:GetComponent("Image")

				if var_242_10 then
					arg_239_1.var_.highlightMatValue104201_1 = var_242_10
				end
			end

			local var_242_11 = 0.034

			if var_242_9 <= arg_239_1.time_ and arg_239_1.time_ < var_242_9 + var_242_11 and not isNil(var_242_8) then
				local var_242_12 = (arg_239_1.time_ - var_242_9) / var_242_11

				if arg_239_1.var_.highlightMatValue104201_1 then
					local var_242_13 = Mathf.Lerp(0.5, 1, var_242_12)
					local var_242_14 = arg_239_1.var_.highlightMatValue104201_1
					local var_242_15 = var_242_14.color

					var_242_15.r = var_242_13
					var_242_15.g = var_242_13
					var_242_15.b = var_242_13
					var_242_14.color = var_242_15
				end
			end

			if arg_239_1.time_ >= var_242_9 + var_242_11 and arg_239_1.time_ < var_242_9 + var_242_11 + arg_242_0 and not isNil(var_242_8) and arg_239_1.var_.highlightMatValue104201_1 then
				local var_242_16 = 1

				var_242_8.transform:SetSiblingIndex(1)

				local var_242_17 = arg_239_1.var_.highlightMatValue104201_1
				local var_242_18 = var_242_17.color

				var_242_18.r = var_242_16
				var_242_18.g = var_242_16
				var_242_18.b = var_242_16
				var_242_17.color = var_242_18
			end

			local var_242_19 = 0
			local var_242_20 = 0.8

			if var_242_19 < arg_239_1.time_ and arg_239_1.time_ <= var_242_19 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_21 = arg_239_1:FormatText(StoryNameCfg[205].name)

				arg_239_1.leftNameTxt_.text = var_242_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_22 = arg_239_1:GetWordFromCfg(114242058)
				local var_242_23 = arg_239_1:FormatText(var_242_22.content)

				arg_239_1.text_.text = var_242_23

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_24 = 32
				local var_242_25 = utf8.len(var_242_23)
				local var_242_26 = var_242_24 <= 0 and var_242_20 or var_242_20 * (var_242_25 / var_242_24)

				if var_242_26 > 0 and var_242_20 < var_242_26 then
					arg_239_1.talkMaxDuration = var_242_26

					if var_242_26 + var_242_19 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_26 + var_242_19
					end
				end

				arg_239_1.text_.text = var_242_23
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242058", "story_v_out_114242.awb") ~= 0 then
					local var_242_27 = manager.audio:GetVoiceLength("story_v_out_114242", "114242058", "story_v_out_114242.awb") / 1000

					if var_242_27 + var_242_19 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_27 + var_242_19
					end

					if var_242_22.prefab_name ~= "" and arg_239_1.actors_[var_242_22.prefab_name] ~= nil then
						local var_242_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_22.prefab_name].transform, "story_v_out_114242", "114242058", "story_v_out_114242.awb")

						arg_239_1:RecordAudio("114242058", var_242_28)
						arg_239_1:RecordAudio("114242058", var_242_28)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_114242", "114242058", "story_v_out_114242.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_114242", "114242058", "story_v_out_114242.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_29 = math.max(var_242_20, arg_239_1.talkMaxDuration)

			if var_242_19 <= arg_239_1.time_ and arg_239_1.time_ < var_242_19 + var_242_29 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_19) / var_242_29

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_19 + var_242_29 and arg_239_1.time_ < var_242_19 + var_242_29 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play114242059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 114242059
		arg_243_1.duration_ = 10.47

		local var_243_0 = {
			ja = 10.466,
			ko = 10.033,
			zh = 10.333,
			en = 6.9
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play114242060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 0.9

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_2 = arg_243_1:FormatText(StoryNameCfg[205].name)

				arg_243_1.leftNameTxt_.text = var_246_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_3 = arg_243_1:GetWordFromCfg(114242059)
				local var_246_4 = arg_243_1:FormatText(var_246_3.content)

				arg_243_1.text_.text = var_246_4

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 37
				local var_246_6 = utf8.len(var_246_4)
				local var_246_7 = var_246_5 <= 0 and var_246_1 or var_246_1 * (var_246_6 / var_246_5)

				if var_246_7 > 0 and var_246_1 < var_246_7 then
					arg_243_1.talkMaxDuration = var_246_7

					if var_246_7 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_4
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242059", "story_v_out_114242.awb") ~= 0 then
					local var_246_8 = manager.audio:GetVoiceLength("story_v_out_114242", "114242059", "story_v_out_114242.awb") / 1000

					if var_246_8 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_8 + var_246_0
					end

					if var_246_3.prefab_name ~= "" and arg_243_1.actors_[var_246_3.prefab_name] ~= nil then
						local var_246_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_3.prefab_name].transform, "story_v_out_114242", "114242059", "story_v_out_114242.awb")

						arg_243_1:RecordAudio("114242059", var_246_9)
						arg_243_1:RecordAudio("114242059", var_246_9)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_114242", "114242059", "story_v_out_114242.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_114242", "114242059", "story_v_out_114242.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_10 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_10 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_10

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_10 and arg_243_1.time_ < var_246_0 + var_246_10 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play114242060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 114242060
		arg_247_1.duration_ = 9.83

		local var_247_0 = {
			ja = 8.732999999999,
			ko = 7.965999999999,
			zh = 9.832999999999,
			en = 9.065999999999
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
				arg_247_0:Play114242061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				local var_250_1 = manager.ui.mainCamera.transform.localPosition
				local var_250_2 = Vector3.New(0, 0, 10) + Vector3.New(var_250_1.x, var_250_1.y, 0)
				local var_250_3 = arg_247_1.bgs_.ST25

				var_250_3.transform.localPosition = var_250_2
				var_250_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_250_4 = var_250_3:GetComponent("SpriteRenderer")

				if var_250_4 and var_250_4.sprite then
					local var_250_5 = (var_250_3.transform.localPosition - var_250_1).z
					local var_250_6 = manager.ui.mainCameraCom_
					local var_250_7 = 2 * var_250_5 * Mathf.Tan(var_250_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_250_8 = var_250_7 * var_250_6.aspect
					local var_250_9 = var_250_4.sprite.bounds.size.x
					local var_250_10 = var_250_4.sprite.bounds.size.y
					local var_250_11 = var_250_8 / var_250_9
					local var_250_12 = var_250_7 / var_250_10
					local var_250_13 = var_250_12 < var_250_11 and var_250_11 or var_250_12

					var_250_3.transform.localScale = Vector3.New(var_250_13, var_250_13, 0)
				end

				for iter_250_0, iter_250_1 in pairs(arg_247_1.bgs_) do
					if iter_250_0 ~= "ST25" then
						iter_250_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_250_14 = 0

			if var_250_14 < arg_247_1.time_ and arg_247_1.time_ <= var_250_14 + arg_250_0 then
				arg_247_1.mask_.enabled = true
				arg_247_1.mask_.raycastTarget = false

				arg_247_1:SetGaussion(false)
			end

			local var_250_15 = 2

			if var_250_14 <= arg_247_1.time_ and arg_247_1.time_ < var_250_14 + var_250_15 then
				local var_250_16 = (arg_247_1.time_ - var_250_14) / var_250_15
				local var_250_17 = Color.New(1, 1, 1)

				var_250_17.a = Mathf.Lerp(1, 0, var_250_16)
				arg_247_1.mask_.color = var_250_17
			end

			if arg_247_1.time_ >= var_250_14 + var_250_15 and arg_247_1.time_ < var_250_14 + var_250_15 + arg_250_0 then
				local var_250_18 = Color.New(1, 1, 1)
				local var_250_19 = 0

				arg_247_1.mask_.enabled = false
				var_250_18.a = var_250_19
				arg_247_1.mask_.color = var_250_18
			end

			local var_250_20 = arg_247_1.actors_["10018"].transform
			local var_250_21 = 0

			if var_250_21 < arg_247_1.time_ and arg_247_1.time_ <= var_250_21 + arg_250_0 then
				arg_247_1.var_.moveOldPos10018 = var_250_20.localPosition
				var_250_20.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10018", 7)

				local var_250_22 = var_250_20.childCount

				for iter_250_2 = 0, var_250_22 - 1 do
					local var_250_23 = var_250_20:GetChild(iter_250_2)

					if var_250_23.name == "split_1" or not string.find(var_250_23.name, "split") then
						var_250_23.gameObject:SetActive(true)
					else
						var_250_23.gameObject:SetActive(false)
					end
				end
			end

			local var_250_24 = 0.001

			if var_250_21 <= arg_247_1.time_ and arg_247_1.time_ < var_250_21 + var_250_24 then
				local var_250_25 = (arg_247_1.time_ - var_250_21) / var_250_24
				local var_250_26 = Vector3.New(0, -2000, -180)

				var_250_20.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10018, var_250_26, var_250_25)
			end

			if arg_247_1.time_ >= var_250_21 + var_250_24 and arg_247_1.time_ < var_250_21 + var_250_24 + arg_250_0 then
				var_250_20.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_250_27 = arg_247_1.actors_["10018"].transform
			local var_250_28 = 1.8

			if var_250_28 < arg_247_1.time_ and arg_247_1.time_ <= var_250_28 + arg_250_0 then
				arg_247_1.var_.moveOldPos10018 = var_250_27.localPosition
				var_250_27.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10018", 2)

				local var_250_29 = var_250_27.childCount

				for iter_250_3 = 0, var_250_29 - 1 do
					local var_250_30 = var_250_27:GetChild(iter_250_3)

					if var_250_30.name == "split_1" or not string.find(var_250_30.name, "split") then
						var_250_30.gameObject:SetActive(true)
					else
						var_250_30.gameObject:SetActive(false)
					end
				end
			end

			local var_250_31 = 0.001

			if var_250_28 <= arg_247_1.time_ and arg_247_1.time_ < var_250_28 + var_250_31 then
				local var_250_32 = (arg_247_1.time_ - var_250_28) / var_250_31
				local var_250_33 = Vector3.New(-390, -350, -180)

				var_250_27.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10018, var_250_33, var_250_32)
			end

			if arg_247_1.time_ >= var_250_28 + var_250_31 and arg_247_1.time_ < var_250_28 + var_250_31 + arg_250_0 then
				var_250_27.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_250_34 = arg_247_1.actors_["104201_1"].transform
			local var_250_35 = 0

			if var_250_35 < arg_247_1.time_ and arg_247_1.time_ <= var_250_35 + arg_250_0 then
				arg_247_1.var_.moveOldPos104201_1 = var_250_34.localPosition
				var_250_34.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("104201_1", 7)
			end

			local var_250_36 = 0.001

			if var_250_35 <= arg_247_1.time_ and arg_247_1.time_ < var_250_35 + var_250_36 then
				local var_250_37 = (arg_247_1.time_ - var_250_35) / var_250_36
				local var_250_38 = Vector3.New(0, -2000, -180)

				var_250_34.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos104201_1, var_250_38, var_250_37)
			end

			if arg_247_1.time_ >= var_250_35 + var_250_36 and arg_247_1.time_ < var_250_35 + var_250_36 + arg_250_0 then
				var_250_34.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_250_39 = arg_247_1.actors_["10018"]
			local var_250_40 = 1.8

			if var_250_40 < arg_247_1.time_ and arg_247_1.time_ <= var_250_40 + arg_250_0 and not isNil(var_250_39) and arg_247_1.var_.actorSpriteComps10018 == nil then
				arg_247_1.var_.actorSpriteComps10018 = var_250_39:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_41 = 0.034

			if var_250_40 <= arg_247_1.time_ and arg_247_1.time_ < var_250_40 + var_250_41 and not isNil(var_250_39) then
				local var_250_42 = (arg_247_1.time_ - var_250_40) / var_250_41

				if arg_247_1.var_.actorSpriteComps10018 then
					for iter_250_4, iter_250_5 in pairs(arg_247_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_250_5 then
							if arg_247_1.isInRecall_ then
								local var_250_43 = Mathf.Lerp(iter_250_5.color.r, arg_247_1.hightColor1.r, var_250_42)
								local var_250_44 = Mathf.Lerp(iter_250_5.color.g, arg_247_1.hightColor1.g, var_250_42)
								local var_250_45 = Mathf.Lerp(iter_250_5.color.b, arg_247_1.hightColor1.b, var_250_42)

								iter_250_5.color = Color.New(var_250_43, var_250_44, var_250_45)
							else
								local var_250_46 = Mathf.Lerp(iter_250_5.color.r, 1, var_250_42)

								iter_250_5.color = Color.New(var_250_46, var_250_46, var_250_46)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= var_250_40 + var_250_41 and arg_247_1.time_ < var_250_40 + var_250_41 + arg_250_0 and not isNil(var_250_39) and arg_247_1.var_.actorSpriteComps10018 then
				for iter_250_6, iter_250_7 in pairs(arg_247_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_250_7 then
						if arg_247_1.isInRecall_ then
							iter_250_7.color = arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_250_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps10018 = nil
			end

			local var_250_47 = arg_247_1.actors_["10018"]
			local var_250_48 = 1.8

			if var_250_48 < arg_247_1.time_ and arg_247_1.time_ <= var_250_48 + arg_250_0 then
				local var_250_49 = var_250_47:GetComponentInChildren(typeof(CanvasGroup))

				if var_250_49 then
					arg_247_1.var_.alphaOldValue10018 = var_250_49.alpha
					arg_247_1.var_.characterEffect10018 = var_250_49
				end

				arg_247_1.var_.alphaOldValue10018 = 0
			end

			local var_250_50 = 0.5

			if var_250_48 <= arg_247_1.time_ and arg_247_1.time_ < var_250_48 + var_250_50 then
				local var_250_51 = (arg_247_1.time_ - var_250_48) / var_250_50
				local var_250_52 = Mathf.Lerp(arg_247_1.var_.alphaOldValue10018, 1, var_250_51)

				if arg_247_1.var_.characterEffect10018 then
					arg_247_1.var_.characterEffect10018.alpha = var_250_52
				end
			end

			if arg_247_1.time_ >= var_250_48 + var_250_50 and arg_247_1.time_ < var_250_48 + var_250_50 + arg_250_0 and arg_247_1.var_.characterEffect10018 then
				arg_247_1.var_.characterEffect10018.alpha = 1
			end

			if arg_247_1.frameCnt_ <= 1 then
				arg_247_1.dialog_:SetActive(false)
			end

			local var_250_53 = 1.999999999999
			local var_250_54 = 0.85

			if var_250_53 < arg_247_1.time_ and arg_247_1.time_ <= var_250_53 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0

				arg_247_1.dialog_:SetActive(true)

				arg_247_1.dialogCg_.alpha = 0

				local var_250_55 = LeanTween.value(arg_247_1.dialog_, 0, 1, 0.3)

				var_250_55:setOnUpdate(LuaHelper.FloatAction(function(arg_251_0)
					arg_247_1.dialogCg_.alpha = arg_251_0
				end))
				var_250_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_247_1.dialog_)
					var_250_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_247_1.duration_ = arg_247_1.duration_ + 0.3

				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_56 = arg_247_1:FormatText(StoryNameCfg[257].name)

				arg_247_1.leftNameTxt_.text = var_250_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_57 = arg_247_1:GetWordFromCfg(114242060)
				local var_250_58 = arg_247_1:FormatText(var_250_57.content)

				arg_247_1.text_.text = var_250_58

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_59 = 34
				local var_250_60 = utf8.len(var_250_58)
				local var_250_61 = var_250_59 <= 0 and var_250_54 or var_250_54 * (var_250_60 / var_250_59)

				if var_250_61 > 0 and var_250_54 < var_250_61 then
					arg_247_1.talkMaxDuration = var_250_61
					var_250_53 = var_250_53 + 0.3

					if var_250_61 + var_250_53 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_61 + var_250_53
					end
				end

				arg_247_1.text_.text = var_250_58
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242060", "story_v_out_114242.awb") ~= 0 then
					local var_250_62 = manager.audio:GetVoiceLength("story_v_out_114242", "114242060", "story_v_out_114242.awb") / 1000

					if var_250_62 + var_250_53 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_62 + var_250_53
					end

					if var_250_57.prefab_name ~= "" and arg_247_1.actors_[var_250_57.prefab_name] ~= nil then
						local var_250_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_57.prefab_name].transform, "story_v_out_114242", "114242060", "story_v_out_114242.awb")

						arg_247_1:RecordAudio("114242060", var_250_63)
						arg_247_1:RecordAudio("114242060", var_250_63)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_114242", "114242060", "story_v_out_114242.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_114242", "114242060", "story_v_out_114242.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_64 = var_250_53 + 0.3
			local var_250_65 = math.max(var_250_54, arg_247_1.talkMaxDuration)

			if var_250_64 <= arg_247_1.time_ and arg_247_1.time_ < var_250_64 + var_250_65 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_64) / var_250_65

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_64 + var_250_65 and arg_247_1.time_ < var_250_64 + var_250_65 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104201_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play114242061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 114242061
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play114242062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["10018"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.actorSpriteComps10018 == nil then
				arg_253_1.var_.actorSpriteComps10018 = var_256_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_2 = 0.034

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.actorSpriteComps10018 then
					for iter_256_0, iter_256_1 in pairs(arg_253_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_256_1 then
							if arg_253_1.isInRecall_ then
								local var_256_4 = Mathf.Lerp(iter_256_1.color.r, arg_253_1.hightColor2.r, var_256_3)
								local var_256_5 = Mathf.Lerp(iter_256_1.color.g, arg_253_1.hightColor2.g, var_256_3)
								local var_256_6 = Mathf.Lerp(iter_256_1.color.b, arg_253_1.hightColor2.b, var_256_3)

								iter_256_1.color = Color.New(var_256_4, var_256_5, var_256_6)
							else
								local var_256_7 = Mathf.Lerp(iter_256_1.color.r, 0.5, var_256_3)

								iter_256_1.color = Color.New(var_256_7, var_256_7, var_256_7)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.actorSpriteComps10018 then
				for iter_256_2, iter_256_3 in pairs(arg_253_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_256_3 then
						if arg_253_1.isInRecall_ then
							iter_256_3.color = arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_256_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps10018 = nil
			end

			local var_256_8 = 0
			local var_256_9 = 0.7

			if var_256_8 < arg_253_1.time_ and arg_253_1.time_ <= var_256_8 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_10 = arg_253_1:GetWordFromCfg(114242061)
				local var_256_11 = arg_253_1:FormatText(var_256_10.content)

				arg_253_1.text_.text = var_256_11

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_12 = 28
				local var_256_13 = utf8.len(var_256_11)
				local var_256_14 = var_256_12 <= 0 and var_256_9 or var_256_9 * (var_256_13 / var_256_12)

				if var_256_14 > 0 and var_256_9 < var_256_14 then
					arg_253_1.talkMaxDuration = var_256_14

					if var_256_14 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_14 + var_256_8
					end
				end

				arg_253_1.text_.text = var_256_11
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_15 = math.max(var_256_9, arg_253_1.talkMaxDuration)

			if var_256_8 <= arg_253_1.time_ and arg_253_1.time_ < var_256_8 + var_256_15 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_8) / var_256_15

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_8 + var_256_15 and arg_253_1.time_ < var_256_8 + var_256_15 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play114242062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 114242062
		arg_257_1.duration_ = 12.2

		local var_257_0 = {
			ja = 12.2,
			ko = 10.633,
			zh = 11.933,
			en = 8.633
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play114242063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["10018"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps10018 == nil then
				arg_257_1.var_.actorSpriteComps10018 = var_260_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_2 = 0.034

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.actorSpriteComps10018 then
					for iter_260_0, iter_260_1 in pairs(arg_257_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_260_1 then
							if arg_257_1.isInRecall_ then
								local var_260_4 = Mathf.Lerp(iter_260_1.color.r, arg_257_1.hightColor1.r, var_260_3)
								local var_260_5 = Mathf.Lerp(iter_260_1.color.g, arg_257_1.hightColor1.g, var_260_3)
								local var_260_6 = Mathf.Lerp(iter_260_1.color.b, arg_257_1.hightColor1.b, var_260_3)

								iter_260_1.color = Color.New(var_260_4, var_260_5, var_260_6)
							else
								local var_260_7 = Mathf.Lerp(iter_260_1.color.r, 1, var_260_3)

								iter_260_1.color = Color.New(var_260_7, var_260_7, var_260_7)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps10018 then
				for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_260_3 then
						if arg_257_1.isInRecall_ then
							iter_260_3.color = arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_260_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps10018 = nil
			end

			local var_260_8 = 0
			local var_260_9 = 1.3

			if var_260_8 < arg_257_1.time_ and arg_257_1.time_ <= var_260_8 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_10 = arg_257_1:FormatText(StoryNameCfg[257].name)

				arg_257_1.leftNameTxt_.text = var_260_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_11 = arg_257_1:GetWordFromCfg(114242062)
				local var_260_12 = arg_257_1:FormatText(var_260_11.content)

				arg_257_1.text_.text = var_260_12

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_13 = 51
				local var_260_14 = utf8.len(var_260_12)
				local var_260_15 = var_260_13 <= 0 and var_260_9 or var_260_9 * (var_260_14 / var_260_13)

				if var_260_15 > 0 and var_260_9 < var_260_15 then
					arg_257_1.talkMaxDuration = var_260_15

					if var_260_15 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_15 + var_260_8
					end
				end

				arg_257_1.text_.text = var_260_12
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242062", "story_v_out_114242.awb") ~= 0 then
					local var_260_16 = manager.audio:GetVoiceLength("story_v_out_114242", "114242062", "story_v_out_114242.awb") / 1000

					if var_260_16 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_16 + var_260_8
					end

					if var_260_11.prefab_name ~= "" and arg_257_1.actors_[var_260_11.prefab_name] ~= nil then
						local var_260_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_11.prefab_name].transform, "story_v_out_114242", "114242062", "story_v_out_114242.awb")

						arg_257_1:RecordAudio("114242062", var_260_17)
						arg_257_1:RecordAudio("114242062", var_260_17)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_114242", "114242062", "story_v_out_114242.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_114242", "114242062", "story_v_out_114242.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_18 = math.max(var_260_9, arg_257_1.talkMaxDuration)

			if var_260_8 <= arg_257_1.time_ and arg_257_1.time_ < var_260_8 + var_260_18 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_8) / var_260_18

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_8 + var_260_18 and arg_257_1.time_ < var_260_8 + var_260_18 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play114242063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 114242063
		arg_261_1.duration_ = 12.2

		local var_261_0 = {
			ja = 12.2,
			ko = 10.6,
			zh = 9.866,
			en = 7.7
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
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play114242064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["10015"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos10015 = var_264_0.localPosition
				var_264_0.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("10015", 4)

				local var_264_2 = var_264_0.childCount

				for iter_264_0 = 0, var_264_2 - 1 do
					local var_264_3 = var_264_0:GetChild(iter_264_0)

					if var_264_3.name == "split_1" or not string.find(var_264_3.name, "split") then
						var_264_3.gameObject:SetActive(true)
					else
						var_264_3.gameObject:SetActive(false)
					end
				end
			end

			local var_264_4 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_4 then
				local var_264_5 = (arg_261_1.time_ - var_264_1) / var_264_4
				local var_264_6 = Vector3.New(390, -350, -180)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10015, var_264_6, var_264_5)
			end

			if arg_261_1.time_ >= var_264_1 + var_264_4 and arg_261_1.time_ < var_264_1 + var_264_4 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_264_7 = arg_261_1.actors_["10018"]
			local var_264_8 = 0

			if var_264_8 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 and not isNil(var_264_7) and arg_261_1.var_.actorSpriteComps10018 == nil then
				arg_261_1.var_.actorSpriteComps10018 = var_264_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_9 = 0.034

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_9 and not isNil(var_264_7) then
				local var_264_10 = (arg_261_1.time_ - var_264_8) / var_264_9

				if arg_261_1.var_.actorSpriteComps10018 then
					for iter_264_1, iter_264_2 in pairs(arg_261_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_264_2 then
							if arg_261_1.isInRecall_ then
								local var_264_11 = Mathf.Lerp(iter_264_2.color.r, arg_261_1.hightColor2.r, var_264_10)
								local var_264_12 = Mathf.Lerp(iter_264_2.color.g, arg_261_1.hightColor2.g, var_264_10)
								local var_264_13 = Mathf.Lerp(iter_264_2.color.b, arg_261_1.hightColor2.b, var_264_10)

								iter_264_2.color = Color.New(var_264_11, var_264_12, var_264_13)
							else
								local var_264_14 = Mathf.Lerp(iter_264_2.color.r, 0.5, var_264_10)

								iter_264_2.color = Color.New(var_264_14, var_264_14, var_264_14)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_8 + var_264_9 and arg_261_1.time_ < var_264_8 + var_264_9 + arg_264_0 and not isNil(var_264_7) and arg_261_1.var_.actorSpriteComps10018 then
				for iter_264_3, iter_264_4 in pairs(arg_261_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_264_4 then
						if arg_261_1.isInRecall_ then
							iter_264_4.color = arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_264_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps10018 = nil
			end

			local var_264_15 = arg_261_1.actors_["10015"]
			local var_264_16 = 0

			if var_264_16 < arg_261_1.time_ and arg_261_1.time_ <= var_264_16 + arg_264_0 and not isNil(var_264_15) and arg_261_1.var_.actorSpriteComps10015 == nil then
				arg_261_1.var_.actorSpriteComps10015 = var_264_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_17 = 0.034

			if var_264_16 <= arg_261_1.time_ and arg_261_1.time_ < var_264_16 + var_264_17 and not isNil(var_264_15) then
				local var_264_18 = (arg_261_1.time_ - var_264_16) / var_264_17

				if arg_261_1.var_.actorSpriteComps10015 then
					for iter_264_5, iter_264_6 in pairs(arg_261_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_264_6 then
							if arg_261_1.isInRecall_ then
								local var_264_19 = Mathf.Lerp(iter_264_6.color.r, arg_261_1.hightColor1.r, var_264_18)
								local var_264_20 = Mathf.Lerp(iter_264_6.color.g, arg_261_1.hightColor1.g, var_264_18)
								local var_264_21 = Mathf.Lerp(iter_264_6.color.b, arg_261_1.hightColor1.b, var_264_18)

								iter_264_6.color = Color.New(var_264_19, var_264_20, var_264_21)
							else
								local var_264_22 = Mathf.Lerp(iter_264_6.color.r, 1, var_264_18)

								iter_264_6.color = Color.New(var_264_22, var_264_22, var_264_22)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_16 + var_264_17 and arg_261_1.time_ < var_264_16 + var_264_17 + arg_264_0 and not isNil(var_264_15) and arg_261_1.var_.actorSpriteComps10015 then
				for iter_264_7, iter_264_8 in pairs(arg_261_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_264_8 then
						if arg_261_1.isInRecall_ then
							iter_264_8.color = arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_264_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps10015 = nil
			end

			local var_264_23 = arg_261_1.actors_["10015"]
			local var_264_24 = 0

			if var_264_24 < arg_261_1.time_ and arg_261_1.time_ <= var_264_24 + arg_264_0 then
				local var_264_25 = var_264_23:GetComponentInChildren(typeof(CanvasGroup))

				if var_264_25 then
					arg_261_1.var_.alphaOldValue10015 = var_264_25.alpha
					arg_261_1.var_.characterEffect10015 = var_264_25
				end

				arg_261_1.var_.alphaOldValue10015 = 0
			end

			local var_264_26 = 0.5

			if var_264_24 <= arg_261_1.time_ and arg_261_1.time_ < var_264_24 + var_264_26 then
				local var_264_27 = (arg_261_1.time_ - var_264_24) / var_264_26
				local var_264_28 = Mathf.Lerp(arg_261_1.var_.alphaOldValue10015, 1, var_264_27)

				if arg_261_1.var_.characterEffect10015 then
					arg_261_1.var_.characterEffect10015.alpha = var_264_28
				end
			end

			if arg_261_1.time_ >= var_264_24 + var_264_26 and arg_261_1.time_ < var_264_24 + var_264_26 + arg_264_0 and arg_261_1.var_.characterEffect10015 then
				arg_261_1.var_.characterEffect10015.alpha = 1
			end

			local var_264_29 = 0
			local var_264_30 = 1.15

			if var_264_29 < arg_261_1.time_ and arg_261_1.time_ <= var_264_29 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_31 = arg_261_1:FormatText(StoryNameCfg[208].name)

				arg_261_1.leftNameTxt_.text = var_264_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_32 = arg_261_1:GetWordFromCfg(114242063)
				local var_264_33 = arg_261_1:FormatText(var_264_32.content)

				arg_261_1.text_.text = var_264_33

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_34 = 46
				local var_264_35 = utf8.len(var_264_33)
				local var_264_36 = var_264_34 <= 0 and var_264_30 or var_264_30 * (var_264_35 / var_264_34)

				if var_264_36 > 0 and var_264_30 < var_264_36 then
					arg_261_1.talkMaxDuration = var_264_36

					if var_264_36 + var_264_29 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_36 + var_264_29
					end
				end

				arg_261_1.text_.text = var_264_33
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242063", "story_v_out_114242.awb") ~= 0 then
					local var_264_37 = manager.audio:GetVoiceLength("story_v_out_114242", "114242063", "story_v_out_114242.awb") / 1000

					if var_264_37 + var_264_29 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_37 + var_264_29
					end

					if var_264_32.prefab_name ~= "" and arg_261_1.actors_[var_264_32.prefab_name] ~= nil then
						local var_264_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_32.prefab_name].transform, "story_v_out_114242", "114242063", "story_v_out_114242.awb")

						arg_261_1:RecordAudio("114242063", var_264_38)
						arg_261_1:RecordAudio("114242063", var_264_38)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_114242", "114242063", "story_v_out_114242.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_114242", "114242063", "story_v_out_114242.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_39 = math.max(var_264_30, arg_261_1.talkMaxDuration)

			if var_264_29 <= arg_261_1.time_ and arg_261_1.time_ < var_264_29 + var_264_39 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_29) / var_264_39

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_29 + var_264_39 and arg_261_1.time_ < var_264_29 + var_264_39 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play114242064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 114242064
		arg_265_1.duration_ = 8.43

		local var_265_0 = {
			ja = 3.9,
			ko = 7.833,
			zh = 7.6,
			en = 8.433
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play114242065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.925

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[208].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_3 = arg_265_1:GetWordFromCfg(114242064)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 37
				local var_268_6 = utf8.len(var_268_4)
				local var_268_7 = var_268_5 <= 0 and var_268_1 or var_268_1 * (var_268_6 / var_268_5)

				if var_268_7 > 0 and var_268_1 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_0
					end
				end

				arg_265_1.text_.text = var_268_4
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242064", "story_v_out_114242.awb") ~= 0 then
					local var_268_8 = manager.audio:GetVoiceLength("story_v_out_114242", "114242064", "story_v_out_114242.awb") / 1000

					if var_268_8 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_0
					end

					if var_268_3.prefab_name ~= "" and arg_265_1.actors_[var_268_3.prefab_name] ~= nil then
						local var_268_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_3.prefab_name].transform, "story_v_out_114242", "114242064", "story_v_out_114242.awb")

						arg_265_1:RecordAudio("114242064", var_268_9)
						arg_265_1:RecordAudio("114242064", var_268_9)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_114242", "114242064", "story_v_out_114242.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_114242", "114242064", "story_v_out_114242.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_10 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_10 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_10

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_10 and arg_265_1.time_ < var_268_0 + var_268_10 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play114242065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 114242065
		arg_269_1.duration_ = 8.67

		local var_269_0 = {
			ja = 8.4,
			ko = 8.666,
			zh = 7.3,
			en = 8
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play114242066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0
			local var_272_1 = 0.9

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_2 = arg_269_1:FormatText(StoryNameCfg[208].name)

				arg_269_1.leftNameTxt_.text = var_272_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_3 = arg_269_1:GetWordFromCfg(114242065)
				local var_272_4 = arg_269_1:FormatText(var_272_3.content)

				arg_269_1.text_.text = var_272_4

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 36
				local var_272_6 = utf8.len(var_272_4)
				local var_272_7 = var_272_5 <= 0 and var_272_1 or var_272_1 * (var_272_6 / var_272_5)

				if var_272_7 > 0 and var_272_1 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_4
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242065", "story_v_out_114242.awb") ~= 0 then
					local var_272_8 = manager.audio:GetVoiceLength("story_v_out_114242", "114242065", "story_v_out_114242.awb") / 1000

					if var_272_8 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_0
					end

					if var_272_3.prefab_name ~= "" and arg_269_1.actors_[var_272_3.prefab_name] ~= nil then
						local var_272_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_3.prefab_name].transform, "story_v_out_114242", "114242065", "story_v_out_114242.awb")

						arg_269_1:RecordAudio("114242065", var_272_9)
						arg_269_1:RecordAudio("114242065", var_272_9)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_114242", "114242065", "story_v_out_114242.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_114242", "114242065", "story_v_out_114242.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_10 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_10 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_10

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_10 and arg_269_1.time_ < var_272_0 + var_272_10 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play114242066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 114242066
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play114242067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["10015"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.actorSpriteComps10015 == nil then
				arg_273_1.var_.actorSpriteComps10015 = var_276_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_2 = 0.034

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.actorSpriteComps10015 then
					for iter_276_0, iter_276_1 in pairs(arg_273_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_276_1 then
							if arg_273_1.isInRecall_ then
								local var_276_4 = Mathf.Lerp(iter_276_1.color.r, arg_273_1.hightColor2.r, var_276_3)
								local var_276_5 = Mathf.Lerp(iter_276_1.color.g, arg_273_1.hightColor2.g, var_276_3)
								local var_276_6 = Mathf.Lerp(iter_276_1.color.b, arg_273_1.hightColor2.b, var_276_3)

								iter_276_1.color = Color.New(var_276_4, var_276_5, var_276_6)
							else
								local var_276_7 = Mathf.Lerp(iter_276_1.color.r, 0.5, var_276_3)

								iter_276_1.color = Color.New(var_276_7, var_276_7, var_276_7)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.actorSpriteComps10015 then
				for iter_276_2, iter_276_3 in pairs(arg_273_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_276_3 then
						if arg_273_1.isInRecall_ then
							iter_276_3.color = arg_273_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_276_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_273_1.var_.actorSpriteComps10015 = nil
			end

			local var_276_8 = 0
			local var_276_9 = 1.65

			if var_276_8 < arg_273_1.time_ and arg_273_1.time_ <= var_276_8 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_10 = arg_273_1:GetWordFromCfg(114242066)
				local var_276_11 = arg_273_1:FormatText(var_276_10.content)

				arg_273_1.text_.text = var_276_11

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_12 = 66
				local var_276_13 = utf8.len(var_276_11)
				local var_276_14 = var_276_12 <= 0 and var_276_9 or var_276_9 * (var_276_13 / var_276_12)

				if var_276_14 > 0 and var_276_9 < var_276_14 then
					arg_273_1.talkMaxDuration = var_276_14

					if var_276_14 + var_276_8 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_14 + var_276_8
					end
				end

				arg_273_1.text_.text = var_276_11
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_15 = math.max(var_276_9, arg_273_1.talkMaxDuration)

			if var_276_8 <= arg_273_1.time_ and arg_273_1.time_ < var_276_8 + var_276_15 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_8) / var_276_15

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_8 + var_276_15 and arg_273_1.time_ < var_276_8 + var_276_15 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play114242067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 114242067
		arg_277_1.duration_ = 6.63

		local var_277_0 = {
			ja = 6.633,
			ko = 4.466,
			zh = 4.1,
			en = 3.666
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play114242068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["10015"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos10015 = var_280_0.localPosition
				var_280_0.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("10015", 4)

				local var_280_2 = var_280_0.childCount

				for iter_280_0 = 0, var_280_2 - 1 do
					local var_280_3 = var_280_0:GetChild(iter_280_0)

					if var_280_3.name == "split_2" or not string.find(var_280_3.name, "split") then
						var_280_3.gameObject:SetActive(true)
					else
						var_280_3.gameObject:SetActive(false)
					end
				end
			end

			local var_280_4 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_4 then
				local var_280_5 = (arg_277_1.time_ - var_280_1) / var_280_4
				local var_280_6 = Vector3.New(390, -350, -180)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10015, var_280_6, var_280_5)
			end

			if arg_277_1.time_ >= var_280_1 + var_280_4 and arg_277_1.time_ < var_280_1 + var_280_4 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_280_7 = arg_277_1.actors_["10015"]
			local var_280_8 = 0

			if var_280_8 < arg_277_1.time_ and arg_277_1.time_ <= var_280_8 + arg_280_0 and not isNil(var_280_7) and arg_277_1.var_.actorSpriteComps10015 == nil then
				arg_277_1.var_.actorSpriteComps10015 = var_280_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_9 = 0.034

			if var_280_8 <= arg_277_1.time_ and arg_277_1.time_ < var_280_8 + var_280_9 and not isNil(var_280_7) then
				local var_280_10 = (arg_277_1.time_ - var_280_8) / var_280_9

				if arg_277_1.var_.actorSpriteComps10015 then
					for iter_280_1, iter_280_2 in pairs(arg_277_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_280_2 then
							if arg_277_1.isInRecall_ then
								local var_280_11 = Mathf.Lerp(iter_280_2.color.r, arg_277_1.hightColor1.r, var_280_10)
								local var_280_12 = Mathf.Lerp(iter_280_2.color.g, arg_277_1.hightColor1.g, var_280_10)
								local var_280_13 = Mathf.Lerp(iter_280_2.color.b, arg_277_1.hightColor1.b, var_280_10)

								iter_280_2.color = Color.New(var_280_11, var_280_12, var_280_13)
							else
								local var_280_14 = Mathf.Lerp(iter_280_2.color.r, 1, var_280_10)

								iter_280_2.color = Color.New(var_280_14, var_280_14, var_280_14)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= var_280_8 + var_280_9 and arg_277_1.time_ < var_280_8 + var_280_9 + arg_280_0 and not isNil(var_280_7) and arg_277_1.var_.actorSpriteComps10015 then
				for iter_280_3, iter_280_4 in pairs(arg_277_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_280_4 then
						if arg_277_1.isInRecall_ then
							iter_280_4.color = arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_280_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps10015 = nil
			end

			local var_280_15 = 0
			local var_280_16 = 0.45

			if var_280_15 < arg_277_1.time_ and arg_277_1.time_ <= var_280_15 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_17 = arg_277_1:FormatText(StoryNameCfg[208].name)

				arg_277_1.leftNameTxt_.text = var_280_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_18 = arg_277_1:GetWordFromCfg(114242067)
				local var_280_19 = arg_277_1:FormatText(var_280_18.content)

				arg_277_1.text_.text = var_280_19

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_20 = 18
				local var_280_21 = utf8.len(var_280_19)
				local var_280_22 = var_280_20 <= 0 and var_280_16 or var_280_16 * (var_280_21 / var_280_20)

				if var_280_22 > 0 and var_280_16 < var_280_22 then
					arg_277_1.talkMaxDuration = var_280_22

					if var_280_22 + var_280_15 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_22 + var_280_15
					end
				end

				arg_277_1.text_.text = var_280_19
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242067", "story_v_out_114242.awb") ~= 0 then
					local var_280_23 = manager.audio:GetVoiceLength("story_v_out_114242", "114242067", "story_v_out_114242.awb") / 1000

					if var_280_23 + var_280_15 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_23 + var_280_15
					end

					if var_280_18.prefab_name ~= "" and arg_277_1.actors_[var_280_18.prefab_name] ~= nil then
						local var_280_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_18.prefab_name].transform, "story_v_out_114242", "114242067", "story_v_out_114242.awb")

						arg_277_1:RecordAudio("114242067", var_280_24)
						arg_277_1:RecordAudio("114242067", var_280_24)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_114242", "114242067", "story_v_out_114242.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_114242", "114242067", "story_v_out_114242.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_25 = math.max(var_280_16, arg_277_1.talkMaxDuration)

			if var_280_15 <= arg_277_1.time_ and arg_277_1.time_ < var_280_15 + var_280_25 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_15) / var_280_25

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_15 + var_280_25 and arg_277_1.time_ < var_280_15 + var_280_25 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play114242068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 114242068
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play114242069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["10015"]
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.actorSpriteComps10015 == nil then
				arg_281_1.var_.actorSpriteComps10015 = var_284_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_2 = 0.034

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 and not isNil(var_284_0) then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2

				if arg_281_1.var_.actorSpriteComps10015 then
					for iter_284_0, iter_284_1 in pairs(arg_281_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_284_1 then
							if arg_281_1.isInRecall_ then
								local var_284_4 = Mathf.Lerp(iter_284_1.color.r, arg_281_1.hightColor2.r, var_284_3)
								local var_284_5 = Mathf.Lerp(iter_284_1.color.g, arg_281_1.hightColor2.g, var_284_3)
								local var_284_6 = Mathf.Lerp(iter_284_1.color.b, arg_281_1.hightColor2.b, var_284_3)

								iter_284_1.color = Color.New(var_284_4, var_284_5, var_284_6)
							else
								local var_284_7 = Mathf.Lerp(iter_284_1.color.r, 0.5, var_284_3)

								iter_284_1.color = Color.New(var_284_7, var_284_7, var_284_7)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.actorSpriteComps10015 then
				for iter_284_2, iter_284_3 in pairs(arg_281_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_284_3 then
						if arg_281_1.isInRecall_ then
							iter_284_3.color = arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_284_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_281_1.var_.actorSpriteComps10015 = nil
			end

			local var_284_8 = 0
			local var_284_9 = 0.875

			if var_284_8 < arg_281_1.time_ and arg_281_1.time_ <= var_284_8 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_10 = arg_281_1:GetWordFromCfg(114242068)
				local var_284_11 = arg_281_1:FormatText(var_284_10.content)

				arg_281_1.text_.text = var_284_11

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_12 = 35
				local var_284_13 = utf8.len(var_284_11)
				local var_284_14 = var_284_12 <= 0 and var_284_9 or var_284_9 * (var_284_13 / var_284_12)

				if var_284_14 > 0 and var_284_9 < var_284_14 then
					arg_281_1.talkMaxDuration = var_284_14

					if var_284_14 + var_284_8 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_14 + var_284_8
					end
				end

				arg_281_1.text_.text = var_284_11
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_15 = math.max(var_284_9, arg_281_1.talkMaxDuration)

			if var_284_8 <= arg_281_1.time_ and arg_281_1.time_ < var_284_8 + var_284_15 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_8) / var_284_15

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_8 + var_284_15 and arg_281_1.time_ < var_284_8 + var_284_15 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play114242069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 114242069
		arg_285_1.duration_ = 1.5

		local var_285_0 = {
			ja = 1.5,
			ko = 1.4,
			en = 1.4
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play114242070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["10015"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.actorSpriteComps10015 == nil then
				arg_285_1.var_.actorSpriteComps10015 = var_288_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_2 = 0.034

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.actorSpriteComps10015 then
					for iter_288_0, iter_288_1 in pairs(arg_285_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_288_1 then
							if arg_285_1.isInRecall_ then
								local var_288_4 = Mathf.Lerp(iter_288_1.color.r, arg_285_1.hightColor1.r, var_288_3)
								local var_288_5 = Mathf.Lerp(iter_288_1.color.g, arg_285_1.hightColor1.g, var_288_3)
								local var_288_6 = Mathf.Lerp(iter_288_1.color.b, arg_285_1.hightColor1.b, var_288_3)

								iter_288_1.color = Color.New(var_288_4, var_288_5, var_288_6)
							else
								local var_288_7 = Mathf.Lerp(iter_288_1.color.r, 1, var_288_3)

								iter_288_1.color = Color.New(var_288_7, var_288_7, var_288_7)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.actorSpriteComps10015 then
				for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_288_3 then
						if arg_285_1.isInRecall_ then
							iter_288_3.color = arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_288_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps10015 = nil
			end

			local var_288_8 = arg_285_1.actors_["10015"].transform
			local var_288_9 = 0

			if var_288_9 < arg_285_1.time_ and arg_285_1.time_ <= var_288_9 + arg_288_0 then
				arg_285_1.var_.moveOldPos10015 = var_288_8.localPosition
				var_288_8.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("10015", 4)

				local var_288_10 = var_288_8.childCount

				for iter_288_4 = 0, var_288_10 - 1 do
					local var_288_11 = var_288_8:GetChild(iter_288_4)

					if var_288_11.name == "split_1" or not string.find(var_288_11.name, "split") then
						var_288_11.gameObject:SetActive(true)
					else
						var_288_11.gameObject:SetActive(false)
					end
				end
			end

			local var_288_12 = 0.001

			if var_288_9 <= arg_285_1.time_ and arg_285_1.time_ < var_288_9 + var_288_12 then
				local var_288_13 = (arg_285_1.time_ - var_288_9) / var_288_12
				local var_288_14 = Vector3.New(390, -350, -180)

				var_288_8.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10015, var_288_14, var_288_13)
			end

			if arg_285_1.time_ >= var_288_9 + var_288_12 and arg_285_1.time_ < var_288_9 + var_288_12 + arg_288_0 then
				var_288_8.localPosition = Vector3.New(390, -350, -180)
			end

			local var_288_15 = 0
			local var_288_16 = 0.05

			if var_288_15 < arg_285_1.time_ and arg_285_1.time_ <= var_288_15 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_17 = arg_285_1:FormatText(StoryNameCfg[208].name)

				arg_285_1.leftNameTxt_.text = var_288_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_18 = arg_285_1:GetWordFromCfg(114242069)
				local var_288_19 = arg_285_1:FormatText(var_288_18.content)

				arg_285_1.text_.text = var_288_19

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_20 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242069", "story_v_out_114242.awb") ~= 0 then
					local var_288_23 = manager.audio:GetVoiceLength("story_v_out_114242", "114242069", "story_v_out_114242.awb") / 1000

					if var_288_23 + var_288_15 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_23 + var_288_15
					end

					if var_288_18.prefab_name ~= "" and arg_285_1.actors_[var_288_18.prefab_name] ~= nil then
						local var_288_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_18.prefab_name].transform, "story_v_out_114242", "114242069", "story_v_out_114242.awb")

						arg_285_1:RecordAudio("114242069", var_288_24)
						arg_285_1:RecordAudio("114242069", var_288_24)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_114242", "114242069", "story_v_out_114242.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_114242", "114242069", "story_v_out_114242.awb")
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
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play114242070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 114242070
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play114242071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["10015"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				local var_292_2 = var_292_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_292_2 then
					arg_289_1.var_.alphaOldValue10015 = var_292_2.alpha
					arg_289_1.var_.characterEffect10015 = var_292_2
				end

				arg_289_1.var_.alphaOldValue10015 = 1
			end

			local var_292_3 = 0.5

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_3 then
				local var_292_4 = (arg_289_1.time_ - var_292_1) / var_292_3
				local var_292_5 = Mathf.Lerp(arg_289_1.var_.alphaOldValue10015, 0, var_292_4)

				if arg_289_1.var_.characterEffect10015 then
					arg_289_1.var_.characterEffect10015.alpha = var_292_5
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_3 and arg_289_1.time_ < var_292_1 + var_292_3 + arg_292_0 and arg_289_1.var_.characterEffect10015 then
				arg_289_1.var_.characterEffect10015.alpha = 0
			end

			local var_292_6 = arg_289_1.actors_["10018"]
			local var_292_7 = 0

			if var_292_7 < arg_289_1.time_ and arg_289_1.time_ <= var_292_7 + arg_292_0 then
				local var_292_8 = var_292_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_292_8 then
					arg_289_1.var_.alphaOldValue10018 = var_292_8.alpha
					arg_289_1.var_.characterEffect10018 = var_292_8
				end

				arg_289_1.var_.alphaOldValue10018 = 1
			end

			local var_292_9 = 0.5

			if var_292_7 <= arg_289_1.time_ and arg_289_1.time_ < var_292_7 + var_292_9 then
				local var_292_10 = (arg_289_1.time_ - var_292_7) / var_292_9
				local var_292_11 = Mathf.Lerp(arg_289_1.var_.alphaOldValue10018, 0, var_292_10)

				if arg_289_1.var_.characterEffect10018 then
					arg_289_1.var_.characterEffect10018.alpha = var_292_11
				end
			end

			if arg_289_1.time_ >= var_292_7 + var_292_9 and arg_289_1.time_ < var_292_7 + var_292_9 + arg_292_0 and arg_289_1.var_.characterEffect10018 then
				arg_289_1.var_.characterEffect10018.alpha = 0
			end

			local var_292_12 = 0
			local var_292_13 = 0.675

			if var_292_12 < arg_289_1.time_ and arg_289_1.time_ <= var_292_12 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_14 = arg_289_1:GetWordFromCfg(114242070)
				local var_292_15 = arg_289_1:FormatText(var_292_14.content)

				arg_289_1.text_.text = var_292_15

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_16 = 27
				local var_292_17 = utf8.len(var_292_15)
				local var_292_18 = var_292_16 <= 0 and var_292_13 or var_292_13 * (var_292_17 / var_292_16)

				if var_292_18 > 0 and var_292_13 < var_292_18 then
					arg_289_1.talkMaxDuration = var_292_18

					if var_292_18 + var_292_12 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_18 + var_292_12
					end
				end

				arg_289_1.text_.text = var_292_15
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_19 = math.max(var_292_13, arg_289_1.talkMaxDuration)

			if var_292_12 <= arg_289_1.time_ and arg_289_1.time_ < var_292_12 + var_292_19 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_12) / var_292_19

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_12 + var_292_19 and arg_289_1.time_ < var_292_12 + var_292_19 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play114242071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 114242071
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play114242072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0
			local var_296_1 = 1.15

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_2 = arg_293_1:GetWordFromCfg(114242071)
				local var_296_3 = arg_293_1:FormatText(var_296_2.content)

				arg_293_1.text_.text = var_296_3

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_4 = 46
				local var_296_5 = utf8.len(var_296_3)
				local var_296_6 = var_296_4 <= 0 and var_296_1 or var_296_1 * (var_296_5 / var_296_4)

				if var_296_6 > 0 and var_296_1 < var_296_6 then
					arg_293_1.talkMaxDuration = var_296_6

					if var_296_6 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_6 + var_296_0
					end
				end

				arg_293_1.text_.text = var_296_3
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_7 = math.max(var_296_1, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_7 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_0) / var_296_7

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_7 and arg_293_1.time_ < var_296_0 + var_296_7 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play114242072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 114242072
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play114242073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0
			local var_300_1 = 0.475

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_2 = arg_297_1:GetWordFromCfg(114242072)
				local var_300_3 = arg_297_1:FormatText(var_300_2.content)

				arg_297_1.text_.text = var_300_3

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_4 = 19
				local var_300_5 = utf8.len(var_300_3)
				local var_300_6 = var_300_4 <= 0 and var_300_1 or var_300_1 * (var_300_5 / var_300_4)

				if var_300_6 > 0 and var_300_1 < var_300_6 then
					arg_297_1.talkMaxDuration = var_300_6

					if var_300_6 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_6 + var_300_0
					end
				end

				arg_297_1.text_.text = var_300_3
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_7 = math.max(var_300_1, arg_297_1.talkMaxDuration)

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_7 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_0) / var_300_7

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_0 + var_300_7 and arg_297_1.time_ < var_300_0 + var_300_7 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play114242073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 114242073
		arg_301_1.duration_ = 6.63

		local var_301_0 = {
			ja = 6.633,
			ko = 5.733,
			zh = 5.5,
			en = 6.566
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play114242074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = manager.ui.mainCamera.transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.shakeOldPos = var_304_0.localPosition
			end

			local var_304_2 = 0.6

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / 0
				local var_304_4, var_304_5 = math.modf(var_304_3)

				var_304_0.localPosition = Vector3.New(var_304_5 * 0, var_304_5 * 0, var_304_5 * 0) + arg_301_1.var_.shakeOldPos
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 then
				var_304_0.localPosition = arg_301_1.var_.shakeOldPos
			end

			local var_304_6 = 0

			if var_304_6 < arg_301_1.time_ and arg_301_1.time_ <= var_304_6 + arg_304_0 then
				arg_301_1.allBtn_.enabled = false
			end

			local var_304_7 = 0.6

			if arg_301_1.time_ >= var_304_6 + var_304_7 and arg_301_1.time_ < var_304_6 + var_304_7 + arg_304_0 then
				arg_301_1.allBtn_.enabled = true
			end

			local var_304_8 = 0
			local var_304_9 = 0.6

			if var_304_8 < arg_301_1.time_ and arg_301_1.time_ <= var_304_8 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_10 = arg_301_1:FormatText(StoryNameCfg[36].name)

				arg_301_1.leftNameTxt_.text = var_304_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_11 = arg_301_1:GetWordFromCfg(114242073)
				local var_304_12 = arg_301_1:FormatText(var_304_11.content)

				arg_301_1.text_.text = var_304_12

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_13 = 24
				local var_304_14 = utf8.len(var_304_12)
				local var_304_15 = var_304_13 <= 0 and var_304_9 or var_304_9 * (var_304_14 / var_304_13)

				if var_304_15 > 0 and var_304_9 < var_304_15 then
					arg_301_1.talkMaxDuration = var_304_15

					if var_304_15 + var_304_8 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_15 + var_304_8
					end
				end

				arg_301_1.text_.text = var_304_12
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242073", "story_v_out_114242.awb") ~= 0 then
					local var_304_16 = manager.audio:GetVoiceLength("story_v_out_114242", "114242073", "story_v_out_114242.awb") / 1000

					if var_304_16 + var_304_8 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_16 + var_304_8
					end

					if var_304_11.prefab_name ~= "" and arg_301_1.actors_[var_304_11.prefab_name] ~= nil then
						local var_304_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_11.prefab_name].transform, "story_v_out_114242", "114242073", "story_v_out_114242.awb")

						arg_301_1:RecordAudio("114242073", var_304_17)
						arg_301_1:RecordAudio("114242073", var_304_17)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_114242", "114242073", "story_v_out_114242.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_114242", "114242073", "story_v_out_114242.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_18 = math.max(var_304_9, arg_301_1.talkMaxDuration)

			if var_304_8 <= arg_301_1.time_ and arg_301_1.time_ < var_304_8 + var_304_18 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_8) / var_304_18

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_8 + var_304_18 and arg_301_1.time_ < var_304_8 + var_304_18 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play114242074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 114242074
		arg_305_1.duration_ = 1.17

		local var_305_0 = {
			ja = 1.166,
			ko = 0.999999999999,
			zh = 0.999999999999,
			en = 1.166
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play114242075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 1

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				local var_308_2 = "play"
				local var_308_3 = "effect"

				arg_305_1:AudioAction(var_308_2, var_308_3, "se_story_activity_1_4_3", "se_story_activity_1_4_3_sword", "")
			end

			local var_308_4 = 0
			local var_308_5 = 0.1

			if var_308_4 < arg_305_1.time_ and arg_305_1.time_ <= var_308_4 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_6 = arg_305_1:FormatText(StoryNameCfg[208].name)

				arg_305_1.leftNameTxt_.text = var_308_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10015_split4")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_7 = arg_305_1:GetWordFromCfg(114242074)
				local var_308_8 = arg_305_1:FormatText(var_308_7.content)

				arg_305_1.text_.text = var_308_8

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_9 = 4
				local var_308_10 = utf8.len(var_308_8)
				local var_308_11 = var_308_9 <= 0 and var_308_5 or var_308_5 * (var_308_10 / var_308_9)

				if var_308_11 > 0 and var_308_5 < var_308_11 then
					arg_305_1.talkMaxDuration = var_308_11

					if var_308_11 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_11 + var_308_4
					end
				end

				arg_305_1.text_.text = var_308_8
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242074", "story_v_out_114242.awb") ~= 0 then
					local var_308_12 = manager.audio:GetVoiceLength("story_v_out_114242", "114242074", "story_v_out_114242.awb") / 1000

					if var_308_12 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_12 + var_308_4
					end

					if var_308_7.prefab_name ~= "" and arg_305_1.actors_[var_308_7.prefab_name] ~= nil then
						local var_308_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_7.prefab_name].transform, "story_v_out_114242", "114242074", "story_v_out_114242.awb")

						arg_305_1:RecordAudio("114242074", var_308_13)
						arg_305_1:RecordAudio("114242074", var_308_13)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_114242", "114242074", "story_v_out_114242.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_114242", "114242074", "story_v_out_114242.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_14 = math.max(var_308_5, arg_305_1.talkMaxDuration)

			if var_308_4 <= arg_305_1.time_ and arg_305_1.time_ < var_308_4 + var_308_14 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_4) / var_308_14

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_4 + var_308_14 and arg_305_1.time_ < var_308_4 + var_308_14 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play114242075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 114242075
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play114242076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 1.5

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_2 = arg_309_1:GetWordFromCfg(114242075)
				local var_312_3 = arg_309_1:FormatText(var_312_2.content)

				arg_309_1.text_.text = var_312_3

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_4 = 60
				local var_312_5 = utf8.len(var_312_3)
				local var_312_6 = var_312_4 <= 0 and var_312_1 or var_312_1 * (var_312_5 / var_312_4)

				if var_312_6 > 0 and var_312_1 < var_312_6 then
					arg_309_1.talkMaxDuration = var_312_6

					if var_312_6 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_6 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_3
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_7 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_7 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_7

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_7 and arg_309_1.time_ < var_312_0 + var_312_7 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play114242076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 114242076
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play114242077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0
			local var_316_1 = 0.75

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_2 = arg_313_1:GetWordFromCfg(114242076)
				local var_316_3 = arg_313_1:FormatText(var_316_2.content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_4 = 30
				local var_316_5 = utf8.len(var_316_3)
				local var_316_6 = var_316_4 <= 0 and var_316_1 or var_316_1 * (var_316_5 / var_316_4)

				if var_316_6 > 0 and var_316_1 < var_316_6 then
					arg_313_1.talkMaxDuration = var_316_6

					if var_316_6 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_6 + var_316_0
					end
				end

				arg_313_1.text_.text = var_316_3
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_7 = math.max(var_316_1, arg_313_1.talkMaxDuration)

			if var_316_0 <= arg_313_1.time_ and arg_313_1.time_ < var_316_0 + var_316_7 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_0) / var_316_7

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_0 + var_316_7 and arg_313_1.time_ < var_316_0 + var_316_7 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play114242077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 114242077
		arg_317_1.duration_ = 1.27

		local var_317_0 = {
			ja = 0.999999999999,
			ko = 1.266,
			zh = 1.1,
			en = 1.066
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play114242078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["10015"].transform
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.var_.moveOldPos10015 = var_320_0.localPosition
				var_320_0.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("10015", 3)

				local var_320_2 = var_320_0.childCount

				for iter_320_0 = 0, var_320_2 - 1 do
					local var_320_3 = var_320_0:GetChild(iter_320_0)

					if var_320_3.name == "split_6" or not string.find(var_320_3.name, "split") then
						var_320_3.gameObject:SetActive(true)
					else
						var_320_3.gameObject:SetActive(false)
					end
				end
			end

			local var_320_4 = 0.001

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_4 then
				local var_320_5 = (arg_317_1.time_ - var_320_1) / var_320_4
				local var_320_6 = Vector3.New(0, -350, -180)

				var_320_0.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos10015, var_320_6, var_320_5)
			end

			if arg_317_1.time_ >= var_320_1 + var_320_4 and arg_317_1.time_ < var_320_1 + var_320_4 + arg_320_0 then
				var_320_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_320_7 = arg_317_1.actors_["10015"]
			local var_320_8 = 0

			if var_320_8 < arg_317_1.time_ and arg_317_1.time_ <= var_320_8 + arg_320_0 and not isNil(var_320_7) and arg_317_1.var_.actorSpriteComps10015 == nil then
				arg_317_1.var_.actorSpriteComps10015 = var_320_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_9 = 0.034

			if var_320_8 <= arg_317_1.time_ and arg_317_1.time_ < var_320_8 + var_320_9 and not isNil(var_320_7) then
				local var_320_10 = (arg_317_1.time_ - var_320_8) / var_320_9

				if arg_317_1.var_.actorSpriteComps10015 then
					for iter_320_1, iter_320_2 in pairs(arg_317_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_320_2 then
							if arg_317_1.isInRecall_ then
								local var_320_11 = Mathf.Lerp(iter_320_2.color.r, arg_317_1.hightColor1.r, var_320_10)
								local var_320_12 = Mathf.Lerp(iter_320_2.color.g, arg_317_1.hightColor1.g, var_320_10)
								local var_320_13 = Mathf.Lerp(iter_320_2.color.b, arg_317_1.hightColor1.b, var_320_10)

								iter_320_2.color = Color.New(var_320_11, var_320_12, var_320_13)
							else
								local var_320_14 = Mathf.Lerp(iter_320_2.color.r, 1, var_320_10)

								iter_320_2.color = Color.New(var_320_14, var_320_14, var_320_14)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= var_320_8 + var_320_9 and arg_317_1.time_ < var_320_8 + var_320_9 + arg_320_0 and not isNil(var_320_7) and arg_317_1.var_.actorSpriteComps10015 then
				for iter_320_3, iter_320_4 in pairs(arg_317_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_320_4 then
						if arg_317_1.isInRecall_ then
							iter_320_4.color = arg_317_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_320_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_317_1.var_.actorSpriteComps10015 = nil
			end

			local var_320_15 = arg_317_1.actors_["10015"]
			local var_320_16 = 0

			if var_320_16 < arg_317_1.time_ and arg_317_1.time_ <= var_320_16 + arg_320_0 then
				local var_320_17 = var_320_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_320_17 then
					arg_317_1.var_.alphaOldValue10015 = var_320_17.alpha
					arg_317_1.var_.characterEffect10015 = var_320_17
				end

				arg_317_1.var_.alphaOldValue10015 = 0
			end

			local var_320_18 = 0.5

			if var_320_16 <= arg_317_1.time_ and arg_317_1.time_ < var_320_16 + var_320_18 then
				local var_320_19 = (arg_317_1.time_ - var_320_16) / var_320_18
				local var_320_20 = Mathf.Lerp(arg_317_1.var_.alphaOldValue10015, 1, var_320_19)

				if arg_317_1.var_.characterEffect10015 then
					arg_317_1.var_.characterEffect10015.alpha = var_320_20
				end
			end

			if arg_317_1.time_ >= var_320_16 + var_320_18 and arg_317_1.time_ < var_320_16 + var_320_18 + arg_320_0 and arg_317_1.var_.characterEffect10015 then
				arg_317_1.var_.characterEffect10015.alpha = 1
			end

			local var_320_21 = 0
			local var_320_22 = 0.05

			if var_320_21 < arg_317_1.time_ and arg_317_1.time_ <= var_320_21 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_23 = arg_317_1:FormatText(StoryNameCfg[208].name)

				arg_317_1.leftNameTxt_.text = var_320_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_24 = arg_317_1:GetWordFromCfg(114242077)
				local var_320_25 = arg_317_1:FormatText(var_320_24.content)

				arg_317_1.text_.text = var_320_25

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_26 = 2
				local var_320_27 = utf8.len(var_320_25)
				local var_320_28 = var_320_26 <= 0 and var_320_22 or var_320_22 * (var_320_27 / var_320_26)

				if var_320_28 > 0 and var_320_22 < var_320_28 then
					arg_317_1.talkMaxDuration = var_320_28

					if var_320_28 + var_320_21 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_28 + var_320_21
					end
				end

				arg_317_1.text_.text = var_320_25
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114242", "114242077", "story_v_out_114242.awb") ~= 0 then
					local var_320_29 = manager.audio:GetVoiceLength("story_v_out_114242", "114242077", "story_v_out_114242.awb") / 1000

					if var_320_29 + var_320_21 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_29 + var_320_21
					end

					if var_320_24.prefab_name ~= "" and arg_317_1.actors_[var_320_24.prefab_name] ~= nil then
						local var_320_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_24.prefab_name].transform, "story_v_out_114242", "114242077", "story_v_out_114242.awb")

						arg_317_1:RecordAudio("114242077", var_320_30)
						arg_317_1:RecordAudio("114242077", var_320_30)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_114242", "114242077", "story_v_out_114242.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_114242", "114242077", "story_v_out_114242.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_31 = math.max(var_320_22, arg_317_1.talkMaxDuration)

			if var_320_21 <= arg_317_1.time_ and arg_317_1.time_ < var_320_21 + var_320_31 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_21) / var_320_31

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_21 + var_320_31 and arg_317_1.time_ < var_320_21 + var_320_31 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play114242078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 114242078
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
			arg_321_1.auto_ = false
		end

		function arg_321_1.playNext_(arg_323_0)
			arg_321_1.onStoryFinished_()
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["10015"]
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.actorSpriteComps10015 == nil then
				arg_321_1.var_.actorSpriteComps10015 = var_324_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_2 = 0.034

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 and not isNil(var_324_0) then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2

				if arg_321_1.var_.actorSpriteComps10015 then
					for iter_324_0, iter_324_1 in pairs(arg_321_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_324_1 then
							if arg_321_1.isInRecall_ then
								local var_324_4 = Mathf.Lerp(iter_324_1.color.r, arg_321_1.hightColor2.r, var_324_3)
								local var_324_5 = Mathf.Lerp(iter_324_1.color.g, arg_321_1.hightColor2.g, var_324_3)
								local var_324_6 = Mathf.Lerp(iter_324_1.color.b, arg_321_1.hightColor2.b, var_324_3)

								iter_324_1.color = Color.New(var_324_4, var_324_5, var_324_6)
							else
								local var_324_7 = Mathf.Lerp(iter_324_1.color.r, 0.5, var_324_3)

								iter_324_1.color = Color.New(var_324_7, var_324_7, var_324_7)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.actorSpriteComps10015 then
				for iter_324_2, iter_324_3 in pairs(arg_321_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_324_3 then
						if arg_321_1.isInRecall_ then
							iter_324_3.color = arg_321_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_324_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_321_1.var_.actorSpriteComps10015 = nil
			end

			local var_324_8 = 0
			local var_324_9 = 0.675

			if var_324_8 < arg_321_1.time_ and arg_321_1.time_ <= var_324_8 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_10 = arg_321_1:GetWordFromCfg(114242078)
				local var_324_11 = arg_321_1:FormatText(var_324_10.content)

				arg_321_1.text_.text = var_324_11

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_12 = 27
				local var_324_13 = utf8.len(var_324_11)
				local var_324_14 = var_324_12 <= 0 and var_324_9 or var_324_9 * (var_324_13 / var_324_12)

				if var_324_14 > 0 and var_324_9 < var_324_14 then
					arg_321_1.talkMaxDuration = var_324_14

					if var_324_14 + var_324_8 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_14 + var_324_8
					end
				end

				arg_321_1.text_.text = var_324_11
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_15 = math.max(var_324_9, arg_321_1.talkMaxDuration)

			if var_324_8 <= arg_321_1.time_ and arg_321_1.time_ < var_324_8 + var_324_15 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_8) / var_324_15

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_8 + var_324_15 and arg_321_1.time_ < var_324_8 + var_324_15 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST25",
		"TextureConfig/Background/F01a"
	},
	voices = {
		"story_v_out_114242.awb"
	}
}
