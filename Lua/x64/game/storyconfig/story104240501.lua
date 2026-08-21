return {
	Play424051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 424051001
		arg_1_1.duration_ = 12.9

		local var_1_0 = {
			zh = 6.666,
			ja = 12.9
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
				arg_1_0:Play424051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST0115"

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
				local var_4_5 = arg_1_1.bgs_.ST0115

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
					if iter_4_0 ~= "ST0115" then
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

			local var_4_24 = "10155"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10155")

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

			local var_4_28 = arg_1_1.actors_["10155"]
			local var_4_29 = 1.8

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps10155 == nil then
				arg_1_1.var_.actorSpriteComps10155 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps10155 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								local var_4_32 = Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, var_4_31)
								local var_4_33 = Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, var_4_31)
								local var_4_34 = Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, var_4_31)

								iter_4_5.color = Color.New(var_4_32, var_4_33, var_4_34)
							else
								local var_4_35 = Mathf.Lerp(iter_4_5.color.r, 1, var_4_31)

								iter_4_5.color = Color.New(var_4_35, var_4_35, var_4_35)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps10155 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10155 = nil
			end

			local var_4_36 = arg_1_1.actors_["10155"].transform
			local var_4_37 = 1.8

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos10155 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10155", 3)

				local var_4_38 = var_4_36.childCount

				for iter_4_8 = 0, var_4_38 - 1 do
					local var_4_39 = var_4_36:GetChild(iter_4_8)

					if var_4_39.name == "split_3" or not string.find(var_4_39.name, "split") then
						var_4_39.gameObject:SetActive(true)
					else
						var_4_39.gameObject:SetActive(false)
					end
				end
			end

			local var_4_40 = 0.001

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_37) / var_4_40
				local var_4_42 = Vector3.New(-40, -390, -250)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10155, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(-40, -390, -250)
			end

			local var_4_43 = 0
			local var_4_44 = 0.3

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				local var_4_45 = "play"
				local var_4_46 = "music"

				arg_1_1:AudioAction(var_4_45, var_4_46, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_47 = ""
				local var_4_48 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_49 = 0.5
			local var_4_50 = 1

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "music"

				arg_1_1:AudioAction(var_4_51, var_4_52, "bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily.awb")

				local var_4_53 = ""
				local var_4_54 = manager.audio:GetAudioName("bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily")

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

			local var_4_55 = 0.2
			local var_4_56 = 1

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				local var_4_57 = "play"
				local var_4_58 = "effect"

				arg_1_1:AudioAction(var_4_57, var_4_58, "se_story_140", "se_story_140_amb_room01", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_59 = 2
			local var_4_60 = 0.5

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

				local var_4_62 = arg_1_1:FormatText(StoryNameCfg[1391].name)

				arg_1_1.leftNameTxt_.text = var_4_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_63 = arg_1_1:GetWordFromCfg(424051001)
				local var_4_64 = arg_1_1:FormatText(var_4_63.content)

				arg_1_1.text_.text = var_4_64

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_65 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051001", "story_v_out_424051.awb") ~= 0 then
					local var_4_68 = manager.audio:GetVoiceLength("story_v_out_424051", "424051001", "story_v_out_424051.awb") / 1000

					if var_4_68 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_68 + var_4_59
					end

					if var_4_63.prefab_name ~= "" and arg_1_1.actors_[var_4_63.prefab_name] ~= nil then
						local var_4_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_63.prefab_name].transform, "story_v_out_424051", "424051001", "story_v_out_424051.awb")

						arg_1_1:RecordAudio("424051001", var_4_69)
						arg_1_1:RecordAudio("424051001", var_4_69)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_424051", "424051001", "story_v_out_424051.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_424051", "424051001", "story_v_out_424051.awb")
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
				actorName = "10155",
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
	Play424051002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 424051002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play424051003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["10155"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps10155 == nil then
				arg_9_1.var_.actorSpriteComps10155 = var_12_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_2 = 0.2

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.actorSpriteComps10155 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_12_1 then
							if arg_9_1.isInRecall_ then
								local var_12_4 = Mathf.Lerp(iter_12_1.color.r, arg_9_1.hightColor2.r, var_12_3)
								local var_12_5 = Mathf.Lerp(iter_12_1.color.g, arg_9_1.hightColor2.g, var_12_3)
								local var_12_6 = Mathf.Lerp(iter_12_1.color.b, arg_9_1.hightColor2.b, var_12_3)

								iter_12_1.color = Color.New(var_12_4, var_12_5, var_12_6)
							else
								local var_12_7 = Mathf.Lerp(iter_12_1.color.r, 0.5, var_12_3)

								iter_12_1.color = Color.New(var_12_7, var_12_7, var_12_7)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps10155 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_12_3 then
						if arg_9_1.isInRecall_ then
							iter_12_3.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10155 = nil
			end

			local var_12_8 = arg_9_1.actors_["10155"].transform
			local var_12_9 = 0

			if var_12_9 < arg_9_1.time_ and arg_9_1.time_ <= var_12_9 + arg_12_0 then
				arg_9_1.var_.moveOldPos10155 = var_12_8.localPosition
				var_12_8.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10155", 7)

				local var_12_10 = var_12_8.childCount

				for iter_12_4 = 0, var_12_10 - 1 do
					local var_12_11 = var_12_8:GetChild(iter_12_4)

					if var_12_11.name == "" or not string.find(var_12_11.name, "split") then
						var_12_11.gameObject:SetActive(true)
					else
						var_12_11.gameObject:SetActive(false)
					end
				end
			end

			local var_12_12 = 0.001

			if var_12_9 <= arg_9_1.time_ and arg_9_1.time_ < var_12_9 + var_12_12 then
				local var_12_13 = (arg_9_1.time_ - var_12_9) / var_12_12
				local var_12_14 = Vector3.New(0, -2000, 0)

				var_12_8.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10155, var_12_14, var_12_13)
			end

			if arg_9_1.time_ >= var_12_9 + var_12_12 and arg_9_1.time_ < var_12_9 + var_12_12 + arg_12_0 then
				var_12_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_12_15 = 0
			local var_12_16 = 1.325

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

				local var_12_17 = arg_9_1:GetWordFromCfg(424051002)
				local var_12_18 = arg_9_1:FormatText(var_12_17.content)

				arg_9_1.text_.text = var_12_18

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_19 = 53
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
	Play424051003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 424051003
		arg_13_1.duration_ = 2.93

		local var_13_0 = {
			zh = 2.366,
			ja = 2.933
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
				arg_13_0:Play424051004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1094"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1094")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(var_16_1, arg_13_1.canvasGo_.transform)

					var_16_2.transform:SetSiblingIndex(1)

					var_16_2.name = var_16_0
					var_16_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_[var_16_0] = var_16_2

					local var_16_3 = var_16_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_13_1.isInRecall_ then
						for iter_16_0, iter_16_1 in ipairs(var_16_3) do
							iter_16_1.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_4 = arg_13_1.actors_["1094"]
			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.actorSpriteComps1094 == nil then
				arg_13_1.var_.actorSpriteComps1094 = var_16_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_6 = 0.2

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_6 and not isNil(var_16_4) then
				local var_16_7 = (arg_13_1.time_ - var_16_5) / var_16_6

				if arg_13_1.var_.actorSpriteComps1094 then
					for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_16_3 then
							if arg_13_1.isInRecall_ then
								local var_16_8 = Mathf.Lerp(iter_16_3.color.r, arg_13_1.hightColor1.r, var_16_7)
								local var_16_9 = Mathf.Lerp(iter_16_3.color.g, arg_13_1.hightColor1.g, var_16_7)
								local var_16_10 = Mathf.Lerp(iter_16_3.color.b, arg_13_1.hightColor1.b, var_16_7)

								iter_16_3.color = Color.New(var_16_8, var_16_9, var_16_10)
							else
								local var_16_11 = Mathf.Lerp(iter_16_3.color.r, 1, var_16_7)

								iter_16_3.color = Color.New(var_16_11, var_16_11, var_16_11)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_5 + var_16_6 and arg_13_1.time_ < var_16_5 + var_16_6 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.actorSpriteComps1094 then
				for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_16_5 then
						if arg_13_1.isInRecall_ then
							iter_16_5.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1094 = nil
			end

			local var_16_12 = arg_13_1.actors_["1094"].transform
			local var_16_13 = 0

			if var_16_13 < arg_13_1.time_ and arg_13_1.time_ <= var_16_13 + arg_16_0 then
				arg_13_1.var_.moveOldPos1094 = var_16_12.localPosition
				var_16_12.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1094", 2)

				local var_16_14 = var_16_12.childCount

				for iter_16_6 = 0, var_16_14 - 1 do
					local var_16_15 = var_16_12:GetChild(iter_16_6)

					if var_16_15.name == "" or not string.find(var_16_15.name, "split") then
						var_16_15.gameObject:SetActive(true)
					else
						var_16_15.gameObject:SetActive(false)
					end
				end
			end

			local var_16_16 = 0.001

			if var_16_13 <= arg_13_1.time_ and arg_13_1.time_ < var_16_13 + var_16_16 then
				local var_16_17 = (arg_13_1.time_ - var_16_13) / var_16_16
				local var_16_18 = Vector3.New(-380, -335, -230)

				var_16_12.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1094, var_16_18, var_16_17)
			end

			if arg_13_1.time_ >= var_16_13 + var_16_16 and arg_13_1.time_ < var_16_13 + var_16_16 + arg_16_0 then
				var_16_12.localPosition = Vector3.New(-380, -335, -230)
			end

			local var_16_19 = arg_13_1.actors_["1094"]
			local var_16_20 = 0

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				local var_16_21 = var_16_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_16_21 then
					arg_13_1.var_.alphaOldValue1094 = var_16_21.alpha
					arg_13_1.var_.characterEffect1094 = var_16_21
				end

				arg_13_1.var_.alphaOldValue1094 = 0
			end

			local var_16_22 = 0.5

			if var_16_20 <= arg_13_1.time_ and arg_13_1.time_ < var_16_20 + var_16_22 then
				local var_16_23 = (arg_13_1.time_ - var_16_20) / var_16_22
				local var_16_24 = Mathf.Lerp(arg_13_1.var_.alphaOldValue1094, 1, var_16_23)

				if arg_13_1.var_.characterEffect1094 then
					arg_13_1.var_.characterEffect1094.alpha = var_16_24
				end
			end

			if arg_13_1.time_ >= var_16_20 + var_16_22 and arg_13_1.time_ < var_16_20 + var_16_22 + arg_16_0 and arg_13_1.var_.characterEffect1094 then
				arg_13_1.var_.characterEffect1094.alpha = 1
			end

			local var_16_25 = 0
			local var_16_26 = 0.2

			if var_16_25 < arg_13_1.time_ and arg_13_1.time_ <= var_16_25 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_27 = arg_13_1:FormatText(StoryNameCfg[181].name)

				arg_13_1.leftNameTxt_.text = var_16_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_28 = arg_13_1:GetWordFromCfg(424051003)
				local var_16_29 = arg_13_1:FormatText(var_16_28.content)

				arg_13_1.text_.text = var_16_29

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_30 = 8
				local var_16_31 = utf8.len(var_16_29)
				local var_16_32 = var_16_30 <= 0 and var_16_26 or var_16_26 * (var_16_31 / var_16_30)

				if var_16_32 > 0 and var_16_26 < var_16_32 then
					arg_13_1.talkMaxDuration = var_16_32

					if var_16_32 + var_16_25 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_32 + var_16_25
					end
				end

				arg_13_1.text_.text = var_16_29
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051003", "story_v_out_424051.awb") ~= 0 then
					local var_16_33 = manager.audio:GetVoiceLength("story_v_out_424051", "424051003", "story_v_out_424051.awb") / 1000

					if var_16_33 + var_16_25 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_33 + var_16_25
					end

					if var_16_28.prefab_name ~= "" and arg_13_1.actors_[var_16_28.prefab_name] ~= nil then
						local var_16_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_28.prefab_name].transform, "story_v_out_424051", "424051003", "story_v_out_424051.awb")

						arg_13_1:RecordAudio("424051003", var_16_34)
						arg_13_1:RecordAudio("424051003", var_16_34)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_424051", "424051003", "story_v_out_424051.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_424051", "424051003", "story_v_out_424051.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_35 = math.max(var_16_26, arg_13_1.talkMaxDuration)

			if var_16_25 <= arg_13_1.time_ and arg_13_1.time_ < var_16_25 + var_16_35 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_25) / var_16_35

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_25 + var_16_35 and arg_13_1.time_ < var_16_25 + var_16_35 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play424051004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 424051004
		arg_17_1.duration_ = 3.6

		local var_17_0 = {
			zh = 3.266,
			ja = 3.6
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
				arg_17_0:Play424051005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10155"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10155 == nil then
				arg_17_1.var_.actorSpriteComps10155 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps10155 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10155 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10155 = nil
			end

			local var_20_8 = arg_17_1.actors_["1094"]
			local var_20_9 = 0

			if var_20_9 < arg_17_1.time_ and arg_17_1.time_ <= var_20_9 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps1094 == nil then
				arg_17_1.var_.actorSpriteComps1094 = var_20_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_10 = 0.2

			if var_20_9 <= arg_17_1.time_ and arg_17_1.time_ < var_20_9 + var_20_10 and not isNil(var_20_8) then
				local var_20_11 = (arg_17_1.time_ - var_20_9) / var_20_10

				if arg_17_1.var_.actorSpriteComps1094 then
					for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_20_5 then
							if arg_17_1.isInRecall_ then
								local var_20_12 = Mathf.Lerp(iter_20_5.color.r, arg_17_1.hightColor2.r, var_20_11)
								local var_20_13 = Mathf.Lerp(iter_20_5.color.g, arg_17_1.hightColor2.g, var_20_11)
								local var_20_14 = Mathf.Lerp(iter_20_5.color.b, arg_17_1.hightColor2.b, var_20_11)

								iter_20_5.color = Color.New(var_20_12, var_20_13, var_20_14)
							else
								local var_20_15 = Mathf.Lerp(iter_20_5.color.r, 0.5, var_20_11)

								iter_20_5.color = Color.New(var_20_15, var_20_15, var_20_15)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_9 + var_20_10 and arg_17_1.time_ < var_20_9 + var_20_10 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps1094 then
				for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_20_7 then
						if arg_17_1.isInRecall_ then
							iter_20_7.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1094 = nil
			end

			local var_20_16 = arg_17_1.actors_["10155"].transform
			local var_20_17 = 0

			if var_20_17 < arg_17_1.time_ and arg_17_1.time_ <= var_20_17 + arg_20_0 then
				arg_17_1.var_.moveOldPos10155 = var_20_16.localPosition
				var_20_16.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10155", 4)

				local var_20_18 = var_20_16.childCount

				for iter_20_8 = 0, var_20_18 - 1 do
					local var_20_19 = var_20_16:GetChild(iter_20_8)

					if var_20_19.name == "split_2" or not string.find(var_20_19.name, "split") then
						var_20_19.gameObject:SetActive(true)
					else
						var_20_19.gameObject:SetActive(false)
					end
				end
			end

			local var_20_20 = 0.001

			if var_20_17 <= arg_17_1.time_ and arg_17_1.time_ < var_20_17 + var_20_20 then
				local var_20_21 = (arg_17_1.time_ - var_20_17) / var_20_20
				local var_20_22 = Vector3.New(440, -390, -250)

				var_20_16.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10155, var_20_22, var_20_21)
			end

			if arg_17_1.time_ >= var_20_17 + var_20_20 and arg_17_1.time_ < var_20_17 + var_20_20 + arg_20_0 then
				var_20_16.localPosition = Vector3.New(440, -390, -250)
			end

			local var_20_23 = 0
			local var_20_24 = 0.2

			if var_20_23 < arg_17_1.time_ and arg_17_1.time_ <= var_20_23 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_25 = arg_17_1:FormatText(StoryNameCfg[1391].name)

				arg_17_1.leftNameTxt_.text = var_20_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_26 = arg_17_1:GetWordFromCfg(424051004)
				local var_20_27 = arg_17_1:FormatText(var_20_26.content)

				arg_17_1.text_.text = var_20_27

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_28 = 9
				local var_20_29 = utf8.len(var_20_27)
				local var_20_30 = var_20_28 <= 0 and var_20_24 or var_20_24 * (var_20_29 / var_20_28)

				if var_20_30 > 0 and var_20_24 < var_20_30 then
					arg_17_1.talkMaxDuration = var_20_30

					if var_20_30 + var_20_23 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_30 + var_20_23
					end
				end

				arg_17_1.text_.text = var_20_27
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051004", "story_v_out_424051.awb") ~= 0 then
					local var_20_31 = manager.audio:GetVoiceLength("story_v_out_424051", "424051004", "story_v_out_424051.awb") / 1000

					if var_20_31 + var_20_23 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_31 + var_20_23
					end

					if var_20_26.prefab_name ~= "" and arg_17_1.actors_[var_20_26.prefab_name] ~= nil then
						local var_20_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_26.prefab_name].transform, "story_v_out_424051", "424051004", "story_v_out_424051.awb")

						arg_17_1:RecordAudio("424051004", var_20_32)
						arg_17_1:RecordAudio("424051004", var_20_32)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_424051", "424051004", "story_v_out_424051.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_424051", "424051004", "story_v_out_424051.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_33 = math.max(var_20_24, arg_17_1.talkMaxDuration)

			if var_20_23 <= arg_17_1.time_ and arg_17_1.time_ < var_20_23 + var_20_33 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_23) / var_20_33

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_23 + var_20_33 and arg_17_1.time_ < var_20_23 + var_20_33 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0329999998211861,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play424051005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 424051005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play424051006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10155"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10155 == nil then
				arg_21_1.var_.actorSpriteComps10155 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps10155 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10155 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10155 = nil
			end

			local var_24_8 = arg_21_1.actors_["10155"].transform
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				arg_21_1.var_.moveOldPos10155 = var_24_8.localPosition
				var_24_8.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10155", 7)

				local var_24_10 = var_24_8.childCount

				for iter_24_4 = 0, var_24_10 - 1 do
					local var_24_11 = var_24_8:GetChild(iter_24_4)

					if var_24_11.name == "" or not string.find(var_24_11.name, "split") then
						var_24_11.gameObject:SetActive(true)
					else
						var_24_11.gameObject:SetActive(false)
					end
				end
			end

			local var_24_12 = 0.001

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_12 then
				local var_24_13 = (arg_21_1.time_ - var_24_9) / var_24_12
				local var_24_14 = Vector3.New(0, -2000, 0)

				var_24_8.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10155, var_24_14, var_24_13)
			end

			if arg_21_1.time_ >= var_24_9 + var_24_12 and arg_21_1.time_ < var_24_9 + var_24_12 + arg_24_0 then
				var_24_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_24_15 = arg_21_1.actors_["1094"].transform
			local var_24_16 = 0

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.var_.moveOldPos1094 = var_24_15.localPosition
				var_24_15.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1094", 7)

				local var_24_17 = var_24_15.childCount

				for iter_24_5 = 0, var_24_17 - 1 do
					local var_24_18 = var_24_15:GetChild(iter_24_5)

					if var_24_18.name == "" or not string.find(var_24_18.name, "split") then
						var_24_18.gameObject:SetActive(true)
					else
						var_24_18.gameObject:SetActive(false)
					end
				end
			end

			local var_24_19 = 0.001

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_19 then
				local var_24_20 = (arg_21_1.time_ - var_24_16) / var_24_19
				local var_24_21 = Vector3.New(0, -2000, 0)

				var_24_15.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1094, var_24_21, var_24_20)
			end

			if arg_21_1.time_ >= var_24_16 + var_24_19 and arg_21_1.time_ < var_24_16 + var_24_19 + arg_24_0 then
				var_24_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_24_22 = 0
			local var_24_23 = 0.9

			if var_24_22 < arg_21_1.time_ and arg_21_1.time_ <= var_24_22 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_24 = arg_21_1:GetWordFromCfg(424051005)
				local var_24_25 = arg_21_1:FormatText(var_24_24.content)

				arg_21_1.text_.text = var_24_25

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_26 = 36
				local var_24_27 = utf8.len(var_24_25)
				local var_24_28 = var_24_26 <= 0 and var_24_23 or var_24_23 * (var_24_27 / var_24_26)

				if var_24_28 > 0 and var_24_23 < var_24_28 then
					arg_21_1.talkMaxDuration = var_24_28

					if var_24_28 + var_24_22 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_28 + var_24_22
					end
				end

				arg_21_1.text_.text = var_24_25
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_29 = math.max(var_24_23, arg_21_1.talkMaxDuration)

			if var_24_22 <= arg_21_1.time_ and arg_21_1.time_ < var_24_22 + var_24_29 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_22) / var_24_29

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_22 + var_24_29 and arg_21_1.time_ < var_24_22 + var_24_29 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
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

		arg_21_1:InitPlayNodeList()
	end,
	Play424051006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 424051006
		arg_25_1.duration_ = 8.13

		local var_25_0 = {
			zh = 7.033,
			ja = 8.133
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
				arg_25_0:Play424051007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "10153"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10153")

				if not isNil(var_28_1) then
					local var_28_2 = Object.Instantiate(var_28_1, arg_25_1.canvasGo_.transform)

					var_28_2.transform:SetSiblingIndex(1)

					var_28_2.name = var_28_0
					var_28_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_25_1.actors_[var_28_0] = var_28_2

					local var_28_3 = var_28_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_25_1.isInRecall_ then
						for iter_28_0, iter_28_1 in ipairs(var_28_3) do
							iter_28_1.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_28_4 = arg_25_1.actors_["10153"]
			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.actorSpriteComps10153 == nil then
				arg_25_1.var_.actorSpriteComps10153 = var_28_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_6 = 0.2

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_6 and not isNil(var_28_4) then
				local var_28_7 = (arg_25_1.time_ - var_28_5) / var_28_6

				if arg_25_1.var_.actorSpriteComps10153 then
					for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_28_3 then
							if arg_25_1.isInRecall_ then
								local var_28_8 = Mathf.Lerp(iter_28_3.color.r, arg_25_1.hightColor1.r, var_28_7)
								local var_28_9 = Mathf.Lerp(iter_28_3.color.g, arg_25_1.hightColor1.g, var_28_7)
								local var_28_10 = Mathf.Lerp(iter_28_3.color.b, arg_25_1.hightColor1.b, var_28_7)

								iter_28_3.color = Color.New(var_28_8, var_28_9, var_28_10)
							else
								local var_28_11 = Mathf.Lerp(iter_28_3.color.r, 1, var_28_7)

								iter_28_3.color = Color.New(var_28_11, var_28_11, var_28_11)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_5 + var_28_6 and arg_25_1.time_ < var_28_5 + var_28_6 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.actorSpriteComps10153 then
				for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_28_5 then
						if arg_25_1.isInRecall_ then
							iter_28_5.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10153 = nil
			end

			local var_28_12 = arg_25_1.actors_["10153"].transform
			local var_28_13 = 0

			if var_28_13 < arg_25_1.time_ and arg_25_1.time_ <= var_28_13 + arg_28_0 then
				arg_25_1.var_.moveOldPos10153 = var_28_12.localPosition
				var_28_12.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10153", 2)

				local var_28_14 = var_28_12.childCount

				for iter_28_6 = 0, var_28_14 - 1 do
					local var_28_15 = var_28_12:GetChild(iter_28_6)

					if var_28_15.name == "split_1" or not string.find(var_28_15.name, "split") then
						var_28_15.gameObject:SetActive(true)
					else
						var_28_15.gameObject:SetActive(false)
					end
				end
			end

			local var_28_16 = 0.001

			if var_28_13 <= arg_25_1.time_ and arg_25_1.time_ < var_28_13 + var_28_16 then
				local var_28_17 = (arg_25_1.time_ - var_28_13) / var_28_16
				local var_28_18 = Vector3.New(-400, -395, -330)

				var_28_12.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10153, var_28_18, var_28_17)
			end

			if arg_25_1.time_ >= var_28_13 + var_28_16 and arg_25_1.time_ < var_28_13 + var_28_16 + arg_28_0 then
				var_28_12.localPosition = Vector3.New(-400, -395, -330)
			end

			local var_28_19 = arg_25_1.actors_["10153"]
			local var_28_20 = 0

			if var_28_20 < arg_25_1.time_ and arg_25_1.time_ <= var_28_20 + arg_28_0 then
				local var_28_21 = var_28_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_28_21 then
					arg_25_1.var_.alphaOldValue10153 = var_28_21.alpha
					arg_25_1.var_.characterEffect10153 = var_28_21
				end

				arg_25_1.var_.alphaOldValue10153 = 0
			end

			local var_28_22 = 0.5

			if var_28_20 <= arg_25_1.time_ and arg_25_1.time_ < var_28_20 + var_28_22 then
				local var_28_23 = (arg_25_1.time_ - var_28_20) / var_28_22
				local var_28_24 = Mathf.Lerp(arg_25_1.var_.alphaOldValue10153, 1, var_28_23)

				if arg_25_1.var_.characterEffect10153 then
					arg_25_1.var_.characterEffect10153.alpha = var_28_24
				end
			end

			if arg_25_1.time_ >= var_28_20 + var_28_22 and arg_25_1.time_ < var_28_20 + var_28_22 + arg_28_0 and arg_25_1.var_.characterEffect10153 then
				arg_25_1.var_.characterEffect10153.alpha = 1
			end

			local var_28_25 = 0
			local var_28_26 = 0.775

			if var_28_25 < arg_25_1.time_ and arg_25_1.time_ <= var_28_25 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_27 = arg_25_1:FormatText(StoryNameCfg[1387].name)

				arg_25_1.leftNameTxt_.text = var_28_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_28 = arg_25_1:GetWordFromCfg(424051006)
				local var_28_29 = arg_25_1:FormatText(var_28_28.content)

				arg_25_1.text_.text = var_28_29

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_30 = 31
				local var_28_31 = utf8.len(var_28_29)
				local var_28_32 = var_28_30 <= 0 and var_28_26 or var_28_26 * (var_28_31 / var_28_30)

				if var_28_32 > 0 and var_28_26 < var_28_32 then
					arg_25_1.talkMaxDuration = var_28_32

					if var_28_32 + var_28_25 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_32 + var_28_25
					end
				end

				arg_25_1.text_.text = var_28_29
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051006", "story_v_out_424051.awb") ~= 0 then
					local var_28_33 = manager.audio:GetVoiceLength("story_v_out_424051", "424051006", "story_v_out_424051.awb") / 1000

					if var_28_33 + var_28_25 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_33 + var_28_25
					end

					if var_28_28.prefab_name ~= "" and arg_25_1.actors_[var_28_28.prefab_name] ~= nil then
						local var_28_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_28.prefab_name].transform, "story_v_out_424051", "424051006", "story_v_out_424051.awb")

						arg_25_1:RecordAudio("424051006", var_28_34)
						arg_25_1:RecordAudio("424051006", var_28_34)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_424051", "424051006", "story_v_out_424051.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_424051", "424051006", "story_v_out_424051.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_35 = math.max(var_28_26, arg_25_1.talkMaxDuration)

			if var_28_25 <= arg_25_1.time_ and arg_25_1.time_ < var_28_25 + var_28_35 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_25) / var_28_35

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_25 + var_28_35 and arg_25_1.time_ < var_28_25 + var_28_35 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play424051007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 424051007
		arg_29_1.duration_ = 9.73

		local var_29_0 = {
			zh = 6.7,
			ja = 9.733
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
				arg_29_0:Play424051008(arg_29_1)
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

			local var_32_8 = arg_29_1.actors_["10153"]
			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10153 == nil then
				arg_29_1.var_.actorSpriteComps10153 = var_32_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_10 = 0.2

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_10 and not isNil(var_32_8) then
				local var_32_11 = (arg_29_1.time_ - var_32_9) / var_32_10

				if arg_29_1.var_.actorSpriteComps10153 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_32_5 then
							if arg_29_1.isInRecall_ then
								local var_32_12 = Mathf.Lerp(iter_32_5.color.r, arg_29_1.hightColor2.r, var_32_11)
								local var_32_13 = Mathf.Lerp(iter_32_5.color.g, arg_29_1.hightColor2.g, var_32_11)
								local var_32_14 = Mathf.Lerp(iter_32_5.color.b, arg_29_1.hightColor2.b, var_32_11)

								iter_32_5.color = Color.New(var_32_12, var_32_13, var_32_14)
							else
								local var_32_15 = Mathf.Lerp(iter_32_5.color.r, 0.5, var_32_11)

								iter_32_5.color = Color.New(var_32_15, var_32_15, var_32_15)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_9 + var_32_10 and arg_29_1.time_ < var_32_9 + var_32_10 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10153 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_32_7 then
						if arg_29_1.isInRecall_ then
							iter_32_7.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10153 = nil
			end

			local var_32_16 = arg_29_1.actors_["10155"].transform
			local var_32_17 = 0

			if var_32_17 < arg_29_1.time_ and arg_29_1.time_ <= var_32_17 + arg_32_0 then
				arg_29_1.var_.moveOldPos10155 = var_32_16.localPosition
				var_32_16.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10155", 4)

				local var_32_18 = var_32_16.childCount

				for iter_32_8 = 0, var_32_18 - 1 do
					local var_32_19 = var_32_16:GetChild(iter_32_8)

					if var_32_19.name == "" or not string.find(var_32_19.name, "split") then
						var_32_19.gameObject:SetActive(true)
					else
						var_32_19.gameObject:SetActive(false)
					end
				end
			end

			local var_32_20 = 0.001

			if var_32_17 <= arg_29_1.time_ and arg_29_1.time_ < var_32_17 + var_32_20 then
				local var_32_21 = (arg_29_1.time_ - var_32_17) / var_32_20
				local var_32_22 = Vector3.New(440, -390, -250)

				var_32_16.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10155, var_32_22, var_32_21)
			end

			if arg_29_1.time_ >= var_32_17 + var_32_20 and arg_29_1.time_ < var_32_17 + var_32_20 + arg_32_0 then
				var_32_16.localPosition = Vector3.New(440, -390, -250)
			end

			local var_32_23 = 0
			local var_32_24 = 0.85

			if var_32_23 < arg_29_1.time_ and arg_29_1.time_ <= var_32_23 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_25 = arg_29_1:FormatText(StoryNameCfg[1391].name)

				arg_29_1.leftNameTxt_.text = var_32_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_26 = arg_29_1:GetWordFromCfg(424051007)
				local var_32_27 = arg_29_1:FormatText(var_32_26.content)

				arg_29_1.text_.text = var_32_27

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_28 = 34
				local var_32_29 = utf8.len(var_32_27)
				local var_32_30 = var_32_28 <= 0 and var_32_24 or var_32_24 * (var_32_29 / var_32_28)

				if var_32_30 > 0 and var_32_24 < var_32_30 then
					arg_29_1.talkMaxDuration = var_32_30

					if var_32_30 + var_32_23 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_30 + var_32_23
					end
				end

				arg_29_1.text_.text = var_32_27
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051007", "story_v_out_424051.awb") ~= 0 then
					local var_32_31 = manager.audio:GetVoiceLength("story_v_out_424051", "424051007", "story_v_out_424051.awb") / 1000

					if var_32_31 + var_32_23 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_31 + var_32_23
					end

					if var_32_26.prefab_name ~= "" and arg_29_1.actors_[var_32_26.prefab_name] ~= nil then
						local var_32_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_26.prefab_name].transform, "story_v_out_424051", "424051007", "story_v_out_424051.awb")

						arg_29_1:RecordAudio("424051007", var_32_32)
						arg_29_1:RecordAudio("424051007", var_32_32)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_424051", "424051007", "story_v_out_424051.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_424051", "424051007", "story_v_out_424051.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_33 = math.max(var_32_24, arg_29_1.talkMaxDuration)

			if var_32_23 <= arg_29_1.time_ and arg_29_1.time_ < var_32_23 + var_32_33 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_23) / var_32_33

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_23 + var_32_33 and arg_29_1.time_ < var_32_23 + var_32_33 + arg_32_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play424051008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 424051008
		arg_33_1.duration_ = 5.4

		local var_33_0 = {
			zh = 2.8,
			ja = 5.4
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
				arg_33_0:Play424051009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10155"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos10155 = var_36_0.localPosition
				var_36_0.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10155", 4)

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
				local var_36_6 = Vector3.New(440, -390, -250)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10155, var_36_6, var_36_5)
			end

			if arg_33_1.time_ >= var_36_1 + var_36_4 and arg_33_1.time_ < var_36_1 + var_36_4 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(440, -390, -250)
			end

			local var_36_7 = 0
			local var_36_8 = 0.35

			if var_36_7 < arg_33_1.time_ and arg_33_1.time_ <= var_36_7 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_9 = arg_33_1:FormatText(StoryNameCfg[1391].name)

				arg_33_1.leftNameTxt_.text = var_36_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_10 = arg_33_1:GetWordFromCfg(424051008)
				local var_36_11 = arg_33_1:FormatText(var_36_10.content)

				arg_33_1.text_.text = var_36_11

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_12 = 14
				local var_36_13 = utf8.len(var_36_11)
				local var_36_14 = var_36_12 <= 0 and var_36_8 or var_36_8 * (var_36_13 / var_36_12)

				if var_36_14 > 0 and var_36_8 < var_36_14 then
					arg_33_1.talkMaxDuration = var_36_14

					if var_36_14 + var_36_7 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_7
					end
				end

				arg_33_1.text_.text = var_36_11
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051008", "story_v_out_424051.awb") ~= 0 then
					local var_36_15 = manager.audio:GetVoiceLength("story_v_out_424051", "424051008", "story_v_out_424051.awb") / 1000

					if var_36_15 + var_36_7 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_15 + var_36_7
					end

					if var_36_10.prefab_name ~= "" and arg_33_1.actors_[var_36_10.prefab_name] ~= nil then
						local var_36_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_10.prefab_name].transform, "story_v_out_424051", "424051008", "story_v_out_424051.awb")

						arg_33_1:RecordAudio("424051008", var_36_16)
						arg_33_1:RecordAudio("424051008", var_36_16)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_424051", "424051008", "story_v_out_424051.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_424051", "424051008", "story_v_out_424051.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_17 = math.max(var_36_8, arg_33_1.talkMaxDuration)

			if var_36_7 <= arg_33_1.time_ and arg_33_1.time_ < var_36_7 + var_36_17 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_7) / var_36_17

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_7 + var_36_17 and arg_33_1.time_ < var_36_7 + var_36_17 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play424051009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 424051009
		arg_37_1.duration_ = 5.37

		local var_37_0 = {
			zh = 3.666,
			ja = 5.366
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
				arg_37_0:Play424051010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10153"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps10153 == nil then
				arg_37_1.var_.actorSpriteComps10153 = var_40_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_2 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.actorSpriteComps10153 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps10153:ToTable()) do
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

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps10153 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_40_3 then
						if arg_37_1.isInRecall_ then
							iter_40_3.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10153 = nil
			end

			local var_40_8 = arg_37_1.actors_["10155"]
			local var_40_9 = 0

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps10155 == nil then
				arg_37_1.var_.actorSpriteComps10155 = var_40_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_10 = 0.2

			if var_40_9 <= arg_37_1.time_ and arg_37_1.time_ < var_40_9 + var_40_10 and not isNil(var_40_8) then
				local var_40_11 = (arg_37_1.time_ - var_40_9) / var_40_10

				if arg_37_1.var_.actorSpriteComps10155 then
					for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_40_5 then
							if arg_37_1.isInRecall_ then
								local var_40_12 = Mathf.Lerp(iter_40_5.color.r, arg_37_1.hightColor2.r, var_40_11)
								local var_40_13 = Mathf.Lerp(iter_40_5.color.g, arg_37_1.hightColor2.g, var_40_11)
								local var_40_14 = Mathf.Lerp(iter_40_5.color.b, arg_37_1.hightColor2.b, var_40_11)

								iter_40_5.color = Color.New(var_40_12, var_40_13, var_40_14)
							else
								local var_40_15 = Mathf.Lerp(iter_40_5.color.r, 0.5, var_40_11)

								iter_40_5.color = Color.New(var_40_15, var_40_15, var_40_15)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_9 + var_40_10 and arg_37_1.time_ < var_40_9 + var_40_10 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps10155 then
				for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_40_7 then
						if arg_37_1.isInRecall_ then
							iter_40_7.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10155 = nil
			end

			local var_40_16 = 0
			local var_40_17 = 0.425

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_18 = arg_37_1:FormatText(StoryNameCfg[1387].name)

				arg_37_1.leftNameTxt_.text = var_40_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_19 = arg_37_1:GetWordFromCfg(424051009)
				local var_40_20 = arg_37_1:FormatText(var_40_19.content)

				arg_37_1.text_.text = var_40_20

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_21 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051009", "story_v_out_424051.awb") ~= 0 then
					local var_40_24 = manager.audio:GetVoiceLength("story_v_out_424051", "424051009", "story_v_out_424051.awb") / 1000

					if var_40_24 + var_40_16 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_24 + var_40_16
					end

					if var_40_19.prefab_name ~= "" and arg_37_1.actors_[var_40_19.prefab_name] ~= nil then
						local var_40_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_19.prefab_name].transform, "story_v_out_424051", "424051009", "story_v_out_424051.awb")

						arg_37_1:RecordAudio("424051009", var_40_25)
						arg_37_1:RecordAudio("424051009", var_40_25)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_424051", "424051009", "story_v_out_424051.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_424051", "424051009", "story_v_out_424051.awb")
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
	Play424051010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 424051010
		arg_41_1.duration_ = 8.37

		local var_41_0 = {
			zh = 5.533,
			ja = 8.366
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
				arg_41_0:Play424051011(arg_41_1)
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

			local var_44_8 = arg_41_1.actors_["10153"]
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10153 == nil then
				arg_41_1.var_.actorSpriteComps10153 = var_44_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_10 = 0.2

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_10 and not isNil(var_44_8) then
				local var_44_11 = (arg_41_1.time_ - var_44_9) / var_44_10

				if arg_41_1.var_.actorSpriteComps10153 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps10153:ToTable()) do
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

			if arg_41_1.time_ >= var_44_9 + var_44_10 and arg_41_1.time_ < var_44_9 + var_44_10 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10153 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_44_7 then
						if arg_41_1.isInRecall_ then
							iter_44_7.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10153 = nil
			end

			local var_44_16 = arg_41_1.actors_["10155"].transform
			local var_44_17 = 0

			if var_44_17 < arg_41_1.time_ and arg_41_1.time_ <= var_44_17 + arg_44_0 then
				arg_41_1.var_.moveOldPos10155 = var_44_16.localPosition
				var_44_16.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10155", 4)

				local var_44_18 = var_44_16.childCount

				for iter_44_8 = 0, var_44_18 - 1 do
					local var_44_19 = var_44_16:GetChild(iter_44_8)

					if var_44_19.name == "split_2" then
						var_44_19:SetAsLastSibling()
						var_44_19.gameObject:SetActive(true)

						arg_41_1.var_.actorSpriteSplit10155 = var_44_19.gameObject:GetComponent(typeof(Image))

						arg_41_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_44_20 = 0.5

			if var_44_17 <= arg_41_1.time_ and arg_41_1.time_ < var_44_17 + var_44_20 then
				local var_44_21 = (arg_41_1.time_ - var_44_17) / var_44_20
				local var_44_22 = Vector3.New(440, -390, -250)

				var_44_16.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10155, var_44_22, var_44_21)

				if arg_41_1.var_.actorSpriteSplit10155 ~= nil then
					arg_41_1.var_.actorSpriteSplit10155:SetAlpha(var_44_21)
				end
			end

			if arg_41_1.time_ >= var_44_17 + var_44_20 and arg_41_1.time_ < var_44_17 + var_44_20 + arg_44_0 then
				var_44_16.localPosition = Vector3.New(440, -390, -250)

				if arg_41_1.var_.actorSpriteSplit10155 ~= nil then
					arg_41_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_44_23 = 0
			local var_44_24 = 0.625

			if var_44_23 < arg_41_1.time_ and arg_41_1.time_ <= var_44_23 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_25 = arg_41_1:FormatText(StoryNameCfg[1391].name)

				arg_41_1.leftNameTxt_.text = var_44_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_26 = arg_41_1:GetWordFromCfg(424051010)
				local var_44_27 = arg_41_1:FormatText(var_44_26.content)

				arg_41_1.text_.text = var_44_27

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_28 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051010", "story_v_out_424051.awb") ~= 0 then
					local var_44_31 = manager.audio:GetVoiceLength("story_v_out_424051", "424051010", "story_v_out_424051.awb") / 1000

					if var_44_31 + var_44_23 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_31 + var_44_23
					end

					if var_44_26.prefab_name ~= "" and arg_41_1.actors_[var_44_26.prefab_name] ~= nil then
						local var_44_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_26.prefab_name].transform, "story_v_out_424051", "424051010", "story_v_out_424051.awb")

						arg_41_1:RecordAudio("424051010", var_44_32)
						arg_41_1:RecordAudio("424051010", var_44_32)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_424051", "424051010", "story_v_out_424051.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_424051", "424051010", "story_v_out_424051.awb")
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
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play424051011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 424051011
		arg_45_1.duration_ = 1.87

		local var_45_0 = {
			zh = 1.433,
			ja = 1.866
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
				arg_45_0:Play424051012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = "10154"

			if arg_45_1.actors_[var_48_0] == nil then
				local var_48_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10154")

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

			local var_48_4 = arg_45_1.actors_["10154"]
			local var_48_5 = 0

			if var_48_5 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.actorSpriteComps10154 == nil then
				arg_45_1.var_.actorSpriteComps10154 = var_48_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_6 = 0.2

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_6 and not isNil(var_48_4) then
				local var_48_7 = (arg_45_1.time_ - var_48_5) / var_48_6

				if arg_45_1.var_.actorSpriteComps10154 then
					for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_45_1.time_ >= var_48_5 + var_48_6 and arg_45_1.time_ < var_48_5 + var_48_6 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.actorSpriteComps10154 then
				for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_48_5 then
						if arg_45_1.isInRecall_ then
							iter_48_5.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10154 = nil
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

			local var_48_20 = arg_45_1.actors_["10154"].transform
			local var_48_21 = 0

			if var_48_21 < arg_45_1.time_ and arg_45_1.time_ <= var_48_21 + arg_48_0 then
				arg_45_1.var_.moveOldPos10154 = var_48_20.localPosition
				var_48_20.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10154", 2)

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
				local var_48_26 = Vector3.New(-375, -338, -538)

				var_48_20.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10154, var_48_26, var_48_25)
			end

			if arg_45_1.time_ >= var_48_21 + var_48_24 and arg_45_1.time_ < var_48_21 + var_48_24 + arg_48_0 then
				var_48_20.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_48_27 = arg_45_1.actors_["10153"].transform
			local var_48_28 = 0

			if var_48_28 < arg_45_1.time_ and arg_45_1.time_ <= var_48_28 + arg_48_0 then
				arg_45_1.var_.moveOldPos10153 = var_48_27.localPosition
				var_48_27.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10153", 7)

				local var_48_29 = var_48_27.childCount

				for iter_48_11 = 0, var_48_29 - 1 do
					local var_48_30 = var_48_27:GetChild(iter_48_11)

					if var_48_30.name == "split_2" or not string.find(var_48_30.name, "split") then
						var_48_30.gameObject:SetActive(true)
					else
						var_48_30.gameObject:SetActive(false)
					end
				end
			end

			local var_48_31 = 0.001

			if var_48_28 <= arg_45_1.time_ and arg_45_1.time_ < var_48_28 + var_48_31 then
				local var_48_32 = (arg_45_1.time_ - var_48_28) / var_48_31
				local var_48_33 = Vector3.New(0, -2000, 0)

				var_48_27.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10153, var_48_33, var_48_32)
			end

			if arg_45_1.time_ >= var_48_28 + var_48_31 and arg_45_1.time_ < var_48_28 + var_48_31 + arg_48_0 then
				var_48_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_48_34 = arg_45_1.actors_["10154"]
			local var_48_35 = 0

			if var_48_35 < arg_45_1.time_ and arg_45_1.time_ <= var_48_35 + arg_48_0 then
				local var_48_36 = var_48_34:GetComponentInChildren(typeof(CanvasGroup))

				if var_48_36 then
					arg_45_1.var_.alphaOldValue10154 = var_48_36.alpha
					arg_45_1.var_.characterEffect10154 = var_48_36
				end

				arg_45_1.var_.alphaOldValue10154 = 0
			end

			local var_48_37 = 0.5

			if var_48_35 <= arg_45_1.time_ and arg_45_1.time_ < var_48_35 + var_48_37 then
				local var_48_38 = (arg_45_1.time_ - var_48_35) / var_48_37
				local var_48_39 = Mathf.Lerp(arg_45_1.var_.alphaOldValue10154, 1, var_48_38)

				if arg_45_1.var_.characterEffect10154 then
					arg_45_1.var_.characterEffect10154.alpha = var_48_39
				end
			end

			if arg_45_1.time_ >= var_48_35 + var_48_37 and arg_45_1.time_ < var_48_35 + var_48_37 + arg_48_0 and arg_45_1.var_.characterEffect10154 then
				arg_45_1.var_.characterEffect10154.alpha = 1
			end

			local var_48_40 = 0
			local var_48_41 = 0.15

			if var_48_40 < arg_45_1.time_ and arg_45_1.time_ <= var_48_40 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_42 = arg_45_1:FormatText(StoryNameCfg[1392].name)

				arg_45_1.leftNameTxt_.text = var_48_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_43 = arg_45_1:GetWordFromCfg(424051011)
				local var_48_44 = arg_45_1:FormatText(var_48_43.content)

				arg_45_1.text_.text = var_48_44

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_45 = 6
				local var_48_46 = utf8.len(var_48_44)
				local var_48_47 = var_48_45 <= 0 and var_48_41 or var_48_41 * (var_48_46 / var_48_45)

				if var_48_47 > 0 and var_48_41 < var_48_47 then
					arg_45_1.talkMaxDuration = var_48_47

					if var_48_47 + var_48_40 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_47 + var_48_40
					end
				end

				arg_45_1.text_.text = var_48_44
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051011", "story_v_out_424051.awb") ~= 0 then
					local var_48_48 = manager.audio:GetVoiceLength("story_v_out_424051", "424051011", "story_v_out_424051.awb") / 1000

					if var_48_48 + var_48_40 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_48 + var_48_40
					end

					if var_48_43.prefab_name ~= "" and arg_45_1.actors_[var_48_43.prefab_name] ~= nil then
						local var_48_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_43.prefab_name].transform, "story_v_out_424051", "424051011", "story_v_out_424051.awb")

						arg_45_1:RecordAudio("424051011", var_48_49)
						arg_45_1:RecordAudio("424051011", var_48_49)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_424051", "424051011", "story_v_out_424051.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_424051", "424051011", "story_v_out_424051.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_50 = math.max(var_48_41, arg_45_1.talkMaxDuration)

			if var_48_40 <= arg_45_1.time_ and arg_45_1.time_ < var_48_40 + var_48_50 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_40) / var_48_50

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_40 + var_48_50 and arg_45_1.time_ < var_48_40 + var_48_50 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_45_1:InitPlayNodeList()
	end,
	Play424051012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 424051012
		arg_49_1.duration_ = 5

		local var_49_0 = {
			zh = 3.333,
			ja = 5
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
				arg_49_0:Play424051013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10155"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10155 == nil then
				arg_49_1.var_.actorSpriteComps10155 = var_52_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.actorSpriteComps10155 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10155 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_52_3 then
						if arg_49_1.isInRecall_ then
							iter_52_3.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10155 = nil
			end

			local var_52_8 = arg_49_1.actors_["10154"]
			local var_52_9 = 0

			if var_52_9 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.actorSpriteComps10154 == nil then
				arg_49_1.var_.actorSpriteComps10154 = var_52_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_10 = 0.2

			if var_52_9 <= arg_49_1.time_ and arg_49_1.time_ < var_52_9 + var_52_10 and not isNil(var_52_8) then
				local var_52_11 = (arg_49_1.time_ - var_52_9) / var_52_10

				if arg_49_1.var_.actorSpriteComps10154 then
					for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_49_1.time_ >= var_52_9 + var_52_10 and arg_49_1.time_ < var_52_9 + var_52_10 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.actorSpriteComps10154 then
				for iter_52_6, iter_52_7 in pairs(arg_49_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_52_7 then
						if arg_49_1.isInRecall_ then
							iter_52_7.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10154 = nil
			end

			local var_52_16 = arg_49_1.actors_["10155"].transform
			local var_52_17 = 0

			if var_52_17 < arg_49_1.time_ and arg_49_1.time_ <= var_52_17 + arg_52_0 then
				arg_49_1.var_.moveOldPos10155 = var_52_16.localPosition
				var_52_16.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10155", 4)

				local var_52_18 = var_52_16.childCount

				for iter_52_8 = 0, var_52_18 - 1 do
					local var_52_19 = var_52_16:GetChild(iter_52_8)

					if var_52_19.name == "split_5" then
						var_52_19:SetAsLastSibling()
						var_52_19.gameObject:SetActive(true)

						arg_49_1.var_.actorSpriteSplit10155 = var_52_19.gameObject:GetComponent(typeof(Image))

						arg_49_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_52_20 = 0.5

			if var_52_17 <= arg_49_1.time_ and arg_49_1.time_ < var_52_17 + var_52_20 then
				local var_52_21 = (arg_49_1.time_ - var_52_17) / var_52_20
				local var_52_22 = Vector3.New(440, -390, -250)

				var_52_16.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10155, var_52_22, var_52_21)

				if arg_49_1.var_.actorSpriteSplit10155 ~= nil then
					arg_49_1.var_.actorSpriteSplit10155:SetAlpha(var_52_21)
				end
			end

			if arg_49_1.time_ >= var_52_17 + var_52_20 and arg_49_1.time_ < var_52_17 + var_52_20 + arg_52_0 then
				var_52_16.localPosition = Vector3.New(440, -390, -250)

				if arg_49_1.var_.actorSpriteSplit10155 ~= nil then
					arg_49_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_52_23 = 0
			local var_52_24 = 0.25

			if var_52_23 < arg_49_1.time_ and arg_49_1.time_ <= var_52_23 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_25 = arg_49_1:FormatText(StoryNameCfg[1391].name)

				arg_49_1.leftNameTxt_.text = var_52_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_26 = arg_49_1:GetWordFromCfg(424051012)
				local var_52_27 = arg_49_1:FormatText(var_52_26.content)

				arg_49_1.text_.text = var_52_27

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_28 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051012", "story_v_out_424051.awb") ~= 0 then
					local var_52_31 = manager.audio:GetVoiceLength("story_v_out_424051", "424051012", "story_v_out_424051.awb") / 1000

					if var_52_31 + var_52_23 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_31 + var_52_23
					end

					if var_52_26.prefab_name ~= "" and arg_49_1.actors_[var_52_26.prefab_name] ~= nil then
						local var_52_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_26.prefab_name].transform, "story_v_out_424051", "424051012", "story_v_out_424051.awb")

						arg_49_1:RecordAudio("424051012", var_52_32)
						arg_49_1:RecordAudio("424051012", var_52_32)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_424051", "424051012", "story_v_out_424051.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_424051", "424051012", "story_v_out_424051.awb")
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
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play424051013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 424051013
		arg_53_1.duration_ = 7.67

		local var_53_0 = {
			zh = 6.766,
			ja = 7.666
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
				arg_53_0:Play424051014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10154"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps10154 == nil then
				arg_53_1.var_.actorSpriteComps10154 = var_56_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_2 = 0.2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.actorSpriteComps10154 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps10154 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_56_3 then
						if arg_53_1.isInRecall_ then
							iter_56_3.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10154 = nil
			end

			local var_56_8 = arg_53_1.actors_["10155"]
			local var_56_9 = 0

			if var_56_9 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.actorSpriteComps10155 == nil then
				arg_53_1.var_.actorSpriteComps10155 = var_56_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_10 = 0.2

			if var_56_9 <= arg_53_1.time_ and arg_53_1.time_ < var_56_9 + var_56_10 and not isNil(var_56_8) then
				local var_56_11 = (arg_53_1.time_ - var_56_9) / var_56_10

				if arg_53_1.var_.actorSpriteComps10155 then
					for iter_56_4, iter_56_5 in pairs(arg_53_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_53_1.time_ >= var_56_9 + var_56_10 and arg_53_1.time_ < var_56_9 + var_56_10 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.actorSpriteComps10155 then
				for iter_56_6, iter_56_7 in pairs(arg_53_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_56_7 then
						if arg_53_1.isInRecall_ then
							iter_56_7.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10155 = nil
			end

			local var_56_16 = arg_53_1.actors_["10154"].transform
			local var_56_17 = 0

			if var_56_17 < arg_53_1.time_ and arg_53_1.time_ <= var_56_17 + arg_56_0 then
				arg_53_1.var_.moveOldPos10154 = var_56_16.localPosition
				var_56_16.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10154", 2)

				local var_56_18 = var_56_16.childCount

				for iter_56_8 = 0, var_56_18 - 1 do
					local var_56_19 = var_56_16:GetChild(iter_56_8)

					if var_56_19.name == "" or not string.find(var_56_19.name, "split") then
						var_56_19.gameObject:SetActive(true)
					else
						var_56_19.gameObject:SetActive(false)
					end
				end
			end

			local var_56_20 = 0.001

			if var_56_17 <= arg_53_1.time_ and arg_53_1.time_ < var_56_17 + var_56_20 then
				local var_56_21 = (arg_53_1.time_ - var_56_17) / var_56_20
				local var_56_22 = Vector3.New(-375, -338, -538)

				var_56_16.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10154, var_56_22, var_56_21)
			end

			if arg_53_1.time_ >= var_56_17 + var_56_20 and arg_53_1.time_ < var_56_17 + var_56_20 + arg_56_0 then
				var_56_16.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_56_23 = 0
			local var_56_24 = 1.15

			if var_56_23 < arg_53_1.time_ and arg_53_1.time_ <= var_56_23 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_25 = arg_53_1:FormatText(StoryNameCfg[1392].name)

				arg_53_1.leftNameTxt_.text = var_56_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_26 = arg_53_1:GetWordFromCfg(424051013)
				local var_56_27 = arg_53_1:FormatText(var_56_26.content)

				arg_53_1.text_.text = var_56_27

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_28 = 46
				local var_56_29 = utf8.len(var_56_27)
				local var_56_30 = var_56_28 <= 0 and var_56_24 or var_56_24 * (var_56_29 / var_56_28)

				if var_56_30 > 0 and var_56_24 < var_56_30 then
					arg_53_1.talkMaxDuration = var_56_30

					if var_56_30 + var_56_23 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_30 + var_56_23
					end
				end

				arg_53_1.text_.text = var_56_27
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051013", "story_v_out_424051.awb") ~= 0 then
					local var_56_31 = manager.audio:GetVoiceLength("story_v_out_424051", "424051013", "story_v_out_424051.awb") / 1000

					if var_56_31 + var_56_23 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_31 + var_56_23
					end

					if var_56_26.prefab_name ~= "" and arg_53_1.actors_[var_56_26.prefab_name] ~= nil then
						local var_56_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_26.prefab_name].transform, "story_v_out_424051", "424051013", "story_v_out_424051.awb")

						arg_53_1:RecordAudio("424051013", var_56_32)
						arg_53_1:RecordAudio("424051013", var_56_32)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_424051", "424051013", "story_v_out_424051.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_424051", "424051013", "story_v_out_424051.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_33 = math.max(var_56_24, arg_53_1.talkMaxDuration)

			if var_56_23 <= arg_53_1.time_ and arg_53_1.time_ < var_56_23 + var_56_33 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_23) / var_56_33

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_23 + var_56_33 and arg_53_1.time_ < var_56_23 + var_56_33 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
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
	Play424051014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 424051014
		arg_57_1.duration_ = 6.83

		local var_57_0 = {
			zh = 6.566,
			ja = 6.833
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
				arg_57_0:Play424051015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10154"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos10154 = var_60_0.localPosition
				var_60_0.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10154", 2)

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
				local var_60_6 = Vector3.New(-375, -338, -538)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10154, var_60_6, var_60_5)
			end

			if arg_57_1.time_ >= var_60_1 + var_60_4 and arg_57_1.time_ < var_60_1 + var_60_4 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_60_7 = 0
			local var_60_8 = 0.875

			if var_60_7 < arg_57_1.time_ and arg_57_1.time_ <= var_60_7 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_9 = arg_57_1:FormatText(StoryNameCfg[1392].name)

				arg_57_1.leftNameTxt_.text = var_60_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_10 = arg_57_1:GetWordFromCfg(424051014)
				local var_60_11 = arg_57_1:FormatText(var_60_10.content)

				arg_57_1.text_.text = var_60_11

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_12 = 35
				local var_60_13 = utf8.len(var_60_11)
				local var_60_14 = var_60_12 <= 0 and var_60_8 or var_60_8 * (var_60_13 / var_60_12)

				if var_60_14 > 0 and var_60_8 < var_60_14 then
					arg_57_1.talkMaxDuration = var_60_14

					if var_60_14 + var_60_7 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_7
					end
				end

				arg_57_1.text_.text = var_60_11
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051014", "story_v_out_424051.awb") ~= 0 then
					local var_60_15 = manager.audio:GetVoiceLength("story_v_out_424051", "424051014", "story_v_out_424051.awb") / 1000

					if var_60_15 + var_60_7 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_15 + var_60_7
					end

					if var_60_10.prefab_name ~= "" and arg_57_1.actors_[var_60_10.prefab_name] ~= nil then
						local var_60_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_10.prefab_name].transform, "story_v_out_424051", "424051014", "story_v_out_424051.awb")

						arg_57_1:RecordAudio("424051014", var_60_16)
						arg_57_1:RecordAudio("424051014", var_60_16)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_424051", "424051014", "story_v_out_424051.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_424051", "424051014", "story_v_out_424051.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_17 = math.max(var_60_8, arg_57_1.talkMaxDuration)

			if var_60_7 <= arg_57_1.time_ and arg_57_1.time_ < var_60_7 + var_60_17 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_7) / var_60_17

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_7 + var_60_17 and arg_57_1.time_ < var_60_7 + var_60_17 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
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
	Play424051015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 424051015
		arg_61_1.duration_ = 8.13

		local var_61_0 = {
			zh = 4.866,
			ja = 8.133
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
				arg_61_0:Play424051016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10155"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10155 == nil then
				arg_61_1.var_.actorSpriteComps10155 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps10155 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10155 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10155 = nil
			end

			local var_64_8 = arg_61_1.actors_["10154"]
			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps10154 == nil then
				arg_61_1.var_.actorSpriteComps10154 = var_64_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_10 = 0.2

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_10 and not isNil(var_64_8) then
				local var_64_11 = (arg_61_1.time_ - var_64_9) / var_64_10

				if arg_61_1.var_.actorSpriteComps10154 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_61_1.time_ >= var_64_9 + var_64_10 and arg_61_1.time_ < var_64_9 + var_64_10 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps10154 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_64_7 then
						if arg_61_1.isInRecall_ then
							iter_64_7.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10154 = nil
			end

			local var_64_16 = arg_61_1.actors_["10155"].transform
			local var_64_17 = 0

			if var_64_17 < arg_61_1.time_ and arg_61_1.time_ <= var_64_17 + arg_64_0 then
				arg_61_1.var_.moveOldPos10155 = var_64_16.localPosition
				var_64_16.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10155", 4)

				local var_64_18 = var_64_16.childCount

				for iter_64_8 = 0, var_64_18 - 1 do
					local var_64_19 = var_64_16:GetChild(iter_64_8)

					if var_64_19.name == "split_4" then
						var_64_19:SetAsLastSibling()
						var_64_19.gameObject:SetActive(true)

						arg_61_1.var_.actorSpriteSplit10155 = var_64_19.gameObject:GetComponent(typeof(Image))

						arg_61_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_64_20 = 0.5

			if var_64_17 <= arg_61_1.time_ and arg_61_1.time_ < var_64_17 + var_64_20 then
				local var_64_21 = (arg_61_1.time_ - var_64_17) / var_64_20
				local var_64_22 = Vector3.New(440, -390, -250)

				var_64_16.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10155, var_64_22, var_64_21)

				if arg_61_1.var_.actorSpriteSplit10155 ~= nil then
					arg_61_1.var_.actorSpriteSplit10155:SetAlpha(var_64_21)
				end
			end

			if arg_61_1.time_ >= var_64_17 + var_64_20 and arg_61_1.time_ < var_64_17 + var_64_20 + arg_64_0 then
				var_64_16.localPosition = Vector3.New(440, -390, -250)

				if arg_61_1.var_.actorSpriteSplit10155 ~= nil then
					arg_61_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_64_23 = 0
			local var_64_24 = 0.475

			if var_64_23 < arg_61_1.time_ and arg_61_1.time_ <= var_64_23 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_25 = arg_61_1:FormatText(StoryNameCfg[1391].name)

				arg_61_1.leftNameTxt_.text = var_64_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_26 = arg_61_1:GetWordFromCfg(424051015)
				local var_64_27 = arg_61_1:FormatText(var_64_26.content)

				arg_61_1.text_.text = var_64_27

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_28 = 19
				local var_64_29 = utf8.len(var_64_27)
				local var_64_30 = var_64_28 <= 0 and var_64_24 or var_64_24 * (var_64_29 / var_64_28)

				if var_64_30 > 0 and var_64_24 < var_64_30 then
					arg_61_1.talkMaxDuration = var_64_30

					if var_64_30 + var_64_23 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_30 + var_64_23
					end
				end

				arg_61_1.text_.text = var_64_27
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051015", "story_v_out_424051.awb") ~= 0 then
					local var_64_31 = manager.audio:GetVoiceLength("story_v_out_424051", "424051015", "story_v_out_424051.awb") / 1000

					if var_64_31 + var_64_23 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_31 + var_64_23
					end

					if var_64_26.prefab_name ~= "" and arg_61_1.actors_[var_64_26.prefab_name] ~= nil then
						local var_64_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_26.prefab_name].transform, "story_v_out_424051", "424051015", "story_v_out_424051.awb")

						arg_61_1:RecordAudio("424051015", var_64_32)
						arg_61_1:RecordAudio("424051015", var_64_32)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_424051", "424051015", "story_v_out_424051.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_424051", "424051015", "story_v_out_424051.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_33 = math.max(var_64_24, arg_61_1.talkMaxDuration)

			if var_64_23 <= arg_61_1.time_ and arg_61_1.time_ < var_64_23 + var_64_33 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_23) / var_64_33

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_23 + var_64_33 and arg_61_1.time_ < var_64_23 + var_64_33 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play424051016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 424051016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play424051017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10155"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10155 == nil then
				arg_65_1.var_.actorSpriteComps10155 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps10155 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								local var_68_4 = Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor2.r, var_68_3)
								local var_68_5 = Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor2.g, var_68_3)
								local var_68_6 = Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor2.b, var_68_3)

								iter_68_1.color = Color.New(var_68_4, var_68_5, var_68_6)
							else
								local var_68_7 = Mathf.Lerp(iter_68_1.color.r, 0.5, var_68_3)

								iter_68_1.color = Color.New(var_68_7, var_68_7, var_68_7)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10155 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10155 = nil
			end

			local var_68_8 = 0
			local var_68_9 = 0.625

			if var_68_8 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_10 = arg_65_1:FormatText(StoryNameCfg[7].name)

				arg_65_1.leftNameTxt_.text = var_68_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_11 = arg_65_1:GetWordFromCfg(424051016)
				local var_68_12 = arg_65_1:FormatText(var_68_11.content)

				arg_65_1.text_.text = var_68_12

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 25
				local var_68_14 = utf8.len(var_68_12)
				local var_68_15 = var_68_13 <= 0 and var_68_9 or var_68_9 * (var_68_14 / var_68_13)

				if var_68_15 > 0 and var_68_9 < var_68_15 then
					arg_65_1.talkMaxDuration = var_68_15

					if var_68_15 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_15 + var_68_8
					end
				end

				arg_65_1.text_.text = var_68_12
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_16 = math.max(var_68_9, arg_65_1.talkMaxDuration)

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_16 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_8) / var_68_16

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_8 + var_68_16 and arg_65_1.time_ < var_68_8 + var_68_16 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play424051017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 424051017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play424051018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.525

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[7].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(424051017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 21
				local var_72_6 = utf8.len(var_72_4)
				local var_72_7 = var_72_5 <= 0 and var_72_1 or var_72_1 * (var_72_6 / var_72_5)

				if var_72_7 > 0 and var_72_1 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_8 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_8 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_8

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_8 and arg_69_1.time_ < var_72_0 + var_72_8 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play424051018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 424051018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play424051019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10155"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos10155 = var_76_0.localPosition
				var_76_0.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10155", 7)

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
				local var_76_6 = Vector3.New(0, -2000, 0)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10155, var_76_6, var_76_5)
			end

			if arg_73_1.time_ >= var_76_1 + var_76_4 and arg_73_1.time_ < var_76_1 + var_76_4 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_76_7 = arg_73_1.actors_["10154"].transform
			local var_76_8 = 0

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.var_.moveOldPos10154 = var_76_7.localPosition
				var_76_7.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10154", 7)

				local var_76_9 = var_76_7.childCount

				for iter_76_1 = 0, var_76_9 - 1 do
					local var_76_10 = var_76_7:GetChild(iter_76_1)

					if var_76_10.name == "" or not string.find(var_76_10.name, "split") then
						var_76_10.gameObject:SetActive(true)
					else
						var_76_10.gameObject:SetActive(false)
					end
				end
			end

			local var_76_11 = 0.001

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_11 then
				local var_76_12 = (arg_73_1.time_ - var_76_8) / var_76_11
				local var_76_13 = Vector3.New(0, -2000, 0)

				var_76_7.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10154, var_76_13, var_76_12)
			end

			if arg_73_1.time_ >= var_76_8 + var_76_11 and arg_73_1.time_ < var_76_8 + var_76_11 + arg_76_0 then
				var_76_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_76_14 = manager.ui.mainCamera.transform
			local var_76_15 = 0.3

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 then
				local var_76_16 = arg_73_1.var_.effectlansesaomiao4601
				local var_76_17
				local var_76_18 = var_76_14

				if not var_76_16 then
					var_76_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_scan_in_out"), var_76_18)
					var_76_16.name = "lansesaomiao4601"
					arg_73_1.var_.effectlansesaomiao4601 = var_76_16
				else
					var_76_16.transform:SetParent(var_76_18)
				end

				var_76_16.transform.localPosition = Vector3.New(0, 0, 0)
				var_76_16.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_76_19 = manager.ui.mainCameraCom_
				local var_76_20 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_76_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_76_21 = var_76_16.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_76_22 = 15
				local var_76_23 = 2 * var_76_22 * Mathf.Tan(var_76_19.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_76_19.aspect
				local var_76_24 = 1
				local var_76_25 = 1.7777777777777777

				if var_76_25 < var_76_19.aspect then
					var_76_24 = var_76_23 / (2 * var_76_22 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_76_25)
				end

				for iter_76_2, iter_76_3 in ipairs(var_76_21) do
					local var_76_26 = iter_76_3.transform.localScale

					iter_76_3.transform.localScale = Vector3.New(var_76_26.x / var_76_20 * var_76_24, var_76_26.y / var_76_20, var_76_26.z)
				end
			end

			local var_76_27 = manager.ui.mainCamera.transform
			local var_76_28 = 3.8

			if var_76_28 < arg_73_1.time_ and arg_73_1.time_ <= var_76_28 + arg_76_0 then
				local var_76_29 = arg_73_1.var_.effectlansesaomiao4601

				if var_76_29 then
					Object.Destroy(var_76_29)

					arg_73_1.var_.effectlansesaomiao4601 = nil
				end
			end

			local var_76_30 = 0

			if var_76_30 < arg_73_1.time_ and arg_73_1.time_ <= var_76_30 + arg_76_0 then
				arg_73_1.allBtn_.enabled = false
			end

			local var_76_31 = 0.3

			if arg_73_1.time_ >= var_76_30 + var_76_31 and arg_73_1.time_ < var_76_30 + var_76_31 + arg_76_0 then
				arg_73_1.allBtn_.enabled = true
			end

			local var_76_32 = 0.3
			local var_76_33 = 1

			if var_76_32 < arg_73_1.time_ and arg_73_1.time_ <= var_76_32 + arg_76_0 then
				local var_76_34 = "play"
				local var_76_35 = "effect"

				arg_73_1:AudioAction(var_76_34, var_76_35, "se_story_120_00", "se_story_120_00_scan", "")
			end

			local var_76_36 = 0
			local var_76_37 = 0.675

			if var_76_36 < arg_73_1.time_ and arg_73_1.time_ <= var_76_36 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				arg_73_1.dialog_:SetActive(true)

				arg_73_1.dialogCg_.alpha = 0

				local var_76_38 = LeanTween.value(arg_73_1.dialog_, 0, 1, 0.3)

				var_76_38:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_73_1.dialogCg_.alpha = arg_77_0
				end))
				var_76_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_73_1.dialog_)
					var_76_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_73_1.duration_ = arg_73_1.duration_ + 0.3

				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_39 = arg_73_1:GetWordFromCfg(424051018)
				local var_76_40 = arg_73_1:FormatText(var_76_39.content)

				arg_73_1.text_.text = var_76_40

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_41 = 27
				local var_76_42 = utf8.len(var_76_40)
				local var_76_43 = var_76_41 <= 0 and var_76_37 or var_76_37 * (var_76_42 / var_76_41)

				if var_76_43 > 0 and var_76_37 < var_76_43 then
					arg_73_1.talkMaxDuration = var_76_43
					var_76_36 = var_76_36 + 0.3

					if var_76_43 + var_76_36 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_43 + var_76_36
					end
				end

				arg_73_1.text_.text = var_76_40
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_44 = var_76_36 + 0.3
			local var_76_45 = math.max(var_76_37, arg_73_1.talkMaxDuration)

			if var_76_44 <= arg_73_1.time_ and arg_73_1.time_ < var_76_44 + var_76_45 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_44) / var_76_45

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_44 + var_76_45 and arg_73_1.time_ < var_76_44 + var_76_45 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10154",
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
	Play424051019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 424051019
		arg_79_1.duration_ = 2.2

		local var_79_0 = {
			zh = 1.5,
			ja = 2.2
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
				arg_79_0:Play424051020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["10155"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.actorSpriteComps10155 == nil then
				arg_79_1.var_.actorSpriteComps10155 = var_82_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_2 = 0.2

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.actorSpriteComps10155 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.actorSpriteComps10155 then
				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_82_3 then
						if arg_79_1.isInRecall_ then
							iter_82_3.color = arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_82_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_79_1.var_.actorSpriteComps10155 = nil
			end

			local var_82_8 = arg_79_1.actors_["10155"].transform
			local var_82_9 = 0

			if var_82_9 < arg_79_1.time_ and arg_79_1.time_ <= var_82_9 + arg_82_0 then
				arg_79_1.var_.moveOldPos10155 = var_82_8.localPosition
				var_82_8.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("10155", 2)

				local var_82_10 = var_82_8.childCount

				for iter_82_4 = 0, var_82_10 - 1 do
					local var_82_11 = var_82_8:GetChild(iter_82_4)

					if var_82_11.name == "" or not string.find(var_82_11.name, "split") then
						var_82_11.gameObject:SetActive(true)
					else
						var_82_11.gameObject:SetActive(false)
					end
				end
			end

			local var_82_12 = 0.001

			if var_82_9 <= arg_79_1.time_ and arg_79_1.time_ < var_82_9 + var_82_12 then
				local var_82_13 = (arg_79_1.time_ - var_82_9) / var_82_12
				local var_82_14 = Vector3.New(-410, -390, -250)

				var_82_8.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10155, var_82_14, var_82_13)
			end

			if arg_79_1.time_ >= var_82_9 + var_82_12 and arg_79_1.time_ < var_82_9 + var_82_12 + arg_82_0 then
				var_82_8.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_82_15 = 0
			local var_82_16 = 0.125

			if var_82_15 < arg_79_1.time_ and arg_79_1.time_ <= var_82_15 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_17 = arg_79_1:FormatText(StoryNameCfg[1391].name)

				arg_79_1.leftNameTxt_.text = var_82_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_18 = arg_79_1:GetWordFromCfg(424051019)
				local var_82_19 = arg_79_1:FormatText(var_82_18.content)

				arg_79_1.text_.text = var_82_19

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_20 = 5
				local var_82_21 = utf8.len(var_82_19)
				local var_82_22 = var_82_20 <= 0 and var_82_16 or var_82_16 * (var_82_21 / var_82_20)

				if var_82_22 > 0 and var_82_16 < var_82_22 then
					arg_79_1.talkMaxDuration = var_82_22

					if var_82_22 + var_82_15 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_22 + var_82_15
					end
				end

				arg_79_1.text_.text = var_82_19
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051019", "story_v_out_424051.awb") ~= 0 then
					local var_82_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051019", "story_v_out_424051.awb") / 1000

					if var_82_23 + var_82_15 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_23 + var_82_15
					end

					if var_82_18.prefab_name ~= "" and arg_79_1.actors_[var_82_18.prefab_name] ~= nil then
						local var_82_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_18.prefab_name].transform, "story_v_out_424051", "424051019", "story_v_out_424051.awb")

						arg_79_1:RecordAudio("424051019", var_82_24)
						arg_79_1:RecordAudio("424051019", var_82_24)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_424051", "424051019", "story_v_out_424051.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_424051", "424051019", "story_v_out_424051.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_25 = math.max(var_82_16, arg_79_1.talkMaxDuration)

			if var_82_15 <= arg_79_1.time_ and arg_79_1.time_ < var_82_15 + var_82_25 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_15) / var_82_25

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_15 + var_82_25 and arg_79_1.time_ < var_82_15 + var_82_25 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
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

		arg_79_1:InitPlayNodeList()
	end,
	Play424051020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 424051020
		arg_83_1.duration_ = 8.6

		local var_83_0 = {
			zh = 8.4,
			ja = 8.6
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
				arg_83_0:Play424051021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["10153"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.actorSpriteComps10153 == nil then
				arg_83_1.var_.actorSpriteComps10153 = var_86_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_2 = 0.2

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.actorSpriteComps10153 then
					for iter_86_0, iter_86_1 in pairs(arg_83_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_86_1 then
							if arg_83_1.isInRecall_ then
								local var_86_4 = Mathf.Lerp(iter_86_1.color.r, arg_83_1.hightColor1.r, var_86_3)
								local var_86_5 = Mathf.Lerp(iter_86_1.color.g, arg_83_1.hightColor1.g, var_86_3)
								local var_86_6 = Mathf.Lerp(iter_86_1.color.b, arg_83_1.hightColor1.b, var_86_3)

								iter_86_1.color = Color.New(var_86_4, var_86_5, var_86_6)
							else
								local var_86_7 = Mathf.Lerp(iter_86_1.color.r, 1, var_86_3)

								iter_86_1.color = Color.New(var_86_7, var_86_7, var_86_7)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.actorSpriteComps10153 then
				for iter_86_2, iter_86_3 in pairs(arg_83_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_86_3 then
						if arg_83_1.isInRecall_ then
							iter_86_3.color = arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_86_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_83_1.var_.actorSpriteComps10153 = nil
			end

			local var_86_8 = arg_83_1.actors_["10155"]
			local var_86_9 = 0

			if var_86_9 < arg_83_1.time_ and arg_83_1.time_ <= var_86_9 + arg_86_0 and not isNil(var_86_8) and arg_83_1.var_.actorSpriteComps10155 == nil then
				arg_83_1.var_.actorSpriteComps10155 = var_86_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_10 = 0.2

			if var_86_9 <= arg_83_1.time_ and arg_83_1.time_ < var_86_9 + var_86_10 and not isNil(var_86_8) then
				local var_86_11 = (arg_83_1.time_ - var_86_9) / var_86_10

				if arg_83_1.var_.actorSpriteComps10155 then
					for iter_86_4, iter_86_5 in pairs(arg_83_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_86_5 then
							if arg_83_1.isInRecall_ then
								local var_86_12 = Mathf.Lerp(iter_86_5.color.r, arg_83_1.hightColor2.r, var_86_11)
								local var_86_13 = Mathf.Lerp(iter_86_5.color.g, arg_83_1.hightColor2.g, var_86_11)
								local var_86_14 = Mathf.Lerp(iter_86_5.color.b, arg_83_1.hightColor2.b, var_86_11)

								iter_86_5.color = Color.New(var_86_12, var_86_13, var_86_14)
							else
								local var_86_15 = Mathf.Lerp(iter_86_5.color.r, 0.5, var_86_11)

								iter_86_5.color = Color.New(var_86_15, var_86_15, var_86_15)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= var_86_9 + var_86_10 and arg_83_1.time_ < var_86_9 + var_86_10 + arg_86_0 and not isNil(var_86_8) and arg_83_1.var_.actorSpriteComps10155 then
				for iter_86_6, iter_86_7 in pairs(arg_83_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_86_7 then
						if arg_83_1.isInRecall_ then
							iter_86_7.color = arg_83_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_86_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_83_1.var_.actorSpriteComps10155 = nil
			end

			local var_86_16 = arg_83_1.actors_["10153"].transform
			local var_86_17 = 0

			if var_86_17 < arg_83_1.time_ and arg_83_1.time_ <= var_86_17 + arg_86_0 then
				arg_83_1.var_.moveOldPos10153 = var_86_16.localPosition
				var_86_16.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("10153", 4)

				local var_86_18 = var_86_16.childCount

				for iter_86_8 = 0, var_86_18 - 1 do
					local var_86_19 = var_86_16:GetChild(iter_86_8)

					if var_86_19.name == "" or not string.find(var_86_19.name, "split") then
						var_86_19.gameObject:SetActive(true)
					else
						var_86_19.gameObject:SetActive(false)
					end
				end
			end

			local var_86_20 = 0.001

			if var_86_17 <= arg_83_1.time_ and arg_83_1.time_ < var_86_17 + var_86_20 then
				local var_86_21 = (arg_83_1.time_ - var_86_17) / var_86_20
				local var_86_22 = Vector3.New(400, -395, -330)

				var_86_16.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10153, var_86_22, var_86_21)
			end

			if arg_83_1.time_ >= var_86_17 + var_86_20 and arg_83_1.time_ < var_86_17 + var_86_20 + arg_86_0 then
				var_86_16.localPosition = Vector3.New(400, -395, -330)
			end

			local var_86_23 = 0
			local var_86_24 = 0.9

			if var_86_23 < arg_83_1.time_ and arg_83_1.time_ <= var_86_23 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_25 = arg_83_1:FormatText(StoryNameCfg[1387].name)

				arg_83_1.leftNameTxt_.text = var_86_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_26 = arg_83_1:GetWordFromCfg(424051020)
				local var_86_27 = arg_83_1:FormatText(var_86_26.content)

				arg_83_1.text_.text = var_86_27

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_28 = 36
				local var_86_29 = utf8.len(var_86_27)
				local var_86_30 = var_86_28 <= 0 and var_86_24 or var_86_24 * (var_86_29 / var_86_28)

				if var_86_30 > 0 and var_86_24 < var_86_30 then
					arg_83_1.talkMaxDuration = var_86_30

					if var_86_30 + var_86_23 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_30 + var_86_23
					end
				end

				arg_83_1.text_.text = var_86_27
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051020", "story_v_out_424051.awb") ~= 0 then
					local var_86_31 = manager.audio:GetVoiceLength("story_v_out_424051", "424051020", "story_v_out_424051.awb") / 1000

					if var_86_31 + var_86_23 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_31 + var_86_23
					end

					if var_86_26.prefab_name ~= "" and arg_83_1.actors_[var_86_26.prefab_name] ~= nil then
						local var_86_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_26.prefab_name].transform, "story_v_out_424051", "424051020", "story_v_out_424051.awb")

						arg_83_1:RecordAudio("424051020", var_86_32)
						arg_83_1:RecordAudio("424051020", var_86_32)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_424051", "424051020", "story_v_out_424051.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_424051", "424051020", "story_v_out_424051.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_33 = math.max(var_86_24, arg_83_1.talkMaxDuration)

			if var_86_23 <= arg_83_1.time_ and arg_83_1.time_ < var_86_23 + var_86_33 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_23) / var_86_33

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_23 + var_86_33 and arg_83_1.time_ < var_86_23 + var_86_33 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
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

		arg_83_1:InitPlayNodeList()
	end,
	Play424051021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 424051021
		arg_87_1.duration_ = 10.53

		local var_87_0 = {
			zh = 5.5,
			ja = 10.533
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
				arg_87_0:Play424051022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["10155"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.actorSpriteComps10155 == nil then
				arg_87_1.var_.actorSpriteComps10155 = var_90_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_2 = 0.2

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.actorSpriteComps10155 then
					for iter_90_0, iter_90_1 in pairs(arg_87_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_90_1 then
							if arg_87_1.isInRecall_ then
								local var_90_4 = Mathf.Lerp(iter_90_1.color.r, arg_87_1.hightColor1.r, var_90_3)
								local var_90_5 = Mathf.Lerp(iter_90_1.color.g, arg_87_1.hightColor1.g, var_90_3)
								local var_90_6 = Mathf.Lerp(iter_90_1.color.b, arg_87_1.hightColor1.b, var_90_3)

								iter_90_1.color = Color.New(var_90_4, var_90_5, var_90_6)
							else
								local var_90_7 = Mathf.Lerp(iter_90_1.color.r, 1, var_90_3)

								iter_90_1.color = Color.New(var_90_7, var_90_7, var_90_7)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.actorSpriteComps10155 then
				for iter_90_2, iter_90_3 in pairs(arg_87_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_90_3 then
						if arg_87_1.isInRecall_ then
							iter_90_3.color = arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_90_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_87_1.var_.actorSpriteComps10155 = nil
			end

			local var_90_8 = arg_87_1.actors_["10153"]
			local var_90_9 = 0

			if var_90_9 < arg_87_1.time_ and arg_87_1.time_ <= var_90_9 + arg_90_0 and not isNil(var_90_8) and arg_87_1.var_.actorSpriteComps10153 == nil then
				arg_87_1.var_.actorSpriteComps10153 = var_90_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_10 = 0.2

			if var_90_9 <= arg_87_1.time_ and arg_87_1.time_ < var_90_9 + var_90_10 and not isNil(var_90_8) then
				local var_90_11 = (arg_87_1.time_ - var_90_9) / var_90_10

				if arg_87_1.var_.actorSpriteComps10153 then
					for iter_90_4, iter_90_5 in pairs(arg_87_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_90_5 then
							if arg_87_1.isInRecall_ then
								local var_90_12 = Mathf.Lerp(iter_90_5.color.r, arg_87_1.hightColor2.r, var_90_11)
								local var_90_13 = Mathf.Lerp(iter_90_5.color.g, arg_87_1.hightColor2.g, var_90_11)
								local var_90_14 = Mathf.Lerp(iter_90_5.color.b, arg_87_1.hightColor2.b, var_90_11)

								iter_90_5.color = Color.New(var_90_12, var_90_13, var_90_14)
							else
								local var_90_15 = Mathf.Lerp(iter_90_5.color.r, 0.5, var_90_11)

								iter_90_5.color = Color.New(var_90_15, var_90_15, var_90_15)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= var_90_9 + var_90_10 and arg_87_1.time_ < var_90_9 + var_90_10 + arg_90_0 and not isNil(var_90_8) and arg_87_1.var_.actorSpriteComps10153 then
				for iter_90_6, iter_90_7 in pairs(arg_87_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_90_7 then
						if arg_87_1.isInRecall_ then
							iter_90_7.color = arg_87_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_90_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_87_1.var_.actorSpriteComps10153 = nil
			end

			local var_90_16 = arg_87_1.actors_["10155"].transform
			local var_90_17 = 0

			if var_90_17 < arg_87_1.time_ and arg_87_1.time_ <= var_90_17 + arg_90_0 then
				arg_87_1.var_.moveOldPos10155 = var_90_16.localPosition
				var_90_16.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("10155", 2)

				local var_90_18 = var_90_16.childCount

				for iter_90_8 = 0, var_90_18 - 1 do
					local var_90_19 = var_90_16:GetChild(iter_90_8)

					if var_90_19.name == "" or not string.find(var_90_19.name, "split") then
						var_90_19.gameObject:SetActive(true)
					else
						var_90_19.gameObject:SetActive(false)
					end
				end
			end

			local var_90_20 = 0.001

			if var_90_17 <= arg_87_1.time_ and arg_87_1.time_ < var_90_17 + var_90_20 then
				local var_90_21 = (arg_87_1.time_ - var_90_17) / var_90_20
				local var_90_22 = Vector3.New(-410, -390, -250)

				var_90_16.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10155, var_90_22, var_90_21)
			end

			if arg_87_1.time_ >= var_90_17 + var_90_20 and arg_87_1.time_ < var_90_17 + var_90_20 + arg_90_0 then
				var_90_16.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_90_23 = 0
			local var_90_24 = 0.45

			if var_90_23 < arg_87_1.time_ and arg_87_1.time_ <= var_90_23 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_25 = arg_87_1:FormatText(StoryNameCfg[1391].name)

				arg_87_1.leftNameTxt_.text = var_90_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_26 = arg_87_1:GetWordFromCfg(424051021)
				local var_90_27 = arg_87_1:FormatText(var_90_26.content)

				arg_87_1.text_.text = var_90_27

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_28 = 18
				local var_90_29 = utf8.len(var_90_27)
				local var_90_30 = var_90_28 <= 0 and var_90_24 or var_90_24 * (var_90_29 / var_90_28)

				if var_90_30 > 0 and var_90_24 < var_90_30 then
					arg_87_1.talkMaxDuration = var_90_30

					if var_90_30 + var_90_23 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_30 + var_90_23
					end
				end

				arg_87_1.text_.text = var_90_27
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051021", "story_v_out_424051.awb") ~= 0 then
					local var_90_31 = manager.audio:GetVoiceLength("story_v_out_424051", "424051021", "story_v_out_424051.awb") / 1000

					if var_90_31 + var_90_23 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_31 + var_90_23
					end

					if var_90_26.prefab_name ~= "" and arg_87_1.actors_[var_90_26.prefab_name] ~= nil then
						local var_90_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_26.prefab_name].transform, "story_v_out_424051", "424051021", "story_v_out_424051.awb")

						arg_87_1:RecordAudio("424051021", var_90_32)
						arg_87_1:RecordAudio("424051021", var_90_32)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_424051", "424051021", "story_v_out_424051.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_424051", "424051021", "story_v_out_424051.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_33 = math.max(var_90_24, arg_87_1.talkMaxDuration)

			if var_90_23 <= arg_87_1.time_ and arg_87_1.time_ < var_90_23 + var_90_33 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_23) / var_90_33

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_23 + var_90_33 and arg_87_1.time_ < var_90_23 + var_90_33 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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

		arg_87_1:InitPlayNodeList()
	end,
	Play424051022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 424051022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play424051023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["10155"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.actorSpriteComps10155 == nil then
				arg_91_1.var_.actorSpriteComps10155 = var_94_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_2 = 0.2

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.actorSpriteComps10155 then
					for iter_94_0, iter_94_1 in pairs(arg_91_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_94_1 then
							if arg_91_1.isInRecall_ then
								local var_94_4 = Mathf.Lerp(iter_94_1.color.r, arg_91_1.hightColor2.r, var_94_3)
								local var_94_5 = Mathf.Lerp(iter_94_1.color.g, arg_91_1.hightColor2.g, var_94_3)
								local var_94_6 = Mathf.Lerp(iter_94_1.color.b, arg_91_1.hightColor2.b, var_94_3)

								iter_94_1.color = Color.New(var_94_4, var_94_5, var_94_6)
							else
								local var_94_7 = Mathf.Lerp(iter_94_1.color.r, 0.5, var_94_3)

								iter_94_1.color = Color.New(var_94_7, var_94_7, var_94_7)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.actorSpriteComps10155 then
				for iter_94_2, iter_94_3 in pairs(arg_91_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_94_3 then
						if arg_91_1.isInRecall_ then
							iter_94_3.color = arg_91_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_94_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps10155 = nil
			end

			local var_94_8 = 0
			local var_94_9 = 0.15

			if var_94_8 < arg_91_1.time_ and arg_91_1.time_ <= var_94_8 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_10 = arg_91_1:FormatText(StoryNameCfg[7].name)

				arg_91_1.leftNameTxt_.text = var_94_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_11 = arg_91_1:GetWordFromCfg(424051022)
				local var_94_12 = arg_91_1:FormatText(var_94_11.content)

				arg_91_1.text_.text = var_94_12

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_13 = 6
				local var_94_14 = utf8.len(var_94_12)
				local var_94_15 = var_94_13 <= 0 and var_94_9 or var_94_9 * (var_94_14 / var_94_13)

				if var_94_15 > 0 and var_94_9 < var_94_15 then
					arg_91_1.talkMaxDuration = var_94_15

					if var_94_15 + var_94_8 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_15 + var_94_8
					end
				end

				arg_91_1.text_.text = var_94_12
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_16 = math.max(var_94_9, arg_91_1.talkMaxDuration)

			if var_94_8 <= arg_91_1.time_ and arg_91_1.time_ < var_94_8 + var_94_16 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_8) / var_94_16

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_8 + var_94_16 and arg_91_1.time_ < var_94_8 + var_94_16 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play424051023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 424051023
		arg_95_1.duration_ = 4.93

		local var_95_0 = {
			zh = 2.666,
			ja = 4.933
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
				arg_95_0:Play424051024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["10155"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.actorSpriteComps10155 == nil then
				arg_95_1.var_.actorSpriteComps10155 = var_98_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_2 = 0.2

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.actorSpriteComps10155 then
					for iter_98_0, iter_98_1 in pairs(arg_95_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_98_1 then
							if arg_95_1.isInRecall_ then
								local var_98_4 = Mathf.Lerp(iter_98_1.color.r, arg_95_1.hightColor1.r, var_98_3)
								local var_98_5 = Mathf.Lerp(iter_98_1.color.g, arg_95_1.hightColor1.g, var_98_3)
								local var_98_6 = Mathf.Lerp(iter_98_1.color.b, arg_95_1.hightColor1.b, var_98_3)

								iter_98_1.color = Color.New(var_98_4, var_98_5, var_98_6)
							else
								local var_98_7 = Mathf.Lerp(iter_98_1.color.r, 1, var_98_3)

								iter_98_1.color = Color.New(var_98_7, var_98_7, var_98_7)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.actorSpriteComps10155 then
				for iter_98_2, iter_98_3 in pairs(arg_95_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_98_3 then
						if arg_95_1.isInRecall_ then
							iter_98_3.color = arg_95_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_98_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_95_1.var_.actorSpriteComps10155 = nil
			end

			local var_98_8 = arg_95_1.actors_["10155"].transform
			local var_98_9 = 0

			if var_98_9 < arg_95_1.time_ and arg_95_1.time_ <= var_98_9 + arg_98_0 then
				arg_95_1.var_.moveOldPos10155 = var_98_8.localPosition
				var_98_8.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("10155", 2)

				local var_98_10 = var_98_8.childCount

				for iter_98_4 = 0, var_98_10 - 1 do
					local var_98_11 = var_98_8:GetChild(iter_98_4)

					if var_98_11.name == "" or not string.find(var_98_11.name, "split") then
						var_98_11.gameObject:SetActive(true)
					else
						var_98_11.gameObject:SetActive(false)
					end
				end
			end

			local var_98_12 = 0.001

			if var_98_9 <= arg_95_1.time_ and arg_95_1.time_ < var_98_9 + var_98_12 then
				local var_98_13 = (arg_95_1.time_ - var_98_9) / var_98_12
				local var_98_14 = Vector3.New(-410, -390, -250)

				var_98_8.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10155, var_98_14, var_98_13)
			end

			if arg_95_1.time_ >= var_98_9 + var_98_12 and arg_95_1.time_ < var_98_9 + var_98_12 + arg_98_0 then
				var_98_8.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_98_15 = 0
			local var_98_16 = 0.225

			if var_98_15 < arg_95_1.time_ and arg_95_1.time_ <= var_98_15 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_17 = arg_95_1:FormatText(StoryNameCfg[1391].name)

				arg_95_1.leftNameTxt_.text = var_98_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_18 = arg_95_1:GetWordFromCfg(424051023)
				local var_98_19 = arg_95_1:FormatText(var_98_18.content)

				arg_95_1.text_.text = var_98_19

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_20 = 9
				local var_98_21 = utf8.len(var_98_19)
				local var_98_22 = var_98_20 <= 0 and var_98_16 or var_98_16 * (var_98_21 / var_98_20)

				if var_98_22 > 0 and var_98_16 < var_98_22 then
					arg_95_1.talkMaxDuration = var_98_22

					if var_98_22 + var_98_15 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_22 + var_98_15
					end
				end

				arg_95_1.text_.text = var_98_19
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051023", "story_v_out_424051.awb") ~= 0 then
					local var_98_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051023", "story_v_out_424051.awb") / 1000

					if var_98_23 + var_98_15 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_23 + var_98_15
					end

					if var_98_18.prefab_name ~= "" and arg_95_1.actors_[var_98_18.prefab_name] ~= nil then
						local var_98_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_18.prefab_name].transform, "story_v_out_424051", "424051023", "story_v_out_424051.awb")

						arg_95_1:RecordAudio("424051023", var_98_24)
						arg_95_1:RecordAudio("424051023", var_98_24)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_424051", "424051023", "story_v_out_424051.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_424051", "424051023", "story_v_out_424051.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_25 = math.max(var_98_16, arg_95_1.talkMaxDuration)

			if var_98_15 <= arg_95_1.time_ and arg_95_1.time_ < var_98_15 + var_98_25 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_15) / var_98_25

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_15 + var_98_25 and arg_95_1.time_ < var_98_15 + var_98_25 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
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

		arg_95_1:InitPlayNodeList()
	end,
	Play424051024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 424051024
		arg_99_1.duration_ = 4.3

		local var_99_0 = {
			zh = 3.266,
			ja = 4.3
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
				arg_99_0:Play424051025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["10155"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.actorSpriteComps10155 == nil then
				arg_99_1.var_.actorSpriteComps10155 = var_102_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_2 = 0.2

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.actorSpriteComps10155 then
					for iter_102_0, iter_102_1 in pairs(arg_99_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_102_1 then
							if arg_99_1.isInRecall_ then
								local var_102_4 = Mathf.Lerp(iter_102_1.color.r, arg_99_1.hightColor2.r, var_102_3)
								local var_102_5 = Mathf.Lerp(iter_102_1.color.g, arg_99_1.hightColor2.g, var_102_3)
								local var_102_6 = Mathf.Lerp(iter_102_1.color.b, arg_99_1.hightColor2.b, var_102_3)

								iter_102_1.color = Color.New(var_102_4, var_102_5, var_102_6)
							else
								local var_102_7 = Mathf.Lerp(iter_102_1.color.r, 0.5, var_102_3)

								iter_102_1.color = Color.New(var_102_7, var_102_7, var_102_7)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.actorSpriteComps10155 then
				for iter_102_2, iter_102_3 in pairs(arg_99_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_102_3 then
						if arg_99_1.isInRecall_ then
							iter_102_3.color = arg_99_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_102_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_99_1.var_.actorSpriteComps10155 = nil
			end

			local var_102_8 = 0
			local var_102_9 = 0.375

			if var_102_8 < arg_99_1.time_ and arg_99_1.time_ <= var_102_8 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_10 = arg_99_1:FormatText(StoryNameCfg[177].name)

				arg_99_1.leftNameTxt_.text = var_102_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_11 = arg_99_1:GetWordFromCfg(424051024)
				local var_102_12 = arg_99_1:FormatText(var_102_11.content)

				arg_99_1.text_.text = var_102_12

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_13 = 15
				local var_102_14 = utf8.len(var_102_12)
				local var_102_15 = var_102_13 <= 0 and var_102_9 or var_102_9 * (var_102_14 / var_102_13)

				if var_102_15 > 0 and var_102_9 < var_102_15 then
					arg_99_1.talkMaxDuration = var_102_15

					if var_102_15 + var_102_8 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_15 + var_102_8
					end
				end

				arg_99_1.text_.text = var_102_12
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051024", "story_v_out_424051.awb") ~= 0 then
					local var_102_16 = manager.audio:GetVoiceLength("story_v_out_424051", "424051024", "story_v_out_424051.awb") / 1000

					if var_102_16 + var_102_8 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_16 + var_102_8
					end

					if var_102_11.prefab_name ~= "" and arg_99_1.actors_[var_102_11.prefab_name] ~= nil then
						local var_102_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_11.prefab_name].transform, "story_v_out_424051", "424051024", "story_v_out_424051.awb")

						arg_99_1:RecordAudio("424051024", var_102_17)
						arg_99_1:RecordAudio("424051024", var_102_17)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_424051", "424051024", "story_v_out_424051.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_424051", "424051024", "story_v_out_424051.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_18 = math.max(var_102_9, arg_99_1.talkMaxDuration)

			if var_102_8 <= arg_99_1.time_ and arg_99_1.time_ < var_102_8 + var_102_18 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_8) / var_102_18

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_8 + var_102_18 and arg_99_1.time_ < var_102_8 + var_102_18 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play424051025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 424051025
		arg_103_1.duration_ = 3.6

		local var_103_0 = {
			zh = 3.2,
			ja = 3.6
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
				arg_103_0:Play424051026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["10153"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.actorSpriteComps10153 == nil then
				arg_103_1.var_.actorSpriteComps10153 = var_106_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_2 = 0.2

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.actorSpriteComps10153 then
					for iter_106_0, iter_106_1 in pairs(arg_103_1.var_.actorSpriteComps10153:ToTable()) do
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

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.actorSpriteComps10153 then
				for iter_106_2, iter_106_3 in pairs(arg_103_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_106_3 then
						if arg_103_1.isInRecall_ then
							iter_106_3.color = arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_106_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_103_1.var_.actorSpriteComps10153 = nil
			end

			local var_106_8 = 0
			local var_106_9 = 0.45

			if var_106_8 < arg_103_1.time_ and arg_103_1.time_ <= var_106_8 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_10 = arg_103_1:FormatText(StoryNameCfg[1387].name)

				arg_103_1.leftNameTxt_.text = var_106_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_11 = arg_103_1:GetWordFromCfg(424051025)
				local var_106_12 = arg_103_1:FormatText(var_106_11.content)

				arg_103_1.text_.text = var_106_12

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_13 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051025", "story_v_out_424051.awb") ~= 0 then
					local var_106_16 = manager.audio:GetVoiceLength("story_v_out_424051", "424051025", "story_v_out_424051.awb") / 1000

					if var_106_16 + var_106_8 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_16 + var_106_8
					end

					if var_106_11.prefab_name ~= "" and arg_103_1.actors_[var_106_11.prefab_name] ~= nil then
						local var_106_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_11.prefab_name].transform, "story_v_out_424051", "424051025", "story_v_out_424051.awb")

						arg_103_1:RecordAudio("424051025", var_106_17)
						arg_103_1:RecordAudio("424051025", var_106_17)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_424051", "424051025", "story_v_out_424051.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_424051", "424051025", "story_v_out_424051.awb")
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
	Play424051026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 424051026
		arg_107_1.duration_ = 12.13

		local var_107_0 = {
			zh = 10.3,
			ja = 12.133
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
				arg_107_0:Play424051027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10155"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps10155 == nil then
				arg_107_1.var_.actorSpriteComps10155 = var_110_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_2 = 0.2

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.actorSpriteComps10155 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps10155 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_110_3 then
						if arg_107_1.isInRecall_ then
							iter_110_3.color = arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_110_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps10155 = nil
			end

			local var_110_8 = arg_107_1.actors_["10153"]
			local var_110_9 = 0

			if var_110_9 < arg_107_1.time_ and arg_107_1.time_ <= var_110_9 + arg_110_0 and not isNil(var_110_8) and arg_107_1.var_.actorSpriteComps10153 == nil then
				arg_107_1.var_.actorSpriteComps10153 = var_110_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_10 = 0.2

			if var_110_9 <= arg_107_1.time_ and arg_107_1.time_ < var_110_9 + var_110_10 and not isNil(var_110_8) then
				local var_110_11 = (arg_107_1.time_ - var_110_9) / var_110_10

				if arg_107_1.var_.actorSpriteComps10153 then
					for iter_110_4, iter_110_5 in pairs(arg_107_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_110_5 then
							if arg_107_1.isInRecall_ then
								local var_110_12 = Mathf.Lerp(iter_110_5.color.r, arg_107_1.hightColor2.r, var_110_11)
								local var_110_13 = Mathf.Lerp(iter_110_5.color.g, arg_107_1.hightColor2.g, var_110_11)
								local var_110_14 = Mathf.Lerp(iter_110_5.color.b, arg_107_1.hightColor2.b, var_110_11)

								iter_110_5.color = Color.New(var_110_12, var_110_13, var_110_14)
							else
								local var_110_15 = Mathf.Lerp(iter_110_5.color.r, 0.5, var_110_11)

								iter_110_5.color = Color.New(var_110_15, var_110_15, var_110_15)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= var_110_9 + var_110_10 and arg_107_1.time_ < var_110_9 + var_110_10 + arg_110_0 and not isNil(var_110_8) and arg_107_1.var_.actorSpriteComps10153 then
				for iter_110_6, iter_110_7 in pairs(arg_107_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_110_7 then
						if arg_107_1.isInRecall_ then
							iter_110_7.color = arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_110_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps10153 = nil
			end

			local var_110_16 = arg_107_1.actors_["10155"].transform
			local var_110_17 = 0

			if var_110_17 < arg_107_1.time_ and arg_107_1.time_ <= var_110_17 + arg_110_0 then
				arg_107_1.var_.moveOldPos10155 = var_110_16.localPosition
				var_110_16.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("10155", 2)

				local var_110_18 = var_110_16.childCount

				for iter_110_8 = 0, var_110_18 - 1 do
					local var_110_19 = var_110_16:GetChild(iter_110_8)

					if var_110_19.name == "" or not string.find(var_110_19.name, "split") then
						var_110_19.gameObject:SetActive(true)
					else
						var_110_19.gameObject:SetActive(false)
					end
				end
			end

			local var_110_20 = 0.001

			if var_110_17 <= arg_107_1.time_ and arg_107_1.time_ < var_110_17 + var_110_20 then
				local var_110_21 = (arg_107_1.time_ - var_110_17) / var_110_20
				local var_110_22 = Vector3.New(-410, -390, -250)

				var_110_16.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10155, var_110_22, var_110_21)
			end

			if arg_107_1.time_ >= var_110_17 + var_110_20 and arg_107_1.time_ < var_110_17 + var_110_20 + arg_110_0 then
				var_110_16.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_110_23 = 0
			local var_110_24 = 1.075

			if var_110_23 < arg_107_1.time_ and arg_107_1.time_ <= var_110_23 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_25 = arg_107_1:FormatText(StoryNameCfg[1391].name)

				arg_107_1.leftNameTxt_.text = var_110_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_26 = arg_107_1:GetWordFromCfg(424051026)
				local var_110_27 = arg_107_1:FormatText(var_110_26.content)

				arg_107_1.text_.text = var_110_27

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_28 = 43
				local var_110_29 = utf8.len(var_110_27)
				local var_110_30 = var_110_28 <= 0 and var_110_24 or var_110_24 * (var_110_29 / var_110_28)

				if var_110_30 > 0 and var_110_24 < var_110_30 then
					arg_107_1.talkMaxDuration = var_110_30

					if var_110_30 + var_110_23 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_30 + var_110_23
					end
				end

				arg_107_1.text_.text = var_110_27
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051026", "story_v_out_424051.awb") ~= 0 then
					local var_110_31 = manager.audio:GetVoiceLength("story_v_out_424051", "424051026", "story_v_out_424051.awb") / 1000

					if var_110_31 + var_110_23 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_31 + var_110_23
					end

					if var_110_26.prefab_name ~= "" and arg_107_1.actors_[var_110_26.prefab_name] ~= nil then
						local var_110_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_26.prefab_name].transform, "story_v_out_424051", "424051026", "story_v_out_424051.awb")

						arg_107_1:RecordAudio("424051026", var_110_32)
						arg_107_1:RecordAudio("424051026", var_110_32)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_424051", "424051026", "story_v_out_424051.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_424051", "424051026", "story_v_out_424051.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_33 = math.max(var_110_24, arg_107_1.talkMaxDuration)

			if var_110_23 <= arg_107_1.time_ and arg_107_1.time_ < var_110_23 + var_110_33 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_23) / var_110_33

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_23 + var_110_33 and arg_107_1.time_ < var_110_23 + var_110_33 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
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

		arg_107_1:InitPlayNodeList()
	end,
	Play424051027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 424051027
		arg_111_1.duration_ = 1.63

		local var_111_0 = {
			zh = 1.1,
			ja = 1.633
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
				arg_111_0:Play424051028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1094"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.actorSpriteComps1094 == nil then
				arg_111_1.var_.actorSpriteComps1094 = var_114_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_2 = 0.2

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.actorSpriteComps1094 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.actorSpriteComps1094 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_114_3 then
						if arg_111_1.isInRecall_ then
							iter_114_3.color = arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_114_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps1094 = nil
			end

			local var_114_8 = arg_111_1.actors_["10155"]
			local var_114_9 = 0

			if var_114_9 < arg_111_1.time_ and arg_111_1.time_ <= var_114_9 + arg_114_0 and not isNil(var_114_8) and arg_111_1.var_.actorSpriteComps10155 == nil then
				arg_111_1.var_.actorSpriteComps10155 = var_114_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_10 = 0.2

			if var_114_9 <= arg_111_1.time_ and arg_111_1.time_ < var_114_9 + var_114_10 and not isNil(var_114_8) then
				local var_114_11 = (arg_111_1.time_ - var_114_9) / var_114_10

				if arg_111_1.var_.actorSpriteComps10155 then
					for iter_114_4, iter_114_5 in pairs(arg_111_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_111_1.time_ >= var_114_9 + var_114_10 and arg_111_1.time_ < var_114_9 + var_114_10 + arg_114_0 and not isNil(var_114_8) and arg_111_1.var_.actorSpriteComps10155 then
				for iter_114_6, iter_114_7 in pairs(arg_111_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_114_7 then
						if arg_111_1.isInRecall_ then
							iter_114_7.color = arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_114_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps10155 = nil
			end

			local var_114_16 = arg_111_1.actors_["1094"].transform
			local var_114_17 = 0

			if var_114_17 < arg_111_1.time_ and arg_111_1.time_ <= var_114_17 + arg_114_0 then
				arg_111_1.var_.moveOldPos1094 = var_114_16.localPosition
				var_114_16.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("1094", 4)

				local var_114_18 = var_114_16.childCount

				for iter_114_8 = 0, var_114_18 - 1 do
					local var_114_19 = var_114_16:GetChild(iter_114_8)

					if var_114_19.name == "split_5" or not string.find(var_114_19.name, "split") then
						var_114_19.gameObject:SetActive(true)
					else
						var_114_19.gameObject:SetActive(false)
					end
				end
			end

			local var_114_20 = 0.001

			if var_114_17 <= arg_111_1.time_ and arg_111_1.time_ < var_114_17 + var_114_20 then
				local var_114_21 = (arg_111_1.time_ - var_114_17) / var_114_20
				local var_114_22 = Vector3.New(470, -335, -230)

				var_114_16.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1094, var_114_22, var_114_21)
			end

			if arg_111_1.time_ >= var_114_17 + var_114_20 and arg_111_1.time_ < var_114_17 + var_114_20 + arg_114_0 then
				var_114_16.localPosition = Vector3.New(470, -335, -230)
			end

			local var_114_23 = arg_111_1.actors_["10153"].transform
			local var_114_24 = 0

			if var_114_24 < arg_111_1.time_ and arg_111_1.time_ <= var_114_24 + arg_114_0 then
				arg_111_1.var_.moveOldPos10153 = var_114_23.localPosition
				var_114_23.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("10153", 7)

				local var_114_25 = var_114_23.childCount

				for iter_114_9 = 0, var_114_25 - 1 do
					local var_114_26 = var_114_23:GetChild(iter_114_9)

					if var_114_26.name == "" or not string.find(var_114_26.name, "split") then
						var_114_26.gameObject:SetActive(true)
					else
						var_114_26.gameObject:SetActive(false)
					end
				end
			end

			local var_114_27 = 0.001

			if var_114_24 <= arg_111_1.time_ and arg_111_1.time_ < var_114_24 + var_114_27 then
				local var_114_28 = (arg_111_1.time_ - var_114_24) / var_114_27
				local var_114_29 = Vector3.New(0, -2000, 0)

				var_114_23.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10153, var_114_29, var_114_28)
			end

			if arg_111_1.time_ >= var_114_24 + var_114_27 and arg_111_1.time_ < var_114_24 + var_114_27 + arg_114_0 then
				var_114_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_114_30 = 0
			local var_114_31 = 0.075

			if var_114_30 < arg_111_1.time_ and arg_111_1.time_ <= var_114_30 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_32 = arg_111_1:FormatText(StoryNameCfg[181].name)

				arg_111_1.leftNameTxt_.text = var_114_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_33 = arg_111_1:GetWordFromCfg(424051027)
				local var_114_34 = arg_111_1:FormatText(var_114_33.content)

				arg_111_1.text_.text = var_114_34

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_35 = 3
				local var_114_36 = utf8.len(var_114_34)
				local var_114_37 = var_114_35 <= 0 and var_114_31 or var_114_31 * (var_114_36 / var_114_35)

				if var_114_37 > 0 and var_114_31 < var_114_37 then
					arg_111_1.talkMaxDuration = var_114_37

					if var_114_37 + var_114_30 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_37 + var_114_30
					end
				end

				arg_111_1.text_.text = var_114_34
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051027", "story_v_out_424051.awb") ~= 0 then
					local var_114_38 = manager.audio:GetVoiceLength("story_v_out_424051", "424051027", "story_v_out_424051.awb") / 1000

					if var_114_38 + var_114_30 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_38 + var_114_30
					end

					if var_114_33.prefab_name ~= "" and arg_111_1.actors_[var_114_33.prefab_name] ~= nil then
						local var_114_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_33.prefab_name].transform, "story_v_out_424051", "424051027", "story_v_out_424051.awb")

						arg_111_1:RecordAudio("424051027", var_114_39)
						arg_111_1:RecordAudio("424051027", var_114_39)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_424051", "424051027", "story_v_out_424051.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_424051", "424051027", "story_v_out_424051.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_40 = math.max(var_114_31, arg_111_1.talkMaxDuration)

			if var_114_30 <= arg_111_1.time_ and arg_111_1.time_ < var_114_30 + var_114_40 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_30) / var_114_40

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_30 + var_114_40 and arg_111_1.time_ < var_114_30 + var_114_40 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
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
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play424051028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 424051028
		arg_115_1.duration_ = 7.2

		local var_115_0 = {
			zh = 7.1,
			ja = 7.2
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
				arg_115_0:Play424051029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["10154"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.actorSpriteComps10154 == nil then
				arg_115_1.var_.actorSpriteComps10154 = var_118_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_2 = 0.2

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.actorSpriteComps10154 then
					for iter_118_0, iter_118_1 in pairs(arg_115_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.actorSpriteComps10154 then
				for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_118_3 then
						if arg_115_1.isInRecall_ then
							iter_118_3.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_118_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps10154 = nil
			end

			local var_118_8 = arg_115_1.actors_["1094"]
			local var_118_9 = 0

			if var_118_9 < arg_115_1.time_ and arg_115_1.time_ <= var_118_9 + arg_118_0 and not isNil(var_118_8) and arg_115_1.var_.actorSpriteComps1094 == nil then
				arg_115_1.var_.actorSpriteComps1094 = var_118_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_10 = 0.2

			if var_118_9 <= arg_115_1.time_ and arg_115_1.time_ < var_118_9 + var_118_10 and not isNil(var_118_8) then
				local var_118_11 = (arg_115_1.time_ - var_118_9) / var_118_10

				if arg_115_1.var_.actorSpriteComps1094 then
					for iter_118_4, iter_118_5 in pairs(arg_115_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_118_5 then
							if arg_115_1.isInRecall_ then
								local var_118_12 = Mathf.Lerp(iter_118_5.color.r, arg_115_1.hightColor2.r, var_118_11)
								local var_118_13 = Mathf.Lerp(iter_118_5.color.g, arg_115_1.hightColor2.g, var_118_11)
								local var_118_14 = Mathf.Lerp(iter_118_5.color.b, arg_115_1.hightColor2.b, var_118_11)

								iter_118_5.color = Color.New(var_118_12, var_118_13, var_118_14)
							else
								local var_118_15 = Mathf.Lerp(iter_118_5.color.r, 0.5, var_118_11)

								iter_118_5.color = Color.New(var_118_15, var_118_15, var_118_15)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_9 + var_118_10 and arg_115_1.time_ < var_118_9 + var_118_10 + arg_118_0 and not isNil(var_118_8) and arg_115_1.var_.actorSpriteComps1094 then
				for iter_118_6, iter_118_7 in pairs(arg_115_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_118_7 then
						if arg_115_1.isInRecall_ then
							iter_118_7.color = arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_118_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps1094 = nil
			end

			local var_118_16 = arg_115_1.actors_["10154"].transform
			local var_118_17 = 0

			if var_118_17 < arg_115_1.time_ and arg_115_1.time_ <= var_118_17 + arg_118_0 then
				arg_115_1.var_.moveOldPos10154 = var_118_16.localPosition
				var_118_16.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10154", 2)

				local var_118_18 = var_118_16.childCount

				for iter_118_8 = 0, var_118_18 - 1 do
					local var_118_19 = var_118_16:GetChild(iter_118_8)

					if var_118_19.name == "" or not string.find(var_118_19.name, "split") then
						var_118_19.gameObject:SetActive(true)
					else
						var_118_19.gameObject:SetActive(false)
					end
				end
			end

			local var_118_20 = 0.001

			if var_118_17 <= arg_115_1.time_ and arg_115_1.time_ < var_118_17 + var_118_20 then
				local var_118_21 = (arg_115_1.time_ - var_118_17) / var_118_20
				local var_118_22 = Vector3.New(-375, -338, -538)

				var_118_16.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10154, var_118_22, var_118_21)
			end

			if arg_115_1.time_ >= var_118_17 + var_118_20 and arg_115_1.time_ < var_118_17 + var_118_20 + arg_118_0 then
				var_118_16.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_118_23 = arg_115_1.actors_["10155"].transform
			local var_118_24 = 0

			if var_118_24 < arg_115_1.time_ and arg_115_1.time_ <= var_118_24 + arg_118_0 then
				arg_115_1.var_.moveOldPos10155 = var_118_23.localPosition
				var_118_23.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10155", 7)

				local var_118_25 = var_118_23.childCount

				for iter_118_9 = 0, var_118_25 - 1 do
					local var_118_26 = var_118_23:GetChild(iter_118_9)

					if var_118_26.name == "" or not string.find(var_118_26.name, "split") then
						var_118_26.gameObject:SetActive(true)
					else
						var_118_26.gameObject:SetActive(false)
					end
				end
			end

			local var_118_27 = 0.001

			if var_118_24 <= arg_115_1.time_ and arg_115_1.time_ < var_118_24 + var_118_27 then
				local var_118_28 = (arg_115_1.time_ - var_118_24) / var_118_27
				local var_118_29 = Vector3.New(0, -2000, 0)

				var_118_23.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10155, var_118_29, var_118_28)
			end

			if arg_115_1.time_ >= var_118_24 + var_118_27 and arg_115_1.time_ < var_118_24 + var_118_27 + arg_118_0 then
				var_118_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_118_30 = 0
			local var_118_31 = 0.975

			if var_118_30 < arg_115_1.time_ and arg_115_1.time_ <= var_118_30 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_32 = arg_115_1:FormatText(StoryNameCfg[1392].name)

				arg_115_1.leftNameTxt_.text = var_118_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_33 = arg_115_1:GetWordFromCfg(424051028)
				local var_118_34 = arg_115_1:FormatText(var_118_33.content)

				arg_115_1.text_.text = var_118_34

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_35 = 37
				local var_118_36 = utf8.len(var_118_34)
				local var_118_37 = var_118_35 <= 0 and var_118_31 or var_118_31 * (var_118_36 / var_118_35)

				if var_118_37 > 0 and var_118_31 < var_118_37 then
					arg_115_1.talkMaxDuration = var_118_37

					if var_118_37 + var_118_30 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_37 + var_118_30
					end
				end

				arg_115_1.text_.text = var_118_34
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051028", "story_v_out_424051.awb") ~= 0 then
					local var_118_38 = manager.audio:GetVoiceLength("story_v_out_424051", "424051028", "story_v_out_424051.awb") / 1000

					if var_118_38 + var_118_30 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_38 + var_118_30
					end

					if var_118_33.prefab_name ~= "" and arg_115_1.actors_[var_118_33.prefab_name] ~= nil then
						local var_118_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_33.prefab_name].transform, "story_v_out_424051", "424051028", "story_v_out_424051.awb")

						arg_115_1:RecordAudio("424051028", var_118_39)
						arg_115_1:RecordAudio("424051028", var_118_39)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_424051", "424051028", "story_v_out_424051.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_424051", "424051028", "story_v_out_424051.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_40 = math.max(var_118_31, arg_115_1.talkMaxDuration)

			if var_118_30 <= arg_115_1.time_ and arg_115_1.time_ < var_118_30 + var_118_40 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_30) / var_118_40

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_30 + var_118_40 and arg_115_1.time_ < var_118_30 + var_118_40 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
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

		arg_115_1:InitPlayNodeList()
	end,
	Play424051029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 424051029
		arg_119_1.duration_ = 5.6

		local var_119_0 = {
			zh = 3.633,
			ja = 5.6
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
				arg_119_0:Play424051030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10154"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.actorSpriteComps10154 == nil then
				arg_119_1.var_.actorSpriteComps10154 = var_122_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_2 = 0.2

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.actorSpriteComps10154 then
					for iter_122_0, iter_122_1 in pairs(arg_119_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.actorSpriteComps10154 then
				for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_122_3 then
						if arg_119_1.isInRecall_ then
							iter_122_3.color = arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_122_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps10154 = nil
			end

			local var_122_8 = 0
			local var_122_9 = 0.425

			if var_122_8 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_10 = arg_119_1:FormatText(StoryNameCfg[177].name)

				arg_119_1.leftNameTxt_.text = var_122_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_11 = arg_119_1:GetWordFromCfg(424051029)
				local var_122_12 = arg_119_1:FormatText(var_122_11.content)

				arg_119_1.text_.text = var_122_12

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_13 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051029", "story_v_out_424051.awb") ~= 0 then
					local var_122_16 = manager.audio:GetVoiceLength("story_v_out_424051", "424051029", "story_v_out_424051.awb") / 1000

					if var_122_16 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_16 + var_122_8
					end

					if var_122_11.prefab_name ~= "" and arg_119_1.actors_[var_122_11.prefab_name] ~= nil then
						local var_122_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_11.prefab_name].transform, "story_v_out_424051", "424051029", "story_v_out_424051.awb")

						arg_119_1:RecordAudio("424051029", var_122_17)
						arg_119_1:RecordAudio("424051029", var_122_17)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_424051", "424051029", "story_v_out_424051.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_424051", "424051029", "story_v_out_424051.awb")
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
	Play424051030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 424051030
		arg_123_1.duration_ = 6.8

		local var_123_0 = {
			zh = 5.133,
			ja = 6.8
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
				arg_123_0:Play424051031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10154"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps10154 == nil then
				arg_123_1.var_.actorSpriteComps10154 = var_126_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_2 = 0.2

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.actorSpriteComps10154 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_126_1 then
							if arg_123_1.isInRecall_ then
								local var_126_4 = Mathf.Lerp(iter_126_1.color.r, arg_123_1.hightColor1.r, var_126_3)
								local var_126_5 = Mathf.Lerp(iter_126_1.color.g, arg_123_1.hightColor1.g, var_126_3)
								local var_126_6 = Mathf.Lerp(iter_126_1.color.b, arg_123_1.hightColor1.b, var_126_3)

								iter_126_1.color = Color.New(var_126_4, var_126_5, var_126_6)
							else
								local var_126_7 = Mathf.Lerp(iter_126_1.color.r, 1, var_126_3)

								iter_126_1.color = Color.New(var_126_7, var_126_7, var_126_7)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps10154 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_126_3 then
						if arg_123_1.isInRecall_ then
							iter_126_3.color = arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_126_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps10154 = nil
			end

			local var_126_8 = arg_123_1.actors_["10154"].transform
			local var_126_9 = 0

			if var_126_9 < arg_123_1.time_ and arg_123_1.time_ <= var_126_9 + arg_126_0 then
				arg_123_1.var_.moveOldPos10154 = var_126_8.localPosition
				var_126_8.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10154", 2)

				local var_126_10 = var_126_8.childCount

				for iter_126_4 = 0, var_126_10 - 1 do
					local var_126_11 = var_126_8:GetChild(iter_126_4)

					if var_126_11.name == "" or not string.find(var_126_11.name, "split") then
						var_126_11.gameObject:SetActive(true)
					else
						var_126_11.gameObject:SetActive(false)
					end
				end
			end

			local var_126_12 = 0.001

			if var_126_9 <= arg_123_1.time_ and arg_123_1.time_ < var_126_9 + var_126_12 then
				local var_126_13 = (arg_123_1.time_ - var_126_9) / var_126_12
				local var_126_14 = Vector3.New(-375, -338, -538)

				var_126_8.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10154, var_126_14, var_126_13)
			end

			if arg_123_1.time_ >= var_126_9 + var_126_12 and arg_123_1.time_ < var_126_9 + var_126_12 + arg_126_0 then
				var_126_8.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_126_15 = 0
			local var_126_16 = 0.775

			if var_126_15 < arg_123_1.time_ and arg_123_1.time_ <= var_126_15 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_17 = arg_123_1:FormatText(StoryNameCfg[1392].name)

				arg_123_1.leftNameTxt_.text = var_126_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_18 = arg_123_1:GetWordFromCfg(424051030)
				local var_126_19 = arg_123_1:FormatText(var_126_18.content)

				arg_123_1.text_.text = var_126_19

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_20 = 31
				local var_126_21 = utf8.len(var_126_19)
				local var_126_22 = var_126_20 <= 0 and var_126_16 or var_126_16 * (var_126_21 / var_126_20)

				if var_126_22 > 0 and var_126_16 < var_126_22 then
					arg_123_1.talkMaxDuration = var_126_22

					if var_126_22 + var_126_15 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_22 + var_126_15
					end
				end

				arg_123_1.text_.text = var_126_19
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051030", "story_v_out_424051.awb") ~= 0 then
					local var_126_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051030", "story_v_out_424051.awb") / 1000

					if var_126_23 + var_126_15 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_23 + var_126_15
					end

					if var_126_18.prefab_name ~= "" and arg_123_1.actors_[var_126_18.prefab_name] ~= nil then
						local var_126_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_18.prefab_name].transform, "story_v_out_424051", "424051030", "story_v_out_424051.awb")

						arg_123_1:RecordAudio("424051030", var_126_24)
						arg_123_1:RecordAudio("424051030", var_126_24)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_424051", "424051030", "story_v_out_424051.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_424051", "424051030", "story_v_out_424051.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_25 = math.max(var_126_16, arg_123_1.talkMaxDuration)

			if var_126_15 <= arg_123_1.time_ and arg_123_1.time_ < var_126_15 + var_126_25 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_15) / var_126_25

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_15 + var_126_25 and arg_123_1.time_ < var_126_15 + var_126_25 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
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
	Play424051031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 424051031
		arg_127_1.duration_ = 6.63

		local var_127_0 = {
			zh = 3.133,
			ja = 6.633
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
				arg_127_0:Play424051032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10155"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps10155 == nil then
				arg_127_1.var_.actorSpriteComps10155 = var_130_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_2 = 0.2

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.actorSpriteComps10155 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps10155 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_130_3 then
						if arg_127_1.isInRecall_ then
							iter_130_3.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_130_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps10155 = nil
			end

			local var_130_8 = arg_127_1.actors_["10154"]
			local var_130_9 = 0

			if var_130_9 < arg_127_1.time_ and arg_127_1.time_ <= var_130_9 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.actorSpriteComps10154 == nil then
				arg_127_1.var_.actorSpriteComps10154 = var_130_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_10 = 0.2

			if var_130_9 <= arg_127_1.time_ and arg_127_1.time_ < var_130_9 + var_130_10 and not isNil(var_130_8) then
				local var_130_11 = (arg_127_1.time_ - var_130_9) / var_130_10

				if arg_127_1.var_.actorSpriteComps10154 then
					for iter_130_4, iter_130_5 in pairs(arg_127_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_130_5 then
							if arg_127_1.isInRecall_ then
								local var_130_12 = Mathf.Lerp(iter_130_5.color.r, arg_127_1.hightColor2.r, var_130_11)
								local var_130_13 = Mathf.Lerp(iter_130_5.color.g, arg_127_1.hightColor2.g, var_130_11)
								local var_130_14 = Mathf.Lerp(iter_130_5.color.b, arg_127_1.hightColor2.b, var_130_11)

								iter_130_5.color = Color.New(var_130_12, var_130_13, var_130_14)
							else
								local var_130_15 = Mathf.Lerp(iter_130_5.color.r, 0.5, var_130_11)

								iter_130_5.color = Color.New(var_130_15, var_130_15, var_130_15)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_9 + var_130_10 and arg_127_1.time_ < var_130_9 + var_130_10 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.actorSpriteComps10154 then
				for iter_130_6, iter_130_7 in pairs(arg_127_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_130_7 then
						if arg_127_1.isInRecall_ then
							iter_130_7.color = arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_130_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps10154 = nil
			end

			local var_130_16 = arg_127_1.actors_["10155"].transform
			local var_130_17 = 0

			if var_130_17 < arg_127_1.time_ and arg_127_1.time_ <= var_130_17 + arg_130_0 then
				arg_127_1.var_.moveOldPos10155 = var_130_16.localPosition
				var_130_16.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10155", 4)

				local var_130_18 = var_130_16.childCount

				for iter_130_8 = 0, var_130_18 - 1 do
					local var_130_19 = var_130_16:GetChild(iter_130_8)

					if var_130_19.name == "split_3" then
						var_130_19:SetAsLastSibling()
						var_130_19.gameObject:SetActive(true)

						arg_127_1.var_.actorSpriteSplit10155 = var_130_19.gameObject:GetComponent(typeof(Image))

						arg_127_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_130_20 = 0.001

			if var_130_17 <= arg_127_1.time_ and arg_127_1.time_ < var_130_17 + var_130_20 then
				local var_130_21 = (arg_127_1.time_ - var_130_17) / var_130_20
				local var_130_22 = Vector3.New(440, -390, -250)

				var_130_16.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10155, var_130_22, var_130_21)

				if arg_127_1.var_.actorSpriteSplit10155 ~= nil then
					arg_127_1.var_.actorSpriteSplit10155:SetAlpha(var_130_21)
				end
			end

			if arg_127_1.time_ >= var_130_17 + var_130_20 and arg_127_1.time_ < var_130_17 + var_130_20 + arg_130_0 then
				var_130_16.localPosition = Vector3.New(440, -390, -250)

				if arg_127_1.var_.actorSpriteSplit10155 ~= nil then
					arg_127_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_130_23 = arg_127_1.actors_["1094"].transform
			local var_130_24 = 0

			if var_130_24 < arg_127_1.time_ and arg_127_1.time_ <= var_130_24 + arg_130_0 then
				arg_127_1.var_.moveOldPos1094 = var_130_23.localPosition
				var_130_23.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("1094", 7)

				local var_130_25 = var_130_23.childCount

				for iter_130_9 = 0, var_130_25 - 1 do
					local var_130_26 = var_130_23:GetChild(iter_130_9)

					if var_130_26.name == "" or not string.find(var_130_26.name, "split") then
						var_130_26.gameObject:SetActive(true)
					else
						var_130_26.gameObject:SetActive(false)
					end
				end
			end

			local var_130_27 = 0.001

			if var_130_24 <= arg_127_1.time_ and arg_127_1.time_ < var_130_24 + var_130_27 then
				local var_130_28 = (arg_127_1.time_ - var_130_24) / var_130_27
				local var_130_29 = Vector3.New(0, -2000, 0)

				var_130_23.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1094, var_130_29, var_130_28)
			end

			if arg_127_1.time_ >= var_130_24 + var_130_27 and arg_127_1.time_ < var_130_24 + var_130_27 + arg_130_0 then
				var_130_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_130_30 = 0
			local var_130_31 = 0.45

			if var_130_30 < arg_127_1.time_ and arg_127_1.time_ <= var_130_30 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_32 = arg_127_1:FormatText(StoryNameCfg[1391].name)

				arg_127_1.leftNameTxt_.text = var_130_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_33 = arg_127_1:GetWordFromCfg(424051031)
				local var_130_34 = arg_127_1:FormatText(var_130_33.content)

				arg_127_1.text_.text = var_130_34

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_35 = 18
				local var_130_36 = utf8.len(var_130_34)
				local var_130_37 = var_130_35 <= 0 and var_130_31 or var_130_31 * (var_130_36 / var_130_35)

				if var_130_37 > 0 and var_130_31 < var_130_37 then
					arg_127_1.talkMaxDuration = var_130_37

					if var_130_37 + var_130_30 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_37 + var_130_30
					end
				end

				arg_127_1.text_.text = var_130_34
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051031", "story_v_out_424051.awb") ~= 0 then
					local var_130_38 = manager.audio:GetVoiceLength("story_v_out_424051", "424051031", "story_v_out_424051.awb") / 1000

					if var_130_38 + var_130_30 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_38 + var_130_30
					end

					if var_130_33.prefab_name ~= "" and arg_127_1.actors_[var_130_33.prefab_name] ~= nil then
						local var_130_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_33.prefab_name].transform, "story_v_out_424051", "424051031", "story_v_out_424051.awb")

						arg_127_1:RecordAudio("424051031", var_130_39)
						arg_127_1:RecordAudio("424051031", var_130_39)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_424051", "424051031", "story_v_out_424051.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_424051", "424051031", "story_v_out_424051.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_40 = math.max(var_130_31, arg_127_1.talkMaxDuration)

			if var_130_30 <= arg_127_1.time_ and arg_127_1.time_ < var_130_30 + var_130_40 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_30) / var_130_40

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_30 + var_130_40 and arg_127_1.time_ < var_130_30 + var_130_40 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
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

		arg_127_1:InitPlayNodeList()
	end,
	Play424051032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 424051032
		arg_131_1.duration_ = 5.87

		local var_131_0 = {
			zh = 5.8,
			ja = 5.866
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
				arg_131_0:Play424051033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10154"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps10154 == nil then
				arg_131_1.var_.actorSpriteComps10154 = var_134_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_2 = 0.2

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.actorSpriteComps10154 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps10154 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_134_3 then
						if arg_131_1.isInRecall_ then
							iter_134_3.color = arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_134_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps10154 = nil
			end

			local var_134_8 = arg_131_1.actors_["10155"]
			local var_134_9 = 0

			if var_134_9 < arg_131_1.time_ and arg_131_1.time_ <= var_134_9 + arg_134_0 and not isNil(var_134_8) and arg_131_1.var_.actorSpriteComps10155 == nil then
				arg_131_1.var_.actorSpriteComps10155 = var_134_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_10 = 0.2

			if var_134_9 <= arg_131_1.time_ and arg_131_1.time_ < var_134_9 + var_134_10 and not isNil(var_134_8) then
				local var_134_11 = (arg_131_1.time_ - var_134_9) / var_134_10

				if arg_131_1.var_.actorSpriteComps10155 then
					for iter_134_4, iter_134_5 in pairs(arg_131_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_134_5 then
							if arg_131_1.isInRecall_ then
								local var_134_12 = Mathf.Lerp(iter_134_5.color.r, arg_131_1.hightColor2.r, var_134_11)
								local var_134_13 = Mathf.Lerp(iter_134_5.color.g, arg_131_1.hightColor2.g, var_134_11)
								local var_134_14 = Mathf.Lerp(iter_134_5.color.b, arg_131_1.hightColor2.b, var_134_11)

								iter_134_5.color = Color.New(var_134_12, var_134_13, var_134_14)
							else
								local var_134_15 = Mathf.Lerp(iter_134_5.color.r, 0.5, var_134_11)

								iter_134_5.color = Color.New(var_134_15, var_134_15, var_134_15)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= var_134_9 + var_134_10 and arg_131_1.time_ < var_134_9 + var_134_10 + arg_134_0 and not isNil(var_134_8) and arg_131_1.var_.actorSpriteComps10155 then
				for iter_134_6, iter_134_7 in pairs(arg_131_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_134_7 then
						if arg_131_1.isInRecall_ then
							iter_134_7.color = arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_134_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps10155 = nil
			end

			local var_134_16 = arg_131_1.actors_["10154"].transform
			local var_134_17 = 0

			if var_134_17 < arg_131_1.time_ and arg_131_1.time_ <= var_134_17 + arg_134_0 then
				arg_131_1.var_.moveOldPos10154 = var_134_16.localPosition
				var_134_16.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("10154", 2)

				local var_134_18 = var_134_16.childCount

				for iter_134_8 = 0, var_134_18 - 1 do
					local var_134_19 = var_134_16:GetChild(iter_134_8)

					if var_134_19.name == "" or not string.find(var_134_19.name, "split") then
						var_134_19.gameObject:SetActive(true)
					else
						var_134_19.gameObject:SetActive(false)
					end
				end
			end

			local var_134_20 = 0.001

			if var_134_17 <= arg_131_1.time_ and arg_131_1.time_ < var_134_17 + var_134_20 then
				local var_134_21 = (arg_131_1.time_ - var_134_17) / var_134_20
				local var_134_22 = Vector3.New(-375, -338, -538)

				var_134_16.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10154, var_134_22, var_134_21)
			end

			if arg_131_1.time_ >= var_134_17 + var_134_20 and arg_131_1.time_ < var_134_17 + var_134_20 + arg_134_0 then
				var_134_16.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_134_23 = 0
			local var_134_24 = 0.675

			if var_134_23 < arg_131_1.time_ and arg_131_1.time_ <= var_134_23 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_25 = arg_131_1:FormatText(StoryNameCfg[1392].name)

				arg_131_1.leftNameTxt_.text = var_134_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_26 = arg_131_1:GetWordFromCfg(424051032)
				local var_134_27 = arg_131_1:FormatText(var_134_26.content)

				arg_131_1.text_.text = var_134_27

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_28 = 27
				local var_134_29 = utf8.len(var_134_27)
				local var_134_30 = var_134_28 <= 0 and var_134_24 or var_134_24 * (var_134_29 / var_134_28)

				if var_134_30 > 0 and var_134_24 < var_134_30 then
					arg_131_1.talkMaxDuration = var_134_30

					if var_134_30 + var_134_23 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_30 + var_134_23
					end
				end

				arg_131_1.text_.text = var_134_27
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051032", "story_v_out_424051.awb") ~= 0 then
					local var_134_31 = manager.audio:GetVoiceLength("story_v_out_424051", "424051032", "story_v_out_424051.awb") / 1000

					if var_134_31 + var_134_23 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_31 + var_134_23
					end

					if var_134_26.prefab_name ~= "" and arg_131_1.actors_[var_134_26.prefab_name] ~= nil then
						local var_134_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_26.prefab_name].transform, "story_v_out_424051", "424051032", "story_v_out_424051.awb")

						arg_131_1:RecordAudio("424051032", var_134_32)
						arg_131_1:RecordAudio("424051032", var_134_32)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_424051", "424051032", "story_v_out_424051.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_424051", "424051032", "story_v_out_424051.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_33 = math.max(var_134_24, arg_131_1.talkMaxDuration)

			if var_134_23 <= arg_131_1.time_ and arg_131_1.time_ < var_134_23 + var_134_33 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_23) / var_134_33

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_23 + var_134_33 and arg_131_1.time_ < var_134_23 + var_134_33 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
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
	Play424051033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 424051033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play424051034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10154"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.actorSpriteComps10154 == nil then
				arg_135_1.var_.actorSpriteComps10154 = var_138_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_2 = 0.2

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.actorSpriteComps10154 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.actorSpriteComps10154 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_138_3 then
						if arg_135_1.isInRecall_ then
							iter_138_3.color = arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_138_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps10154 = nil
			end

			local var_138_8 = 0
			local var_138_9 = 0.375

			if var_138_8 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_10 = arg_135_1:FormatText(StoryNameCfg[7].name)

				arg_135_1.leftNameTxt_.text = var_138_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_11 = arg_135_1:GetWordFromCfg(424051033)
				local var_138_12 = arg_135_1:FormatText(var_138_11.content)

				arg_135_1.text_.text = var_138_12

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_13 = 15
				local var_138_14 = utf8.len(var_138_12)
				local var_138_15 = var_138_13 <= 0 and var_138_9 or var_138_9 * (var_138_14 / var_138_13)

				if var_138_15 > 0 and var_138_9 < var_138_15 then
					arg_135_1.talkMaxDuration = var_138_15

					if var_138_15 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_15 + var_138_8
					end
				end

				arg_135_1.text_.text = var_138_12
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_16 = math.max(var_138_9, arg_135_1.talkMaxDuration)

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_16 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_8) / var_138_16

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_8 + var_138_16 and arg_135_1.time_ < var_138_8 + var_138_16 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play424051034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 424051034
		arg_139_1.duration_ = 2.73

		local var_139_0 = {
			zh = 1.966,
			ja = 2.733
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
				arg_139_0:Play424051035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10155"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps10155 == nil then
				arg_139_1.var_.actorSpriteComps10155 = var_142_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_2 = 0.2

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.actorSpriteComps10155 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								local var_142_4 = Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor1.r, var_142_3)
								local var_142_5 = Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor1.g, var_142_3)
								local var_142_6 = Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor1.b, var_142_3)

								iter_142_1.color = Color.New(var_142_4, var_142_5, var_142_6)
							else
								local var_142_7 = Mathf.Lerp(iter_142_1.color.r, 1, var_142_3)

								iter_142_1.color = Color.New(var_142_7, var_142_7, var_142_7)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps10155 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_142_3 then
						if arg_139_1.isInRecall_ then
							iter_142_3.color = arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_142_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps10155 = nil
			end

			local var_142_8 = arg_139_1.actors_["10155"].transform
			local var_142_9 = 0

			if var_142_9 < arg_139_1.time_ and arg_139_1.time_ <= var_142_9 + arg_142_0 then
				arg_139_1.var_.moveOldPos10155 = var_142_8.localPosition
				var_142_8.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10155", 4)

				local var_142_10 = var_142_8.childCount

				for iter_142_4 = 0, var_142_10 - 1 do
					local var_142_11 = var_142_8:GetChild(iter_142_4)

					if var_142_11.name == "split_4" then
						var_142_11:SetAsLastSibling()
						var_142_11.gameObject:SetActive(true)

						arg_139_1.var_.actorSpriteSplit10155 = var_142_11.gameObject:GetComponent(typeof(Image))

						arg_139_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_142_12 = 0.5

			if var_142_9 <= arg_139_1.time_ and arg_139_1.time_ < var_142_9 + var_142_12 then
				local var_142_13 = (arg_139_1.time_ - var_142_9) / var_142_12
				local var_142_14 = Vector3.New(440, -390, -250)

				var_142_8.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10155, var_142_14, var_142_13)

				if arg_139_1.var_.actorSpriteSplit10155 ~= nil then
					arg_139_1.var_.actorSpriteSplit10155:SetAlpha(var_142_13)
				end
			end

			if arg_139_1.time_ >= var_142_9 + var_142_12 and arg_139_1.time_ < var_142_9 + var_142_12 + arg_142_0 then
				var_142_8.localPosition = Vector3.New(440, -390, -250)

				if arg_139_1.var_.actorSpriteSplit10155 ~= nil then
					arg_139_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_142_15 = 0
			local var_142_16 = 0.25

			if var_142_15 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_17 = arg_139_1:FormatText(StoryNameCfg[1391].name)

				arg_139_1.leftNameTxt_.text = var_142_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_18 = arg_139_1:GetWordFromCfg(424051034)
				local var_142_19 = arg_139_1:FormatText(var_142_18.content)

				arg_139_1.text_.text = var_142_19

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_20 = 10
				local var_142_21 = utf8.len(var_142_19)
				local var_142_22 = var_142_20 <= 0 and var_142_16 or var_142_16 * (var_142_21 / var_142_20)

				if var_142_22 > 0 and var_142_16 < var_142_22 then
					arg_139_1.talkMaxDuration = var_142_22

					if var_142_22 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_22 + var_142_15
					end
				end

				arg_139_1.text_.text = var_142_19
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051034", "story_v_out_424051.awb") ~= 0 then
					local var_142_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051034", "story_v_out_424051.awb") / 1000

					if var_142_23 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_23 + var_142_15
					end

					if var_142_18.prefab_name ~= "" and arg_139_1.actors_[var_142_18.prefab_name] ~= nil then
						local var_142_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_18.prefab_name].transform, "story_v_out_424051", "424051034", "story_v_out_424051.awb")

						arg_139_1:RecordAudio("424051034", var_142_24)
						arg_139_1:RecordAudio("424051034", var_142_24)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_424051", "424051034", "story_v_out_424051.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_424051", "424051034", "story_v_out_424051.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_25 = math.max(var_142_16, arg_139_1.talkMaxDuration)

			if var_142_15 <= arg_139_1.time_ and arg_139_1.time_ < var_142_15 + var_142_25 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_15) / var_142_25

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_15 + var_142_25 and arg_139_1.time_ < var_142_15 + var_142_25 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play424051035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 424051035
		arg_143_1.duration_ = 12

		local var_143_0 = {
			zh = 7.566,
			ja = 12
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
				arg_143_0:Play424051036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["10155"].transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos10155 = var_146_0.localPosition
				var_146_0.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("10155", 4)

				local var_146_2 = var_146_0.childCount

				for iter_146_0 = 0, var_146_2 - 1 do
					local var_146_3 = var_146_0:GetChild(iter_146_0)

					if var_146_3.name == "split_3" then
						var_146_3:SetAsLastSibling()
						var_146_3.gameObject:SetActive(true)

						arg_143_1.var_.actorSpriteSplit10155 = var_146_3.gameObject:GetComponent(typeof(Image))

						arg_143_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_146_4 = 0.5

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_4 then
				local var_146_5 = (arg_143_1.time_ - var_146_1) / var_146_4
				local var_146_6 = Vector3.New(440, -390, -250)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10155, var_146_6, var_146_5)

				if arg_143_1.var_.actorSpriteSplit10155 ~= nil then
					arg_143_1.var_.actorSpriteSplit10155:SetAlpha(var_146_5)
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_4 and arg_143_1.time_ < var_146_1 + var_146_4 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(440, -390, -250)

				if arg_143_1.var_.actorSpriteSplit10155 ~= nil then
					arg_143_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_146_7 = 0
			local var_146_8 = 1

			if var_146_7 < arg_143_1.time_ and arg_143_1.time_ <= var_146_7 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_9 = arg_143_1:FormatText(StoryNameCfg[1391].name)

				arg_143_1.leftNameTxt_.text = var_146_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_10 = arg_143_1:GetWordFromCfg(424051035)
				local var_146_11 = arg_143_1:FormatText(var_146_10.content)

				arg_143_1.text_.text = var_146_11

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_12 = 40
				local var_146_13 = utf8.len(var_146_11)
				local var_146_14 = var_146_12 <= 0 and var_146_8 or var_146_8 * (var_146_13 / var_146_12)

				if var_146_14 > 0 and var_146_8 < var_146_14 then
					arg_143_1.talkMaxDuration = var_146_14

					if var_146_14 + var_146_7 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_14 + var_146_7
					end
				end

				arg_143_1.text_.text = var_146_11
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051035", "story_v_out_424051.awb") ~= 0 then
					local var_146_15 = manager.audio:GetVoiceLength("story_v_out_424051", "424051035", "story_v_out_424051.awb") / 1000

					if var_146_15 + var_146_7 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_15 + var_146_7
					end

					if var_146_10.prefab_name ~= "" and arg_143_1.actors_[var_146_10.prefab_name] ~= nil then
						local var_146_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_10.prefab_name].transform, "story_v_out_424051", "424051035", "story_v_out_424051.awb")

						arg_143_1:RecordAudio("424051035", var_146_16)
						arg_143_1:RecordAudio("424051035", var_146_16)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_424051", "424051035", "story_v_out_424051.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_424051", "424051035", "story_v_out_424051.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_17 = math.max(var_146_8, arg_143_1.talkMaxDuration)

			if var_146_7 <= arg_143_1.time_ and arg_143_1.time_ < var_146_7 + var_146_17 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_7) / var_146_17

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_7 + var_146_17 and arg_143_1.time_ < var_146_7 + var_146_17 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play424051036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 424051036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play424051037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10155"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.actorSpriteComps10155 == nil then
				arg_147_1.var_.actorSpriteComps10155 = var_150_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_2 = 0.2

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.actorSpriteComps10155 then
					for iter_150_0, iter_150_1 in pairs(arg_147_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_150_1 then
							if arg_147_1.isInRecall_ then
								local var_150_4 = Mathf.Lerp(iter_150_1.color.r, arg_147_1.hightColor2.r, var_150_3)
								local var_150_5 = Mathf.Lerp(iter_150_1.color.g, arg_147_1.hightColor2.g, var_150_3)
								local var_150_6 = Mathf.Lerp(iter_150_1.color.b, arg_147_1.hightColor2.b, var_150_3)

								iter_150_1.color = Color.New(var_150_4, var_150_5, var_150_6)
							else
								local var_150_7 = Mathf.Lerp(iter_150_1.color.r, 0.5, var_150_3)

								iter_150_1.color = Color.New(var_150_7, var_150_7, var_150_7)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.actorSpriteComps10155 then
				for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_150_3 then
						if arg_147_1.isInRecall_ then
							iter_150_3.color = arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_150_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps10155 = nil
			end

			local var_150_8 = 0
			local var_150_9 = 0.5

			if var_150_8 < arg_147_1.time_ and arg_147_1.time_ <= var_150_8 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_10 = arg_147_1:FormatText(StoryNameCfg[7].name)

				arg_147_1.leftNameTxt_.text = var_150_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_11 = arg_147_1:GetWordFromCfg(424051036)
				local var_150_12 = arg_147_1:FormatText(var_150_11.content)

				arg_147_1.text_.text = var_150_12

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_13 = 20
				local var_150_14 = utf8.len(var_150_12)
				local var_150_15 = var_150_13 <= 0 and var_150_9 or var_150_9 * (var_150_14 / var_150_13)

				if var_150_15 > 0 and var_150_9 < var_150_15 then
					arg_147_1.talkMaxDuration = var_150_15

					if var_150_15 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_15 + var_150_8
					end
				end

				arg_147_1.text_.text = var_150_12
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_16 = math.max(var_150_9, arg_147_1.talkMaxDuration)

			if var_150_8 <= arg_147_1.time_ and arg_147_1.time_ < var_150_8 + var_150_16 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_8) / var_150_16

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_8 + var_150_16 and arg_147_1.time_ < var_150_8 + var_150_16 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play424051037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 424051037
		arg_151_1.duration_ = 18.2

		local var_151_0 = {
			zh = 10.966,
			ja = 18.2
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
				arg_151_0:Play424051038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10155"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps10155 == nil then
				arg_151_1.var_.actorSpriteComps10155 = var_154_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_2 = 0.2

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.actorSpriteComps10155 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps10155 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_154_3 then
						if arg_151_1.isInRecall_ then
							iter_154_3.color = arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_154_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps10155 = nil
			end

			local var_154_8 = arg_151_1.actors_["10155"].transform
			local var_154_9 = 0

			if var_154_9 < arg_151_1.time_ and arg_151_1.time_ <= var_154_9 + arg_154_0 then
				arg_151_1.var_.moveOldPos10155 = var_154_8.localPosition
				var_154_8.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("10155", 4)

				local var_154_10 = var_154_8.childCount

				for iter_154_4 = 0, var_154_10 - 1 do
					local var_154_11 = var_154_8:GetChild(iter_154_4)

					if var_154_11.name == "split_4" then
						var_154_11:SetAsLastSibling()
						var_154_11.gameObject:SetActive(true)

						arg_151_1.var_.actorSpriteSplit10155 = var_154_11.gameObject:GetComponent(typeof(Image))

						arg_151_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_154_12 = 0.5

			if var_154_9 <= arg_151_1.time_ and arg_151_1.time_ < var_154_9 + var_154_12 then
				local var_154_13 = (arg_151_1.time_ - var_154_9) / var_154_12
				local var_154_14 = Vector3.New(440, -390, -250)

				var_154_8.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10155, var_154_14, var_154_13)

				if arg_151_1.var_.actorSpriteSplit10155 ~= nil then
					arg_151_1.var_.actorSpriteSplit10155:SetAlpha(var_154_13)
				end
			end

			if arg_151_1.time_ >= var_154_9 + var_154_12 and arg_151_1.time_ < var_154_9 + var_154_12 + arg_154_0 then
				var_154_8.localPosition = Vector3.New(440, -390, -250)

				if arg_151_1.var_.actorSpriteSplit10155 ~= nil then
					arg_151_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_154_15 = 0
			local var_154_16 = 0.725

			if var_154_15 < arg_151_1.time_ and arg_151_1.time_ <= var_154_15 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_17 = arg_151_1:FormatText(StoryNameCfg[1391].name)

				arg_151_1.leftNameTxt_.text = var_154_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_18 = arg_151_1:GetWordFromCfg(424051037)
				local var_154_19 = arg_151_1:FormatText(var_154_18.content)

				arg_151_1.text_.text = var_154_19

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_20 = 29
				local var_154_21 = utf8.len(var_154_19)
				local var_154_22 = var_154_20 <= 0 and var_154_16 or var_154_16 * (var_154_21 / var_154_20)

				if var_154_22 > 0 and var_154_16 < var_154_22 then
					arg_151_1.talkMaxDuration = var_154_22

					if var_154_22 + var_154_15 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_22 + var_154_15
					end
				end

				arg_151_1.text_.text = var_154_19
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051037", "story_v_out_424051.awb") ~= 0 then
					local var_154_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051037", "story_v_out_424051.awb") / 1000

					if var_154_23 + var_154_15 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_23 + var_154_15
					end

					if var_154_18.prefab_name ~= "" and arg_151_1.actors_[var_154_18.prefab_name] ~= nil then
						local var_154_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_18.prefab_name].transform, "story_v_out_424051", "424051037", "story_v_out_424051.awb")

						arg_151_1:RecordAudio("424051037", var_154_24)
						arg_151_1:RecordAudio("424051037", var_154_24)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_424051", "424051037", "story_v_out_424051.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_424051", "424051037", "story_v_out_424051.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_25 = math.max(var_154_16, arg_151_1.talkMaxDuration)

			if var_154_15 <= arg_151_1.time_ and arg_151_1.time_ < var_154_15 + var_154_25 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_15) / var_154_25

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_15 + var_154_25 and arg_151_1.time_ < var_154_15 + var_154_25 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play424051038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 424051038
		arg_155_1.duration_ = 1.5

		local var_155_0 = {
			zh = 1.2,
			ja = 1.5
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
				arg_155_0:Play424051039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1094"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.actorSpriteComps1094 == nil then
				arg_155_1.var_.actorSpriteComps1094 = var_158_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_2 = 0.2

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.actorSpriteComps1094 then
					for iter_158_0, iter_158_1 in pairs(arg_155_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.actorSpriteComps1094 then
				for iter_158_2, iter_158_3 in pairs(arg_155_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_158_3 then
						if arg_155_1.isInRecall_ then
							iter_158_3.color = arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_158_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps1094 = nil
			end

			local var_158_8 = arg_155_1.actors_["10155"]
			local var_158_9 = 0

			if var_158_9 < arg_155_1.time_ and arg_155_1.time_ <= var_158_9 + arg_158_0 and not isNil(var_158_8) and arg_155_1.var_.actorSpriteComps10155 == nil then
				arg_155_1.var_.actorSpriteComps10155 = var_158_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_10 = 0.2

			if var_158_9 <= arg_155_1.time_ and arg_155_1.time_ < var_158_9 + var_158_10 and not isNil(var_158_8) then
				local var_158_11 = (arg_155_1.time_ - var_158_9) / var_158_10

				if arg_155_1.var_.actorSpriteComps10155 then
					for iter_158_4, iter_158_5 in pairs(arg_155_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_155_1.time_ >= var_158_9 + var_158_10 and arg_155_1.time_ < var_158_9 + var_158_10 + arg_158_0 and not isNil(var_158_8) and arg_155_1.var_.actorSpriteComps10155 then
				for iter_158_6, iter_158_7 in pairs(arg_155_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_158_7 then
						if arg_155_1.isInRecall_ then
							iter_158_7.color = arg_155_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_158_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps10155 = nil
			end

			local var_158_16 = arg_155_1.actors_["1094"].transform
			local var_158_17 = 0

			if var_158_17 < arg_155_1.time_ and arg_155_1.time_ <= var_158_17 + arg_158_0 then
				arg_155_1.var_.moveOldPos1094 = var_158_16.localPosition
				var_158_16.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("1094", 2)

				local var_158_18 = var_158_16.childCount

				for iter_158_8 = 0, var_158_18 - 1 do
					local var_158_19 = var_158_16:GetChild(iter_158_8)

					if var_158_19.name == "split_1" or not string.find(var_158_19.name, "split") then
						var_158_19.gameObject:SetActive(true)
					else
						var_158_19.gameObject:SetActive(false)
					end
				end
			end

			local var_158_20 = 0.001

			if var_158_17 <= arg_155_1.time_ and arg_155_1.time_ < var_158_17 + var_158_20 then
				local var_158_21 = (arg_155_1.time_ - var_158_17) / var_158_20
				local var_158_22 = Vector3.New(-380, -335, -230)

				var_158_16.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1094, var_158_22, var_158_21)
			end

			if arg_155_1.time_ >= var_158_17 + var_158_20 and arg_155_1.time_ < var_158_17 + var_158_20 + arg_158_0 then
				var_158_16.localPosition = Vector3.New(-380, -335, -230)
			end

			local var_158_23 = arg_155_1.actors_["10154"].transform
			local var_158_24 = 0

			if var_158_24 < arg_155_1.time_ and arg_155_1.time_ <= var_158_24 + arg_158_0 then
				arg_155_1.var_.moveOldPos10154 = var_158_23.localPosition
				var_158_23.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10154", 7)

				local var_158_25 = var_158_23.childCount

				for iter_158_9 = 0, var_158_25 - 1 do
					local var_158_26 = var_158_23:GetChild(iter_158_9)

					if var_158_26.name == "" or not string.find(var_158_26.name, "split") then
						var_158_26.gameObject:SetActive(true)
					else
						var_158_26.gameObject:SetActive(false)
					end
				end
			end

			local var_158_27 = 0.001

			if var_158_24 <= arg_155_1.time_ and arg_155_1.time_ < var_158_24 + var_158_27 then
				local var_158_28 = (arg_155_1.time_ - var_158_24) / var_158_27
				local var_158_29 = Vector3.New(0, -2000, 0)

				var_158_23.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10154, var_158_29, var_158_28)
			end

			if arg_155_1.time_ >= var_158_24 + var_158_27 and arg_155_1.time_ < var_158_24 + var_158_27 + arg_158_0 then
				var_158_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_158_30 = 0
			local var_158_31 = 0.15

			if var_158_30 < arg_155_1.time_ and arg_155_1.time_ <= var_158_30 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_32 = arg_155_1:FormatText(StoryNameCfg[181].name)

				arg_155_1.leftNameTxt_.text = var_158_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_33 = arg_155_1:GetWordFromCfg(424051038)
				local var_158_34 = arg_155_1:FormatText(var_158_33.content)

				arg_155_1.text_.text = var_158_34

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_35 = 6
				local var_158_36 = utf8.len(var_158_34)
				local var_158_37 = var_158_35 <= 0 and var_158_31 or var_158_31 * (var_158_36 / var_158_35)

				if var_158_37 > 0 and var_158_31 < var_158_37 then
					arg_155_1.talkMaxDuration = var_158_37

					if var_158_37 + var_158_30 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_37 + var_158_30
					end
				end

				arg_155_1.text_.text = var_158_34
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051038", "story_v_out_424051.awb") ~= 0 then
					local var_158_38 = manager.audio:GetVoiceLength("story_v_out_424051", "424051038", "story_v_out_424051.awb") / 1000

					if var_158_38 + var_158_30 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_38 + var_158_30
					end

					if var_158_33.prefab_name ~= "" and arg_155_1.actors_[var_158_33.prefab_name] ~= nil then
						local var_158_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_33.prefab_name].transform, "story_v_out_424051", "424051038", "story_v_out_424051.awb")

						arg_155_1:RecordAudio("424051038", var_158_39)
						arg_155_1:RecordAudio("424051038", var_158_39)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_424051", "424051038", "story_v_out_424051.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_424051", "424051038", "story_v_out_424051.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_40 = math.max(var_158_31, arg_155_1.talkMaxDuration)

			if var_158_30 <= arg_155_1.time_ and arg_155_1.time_ < var_158_30 + var_158_40 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_30) / var_158_40

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_30 + var_158_40 and arg_155_1.time_ < var_158_30 + var_158_40 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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
				actorName = "10154",
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
	Play424051039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 424051039
		arg_159_1.duration_ = 12.83

		local var_159_0 = {
			zh = 7.4,
			ja = 12.833
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
				arg_159_0:Play424051040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10155"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.actorSpriteComps10155 == nil then
				arg_159_1.var_.actorSpriteComps10155 = var_162_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_2 = 0.2

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.actorSpriteComps10155 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_162_1 then
							if arg_159_1.isInRecall_ then
								local var_162_4 = Mathf.Lerp(iter_162_1.color.r, arg_159_1.hightColor1.r, var_162_3)
								local var_162_5 = Mathf.Lerp(iter_162_1.color.g, arg_159_1.hightColor1.g, var_162_3)
								local var_162_6 = Mathf.Lerp(iter_162_1.color.b, arg_159_1.hightColor1.b, var_162_3)

								iter_162_1.color = Color.New(var_162_4, var_162_5, var_162_6)
							else
								local var_162_7 = Mathf.Lerp(iter_162_1.color.r, 1, var_162_3)

								iter_162_1.color = Color.New(var_162_7, var_162_7, var_162_7)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.actorSpriteComps10155 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_162_3 then
						if arg_159_1.isInRecall_ then
							iter_162_3.color = arg_159_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_162_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_159_1.var_.actorSpriteComps10155 = nil
			end

			local var_162_8 = arg_159_1.actors_["1094"]
			local var_162_9 = 0

			if var_162_9 < arg_159_1.time_ and arg_159_1.time_ <= var_162_9 + arg_162_0 and not isNil(var_162_8) and arg_159_1.var_.actorSpriteComps1094 == nil then
				arg_159_1.var_.actorSpriteComps1094 = var_162_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_10 = 0.2

			if var_162_9 <= arg_159_1.time_ and arg_159_1.time_ < var_162_9 + var_162_10 and not isNil(var_162_8) then
				local var_162_11 = (arg_159_1.time_ - var_162_9) / var_162_10

				if arg_159_1.var_.actorSpriteComps1094 then
					for iter_162_4, iter_162_5 in pairs(arg_159_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_162_5 then
							if arg_159_1.isInRecall_ then
								local var_162_12 = Mathf.Lerp(iter_162_5.color.r, arg_159_1.hightColor2.r, var_162_11)
								local var_162_13 = Mathf.Lerp(iter_162_5.color.g, arg_159_1.hightColor2.g, var_162_11)
								local var_162_14 = Mathf.Lerp(iter_162_5.color.b, arg_159_1.hightColor2.b, var_162_11)

								iter_162_5.color = Color.New(var_162_12, var_162_13, var_162_14)
							else
								local var_162_15 = Mathf.Lerp(iter_162_5.color.r, 0.5, var_162_11)

								iter_162_5.color = Color.New(var_162_15, var_162_15, var_162_15)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= var_162_9 + var_162_10 and arg_159_1.time_ < var_162_9 + var_162_10 + arg_162_0 and not isNil(var_162_8) and arg_159_1.var_.actorSpriteComps1094 then
				for iter_162_6, iter_162_7 in pairs(arg_159_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_162_7 then
						if arg_159_1.isInRecall_ then
							iter_162_7.color = arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_162_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_159_1.var_.actorSpriteComps1094 = nil
			end

			local var_162_16 = arg_159_1.actors_["10155"].transform
			local var_162_17 = 0

			if var_162_17 < arg_159_1.time_ and arg_159_1.time_ <= var_162_17 + arg_162_0 then
				arg_159_1.var_.moveOldPos10155 = var_162_16.localPosition
				var_162_16.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10155", 4)

				local var_162_18 = var_162_16.childCount

				for iter_162_8 = 0, var_162_18 - 1 do
					local var_162_19 = var_162_16:GetChild(iter_162_8)

					if var_162_19.name == "split_1" then
						var_162_19:SetAsLastSibling()
						var_162_19.gameObject:SetActive(true)

						arg_159_1.var_.actorSpriteSplit10155 = var_162_19.gameObject:GetComponent(typeof(Image))

						arg_159_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_162_20 = 0.5

			if var_162_17 <= arg_159_1.time_ and arg_159_1.time_ < var_162_17 + var_162_20 then
				local var_162_21 = (arg_159_1.time_ - var_162_17) / var_162_20
				local var_162_22 = Vector3.New(440, -390, -250)

				var_162_16.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10155, var_162_22, var_162_21)

				if arg_159_1.var_.actorSpriteSplit10155 ~= nil then
					arg_159_1.var_.actorSpriteSplit10155:SetAlpha(var_162_21)
				end
			end

			if arg_159_1.time_ >= var_162_17 + var_162_20 and arg_159_1.time_ < var_162_17 + var_162_20 + arg_162_0 then
				var_162_16.localPosition = Vector3.New(440, -390, -250)

				if arg_159_1.var_.actorSpriteSplit10155 ~= nil then
					arg_159_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_162_23 = 0
			local var_162_24 = 0.725

			if var_162_23 < arg_159_1.time_ and arg_159_1.time_ <= var_162_23 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_25 = arg_159_1:FormatText(StoryNameCfg[1391].name)

				arg_159_1.leftNameTxt_.text = var_162_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_26 = arg_159_1:GetWordFromCfg(424051039)
				local var_162_27 = arg_159_1:FormatText(var_162_26.content)

				arg_159_1.text_.text = var_162_27

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_28 = 29
				local var_162_29 = utf8.len(var_162_27)
				local var_162_30 = var_162_28 <= 0 and var_162_24 or var_162_24 * (var_162_29 / var_162_28)

				if var_162_30 > 0 and var_162_24 < var_162_30 then
					arg_159_1.talkMaxDuration = var_162_30

					if var_162_30 + var_162_23 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_30 + var_162_23
					end
				end

				arg_159_1.text_.text = var_162_27
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051039", "story_v_out_424051.awb") ~= 0 then
					local var_162_31 = manager.audio:GetVoiceLength("story_v_out_424051", "424051039", "story_v_out_424051.awb") / 1000

					if var_162_31 + var_162_23 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_31 + var_162_23
					end

					if var_162_26.prefab_name ~= "" and arg_159_1.actors_[var_162_26.prefab_name] ~= nil then
						local var_162_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_26.prefab_name].transform, "story_v_out_424051", "424051039", "story_v_out_424051.awb")

						arg_159_1:RecordAudio("424051039", var_162_32)
						arg_159_1:RecordAudio("424051039", var_162_32)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_424051", "424051039", "story_v_out_424051.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_424051", "424051039", "story_v_out_424051.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_33 = math.max(var_162_24, arg_159_1.talkMaxDuration)

			if var_162_23 <= arg_159_1.time_ and arg_159_1.time_ < var_162_23 + var_162_33 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_23) / var_162_33

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_23 + var_162_33 and arg_159_1.time_ < var_162_23 + var_162_33 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play424051040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 424051040
		arg_163_1.duration_ = 7.23

		local var_163_0 = {
			zh = 4.966,
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
				arg_163_0:Play424051041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10154"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.actorSpriteComps10154 == nil then
				arg_163_1.var_.actorSpriteComps10154 = var_166_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_2 = 0.2

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.actorSpriteComps10154 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.actorSpriteComps10154 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_166_3 then
						if arg_163_1.isInRecall_ then
							iter_166_3.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_166_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps10154 = nil
			end

			local var_166_8 = arg_163_1.actors_["10155"]
			local var_166_9 = 0

			if var_166_9 < arg_163_1.time_ and arg_163_1.time_ <= var_166_9 + arg_166_0 and not isNil(var_166_8) and arg_163_1.var_.actorSpriteComps10155 == nil then
				arg_163_1.var_.actorSpriteComps10155 = var_166_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_10 = 0.2

			if var_166_9 <= arg_163_1.time_ and arg_163_1.time_ < var_166_9 + var_166_10 and not isNil(var_166_8) then
				local var_166_11 = (arg_163_1.time_ - var_166_9) / var_166_10

				if arg_163_1.var_.actorSpriteComps10155 then
					for iter_166_4, iter_166_5 in pairs(arg_163_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_166_5 then
							if arg_163_1.isInRecall_ then
								local var_166_12 = Mathf.Lerp(iter_166_5.color.r, arg_163_1.hightColor2.r, var_166_11)
								local var_166_13 = Mathf.Lerp(iter_166_5.color.g, arg_163_1.hightColor2.g, var_166_11)
								local var_166_14 = Mathf.Lerp(iter_166_5.color.b, arg_163_1.hightColor2.b, var_166_11)

								iter_166_5.color = Color.New(var_166_12, var_166_13, var_166_14)
							else
								local var_166_15 = Mathf.Lerp(iter_166_5.color.r, 0.5, var_166_11)

								iter_166_5.color = Color.New(var_166_15, var_166_15, var_166_15)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_9 + var_166_10 and arg_163_1.time_ < var_166_9 + var_166_10 + arg_166_0 and not isNil(var_166_8) and arg_163_1.var_.actorSpriteComps10155 then
				for iter_166_6, iter_166_7 in pairs(arg_163_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_166_7 then
						if arg_163_1.isInRecall_ then
							iter_166_7.color = arg_163_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_166_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps10155 = nil
			end

			local var_166_16 = arg_163_1.actors_["10154"].transform
			local var_166_17 = 0

			if var_166_17 < arg_163_1.time_ and arg_163_1.time_ <= var_166_17 + arg_166_0 then
				arg_163_1.var_.moveOldPos10154 = var_166_16.localPosition
				var_166_16.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10154", 2)

				local var_166_18 = var_166_16.childCount

				for iter_166_8 = 0, var_166_18 - 1 do
					local var_166_19 = var_166_16:GetChild(iter_166_8)

					if var_166_19.name == "split_1" then
						var_166_19:SetAsLastSibling()
						var_166_19.gameObject:SetActive(true)

						arg_163_1.var_.actorSpriteSplit10154 = var_166_19.gameObject:GetComponent(typeof(Image))

						arg_163_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_166_20 = 0.001

			if var_166_17 <= arg_163_1.time_ and arg_163_1.time_ < var_166_17 + var_166_20 then
				local var_166_21 = (arg_163_1.time_ - var_166_17) / var_166_20
				local var_166_22 = Vector3.New(-375, -338, -538)

				var_166_16.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10154, var_166_22, var_166_21)

				if arg_163_1.var_.actorSpriteSplit10154 ~= nil then
					arg_163_1.var_.actorSpriteSplit10154:SetAlpha(var_166_21)
				end
			end

			if arg_163_1.time_ >= var_166_17 + var_166_20 and arg_163_1.time_ < var_166_17 + var_166_20 + arg_166_0 then
				var_166_16.localPosition = Vector3.New(-375, -338, -538)

				if arg_163_1.var_.actorSpriteSplit10154 ~= nil then
					arg_163_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_166_23 = arg_163_1.actors_["1094"].transform
			local var_166_24 = 0

			if var_166_24 < arg_163_1.time_ and arg_163_1.time_ <= var_166_24 + arg_166_0 then
				arg_163_1.var_.moveOldPos1094 = var_166_23.localPosition
				var_166_23.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("1094", 7)

				local var_166_25 = var_166_23.childCount

				for iter_166_9 = 0, var_166_25 - 1 do
					local var_166_26 = var_166_23:GetChild(iter_166_9)

					if var_166_26.name == "split_1" or not string.find(var_166_26.name, "split") then
						var_166_26.gameObject:SetActive(true)
					else
						var_166_26.gameObject:SetActive(false)
					end
				end
			end

			local var_166_27 = 0.001

			if var_166_24 <= arg_163_1.time_ and arg_163_1.time_ < var_166_24 + var_166_27 then
				local var_166_28 = (arg_163_1.time_ - var_166_24) / var_166_27
				local var_166_29 = Vector3.New(0, -2000, 0)

				var_166_23.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1094, var_166_29, var_166_28)
			end

			if arg_163_1.time_ >= var_166_24 + var_166_27 and arg_163_1.time_ < var_166_24 + var_166_27 + arg_166_0 then
				var_166_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_166_30 = 0
			local var_166_31 = 0.8

			if var_166_30 < arg_163_1.time_ and arg_163_1.time_ <= var_166_30 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_32 = arg_163_1:FormatText(StoryNameCfg[1392].name)

				arg_163_1.leftNameTxt_.text = var_166_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_33 = arg_163_1:GetWordFromCfg(424051040)
				local var_166_34 = arg_163_1:FormatText(var_166_33.content)

				arg_163_1.text_.text = var_166_34

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_35 = 32
				local var_166_36 = utf8.len(var_166_34)
				local var_166_37 = var_166_35 <= 0 and var_166_31 or var_166_31 * (var_166_36 / var_166_35)

				if var_166_37 > 0 and var_166_31 < var_166_37 then
					arg_163_1.talkMaxDuration = var_166_37

					if var_166_37 + var_166_30 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_37 + var_166_30
					end
				end

				arg_163_1.text_.text = var_166_34
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051040", "story_v_out_424051.awb") ~= 0 then
					local var_166_38 = manager.audio:GetVoiceLength("story_v_out_424051", "424051040", "story_v_out_424051.awb") / 1000

					if var_166_38 + var_166_30 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_38 + var_166_30
					end

					if var_166_33.prefab_name ~= "" and arg_163_1.actors_[var_166_33.prefab_name] ~= nil then
						local var_166_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_33.prefab_name].transform, "story_v_out_424051", "424051040", "story_v_out_424051.awb")

						arg_163_1:RecordAudio("424051040", var_166_39)
						arg_163_1:RecordAudio("424051040", var_166_39)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_424051", "424051040", "story_v_out_424051.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_424051", "424051040", "story_v_out_424051.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_40 = math.max(var_166_31, arg_163_1.talkMaxDuration)

			if var_166_30 <= arg_163_1.time_ and arg_163_1.time_ < var_166_30 + var_166_40 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_30) / var_166_40

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_30 + var_166_40 and arg_163_1.time_ < var_166_30 + var_166_40 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
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

		arg_163_1:InitPlayNodeList()
	end,
	Play424051041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 424051041
		arg_167_1.duration_ = 8.5

		local var_167_0 = {
			zh = 4.166,
			ja = 8.5
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
				arg_167_0:Play424051042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10155"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps10155 == nil then
				arg_167_1.var_.actorSpriteComps10155 = var_170_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_2 = 0.2

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.actorSpriteComps10155 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps10155 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_170_3 then
						if arg_167_1.isInRecall_ then
							iter_170_3.color = arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_170_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps10155 = nil
			end

			local var_170_8 = arg_167_1.actors_["10154"]
			local var_170_9 = 0

			if var_170_9 < arg_167_1.time_ and arg_167_1.time_ <= var_170_9 + arg_170_0 and not isNil(var_170_8) and arg_167_1.var_.actorSpriteComps10154 == nil then
				arg_167_1.var_.actorSpriteComps10154 = var_170_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_10 = 0.2

			if var_170_9 <= arg_167_1.time_ and arg_167_1.time_ < var_170_9 + var_170_10 and not isNil(var_170_8) then
				local var_170_11 = (arg_167_1.time_ - var_170_9) / var_170_10

				if arg_167_1.var_.actorSpriteComps10154 then
					for iter_170_4, iter_170_5 in pairs(arg_167_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_167_1.time_ >= var_170_9 + var_170_10 and arg_167_1.time_ < var_170_9 + var_170_10 + arg_170_0 and not isNil(var_170_8) and arg_167_1.var_.actorSpriteComps10154 then
				for iter_170_6, iter_170_7 in pairs(arg_167_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_170_7 then
						if arg_167_1.isInRecall_ then
							iter_170_7.color = arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_170_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps10154 = nil
			end

			local var_170_16 = arg_167_1.actors_["10155"].transform
			local var_170_17 = 0

			if var_170_17 < arg_167_1.time_ and arg_167_1.time_ <= var_170_17 + arg_170_0 then
				arg_167_1.var_.moveOldPos10155 = var_170_16.localPosition
				var_170_16.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10155", 4)

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
				local var_170_22 = Vector3.New(440, -390, -250)

				var_170_16.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10155, var_170_22, var_170_21)
			end

			if arg_167_1.time_ >= var_170_17 + var_170_20 and arg_167_1.time_ < var_170_17 + var_170_20 + arg_170_0 then
				var_170_16.localPosition = Vector3.New(440, -390, -250)
			end

			local var_170_23 = 0
			local var_170_24 = 0.55

			if var_170_23 < arg_167_1.time_ and arg_167_1.time_ <= var_170_23 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_25 = arg_167_1:FormatText(StoryNameCfg[1391].name)

				arg_167_1.leftNameTxt_.text = var_170_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_26 = arg_167_1:GetWordFromCfg(424051041)
				local var_170_27 = arg_167_1:FormatText(var_170_26.content)

				arg_167_1.text_.text = var_170_27

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_28 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051041", "story_v_out_424051.awb") ~= 0 then
					local var_170_31 = manager.audio:GetVoiceLength("story_v_out_424051", "424051041", "story_v_out_424051.awb") / 1000

					if var_170_31 + var_170_23 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_31 + var_170_23
					end

					if var_170_26.prefab_name ~= "" and arg_167_1.actors_[var_170_26.prefab_name] ~= nil then
						local var_170_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_26.prefab_name].transform, "story_v_out_424051", "424051041", "story_v_out_424051.awb")

						arg_167_1:RecordAudio("424051041", var_170_32)
						arg_167_1:RecordAudio("424051041", var_170_32)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_424051", "424051041", "story_v_out_424051.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_424051", "424051041", "story_v_out_424051.awb")
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
				actorName = "10155",
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
	Play424051042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 424051042
		arg_171_1.duration_ = 2.43

		local var_171_0 = {
			zh = 2,
			ja = 2.433
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
				arg_171_0:Play424051043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10154"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.actorSpriteComps10154 == nil then
				arg_171_1.var_.actorSpriteComps10154 = var_174_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_2 = 0.2

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.actorSpriteComps10154 then
					for iter_174_0, iter_174_1 in pairs(arg_171_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.actorSpriteComps10154 then
				for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_174_3 then
						if arg_171_1.isInRecall_ then
							iter_174_3.color = arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_174_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps10154 = nil
			end

			local var_174_8 = arg_171_1.actors_["10155"]
			local var_174_9 = 0

			if var_174_9 < arg_171_1.time_ and arg_171_1.time_ <= var_174_9 + arg_174_0 and not isNil(var_174_8) and arg_171_1.var_.actorSpriteComps10155 == nil then
				arg_171_1.var_.actorSpriteComps10155 = var_174_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_10 = 0.2

			if var_174_9 <= arg_171_1.time_ and arg_171_1.time_ < var_174_9 + var_174_10 and not isNil(var_174_8) then
				local var_174_11 = (arg_171_1.time_ - var_174_9) / var_174_10

				if arg_171_1.var_.actorSpriteComps10155 then
					for iter_174_4, iter_174_5 in pairs(arg_171_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_174_5 then
							if arg_171_1.isInRecall_ then
								local var_174_12 = Mathf.Lerp(iter_174_5.color.r, arg_171_1.hightColor2.r, var_174_11)
								local var_174_13 = Mathf.Lerp(iter_174_5.color.g, arg_171_1.hightColor2.g, var_174_11)
								local var_174_14 = Mathf.Lerp(iter_174_5.color.b, arg_171_1.hightColor2.b, var_174_11)

								iter_174_5.color = Color.New(var_174_12, var_174_13, var_174_14)
							else
								local var_174_15 = Mathf.Lerp(iter_174_5.color.r, 0.5, var_174_11)

								iter_174_5.color = Color.New(var_174_15, var_174_15, var_174_15)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= var_174_9 + var_174_10 and arg_171_1.time_ < var_174_9 + var_174_10 + arg_174_0 and not isNil(var_174_8) and arg_171_1.var_.actorSpriteComps10155 then
				for iter_174_6, iter_174_7 in pairs(arg_171_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_174_7 then
						if arg_171_1.isInRecall_ then
							iter_174_7.color = arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_174_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps10155 = nil
			end

			local var_174_16 = arg_171_1.actors_["10154"].transform
			local var_174_17 = 0

			if var_174_17 < arg_171_1.time_ and arg_171_1.time_ <= var_174_17 + arg_174_0 then
				arg_171_1.var_.moveOldPos10154 = var_174_16.localPosition
				var_174_16.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10154", 2)

				local var_174_18 = var_174_16.childCount

				for iter_174_8 = 0, var_174_18 - 1 do
					local var_174_19 = var_174_16:GetChild(iter_174_8)

					if var_174_19.name == "split_1" then
						var_174_19:SetAsLastSibling()
						var_174_19.gameObject:SetActive(true)

						arg_171_1.var_.actorSpriteSplit10154 = var_174_19.gameObject:GetComponent(typeof(Image))

						arg_171_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_174_20 = 0.5

			if var_174_17 <= arg_171_1.time_ and arg_171_1.time_ < var_174_17 + var_174_20 then
				local var_174_21 = (arg_171_1.time_ - var_174_17) / var_174_20
				local var_174_22 = Vector3.New(-375, -338, -538)

				var_174_16.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10154, var_174_22, var_174_21)

				if arg_171_1.var_.actorSpriteSplit10154 ~= nil then
					arg_171_1.var_.actorSpriteSplit10154:SetAlpha(var_174_21)
				end
			end

			if arg_171_1.time_ >= var_174_17 + var_174_20 and arg_171_1.time_ < var_174_17 + var_174_20 + arg_174_0 then
				var_174_16.localPosition = Vector3.New(-375, -338, -538)

				if arg_171_1.var_.actorSpriteSplit10154 ~= nil then
					arg_171_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_174_23 = 0
			local var_174_24 = 0.275

			if var_174_23 < arg_171_1.time_ and arg_171_1.time_ <= var_174_23 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_25 = arg_171_1:FormatText(StoryNameCfg[1392].name)

				arg_171_1.leftNameTxt_.text = var_174_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_26 = arg_171_1:GetWordFromCfg(424051042)
				local var_174_27 = arg_171_1:FormatText(var_174_26.content)

				arg_171_1.text_.text = var_174_27

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_28 = 11
				local var_174_29 = utf8.len(var_174_27)
				local var_174_30 = var_174_28 <= 0 and var_174_24 or var_174_24 * (var_174_29 / var_174_28)

				if var_174_30 > 0 and var_174_24 < var_174_30 then
					arg_171_1.talkMaxDuration = var_174_30

					if var_174_30 + var_174_23 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_30 + var_174_23
					end
				end

				arg_171_1.text_.text = var_174_27
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051042", "story_v_out_424051.awb") ~= 0 then
					local var_174_31 = manager.audio:GetVoiceLength("story_v_out_424051", "424051042", "story_v_out_424051.awb") / 1000

					if var_174_31 + var_174_23 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_31 + var_174_23
					end

					if var_174_26.prefab_name ~= "" and arg_171_1.actors_[var_174_26.prefab_name] ~= nil then
						local var_174_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_26.prefab_name].transform, "story_v_out_424051", "424051042", "story_v_out_424051.awb")

						arg_171_1:RecordAudio("424051042", var_174_32)
						arg_171_1:RecordAudio("424051042", var_174_32)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_424051", "424051042", "story_v_out_424051.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_424051", "424051042", "story_v_out_424051.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_33 = math.max(var_174_24, arg_171_1.talkMaxDuration)

			if var_174_23 <= arg_171_1.time_ and arg_171_1.time_ < var_174_23 + var_174_33 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_23) / var_174_33

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_23 + var_174_33 and arg_171_1.time_ < var_174_23 + var_174_33 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play424051043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 424051043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play424051044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["10154"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.actorSpriteComps10154 == nil then
				arg_175_1.var_.actorSpriteComps10154 = var_178_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_2 = 0.2

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.actorSpriteComps10154 then
					for iter_178_0, iter_178_1 in pairs(arg_175_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_178_1 then
							if arg_175_1.isInRecall_ then
								local var_178_4 = Mathf.Lerp(iter_178_1.color.r, arg_175_1.hightColor2.r, var_178_3)
								local var_178_5 = Mathf.Lerp(iter_178_1.color.g, arg_175_1.hightColor2.g, var_178_3)
								local var_178_6 = Mathf.Lerp(iter_178_1.color.b, arg_175_1.hightColor2.b, var_178_3)

								iter_178_1.color = Color.New(var_178_4, var_178_5, var_178_6)
							else
								local var_178_7 = Mathf.Lerp(iter_178_1.color.r, 0.5, var_178_3)

								iter_178_1.color = Color.New(var_178_7, var_178_7, var_178_7)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.actorSpriteComps10154 then
				for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_178_3 then
						if arg_175_1.isInRecall_ then
							iter_178_3.color = arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_178_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_175_1.var_.actorSpriteComps10154 = nil
			end

			local var_178_8 = arg_175_1.actors_["10154"].transform
			local var_178_9 = 0

			if var_178_9 < arg_175_1.time_ and arg_175_1.time_ <= var_178_9 + arg_178_0 then
				arg_175_1.var_.moveOldPos10154 = var_178_8.localPosition
				var_178_8.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("10154", 7)

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
				local var_178_14 = Vector3.New(0, -2000, 0)

				var_178_8.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10154, var_178_14, var_178_13)
			end

			if arg_175_1.time_ >= var_178_9 + var_178_12 and arg_175_1.time_ < var_178_9 + var_178_12 + arg_178_0 then
				var_178_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_178_15 = arg_175_1.actors_["10155"].transform
			local var_178_16 = 0

			if var_178_16 < arg_175_1.time_ and arg_175_1.time_ <= var_178_16 + arg_178_0 then
				arg_175_1.var_.moveOldPos10155 = var_178_15.localPosition
				var_178_15.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("10155", 7)

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

				var_178_15.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10155, var_178_21, var_178_20)
			end

			if arg_175_1.time_ >= var_178_16 + var_178_19 and arg_175_1.time_ < var_178_16 + var_178_19 + arg_178_0 then
				var_178_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_178_22 = 0
			local var_178_23 = 1.2

			if var_178_22 < arg_175_1.time_ and arg_175_1.time_ <= var_178_22 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_24 = arg_175_1:GetWordFromCfg(424051043)
				local var_178_25 = arg_175_1:FormatText(var_178_24.content)

				arg_175_1.text_.text = var_178_25

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_26 = 48
				local var_178_27 = utf8.len(var_178_25)
				local var_178_28 = var_178_26 <= 0 and var_178_23 or var_178_23 * (var_178_27 / var_178_26)

				if var_178_28 > 0 and var_178_23 < var_178_28 then
					arg_175_1.talkMaxDuration = var_178_28

					if var_178_28 + var_178_22 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_28 + var_178_22
					end
				end

				arg_175_1.text_.text = var_178_25
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_29 = math.max(var_178_23, arg_175_1.talkMaxDuration)

			if var_178_22 <= arg_175_1.time_ and arg_175_1.time_ < var_178_22 + var_178_29 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_22) / var_178_29

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_22 + var_178_29 and arg_175_1.time_ < var_178_22 + var_178_29 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
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

		arg_175_1:InitPlayNodeList()
	end,
	Play424051044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 424051044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play424051045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.034
			local var_182_1 = 1

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				local var_182_2 = "play"
				local var_182_3 = "effect"

				arg_179_1:AudioAction(var_182_2, var_182_3, "se_story_side_1067", "se_story_1067_ring", "")
			end

			local var_182_4 = 0
			local var_182_5 = 1.125

			if var_182_4 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_6 = arg_179_1:GetWordFromCfg(424051044)
				local var_182_7 = arg_179_1:FormatText(var_182_6.content)

				arg_179_1.text_.text = var_182_7

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_8 = 45
				local var_182_9 = utf8.len(var_182_7)
				local var_182_10 = var_182_8 <= 0 and var_182_5 or var_182_5 * (var_182_9 / var_182_8)

				if var_182_10 > 0 and var_182_5 < var_182_10 then
					arg_179_1.talkMaxDuration = var_182_10

					if var_182_10 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_4
					end
				end

				arg_179_1.text_.text = var_182_7
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_11 = math.max(var_182_5, arg_179_1.talkMaxDuration)

			if var_182_4 <= arg_179_1.time_ and arg_179_1.time_ < var_182_4 + var_182_11 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_4) / var_182_11

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_4 + var_182_11 and arg_179_1.time_ < var_182_4 + var_182_11 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play424051045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 424051045
		arg_183_1.duration_ = 2.1

		local var_183_0 = {
			zh = 2.1,
			ja = 1.7
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
				arg_183_0:Play424051046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["10154"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.actorSpriteComps10154 == nil then
				arg_183_1.var_.actorSpriteComps10154 = var_186_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_2 = 0.2

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.actorSpriteComps10154 then
					for iter_186_0, iter_186_1 in pairs(arg_183_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.actorSpriteComps10154 then
				for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_186_3 then
						if arg_183_1.isInRecall_ then
							iter_186_3.color = arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_186_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps10154 = nil
			end

			local var_186_8 = arg_183_1.actors_["10154"].transform
			local var_186_9 = 0

			if var_186_9 < arg_183_1.time_ and arg_183_1.time_ <= var_186_9 + arg_186_0 then
				arg_183_1.var_.moveOldPos10154 = var_186_8.localPosition
				var_186_8.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10154", 2)

				local var_186_10 = var_186_8.childCount

				for iter_186_4 = 0, var_186_10 - 1 do
					local var_186_11 = var_186_8:GetChild(iter_186_4)

					if var_186_11.name == "split_3" then
						var_186_11:SetAsLastSibling()
						var_186_11.gameObject:SetActive(true)

						arg_183_1.var_.actorSpriteSplit10154 = var_186_11.gameObject:GetComponent(typeof(Image))

						arg_183_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_186_12 = 0.001

			if var_186_9 <= arg_183_1.time_ and arg_183_1.time_ < var_186_9 + var_186_12 then
				local var_186_13 = (arg_183_1.time_ - var_186_9) / var_186_12
				local var_186_14 = Vector3.New(-375, -338, -538)

				var_186_8.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10154, var_186_14, var_186_13)

				if arg_183_1.var_.actorSpriteSplit10154 ~= nil then
					arg_183_1.var_.actorSpriteSplit10154:SetAlpha(var_186_13)
				end
			end

			if arg_183_1.time_ >= var_186_9 + var_186_12 and arg_183_1.time_ < var_186_9 + var_186_12 + arg_186_0 then
				var_186_8.localPosition = Vector3.New(-375, -338, -538)

				if arg_183_1.var_.actorSpriteSplit10154 ~= nil then
					arg_183_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_186_15 = 0
			local var_186_16 = 0.275

			if var_186_15 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_17 = arg_183_1:FormatText(StoryNameCfg[1392].name)

				arg_183_1.leftNameTxt_.text = var_186_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_18 = arg_183_1:GetWordFromCfg(424051045)
				local var_186_19 = arg_183_1:FormatText(var_186_18.content)

				arg_183_1.text_.text = var_186_19

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_20 = 11
				local var_186_21 = utf8.len(var_186_19)
				local var_186_22 = var_186_20 <= 0 and var_186_16 or var_186_16 * (var_186_21 / var_186_20)

				if var_186_22 > 0 and var_186_16 < var_186_22 then
					arg_183_1.talkMaxDuration = var_186_22

					if var_186_22 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_22 + var_186_15
					end
				end

				arg_183_1.text_.text = var_186_19
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051045", "story_v_out_424051.awb") ~= 0 then
					local var_186_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051045", "story_v_out_424051.awb") / 1000

					if var_186_23 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_23 + var_186_15
					end

					if var_186_18.prefab_name ~= "" and arg_183_1.actors_[var_186_18.prefab_name] ~= nil then
						local var_186_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_18.prefab_name].transform, "story_v_out_424051", "424051045", "story_v_out_424051.awb")

						arg_183_1:RecordAudio("424051045", var_186_24)
						arg_183_1:RecordAudio("424051045", var_186_24)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_424051", "424051045", "story_v_out_424051.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_424051", "424051045", "story_v_out_424051.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_25 = math.max(var_186_16, arg_183_1.talkMaxDuration)

			if var_186_15 <= arg_183_1.time_ and arg_183_1.time_ < var_186_15 + var_186_25 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_15) / var_186_25

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_15 + var_186_25 and arg_183_1.time_ < var_186_15 + var_186_25 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play424051046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 424051046
		arg_187_1.duration_ = 1.37

		local var_187_0 = {
			zh = 1.066,
			ja = 1.366
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
				arg_187_0:Play424051047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["10155"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.actorSpriteComps10155 == nil then
				arg_187_1.var_.actorSpriteComps10155 = var_190_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_2 = 0.2

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.actorSpriteComps10155 then
					for iter_190_0, iter_190_1 in pairs(arg_187_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.actorSpriteComps10155 then
				for iter_190_2, iter_190_3 in pairs(arg_187_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_190_3 then
						if arg_187_1.isInRecall_ then
							iter_190_3.color = arg_187_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_190_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_187_1.var_.actorSpriteComps10155 = nil
			end

			local var_190_8 = arg_187_1.actors_["10154"]
			local var_190_9 = 0

			if var_190_9 < arg_187_1.time_ and arg_187_1.time_ <= var_190_9 + arg_190_0 and not isNil(var_190_8) and arg_187_1.var_.actorSpriteComps10154 == nil then
				arg_187_1.var_.actorSpriteComps10154 = var_190_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_10 = 0.2

			if var_190_9 <= arg_187_1.time_ and arg_187_1.time_ < var_190_9 + var_190_10 and not isNil(var_190_8) then
				local var_190_11 = (arg_187_1.time_ - var_190_9) / var_190_10

				if arg_187_1.var_.actorSpriteComps10154 then
					for iter_190_4, iter_190_5 in pairs(arg_187_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_187_1.time_ >= var_190_9 + var_190_10 and arg_187_1.time_ < var_190_9 + var_190_10 + arg_190_0 and not isNil(var_190_8) and arg_187_1.var_.actorSpriteComps10154 then
				for iter_190_6, iter_190_7 in pairs(arg_187_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_190_7 then
						if arg_187_1.isInRecall_ then
							iter_190_7.color = arg_187_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_190_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_187_1.var_.actorSpriteComps10154 = nil
			end

			local var_190_16 = arg_187_1.actors_["10155"].transform
			local var_190_17 = 0

			if var_190_17 < arg_187_1.time_ and arg_187_1.time_ <= var_190_17 + arg_190_0 then
				arg_187_1.var_.moveOldPos10155 = var_190_16.localPosition
				var_190_16.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("10155", 4)

				local var_190_18 = var_190_16.childCount

				for iter_190_8 = 0, var_190_18 - 1 do
					local var_190_19 = var_190_16:GetChild(iter_190_8)

					if var_190_19.name == "split_4" or not string.find(var_190_19.name, "split") then
						var_190_19.gameObject:SetActive(true)
					else
						var_190_19.gameObject:SetActive(false)
					end
				end
			end

			local var_190_20 = 0.001

			if var_190_17 <= arg_187_1.time_ and arg_187_1.time_ < var_190_17 + var_190_20 then
				local var_190_21 = (arg_187_1.time_ - var_190_17) / var_190_20
				local var_190_22 = Vector3.New(440, -390, -250)

				var_190_16.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10155, var_190_22, var_190_21)
			end

			if arg_187_1.time_ >= var_190_17 + var_190_20 and arg_187_1.time_ < var_190_17 + var_190_20 + arg_190_0 then
				var_190_16.localPosition = Vector3.New(440, -390, -250)
			end

			local var_190_23 = 0
			local var_190_24 = 0.125

			if var_190_23 < arg_187_1.time_ and arg_187_1.time_ <= var_190_23 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_25 = arg_187_1:FormatText(StoryNameCfg[1391].name)

				arg_187_1.leftNameTxt_.text = var_190_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_26 = arg_187_1:GetWordFromCfg(424051046)
				local var_190_27 = arg_187_1:FormatText(var_190_26.content)

				arg_187_1.text_.text = var_190_27

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_28 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051046", "story_v_out_424051.awb") ~= 0 then
					local var_190_31 = manager.audio:GetVoiceLength("story_v_out_424051", "424051046", "story_v_out_424051.awb") / 1000

					if var_190_31 + var_190_23 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_31 + var_190_23
					end

					if var_190_26.prefab_name ~= "" and arg_187_1.actors_[var_190_26.prefab_name] ~= nil then
						local var_190_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_26.prefab_name].transform, "story_v_out_424051", "424051046", "story_v_out_424051.awb")

						arg_187_1:RecordAudio("424051046", var_190_32)
						arg_187_1:RecordAudio("424051046", var_190_32)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_424051", "424051046", "story_v_out_424051.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_424051", "424051046", "story_v_out_424051.awb")
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
				actorName = "10155",
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
	Play424051047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 424051047
		arg_191_1.duration_ = 7.1

		local var_191_0 = {
			zh = 4.866,
			ja = 7.1
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
				arg_191_0:Play424051048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["10154"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.actorSpriteComps10154 == nil then
				arg_191_1.var_.actorSpriteComps10154 = var_194_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_2 = 0.2

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.actorSpriteComps10154 then
					for iter_194_0, iter_194_1 in pairs(arg_191_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.actorSpriteComps10154 then
				for iter_194_2, iter_194_3 in pairs(arg_191_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_194_3 then
						if arg_191_1.isInRecall_ then
							iter_194_3.color = arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_194_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_191_1.var_.actorSpriteComps10154 = nil
			end

			local var_194_8 = arg_191_1.actors_["10155"]
			local var_194_9 = 0

			if var_194_9 < arg_191_1.time_ and arg_191_1.time_ <= var_194_9 + arg_194_0 and not isNil(var_194_8) and arg_191_1.var_.actorSpriteComps10155 == nil then
				arg_191_1.var_.actorSpriteComps10155 = var_194_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_10 = 0.2

			if var_194_9 <= arg_191_1.time_ and arg_191_1.time_ < var_194_9 + var_194_10 and not isNil(var_194_8) then
				local var_194_11 = (arg_191_1.time_ - var_194_9) / var_194_10

				if arg_191_1.var_.actorSpriteComps10155 then
					for iter_194_4, iter_194_5 in pairs(arg_191_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_191_1.time_ >= var_194_9 + var_194_10 and arg_191_1.time_ < var_194_9 + var_194_10 + arg_194_0 and not isNil(var_194_8) and arg_191_1.var_.actorSpriteComps10155 then
				for iter_194_6, iter_194_7 in pairs(arg_191_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_194_7 then
						if arg_191_1.isInRecall_ then
							iter_194_7.color = arg_191_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_194_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_191_1.var_.actorSpriteComps10155 = nil
			end

			local var_194_16 = arg_191_1.actors_["10154"].transform
			local var_194_17 = 0

			if var_194_17 < arg_191_1.time_ and arg_191_1.time_ <= var_194_17 + arg_194_0 then
				arg_191_1.var_.moveOldPos10154 = var_194_16.localPosition
				var_194_16.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("10154", 2)

				local var_194_18 = var_194_16.childCount

				for iter_194_8 = 0, var_194_18 - 1 do
					local var_194_19 = var_194_16:GetChild(iter_194_8)

					if var_194_19.name == "split_1" then
						var_194_19:SetAsLastSibling()
						var_194_19.gameObject:SetActive(true)

						arg_191_1.var_.actorSpriteSplit10154 = var_194_19.gameObject:GetComponent(typeof(Image))

						arg_191_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_194_20 = 0.5

			if var_194_17 <= arg_191_1.time_ and arg_191_1.time_ < var_194_17 + var_194_20 then
				local var_194_21 = (arg_191_1.time_ - var_194_17) / var_194_20
				local var_194_22 = Vector3.New(-375, -338, -538)

				var_194_16.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10154, var_194_22, var_194_21)

				if arg_191_1.var_.actorSpriteSplit10154 ~= nil then
					arg_191_1.var_.actorSpriteSplit10154:SetAlpha(var_194_21)
				end
			end

			if arg_191_1.time_ >= var_194_17 + var_194_20 and arg_191_1.time_ < var_194_17 + var_194_20 + arg_194_0 then
				var_194_16.localPosition = Vector3.New(-375, -338, -538)

				if arg_191_1.var_.actorSpriteSplit10154 ~= nil then
					arg_191_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_194_23 = 0
			local var_194_24 = 0.625

			if var_194_23 < arg_191_1.time_ and arg_191_1.time_ <= var_194_23 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_25 = arg_191_1:FormatText(StoryNameCfg[1392].name)

				arg_191_1.leftNameTxt_.text = var_194_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_26 = arg_191_1:GetWordFromCfg(424051047)
				local var_194_27 = arg_191_1:FormatText(var_194_26.content)

				arg_191_1.text_.text = var_194_27

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_28 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051047", "story_v_out_424051.awb") ~= 0 then
					local var_194_31 = manager.audio:GetVoiceLength("story_v_out_424051", "424051047", "story_v_out_424051.awb") / 1000

					if var_194_31 + var_194_23 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_31 + var_194_23
					end

					if var_194_26.prefab_name ~= "" and arg_191_1.actors_[var_194_26.prefab_name] ~= nil then
						local var_194_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_26.prefab_name].transform, "story_v_out_424051", "424051047", "story_v_out_424051.awb")

						arg_191_1:RecordAudio("424051047", var_194_32)
						arg_191_1:RecordAudio("424051047", var_194_32)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_424051", "424051047", "story_v_out_424051.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_424051", "424051047", "story_v_out_424051.awb")
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
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play424051048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 424051048
		arg_195_1.duration_ = 8.43

		local var_195_0 = {
			zh = 5.666,
			ja = 8.433
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
				arg_195_0:Play424051049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["10153"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.actorSpriteComps10153 == nil then
				arg_195_1.var_.actorSpriteComps10153 = var_198_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_2 = 0.2

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.actorSpriteComps10153 then
					for iter_198_0, iter_198_1 in pairs(arg_195_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_198_1 then
							if arg_195_1.isInRecall_ then
								local var_198_4 = Mathf.Lerp(iter_198_1.color.r, arg_195_1.hightColor1.r, var_198_3)
								local var_198_5 = Mathf.Lerp(iter_198_1.color.g, arg_195_1.hightColor1.g, var_198_3)
								local var_198_6 = Mathf.Lerp(iter_198_1.color.b, arg_195_1.hightColor1.b, var_198_3)

								iter_198_1.color = Color.New(var_198_4, var_198_5, var_198_6)
							else
								local var_198_7 = Mathf.Lerp(iter_198_1.color.r, 1, var_198_3)

								iter_198_1.color = Color.New(var_198_7, var_198_7, var_198_7)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.actorSpriteComps10153 then
				for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_198_3 then
						if arg_195_1.isInRecall_ then
							iter_198_3.color = arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_198_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_195_1.var_.actorSpriteComps10153 = nil
			end

			local var_198_8 = arg_195_1.actors_["10154"]
			local var_198_9 = 0

			if var_198_9 < arg_195_1.time_ and arg_195_1.time_ <= var_198_9 + arg_198_0 and not isNil(var_198_8) and arg_195_1.var_.actorSpriteComps10154 == nil then
				arg_195_1.var_.actorSpriteComps10154 = var_198_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_10 = 0.2

			if var_198_9 <= arg_195_1.time_ and arg_195_1.time_ < var_198_9 + var_198_10 and not isNil(var_198_8) then
				local var_198_11 = (arg_195_1.time_ - var_198_9) / var_198_10

				if arg_195_1.var_.actorSpriteComps10154 then
					for iter_198_4, iter_198_5 in pairs(arg_195_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_198_5 then
							if arg_195_1.isInRecall_ then
								local var_198_12 = Mathf.Lerp(iter_198_5.color.r, arg_195_1.hightColor2.r, var_198_11)
								local var_198_13 = Mathf.Lerp(iter_198_5.color.g, arg_195_1.hightColor2.g, var_198_11)
								local var_198_14 = Mathf.Lerp(iter_198_5.color.b, arg_195_1.hightColor2.b, var_198_11)

								iter_198_5.color = Color.New(var_198_12, var_198_13, var_198_14)
							else
								local var_198_15 = Mathf.Lerp(iter_198_5.color.r, 0.5, var_198_11)

								iter_198_5.color = Color.New(var_198_15, var_198_15, var_198_15)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= var_198_9 + var_198_10 and arg_195_1.time_ < var_198_9 + var_198_10 + arg_198_0 and not isNil(var_198_8) and arg_195_1.var_.actorSpriteComps10154 then
				for iter_198_6, iter_198_7 in pairs(arg_195_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_198_7 then
						if arg_195_1.isInRecall_ then
							iter_198_7.color = arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_198_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_195_1.var_.actorSpriteComps10154 = nil
			end

			local var_198_16 = arg_195_1.actors_["10153"].transform
			local var_198_17 = 0

			if var_198_17 < arg_195_1.time_ and arg_195_1.time_ <= var_198_17 + arg_198_0 then
				arg_195_1.var_.moveOldPos10153 = var_198_16.localPosition
				var_198_16.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10153", 4)

				local var_198_18 = var_198_16.childCount

				for iter_198_8 = 0, var_198_18 - 1 do
					local var_198_19 = var_198_16:GetChild(iter_198_8)

					if var_198_19.name == "" or not string.find(var_198_19.name, "split") then
						var_198_19.gameObject:SetActive(true)
					else
						var_198_19.gameObject:SetActive(false)
					end
				end
			end

			local var_198_20 = 0.001

			if var_198_17 <= arg_195_1.time_ and arg_195_1.time_ < var_198_17 + var_198_20 then
				local var_198_21 = (arg_195_1.time_ - var_198_17) / var_198_20
				local var_198_22 = Vector3.New(400, -395, -330)

				var_198_16.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10153, var_198_22, var_198_21)
			end

			if arg_195_1.time_ >= var_198_17 + var_198_20 and arg_195_1.time_ < var_198_17 + var_198_20 + arg_198_0 then
				var_198_16.localPosition = Vector3.New(400, -395, -330)
			end

			local var_198_23 = arg_195_1.actors_["10155"].transform
			local var_198_24 = 0

			if var_198_24 < arg_195_1.time_ and arg_195_1.time_ <= var_198_24 + arg_198_0 then
				arg_195_1.var_.moveOldPos10155 = var_198_23.localPosition
				var_198_23.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10155", 7)

				local var_198_25 = var_198_23.childCount

				for iter_198_9 = 0, var_198_25 - 1 do
					local var_198_26 = var_198_23:GetChild(iter_198_9)

					if var_198_26.name == "" or not string.find(var_198_26.name, "split") then
						var_198_26.gameObject:SetActive(true)
					else
						var_198_26.gameObject:SetActive(false)
					end
				end
			end

			local var_198_27 = 0.001

			if var_198_24 <= arg_195_1.time_ and arg_195_1.time_ < var_198_24 + var_198_27 then
				local var_198_28 = (arg_195_1.time_ - var_198_24) / var_198_27
				local var_198_29 = Vector3.New(0, -2000, 0)

				var_198_23.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10155, var_198_29, var_198_28)
			end

			if arg_195_1.time_ >= var_198_24 + var_198_27 and arg_195_1.time_ < var_198_24 + var_198_27 + arg_198_0 then
				var_198_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_198_30 = 0
			local var_198_31 = 0.6

			if var_198_30 < arg_195_1.time_ and arg_195_1.time_ <= var_198_30 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_32 = arg_195_1:FormatText(StoryNameCfg[1387].name)

				arg_195_1.leftNameTxt_.text = var_198_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_33 = arg_195_1:GetWordFromCfg(424051048)
				local var_198_34 = arg_195_1:FormatText(var_198_33.content)

				arg_195_1.text_.text = var_198_34

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_35 = 24
				local var_198_36 = utf8.len(var_198_34)
				local var_198_37 = var_198_35 <= 0 and var_198_31 or var_198_31 * (var_198_36 / var_198_35)

				if var_198_37 > 0 and var_198_31 < var_198_37 then
					arg_195_1.talkMaxDuration = var_198_37

					if var_198_37 + var_198_30 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_37 + var_198_30
					end
				end

				arg_195_1.text_.text = var_198_34
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051048", "story_v_out_424051.awb") ~= 0 then
					local var_198_38 = manager.audio:GetVoiceLength("story_v_out_424051", "424051048", "story_v_out_424051.awb") / 1000

					if var_198_38 + var_198_30 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_38 + var_198_30
					end

					if var_198_33.prefab_name ~= "" and arg_195_1.actors_[var_198_33.prefab_name] ~= nil then
						local var_198_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_33.prefab_name].transform, "story_v_out_424051", "424051048", "story_v_out_424051.awb")

						arg_195_1:RecordAudio("424051048", var_198_39)
						arg_195_1:RecordAudio("424051048", var_198_39)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_424051", "424051048", "story_v_out_424051.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_424051", "424051048", "story_v_out_424051.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_40 = math.max(var_198_31, arg_195_1.talkMaxDuration)

			if var_198_30 <= arg_195_1.time_ and arg_195_1.time_ < var_198_30 + var_198_40 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_30) / var_198_40

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_30 + var_198_40 and arg_195_1.time_ < var_198_30 + var_198_40 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
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
				actorName = "10155",
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
	Play424051049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 424051049
		arg_199_1.duration_ = 2.27

		local var_199_0 = {
			zh = 1.7,
			ja = 2.266
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
				arg_199_0:Play424051050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["10154"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.actorSpriteComps10154 == nil then
				arg_199_1.var_.actorSpriteComps10154 = var_202_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_2 = 0.2

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.actorSpriteComps10154 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_202_1 then
							if arg_199_1.isInRecall_ then
								local var_202_4 = Mathf.Lerp(iter_202_1.color.r, arg_199_1.hightColor1.r, var_202_3)
								local var_202_5 = Mathf.Lerp(iter_202_1.color.g, arg_199_1.hightColor1.g, var_202_3)
								local var_202_6 = Mathf.Lerp(iter_202_1.color.b, arg_199_1.hightColor1.b, var_202_3)

								iter_202_1.color = Color.New(var_202_4, var_202_5, var_202_6)
							else
								local var_202_7 = Mathf.Lerp(iter_202_1.color.r, 1, var_202_3)

								iter_202_1.color = Color.New(var_202_7, var_202_7, var_202_7)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.actorSpriteComps10154 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_202_3 then
						if arg_199_1.isInRecall_ then
							iter_202_3.color = arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_202_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps10154 = nil
			end

			local var_202_8 = arg_199_1.actors_["10153"]
			local var_202_9 = 0

			if var_202_9 < arg_199_1.time_ and arg_199_1.time_ <= var_202_9 + arg_202_0 and not isNil(var_202_8) and arg_199_1.var_.actorSpriteComps10153 == nil then
				arg_199_1.var_.actorSpriteComps10153 = var_202_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_10 = 0.2

			if var_202_9 <= arg_199_1.time_ and arg_199_1.time_ < var_202_9 + var_202_10 and not isNil(var_202_8) then
				local var_202_11 = (arg_199_1.time_ - var_202_9) / var_202_10

				if arg_199_1.var_.actorSpriteComps10153 then
					for iter_202_4, iter_202_5 in pairs(arg_199_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_202_5 then
							if arg_199_1.isInRecall_ then
								local var_202_12 = Mathf.Lerp(iter_202_5.color.r, arg_199_1.hightColor2.r, var_202_11)
								local var_202_13 = Mathf.Lerp(iter_202_5.color.g, arg_199_1.hightColor2.g, var_202_11)
								local var_202_14 = Mathf.Lerp(iter_202_5.color.b, arg_199_1.hightColor2.b, var_202_11)

								iter_202_5.color = Color.New(var_202_12, var_202_13, var_202_14)
							else
								local var_202_15 = Mathf.Lerp(iter_202_5.color.r, 0.5, var_202_11)

								iter_202_5.color = Color.New(var_202_15, var_202_15, var_202_15)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= var_202_9 + var_202_10 and arg_199_1.time_ < var_202_9 + var_202_10 + arg_202_0 and not isNil(var_202_8) and arg_199_1.var_.actorSpriteComps10153 then
				for iter_202_6, iter_202_7 in pairs(arg_199_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_202_7 then
						if arg_199_1.isInRecall_ then
							iter_202_7.color = arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_202_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps10153 = nil
			end

			local var_202_16 = arg_199_1.actors_["10154"].transform
			local var_202_17 = 0

			if var_202_17 < arg_199_1.time_ and arg_199_1.time_ <= var_202_17 + arg_202_0 then
				arg_199_1.var_.moveOldPos10154 = var_202_16.localPosition
				var_202_16.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("10154", 2)

				local var_202_18 = var_202_16.childCount

				for iter_202_8 = 0, var_202_18 - 1 do
					local var_202_19 = var_202_16:GetChild(iter_202_8)

					if var_202_19.name == "" or not string.find(var_202_19.name, "split") then
						var_202_19.gameObject:SetActive(true)
					else
						var_202_19.gameObject:SetActive(false)
					end
				end
			end

			local var_202_20 = 0.001

			if var_202_17 <= arg_199_1.time_ and arg_199_1.time_ < var_202_17 + var_202_20 then
				local var_202_21 = (arg_199_1.time_ - var_202_17) / var_202_20
				local var_202_22 = Vector3.New(-375, -338, -538)

				var_202_16.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10154, var_202_22, var_202_21)
			end

			if arg_199_1.time_ >= var_202_17 + var_202_20 and arg_199_1.time_ < var_202_17 + var_202_20 + arg_202_0 then
				var_202_16.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_202_23 = 0
			local var_202_24 = 0.225

			if var_202_23 < arg_199_1.time_ and arg_199_1.time_ <= var_202_23 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_25 = arg_199_1:FormatText(StoryNameCfg[1392].name)

				arg_199_1.leftNameTxt_.text = var_202_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_26 = arg_199_1:GetWordFromCfg(424051049)
				local var_202_27 = arg_199_1:FormatText(var_202_26.content)

				arg_199_1.text_.text = var_202_27

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_28 = 9
				local var_202_29 = utf8.len(var_202_27)
				local var_202_30 = var_202_28 <= 0 and var_202_24 or var_202_24 * (var_202_29 / var_202_28)

				if var_202_30 > 0 and var_202_24 < var_202_30 then
					arg_199_1.talkMaxDuration = var_202_30

					if var_202_30 + var_202_23 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_30 + var_202_23
					end
				end

				arg_199_1.text_.text = var_202_27
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051049", "story_v_out_424051.awb") ~= 0 then
					local var_202_31 = manager.audio:GetVoiceLength("story_v_out_424051", "424051049", "story_v_out_424051.awb") / 1000

					if var_202_31 + var_202_23 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_31 + var_202_23
					end

					if var_202_26.prefab_name ~= "" and arg_199_1.actors_[var_202_26.prefab_name] ~= nil then
						local var_202_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_26.prefab_name].transform, "story_v_out_424051", "424051049", "story_v_out_424051.awb")

						arg_199_1:RecordAudio("424051049", var_202_32)
						arg_199_1:RecordAudio("424051049", var_202_32)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_424051", "424051049", "story_v_out_424051.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_424051", "424051049", "story_v_out_424051.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_33 = math.max(var_202_24, arg_199_1.talkMaxDuration)

			if var_202_23 <= arg_199_1.time_ and arg_199_1.time_ < var_202_23 + var_202_33 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_23) / var_202_33

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_23 + var_202_33 and arg_199_1.time_ < var_202_23 + var_202_33 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
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
	Play424051050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 424051050
		arg_203_1.duration_ = 3.37

		local var_203_0 = {
			zh = 3.366,
			ja = 1.433
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
				arg_203_0:Play424051051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["10154"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos10154 = var_206_0.localPosition
				var_206_0.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("10154", 2)

				local var_206_2 = var_206_0.childCount

				for iter_206_0 = 0, var_206_2 - 1 do
					local var_206_3 = var_206_0:GetChild(iter_206_0)

					if var_206_3.name == "" or not string.find(var_206_3.name, "split") then
						var_206_3.gameObject:SetActive(true)
					else
						var_206_3.gameObject:SetActive(false)
					end
				end
			end

			local var_206_4 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_4 then
				local var_206_5 = (arg_203_1.time_ - var_206_1) / var_206_4
				local var_206_6 = Vector3.New(-375, -338, -538)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10154, var_206_6, var_206_5)
			end

			if arg_203_1.time_ >= var_206_1 + var_206_4 and arg_203_1.time_ < var_206_1 + var_206_4 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_206_7 = 0
			local var_206_8 = 0.55

			if var_206_7 < arg_203_1.time_ and arg_203_1.time_ <= var_206_7 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_9 = arg_203_1:FormatText(StoryNameCfg[1392].name)

				arg_203_1.leftNameTxt_.text = var_206_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_10 = arg_203_1:GetWordFromCfg(424051050)
				local var_206_11 = arg_203_1:FormatText(var_206_10.content)

				arg_203_1.text_.text = var_206_11

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_12 = 22
				local var_206_13 = utf8.len(var_206_11)
				local var_206_14 = var_206_12 <= 0 and var_206_8 or var_206_8 * (var_206_13 / var_206_12)

				if var_206_14 > 0 and var_206_8 < var_206_14 then
					arg_203_1.talkMaxDuration = var_206_14

					if var_206_14 + var_206_7 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_14 + var_206_7
					end
				end

				arg_203_1.text_.text = var_206_11
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051050", "story_v_out_424051.awb") ~= 0 then
					local var_206_15 = manager.audio:GetVoiceLength("story_v_out_424051", "424051050", "story_v_out_424051.awb") / 1000

					if var_206_15 + var_206_7 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_15 + var_206_7
					end

					if var_206_10.prefab_name ~= "" and arg_203_1.actors_[var_206_10.prefab_name] ~= nil then
						local var_206_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_10.prefab_name].transform, "story_v_out_424051", "424051050", "story_v_out_424051.awb")

						arg_203_1:RecordAudio("424051050", var_206_16)
						arg_203_1:RecordAudio("424051050", var_206_16)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_424051", "424051050", "story_v_out_424051.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_424051", "424051050", "story_v_out_424051.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_17 = math.max(var_206_8, arg_203_1.talkMaxDuration)

			if var_206_7 <= arg_203_1.time_ and arg_203_1.time_ < var_206_7 + var_206_17 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_7) / var_206_17

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_7 + var_206_17 and arg_203_1.time_ < var_206_7 + var_206_17 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
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
	Play424051051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 424051051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play424051052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["10154"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.actorSpriteComps10154 == nil then
				arg_207_1.var_.actorSpriteComps10154 = var_210_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_2 = 0.2

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.actorSpriteComps10154 then
					for iter_210_0, iter_210_1 in pairs(arg_207_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_210_1 then
							if arg_207_1.isInRecall_ then
								local var_210_4 = Mathf.Lerp(iter_210_1.color.r, arg_207_1.hightColor2.r, var_210_3)
								local var_210_5 = Mathf.Lerp(iter_210_1.color.g, arg_207_1.hightColor2.g, var_210_3)
								local var_210_6 = Mathf.Lerp(iter_210_1.color.b, arg_207_1.hightColor2.b, var_210_3)

								iter_210_1.color = Color.New(var_210_4, var_210_5, var_210_6)
							else
								local var_210_7 = Mathf.Lerp(iter_210_1.color.r, 0.5, var_210_3)

								iter_210_1.color = Color.New(var_210_7, var_210_7, var_210_7)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.actorSpriteComps10154 then
				for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_210_3 then
						if arg_207_1.isInRecall_ then
							iter_210_3.color = arg_207_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_210_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_207_1.var_.actorSpriteComps10154 = nil
			end

			local var_210_8 = 0
			local var_210_9 = 0.15

			if var_210_8 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_10 = arg_207_1:FormatText(StoryNameCfg[7].name)

				arg_207_1.leftNameTxt_.text = var_210_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_11 = arg_207_1:GetWordFromCfg(424051051)
				local var_210_12 = arg_207_1:FormatText(var_210_11.content)

				arg_207_1.text_.text = var_210_12

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_13 = 6
				local var_210_14 = utf8.len(var_210_12)
				local var_210_15 = var_210_13 <= 0 and var_210_9 or var_210_9 * (var_210_14 / var_210_13)

				if var_210_15 > 0 and var_210_9 < var_210_15 then
					arg_207_1.talkMaxDuration = var_210_15

					if var_210_15 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_15 + var_210_8
					end
				end

				arg_207_1.text_.text = var_210_12
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_16 = math.max(var_210_9, arg_207_1.talkMaxDuration)

			if var_210_8 <= arg_207_1.time_ and arg_207_1.time_ < var_210_8 + var_210_16 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_8) / var_210_16

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_8 + var_210_16 and arg_207_1.time_ < var_210_8 + var_210_16 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play424051052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 424051052
		arg_211_1.duration_ = 12.6

		local var_211_0 = {
			zh = 9.3,
			ja = 12.6
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
				arg_211_0:Play424051053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["10155"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.actorSpriteComps10155 == nil then
				arg_211_1.var_.actorSpriteComps10155 = var_214_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_2 = 0.2

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.actorSpriteComps10155 then
					for iter_214_0, iter_214_1 in pairs(arg_211_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_214_1 then
							if arg_211_1.isInRecall_ then
								local var_214_4 = Mathf.Lerp(iter_214_1.color.r, arg_211_1.hightColor1.r, var_214_3)
								local var_214_5 = Mathf.Lerp(iter_214_1.color.g, arg_211_1.hightColor1.g, var_214_3)
								local var_214_6 = Mathf.Lerp(iter_214_1.color.b, arg_211_1.hightColor1.b, var_214_3)

								iter_214_1.color = Color.New(var_214_4, var_214_5, var_214_6)
							else
								local var_214_7 = Mathf.Lerp(iter_214_1.color.r, 1, var_214_3)

								iter_214_1.color = Color.New(var_214_7, var_214_7, var_214_7)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.actorSpriteComps10155 then
				for iter_214_2, iter_214_3 in pairs(arg_211_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_214_3 then
						if arg_211_1.isInRecall_ then
							iter_214_3.color = arg_211_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_214_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_211_1.var_.actorSpriteComps10155 = nil
			end

			local var_214_8 = arg_211_1.actors_["10154"].transform
			local var_214_9 = 0

			if var_214_9 < arg_211_1.time_ and arg_211_1.time_ <= var_214_9 + arg_214_0 then
				arg_211_1.var_.moveOldPos10154 = var_214_8.localPosition
				var_214_8.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("10154", 7)

				local var_214_10 = var_214_8.childCount

				for iter_214_4 = 0, var_214_10 - 1 do
					local var_214_11 = var_214_8:GetChild(iter_214_4)

					if var_214_11.name == "" or not string.find(var_214_11.name, "split") then
						var_214_11.gameObject:SetActive(true)
					else
						var_214_11.gameObject:SetActive(false)
					end
				end
			end

			local var_214_12 = 0.001

			if var_214_9 <= arg_211_1.time_ and arg_211_1.time_ < var_214_9 + var_214_12 then
				local var_214_13 = (arg_211_1.time_ - var_214_9) / var_214_12
				local var_214_14 = Vector3.New(0, -2000, 0)

				var_214_8.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10154, var_214_14, var_214_13)
			end

			if arg_211_1.time_ >= var_214_9 + var_214_12 and arg_211_1.time_ < var_214_9 + var_214_12 + arg_214_0 then
				var_214_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_214_15 = arg_211_1.actors_["10153"].transform
			local var_214_16 = 0

			if var_214_16 < arg_211_1.time_ and arg_211_1.time_ <= var_214_16 + arg_214_0 then
				arg_211_1.var_.moveOldPos10153 = var_214_15.localPosition
				var_214_15.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("10153", 7)

				local var_214_17 = var_214_15.childCount

				for iter_214_5 = 0, var_214_17 - 1 do
					local var_214_18 = var_214_15:GetChild(iter_214_5)

					if var_214_18.name == "" or not string.find(var_214_18.name, "split") then
						var_214_18.gameObject:SetActive(true)
					else
						var_214_18.gameObject:SetActive(false)
					end
				end
			end

			local var_214_19 = 0.001

			if var_214_16 <= arg_211_1.time_ and arg_211_1.time_ < var_214_16 + var_214_19 then
				local var_214_20 = (arg_211_1.time_ - var_214_16) / var_214_19
				local var_214_21 = Vector3.New(0, -2000, 0)

				var_214_15.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10153, var_214_21, var_214_20)
			end

			if arg_211_1.time_ >= var_214_16 + var_214_19 and arg_211_1.time_ < var_214_16 + var_214_19 + arg_214_0 then
				var_214_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_214_22 = arg_211_1.actors_["10155"].transform
			local var_214_23 = 0

			if var_214_23 < arg_211_1.time_ and arg_211_1.time_ <= var_214_23 + arg_214_0 then
				arg_211_1.var_.moveOldPos10155 = var_214_22.localPosition
				var_214_22.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("10155", 3)

				local var_214_24 = var_214_22.childCount

				for iter_214_6 = 0, var_214_24 - 1 do
					local var_214_25 = var_214_22:GetChild(iter_214_6)

					if var_214_25.name == "" or not string.find(var_214_25.name, "split") then
						var_214_25.gameObject:SetActive(true)
					else
						var_214_25.gameObject:SetActive(false)
					end
				end
			end

			local var_214_26 = 0.001

			if var_214_23 <= arg_211_1.time_ and arg_211_1.time_ < var_214_23 + var_214_26 then
				local var_214_27 = (arg_211_1.time_ - var_214_23) / var_214_26
				local var_214_28 = Vector3.New(-40, -390, -250)

				var_214_22.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10155, var_214_28, var_214_27)
			end

			if arg_211_1.time_ >= var_214_23 + var_214_26 and arg_211_1.time_ < var_214_23 + var_214_26 + arg_214_0 then
				var_214_22.localPosition = Vector3.New(-40, -390, -250)
			end

			local var_214_29 = 0
			local var_214_30 = 1

			if var_214_29 < arg_211_1.time_ and arg_211_1.time_ <= var_214_29 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_31 = arg_211_1:FormatText(StoryNameCfg[1391].name)

				arg_211_1.leftNameTxt_.text = var_214_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_32 = arg_211_1:GetWordFromCfg(424051052)
				local var_214_33 = arg_211_1:FormatText(var_214_32.content)

				arg_211_1.text_.text = var_214_33

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_34 = 40
				local var_214_35 = utf8.len(var_214_33)
				local var_214_36 = var_214_34 <= 0 and var_214_30 or var_214_30 * (var_214_35 / var_214_34)

				if var_214_36 > 0 and var_214_30 < var_214_36 then
					arg_211_1.talkMaxDuration = var_214_36

					if var_214_36 + var_214_29 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_36 + var_214_29
					end
				end

				arg_211_1.text_.text = var_214_33
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051052", "story_v_out_424051.awb") ~= 0 then
					local var_214_37 = manager.audio:GetVoiceLength("story_v_out_424051", "424051052", "story_v_out_424051.awb") / 1000

					if var_214_37 + var_214_29 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_37 + var_214_29
					end

					if var_214_32.prefab_name ~= "" and arg_211_1.actors_[var_214_32.prefab_name] ~= nil then
						local var_214_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_32.prefab_name].transform, "story_v_out_424051", "424051052", "story_v_out_424051.awb")

						arg_211_1:RecordAudio("424051052", var_214_38)
						arg_211_1:RecordAudio("424051052", var_214_38)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_424051", "424051052", "story_v_out_424051.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_424051", "424051052", "story_v_out_424051.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_39 = math.max(var_214_30, arg_211_1.talkMaxDuration)

			if var_214_29 <= arg_211_1.time_ and arg_211_1.time_ < var_214_29 + var_214_39 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_29) / var_214_39

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_29 + var_214_39 and arg_211_1.time_ < var_214_29 + var_214_39 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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
				actorName = "10155",
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
	Play424051053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 424051053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play424051054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["10155"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.actorSpriteComps10155 == nil then
				arg_215_1.var_.actorSpriteComps10155 = var_218_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_2 = 0.2

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.actorSpriteComps10155 then
					for iter_218_0, iter_218_1 in pairs(arg_215_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_218_1 then
							if arg_215_1.isInRecall_ then
								local var_218_4 = Mathf.Lerp(iter_218_1.color.r, arg_215_1.hightColor2.r, var_218_3)
								local var_218_5 = Mathf.Lerp(iter_218_1.color.g, arg_215_1.hightColor2.g, var_218_3)
								local var_218_6 = Mathf.Lerp(iter_218_1.color.b, arg_215_1.hightColor2.b, var_218_3)

								iter_218_1.color = Color.New(var_218_4, var_218_5, var_218_6)
							else
								local var_218_7 = Mathf.Lerp(iter_218_1.color.r, 0.5, var_218_3)

								iter_218_1.color = Color.New(var_218_7, var_218_7, var_218_7)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.actorSpriteComps10155 then
				for iter_218_2, iter_218_3 in pairs(arg_215_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_218_3 then
						if arg_215_1.isInRecall_ then
							iter_218_3.color = arg_215_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_218_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_215_1.var_.actorSpriteComps10155 = nil
			end

			local var_218_8 = arg_215_1.actors_["10155"].transform
			local var_218_9 = 0

			if var_218_9 < arg_215_1.time_ and arg_215_1.time_ <= var_218_9 + arg_218_0 then
				arg_215_1.var_.moveOldPos10155 = var_218_8.localPosition
				var_218_8.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("10155", 7)

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
				local var_218_14 = Vector3.New(0, -2000, 0)

				var_218_8.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10155, var_218_14, var_218_13)
			end

			if arg_215_1.time_ >= var_218_9 + var_218_12 and arg_215_1.time_ < var_218_9 + var_218_12 + arg_218_0 then
				var_218_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_218_15 = 0
			local var_218_16 = 0.9

			if var_218_15 < arg_215_1.time_ and arg_215_1.time_ <= var_218_15 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_17 = arg_215_1:GetWordFromCfg(424051053)
				local var_218_18 = arg_215_1:FormatText(var_218_17.content)

				arg_215_1.text_.text = var_218_18

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_19 = 36
				local var_218_20 = utf8.len(var_218_18)
				local var_218_21 = var_218_19 <= 0 and var_218_16 or var_218_16 * (var_218_20 / var_218_19)

				if var_218_21 > 0 and var_218_16 < var_218_21 then
					arg_215_1.talkMaxDuration = var_218_21

					if var_218_21 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_21 + var_218_15
					end
				end

				arg_215_1.text_.text = var_218_18
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_22 = math.max(var_218_16, arg_215_1.talkMaxDuration)

			if var_218_15 <= arg_215_1.time_ and arg_215_1.time_ < var_218_15 + var_218_22 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_15) / var_218_22

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_15 + var_218_22 and arg_215_1.time_ < var_218_15 + var_218_22 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
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

		arg_215_1:InitPlayNodeList()
	end,
	Play424051054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 424051054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play424051055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 0.4

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_2 = arg_219_1:FormatText(StoryNameCfg[7].name)

				arg_219_1.leftNameTxt_.text = var_222_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:GetWordFromCfg(424051054)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 16
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
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_8 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_8 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_8

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_8 and arg_219_1.time_ < var_222_0 + var_222_8 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play424051055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 424051055
		arg_223_1.duration_ = 3.53

		local var_223_0 = {
			zh = 1.433,
			ja = 3.533
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
				arg_223_0:Play424051056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["10155"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.actorSpriteComps10155 == nil then
				arg_223_1.var_.actorSpriteComps10155 = var_226_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_2 = 0.2

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.actorSpriteComps10155 then
					for iter_226_0, iter_226_1 in pairs(arg_223_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.actorSpriteComps10155 then
				for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_226_3 then
						if arg_223_1.isInRecall_ then
							iter_226_3.color = arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_226_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_223_1.var_.actorSpriteComps10155 = nil
			end

			local var_226_8 = arg_223_1.actors_["10155"].transform
			local var_226_9 = 0

			if var_226_9 < arg_223_1.time_ and arg_223_1.time_ <= var_226_9 + arg_226_0 then
				arg_223_1.var_.moveOldPos10155 = var_226_8.localPosition
				var_226_8.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("10155", 3)

				local var_226_10 = var_226_8.childCount

				for iter_226_4 = 0, var_226_10 - 1 do
					local var_226_11 = var_226_8:GetChild(iter_226_4)

					if var_226_11.name == "split_4" then
						var_226_11:SetAsLastSibling()
						var_226_11.gameObject:SetActive(true)

						arg_223_1.var_.actorSpriteSplit10155 = var_226_11.gameObject:GetComponent(typeof(Image))

						arg_223_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_226_12 = 0.001

			if var_226_9 <= arg_223_1.time_ and arg_223_1.time_ < var_226_9 + var_226_12 then
				local var_226_13 = (arg_223_1.time_ - var_226_9) / var_226_12
				local var_226_14 = Vector3.New(-40, -390, -250)

				var_226_8.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10155, var_226_14, var_226_13)

				if arg_223_1.var_.actorSpriteSplit10155 ~= nil then
					arg_223_1.var_.actorSpriteSplit10155:SetAlpha(var_226_13)
				end
			end

			if arg_223_1.time_ >= var_226_9 + var_226_12 and arg_223_1.time_ < var_226_9 + var_226_12 + arg_226_0 then
				var_226_8.localPosition = Vector3.New(-40, -390, -250)

				if arg_223_1.var_.actorSpriteSplit10155 ~= nil then
					arg_223_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_226_15 = 0
			local var_226_16 = 0.175

			if var_226_15 < arg_223_1.time_ and arg_223_1.time_ <= var_226_15 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_17 = arg_223_1:FormatText(StoryNameCfg[1391].name)

				arg_223_1.leftNameTxt_.text = var_226_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_18 = arg_223_1:GetWordFromCfg(424051055)
				local var_226_19 = arg_223_1:FormatText(var_226_18.content)

				arg_223_1.text_.text = var_226_19

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_20 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051055", "story_v_out_424051.awb") ~= 0 then
					local var_226_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051055", "story_v_out_424051.awb") / 1000

					if var_226_23 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_23 + var_226_15
					end

					if var_226_18.prefab_name ~= "" and arg_223_1.actors_[var_226_18.prefab_name] ~= nil then
						local var_226_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_18.prefab_name].transform, "story_v_out_424051", "424051055", "story_v_out_424051.awb")

						arg_223_1:RecordAudio("424051055", var_226_24)
						arg_223_1:RecordAudio("424051055", var_226_24)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_424051", "424051055", "story_v_out_424051.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_424051", "424051055", "story_v_out_424051.awb")
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
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play424051056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 424051056
		arg_227_1.duration_ = 1.7

		local var_227_0 = {
			zh = 1.133,
			ja = 1.7
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
				arg_227_0:Play424051057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["10155"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.actorSpriteComps10155 == nil then
				arg_227_1.var_.actorSpriteComps10155 = var_230_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_2 = 0.2

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.actorSpriteComps10155 then
					for iter_230_0, iter_230_1 in pairs(arg_227_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_230_1 then
							if arg_227_1.isInRecall_ then
								local var_230_4 = Mathf.Lerp(iter_230_1.color.r, arg_227_1.hightColor2.r, var_230_3)
								local var_230_5 = Mathf.Lerp(iter_230_1.color.g, arg_227_1.hightColor2.g, var_230_3)
								local var_230_6 = Mathf.Lerp(iter_230_1.color.b, arg_227_1.hightColor2.b, var_230_3)

								iter_230_1.color = Color.New(var_230_4, var_230_5, var_230_6)
							else
								local var_230_7 = Mathf.Lerp(iter_230_1.color.r, 0.5, var_230_3)

								iter_230_1.color = Color.New(var_230_7, var_230_7, var_230_7)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.actorSpriteComps10155 then
				for iter_230_2, iter_230_3 in pairs(arg_227_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_230_3 then
						if arg_227_1.isInRecall_ then
							iter_230_3.color = arg_227_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_230_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_227_1.var_.actorSpriteComps10155 = nil
			end

			local var_230_8 = 0
			local var_230_9 = 0.125

			if var_230_8 < arg_227_1.time_ and arg_227_1.time_ <= var_230_8 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_10 = arg_227_1:FormatText(StoryNameCfg[177].name)

				arg_227_1.leftNameTxt_.text = var_230_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_11 = arg_227_1:GetWordFromCfg(424051056)
				local var_230_12 = arg_227_1:FormatText(var_230_11.content)

				arg_227_1.text_.text = var_230_12

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_13 = 5
				local var_230_14 = utf8.len(var_230_12)
				local var_230_15 = var_230_13 <= 0 and var_230_9 or var_230_9 * (var_230_14 / var_230_13)

				if var_230_15 > 0 and var_230_9 < var_230_15 then
					arg_227_1.talkMaxDuration = var_230_15

					if var_230_15 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_15 + var_230_8
					end
				end

				arg_227_1.text_.text = var_230_12
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051056", "story_v_out_424051.awb") ~= 0 then
					local var_230_16 = manager.audio:GetVoiceLength("story_v_out_424051", "424051056", "story_v_out_424051.awb") / 1000

					if var_230_16 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_16 + var_230_8
					end

					if var_230_11.prefab_name ~= "" and arg_227_1.actors_[var_230_11.prefab_name] ~= nil then
						local var_230_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_11.prefab_name].transform, "story_v_out_424051", "424051056", "story_v_out_424051.awb")

						arg_227_1:RecordAudio("424051056", var_230_17)
						arg_227_1:RecordAudio("424051056", var_230_17)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_424051", "424051056", "story_v_out_424051.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_424051", "424051056", "story_v_out_424051.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_18 = math.max(var_230_9, arg_227_1.talkMaxDuration)

			if var_230_8 <= arg_227_1.time_ and arg_227_1.time_ < var_230_8 + var_230_18 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_8) / var_230_18

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_8 + var_230_18 and arg_227_1.time_ < var_230_8 + var_230_18 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play424051057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 424051057
		arg_231_1.duration_ = 13.3

		local var_231_0 = {
			zh = 8.1,
			ja = 13.3
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
				arg_231_0:Play424051058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["10155"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps10155 == nil then
				arg_231_1.var_.actorSpriteComps10155 = var_234_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_2 = 0.2

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.actorSpriteComps10155 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps10155 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_234_3 then
						if arg_231_1.isInRecall_ then
							iter_234_3.color = arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_234_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps10155 = nil
			end

			local var_234_8 = arg_231_1.actors_["10155"].transform
			local var_234_9 = 0

			if var_234_9 < arg_231_1.time_ and arg_231_1.time_ <= var_234_9 + arg_234_0 then
				arg_231_1.var_.moveOldPos10155 = var_234_8.localPosition
				var_234_8.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("10155", 3)

				local var_234_10 = var_234_8.childCount

				for iter_234_4 = 0, var_234_10 - 1 do
					local var_234_11 = var_234_8:GetChild(iter_234_4)

					if var_234_11.name == "split_1" then
						var_234_11:SetAsLastSibling()
						var_234_11.gameObject:SetActive(true)

						arg_231_1.var_.actorSpriteSplit10155 = var_234_11.gameObject:GetComponent(typeof(Image))

						arg_231_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_234_12 = 0.5

			if var_234_9 <= arg_231_1.time_ and arg_231_1.time_ < var_234_9 + var_234_12 then
				local var_234_13 = (arg_231_1.time_ - var_234_9) / var_234_12
				local var_234_14 = Vector3.New(-40, -390, -250)

				var_234_8.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10155, var_234_14, var_234_13)

				if arg_231_1.var_.actorSpriteSplit10155 ~= nil then
					arg_231_1.var_.actorSpriteSplit10155:SetAlpha(var_234_13)
				end
			end

			if arg_231_1.time_ >= var_234_9 + var_234_12 and arg_231_1.time_ < var_234_9 + var_234_12 + arg_234_0 then
				var_234_8.localPosition = Vector3.New(-40, -390, -250)

				if arg_231_1.var_.actorSpriteSplit10155 ~= nil then
					arg_231_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_234_15 = 0
			local var_234_16 = 0.625

			if var_234_15 < arg_231_1.time_ and arg_231_1.time_ <= var_234_15 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_17 = arg_231_1:FormatText(StoryNameCfg[1391].name)

				arg_231_1.leftNameTxt_.text = var_234_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_18 = arg_231_1:GetWordFromCfg(424051057)
				local var_234_19 = arg_231_1:FormatText(var_234_18.content)

				arg_231_1.text_.text = var_234_19

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_20 = 25
				local var_234_21 = utf8.len(var_234_19)
				local var_234_22 = var_234_20 <= 0 and var_234_16 or var_234_16 * (var_234_21 / var_234_20)

				if var_234_22 > 0 and var_234_16 < var_234_22 then
					arg_231_1.talkMaxDuration = var_234_22

					if var_234_22 + var_234_15 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_22 + var_234_15
					end
				end

				arg_231_1.text_.text = var_234_19
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051057", "story_v_out_424051.awb") ~= 0 then
					local var_234_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051057", "story_v_out_424051.awb") / 1000

					if var_234_23 + var_234_15 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_23 + var_234_15
					end

					if var_234_18.prefab_name ~= "" and arg_231_1.actors_[var_234_18.prefab_name] ~= nil then
						local var_234_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_18.prefab_name].transform, "story_v_out_424051", "424051057", "story_v_out_424051.awb")

						arg_231_1:RecordAudio("424051057", var_234_24)
						arg_231_1:RecordAudio("424051057", var_234_24)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_424051", "424051057", "story_v_out_424051.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_424051", "424051057", "story_v_out_424051.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_25 = math.max(var_234_16, arg_231_1.talkMaxDuration)

			if var_234_15 <= arg_231_1.time_ and arg_231_1.time_ < var_234_15 + var_234_25 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_15) / var_234_25

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_15 + var_234_25 and arg_231_1.time_ < var_234_15 + var_234_25 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play424051058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 424051058
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play424051059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["10155"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps10155 == nil then
				arg_235_1.var_.actorSpriteComps10155 = var_238_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_2 = 0.2

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.actorSpriteComps10155 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_238_1 then
							if arg_235_1.isInRecall_ then
								local var_238_4 = Mathf.Lerp(iter_238_1.color.r, arg_235_1.hightColor2.r, var_238_3)
								local var_238_5 = Mathf.Lerp(iter_238_1.color.g, arg_235_1.hightColor2.g, var_238_3)
								local var_238_6 = Mathf.Lerp(iter_238_1.color.b, arg_235_1.hightColor2.b, var_238_3)

								iter_238_1.color = Color.New(var_238_4, var_238_5, var_238_6)
							else
								local var_238_7 = Mathf.Lerp(iter_238_1.color.r, 0.5, var_238_3)

								iter_238_1.color = Color.New(var_238_7, var_238_7, var_238_7)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps10155 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_238_3 then
						if arg_235_1.isInRecall_ then
							iter_238_3.color = arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_238_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps10155 = nil
			end

			local var_238_8 = 0
			local var_238_9 = 1.175

			if var_238_8 < arg_235_1.time_ and arg_235_1.time_ <= var_238_8 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_10 = arg_235_1:FormatText(StoryNameCfg[7].name)

				arg_235_1.leftNameTxt_.text = var_238_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_11 = arg_235_1:GetWordFromCfg(424051058)
				local var_238_12 = arg_235_1:FormatText(var_238_11.content)

				arg_235_1.text_.text = var_238_12

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_13 = 47
				local var_238_14 = utf8.len(var_238_12)
				local var_238_15 = var_238_13 <= 0 and var_238_9 or var_238_9 * (var_238_14 / var_238_13)

				if var_238_15 > 0 and var_238_9 < var_238_15 then
					arg_235_1.talkMaxDuration = var_238_15

					if var_238_15 + var_238_8 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_15 + var_238_8
					end
				end

				arg_235_1.text_.text = var_238_12
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_16 = math.max(var_238_9, arg_235_1.talkMaxDuration)

			if var_238_8 <= arg_235_1.time_ and arg_235_1.time_ < var_238_8 + var_238_16 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_8) / var_238_16

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_8 + var_238_16 and arg_235_1.time_ < var_238_8 + var_238_16 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play424051059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 424051059
		arg_239_1.duration_ = 2.67

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play424051060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1094"]
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.actorSpriteComps1094 == nil then
				arg_239_1.var_.actorSpriteComps1094 = var_242_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_2 = 0.2

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 and not isNil(var_242_0) then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2

				if arg_239_1.var_.actorSpriteComps1094 then
					for iter_242_0, iter_242_1 in pairs(arg_239_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_242_1 then
							if arg_239_1.isInRecall_ then
								local var_242_4 = Mathf.Lerp(iter_242_1.color.r, arg_239_1.hightColor1.r, var_242_3)
								local var_242_5 = Mathf.Lerp(iter_242_1.color.g, arg_239_1.hightColor1.g, var_242_3)
								local var_242_6 = Mathf.Lerp(iter_242_1.color.b, arg_239_1.hightColor1.b, var_242_3)

								iter_242_1.color = Color.New(var_242_4, var_242_5, var_242_6)
							else
								local var_242_7 = Mathf.Lerp(iter_242_1.color.r, 1, var_242_3)

								iter_242_1.color = Color.New(var_242_7, var_242_7, var_242_7)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.actorSpriteComps1094 then
				for iter_242_2, iter_242_3 in pairs(arg_239_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_242_3 then
						if arg_239_1.isInRecall_ then
							iter_242_3.color = arg_239_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_242_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_239_1.var_.actorSpriteComps1094 = nil
			end

			local var_242_8 = arg_239_1.actors_["1094"].transform
			local var_242_9 = 0

			if var_242_9 < arg_239_1.time_ and arg_239_1.time_ <= var_242_9 + arg_242_0 then
				arg_239_1.var_.moveOldPos1094 = var_242_8.localPosition
				var_242_8.localScale = Vector3.New(1, 1, 1)

				arg_239_1:CheckSpriteTmpPos("1094", 4)

				local var_242_10 = var_242_8.childCount

				for iter_242_4 = 0, var_242_10 - 1 do
					local var_242_11 = var_242_8:GetChild(iter_242_4)

					if var_242_11.name == "split_1" or not string.find(var_242_11.name, "split") then
						var_242_11.gameObject:SetActive(true)
					else
						var_242_11.gameObject:SetActive(false)
					end
				end
			end

			local var_242_12 = 0.001

			if var_242_9 <= arg_239_1.time_ and arg_239_1.time_ < var_242_9 + var_242_12 then
				local var_242_13 = (arg_239_1.time_ - var_242_9) / var_242_12
				local var_242_14 = Vector3.New(470, -335, -230)

				var_242_8.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1094, var_242_14, var_242_13)
			end

			if arg_239_1.time_ >= var_242_9 + var_242_12 and arg_239_1.time_ < var_242_9 + var_242_12 + arg_242_0 then
				var_242_8.localPosition = Vector3.New(470, -335, -230)
			end

			local var_242_15 = arg_239_1.actors_["10155"].transform
			local var_242_16 = 0

			if var_242_16 < arg_239_1.time_ and arg_239_1.time_ <= var_242_16 + arg_242_0 then
				arg_239_1.var_.moveOldPos10155 = var_242_15.localPosition
				var_242_15.localScale = Vector3.New(1, 1, 1)

				arg_239_1:CheckSpriteTmpPos("10155", 2)

				local var_242_17 = var_242_15.childCount

				for iter_242_5 = 0, var_242_17 - 1 do
					local var_242_18 = var_242_15:GetChild(iter_242_5)

					if var_242_18.name == "" or not string.find(var_242_18.name, "split") then
						var_242_18.gameObject:SetActive(true)
					else
						var_242_18.gameObject:SetActive(false)
					end
				end
			end

			local var_242_19 = 0.001

			if var_242_16 <= arg_239_1.time_ and arg_239_1.time_ < var_242_16 + var_242_19 then
				local var_242_20 = (arg_239_1.time_ - var_242_16) / var_242_19
				local var_242_21 = Vector3.New(-410, -390, -250)

				var_242_15.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos10155, var_242_21, var_242_20)
			end

			if arg_239_1.time_ >= var_242_16 + var_242_19 and arg_239_1.time_ < var_242_16 + var_242_19 + arg_242_0 then
				var_242_15.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_242_22 = 0
			local var_242_23 = 0.175

			if var_242_22 < arg_239_1.time_ and arg_239_1.time_ <= var_242_22 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_24 = arg_239_1:FormatText(StoryNameCfg[181].name)

				arg_239_1.leftNameTxt_.text = var_242_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_25 = arg_239_1:GetWordFromCfg(424051059)
				local var_242_26 = arg_239_1:FormatText(var_242_25.content)

				arg_239_1.text_.text = var_242_26

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_27 = 7
				local var_242_28 = utf8.len(var_242_26)
				local var_242_29 = var_242_27 <= 0 and var_242_23 or var_242_23 * (var_242_28 / var_242_27)

				if var_242_29 > 0 and var_242_23 < var_242_29 then
					arg_239_1.talkMaxDuration = var_242_29

					if var_242_29 + var_242_22 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_29 + var_242_22
					end
				end

				arg_239_1.text_.text = var_242_26
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051059", "story_v_out_424051.awb") ~= 0 then
					local var_242_30 = manager.audio:GetVoiceLength("story_v_out_424051", "424051059", "story_v_out_424051.awb") / 1000

					if var_242_30 + var_242_22 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_30 + var_242_22
					end

					if var_242_25.prefab_name ~= "" and arg_239_1.actors_[var_242_25.prefab_name] ~= nil then
						local var_242_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_25.prefab_name].transform, "story_v_out_424051", "424051059", "story_v_out_424051.awb")

						arg_239_1:RecordAudio("424051059", var_242_31)
						arg_239_1:RecordAudio("424051059", var_242_31)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_424051", "424051059", "story_v_out_424051.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_424051", "424051059", "story_v_out_424051.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_32 = math.max(var_242_23, arg_239_1.talkMaxDuration)

			if var_242_22 <= arg_239_1.time_ and arg_239_1.time_ < var_242_22 + var_242_32 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_22) / var_242_32

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_22 + var_242_32 and arg_239_1.time_ < var_242_22 + var_242_32 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
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

		arg_239_1:InitPlayNodeList()
	end,
	Play424051060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 424051060
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play424051061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1094"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps1094 == nil then
				arg_243_1.var_.actorSpriteComps1094 = var_246_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_2 = 0.2

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.actorSpriteComps1094 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps1094 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_246_3 then
						if arg_243_1.isInRecall_ then
							iter_246_3.color = arg_243_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_246_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps1094 = nil
			end

			local var_246_8 = 0
			local var_246_9 = 0.5

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

				local var_246_11 = arg_243_1:GetWordFromCfg(424051060)
				local var_246_12 = arg_243_1:FormatText(var_246_11.content)

				arg_243_1.text_.text = var_246_12

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_13 = 20
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
	Play424051061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 424051061
		arg_247_1.duration_ = 15.7

		local var_247_0 = {
			zh = 7.133,
			ja = 15.7
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
				arg_247_0:Play424051062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["10155"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps10155 == nil then
				arg_247_1.var_.actorSpriteComps10155 = var_250_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_2 = 0.2

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.actorSpriteComps10155 then
					for iter_250_0, iter_250_1 in pairs(arg_247_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps10155 then
				for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_250_3 then
						if arg_247_1.isInRecall_ then
							iter_250_3.color = arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_250_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps10155 = nil
			end

			local var_250_8 = arg_247_1.actors_["10155"].transform
			local var_250_9 = 0

			if var_250_9 < arg_247_1.time_ and arg_247_1.time_ <= var_250_9 + arg_250_0 then
				arg_247_1.var_.moveOldPos10155 = var_250_8.localPosition
				var_250_8.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10155", 2)

				local var_250_10 = var_250_8.childCount

				for iter_250_4 = 0, var_250_10 - 1 do
					local var_250_11 = var_250_8:GetChild(iter_250_4)

					if var_250_11.name == "" or not string.find(var_250_11.name, "split") then
						var_250_11.gameObject:SetActive(true)
					else
						var_250_11.gameObject:SetActive(false)
					end
				end
			end

			local var_250_12 = 0.001

			if var_250_9 <= arg_247_1.time_ and arg_247_1.time_ < var_250_9 + var_250_12 then
				local var_250_13 = (arg_247_1.time_ - var_250_9) / var_250_12
				local var_250_14 = Vector3.New(-410, -390, -250)

				var_250_8.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10155, var_250_14, var_250_13)
			end

			if arg_247_1.time_ >= var_250_9 + var_250_12 and arg_247_1.time_ < var_250_9 + var_250_12 + arg_250_0 then
				var_250_8.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_250_15 = 0
			local var_250_16 = 0.875

			if var_250_15 < arg_247_1.time_ and arg_247_1.time_ <= var_250_15 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_17 = arg_247_1:FormatText(StoryNameCfg[1391].name)

				arg_247_1.leftNameTxt_.text = var_250_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_18 = arg_247_1:GetWordFromCfg(424051061)
				local var_250_19 = arg_247_1:FormatText(var_250_18.content)

				arg_247_1.text_.text = var_250_19

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_20 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051061", "story_v_out_424051.awb") ~= 0 then
					local var_250_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051061", "story_v_out_424051.awb") / 1000

					if var_250_23 + var_250_15 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_23 + var_250_15
					end

					if var_250_18.prefab_name ~= "" and arg_247_1.actors_[var_250_18.prefab_name] ~= nil then
						local var_250_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_18.prefab_name].transform, "story_v_out_424051", "424051061", "story_v_out_424051.awb")

						arg_247_1:RecordAudio("424051061", var_250_24)
						arg_247_1:RecordAudio("424051061", var_250_24)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_424051", "424051061", "story_v_out_424051.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_424051", "424051061", "story_v_out_424051.awb")
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
	Play424051062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 424051062
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play424051063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["10155"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.actorSpriteComps10155 == nil then
				arg_251_1.var_.actorSpriteComps10155 = var_254_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_2 = 0.2

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.actorSpriteComps10155 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_254_1 then
							if arg_251_1.isInRecall_ then
								local var_254_4 = Mathf.Lerp(iter_254_1.color.r, arg_251_1.hightColor2.r, var_254_3)
								local var_254_5 = Mathf.Lerp(iter_254_1.color.g, arg_251_1.hightColor2.g, var_254_3)
								local var_254_6 = Mathf.Lerp(iter_254_1.color.b, arg_251_1.hightColor2.b, var_254_3)

								iter_254_1.color = Color.New(var_254_4, var_254_5, var_254_6)
							else
								local var_254_7 = Mathf.Lerp(iter_254_1.color.r, 0.5, var_254_3)

								iter_254_1.color = Color.New(var_254_7, var_254_7, var_254_7)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.actorSpriteComps10155 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_254_3 then
						if arg_251_1.isInRecall_ then
							iter_254_3.color = arg_251_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_254_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_251_1.var_.actorSpriteComps10155 = nil
			end

			local var_254_8 = 0
			local var_254_9 = 0.25

			if var_254_8 < arg_251_1.time_ and arg_251_1.time_ <= var_254_8 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_10 = arg_251_1:FormatText(StoryNameCfg[7].name)

				arg_251_1.leftNameTxt_.text = var_254_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_11 = arg_251_1:GetWordFromCfg(424051062)
				local var_254_12 = arg_251_1:FormatText(var_254_11.content)

				arg_251_1.text_.text = var_254_12

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_13 = 10
				local var_254_14 = utf8.len(var_254_12)
				local var_254_15 = var_254_13 <= 0 and var_254_9 or var_254_9 * (var_254_14 / var_254_13)

				if var_254_15 > 0 and var_254_9 < var_254_15 then
					arg_251_1.talkMaxDuration = var_254_15

					if var_254_15 + var_254_8 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_15 + var_254_8
					end
				end

				arg_251_1.text_.text = var_254_12
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_16 = math.max(var_254_9, arg_251_1.talkMaxDuration)

			if var_254_8 <= arg_251_1.time_ and arg_251_1.time_ < var_254_8 + var_254_16 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_8) / var_254_16

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_8 + var_254_16 and arg_251_1.time_ < var_254_8 + var_254_16 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play424051063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 424051063
		arg_255_1.duration_ = 5.8

		local var_255_0 = {
			zh = 2.433,
			ja = 5.8
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
				arg_255_0:Play424051064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["10155"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.actorSpriteComps10155 == nil then
				arg_255_1.var_.actorSpriteComps10155 = var_258_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_2 = 0.2

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.actorSpriteComps10155 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.actorSpriteComps10155 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_258_3 then
						if arg_255_1.isInRecall_ then
							iter_258_3.color = arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_258_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_255_1.var_.actorSpriteComps10155 = nil
			end

			local var_258_8 = arg_255_1.actors_["10155"].transform
			local var_258_9 = 0

			if var_258_9 < arg_255_1.time_ and arg_255_1.time_ <= var_258_9 + arg_258_0 then
				arg_255_1.var_.moveOldPos10155 = var_258_8.localPosition
				var_258_8.localScale = Vector3.New(1, 1, 1)

				arg_255_1:CheckSpriteTmpPos("10155", 2)

				local var_258_10 = var_258_8.childCount

				for iter_258_4 = 0, var_258_10 - 1 do
					local var_258_11 = var_258_8:GetChild(iter_258_4)

					if var_258_11.name == "" or not string.find(var_258_11.name, "split") then
						var_258_11.gameObject:SetActive(true)
					else
						var_258_11.gameObject:SetActive(false)
					end
				end
			end

			local var_258_12 = 0.001

			if var_258_9 <= arg_255_1.time_ and arg_255_1.time_ < var_258_9 + var_258_12 then
				local var_258_13 = (arg_255_1.time_ - var_258_9) / var_258_12
				local var_258_14 = Vector3.New(-410, -390, -250)

				var_258_8.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10155, var_258_14, var_258_13)
			end

			if arg_255_1.time_ >= var_258_9 + var_258_12 and arg_255_1.time_ < var_258_9 + var_258_12 + arg_258_0 then
				var_258_8.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_258_15 = 0
			local var_258_16 = 0.35

			if var_258_15 < arg_255_1.time_ and arg_255_1.time_ <= var_258_15 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_17 = arg_255_1:FormatText(StoryNameCfg[1391].name)

				arg_255_1.leftNameTxt_.text = var_258_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_18 = arg_255_1:GetWordFromCfg(424051063)
				local var_258_19 = arg_255_1:FormatText(var_258_18.content)

				arg_255_1.text_.text = var_258_19

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_20 = 14
				local var_258_21 = utf8.len(var_258_19)
				local var_258_22 = var_258_20 <= 0 and var_258_16 or var_258_16 * (var_258_21 / var_258_20)

				if var_258_22 > 0 and var_258_16 < var_258_22 then
					arg_255_1.talkMaxDuration = var_258_22

					if var_258_22 + var_258_15 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_22 + var_258_15
					end
				end

				arg_255_1.text_.text = var_258_19
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051063", "story_v_out_424051.awb") ~= 0 then
					local var_258_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051063", "story_v_out_424051.awb") / 1000

					if var_258_23 + var_258_15 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_23 + var_258_15
					end

					if var_258_18.prefab_name ~= "" and arg_255_1.actors_[var_258_18.prefab_name] ~= nil then
						local var_258_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_18.prefab_name].transform, "story_v_out_424051", "424051063", "story_v_out_424051.awb")

						arg_255_1:RecordAudio("424051063", var_258_24)
						arg_255_1:RecordAudio("424051063", var_258_24)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_424051", "424051063", "story_v_out_424051.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_424051", "424051063", "story_v_out_424051.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_25 = math.max(var_258_16, arg_255_1.talkMaxDuration)

			if var_258_15 <= arg_255_1.time_ and arg_255_1.time_ < var_258_15 + var_258_25 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_15) / var_258_25

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_15 + var_258_25 and arg_255_1.time_ < var_258_15 + var_258_25 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
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

		arg_255_1:InitPlayNodeList()
	end,
	Play424051064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 424051064
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play424051065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["10155"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps10155 == nil then
				arg_259_1.var_.actorSpriteComps10155 = var_262_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_2 = 0.2

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.actorSpriteComps10155 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_262_1 then
							if arg_259_1.isInRecall_ then
								local var_262_4 = Mathf.Lerp(iter_262_1.color.r, arg_259_1.hightColor2.r, var_262_3)
								local var_262_5 = Mathf.Lerp(iter_262_1.color.g, arg_259_1.hightColor2.g, var_262_3)
								local var_262_6 = Mathf.Lerp(iter_262_1.color.b, arg_259_1.hightColor2.b, var_262_3)

								iter_262_1.color = Color.New(var_262_4, var_262_5, var_262_6)
							else
								local var_262_7 = Mathf.Lerp(iter_262_1.color.r, 0.5, var_262_3)

								iter_262_1.color = Color.New(var_262_7, var_262_7, var_262_7)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps10155 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_262_3 then
						if arg_259_1.isInRecall_ then
							iter_262_3.color = arg_259_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_262_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_259_1.var_.actorSpriteComps10155 = nil
			end

			local var_262_8 = 0
			local var_262_9 = 0.35

			if var_262_8 < arg_259_1.time_ and arg_259_1.time_ <= var_262_8 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_10 = arg_259_1:FormatText(StoryNameCfg[7].name)

				arg_259_1.leftNameTxt_.text = var_262_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_11 = arg_259_1:GetWordFromCfg(424051064)
				local var_262_12 = arg_259_1:FormatText(var_262_11.content)

				arg_259_1.text_.text = var_262_12

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_13 = 14
				local var_262_14 = utf8.len(var_262_12)
				local var_262_15 = var_262_13 <= 0 and var_262_9 or var_262_9 * (var_262_14 / var_262_13)

				if var_262_15 > 0 and var_262_9 < var_262_15 then
					arg_259_1.talkMaxDuration = var_262_15

					if var_262_15 + var_262_8 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_15 + var_262_8
					end
				end

				arg_259_1.text_.text = var_262_12
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_16 = math.max(var_262_9, arg_259_1.talkMaxDuration)

			if var_262_8 <= arg_259_1.time_ and arg_259_1.time_ < var_262_8 + var_262_16 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_8) / var_262_16

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_8 + var_262_16 and arg_259_1.time_ < var_262_8 + var_262_16 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play424051065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 424051065
		arg_263_1.duration_ = 3.4

		local var_263_0 = {
			zh = 2.466,
			ja = 3.4
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
				arg_263_0:Play424051066(arg_263_1)
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

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps1094 then
				for iter_266_2, iter_266_3 in pairs(arg_263_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_266_3 then
						if arg_263_1.isInRecall_ then
							iter_266_3.color = arg_263_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_266_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_263_1.var_.actorSpriteComps1094 = nil
			end

			local var_266_8 = arg_263_1.actors_["1094"].transform
			local var_266_9 = 0

			if var_266_9 < arg_263_1.time_ and arg_263_1.time_ <= var_266_9 + arg_266_0 then
				arg_263_1.var_.moveOldPos1094 = var_266_8.localPosition
				var_266_8.localScale = Vector3.New(1, 1, 1)

				arg_263_1:CheckSpriteTmpPos("1094", 4)

				local var_266_10 = var_266_8.childCount

				for iter_266_4 = 0, var_266_10 - 1 do
					local var_266_11 = var_266_8:GetChild(iter_266_4)

					if var_266_11.name == "split_2" or not string.find(var_266_11.name, "split") then
						var_266_11.gameObject:SetActive(true)
					else
						var_266_11.gameObject:SetActive(false)
					end
				end
			end

			local var_266_12 = 0.001

			if var_266_9 <= arg_263_1.time_ and arg_263_1.time_ < var_266_9 + var_266_12 then
				local var_266_13 = (arg_263_1.time_ - var_266_9) / var_266_12
				local var_266_14 = Vector3.New(470, -335, -230)

				var_266_8.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1094, var_266_14, var_266_13)
			end

			if arg_263_1.time_ >= var_266_9 + var_266_12 and arg_263_1.time_ < var_266_9 + var_266_12 + arg_266_0 then
				var_266_8.localPosition = Vector3.New(470, -335, -230)
			end

			local var_266_15 = 0
			local var_266_16 = 0.2

			if var_266_15 < arg_263_1.time_ and arg_263_1.time_ <= var_266_15 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_17 = arg_263_1:FormatText(StoryNameCfg[181].name)

				arg_263_1.leftNameTxt_.text = var_266_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_18 = arg_263_1:GetWordFromCfg(424051065)
				local var_266_19 = arg_263_1:FormatText(var_266_18.content)

				arg_263_1.text_.text = var_266_19

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_20 = 8
				local var_266_21 = utf8.len(var_266_19)
				local var_266_22 = var_266_20 <= 0 and var_266_16 or var_266_16 * (var_266_21 / var_266_20)

				if var_266_22 > 0 and var_266_16 < var_266_22 then
					arg_263_1.talkMaxDuration = var_266_22

					if var_266_22 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_22 + var_266_15
					end
				end

				arg_263_1.text_.text = var_266_19
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051065", "story_v_out_424051.awb") ~= 0 then
					local var_266_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051065", "story_v_out_424051.awb") / 1000

					if var_266_23 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_23 + var_266_15
					end

					if var_266_18.prefab_name ~= "" and arg_263_1.actors_[var_266_18.prefab_name] ~= nil then
						local var_266_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_18.prefab_name].transform, "story_v_out_424051", "424051065", "story_v_out_424051.awb")

						arg_263_1:RecordAudio("424051065", var_266_24)
						arg_263_1:RecordAudio("424051065", var_266_24)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_424051", "424051065", "story_v_out_424051.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_424051", "424051065", "story_v_out_424051.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_25 = math.max(var_266_16, arg_263_1.talkMaxDuration)

			if var_266_15 <= arg_263_1.time_ and arg_263_1.time_ < var_266_15 + var_266_25 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_15) / var_266_25

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_15 + var_266_25 and arg_263_1.time_ < var_266_15 + var_266_25 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
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

		arg_263_1:InitPlayNodeList()
	end,
	Play424051066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 424051066
		arg_267_1.duration_ = 8.3

		local var_267_0 = {
			zh = 2.566,
			ja = 8.3
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
				arg_267_0:Play424051067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["10155"]
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.actorSpriteComps10155 == nil then
				arg_267_1.var_.actorSpriteComps10155 = var_270_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_2 = 0.2

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 and not isNil(var_270_0) then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2

				if arg_267_1.var_.actorSpriteComps10155 then
					for iter_270_0, iter_270_1 in pairs(arg_267_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.actorSpriteComps10155 then
				for iter_270_2, iter_270_3 in pairs(arg_267_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_270_3 then
						if arg_267_1.isInRecall_ then
							iter_270_3.color = arg_267_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_270_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_267_1.var_.actorSpriteComps10155 = nil
			end

			local var_270_8 = arg_267_1.actors_["1094"]
			local var_270_9 = 0

			if var_270_9 < arg_267_1.time_ and arg_267_1.time_ <= var_270_9 + arg_270_0 and not isNil(var_270_8) and arg_267_1.var_.actorSpriteComps1094 == nil then
				arg_267_1.var_.actorSpriteComps1094 = var_270_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_10 = 0.2

			if var_270_9 <= arg_267_1.time_ and arg_267_1.time_ < var_270_9 + var_270_10 and not isNil(var_270_8) then
				local var_270_11 = (arg_267_1.time_ - var_270_9) / var_270_10

				if arg_267_1.var_.actorSpriteComps1094 then
					for iter_270_4, iter_270_5 in pairs(arg_267_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_270_5 then
							if arg_267_1.isInRecall_ then
								local var_270_12 = Mathf.Lerp(iter_270_5.color.r, arg_267_1.hightColor2.r, var_270_11)
								local var_270_13 = Mathf.Lerp(iter_270_5.color.g, arg_267_1.hightColor2.g, var_270_11)
								local var_270_14 = Mathf.Lerp(iter_270_5.color.b, arg_267_1.hightColor2.b, var_270_11)

								iter_270_5.color = Color.New(var_270_12, var_270_13, var_270_14)
							else
								local var_270_15 = Mathf.Lerp(iter_270_5.color.r, 0.5, var_270_11)

								iter_270_5.color = Color.New(var_270_15, var_270_15, var_270_15)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= var_270_9 + var_270_10 and arg_267_1.time_ < var_270_9 + var_270_10 + arg_270_0 and not isNil(var_270_8) and arg_267_1.var_.actorSpriteComps1094 then
				for iter_270_6, iter_270_7 in pairs(arg_267_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_270_7 then
						if arg_267_1.isInRecall_ then
							iter_270_7.color = arg_267_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_270_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_267_1.var_.actorSpriteComps1094 = nil
			end

			local var_270_16 = arg_267_1.actors_["10155"].transform
			local var_270_17 = 0

			if var_270_17 < arg_267_1.time_ and arg_267_1.time_ <= var_270_17 + arg_270_0 then
				arg_267_1.var_.moveOldPos10155 = var_270_16.localPosition
				var_270_16.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("10155", 2)

				local var_270_18 = var_270_16.childCount

				for iter_270_8 = 0, var_270_18 - 1 do
					local var_270_19 = var_270_16:GetChild(iter_270_8)

					if var_270_19.name == "split_2" or not string.find(var_270_19.name, "split") then
						var_270_19.gameObject:SetActive(true)
					else
						var_270_19.gameObject:SetActive(false)
					end
				end
			end

			local var_270_20 = 0.001

			if var_270_17 <= arg_267_1.time_ and arg_267_1.time_ < var_270_17 + var_270_20 then
				local var_270_21 = (arg_267_1.time_ - var_270_17) / var_270_20
				local var_270_22 = Vector3.New(-410, -390, -250)

				var_270_16.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos10155, var_270_22, var_270_21)
			end

			if arg_267_1.time_ >= var_270_17 + var_270_20 and arg_267_1.time_ < var_270_17 + var_270_20 + arg_270_0 then
				var_270_16.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_270_23 = 0
			local var_270_24 = 0.45

			if var_270_23 < arg_267_1.time_ and arg_267_1.time_ <= var_270_23 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_25 = arg_267_1:FormatText(StoryNameCfg[1391].name)

				arg_267_1.leftNameTxt_.text = var_270_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_26 = arg_267_1:GetWordFromCfg(424051066)
				local var_270_27 = arg_267_1:FormatText(var_270_26.content)

				arg_267_1.text_.text = var_270_27

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_28 = 18
				local var_270_29 = utf8.len(var_270_27)
				local var_270_30 = var_270_28 <= 0 and var_270_24 or var_270_24 * (var_270_29 / var_270_28)

				if var_270_30 > 0 and var_270_24 < var_270_30 then
					arg_267_1.talkMaxDuration = var_270_30

					if var_270_30 + var_270_23 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_30 + var_270_23
					end
				end

				arg_267_1.text_.text = var_270_27
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051066", "story_v_out_424051.awb") ~= 0 then
					local var_270_31 = manager.audio:GetVoiceLength("story_v_out_424051", "424051066", "story_v_out_424051.awb") / 1000

					if var_270_31 + var_270_23 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_31 + var_270_23
					end

					if var_270_26.prefab_name ~= "" and arg_267_1.actors_[var_270_26.prefab_name] ~= nil then
						local var_270_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_26.prefab_name].transform, "story_v_out_424051", "424051066", "story_v_out_424051.awb")

						arg_267_1:RecordAudio("424051066", var_270_32)
						arg_267_1:RecordAudio("424051066", var_270_32)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_424051", "424051066", "story_v_out_424051.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_424051", "424051066", "story_v_out_424051.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_33 = math.max(var_270_24, arg_267_1.talkMaxDuration)

			if var_270_23 <= arg_267_1.time_ and arg_267_1.time_ < var_270_23 + var_270_33 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_23) / var_270_33

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_23 + var_270_33 and arg_267_1.time_ < var_270_23 + var_270_33 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
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

		arg_267_1:InitPlayNodeList()
	end,
	Play424051067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 424051067
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play424051068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["10155"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps10155 == nil then
				arg_271_1.var_.actorSpriteComps10155 = var_274_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_2 = 0.2

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.actorSpriteComps10155 then
					for iter_274_0, iter_274_1 in pairs(arg_271_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps10155 then
				for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_274_3 then
						if arg_271_1.isInRecall_ then
							iter_274_3.color = arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_274_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps10155 = nil
			end

			local var_274_8 = 0
			local var_274_9 = 1.125

			if var_274_8 < arg_271_1.time_ and arg_271_1.time_ <= var_274_8 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_10 = arg_271_1:FormatText(StoryNameCfg[7].name)

				arg_271_1.leftNameTxt_.text = var_274_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_11 = arg_271_1:GetWordFromCfg(424051067)
				local var_274_12 = arg_271_1:FormatText(var_274_11.content)

				arg_271_1.text_.text = var_274_12

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_13 = 45
				local var_274_14 = utf8.len(var_274_12)
				local var_274_15 = var_274_13 <= 0 and var_274_9 or var_274_9 * (var_274_14 / var_274_13)

				if var_274_15 > 0 and var_274_9 < var_274_15 then
					arg_271_1.talkMaxDuration = var_274_15

					if var_274_15 + var_274_8 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_15 + var_274_8
					end
				end

				arg_271_1.text_.text = var_274_12
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_16 = math.max(var_274_9, arg_271_1.talkMaxDuration)

			if var_274_8 <= arg_271_1.time_ and arg_271_1.time_ < var_274_8 + var_274_16 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_8) / var_274_16

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_8 + var_274_16 and arg_271_1.time_ < var_274_8 + var_274_16 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play424051068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 424051068
		arg_275_1.duration_ = 12.2

		local var_275_0 = {
			zh = 5.766,
			ja = 12.2
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
				arg_275_0:Play424051069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["10155"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps10155 == nil then
				arg_275_1.var_.actorSpriteComps10155 = var_278_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_2 = 0.2

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.actorSpriteComps10155 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps10155 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_278_3 then
						if arg_275_1.isInRecall_ then
							iter_278_3.color = arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_278_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_275_1.var_.actorSpriteComps10155 = nil
			end

			local var_278_8 = arg_275_1.actors_["10155"].transform
			local var_278_9 = 0

			if var_278_9 < arg_275_1.time_ and arg_275_1.time_ <= var_278_9 + arg_278_0 then
				arg_275_1.var_.moveOldPos10155 = var_278_8.localPosition
				var_278_8.localScale = Vector3.New(1, 1, 1)

				arg_275_1:CheckSpriteTmpPos("10155", 2)

				local var_278_10 = var_278_8.childCount

				for iter_278_4 = 0, var_278_10 - 1 do
					local var_278_11 = var_278_8:GetChild(iter_278_4)

					if var_278_11.name == "" or not string.find(var_278_11.name, "split") then
						var_278_11.gameObject:SetActive(true)
					else
						var_278_11.gameObject:SetActive(false)
					end
				end
			end

			local var_278_12 = 0.001

			if var_278_9 <= arg_275_1.time_ and arg_275_1.time_ < var_278_9 + var_278_12 then
				local var_278_13 = (arg_275_1.time_ - var_278_9) / var_278_12
				local var_278_14 = Vector3.New(-410, -390, -250)

				var_278_8.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10155, var_278_14, var_278_13)
			end

			if arg_275_1.time_ >= var_278_9 + var_278_12 and arg_275_1.time_ < var_278_9 + var_278_12 + arg_278_0 then
				var_278_8.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_278_15 = 0
			local var_278_16 = 0.675

			if var_278_15 < arg_275_1.time_ and arg_275_1.time_ <= var_278_15 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_17 = arg_275_1:FormatText(StoryNameCfg[1391].name)

				arg_275_1.leftNameTxt_.text = var_278_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_18 = arg_275_1:GetWordFromCfg(424051068)
				local var_278_19 = arg_275_1:FormatText(var_278_18.content)

				arg_275_1.text_.text = var_278_19

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_20 = 27
				local var_278_21 = utf8.len(var_278_19)
				local var_278_22 = var_278_20 <= 0 and var_278_16 or var_278_16 * (var_278_21 / var_278_20)

				if var_278_22 > 0 and var_278_16 < var_278_22 then
					arg_275_1.talkMaxDuration = var_278_22

					if var_278_22 + var_278_15 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_22 + var_278_15
					end
				end

				arg_275_1.text_.text = var_278_19
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051068", "story_v_out_424051.awb") ~= 0 then
					local var_278_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051068", "story_v_out_424051.awb") / 1000

					if var_278_23 + var_278_15 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_23 + var_278_15
					end

					if var_278_18.prefab_name ~= "" and arg_275_1.actors_[var_278_18.prefab_name] ~= nil then
						local var_278_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_18.prefab_name].transform, "story_v_out_424051", "424051068", "story_v_out_424051.awb")

						arg_275_1:RecordAudio("424051068", var_278_24)
						arg_275_1:RecordAudio("424051068", var_278_24)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_424051", "424051068", "story_v_out_424051.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_424051", "424051068", "story_v_out_424051.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_25 = math.max(var_278_16, arg_275_1.talkMaxDuration)

			if var_278_15 <= arg_275_1.time_ and arg_275_1.time_ < var_278_15 + var_278_25 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_15) / var_278_25

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_15 + var_278_25 and arg_275_1.time_ < var_278_15 + var_278_25 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
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

		arg_275_1:InitPlayNodeList()
	end,
	Play424051069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 424051069
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play424051070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["10155"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps10155 == nil then
				arg_279_1.var_.actorSpriteComps10155 = var_282_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_2 = 0.2

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.actorSpriteComps10155 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_282_1 then
							if arg_279_1.isInRecall_ then
								local var_282_4 = Mathf.Lerp(iter_282_1.color.r, arg_279_1.hightColor2.r, var_282_3)
								local var_282_5 = Mathf.Lerp(iter_282_1.color.g, arg_279_1.hightColor2.g, var_282_3)
								local var_282_6 = Mathf.Lerp(iter_282_1.color.b, arg_279_1.hightColor2.b, var_282_3)

								iter_282_1.color = Color.New(var_282_4, var_282_5, var_282_6)
							else
								local var_282_7 = Mathf.Lerp(iter_282_1.color.r, 0.5, var_282_3)

								iter_282_1.color = Color.New(var_282_7, var_282_7, var_282_7)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps10155 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_282_3 then
						if arg_279_1.isInRecall_ then
							iter_282_3.color = arg_279_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_282_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_279_1.var_.actorSpriteComps10155 = nil
			end

			local var_282_8 = 0
			local var_282_9 = 1.2

			if var_282_8 < arg_279_1.time_ and arg_279_1.time_ <= var_282_8 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_10 = arg_279_1:GetWordFromCfg(424051069)
				local var_282_11 = arg_279_1:FormatText(var_282_10.content)

				arg_279_1.text_.text = var_282_11

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_12 = 48
				local var_282_13 = utf8.len(var_282_11)
				local var_282_14 = var_282_12 <= 0 and var_282_9 or var_282_9 * (var_282_13 / var_282_12)

				if var_282_14 > 0 and var_282_9 < var_282_14 then
					arg_279_1.talkMaxDuration = var_282_14

					if var_282_14 + var_282_8 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_14 + var_282_8
					end
				end

				arg_279_1.text_.text = var_282_11
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_15 = math.max(var_282_9, arg_279_1.talkMaxDuration)

			if var_282_8 <= arg_279_1.time_ and arg_279_1.time_ < var_282_8 + var_282_15 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_8) / var_282_15

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_8 + var_282_15 and arg_279_1.time_ < var_282_8 + var_282_15 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play424051070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 424051070
		arg_283_1.duration_ = 1.4

		local var_283_0 = {
			zh = 1.4,
			ja = 1.3
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
				arg_283_0:Play424051071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["1094"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps1094 == nil then
				arg_283_1.var_.actorSpriteComps1094 = var_286_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_2 = 0.2

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.actorSpriteComps1094 then
					for iter_286_0, iter_286_1 in pairs(arg_283_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_286_1 then
							if arg_283_1.isInRecall_ then
								local var_286_4 = Mathf.Lerp(iter_286_1.color.r, arg_283_1.hightColor1.r, var_286_3)
								local var_286_5 = Mathf.Lerp(iter_286_1.color.g, arg_283_1.hightColor1.g, var_286_3)
								local var_286_6 = Mathf.Lerp(iter_286_1.color.b, arg_283_1.hightColor1.b, var_286_3)

								iter_286_1.color = Color.New(var_286_4, var_286_5, var_286_6)
							else
								local var_286_7 = Mathf.Lerp(iter_286_1.color.r, 1, var_286_3)

								iter_286_1.color = Color.New(var_286_7, var_286_7, var_286_7)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps1094 then
				for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_286_3 then
						if arg_283_1.isInRecall_ then
							iter_286_3.color = arg_283_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_286_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_283_1.var_.actorSpriteComps1094 = nil
			end

			local var_286_8 = arg_283_1.actors_["1094"].transform
			local var_286_9 = 0

			if var_286_9 < arg_283_1.time_ and arg_283_1.time_ <= var_286_9 + arg_286_0 then
				arg_283_1.var_.moveOldPos1094 = var_286_8.localPosition
				var_286_8.localScale = Vector3.New(1, 1, 1)

				arg_283_1:CheckSpriteTmpPos("1094", 4)

				local var_286_10 = var_286_8.childCount

				for iter_286_4 = 0, var_286_10 - 1 do
					local var_286_11 = var_286_8:GetChild(iter_286_4)

					if var_286_11.name == "split_4" then
						var_286_11:SetAsLastSibling()
						var_286_11.gameObject:SetActive(true)

						arg_283_1.var_.actorSpriteSplit1094 = var_286_11.gameObject:GetComponent(typeof(Image))

						arg_283_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_286_12 = 0.5

			if var_286_9 <= arg_283_1.time_ and arg_283_1.time_ < var_286_9 + var_286_12 then
				local var_286_13 = (arg_283_1.time_ - var_286_9) / var_286_12
				local var_286_14 = Vector3.New(470, -335, -230)

				var_286_8.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1094, var_286_14, var_286_13)

				if arg_283_1.var_.actorSpriteSplit1094 ~= nil then
					arg_283_1.var_.actorSpriteSplit1094:SetAlpha(var_286_13)
				end
			end

			if arg_283_1.time_ >= var_286_9 + var_286_12 and arg_283_1.time_ < var_286_9 + var_286_12 + arg_286_0 then
				var_286_8.localPosition = Vector3.New(470, -335, -230)

				if arg_283_1.var_.actorSpriteSplit1094 ~= nil then
					arg_283_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_286_15 = 0
			local var_286_16 = 0.125

			if var_286_15 < arg_283_1.time_ and arg_283_1.time_ <= var_286_15 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_17 = arg_283_1:FormatText(StoryNameCfg[181].name)

				arg_283_1.leftNameTxt_.text = var_286_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_18 = arg_283_1:GetWordFromCfg(424051070)
				local var_286_19 = arg_283_1:FormatText(var_286_18.content)

				arg_283_1.text_.text = var_286_19

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_20 = 5
				local var_286_21 = utf8.len(var_286_19)
				local var_286_22 = var_286_20 <= 0 and var_286_16 or var_286_16 * (var_286_21 / var_286_20)

				if var_286_22 > 0 and var_286_16 < var_286_22 then
					arg_283_1.talkMaxDuration = var_286_22

					if var_286_22 + var_286_15 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_22 + var_286_15
					end
				end

				arg_283_1.text_.text = var_286_19
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051070", "story_v_out_424051.awb") ~= 0 then
					local var_286_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051070", "story_v_out_424051.awb") / 1000

					if var_286_23 + var_286_15 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_23 + var_286_15
					end

					if var_286_18.prefab_name ~= "" and arg_283_1.actors_[var_286_18.prefab_name] ~= nil then
						local var_286_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_18.prefab_name].transform, "story_v_out_424051", "424051070", "story_v_out_424051.awb")

						arg_283_1:RecordAudio("424051070", var_286_24)
						arg_283_1:RecordAudio("424051070", var_286_24)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_424051", "424051070", "story_v_out_424051.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_424051", "424051070", "story_v_out_424051.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_25 = math.max(var_286_16, arg_283_1.talkMaxDuration)

			if var_286_15 <= arg_283_1.time_ and arg_283_1.time_ < var_286_15 + var_286_25 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_15) / var_286_25

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_15 + var_286_25 and arg_283_1.time_ < var_286_15 + var_286_25 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play424051071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 424051071
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play424051072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1094"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps1094 == nil then
				arg_287_1.var_.actorSpriteComps1094 = var_290_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_2 = 0.2

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.actorSpriteComps1094 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_290_1 then
							if arg_287_1.isInRecall_ then
								local var_290_4 = Mathf.Lerp(iter_290_1.color.r, arg_287_1.hightColor2.r, var_290_3)
								local var_290_5 = Mathf.Lerp(iter_290_1.color.g, arg_287_1.hightColor2.g, var_290_3)
								local var_290_6 = Mathf.Lerp(iter_290_1.color.b, arg_287_1.hightColor2.b, var_290_3)

								iter_290_1.color = Color.New(var_290_4, var_290_5, var_290_6)
							else
								local var_290_7 = Mathf.Lerp(iter_290_1.color.r, 0.5, var_290_3)

								iter_290_1.color = Color.New(var_290_7, var_290_7, var_290_7)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps1094 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_290_3 then
						if arg_287_1.isInRecall_ then
							iter_290_3.color = arg_287_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_290_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_287_1.var_.actorSpriteComps1094 = nil
			end

			local var_290_8 = 0
			local var_290_9 = 0.5

			if var_290_8 < arg_287_1.time_ and arg_287_1.time_ <= var_290_8 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_10 = arg_287_1:FormatText(StoryNameCfg[7].name)

				arg_287_1.leftNameTxt_.text = var_290_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_11 = arg_287_1:GetWordFromCfg(424051071)
				local var_290_12 = arg_287_1:FormatText(var_290_11.content)

				arg_287_1.text_.text = var_290_12

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_13 = 20
				local var_290_14 = utf8.len(var_290_12)
				local var_290_15 = var_290_13 <= 0 and var_290_9 or var_290_9 * (var_290_14 / var_290_13)

				if var_290_15 > 0 and var_290_9 < var_290_15 then
					arg_287_1.talkMaxDuration = var_290_15

					if var_290_15 + var_290_8 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_15 + var_290_8
					end
				end

				arg_287_1.text_.text = var_290_12
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_16 = math.max(var_290_9, arg_287_1.talkMaxDuration)

			if var_290_8 <= arg_287_1.time_ and arg_287_1.time_ < var_290_8 + var_290_16 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_8) / var_290_16

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_8 + var_290_16 and arg_287_1.time_ < var_290_8 + var_290_16 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play424051072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 424051072
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play424051073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0
			local var_294_1 = 1.2

			if var_294_0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_2 = arg_291_1:FormatText(StoryNameCfg[7].name)

				arg_291_1.leftNameTxt_.text = var_294_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_3 = arg_291_1:GetWordFromCfg(424051072)
				local var_294_4 = arg_291_1:FormatText(var_294_3.content)

				arg_291_1.text_.text = var_294_4

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 48
				local var_294_6 = utf8.len(var_294_4)
				local var_294_7 = var_294_5 <= 0 and var_294_1 or var_294_1 * (var_294_6 / var_294_5)

				if var_294_7 > 0 and var_294_1 < var_294_7 then
					arg_291_1.talkMaxDuration = var_294_7

					if var_294_7 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_7 + var_294_0
					end
				end

				arg_291_1.text_.text = var_294_4
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_8 = math.max(var_294_1, arg_291_1.talkMaxDuration)

			if var_294_0 <= arg_291_1.time_ and arg_291_1.time_ < var_294_0 + var_294_8 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_0) / var_294_8

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_0 + var_294_8 and arg_291_1.time_ < var_294_0 + var_294_8 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play424051073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 424051073
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play424051074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 0.975

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_2 = arg_295_1:FormatText(StoryNameCfg[7].name)

				arg_295_1.leftNameTxt_.text = var_298_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_3 = arg_295_1:GetWordFromCfg(424051073)
				local var_298_4 = arg_295_1:FormatText(var_298_3.content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 39
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
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_8 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_8 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_8

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_8 and arg_295_1.time_ < var_298_0 + var_298_8 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play424051074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 424051074
		arg_299_1.duration_ = 3.33

		local var_299_0 = {
			zh = 1.433,
			ja = 3.333
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
				arg_299_0:Play424051075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["10155"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.actorSpriteComps10155 == nil then
				arg_299_1.var_.actorSpriteComps10155 = var_302_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_2 = 0.2

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 and not isNil(var_302_0) then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2

				if arg_299_1.var_.actorSpriteComps10155 then
					for iter_302_0, iter_302_1 in pairs(arg_299_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.actorSpriteComps10155 then
				for iter_302_2, iter_302_3 in pairs(arg_299_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_302_3 then
						if arg_299_1.isInRecall_ then
							iter_302_3.color = arg_299_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_302_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_299_1.var_.actorSpriteComps10155 = nil
			end

			local var_302_8 = arg_299_1.actors_["10155"].transform
			local var_302_9 = 0

			if var_302_9 < arg_299_1.time_ and arg_299_1.time_ <= var_302_9 + arg_302_0 then
				arg_299_1.var_.moveOldPos10155 = var_302_8.localPosition
				var_302_8.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("10155", 2)

				local var_302_10 = var_302_8.childCount

				for iter_302_4 = 0, var_302_10 - 1 do
					local var_302_11 = var_302_8:GetChild(iter_302_4)

					if var_302_11.name == "split_1" or not string.find(var_302_11.name, "split") then
						var_302_11.gameObject:SetActive(true)
					else
						var_302_11.gameObject:SetActive(false)
					end
				end
			end

			local var_302_12 = 0.001

			if var_302_9 <= arg_299_1.time_ and arg_299_1.time_ < var_302_9 + var_302_12 then
				local var_302_13 = (arg_299_1.time_ - var_302_9) / var_302_12
				local var_302_14 = Vector3.New(-410, -390, -250)

				var_302_8.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10155, var_302_14, var_302_13)
			end

			if arg_299_1.time_ >= var_302_9 + var_302_12 and arg_299_1.time_ < var_302_9 + var_302_12 + arg_302_0 then
				var_302_8.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_302_15 = 0
			local var_302_16 = 0.15

			if var_302_15 < arg_299_1.time_ and arg_299_1.time_ <= var_302_15 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_17 = arg_299_1:FormatText(StoryNameCfg[1391].name)

				arg_299_1.leftNameTxt_.text = var_302_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_18 = arg_299_1:GetWordFromCfg(424051074)
				local var_302_19 = arg_299_1:FormatText(var_302_18.content)

				arg_299_1.text_.text = var_302_19

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_20 = 6
				local var_302_21 = utf8.len(var_302_19)
				local var_302_22 = var_302_20 <= 0 and var_302_16 or var_302_16 * (var_302_21 / var_302_20)

				if var_302_22 > 0 and var_302_16 < var_302_22 then
					arg_299_1.talkMaxDuration = var_302_22

					if var_302_22 + var_302_15 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_22 + var_302_15
					end
				end

				arg_299_1.text_.text = var_302_19
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051074", "story_v_out_424051.awb") ~= 0 then
					local var_302_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051074", "story_v_out_424051.awb") / 1000

					if var_302_23 + var_302_15 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_23 + var_302_15
					end

					if var_302_18.prefab_name ~= "" and arg_299_1.actors_[var_302_18.prefab_name] ~= nil then
						local var_302_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_18.prefab_name].transform, "story_v_out_424051", "424051074", "story_v_out_424051.awb")

						arg_299_1:RecordAudio("424051074", var_302_24)
						arg_299_1:RecordAudio("424051074", var_302_24)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_424051", "424051074", "story_v_out_424051.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_424051", "424051074", "story_v_out_424051.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_25 = math.max(var_302_16, arg_299_1.talkMaxDuration)

			if var_302_15 <= arg_299_1.time_ and arg_299_1.time_ < var_302_15 + var_302_25 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_15) / var_302_25

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_15 + var_302_25 and arg_299_1.time_ < var_302_15 + var_302_25 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
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

		arg_299_1:InitPlayNodeList()
	end,
	Play424051075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 424051075
		arg_303_1.duration_ = 1.4

		local var_303_0 = {
			zh = 1.1,
			ja = 1.4
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play424051076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1094"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.actorSpriteComps1094 == nil then
				arg_303_1.var_.actorSpriteComps1094 = var_306_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_2 = 0.2

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.actorSpriteComps1094 then
					for iter_306_0, iter_306_1 in pairs(arg_303_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_306_1 then
							if arg_303_1.isInRecall_ then
								local var_306_4 = Mathf.Lerp(iter_306_1.color.r, arg_303_1.hightColor1.r, var_306_3)
								local var_306_5 = Mathf.Lerp(iter_306_1.color.g, arg_303_1.hightColor1.g, var_306_3)
								local var_306_6 = Mathf.Lerp(iter_306_1.color.b, arg_303_1.hightColor1.b, var_306_3)

								iter_306_1.color = Color.New(var_306_4, var_306_5, var_306_6)
							else
								local var_306_7 = Mathf.Lerp(iter_306_1.color.r, 1, var_306_3)

								iter_306_1.color = Color.New(var_306_7, var_306_7, var_306_7)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.actorSpriteComps1094 then
				for iter_306_2, iter_306_3 in pairs(arg_303_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_306_3 then
						if arg_303_1.isInRecall_ then
							iter_306_3.color = arg_303_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_306_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_303_1.var_.actorSpriteComps1094 = nil
			end

			local var_306_8 = arg_303_1.actors_["10155"]
			local var_306_9 = 0

			if var_306_9 < arg_303_1.time_ and arg_303_1.time_ <= var_306_9 + arg_306_0 and not isNil(var_306_8) and arg_303_1.var_.actorSpriteComps10155 == nil then
				arg_303_1.var_.actorSpriteComps10155 = var_306_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_10 = 0.2

			if var_306_9 <= arg_303_1.time_ and arg_303_1.time_ < var_306_9 + var_306_10 and not isNil(var_306_8) then
				local var_306_11 = (arg_303_1.time_ - var_306_9) / var_306_10

				if arg_303_1.var_.actorSpriteComps10155 then
					for iter_306_4, iter_306_5 in pairs(arg_303_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_306_5 then
							if arg_303_1.isInRecall_ then
								local var_306_12 = Mathf.Lerp(iter_306_5.color.r, arg_303_1.hightColor2.r, var_306_11)
								local var_306_13 = Mathf.Lerp(iter_306_5.color.g, arg_303_1.hightColor2.g, var_306_11)
								local var_306_14 = Mathf.Lerp(iter_306_5.color.b, arg_303_1.hightColor2.b, var_306_11)

								iter_306_5.color = Color.New(var_306_12, var_306_13, var_306_14)
							else
								local var_306_15 = Mathf.Lerp(iter_306_5.color.r, 0.5, var_306_11)

								iter_306_5.color = Color.New(var_306_15, var_306_15, var_306_15)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= var_306_9 + var_306_10 and arg_303_1.time_ < var_306_9 + var_306_10 + arg_306_0 and not isNil(var_306_8) and arg_303_1.var_.actorSpriteComps10155 then
				for iter_306_6, iter_306_7 in pairs(arg_303_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_306_7 then
						if arg_303_1.isInRecall_ then
							iter_306_7.color = arg_303_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_306_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_303_1.var_.actorSpriteComps10155 = nil
			end

			local var_306_16 = arg_303_1.actors_["1094"].transform
			local var_306_17 = 0

			if var_306_17 < arg_303_1.time_ and arg_303_1.time_ <= var_306_17 + arg_306_0 then
				arg_303_1.var_.moveOldPos1094 = var_306_16.localPosition
				var_306_16.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("1094", 4)

				local var_306_18 = var_306_16.childCount

				for iter_306_8 = 0, var_306_18 - 1 do
					local var_306_19 = var_306_16:GetChild(iter_306_8)

					if var_306_19.name == "split_5" then
						var_306_19:SetAsLastSibling()
						var_306_19.gameObject:SetActive(true)

						arg_303_1.var_.actorSpriteSplit1094 = var_306_19.gameObject:GetComponent(typeof(Image))

						arg_303_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_306_20 = 0.5

			if var_306_17 <= arg_303_1.time_ and arg_303_1.time_ < var_306_17 + var_306_20 then
				local var_306_21 = (arg_303_1.time_ - var_306_17) / var_306_20
				local var_306_22 = Vector3.New(470, -335, -230)

				var_306_16.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1094, var_306_22, var_306_21)

				if arg_303_1.var_.actorSpriteSplit1094 ~= nil then
					arg_303_1.var_.actorSpriteSplit1094:SetAlpha(var_306_21)
				end
			end

			if arg_303_1.time_ >= var_306_17 + var_306_20 and arg_303_1.time_ < var_306_17 + var_306_20 + arg_306_0 then
				var_306_16.localPosition = Vector3.New(470, -335, -230)

				if arg_303_1.var_.actorSpriteSplit1094 ~= nil then
					arg_303_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_306_23 = 0
			local var_306_24 = 0.125

			if var_306_23 < arg_303_1.time_ and arg_303_1.time_ <= var_306_23 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_25 = arg_303_1:FormatText(StoryNameCfg[181].name)

				arg_303_1.leftNameTxt_.text = var_306_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_26 = arg_303_1:GetWordFromCfg(424051075)
				local var_306_27 = arg_303_1:FormatText(var_306_26.content)

				arg_303_1.text_.text = var_306_27

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_28 = 5
				local var_306_29 = utf8.len(var_306_27)
				local var_306_30 = var_306_28 <= 0 and var_306_24 or var_306_24 * (var_306_29 / var_306_28)

				if var_306_30 > 0 and var_306_24 < var_306_30 then
					arg_303_1.talkMaxDuration = var_306_30

					if var_306_30 + var_306_23 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_30 + var_306_23
					end
				end

				arg_303_1.text_.text = var_306_27
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051075", "story_v_out_424051.awb") ~= 0 then
					local var_306_31 = manager.audio:GetVoiceLength("story_v_out_424051", "424051075", "story_v_out_424051.awb") / 1000

					if var_306_31 + var_306_23 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_31 + var_306_23
					end

					if var_306_26.prefab_name ~= "" and arg_303_1.actors_[var_306_26.prefab_name] ~= nil then
						local var_306_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_26.prefab_name].transform, "story_v_out_424051", "424051075", "story_v_out_424051.awb")

						arg_303_1:RecordAudio("424051075", var_306_32)
						arg_303_1:RecordAudio("424051075", var_306_32)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_424051", "424051075", "story_v_out_424051.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_424051", "424051075", "story_v_out_424051.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_33 = math.max(var_306_24, arg_303_1.talkMaxDuration)

			if var_306_23 <= arg_303_1.time_ and arg_303_1.time_ < var_306_23 + var_306_33 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_23) / var_306_33

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_23 + var_306_33 and arg_303_1.time_ < var_306_23 + var_306_33 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play424051076 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 424051076
		arg_307_1.duration_ = 10.2

		local var_307_0 = {
			zh = 7.1,
			ja = 10.2
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play424051077(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["10155"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.actorSpriteComps10155 == nil then
				arg_307_1.var_.actorSpriteComps10155 = var_310_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_2 = 0.2

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 and not isNil(var_310_0) then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2

				if arg_307_1.var_.actorSpriteComps10155 then
					for iter_310_0, iter_310_1 in pairs(arg_307_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_310_1 then
							if arg_307_1.isInRecall_ then
								local var_310_4 = Mathf.Lerp(iter_310_1.color.r, arg_307_1.hightColor1.r, var_310_3)
								local var_310_5 = Mathf.Lerp(iter_310_1.color.g, arg_307_1.hightColor1.g, var_310_3)
								local var_310_6 = Mathf.Lerp(iter_310_1.color.b, arg_307_1.hightColor1.b, var_310_3)

								iter_310_1.color = Color.New(var_310_4, var_310_5, var_310_6)
							else
								local var_310_7 = Mathf.Lerp(iter_310_1.color.r, 1, var_310_3)

								iter_310_1.color = Color.New(var_310_7, var_310_7, var_310_7)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.actorSpriteComps10155 then
				for iter_310_2, iter_310_3 in pairs(arg_307_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_310_3 then
						if arg_307_1.isInRecall_ then
							iter_310_3.color = arg_307_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_310_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_307_1.var_.actorSpriteComps10155 = nil
			end

			local var_310_8 = arg_307_1.actors_["1094"]
			local var_310_9 = 0

			if var_310_9 < arg_307_1.time_ and arg_307_1.time_ <= var_310_9 + arg_310_0 and not isNil(var_310_8) and arg_307_1.var_.actorSpriteComps1094 == nil then
				arg_307_1.var_.actorSpriteComps1094 = var_310_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_10 = 0.2

			if var_310_9 <= arg_307_1.time_ and arg_307_1.time_ < var_310_9 + var_310_10 and not isNil(var_310_8) then
				local var_310_11 = (arg_307_1.time_ - var_310_9) / var_310_10

				if arg_307_1.var_.actorSpriteComps1094 then
					for iter_310_4, iter_310_5 in pairs(arg_307_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_310_5 then
							if arg_307_1.isInRecall_ then
								local var_310_12 = Mathf.Lerp(iter_310_5.color.r, arg_307_1.hightColor2.r, var_310_11)
								local var_310_13 = Mathf.Lerp(iter_310_5.color.g, arg_307_1.hightColor2.g, var_310_11)
								local var_310_14 = Mathf.Lerp(iter_310_5.color.b, arg_307_1.hightColor2.b, var_310_11)

								iter_310_5.color = Color.New(var_310_12, var_310_13, var_310_14)
							else
								local var_310_15 = Mathf.Lerp(iter_310_5.color.r, 0.5, var_310_11)

								iter_310_5.color = Color.New(var_310_15, var_310_15, var_310_15)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= var_310_9 + var_310_10 and arg_307_1.time_ < var_310_9 + var_310_10 + arg_310_0 and not isNil(var_310_8) and arg_307_1.var_.actorSpriteComps1094 then
				for iter_310_6, iter_310_7 in pairs(arg_307_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_310_7 then
						if arg_307_1.isInRecall_ then
							iter_310_7.color = arg_307_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_310_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_307_1.var_.actorSpriteComps1094 = nil
			end

			local var_310_16 = arg_307_1.actors_["10155"].transform
			local var_310_17 = 0

			if var_310_17 < arg_307_1.time_ and arg_307_1.time_ <= var_310_17 + arg_310_0 then
				arg_307_1.var_.moveOldPos10155 = var_310_16.localPosition
				var_310_16.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("10155", 2)

				local var_310_18 = var_310_16.childCount

				for iter_310_8 = 0, var_310_18 - 1 do
					local var_310_19 = var_310_16:GetChild(iter_310_8)

					if var_310_19.name == "split_4" then
						var_310_19:SetAsLastSibling()
						var_310_19.gameObject:SetActive(true)

						arg_307_1.var_.actorSpriteSplit10155 = var_310_19.gameObject:GetComponent(typeof(Image))

						arg_307_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_310_20 = 0.5

			if var_310_17 <= arg_307_1.time_ and arg_307_1.time_ < var_310_17 + var_310_20 then
				local var_310_21 = (arg_307_1.time_ - var_310_17) / var_310_20
				local var_310_22 = Vector3.New(-410, -390, -250)

				var_310_16.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos10155, var_310_22, var_310_21)

				if arg_307_1.var_.actorSpriteSplit10155 ~= nil then
					arg_307_1.var_.actorSpriteSplit10155:SetAlpha(var_310_21)
				end
			end

			if arg_307_1.time_ >= var_310_17 + var_310_20 and arg_307_1.time_ < var_310_17 + var_310_20 + arg_310_0 then
				var_310_16.localPosition = Vector3.New(-410, -390, -250)

				if arg_307_1.var_.actorSpriteSplit10155 ~= nil then
					arg_307_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_310_23 = 0
			local var_310_24 = 0.75

			if var_310_23 < arg_307_1.time_ and arg_307_1.time_ <= var_310_23 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_25 = arg_307_1:FormatText(StoryNameCfg[1391].name)

				arg_307_1.leftNameTxt_.text = var_310_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_26 = arg_307_1:GetWordFromCfg(424051076)
				local var_310_27 = arg_307_1:FormatText(var_310_26.content)

				arg_307_1.text_.text = var_310_27

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_28 = 30
				local var_310_29 = utf8.len(var_310_27)
				local var_310_30 = var_310_28 <= 0 and var_310_24 or var_310_24 * (var_310_29 / var_310_28)

				if var_310_30 > 0 and var_310_24 < var_310_30 then
					arg_307_1.talkMaxDuration = var_310_30

					if var_310_30 + var_310_23 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_30 + var_310_23
					end
				end

				arg_307_1.text_.text = var_310_27
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051076", "story_v_out_424051.awb") ~= 0 then
					local var_310_31 = manager.audio:GetVoiceLength("story_v_out_424051", "424051076", "story_v_out_424051.awb") / 1000

					if var_310_31 + var_310_23 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_31 + var_310_23
					end

					if var_310_26.prefab_name ~= "" and arg_307_1.actors_[var_310_26.prefab_name] ~= nil then
						local var_310_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_26.prefab_name].transform, "story_v_out_424051", "424051076", "story_v_out_424051.awb")

						arg_307_1:RecordAudio("424051076", var_310_32)
						arg_307_1:RecordAudio("424051076", var_310_32)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_424051", "424051076", "story_v_out_424051.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_424051", "424051076", "story_v_out_424051.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_33 = math.max(var_310_24, arg_307_1.talkMaxDuration)

			if var_310_23 <= arg_307_1.time_ and arg_307_1.time_ < var_310_23 + var_310_33 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_23) / var_310_33

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_23 + var_310_33 and arg_307_1.time_ < var_310_23 + var_310_33 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play424051077 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 424051077
		arg_311_1.duration_ = 4.8

		local var_311_0 = {
			zh = 3,
			ja = 4.8
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
				arg_311_0:Play424051078(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["10155"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps10155 == nil then
				arg_311_1.var_.actorSpriteComps10155 = var_314_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_2 = 0.2

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.actorSpriteComps10155 then
					for iter_314_0, iter_314_1 in pairs(arg_311_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_314_1 then
							if arg_311_1.isInRecall_ then
								local var_314_4 = Mathf.Lerp(iter_314_1.color.r, arg_311_1.hightColor2.r, var_314_3)
								local var_314_5 = Mathf.Lerp(iter_314_1.color.g, arg_311_1.hightColor2.g, var_314_3)
								local var_314_6 = Mathf.Lerp(iter_314_1.color.b, arg_311_1.hightColor2.b, var_314_3)

								iter_314_1.color = Color.New(var_314_4, var_314_5, var_314_6)
							else
								local var_314_7 = Mathf.Lerp(iter_314_1.color.r, 0.5, var_314_3)

								iter_314_1.color = Color.New(var_314_7, var_314_7, var_314_7)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps10155 then
				for iter_314_2, iter_314_3 in pairs(arg_311_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_314_3 then
						if arg_311_1.isInRecall_ then
							iter_314_3.color = arg_311_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_314_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_311_1.var_.actorSpriteComps10155 = nil
			end

			local var_314_8 = arg_311_1.actors_["1094"].transform
			local var_314_9 = 0

			if var_314_9 < arg_311_1.time_ and arg_311_1.time_ <= var_314_9 + arg_314_0 then
				arg_311_1.var_.moveOldPos1094 = var_314_8.localPosition
				var_314_8.localScale = Vector3.New(1, 1, 1)

				arg_311_1:CheckSpriteTmpPos("1094", 4)

				local var_314_10 = var_314_8.childCount

				for iter_314_4 = 0, var_314_10 - 1 do
					local var_314_11 = var_314_8:GetChild(iter_314_4)

					if var_314_11.name == "split_1" then
						var_314_11:SetAsLastSibling()
						var_314_11.gameObject:SetActive(true)

						arg_311_1.var_.actorSpriteSplit1094 = var_314_11.gameObject:GetComponent(typeof(Image))

						arg_311_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_314_12 = 0.5

			if var_314_9 <= arg_311_1.time_ and arg_311_1.time_ < var_314_9 + var_314_12 then
				local var_314_13 = (arg_311_1.time_ - var_314_9) / var_314_12
				local var_314_14 = Vector3.New(470, -335, -230)

				var_314_8.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1094, var_314_14, var_314_13)

				if arg_311_1.var_.actorSpriteSplit1094 ~= nil then
					arg_311_1.var_.actorSpriteSplit1094:SetAlpha(var_314_13)
				end
			end

			if arg_311_1.time_ >= var_314_9 + var_314_12 and arg_311_1.time_ < var_314_9 + var_314_12 + arg_314_0 then
				var_314_8.localPosition = Vector3.New(470, -335, -230)

				if arg_311_1.var_.actorSpriteSplit1094 ~= nil then
					arg_311_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_314_15 = 0
			local var_314_16 = 0.35

			if var_314_15 < arg_311_1.time_ and arg_311_1.time_ <= var_314_15 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_17 = arg_311_1:FormatText(StoryNameCfg[177].name)

				arg_311_1.leftNameTxt_.text = var_314_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_18 = arg_311_1:GetWordFromCfg(424051077)
				local var_314_19 = arg_311_1:FormatText(var_314_18.content)

				arg_311_1.text_.text = var_314_19

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_20 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051077", "story_v_out_424051.awb") ~= 0 then
					local var_314_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051077", "story_v_out_424051.awb") / 1000

					if var_314_23 + var_314_15 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_23 + var_314_15
					end

					if var_314_18.prefab_name ~= "" and arg_311_1.actors_[var_314_18.prefab_name] ~= nil then
						local var_314_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_18.prefab_name].transform, "story_v_out_424051", "424051077", "story_v_out_424051.awb")

						arg_311_1:RecordAudio("424051077", var_314_24)
						arg_311_1:RecordAudio("424051077", var_314_24)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_424051", "424051077", "story_v_out_424051.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_424051", "424051077", "story_v_out_424051.awb")
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
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play424051078 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 424051078
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play424051079(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0
			local var_318_1 = 0.175

			if var_318_0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_2 = arg_315_1:FormatText(StoryNameCfg[7].name)

				arg_315_1.leftNameTxt_.text = var_318_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_3 = arg_315_1:GetWordFromCfg(424051078)
				local var_318_4 = arg_315_1:FormatText(var_318_3.content)

				arg_315_1.text_.text = var_318_4

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 7
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
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_8 = math.max(var_318_1, arg_315_1.talkMaxDuration)

			if var_318_0 <= arg_315_1.time_ and arg_315_1.time_ < var_318_0 + var_318_8 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_0) / var_318_8

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_0 + var_318_8 and arg_315_1.time_ < var_318_0 + var_318_8 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play424051079 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 424051079
		arg_319_1.duration_ = 22.53

		local var_319_0 = {
			zh = 13.433,
			ja = 22.533
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
				arg_319_0:Play424051080(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["10155"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.actorSpriteComps10155 == nil then
				arg_319_1.var_.actorSpriteComps10155 = var_322_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_2 = 0.2

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 and not isNil(var_322_0) then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2

				if arg_319_1.var_.actorSpriteComps10155 then
					for iter_322_0, iter_322_1 in pairs(arg_319_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.actorSpriteComps10155 then
				for iter_322_2, iter_322_3 in pairs(arg_319_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_322_3 then
						if arg_319_1.isInRecall_ then
							iter_322_3.color = arg_319_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_322_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_319_1.var_.actorSpriteComps10155 = nil
			end

			local var_322_8 = arg_319_1.actors_["10155"].transform
			local var_322_9 = 0

			if var_322_9 < arg_319_1.time_ and arg_319_1.time_ <= var_322_9 + arg_322_0 then
				arg_319_1.var_.moveOldPos10155 = var_322_8.localPosition
				var_322_8.localScale = Vector3.New(1, 1, 1)

				arg_319_1:CheckSpriteTmpPos("10155", 2)

				local var_322_10 = var_322_8.childCount

				for iter_322_4 = 0, var_322_10 - 1 do
					local var_322_11 = var_322_8:GetChild(iter_322_4)

					if var_322_11.name == "split_1" then
						var_322_11:SetAsLastSibling()
						var_322_11.gameObject:SetActive(true)

						arg_319_1.var_.actorSpriteSplit10155 = var_322_11.gameObject:GetComponent(typeof(Image))

						arg_319_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_322_12 = 0.5

			if var_322_9 <= arg_319_1.time_ and arg_319_1.time_ < var_322_9 + var_322_12 then
				local var_322_13 = (arg_319_1.time_ - var_322_9) / var_322_12
				local var_322_14 = Vector3.New(-410, -390, -250)

				var_322_8.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos10155, var_322_14, var_322_13)

				if arg_319_1.var_.actorSpriteSplit10155 ~= nil then
					arg_319_1.var_.actorSpriteSplit10155:SetAlpha(var_322_13)
				end
			end

			if arg_319_1.time_ >= var_322_9 + var_322_12 and arg_319_1.time_ < var_322_9 + var_322_12 + arg_322_0 then
				var_322_8.localPosition = Vector3.New(-410, -390, -250)

				if arg_319_1.var_.actorSpriteSplit10155 ~= nil then
					arg_319_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_322_15 = 0
			local var_322_16 = 1.4

			if var_322_15 < arg_319_1.time_ and arg_319_1.time_ <= var_322_15 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_17 = arg_319_1:FormatText(StoryNameCfg[1391].name)

				arg_319_1.leftNameTxt_.text = var_322_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_18 = arg_319_1:GetWordFromCfg(424051079)
				local var_322_19 = arg_319_1:FormatText(var_322_18.content)

				arg_319_1.text_.text = var_322_19

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_20 = 56
				local var_322_21 = utf8.len(var_322_19)
				local var_322_22 = var_322_20 <= 0 and var_322_16 or var_322_16 * (var_322_21 / var_322_20)

				if var_322_22 > 0 and var_322_16 < var_322_22 then
					arg_319_1.talkMaxDuration = var_322_22

					if var_322_22 + var_322_15 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_22 + var_322_15
					end
				end

				arg_319_1.text_.text = var_322_19
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051079", "story_v_out_424051.awb") ~= 0 then
					local var_322_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051079", "story_v_out_424051.awb") / 1000

					if var_322_23 + var_322_15 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_23 + var_322_15
					end

					if var_322_18.prefab_name ~= "" and arg_319_1.actors_[var_322_18.prefab_name] ~= nil then
						local var_322_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_18.prefab_name].transform, "story_v_out_424051", "424051079", "story_v_out_424051.awb")

						arg_319_1:RecordAudio("424051079", var_322_24)
						arg_319_1:RecordAudio("424051079", var_322_24)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_424051", "424051079", "story_v_out_424051.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_424051", "424051079", "story_v_out_424051.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_25 = math.max(var_322_16, arg_319_1.talkMaxDuration)

			if var_322_15 <= arg_319_1.time_ and arg_319_1.time_ < var_322_15 + var_322_25 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_15) / var_322_25

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_15 + var_322_25 and arg_319_1.time_ < var_322_15 + var_322_25 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play424051080 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 424051080
		arg_323_1.duration_ = 23.6

		local var_323_0 = {
			zh = 16.866,
			ja = 23.6
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
				arg_323_0:Play424051081(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["10155"].transform
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1.var_.moveOldPos10155 = var_326_0.localPosition
				var_326_0.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("10155", 2)

				local var_326_2 = var_326_0.childCount

				for iter_326_0 = 0, var_326_2 - 1 do
					local var_326_3 = var_326_0:GetChild(iter_326_0)

					if var_326_3.name == "" or not string.find(var_326_3.name, "split") then
						var_326_3.gameObject:SetActive(true)
					else
						var_326_3.gameObject:SetActive(false)
					end
				end
			end

			local var_326_4 = 0.001

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_4 then
				local var_326_5 = (arg_323_1.time_ - var_326_1) / var_326_4
				local var_326_6 = Vector3.New(-410, -390, -250)

				var_326_0.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10155, var_326_6, var_326_5)
			end

			if arg_323_1.time_ >= var_326_1 + var_326_4 and arg_323_1.time_ < var_326_1 + var_326_4 + arg_326_0 then
				var_326_0.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_326_7 = 0
			local var_326_8 = 1.825

			if var_326_7 < arg_323_1.time_ and arg_323_1.time_ <= var_326_7 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_9 = arg_323_1:FormatText(StoryNameCfg[1391].name)

				arg_323_1.leftNameTxt_.text = var_326_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_10 = arg_323_1:GetWordFromCfg(424051080)
				local var_326_11 = arg_323_1:FormatText(var_326_10.content)

				arg_323_1.text_.text = var_326_11

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_12 = 73
				local var_326_13 = utf8.len(var_326_11)
				local var_326_14 = var_326_12 <= 0 and var_326_8 or var_326_8 * (var_326_13 / var_326_12)

				if var_326_14 > 0 and var_326_8 < var_326_14 then
					arg_323_1.talkMaxDuration = var_326_14

					if var_326_14 + var_326_7 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_14 + var_326_7
					end
				end

				arg_323_1.text_.text = var_326_11
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051080", "story_v_out_424051.awb") ~= 0 then
					local var_326_15 = manager.audio:GetVoiceLength("story_v_out_424051", "424051080", "story_v_out_424051.awb") / 1000

					if var_326_15 + var_326_7 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_15 + var_326_7
					end

					if var_326_10.prefab_name ~= "" and arg_323_1.actors_[var_326_10.prefab_name] ~= nil then
						local var_326_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_10.prefab_name].transform, "story_v_out_424051", "424051080", "story_v_out_424051.awb")

						arg_323_1:RecordAudio("424051080", var_326_16)
						arg_323_1:RecordAudio("424051080", var_326_16)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_424051", "424051080", "story_v_out_424051.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_424051", "424051080", "story_v_out_424051.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_17 = math.max(var_326_8, arg_323_1.talkMaxDuration)

			if var_326_7 <= arg_323_1.time_ and arg_323_1.time_ < var_326_7 + var_326_17 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_7) / var_326_17

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_7 + var_326_17 and arg_323_1.time_ < var_326_7 + var_326_17 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
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

		arg_323_1:InitPlayNodeList()
	end,
	Play424051081 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 424051081
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play424051082(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["10155"]
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.actorSpriteComps10155 == nil then
				arg_327_1.var_.actorSpriteComps10155 = var_330_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_2 = 0.2

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 and not isNil(var_330_0) then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2

				if arg_327_1.var_.actorSpriteComps10155 then
					for iter_330_0, iter_330_1 in pairs(arg_327_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_330_1 then
							if arg_327_1.isInRecall_ then
								local var_330_4 = Mathf.Lerp(iter_330_1.color.r, arg_327_1.hightColor2.r, var_330_3)
								local var_330_5 = Mathf.Lerp(iter_330_1.color.g, arg_327_1.hightColor2.g, var_330_3)
								local var_330_6 = Mathf.Lerp(iter_330_1.color.b, arg_327_1.hightColor2.b, var_330_3)

								iter_330_1.color = Color.New(var_330_4, var_330_5, var_330_6)
							else
								local var_330_7 = Mathf.Lerp(iter_330_1.color.r, 0.5, var_330_3)

								iter_330_1.color = Color.New(var_330_7, var_330_7, var_330_7)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.actorSpriteComps10155 then
				for iter_330_2, iter_330_3 in pairs(arg_327_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_330_3 then
						if arg_327_1.isInRecall_ then
							iter_330_3.color = arg_327_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_330_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_327_1.var_.actorSpriteComps10155 = nil
			end

			local var_330_8 = 0
			local var_330_9 = 0.5

			if var_330_8 < arg_327_1.time_ and arg_327_1.time_ <= var_330_8 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_10 = arg_327_1:FormatText(StoryNameCfg[7].name)

				arg_327_1.leftNameTxt_.text = var_330_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_11 = arg_327_1:GetWordFromCfg(424051081)
				local var_330_12 = arg_327_1:FormatText(var_330_11.content)

				arg_327_1.text_.text = var_330_12

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_13 = 20
				local var_330_14 = utf8.len(var_330_12)
				local var_330_15 = var_330_13 <= 0 and var_330_9 or var_330_9 * (var_330_14 / var_330_13)

				if var_330_15 > 0 and var_330_9 < var_330_15 then
					arg_327_1.talkMaxDuration = var_330_15

					if var_330_15 + var_330_8 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_15 + var_330_8
					end
				end

				arg_327_1.text_.text = var_330_12
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_16 = math.max(var_330_9, arg_327_1.talkMaxDuration)

			if var_330_8 <= arg_327_1.time_ and arg_327_1.time_ < var_330_8 + var_330_16 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_8) / var_330_16

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_8 + var_330_16 and arg_327_1.time_ < var_330_8 + var_330_16 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play424051082 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 424051082
		arg_331_1.duration_ = 3.97

		local var_331_0 = {
			zh = 2.8,
			ja = 3.966
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play424051083(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["10155"]
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.actorSpriteComps10155 == nil then
				arg_331_1.var_.actorSpriteComps10155 = var_334_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_2 = 0.2

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 and not isNil(var_334_0) then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2

				if arg_331_1.var_.actorSpriteComps10155 then
					for iter_334_0, iter_334_1 in pairs(arg_331_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_334_1 then
							if arg_331_1.isInRecall_ then
								local var_334_4 = Mathf.Lerp(iter_334_1.color.r, arg_331_1.hightColor1.r, var_334_3)
								local var_334_5 = Mathf.Lerp(iter_334_1.color.g, arg_331_1.hightColor1.g, var_334_3)
								local var_334_6 = Mathf.Lerp(iter_334_1.color.b, arg_331_1.hightColor1.b, var_334_3)

								iter_334_1.color = Color.New(var_334_4, var_334_5, var_334_6)
							else
								local var_334_7 = Mathf.Lerp(iter_334_1.color.r, 1, var_334_3)

								iter_334_1.color = Color.New(var_334_7, var_334_7, var_334_7)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.actorSpriteComps10155 then
				for iter_334_2, iter_334_3 in pairs(arg_331_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_334_3 then
						if arg_331_1.isInRecall_ then
							iter_334_3.color = arg_331_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_334_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_331_1.var_.actorSpriteComps10155 = nil
			end

			local var_334_8 = arg_331_1.actors_["10155"].transform
			local var_334_9 = 0

			if var_334_9 < arg_331_1.time_ and arg_331_1.time_ <= var_334_9 + arg_334_0 then
				arg_331_1.var_.moveOldPos10155 = var_334_8.localPosition
				var_334_8.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("10155", 2)

				local var_334_10 = var_334_8.childCount

				for iter_334_4 = 0, var_334_10 - 1 do
					local var_334_11 = var_334_8:GetChild(iter_334_4)

					if var_334_11.name == "split_5" then
						var_334_11:SetAsLastSibling()
						var_334_11.gameObject:SetActive(true)

						arg_331_1.var_.actorSpriteSplit10155 = var_334_11.gameObject:GetComponent(typeof(Image))

						arg_331_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_334_12 = 0.5

			if var_334_9 <= arg_331_1.time_ and arg_331_1.time_ < var_334_9 + var_334_12 then
				local var_334_13 = (arg_331_1.time_ - var_334_9) / var_334_12
				local var_334_14 = Vector3.New(-410, -390, -250)

				var_334_8.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10155, var_334_14, var_334_13)

				if arg_331_1.var_.actorSpriteSplit10155 ~= nil then
					arg_331_1.var_.actorSpriteSplit10155:SetAlpha(var_334_13)
				end
			end

			if arg_331_1.time_ >= var_334_9 + var_334_12 and arg_331_1.time_ < var_334_9 + var_334_12 + arg_334_0 then
				var_334_8.localPosition = Vector3.New(-410, -390, -250)

				if arg_331_1.var_.actorSpriteSplit10155 ~= nil then
					arg_331_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_334_15 = 0
			local var_334_16 = 0.225

			if var_334_15 < arg_331_1.time_ and arg_331_1.time_ <= var_334_15 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_17 = arg_331_1:FormatText(StoryNameCfg[1391].name)

				arg_331_1.leftNameTxt_.text = var_334_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_18 = arg_331_1:GetWordFromCfg(424051082)
				local var_334_19 = arg_331_1:FormatText(var_334_18.content)

				arg_331_1.text_.text = var_334_19

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_20 = 9
				local var_334_21 = utf8.len(var_334_19)
				local var_334_22 = var_334_20 <= 0 and var_334_16 or var_334_16 * (var_334_21 / var_334_20)

				if var_334_22 > 0 and var_334_16 < var_334_22 then
					arg_331_1.talkMaxDuration = var_334_22

					if var_334_22 + var_334_15 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_22 + var_334_15
					end
				end

				arg_331_1.text_.text = var_334_19
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051082", "story_v_out_424051.awb") ~= 0 then
					local var_334_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051082", "story_v_out_424051.awb") / 1000

					if var_334_23 + var_334_15 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_23 + var_334_15
					end

					if var_334_18.prefab_name ~= "" and arg_331_1.actors_[var_334_18.prefab_name] ~= nil then
						local var_334_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_18.prefab_name].transform, "story_v_out_424051", "424051082", "story_v_out_424051.awb")

						arg_331_1:RecordAudio("424051082", var_334_24)
						arg_331_1:RecordAudio("424051082", var_334_24)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_424051", "424051082", "story_v_out_424051.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_424051", "424051082", "story_v_out_424051.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_25 = math.max(var_334_16, arg_331_1.talkMaxDuration)

			if var_334_15 <= arg_331_1.time_ and arg_331_1.time_ < var_334_15 + var_334_25 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_15) / var_334_25

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_15 + var_334_25 and arg_331_1.time_ < var_334_15 + var_334_25 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play424051083 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 424051083
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play424051084(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["10155"]
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.actorSpriteComps10155 == nil then
				arg_335_1.var_.actorSpriteComps10155 = var_338_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_2 = 0.2

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 and not isNil(var_338_0) then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2

				if arg_335_1.var_.actorSpriteComps10155 then
					for iter_338_0, iter_338_1 in pairs(arg_335_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_338_1 then
							if arg_335_1.isInRecall_ then
								local var_338_4 = Mathf.Lerp(iter_338_1.color.r, arg_335_1.hightColor2.r, var_338_3)
								local var_338_5 = Mathf.Lerp(iter_338_1.color.g, arg_335_1.hightColor2.g, var_338_3)
								local var_338_6 = Mathf.Lerp(iter_338_1.color.b, arg_335_1.hightColor2.b, var_338_3)

								iter_338_1.color = Color.New(var_338_4, var_338_5, var_338_6)
							else
								local var_338_7 = Mathf.Lerp(iter_338_1.color.r, 0.5, var_338_3)

								iter_338_1.color = Color.New(var_338_7, var_338_7, var_338_7)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.actorSpriteComps10155 then
				for iter_338_2, iter_338_3 in pairs(arg_335_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_338_3 then
						if arg_335_1.isInRecall_ then
							iter_338_3.color = arg_335_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_338_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_335_1.var_.actorSpriteComps10155 = nil
			end

			local var_338_8 = 0
			local var_338_9 = 0.625

			if var_338_8 < arg_335_1.time_ and arg_335_1.time_ <= var_338_8 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_10 = arg_335_1:FormatText(StoryNameCfg[7].name)

				arg_335_1.leftNameTxt_.text = var_338_10

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

				local var_338_11 = arg_335_1:GetWordFromCfg(424051083)
				local var_338_12 = arg_335_1:FormatText(var_338_11.content)

				arg_335_1.text_.text = var_338_12

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_13 = 25
				local var_338_14 = utf8.len(var_338_12)
				local var_338_15 = var_338_13 <= 0 and var_338_9 or var_338_9 * (var_338_14 / var_338_13)

				if var_338_15 > 0 and var_338_9 < var_338_15 then
					arg_335_1.talkMaxDuration = var_338_15

					if var_338_15 + var_338_8 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_15 + var_338_8
					end
				end

				arg_335_1.text_.text = var_338_12
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_16 = math.max(var_338_9, arg_335_1.talkMaxDuration)

			if var_338_8 <= arg_335_1.time_ and arg_335_1.time_ < var_338_8 + var_338_16 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_8) / var_338_16

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_8 + var_338_16 and arg_335_1.time_ < var_338_8 + var_338_16 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play424051084 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 424051084
		arg_339_1.duration_ = 17.37

		local var_339_0 = {
			zh = 11.2,
			ja = 17.366
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play424051085(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["10155"]
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.actorSpriteComps10155 == nil then
				arg_339_1.var_.actorSpriteComps10155 = var_342_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_2 = 0.2

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 and not isNil(var_342_0) then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2

				if arg_339_1.var_.actorSpriteComps10155 then
					for iter_342_0, iter_342_1 in pairs(arg_339_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_342_1 then
							if arg_339_1.isInRecall_ then
								local var_342_4 = Mathf.Lerp(iter_342_1.color.r, arg_339_1.hightColor1.r, var_342_3)
								local var_342_5 = Mathf.Lerp(iter_342_1.color.g, arg_339_1.hightColor1.g, var_342_3)
								local var_342_6 = Mathf.Lerp(iter_342_1.color.b, arg_339_1.hightColor1.b, var_342_3)

								iter_342_1.color = Color.New(var_342_4, var_342_5, var_342_6)
							else
								local var_342_7 = Mathf.Lerp(iter_342_1.color.r, 1, var_342_3)

								iter_342_1.color = Color.New(var_342_7, var_342_7, var_342_7)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.actorSpriteComps10155 then
				for iter_342_2, iter_342_3 in pairs(arg_339_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_342_3 then
						if arg_339_1.isInRecall_ then
							iter_342_3.color = arg_339_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_342_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_339_1.var_.actorSpriteComps10155 = nil
			end

			local var_342_8 = arg_339_1.actors_["10155"].transform
			local var_342_9 = 0

			if var_342_9 < arg_339_1.time_ and arg_339_1.time_ <= var_342_9 + arg_342_0 then
				arg_339_1.var_.moveOldPos10155 = var_342_8.localPosition
				var_342_8.localScale = Vector3.New(1, 1, 1)

				arg_339_1:CheckSpriteTmpPos("10155", 2)

				local var_342_10 = var_342_8.childCount

				for iter_342_4 = 0, var_342_10 - 1 do
					local var_342_11 = var_342_8:GetChild(iter_342_4)

					if var_342_11.name == "split_4" or not string.find(var_342_11.name, "split") then
						var_342_11.gameObject:SetActive(true)
					else
						var_342_11.gameObject:SetActive(false)
					end
				end
			end

			local var_342_12 = 0.001

			if var_342_9 <= arg_339_1.time_ and arg_339_1.time_ < var_342_9 + var_342_12 then
				local var_342_13 = (arg_339_1.time_ - var_342_9) / var_342_12
				local var_342_14 = Vector3.New(-410, -390, -250)

				var_342_8.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos10155, var_342_14, var_342_13)
			end

			if arg_339_1.time_ >= var_342_9 + var_342_12 and arg_339_1.time_ < var_342_9 + var_342_12 + arg_342_0 then
				var_342_8.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_342_15 = 0
			local var_342_16 = 1.05

			if var_342_15 < arg_339_1.time_ and arg_339_1.time_ <= var_342_15 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_17 = arg_339_1:FormatText(StoryNameCfg[1391].name)

				arg_339_1.leftNameTxt_.text = var_342_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_18 = arg_339_1:GetWordFromCfg(424051084)
				local var_342_19 = arg_339_1:FormatText(var_342_18.content)

				arg_339_1.text_.text = var_342_19

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_20 = 42
				local var_342_21 = utf8.len(var_342_19)
				local var_342_22 = var_342_20 <= 0 and var_342_16 or var_342_16 * (var_342_21 / var_342_20)

				if var_342_22 > 0 and var_342_16 < var_342_22 then
					arg_339_1.talkMaxDuration = var_342_22

					if var_342_22 + var_342_15 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_22 + var_342_15
					end
				end

				arg_339_1.text_.text = var_342_19
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051084", "story_v_out_424051.awb") ~= 0 then
					local var_342_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051084", "story_v_out_424051.awb") / 1000

					if var_342_23 + var_342_15 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_23 + var_342_15
					end

					if var_342_18.prefab_name ~= "" and arg_339_1.actors_[var_342_18.prefab_name] ~= nil then
						local var_342_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_18.prefab_name].transform, "story_v_out_424051", "424051084", "story_v_out_424051.awb")

						arg_339_1:RecordAudio("424051084", var_342_24)
						arg_339_1:RecordAudio("424051084", var_342_24)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_424051", "424051084", "story_v_out_424051.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_424051", "424051084", "story_v_out_424051.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_25 = math.max(var_342_16, arg_339_1.talkMaxDuration)

			if var_342_15 <= arg_339_1.time_ and arg_339_1.time_ < var_342_15 + var_342_25 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_15) / var_342_25

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_15 + var_342_25 and arg_339_1.time_ < var_342_15 + var_342_25 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
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

		arg_339_1:InitPlayNodeList()
	end,
	Play424051085 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 424051085
		arg_343_1.duration_ = 18.5

		local var_343_0 = {
			zh = 9.933,
			ja = 18.5
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play424051086(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0
			local var_346_1 = 1.15

			if var_346_0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_2 = arg_343_1:FormatText(StoryNameCfg[1391].name)

				arg_343_1.leftNameTxt_.text = var_346_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_3 = arg_343_1:GetWordFromCfg(424051085)
				local var_346_4 = arg_343_1:FormatText(var_346_3.content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_5 = 46
				local var_346_6 = utf8.len(var_346_4)
				local var_346_7 = var_346_5 <= 0 and var_346_1 or var_346_1 * (var_346_6 / var_346_5)

				if var_346_7 > 0 and var_346_1 < var_346_7 then
					arg_343_1.talkMaxDuration = var_346_7

					if var_346_7 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_7 + var_346_0
					end
				end

				arg_343_1.text_.text = var_346_4
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051085", "story_v_out_424051.awb") ~= 0 then
					local var_346_8 = manager.audio:GetVoiceLength("story_v_out_424051", "424051085", "story_v_out_424051.awb") / 1000

					if var_346_8 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_8 + var_346_0
					end

					if var_346_3.prefab_name ~= "" and arg_343_1.actors_[var_346_3.prefab_name] ~= nil then
						local var_346_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_3.prefab_name].transform, "story_v_out_424051", "424051085", "story_v_out_424051.awb")

						arg_343_1:RecordAudio("424051085", var_346_9)
						arg_343_1:RecordAudio("424051085", var_346_9)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_424051", "424051085", "story_v_out_424051.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_424051", "424051085", "story_v_out_424051.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_10 = math.max(var_346_1, arg_343_1.talkMaxDuration)

			if var_346_0 <= arg_343_1.time_ and arg_343_1.time_ < var_346_0 + var_346_10 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_0) / var_346_10

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_0 + var_346_10 and arg_343_1.time_ < var_346_0 + var_346_10 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play424051086 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 424051086
		arg_347_1.duration_ = 9.77

		local var_347_0 = {
			zh = 6.2,
			ja = 9.766
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play424051087(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["10155"].transform
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.var_.moveOldPos10155 = var_350_0.localPosition
				var_350_0.localScale = Vector3.New(1, 1, 1)

				arg_347_1:CheckSpriteTmpPos("10155", 2)

				local var_350_2 = var_350_0.childCount

				for iter_350_0 = 0, var_350_2 - 1 do
					local var_350_3 = var_350_0:GetChild(iter_350_0)

					if var_350_3.name == "" or not string.find(var_350_3.name, "split") then
						var_350_3.gameObject:SetActive(true)
					else
						var_350_3.gameObject:SetActive(false)
					end
				end
			end

			local var_350_4 = 0.001

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_4 then
				local var_350_5 = (arg_347_1.time_ - var_350_1) / var_350_4
				local var_350_6 = Vector3.New(-410, -390, -250)

				var_350_0.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos10155, var_350_6, var_350_5)
			end

			if arg_347_1.time_ >= var_350_1 + var_350_4 and arg_347_1.time_ < var_350_1 + var_350_4 + arg_350_0 then
				var_350_0.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_350_7 = 0
			local var_350_8 = 0.7

			if var_350_7 < arg_347_1.time_ and arg_347_1.time_ <= var_350_7 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_9 = arg_347_1:FormatText(StoryNameCfg[1391].name)

				arg_347_1.leftNameTxt_.text = var_350_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_10 = arg_347_1:GetWordFromCfg(424051086)
				local var_350_11 = arg_347_1:FormatText(var_350_10.content)

				arg_347_1.text_.text = var_350_11

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_12 = 28
				local var_350_13 = utf8.len(var_350_11)
				local var_350_14 = var_350_12 <= 0 and var_350_8 or var_350_8 * (var_350_13 / var_350_12)

				if var_350_14 > 0 and var_350_8 < var_350_14 then
					arg_347_1.talkMaxDuration = var_350_14

					if var_350_14 + var_350_7 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_14 + var_350_7
					end
				end

				arg_347_1.text_.text = var_350_11
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051086", "story_v_out_424051.awb") ~= 0 then
					local var_350_15 = manager.audio:GetVoiceLength("story_v_out_424051", "424051086", "story_v_out_424051.awb") / 1000

					if var_350_15 + var_350_7 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_15 + var_350_7
					end

					if var_350_10.prefab_name ~= "" and arg_347_1.actors_[var_350_10.prefab_name] ~= nil then
						local var_350_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_10.prefab_name].transform, "story_v_out_424051", "424051086", "story_v_out_424051.awb")

						arg_347_1:RecordAudio("424051086", var_350_16)
						arg_347_1:RecordAudio("424051086", var_350_16)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_424051", "424051086", "story_v_out_424051.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_424051", "424051086", "story_v_out_424051.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_17 = math.max(var_350_8, arg_347_1.talkMaxDuration)

			if var_350_7 <= arg_347_1.time_ and arg_347_1.time_ < var_350_7 + var_350_17 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_7) / var_350_17

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_7 + var_350_17 and arg_347_1.time_ < var_350_7 + var_350_17 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
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

		arg_347_1:InitPlayNodeList()
	end,
	Play424051087 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 424051087
		arg_351_1.duration_ = 3.7

		local var_351_0 = {
			zh = 2.1,
			ja = 3.7
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play424051088(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["10155"]
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.actorSpriteComps10155 == nil then
				arg_351_1.var_.actorSpriteComps10155 = var_354_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_2 = 0.2

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 and not isNil(var_354_0) then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2

				if arg_351_1.var_.actorSpriteComps10155 then
					for iter_354_0, iter_354_1 in pairs(arg_351_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_354_1 then
							if arg_351_1.isInRecall_ then
								local var_354_4 = Mathf.Lerp(iter_354_1.color.r, arg_351_1.hightColor2.r, var_354_3)
								local var_354_5 = Mathf.Lerp(iter_354_1.color.g, arg_351_1.hightColor2.g, var_354_3)
								local var_354_6 = Mathf.Lerp(iter_354_1.color.b, arg_351_1.hightColor2.b, var_354_3)

								iter_354_1.color = Color.New(var_354_4, var_354_5, var_354_6)
							else
								local var_354_7 = Mathf.Lerp(iter_354_1.color.r, 0.5, var_354_3)

								iter_354_1.color = Color.New(var_354_7, var_354_7, var_354_7)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.actorSpriteComps10155 then
				for iter_354_2, iter_354_3 in pairs(arg_351_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_354_3 then
						if arg_351_1.isInRecall_ then
							iter_354_3.color = arg_351_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_354_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_351_1.var_.actorSpriteComps10155 = nil
			end

			local var_354_8 = 0
			local var_354_9 = 0.275

			if var_354_8 < arg_351_1.time_ and arg_351_1.time_ <= var_354_8 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_10 = arg_351_1:FormatText(StoryNameCfg[177].name)

				arg_351_1.leftNameTxt_.text = var_354_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_11 = arg_351_1:GetWordFromCfg(424051087)
				local var_354_12 = arg_351_1:FormatText(var_354_11.content)

				arg_351_1.text_.text = var_354_12

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_13 = 11
				local var_354_14 = utf8.len(var_354_12)
				local var_354_15 = var_354_13 <= 0 and var_354_9 or var_354_9 * (var_354_14 / var_354_13)

				if var_354_15 > 0 and var_354_9 < var_354_15 then
					arg_351_1.talkMaxDuration = var_354_15

					if var_354_15 + var_354_8 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_15 + var_354_8
					end
				end

				arg_351_1.text_.text = var_354_12
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051087", "story_v_out_424051.awb") ~= 0 then
					local var_354_16 = manager.audio:GetVoiceLength("story_v_out_424051", "424051087", "story_v_out_424051.awb") / 1000

					if var_354_16 + var_354_8 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_16 + var_354_8
					end

					if var_354_11.prefab_name ~= "" and arg_351_1.actors_[var_354_11.prefab_name] ~= nil then
						local var_354_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_11.prefab_name].transform, "story_v_out_424051", "424051087", "story_v_out_424051.awb")

						arg_351_1:RecordAudio("424051087", var_354_17)
						arg_351_1:RecordAudio("424051087", var_354_17)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_424051", "424051087", "story_v_out_424051.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_424051", "424051087", "story_v_out_424051.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_18 = math.max(var_354_9, arg_351_1.talkMaxDuration)

			if var_354_8 <= arg_351_1.time_ and arg_351_1.time_ < var_354_8 + var_354_18 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_8) / var_354_18

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_8 + var_354_18 and arg_351_1.time_ < var_354_8 + var_354_18 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play424051088 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 424051088
		arg_355_1.duration_ = 10.3

		local var_355_0 = {
			zh = 5.7,
			ja = 10.3
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play424051089(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["10155"]
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.actorSpriteComps10155 == nil then
				arg_355_1.var_.actorSpriteComps10155 = var_358_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_2 = 0.2

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 and not isNil(var_358_0) then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2

				if arg_355_1.var_.actorSpriteComps10155 then
					for iter_358_0, iter_358_1 in pairs(arg_355_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_358_1 then
							if arg_355_1.isInRecall_ then
								local var_358_4 = Mathf.Lerp(iter_358_1.color.r, arg_355_1.hightColor1.r, var_358_3)
								local var_358_5 = Mathf.Lerp(iter_358_1.color.g, arg_355_1.hightColor1.g, var_358_3)
								local var_358_6 = Mathf.Lerp(iter_358_1.color.b, arg_355_1.hightColor1.b, var_358_3)

								iter_358_1.color = Color.New(var_358_4, var_358_5, var_358_6)
							else
								local var_358_7 = Mathf.Lerp(iter_358_1.color.r, 1, var_358_3)

								iter_358_1.color = Color.New(var_358_7, var_358_7, var_358_7)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.actorSpriteComps10155 then
				for iter_358_2, iter_358_3 in pairs(arg_355_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_358_3 then
						if arg_355_1.isInRecall_ then
							iter_358_3.color = arg_355_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_358_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_355_1.var_.actorSpriteComps10155 = nil
			end

			local var_358_8 = arg_355_1.actors_["10155"].transform
			local var_358_9 = 0

			if var_358_9 < arg_355_1.time_ and arg_355_1.time_ <= var_358_9 + arg_358_0 then
				arg_355_1.var_.moveOldPos10155 = var_358_8.localPosition
				var_358_8.localScale = Vector3.New(1, 1, 1)

				arg_355_1:CheckSpriteTmpPos("10155", 2)

				local var_358_10 = var_358_8.childCount

				for iter_358_4 = 0, var_358_10 - 1 do
					local var_358_11 = var_358_8:GetChild(iter_358_4)

					if var_358_11.name == "split_4" then
						var_358_11:SetAsLastSibling()
						var_358_11.gameObject:SetActive(true)

						arg_355_1.var_.actorSpriteSplit10155 = var_358_11.gameObject:GetComponent(typeof(Image))

						arg_355_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_358_12 = 0.5

			if var_358_9 <= arg_355_1.time_ and arg_355_1.time_ < var_358_9 + var_358_12 then
				local var_358_13 = (arg_355_1.time_ - var_358_9) / var_358_12
				local var_358_14 = Vector3.New(-410, -390, -250)

				var_358_8.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos10155, var_358_14, var_358_13)

				if arg_355_1.var_.actorSpriteSplit10155 ~= nil then
					arg_355_1.var_.actorSpriteSplit10155:SetAlpha(var_358_13)
				end
			end

			if arg_355_1.time_ >= var_358_9 + var_358_12 and arg_355_1.time_ < var_358_9 + var_358_12 + arg_358_0 then
				var_358_8.localPosition = Vector3.New(-410, -390, -250)

				if arg_355_1.var_.actorSpriteSplit10155 ~= nil then
					arg_355_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_358_15 = 0
			local var_358_16 = 0.525

			if var_358_15 < arg_355_1.time_ and arg_355_1.time_ <= var_358_15 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_17 = arg_355_1:FormatText(StoryNameCfg[1391].name)

				arg_355_1.leftNameTxt_.text = var_358_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_18 = arg_355_1:GetWordFromCfg(424051088)
				local var_358_19 = arg_355_1:FormatText(var_358_18.content)

				arg_355_1.text_.text = var_358_19

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_20 = 21
				local var_358_21 = utf8.len(var_358_19)
				local var_358_22 = var_358_20 <= 0 and var_358_16 or var_358_16 * (var_358_21 / var_358_20)

				if var_358_22 > 0 and var_358_16 < var_358_22 then
					arg_355_1.talkMaxDuration = var_358_22

					if var_358_22 + var_358_15 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_22 + var_358_15
					end
				end

				arg_355_1.text_.text = var_358_19
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051088", "story_v_out_424051.awb") ~= 0 then
					local var_358_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051088", "story_v_out_424051.awb") / 1000

					if var_358_23 + var_358_15 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_23 + var_358_15
					end

					if var_358_18.prefab_name ~= "" and arg_355_1.actors_[var_358_18.prefab_name] ~= nil then
						local var_358_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_18.prefab_name].transform, "story_v_out_424051", "424051088", "story_v_out_424051.awb")

						arg_355_1:RecordAudio("424051088", var_358_24)
						arg_355_1:RecordAudio("424051088", var_358_24)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_424051", "424051088", "story_v_out_424051.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_424051", "424051088", "story_v_out_424051.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_25 = math.max(var_358_16, arg_355_1.talkMaxDuration)

			if var_358_15 <= arg_355_1.time_ and arg_355_1.time_ < var_358_15 + var_358_25 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_15) / var_358_25

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_15 + var_358_25 and arg_355_1.time_ < var_358_15 + var_358_25 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play424051089 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 424051089
		arg_359_1.duration_ = 1.07

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play424051090(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["10155"]
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.actorSpriteComps10155 == nil then
				arg_359_1.var_.actorSpriteComps10155 = var_362_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_2 = 0.2

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 and not isNil(var_362_0) then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2

				if arg_359_1.var_.actorSpriteComps10155 then
					for iter_362_0, iter_362_1 in pairs(arg_359_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_362_1 then
							if arg_359_1.isInRecall_ then
								local var_362_4 = Mathf.Lerp(iter_362_1.color.r, arg_359_1.hightColor2.r, var_362_3)
								local var_362_5 = Mathf.Lerp(iter_362_1.color.g, arg_359_1.hightColor2.g, var_362_3)
								local var_362_6 = Mathf.Lerp(iter_362_1.color.b, arg_359_1.hightColor2.b, var_362_3)

								iter_362_1.color = Color.New(var_362_4, var_362_5, var_362_6)
							else
								local var_362_7 = Mathf.Lerp(iter_362_1.color.r, 0.5, var_362_3)

								iter_362_1.color = Color.New(var_362_7, var_362_7, var_362_7)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.actorSpriteComps10155 then
				for iter_362_2, iter_362_3 in pairs(arg_359_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_362_3 then
						if arg_359_1.isInRecall_ then
							iter_362_3.color = arg_359_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_362_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_359_1.var_.actorSpriteComps10155 = nil
			end

			local var_362_8 = 0
			local var_362_9 = 0.075

			if var_362_8 < arg_359_1.time_ and arg_359_1.time_ <= var_362_8 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_10 = arg_359_1:FormatText(StoryNameCfg[177].name)

				arg_359_1.leftNameTxt_.text = var_362_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_11 = arg_359_1:GetWordFromCfg(424051089)
				local var_362_12 = arg_359_1:FormatText(var_362_11.content)

				arg_359_1.text_.text = var_362_12

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_13 = 3
				local var_362_14 = utf8.len(var_362_12)
				local var_362_15 = var_362_13 <= 0 and var_362_9 or var_362_9 * (var_362_14 / var_362_13)

				if var_362_15 > 0 and var_362_9 < var_362_15 then
					arg_359_1.talkMaxDuration = var_362_15

					if var_362_15 + var_362_8 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_15 + var_362_8
					end
				end

				arg_359_1.text_.text = var_362_12
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051089", "story_v_out_424051.awb") ~= 0 then
					local var_362_16 = manager.audio:GetVoiceLength("story_v_out_424051", "424051089", "story_v_out_424051.awb") / 1000

					if var_362_16 + var_362_8 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_16 + var_362_8
					end

					if var_362_11.prefab_name ~= "" and arg_359_1.actors_[var_362_11.prefab_name] ~= nil then
						local var_362_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_11.prefab_name].transform, "story_v_out_424051", "424051089", "story_v_out_424051.awb")

						arg_359_1:RecordAudio("424051089", var_362_17)
						arg_359_1:RecordAudio("424051089", var_362_17)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_424051", "424051089", "story_v_out_424051.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_424051", "424051089", "story_v_out_424051.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_18 = math.max(var_362_9, arg_359_1.talkMaxDuration)

			if var_362_8 <= arg_359_1.time_ and arg_359_1.time_ < var_362_8 + var_362_18 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_8) / var_362_18

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_8 + var_362_18 and arg_359_1.time_ < var_362_8 + var_362_18 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play424051090 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 424051090
		arg_363_1.duration_ = 4.3

		local var_363_0 = {
			zh = 3.133,
			ja = 4.3
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play424051091(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["10155"]
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.actorSpriteComps10155 == nil then
				arg_363_1.var_.actorSpriteComps10155 = var_366_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_2 = 0.2

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 and not isNil(var_366_0) then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2

				if arg_363_1.var_.actorSpriteComps10155 then
					for iter_366_0, iter_366_1 in pairs(arg_363_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_366_1 then
							if arg_363_1.isInRecall_ then
								local var_366_4 = Mathf.Lerp(iter_366_1.color.r, arg_363_1.hightColor1.r, var_366_3)
								local var_366_5 = Mathf.Lerp(iter_366_1.color.g, arg_363_1.hightColor1.g, var_366_3)
								local var_366_6 = Mathf.Lerp(iter_366_1.color.b, arg_363_1.hightColor1.b, var_366_3)

								iter_366_1.color = Color.New(var_366_4, var_366_5, var_366_6)
							else
								local var_366_7 = Mathf.Lerp(iter_366_1.color.r, 1, var_366_3)

								iter_366_1.color = Color.New(var_366_7, var_366_7, var_366_7)
							end
						end
					end
				end
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.actorSpriteComps10155 then
				for iter_366_2, iter_366_3 in pairs(arg_363_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_366_3 then
						if arg_363_1.isInRecall_ then
							iter_366_3.color = arg_363_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_366_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_363_1.var_.actorSpriteComps10155 = nil
			end

			local var_366_8 = arg_363_1.actors_["10155"].transform
			local var_366_9 = 0

			if var_366_9 < arg_363_1.time_ and arg_363_1.time_ <= var_366_9 + arg_366_0 then
				arg_363_1.var_.moveOldPos10155 = var_366_8.localPosition
				var_366_8.localScale = Vector3.New(1, 1, 1)

				arg_363_1:CheckSpriteTmpPos("10155", 2)

				local var_366_10 = var_366_8.childCount

				for iter_366_4 = 0, var_366_10 - 1 do
					local var_366_11 = var_366_8:GetChild(iter_366_4)

					if var_366_11.name == "split_1" then
						var_366_11:SetAsLastSibling()
						var_366_11.gameObject:SetActive(true)

						arg_363_1.var_.actorSpriteSplit10155 = var_366_11.gameObject:GetComponent(typeof(Image))

						arg_363_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_366_12 = 0.5

			if var_366_9 <= arg_363_1.time_ and arg_363_1.time_ < var_366_9 + var_366_12 then
				local var_366_13 = (arg_363_1.time_ - var_366_9) / var_366_12
				local var_366_14 = Vector3.New(-410, -390, -250)

				var_366_8.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos10155, var_366_14, var_366_13)

				if arg_363_1.var_.actorSpriteSplit10155 ~= nil then
					arg_363_1.var_.actorSpriteSplit10155:SetAlpha(var_366_13)
				end
			end

			if arg_363_1.time_ >= var_366_9 + var_366_12 and arg_363_1.time_ < var_366_9 + var_366_12 + arg_366_0 then
				var_366_8.localPosition = Vector3.New(-410, -390, -250)

				if arg_363_1.var_.actorSpriteSplit10155 ~= nil then
					arg_363_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_366_15 = 0
			local var_366_16 = 0.4

			if var_366_15 < arg_363_1.time_ and arg_363_1.time_ <= var_366_15 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_17 = arg_363_1:FormatText(StoryNameCfg[1391].name)

				arg_363_1.leftNameTxt_.text = var_366_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_18 = arg_363_1:GetWordFromCfg(424051090)
				local var_366_19 = arg_363_1:FormatText(var_366_18.content)

				arg_363_1.text_.text = var_366_19

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_20 = 16
				local var_366_21 = utf8.len(var_366_19)
				local var_366_22 = var_366_20 <= 0 and var_366_16 or var_366_16 * (var_366_21 / var_366_20)

				if var_366_22 > 0 and var_366_16 < var_366_22 then
					arg_363_1.talkMaxDuration = var_366_22

					if var_366_22 + var_366_15 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_22 + var_366_15
					end
				end

				arg_363_1.text_.text = var_366_19
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051090", "story_v_out_424051.awb") ~= 0 then
					local var_366_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051090", "story_v_out_424051.awb") / 1000

					if var_366_23 + var_366_15 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_23 + var_366_15
					end

					if var_366_18.prefab_name ~= "" and arg_363_1.actors_[var_366_18.prefab_name] ~= nil then
						local var_366_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_18.prefab_name].transform, "story_v_out_424051", "424051090", "story_v_out_424051.awb")

						arg_363_1:RecordAudio("424051090", var_366_24)
						arg_363_1:RecordAudio("424051090", var_366_24)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_424051", "424051090", "story_v_out_424051.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_424051", "424051090", "story_v_out_424051.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_25 = math.max(var_366_16, arg_363_1.talkMaxDuration)

			if var_366_15 <= arg_363_1.time_ and arg_363_1.time_ < var_366_15 + var_366_25 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_15) / var_366_25

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_15 + var_366_25 and arg_363_1.time_ < var_366_15 + var_366_25 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play424051091 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 424051091
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play424051092(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["10155"]
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.actorSpriteComps10155 == nil then
				arg_367_1.var_.actorSpriteComps10155 = var_370_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_2 = 0.2

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 and not isNil(var_370_0) then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2

				if arg_367_1.var_.actorSpriteComps10155 then
					for iter_370_0, iter_370_1 in pairs(arg_367_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_370_1 then
							if arg_367_1.isInRecall_ then
								local var_370_4 = Mathf.Lerp(iter_370_1.color.r, arg_367_1.hightColor2.r, var_370_3)
								local var_370_5 = Mathf.Lerp(iter_370_1.color.g, arg_367_1.hightColor2.g, var_370_3)
								local var_370_6 = Mathf.Lerp(iter_370_1.color.b, arg_367_1.hightColor2.b, var_370_3)

								iter_370_1.color = Color.New(var_370_4, var_370_5, var_370_6)
							else
								local var_370_7 = Mathf.Lerp(iter_370_1.color.r, 0.5, var_370_3)

								iter_370_1.color = Color.New(var_370_7, var_370_7, var_370_7)
							end
						end
					end
				end
			end

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.actorSpriteComps10155 then
				for iter_370_2, iter_370_3 in pairs(arg_367_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_370_3 then
						if arg_367_1.isInRecall_ then
							iter_370_3.color = arg_367_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_370_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_367_1.var_.actorSpriteComps10155 = nil
			end

			local var_370_8 = 0
			local var_370_9 = 0.325

			if var_370_8 < arg_367_1.time_ and arg_367_1.time_ <= var_370_8 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_10 = arg_367_1:FormatText(StoryNameCfg[7].name)

				arg_367_1.leftNameTxt_.text = var_370_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_11 = arg_367_1:GetWordFromCfg(424051091)
				local var_370_12 = arg_367_1:FormatText(var_370_11.content)

				arg_367_1.text_.text = var_370_12

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_13 = 13
				local var_370_14 = utf8.len(var_370_12)
				local var_370_15 = var_370_13 <= 0 and var_370_9 or var_370_9 * (var_370_14 / var_370_13)

				if var_370_15 > 0 and var_370_9 < var_370_15 then
					arg_367_1.talkMaxDuration = var_370_15

					if var_370_15 + var_370_8 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_15 + var_370_8
					end
				end

				arg_367_1.text_.text = var_370_12
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_16 = math.max(var_370_9, arg_367_1.talkMaxDuration)

			if var_370_8 <= arg_367_1.time_ and arg_367_1.time_ < var_370_8 + var_370_16 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_8) / var_370_16

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_8 + var_370_16 and arg_367_1.time_ < var_370_8 + var_370_16 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play424051092 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 424051092
		arg_371_1.duration_ = 12.7

		local var_371_0 = {
			zh = 7.133,
			ja = 12.7
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play424051093(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["10155"]
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.actorSpriteComps10155 == nil then
				arg_371_1.var_.actorSpriteComps10155 = var_374_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_2 = 0.2

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 and not isNil(var_374_0) then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2

				if arg_371_1.var_.actorSpriteComps10155 then
					for iter_374_0, iter_374_1 in pairs(arg_371_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_374_1 then
							if arg_371_1.isInRecall_ then
								local var_374_4 = Mathf.Lerp(iter_374_1.color.r, arg_371_1.hightColor1.r, var_374_3)
								local var_374_5 = Mathf.Lerp(iter_374_1.color.g, arg_371_1.hightColor1.g, var_374_3)
								local var_374_6 = Mathf.Lerp(iter_374_1.color.b, arg_371_1.hightColor1.b, var_374_3)

								iter_374_1.color = Color.New(var_374_4, var_374_5, var_374_6)
							else
								local var_374_7 = Mathf.Lerp(iter_374_1.color.r, 1, var_374_3)

								iter_374_1.color = Color.New(var_374_7, var_374_7, var_374_7)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.actorSpriteComps10155 then
				for iter_374_2, iter_374_3 in pairs(arg_371_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_374_3 then
						if arg_371_1.isInRecall_ then
							iter_374_3.color = arg_371_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_374_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_371_1.var_.actorSpriteComps10155 = nil
			end

			local var_374_8 = arg_371_1.actors_["10155"].transform
			local var_374_9 = 0

			if var_374_9 < arg_371_1.time_ and arg_371_1.time_ <= var_374_9 + arg_374_0 then
				arg_371_1.var_.moveOldPos10155 = var_374_8.localPosition
				var_374_8.localScale = Vector3.New(1, 1, 1)

				arg_371_1:CheckSpriteTmpPos("10155", 2)

				local var_374_10 = var_374_8.childCount

				for iter_374_4 = 0, var_374_10 - 1 do
					local var_374_11 = var_374_8:GetChild(iter_374_4)

					if var_374_11.name == "split_4" then
						var_374_11:SetAsLastSibling()
						var_374_11.gameObject:SetActive(true)

						arg_371_1.var_.actorSpriteSplit10155 = var_374_11.gameObject:GetComponent(typeof(Image))

						arg_371_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_374_12 = 0.5

			if var_374_9 <= arg_371_1.time_ and arg_371_1.time_ < var_374_9 + var_374_12 then
				local var_374_13 = (arg_371_1.time_ - var_374_9) / var_374_12
				local var_374_14 = Vector3.New(-410, -390, -250)

				var_374_8.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos10155, var_374_14, var_374_13)

				if arg_371_1.var_.actorSpriteSplit10155 ~= nil then
					arg_371_1.var_.actorSpriteSplit10155:SetAlpha(var_374_13)
				end
			end

			if arg_371_1.time_ >= var_374_9 + var_374_12 and arg_371_1.time_ < var_374_9 + var_374_12 + arg_374_0 then
				var_374_8.localPosition = Vector3.New(-410, -390, -250)

				if arg_371_1.var_.actorSpriteSplit10155 ~= nil then
					arg_371_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_374_15 = 0
			local var_374_16 = 0.675

			if var_374_15 < arg_371_1.time_ and arg_371_1.time_ <= var_374_15 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_17 = arg_371_1:FormatText(StoryNameCfg[1391].name)

				arg_371_1.leftNameTxt_.text = var_374_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_18 = arg_371_1:GetWordFromCfg(424051092)
				local var_374_19 = arg_371_1:FormatText(var_374_18.content)

				arg_371_1.text_.text = var_374_19

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_20 = 27
				local var_374_21 = utf8.len(var_374_19)
				local var_374_22 = var_374_20 <= 0 and var_374_16 or var_374_16 * (var_374_21 / var_374_20)

				if var_374_22 > 0 and var_374_16 < var_374_22 then
					arg_371_1.talkMaxDuration = var_374_22

					if var_374_22 + var_374_15 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_22 + var_374_15
					end
				end

				arg_371_1.text_.text = var_374_19
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051092", "story_v_out_424051.awb") ~= 0 then
					local var_374_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051092", "story_v_out_424051.awb") / 1000

					if var_374_23 + var_374_15 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_23 + var_374_15
					end

					if var_374_18.prefab_name ~= "" and arg_371_1.actors_[var_374_18.prefab_name] ~= nil then
						local var_374_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_18.prefab_name].transform, "story_v_out_424051", "424051092", "story_v_out_424051.awb")

						arg_371_1:RecordAudio("424051092", var_374_24)
						arg_371_1:RecordAudio("424051092", var_374_24)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_424051", "424051092", "story_v_out_424051.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_424051", "424051092", "story_v_out_424051.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_25 = math.max(var_374_16, arg_371_1.talkMaxDuration)

			if var_374_15 <= arg_371_1.time_ and arg_371_1.time_ < var_374_15 + var_374_25 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_15) / var_374_25

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_15 + var_374_25 and arg_371_1.time_ < var_374_15 + var_374_25 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play424051093 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 424051093
		arg_375_1.duration_ = 15

		local var_375_0 = {
			zh = 7.533,
			ja = 15
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play424051094(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["10155"].transform
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.var_.moveOldPos10155 = var_378_0.localPosition
				var_378_0.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("10155", 2)

				local var_378_2 = var_378_0.childCount

				for iter_378_0 = 0, var_378_2 - 1 do
					local var_378_3 = var_378_0:GetChild(iter_378_0)

					if var_378_3.name == "split_1" then
						var_378_3:SetAsLastSibling()
						var_378_3.gameObject:SetActive(true)

						arg_375_1.var_.actorSpriteSplit10155 = var_378_3.gameObject:GetComponent(typeof(Image))

						arg_375_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_378_4 = 0.5

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_4 then
				local var_378_5 = (arg_375_1.time_ - var_378_1) / var_378_4
				local var_378_6 = Vector3.New(-410, -390, -250)

				var_378_0.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos10155, var_378_6, var_378_5)

				if arg_375_1.var_.actorSpriteSplit10155 ~= nil then
					arg_375_1.var_.actorSpriteSplit10155:SetAlpha(var_378_5)
				end
			end

			if arg_375_1.time_ >= var_378_1 + var_378_4 and arg_375_1.time_ < var_378_1 + var_378_4 + arg_378_0 then
				var_378_0.localPosition = Vector3.New(-410, -390, -250)

				if arg_375_1.var_.actorSpriteSplit10155 ~= nil then
					arg_375_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_378_7 = 0
			local var_378_8 = 0.925

			if var_378_7 < arg_375_1.time_ and arg_375_1.time_ <= var_378_7 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_9 = arg_375_1:FormatText(StoryNameCfg[1391].name)

				arg_375_1.leftNameTxt_.text = var_378_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_10 = arg_375_1:GetWordFromCfg(424051093)
				local var_378_11 = arg_375_1:FormatText(var_378_10.content)

				arg_375_1.text_.text = var_378_11

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_12 = 37
				local var_378_13 = utf8.len(var_378_11)
				local var_378_14 = var_378_12 <= 0 and var_378_8 or var_378_8 * (var_378_13 / var_378_12)

				if var_378_14 > 0 and var_378_8 < var_378_14 then
					arg_375_1.talkMaxDuration = var_378_14

					if var_378_14 + var_378_7 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_14 + var_378_7
					end
				end

				arg_375_1.text_.text = var_378_11
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051093", "story_v_out_424051.awb") ~= 0 then
					local var_378_15 = manager.audio:GetVoiceLength("story_v_out_424051", "424051093", "story_v_out_424051.awb") / 1000

					if var_378_15 + var_378_7 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_15 + var_378_7
					end

					if var_378_10.prefab_name ~= "" and arg_375_1.actors_[var_378_10.prefab_name] ~= nil then
						local var_378_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_10.prefab_name].transform, "story_v_out_424051", "424051093", "story_v_out_424051.awb")

						arg_375_1:RecordAudio("424051093", var_378_16)
						arg_375_1:RecordAudio("424051093", var_378_16)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_424051", "424051093", "story_v_out_424051.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_424051", "424051093", "story_v_out_424051.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_17 = math.max(var_378_8, arg_375_1.talkMaxDuration)

			if var_378_7 <= arg_375_1.time_ and arg_375_1.time_ < var_378_7 + var_378_17 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_7) / var_378_17

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_7 + var_378_17 and arg_375_1.time_ < var_378_7 + var_378_17 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play424051094 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 424051094
		arg_379_1.duration_ = 4.27

		local var_379_0 = {
			zh = 3.9,
			ja = 4.266
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play424051095(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["10155"]
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.actorSpriteComps10155 == nil then
				arg_379_1.var_.actorSpriteComps10155 = var_382_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_382_2 = 0.2

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 and not isNil(var_382_0) then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2

				if arg_379_1.var_.actorSpriteComps10155 then
					for iter_382_0, iter_382_1 in pairs(arg_379_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_382_1 then
							if arg_379_1.isInRecall_ then
								local var_382_4 = Mathf.Lerp(iter_382_1.color.r, arg_379_1.hightColor2.r, var_382_3)
								local var_382_5 = Mathf.Lerp(iter_382_1.color.g, arg_379_1.hightColor2.g, var_382_3)
								local var_382_6 = Mathf.Lerp(iter_382_1.color.b, arg_379_1.hightColor2.b, var_382_3)

								iter_382_1.color = Color.New(var_382_4, var_382_5, var_382_6)
							else
								local var_382_7 = Mathf.Lerp(iter_382_1.color.r, 0.5, var_382_3)

								iter_382_1.color = Color.New(var_382_7, var_382_7, var_382_7)
							end
						end
					end
				end
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.actorSpriteComps10155 then
				for iter_382_2, iter_382_3 in pairs(arg_379_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_382_3 then
						if arg_379_1.isInRecall_ then
							iter_382_3.color = arg_379_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_382_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_379_1.var_.actorSpriteComps10155 = nil
			end

			local var_382_8 = 0
			local var_382_9 = 0.425

			if var_382_8 < arg_379_1.time_ and arg_379_1.time_ <= var_382_8 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_10 = arg_379_1:FormatText(StoryNameCfg[177].name)

				arg_379_1.leftNameTxt_.text = var_382_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_11 = arg_379_1:GetWordFromCfg(424051094)
				local var_382_12 = arg_379_1:FormatText(var_382_11.content)

				arg_379_1.text_.text = var_382_12

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_13 = 17
				local var_382_14 = utf8.len(var_382_12)
				local var_382_15 = var_382_13 <= 0 and var_382_9 or var_382_9 * (var_382_14 / var_382_13)

				if var_382_15 > 0 and var_382_9 < var_382_15 then
					arg_379_1.talkMaxDuration = var_382_15

					if var_382_15 + var_382_8 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_15 + var_382_8
					end
				end

				arg_379_1.text_.text = var_382_12
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051094", "story_v_out_424051.awb") ~= 0 then
					local var_382_16 = manager.audio:GetVoiceLength("story_v_out_424051", "424051094", "story_v_out_424051.awb") / 1000

					if var_382_16 + var_382_8 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_16 + var_382_8
					end

					if var_382_11.prefab_name ~= "" and arg_379_1.actors_[var_382_11.prefab_name] ~= nil then
						local var_382_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_11.prefab_name].transform, "story_v_out_424051", "424051094", "story_v_out_424051.awb")

						arg_379_1:RecordAudio("424051094", var_382_17)
						arg_379_1:RecordAudio("424051094", var_382_17)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_424051", "424051094", "story_v_out_424051.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_424051", "424051094", "story_v_out_424051.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_18 = math.max(var_382_9, arg_379_1.talkMaxDuration)

			if var_382_8 <= arg_379_1.time_ and arg_379_1.time_ < var_382_8 + var_382_18 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_8) / var_382_18

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_8 + var_382_18 and arg_379_1.time_ < var_382_8 + var_382_18 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play424051095 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 424051095
		arg_383_1.duration_ = 27.53

		local var_383_0 = {
			zh = 14.5,
			ja = 27.533
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play424051096(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = "I18a"

			if arg_383_1.bgs_[var_386_0] == nil then
				local var_386_1 = Object.Instantiate(arg_383_1.paintGo_)

				var_386_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_386_0)
				var_386_1.name = var_386_0
				var_386_1.transform.parent = arg_383_1.stage_.transform
				var_386_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_383_1.bgs_[var_386_0] = var_386_1
			end

			local var_386_2 = 2

			if var_386_2 < arg_383_1.time_ and arg_383_1.time_ <= var_386_2 + arg_386_0 then
				local var_386_3 = manager.ui.mainCamera.transform.localPosition
				local var_386_4 = Vector3.New(0, 0, 10) + Vector3.New(var_386_3.x, var_386_3.y, 0)
				local var_386_5 = arg_383_1.bgs_.I18a

				var_386_5.transform.localPosition = var_386_4
				var_386_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_386_6 = var_386_5:GetComponent("SpriteRenderer")

				if var_386_6 and var_386_6.sprite then
					local var_386_7 = (var_386_5.transform.localPosition - var_386_3).z
					local var_386_8 = manager.ui.mainCameraCom_
					local var_386_9 = 2 * var_386_7 * Mathf.Tan(var_386_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_386_10 = var_386_9 * var_386_8.aspect
					local var_386_11 = var_386_6.sprite.bounds.size.x
					local var_386_12 = var_386_6.sprite.bounds.size.y
					local var_386_13 = var_386_10 / var_386_11
					local var_386_14 = var_386_9 / var_386_12
					local var_386_15 = var_386_14 < var_386_13 and var_386_13 or var_386_14

					var_386_5.transform.localScale = Vector3.New(var_386_15, var_386_15, 0)
				end

				for iter_386_0, iter_386_1 in pairs(arg_383_1.bgs_) do
					if iter_386_0 ~= "I18a" then
						iter_386_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_386_16 = 4

			if var_386_16 < arg_383_1.time_ and arg_383_1.time_ <= var_386_16 + arg_386_0 then
				arg_383_1.allBtn_.enabled = false
			end

			local var_386_17 = 0.3

			if arg_383_1.time_ >= var_386_16 + var_386_17 and arg_383_1.time_ < var_386_16 + var_386_17 + arg_386_0 then
				arg_383_1.allBtn_.enabled = true
			end

			local var_386_18 = 0

			if var_386_18 < arg_383_1.time_ and arg_383_1.time_ <= var_386_18 + arg_386_0 then
				arg_383_1.mask_.enabled = true
				arg_383_1.mask_.raycastTarget = true

				arg_383_1:SetGaussion(false)
			end

			local var_386_19 = 2

			if var_386_18 <= arg_383_1.time_ and arg_383_1.time_ < var_386_18 + var_386_19 then
				local var_386_20 = (arg_383_1.time_ - var_386_18) / var_386_19
				local var_386_21 = Color.New(0, 0, 0)

				var_386_21.a = Mathf.Lerp(0, 1, var_386_20)
				arg_383_1.mask_.color = var_386_21
			end

			if arg_383_1.time_ >= var_386_18 + var_386_19 and arg_383_1.time_ < var_386_18 + var_386_19 + arg_386_0 then
				local var_386_22 = Color.New(0, 0, 0)

				var_386_22.a = 1
				arg_383_1.mask_.color = var_386_22
			end

			local var_386_23 = 2

			if var_386_23 < arg_383_1.time_ and arg_383_1.time_ <= var_386_23 + arg_386_0 then
				arg_383_1.mask_.enabled = true
				arg_383_1.mask_.raycastTarget = true

				arg_383_1:SetGaussion(false)
			end

			local var_386_24 = 2

			if var_386_23 <= arg_383_1.time_ and arg_383_1.time_ < var_386_23 + var_386_24 then
				local var_386_25 = (arg_383_1.time_ - var_386_23) / var_386_24
				local var_386_26 = Color.New(0, 0, 0)

				var_386_26.a = Mathf.Lerp(1, 0, var_386_25)
				arg_383_1.mask_.color = var_386_26
			end

			if arg_383_1.time_ >= var_386_23 + var_386_24 and arg_383_1.time_ < var_386_23 + var_386_24 + arg_386_0 then
				local var_386_27 = Color.New(0, 0, 0)
				local var_386_28 = 0

				arg_383_1.mask_.enabled = false
				var_386_27.a = var_386_28
				arg_383_1.mask_.color = var_386_27
			end

			local var_386_29 = arg_383_1.actors_["10155"].transform
			local var_386_30 = 1.966

			if var_386_30 < arg_383_1.time_ and arg_383_1.time_ <= var_386_30 + arg_386_0 then
				arg_383_1.var_.moveOldPos10155 = var_386_29.localPosition
				var_386_29.localScale = Vector3.New(1, 1, 1)

				arg_383_1:CheckSpriteTmpPos("10155", 7)

				local var_386_31 = var_386_29.childCount

				for iter_386_2 = 0, var_386_31 - 1 do
					local var_386_32 = var_386_29:GetChild(iter_386_2)

					if var_386_32.name == "" or not string.find(var_386_32.name, "split") then
						var_386_32.gameObject:SetActive(true)
					else
						var_386_32.gameObject:SetActive(false)
					end
				end
			end

			local var_386_33 = 0.001

			if var_386_30 <= arg_383_1.time_ and arg_383_1.time_ < var_386_30 + var_386_33 then
				local var_386_34 = (arg_383_1.time_ - var_386_30) / var_386_33
				local var_386_35 = Vector3.New(0, -2000, 0)

				var_386_29.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos10155, var_386_35, var_386_34)
			end

			if arg_383_1.time_ >= var_386_30 + var_386_33 and arg_383_1.time_ < var_386_30 + var_386_33 + arg_386_0 then
				var_386_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_386_36 = arg_383_1.actors_["1094"].transform
			local var_386_37 = 1.966

			if var_386_37 < arg_383_1.time_ and arg_383_1.time_ <= var_386_37 + arg_386_0 then
				arg_383_1.var_.moveOldPos1094 = var_386_36.localPosition
				var_386_36.localScale = Vector3.New(1, 1, 1)

				arg_383_1:CheckSpriteTmpPos("1094", 7)

				local var_386_38 = var_386_36.childCount

				for iter_386_3 = 0, var_386_38 - 1 do
					local var_386_39 = var_386_36:GetChild(iter_386_3)

					if var_386_39.name == "" or not string.find(var_386_39.name, "split") then
						var_386_39.gameObject:SetActive(true)
					else
						var_386_39.gameObject:SetActive(false)
					end
				end
			end

			local var_386_40 = 0.001

			if var_386_37 <= arg_383_1.time_ and arg_383_1.time_ < var_386_37 + var_386_40 then
				local var_386_41 = (arg_383_1.time_ - var_386_37) / var_386_40
				local var_386_42 = Vector3.New(0, -2000, 0)

				var_386_36.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1094, var_386_42, var_386_41)
			end

			if arg_383_1.time_ >= var_386_37 + var_386_40 and arg_383_1.time_ < var_386_37 + var_386_40 + arg_386_0 then
				var_386_36.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_386_43 = 2

			arg_383_1.isInRecall_ = false

			if var_386_43 < arg_383_1.time_ and arg_383_1.time_ <= var_386_43 + arg_386_0 then
				arg_383_1.screenFilterGo_:SetActive(true)

				arg_383_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_386_4, iter_386_5 in pairs(arg_383_1.actors_) do
					local var_386_44 = iter_386_5:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_386_6, iter_386_7 in ipairs(var_386_44) do
						if iter_386_7.color.r > 0.51 then
							iter_386_7.color = Color.New(1, 1, 1)
						else
							iter_386_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_386_45 = 0.2

			if var_386_43 <= arg_383_1.time_ and arg_383_1.time_ < var_386_43 + var_386_45 then
				local var_386_46 = (arg_383_1.time_ - var_386_43) / var_386_45

				arg_383_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_386_46)
			end

			if arg_383_1.time_ >= var_386_43 + var_386_45 and arg_383_1.time_ < var_386_43 + var_386_45 + arg_386_0 then
				arg_383_1.screenFilterEffect_.weight = 1
			end

			local var_386_47 = 0.233333333333333
			local var_386_48 = 1

			if var_386_47 < arg_383_1.time_ and arg_383_1.time_ <= var_386_47 + arg_386_0 then
				local var_386_49 = "stop"
				local var_386_50 = "effect"

				arg_383_1:AudioAction(var_386_49, var_386_50, "se_story_140", "se_story_140_amb_room01", "")
			end

			local var_386_51 = 1.76666666666667
			local var_386_52 = 1

			if var_386_51 < arg_383_1.time_ and arg_383_1.time_ <= var_386_51 + arg_386_0 then
				local var_386_53 = "play"
				local var_386_54 = "effect"

				arg_383_1:AudioAction(var_386_53, var_386_54, "se_story_140", "se_story_140_amb_valley", "")
			end

			if arg_383_1.frameCnt_ <= 1 then
				arg_383_1.dialog_:SetActive(false)
			end

			local var_386_55 = 4
			local var_386_56 = 1.025

			if var_386_55 < arg_383_1.time_ and arg_383_1.time_ <= var_386_55 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0

				arg_383_1.dialog_:SetActive(true)

				arg_383_1.dialogCg_.alpha = 0

				local var_386_57 = LeanTween.value(arg_383_1.dialog_, 0, 1, 0.3)

				var_386_57:setOnUpdate(LuaHelper.FloatAction(function(arg_387_0)
					arg_383_1.dialogCg_.alpha = arg_387_0
				end))
				var_386_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_383_1.dialog_)
					var_386_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_383_1.duration_ = arg_383_1.duration_ + 0.3

				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_58 = arg_383_1:FormatText(StoryNameCfg[462].name)

				arg_383_1.leftNameTxt_.text = var_386_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10050")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_383_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_386_59 = arg_383_1:GetWordFromCfg(424051095)
				local var_386_60 = arg_383_1:FormatText(var_386_59.content)

				arg_383_1.text_.text = var_386_60

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_61 = 41
				local var_386_62 = utf8.len(var_386_60)
				local var_386_63 = var_386_61 <= 0 and var_386_56 or var_386_56 * (var_386_62 / var_386_61)

				if var_386_63 > 0 and var_386_56 < var_386_63 then
					arg_383_1.talkMaxDuration = var_386_63
					var_386_55 = var_386_55 + 0.3

					if var_386_63 + var_386_55 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_63 + var_386_55
					end
				end

				arg_383_1.text_.text = var_386_60
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051095", "story_v_out_424051.awb") ~= 0 then
					local var_386_64 = manager.audio:GetVoiceLength("story_v_out_424051", "424051095", "story_v_out_424051.awb") / 1000

					if var_386_64 + var_386_55 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_64 + var_386_55
					end

					if var_386_59.prefab_name ~= "" and arg_383_1.actors_[var_386_59.prefab_name] ~= nil then
						local var_386_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_59.prefab_name].transform, "story_v_out_424051", "424051095", "story_v_out_424051.awb")

						arg_383_1:RecordAudio("424051095", var_386_65)
						arg_383_1:RecordAudio("424051095", var_386_65)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_424051", "424051095", "story_v_out_424051.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_424051", "424051095", "story_v_out_424051.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_66 = var_386_55 + 0.3
			local var_386_67 = math.max(var_386_56, arg_383_1.talkMaxDuration)

			if var_386_66 <= arg_383_1.time_ and arg_383_1.time_ < var_386_66 + var_386_67 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_66) / var_386_67

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_66 + var_386_67 and arg_383_1.time_ < var_386_66 + var_386_67 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play424051096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 424051096
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play424051097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0
			local var_392_1 = 0.425

			if var_392_0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_2 = arg_389_1:FormatText(StoryNameCfg[7].name)

				arg_389_1.leftNameTxt_.text = var_392_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, true)
				arg_389_1.iconController_:SetSelectedState("hero")

				arg_389_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_389_1.callingController_:SetSelectedState("normal")

				arg_389_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_389_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_392_3 = arg_389_1:GetWordFromCfg(424051096)
				local var_392_4 = arg_389_1:FormatText(var_392_3.content)

				arg_389_1.text_.text = var_392_4

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_5 = 17
				local var_392_6 = utf8.len(var_392_4)
				local var_392_7 = var_392_5 <= 0 and var_392_1 or var_392_1 * (var_392_6 / var_392_5)

				if var_392_7 > 0 and var_392_1 < var_392_7 then
					arg_389_1.talkMaxDuration = var_392_7

					if var_392_7 + var_392_0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_7 + var_392_0
					end
				end

				arg_389_1.text_.text = var_392_4
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_8 = math.max(var_392_1, arg_389_1.talkMaxDuration)

			if var_392_0 <= arg_389_1.time_ and arg_389_1.time_ < var_392_0 + var_392_8 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_0) / var_392_8

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_0 + var_392_8 and arg_389_1.time_ < var_392_0 + var_392_8 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play424051097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 424051097
		arg_393_1.duration_ = 8.37

		local var_393_0 = {
			zh = 5.3,
			ja = 8.366
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
				arg_393_0:Play424051098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0
			local var_396_1 = 0.525

			if var_396_0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_2 = arg_393_1:FormatText(StoryNameCfg[462].name)

				arg_393_1.leftNameTxt_.text = var_396_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, true)
				arg_393_1.iconController_:SetSelectedState("hero")

				arg_393_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10050")

				arg_393_1.callingController_:SetSelectedState("normal")

				arg_393_1.keyicon_.color = Color.New(1, 1, 1)
				arg_393_1.icon_.color = Color.New(1, 1, 1)

				local var_396_3 = arg_393_1:GetWordFromCfg(424051097)
				local var_396_4 = arg_393_1:FormatText(var_396_3.content)

				arg_393_1.text_.text = var_396_4

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051097", "story_v_out_424051.awb") ~= 0 then
					local var_396_8 = manager.audio:GetVoiceLength("story_v_out_424051", "424051097", "story_v_out_424051.awb") / 1000

					if var_396_8 + var_396_0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_8 + var_396_0
					end

					if var_396_3.prefab_name ~= "" and arg_393_1.actors_[var_396_3.prefab_name] ~= nil then
						local var_396_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_3.prefab_name].transform, "story_v_out_424051", "424051097", "story_v_out_424051.awb")

						arg_393_1:RecordAudio("424051097", var_396_9)
						arg_393_1:RecordAudio("424051097", var_396_9)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_424051", "424051097", "story_v_out_424051.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_424051", "424051097", "story_v_out_424051.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_10 = math.max(var_396_1, arg_393_1.talkMaxDuration)

			if var_396_0 <= arg_393_1.time_ and arg_393_1.time_ < var_396_0 + var_396_10 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_0) / var_396_10

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_0 + var_396_10 and arg_393_1.time_ < var_396_0 + var_396_10 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play424051098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 424051098
		arg_397_1.duration_ = 31.3

		local var_397_0 = {
			zh = 15.2,
			ja = 31.3
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
				arg_397_0:Play424051099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0
			local var_400_1 = 1.325

			if var_400_0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_2 = arg_397_1:FormatText(StoryNameCfg[462].name)

				arg_397_1.leftNameTxt_.text = var_400_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10050")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_3 = arg_397_1:GetWordFromCfg(424051098)
				local var_400_4 = arg_397_1:FormatText(var_400_3.content)

				arg_397_1.text_.text = var_400_4

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_5 = 53
				local var_400_6 = utf8.len(var_400_4)
				local var_400_7 = var_400_5 <= 0 and var_400_1 or var_400_1 * (var_400_6 / var_400_5)

				if var_400_7 > 0 and var_400_1 < var_400_7 then
					arg_397_1.talkMaxDuration = var_400_7

					if var_400_7 + var_400_0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_7 + var_400_0
					end
				end

				arg_397_1.text_.text = var_400_4
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051098", "story_v_out_424051.awb") ~= 0 then
					local var_400_8 = manager.audio:GetVoiceLength("story_v_out_424051", "424051098", "story_v_out_424051.awb") / 1000

					if var_400_8 + var_400_0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_8 + var_400_0
					end

					if var_400_3.prefab_name ~= "" and arg_397_1.actors_[var_400_3.prefab_name] ~= nil then
						local var_400_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_3.prefab_name].transform, "story_v_out_424051", "424051098", "story_v_out_424051.awb")

						arg_397_1:RecordAudio("424051098", var_400_9)
						arg_397_1:RecordAudio("424051098", var_400_9)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_424051", "424051098", "story_v_out_424051.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_424051", "424051098", "story_v_out_424051.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_10 = math.max(var_400_1, arg_397_1.talkMaxDuration)

			if var_400_0 <= arg_397_1.time_ and arg_397_1.time_ < var_400_0 + var_400_10 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_0) / var_400_10

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_0 + var_400_10 and arg_397_1.time_ < var_400_0 + var_400_10 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play424051099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 424051099
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play424051100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0
			local var_404_1 = 0.875

			if var_404_0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_2 = arg_401_1:GetWordFromCfg(424051099)
				local var_404_3 = arg_401_1:FormatText(var_404_2.content)

				arg_401_1.text_.text = var_404_3

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 35
				local var_404_5 = utf8.len(var_404_3)
				local var_404_6 = var_404_4 <= 0 and var_404_1 or var_404_1 * (var_404_5 / var_404_4)

				if var_404_6 > 0 and var_404_1 < var_404_6 then
					arg_401_1.talkMaxDuration = var_404_6

					if var_404_6 + var_404_0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_6 + var_404_0
					end
				end

				arg_401_1.text_.text = var_404_3
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_1, arg_401_1.talkMaxDuration)

			if var_404_0 <= arg_401_1.time_ and arg_401_1.time_ < var_404_0 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_0) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_0 + var_404_7 and arg_401_1.time_ < var_404_0 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play424051100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 424051100
		arg_405_1.duration_ = 9

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play424051101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 4

			if var_408_0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				arg_405_1.allBtn_.enabled = false
			end

			local var_408_1 = 0.3

			if arg_405_1.time_ >= var_408_0 + var_408_1 and arg_405_1.time_ < var_408_0 + var_408_1 + arg_408_0 then
				arg_405_1.allBtn_.enabled = true
			end

			local var_408_2 = 0

			if var_408_2 < arg_405_1.time_ and arg_405_1.time_ <= var_408_2 + arg_408_0 then
				arg_405_1.mask_.enabled = true
				arg_405_1.mask_.raycastTarget = true

				arg_405_1:SetGaussion(false)
			end

			local var_408_3 = 2

			if var_408_2 <= arg_405_1.time_ and arg_405_1.time_ < var_408_2 + var_408_3 then
				local var_408_4 = (arg_405_1.time_ - var_408_2) / var_408_3
				local var_408_5 = Color.New(0, 0, 0)

				var_408_5.a = Mathf.Lerp(0, 1, var_408_4)
				arg_405_1.mask_.color = var_408_5
			end

			if arg_405_1.time_ >= var_408_2 + var_408_3 and arg_405_1.time_ < var_408_2 + var_408_3 + arg_408_0 then
				local var_408_6 = Color.New(0, 0, 0)

				var_408_6.a = 1
				arg_405_1.mask_.color = var_408_6
			end

			local var_408_7 = 2

			if var_408_7 < arg_405_1.time_ and arg_405_1.time_ <= var_408_7 + arg_408_0 then
				arg_405_1.mask_.enabled = true
				arg_405_1.mask_.raycastTarget = true

				arg_405_1:SetGaussion(false)
			end

			local var_408_8 = 2

			if var_408_7 <= arg_405_1.time_ and arg_405_1.time_ < var_408_7 + var_408_8 then
				local var_408_9 = (arg_405_1.time_ - var_408_7) / var_408_8
				local var_408_10 = Color.New(0, 0, 0)

				var_408_10.a = Mathf.Lerp(1, 0, var_408_9)
				arg_405_1.mask_.color = var_408_10
			end

			if arg_405_1.time_ >= var_408_7 + var_408_8 and arg_405_1.time_ < var_408_7 + var_408_8 + arg_408_0 then
				local var_408_11 = Color.New(0, 0, 0)
				local var_408_12 = 0

				arg_405_1.mask_.enabled = false
				var_408_11.a = var_408_12
				arg_405_1.mask_.color = var_408_11
			end

			local var_408_13 = 2

			if var_408_13 < arg_405_1.time_ and arg_405_1.time_ <= var_408_13 + arg_408_0 then
				local var_408_14 = manager.ui.mainCamera.transform.localPosition
				local var_408_15 = Vector3.New(0, 0, 10) + Vector3.New(var_408_14.x, var_408_14.y, 0)
				local var_408_16 = arg_405_1.bgs_.ST0115

				var_408_16.transform.localPosition = var_408_15
				var_408_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_408_17 = var_408_16:GetComponent("SpriteRenderer")

				if var_408_17 and var_408_17.sprite then
					local var_408_18 = (var_408_16.transform.localPosition - var_408_14).z
					local var_408_19 = manager.ui.mainCameraCom_
					local var_408_20 = 2 * var_408_18 * Mathf.Tan(var_408_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_408_21 = var_408_20 * var_408_19.aspect
					local var_408_22 = var_408_17.sprite.bounds.size.x
					local var_408_23 = var_408_17.sprite.bounds.size.y
					local var_408_24 = var_408_21 / var_408_22
					local var_408_25 = var_408_20 / var_408_23
					local var_408_26 = var_408_25 < var_408_24 and var_408_24 or var_408_25

					var_408_16.transform.localScale = Vector3.New(var_408_26, var_408_26, 0)
				end

				for iter_408_0, iter_408_1 in pairs(arg_405_1.bgs_) do
					if iter_408_0 ~= "ST0115" then
						iter_408_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_408_27 = 2

			arg_405_1.isInRecall_ = false

			if var_408_27 < arg_405_1.time_ and arg_405_1.time_ <= var_408_27 + arg_408_0 then
				arg_405_1.screenFilterGo_:SetActive(false)

				for iter_408_2, iter_408_3 in pairs(arg_405_1.actors_) do
					local var_408_28 = iter_408_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_408_4, iter_408_5 in ipairs(var_408_28) do
						if iter_408_5.color.r > 0.51 then
							iter_408_5.color = Color.New(1, 1, 1)
						else
							iter_408_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_408_29 = 0.2

			if var_408_27 <= arg_405_1.time_ and arg_405_1.time_ < var_408_27 + var_408_29 then
				local var_408_30 = (arg_405_1.time_ - var_408_27) / var_408_29

				arg_405_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_408_30)
			end

			if arg_405_1.time_ >= var_408_27 + var_408_29 and arg_405_1.time_ < var_408_27 + var_408_29 + arg_408_0 then
				arg_405_1.screenFilterEffect_.weight = 0
			end

			local var_408_31 = 0.233333333333333
			local var_408_32 = 1

			if var_408_31 < arg_405_1.time_ and arg_405_1.time_ <= var_408_31 + arg_408_0 then
				local var_408_33 = "stop"
				local var_408_34 = "effect"

				arg_405_1:AudioAction(var_408_33, var_408_34, "se_story_140", "se_story_140_amb_valley", "")
			end

			local var_408_35 = 1.7
			local var_408_36 = 1

			if var_408_35 < arg_405_1.time_ and arg_405_1.time_ <= var_408_35 + arg_408_0 then
				local var_408_37 = "play"
				local var_408_38 = "effect"

				arg_405_1:AudioAction(var_408_37, var_408_38, "se_story_140", "se_story_140_amb_room01", "")
			end

			if arg_405_1.frameCnt_ <= 1 then
				arg_405_1.dialog_:SetActive(false)
			end

			local var_408_39 = 4
			local var_408_40 = 0.875

			if var_408_39 < arg_405_1.time_ and arg_405_1.time_ <= var_408_39 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0

				arg_405_1.dialog_:SetActive(true)

				arg_405_1.dialogCg_.alpha = 0

				local var_408_41 = LeanTween.value(arg_405_1.dialog_, 0, 1, 0.3)

				var_408_41:setOnUpdate(LuaHelper.FloatAction(function(arg_409_0)
					arg_405_1.dialogCg_.alpha = arg_409_0
				end))
				var_408_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_405_1.dialog_)
					var_408_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_405_1.duration_ = arg_405_1.duration_ + 0.3

				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_42 = arg_405_1:GetWordFromCfg(424051100)
				local var_408_43 = arg_405_1:FormatText(var_408_42.content)

				arg_405_1.text_.text = var_408_43

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_44 = 35
				local var_408_45 = utf8.len(var_408_43)
				local var_408_46 = var_408_44 <= 0 and var_408_40 or var_408_40 * (var_408_45 / var_408_44)

				if var_408_46 > 0 and var_408_40 < var_408_46 then
					arg_405_1.talkMaxDuration = var_408_46
					var_408_39 = var_408_39 + 0.3

					if var_408_46 + var_408_39 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_46 + var_408_39
					end
				end

				arg_405_1.text_.text = var_408_43
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_47 = var_408_39 + 0.3
			local var_408_48 = math.max(var_408_40, arg_405_1.talkMaxDuration)

			if var_408_47 <= arg_405_1.time_ and arg_405_1.time_ < var_408_47 + var_408_48 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_47) / var_408_48

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_47 + var_408_48 and arg_405_1.time_ < var_408_47 + var_408_48 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play424051101 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 424051101
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play424051102(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0
			local var_414_1 = 1.4

			if var_414_0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_2 = arg_411_1:FormatText(StoryNameCfg[7].name)

				arg_411_1.leftNameTxt_.text = var_414_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_3 = arg_411_1:GetWordFromCfg(424051101)
				local var_414_4 = arg_411_1:FormatText(var_414_3.content)

				arg_411_1.text_.text = var_414_4

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_5 = 56
				local var_414_6 = utf8.len(var_414_4)
				local var_414_7 = var_414_5 <= 0 and var_414_1 or var_414_1 * (var_414_6 / var_414_5)

				if var_414_7 > 0 and var_414_1 < var_414_7 then
					arg_411_1.talkMaxDuration = var_414_7

					if var_414_7 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_7 + var_414_0
					end
				end

				arg_411_1.text_.text = var_414_4
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_8 = math.max(var_414_1, arg_411_1.talkMaxDuration)

			if var_414_0 <= arg_411_1.time_ and arg_411_1.time_ < var_414_0 + var_414_8 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_0) / var_414_8

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_0 + var_414_8 and arg_411_1.time_ < var_414_0 + var_414_8 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play424051102 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 424051102
		arg_415_1.duration_ = 3.8

		local var_415_0 = {
			zh = 3,
			ja = 3.8
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play424051103(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0
			local var_418_1 = 0.275

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_2 = arg_415_1:FormatText(StoryNameCfg[177].name)

				arg_415_1.leftNameTxt_.text = var_418_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, true)
				arg_415_1.iconController_:SetSelectedState("hero")

				arg_415_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_415_1.callingController_:SetSelectedState("normal")

				arg_415_1.keyicon_.color = Color.New(1, 1, 1)
				arg_415_1.icon_.color = Color.New(1, 1, 1)

				local var_418_3 = arg_415_1:GetWordFromCfg(424051102)
				local var_418_4 = arg_415_1:FormatText(var_418_3.content)

				arg_415_1.text_.text = var_418_4

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_5 = 11
				local var_418_6 = utf8.len(var_418_4)
				local var_418_7 = var_418_5 <= 0 and var_418_1 or var_418_1 * (var_418_6 / var_418_5)

				if var_418_7 > 0 and var_418_1 < var_418_7 then
					arg_415_1.talkMaxDuration = var_418_7

					if var_418_7 + var_418_0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_7 + var_418_0
					end
				end

				arg_415_1.text_.text = var_418_4
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051102", "story_v_out_424051.awb") ~= 0 then
					local var_418_8 = manager.audio:GetVoiceLength("story_v_out_424051", "424051102", "story_v_out_424051.awb") / 1000

					if var_418_8 + var_418_0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_8 + var_418_0
					end

					if var_418_3.prefab_name ~= "" and arg_415_1.actors_[var_418_3.prefab_name] ~= nil then
						local var_418_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_3.prefab_name].transform, "story_v_out_424051", "424051102", "story_v_out_424051.awb")

						arg_415_1:RecordAudio("424051102", var_418_9)
						arg_415_1:RecordAudio("424051102", var_418_9)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_424051", "424051102", "story_v_out_424051.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_424051", "424051102", "story_v_out_424051.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_10 = math.max(var_418_1, arg_415_1.talkMaxDuration)

			if var_418_0 <= arg_415_1.time_ and arg_415_1.time_ < var_418_0 + var_418_10 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_0) / var_418_10

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_0 + var_418_10 and arg_415_1.time_ < var_418_0 + var_418_10 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play424051103 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 424051103
		arg_419_1.duration_ = 11.6

		local var_419_0 = {
			zh = 7.833,
			ja = 11.6
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play424051104(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = arg_419_1.actors_["10155"]
			local var_422_1 = 0

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 and not isNil(var_422_0) and arg_419_1.var_.actorSpriteComps10155 == nil then
				arg_419_1.var_.actorSpriteComps10155 = var_422_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_422_2 = 0.2

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_2 and not isNil(var_422_0) then
				local var_422_3 = (arg_419_1.time_ - var_422_1) / var_422_2

				if arg_419_1.var_.actorSpriteComps10155 then
					for iter_422_0, iter_422_1 in pairs(arg_419_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_422_1 then
							if arg_419_1.isInRecall_ then
								local var_422_4 = Mathf.Lerp(iter_422_1.color.r, arg_419_1.hightColor1.r, var_422_3)
								local var_422_5 = Mathf.Lerp(iter_422_1.color.g, arg_419_1.hightColor1.g, var_422_3)
								local var_422_6 = Mathf.Lerp(iter_422_1.color.b, arg_419_1.hightColor1.b, var_422_3)

								iter_422_1.color = Color.New(var_422_4, var_422_5, var_422_6)
							else
								local var_422_7 = Mathf.Lerp(iter_422_1.color.r, 1, var_422_3)

								iter_422_1.color = Color.New(var_422_7, var_422_7, var_422_7)
							end
						end
					end
				end
			end

			if arg_419_1.time_ >= var_422_1 + var_422_2 and arg_419_1.time_ < var_422_1 + var_422_2 + arg_422_0 and not isNil(var_422_0) and arg_419_1.var_.actorSpriteComps10155 then
				for iter_422_2, iter_422_3 in pairs(arg_419_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_422_3 then
						if arg_419_1.isInRecall_ then
							iter_422_3.color = arg_419_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_422_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_419_1.var_.actorSpriteComps10155 = nil
			end

			local var_422_8 = arg_419_1.actors_["10155"].transform
			local var_422_9 = 0

			if var_422_9 < arg_419_1.time_ and arg_419_1.time_ <= var_422_9 + arg_422_0 then
				arg_419_1.var_.moveOldPos10155 = var_422_8.localPosition
				var_422_8.localScale = Vector3.New(1, 1, 1)

				arg_419_1:CheckSpriteTmpPos("10155", 3)

				local var_422_10 = var_422_8.childCount

				for iter_422_4 = 0, var_422_10 - 1 do
					local var_422_11 = var_422_8:GetChild(iter_422_4)

					if var_422_11.name == "split_4" then
						var_422_11:SetAsLastSibling()
						var_422_11.gameObject:SetActive(true)

						arg_419_1.var_.actorSpriteSplit10155 = var_422_11.gameObject:GetComponent(typeof(Image))

						arg_419_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_422_12 = 0.001

			if var_422_9 <= arg_419_1.time_ and arg_419_1.time_ < var_422_9 + var_422_12 then
				local var_422_13 = (arg_419_1.time_ - var_422_9) / var_422_12
				local var_422_14 = Vector3.New(-40, -390, -250)

				var_422_8.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos10155, var_422_14, var_422_13)

				if arg_419_1.var_.actorSpriteSplit10155 ~= nil then
					arg_419_1.var_.actorSpriteSplit10155:SetAlpha(var_422_13)
				end
			end

			if arg_419_1.time_ >= var_422_9 + var_422_12 and arg_419_1.time_ < var_422_9 + var_422_12 + arg_422_0 then
				var_422_8.localPosition = Vector3.New(-40, -390, -250)

				if arg_419_1.var_.actorSpriteSplit10155 ~= nil then
					arg_419_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_422_15 = 0
			local var_422_16 = 0.875

			if var_422_15 < arg_419_1.time_ and arg_419_1.time_ <= var_422_15 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_17 = arg_419_1:FormatText(StoryNameCfg[1391].name)

				arg_419_1.leftNameTxt_.text = var_422_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_18 = arg_419_1:GetWordFromCfg(424051103)
				local var_422_19 = arg_419_1:FormatText(var_422_18.content)

				arg_419_1.text_.text = var_422_19

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_20 = 35
				local var_422_21 = utf8.len(var_422_19)
				local var_422_22 = var_422_20 <= 0 and var_422_16 or var_422_16 * (var_422_21 / var_422_20)

				if var_422_22 > 0 and var_422_16 < var_422_22 then
					arg_419_1.talkMaxDuration = var_422_22

					if var_422_22 + var_422_15 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_22 + var_422_15
					end
				end

				arg_419_1.text_.text = var_422_19
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051103", "story_v_out_424051.awb") ~= 0 then
					local var_422_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051103", "story_v_out_424051.awb") / 1000

					if var_422_23 + var_422_15 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_23 + var_422_15
					end

					if var_422_18.prefab_name ~= "" and arg_419_1.actors_[var_422_18.prefab_name] ~= nil then
						local var_422_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_18.prefab_name].transform, "story_v_out_424051", "424051103", "story_v_out_424051.awb")

						arg_419_1:RecordAudio("424051103", var_422_24)
						arg_419_1:RecordAudio("424051103", var_422_24)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_424051", "424051103", "story_v_out_424051.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_424051", "424051103", "story_v_out_424051.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_25 = math.max(var_422_16, arg_419_1.talkMaxDuration)

			if var_422_15 <= arg_419_1.time_ and arg_419_1.time_ < var_422_15 + var_422_25 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_15) / var_422_25

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_15 + var_422_25 and arg_419_1.time_ < var_422_15 + var_422_25 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
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

		arg_419_1:InitPlayNodeList()
	end,
	Play424051104 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 424051104
		arg_423_1.duration_ = 11.07

		local var_423_0 = {
			zh = 5.3,
			ja = 11.066
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
				arg_423_0:Play424051105(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0
			local var_426_1 = 0.975

			if var_426_0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_2 = arg_423_1:FormatText(StoryNameCfg[1391].name)

				arg_423_1.leftNameTxt_.text = var_426_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_3 = arg_423_1:GetWordFromCfg(424051104)
				local var_426_4 = arg_423_1:FormatText(var_426_3.content)

				arg_423_1.text_.text = var_426_4

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051104", "story_v_out_424051.awb") ~= 0 then
					local var_426_8 = manager.audio:GetVoiceLength("story_v_out_424051", "424051104", "story_v_out_424051.awb") / 1000

					if var_426_8 + var_426_0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_8 + var_426_0
					end

					if var_426_3.prefab_name ~= "" and arg_423_1.actors_[var_426_3.prefab_name] ~= nil then
						local var_426_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_3.prefab_name].transform, "story_v_out_424051", "424051104", "story_v_out_424051.awb")

						arg_423_1:RecordAudio("424051104", var_426_9)
						arg_423_1:RecordAudio("424051104", var_426_9)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_424051", "424051104", "story_v_out_424051.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_424051", "424051104", "story_v_out_424051.awb")
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
	Play424051105 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 424051105
		arg_427_1.duration_ = 14.03

		local var_427_0 = {
			zh = 9.433,
			ja = 14.033
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
				arg_427_0:Play424051106(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = arg_427_1.actors_["10155"].transform
			local var_430_1 = 0

			if var_430_1 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 then
				arg_427_1.var_.moveOldPos10155 = var_430_0.localPosition
				var_430_0.localScale = Vector3.New(1, 1, 1)

				arg_427_1:CheckSpriteTmpPos("10155", 3)

				local var_430_2 = var_430_0.childCount

				for iter_430_0 = 0, var_430_2 - 1 do
					local var_430_3 = var_430_0:GetChild(iter_430_0)

					if var_430_3.name == "split_1" then
						var_430_3:SetAsLastSibling()
						var_430_3.gameObject:SetActive(true)

						arg_427_1.var_.actorSpriteSplit10155 = var_430_3.gameObject:GetComponent(typeof(Image))

						arg_427_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_430_4 = 0.5

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_4 then
				local var_430_5 = (arg_427_1.time_ - var_430_1) / var_430_4
				local var_430_6 = Vector3.New(-40, -390, -250)

				var_430_0.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos10155, var_430_6, var_430_5)

				if arg_427_1.var_.actorSpriteSplit10155 ~= nil then
					arg_427_1.var_.actorSpriteSplit10155:SetAlpha(var_430_5)
				end
			end

			if arg_427_1.time_ >= var_430_1 + var_430_4 and arg_427_1.time_ < var_430_1 + var_430_4 + arg_430_0 then
				var_430_0.localPosition = Vector3.New(-40, -390, -250)

				if arg_427_1.var_.actorSpriteSplit10155 ~= nil then
					arg_427_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_430_7 = 0
			local var_430_8 = 1

			if var_430_7 < arg_427_1.time_ and arg_427_1.time_ <= var_430_7 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_9 = arg_427_1:FormatText(StoryNameCfg[1391].name)

				arg_427_1.leftNameTxt_.text = var_430_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_10 = arg_427_1:GetWordFromCfg(424051105)
				local var_430_11 = arg_427_1:FormatText(var_430_10.content)

				arg_427_1.text_.text = var_430_11

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_12 = 40
				local var_430_13 = utf8.len(var_430_11)
				local var_430_14 = var_430_12 <= 0 and var_430_8 or var_430_8 * (var_430_13 / var_430_12)

				if var_430_14 > 0 and var_430_8 < var_430_14 then
					arg_427_1.talkMaxDuration = var_430_14

					if var_430_14 + var_430_7 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_14 + var_430_7
					end
				end

				arg_427_1.text_.text = var_430_11
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051105", "story_v_out_424051.awb") ~= 0 then
					local var_430_15 = manager.audio:GetVoiceLength("story_v_out_424051", "424051105", "story_v_out_424051.awb") / 1000

					if var_430_15 + var_430_7 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_15 + var_430_7
					end

					if var_430_10.prefab_name ~= "" and arg_427_1.actors_[var_430_10.prefab_name] ~= nil then
						local var_430_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_10.prefab_name].transform, "story_v_out_424051", "424051105", "story_v_out_424051.awb")

						arg_427_1:RecordAudio("424051105", var_430_16)
						arg_427_1:RecordAudio("424051105", var_430_16)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_424051", "424051105", "story_v_out_424051.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_424051", "424051105", "story_v_out_424051.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_17 = math.max(var_430_8, arg_427_1.talkMaxDuration)

			if var_430_7 <= arg_427_1.time_ and arg_427_1.time_ < var_430_7 + var_430_17 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_7) / var_430_17

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_7 + var_430_17 and arg_427_1.time_ < var_430_7 + var_430_17 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play424051106 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 424051106
		arg_431_1.duration_ = 9.07

		local var_431_0 = {
			zh = 6.633,
			ja = 9.066
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play424051107(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["10155"].transform
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 then
				arg_431_1.var_.moveOldPos10155 = var_434_0.localPosition
				var_434_0.localScale = Vector3.New(1, 1, 1)

				arg_431_1:CheckSpriteTmpPos("10155", 3)

				local var_434_2 = var_434_0.childCount

				for iter_434_0 = 0, var_434_2 - 1 do
					local var_434_3 = var_434_0:GetChild(iter_434_0)

					if var_434_3.name == "split_4" then
						var_434_3:SetAsLastSibling()
						var_434_3.gameObject:SetActive(true)

						arg_431_1.var_.actorSpriteSplit10155 = var_434_3.gameObject:GetComponent(typeof(Image))

						arg_431_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_434_4 = 0.5

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_4 then
				local var_434_5 = (arg_431_1.time_ - var_434_1) / var_434_4
				local var_434_6 = Vector3.New(-40, -390, -250)

				var_434_0.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos10155, var_434_6, var_434_5)

				if arg_431_1.var_.actorSpriteSplit10155 ~= nil then
					arg_431_1.var_.actorSpriteSplit10155:SetAlpha(var_434_5)
				end
			end

			if arg_431_1.time_ >= var_434_1 + var_434_4 and arg_431_1.time_ < var_434_1 + var_434_4 + arg_434_0 then
				var_434_0.localPosition = Vector3.New(-40, -390, -250)

				if arg_431_1.var_.actorSpriteSplit10155 ~= nil then
					arg_431_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_434_7 = 0
			local var_434_8 = 0.725

			if var_434_7 < arg_431_1.time_ and arg_431_1.time_ <= var_434_7 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_9 = arg_431_1:FormatText(StoryNameCfg[1391].name)

				arg_431_1.leftNameTxt_.text = var_434_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_10 = arg_431_1:GetWordFromCfg(424051106)
				local var_434_11 = arg_431_1:FormatText(var_434_10.content)

				arg_431_1.text_.text = var_434_11

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_12 = 29
				local var_434_13 = utf8.len(var_434_11)
				local var_434_14 = var_434_12 <= 0 and var_434_8 or var_434_8 * (var_434_13 / var_434_12)

				if var_434_14 > 0 and var_434_8 < var_434_14 then
					arg_431_1.talkMaxDuration = var_434_14

					if var_434_14 + var_434_7 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_14 + var_434_7
					end
				end

				arg_431_1.text_.text = var_434_11
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051106", "story_v_out_424051.awb") ~= 0 then
					local var_434_15 = manager.audio:GetVoiceLength("story_v_out_424051", "424051106", "story_v_out_424051.awb") / 1000

					if var_434_15 + var_434_7 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_15 + var_434_7
					end

					if var_434_10.prefab_name ~= "" and arg_431_1.actors_[var_434_10.prefab_name] ~= nil then
						local var_434_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_10.prefab_name].transform, "story_v_out_424051", "424051106", "story_v_out_424051.awb")

						arg_431_1:RecordAudio("424051106", var_434_16)
						arg_431_1:RecordAudio("424051106", var_434_16)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_424051", "424051106", "story_v_out_424051.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_424051", "424051106", "story_v_out_424051.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_17 = math.max(var_434_8, arg_431_1.talkMaxDuration)

			if var_434_7 <= arg_431_1.time_ and arg_431_1.time_ < var_434_7 + var_434_17 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_7) / var_434_17

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_7 + var_434_17 and arg_431_1.time_ < var_434_7 + var_434_17 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_431_1:InitPlayNodeList()
	end,
	Play424051107 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 424051107
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play424051108(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["10155"]
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.actorSpriteComps10155 == nil then
				arg_435_1.var_.actorSpriteComps10155 = var_438_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_438_2 = 0.2

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_2 and not isNil(var_438_0) then
				local var_438_3 = (arg_435_1.time_ - var_438_1) / var_438_2

				if arg_435_1.var_.actorSpriteComps10155 then
					for iter_438_0, iter_438_1 in pairs(arg_435_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_438_1 then
							if arg_435_1.isInRecall_ then
								local var_438_4 = Mathf.Lerp(iter_438_1.color.r, arg_435_1.hightColor2.r, var_438_3)
								local var_438_5 = Mathf.Lerp(iter_438_1.color.g, arg_435_1.hightColor2.g, var_438_3)
								local var_438_6 = Mathf.Lerp(iter_438_1.color.b, arg_435_1.hightColor2.b, var_438_3)

								iter_438_1.color = Color.New(var_438_4, var_438_5, var_438_6)
							else
								local var_438_7 = Mathf.Lerp(iter_438_1.color.r, 0.5, var_438_3)

								iter_438_1.color = Color.New(var_438_7, var_438_7, var_438_7)
							end
						end
					end
				end
			end

			if arg_435_1.time_ >= var_438_1 + var_438_2 and arg_435_1.time_ < var_438_1 + var_438_2 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.actorSpriteComps10155 then
				for iter_438_2, iter_438_3 in pairs(arg_435_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_438_3 then
						if arg_435_1.isInRecall_ then
							iter_438_3.color = arg_435_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_438_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_435_1.var_.actorSpriteComps10155 = nil
			end

			local var_438_8 = 0
			local var_438_9 = 0.475

			if var_438_8 < arg_435_1.time_ and arg_435_1.time_ <= var_438_8 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_10 = arg_435_1:FormatText(StoryNameCfg[7].name)

				arg_435_1.leftNameTxt_.text = var_438_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_435_1.callingController_:SetSelectedState("normal")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_11 = arg_435_1:GetWordFromCfg(424051107)
				local var_438_12 = arg_435_1:FormatText(var_438_11.content)

				arg_435_1.text_.text = var_438_12

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_13 = 19
				local var_438_14 = utf8.len(var_438_12)
				local var_438_15 = var_438_13 <= 0 and var_438_9 or var_438_9 * (var_438_14 / var_438_13)

				if var_438_15 > 0 and var_438_9 < var_438_15 then
					arg_435_1.talkMaxDuration = var_438_15

					if var_438_15 + var_438_8 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_15 + var_438_8
					end
				end

				arg_435_1.text_.text = var_438_12
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_16 = math.max(var_438_9, arg_435_1.talkMaxDuration)

			if var_438_8 <= arg_435_1.time_ and arg_435_1.time_ < var_438_8 + var_438_16 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_8) / var_438_16

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_8 + var_438_16 and arg_435_1.time_ < var_438_8 + var_438_16 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play424051108 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 424051108
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play424051109(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0
			local var_442_1 = 1.25

			if var_442_0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, false)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_2 = arg_439_1:GetWordFromCfg(424051108)
				local var_442_3 = arg_439_1:FormatText(var_442_2.content)

				arg_439_1.text_.text = var_442_3

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_4 = 50
				local var_442_5 = utf8.len(var_442_3)
				local var_442_6 = var_442_4 <= 0 and var_442_1 or var_442_1 * (var_442_5 / var_442_4)

				if var_442_6 > 0 and var_442_1 < var_442_6 then
					arg_439_1.talkMaxDuration = var_442_6

					if var_442_6 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_6 + var_442_0
					end
				end

				arg_439_1.text_.text = var_442_3
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_7 = math.max(var_442_1, arg_439_1.talkMaxDuration)

			if var_442_0 <= arg_439_1.time_ and arg_439_1.time_ < var_442_0 + var_442_7 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_0) / var_442_7

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_0 + var_442_7 and arg_439_1.time_ < var_442_0 + var_442_7 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play424051109 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 424051109
		arg_443_1.duration_ = 4.4

		local var_443_0 = {
			zh = 3.8,
			ja = 4.4
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play424051110(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = arg_443_1.actors_["10155"]
			local var_446_1 = 0

			if var_446_1 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 and not isNil(var_446_0) and arg_443_1.var_.actorSpriteComps10155 == nil then
				arg_443_1.var_.actorSpriteComps10155 = var_446_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_446_2 = 0.2

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_2 and not isNil(var_446_0) then
				local var_446_3 = (arg_443_1.time_ - var_446_1) / var_446_2

				if arg_443_1.var_.actorSpriteComps10155 then
					for iter_446_0, iter_446_1 in pairs(arg_443_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_446_1 then
							if arg_443_1.isInRecall_ then
								local var_446_4 = Mathf.Lerp(iter_446_1.color.r, arg_443_1.hightColor1.r, var_446_3)
								local var_446_5 = Mathf.Lerp(iter_446_1.color.g, arg_443_1.hightColor1.g, var_446_3)
								local var_446_6 = Mathf.Lerp(iter_446_1.color.b, arg_443_1.hightColor1.b, var_446_3)

								iter_446_1.color = Color.New(var_446_4, var_446_5, var_446_6)
							else
								local var_446_7 = Mathf.Lerp(iter_446_1.color.r, 1, var_446_3)

								iter_446_1.color = Color.New(var_446_7, var_446_7, var_446_7)
							end
						end
					end
				end
			end

			if arg_443_1.time_ >= var_446_1 + var_446_2 and arg_443_1.time_ < var_446_1 + var_446_2 + arg_446_0 and not isNil(var_446_0) and arg_443_1.var_.actorSpriteComps10155 then
				for iter_446_2, iter_446_3 in pairs(arg_443_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_446_3 then
						if arg_443_1.isInRecall_ then
							iter_446_3.color = arg_443_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_446_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_443_1.var_.actorSpriteComps10155 = nil
			end

			local var_446_8 = arg_443_1.actors_["10155"].transform
			local var_446_9 = 0

			if var_446_9 < arg_443_1.time_ and arg_443_1.time_ <= var_446_9 + arg_446_0 then
				arg_443_1.var_.moveOldPos10155 = var_446_8.localPosition
				var_446_8.localScale = Vector3.New(1, 1, 1)

				arg_443_1:CheckSpriteTmpPos("10155", 3)

				local var_446_10 = var_446_8.childCount

				for iter_446_4 = 0, var_446_10 - 1 do
					local var_446_11 = var_446_8:GetChild(iter_446_4)

					if var_446_11.name == "split_1" then
						var_446_11:SetAsLastSibling()
						var_446_11.gameObject:SetActive(true)

						arg_443_1.var_.actorSpriteSplit10155 = var_446_11.gameObject:GetComponent(typeof(Image))

						arg_443_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_446_12 = 0.5

			if var_446_9 <= arg_443_1.time_ and arg_443_1.time_ < var_446_9 + var_446_12 then
				local var_446_13 = (arg_443_1.time_ - var_446_9) / var_446_12
				local var_446_14 = Vector3.New(-40, -390, -250)

				var_446_8.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos10155, var_446_14, var_446_13)

				if arg_443_1.var_.actorSpriteSplit10155 ~= nil then
					arg_443_1.var_.actorSpriteSplit10155:SetAlpha(var_446_13)
				end
			end

			if arg_443_1.time_ >= var_446_9 + var_446_12 and arg_443_1.time_ < var_446_9 + var_446_12 + arg_446_0 then
				var_446_8.localPosition = Vector3.New(-40, -390, -250)

				if arg_443_1.var_.actorSpriteSplit10155 ~= nil then
					arg_443_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_446_15 = 0
			local var_446_16 = 0.375

			if var_446_15 < arg_443_1.time_ and arg_443_1.time_ <= var_446_15 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_17 = arg_443_1:FormatText(StoryNameCfg[1391].name)

				arg_443_1.leftNameTxt_.text = var_446_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_18 = arg_443_1:GetWordFromCfg(424051109)
				local var_446_19 = arg_443_1:FormatText(var_446_18.content)

				arg_443_1.text_.text = var_446_19

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_20 = 15
				local var_446_21 = utf8.len(var_446_19)
				local var_446_22 = var_446_20 <= 0 and var_446_16 or var_446_16 * (var_446_21 / var_446_20)

				if var_446_22 > 0 and var_446_16 < var_446_22 then
					arg_443_1.talkMaxDuration = var_446_22

					if var_446_22 + var_446_15 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_22 + var_446_15
					end
				end

				arg_443_1.text_.text = var_446_19
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051109", "story_v_out_424051.awb") ~= 0 then
					local var_446_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051109", "story_v_out_424051.awb") / 1000

					if var_446_23 + var_446_15 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_23 + var_446_15
					end

					if var_446_18.prefab_name ~= "" and arg_443_1.actors_[var_446_18.prefab_name] ~= nil then
						local var_446_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_18.prefab_name].transform, "story_v_out_424051", "424051109", "story_v_out_424051.awb")

						arg_443_1:RecordAudio("424051109", var_446_24)
						arg_443_1:RecordAudio("424051109", var_446_24)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_424051", "424051109", "story_v_out_424051.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_424051", "424051109", "story_v_out_424051.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_25 = math.max(var_446_16, arg_443_1.talkMaxDuration)

			if var_446_15 <= arg_443_1.time_ and arg_443_1.time_ < var_446_15 + var_446_25 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_15) / var_446_25

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_15 + var_446_25 and arg_443_1.time_ < var_446_15 + var_446_25 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_443_1:InitPlayNodeList()
	end,
	Play424051110 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 424051110
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play424051111(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = arg_447_1.actors_["10155"]
			local var_450_1 = 0

			if var_450_1 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 and not isNil(var_450_0) and arg_447_1.var_.actorSpriteComps10155 == nil then
				arg_447_1.var_.actorSpriteComps10155 = var_450_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_450_2 = 0.2

			if var_450_1 <= arg_447_1.time_ and arg_447_1.time_ < var_450_1 + var_450_2 and not isNil(var_450_0) then
				local var_450_3 = (arg_447_1.time_ - var_450_1) / var_450_2

				if arg_447_1.var_.actorSpriteComps10155 then
					for iter_450_0, iter_450_1 in pairs(arg_447_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_450_1 then
							if arg_447_1.isInRecall_ then
								local var_450_4 = Mathf.Lerp(iter_450_1.color.r, arg_447_1.hightColor2.r, var_450_3)
								local var_450_5 = Mathf.Lerp(iter_450_1.color.g, arg_447_1.hightColor2.g, var_450_3)
								local var_450_6 = Mathf.Lerp(iter_450_1.color.b, arg_447_1.hightColor2.b, var_450_3)

								iter_450_1.color = Color.New(var_450_4, var_450_5, var_450_6)
							else
								local var_450_7 = Mathf.Lerp(iter_450_1.color.r, 0.5, var_450_3)

								iter_450_1.color = Color.New(var_450_7, var_450_7, var_450_7)
							end
						end
					end
				end
			end

			if arg_447_1.time_ >= var_450_1 + var_450_2 and arg_447_1.time_ < var_450_1 + var_450_2 + arg_450_0 and not isNil(var_450_0) and arg_447_1.var_.actorSpriteComps10155 then
				for iter_450_2, iter_450_3 in pairs(arg_447_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_450_3 then
						if arg_447_1.isInRecall_ then
							iter_450_3.color = arg_447_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_450_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_447_1.var_.actorSpriteComps10155 = nil
			end

			local var_450_8 = 0.2
			local var_450_9 = 1

			if var_450_8 < arg_447_1.time_ and arg_447_1.time_ <= var_450_8 + arg_450_0 then
				local var_450_10 = "play"
				local var_450_11 = "effect"

				arg_447_1:AudioAction(var_450_10, var_450_11, "se_story_146", "se_story_146_hourglass_sand", "")
			end

			local var_450_12 = 0
			local var_450_13 = 1.5

			if var_450_12 < arg_447_1.time_ and arg_447_1.time_ <= var_450_12 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, false)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_14 = arg_447_1:GetWordFromCfg(424051110)
				local var_450_15 = arg_447_1:FormatText(var_450_14.content)

				arg_447_1.text_.text = var_450_15

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_16 = 60
				local var_450_17 = utf8.len(var_450_15)
				local var_450_18 = var_450_16 <= 0 and var_450_13 or var_450_13 * (var_450_17 / var_450_16)

				if var_450_18 > 0 and var_450_13 < var_450_18 then
					arg_447_1.talkMaxDuration = var_450_18

					if var_450_18 + var_450_12 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_18 + var_450_12
					end
				end

				arg_447_1.text_.text = var_450_15
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_19 = math.max(var_450_13, arg_447_1.talkMaxDuration)

			if var_450_12 <= arg_447_1.time_ and arg_447_1.time_ < var_450_12 + var_450_19 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_12) / var_450_19

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_12 + var_450_19 and arg_447_1.time_ < var_450_12 + var_450_19 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play424051111 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 424051111
		arg_451_1.duration_ = 2.9

		local var_451_0 = {
			zh = 1.333,
			ja = 2.9
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play424051112(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = arg_451_1.actors_["10155"]
			local var_454_1 = 0

			if var_454_1 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 and not isNil(var_454_0) and arg_451_1.var_.actorSpriteComps10155 == nil then
				arg_451_1.var_.actorSpriteComps10155 = var_454_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_454_2 = 0.2

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_2 and not isNil(var_454_0) then
				local var_454_3 = (arg_451_1.time_ - var_454_1) / var_454_2

				if arg_451_1.var_.actorSpriteComps10155 then
					for iter_454_0, iter_454_1 in pairs(arg_451_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_454_1 then
							if arg_451_1.isInRecall_ then
								local var_454_4 = Mathf.Lerp(iter_454_1.color.r, arg_451_1.hightColor1.r, var_454_3)
								local var_454_5 = Mathf.Lerp(iter_454_1.color.g, arg_451_1.hightColor1.g, var_454_3)
								local var_454_6 = Mathf.Lerp(iter_454_1.color.b, arg_451_1.hightColor1.b, var_454_3)

								iter_454_1.color = Color.New(var_454_4, var_454_5, var_454_6)
							else
								local var_454_7 = Mathf.Lerp(iter_454_1.color.r, 1, var_454_3)

								iter_454_1.color = Color.New(var_454_7, var_454_7, var_454_7)
							end
						end
					end
				end
			end

			if arg_451_1.time_ >= var_454_1 + var_454_2 and arg_451_1.time_ < var_454_1 + var_454_2 + arg_454_0 and not isNil(var_454_0) and arg_451_1.var_.actorSpriteComps10155 then
				for iter_454_2, iter_454_3 in pairs(arg_451_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_454_3 then
						if arg_451_1.isInRecall_ then
							iter_454_3.color = arg_451_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_454_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_451_1.var_.actorSpriteComps10155 = nil
			end

			local var_454_8 = arg_451_1.actors_["10155"].transform
			local var_454_9 = 0

			if var_454_9 < arg_451_1.time_ and arg_451_1.time_ <= var_454_9 + arg_454_0 then
				arg_451_1.var_.moveOldPos10155 = var_454_8.localPosition
				var_454_8.localScale = Vector3.New(1, 1, 1)

				arg_451_1:CheckSpriteTmpPos("10155", 3)

				local var_454_10 = var_454_8.childCount

				for iter_454_4 = 0, var_454_10 - 1 do
					local var_454_11 = var_454_8:GetChild(iter_454_4)

					if var_454_11.name == "split_5" then
						var_454_11:SetAsLastSibling()
						var_454_11.gameObject:SetActive(true)

						arg_451_1.var_.actorSpriteSplit10155 = var_454_11.gameObject:GetComponent(typeof(Image))

						arg_451_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_454_12 = 0.5

			if var_454_9 <= arg_451_1.time_ and arg_451_1.time_ < var_454_9 + var_454_12 then
				local var_454_13 = (arg_451_1.time_ - var_454_9) / var_454_12
				local var_454_14 = Vector3.New(-40, -390, -250)

				var_454_8.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos10155, var_454_14, var_454_13)

				if arg_451_1.var_.actorSpriteSplit10155 ~= nil then
					arg_451_1.var_.actorSpriteSplit10155:SetAlpha(var_454_13)
				end
			end

			if arg_451_1.time_ >= var_454_9 + var_454_12 and arg_451_1.time_ < var_454_9 + var_454_12 + arg_454_0 then
				var_454_8.localPosition = Vector3.New(-40, -390, -250)

				if arg_451_1.var_.actorSpriteSplit10155 ~= nil then
					arg_451_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_454_15 = 0
			local var_454_16 = 0.075

			if var_454_15 < arg_451_1.time_ and arg_451_1.time_ <= var_454_15 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_17 = arg_451_1:FormatText(StoryNameCfg[1391].name)

				arg_451_1.leftNameTxt_.text = var_454_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_18 = arg_451_1:GetWordFromCfg(424051111)
				local var_454_19 = arg_451_1:FormatText(var_454_18.content)

				arg_451_1.text_.text = var_454_19

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_20 = 3
				local var_454_21 = utf8.len(var_454_19)
				local var_454_22 = var_454_20 <= 0 and var_454_16 or var_454_16 * (var_454_21 / var_454_20)

				if var_454_22 > 0 and var_454_16 < var_454_22 then
					arg_451_1.talkMaxDuration = var_454_22

					if var_454_22 + var_454_15 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_22 + var_454_15
					end
				end

				arg_451_1.text_.text = var_454_19
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051111", "story_v_out_424051.awb") ~= 0 then
					local var_454_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051111", "story_v_out_424051.awb") / 1000

					if var_454_23 + var_454_15 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_23 + var_454_15
					end

					if var_454_18.prefab_name ~= "" and arg_451_1.actors_[var_454_18.prefab_name] ~= nil then
						local var_454_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_18.prefab_name].transform, "story_v_out_424051", "424051111", "story_v_out_424051.awb")

						arg_451_1:RecordAudio("424051111", var_454_24)
						arg_451_1:RecordAudio("424051111", var_454_24)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_424051", "424051111", "story_v_out_424051.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_424051", "424051111", "story_v_out_424051.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_25 = math.max(var_454_16, arg_451_1.talkMaxDuration)

			if var_454_15 <= arg_451_1.time_ and arg_451_1.time_ < var_454_15 + var_454_25 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_15) / var_454_25

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_15 + var_454_25 and arg_451_1.time_ < var_454_15 + var_454_25 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_451_1:InitPlayNodeList()
	end,
	Play424051112 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 424051112
		arg_455_1.duration_ = 8.73

		local var_455_0 = {
			zh = 8.733,
			ja = 8.033
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play424051113(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = arg_455_1.actors_["10155"]
			local var_458_1 = 0

			if var_458_1 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 and not isNil(var_458_0) and arg_455_1.var_.actorSpriteComps10155 == nil then
				arg_455_1.var_.actorSpriteComps10155 = var_458_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_458_2 = 0.2

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_2 and not isNil(var_458_0) then
				local var_458_3 = (arg_455_1.time_ - var_458_1) / var_458_2

				if arg_455_1.var_.actorSpriteComps10155 then
					for iter_458_0, iter_458_1 in pairs(arg_455_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_458_1 then
							if arg_455_1.isInRecall_ then
								local var_458_4 = Mathf.Lerp(iter_458_1.color.r, arg_455_1.hightColor2.r, var_458_3)
								local var_458_5 = Mathf.Lerp(iter_458_1.color.g, arg_455_1.hightColor2.g, var_458_3)
								local var_458_6 = Mathf.Lerp(iter_458_1.color.b, arg_455_1.hightColor2.b, var_458_3)

								iter_458_1.color = Color.New(var_458_4, var_458_5, var_458_6)
							else
								local var_458_7 = Mathf.Lerp(iter_458_1.color.r, 0.5, var_458_3)

								iter_458_1.color = Color.New(var_458_7, var_458_7, var_458_7)
							end
						end
					end
				end
			end

			if arg_455_1.time_ >= var_458_1 + var_458_2 and arg_455_1.time_ < var_458_1 + var_458_2 + arg_458_0 and not isNil(var_458_0) and arg_455_1.var_.actorSpriteComps10155 then
				for iter_458_2, iter_458_3 in pairs(arg_455_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_458_3 then
						if arg_455_1.isInRecall_ then
							iter_458_3.color = arg_455_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_458_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_455_1.var_.actorSpriteComps10155 = nil
			end

			local var_458_8 = 0
			local var_458_9 = 1.075

			if var_458_8 < arg_455_1.time_ and arg_455_1.time_ <= var_458_8 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_10 = arg_455_1:FormatText(StoryNameCfg[177].name)

				arg_455_1.leftNameTxt_.text = var_458_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, true)
				arg_455_1.iconController_:SetSelectedState("hero")

				arg_455_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_455_1.callingController_:SetSelectedState("normal")

				arg_455_1.keyicon_.color = Color.New(1, 1, 1)
				arg_455_1.icon_.color = Color.New(1, 1, 1)

				local var_458_11 = arg_455_1:GetWordFromCfg(424051112)
				local var_458_12 = arg_455_1:FormatText(var_458_11.content)

				arg_455_1.text_.text = var_458_12

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_13 = 43
				local var_458_14 = utf8.len(var_458_12)
				local var_458_15 = var_458_13 <= 0 and var_458_9 or var_458_9 * (var_458_14 / var_458_13)

				if var_458_15 > 0 and var_458_9 < var_458_15 then
					arg_455_1.talkMaxDuration = var_458_15

					if var_458_15 + var_458_8 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_15 + var_458_8
					end
				end

				arg_455_1.text_.text = var_458_12
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051112", "story_v_out_424051.awb") ~= 0 then
					local var_458_16 = manager.audio:GetVoiceLength("story_v_out_424051", "424051112", "story_v_out_424051.awb") / 1000

					if var_458_16 + var_458_8 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_16 + var_458_8
					end

					if var_458_11.prefab_name ~= "" and arg_455_1.actors_[var_458_11.prefab_name] ~= nil then
						local var_458_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_11.prefab_name].transform, "story_v_out_424051", "424051112", "story_v_out_424051.awb")

						arg_455_1:RecordAudio("424051112", var_458_17)
						arg_455_1:RecordAudio("424051112", var_458_17)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_424051", "424051112", "story_v_out_424051.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_424051", "424051112", "story_v_out_424051.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_18 = math.max(var_458_9, arg_455_1.talkMaxDuration)

			if var_458_8 <= arg_455_1.time_ and arg_455_1.time_ < var_458_8 + var_458_18 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_8) / var_458_18

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_8 + var_458_18 and arg_455_1.time_ < var_458_8 + var_458_18 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play424051113 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 424051113
		arg_459_1.duration_ = 4.7

		local var_459_0 = {
			zh = 1.566,
			ja = 4.7
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play424051114(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = arg_459_1.actors_["10155"]
			local var_462_1 = 0

			if var_462_1 < arg_459_1.time_ and arg_459_1.time_ <= var_462_1 + arg_462_0 and not isNil(var_462_0) and arg_459_1.var_.actorSpriteComps10155 == nil then
				arg_459_1.var_.actorSpriteComps10155 = var_462_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_462_2 = 0.2

			if var_462_1 <= arg_459_1.time_ and arg_459_1.time_ < var_462_1 + var_462_2 and not isNil(var_462_0) then
				local var_462_3 = (arg_459_1.time_ - var_462_1) / var_462_2

				if arg_459_1.var_.actorSpriteComps10155 then
					for iter_462_0, iter_462_1 in pairs(arg_459_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_462_1 then
							if arg_459_1.isInRecall_ then
								local var_462_4 = Mathf.Lerp(iter_462_1.color.r, arg_459_1.hightColor1.r, var_462_3)
								local var_462_5 = Mathf.Lerp(iter_462_1.color.g, arg_459_1.hightColor1.g, var_462_3)
								local var_462_6 = Mathf.Lerp(iter_462_1.color.b, arg_459_1.hightColor1.b, var_462_3)

								iter_462_1.color = Color.New(var_462_4, var_462_5, var_462_6)
							else
								local var_462_7 = Mathf.Lerp(iter_462_1.color.r, 1, var_462_3)

								iter_462_1.color = Color.New(var_462_7, var_462_7, var_462_7)
							end
						end
					end
				end
			end

			if arg_459_1.time_ >= var_462_1 + var_462_2 and arg_459_1.time_ < var_462_1 + var_462_2 + arg_462_0 and not isNil(var_462_0) and arg_459_1.var_.actorSpriteComps10155 then
				for iter_462_2, iter_462_3 in pairs(arg_459_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_462_3 then
						if arg_459_1.isInRecall_ then
							iter_462_3.color = arg_459_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_462_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_459_1.var_.actorSpriteComps10155 = nil
			end

			local var_462_8 = arg_459_1.actors_["10155"].transform
			local var_462_9 = 0

			if var_462_9 < arg_459_1.time_ and arg_459_1.time_ <= var_462_9 + arg_462_0 then
				arg_459_1.var_.moveOldPos10155 = var_462_8.localPosition
				var_462_8.localScale = Vector3.New(1, 1, 1)

				arg_459_1:CheckSpriteTmpPos("10155", 3)

				local var_462_10 = var_462_8.childCount

				for iter_462_4 = 0, var_462_10 - 1 do
					local var_462_11 = var_462_8:GetChild(iter_462_4)

					if var_462_11.name == "split_4" then
						var_462_11:SetAsLastSibling()
						var_462_11.gameObject:SetActive(true)

						arg_459_1.var_.actorSpriteSplit10155 = var_462_11.gameObject:GetComponent(typeof(Image))

						arg_459_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_462_12 = 0.5

			if var_462_9 <= arg_459_1.time_ and arg_459_1.time_ < var_462_9 + var_462_12 then
				local var_462_13 = (arg_459_1.time_ - var_462_9) / var_462_12
				local var_462_14 = Vector3.New(-40, -390, -250)

				var_462_8.localPosition = Vector3.Lerp(arg_459_1.var_.moveOldPos10155, var_462_14, var_462_13)

				if arg_459_1.var_.actorSpriteSplit10155 ~= nil then
					arg_459_1.var_.actorSpriteSplit10155:SetAlpha(var_462_13)
				end
			end

			if arg_459_1.time_ >= var_462_9 + var_462_12 and arg_459_1.time_ < var_462_9 + var_462_12 + arg_462_0 then
				var_462_8.localPosition = Vector3.New(-40, -390, -250)

				if arg_459_1.var_.actorSpriteSplit10155 ~= nil then
					arg_459_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_462_15 = 0
			local var_462_16 = 0.175

			if var_462_15 < arg_459_1.time_ and arg_459_1.time_ <= var_462_15 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				local var_462_17 = arg_459_1:FormatText(StoryNameCfg[1391].name)

				arg_459_1.leftNameTxt_.text = var_462_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_18 = arg_459_1:GetWordFromCfg(424051113)
				local var_462_19 = arg_459_1:FormatText(var_462_18.content)

				arg_459_1.text_.text = var_462_19

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_20 = 7
				local var_462_21 = utf8.len(var_462_19)
				local var_462_22 = var_462_20 <= 0 and var_462_16 or var_462_16 * (var_462_21 / var_462_20)

				if var_462_22 > 0 and var_462_16 < var_462_22 then
					arg_459_1.talkMaxDuration = var_462_22

					if var_462_22 + var_462_15 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_22 + var_462_15
					end
				end

				arg_459_1.text_.text = var_462_19
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051113", "story_v_out_424051.awb") ~= 0 then
					local var_462_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051113", "story_v_out_424051.awb") / 1000

					if var_462_23 + var_462_15 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_23 + var_462_15
					end

					if var_462_18.prefab_name ~= "" and arg_459_1.actors_[var_462_18.prefab_name] ~= nil then
						local var_462_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_18.prefab_name].transform, "story_v_out_424051", "424051113", "story_v_out_424051.awb")

						arg_459_1:RecordAudio("424051113", var_462_24)
						arg_459_1:RecordAudio("424051113", var_462_24)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_424051", "424051113", "story_v_out_424051.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_424051", "424051113", "story_v_out_424051.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_25 = math.max(var_462_16, arg_459_1.talkMaxDuration)

			if var_462_15 <= arg_459_1.time_ and arg_459_1.time_ < var_462_15 + var_462_25 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_15) / var_462_25

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_15 + var_462_25 and arg_459_1.time_ < var_462_15 + var_462_25 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_459_1:InitPlayNodeList()
	end,
	Play424051114 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 424051114
		arg_463_1.duration_ = 6

		local var_463_0 = {
			zh = 4.166,
			ja = 6
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play424051115(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = arg_463_1.actors_["1094"]
			local var_466_1 = 0

			if var_466_1 < arg_463_1.time_ and arg_463_1.time_ <= var_466_1 + arg_466_0 and not isNil(var_466_0) and arg_463_1.var_.actorSpriteComps1094 == nil then
				arg_463_1.var_.actorSpriteComps1094 = var_466_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_466_2 = 0.2

			if var_466_1 <= arg_463_1.time_ and arg_463_1.time_ < var_466_1 + var_466_2 and not isNil(var_466_0) then
				local var_466_3 = (arg_463_1.time_ - var_466_1) / var_466_2

				if arg_463_1.var_.actorSpriteComps1094 then
					for iter_466_0, iter_466_1 in pairs(arg_463_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_466_1 then
							if arg_463_1.isInRecall_ then
								local var_466_4 = Mathf.Lerp(iter_466_1.color.r, arg_463_1.hightColor1.r, var_466_3)
								local var_466_5 = Mathf.Lerp(iter_466_1.color.g, arg_463_1.hightColor1.g, var_466_3)
								local var_466_6 = Mathf.Lerp(iter_466_1.color.b, arg_463_1.hightColor1.b, var_466_3)

								iter_466_1.color = Color.New(var_466_4, var_466_5, var_466_6)
							else
								local var_466_7 = Mathf.Lerp(iter_466_1.color.r, 1, var_466_3)

								iter_466_1.color = Color.New(var_466_7, var_466_7, var_466_7)
							end
						end
					end
				end
			end

			if arg_463_1.time_ >= var_466_1 + var_466_2 and arg_463_1.time_ < var_466_1 + var_466_2 + arg_466_0 and not isNil(var_466_0) and arg_463_1.var_.actorSpriteComps1094 then
				for iter_466_2, iter_466_3 in pairs(arg_463_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_466_3 then
						if arg_463_1.isInRecall_ then
							iter_466_3.color = arg_463_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_466_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_463_1.var_.actorSpriteComps1094 = nil
			end

			local var_466_8 = arg_463_1.actors_["10155"]
			local var_466_9 = 0

			if var_466_9 < arg_463_1.time_ and arg_463_1.time_ <= var_466_9 + arg_466_0 and not isNil(var_466_8) and arg_463_1.var_.actorSpriteComps10155 == nil then
				arg_463_1.var_.actorSpriteComps10155 = var_466_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_466_10 = 0.2

			if var_466_9 <= arg_463_1.time_ and arg_463_1.time_ < var_466_9 + var_466_10 and not isNil(var_466_8) then
				local var_466_11 = (arg_463_1.time_ - var_466_9) / var_466_10

				if arg_463_1.var_.actorSpriteComps10155 then
					for iter_466_4, iter_466_5 in pairs(arg_463_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_466_5 then
							if arg_463_1.isInRecall_ then
								local var_466_12 = Mathf.Lerp(iter_466_5.color.r, arg_463_1.hightColor2.r, var_466_11)
								local var_466_13 = Mathf.Lerp(iter_466_5.color.g, arg_463_1.hightColor2.g, var_466_11)
								local var_466_14 = Mathf.Lerp(iter_466_5.color.b, arg_463_1.hightColor2.b, var_466_11)

								iter_466_5.color = Color.New(var_466_12, var_466_13, var_466_14)
							else
								local var_466_15 = Mathf.Lerp(iter_466_5.color.r, 0.5, var_466_11)

								iter_466_5.color = Color.New(var_466_15, var_466_15, var_466_15)
							end
						end
					end
				end
			end

			if arg_463_1.time_ >= var_466_9 + var_466_10 and arg_463_1.time_ < var_466_9 + var_466_10 + arg_466_0 and not isNil(var_466_8) and arg_463_1.var_.actorSpriteComps10155 then
				for iter_466_6, iter_466_7 in pairs(arg_463_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_466_7 then
						if arg_463_1.isInRecall_ then
							iter_466_7.color = arg_463_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_466_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_463_1.var_.actorSpriteComps10155 = nil
			end

			local var_466_16 = arg_463_1.actors_["1094"].transform
			local var_466_17 = 0

			if var_466_17 < arg_463_1.time_ and arg_463_1.time_ <= var_466_17 + arg_466_0 then
				arg_463_1.var_.moveOldPos1094 = var_466_16.localPosition
				var_466_16.localScale = Vector3.New(1, 1, 1)

				arg_463_1:CheckSpriteTmpPos("1094", 4)

				local var_466_18 = var_466_16.childCount

				for iter_466_8 = 0, var_466_18 - 1 do
					local var_466_19 = var_466_16:GetChild(iter_466_8)

					if var_466_19.name == "split_1" or not string.find(var_466_19.name, "split") then
						var_466_19.gameObject:SetActive(true)
					else
						var_466_19.gameObject:SetActive(false)
					end
				end
			end

			local var_466_20 = 0.001

			if var_466_17 <= arg_463_1.time_ and arg_463_1.time_ < var_466_17 + var_466_20 then
				local var_466_21 = (arg_463_1.time_ - var_466_17) / var_466_20
				local var_466_22 = Vector3.New(470, -335, -230)

				var_466_16.localPosition = Vector3.Lerp(arg_463_1.var_.moveOldPos1094, var_466_22, var_466_21)
			end

			if arg_463_1.time_ >= var_466_17 + var_466_20 and arg_463_1.time_ < var_466_17 + var_466_20 + arg_466_0 then
				var_466_16.localPosition = Vector3.New(470, -335, -230)
			end

			local var_466_23 = arg_463_1.actors_["10155"].transform
			local var_466_24 = 0

			if var_466_24 < arg_463_1.time_ and arg_463_1.time_ <= var_466_24 + arg_466_0 then
				arg_463_1.var_.moveOldPos10155 = var_466_23.localPosition
				var_466_23.localScale = Vector3.New(1, 1, 1)

				arg_463_1:CheckSpriteTmpPos("10155", 2)

				local var_466_25 = var_466_23.childCount

				for iter_466_9 = 0, var_466_25 - 1 do
					local var_466_26 = var_466_23:GetChild(iter_466_9)

					if var_466_26.name == "split_4" or not string.find(var_466_26.name, "split") then
						var_466_26.gameObject:SetActive(true)
					else
						var_466_26.gameObject:SetActive(false)
					end
				end
			end

			local var_466_27 = 0.001

			if var_466_24 <= arg_463_1.time_ and arg_463_1.time_ < var_466_24 + var_466_27 then
				local var_466_28 = (arg_463_1.time_ - var_466_24) / var_466_27
				local var_466_29 = Vector3.New(-410, -390, -250)

				var_466_23.localPosition = Vector3.Lerp(arg_463_1.var_.moveOldPos10155, var_466_29, var_466_28)
			end

			if arg_463_1.time_ >= var_466_24 + var_466_27 and arg_463_1.time_ < var_466_24 + var_466_27 + arg_466_0 then
				var_466_23.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_466_30 = 0
			local var_466_31 = 0.4

			if var_466_30 < arg_463_1.time_ and arg_463_1.time_ <= var_466_30 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_32 = arg_463_1:FormatText(StoryNameCfg[181].name)

				arg_463_1.leftNameTxt_.text = var_466_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_33 = arg_463_1:GetWordFromCfg(424051114)
				local var_466_34 = arg_463_1:FormatText(var_466_33.content)

				arg_463_1.text_.text = var_466_34

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_35 = 16
				local var_466_36 = utf8.len(var_466_34)
				local var_466_37 = var_466_35 <= 0 and var_466_31 or var_466_31 * (var_466_36 / var_466_35)

				if var_466_37 > 0 and var_466_31 < var_466_37 then
					arg_463_1.talkMaxDuration = var_466_37

					if var_466_37 + var_466_30 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_37 + var_466_30
					end
				end

				arg_463_1.text_.text = var_466_34
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051114", "story_v_out_424051.awb") ~= 0 then
					local var_466_38 = manager.audio:GetVoiceLength("story_v_out_424051", "424051114", "story_v_out_424051.awb") / 1000

					if var_466_38 + var_466_30 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_38 + var_466_30
					end

					if var_466_33.prefab_name ~= "" and arg_463_1.actors_[var_466_33.prefab_name] ~= nil then
						local var_466_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_33.prefab_name].transform, "story_v_out_424051", "424051114", "story_v_out_424051.awb")

						arg_463_1:RecordAudio("424051114", var_466_39)
						arg_463_1:RecordAudio("424051114", var_466_39)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_424051", "424051114", "story_v_out_424051.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_424051", "424051114", "story_v_out_424051.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_40 = math.max(var_466_31, arg_463_1.talkMaxDuration)

			if var_466_30 <= arg_463_1.time_ and arg_463_1.time_ < var_466_30 + var_466_40 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_30) / var_466_40

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_30 + var_466_40 and arg_463_1.time_ < var_466_30 + var_466_40 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {
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

		arg_463_1:InitPlayNodeList()
	end,
	Play424051115 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 424051115
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play424051116(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = arg_467_1.actors_["1094"]
			local var_470_1 = 0

			if var_470_1 < arg_467_1.time_ and arg_467_1.time_ <= var_470_1 + arg_470_0 and not isNil(var_470_0) and arg_467_1.var_.actorSpriteComps1094 == nil then
				arg_467_1.var_.actorSpriteComps1094 = var_470_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_470_2 = 0.2

			if var_470_1 <= arg_467_1.time_ and arg_467_1.time_ < var_470_1 + var_470_2 and not isNil(var_470_0) then
				local var_470_3 = (arg_467_1.time_ - var_470_1) / var_470_2

				if arg_467_1.var_.actorSpriteComps1094 then
					for iter_470_0, iter_470_1 in pairs(arg_467_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_470_1 then
							if arg_467_1.isInRecall_ then
								local var_470_4 = Mathf.Lerp(iter_470_1.color.r, arg_467_1.hightColor2.r, var_470_3)
								local var_470_5 = Mathf.Lerp(iter_470_1.color.g, arg_467_1.hightColor2.g, var_470_3)
								local var_470_6 = Mathf.Lerp(iter_470_1.color.b, arg_467_1.hightColor2.b, var_470_3)

								iter_470_1.color = Color.New(var_470_4, var_470_5, var_470_6)
							else
								local var_470_7 = Mathf.Lerp(iter_470_1.color.r, 0.5, var_470_3)

								iter_470_1.color = Color.New(var_470_7, var_470_7, var_470_7)
							end
						end
					end
				end
			end

			if arg_467_1.time_ >= var_470_1 + var_470_2 and arg_467_1.time_ < var_470_1 + var_470_2 + arg_470_0 and not isNil(var_470_0) and arg_467_1.var_.actorSpriteComps1094 then
				for iter_470_2, iter_470_3 in pairs(arg_467_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_470_3 then
						if arg_467_1.isInRecall_ then
							iter_470_3.color = arg_467_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_470_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_467_1.var_.actorSpriteComps1094 = nil
			end

			local var_470_8 = 0
			local var_470_9 = 0.575

			if var_470_8 < arg_467_1.time_ and arg_467_1.time_ <= var_470_8 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, false)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_10 = arg_467_1:GetWordFromCfg(424051115)
				local var_470_11 = arg_467_1:FormatText(var_470_10.content)

				arg_467_1.text_.text = var_470_11

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_12 = 23
				local var_470_13 = utf8.len(var_470_11)
				local var_470_14 = var_470_12 <= 0 and var_470_9 or var_470_9 * (var_470_13 / var_470_12)

				if var_470_14 > 0 and var_470_9 < var_470_14 then
					arg_467_1.talkMaxDuration = var_470_14

					if var_470_14 + var_470_8 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_14 + var_470_8
					end
				end

				arg_467_1.text_.text = var_470_11
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_15 = math.max(var_470_9, arg_467_1.talkMaxDuration)

			if var_470_8 <= arg_467_1.time_ and arg_467_1.time_ < var_470_8 + var_470_15 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_8) / var_470_15

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_8 + var_470_15 and arg_467_1.time_ < var_470_8 + var_470_15 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play424051116 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 424051116
		arg_471_1.duration_ = 9.13

		local var_471_0 = {
			zh = 5.966,
			ja = 9.133
		}
		local var_471_1 = manager.audio:GetLocalizationFlag()

		if var_471_0[var_471_1] ~= nil then
			arg_471_1.duration_ = var_471_0[var_471_1]
		end

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play424051117(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = arg_471_1.actors_["10155"]
			local var_474_1 = 0

			if var_474_1 < arg_471_1.time_ and arg_471_1.time_ <= var_474_1 + arg_474_0 and not isNil(var_474_0) and arg_471_1.var_.actorSpriteComps10155 == nil then
				arg_471_1.var_.actorSpriteComps10155 = var_474_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_474_2 = 0.2

			if var_474_1 <= arg_471_1.time_ and arg_471_1.time_ < var_474_1 + var_474_2 and not isNil(var_474_0) then
				local var_474_3 = (arg_471_1.time_ - var_474_1) / var_474_2

				if arg_471_1.var_.actorSpriteComps10155 then
					for iter_474_0, iter_474_1 in pairs(arg_471_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_474_1 then
							if arg_471_1.isInRecall_ then
								local var_474_4 = Mathf.Lerp(iter_474_1.color.r, arg_471_1.hightColor1.r, var_474_3)
								local var_474_5 = Mathf.Lerp(iter_474_1.color.g, arg_471_1.hightColor1.g, var_474_3)
								local var_474_6 = Mathf.Lerp(iter_474_1.color.b, arg_471_1.hightColor1.b, var_474_3)

								iter_474_1.color = Color.New(var_474_4, var_474_5, var_474_6)
							else
								local var_474_7 = Mathf.Lerp(iter_474_1.color.r, 1, var_474_3)

								iter_474_1.color = Color.New(var_474_7, var_474_7, var_474_7)
							end
						end
					end
				end
			end

			if arg_471_1.time_ >= var_474_1 + var_474_2 and arg_471_1.time_ < var_474_1 + var_474_2 + arg_474_0 and not isNil(var_474_0) and arg_471_1.var_.actorSpriteComps10155 then
				for iter_474_2, iter_474_3 in pairs(arg_471_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_474_3 then
						if arg_471_1.isInRecall_ then
							iter_474_3.color = arg_471_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_474_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_471_1.var_.actorSpriteComps10155 = nil
			end

			local var_474_8 = arg_471_1.actors_["10155"].transform
			local var_474_9 = 0

			if var_474_9 < arg_471_1.time_ and arg_471_1.time_ <= var_474_9 + arg_474_0 then
				arg_471_1.var_.moveOldPos10155 = var_474_8.localPosition
				var_474_8.localScale = Vector3.New(1, 1, 1)

				arg_471_1:CheckSpriteTmpPos("10155", 2)

				local var_474_10 = var_474_8.childCount

				for iter_474_4 = 0, var_474_10 - 1 do
					local var_474_11 = var_474_8:GetChild(iter_474_4)

					if var_474_11.name == "split_1" then
						var_474_11:SetAsLastSibling()
						var_474_11.gameObject:SetActive(true)

						arg_471_1.var_.actorSpriteSplit10155 = var_474_11.gameObject:GetComponent(typeof(Image))

						arg_471_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_474_12 = 0.5

			if var_474_9 <= arg_471_1.time_ and arg_471_1.time_ < var_474_9 + var_474_12 then
				local var_474_13 = (arg_471_1.time_ - var_474_9) / var_474_12
				local var_474_14 = Vector3.New(-410, -390, -250)

				var_474_8.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos10155, var_474_14, var_474_13)

				if arg_471_1.var_.actorSpriteSplit10155 ~= nil then
					arg_471_1.var_.actorSpriteSplit10155:SetAlpha(var_474_13)
				end
			end

			if arg_471_1.time_ >= var_474_9 + var_474_12 and arg_471_1.time_ < var_474_9 + var_474_12 + arg_474_0 then
				var_474_8.localPosition = Vector3.New(-410, -390, -250)

				if arg_471_1.var_.actorSpriteSplit10155 ~= nil then
					arg_471_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_474_15 = 0
			local var_474_16 = 0.625

			if var_474_15 < arg_471_1.time_ and arg_471_1.time_ <= var_474_15 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				local var_474_17 = arg_471_1:FormatText(StoryNameCfg[1391].name)

				arg_471_1.leftNameTxt_.text = var_474_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_18 = arg_471_1:GetWordFromCfg(424051116)
				local var_474_19 = arg_471_1:FormatText(var_474_18.content)

				arg_471_1.text_.text = var_474_19

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_20 = 25
				local var_474_21 = utf8.len(var_474_19)
				local var_474_22 = var_474_20 <= 0 and var_474_16 or var_474_16 * (var_474_21 / var_474_20)

				if var_474_22 > 0 and var_474_16 < var_474_22 then
					arg_471_1.talkMaxDuration = var_474_22

					if var_474_22 + var_474_15 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_22 + var_474_15
					end
				end

				arg_471_1.text_.text = var_474_19
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051116", "story_v_out_424051.awb") ~= 0 then
					local var_474_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051116", "story_v_out_424051.awb") / 1000

					if var_474_23 + var_474_15 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_23 + var_474_15
					end

					if var_474_18.prefab_name ~= "" and arg_471_1.actors_[var_474_18.prefab_name] ~= nil then
						local var_474_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_18.prefab_name].transform, "story_v_out_424051", "424051116", "story_v_out_424051.awb")

						arg_471_1:RecordAudio("424051116", var_474_24)
						arg_471_1:RecordAudio("424051116", var_474_24)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_424051", "424051116", "story_v_out_424051.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_424051", "424051116", "story_v_out_424051.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_25 = math.max(var_474_16, arg_471_1.talkMaxDuration)

			if var_474_15 <= arg_471_1.time_ and arg_471_1.time_ < var_474_15 + var_474_25 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_15) / var_474_25

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_15 + var_474_25 and arg_471_1.time_ < var_474_15 + var_474_25 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_471_1:InitPlayNodeList()
	end,
	Play424051117 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 424051117
		arg_475_1.duration_ = 2.13

		local var_475_0 = {
			zh = 1.766,
			ja = 2.133
		}
		local var_475_1 = manager.audio:GetLocalizationFlag()

		if var_475_0[var_475_1] ~= nil then
			arg_475_1.duration_ = var_475_0[var_475_1]
		end

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play424051118(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = arg_475_1.actors_["1094"]
			local var_478_1 = 0

			if var_478_1 < arg_475_1.time_ and arg_475_1.time_ <= var_478_1 + arg_478_0 and not isNil(var_478_0) and arg_475_1.var_.actorSpriteComps1094 == nil then
				arg_475_1.var_.actorSpriteComps1094 = var_478_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_478_2 = 0.2

			if var_478_1 <= arg_475_1.time_ and arg_475_1.time_ < var_478_1 + var_478_2 and not isNil(var_478_0) then
				local var_478_3 = (arg_475_1.time_ - var_478_1) / var_478_2

				if arg_475_1.var_.actorSpriteComps1094 then
					for iter_478_0, iter_478_1 in pairs(arg_475_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_478_1 then
							if arg_475_1.isInRecall_ then
								local var_478_4 = Mathf.Lerp(iter_478_1.color.r, arg_475_1.hightColor1.r, var_478_3)
								local var_478_5 = Mathf.Lerp(iter_478_1.color.g, arg_475_1.hightColor1.g, var_478_3)
								local var_478_6 = Mathf.Lerp(iter_478_1.color.b, arg_475_1.hightColor1.b, var_478_3)

								iter_478_1.color = Color.New(var_478_4, var_478_5, var_478_6)
							else
								local var_478_7 = Mathf.Lerp(iter_478_1.color.r, 1, var_478_3)

								iter_478_1.color = Color.New(var_478_7, var_478_7, var_478_7)
							end
						end
					end
				end
			end

			if arg_475_1.time_ >= var_478_1 + var_478_2 and arg_475_1.time_ < var_478_1 + var_478_2 + arg_478_0 and not isNil(var_478_0) and arg_475_1.var_.actorSpriteComps1094 then
				for iter_478_2, iter_478_3 in pairs(arg_475_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_478_3 then
						if arg_475_1.isInRecall_ then
							iter_478_3.color = arg_475_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_478_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_475_1.var_.actorSpriteComps1094 = nil
			end

			local var_478_8 = arg_475_1.actors_["10155"]
			local var_478_9 = 0

			if var_478_9 < arg_475_1.time_ and arg_475_1.time_ <= var_478_9 + arg_478_0 and not isNil(var_478_8) and arg_475_1.var_.actorSpriteComps10155 == nil then
				arg_475_1.var_.actorSpriteComps10155 = var_478_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_478_10 = 0.2

			if var_478_9 <= arg_475_1.time_ and arg_475_1.time_ < var_478_9 + var_478_10 and not isNil(var_478_8) then
				local var_478_11 = (arg_475_1.time_ - var_478_9) / var_478_10

				if arg_475_1.var_.actorSpriteComps10155 then
					for iter_478_4, iter_478_5 in pairs(arg_475_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_478_5 then
							if arg_475_1.isInRecall_ then
								local var_478_12 = Mathf.Lerp(iter_478_5.color.r, arg_475_1.hightColor2.r, var_478_11)
								local var_478_13 = Mathf.Lerp(iter_478_5.color.g, arg_475_1.hightColor2.g, var_478_11)
								local var_478_14 = Mathf.Lerp(iter_478_5.color.b, arg_475_1.hightColor2.b, var_478_11)

								iter_478_5.color = Color.New(var_478_12, var_478_13, var_478_14)
							else
								local var_478_15 = Mathf.Lerp(iter_478_5.color.r, 0.5, var_478_11)

								iter_478_5.color = Color.New(var_478_15, var_478_15, var_478_15)
							end
						end
					end
				end
			end

			if arg_475_1.time_ >= var_478_9 + var_478_10 and arg_475_1.time_ < var_478_9 + var_478_10 + arg_478_0 and not isNil(var_478_8) and arg_475_1.var_.actorSpriteComps10155 then
				for iter_478_6, iter_478_7 in pairs(arg_475_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_478_7 then
						if arg_475_1.isInRecall_ then
							iter_478_7.color = arg_475_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_478_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_475_1.var_.actorSpriteComps10155 = nil
			end

			local var_478_16 = arg_475_1.actors_["1094"].transform
			local var_478_17 = 0

			if var_478_17 < arg_475_1.time_ and arg_475_1.time_ <= var_478_17 + arg_478_0 then
				arg_475_1.var_.moveOldPos1094 = var_478_16.localPosition
				var_478_16.localScale = Vector3.New(1, 1, 1)

				arg_475_1:CheckSpriteTmpPos("1094", 4)

				local var_478_18 = var_478_16.childCount

				for iter_478_8 = 0, var_478_18 - 1 do
					local var_478_19 = var_478_16:GetChild(iter_478_8)

					if var_478_19.name == "" or not string.find(var_478_19.name, "split") then
						var_478_19.gameObject:SetActive(true)
					else
						var_478_19.gameObject:SetActive(false)
					end
				end
			end

			local var_478_20 = 0.001

			if var_478_17 <= arg_475_1.time_ and arg_475_1.time_ < var_478_17 + var_478_20 then
				local var_478_21 = (arg_475_1.time_ - var_478_17) / var_478_20
				local var_478_22 = Vector3.New(470, -335, -230)

				var_478_16.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos1094, var_478_22, var_478_21)
			end

			if arg_475_1.time_ >= var_478_17 + var_478_20 and arg_475_1.time_ < var_478_17 + var_478_20 + arg_478_0 then
				var_478_16.localPosition = Vector3.New(470, -335, -230)
			end

			local var_478_23 = 0
			local var_478_24 = 0.2

			if var_478_23 < arg_475_1.time_ and arg_475_1.time_ <= var_478_23 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				local var_478_25 = arg_475_1:FormatText(StoryNameCfg[181].name)

				arg_475_1.leftNameTxt_.text = var_478_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_26 = arg_475_1:GetWordFromCfg(424051117)
				local var_478_27 = arg_475_1:FormatText(var_478_26.content)

				arg_475_1.text_.text = var_478_27

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_28 = 8
				local var_478_29 = utf8.len(var_478_27)
				local var_478_30 = var_478_28 <= 0 and var_478_24 or var_478_24 * (var_478_29 / var_478_28)

				if var_478_30 > 0 and var_478_24 < var_478_30 then
					arg_475_1.talkMaxDuration = var_478_30

					if var_478_30 + var_478_23 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_30 + var_478_23
					end
				end

				arg_475_1.text_.text = var_478_27
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051117", "story_v_out_424051.awb") ~= 0 then
					local var_478_31 = manager.audio:GetVoiceLength("story_v_out_424051", "424051117", "story_v_out_424051.awb") / 1000

					if var_478_31 + var_478_23 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_31 + var_478_23
					end

					if var_478_26.prefab_name ~= "" and arg_475_1.actors_[var_478_26.prefab_name] ~= nil then
						local var_478_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_26.prefab_name].transform, "story_v_out_424051", "424051117", "story_v_out_424051.awb")

						arg_475_1:RecordAudio("424051117", var_478_32)
						arg_475_1:RecordAudio("424051117", var_478_32)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_424051", "424051117", "story_v_out_424051.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_424051", "424051117", "story_v_out_424051.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_33 = math.max(var_478_24, arg_475_1.talkMaxDuration)

			if var_478_23 <= arg_475_1.time_ and arg_475_1.time_ < var_478_23 + var_478_33 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_23) / var_478_33

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_23 + var_478_33 and arg_475_1.time_ < var_478_23 + var_478_33 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {
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

		arg_475_1:InitPlayNodeList()
	end,
	Play424051118 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 424051118
		arg_479_1.duration_ = 8.97

		local var_479_0 = {
			zh = 4.4,
			ja = 8.966
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play424051119(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = arg_479_1.actors_["10155"]
			local var_482_1 = 0

			if var_482_1 < arg_479_1.time_ and arg_479_1.time_ <= var_482_1 + arg_482_0 and not isNil(var_482_0) and arg_479_1.var_.actorSpriteComps10155 == nil then
				arg_479_1.var_.actorSpriteComps10155 = var_482_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_482_2 = 0.2

			if var_482_1 <= arg_479_1.time_ and arg_479_1.time_ < var_482_1 + var_482_2 and not isNil(var_482_0) then
				local var_482_3 = (arg_479_1.time_ - var_482_1) / var_482_2

				if arg_479_1.var_.actorSpriteComps10155 then
					for iter_482_0, iter_482_1 in pairs(arg_479_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_482_1 then
							if arg_479_1.isInRecall_ then
								local var_482_4 = Mathf.Lerp(iter_482_1.color.r, arg_479_1.hightColor1.r, var_482_3)
								local var_482_5 = Mathf.Lerp(iter_482_1.color.g, arg_479_1.hightColor1.g, var_482_3)
								local var_482_6 = Mathf.Lerp(iter_482_1.color.b, arg_479_1.hightColor1.b, var_482_3)

								iter_482_1.color = Color.New(var_482_4, var_482_5, var_482_6)
							else
								local var_482_7 = Mathf.Lerp(iter_482_1.color.r, 1, var_482_3)

								iter_482_1.color = Color.New(var_482_7, var_482_7, var_482_7)
							end
						end
					end
				end
			end

			if arg_479_1.time_ >= var_482_1 + var_482_2 and arg_479_1.time_ < var_482_1 + var_482_2 + arg_482_0 and not isNil(var_482_0) and arg_479_1.var_.actorSpriteComps10155 then
				for iter_482_2, iter_482_3 in pairs(arg_479_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_482_3 then
						if arg_479_1.isInRecall_ then
							iter_482_3.color = arg_479_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_482_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_479_1.var_.actorSpriteComps10155 = nil
			end

			local var_482_8 = arg_479_1.actors_["1094"]
			local var_482_9 = 0

			if var_482_9 < arg_479_1.time_ and arg_479_1.time_ <= var_482_9 + arg_482_0 and not isNil(var_482_8) and arg_479_1.var_.actorSpriteComps1094 == nil then
				arg_479_1.var_.actorSpriteComps1094 = var_482_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_482_10 = 0.2

			if var_482_9 <= arg_479_1.time_ and arg_479_1.time_ < var_482_9 + var_482_10 and not isNil(var_482_8) then
				local var_482_11 = (arg_479_1.time_ - var_482_9) / var_482_10

				if arg_479_1.var_.actorSpriteComps1094 then
					for iter_482_4, iter_482_5 in pairs(arg_479_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_482_5 then
							if arg_479_1.isInRecall_ then
								local var_482_12 = Mathf.Lerp(iter_482_5.color.r, arg_479_1.hightColor2.r, var_482_11)
								local var_482_13 = Mathf.Lerp(iter_482_5.color.g, arg_479_1.hightColor2.g, var_482_11)
								local var_482_14 = Mathf.Lerp(iter_482_5.color.b, arg_479_1.hightColor2.b, var_482_11)

								iter_482_5.color = Color.New(var_482_12, var_482_13, var_482_14)
							else
								local var_482_15 = Mathf.Lerp(iter_482_5.color.r, 0.5, var_482_11)

								iter_482_5.color = Color.New(var_482_15, var_482_15, var_482_15)
							end
						end
					end
				end
			end

			if arg_479_1.time_ >= var_482_9 + var_482_10 and arg_479_1.time_ < var_482_9 + var_482_10 + arg_482_0 and not isNil(var_482_8) and arg_479_1.var_.actorSpriteComps1094 then
				for iter_482_6, iter_482_7 in pairs(arg_479_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_482_7 then
						if arg_479_1.isInRecall_ then
							iter_482_7.color = arg_479_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_482_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_479_1.var_.actorSpriteComps1094 = nil
			end

			local var_482_16 = arg_479_1.actors_["10155"].transform
			local var_482_17 = 0

			if var_482_17 < arg_479_1.time_ and arg_479_1.time_ <= var_482_17 + arg_482_0 then
				arg_479_1.var_.moveOldPos10155 = var_482_16.localPosition
				var_482_16.localScale = Vector3.New(1, 1, 1)

				arg_479_1:CheckSpriteTmpPos("10155", 2)

				local var_482_18 = var_482_16.childCount

				for iter_482_8 = 0, var_482_18 - 1 do
					local var_482_19 = var_482_16:GetChild(iter_482_8)

					if var_482_19.name == "split_1" or not string.find(var_482_19.name, "split") then
						var_482_19.gameObject:SetActive(true)
					else
						var_482_19.gameObject:SetActive(false)
					end
				end
			end

			local var_482_20 = 0.001

			if var_482_17 <= arg_479_1.time_ and arg_479_1.time_ < var_482_17 + var_482_20 then
				local var_482_21 = (arg_479_1.time_ - var_482_17) / var_482_20
				local var_482_22 = Vector3.New(-410, -390, -250)

				var_482_16.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPos10155, var_482_22, var_482_21)
			end

			if arg_479_1.time_ >= var_482_17 + var_482_20 and arg_479_1.time_ < var_482_17 + var_482_20 + arg_482_0 then
				var_482_16.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_482_23 = 0
			local var_482_24 = 0.575

			if var_482_23 < arg_479_1.time_ and arg_479_1.time_ <= var_482_23 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				local var_482_25 = arg_479_1:FormatText(StoryNameCfg[1391].name)

				arg_479_1.leftNameTxt_.text = var_482_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_26 = arg_479_1:GetWordFromCfg(424051118)
				local var_482_27 = arg_479_1:FormatText(var_482_26.content)

				arg_479_1.text_.text = var_482_27

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_28 = 18
				local var_482_29 = utf8.len(var_482_27)
				local var_482_30 = var_482_28 <= 0 and var_482_24 or var_482_24 * (var_482_29 / var_482_28)

				if var_482_30 > 0 and var_482_24 < var_482_30 then
					arg_479_1.talkMaxDuration = var_482_30

					if var_482_30 + var_482_23 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_30 + var_482_23
					end
				end

				arg_479_1.text_.text = var_482_27
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051118", "story_v_out_424051.awb") ~= 0 then
					local var_482_31 = manager.audio:GetVoiceLength("story_v_out_424051", "424051118", "story_v_out_424051.awb") / 1000

					if var_482_31 + var_482_23 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_31 + var_482_23
					end

					if var_482_26.prefab_name ~= "" and arg_479_1.actors_[var_482_26.prefab_name] ~= nil then
						local var_482_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_26.prefab_name].transform, "story_v_out_424051", "424051118", "story_v_out_424051.awb")

						arg_479_1:RecordAudio("424051118", var_482_32)
						arg_479_1:RecordAudio("424051118", var_482_32)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_424051", "424051118", "story_v_out_424051.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_424051", "424051118", "story_v_out_424051.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_33 = math.max(var_482_24, arg_479_1.talkMaxDuration)

			if var_482_23 <= arg_479_1.time_ and arg_479_1.time_ < var_482_23 + var_482_33 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_23) / var_482_33

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_23 + var_482_33 and arg_479_1.time_ < var_482_23 + var_482_33 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {
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

		arg_479_1:InitPlayNodeList()
	end,
	Play424051119 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 424051119
		arg_483_1.duration_ = 12.47

		local var_483_0 = {
			zh = 6.366,
			ja = 12.466
		}
		local var_483_1 = manager.audio:GetLocalizationFlag()

		if var_483_0[var_483_1] ~= nil then
			arg_483_1.duration_ = var_483_0[var_483_1]
		end

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play424051120(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0
			local var_486_1 = 0.7

			if var_486_0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				local var_486_2 = arg_483_1:FormatText(StoryNameCfg[1391].name)

				arg_483_1.leftNameTxt_.text = var_486_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_3 = arg_483_1:GetWordFromCfg(424051119)
				local var_486_4 = arg_483_1:FormatText(var_486_3.content)

				arg_483_1.text_.text = var_486_4

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_5 = 28
				local var_486_6 = utf8.len(var_486_4)
				local var_486_7 = var_486_5 <= 0 and var_486_1 or var_486_1 * (var_486_6 / var_486_5)

				if var_486_7 > 0 and var_486_1 < var_486_7 then
					arg_483_1.talkMaxDuration = var_486_7

					if var_486_7 + var_486_0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_7 + var_486_0
					end
				end

				arg_483_1.text_.text = var_486_4
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051119", "story_v_out_424051.awb") ~= 0 then
					local var_486_8 = manager.audio:GetVoiceLength("story_v_out_424051", "424051119", "story_v_out_424051.awb") / 1000

					if var_486_8 + var_486_0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_8 + var_486_0
					end

					if var_486_3.prefab_name ~= "" and arg_483_1.actors_[var_486_3.prefab_name] ~= nil then
						local var_486_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_3.prefab_name].transform, "story_v_out_424051", "424051119", "story_v_out_424051.awb")

						arg_483_1:RecordAudio("424051119", var_486_9)
						arg_483_1:RecordAudio("424051119", var_486_9)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_424051", "424051119", "story_v_out_424051.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_424051", "424051119", "story_v_out_424051.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_10 = math.max(var_486_1, arg_483_1.talkMaxDuration)

			if var_486_0 <= arg_483_1.time_ and arg_483_1.time_ < var_486_0 + var_486_10 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_0) / var_486_10

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_0 + var_486_10 and arg_483_1.time_ < var_486_0 + var_486_10 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play424051120 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 424051120
		arg_487_1.duration_ = 1.7

		local var_487_0 = {
			zh = 1.466,
			ja = 1.7
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play424051121(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = arg_487_1.actors_["10155"].transform
			local var_490_1 = 0

			if var_490_1 < arg_487_1.time_ and arg_487_1.time_ <= var_490_1 + arg_490_0 then
				arg_487_1.var_.moveOldPos10155 = var_490_0.localPosition
				var_490_0.localScale = Vector3.New(1, 1, 1)

				arg_487_1:CheckSpriteTmpPos("10155", 2)

				local var_490_2 = var_490_0.childCount

				for iter_490_0 = 0, var_490_2 - 1 do
					local var_490_3 = var_490_0:GetChild(iter_490_0)

					if var_490_3.name == "split_1" or not string.find(var_490_3.name, "split") then
						var_490_3.gameObject:SetActive(true)
					else
						var_490_3.gameObject:SetActive(false)
					end
				end
			end

			local var_490_4 = 0.001

			if var_490_1 <= arg_487_1.time_ and arg_487_1.time_ < var_490_1 + var_490_4 then
				local var_490_5 = (arg_487_1.time_ - var_490_1) / var_490_4
				local var_490_6 = Vector3.New(-410, -390, -250)

				var_490_0.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos10155, var_490_6, var_490_5)
			end

			if arg_487_1.time_ >= var_490_1 + var_490_4 and arg_487_1.time_ < var_490_1 + var_490_4 + arg_490_0 then
				var_490_0.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_490_7 = 0
			local var_490_8 = 0.175

			if var_490_7 < arg_487_1.time_ and arg_487_1.time_ <= var_490_7 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				local var_490_9 = arg_487_1:FormatText(StoryNameCfg[1391].name)

				arg_487_1.leftNameTxt_.text = var_490_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_10 = arg_487_1:GetWordFromCfg(424051120)
				local var_490_11 = arg_487_1:FormatText(var_490_10.content)

				arg_487_1.text_.text = var_490_11

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_12 = 7
				local var_490_13 = utf8.len(var_490_11)
				local var_490_14 = var_490_12 <= 0 and var_490_8 or var_490_8 * (var_490_13 / var_490_12)

				if var_490_14 > 0 and var_490_8 < var_490_14 then
					arg_487_1.talkMaxDuration = var_490_14

					if var_490_14 + var_490_7 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_14 + var_490_7
					end
				end

				arg_487_1.text_.text = var_490_11
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051120", "story_v_out_424051.awb") ~= 0 then
					local var_490_15 = manager.audio:GetVoiceLength("story_v_out_424051", "424051120", "story_v_out_424051.awb") / 1000

					if var_490_15 + var_490_7 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_15 + var_490_7
					end

					if var_490_10.prefab_name ~= "" and arg_487_1.actors_[var_490_10.prefab_name] ~= nil then
						local var_490_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_10.prefab_name].transform, "story_v_out_424051", "424051120", "story_v_out_424051.awb")

						arg_487_1:RecordAudio("424051120", var_490_16)
						arg_487_1:RecordAudio("424051120", var_490_16)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_424051", "424051120", "story_v_out_424051.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_424051", "424051120", "story_v_out_424051.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_17 = math.max(var_490_8, arg_487_1.talkMaxDuration)

			if var_490_7 <= arg_487_1.time_ and arg_487_1.time_ < var_490_7 + var_490_17 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_7) / var_490_17

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_7 + var_490_17 and arg_487_1.time_ < var_490_7 + var_490_17 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {
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

		arg_487_1:InitPlayNodeList()
	end,
	Play424051121 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 424051121
		arg_491_1.duration_ = 5.47

		local var_491_0 = {
			zh = 4.2,
			ja = 5.466
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play424051122(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = arg_491_1.actors_["1094"]
			local var_494_1 = 0

			if var_494_1 < arg_491_1.time_ and arg_491_1.time_ <= var_494_1 + arg_494_0 and not isNil(var_494_0) and arg_491_1.var_.actorSpriteComps1094 == nil then
				arg_491_1.var_.actorSpriteComps1094 = var_494_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_494_2 = 0.2

			if var_494_1 <= arg_491_1.time_ and arg_491_1.time_ < var_494_1 + var_494_2 and not isNil(var_494_0) then
				local var_494_3 = (arg_491_1.time_ - var_494_1) / var_494_2

				if arg_491_1.var_.actorSpriteComps1094 then
					for iter_494_0, iter_494_1 in pairs(arg_491_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_494_1 then
							if arg_491_1.isInRecall_ then
								local var_494_4 = Mathf.Lerp(iter_494_1.color.r, arg_491_1.hightColor1.r, var_494_3)
								local var_494_5 = Mathf.Lerp(iter_494_1.color.g, arg_491_1.hightColor1.g, var_494_3)
								local var_494_6 = Mathf.Lerp(iter_494_1.color.b, arg_491_1.hightColor1.b, var_494_3)

								iter_494_1.color = Color.New(var_494_4, var_494_5, var_494_6)
							else
								local var_494_7 = Mathf.Lerp(iter_494_1.color.r, 1, var_494_3)

								iter_494_1.color = Color.New(var_494_7, var_494_7, var_494_7)
							end
						end
					end
				end
			end

			if arg_491_1.time_ >= var_494_1 + var_494_2 and arg_491_1.time_ < var_494_1 + var_494_2 + arg_494_0 and not isNil(var_494_0) and arg_491_1.var_.actorSpriteComps1094 then
				for iter_494_2, iter_494_3 in pairs(arg_491_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_494_3 then
						if arg_491_1.isInRecall_ then
							iter_494_3.color = arg_491_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_494_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_491_1.var_.actorSpriteComps1094 = nil
			end

			local var_494_8 = arg_491_1.actors_["10155"]
			local var_494_9 = 0

			if var_494_9 < arg_491_1.time_ and arg_491_1.time_ <= var_494_9 + arg_494_0 and not isNil(var_494_8) and arg_491_1.var_.actorSpriteComps10155 == nil then
				arg_491_1.var_.actorSpriteComps10155 = var_494_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_494_10 = 0.2

			if var_494_9 <= arg_491_1.time_ and arg_491_1.time_ < var_494_9 + var_494_10 and not isNil(var_494_8) then
				local var_494_11 = (arg_491_1.time_ - var_494_9) / var_494_10

				if arg_491_1.var_.actorSpriteComps10155 then
					for iter_494_4, iter_494_5 in pairs(arg_491_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_494_5 then
							if arg_491_1.isInRecall_ then
								local var_494_12 = Mathf.Lerp(iter_494_5.color.r, arg_491_1.hightColor2.r, var_494_11)
								local var_494_13 = Mathf.Lerp(iter_494_5.color.g, arg_491_1.hightColor2.g, var_494_11)
								local var_494_14 = Mathf.Lerp(iter_494_5.color.b, arg_491_1.hightColor2.b, var_494_11)

								iter_494_5.color = Color.New(var_494_12, var_494_13, var_494_14)
							else
								local var_494_15 = Mathf.Lerp(iter_494_5.color.r, 0.5, var_494_11)

								iter_494_5.color = Color.New(var_494_15, var_494_15, var_494_15)
							end
						end
					end
				end
			end

			if arg_491_1.time_ >= var_494_9 + var_494_10 and arg_491_1.time_ < var_494_9 + var_494_10 + arg_494_0 and not isNil(var_494_8) and arg_491_1.var_.actorSpriteComps10155 then
				for iter_494_6, iter_494_7 in pairs(arg_491_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_494_7 then
						if arg_491_1.isInRecall_ then
							iter_494_7.color = arg_491_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_494_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_491_1.var_.actorSpriteComps10155 = nil
			end

			local var_494_16 = arg_491_1.actors_["1094"].transform
			local var_494_17 = 0

			if var_494_17 < arg_491_1.time_ and arg_491_1.time_ <= var_494_17 + arg_494_0 then
				arg_491_1.var_.moveOldPos1094 = var_494_16.localPosition
				var_494_16.localScale = Vector3.New(1, 1, 1)

				arg_491_1:CheckSpriteTmpPos("1094", 4)

				local var_494_18 = var_494_16.childCount

				for iter_494_8 = 0, var_494_18 - 1 do
					local var_494_19 = var_494_16:GetChild(iter_494_8)

					if var_494_19.name == "" or not string.find(var_494_19.name, "split") then
						var_494_19.gameObject:SetActive(true)
					else
						var_494_19.gameObject:SetActive(false)
					end
				end
			end

			local var_494_20 = 0.001

			if var_494_17 <= arg_491_1.time_ and arg_491_1.time_ < var_494_17 + var_494_20 then
				local var_494_21 = (arg_491_1.time_ - var_494_17) / var_494_20
				local var_494_22 = Vector3.New(470, -335, -230)

				var_494_16.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos1094, var_494_22, var_494_21)
			end

			if arg_491_1.time_ >= var_494_17 + var_494_20 and arg_491_1.time_ < var_494_17 + var_494_20 + arg_494_0 then
				var_494_16.localPosition = Vector3.New(470, -335, -230)
			end

			local var_494_23 = 0
			local var_494_24 = 0.3

			if var_494_23 < arg_491_1.time_ and arg_491_1.time_ <= var_494_23 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				local var_494_25 = arg_491_1:FormatText(StoryNameCfg[181].name)

				arg_491_1.leftNameTxt_.text = var_494_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_26 = arg_491_1:GetWordFromCfg(424051121)
				local var_494_27 = arg_491_1:FormatText(var_494_26.content)

				arg_491_1.text_.text = var_494_27

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_28 = 12
				local var_494_29 = utf8.len(var_494_27)
				local var_494_30 = var_494_28 <= 0 and var_494_24 or var_494_24 * (var_494_29 / var_494_28)

				if var_494_30 > 0 and var_494_24 < var_494_30 then
					arg_491_1.talkMaxDuration = var_494_30

					if var_494_30 + var_494_23 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_30 + var_494_23
					end
				end

				arg_491_1.text_.text = var_494_27
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051121", "story_v_out_424051.awb") ~= 0 then
					local var_494_31 = manager.audio:GetVoiceLength("story_v_out_424051", "424051121", "story_v_out_424051.awb") / 1000

					if var_494_31 + var_494_23 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_31 + var_494_23
					end

					if var_494_26.prefab_name ~= "" and arg_491_1.actors_[var_494_26.prefab_name] ~= nil then
						local var_494_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_26.prefab_name].transform, "story_v_out_424051", "424051121", "story_v_out_424051.awb")

						arg_491_1:RecordAudio("424051121", var_494_32)
						arg_491_1:RecordAudio("424051121", var_494_32)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_424051", "424051121", "story_v_out_424051.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_424051", "424051121", "story_v_out_424051.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_33 = math.max(var_494_24, arg_491_1.talkMaxDuration)

			if var_494_23 <= arg_491_1.time_ and arg_491_1.time_ < var_494_23 + var_494_33 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_23) / var_494_33

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_23 + var_494_33 and arg_491_1.time_ < var_494_23 + var_494_33 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {
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

		arg_491_1:InitPlayNodeList()
	end,
	Play424051122 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 424051122
		arg_495_1.duration_ = 1

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"

			SetActive(arg_495_1.choicesGo_, true)

			for iter_496_0, iter_496_1 in ipairs(arg_495_1.choices_) do
				local var_496_0 = iter_496_0 <= 2

				SetActive(iter_496_1.go, var_496_0)
			end

			arg_495_1.choices_[1].txt.text = arg_495_1:FormatText(StoryChoiceCfg[1481].name)
			arg_495_1.choices_[2].txt.text = arg_495_1:FormatText(StoryChoiceCfg[1482].name)
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play424051123(arg_495_1)
			end

			if arg_497_0 == 2 then
				arg_495_0:Play424051123(arg_495_1)
			end

			arg_495_1:RecordChoiceLog(424051122, 1481, 1482)
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = arg_495_1.actors_["1094"]
			local var_498_1 = 0

			if var_498_1 < arg_495_1.time_ and arg_495_1.time_ <= var_498_1 + arg_498_0 and not isNil(var_498_0) and arg_495_1.var_.actorSpriteComps1094 == nil then
				arg_495_1.var_.actorSpriteComps1094 = var_498_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_498_2 = 0.2

			if var_498_1 <= arg_495_1.time_ and arg_495_1.time_ < var_498_1 + var_498_2 and not isNil(var_498_0) then
				local var_498_3 = (arg_495_1.time_ - var_498_1) / var_498_2

				if arg_495_1.var_.actorSpriteComps1094 then
					for iter_498_0, iter_498_1 in pairs(arg_495_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_498_1 then
							if arg_495_1.isInRecall_ then
								local var_498_4 = Mathf.Lerp(iter_498_1.color.r, arg_495_1.hightColor2.r, var_498_3)
								local var_498_5 = Mathf.Lerp(iter_498_1.color.g, arg_495_1.hightColor2.g, var_498_3)
								local var_498_6 = Mathf.Lerp(iter_498_1.color.b, arg_495_1.hightColor2.b, var_498_3)

								iter_498_1.color = Color.New(var_498_4, var_498_5, var_498_6)
							else
								local var_498_7 = Mathf.Lerp(iter_498_1.color.r, 0.5, var_498_3)

								iter_498_1.color = Color.New(var_498_7, var_498_7, var_498_7)
							end
						end
					end
				end
			end

			if arg_495_1.time_ >= var_498_1 + var_498_2 and arg_495_1.time_ < var_498_1 + var_498_2 + arg_498_0 and not isNil(var_498_0) and arg_495_1.var_.actorSpriteComps1094 then
				for iter_498_2, iter_498_3 in pairs(arg_495_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_498_3 then
						if arg_495_1.isInRecall_ then
							iter_498_3.color = arg_495_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_498_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_495_1.var_.actorSpriteComps1094 = nil
			end

			local var_498_8 = 0

			if var_498_8 < arg_495_1.time_ and arg_495_1.time_ <= var_498_8 + arg_498_0 then
				arg_495_1.allBtn_.enabled = false
			end

			local var_498_9 = 0.6

			if arg_495_1.time_ >= var_498_8 + var_498_9 and arg_495_1.time_ < var_498_8 + var_498_9 + arg_498_0 then
				arg_495_1.allBtn_.enabled = true
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play424051123 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 424051123
		arg_499_1.duration_ = 13.6

		local var_499_0 = {
			zh = 7.4,
			ja = 13.6
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
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play424051124(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = arg_499_1.actors_["10155"]
			local var_502_1 = 0

			if var_502_1 < arg_499_1.time_ and arg_499_1.time_ <= var_502_1 + arg_502_0 and not isNil(var_502_0) and arg_499_1.var_.actorSpriteComps10155 == nil then
				arg_499_1.var_.actorSpriteComps10155 = var_502_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_502_2 = 0.2

			if var_502_1 <= arg_499_1.time_ and arg_499_1.time_ < var_502_1 + var_502_2 and not isNil(var_502_0) then
				local var_502_3 = (arg_499_1.time_ - var_502_1) / var_502_2

				if arg_499_1.var_.actorSpriteComps10155 then
					for iter_502_0, iter_502_1 in pairs(arg_499_1.var_.actorSpriteComps10155:ToTable()) do
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

			if arg_499_1.time_ >= var_502_1 + var_502_2 and arg_499_1.time_ < var_502_1 + var_502_2 + arg_502_0 and not isNil(var_502_0) and arg_499_1.var_.actorSpriteComps10155 then
				for iter_502_2, iter_502_3 in pairs(arg_499_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_502_3 then
						if arg_499_1.isInRecall_ then
							iter_502_3.color = arg_499_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_502_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_499_1.var_.actorSpriteComps10155 = nil
			end

			local var_502_8 = arg_499_1.actors_["10155"].transform
			local var_502_9 = 0

			if var_502_9 < arg_499_1.time_ and arg_499_1.time_ <= var_502_9 + arg_502_0 then
				arg_499_1.var_.moveOldPos10155 = var_502_8.localPosition
				var_502_8.localScale = Vector3.New(1, 1, 1)

				arg_499_1:CheckSpriteTmpPos("10155", 2)

				local var_502_10 = var_502_8.childCount

				for iter_502_4 = 0, var_502_10 - 1 do
					local var_502_11 = var_502_8:GetChild(iter_502_4)

					if var_502_11.name == "split_2" then
						var_502_11:SetAsLastSibling()
						var_502_11.gameObject:SetActive(true)

						arg_499_1.var_.actorSpriteSplit10155 = var_502_11.gameObject:GetComponent(typeof(Image))

						arg_499_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_502_12 = 0.5

			if var_502_9 <= arg_499_1.time_ and arg_499_1.time_ < var_502_9 + var_502_12 then
				local var_502_13 = (arg_499_1.time_ - var_502_9) / var_502_12
				local var_502_14 = Vector3.New(-410, -390, -250)

				var_502_8.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos10155, var_502_14, var_502_13)

				if arg_499_1.var_.actorSpriteSplit10155 ~= nil then
					arg_499_1.var_.actorSpriteSplit10155:SetAlpha(var_502_13)
				end
			end

			if arg_499_1.time_ >= var_502_9 + var_502_12 and arg_499_1.time_ < var_502_9 + var_502_12 + arg_502_0 then
				var_502_8.localPosition = Vector3.New(-410, -390, -250)

				if arg_499_1.var_.actorSpriteSplit10155 ~= nil then
					arg_499_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_502_15 = 0
			local var_502_16 = 0.8

			if var_502_15 < arg_499_1.time_ and arg_499_1.time_ <= var_502_15 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				local var_502_17 = arg_499_1:FormatText(StoryNameCfg[1391].name)

				arg_499_1.leftNameTxt_.text = var_502_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_18 = arg_499_1:GetWordFromCfg(424051123)
				local var_502_19 = arg_499_1:FormatText(var_502_18.content)

				arg_499_1.text_.text = var_502_19

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_20 = 32
				local var_502_21 = utf8.len(var_502_19)
				local var_502_22 = var_502_20 <= 0 and var_502_16 or var_502_16 * (var_502_21 / var_502_20)

				if var_502_22 > 0 and var_502_16 < var_502_22 then
					arg_499_1.talkMaxDuration = var_502_22

					if var_502_22 + var_502_15 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_22 + var_502_15
					end
				end

				arg_499_1.text_.text = var_502_19
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051123", "story_v_out_424051.awb") ~= 0 then
					local var_502_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051123", "story_v_out_424051.awb") / 1000

					if var_502_23 + var_502_15 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_23 + var_502_15
					end

					if var_502_18.prefab_name ~= "" and arg_499_1.actors_[var_502_18.prefab_name] ~= nil then
						local var_502_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_18.prefab_name].transform, "story_v_out_424051", "424051123", "story_v_out_424051.awb")

						arg_499_1:RecordAudio("424051123", var_502_24)
						arg_499_1:RecordAudio("424051123", var_502_24)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_424051", "424051123", "story_v_out_424051.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_424051", "424051123", "story_v_out_424051.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_25 = math.max(var_502_16, arg_499_1.talkMaxDuration)

			if var_502_15 <= arg_499_1.time_ and arg_499_1.time_ < var_502_15 + var_502_25 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_15) / var_502_25

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_15 + var_502_25 and arg_499_1.time_ < var_502_15 + var_502_25 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_499_1:InitPlayNodeList()
	end,
	Play424051124 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 424051124
		arg_503_1.duration_ = 8.77

		local var_503_0 = {
			zh = 6.433,
			ja = 8.766
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play424051125(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = arg_503_1.actors_["10155"]
			local var_506_1 = 0

			if var_506_1 < arg_503_1.time_ and arg_503_1.time_ <= var_506_1 + arg_506_0 and not isNil(var_506_0) and arg_503_1.var_.actorSpriteComps10155 == nil then
				arg_503_1.var_.actorSpriteComps10155 = var_506_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_506_2 = 0.2

			if var_506_1 <= arg_503_1.time_ and arg_503_1.time_ < var_506_1 + var_506_2 and not isNil(var_506_0) then
				local var_506_3 = (arg_503_1.time_ - var_506_1) / var_506_2

				if arg_503_1.var_.actorSpriteComps10155 then
					for iter_506_0, iter_506_1 in pairs(arg_503_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_506_1 then
							if arg_503_1.isInRecall_ then
								local var_506_4 = Mathf.Lerp(iter_506_1.color.r, arg_503_1.hightColor2.r, var_506_3)
								local var_506_5 = Mathf.Lerp(iter_506_1.color.g, arg_503_1.hightColor2.g, var_506_3)
								local var_506_6 = Mathf.Lerp(iter_506_1.color.b, arg_503_1.hightColor2.b, var_506_3)

								iter_506_1.color = Color.New(var_506_4, var_506_5, var_506_6)
							else
								local var_506_7 = Mathf.Lerp(iter_506_1.color.r, 0.5, var_506_3)

								iter_506_1.color = Color.New(var_506_7, var_506_7, var_506_7)
							end
						end
					end
				end
			end

			if arg_503_1.time_ >= var_506_1 + var_506_2 and arg_503_1.time_ < var_506_1 + var_506_2 + arg_506_0 and not isNil(var_506_0) and arg_503_1.var_.actorSpriteComps10155 then
				for iter_506_2, iter_506_3 in pairs(arg_503_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_506_3 then
						if arg_503_1.isInRecall_ then
							iter_506_3.color = arg_503_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_506_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_503_1.var_.actorSpriteComps10155 = nil
			end

			local var_506_8 = 0
			local var_506_9 = 0.85

			if var_506_8 < arg_503_1.time_ and arg_503_1.time_ <= var_506_8 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_10 = arg_503_1:FormatText(StoryNameCfg[177].name)

				arg_503_1.leftNameTxt_.text = var_506_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, true)
				arg_503_1.iconController_:SetSelectedState("hero")

				arg_503_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_503_1.callingController_:SetSelectedState("normal")

				arg_503_1.keyicon_.color = Color.New(1, 1, 1)
				arg_503_1.icon_.color = Color.New(1, 1, 1)

				local var_506_11 = arg_503_1:GetWordFromCfg(424051124)
				local var_506_12 = arg_503_1:FormatText(var_506_11.content)

				arg_503_1.text_.text = var_506_12

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_13 = 34
				local var_506_14 = utf8.len(var_506_12)
				local var_506_15 = var_506_13 <= 0 and var_506_9 or var_506_9 * (var_506_14 / var_506_13)

				if var_506_15 > 0 and var_506_9 < var_506_15 then
					arg_503_1.talkMaxDuration = var_506_15

					if var_506_15 + var_506_8 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_15 + var_506_8
					end
				end

				arg_503_1.text_.text = var_506_12
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051124", "story_v_out_424051.awb") ~= 0 then
					local var_506_16 = manager.audio:GetVoiceLength("story_v_out_424051", "424051124", "story_v_out_424051.awb") / 1000

					if var_506_16 + var_506_8 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_16 + var_506_8
					end

					if var_506_11.prefab_name ~= "" and arg_503_1.actors_[var_506_11.prefab_name] ~= nil then
						local var_506_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_11.prefab_name].transform, "story_v_out_424051", "424051124", "story_v_out_424051.awb")

						arg_503_1:RecordAudio("424051124", var_506_17)
						arg_503_1:RecordAudio("424051124", var_506_17)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_424051", "424051124", "story_v_out_424051.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_424051", "424051124", "story_v_out_424051.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_18 = math.max(var_506_9, arg_503_1.talkMaxDuration)

			if var_506_8 <= arg_503_1.time_ and arg_503_1.time_ < var_506_8 + var_506_18 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_8) / var_506_18

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_8 + var_506_18 and arg_503_1.time_ < var_506_8 + var_506_18 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play424051125 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 424051125
		arg_507_1.duration_ = 18.8

		local var_507_0 = {
			zh = 10.033,
			ja = 18.8
		}
		local var_507_1 = manager.audio:GetLocalizationFlag()

		if var_507_0[var_507_1] ~= nil then
			arg_507_1.duration_ = var_507_0[var_507_1]
		end

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play424051126(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = arg_507_1.actors_["10155"]
			local var_510_1 = 0

			if var_510_1 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 and not isNil(var_510_0) and arg_507_1.var_.actorSpriteComps10155 == nil then
				arg_507_1.var_.actorSpriteComps10155 = var_510_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_510_2 = 0.2

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_2 and not isNil(var_510_0) then
				local var_510_3 = (arg_507_1.time_ - var_510_1) / var_510_2

				if arg_507_1.var_.actorSpriteComps10155 then
					for iter_510_0, iter_510_1 in pairs(arg_507_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_510_1 then
							if arg_507_1.isInRecall_ then
								local var_510_4 = Mathf.Lerp(iter_510_1.color.r, arg_507_1.hightColor1.r, var_510_3)
								local var_510_5 = Mathf.Lerp(iter_510_1.color.g, arg_507_1.hightColor1.g, var_510_3)
								local var_510_6 = Mathf.Lerp(iter_510_1.color.b, arg_507_1.hightColor1.b, var_510_3)

								iter_510_1.color = Color.New(var_510_4, var_510_5, var_510_6)
							else
								local var_510_7 = Mathf.Lerp(iter_510_1.color.r, 1, var_510_3)

								iter_510_1.color = Color.New(var_510_7, var_510_7, var_510_7)
							end
						end
					end
				end
			end

			if arg_507_1.time_ >= var_510_1 + var_510_2 and arg_507_1.time_ < var_510_1 + var_510_2 + arg_510_0 and not isNil(var_510_0) and arg_507_1.var_.actorSpriteComps10155 then
				for iter_510_2, iter_510_3 in pairs(arg_507_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_510_3 then
						if arg_507_1.isInRecall_ then
							iter_510_3.color = arg_507_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_510_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_507_1.var_.actorSpriteComps10155 = nil
			end

			local var_510_8 = arg_507_1.actors_["10155"].transform
			local var_510_9 = 0

			if var_510_9 < arg_507_1.time_ and arg_507_1.time_ <= var_510_9 + arg_510_0 then
				arg_507_1.var_.moveOldPos10155 = var_510_8.localPosition
				var_510_8.localScale = Vector3.New(1, 1, 1)

				arg_507_1:CheckSpriteTmpPos("10155", 2)

				local var_510_10 = var_510_8.childCount

				for iter_510_4 = 0, var_510_10 - 1 do
					local var_510_11 = var_510_8:GetChild(iter_510_4)

					if var_510_11.name == "split_1" or not string.find(var_510_11.name, "split") then
						var_510_11.gameObject:SetActive(true)
					else
						var_510_11.gameObject:SetActive(false)
					end
				end
			end

			local var_510_12 = 0.001

			if var_510_9 <= arg_507_1.time_ and arg_507_1.time_ < var_510_9 + var_510_12 then
				local var_510_13 = (arg_507_1.time_ - var_510_9) / var_510_12
				local var_510_14 = Vector3.New(-410, -390, -250)

				var_510_8.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos10155, var_510_14, var_510_13)
			end

			if arg_507_1.time_ >= var_510_9 + var_510_12 and arg_507_1.time_ < var_510_9 + var_510_12 + arg_510_0 then
				var_510_8.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_510_15 = 0
			local var_510_16 = 1.1

			if var_510_15 < arg_507_1.time_ and arg_507_1.time_ <= var_510_15 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				local var_510_17 = arg_507_1:FormatText(StoryNameCfg[1391].name)

				arg_507_1.leftNameTxt_.text = var_510_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_18 = arg_507_1:GetWordFromCfg(424051125)
				local var_510_19 = arg_507_1:FormatText(var_510_18.content)

				arg_507_1.text_.text = var_510_19

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_20 = 44
				local var_510_21 = utf8.len(var_510_19)
				local var_510_22 = var_510_20 <= 0 and var_510_16 or var_510_16 * (var_510_21 / var_510_20)

				if var_510_22 > 0 and var_510_16 < var_510_22 then
					arg_507_1.talkMaxDuration = var_510_22

					if var_510_22 + var_510_15 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_22 + var_510_15
					end
				end

				arg_507_1.text_.text = var_510_19
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051125", "story_v_out_424051.awb") ~= 0 then
					local var_510_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051125", "story_v_out_424051.awb") / 1000

					if var_510_23 + var_510_15 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_23 + var_510_15
					end

					if var_510_18.prefab_name ~= "" and arg_507_1.actors_[var_510_18.prefab_name] ~= nil then
						local var_510_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_18.prefab_name].transform, "story_v_out_424051", "424051125", "story_v_out_424051.awb")

						arg_507_1:RecordAudio("424051125", var_510_24)
						arg_507_1:RecordAudio("424051125", var_510_24)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_424051", "424051125", "story_v_out_424051.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_424051", "424051125", "story_v_out_424051.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_25 = math.max(var_510_16, arg_507_1.talkMaxDuration)

			if var_510_15 <= arg_507_1.time_ and arg_507_1.time_ < var_510_15 + var_510_25 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_15) / var_510_25

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_15 + var_510_25 and arg_507_1.time_ < var_510_15 + var_510_25 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {
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

		arg_507_1:InitPlayNodeList()
	end,
	Play424051126 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 424051126
		arg_511_1.duration_ = 3

		local var_511_0 = {
			zh = 1.933,
			ja = 3
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play424051127(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = arg_511_1.actors_["1094"]
			local var_514_1 = 0

			if var_514_1 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 and not isNil(var_514_0) and arg_511_1.var_.actorSpriteComps1094 == nil then
				arg_511_1.var_.actorSpriteComps1094 = var_514_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_514_2 = 0.2

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_2 and not isNil(var_514_0) then
				local var_514_3 = (arg_511_1.time_ - var_514_1) / var_514_2

				if arg_511_1.var_.actorSpriteComps1094 then
					for iter_514_0, iter_514_1 in pairs(arg_511_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_514_1 then
							if arg_511_1.isInRecall_ then
								local var_514_4 = Mathf.Lerp(iter_514_1.color.r, arg_511_1.hightColor1.r, var_514_3)
								local var_514_5 = Mathf.Lerp(iter_514_1.color.g, arg_511_1.hightColor1.g, var_514_3)
								local var_514_6 = Mathf.Lerp(iter_514_1.color.b, arg_511_1.hightColor1.b, var_514_3)

								iter_514_1.color = Color.New(var_514_4, var_514_5, var_514_6)
							else
								local var_514_7 = Mathf.Lerp(iter_514_1.color.r, 1, var_514_3)

								iter_514_1.color = Color.New(var_514_7, var_514_7, var_514_7)
							end
						end
					end
				end
			end

			if arg_511_1.time_ >= var_514_1 + var_514_2 and arg_511_1.time_ < var_514_1 + var_514_2 + arg_514_0 and not isNil(var_514_0) and arg_511_1.var_.actorSpriteComps1094 then
				for iter_514_2, iter_514_3 in pairs(arg_511_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_514_3 then
						if arg_511_1.isInRecall_ then
							iter_514_3.color = arg_511_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_514_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_511_1.var_.actorSpriteComps1094 = nil
			end

			local var_514_8 = arg_511_1.actors_["10155"]
			local var_514_9 = 0

			if var_514_9 < arg_511_1.time_ and arg_511_1.time_ <= var_514_9 + arg_514_0 and not isNil(var_514_8) and arg_511_1.var_.actorSpriteComps10155 == nil then
				arg_511_1.var_.actorSpriteComps10155 = var_514_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_514_10 = 0.2

			if var_514_9 <= arg_511_1.time_ and arg_511_1.time_ < var_514_9 + var_514_10 and not isNil(var_514_8) then
				local var_514_11 = (arg_511_1.time_ - var_514_9) / var_514_10

				if arg_511_1.var_.actorSpriteComps10155 then
					for iter_514_4, iter_514_5 in pairs(arg_511_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_514_5 then
							if arg_511_1.isInRecall_ then
								local var_514_12 = Mathf.Lerp(iter_514_5.color.r, arg_511_1.hightColor2.r, var_514_11)
								local var_514_13 = Mathf.Lerp(iter_514_5.color.g, arg_511_1.hightColor2.g, var_514_11)
								local var_514_14 = Mathf.Lerp(iter_514_5.color.b, arg_511_1.hightColor2.b, var_514_11)

								iter_514_5.color = Color.New(var_514_12, var_514_13, var_514_14)
							else
								local var_514_15 = Mathf.Lerp(iter_514_5.color.r, 0.5, var_514_11)

								iter_514_5.color = Color.New(var_514_15, var_514_15, var_514_15)
							end
						end
					end
				end
			end

			if arg_511_1.time_ >= var_514_9 + var_514_10 and arg_511_1.time_ < var_514_9 + var_514_10 + arg_514_0 and not isNil(var_514_8) and arg_511_1.var_.actorSpriteComps10155 then
				for iter_514_6, iter_514_7 in pairs(arg_511_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_514_7 then
						if arg_511_1.isInRecall_ then
							iter_514_7.color = arg_511_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_514_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_511_1.var_.actorSpriteComps10155 = nil
			end

			local var_514_16 = arg_511_1.actors_["1094"].transform
			local var_514_17 = 0

			if var_514_17 < arg_511_1.time_ and arg_511_1.time_ <= var_514_17 + arg_514_0 then
				arg_511_1.var_.moveOldPos1094 = var_514_16.localPosition
				var_514_16.localScale = Vector3.New(1, 1, 1)

				arg_511_1:CheckSpriteTmpPos("1094", 4)

				local var_514_18 = var_514_16.childCount

				for iter_514_8 = 0, var_514_18 - 1 do
					local var_514_19 = var_514_16:GetChild(iter_514_8)

					if var_514_19.name == "split_4" then
						var_514_19:SetAsLastSibling()
						var_514_19.gameObject:SetActive(true)

						arg_511_1.var_.actorSpriteSplit1094 = var_514_19.gameObject:GetComponent(typeof(Image))

						arg_511_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_514_20 = 0.5

			if var_514_17 <= arg_511_1.time_ and arg_511_1.time_ < var_514_17 + var_514_20 then
				local var_514_21 = (arg_511_1.time_ - var_514_17) / var_514_20
				local var_514_22 = Vector3.New(470, -335, -230)

				var_514_16.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos1094, var_514_22, var_514_21)

				if arg_511_1.var_.actorSpriteSplit1094 ~= nil then
					arg_511_1.var_.actorSpriteSplit1094:SetAlpha(var_514_21)
				end
			end

			if arg_511_1.time_ >= var_514_17 + var_514_20 and arg_511_1.time_ < var_514_17 + var_514_20 + arg_514_0 then
				var_514_16.localPosition = Vector3.New(470, -335, -230)

				if arg_511_1.var_.actorSpriteSplit1094 ~= nil then
					arg_511_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_514_23 = 0
			local var_514_24 = 0.2

			if var_514_23 < arg_511_1.time_ and arg_511_1.time_ <= var_514_23 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_25 = arg_511_1:FormatText(StoryNameCfg[181].name)

				arg_511_1.leftNameTxt_.text = var_514_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_26 = arg_511_1:GetWordFromCfg(424051126)
				local var_514_27 = arg_511_1:FormatText(var_514_26.content)

				arg_511_1.text_.text = var_514_27

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_28 = 8
				local var_514_29 = utf8.len(var_514_27)
				local var_514_30 = var_514_28 <= 0 and var_514_24 or var_514_24 * (var_514_29 / var_514_28)

				if var_514_30 > 0 and var_514_24 < var_514_30 then
					arg_511_1.talkMaxDuration = var_514_30

					if var_514_30 + var_514_23 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_30 + var_514_23
					end
				end

				arg_511_1.text_.text = var_514_27
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051126", "story_v_out_424051.awb") ~= 0 then
					local var_514_31 = manager.audio:GetVoiceLength("story_v_out_424051", "424051126", "story_v_out_424051.awb") / 1000

					if var_514_31 + var_514_23 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_31 + var_514_23
					end

					if var_514_26.prefab_name ~= "" and arg_511_1.actors_[var_514_26.prefab_name] ~= nil then
						local var_514_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_26.prefab_name].transform, "story_v_out_424051", "424051126", "story_v_out_424051.awb")

						arg_511_1:RecordAudio("424051126", var_514_32)
						arg_511_1:RecordAudio("424051126", var_514_32)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_424051", "424051126", "story_v_out_424051.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_424051", "424051126", "story_v_out_424051.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_33 = math.max(var_514_24, arg_511_1.talkMaxDuration)

			if var_514_23 <= arg_511_1.time_ and arg_511_1.time_ < var_514_23 + var_514_33 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_23) / var_514_33

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_23 + var_514_33 and arg_511_1.time_ < var_514_23 + var_514_33 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_511_1:InitPlayNodeList()
	end,
	Play424051127 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 424051127
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play424051128(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = arg_515_1.actors_["1094"]
			local var_518_1 = 0

			if var_518_1 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 and not isNil(var_518_0) and arg_515_1.var_.actorSpriteComps1094 == nil then
				arg_515_1.var_.actorSpriteComps1094 = var_518_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_518_2 = 0.2

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_2 and not isNil(var_518_0) then
				local var_518_3 = (arg_515_1.time_ - var_518_1) / var_518_2

				if arg_515_1.var_.actorSpriteComps1094 then
					for iter_518_0, iter_518_1 in pairs(arg_515_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_518_1 then
							if arg_515_1.isInRecall_ then
								local var_518_4 = Mathf.Lerp(iter_518_1.color.r, arg_515_1.hightColor2.r, var_518_3)
								local var_518_5 = Mathf.Lerp(iter_518_1.color.g, arg_515_1.hightColor2.g, var_518_3)
								local var_518_6 = Mathf.Lerp(iter_518_1.color.b, arg_515_1.hightColor2.b, var_518_3)

								iter_518_1.color = Color.New(var_518_4, var_518_5, var_518_6)
							else
								local var_518_7 = Mathf.Lerp(iter_518_1.color.r, 0.5, var_518_3)

								iter_518_1.color = Color.New(var_518_7, var_518_7, var_518_7)
							end
						end
					end
				end
			end

			if arg_515_1.time_ >= var_518_1 + var_518_2 and arg_515_1.time_ < var_518_1 + var_518_2 + arg_518_0 and not isNil(var_518_0) and arg_515_1.var_.actorSpriteComps1094 then
				for iter_518_2, iter_518_3 in pairs(arg_515_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_518_3 then
						if arg_515_1.isInRecall_ then
							iter_518_3.color = arg_515_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_518_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_515_1.var_.actorSpriteComps1094 = nil
			end

			local var_518_8 = 0
			local var_518_9 = 0.675

			if var_518_8 < arg_515_1.time_ and arg_515_1.time_ <= var_518_8 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_10 = arg_515_1:FormatText(StoryNameCfg[7].name)

				arg_515_1.leftNameTxt_.text = var_518_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_515_1.callingController_:SetSelectedState("normal")

				arg_515_1.keyicon_.color = Color.New(1, 1, 1)
				arg_515_1.icon_.color = Color.New(1, 1, 1)

				local var_518_11 = arg_515_1:GetWordFromCfg(424051127)
				local var_518_12 = arg_515_1:FormatText(var_518_11.content)

				arg_515_1.text_.text = var_518_12

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_13 = 27
				local var_518_14 = utf8.len(var_518_12)
				local var_518_15 = var_518_13 <= 0 and var_518_9 or var_518_9 * (var_518_14 / var_518_13)

				if var_518_15 > 0 and var_518_9 < var_518_15 then
					arg_515_1.talkMaxDuration = var_518_15

					if var_518_15 + var_518_8 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_15 + var_518_8
					end
				end

				arg_515_1.text_.text = var_518_12
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_16 = math.max(var_518_9, arg_515_1.talkMaxDuration)

			if var_518_8 <= arg_515_1.time_ and arg_515_1.time_ < var_518_8 + var_518_16 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_8) / var_518_16

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_8 + var_518_16 and arg_515_1.time_ < var_518_8 + var_518_16 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play424051128 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 424051128
		arg_519_1.duration_ = 17.83

		local var_519_0 = {
			zh = 8.3,
			ja = 17.833
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play424051129(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = arg_519_1.actors_["10155"]
			local var_522_1 = 0

			if var_522_1 < arg_519_1.time_ and arg_519_1.time_ <= var_522_1 + arg_522_0 and not isNil(var_522_0) and arg_519_1.var_.actorSpriteComps10155 == nil then
				arg_519_1.var_.actorSpriteComps10155 = var_522_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_522_2 = 0.2

			if var_522_1 <= arg_519_1.time_ and arg_519_1.time_ < var_522_1 + var_522_2 and not isNil(var_522_0) then
				local var_522_3 = (arg_519_1.time_ - var_522_1) / var_522_2

				if arg_519_1.var_.actorSpriteComps10155 then
					for iter_522_0, iter_522_1 in pairs(arg_519_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_522_1 then
							if arg_519_1.isInRecall_ then
								local var_522_4 = Mathf.Lerp(iter_522_1.color.r, arg_519_1.hightColor1.r, var_522_3)
								local var_522_5 = Mathf.Lerp(iter_522_1.color.g, arg_519_1.hightColor1.g, var_522_3)
								local var_522_6 = Mathf.Lerp(iter_522_1.color.b, arg_519_1.hightColor1.b, var_522_3)

								iter_522_1.color = Color.New(var_522_4, var_522_5, var_522_6)
							else
								local var_522_7 = Mathf.Lerp(iter_522_1.color.r, 1, var_522_3)

								iter_522_1.color = Color.New(var_522_7, var_522_7, var_522_7)
							end
						end
					end
				end
			end

			if arg_519_1.time_ >= var_522_1 + var_522_2 and arg_519_1.time_ < var_522_1 + var_522_2 + arg_522_0 and not isNil(var_522_0) and arg_519_1.var_.actorSpriteComps10155 then
				for iter_522_2, iter_522_3 in pairs(arg_519_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_522_3 then
						if arg_519_1.isInRecall_ then
							iter_522_3.color = arg_519_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_522_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_519_1.var_.actorSpriteComps10155 = nil
			end

			local var_522_8 = arg_519_1.actors_["10155"].transform
			local var_522_9 = 0

			if var_522_9 < arg_519_1.time_ and arg_519_1.time_ <= var_522_9 + arg_522_0 then
				arg_519_1.var_.moveOldPos10155 = var_522_8.localPosition
				var_522_8.localScale = Vector3.New(1, 1, 1)

				arg_519_1:CheckSpriteTmpPos("10155", 2)

				local var_522_10 = var_522_8.childCount

				for iter_522_4 = 0, var_522_10 - 1 do
					local var_522_11 = var_522_8:GetChild(iter_522_4)

					if var_522_11.name == "split_4" then
						var_522_11:SetAsLastSibling()
						var_522_11.gameObject:SetActive(true)

						arg_519_1.var_.actorSpriteSplit10155 = var_522_11.gameObject:GetComponent(typeof(Image))

						arg_519_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_522_12 = 0.5

			if var_522_9 <= arg_519_1.time_ and arg_519_1.time_ < var_522_9 + var_522_12 then
				local var_522_13 = (arg_519_1.time_ - var_522_9) / var_522_12
				local var_522_14 = Vector3.New(-410, -390, -250)

				var_522_8.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos10155, var_522_14, var_522_13)

				if arg_519_1.var_.actorSpriteSplit10155 ~= nil then
					arg_519_1.var_.actorSpriteSplit10155:SetAlpha(var_522_13)
				end
			end

			if arg_519_1.time_ >= var_522_9 + var_522_12 and arg_519_1.time_ < var_522_9 + var_522_12 + arg_522_0 then
				var_522_8.localPosition = Vector3.New(-410, -390, -250)

				if arg_519_1.var_.actorSpriteSplit10155 ~= nil then
					arg_519_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_522_15 = 0
			local var_522_16 = 0.9

			if var_522_15 < arg_519_1.time_ and arg_519_1.time_ <= var_522_15 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				local var_522_17 = arg_519_1:FormatText(StoryNameCfg[1391].name)

				arg_519_1.leftNameTxt_.text = var_522_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_18 = arg_519_1:GetWordFromCfg(424051128)
				local var_522_19 = arg_519_1:FormatText(var_522_18.content)

				arg_519_1.text_.text = var_522_19

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_20 = 36
				local var_522_21 = utf8.len(var_522_19)
				local var_522_22 = var_522_20 <= 0 and var_522_16 or var_522_16 * (var_522_21 / var_522_20)

				if var_522_22 > 0 and var_522_16 < var_522_22 then
					arg_519_1.talkMaxDuration = var_522_22

					if var_522_22 + var_522_15 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_22 + var_522_15
					end
				end

				arg_519_1.text_.text = var_522_19
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051128", "story_v_out_424051.awb") ~= 0 then
					local var_522_23 = manager.audio:GetVoiceLength("story_v_out_424051", "424051128", "story_v_out_424051.awb") / 1000

					if var_522_23 + var_522_15 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_23 + var_522_15
					end

					if var_522_18.prefab_name ~= "" and arg_519_1.actors_[var_522_18.prefab_name] ~= nil then
						local var_522_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_18.prefab_name].transform, "story_v_out_424051", "424051128", "story_v_out_424051.awb")

						arg_519_1:RecordAudio("424051128", var_522_24)
						arg_519_1:RecordAudio("424051128", var_522_24)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_424051", "424051128", "story_v_out_424051.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_424051", "424051128", "story_v_out_424051.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_25 = math.max(var_522_16, arg_519_1.talkMaxDuration)

			if var_522_15 <= arg_519_1.time_ and arg_519_1.time_ < var_522_15 + var_522_25 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_15) / var_522_25

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_15 + var_522_25 and arg_519_1.time_ < var_522_15 + var_522_25 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_519_1:InitPlayNodeList()
	end,
	Play424051129 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 424051129
		arg_523_1.duration_ = 10.23

		local var_523_0 = {
			zh = 5.766,
			ja = 10.233
		}
		local var_523_1 = manager.audio:GetLocalizationFlag()

		if var_523_0[var_523_1] ~= nil then
			arg_523_1.duration_ = var_523_0[var_523_1]
		end

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play424051130(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = arg_523_1.actors_["10155"]
			local var_526_1 = 0

			if var_526_1 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 and not isNil(var_526_0) and arg_523_1.var_.actorSpriteComps10155 == nil then
				arg_523_1.var_.actorSpriteComps10155 = var_526_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_526_2 = 0.2

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_2 and not isNil(var_526_0) then
				local var_526_3 = (arg_523_1.time_ - var_526_1) / var_526_2

				if arg_523_1.var_.actorSpriteComps10155 then
					for iter_526_0, iter_526_1 in pairs(arg_523_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_526_1 then
							if arg_523_1.isInRecall_ then
								local var_526_4 = Mathf.Lerp(iter_526_1.color.r, arg_523_1.hightColor2.r, var_526_3)
								local var_526_5 = Mathf.Lerp(iter_526_1.color.g, arg_523_1.hightColor2.g, var_526_3)
								local var_526_6 = Mathf.Lerp(iter_526_1.color.b, arg_523_1.hightColor2.b, var_526_3)

								iter_526_1.color = Color.New(var_526_4, var_526_5, var_526_6)
							else
								local var_526_7 = Mathf.Lerp(iter_526_1.color.r, 0.5, var_526_3)

								iter_526_1.color = Color.New(var_526_7, var_526_7, var_526_7)
							end
						end
					end
				end
			end

			if arg_523_1.time_ >= var_526_1 + var_526_2 and arg_523_1.time_ < var_526_1 + var_526_2 + arg_526_0 and not isNil(var_526_0) and arg_523_1.var_.actorSpriteComps10155 then
				for iter_526_2, iter_526_3 in pairs(arg_523_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_526_3 then
						if arg_523_1.isInRecall_ then
							iter_526_3.color = arg_523_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_526_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_523_1.var_.actorSpriteComps10155 = nil
			end

			local var_526_8 = 0
			local var_526_9 = 0.6

			if var_526_8 < arg_523_1.time_ and arg_523_1.time_ <= var_526_8 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				local var_526_10 = arg_523_1:FormatText(StoryNameCfg[177].name)

				arg_523_1.leftNameTxt_.text = var_526_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, true)
				arg_523_1.iconController_:SetSelectedState("hero")

				arg_523_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_523_1.callingController_:SetSelectedState("normal")

				arg_523_1.keyicon_.color = Color.New(1, 1, 1)
				arg_523_1.icon_.color = Color.New(1, 1, 1)

				local var_526_11 = arg_523_1:GetWordFromCfg(424051129)
				local var_526_12 = arg_523_1:FormatText(var_526_11.content)

				arg_523_1.text_.text = var_526_12

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_13 = 24
				local var_526_14 = utf8.len(var_526_12)
				local var_526_15 = var_526_13 <= 0 and var_526_9 or var_526_9 * (var_526_14 / var_526_13)

				if var_526_15 > 0 and var_526_9 < var_526_15 then
					arg_523_1.talkMaxDuration = var_526_15

					if var_526_15 + var_526_8 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_15 + var_526_8
					end
				end

				arg_523_1.text_.text = var_526_12
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424051", "424051129", "story_v_out_424051.awb") ~= 0 then
					local var_526_16 = manager.audio:GetVoiceLength("story_v_out_424051", "424051129", "story_v_out_424051.awb") / 1000

					if var_526_16 + var_526_8 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_16 + var_526_8
					end

					if var_526_11.prefab_name ~= "" and arg_523_1.actors_[var_526_11.prefab_name] ~= nil then
						local var_526_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_11.prefab_name].transform, "story_v_out_424051", "424051129", "story_v_out_424051.awb")

						arg_523_1:RecordAudio("424051129", var_526_17)
						arg_523_1:RecordAudio("424051129", var_526_17)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_out_424051", "424051129", "story_v_out_424051.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_out_424051", "424051129", "story_v_out_424051.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_18 = math.max(var_526_9, arg_523_1.talkMaxDuration)

			if var_526_8 <= arg_523_1.time_ and arg_523_1.time_ < var_526_8 + var_526_18 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_8) / var_526_18

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_8 + var_526_18 and arg_523_1.time_ < var_526_8 + var_526_18 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play424051130 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 424051130
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
			arg_527_1.auto_ = false
		end

		function arg_527_1.playNext_(arg_529_0)
			arg_527_1.onStoryFinished_()
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0
			local var_530_1 = 0.625

			if var_530_0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				local var_530_2 = arg_527_1:FormatText(StoryNameCfg[7].name)

				arg_527_1.leftNameTxt_.text = var_530_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, true)
				arg_527_1.iconController_:SetSelectedState("hero")

				arg_527_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_527_1.callingController_:SetSelectedState("normal")

				arg_527_1.keyicon_.color = Color.New(1, 1, 1)
				arg_527_1.icon_.color = Color.New(1, 1, 1)

				local var_530_3 = arg_527_1:GetWordFromCfg(424051130)
				local var_530_4 = arg_527_1:FormatText(var_530_3.content)

				arg_527_1.text_.text = var_530_4

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_5 = 25
				local var_530_6 = utf8.len(var_530_4)
				local var_530_7 = var_530_5 <= 0 and var_530_1 or var_530_1 * (var_530_6 / var_530_5)

				if var_530_7 > 0 and var_530_1 < var_530_7 then
					arg_527_1.talkMaxDuration = var_530_7

					if var_530_7 + var_530_0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_7 + var_530_0
					end
				end

				arg_527_1.text_.text = var_530_4
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_8 = math.max(var_530_1, arg_527_1.talkMaxDuration)

			if var_530_0 <= arg_527_1.time_ and arg_527_1.time_ < var_530_0 + var_530_8 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_0) / var_530_8

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_0 + var_530_8 and arg_527_1.time_ < var_530_0 + var_530_8 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0115",
		"TextureConfig/Background/I18a"
	},
	voices = {
		"story_v_out_424051.awb"
	}
}
