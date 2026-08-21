return {
	Play410232001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410232001
		arg_1_1.duration_ = 7.27

		local var_1_0 = {
			ja = 7.266,
			CriLanguages = 4.5,
			zh = 4.5
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
				arg_1_0:Play410232002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST62"

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
				local var_4_5 = arg_1_1.bgs_.ST62

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
					if iter_4_0 ~= "ST62" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_22 = "10062"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10062")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(var_4_23, arg_1_1.canvasGo_.transform)

					var_4_24.transform:SetSiblingIndex(1)

					var_4_24.name = var_4_22
					var_4_24.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_22] = var_4_24

					local var_4_25 = var_4_24:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs(var_4_25) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_26 = arg_1_1.actors_["10062"].transform
			local var_4_27 = 2

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.var_.moveOldPos10062 = var_4_26.localPosition
				var_4_26.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10062", 3)

				local var_4_28 = var_4_26.childCount

				for iter_4_4 = 0, var_4_28 - 1 do
					local var_4_29 = var_4_26:GetChild(iter_4_4)

					if var_4_29.name == "split_1_1" or not string.find(var_4_29.name, "split") then
						var_4_29.gameObject:SetActive(true)
					else
						var_4_29.gameObject:SetActive(false)
					end
				end
			end

			local var_4_30 = 0.001

			if var_4_27 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_30 then
				local var_4_31 = (arg_1_1.time_ - var_4_27) / var_4_30
				local var_4_32 = Vector3.New(0, -390, -290)

				var_4_26.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10062, var_4_32, var_4_31)
			end

			if arg_1_1.time_ >= var_4_27 + var_4_30 and arg_1_1.time_ < var_4_27 + var_4_30 + arg_4_0 then
				var_4_26.localPosition = Vector3.New(0, -390, -290)
			end

			local var_4_33 = arg_1_1.actors_["10062"]
			local var_4_34 = 2

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 and not isNil(var_4_33) and arg_1_1.var_.actorSpriteComps10062 == nil then
				arg_1_1.var_.actorSpriteComps10062 = var_4_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_35 = 0.034

			if var_4_34 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 and not isNil(var_4_33) then
				local var_4_36 = (arg_1_1.time_ - var_4_34) / var_4_35

				if arg_1_1.var_.actorSpriteComps10062 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								local var_4_37 = Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, var_4_36)
								local var_4_38 = Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, var_4_36)
								local var_4_39 = Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, var_4_36)

								iter_4_6.color = Color.New(var_4_37, var_4_38, var_4_39)
							else
								local var_4_40 = Mathf.Lerp(iter_4_6.color.r, 1, var_4_36)

								iter_4_6.color = Color.New(var_4_40, var_4_40, var_4_40)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 and not isNil(var_4_33) and arg_1_1.var_.actorSpriteComps10062 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_4_8 then
						if arg_1_1.isInRecall_ then
							iter_4_8.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10062 = nil
			end

			local var_4_41 = 0
			local var_4_42 = 0.166666666666667

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				local var_4_43 = "play"
				local var_4_44 = "music"

				arg_1_1:AudioAction(var_4_43, var_4_44, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_45 = ""
				local var_4_46 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_46 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_46 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_46

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_46
						arg_1_1.bgmTxt2_.text = var_4_46
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

			local var_4_47 = 0.3
			local var_4_48 = 1

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_49 = "play"
				local var_4_50 = "music"

				arg_1_1:AudioAction(var_4_49, var_4_50, "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building.awb")

				local var_4_51 = ""
				local var_4_52 = manager.audio:GetAudioName("bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_53 = 2
			local var_4_54 = 0.15

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_55 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_55:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_56 = arg_1_1:FormatText(StoryNameCfg[600].name)

				arg_1_1.leftNameTxt_.text = var_4_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_57 = arg_1_1:GetWordFromCfg(410232001)
				local var_4_58 = arg_1_1:FormatText(var_4_57.content)

				arg_1_1.text_.text = var_4_58

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_59 = 6
				local var_4_60 = utf8.len(var_4_58)
				local var_4_61 = var_4_59 <= 0 and var_4_54 or var_4_54 * (var_4_60 / var_4_59)

				if var_4_61 > 0 and var_4_54 < var_4_61 then
					arg_1_1.talkMaxDuration = var_4_61
					var_4_53 = var_4_53 + 0.3

					if var_4_61 + var_4_53 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_61 + var_4_53
					end
				end

				arg_1_1.text_.text = var_4_58
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232001", "story_v_out_410232.awb") ~= 0 then
					local var_4_62 = manager.audio:GetVoiceLength("story_v_out_410232", "410232001", "story_v_out_410232.awb") / 1000

					if var_4_62 + var_4_53 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_53
					end

					if var_4_57.prefab_name ~= "" and arg_1_1.actors_[var_4_57.prefab_name] ~= nil then
						local var_4_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_57.prefab_name].transform, "story_v_out_410232", "410232001", "story_v_out_410232.awb")

						arg_1_1:RecordAudio("410232001", var_4_63)
						arg_1_1:RecordAudio("410232001", var_4_63)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_410232", "410232001", "story_v_out_410232.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_410232", "410232001", "story_v_out_410232.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_64 = var_4_53 + 0.3
			local var_4_65 = math.max(var_4_54, arg_1_1.talkMaxDuration)

			if var_4_64 <= arg_1_1.time_ and arg_1_1.time_ < var_4_64 + var_4_65 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_64) / var_4_65

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_64 + var_4_65 and arg_1_1.time_ < var_4_64 + var_4_65 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play410232002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410232002
		arg_9_1.duration_ = 4.13

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play410232003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1061"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1061")

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

			local var_12_4 = arg_9_1.actors_["1061"].transform
			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1.var_.moveOldPos1061 = var_12_4.localPosition
				var_12_4.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1061", 3)

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
				local var_12_10 = Vector3.New(0, -490, 18)

				var_12_4.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1061, var_12_10, var_12_9)
			end

			if arg_9_1.time_ >= var_12_5 + var_12_8 and arg_9_1.time_ < var_12_5 + var_12_8 + arg_12_0 then
				var_12_4.localPosition = Vector3.New(0, -490, 18)
			end

			local var_12_11 = arg_9_1.actors_["10062"].transform
			local var_12_12 = 0

			if var_12_12 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 then
				arg_9_1.var_.moveOldPos10062 = var_12_11.localPosition
				var_12_11.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10062", 7)

				local var_12_13 = var_12_11.childCount

				for iter_12_3 = 0, var_12_13 - 1 do
					local var_12_14 = var_12_11:GetChild(iter_12_3)

					if var_12_14.name == "" or not string.find(var_12_14.name, "split") then
						var_12_14.gameObject:SetActive(true)
					else
						var_12_14.gameObject:SetActive(false)
					end
				end
			end

			local var_12_15 = 0.001

			if var_12_12 <= arg_9_1.time_ and arg_9_1.time_ < var_12_12 + var_12_15 then
				local var_12_16 = (arg_9_1.time_ - var_12_12) / var_12_15
				local var_12_17 = Vector3.New(0, -2000, -290)

				var_12_11.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10062, var_12_17, var_12_16)
			end

			if arg_9_1.time_ >= var_12_12 + var_12_15 and arg_9_1.time_ < var_12_12 + var_12_15 + arg_12_0 then
				var_12_11.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_12_18 = arg_9_1.actors_["1061"]
			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 and not isNil(var_12_18) and arg_9_1.var_.actorSpriteComps1061 == nil then
				arg_9_1.var_.actorSpriteComps1061 = var_12_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_20 = 0.034

			if var_12_19 <= arg_9_1.time_ and arg_9_1.time_ < var_12_19 + var_12_20 and not isNil(var_12_18) then
				local var_12_21 = (arg_9_1.time_ - var_12_19) / var_12_20

				if arg_9_1.var_.actorSpriteComps1061 then
					for iter_12_4, iter_12_5 in pairs(arg_9_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_12_5 then
							if arg_9_1.isInRecall_ then
								local var_12_22 = Mathf.Lerp(iter_12_5.color.r, arg_9_1.hightColor1.r, var_12_21)
								local var_12_23 = Mathf.Lerp(iter_12_5.color.g, arg_9_1.hightColor1.g, var_12_21)
								local var_12_24 = Mathf.Lerp(iter_12_5.color.b, arg_9_1.hightColor1.b, var_12_21)

								iter_12_5.color = Color.New(var_12_22, var_12_23, var_12_24)
							else
								local var_12_25 = Mathf.Lerp(iter_12_5.color.r, 1, var_12_21)

								iter_12_5.color = Color.New(var_12_25, var_12_25, var_12_25)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_19 + var_12_20 and arg_9_1.time_ < var_12_19 + var_12_20 + arg_12_0 and not isNil(var_12_18) and arg_9_1.var_.actorSpriteComps1061 then
				for iter_12_6, iter_12_7 in pairs(arg_9_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_12_7 then
						if arg_9_1.isInRecall_ then
							iter_12_7.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps1061 = nil
			end

			local var_12_26 = arg_9_1.actors_["10062"]
			local var_12_27 = 0

			if var_12_27 < arg_9_1.time_ and arg_9_1.time_ <= var_12_27 + arg_12_0 and not isNil(var_12_26) and arg_9_1.var_.actorSpriteComps10062 == nil then
				arg_9_1.var_.actorSpriteComps10062 = var_12_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_28 = 0.034

			if var_12_27 <= arg_9_1.time_ and arg_9_1.time_ < var_12_27 + var_12_28 and not isNil(var_12_26) then
				local var_12_29 = (arg_9_1.time_ - var_12_27) / var_12_28

				if arg_9_1.var_.actorSpriteComps10062 then
					for iter_12_8, iter_12_9 in pairs(arg_9_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_12_9 then
							if arg_9_1.isInRecall_ then
								local var_12_30 = Mathf.Lerp(iter_12_9.color.r, arg_9_1.hightColor2.r, var_12_29)
								local var_12_31 = Mathf.Lerp(iter_12_9.color.g, arg_9_1.hightColor2.g, var_12_29)
								local var_12_32 = Mathf.Lerp(iter_12_9.color.b, arg_9_1.hightColor2.b, var_12_29)

								iter_12_9.color = Color.New(var_12_30, var_12_31, var_12_32)
							else
								local var_12_33 = Mathf.Lerp(iter_12_9.color.r, 0.5, var_12_29)

								iter_12_9.color = Color.New(var_12_33, var_12_33, var_12_33)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_27 + var_12_28 and arg_9_1.time_ < var_12_27 + var_12_28 + arg_12_0 and not isNil(var_12_26) and arg_9_1.var_.actorSpriteComps10062 then
				for iter_12_10, iter_12_11 in pairs(arg_9_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_12_11 then
						if arg_9_1.isInRecall_ then
							iter_12_11.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10062 = nil
			end

			local var_12_34 = 0
			local var_12_35 = 0.175

			if var_12_34 < arg_9_1.time_ and arg_9_1.time_ <= var_12_34 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_36 = arg_9_1:FormatText(StoryNameCfg[612].name)

				arg_9_1.leftNameTxt_.text = var_12_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_37 = arg_9_1:GetWordFromCfg(410232002)
				local var_12_38 = arg_9_1:FormatText(var_12_37.content)

				arg_9_1.text_.text = var_12_38

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_39 = 7
				local var_12_40 = utf8.len(var_12_38)
				local var_12_41 = var_12_39 <= 0 and var_12_35 or var_12_35 * (var_12_40 / var_12_39)

				if var_12_41 > 0 and var_12_35 < var_12_41 then
					arg_9_1.talkMaxDuration = var_12_41

					if var_12_41 + var_12_34 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_41 + var_12_34
					end
				end

				arg_9_1.text_.text = var_12_38
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232002", "story_v_out_410232.awb") ~= 0 then
					local var_12_42 = manager.audio:GetVoiceLength("story_v_out_410232", "410232002", "story_v_out_410232.awb") / 1000

					if var_12_42 + var_12_34 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_42 + var_12_34
					end

					if var_12_37.prefab_name ~= "" and arg_9_1.actors_[var_12_37.prefab_name] ~= nil then
						local var_12_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_37.prefab_name].transform, "story_v_out_410232", "410232002", "story_v_out_410232.awb")

						arg_9_1:RecordAudio("410232002", var_12_43)
						arg_9_1:RecordAudio("410232002", var_12_43)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_410232", "410232002", "story_v_out_410232.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_410232", "410232002", "story_v_out_410232.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_44 = math.max(var_12_35, arg_9_1.talkMaxDuration)

			if var_12_34 <= arg_9_1.time_ and arg_9_1.time_ < var_12_34 + var_12_44 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_34) / var_12_44

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_34 + var_12_44 and arg_9_1.time_ < var_12_34 + var_12_44 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410232003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play410232004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1061"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1061 = var_16_0.localPosition
				var_16_0.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1061", 7)

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
				local var_16_6 = Vector3.New(0, -2000, 18)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1061, var_16_6, var_16_5)
			end

			if arg_13_1.time_ >= var_16_1 + var_16_4 and arg_13_1.time_ < var_16_1 + var_16_4 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_16_7 = arg_13_1.actors_["1061"]
			local var_16_8 = 0

			if var_16_8 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps1061 == nil then
				arg_13_1.var_.actorSpriteComps1061 = var_16_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_9 = 0.034

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_9 and not isNil(var_16_7) then
				local var_16_10 = (arg_13_1.time_ - var_16_8) / var_16_9

				if arg_13_1.var_.actorSpriteComps1061 then
					for iter_16_1, iter_16_2 in pairs(arg_13_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_13_1.time_ >= var_16_8 + var_16_9 and arg_13_1.time_ < var_16_8 + var_16_9 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps1061 then
				for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_16_4 then
						if arg_13_1.isInRecall_ then
							iter_16_4.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1061 = nil
			end

			local var_16_15 = 0
			local var_16_16 = 1.45

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_17 = arg_13_1:GetWordFromCfg(410232003)
				local var_16_18 = arg_13_1:FormatText(var_16_17.content)

				arg_13_1.text_.text = var_16_18

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_19 = 58
				local var_16_20 = utf8.len(var_16_18)
				local var_16_21 = var_16_19 <= 0 and var_16_16 or var_16_16 * (var_16_20 / var_16_19)

				if var_16_21 > 0 and var_16_16 < var_16_21 then
					arg_13_1.talkMaxDuration = var_16_21

					if var_16_21 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_21 + var_16_15
					end
				end

				arg_13_1.text_.text = var_16_18
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_22 = math.max(var_16_16, arg_13_1.talkMaxDuration)

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_22 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_15) / var_16_22

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_15 + var_16_22 and arg_13_1.time_ < var_16_15 + var_16_22 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410232004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410232004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play410232005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.9

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_2 = arg_17_1:GetWordFromCfg(410232004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 36
				local var_20_5 = utf8.len(var_20_3)
				local var_20_6 = var_20_4 <= 0 and var_20_1 or var_20_1 * (var_20_5 / var_20_4)

				if var_20_6 > 0 and var_20_1 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_7 and arg_17_1.time_ < var_20_0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play410232005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410232005
		arg_21_1.duration_ = 7.1

		local var_21_0 = {
			ja = 7.1,
			CriLanguages = 6.333,
			zh = 6.333
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
				arg_21_0:Play410232006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10062"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos10062 = var_24_0.localPosition
				var_24_0.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10062", 3)

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
				local var_24_6 = Vector3.New(0, -390, -290)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10062, var_24_6, var_24_5)
			end

			if arg_21_1.time_ >= var_24_1 + var_24_4 and arg_21_1.time_ < var_24_1 + var_24_4 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, -390, -290)
			end

			local var_24_7 = arg_21_1.actors_["10062"]
			local var_24_8 = 0

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 and not isNil(var_24_7) and arg_21_1.var_.actorSpriteComps10062 == nil then
				arg_21_1.var_.actorSpriteComps10062 = var_24_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_9 = 0.034

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_9 and not isNil(var_24_7) then
				local var_24_10 = (arg_21_1.time_ - var_24_8) / var_24_9

				if arg_21_1.var_.actorSpriteComps10062 then
					for iter_24_1, iter_24_2 in pairs(arg_21_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_24_2 then
							if arg_21_1.isInRecall_ then
								local var_24_11 = Mathf.Lerp(iter_24_2.color.r, arg_21_1.hightColor1.r, var_24_10)
								local var_24_12 = Mathf.Lerp(iter_24_2.color.g, arg_21_1.hightColor1.g, var_24_10)
								local var_24_13 = Mathf.Lerp(iter_24_2.color.b, arg_21_1.hightColor1.b, var_24_10)

								iter_24_2.color = Color.New(var_24_11, var_24_12, var_24_13)
							else
								local var_24_14 = Mathf.Lerp(iter_24_2.color.r, 1, var_24_10)

								iter_24_2.color = Color.New(var_24_14, var_24_14, var_24_14)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_8 + var_24_9 and arg_21_1.time_ < var_24_8 + var_24_9 + arg_24_0 and not isNil(var_24_7) and arg_21_1.var_.actorSpriteComps10062 then
				for iter_24_3, iter_24_4 in pairs(arg_21_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_24_4 then
						if arg_21_1.isInRecall_ then
							iter_24_4.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10062 = nil
			end

			local var_24_15 = 0
			local var_24_16 = 0.625

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_17 = arg_21_1:FormatText(StoryNameCfg[600].name)

				arg_21_1.leftNameTxt_.text = var_24_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_18 = arg_21_1:GetWordFromCfg(410232005)
				local var_24_19 = arg_21_1:FormatText(var_24_18.content)

				arg_21_1.text_.text = var_24_19

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_20 = 25
				local var_24_21 = utf8.len(var_24_19)
				local var_24_22 = var_24_20 <= 0 and var_24_16 or var_24_16 * (var_24_21 / var_24_20)

				if var_24_22 > 0 and var_24_16 < var_24_22 then
					arg_21_1.talkMaxDuration = var_24_22

					if var_24_22 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_22 + var_24_15
					end
				end

				arg_21_1.text_.text = var_24_19
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232005", "story_v_out_410232.awb") ~= 0 then
					local var_24_23 = manager.audio:GetVoiceLength("story_v_out_410232", "410232005", "story_v_out_410232.awb") / 1000

					if var_24_23 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_15
					end

					if var_24_18.prefab_name ~= "" and arg_21_1.actors_[var_24_18.prefab_name] ~= nil then
						local var_24_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_18.prefab_name].transform, "story_v_out_410232", "410232005", "story_v_out_410232.awb")

						arg_21_1:RecordAudio("410232005", var_24_24)
						arg_21_1:RecordAudio("410232005", var_24_24)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410232", "410232005", "story_v_out_410232.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410232", "410232005", "story_v_out_410232.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_25 = math.max(var_24_16, arg_21_1.talkMaxDuration)

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_25 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_15) / var_24_25

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_15 + var_24_25 and arg_21_1.time_ < var_24_15 + var_24_25 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410232006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play410232007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10062"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos10062 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10062", 7)

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
				local var_28_6 = Vector3.New(0, -2000, -290)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10062, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_28_7 = arg_25_1.actors_["10062"]
			local var_28_8 = 0

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps10062 == nil then
				arg_25_1.var_.actorSpriteComps10062 = var_28_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_9 = 0.034

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_9 and not isNil(var_28_7) then
				local var_28_10 = (arg_25_1.time_ - var_28_8) / var_28_9

				if arg_25_1.var_.actorSpriteComps10062 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_28_2 then
							if arg_25_1.isInRecall_ then
								local var_28_11 = Mathf.Lerp(iter_28_2.color.r, arg_25_1.hightColor2.r, var_28_10)
								local var_28_12 = Mathf.Lerp(iter_28_2.color.g, arg_25_1.hightColor2.g, var_28_10)
								local var_28_13 = Mathf.Lerp(iter_28_2.color.b, arg_25_1.hightColor2.b, var_28_10)

								iter_28_2.color = Color.New(var_28_11, var_28_12, var_28_13)
							else
								local var_28_14 = Mathf.Lerp(iter_28_2.color.r, 0.5, var_28_10)

								iter_28_2.color = Color.New(var_28_14, var_28_14, var_28_14)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_8 + var_28_9 and arg_25_1.time_ < var_28_8 + var_28_9 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps10062 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_28_4 then
						if arg_25_1.isInRecall_ then
							iter_28_4.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10062 = nil
			end

			local var_28_15 = 0
			local var_28_16 = 1.55

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_17 = arg_25_1:GetWordFromCfg(410232006)
				local var_28_18 = arg_25_1:FormatText(var_28_17.content)

				arg_25_1.text_.text = var_28_18

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_19 = 62
				local var_28_20 = utf8.len(var_28_18)
				local var_28_21 = var_28_19 <= 0 and var_28_16 or var_28_16 * (var_28_20 / var_28_19)

				if var_28_21 > 0 and var_28_16 < var_28_21 then
					arg_25_1.talkMaxDuration = var_28_21

					if var_28_21 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_21 + var_28_15
					end
				end

				arg_25_1.text_.text = var_28_18
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_22 = math.max(var_28_16, arg_25_1.talkMaxDuration)

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_22 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_15) / var_28_22

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_15 + var_28_22 and arg_25_1.time_ < var_28_15 + var_28_22 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410232007
		arg_29_1.duration_ = 12.43

		local var_29_0 = {
			ja = 12.433,
			CriLanguages = 4.833,
			zh = 4.833
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
				arg_29_0:Play410232008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10062"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos10062 = var_32_0.localPosition
				var_32_0.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10062", 3)

				local var_32_2 = var_32_0.childCount

				for iter_32_0 = 0, var_32_2 - 1 do
					local var_32_3 = var_32_0:GetChild(iter_32_0)

					if var_32_3.name == "split_5" or not string.find(var_32_3.name, "split") then
						var_32_3.gameObject:SetActive(true)
					else
						var_32_3.gameObject:SetActive(false)
					end
				end
			end

			local var_32_4 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_4 then
				local var_32_5 = (arg_29_1.time_ - var_32_1) / var_32_4
				local var_32_6 = Vector3.New(0, -390, -290)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10062, var_32_6, var_32_5)
			end

			if arg_29_1.time_ >= var_32_1 + var_32_4 and arg_29_1.time_ < var_32_1 + var_32_4 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, -390, -290)
			end

			local var_32_7 = arg_29_1.actors_["10062"]
			local var_32_8 = 0

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.actorSpriteComps10062 == nil then
				arg_29_1.var_.actorSpriteComps10062 = var_32_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_9 = 0.034

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_9 and not isNil(var_32_7) then
				local var_32_10 = (arg_29_1.time_ - var_32_8) / var_32_9

				if arg_29_1.var_.actorSpriteComps10062 then
					for iter_32_1, iter_32_2 in pairs(arg_29_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_29_1.time_ >= var_32_8 + var_32_9 and arg_29_1.time_ < var_32_8 + var_32_9 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.actorSpriteComps10062 then
				for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_32_4 then
						if arg_29_1.isInRecall_ then
							iter_32_4.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10062 = nil
			end

			local var_32_15 = 0
			local var_32_16 = 0.45

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_17 = arg_29_1:FormatText(StoryNameCfg[600].name)

				arg_29_1.leftNameTxt_.text = var_32_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_18 = arg_29_1:GetWordFromCfg(410232007)
				local var_32_19 = arg_29_1:FormatText(var_32_18.content)

				arg_29_1.text_.text = var_32_19

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_20 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232007", "story_v_out_410232.awb") ~= 0 then
					local var_32_23 = manager.audio:GetVoiceLength("story_v_out_410232", "410232007", "story_v_out_410232.awb") / 1000

					if var_32_23 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_23 + var_32_15
					end

					if var_32_18.prefab_name ~= "" and arg_29_1.actors_[var_32_18.prefab_name] ~= nil then
						local var_32_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_18.prefab_name].transform, "story_v_out_410232", "410232007", "story_v_out_410232.awb")

						arg_29_1:RecordAudio("410232007", var_32_24)
						arg_29_1:RecordAudio("410232007", var_32_24)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_410232", "410232007", "story_v_out_410232.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_410232", "410232007", "story_v_out_410232.awb")
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
				actorName = "10062",
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
	Play410232008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410232008
		arg_33_1.duration_ = 7

		local var_33_0 = {
			ja = 7,
			CriLanguages = 4.966,
			zh = 4.966
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
				arg_33_0:Play410232009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10062"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos10062 = var_36_0.localPosition
				var_36_0.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10062", 7)

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
				local var_36_6 = Vector3.New(0, -2000, -290)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10062, var_36_6, var_36_5)
			end

			if arg_33_1.time_ >= var_36_1 + var_36_4 and arg_33_1.time_ < var_36_1 + var_36_4 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_36_7 = arg_33_1.actors_["1061"].transform
			local var_36_8 = 0

			if var_36_8 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.var_.moveOldPos1061 = var_36_7.localPosition
				var_36_7.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1061", 3)

				local var_36_9 = var_36_7.childCount

				for iter_36_1 = 0, var_36_9 - 1 do
					local var_36_10 = var_36_7:GetChild(iter_36_1)

					if var_36_10.name == "split_5" or not string.find(var_36_10.name, "split") then
						var_36_10.gameObject:SetActive(true)
					else
						var_36_10.gameObject:SetActive(false)
					end
				end
			end

			local var_36_11 = 0.001

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_11 then
				local var_36_12 = (arg_33_1.time_ - var_36_8) / var_36_11
				local var_36_13 = Vector3.New(0, -490, 18)

				var_36_7.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1061, var_36_13, var_36_12)
			end

			if arg_33_1.time_ >= var_36_8 + var_36_11 and arg_33_1.time_ < var_36_8 + var_36_11 + arg_36_0 then
				var_36_7.localPosition = Vector3.New(0, -490, 18)
			end

			local var_36_14 = arg_33_1.actors_["10062"]
			local var_36_15 = 0

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.actorSpriteComps10062 == nil then
				arg_33_1.var_.actorSpriteComps10062 = var_36_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_16 = 0.034

			if var_36_15 <= arg_33_1.time_ and arg_33_1.time_ < var_36_15 + var_36_16 and not isNil(var_36_14) then
				local var_36_17 = (arg_33_1.time_ - var_36_15) / var_36_16

				if arg_33_1.var_.actorSpriteComps10062 then
					for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_36_3 then
							if arg_33_1.isInRecall_ then
								local var_36_18 = Mathf.Lerp(iter_36_3.color.r, arg_33_1.hightColor2.r, var_36_17)
								local var_36_19 = Mathf.Lerp(iter_36_3.color.g, arg_33_1.hightColor2.g, var_36_17)
								local var_36_20 = Mathf.Lerp(iter_36_3.color.b, arg_33_1.hightColor2.b, var_36_17)

								iter_36_3.color = Color.New(var_36_18, var_36_19, var_36_20)
							else
								local var_36_21 = Mathf.Lerp(iter_36_3.color.r, 0.5, var_36_17)

								iter_36_3.color = Color.New(var_36_21, var_36_21, var_36_21)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_15 + var_36_16 and arg_33_1.time_ < var_36_15 + var_36_16 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.actorSpriteComps10062 then
				for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_36_5 then
						if arg_33_1.isInRecall_ then
							iter_36_5.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10062 = nil
			end

			local var_36_22 = arg_33_1.actors_["1061"]
			local var_36_23 = 0

			if var_36_23 < arg_33_1.time_ and arg_33_1.time_ <= var_36_23 + arg_36_0 and not isNil(var_36_22) and arg_33_1.var_.actorSpriteComps1061 == nil then
				arg_33_1.var_.actorSpriteComps1061 = var_36_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_24 = 0.034

			if var_36_23 <= arg_33_1.time_ and arg_33_1.time_ < var_36_23 + var_36_24 and not isNil(var_36_22) then
				local var_36_25 = (arg_33_1.time_ - var_36_23) / var_36_24

				if arg_33_1.var_.actorSpriteComps1061 then
					for iter_36_6, iter_36_7 in pairs(arg_33_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_36_7 then
							if arg_33_1.isInRecall_ then
								local var_36_26 = Mathf.Lerp(iter_36_7.color.r, arg_33_1.hightColor1.r, var_36_25)
								local var_36_27 = Mathf.Lerp(iter_36_7.color.g, arg_33_1.hightColor1.g, var_36_25)
								local var_36_28 = Mathf.Lerp(iter_36_7.color.b, arg_33_1.hightColor1.b, var_36_25)

								iter_36_7.color = Color.New(var_36_26, var_36_27, var_36_28)
							else
								local var_36_29 = Mathf.Lerp(iter_36_7.color.r, 1, var_36_25)

								iter_36_7.color = Color.New(var_36_29, var_36_29, var_36_29)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_23 + var_36_24 and arg_33_1.time_ < var_36_23 + var_36_24 + arg_36_0 and not isNil(var_36_22) and arg_33_1.var_.actorSpriteComps1061 then
				for iter_36_8, iter_36_9 in pairs(arg_33_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_36_9 then
						if arg_33_1.isInRecall_ then
							iter_36_9.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps1061 = nil
			end

			local var_36_30 = 0
			local var_36_31 = 0.35

			if var_36_30 < arg_33_1.time_ and arg_33_1.time_ <= var_36_30 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_32 = arg_33_1:FormatText(StoryNameCfg[612].name)

				arg_33_1.leftNameTxt_.text = var_36_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_33 = arg_33_1:GetWordFromCfg(410232008)
				local var_36_34 = arg_33_1:FormatText(var_36_33.content)

				arg_33_1.text_.text = var_36_34

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_35 = 14
				local var_36_36 = utf8.len(var_36_34)
				local var_36_37 = var_36_35 <= 0 and var_36_31 or var_36_31 * (var_36_36 / var_36_35)

				if var_36_37 > 0 and var_36_31 < var_36_37 then
					arg_33_1.talkMaxDuration = var_36_37

					if var_36_37 + var_36_30 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_37 + var_36_30
					end
				end

				arg_33_1.text_.text = var_36_34
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232008", "story_v_out_410232.awb") ~= 0 then
					local var_36_38 = manager.audio:GetVoiceLength("story_v_out_410232", "410232008", "story_v_out_410232.awb") / 1000

					if var_36_38 + var_36_30 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_38 + var_36_30
					end

					if var_36_33.prefab_name ~= "" and arg_33_1.actors_[var_36_33.prefab_name] ~= nil then
						local var_36_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_33.prefab_name].transform, "story_v_out_410232", "410232008", "story_v_out_410232.awb")

						arg_33_1:RecordAudio("410232008", var_36_39)
						arg_33_1:RecordAudio("410232008", var_36_39)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_410232", "410232008", "story_v_out_410232.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_410232", "410232008", "story_v_out_410232.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_40 = math.max(var_36_31, arg_33_1.talkMaxDuration)

			if var_36_30 <= arg_33_1.time_ and arg_33_1.time_ < var_36_30 + var_36_40 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_30) / var_36_40

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_30 + var_36_40 and arg_33_1.time_ < var_36_30 + var_36_40 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
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
	Play410232009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410232009
		arg_37_1.duration_ = 4.9

		local var_37_0 = {
			ja = 4.9,
			CriLanguages = 2.466,
			zh = 2.466
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
				arg_37_0:Play410232010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1061"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1061 = var_40_0.localPosition
				var_40_0.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1061", 7)

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
				local var_40_6 = Vector3.New(0, -2000, 18)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1061, var_40_6, var_40_5)
			end

			if arg_37_1.time_ >= var_40_1 + var_40_4 and arg_37_1.time_ < var_40_1 + var_40_4 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_40_7 = arg_37_1.actors_["10062"].transform
			local var_40_8 = 0

			if var_40_8 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.var_.moveOldPos10062 = var_40_7.localPosition
				var_40_7.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10062", 3)

				local var_40_9 = var_40_7.childCount

				for iter_40_1 = 0, var_40_9 - 1 do
					local var_40_10 = var_40_7:GetChild(iter_40_1)

					if var_40_10.name == "" or not string.find(var_40_10.name, "split") then
						var_40_10.gameObject:SetActive(true)
					else
						var_40_10.gameObject:SetActive(false)
					end
				end
			end

			local var_40_11 = 0.001

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_11 then
				local var_40_12 = (arg_37_1.time_ - var_40_8) / var_40_11
				local var_40_13 = Vector3.New(0, -390, -290)

				var_40_7.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10062, var_40_13, var_40_12)
			end

			if arg_37_1.time_ >= var_40_8 + var_40_11 and arg_37_1.time_ < var_40_8 + var_40_11 + arg_40_0 then
				var_40_7.localPosition = Vector3.New(0, -390, -290)
			end

			local var_40_14 = arg_37_1.actors_["1061"]
			local var_40_15 = 0

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 and not isNil(var_40_14) and arg_37_1.var_.actorSpriteComps1061 == nil then
				arg_37_1.var_.actorSpriteComps1061 = var_40_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_16 = 0.034

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_16 and not isNil(var_40_14) then
				local var_40_17 = (arg_37_1.time_ - var_40_15) / var_40_16

				if arg_37_1.var_.actorSpriteComps1061 then
					for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_40_3 then
							if arg_37_1.isInRecall_ then
								local var_40_18 = Mathf.Lerp(iter_40_3.color.r, arg_37_1.hightColor2.r, var_40_17)
								local var_40_19 = Mathf.Lerp(iter_40_3.color.g, arg_37_1.hightColor2.g, var_40_17)
								local var_40_20 = Mathf.Lerp(iter_40_3.color.b, arg_37_1.hightColor2.b, var_40_17)

								iter_40_3.color = Color.New(var_40_18, var_40_19, var_40_20)
							else
								local var_40_21 = Mathf.Lerp(iter_40_3.color.r, 0.5, var_40_17)

								iter_40_3.color = Color.New(var_40_21, var_40_21, var_40_21)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_15 + var_40_16 and arg_37_1.time_ < var_40_15 + var_40_16 + arg_40_0 and not isNil(var_40_14) and arg_37_1.var_.actorSpriteComps1061 then
				for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_40_5 then
						if arg_37_1.isInRecall_ then
							iter_40_5.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps1061 = nil
			end

			local var_40_22 = arg_37_1.actors_["10062"]
			local var_40_23 = 0

			if var_40_23 < arg_37_1.time_ and arg_37_1.time_ <= var_40_23 + arg_40_0 and not isNil(var_40_22) and arg_37_1.var_.actorSpriteComps10062 == nil then
				arg_37_1.var_.actorSpriteComps10062 = var_40_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_24 = 0.034

			if var_40_23 <= arg_37_1.time_ and arg_37_1.time_ < var_40_23 + var_40_24 and not isNil(var_40_22) then
				local var_40_25 = (arg_37_1.time_ - var_40_23) / var_40_24

				if arg_37_1.var_.actorSpriteComps10062 then
					for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_40_7 then
							if arg_37_1.isInRecall_ then
								local var_40_26 = Mathf.Lerp(iter_40_7.color.r, arg_37_1.hightColor1.r, var_40_25)
								local var_40_27 = Mathf.Lerp(iter_40_7.color.g, arg_37_1.hightColor1.g, var_40_25)
								local var_40_28 = Mathf.Lerp(iter_40_7.color.b, arg_37_1.hightColor1.b, var_40_25)

								iter_40_7.color = Color.New(var_40_26, var_40_27, var_40_28)
							else
								local var_40_29 = Mathf.Lerp(iter_40_7.color.r, 1, var_40_25)

								iter_40_7.color = Color.New(var_40_29, var_40_29, var_40_29)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_23 + var_40_24 and arg_37_1.time_ < var_40_23 + var_40_24 + arg_40_0 and not isNil(var_40_22) and arg_37_1.var_.actorSpriteComps10062 then
				for iter_40_8, iter_40_9 in pairs(arg_37_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_40_9 then
						if arg_37_1.isInRecall_ then
							iter_40_9.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10062 = nil
			end

			local var_40_30 = 0
			local var_40_31 = 0.175

			if var_40_30 < arg_37_1.time_ and arg_37_1.time_ <= var_40_30 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_32 = arg_37_1:FormatText(StoryNameCfg[600].name)

				arg_37_1.leftNameTxt_.text = var_40_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_33 = arg_37_1:GetWordFromCfg(410232009)
				local var_40_34 = arg_37_1:FormatText(var_40_33.content)

				arg_37_1.text_.text = var_40_34

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_35 = 7
				local var_40_36 = utf8.len(var_40_34)
				local var_40_37 = var_40_35 <= 0 and var_40_31 or var_40_31 * (var_40_36 / var_40_35)

				if var_40_37 > 0 and var_40_31 < var_40_37 then
					arg_37_1.talkMaxDuration = var_40_37

					if var_40_37 + var_40_30 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_37 + var_40_30
					end
				end

				arg_37_1.text_.text = var_40_34
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232009", "story_v_out_410232.awb") ~= 0 then
					local var_40_38 = manager.audio:GetVoiceLength("story_v_out_410232", "410232009", "story_v_out_410232.awb") / 1000

					if var_40_38 + var_40_30 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_38 + var_40_30
					end

					if var_40_33.prefab_name ~= "" and arg_37_1.actors_[var_40_33.prefab_name] ~= nil then
						local var_40_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_33.prefab_name].transform, "story_v_out_410232", "410232009", "story_v_out_410232.awb")

						arg_37_1:RecordAudio("410232009", var_40_39)
						arg_37_1:RecordAudio("410232009", var_40_39)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_410232", "410232009", "story_v_out_410232.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_410232", "410232009", "story_v_out_410232.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_40 = math.max(var_40_31, arg_37_1.talkMaxDuration)

			if var_40_30 <= arg_37_1.time_ and arg_37_1.time_ < var_40_30 + var_40_40 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_30) / var_40_40

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_30 + var_40_40 and arg_37_1.time_ < var_40_30 + var_40_40 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410232010
		arg_41_1.duration_ = 16.87

		local var_41_0 = {
			ja = 16.866,
			CriLanguages = 8.466,
			zh = 8.466
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
				arg_41_0:Play410232011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10062"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos10062 = var_44_0.localPosition
				var_44_0.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10062", 3)

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
				local var_44_6 = Vector3.New(0, -390, -290)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10062, var_44_6, var_44_5)
			end

			if arg_41_1.time_ >= var_44_1 + var_44_4 and arg_41_1.time_ < var_44_1 + var_44_4 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(0, -390, -290)
			end

			local var_44_7 = arg_41_1.actors_["10062"]
			local var_44_8 = 0

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.actorSpriteComps10062 == nil then
				arg_41_1.var_.actorSpriteComps10062 = var_44_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_9 = 0.034

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_9 and not isNil(var_44_7) then
				local var_44_10 = (arg_41_1.time_ - var_44_8) / var_44_9

				if arg_41_1.var_.actorSpriteComps10062 then
					for iter_44_1, iter_44_2 in pairs(arg_41_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_41_1.time_ >= var_44_8 + var_44_9 and arg_41_1.time_ < var_44_8 + var_44_9 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.actorSpriteComps10062 then
				for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_44_4 then
						if arg_41_1.isInRecall_ then
							iter_44_4.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10062 = nil
			end

			local var_44_15 = 0
			local var_44_16 = 0.9

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_17 = arg_41_1:FormatText(StoryNameCfg[600].name)

				arg_41_1.leftNameTxt_.text = var_44_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_18 = arg_41_1:GetWordFromCfg(410232010)
				local var_44_19 = arg_41_1:FormatText(var_44_18.content)

				arg_41_1.text_.text = var_44_19

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_20 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232010", "story_v_out_410232.awb") ~= 0 then
					local var_44_23 = manager.audio:GetVoiceLength("story_v_out_410232", "410232010", "story_v_out_410232.awb") / 1000

					if var_44_23 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_23 + var_44_15
					end

					if var_44_18.prefab_name ~= "" and arg_41_1.actors_[var_44_18.prefab_name] ~= nil then
						local var_44_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_18.prefab_name].transform, "story_v_out_410232", "410232010", "story_v_out_410232.awb")

						arg_41_1:RecordAudio("410232010", var_44_24)
						arg_41_1:RecordAudio("410232010", var_44_24)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_410232", "410232010", "story_v_out_410232.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_410232", "410232010", "story_v_out_410232.awb")
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
				actorName = "10062",
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
	Play410232011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410232011
		arg_45_1.duration_ = 12.03

		local var_45_0 = {
			ja = 12.033,
			CriLanguages = 5.133,
			zh = 5.133
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
				arg_45_0:Play410232012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10062"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos10062 = var_48_0.localPosition
				var_48_0.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10062", 3)

				local var_48_2 = var_48_0.childCount

				for iter_48_0 = 0, var_48_2 - 1 do
					local var_48_3 = var_48_0:GetChild(iter_48_0)

					if var_48_3.name == "" or not string.find(var_48_3.name, "split") then
						var_48_3.gameObject:SetActive(true)
					else
						var_48_3.gameObject:SetActive(false)
					end
				end
			end

			local var_48_4 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_4 then
				local var_48_5 = (arg_45_1.time_ - var_48_1) / var_48_4
				local var_48_6 = Vector3.New(0, -390, -290)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10062, var_48_6, var_48_5)
			end

			if arg_45_1.time_ >= var_48_1 + var_48_4 and arg_45_1.time_ < var_48_1 + var_48_4 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0, -390, -290)
			end

			local var_48_7 = arg_45_1.actors_["10062"]
			local var_48_8 = 0

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps10062 == nil then
				arg_45_1.var_.actorSpriteComps10062 = var_48_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_9 = 0.034

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_9 and not isNil(var_48_7) then
				local var_48_10 = (arg_45_1.time_ - var_48_8) / var_48_9

				if arg_45_1.var_.actorSpriteComps10062 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_48_2 then
							if arg_45_1.isInRecall_ then
								local var_48_11 = Mathf.Lerp(iter_48_2.color.r, arg_45_1.hightColor1.r, var_48_10)
								local var_48_12 = Mathf.Lerp(iter_48_2.color.g, arg_45_1.hightColor1.g, var_48_10)
								local var_48_13 = Mathf.Lerp(iter_48_2.color.b, arg_45_1.hightColor1.b, var_48_10)

								iter_48_2.color = Color.New(var_48_11, var_48_12, var_48_13)
							else
								local var_48_14 = Mathf.Lerp(iter_48_2.color.r, 1, var_48_10)

								iter_48_2.color = Color.New(var_48_14, var_48_14, var_48_14)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_8 + var_48_9 and arg_45_1.time_ < var_48_8 + var_48_9 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps10062 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_48_4 then
						if arg_45_1.isInRecall_ then
							iter_48_4.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10062 = nil
			end

			local var_48_15 = 0
			local var_48_16 = 0.5

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_17 = arg_45_1:FormatText(StoryNameCfg[600].name)

				arg_45_1.leftNameTxt_.text = var_48_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_18 = arg_45_1:GetWordFromCfg(410232011)
				local var_48_19 = arg_45_1:FormatText(var_48_18.content)

				arg_45_1.text_.text = var_48_19

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_20 = 20
				local var_48_21 = utf8.len(var_48_19)
				local var_48_22 = var_48_20 <= 0 and var_48_16 or var_48_16 * (var_48_21 / var_48_20)

				if var_48_22 > 0 and var_48_16 < var_48_22 then
					arg_45_1.talkMaxDuration = var_48_22

					if var_48_22 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_22 + var_48_15
					end
				end

				arg_45_1.text_.text = var_48_19
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232011", "story_v_out_410232.awb") ~= 0 then
					local var_48_23 = manager.audio:GetVoiceLength("story_v_out_410232", "410232011", "story_v_out_410232.awb") / 1000

					if var_48_23 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_23 + var_48_15
					end

					if var_48_18.prefab_name ~= "" and arg_45_1.actors_[var_48_18.prefab_name] ~= nil then
						local var_48_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_18.prefab_name].transform, "story_v_out_410232", "410232011", "story_v_out_410232.awb")

						arg_45_1:RecordAudio("410232011", var_48_24)
						arg_45_1:RecordAudio("410232011", var_48_24)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_410232", "410232011", "story_v_out_410232.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_410232", "410232011", "story_v_out_410232.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_25 = math.max(var_48_16, arg_45_1.talkMaxDuration)

			if var_48_15 <= arg_45_1.time_ and arg_45_1.time_ < var_48_15 + var_48_25 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_15) / var_48_25

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_15 + var_48_25 and arg_45_1.time_ < var_48_15 + var_48_25 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410232012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play410232013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10062"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos10062 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10062", 7)

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
				local var_52_6 = Vector3.New(0, -2000, -290)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10062, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_52_7 = arg_49_1.actors_["10062"]
			local var_52_8 = 0

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps10062 == nil then
				arg_49_1.var_.actorSpriteComps10062 = var_52_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_9 = 0.034

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_9 and not isNil(var_52_7) then
				local var_52_10 = (arg_49_1.time_ - var_52_8) / var_52_9

				if arg_49_1.var_.actorSpriteComps10062 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_49_1.time_ >= var_52_8 + var_52_9 and arg_49_1.time_ < var_52_8 + var_52_9 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps10062 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_52_4 then
						if arg_49_1.isInRecall_ then
							iter_52_4.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10062 = nil
			end

			local var_52_15 = 0
			local var_52_16 = 1.475

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

				local var_52_17 = arg_49_1:GetWordFromCfg(410232012)
				local var_52_18 = arg_49_1:FormatText(var_52_17.content)

				arg_49_1.text_.text = var_52_18

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_19 = 59
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
				actorName = "10062",
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
	Play410232013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410232013
		arg_53_1.duration_ = 5.8

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play410232014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_1 = 1

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_1 then
				local var_56_2 = (arg_53_1.time_ - var_56_0) / var_56_1
				local var_56_3 = Color.New(1, 1, 1)

				var_56_3.a = Mathf.Lerp(1, 0, var_56_2)
				arg_53_1.mask_.color = var_56_3
			end

			if arg_53_1.time_ >= var_56_0 + var_56_1 and arg_53_1.time_ < var_56_0 + var_56_1 + arg_56_0 then
				local var_56_4 = Color.New(1, 1, 1)
				local var_56_5 = 0

				arg_53_1.mask_.enabled = false
				var_56_4.a = var_56_5
				arg_53_1.mask_.color = var_56_4
			end

			local var_56_6 = manager.ui.mainCamera.transform
			local var_56_7 = 0

			if var_56_7 < arg_53_1.time_ and arg_53_1.time_ <= var_56_7 + arg_56_0 then
				arg_53_1.var_.shakeOldPos = var_56_6.localPosition
			end

			local var_56_8 = 1

			if var_56_7 <= arg_53_1.time_ and arg_53_1.time_ < var_56_7 + var_56_8 then
				local var_56_9 = (arg_53_1.time_ - var_56_7) / 0.066
				local var_56_10, var_56_11 = math.modf(var_56_9)

				var_56_6.localPosition = Vector3.New(var_56_11 * 0.13, var_56_11 * 0.13, var_56_11 * 0.13) + arg_53_1.var_.shakeOldPos
			end

			if arg_53_1.time_ >= var_56_7 + var_56_8 and arg_53_1.time_ < var_56_7 + var_56_8 + arg_56_0 then
				var_56_6.localPosition = arg_53_1.var_.shakeOldPos
			end

			if arg_53_1.frameCnt_ <= 1 then
				arg_53_1.dialog_:SetActive(false)
			end

			local var_56_12 = 0.8
			local var_56_13 = 1.125

			if var_56_12 < arg_53_1.time_ and arg_53_1.time_ <= var_56_12 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_14 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_14:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_53_1.dialogCg_.alpha = arg_57_0
				end))
				var_56_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_15 = arg_53_1:GetWordFromCfg(410232013)
				local var_56_16 = arg_53_1:FormatText(var_56_15.content)

				arg_53_1.text_.text = var_56_16

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_17 = 45
				local var_56_18 = utf8.len(var_56_16)
				local var_56_19 = var_56_17 <= 0 and var_56_13 or var_56_13 * (var_56_18 / var_56_17)

				if var_56_19 > 0 and var_56_13 < var_56_19 then
					arg_53_1.talkMaxDuration = var_56_19
					var_56_12 = var_56_12 + 0.3

					if var_56_19 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_19 + var_56_12
					end
				end

				arg_53_1.text_.text = var_56_16
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_20 = var_56_12 + 0.3
			local var_56_21 = math.max(var_56_13, arg_53_1.talkMaxDuration)

			if var_56_20 <= arg_53_1.time_ and arg_53_1.time_ < var_56_20 + var_56_21 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_20) / var_56_21

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_20 + var_56_21 and arg_53_1.time_ < var_56_20 + var_56_21 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play410232014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 410232014
		arg_59_1.duration_ = 13.6

		local var_59_0 = {
			ja = 13.6,
			CriLanguages = 8.366,
			zh = 8.366
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
				arg_59_0:Play410232015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["10062"].transform
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.var_.moveOldPos10062 = var_62_0.localPosition
				var_62_0.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("10062", 2)

				local var_62_2 = var_62_0.childCount

				for iter_62_0 = 0, var_62_2 - 1 do
					local var_62_3 = var_62_0:GetChild(iter_62_0)

					if var_62_3.name == "" or not string.find(var_62_3.name, "split") then
						var_62_3.gameObject:SetActive(true)
					else
						var_62_3.gameObject:SetActive(false)
					end
				end
			end

			local var_62_4 = 0.001

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_4 then
				local var_62_5 = (arg_59_1.time_ - var_62_1) / var_62_4
				local var_62_6 = Vector3.New(-370, -390, -290)

				var_62_0.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10062, var_62_6, var_62_5)
			end

			if arg_59_1.time_ >= var_62_1 + var_62_4 and arg_59_1.time_ < var_62_1 + var_62_4 + arg_62_0 then
				var_62_0.localPosition = Vector3.New(-370, -390, -290)
			end

			local var_62_7 = "10059"

			if arg_59_1.actors_[var_62_7] == nil then
				local var_62_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10059")

				if not isNil(var_62_8) then
					local var_62_9 = Object.Instantiate(var_62_8, arg_59_1.canvasGo_.transform)

					var_62_9.transform:SetSiblingIndex(1)

					var_62_9.name = var_62_7
					var_62_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_59_1.actors_[var_62_7] = var_62_9

					local var_62_10 = var_62_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_59_1.isInRecall_ then
						for iter_62_1, iter_62_2 in ipairs(var_62_10) do
							iter_62_2.color = arg_59_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_62_11 = arg_59_1.actors_["10059"].transform
			local var_62_12 = 0

			if var_62_12 < arg_59_1.time_ and arg_59_1.time_ <= var_62_12 + arg_62_0 then
				arg_59_1.var_.moveOldPos10059 = var_62_11.localPosition
				var_62_11.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("10059", 4)

				local var_62_13 = var_62_11.childCount

				for iter_62_3 = 0, var_62_13 - 1 do
					local var_62_14 = var_62_11:GetChild(iter_62_3)

					if var_62_14.name == "" or not string.find(var_62_14.name, "split") then
						var_62_14.gameObject:SetActive(true)
					else
						var_62_14.gameObject:SetActive(false)
					end
				end
			end

			local var_62_15 = 0.001

			if var_62_12 <= arg_59_1.time_ and arg_59_1.time_ < var_62_12 + var_62_15 then
				local var_62_16 = (arg_59_1.time_ - var_62_12) / var_62_15
				local var_62_17 = Vector3.New(390, -530, 35)

				var_62_11.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10059, var_62_17, var_62_16)
			end

			if arg_59_1.time_ >= var_62_12 + var_62_15 and arg_59_1.time_ < var_62_12 + var_62_15 + arg_62_0 then
				var_62_11.localPosition = Vector3.New(390, -530, 35)
			end

			local var_62_18 = arg_59_1.actors_["10062"]
			local var_62_19 = 0

			if var_62_19 < arg_59_1.time_ and arg_59_1.time_ <= var_62_19 + arg_62_0 and not isNil(var_62_18) and arg_59_1.var_.actorSpriteComps10062 == nil then
				arg_59_1.var_.actorSpriteComps10062 = var_62_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_20 = 0.034

			if var_62_19 <= arg_59_1.time_ and arg_59_1.time_ < var_62_19 + var_62_20 and not isNil(var_62_18) then
				local var_62_21 = (arg_59_1.time_ - var_62_19) / var_62_20

				if arg_59_1.var_.actorSpriteComps10062 then
					for iter_62_4, iter_62_5 in pairs(arg_59_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_62_5 then
							if arg_59_1.isInRecall_ then
								local var_62_22 = Mathf.Lerp(iter_62_5.color.r, arg_59_1.hightColor1.r, var_62_21)
								local var_62_23 = Mathf.Lerp(iter_62_5.color.g, arg_59_1.hightColor1.g, var_62_21)
								local var_62_24 = Mathf.Lerp(iter_62_5.color.b, arg_59_1.hightColor1.b, var_62_21)

								iter_62_5.color = Color.New(var_62_22, var_62_23, var_62_24)
							else
								local var_62_25 = Mathf.Lerp(iter_62_5.color.r, 1, var_62_21)

								iter_62_5.color = Color.New(var_62_25, var_62_25, var_62_25)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= var_62_19 + var_62_20 and arg_59_1.time_ < var_62_19 + var_62_20 + arg_62_0 and not isNil(var_62_18) and arg_59_1.var_.actorSpriteComps10062 then
				for iter_62_6, iter_62_7 in pairs(arg_59_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_62_7 then
						if arg_59_1.isInRecall_ then
							iter_62_7.color = arg_59_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_62_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_59_1.var_.actorSpriteComps10062 = nil
			end

			local var_62_26 = arg_59_1.actors_["10059"]
			local var_62_27 = 0

			if var_62_27 < arg_59_1.time_ and arg_59_1.time_ <= var_62_27 + arg_62_0 and not isNil(var_62_26) and arg_59_1.var_.actorSpriteComps10059 == nil then
				arg_59_1.var_.actorSpriteComps10059 = var_62_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_28 = 0.034

			if var_62_27 <= arg_59_1.time_ and arg_59_1.time_ < var_62_27 + var_62_28 and not isNil(var_62_26) then
				local var_62_29 = (arg_59_1.time_ - var_62_27) / var_62_28

				if arg_59_1.var_.actorSpriteComps10059 then
					for iter_62_8, iter_62_9 in pairs(arg_59_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_62_9 then
							if arg_59_1.isInRecall_ then
								local var_62_30 = Mathf.Lerp(iter_62_9.color.r, arg_59_1.hightColor2.r, var_62_29)
								local var_62_31 = Mathf.Lerp(iter_62_9.color.g, arg_59_1.hightColor2.g, var_62_29)
								local var_62_32 = Mathf.Lerp(iter_62_9.color.b, arg_59_1.hightColor2.b, var_62_29)

								iter_62_9.color = Color.New(var_62_30, var_62_31, var_62_32)
							else
								local var_62_33 = Mathf.Lerp(iter_62_9.color.r, 0.5, var_62_29)

								iter_62_9.color = Color.New(var_62_33, var_62_33, var_62_33)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= var_62_27 + var_62_28 and arg_59_1.time_ < var_62_27 + var_62_28 + arg_62_0 and not isNil(var_62_26) and arg_59_1.var_.actorSpriteComps10059 then
				for iter_62_10, iter_62_11 in pairs(arg_59_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_62_11 then
						if arg_59_1.isInRecall_ then
							iter_62_11.color = arg_59_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_62_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_59_1.var_.actorSpriteComps10059 = nil
			end

			local var_62_34 = 0
			local var_62_35 = 0.9

			if var_62_34 < arg_59_1.time_ and arg_59_1.time_ <= var_62_34 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_36 = arg_59_1:FormatText(StoryNameCfg[600].name)

				arg_59_1.leftNameTxt_.text = var_62_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_37 = arg_59_1:GetWordFromCfg(410232014)
				local var_62_38 = arg_59_1:FormatText(var_62_37.content)

				arg_59_1.text_.text = var_62_38

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_39 = 36
				local var_62_40 = utf8.len(var_62_38)
				local var_62_41 = var_62_39 <= 0 and var_62_35 or var_62_35 * (var_62_40 / var_62_39)

				if var_62_41 > 0 and var_62_35 < var_62_41 then
					arg_59_1.talkMaxDuration = var_62_41

					if var_62_41 + var_62_34 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_41 + var_62_34
					end
				end

				arg_59_1.text_.text = var_62_38
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232014", "story_v_out_410232.awb") ~= 0 then
					local var_62_42 = manager.audio:GetVoiceLength("story_v_out_410232", "410232014", "story_v_out_410232.awb") / 1000

					if var_62_42 + var_62_34 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_42 + var_62_34
					end

					if var_62_37.prefab_name ~= "" and arg_59_1.actors_[var_62_37.prefab_name] ~= nil then
						local var_62_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_37.prefab_name].transform, "story_v_out_410232", "410232014", "story_v_out_410232.awb")

						arg_59_1:RecordAudio("410232014", var_62_43)
						arg_59_1:RecordAudio("410232014", var_62_43)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_410232", "410232014", "story_v_out_410232.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_410232", "410232014", "story_v_out_410232.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_44 = math.max(var_62_35, arg_59_1.talkMaxDuration)

			if var_62_34 <= arg_59_1.time_ and arg_59_1.time_ < var_62_34 + var_62_44 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_34) / var_62_44

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_34 + var_62_44 and arg_59_1.time_ < var_62_34 + var_62_44 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play410232015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 410232015
		arg_63_1.duration_ = 1.6

		local var_63_0 = {
			ja = 1.566,
			CriLanguages = 1.6,
			zh = 1.6
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
				arg_63_0:Play410232016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["10059"].transform
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.var_.moveOldPos10059 = var_66_0.localPosition
				var_66_0.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("10059", 4)

				local var_66_2 = var_66_0.childCount

				for iter_66_0 = 0, var_66_2 - 1 do
					local var_66_3 = var_66_0:GetChild(iter_66_0)

					if var_66_3.name == "" or not string.find(var_66_3.name, "split") then
						var_66_3.gameObject:SetActive(true)
					else
						var_66_3.gameObject:SetActive(false)
					end
				end
			end

			local var_66_4 = 0.001

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_4 then
				local var_66_5 = (arg_63_1.time_ - var_66_1) / var_66_4
				local var_66_6 = Vector3.New(390, -530, 35)

				var_66_0.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10059, var_66_6, var_66_5)
			end

			if arg_63_1.time_ >= var_66_1 + var_66_4 and arg_63_1.time_ < var_66_1 + var_66_4 + arg_66_0 then
				var_66_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_66_7 = arg_63_1.actors_["10059"]
			local var_66_8 = 0

			if var_66_8 < arg_63_1.time_ and arg_63_1.time_ <= var_66_8 + arg_66_0 and not isNil(var_66_7) and arg_63_1.var_.actorSpriteComps10059 == nil then
				arg_63_1.var_.actorSpriteComps10059 = var_66_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_9 = 0.034

			if var_66_8 <= arg_63_1.time_ and arg_63_1.time_ < var_66_8 + var_66_9 and not isNil(var_66_7) then
				local var_66_10 = (arg_63_1.time_ - var_66_8) / var_66_9

				if arg_63_1.var_.actorSpriteComps10059 then
					for iter_66_1, iter_66_2 in pairs(arg_63_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_66_2 then
							if arg_63_1.isInRecall_ then
								local var_66_11 = Mathf.Lerp(iter_66_2.color.r, arg_63_1.hightColor1.r, var_66_10)
								local var_66_12 = Mathf.Lerp(iter_66_2.color.g, arg_63_1.hightColor1.g, var_66_10)
								local var_66_13 = Mathf.Lerp(iter_66_2.color.b, arg_63_1.hightColor1.b, var_66_10)

								iter_66_2.color = Color.New(var_66_11, var_66_12, var_66_13)
							else
								local var_66_14 = Mathf.Lerp(iter_66_2.color.r, 1, var_66_10)

								iter_66_2.color = Color.New(var_66_14, var_66_14, var_66_14)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= var_66_8 + var_66_9 and arg_63_1.time_ < var_66_8 + var_66_9 + arg_66_0 and not isNil(var_66_7) and arg_63_1.var_.actorSpriteComps10059 then
				for iter_66_3, iter_66_4 in pairs(arg_63_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_66_4 then
						if arg_63_1.isInRecall_ then
							iter_66_4.color = arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_66_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_63_1.var_.actorSpriteComps10059 = nil
			end

			local var_66_15 = arg_63_1.actors_["10062"]
			local var_66_16 = 0

			if var_66_16 < arg_63_1.time_ and arg_63_1.time_ <= var_66_16 + arg_66_0 and not isNil(var_66_15) and arg_63_1.var_.actorSpriteComps10062 == nil then
				arg_63_1.var_.actorSpriteComps10062 = var_66_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_17 = 0.034

			if var_66_16 <= arg_63_1.time_ and arg_63_1.time_ < var_66_16 + var_66_17 and not isNil(var_66_15) then
				local var_66_18 = (arg_63_1.time_ - var_66_16) / var_66_17

				if arg_63_1.var_.actorSpriteComps10062 then
					for iter_66_5, iter_66_6 in pairs(arg_63_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_66_6 then
							if arg_63_1.isInRecall_ then
								local var_66_19 = Mathf.Lerp(iter_66_6.color.r, arg_63_1.hightColor2.r, var_66_18)
								local var_66_20 = Mathf.Lerp(iter_66_6.color.g, arg_63_1.hightColor2.g, var_66_18)
								local var_66_21 = Mathf.Lerp(iter_66_6.color.b, arg_63_1.hightColor2.b, var_66_18)

								iter_66_6.color = Color.New(var_66_19, var_66_20, var_66_21)
							else
								local var_66_22 = Mathf.Lerp(iter_66_6.color.r, 0.5, var_66_18)

								iter_66_6.color = Color.New(var_66_22, var_66_22, var_66_22)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= var_66_16 + var_66_17 and arg_63_1.time_ < var_66_16 + var_66_17 + arg_66_0 and not isNil(var_66_15) and arg_63_1.var_.actorSpriteComps10062 then
				for iter_66_7, iter_66_8 in pairs(arg_63_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_66_8 then
						if arg_63_1.isInRecall_ then
							iter_66_8.color = arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_66_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_63_1.var_.actorSpriteComps10062 = nil
			end

			local var_66_23 = 0
			local var_66_24 = 0.175

			if var_66_23 < arg_63_1.time_ and arg_63_1.time_ <= var_66_23 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_25 = arg_63_1:FormatText(StoryNameCfg[596].name)

				arg_63_1.leftNameTxt_.text = var_66_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_26 = arg_63_1:GetWordFromCfg(410232015)
				local var_66_27 = arg_63_1:FormatText(var_66_26.content)

				arg_63_1.text_.text = var_66_27

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_28 = 7
				local var_66_29 = utf8.len(var_66_27)
				local var_66_30 = var_66_28 <= 0 and var_66_24 or var_66_24 * (var_66_29 / var_66_28)

				if var_66_30 > 0 and var_66_24 < var_66_30 then
					arg_63_1.talkMaxDuration = var_66_30

					if var_66_30 + var_66_23 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_30 + var_66_23
					end
				end

				arg_63_1.text_.text = var_66_27
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232015", "story_v_out_410232.awb") ~= 0 then
					local var_66_31 = manager.audio:GetVoiceLength("story_v_out_410232", "410232015", "story_v_out_410232.awb") / 1000

					if var_66_31 + var_66_23 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_31 + var_66_23
					end

					if var_66_26.prefab_name ~= "" and arg_63_1.actors_[var_66_26.prefab_name] ~= nil then
						local var_66_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_26.prefab_name].transform, "story_v_out_410232", "410232015", "story_v_out_410232.awb")

						arg_63_1:RecordAudio("410232015", var_66_32)
						arg_63_1:RecordAudio("410232015", var_66_32)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_410232", "410232015", "story_v_out_410232.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_410232", "410232015", "story_v_out_410232.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_33 = math.max(var_66_24, arg_63_1.talkMaxDuration)

			if var_66_23 <= arg_63_1.time_ and arg_63_1.time_ < var_66_23 + var_66_33 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_23) / var_66_33

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_23 + var_66_33 and arg_63_1.time_ < var_66_23 + var_66_33 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
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
	Play410232016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 410232016
		arg_67_1.duration_ = 13.3

		local var_67_0 = {
			ja = 13.3,
			CriLanguages = 8.2,
			zh = 8.2
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
				arg_67_0:Play410232017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["10062"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos10062 = var_70_0.localPosition
				var_70_0.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("10062", 2)

				local var_70_2 = var_70_0.childCount

				for iter_70_0 = 0, var_70_2 - 1 do
					local var_70_3 = var_70_0:GetChild(iter_70_0)

					if var_70_3.name == "" or not string.find(var_70_3.name, "split") then
						var_70_3.gameObject:SetActive(true)
					else
						var_70_3.gameObject:SetActive(false)
					end
				end
			end

			local var_70_4 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_4 then
				local var_70_5 = (arg_67_1.time_ - var_70_1) / var_70_4
				local var_70_6 = Vector3.New(-370, -390, -290)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos10062, var_70_6, var_70_5)
			end

			if arg_67_1.time_ >= var_70_1 + var_70_4 and arg_67_1.time_ < var_70_1 + var_70_4 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(-370, -390, -290)
			end

			local var_70_7 = arg_67_1.actors_["10059"]
			local var_70_8 = 0

			if var_70_8 < arg_67_1.time_ and arg_67_1.time_ <= var_70_8 + arg_70_0 and not isNil(var_70_7) and arg_67_1.var_.actorSpriteComps10059 == nil then
				arg_67_1.var_.actorSpriteComps10059 = var_70_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_9 = 0.034

			if var_70_8 <= arg_67_1.time_ and arg_67_1.time_ < var_70_8 + var_70_9 and not isNil(var_70_7) then
				local var_70_10 = (arg_67_1.time_ - var_70_8) / var_70_9

				if arg_67_1.var_.actorSpriteComps10059 then
					for iter_70_1, iter_70_2 in pairs(arg_67_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_70_2 then
							if arg_67_1.isInRecall_ then
								local var_70_11 = Mathf.Lerp(iter_70_2.color.r, arg_67_1.hightColor2.r, var_70_10)
								local var_70_12 = Mathf.Lerp(iter_70_2.color.g, arg_67_1.hightColor2.g, var_70_10)
								local var_70_13 = Mathf.Lerp(iter_70_2.color.b, arg_67_1.hightColor2.b, var_70_10)

								iter_70_2.color = Color.New(var_70_11, var_70_12, var_70_13)
							else
								local var_70_14 = Mathf.Lerp(iter_70_2.color.r, 0.5, var_70_10)

								iter_70_2.color = Color.New(var_70_14, var_70_14, var_70_14)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= var_70_8 + var_70_9 and arg_67_1.time_ < var_70_8 + var_70_9 + arg_70_0 and not isNil(var_70_7) and arg_67_1.var_.actorSpriteComps10059 then
				for iter_70_3, iter_70_4 in pairs(arg_67_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_70_4 then
						if arg_67_1.isInRecall_ then
							iter_70_4.color = arg_67_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_70_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_67_1.var_.actorSpriteComps10059 = nil
			end

			local var_70_15 = arg_67_1.actors_["10062"]
			local var_70_16 = 0

			if var_70_16 < arg_67_1.time_ and arg_67_1.time_ <= var_70_16 + arg_70_0 and not isNil(var_70_15) and arg_67_1.var_.actorSpriteComps10062 == nil then
				arg_67_1.var_.actorSpriteComps10062 = var_70_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_17 = 0.034

			if var_70_16 <= arg_67_1.time_ and arg_67_1.time_ < var_70_16 + var_70_17 and not isNil(var_70_15) then
				local var_70_18 = (arg_67_1.time_ - var_70_16) / var_70_17

				if arg_67_1.var_.actorSpriteComps10062 then
					for iter_70_5, iter_70_6 in pairs(arg_67_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_70_6 then
							if arg_67_1.isInRecall_ then
								local var_70_19 = Mathf.Lerp(iter_70_6.color.r, arg_67_1.hightColor1.r, var_70_18)
								local var_70_20 = Mathf.Lerp(iter_70_6.color.g, arg_67_1.hightColor1.g, var_70_18)
								local var_70_21 = Mathf.Lerp(iter_70_6.color.b, arg_67_1.hightColor1.b, var_70_18)

								iter_70_6.color = Color.New(var_70_19, var_70_20, var_70_21)
							else
								local var_70_22 = Mathf.Lerp(iter_70_6.color.r, 1, var_70_18)

								iter_70_6.color = Color.New(var_70_22, var_70_22, var_70_22)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= var_70_16 + var_70_17 and arg_67_1.time_ < var_70_16 + var_70_17 + arg_70_0 and not isNil(var_70_15) and arg_67_1.var_.actorSpriteComps10062 then
				for iter_70_7, iter_70_8 in pairs(arg_67_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_70_8 then
						if arg_67_1.isInRecall_ then
							iter_70_8.color = arg_67_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_70_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_67_1.var_.actorSpriteComps10062 = nil
			end

			local var_70_23 = 0
			local var_70_24 = 0.8

			if var_70_23 < arg_67_1.time_ and arg_67_1.time_ <= var_70_23 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_25 = arg_67_1:FormatText(StoryNameCfg[600].name)

				arg_67_1.leftNameTxt_.text = var_70_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_26 = arg_67_1:GetWordFromCfg(410232016)
				local var_70_27 = arg_67_1:FormatText(var_70_26.content)

				arg_67_1.text_.text = var_70_27

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_28 = 32
				local var_70_29 = utf8.len(var_70_27)
				local var_70_30 = var_70_28 <= 0 and var_70_24 or var_70_24 * (var_70_29 / var_70_28)

				if var_70_30 > 0 and var_70_24 < var_70_30 then
					arg_67_1.talkMaxDuration = var_70_30

					if var_70_30 + var_70_23 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_30 + var_70_23
					end
				end

				arg_67_1.text_.text = var_70_27
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232016", "story_v_out_410232.awb") ~= 0 then
					local var_70_31 = manager.audio:GetVoiceLength("story_v_out_410232", "410232016", "story_v_out_410232.awb") / 1000

					if var_70_31 + var_70_23 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_31 + var_70_23
					end

					if var_70_26.prefab_name ~= "" and arg_67_1.actors_[var_70_26.prefab_name] ~= nil then
						local var_70_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_26.prefab_name].transform, "story_v_out_410232", "410232016", "story_v_out_410232.awb")

						arg_67_1:RecordAudio("410232016", var_70_32)
						arg_67_1:RecordAudio("410232016", var_70_32)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_410232", "410232016", "story_v_out_410232.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_410232", "410232016", "story_v_out_410232.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_33 = math.max(var_70_24, arg_67_1.talkMaxDuration)

			if var_70_23 <= arg_67_1.time_ and arg_67_1.time_ < var_70_23 + var_70_33 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_23) / var_70_33

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_23 + var_70_33 and arg_67_1.time_ < var_70_23 + var_70_33 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play410232017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 410232017
		arg_71_1.duration_ = 17.67

		local var_71_0 = {
			ja = 17.666,
			CriLanguages = 9.2,
			zh = 9.2
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
				arg_71_0:Play410232018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["10062"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos10062 = var_74_0.localPosition
				var_74_0.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("10062", 2)

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
				local var_74_6 = Vector3.New(-370, -390, -290)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10062, var_74_6, var_74_5)
			end

			if arg_71_1.time_ >= var_74_1 + var_74_4 and arg_71_1.time_ < var_74_1 + var_74_4 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(-370, -390, -290)
			end

			local var_74_7 = arg_71_1.actors_["10062"]
			local var_74_8 = 0

			if var_74_8 < arg_71_1.time_ and arg_71_1.time_ <= var_74_8 + arg_74_0 and not isNil(var_74_7) and arg_71_1.var_.actorSpriteComps10062 == nil then
				arg_71_1.var_.actorSpriteComps10062 = var_74_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_9 = 0.034

			if var_74_8 <= arg_71_1.time_ and arg_71_1.time_ < var_74_8 + var_74_9 and not isNil(var_74_7) then
				local var_74_10 = (arg_71_1.time_ - var_74_8) / var_74_9

				if arg_71_1.var_.actorSpriteComps10062 then
					for iter_74_1, iter_74_2 in pairs(arg_71_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_74_2 then
							if arg_71_1.isInRecall_ then
								local var_74_11 = Mathf.Lerp(iter_74_2.color.r, arg_71_1.hightColor1.r, var_74_10)
								local var_74_12 = Mathf.Lerp(iter_74_2.color.g, arg_71_1.hightColor1.g, var_74_10)
								local var_74_13 = Mathf.Lerp(iter_74_2.color.b, arg_71_1.hightColor1.b, var_74_10)

								iter_74_2.color = Color.New(var_74_11, var_74_12, var_74_13)
							else
								local var_74_14 = Mathf.Lerp(iter_74_2.color.r, 1, var_74_10)

								iter_74_2.color = Color.New(var_74_14, var_74_14, var_74_14)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= var_74_8 + var_74_9 and arg_71_1.time_ < var_74_8 + var_74_9 + arg_74_0 and not isNil(var_74_7) and arg_71_1.var_.actorSpriteComps10062 then
				for iter_74_3, iter_74_4 in pairs(arg_71_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_74_4 then
						if arg_71_1.isInRecall_ then
							iter_74_4.color = arg_71_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_74_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_71_1.var_.actorSpriteComps10062 = nil
			end

			local var_74_15 = 0
			local var_74_16 = 1

			if var_74_15 < arg_71_1.time_ and arg_71_1.time_ <= var_74_15 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_17 = arg_71_1:FormatText(StoryNameCfg[600].name)

				arg_71_1.leftNameTxt_.text = var_74_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_18 = arg_71_1:GetWordFromCfg(410232017)
				local var_74_19 = arg_71_1:FormatText(var_74_18.content)

				arg_71_1.text_.text = var_74_19

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_20 = 40
				local var_74_21 = utf8.len(var_74_19)
				local var_74_22 = var_74_20 <= 0 and var_74_16 or var_74_16 * (var_74_21 / var_74_20)

				if var_74_22 > 0 and var_74_16 < var_74_22 then
					arg_71_1.talkMaxDuration = var_74_22

					if var_74_22 + var_74_15 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_22 + var_74_15
					end
				end

				arg_71_1.text_.text = var_74_19
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232017", "story_v_out_410232.awb") ~= 0 then
					local var_74_23 = manager.audio:GetVoiceLength("story_v_out_410232", "410232017", "story_v_out_410232.awb") / 1000

					if var_74_23 + var_74_15 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_23 + var_74_15
					end

					if var_74_18.prefab_name ~= "" and arg_71_1.actors_[var_74_18.prefab_name] ~= nil then
						local var_74_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_18.prefab_name].transform, "story_v_out_410232", "410232017", "story_v_out_410232.awb")

						arg_71_1:RecordAudio("410232017", var_74_24)
						arg_71_1:RecordAudio("410232017", var_74_24)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_410232", "410232017", "story_v_out_410232.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_410232", "410232017", "story_v_out_410232.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_25 = math.max(var_74_16, arg_71_1.talkMaxDuration)

			if var_74_15 <= arg_71_1.time_ and arg_71_1.time_ < var_74_15 + var_74_25 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_15) / var_74_25

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_15 + var_74_25 and arg_71_1.time_ < var_74_15 + var_74_25 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 410232018
		arg_75_1.duration_ = 1.63

		local var_75_0 = {
			ja = 1.4,
			CriLanguages = 1.633,
			zh = 1.633
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
				arg_75_0:Play410232019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["10059"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos10059 = var_78_0.localPosition
				var_78_0.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("10059", 4)

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
				local var_78_6 = Vector3.New(390, -530, 35)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10059, var_78_6, var_78_5)
			end

			if arg_75_1.time_ >= var_78_1 + var_78_4 and arg_75_1.time_ < var_78_1 + var_78_4 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_78_7 = arg_75_1.actors_["10059"]
			local var_78_8 = 0

			if var_78_8 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 and not isNil(var_78_7) and arg_75_1.var_.actorSpriteComps10059 == nil then
				arg_75_1.var_.actorSpriteComps10059 = var_78_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_9 = 0.034

			if var_78_8 <= arg_75_1.time_ and arg_75_1.time_ < var_78_8 + var_78_9 and not isNil(var_78_7) then
				local var_78_10 = (arg_75_1.time_ - var_78_8) / var_78_9

				if arg_75_1.var_.actorSpriteComps10059 then
					for iter_78_1, iter_78_2 in pairs(arg_75_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_78_2 then
							if arg_75_1.isInRecall_ then
								local var_78_11 = Mathf.Lerp(iter_78_2.color.r, arg_75_1.hightColor1.r, var_78_10)
								local var_78_12 = Mathf.Lerp(iter_78_2.color.g, arg_75_1.hightColor1.g, var_78_10)
								local var_78_13 = Mathf.Lerp(iter_78_2.color.b, arg_75_1.hightColor1.b, var_78_10)

								iter_78_2.color = Color.New(var_78_11, var_78_12, var_78_13)
							else
								local var_78_14 = Mathf.Lerp(iter_78_2.color.r, 1, var_78_10)

								iter_78_2.color = Color.New(var_78_14, var_78_14, var_78_14)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= var_78_8 + var_78_9 and arg_75_1.time_ < var_78_8 + var_78_9 + arg_78_0 and not isNil(var_78_7) and arg_75_1.var_.actorSpriteComps10059 then
				for iter_78_3, iter_78_4 in pairs(arg_75_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_78_4 then
						if arg_75_1.isInRecall_ then
							iter_78_4.color = arg_75_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_78_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_75_1.var_.actorSpriteComps10059 = nil
			end

			local var_78_15 = arg_75_1.actors_["10062"]
			local var_78_16 = 0

			if var_78_16 < arg_75_1.time_ and arg_75_1.time_ <= var_78_16 + arg_78_0 and not isNil(var_78_15) and arg_75_1.var_.actorSpriteComps10062 == nil then
				arg_75_1.var_.actorSpriteComps10062 = var_78_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_17 = 0.034

			if var_78_16 <= arg_75_1.time_ and arg_75_1.time_ < var_78_16 + var_78_17 and not isNil(var_78_15) then
				local var_78_18 = (arg_75_1.time_ - var_78_16) / var_78_17

				if arg_75_1.var_.actorSpriteComps10062 then
					for iter_78_5, iter_78_6 in pairs(arg_75_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_78_6 then
							if arg_75_1.isInRecall_ then
								local var_78_19 = Mathf.Lerp(iter_78_6.color.r, arg_75_1.hightColor2.r, var_78_18)
								local var_78_20 = Mathf.Lerp(iter_78_6.color.g, arg_75_1.hightColor2.g, var_78_18)
								local var_78_21 = Mathf.Lerp(iter_78_6.color.b, arg_75_1.hightColor2.b, var_78_18)

								iter_78_6.color = Color.New(var_78_19, var_78_20, var_78_21)
							else
								local var_78_22 = Mathf.Lerp(iter_78_6.color.r, 0.5, var_78_18)

								iter_78_6.color = Color.New(var_78_22, var_78_22, var_78_22)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= var_78_16 + var_78_17 and arg_75_1.time_ < var_78_16 + var_78_17 + arg_78_0 and not isNil(var_78_15) and arg_75_1.var_.actorSpriteComps10062 then
				for iter_78_7, iter_78_8 in pairs(arg_75_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_78_8 then
						if arg_75_1.isInRecall_ then
							iter_78_8.color = arg_75_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_78_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_75_1.var_.actorSpriteComps10062 = nil
			end

			local var_78_23 = 0
			local var_78_24 = 0.1

			if var_78_23 < arg_75_1.time_ and arg_75_1.time_ <= var_78_23 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_25 = arg_75_1:FormatText(StoryNameCfg[596].name)

				arg_75_1.leftNameTxt_.text = var_78_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_26 = arg_75_1:GetWordFromCfg(410232018)
				local var_78_27 = arg_75_1:FormatText(var_78_26.content)

				arg_75_1.text_.text = var_78_27

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_28 = 4
				local var_78_29 = utf8.len(var_78_27)
				local var_78_30 = var_78_28 <= 0 and var_78_24 or var_78_24 * (var_78_29 / var_78_28)

				if var_78_30 > 0 and var_78_24 < var_78_30 then
					arg_75_1.talkMaxDuration = var_78_30

					if var_78_30 + var_78_23 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_30 + var_78_23
					end
				end

				arg_75_1.text_.text = var_78_27
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232018", "story_v_out_410232.awb") ~= 0 then
					local var_78_31 = manager.audio:GetVoiceLength("story_v_out_410232", "410232018", "story_v_out_410232.awb") / 1000

					if var_78_31 + var_78_23 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_31 + var_78_23
					end

					if var_78_26.prefab_name ~= "" and arg_75_1.actors_[var_78_26.prefab_name] ~= nil then
						local var_78_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_26.prefab_name].transform, "story_v_out_410232", "410232018", "story_v_out_410232.awb")

						arg_75_1:RecordAudio("410232018", var_78_32)
						arg_75_1:RecordAudio("410232018", var_78_32)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_410232", "410232018", "story_v_out_410232.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_410232", "410232018", "story_v_out_410232.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_33 = math.max(var_78_24, arg_75_1.talkMaxDuration)

			if var_78_23 <= arg_75_1.time_ and arg_75_1.time_ < var_78_23 + var_78_33 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_23) / var_78_33

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_23 + var_78_33 and arg_75_1.time_ < var_78_23 + var_78_33 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
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
	Play410232019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 410232019
		arg_79_1.duration_ = 3.57

		local var_79_0 = {
			ja = 3.566,
			CriLanguages = 1.833,
			zh = 1.833
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
				arg_79_0:Play410232020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["10062"].transform
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos10062 = var_82_0.localPosition
				var_82_0.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("10062", 7)

				local var_82_2 = var_82_0.childCount

				for iter_82_0 = 0, var_82_2 - 1 do
					local var_82_3 = var_82_0:GetChild(iter_82_0)

					if var_82_3.name == "" or not string.find(var_82_3.name, "split") then
						var_82_3.gameObject:SetActive(true)
					else
						var_82_3.gameObject:SetActive(false)
					end
				end
			end

			local var_82_4 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_4 then
				local var_82_5 = (arg_79_1.time_ - var_82_1) / var_82_4
				local var_82_6 = Vector3.New(0, -2000, -290)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10062, var_82_6, var_82_5)
			end

			if arg_79_1.time_ >= var_82_1 + var_82_4 and arg_79_1.time_ < var_82_1 + var_82_4 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_82_7 = arg_79_1.actors_["10059"].transform
			local var_82_8 = 0

			if var_82_8 < arg_79_1.time_ and arg_79_1.time_ <= var_82_8 + arg_82_0 then
				arg_79_1.var_.moveOldPos10059 = var_82_7.localPosition
				var_82_7.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("10059", 7)

				local var_82_9 = var_82_7.childCount

				for iter_82_1 = 0, var_82_9 - 1 do
					local var_82_10 = var_82_7:GetChild(iter_82_1)

					if var_82_10.name == "" or not string.find(var_82_10.name, "split") then
						var_82_10.gameObject:SetActive(true)
					else
						var_82_10.gameObject:SetActive(false)
					end
				end
			end

			local var_82_11 = 0.001

			if var_82_8 <= arg_79_1.time_ and arg_79_1.time_ < var_82_8 + var_82_11 then
				local var_82_12 = (arg_79_1.time_ - var_82_8) / var_82_11
				local var_82_13 = Vector3.New(0, -2000, 35)

				var_82_7.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10059, var_82_13, var_82_12)
			end

			if arg_79_1.time_ >= var_82_8 + var_82_11 and arg_79_1.time_ < var_82_8 + var_82_11 + arg_82_0 then
				var_82_7.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_82_14 = "10060"

			if arg_79_1.actors_[var_82_14] == nil then
				local var_82_15 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10060")

				if not isNil(var_82_15) then
					local var_82_16 = Object.Instantiate(var_82_15, arg_79_1.canvasGo_.transform)

					var_82_16.transform:SetSiblingIndex(1)

					var_82_16.name = var_82_14
					var_82_16.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_79_1.actors_[var_82_14] = var_82_16

					local var_82_17 = var_82_16:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_79_1.isInRecall_ then
						for iter_82_2, iter_82_3 in ipairs(var_82_17) do
							iter_82_3.color = arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_82_18 = arg_79_1.actors_["10060"].transform
			local var_82_19 = 0

			if var_82_19 < arg_79_1.time_ and arg_79_1.time_ <= var_82_19 + arg_82_0 then
				arg_79_1.var_.moveOldPos10060 = var_82_18.localPosition
				var_82_18.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("10060", 3)

				local var_82_20 = var_82_18.childCount

				for iter_82_4 = 0, var_82_20 - 1 do
					local var_82_21 = var_82_18:GetChild(iter_82_4)

					if var_82_21.name == "split_5" or not string.find(var_82_21.name, "split") then
						var_82_21.gameObject:SetActive(true)
					else
						var_82_21.gameObject:SetActive(false)
					end
				end
			end

			local var_82_22 = 0.001

			if var_82_19 <= arg_79_1.time_ and arg_79_1.time_ < var_82_19 + var_82_22 then
				local var_82_23 = (arg_79_1.time_ - var_82_19) / var_82_22
				local var_82_24 = Vector3.New(0, -400, 0)

				var_82_18.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10060, var_82_24, var_82_23)
			end

			if arg_79_1.time_ >= var_82_19 + var_82_22 and arg_79_1.time_ < var_82_19 + var_82_22 + arg_82_0 then
				var_82_18.localPosition = Vector3.New(0, -400, 0)
			end

			local var_82_25 = arg_79_1.actors_["10062"]
			local var_82_26 = 0

			if var_82_26 < arg_79_1.time_ and arg_79_1.time_ <= var_82_26 + arg_82_0 and not isNil(var_82_25) and arg_79_1.var_.actorSpriteComps10062 == nil then
				arg_79_1.var_.actorSpriteComps10062 = var_82_25:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_27 = 0.034

			if var_82_26 <= arg_79_1.time_ and arg_79_1.time_ < var_82_26 + var_82_27 and not isNil(var_82_25) then
				local var_82_28 = (arg_79_1.time_ - var_82_26) / var_82_27

				if arg_79_1.var_.actorSpriteComps10062 then
					for iter_82_5, iter_82_6 in pairs(arg_79_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_82_6 then
							if arg_79_1.isInRecall_ then
								local var_82_29 = Mathf.Lerp(iter_82_6.color.r, arg_79_1.hightColor2.r, var_82_28)
								local var_82_30 = Mathf.Lerp(iter_82_6.color.g, arg_79_1.hightColor2.g, var_82_28)
								local var_82_31 = Mathf.Lerp(iter_82_6.color.b, arg_79_1.hightColor2.b, var_82_28)

								iter_82_6.color = Color.New(var_82_29, var_82_30, var_82_31)
							else
								local var_82_32 = Mathf.Lerp(iter_82_6.color.r, 0.5, var_82_28)

								iter_82_6.color = Color.New(var_82_32, var_82_32, var_82_32)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= var_82_26 + var_82_27 and arg_79_1.time_ < var_82_26 + var_82_27 + arg_82_0 and not isNil(var_82_25) and arg_79_1.var_.actorSpriteComps10062 then
				for iter_82_7, iter_82_8 in pairs(arg_79_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_82_8 then
						if arg_79_1.isInRecall_ then
							iter_82_8.color = arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_82_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_79_1.var_.actorSpriteComps10062 = nil
			end

			local var_82_33 = arg_79_1.actors_["10059"]
			local var_82_34 = 0

			if var_82_34 < arg_79_1.time_ and arg_79_1.time_ <= var_82_34 + arg_82_0 and not isNil(var_82_33) and arg_79_1.var_.actorSpriteComps10059 == nil then
				arg_79_1.var_.actorSpriteComps10059 = var_82_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_35 = 0.034

			if var_82_34 <= arg_79_1.time_ and arg_79_1.time_ < var_82_34 + var_82_35 and not isNil(var_82_33) then
				local var_82_36 = (arg_79_1.time_ - var_82_34) / var_82_35

				if arg_79_1.var_.actorSpriteComps10059 then
					for iter_82_9, iter_82_10 in pairs(arg_79_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_82_10 then
							if arg_79_1.isInRecall_ then
								local var_82_37 = Mathf.Lerp(iter_82_10.color.r, arg_79_1.hightColor2.r, var_82_36)
								local var_82_38 = Mathf.Lerp(iter_82_10.color.g, arg_79_1.hightColor2.g, var_82_36)
								local var_82_39 = Mathf.Lerp(iter_82_10.color.b, arg_79_1.hightColor2.b, var_82_36)

								iter_82_10.color = Color.New(var_82_37, var_82_38, var_82_39)
							else
								local var_82_40 = Mathf.Lerp(iter_82_10.color.r, 0.5, var_82_36)

								iter_82_10.color = Color.New(var_82_40, var_82_40, var_82_40)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= var_82_34 + var_82_35 and arg_79_1.time_ < var_82_34 + var_82_35 + arg_82_0 and not isNil(var_82_33) and arg_79_1.var_.actorSpriteComps10059 then
				for iter_82_11, iter_82_12 in pairs(arg_79_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_82_12 then
						if arg_79_1.isInRecall_ then
							iter_82_12.color = arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_82_12.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_79_1.var_.actorSpriteComps10059 = nil
			end

			local var_82_41 = arg_79_1.actors_["10060"]
			local var_82_42 = 0

			if var_82_42 < arg_79_1.time_ and arg_79_1.time_ <= var_82_42 + arg_82_0 and not isNil(var_82_41) and arg_79_1.var_.actorSpriteComps10060 == nil then
				arg_79_1.var_.actorSpriteComps10060 = var_82_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_43 = 0.034

			if var_82_42 <= arg_79_1.time_ and arg_79_1.time_ < var_82_42 + var_82_43 and not isNil(var_82_41) then
				local var_82_44 = (arg_79_1.time_ - var_82_42) / var_82_43

				if arg_79_1.var_.actorSpriteComps10060 then
					for iter_82_13, iter_82_14 in pairs(arg_79_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_82_14 then
							if arg_79_1.isInRecall_ then
								local var_82_45 = Mathf.Lerp(iter_82_14.color.r, arg_79_1.hightColor1.r, var_82_44)
								local var_82_46 = Mathf.Lerp(iter_82_14.color.g, arg_79_1.hightColor1.g, var_82_44)
								local var_82_47 = Mathf.Lerp(iter_82_14.color.b, arg_79_1.hightColor1.b, var_82_44)

								iter_82_14.color = Color.New(var_82_45, var_82_46, var_82_47)
							else
								local var_82_48 = Mathf.Lerp(iter_82_14.color.r, 1, var_82_44)

								iter_82_14.color = Color.New(var_82_48, var_82_48, var_82_48)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= var_82_42 + var_82_43 and arg_79_1.time_ < var_82_42 + var_82_43 + arg_82_0 and not isNil(var_82_41) and arg_79_1.var_.actorSpriteComps10060 then
				for iter_82_15, iter_82_16 in pairs(arg_79_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_82_16 then
						if arg_79_1.isInRecall_ then
							iter_82_16.color = arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_82_16.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_79_1.var_.actorSpriteComps10060 = nil
			end

			local var_82_49 = 0
			local var_82_50 = 0.225

			if var_82_49 < arg_79_1.time_ and arg_79_1.time_ <= var_82_49 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_51 = arg_79_1:FormatText(StoryNameCfg[597].name)

				arg_79_1.leftNameTxt_.text = var_82_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_52 = arg_79_1:GetWordFromCfg(410232019)
				local var_82_53 = arg_79_1:FormatText(var_82_52.content)

				arg_79_1.text_.text = var_82_53

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_54 = 9
				local var_82_55 = utf8.len(var_82_53)
				local var_82_56 = var_82_54 <= 0 and var_82_50 or var_82_50 * (var_82_55 / var_82_54)

				if var_82_56 > 0 and var_82_50 < var_82_56 then
					arg_79_1.talkMaxDuration = var_82_56

					if var_82_56 + var_82_49 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_56 + var_82_49
					end
				end

				arg_79_1.text_.text = var_82_53
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232019", "story_v_out_410232.awb") ~= 0 then
					local var_82_57 = manager.audio:GetVoiceLength("story_v_out_410232", "410232019", "story_v_out_410232.awb") / 1000

					if var_82_57 + var_82_49 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_57 + var_82_49
					end

					if var_82_52.prefab_name ~= "" and arg_79_1.actors_[var_82_52.prefab_name] ~= nil then
						local var_82_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_52.prefab_name].transform, "story_v_out_410232", "410232019", "story_v_out_410232.awb")

						arg_79_1:RecordAudio("410232019", var_82_58)
						arg_79_1:RecordAudio("410232019", var_82_58)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_410232", "410232019", "story_v_out_410232.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_410232", "410232019", "story_v_out_410232.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_59 = math.max(var_82_50, arg_79_1.talkMaxDuration)

			if var_82_49 <= arg_79_1.time_ and arg_79_1.time_ < var_82_49 + var_82_59 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_49) / var_82_59

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_49 + var_82_59 and arg_79_1.time_ < var_82_49 + var_82_59 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10060",
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
	Play410232020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 410232020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play410232021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["10060"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.actorSpriteComps10060 == nil then
				arg_83_1.var_.actorSpriteComps10060 = var_86_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_2 = 0.034

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.actorSpriteComps10060 then
					for iter_86_0, iter_86_1 in pairs(arg_83_1.var_.actorSpriteComps10060:ToTable()) do
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

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.actorSpriteComps10060 then
				for iter_86_2, iter_86_3 in pairs(arg_83_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_86_3 then
						if arg_83_1.isInRecall_ then
							iter_86_3.color = arg_83_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_86_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_83_1.var_.actorSpriteComps10060 = nil
			end

			local var_86_8 = 0
			local var_86_9 = 1.525

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

				local var_86_10 = arg_83_1:GetWordFromCfg(410232020)
				local var_86_11 = arg_83_1:FormatText(var_86_10.content)

				arg_83_1.text_.text = var_86_11

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_12 = 61
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
	Play410232021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 410232021
		arg_87_1.duration_ = 9.53

		local var_87_0 = {
			ja = 9.533,
			CriLanguages = 5.066,
			zh = 5.066
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
				arg_87_0:Play410232022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["10060"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos10060 = var_90_0.localPosition
				var_90_0.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("10060", 7)

				local var_90_2 = var_90_0.childCount

				for iter_90_0 = 0, var_90_2 - 1 do
					local var_90_3 = var_90_0:GetChild(iter_90_0)

					if var_90_3.name == "" or not string.find(var_90_3.name, "split") then
						var_90_3.gameObject:SetActive(true)
					else
						var_90_3.gameObject:SetActive(false)
					end
				end
			end

			local var_90_4 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_4 then
				local var_90_5 = (arg_87_1.time_ - var_90_1) / var_90_4
				local var_90_6 = Vector3.New(0, -2000, 0)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10060, var_90_6, var_90_5)
			end

			if arg_87_1.time_ >= var_90_1 + var_90_4 and arg_87_1.time_ < var_90_1 + var_90_4 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_90_7 = arg_87_1.actors_["10062"].transform
			local var_90_8 = 0

			if var_90_8 < arg_87_1.time_ and arg_87_1.time_ <= var_90_8 + arg_90_0 then
				arg_87_1.var_.moveOldPos10062 = var_90_7.localPosition
				var_90_7.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("10062", 3)

				local var_90_9 = var_90_7.childCount

				for iter_90_1 = 0, var_90_9 - 1 do
					local var_90_10 = var_90_7:GetChild(iter_90_1)

					if var_90_10.name == "split_1_1" or not string.find(var_90_10.name, "split") then
						var_90_10.gameObject:SetActive(true)
					else
						var_90_10.gameObject:SetActive(false)
					end
				end
			end

			local var_90_11 = 0.001

			if var_90_8 <= arg_87_1.time_ and arg_87_1.time_ < var_90_8 + var_90_11 then
				local var_90_12 = (arg_87_1.time_ - var_90_8) / var_90_11
				local var_90_13 = Vector3.New(0, -390, -290)

				var_90_7.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10062, var_90_13, var_90_12)
			end

			if arg_87_1.time_ >= var_90_8 + var_90_11 and arg_87_1.time_ < var_90_8 + var_90_11 + arg_90_0 then
				var_90_7.localPosition = Vector3.New(0, -390, -290)
			end

			local var_90_14 = arg_87_1.actors_["10060"]
			local var_90_15 = 0

			if var_90_15 < arg_87_1.time_ and arg_87_1.time_ <= var_90_15 + arg_90_0 and not isNil(var_90_14) and arg_87_1.var_.actorSpriteComps10060 == nil then
				arg_87_1.var_.actorSpriteComps10060 = var_90_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_16 = 0.034

			if var_90_15 <= arg_87_1.time_ and arg_87_1.time_ < var_90_15 + var_90_16 and not isNil(var_90_14) then
				local var_90_17 = (arg_87_1.time_ - var_90_15) / var_90_16

				if arg_87_1.var_.actorSpriteComps10060 then
					for iter_90_2, iter_90_3 in pairs(arg_87_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_90_3 then
							if arg_87_1.isInRecall_ then
								local var_90_18 = Mathf.Lerp(iter_90_3.color.r, arg_87_1.hightColor2.r, var_90_17)
								local var_90_19 = Mathf.Lerp(iter_90_3.color.g, arg_87_1.hightColor2.g, var_90_17)
								local var_90_20 = Mathf.Lerp(iter_90_3.color.b, arg_87_1.hightColor2.b, var_90_17)

								iter_90_3.color = Color.New(var_90_18, var_90_19, var_90_20)
							else
								local var_90_21 = Mathf.Lerp(iter_90_3.color.r, 0.5, var_90_17)

								iter_90_3.color = Color.New(var_90_21, var_90_21, var_90_21)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= var_90_15 + var_90_16 and arg_87_1.time_ < var_90_15 + var_90_16 + arg_90_0 and not isNil(var_90_14) and arg_87_1.var_.actorSpriteComps10060 then
				for iter_90_4, iter_90_5 in pairs(arg_87_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_90_5 then
						if arg_87_1.isInRecall_ then
							iter_90_5.color = arg_87_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_90_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_87_1.var_.actorSpriteComps10060 = nil
			end

			local var_90_22 = arg_87_1.actors_["10062"]
			local var_90_23 = 0

			if var_90_23 < arg_87_1.time_ and arg_87_1.time_ <= var_90_23 + arg_90_0 and not isNil(var_90_22) and arg_87_1.var_.actorSpriteComps10062 == nil then
				arg_87_1.var_.actorSpriteComps10062 = var_90_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_24 = 0.034

			if var_90_23 <= arg_87_1.time_ and arg_87_1.time_ < var_90_23 + var_90_24 and not isNil(var_90_22) then
				local var_90_25 = (arg_87_1.time_ - var_90_23) / var_90_24

				if arg_87_1.var_.actorSpriteComps10062 then
					for iter_90_6, iter_90_7 in pairs(arg_87_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_90_7 then
							if arg_87_1.isInRecall_ then
								local var_90_26 = Mathf.Lerp(iter_90_7.color.r, arg_87_1.hightColor1.r, var_90_25)
								local var_90_27 = Mathf.Lerp(iter_90_7.color.g, arg_87_1.hightColor1.g, var_90_25)
								local var_90_28 = Mathf.Lerp(iter_90_7.color.b, arg_87_1.hightColor1.b, var_90_25)

								iter_90_7.color = Color.New(var_90_26, var_90_27, var_90_28)
							else
								local var_90_29 = Mathf.Lerp(iter_90_7.color.r, 1, var_90_25)

								iter_90_7.color = Color.New(var_90_29, var_90_29, var_90_29)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= var_90_23 + var_90_24 and arg_87_1.time_ < var_90_23 + var_90_24 + arg_90_0 and not isNil(var_90_22) and arg_87_1.var_.actorSpriteComps10062 then
				for iter_90_8, iter_90_9 in pairs(arg_87_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_90_9 then
						if arg_87_1.isInRecall_ then
							iter_90_9.color = arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_90_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_87_1.var_.actorSpriteComps10062 = nil
			end

			local var_90_30 = 0
			local var_90_31 = 0.525

			if var_90_30 < arg_87_1.time_ and arg_87_1.time_ <= var_90_30 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_32 = arg_87_1:FormatText(StoryNameCfg[600].name)

				arg_87_1.leftNameTxt_.text = var_90_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_33 = arg_87_1:GetWordFromCfg(410232021)
				local var_90_34 = arg_87_1:FormatText(var_90_33.content)

				arg_87_1.text_.text = var_90_34

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_35 = 21
				local var_90_36 = utf8.len(var_90_34)
				local var_90_37 = var_90_35 <= 0 and var_90_31 or var_90_31 * (var_90_36 / var_90_35)

				if var_90_37 > 0 and var_90_31 < var_90_37 then
					arg_87_1.talkMaxDuration = var_90_37

					if var_90_37 + var_90_30 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_37 + var_90_30
					end
				end

				arg_87_1.text_.text = var_90_34
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232021", "story_v_out_410232.awb") ~= 0 then
					local var_90_38 = manager.audio:GetVoiceLength("story_v_out_410232", "410232021", "story_v_out_410232.awb") / 1000

					if var_90_38 + var_90_30 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_38 + var_90_30
					end

					if var_90_33.prefab_name ~= "" and arg_87_1.actors_[var_90_33.prefab_name] ~= nil then
						local var_90_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_33.prefab_name].transform, "story_v_out_410232", "410232021", "story_v_out_410232.awb")

						arg_87_1:RecordAudio("410232021", var_90_39)
						arg_87_1:RecordAudio("410232021", var_90_39)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_410232", "410232021", "story_v_out_410232.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_410232", "410232021", "story_v_out_410232.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_40 = math.max(var_90_31, arg_87_1.talkMaxDuration)

			if var_90_30 <= arg_87_1.time_ and arg_87_1.time_ < var_90_30 + var_90_40 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_30) / var_90_40

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_30 + var_90_40 and arg_87_1.time_ < var_90_30 + var_90_40 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 410232022
		arg_91_1.duration_ = 3.23

		local var_91_0 = {
			ja = 3.233,
			CriLanguages = 3.166,
			zh = 3.166
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
				arg_91_0:Play410232023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["10060"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos10060 = var_94_0.localPosition
				var_94_0.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("10060", 3)

				local var_94_2 = var_94_0.childCount

				for iter_94_0 = 0, var_94_2 - 1 do
					local var_94_3 = var_94_0:GetChild(iter_94_0)

					if var_94_3.name == "split_3" or not string.find(var_94_3.name, "split") then
						var_94_3.gameObject:SetActive(true)
					else
						var_94_3.gameObject:SetActive(false)
					end
				end
			end

			local var_94_4 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_4 then
				local var_94_5 = (arg_91_1.time_ - var_94_1) / var_94_4
				local var_94_6 = Vector3.New(0, -400, 0)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10060, var_94_6, var_94_5)
			end

			if arg_91_1.time_ >= var_94_1 + var_94_4 and arg_91_1.time_ < var_94_1 + var_94_4 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_94_7 = arg_91_1.actors_["10062"].transform
			local var_94_8 = 0

			if var_94_8 < arg_91_1.time_ and arg_91_1.time_ <= var_94_8 + arg_94_0 then
				arg_91_1.var_.moveOldPos10062 = var_94_7.localPosition
				var_94_7.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("10062", 7)

				local var_94_9 = var_94_7.childCount

				for iter_94_1 = 0, var_94_9 - 1 do
					local var_94_10 = var_94_7:GetChild(iter_94_1)

					if var_94_10.name == "" or not string.find(var_94_10.name, "split") then
						var_94_10.gameObject:SetActive(true)
					else
						var_94_10.gameObject:SetActive(false)
					end
				end
			end

			local var_94_11 = 0.001

			if var_94_8 <= arg_91_1.time_ and arg_91_1.time_ < var_94_8 + var_94_11 then
				local var_94_12 = (arg_91_1.time_ - var_94_8) / var_94_11
				local var_94_13 = Vector3.New(0, -2000, -290)

				var_94_7.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10062, var_94_13, var_94_12)
			end

			if arg_91_1.time_ >= var_94_8 + var_94_11 and arg_91_1.time_ < var_94_8 + var_94_11 + arg_94_0 then
				var_94_7.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_94_14 = arg_91_1.actors_["10060"]
			local var_94_15 = 0

			if var_94_15 < arg_91_1.time_ and arg_91_1.time_ <= var_94_15 + arg_94_0 and not isNil(var_94_14) and arg_91_1.var_.actorSpriteComps10060 == nil then
				arg_91_1.var_.actorSpriteComps10060 = var_94_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_16 = 0.034

			if var_94_15 <= arg_91_1.time_ and arg_91_1.time_ < var_94_15 + var_94_16 and not isNil(var_94_14) then
				local var_94_17 = (arg_91_1.time_ - var_94_15) / var_94_16

				if arg_91_1.var_.actorSpriteComps10060 then
					for iter_94_2, iter_94_3 in pairs(arg_91_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_94_3 then
							if arg_91_1.isInRecall_ then
								local var_94_18 = Mathf.Lerp(iter_94_3.color.r, arg_91_1.hightColor1.r, var_94_17)
								local var_94_19 = Mathf.Lerp(iter_94_3.color.g, arg_91_1.hightColor1.g, var_94_17)
								local var_94_20 = Mathf.Lerp(iter_94_3.color.b, arg_91_1.hightColor1.b, var_94_17)

								iter_94_3.color = Color.New(var_94_18, var_94_19, var_94_20)
							else
								local var_94_21 = Mathf.Lerp(iter_94_3.color.r, 1, var_94_17)

								iter_94_3.color = Color.New(var_94_21, var_94_21, var_94_21)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= var_94_15 + var_94_16 and arg_91_1.time_ < var_94_15 + var_94_16 + arg_94_0 and not isNil(var_94_14) and arg_91_1.var_.actorSpriteComps10060 then
				for iter_94_4, iter_94_5 in pairs(arg_91_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_94_5 then
						if arg_91_1.isInRecall_ then
							iter_94_5.color = arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_94_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps10060 = nil
			end

			local var_94_22 = arg_91_1.actors_["10062"]
			local var_94_23 = 0

			if var_94_23 < arg_91_1.time_ and arg_91_1.time_ <= var_94_23 + arg_94_0 and not isNil(var_94_22) and arg_91_1.var_.actorSpriteComps10062 == nil then
				arg_91_1.var_.actorSpriteComps10062 = var_94_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_24 = 0.034

			if var_94_23 <= arg_91_1.time_ and arg_91_1.time_ < var_94_23 + var_94_24 and not isNil(var_94_22) then
				local var_94_25 = (arg_91_1.time_ - var_94_23) / var_94_24

				if arg_91_1.var_.actorSpriteComps10062 then
					for iter_94_6, iter_94_7 in pairs(arg_91_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_94_7 then
							if arg_91_1.isInRecall_ then
								local var_94_26 = Mathf.Lerp(iter_94_7.color.r, arg_91_1.hightColor2.r, var_94_25)
								local var_94_27 = Mathf.Lerp(iter_94_7.color.g, arg_91_1.hightColor2.g, var_94_25)
								local var_94_28 = Mathf.Lerp(iter_94_7.color.b, arg_91_1.hightColor2.b, var_94_25)

								iter_94_7.color = Color.New(var_94_26, var_94_27, var_94_28)
							else
								local var_94_29 = Mathf.Lerp(iter_94_7.color.r, 0.5, var_94_25)

								iter_94_7.color = Color.New(var_94_29, var_94_29, var_94_29)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= var_94_23 + var_94_24 and arg_91_1.time_ < var_94_23 + var_94_24 + arg_94_0 and not isNil(var_94_22) and arg_91_1.var_.actorSpriteComps10062 then
				for iter_94_8, iter_94_9 in pairs(arg_91_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_94_9 then
						if arg_91_1.isInRecall_ then
							iter_94_9.color = arg_91_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_94_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps10062 = nil
			end

			local var_94_30 = 0
			local var_94_31 = 0.325

			if var_94_30 < arg_91_1.time_ and arg_91_1.time_ <= var_94_30 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_32 = arg_91_1:FormatText(StoryNameCfg[597].name)

				arg_91_1.leftNameTxt_.text = var_94_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_33 = arg_91_1:GetWordFromCfg(410232022)
				local var_94_34 = arg_91_1:FormatText(var_94_33.content)

				arg_91_1.text_.text = var_94_34

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_35 = 13
				local var_94_36 = utf8.len(var_94_34)
				local var_94_37 = var_94_35 <= 0 and var_94_31 or var_94_31 * (var_94_36 / var_94_35)

				if var_94_37 > 0 and var_94_31 < var_94_37 then
					arg_91_1.talkMaxDuration = var_94_37

					if var_94_37 + var_94_30 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_37 + var_94_30
					end
				end

				arg_91_1.text_.text = var_94_34
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232022", "story_v_out_410232.awb") ~= 0 then
					local var_94_38 = manager.audio:GetVoiceLength("story_v_out_410232", "410232022", "story_v_out_410232.awb") / 1000

					if var_94_38 + var_94_30 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_38 + var_94_30
					end

					if var_94_33.prefab_name ~= "" and arg_91_1.actors_[var_94_33.prefab_name] ~= nil then
						local var_94_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_33.prefab_name].transform, "story_v_out_410232", "410232022", "story_v_out_410232.awb")

						arg_91_1:RecordAudio("410232022", var_94_39)
						arg_91_1:RecordAudio("410232022", var_94_39)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_410232", "410232022", "story_v_out_410232.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_410232", "410232022", "story_v_out_410232.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_40 = math.max(var_94_31, arg_91_1.talkMaxDuration)

			if var_94_30 <= arg_91_1.time_ and arg_91_1.time_ < var_94_30 + var_94_40 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_30) / var_94_40

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_30 + var_94_40 and arg_91_1.time_ < var_94_30 + var_94_40 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play410232023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 410232023
		arg_95_1.duration_ = 9.13

		local var_95_0 = {
			ja = 9.133,
			CriLanguages = 5.266,
			zh = 5.266
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
				arg_95_0:Play410232024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["10060"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos10060 = var_98_0.localPosition
				var_98_0.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("10060", 7)

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

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10060, var_98_6, var_98_5)
			end

			if arg_95_1.time_ >= var_98_1 + var_98_4 and arg_95_1.time_ < var_98_1 + var_98_4 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_98_7 = arg_95_1.actors_["10062"].transform
			local var_98_8 = 0

			if var_98_8 < arg_95_1.time_ and arg_95_1.time_ <= var_98_8 + arg_98_0 then
				arg_95_1.var_.moveOldPos10062 = var_98_7.localPosition
				var_98_7.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("10062", 3)

				local var_98_9 = var_98_7.childCount

				for iter_98_1 = 0, var_98_9 - 1 do
					local var_98_10 = var_98_7:GetChild(iter_98_1)

					if var_98_10.name == "split_5" or not string.find(var_98_10.name, "split") then
						var_98_10.gameObject:SetActive(true)
					else
						var_98_10.gameObject:SetActive(false)
					end
				end
			end

			local var_98_11 = 0.001

			if var_98_8 <= arg_95_1.time_ and arg_95_1.time_ < var_98_8 + var_98_11 then
				local var_98_12 = (arg_95_1.time_ - var_98_8) / var_98_11
				local var_98_13 = Vector3.New(0, -390, -290)

				var_98_7.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10062, var_98_13, var_98_12)
			end

			if arg_95_1.time_ >= var_98_8 + var_98_11 and arg_95_1.time_ < var_98_8 + var_98_11 + arg_98_0 then
				var_98_7.localPosition = Vector3.New(0, -390, -290)
			end

			local var_98_14 = arg_95_1.actors_["10060"]
			local var_98_15 = 0

			if var_98_15 < arg_95_1.time_ and arg_95_1.time_ <= var_98_15 + arg_98_0 and not isNil(var_98_14) and arg_95_1.var_.actorSpriteComps10060 == nil then
				arg_95_1.var_.actorSpriteComps10060 = var_98_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_16 = 0.034

			if var_98_15 <= arg_95_1.time_ and arg_95_1.time_ < var_98_15 + var_98_16 and not isNil(var_98_14) then
				local var_98_17 = (arg_95_1.time_ - var_98_15) / var_98_16

				if arg_95_1.var_.actorSpriteComps10060 then
					for iter_98_2, iter_98_3 in pairs(arg_95_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_98_3 then
							if arg_95_1.isInRecall_ then
								local var_98_18 = Mathf.Lerp(iter_98_3.color.r, arg_95_1.hightColor2.r, var_98_17)
								local var_98_19 = Mathf.Lerp(iter_98_3.color.g, arg_95_1.hightColor2.g, var_98_17)
								local var_98_20 = Mathf.Lerp(iter_98_3.color.b, arg_95_1.hightColor2.b, var_98_17)

								iter_98_3.color = Color.New(var_98_18, var_98_19, var_98_20)
							else
								local var_98_21 = Mathf.Lerp(iter_98_3.color.r, 0.5, var_98_17)

								iter_98_3.color = Color.New(var_98_21, var_98_21, var_98_21)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= var_98_15 + var_98_16 and arg_95_1.time_ < var_98_15 + var_98_16 + arg_98_0 and not isNil(var_98_14) and arg_95_1.var_.actorSpriteComps10060 then
				for iter_98_4, iter_98_5 in pairs(arg_95_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_98_5 then
						if arg_95_1.isInRecall_ then
							iter_98_5.color = arg_95_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_98_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_95_1.var_.actorSpriteComps10060 = nil
			end

			local var_98_22 = arg_95_1.actors_["10062"]
			local var_98_23 = 0

			if var_98_23 < arg_95_1.time_ and arg_95_1.time_ <= var_98_23 + arg_98_0 and not isNil(var_98_22) and arg_95_1.var_.actorSpriteComps10062 == nil then
				arg_95_1.var_.actorSpriteComps10062 = var_98_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_24 = 0.034

			if var_98_23 <= arg_95_1.time_ and arg_95_1.time_ < var_98_23 + var_98_24 and not isNil(var_98_22) then
				local var_98_25 = (arg_95_1.time_ - var_98_23) / var_98_24

				if arg_95_1.var_.actorSpriteComps10062 then
					for iter_98_6, iter_98_7 in pairs(arg_95_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_98_7 then
							if arg_95_1.isInRecall_ then
								local var_98_26 = Mathf.Lerp(iter_98_7.color.r, arg_95_1.hightColor1.r, var_98_25)
								local var_98_27 = Mathf.Lerp(iter_98_7.color.g, arg_95_1.hightColor1.g, var_98_25)
								local var_98_28 = Mathf.Lerp(iter_98_7.color.b, arg_95_1.hightColor1.b, var_98_25)

								iter_98_7.color = Color.New(var_98_26, var_98_27, var_98_28)
							else
								local var_98_29 = Mathf.Lerp(iter_98_7.color.r, 1, var_98_25)

								iter_98_7.color = Color.New(var_98_29, var_98_29, var_98_29)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= var_98_23 + var_98_24 and arg_95_1.time_ < var_98_23 + var_98_24 + arg_98_0 and not isNil(var_98_22) and arg_95_1.var_.actorSpriteComps10062 then
				for iter_98_8, iter_98_9 in pairs(arg_95_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_98_9 then
						if arg_95_1.isInRecall_ then
							iter_98_9.color = arg_95_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_98_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_95_1.var_.actorSpriteComps10062 = nil
			end

			local var_98_30 = 0
			local var_98_31 = 0.55

			if var_98_30 < arg_95_1.time_ and arg_95_1.time_ <= var_98_30 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_32 = arg_95_1:FormatText(StoryNameCfg[600].name)

				arg_95_1.leftNameTxt_.text = var_98_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_33 = arg_95_1:GetWordFromCfg(410232023)
				local var_98_34 = arg_95_1:FormatText(var_98_33.content)

				arg_95_1.text_.text = var_98_34

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_35 = 22
				local var_98_36 = utf8.len(var_98_34)
				local var_98_37 = var_98_35 <= 0 and var_98_31 or var_98_31 * (var_98_36 / var_98_35)

				if var_98_37 > 0 and var_98_31 < var_98_37 then
					arg_95_1.talkMaxDuration = var_98_37

					if var_98_37 + var_98_30 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_37 + var_98_30
					end
				end

				arg_95_1.text_.text = var_98_34
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232023", "story_v_out_410232.awb") ~= 0 then
					local var_98_38 = manager.audio:GetVoiceLength("story_v_out_410232", "410232023", "story_v_out_410232.awb") / 1000

					if var_98_38 + var_98_30 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_38 + var_98_30
					end

					if var_98_33.prefab_name ~= "" and arg_95_1.actors_[var_98_33.prefab_name] ~= nil then
						local var_98_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_33.prefab_name].transform, "story_v_out_410232", "410232023", "story_v_out_410232.awb")

						arg_95_1:RecordAudio("410232023", var_98_39)
						arg_95_1:RecordAudio("410232023", var_98_39)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_410232", "410232023", "story_v_out_410232.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_410232", "410232023", "story_v_out_410232.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_40 = math.max(var_98_31, arg_95_1.talkMaxDuration)

			if var_98_30 <= arg_95_1.time_ and arg_95_1.time_ < var_98_30 + var_98_40 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_30) / var_98_40

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_30 + var_98_40 and arg_95_1.time_ < var_98_30 + var_98_40 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 410232024
		arg_99_1.duration_ = 2.9

		local var_99_0 = {
			ja = 2.866,
			CriLanguages = 2.9,
			zh = 2.9
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
				arg_99_0:Play410232025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["10060"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos10060 = var_102_0.localPosition
				var_102_0.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("10060", 2)

				local var_102_2 = var_102_0.childCount

				for iter_102_0 = 0, var_102_2 - 1 do
					local var_102_3 = var_102_0:GetChild(iter_102_0)

					if var_102_3.name == "" or not string.find(var_102_3.name, "split") then
						var_102_3.gameObject:SetActive(true)
					else
						var_102_3.gameObject:SetActive(false)
					end
				end
			end

			local var_102_4 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_4 then
				local var_102_5 = (arg_99_1.time_ - var_102_1) / var_102_4
				local var_102_6 = Vector3.New(-390, -400, 0)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10060, var_102_6, var_102_5)
			end

			if arg_99_1.time_ >= var_102_1 + var_102_4 and arg_99_1.time_ < var_102_1 + var_102_4 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_102_7 = arg_99_1.actors_["10059"].transform
			local var_102_8 = 0

			if var_102_8 < arg_99_1.time_ and arg_99_1.time_ <= var_102_8 + arg_102_0 then
				arg_99_1.var_.moveOldPos10059 = var_102_7.localPosition
				var_102_7.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("10059", 4)

				local var_102_9 = var_102_7.childCount

				for iter_102_1 = 0, var_102_9 - 1 do
					local var_102_10 = var_102_7:GetChild(iter_102_1)

					if var_102_10.name == "split_4" or not string.find(var_102_10.name, "split") then
						var_102_10.gameObject:SetActive(true)
					else
						var_102_10.gameObject:SetActive(false)
					end
				end
			end

			local var_102_11 = 0.001

			if var_102_8 <= arg_99_1.time_ and arg_99_1.time_ < var_102_8 + var_102_11 then
				local var_102_12 = (arg_99_1.time_ - var_102_8) / var_102_11
				local var_102_13 = Vector3.New(390, -530, 35)

				var_102_7.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10059, var_102_13, var_102_12)
			end

			if arg_99_1.time_ >= var_102_8 + var_102_11 and arg_99_1.time_ < var_102_8 + var_102_11 + arg_102_0 then
				var_102_7.localPosition = Vector3.New(390, -530, 35)
			end

			local var_102_14 = arg_99_1.actors_["10060"]
			local var_102_15 = 0

			if var_102_15 < arg_99_1.time_ and arg_99_1.time_ <= var_102_15 + arg_102_0 and not isNil(var_102_14) and arg_99_1.var_.actorSpriteComps10060 == nil then
				arg_99_1.var_.actorSpriteComps10060 = var_102_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_16 = 0.034

			if var_102_15 <= arg_99_1.time_ and arg_99_1.time_ < var_102_15 + var_102_16 and not isNil(var_102_14) then
				local var_102_17 = (arg_99_1.time_ - var_102_15) / var_102_16

				if arg_99_1.var_.actorSpriteComps10060 then
					for iter_102_2, iter_102_3 in pairs(arg_99_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_102_3 then
							if arg_99_1.isInRecall_ then
								local var_102_18 = Mathf.Lerp(iter_102_3.color.r, arg_99_1.hightColor2.r, var_102_17)
								local var_102_19 = Mathf.Lerp(iter_102_3.color.g, arg_99_1.hightColor2.g, var_102_17)
								local var_102_20 = Mathf.Lerp(iter_102_3.color.b, arg_99_1.hightColor2.b, var_102_17)

								iter_102_3.color = Color.New(var_102_18, var_102_19, var_102_20)
							else
								local var_102_21 = Mathf.Lerp(iter_102_3.color.r, 0.5, var_102_17)

								iter_102_3.color = Color.New(var_102_21, var_102_21, var_102_21)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= var_102_15 + var_102_16 and arg_99_1.time_ < var_102_15 + var_102_16 + arg_102_0 and not isNil(var_102_14) and arg_99_1.var_.actorSpriteComps10060 then
				for iter_102_4, iter_102_5 in pairs(arg_99_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_102_5 then
						if arg_99_1.isInRecall_ then
							iter_102_5.color = arg_99_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_102_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_99_1.var_.actorSpriteComps10060 = nil
			end

			local var_102_22 = arg_99_1.actors_["10059"]
			local var_102_23 = 0

			if var_102_23 < arg_99_1.time_ and arg_99_1.time_ <= var_102_23 + arg_102_0 and not isNil(var_102_22) and arg_99_1.var_.actorSpriteComps10059 == nil then
				arg_99_1.var_.actorSpriteComps10059 = var_102_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_24 = 0.034

			if var_102_23 <= arg_99_1.time_ and arg_99_1.time_ < var_102_23 + var_102_24 and not isNil(var_102_22) then
				local var_102_25 = (arg_99_1.time_ - var_102_23) / var_102_24

				if arg_99_1.var_.actorSpriteComps10059 then
					for iter_102_6, iter_102_7 in pairs(arg_99_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_102_7 then
							if arg_99_1.isInRecall_ then
								local var_102_26 = Mathf.Lerp(iter_102_7.color.r, arg_99_1.hightColor1.r, var_102_25)
								local var_102_27 = Mathf.Lerp(iter_102_7.color.g, arg_99_1.hightColor1.g, var_102_25)
								local var_102_28 = Mathf.Lerp(iter_102_7.color.b, arg_99_1.hightColor1.b, var_102_25)

								iter_102_7.color = Color.New(var_102_26, var_102_27, var_102_28)
							else
								local var_102_29 = Mathf.Lerp(iter_102_7.color.r, 1, var_102_25)

								iter_102_7.color = Color.New(var_102_29, var_102_29, var_102_29)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= var_102_23 + var_102_24 and arg_99_1.time_ < var_102_23 + var_102_24 + arg_102_0 and not isNil(var_102_22) and arg_99_1.var_.actorSpriteComps10059 then
				for iter_102_8, iter_102_9 in pairs(arg_99_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_102_9 then
						if arg_99_1.isInRecall_ then
							iter_102_9.color = arg_99_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_102_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_99_1.var_.actorSpriteComps10059 = nil
			end

			local var_102_30 = arg_99_1.actors_["10062"].transform
			local var_102_31 = 0

			if var_102_31 < arg_99_1.time_ and arg_99_1.time_ <= var_102_31 + arg_102_0 then
				arg_99_1.var_.moveOldPos10062 = var_102_30.localPosition
				var_102_30.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("10062", 7)

				local var_102_32 = var_102_30.childCount

				for iter_102_10 = 0, var_102_32 - 1 do
					local var_102_33 = var_102_30:GetChild(iter_102_10)

					if var_102_33.name == "split_5" or not string.find(var_102_33.name, "split") then
						var_102_33.gameObject:SetActive(true)
					else
						var_102_33.gameObject:SetActive(false)
					end
				end
			end

			local var_102_34 = 0.001

			if var_102_31 <= arg_99_1.time_ and arg_99_1.time_ < var_102_31 + var_102_34 then
				local var_102_35 = (arg_99_1.time_ - var_102_31) / var_102_34
				local var_102_36 = Vector3.New(0, -2000, -290)

				var_102_30.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10062, var_102_36, var_102_35)
			end

			if arg_99_1.time_ >= var_102_31 + var_102_34 and arg_99_1.time_ < var_102_31 + var_102_34 + arg_102_0 then
				var_102_30.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_102_37 = 0
			local var_102_38 = 0.275

			if var_102_37 < arg_99_1.time_ and arg_99_1.time_ <= var_102_37 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_39 = arg_99_1:FormatText(StoryNameCfg[596].name)

				arg_99_1.leftNameTxt_.text = var_102_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_40 = arg_99_1:GetWordFromCfg(410232024)
				local var_102_41 = arg_99_1:FormatText(var_102_40.content)

				arg_99_1.text_.text = var_102_41

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_42 = 11
				local var_102_43 = utf8.len(var_102_41)
				local var_102_44 = var_102_42 <= 0 and var_102_38 or var_102_38 * (var_102_43 / var_102_42)

				if var_102_44 > 0 and var_102_38 < var_102_44 then
					arg_99_1.talkMaxDuration = var_102_44

					if var_102_44 + var_102_37 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_44 + var_102_37
					end
				end

				arg_99_1.text_.text = var_102_41
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232024", "story_v_out_410232.awb") ~= 0 then
					local var_102_45 = manager.audio:GetVoiceLength("story_v_out_410232", "410232024", "story_v_out_410232.awb") / 1000

					if var_102_45 + var_102_37 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_45 + var_102_37
					end

					if var_102_40.prefab_name ~= "" and arg_99_1.actors_[var_102_40.prefab_name] ~= nil then
						local var_102_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_40.prefab_name].transform, "story_v_out_410232", "410232024", "story_v_out_410232.awb")

						arg_99_1:RecordAudio("410232024", var_102_46)
						arg_99_1:RecordAudio("410232024", var_102_46)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_410232", "410232024", "story_v_out_410232.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_410232", "410232024", "story_v_out_410232.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_47 = math.max(var_102_38, arg_99_1.talkMaxDuration)

			if var_102_37 <= arg_99_1.time_ and arg_99_1.time_ < var_102_37 + var_102_47 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_37) / var_102_47

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_37 + var_102_47 and arg_99_1.time_ < var_102_37 + var_102_47 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play410232025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 410232025
		arg_103_1.duration_ = 4.7

		local var_103_0 = {
			ja = 4.7,
			CriLanguages = 2.866,
			zh = 2.866
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
				arg_103_0:Play410232026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["10062"].transform
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.var_.moveOldPos10062 = var_106_0.localPosition
				var_106_0.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("10062", 3)

				local var_106_2 = var_106_0.childCount

				for iter_106_0 = 0, var_106_2 - 1 do
					local var_106_3 = var_106_0:GetChild(iter_106_0)

					if var_106_3.name == "" or not string.find(var_106_3.name, "split") then
						var_106_3.gameObject:SetActive(true)
					else
						var_106_3.gameObject:SetActive(false)
					end
				end
			end

			local var_106_4 = 0.001

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_4 then
				local var_106_5 = (arg_103_1.time_ - var_106_1) / var_106_4
				local var_106_6 = Vector3.New(0, -390, -290)

				var_106_0.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10062, var_106_6, var_106_5)
			end

			if arg_103_1.time_ >= var_106_1 + var_106_4 and arg_103_1.time_ < var_106_1 + var_106_4 + arg_106_0 then
				var_106_0.localPosition = Vector3.New(0, -390, -290)
			end

			local var_106_7 = arg_103_1.actors_["10060"].transform
			local var_106_8 = 0

			if var_106_8 < arg_103_1.time_ and arg_103_1.time_ <= var_106_8 + arg_106_0 then
				arg_103_1.var_.moveOldPos10060 = var_106_7.localPosition
				var_106_7.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("10060", 7)

				local var_106_9 = var_106_7.childCount

				for iter_106_1 = 0, var_106_9 - 1 do
					local var_106_10 = var_106_7:GetChild(iter_106_1)

					if var_106_10.name == "" or not string.find(var_106_10.name, "split") then
						var_106_10.gameObject:SetActive(true)
					else
						var_106_10.gameObject:SetActive(false)
					end
				end
			end

			local var_106_11 = 0.001

			if var_106_8 <= arg_103_1.time_ and arg_103_1.time_ < var_106_8 + var_106_11 then
				local var_106_12 = (arg_103_1.time_ - var_106_8) / var_106_11
				local var_106_13 = Vector3.New(0, -2000, 0)

				var_106_7.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10060, var_106_13, var_106_12)
			end

			if arg_103_1.time_ >= var_106_8 + var_106_11 and arg_103_1.time_ < var_106_8 + var_106_11 + arg_106_0 then
				var_106_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_106_14 = arg_103_1.actors_["10059"].transform
			local var_106_15 = 0

			if var_106_15 < arg_103_1.time_ and arg_103_1.time_ <= var_106_15 + arg_106_0 then
				arg_103_1.var_.moveOldPos10059 = var_106_14.localPosition
				var_106_14.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("10059", 7)

				local var_106_16 = var_106_14.childCount

				for iter_106_2 = 0, var_106_16 - 1 do
					local var_106_17 = var_106_14:GetChild(iter_106_2)

					if var_106_17.name == "" or not string.find(var_106_17.name, "split") then
						var_106_17.gameObject:SetActive(true)
					else
						var_106_17.gameObject:SetActive(false)
					end
				end
			end

			local var_106_18 = 0.001

			if var_106_15 <= arg_103_1.time_ and arg_103_1.time_ < var_106_15 + var_106_18 then
				local var_106_19 = (arg_103_1.time_ - var_106_15) / var_106_18
				local var_106_20 = Vector3.New(0, -2000, 35)

				var_106_14.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10059, var_106_20, var_106_19)
			end

			if arg_103_1.time_ >= var_106_15 + var_106_18 and arg_103_1.time_ < var_106_15 + var_106_18 + arg_106_0 then
				var_106_14.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_106_21 = arg_103_1.actors_["10062"]
			local var_106_22 = 0

			if var_106_22 < arg_103_1.time_ and arg_103_1.time_ <= var_106_22 + arg_106_0 and not isNil(var_106_21) and arg_103_1.var_.actorSpriteComps10062 == nil then
				arg_103_1.var_.actorSpriteComps10062 = var_106_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_23 = 0.034

			if var_106_22 <= arg_103_1.time_ and arg_103_1.time_ < var_106_22 + var_106_23 and not isNil(var_106_21) then
				local var_106_24 = (arg_103_1.time_ - var_106_22) / var_106_23

				if arg_103_1.var_.actorSpriteComps10062 then
					for iter_106_3, iter_106_4 in pairs(arg_103_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_106_4 then
							if arg_103_1.isInRecall_ then
								local var_106_25 = Mathf.Lerp(iter_106_4.color.r, arg_103_1.hightColor1.r, var_106_24)
								local var_106_26 = Mathf.Lerp(iter_106_4.color.g, arg_103_1.hightColor1.g, var_106_24)
								local var_106_27 = Mathf.Lerp(iter_106_4.color.b, arg_103_1.hightColor1.b, var_106_24)

								iter_106_4.color = Color.New(var_106_25, var_106_26, var_106_27)
							else
								local var_106_28 = Mathf.Lerp(iter_106_4.color.r, 1, var_106_24)

								iter_106_4.color = Color.New(var_106_28, var_106_28, var_106_28)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= var_106_22 + var_106_23 and arg_103_1.time_ < var_106_22 + var_106_23 + arg_106_0 and not isNil(var_106_21) and arg_103_1.var_.actorSpriteComps10062 then
				for iter_106_5, iter_106_6 in pairs(arg_103_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_106_6 then
						if arg_103_1.isInRecall_ then
							iter_106_6.color = arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_106_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_103_1.var_.actorSpriteComps10062 = nil
			end

			local var_106_29 = arg_103_1.actors_["10060"]
			local var_106_30 = 0

			if var_106_30 < arg_103_1.time_ and arg_103_1.time_ <= var_106_30 + arg_106_0 and not isNil(var_106_29) and arg_103_1.var_.actorSpriteComps10060 == nil then
				arg_103_1.var_.actorSpriteComps10060 = var_106_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_31 = 0.034

			if var_106_30 <= arg_103_1.time_ and arg_103_1.time_ < var_106_30 + var_106_31 and not isNil(var_106_29) then
				local var_106_32 = (arg_103_1.time_ - var_106_30) / var_106_31

				if arg_103_1.var_.actorSpriteComps10060 then
					for iter_106_7, iter_106_8 in pairs(arg_103_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_106_8 then
							if arg_103_1.isInRecall_ then
								local var_106_33 = Mathf.Lerp(iter_106_8.color.r, arg_103_1.hightColor2.r, var_106_32)
								local var_106_34 = Mathf.Lerp(iter_106_8.color.g, arg_103_1.hightColor2.g, var_106_32)
								local var_106_35 = Mathf.Lerp(iter_106_8.color.b, arg_103_1.hightColor2.b, var_106_32)

								iter_106_8.color = Color.New(var_106_33, var_106_34, var_106_35)
							else
								local var_106_36 = Mathf.Lerp(iter_106_8.color.r, 0.5, var_106_32)

								iter_106_8.color = Color.New(var_106_36, var_106_36, var_106_36)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= var_106_30 + var_106_31 and arg_103_1.time_ < var_106_30 + var_106_31 + arg_106_0 and not isNil(var_106_29) and arg_103_1.var_.actorSpriteComps10060 then
				for iter_106_9, iter_106_10 in pairs(arg_103_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_106_10 then
						if arg_103_1.isInRecall_ then
							iter_106_10.color = arg_103_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_106_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_103_1.var_.actorSpriteComps10060 = nil
			end

			local var_106_37 = arg_103_1.actors_["10059"]
			local var_106_38 = 0

			if var_106_38 < arg_103_1.time_ and arg_103_1.time_ <= var_106_38 + arg_106_0 and not isNil(var_106_37) and arg_103_1.var_.actorSpriteComps10059 == nil then
				arg_103_1.var_.actorSpriteComps10059 = var_106_37:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_39 = 0.034

			if var_106_38 <= arg_103_1.time_ and arg_103_1.time_ < var_106_38 + var_106_39 and not isNil(var_106_37) then
				local var_106_40 = (arg_103_1.time_ - var_106_38) / var_106_39

				if arg_103_1.var_.actorSpriteComps10059 then
					for iter_106_11, iter_106_12 in pairs(arg_103_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_106_12 then
							if arg_103_1.isInRecall_ then
								local var_106_41 = Mathf.Lerp(iter_106_12.color.r, arg_103_1.hightColor2.r, var_106_40)
								local var_106_42 = Mathf.Lerp(iter_106_12.color.g, arg_103_1.hightColor2.g, var_106_40)
								local var_106_43 = Mathf.Lerp(iter_106_12.color.b, arg_103_1.hightColor2.b, var_106_40)

								iter_106_12.color = Color.New(var_106_41, var_106_42, var_106_43)
							else
								local var_106_44 = Mathf.Lerp(iter_106_12.color.r, 0.5, var_106_40)

								iter_106_12.color = Color.New(var_106_44, var_106_44, var_106_44)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= var_106_38 + var_106_39 and arg_103_1.time_ < var_106_38 + var_106_39 + arg_106_0 and not isNil(var_106_37) and arg_103_1.var_.actorSpriteComps10059 then
				for iter_106_13, iter_106_14 in pairs(arg_103_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_106_14 then
						if arg_103_1.isInRecall_ then
							iter_106_14.color = arg_103_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_106_14.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_103_1.var_.actorSpriteComps10059 = nil
			end

			local var_106_45 = 0
			local var_106_46 = 0.275

			if var_106_45 < arg_103_1.time_ and arg_103_1.time_ <= var_106_45 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_47 = arg_103_1:FormatText(StoryNameCfg[600].name)

				arg_103_1.leftNameTxt_.text = var_106_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_48 = arg_103_1:GetWordFromCfg(410232025)
				local var_106_49 = arg_103_1:FormatText(var_106_48.content)

				arg_103_1.text_.text = var_106_49

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_50 = 11
				local var_106_51 = utf8.len(var_106_49)
				local var_106_52 = var_106_50 <= 0 and var_106_46 or var_106_46 * (var_106_51 / var_106_50)

				if var_106_52 > 0 and var_106_46 < var_106_52 then
					arg_103_1.talkMaxDuration = var_106_52

					if var_106_52 + var_106_45 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_52 + var_106_45
					end
				end

				arg_103_1.text_.text = var_106_49
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232025", "story_v_out_410232.awb") ~= 0 then
					local var_106_53 = manager.audio:GetVoiceLength("story_v_out_410232", "410232025", "story_v_out_410232.awb") / 1000

					if var_106_53 + var_106_45 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_53 + var_106_45
					end

					if var_106_48.prefab_name ~= "" and arg_103_1.actors_[var_106_48.prefab_name] ~= nil then
						local var_106_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_48.prefab_name].transform, "story_v_out_410232", "410232025", "story_v_out_410232.awb")

						arg_103_1:RecordAudio("410232025", var_106_54)
						arg_103_1:RecordAudio("410232025", var_106_54)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_410232", "410232025", "story_v_out_410232.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_410232", "410232025", "story_v_out_410232.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_55 = math.max(var_106_46, arg_103_1.talkMaxDuration)

			if var_106_45 <= arg_103_1.time_ and arg_103_1.time_ < var_106_45 + var_106_55 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_45) / var_106_55

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_45 + var_106_55 and arg_103_1.time_ < var_106_45 + var_106_55 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
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
	Play410232026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 410232026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play410232027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10062"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps10062 == nil then
				arg_107_1.var_.actorSpriteComps10062 = var_110_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_2 = 0.034

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.actorSpriteComps10062 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_110_1 then
							if arg_107_1.isInRecall_ then
								local var_110_4 = Mathf.Lerp(iter_110_1.color.r, arg_107_1.hightColor2.r, var_110_3)
								local var_110_5 = Mathf.Lerp(iter_110_1.color.g, arg_107_1.hightColor2.g, var_110_3)
								local var_110_6 = Mathf.Lerp(iter_110_1.color.b, arg_107_1.hightColor2.b, var_110_3)

								iter_110_1.color = Color.New(var_110_4, var_110_5, var_110_6)
							else
								local var_110_7 = Mathf.Lerp(iter_110_1.color.r, 0.5, var_110_3)

								iter_110_1.color = Color.New(var_110_7, var_110_7, var_110_7)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps10062 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_110_3 then
						if arg_107_1.isInRecall_ then
							iter_110_3.color = arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_110_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps10062 = nil
			end

			local var_110_8 = 0
			local var_110_9 = 0.975

			if var_110_8 < arg_107_1.time_ and arg_107_1.time_ <= var_110_8 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_10 = arg_107_1:GetWordFromCfg(410232026)
				local var_110_11 = arg_107_1:FormatText(var_110_10.content)

				arg_107_1.text_.text = var_110_11

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_12 = 39
				local var_110_13 = utf8.len(var_110_11)
				local var_110_14 = var_110_12 <= 0 and var_110_9 or var_110_9 * (var_110_13 / var_110_12)

				if var_110_14 > 0 and var_110_9 < var_110_14 then
					arg_107_1.talkMaxDuration = var_110_14

					if var_110_14 + var_110_8 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_14 + var_110_8
					end
				end

				arg_107_1.text_.text = var_110_11
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_15 = math.max(var_110_9, arg_107_1.talkMaxDuration)

			if var_110_8 <= arg_107_1.time_ and arg_107_1.time_ < var_110_8 + var_110_15 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_8) / var_110_15

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_8 + var_110_15 and arg_107_1.time_ < var_110_8 + var_110_15 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play410232027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 410232027
		arg_111_1.duration_ = 3

		local var_111_0 = {
			ja = 3,
			CriLanguages = 2.933,
			zh = 2.933
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
				arg_111_0:Play410232028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["10060"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos10060 = var_114_0.localPosition
				var_114_0.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("10060", 2)

				local var_114_2 = var_114_0.childCount

				for iter_114_0 = 0, var_114_2 - 1 do
					local var_114_3 = var_114_0:GetChild(iter_114_0)

					if var_114_3.name == "" or not string.find(var_114_3.name, "split") then
						var_114_3.gameObject:SetActive(true)
					else
						var_114_3.gameObject:SetActive(false)
					end
				end
			end

			local var_114_4 = 0.001

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_4 then
				local var_114_5 = (arg_111_1.time_ - var_114_1) / var_114_4
				local var_114_6 = Vector3.New(-390, -400, 0)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10060, var_114_6, var_114_5)
			end

			if arg_111_1.time_ >= var_114_1 + var_114_4 and arg_111_1.time_ < var_114_1 + var_114_4 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_114_7 = arg_111_1.actors_["10062"].transform
			local var_114_8 = 0

			if var_114_8 < arg_111_1.time_ and arg_111_1.time_ <= var_114_8 + arg_114_0 then
				arg_111_1.var_.moveOldPos10062 = var_114_7.localPosition
				var_114_7.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("10062", 4)

				local var_114_9 = var_114_7.childCount

				for iter_114_1 = 0, var_114_9 - 1 do
					local var_114_10 = var_114_7:GetChild(iter_114_1)

					if var_114_10.name == "" or not string.find(var_114_10.name, "split") then
						var_114_10.gameObject:SetActive(true)
					else
						var_114_10.gameObject:SetActive(false)
					end
				end
			end

			local var_114_11 = 0.001

			if var_114_8 <= arg_111_1.time_ and arg_111_1.time_ < var_114_8 + var_114_11 then
				local var_114_12 = (arg_111_1.time_ - var_114_8) / var_114_11
				local var_114_13 = Vector3.New(370, -390, -290)

				var_114_7.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10062, var_114_13, var_114_12)
			end

			if arg_111_1.time_ >= var_114_8 + var_114_11 and arg_111_1.time_ < var_114_8 + var_114_11 + arg_114_0 then
				var_114_7.localPosition = Vector3.New(370, -390, -290)
			end

			local var_114_14 = arg_111_1.actors_["10060"]
			local var_114_15 = 0

			if var_114_15 < arg_111_1.time_ and arg_111_1.time_ <= var_114_15 + arg_114_0 and not isNil(var_114_14) and arg_111_1.var_.actorSpriteComps10060 == nil then
				arg_111_1.var_.actorSpriteComps10060 = var_114_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_16 = 0.034

			if var_114_15 <= arg_111_1.time_ and arg_111_1.time_ < var_114_15 + var_114_16 and not isNil(var_114_14) then
				local var_114_17 = (arg_111_1.time_ - var_114_15) / var_114_16

				if arg_111_1.var_.actorSpriteComps10060 then
					for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_114_3 then
							if arg_111_1.isInRecall_ then
								local var_114_18 = Mathf.Lerp(iter_114_3.color.r, arg_111_1.hightColor1.r, var_114_17)
								local var_114_19 = Mathf.Lerp(iter_114_3.color.g, arg_111_1.hightColor1.g, var_114_17)
								local var_114_20 = Mathf.Lerp(iter_114_3.color.b, arg_111_1.hightColor1.b, var_114_17)

								iter_114_3.color = Color.New(var_114_18, var_114_19, var_114_20)
							else
								local var_114_21 = Mathf.Lerp(iter_114_3.color.r, 1, var_114_17)

								iter_114_3.color = Color.New(var_114_21, var_114_21, var_114_21)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= var_114_15 + var_114_16 and arg_111_1.time_ < var_114_15 + var_114_16 + arg_114_0 and not isNil(var_114_14) and arg_111_1.var_.actorSpriteComps10060 then
				for iter_114_4, iter_114_5 in pairs(arg_111_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_114_5 then
						if arg_111_1.isInRecall_ then
							iter_114_5.color = arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_114_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps10060 = nil
			end

			local var_114_22 = arg_111_1.actors_["10062"]
			local var_114_23 = 0

			if var_114_23 < arg_111_1.time_ and arg_111_1.time_ <= var_114_23 + arg_114_0 and not isNil(var_114_22) and arg_111_1.var_.actorSpriteComps10062 == nil then
				arg_111_1.var_.actorSpriteComps10062 = var_114_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_24 = 0.034

			if var_114_23 <= arg_111_1.time_ and arg_111_1.time_ < var_114_23 + var_114_24 and not isNil(var_114_22) then
				local var_114_25 = (arg_111_1.time_ - var_114_23) / var_114_24

				if arg_111_1.var_.actorSpriteComps10062 then
					for iter_114_6, iter_114_7 in pairs(arg_111_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_114_7 then
							if arg_111_1.isInRecall_ then
								local var_114_26 = Mathf.Lerp(iter_114_7.color.r, arg_111_1.hightColor2.r, var_114_25)
								local var_114_27 = Mathf.Lerp(iter_114_7.color.g, arg_111_1.hightColor2.g, var_114_25)
								local var_114_28 = Mathf.Lerp(iter_114_7.color.b, arg_111_1.hightColor2.b, var_114_25)

								iter_114_7.color = Color.New(var_114_26, var_114_27, var_114_28)
							else
								local var_114_29 = Mathf.Lerp(iter_114_7.color.r, 0.5, var_114_25)

								iter_114_7.color = Color.New(var_114_29, var_114_29, var_114_29)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= var_114_23 + var_114_24 and arg_111_1.time_ < var_114_23 + var_114_24 + arg_114_0 and not isNil(var_114_22) and arg_111_1.var_.actorSpriteComps10062 then
				for iter_114_8, iter_114_9 in pairs(arg_111_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_114_9 then
						if arg_111_1.isInRecall_ then
							iter_114_9.color = arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_114_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps10062 = nil
			end

			local var_114_30 = 0
			local var_114_31 = 0.275

			if var_114_30 < arg_111_1.time_ and arg_111_1.time_ <= var_114_30 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_32 = arg_111_1:FormatText(StoryNameCfg[597].name)

				arg_111_1.leftNameTxt_.text = var_114_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_33 = arg_111_1:GetWordFromCfg(410232027)
				local var_114_34 = arg_111_1:FormatText(var_114_33.content)

				arg_111_1.text_.text = var_114_34

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_35 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232027", "story_v_out_410232.awb") ~= 0 then
					local var_114_38 = manager.audio:GetVoiceLength("story_v_out_410232", "410232027", "story_v_out_410232.awb") / 1000

					if var_114_38 + var_114_30 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_38 + var_114_30
					end

					if var_114_33.prefab_name ~= "" and arg_111_1.actors_[var_114_33.prefab_name] ~= nil then
						local var_114_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_33.prefab_name].transform, "story_v_out_410232", "410232027", "story_v_out_410232.awb")

						arg_111_1:RecordAudio("410232027", var_114_39)
						arg_111_1:RecordAudio("410232027", var_114_39)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_410232", "410232027", "story_v_out_410232.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_410232", "410232027", "story_v_out_410232.awb")
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
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 410232028
		arg_115_1.duration_ = 8.97

		local var_115_0 = {
			ja = 8.966,
			CriLanguages = 6.6,
			zh = 6.6
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
				arg_115_0:Play410232029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["10062"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos10062 = var_118_0.localPosition
				var_118_0.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10062", 4)

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
				local var_118_6 = Vector3.New(370, -390, -290)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10062, var_118_6, var_118_5)
			end

			if arg_115_1.time_ >= var_118_1 + var_118_4 and arg_115_1.time_ < var_118_1 + var_118_4 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_118_7 = arg_115_1.actors_["10062"]
			local var_118_8 = 0

			if var_118_8 < arg_115_1.time_ and arg_115_1.time_ <= var_118_8 + arg_118_0 and not isNil(var_118_7) and arg_115_1.var_.actorSpriteComps10062 == nil then
				arg_115_1.var_.actorSpriteComps10062 = var_118_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_9 = 0.034

			if var_118_8 <= arg_115_1.time_ and arg_115_1.time_ < var_118_8 + var_118_9 and not isNil(var_118_7) then
				local var_118_10 = (arg_115_1.time_ - var_118_8) / var_118_9

				if arg_115_1.var_.actorSpriteComps10062 then
					for iter_118_1, iter_118_2 in pairs(arg_115_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_115_1.time_ >= var_118_8 + var_118_9 and arg_115_1.time_ < var_118_8 + var_118_9 + arg_118_0 and not isNil(var_118_7) and arg_115_1.var_.actorSpriteComps10062 then
				for iter_118_3, iter_118_4 in pairs(arg_115_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_118_4 then
						if arg_115_1.isInRecall_ then
							iter_118_4.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_118_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps10062 = nil
			end

			local var_118_15 = arg_115_1.actors_["10060"]
			local var_118_16 = 0

			if var_118_16 < arg_115_1.time_ and arg_115_1.time_ <= var_118_16 + arg_118_0 and not isNil(var_118_15) and arg_115_1.var_.actorSpriteComps10060 == nil then
				arg_115_1.var_.actorSpriteComps10060 = var_118_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_17 = 0.034

			if var_118_16 <= arg_115_1.time_ and arg_115_1.time_ < var_118_16 + var_118_17 and not isNil(var_118_15) then
				local var_118_18 = (arg_115_1.time_ - var_118_16) / var_118_17

				if arg_115_1.var_.actorSpriteComps10060 then
					for iter_118_5, iter_118_6 in pairs(arg_115_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_118_6 then
							if arg_115_1.isInRecall_ then
								local var_118_19 = Mathf.Lerp(iter_118_6.color.r, arg_115_1.hightColor2.r, var_118_18)
								local var_118_20 = Mathf.Lerp(iter_118_6.color.g, arg_115_1.hightColor2.g, var_118_18)
								local var_118_21 = Mathf.Lerp(iter_118_6.color.b, arg_115_1.hightColor2.b, var_118_18)

								iter_118_6.color = Color.New(var_118_19, var_118_20, var_118_21)
							else
								local var_118_22 = Mathf.Lerp(iter_118_6.color.r, 0.5, var_118_18)

								iter_118_6.color = Color.New(var_118_22, var_118_22, var_118_22)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_16 + var_118_17 and arg_115_1.time_ < var_118_16 + var_118_17 + arg_118_0 and not isNil(var_118_15) and arg_115_1.var_.actorSpriteComps10060 then
				for iter_118_7, iter_118_8 in pairs(arg_115_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_118_8 then
						if arg_115_1.isInRecall_ then
							iter_118_8.color = arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_118_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps10060 = nil
			end

			local var_118_23 = 0
			local var_118_24 = 0.425

			if var_118_23 < arg_115_1.time_ and arg_115_1.time_ <= var_118_23 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_25 = arg_115_1:FormatText(StoryNameCfg[600].name)

				arg_115_1.leftNameTxt_.text = var_118_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_26 = arg_115_1:GetWordFromCfg(410232028)
				local var_118_27 = arg_115_1:FormatText(var_118_26.content)

				arg_115_1.text_.text = var_118_27

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_28 = 17
				local var_118_29 = utf8.len(var_118_27)
				local var_118_30 = var_118_28 <= 0 and var_118_24 or var_118_24 * (var_118_29 / var_118_28)

				if var_118_30 > 0 and var_118_24 < var_118_30 then
					arg_115_1.talkMaxDuration = var_118_30

					if var_118_30 + var_118_23 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_30 + var_118_23
					end
				end

				arg_115_1.text_.text = var_118_27
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232028", "story_v_out_410232.awb") ~= 0 then
					local var_118_31 = manager.audio:GetVoiceLength("story_v_out_410232", "410232028", "story_v_out_410232.awb") / 1000

					if var_118_31 + var_118_23 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_31 + var_118_23
					end

					if var_118_26.prefab_name ~= "" and arg_115_1.actors_[var_118_26.prefab_name] ~= nil then
						local var_118_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_26.prefab_name].transform, "story_v_out_410232", "410232028", "story_v_out_410232.awb")

						arg_115_1:RecordAudio("410232028", var_118_32)
						arg_115_1:RecordAudio("410232028", var_118_32)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_410232", "410232028", "story_v_out_410232.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_410232", "410232028", "story_v_out_410232.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_33 = math.max(var_118_24, arg_115_1.talkMaxDuration)

			if var_118_23 <= arg_115_1.time_ and arg_115_1.time_ < var_118_23 + var_118_33 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_23) / var_118_33

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_23 + var_118_33 and arg_115_1.time_ < var_118_23 + var_118_33 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 410232029
		arg_119_1.duration_ = 9.6

		local var_119_0 = {
			ja = 8.5,
			CriLanguages = 9.6,
			zh = 9.6
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
				arg_119_0:Play410232030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10060"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos10060 = var_122_0.localPosition
				var_122_0.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10060", 2)

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
				local var_122_6 = Vector3.New(-390, -400, 0)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10060, var_122_6, var_122_5)
			end

			if arg_119_1.time_ >= var_122_1 + var_122_4 and arg_119_1.time_ < var_122_1 + var_122_4 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_122_7 = arg_119_1.actors_["10060"]
			local var_122_8 = 0

			if var_122_8 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 and not isNil(var_122_7) and arg_119_1.var_.actorSpriteComps10060 == nil then
				arg_119_1.var_.actorSpriteComps10060 = var_122_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_9 = 0.034

			if var_122_8 <= arg_119_1.time_ and arg_119_1.time_ < var_122_8 + var_122_9 and not isNil(var_122_7) then
				local var_122_10 = (arg_119_1.time_ - var_122_8) / var_122_9

				if arg_119_1.var_.actorSpriteComps10060 then
					for iter_122_1, iter_122_2 in pairs(arg_119_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_122_2 then
							if arg_119_1.isInRecall_ then
								local var_122_11 = Mathf.Lerp(iter_122_2.color.r, arg_119_1.hightColor1.r, var_122_10)
								local var_122_12 = Mathf.Lerp(iter_122_2.color.g, arg_119_1.hightColor1.g, var_122_10)
								local var_122_13 = Mathf.Lerp(iter_122_2.color.b, arg_119_1.hightColor1.b, var_122_10)

								iter_122_2.color = Color.New(var_122_11, var_122_12, var_122_13)
							else
								local var_122_14 = Mathf.Lerp(iter_122_2.color.r, 1, var_122_10)

								iter_122_2.color = Color.New(var_122_14, var_122_14, var_122_14)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_8 + var_122_9 and arg_119_1.time_ < var_122_8 + var_122_9 + arg_122_0 and not isNil(var_122_7) and arg_119_1.var_.actorSpriteComps10060 then
				for iter_122_3, iter_122_4 in pairs(arg_119_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_122_4 then
						if arg_119_1.isInRecall_ then
							iter_122_4.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_122_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps10060 = nil
			end

			local var_122_15 = arg_119_1.actors_["10062"]
			local var_122_16 = 0

			if var_122_16 < arg_119_1.time_ and arg_119_1.time_ <= var_122_16 + arg_122_0 and not isNil(var_122_15) and arg_119_1.var_.actorSpriteComps10062 == nil then
				arg_119_1.var_.actorSpriteComps10062 = var_122_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_17 = 0.034

			if var_122_16 <= arg_119_1.time_ and arg_119_1.time_ < var_122_16 + var_122_17 and not isNil(var_122_15) then
				local var_122_18 = (arg_119_1.time_ - var_122_16) / var_122_17

				if arg_119_1.var_.actorSpriteComps10062 then
					for iter_122_5, iter_122_6 in pairs(arg_119_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_122_6 then
							if arg_119_1.isInRecall_ then
								local var_122_19 = Mathf.Lerp(iter_122_6.color.r, arg_119_1.hightColor2.r, var_122_18)
								local var_122_20 = Mathf.Lerp(iter_122_6.color.g, arg_119_1.hightColor2.g, var_122_18)
								local var_122_21 = Mathf.Lerp(iter_122_6.color.b, arg_119_1.hightColor2.b, var_122_18)

								iter_122_6.color = Color.New(var_122_19, var_122_20, var_122_21)
							else
								local var_122_22 = Mathf.Lerp(iter_122_6.color.r, 0.5, var_122_18)

								iter_122_6.color = Color.New(var_122_22, var_122_22, var_122_22)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_16 + var_122_17 and arg_119_1.time_ < var_122_16 + var_122_17 + arg_122_0 and not isNil(var_122_15) and arg_119_1.var_.actorSpriteComps10062 then
				for iter_122_7, iter_122_8 in pairs(arg_119_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_122_8 then
						if arg_119_1.isInRecall_ then
							iter_122_8.color = arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_122_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps10062 = nil
			end

			local var_122_23 = 0
			local var_122_24 = 0.875

			if var_122_23 < arg_119_1.time_ and arg_119_1.time_ <= var_122_23 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_25 = arg_119_1:FormatText(StoryNameCfg[597].name)

				arg_119_1.leftNameTxt_.text = var_122_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_26 = arg_119_1:GetWordFromCfg(410232029)
				local var_122_27 = arg_119_1:FormatText(var_122_26.content)

				arg_119_1.text_.text = var_122_27

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_28 = 35
				local var_122_29 = utf8.len(var_122_27)
				local var_122_30 = var_122_28 <= 0 and var_122_24 or var_122_24 * (var_122_29 / var_122_28)

				if var_122_30 > 0 and var_122_24 < var_122_30 then
					arg_119_1.talkMaxDuration = var_122_30

					if var_122_30 + var_122_23 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_30 + var_122_23
					end
				end

				arg_119_1.text_.text = var_122_27
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232029", "story_v_out_410232.awb") ~= 0 then
					local var_122_31 = manager.audio:GetVoiceLength("story_v_out_410232", "410232029", "story_v_out_410232.awb") / 1000

					if var_122_31 + var_122_23 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_31 + var_122_23
					end

					if var_122_26.prefab_name ~= "" and arg_119_1.actors_[var_122_26.prefab_name] ~= nil then
						local var_122_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_26.prefab_name].transform, "story_v_out_410232", "410232029", "story_v_out_410232.awb")

						arg_119_1:RecordAudio("410232029", var_122_32)
						arg_119_1:RecordAudio("410232029", var_122_32)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_410232", "410232029", "story_v_out_410232.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_410232", "410232029", "story_v_out_410232.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_33 = math.max(var_122_24, arg_119_1.talkMaxDuration)

			if var_122_23 <= arg_119_1.time_ and arg_119_1.time_ < var_122_23 + var_122_33 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_23) / var_122_33

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_23 + var_122_33 and arg_119_1.time_ < var_122_23 + var_122_33 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
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
	Play410232030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 410232030
		arg_123_1.duration_ = 5.07

		local var_123_0 = {
			ja = 5.066,
			CriLanguages = 4.866,
			zh = 4.866
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
				arg_123_0:Play410232031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10060"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos10060 = var_126_0.localPosition
				var_126_0.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10060", 2)

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
				local var_126_6 = Vector3.New(-390, -400, 0)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10060, var_126_6, var_126_5)
			end

			if arg_123_1.time_ >= var_126_1 + var_126_4 and arg_123_1.time_ < var_126_1 + var_126_4 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_126_7 = arg_123_1.actors_["10060"]
			local var_126_8 = 0

			if var_126_8 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 and not isNil(var_126_7) and arg_123_1.var_.actorSpriteComps10060 == nil then
				arg_123_1.var_.actorSpriteComps10060 = var_126_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_9 = 0.034

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_9 and not isNil(var_126_7) then
				local var_126_10 = (arg_123_1.time_ - var_126_8) / var_126_9

				if arg_123_1.var_.actorSpriteComps10060 then
					for iter_126_1, iter_126_2 in pairs(arg_123_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_126_2 then
							if arg_123_1.isInRecall_ then
								local var_126_11 = Mathf.Lerp(iter_126_2.color.r, arg_123_1.hightColor1.r, var_126_10)
								local var_126_12 = Mathf.Lerp(iter_126_2.color.g, arg_123_1.hightColor1.g, var_126_10)
								local var_126_13 = Mathf.Lerp(iter_126_2.color.b, arg_123_1.hightColor1.b, var_126_10)

								iter_126_2.color = Color.New(var_126_11, var_126_12, var_126_13)
							else
								local var_126_14 = Mathf.Lerp(iter_126_2.color.r, 1, var_126_10)

								iter_126_2.color = Color.New(var_126_14, var_126_14, var_126_14)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_8 + var_126_9 and arg_123_1.time_ < var_126_8 + var_126_9 + arg_126_0 and not isNil(var_126_7) and arg_123_1.var_.actorSpriteComps10060 then
				for iter_126_3, iter_126_4 in pairs(arg_123_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_126_4 then
						if arg_123_1.isInRecall_ then
							iter_126_4.color = arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_126_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps10060 = nil
			end

			local var_126_15 = 0
			local var_126_16 = 0.475

			if var_126_15 < arg_123_1.time_ and arg_123_1.time_ <= var_126_15 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_17 = arg_123_1:FormatText(StoryNameCfg[597].name)

				arg_123_1.leftNameTxt_.text = var_126_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_18 = arg_123_1:GetWordFromCfg(410232030)
				local var_126_19 = arg_123_1:FormatText(var_126_18.content)

				arg_123_1.text_.text = var_126_19

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_20 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232030", "story_v_out_410232.awb") ~= 0 then
					local var_126_23 = manager.audio:GetVoiceLength("story_v_out_410232", "410232030", "story_v_out_410232.awb") / 1000

					if var_126_23 + var_126_15 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_23 + var_126_15
					end

					if var_126_18.prefab_name ~= "" and arg_123_1.actors_[var_126_18.prefab_name] ~= nil then
						local var_126_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_18.prefab_name].transform, "story_v_out_410232", "410232030", "story_v_out_410232.awb")

						arg_123_1:RecordAudio("410232030", var_126_24)
						arg_123_1:RecordAudio("410232030", var_126_24)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_410232", "410232030", "story_v_out_410232.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_410232", "410232030", "story_v_out_410232.awb")
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
				actorName = "10060",
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
	Play410232031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 410232031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play410232032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10060"].transform
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos10060 = var_130_0.localPosition
				var_130_0.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10060", 7)

				local var_130_2 = var_130_0.childCount

				for iter_130_0 = 0, var_130_2 - 1 do
					local var_130_3 = var_130_0:GetChild(iter_130_0)

					if var_130_3.name == "" or not string.find(var_130_3.name, "split") then
						var_130_3.gameObject:SetActive(true)
					else
						var_130_3.gameObject:SetActive(false)
					end
				end
			end

			local var_130_4 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_4 then
				local var_130_5 = (arg_127_1.time_ - var_130_1) / var_130_4
				local var_130_6 = Vector3.New(0, -2000, 0)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10060, var_130_6, var_130_5)
			end

			if arg_127_1.time_ >= var_130_1 + var_130_4 and arg_127_1.time_ < var_130_1 + var_130_4 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_130_7 = arg_127_1.actors_["10062"].transform
			local var_130_8 = 0

			if var_130_8 < arg_127_1.time_ and arg_127_1.time_ <= var_130_8 + arg_130_0 then
				arg_127_1.var_.moveOldPos10062 = var_130_7.localPosition
				var_130_7.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10062", 7)

				local var_130_9 = var_130_7.childCount

				for iter_130_1 = 0, var_130_9 - 1 do
					local var_130_10 = var_130_7:GetChild(iter_130_1)

					if var_130_10.name == "" or not string.find(var_130_10.name, "split") then
						var_130_10.gameObject:SetActive(true)
					else
						var_130_10.gameObject:SetActive(false)
					end
				end
			end

			local var_130_11 = 0.001

			if var_130_8 <= arg_127_1.time_ and arg_127_1.time_ < var_130_8 + var_130_11 then
				local var_130_12 = (arg_127_1.time_ - var_130_8) / var_130_11
				local var_130_13 = Vector3.New(0, -2000, -290)

				var_130_7.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10062, var_130_13, var_130_12)
			end

			if arg_127_1.time_ >= var_130_8 + var_130_11 and arg_127_1.time_ < var_130_8 + var_130_11 + arg_130_0 then
				var_130_7.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_130_14 = arg_127_1.actors_["10059"].transform
			local var_130_15 = 0

			if var_130_15 < arg_127_1.time_ and arg_127_1.time_ <= var_130_15 + arg_130_0 then
				arg_127_1.var_.moveOldPos10059 = var_130_14.localPosition
				var_130_14.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10059", 3)

				local var_130_16 = var_130_14.childCount

				for iter_130_2 = 0, var_130_16 - 1 do
					local var_130_17 = var_130_14:GetChild(iter_130_2)

					if var_130_17.name == "split_3" or not string.find(var_130_17.name, "split") then
						var_130_17.gameObject:SetActive(true)
					else
						var_130_17.gameObject:SetActive(false)
					end
				end
			end

			local var_130_18 = 0.001

			if var_130_15 <= arg_127_1.time_ and arg_127_1.time_ < var_130_15 + var_130_18 then
				local var_130_19 = (arg_127_1.time_ - var_130_15) / var_130_18
				local var_130_20 = Vector3.New(0, -530, 35)

				var_130_14.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10059, var_130_20, var_130_19)
			end

			if arg_127_1.time_ >= var_130_15 + var_130_18 and arg_127_1.time_ < var_130_15 + var_130_18 + arg_130_0 then
				var_130_14.localPosition = Vector3.New(0, -530, 35)
			end

			local var_130_21 = arg_127_1.actors_["10060"]
			local var_130_22 = 0

			if var_130_22 < arg_127_1.time_ and arg_127_1.time_ <= var_130_22 + arg_130_0 and not isNil(var_130_21) and arg_127_1.var_.actorSpriteComps10060 == nil then
				arg_127_1.var_.actorSpriteComps10060 = var_130_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_23 = 0.034

			if var_130_22 <= arg_127_1.time_ and arg_127_1.time_ < var_130_22 + var_130_23 and not isNil(var_130_21) then
				local var_130_24 = (arg_127_1.time_ - var_130_22) / var_130_23

				if arg_127_1.var_.actorSpriteComps10060 then
					for iter_130_3, iter_130_4 in pairs(arg_127_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_130_4 then
							if arg_127_1.isInRecall_ then
								local var_130_25 = Mathf.Lerp(iter_130_4.color.r, arg_127_1.hightColor2.r, var_130_24)
								local var_130_26 = Mathf.Lerp(iter_130_4.color.g, arg_127_1.hightColor2.g, var_130_24)
								local var_130_27 = Mathf.Lerp(iter_130_4.color.b, arg_127_1.hightColor2.b, var_130_24)

								iter_130_4.color = Color.New(var_130_25, var_130_26, var_130_27)
							else
								local var_130_28 = Mathf.Lerp(iter_130_4.color.r, 0.5, var_130_24)

								iter_130_4.color = Color.New(var_130_28, var_130_28, var_130_28)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_22 + var_130_23 and arg_127_1.time_ < var_130_22 + var_130_23 + arg_130_0 and not isNil(var_130_21) and arg_127_1.var_.actorSpriteComps10060 then
				for iter_130_5, iter_130_6 in pairs(arg_127_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_130_6 then
						if arg_127_1.isInRecall_ then
							iter_130_6.color = arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_130_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps10060 = nil
			end

			local var_130_29 = arg_127_1.actors_["10062"]
			local var_130_30 = 0

			if var_130_30 < arg_127_1.time_ and arg_127_1.time_ <= var_130_30 + arg_130_0 and not isNil(var_130_29) and arg_127_1.var_.actorSpriteComps10062 == nil then
				arg_127_1.var_.actorSpriteComps10062 = var_130_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_31 = 0.034

			if var_130_30 <= arg_127_1.time_ and arg_127_1.time_ < var_130_30 + var_130_31 and not isNil(var_130_29) then
				local var_130_32 = (arg_127_1.time_ - var_130_30) / var_130_31

				if arg_127_1.var_.actorSpriteComps10062 then
					for iter_130_7, iter_130_8 in pairs(arg_127_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_130_8 then
							if arg_127_1.isInRecall_ then
								local var_130_33 = Mathf.Lerp(iter_130_8.color.r, arg_127_1.hightColor2.r, var_130_32)
								local var_130_34 = Mathf.Lerp(iter_130_8.color.g, arg_127_1.hightColor2.g, var_130_32)
								local var_130_35 = Mathf.Lerp(iter_130_8.color.b, arg_127_1.hightColor2.b, var_130_32)

								iter_130_8.color = Color.New(var_130_33, var_130_34, var_130_35)
							else
								local var_130_36 = Mathf.Lerp(iter_130_8.color.r, 0.5, var_130_32)

								iter_130_8.color = Color.New(var_130_36, var_130_36, var_130_36)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_30 + var_130_31 and arg_127_1.time_ < var_130_30 + var_130_31 + arg_130_0 and not isNil(var_130_29) and arg_127_1.var_.actorSpriteComps10062 then
				for iter_130_9, iter_130_10 in pairs(arg_127_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_130_10 then
						if arg_127_1.isInRecall_ then
							iter_130_10.color = arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_130_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps10062 = nil
			end

			local var_130_37 = arg_127_1.actors_["10059"]
			local var_130_38 = 0

			if var_130_38 < arg_127_1.time_ and arg_127_1.time_ <= var_130_38 + arg_130_0 and not isNil(var_130_37) and arg_127_1.var_.actorSpriteComps10059 == nil then
				arg_127_1.var_.actorSpriteComps10059 = var_130_37:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_39 = 0.034

			if var_130_38 <= arg_127_1.time_ and arg_127_1.time_ < var_130_38 + var_130_39 and not isNil(var_130_37) then
				local var_130_40 = (arg_127_1.time_ - var_130_38) / var_130_39

				if arg_127_1.var_.actorSpriteComps10059 then
					for iter_130_11, iter_130_12 in pairs(arg_127_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_130_12 then
							if arg_127_1.isInRecall_ then
								local var_130_41 = Mathf.Lerp(iter_130_12.color.r, arg_127_1.hightColor2.r, var_130_40)
								local var_130_42 = Mathf.Lerp(iter_130_12.color.g, arg_127_1.hightColor2.g, var_130_40)
								local var_130_43 = Mathf.Lerp(iter_130_12.color.b, arg_127_1.hightColor2.b, var_130_40)

								iter_130_12.color = Color.New(var_130_41, var_130_42, var_130_43)
							else
								local var_130_44 = Mathf.Lerp(iter_130_12.color.r, 0.5, var_130_40)

								iter_130_12.color = Color.New(var_130_44, var_130_44, var_130_44)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_38 + var_130_39 and arg_127_1.time_ < var_130_38 + var_130_39 + arg_130_0 and not isNil(var_130_37) and arg_127_1.var_.actorSpriteComps10059 then
				for iter_130_13, iter_130_14 in pairs(arg_127_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_130_14 then
						if arg_127_1.isInRecall_ then
							iter_130_14.color = arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_130_14.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps10059 = nil
			end

			local var_130_45 = 0
			local var_130_46 = 0.975

			if var_130_45 < arg_127_1.time_ and arg_127_1.time_ <= var_130_45 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_47 = arg_127_1:GetWordFromCfg(410232031)
				local var_130_48 = arg_127_1:FormatText(var_130_47.content)

				arg_127_1.text_.text = var_130_48

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_49 = 39
				local var_130_50 = utf8.len(var_130_48)
				local var_130_51 = var_130_49 <= 0 and var_130_46 or var_130_46 * (var_130_50 / var_130_49)

				if var_130_51 > 0 and var_130_46 < var_130_51 then
					arg_127_1.talkMaxDuration = var_130_51

					if var_130_51 + var_130_45 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_51 + var_130_45
					end
				end

				arg_127_1.text_.text = var_130_48
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_52 = math.max(var_130_46, arg_127_1.talkMaxDuration)

			if var_130_45 <= arg_127_1.time_ and arg_127_1.time_ < var_130_45 + var_130_52 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_45) / var_130_52

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_45 + var_130_52 and arg_127_1.time_ < var_130_45 + var_130_52 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
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
	Play410232032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 410232032
		arg_131_1.duration_ = 10

		local var_131_0 = {
			ja = 7.333,
			CriLanguages = 10,
			zh = 10
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
				arg_131_0:Play410232033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10059"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos10059 = var_134_0.localPosition
				var_134_0.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("10059", 7)

				local var_134_2 = var_134_0.childCount

				for iter_134_0 = 0, var_134_2 - 1 do
					local var_134_3 = var_134_0:GetChild(iter_134_0)

					if var_134_3.name == "" or not string.find(var_134_3.name, "split") then
						var_134_3.gameObject:SetActive(true)
					else
						var_134_3.gameObject:SetActive(false)
					end
				end
			end

			local var_134_4 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_4 then
				local var_134_5 = (arg_131_1.time_ - var_134_1) / var_134_4
				local var_134_6 = Vector3.New(0, -2000, 35)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10059, var_134_6, var_134_5)
			end

			if arg_131_1.time_ >= var_134_1 + var_134_4 and arg_131_1.time_ < var_134_1 + var_134_4 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_134_7 = arg_131_1.actors_["10062"].transform
			local var_134_8 = 0

			if var_134_8 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 then
				arg_131_1.var_.moveOldPos10062 = var_134_7.localPosition
				var_134_7.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("10062", 3)

				local var_134_9 = var_134_7.childCount

				for iter_134_1 = 0, var_134_9 - 1 do
					local var_134_10 = var_134_7:GetChild(iter_134_1)

					if var_134_10.name == "split_2" or not string.find(var_134_10.name, "split") then
						var_134_10.gameObject:SetActive(true)
					else
						var_134_10.gameObject:SetActive(false)
					end
				end
			end

			local var_134_11 = 0.001

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_11 then
				local var_134_12 = (arg_131_1.time_ - var_134_8) / var_134_11
				local var_134_13 = Vector3.New(0, -390, -290)

				var_134_7.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10062, var_134_13, var_134_12)
			end

			if arg_131_1.time_ >= var_134_8 + var_134_11 and arg_131_1.time_ < var_134_8 + var_134_11 + arg_134_0 then
				var_134_7.localPosition = Vector3.New(0, -390, -290)
			end

			local var_134_14 = arg_131_1.actors_["10059"]
			local var_134_15 = 0

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 and not isNil(var_134_14) and arg_131_1.var_.actorSpriteComps10059 == nil then
				arg_131_1.var_.actorSpriteComps10059 = var_134_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_16 = 0.034

			if var_134_15 <= arg_131_1.time_ and arg_131_1.time_ < var_134_15 + var_134_16 and not isNil(var_134_14) then
				local var_134_17 = (arg_131_1.time_ - var_134_15) / var_134_16

				if arg_131_1.var_.actorSpriteComps10059 then
					for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_134_3 then
							if arg_131_1.isInRecall_ then
								local var_134_18 = Mathf.Lerp(iter_134_3.color.r, arg_131_1.hightColor2.r, var_134_17)
								local var_134_19 = Mathf.Lerp(iter_134_3.color.g, arg_131_1.hightColor2.g, var_134_17)
								local var_134_20 = Mathf.Lerp(iter_134_3.color.b, arg_131_1.hightColor2.b, var_134_17)

								iter_134_3.color = Color.New(var_134_18, var_134_19, var_134_20)
							else
								local var_134_21 = Mathf.Lerp(iter_134_3.color.r, 0.5, var_134_17)

								iter_134_3.color = Color.New(var_134_21, var_134_21, var_134_21)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= var_134_15 + var_134_16 and arg_131_1.time_ < var_134_15 + var_134_16 + arg_134_0 and not isNil(var_134_14) and arg_131_1.var_.actorSpriteComps10059 then
				for iter_134_4, iter_134_5 in pairs(arg_131_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_134_5 then
						if arg_131_1.isInRecall_ then
							iter_134_5.color = arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_134_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps10059 = nil
			end

			local var_134_22 = arg_131_1.actors_["10062"]
			local var_134_23 = 0

			if var_134_23 < arg_131_1.time_ and arg_131_1.time_ <= var_134_23 + arg_134_0 and not isNil(var_134_22) and arg_131_1.var_.actorSpriteComps10062 == nil then
				arg_131_1.var_.actorSpriteComps10062 = var_134_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_24 = 0.034

			if var_134_23 <= arg_131_1.time_ and arg_131_1.time_ < var_134_23 + var_134_24 and not isNil(var_134_22) then
				local var_134_25 = (arg_131_1.time_ - var_134_23) / var_134_24

				if arg_131_1.var_.actorSpriteComps10062 then
					for iter_134_6, iter_134_7 in pairs(arg_131_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_134_7 then
							if arg_131_1.isInRecall_ then
								local var_134_26 = Mathf.Lerp(iter_134_7.color.r, arg_131_1.hightColor1.r, var_134_25)
								local var_134_27 = Mathf.Lerp(iter_134_7.color.g, arg_131_1.hightColor1.g, var_134_25)
								local var_134_28 = Mathf.Lerp(iter_134_7.color.b, arg_131_1.hightColor1.b, var_134_25)

								iter_134_7.color = Color.New(var_134_26, var_134_27, var_134_28)
							else
								local var_134_29 = Mathf.Lerp(iter_134_7.color.r, 1, var_134_25)

								iter_134_7.color = Color.New(var_134_29, var_134_29, var_134_29)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= var_134_23 + var_134_24 and arg_131_1.time_ < var_134_23 + var_134_24 + arg_134_0 and not isNil(var_134_22) and arg_131_1.var_.actorSpriteComps10062 then
				for iter_134_8, iter_134_9 in pairs(arg_131_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_134_9 then
						if arg_131_1.isInRecall_ then
							iter_134_9.color = arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_134_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps10062 = nil
			end

			local var_134_30 = 0
			local var_134_31 = 0.425

			if var_134_30 < arg_131_1.time_ and arg_131_1.time_ <= var_134_30 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_32 = arg_131_1:FormatText(StoryNameCfg[600].name)

				arg_131_1.leftNameTxt_.text = var_134_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_33 = arg_131_1:GetWordFromCfg(410232032)
				local var_134_34 = arg_131_1:FormatText(var_134_33.content)

				arg_131_1.text_.text = var_134_34

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_35 = 17
				local var_134_36 = utf8.len(var_134_34)
				local var_134_37 = var_134_35 <= 0 and var_134_31 or var_134_31 * (var_134_36 / var_134_35)

				if var_134_37 > 0 and var_134_31 < var_134_37 then
					arg_131_1.talkMaxDuration = var_134_37

					if var_134_37 + var_134_30 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_37 + var_134_30
					end
				end

				arg_131_1.text_.text = var_134_34
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232032", "story_v_out_410232.awb") ~= 0 then
					local var_134_38 = manager.audio:GetVoiceLength("story_v_out_410232", "410232032", "story_v_out_410232.awb") / 1000

					if var_134_38 + var_134_30 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_38 + var_134_30
					end

					if var_134_33.prefab_name ~= "" and arg_131_1.actors_[var_134_33.prefab_name] ~= nil then
						local var_134_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_33.prefab_name].transform, "story_v_out_410232", "410232032", "story_v_out_410232.awb")

						arg_131_1:RecordAudio("410232032", var_134_39)
						arg_131_1:RecordAudio("410232032", var_134_39)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_410232", "410232032", "story_v_out_410232.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_410232", "410232032", "story_v_out_410232.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_40 = math.max(var_134_31, arg_131_1.talkMaxDuration)

			if var_134_30 <= arg_131_1.time_ and arg_131_1.time_ < var_134_30 + var_134_40 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_30) / var_134_40

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_30 + var_134_40 and arg_131_1.time_ < var_134_30 + var_134_40 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 410232033
		arg_135_1.duration_ = 6.5

		local var_135_0 = {
			ja = 6.5,
			CriLanguages = 6.266,
			zh = 6.266
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
				arg_135_0:Play410232034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = "ST67"

			if arg_135_1.bgs_[var_138_0] == nil then
				local var_138_1 = Object.Instantiate(arg_135_1.paintGo_)

				var_138_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_138_0)
				var_138_1.name = var_138_0
				var_138_1.transform.parent = arg_135_1.stage_.transform
				var_138_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_135_1.bgs_[var_138_0] = var_138_1
			end

			local var_138_2 = 2

			if var_138_2 < arg_135_1.time_ and arg_135_1.time_ <= var_138_2 + arg_138_0 then
				local var_138_3 = manager.ui.mainCamera.transform.localPosition
				local var_138_4 = Vector3.New(0, 0, 10) + Vector3.New(var_138_3.x, var_138_3.y, 0)
				local var_138_5 = arg_135_1.bgs_.ST67

				var_138_5.transform.localPosition = var_138_4
				var_138_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_138_6 = var_138_5:GetComponent("SpriteRenderer")

				if var_138_6 and var_138_6.sprite then
					local var_138_7 = (var_138_5.transform.localPosition - var_138_3).z
					local var_138_8 = manager.ui.mainCameraCom_
					local var_138_9 = 2 * var_138_7 * Mathf.Tan(var_138_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_138_10 = var_138_9 * var_138_8.aspect
					local var_138_11 = var_138_6.sprite.bounds.size.x
					local var_138_12 = var_138_6.sprite.bounds.size.y
					local var_138_13 = var_138_10 / var_138_11
					local var_138_14 = var_138_9 / var_138_12
					local var_138_15 = var_138_14 < var_138_13 and var_138_13 or var_138_14

					var_138_5.transform.localScale = Vector3.New(var_138_15, var_138_15, 0)
				end

				for iter_138_0, iter_138_1 in pairs(arg_135_1.bgs_) do
					if iter_138_0 ~= "ST67" then
						iter_138_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_138_16 = 0

			if var_138_16 < arg_135_1.time_ and arg_135_1.time_ <= var_138_16 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_17 = 2

			if var_138_16 <= arg_135_1.time_ and arg_135_1.time_ < var_138_16 + var_138_17 then
				local var_138_18 = (arg_135_1.time_ - var_138_16) / var_138_17
				local var_138_19 = Color.New(0, 0, 0)

				var_138_19.a = Mathf.Lerp(0, 1, var_138_18)
				arg_135_1.mask_.color = var_138_19
			end

			if arg_135_1.time_ >= var_138_16 + var_138_17 and arg_135_1.time_ < var_138_16 + var_138_17 + arg_138_0 then
				local var_138_20 = Color.New(0, 0, 0)

				var_138_20.a = 1
				arg_135_1.mask_.color = var_138_20
			end

			local var_138_21 = 2

			if var_138_21 < arg_135_1.time_ and arg_135_1.time_ <= var_138_21 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_22 = 2

			if var_138_21 <= arg_135_1.time_ and arg_135_1.time_ < var_138_21 + var_138_22 then
				local var_138_23 = (arg_135_1.time_ - var_138_21) / var_138_22
				local var_138_24 = Color.New(0, 0, 0)

				var_138_24.a = Mathf.Lerp(1, 0, var_138_23)
				arg_135_1.mask_.color = var_138_24
			end

			if arg_135_1.time_ >= var_138_21 + var_138_22 and arg_135_1.time_ < var_138_21 + var_138_22 + arg_138_0 then
				local var_138_25 = Color.New(0, 0, 0)
				local var_138_26 = 0

				arg_135_1.mask_.enabled = false
				var_138_25.a = var_138_26
				arg_135_1.mask_.color = var_138_25
			end

			local var_138_27 = arg_135_1.actors_["10062"].transform
			local var_138_28 = 4

			if var_138_28 < arg_135_1.time_ and arg_135_1.time_ <= var_138_28 + arg_138_0 then
				arg_135_1.var_.moveOldPos10062 = var_138_27.localPosition
				var_138_27.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10062", 3)

				local var_138_29 = var_138_27.childCount

				for iter_138_2 = 0, var_138_29 - 1 do
					local var_138_30 = var_138_27:GetChild(iter_138_2)

					if var_138_30.name == "" or not string.find(var_138_30.name, "split") then
						var_138_30.gameObject:SetActive(true)
					else
						var_138_30.gameObject:SetActive(false)
					end
				end
			end

			local var_138_31 = 0.001

			if var_138_28 <= arg_135_1.time_ and arg_135_1.time_ < var_138_28 + var_138_31 then
				local var_138_32 = (arg_135_1.time_ - var_138_28) / var_138_31
				local var_138_33 = Vector3.New(0, -390, -290)

				var_138_27.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10062, var_138_33, var_138_32)
			end

			if arg_135_1.time_ >= var_138_28 + var_138_31 and arg_135_1.time_ < var_138_28 + var_138_31 + arg_138_0 then
				var_138_27.localPosition = Vector3.New(0, -390, -290)
			end

			local var_138_34 = arg_135_1.actors_["10062"]
			local var_138_35 = 4

			if var_138_35 < arg_135_1.time_ and arg_135_1.time_ <= var_138_35 + arg_138_0 and not isNil(var_138_34) and arg_135_1.var_.actorSpriteComps10062 == nil then
				arg_135_1.var_.actorSpriteComps10062 = var_138_34:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_36 = 0.034

			if var_138_35 <= arg_135_1.time_ and arg_135_1.time_ < var_138_35 + var_138_36 and not isNil(var_138_34) then
				local var_138_37 = (arg_135_1.time_ - var_138_35) / var_138_36

				if arg_135_1.var_.actorSpriteComps10062 then
					for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_138_4 then
							if arg_135_1.isInRecall_ then
								local var_138_38 = Mathf.Lerp(iter_138_4.color.r, arg_135_1.hightColor1.r, var_138_37)
								local var_138_39 = Mathf.Lerp(iter_138_4.color.g, arg_135_1.hightColor1.g, var_138_37)
								local var_138_40 = Mathf.Lerp(iter_138_4.color.b, arg_135_1.hightColor1.b, var_138_37)

								iter_138_4.color = Color.New(var_138_38, var_138_39, var_138_40)
							else
								local var_138_41 = Mathf.Lerp(iter_138_4.color.r, 1, var_138_37)

								iter_138_4.color = Color.New(var_138_41, var_138_41, var_138_41)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_35 + var_138_36 and arg_135_1.time_ < var_138_35 + var_138_36 + arg_138_0 and not isNil(var_138_34) and arg_135_1.var_.actorSpriteComps10062 then
				for iter_138_5, iter_138_6 in pairs(arg_135_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_138_6 then
						if arg_135_1.isInRecall_ then
							iter_138_6.color = arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_138_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps10062 = nil
			end

			local var_138_42 = arg_135_1.actors_["10062"].transform
			local var_138_43 = 2

			if var_138_43 < arg_135_1.time_ and arg_135_1.time_ <= var_138_43 + arg_138_0 then
				arg_135_1.var_.moveOldPos10062 = var_138_42.localPosition
				var_138_42.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10062", 7)

				local var_138_44 = var_138_42.childCount

				for iter_138_7 = 0, var_138_44 - 1 do
					local var_138_45 = var_138_42:GetChild(iter_138_7)

					if var_138_45.name == "" or not string.find(var_138_45.name, "split") then
						var_138_45.gameObject:SetActive(true)
					else
						var_138_45.gameObject:SetActive(false)
					end
				end
			end

			local var_138_46 = 0.001

			if var_138_43 <= arg_135_1.time_ and arg_135_1.time_ < var_138_43 + var_138_46 then
				local var_138_47 = (arg_135_1.time_ - var_138_43) / var_138_46
				local var_138_48 = Vector3.New(0, -2000, -290)

				var_138_42.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10062, var_138_48, var_138_47)
			end

			if arg_135_1.time_ >= var_138_43 + var_138_46 and arg_135_1.time_ < var_138_43 + var_138_46 + arg_138_0 then
				var_138_42.localPosition = Vector3.New(0, -2000, -290)
			end

			if arg_135_1.frameCnt_ <= 1 then
				arg_135_1.dialog_:SetActive(false)
			end

			local var_138_49 = 4
			local var_138_50 = 0.2

			if var_138_49 < arg_135_1.time_ and arg_135_1.time_ <= var_138_49 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				arg_135_1.dialog_:SetActive(true)

				arg_135_1.dialogCg_.alpha = 0

				local var_138_51 = LeanTween.value(arg_135_1.dialog_, 0, 1, 0.3)

				var_138_51:setOnUpdate(LuaHelper.FloatAction(function(arg_139_0)
					arg_135_1.dialogCg_.alpha = arg_139_0
				end))
				var_138_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_135_1.dialog_)
					var_138_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_135_1.duration_ = arg_135_1.duration_ + 0.3

				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_52 = arg_135_1:FormatText(StoryNameCfg[600].name)

				arg_135_1.leftNameTxt_.text = var_138_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_53 = arg_135_1:GetWordFromCfg(410232033)
				local var_138_54 = arg_135_1:FormatText(var_138_53.content)

				arg_135_1.text_.text = var_138_54

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_55 = 8
				local var_138_56 = utf8.len(var_138_54)
				local var_138_57 = var_138_55 <= 0 and var_138_50 or var_138_50 * (var_138_56 / var_138_55)

				if var_138_57 > 0 and var_138_50 < var_138_57 then
					arg_135_1.talkMaxDuration = var_138_57
					var_138_49 = var_138_49 + 0.3

					if var_138_57 + var_138_49 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_57 + var_138_49
					end
				end

				arg_135_1.text_.text = var_138_54
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232033", "story_v_out_410232.awb") ~= 0 then
					local var_138_58 = manager.audio:GetVoiceLength("story_v_out_410232", "410232033", "story_v_out_410232.awb") / 1000

					if var_138_58 + var_138_49 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_58 + var_138_49
					end

					if var_138_53.prefab_name ~= "" and arg_135_1.actors_[var_138_53.prefab_name] ~= nil then
						local var_138_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_53.prefab_name].transform, "story_v_out_410232", "410232033", "story_v_out_410232.awb")

						arg_135_1:RecordAudio("410232033", var_138_59)
						arg_135_1:RecordAudio("410232033", var_138_59)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_410232", "410232033", "story_v_out_410232.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_410232", "410232033", "story_v_out_410232.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_60 = var_138_49 + 0.3
			local var_138_61 = math.max(var_138_50, arg_135_1.talkMaxDuration)

			if var_138_60 <= arg_135_1.time_ and arg_135_1.time_ < var_138_60 + var_138_61 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_60) / var_138_61

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_60 + var_138_61 and arg_135_1.time_ < var_138_60 + var_138_61 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play410232034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 410232034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play410232035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10062"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps10062 == nil then
				arg_141_1.var_.actorSpriteComps10062 = var_144_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_2 = 0.034

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.actorSpriteComps10062 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_144_1 then
							if arg_141_1.isInRecall_ then
								local var_144_4 = Mathf.Lerp(iter_144_1.color.r, arg_141_1.hightColor2.r, var_144_3)
								local var_144_5 = Mathf.Lerp(iter_144_1.color.g, arg_141_1.hightColor2.g, var_144_3)
								local var_144_6 = Mathf.Lerp(iter_144_1.color.b, arg_141_1.hightColor2.b, var_144_3)

								iter_144_1.color = Color.New(var_144_4, var_144_5, var_144_6)
							else
								local var_144_7 = Mathf.Lerp(iter_144_1.color.r, 0.5, var_144_3)

								iter_144_1.color = Color.New(var_144_7, var_144_7, var_144_7)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps10062 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_144_3 then
						if arg_141_1.isInRecall_ then
							iter_144_3.color = arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_144_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10062 = nil
			end

			local var_144_8 = 0
			local var_144_9 = 0.925

			if var_144_8 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_10 = arg_141_1:GetWordFromCfg(410232034)
				local var_144_11 = arg_141_1:FormatText(var_144_10.content)

				arg_141_1.text_.text = var_144_11

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_12 = 37
				local var_144_13 = utf8.len(var_144_11)
				local var_144_14 = var_144_12 <= 0 and var_144_9 or var_144_9 * (var_144_13 / var_144_12)

				if var_144_14 > 0 and var_144_9 < var_144_14 then
					arg_141_1.talkMaxDuration = var_144_14

					if var_144_14 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_14 + var_144_8
					end
				end

				arg_141_1.text_.text = var_144_11
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_15 = math.max(var_144_9, arg_141_1.talkMaxDuration)

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_15 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_8) / var_144_15

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_8 + var_144_15 and arg_141_1.time_ < var_144_8 + var_144_15 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play410232035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 410232035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play410232036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.925

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_2 = arg_145_1:GetWordFromCfg(410232035)
				local var_148_3 = arg_145_1:FormatText(var_148_2.content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 37
				local var_148_5 = utf8.len(var_148_3)
				local var_148_6 = var_148_4 <= 0 and var_148_1 or var_148_1 * (var_148_5 / var_148_4)

				if var_148_6 > 0 and var_148_1 < var_148_6 then
					arg_145_1.talkMaxDuration = var_148_6

					if var_148_6 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_6 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_7 and arg_145_1.time_ < var_148_0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play410232036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 410232036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play410232037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 1.575

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_2 = arg_149_1:GetWordFromCfg(410232036)
				local var_152_3 = arg_149_1:FormatText(var_152_2.content)

				arg_149_1.text_.text = var_152_3

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 63
				local var_152_5 = utf8.len(var_152_3)
				local var_152_6 = var_152_4 <= 0 and var_152_1 or var_152_1 * (var_152_5 / var_152_4)

				if var_152_6 > 0 and var_152_1 < var_152_6 then
					arg_149_1.talkMaxDuration = var_152_6

					if var_152_6 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_3
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_7 and arg_149_1.time_ < var_152_0 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play410232037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 410232037
		arg_153_1.duration_ = 5.23

		local var_153_0 = {
			ja = 5.233,
			CriLanguages = 1.8,
			zh = 1.8
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
				arg_153_0:Play410232038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10062"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos10062 = var_156_0.localPosition
				var_156_0.localScale = Vector3.New(1, 1, 1)

				local var_156_2 = var_156_0.childCount

				for iter_156_0 = 0, var_156_2 - 1 do
					local var_156_3 = var_156_0:GetChild(iter_156_0)

					if var_156_3.name == "" or not string.find(var_156_3.name, "split") then
						var_156_3.gameObject:SetActive(true)
					else
						var_156_3.gameObject:SetActive(false)
					end
				end
			end

			local var_156_4 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_4 then
				local var_156_5 = (arg_153_1.time_ - var_156_1) / var_156_4
				local var_156_6 = Vector3.New(-370, -390, -290)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10062, var_156_6, var_156_5)
			end

			if arg_153_1.time_ >= var_156_1 + var_156_4 and arg_153_1.time_ < var_156_1 + var_156_4 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(-370, -390, -290)
			end

			local var_156_7 = arg_153_1.actors_["10060"].transform
			local var_156_8 = 0

			if var_156_8 < arg_153_1.time_ and arg_153_1.time_ <= var_156_8 + arg_156_0 then
				arg_153_1.var_.moveOldPos10060 = var_156_7.localPosition
				var_156_7.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10060", 4)

				local var_156_9 = var_156_7.childCount

				for iter_156_1 = 0, var_156_9 - 1 do
					local var_156_10 = var_156_7:GetChild(iter_156_1)

					if var_156_10.name == "" or not string.find(var_156_10.name, "split") then
						var_156_10.gameObject:SetActive(true)
					else
						var_156_10.gameObject:SetActive(false)
					end
				end
			end

			local var_156_11 = 0.001

			if var_156_8 <= arg_153_1.time_ and arg_153_1.time_ < var_156_8 + var_156_11 then
				local var_156_12 = (arg_153_1.time_ - var_156_8) / var_156_11
				local var_156_13 = Vector3.New(390, -400, 0)

				var_156_7.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10060, var_156_13, var_156_12)
			end

			if arg_153_1.time_ >= var_156_8 + var_156_11 and arg_153_1.time_ < var_156_8 + var_156_11 + arg_156_0 then
				var_156_7.localPosition = Vector3.New(390, -400, 0)
			end

			local var_156_14 = arg_153_1.actors_["10062"]
			local var_156_15 = 0

			if var_156_15 < arg_153_1.time_ and arg_153_1.time_ <= var_156_15 + arg_156_0 and not isNil(var_156_14) and arg_153_1.var_.actorSpriteComps10062 == nil then
				arg_153_1.var_.actorSpriteComps10062 = var_156_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_16 = 0.034

			if var_156_15 <= arg_153_1.time_ and arg_153_1.time_ < var_156_15 + var_156_16 and not isNil(var_156_14) then
				local var_156_17 = (arg_153_1.time_ - var_156_15) / var_156_16

				if arg_153_1.var_.actorSpriteComps10062 then
					for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_156_3 then
							if arg_153_1.isInRecall_ then
								local var_156_18 = Mathf.Lerp(iter_156_3.color.r, arg_153_1.hightColor1.r, var_156_17)
								local var_156_19 = Mathf.Lerp(iter_156_3.color.g, arg_153_1.hightColor1.g, var_156_17)
								local var_156_20 = Mathf.Lerp(iter_156_3.color.b, arg_153_1.hightColor1.b, var_156_17)

								iter_156_3.color = Color.New(var_156_18, var_156_19, var_156_20)
							else
								local var_156_21 = Mathf.Lerp(iter_156_3.color.r, 1, var_156_17)

								iter_156_3.color = Color.New(var_156_21, var_156_21, var_156_21)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_15 + var_156_16 and arg_153_1.time_ < var_156_15 + var_156_16 + arg_156_0 and not isNil(var_156_14) and arg_153_1.var_.actorSpriteComps10062 then
				for iter_156_4, iter_156_5 in pairs(arg_153_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_156_5 then
						if arg_153_1.isInRecall_ then
							iter_156_5.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps10062 = nil
			end

			local var_156_22 = arg_153_1.actors_["10060"]
			local var_156_23 = 0

			if var_156_23 < arg_153_1.time_ and arg_153_1.time_ <= var_156_23 + arg_156_0 and not isNil(var_156_22) and arg_153_1.var_.actorSpriteComps10060 == nil then
				arg_153_1.var_.actorSpriteComps10060 = var_156_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_24 = 0.034

			if var_156_23 <= arg_153_1.time_ and arg_153_1.time_ < var_156_23 + var_156_24 and not isNil(var_156_22) then
				local var_156_25 = (arg_153_1.time_ - var_156_23) / var_156_24

				if arg_153_1.var_.actorSpriteComps10060 then
					for iter_156_6, iter_156_7 in pairs(arg_153_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_156_7 then
							if arg_153_1.isInRecall_ then
								local var_156_26 = Mathf.Lerp(iter_156_7.color.r, arg_153_1.hightColor2.r, var_156_25)
								local var_156_27 = Mathf.Lerp(iter_156_7.color.g, arg_153_1.hightColor2.g, var_156_25)
								local var_156_28 = Mathf.Lerp(iter_156_7.color.b, arg_153_1.hightColor2.b, var_156_25)

								iter_156_7.color = Color.New(var_156_26, var_156_27, var_156_28)
							else
								local var_156_29 = Mathf.Lerp(iter_156_7.color.r, 0.5, var_156_25)

								iter_156_7.color = Color.New(var_156_29, var_156_29, var_156_29)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_23 + var_156_24 and arg_153_1.time_ < var_156_23 + var_156_24 + arg_156_0 and not isNil(var_156_22) and arg_153_1.var_.actorSpriteComps10060 then
				for iter_156_8, iter_156_9 in pairs(arg_153_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_156_9 then
						if arg_153_1.isInRecall_ then
							iter_156_9.color = arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_156_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps10060 = nil
			end

			local var_156_30 = 0
			local var_156_31 = 0.1

			if var_156_30 < arg_153_1.time_ and arg_153_1.time_ <= var_156_30 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_32 = arg_153_1:FormatText(StoryNameCfg[600].name)

				arg_153_1.leftNameTxt_.text = var_156_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_33 = arg_153_1:GetWordFromCfg(410232037)
				local var_156_34 = arg_153_1:FormatText(var_156_33.content)

				arg_153_1.text_.text = var_156_34

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_35 = 4
				local var_156_36 = utf8.len(var_156_34)
				local var_156_37 = var_156_35 <= 0 and var_156_31 or var_156_31 * (var_156_36 / var_156_35)

				if var_156_37 > 0 and var_156_31 < var_156_37 then
					arg_153_1.talkMaxDuration = var_156_37

					if var_156_37 + var_156_30 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_37 + var_156_30
					end
				end

				arg_153_1.text_.text = var_156_34
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232037", "story_v_out_410232.awb") ~= 0 then
					local var_156_38 = manager.audio:GetVoiceLength("story_v_out_410232", "410232037", "story_v_out_410232.awb") / 1000

					if var_156_38 + var_156_30 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_38 + var_156_30
					end

					if var_156_33.prefab_name ~= "" and arg_153_1.actors_[var_156_33.prefab_name] ~= nil then
						local var_156_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_33.prefab_name].transform, "story_v_out_410232", "410232037", "story_v_out_410232.awb")

						arg_153_1:RecordAudio("410232037", var_156_39)
						arg_153_1:RecordAudio("410232037", var_156_39)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_410232", "410232037", "story_v_out_410232.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_410232", "410232037", "story_v_out_410232.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_40 = math.max(var_156_31, arg_153_1.talkMaxDuration)

			if var_156_30 <= arg_153_1.time_ and arg_153_1.time_ < var_156_30 + var_156_40 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_30) / var_156_40

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_30 + var_156_40 and arg_153_1.time_ < var_156_30 + var_156_40 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play410232038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 410232038
		arg_157_1.duration_ = 3.17

		local var_157_0 = {
			ja = 3.166,
			CriLanguages = 2.1,
			zh = 2.1
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play410232039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10060"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos10060 = var_160_0.localPosition
				var_160_0.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10060", 4)

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
				local var_160_6 = Vector3.New(390, -400, 0)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10060, var_160_6, var_160_5)
			end

			if arg_157_1.time_ >= var_160_1 + var_160_4 and arg_157_1.time_ < var_160_1 + var_160_4 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(390, -400, 0)
			end

			local var_160_7 = arg_157_1.actors_["10060"]
			local var_160_8 = 0

			if var_160_8 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.actorSpriteComps10060 == nil then
				arg_157_1.var_.actorSpriteComps10060 = var_160_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_9 = 0.034

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_9 and not isNil(var_160_7) then
				local var_160_10 = (arg_157_1.time_ - var_160_8) / var_160_9

				if arg_157_1.var_.actorSpriteComps10060 then
					for iter_160_1, iter_160_2 in pairs(arg_157_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_160_2 then
							if arg_157_1.isInRecall_ then
								local var_160_11 = Mathf.Lerp(iter_160_2.color.r, arg_157_1.hightColor1.r, var_160_10)
								local var_160_12 = Mathf.Lerp(iter_160_2.color.g, arg_157_1.hightColor1.g, var_160_10)
								local var_160_13 = Mathf.Lerp(iter_160_2.color.b, arg_157_1.hightColor1.b, var_160_10)

								iter_160_2.color = Color.New(var_160_11, var_160_12, var_160_13)
							else
								local var_160_14 = Mathf.Lerp(iter_160_2.color.r, 1, var_160_10)

								iter_160_2.color = Color.New(var_160_14, var_160_14, var_160_14)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_8 + var_160_9 and arg_157_1.time_ < var_160_8 + var_160_9 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.actorSpriteComps10060 then
				for iter_160_3, iter_160_4 in pairs(arg_157_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_160_4 then
						if arg_157_1.isInRecall_ then
							iter_160_4.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_160_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10060 = nil
			end

			local var_160_15 = arg_157_1.actors_["10062"]
			local var_160_16 = 0

			if var_160_16 < arg_157_1.time_ and arg_157_1.time_ <= var_160_16 + arg_160_0 and not isNil(var_160_15) and arg_157_1.var_.actorSpriteComps10062 == nil then
				arg_157_1.var_.actorSpriteComps10062 = var_160_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_17 = 0.034

			if var_160_16 <= arg_157_1.time_ and arg_157_1.time_ < var_160_16 + var_160_17 and not isNil(var_160_15) then
				local var_160_18 = (arg_157_1.time_ - var_160_16) / var_160_17

				if arg_157_1.var_.actorSpriteComps10062 then
					for iter_160_5, iter_160_6 in pairs(arg_157_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_160_6 then
							if arg_157_1.isInRecall_ then
								local var_160_19 = Mathf.Lerp(iter_160_6.color.r, arg_157_1.hightColor2.r, var_160_18)
								local var_160_20 = Mathf.Lerp(iter_160_6.color.g, arg_157_1.hightColor2.g, var_160_18)
								local var_160_21 = Mathf.Lerp(iter_160_6.color.b, arg_157_1.hightColor2.b, var_160_18)

								iter_160_6.color = Color.New(var_160_19, var_160_20, var_160_21)
							else
								local var_160_22 = Mathf.Lerp(iter_160_6.color.r, 0.5, var_160_18)

								iter_160_6.color = Color.New(var_160_22, var_160_22, var_160_22)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_16 + var_160_17 and arg_157_1.time_ < var_160_16 + var_160_17 + arg_160_0 and not isNil(var_160_15) and arg_157_1.var_.actorSpriteComps10062 then
				for iter_160_7, iter_160_8 in pairs(arg_157_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_160_8 then
						if arg_157_1.isInRecall_ then
							iter_160_8.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10062 = nil
			end

			local var_160_23 = 0
			local var_160_24 = 0.2

			if var_160_23 < arg_157_1.time_ and arg_157_1.time_ <= var_160_23 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_25 = arg_157_1:FormatText(StoryNameCfg[597].name)

				arg_157_1.leftNameTxt_.text = var_160_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_26 = arg_157_1:GetWordFromCfg(410232038)
				local var_160_27 = arg_157_1:FormatText(var_160_26.content)

				arg_157_1.text_.text = var_160_27

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_28 = 8
				local var_160_29 = utf8.len(var_160_27)
				local var_160_30 = var_160_28 <= 0 and var_160_24 or var_160_24 * (var_160_29 / var_160_28)

				if var_160_30 > 0 and var_160_24 < var_160_30 then
					arg_157_1.talkMaxDuration = var_160_30

					if var_160_30 + var_160_23 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_30 + var_160_23
					end
				end

				arg_157_1.text_.text = var_160_27
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232038", "story_v_out_410232.awb") ~= 0 then
					local var_160_31 = manager.audio:GetVoiceLength("story_v_out_410232", "410232038", "story_v_out_410232.awb") / 1000

					if var_160_31 + var_160_23 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_31 + var_160_23
					end

					if var_160_26.prefab_name ~= "" and arg_157_1.actors_[var_160_26.prefab_name] ~= nil then
						local var_160_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_26.prefab_name].transform, "story_v_out_410232", "410232038", "story_v_out_410232.awb")

						arg_157_1:RecordAudio("410232038", var_160_32)
						arg_157_1:RecordAudio("410232038", var_160_32)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_410232", "410232038", "story_v_out_410232.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_410232", "410232038", "story_v_out_410232.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_33 = math.max(var_160_24, arg_157_1.talkMaxDuration)

			if var_160_23 <= arg_157_1.time_ and arg_157_1.time_ < var_160_23 + var_160_33 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_23) / var_160_33

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_23 + var_160_33 and arg_157_1.time_ < var_160_23 + var_160_33 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play410232039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 410232039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play410232040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10060"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps10060 == nil then
				arg_161_1.var_.actorSpriteComps10060 = var_164_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_2 = 0.034

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.actorSpriteComps10060 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_164_1 then
							if arg_161_1.isInRecall_ then
								local var_164_4 = Mathf.Lerp(iter_164_1.color.r, arg_161_1.hightColor2.r, var_164_3)
								local var_164_5 = Mathf.Lerp(iter_164_1.color.g, arg_161_1.hightColor2.g, var_164_3)
								local var_164_6 = Mathf.Lerp(iter_164_1.color.b, arg_161_1.hightColor2.b, var_164_3)

								iter_164_1.color = Color.New(var_164_4, var_164_5, var_164_6)
							else
								local var_164_7 = Mathf.Lerp(iter_164_1.color.r, 0.5, var_164_3)

								iter_164_1.color = Color.New(var_164_7, var_164_7, var_164_7)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps10060 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_164_3 then
						if arg_161_1.isInRecall_ then
							iter_164_3.color = arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_164_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps10060 = nil
			end

			local var_164_8 = 0
			local var_164_9 = 1.4

			if var_164_8 < arg_161_1.time_ and arg_161_1.time_ <= var_164_8 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_10 = arg_161_1:GetWordFromCfg(410232039)
				local var_164_11 = arg_161_1:FormatText(var_164_10.content)

				arg_161_1.text_.text = var_164_11

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_12 = 56
				local var_164_13 = utf8.len(var_164_11)
				local var_164_14 = var_164_12 <= 0 and var_164_9 or var_164_9 * (var_164_13 / var_164_12)

				if var_164_14 > 0 and var_164_9 < var_164_14 then
					arg_161_1.talkMaxDuration = var_164_14

					if var_164_14 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_14 + var_164_8
					end
				end

				arg_161_1.text_.text = var_164_11
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_15 = math.max(var_164_9, arg_161_1.talkMaxDuration)

			if var_164_8 <= arg_161_1.time_ and arg_161_1.time_ < var_164_8 + var_164_15 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_8) / var_164_15

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_8 + var_164_15 and arg_161_1.time_ < var_164_8 + var_164_15 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play410232040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 410232040
		arg_165_1.duration_ = 15.23

		local var_165_0 = {
			ja = 15.233,
			CriLanguages = 9.433,
			zh = 9.433
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
				arg_165_0:Play410232041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["10062"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos10062 = var_168_0.localPosition
				var_168_0.localScale = Vector3.New(1, 1, 1)

				local var_168_2 = var_168_0.childCount

				for iter_168_0 = 0, var_168_2 - 1 do
					local var_168_3 = var_168_0:GetChild(iter_168_0)

					if var_168_3.name == "" or not string.find(var_168_3.name, "split") then
						var_168_3.gameObject:SetActive(true)
					else
						var_168_3.gameObject:SetActive(false)
					end
				end
			end

			local var_168_4 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_4 then
				local var_168_5 = (arg_165_1.time_ - var_168_1) / var_168_4
				local var_168_6 = Vector3.New(-370, -390, -290)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10062, var_168_6, var_168_5)
			end

			if arg_165_1.time_ >= var_168_1 + var_168_4 and arg_165_1.time_ < var_168_1 + var_168_4 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(-370, -390, -290)
			end

			local var_168_7 = arg_165_1.actors_["10062"]
			local var_168_8 = 0

			if var_168_8 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 and not isNil(var_168_7) and arg_165_1.var_.actorSpriteComps10062 == nil then
				arg_165_1.var_.actorSpriteComps10062 = var_168_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_9 = 0.034

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_9 and not isNil(var_168_7) then
				local var_168_10 = (arg_165_1.time_ - var_168_8) / var_168_9

				if arg_165_1.var_.actorSpriteComps10062 then
					for iter_168_1, iter_168_2 in pairs(arg_165_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_168_2 then
							if arg_165_1.isInRecall_ then
								local var_168_11 = Mathf.Lerp(iter_168_2.color.r, arg_165_1.hightColor1.r, var_168_10)
								local var_168_12 = Mathf.Lerp(iter_168_2.color.g, arg_165_1.hightColor1.g, var_168_10)
								local var_168_13 = Mathf.Lerp(iter_168_2.color.b, arg_165_1.hightColor1.b, var_168_10)

								iter_168_2.color = Color.New(var_168_11, var_168_12, var_168_13)
							else
								local var_168_14 = Mathf.Lerp(iter_168_2.color.r, 1, var_168_10)

								iter_168_2.color = Color.New(var_168_14, var_168_14, var_168_14)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_8 + var_168_9 and arg_165_1.time_ < var_168_8 + var_168_9 + arg_168_0 and not isNil(var_168_7) and arg_165_1.var_.actorSpriteComps10062 then
				for iter_168_3, iter_168_4 in pairs(arg_165_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_168_4 then
						if arg_165_1.isInRecall_ then
							iter_168_4.color = arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_168_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps10062 = nil
			end

			local var_168_15 = 0
			local var_168_16 = 0.975

			if var_168_15 < arg_165_1.time_ and arg_165_1.time_ <= var_168_15 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_17 = arg_165_1:FormatText(StoryNameCfg[600].name)

				arg_165_1.leftNameTxt_.text = var_168_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_18 = arg_165_1:GetWordFromCfg(410232040)
				local var_168_19 = arg_165_1:FormatText(var_168_18.content)

				arg_165_1.text_.text = var_168_19

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_20 = 39
				local var_168_21 = utf8.len(var_168_19)
				local var_168_22 = var_168_20 <= 0 and var_168_16 or var_168_16 * (var_168_21 / var_168_20)

				if var_168_22 > 0 and var_168_16 < var_168_22 then
					arg_165_1.talkMaxDuration = var_168_22

					if var_168_22 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_22 + var_168_15
					end
				end

				arg_165_1.text_.text = var_168_19
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232040", "story_v_out_410232.awb") ~= 0 then
					local var_168_23 = manager.audio:GetVoiceLength("story_v_out_410232", "410232040", "story_v_out_410232.awb") / 1000

					if var_168_23 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_23 + var_168_15
					end

					if var_168_18.prefab_name ~= "" and arg_165_1.actors_[var_168_18.prefab_name] ~= nil then
						local var_168_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_18.prefab_name].transform, "story_v_out_410232", "410232040", "story_v_out_410232.awb")

						arg_165_1:RecordAudio("410232040", var_168_24)
						arg_165_1:RecordAudio("410232040", var_168_24)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_410232", "410232040", "story_v_out_410232.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_410232", "410232040", "story_v_out_410232.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_25 = math.max(var_168_16, arg_165_1.talkMaxDuration)

			if var_168_15 <= arg_165_1.time_ and arg_165_1.time_ < var_168_15 + var_168_25 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_15) / var_168_25

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_15 + var_168_25 and arg_165_1.time_ < var_168_15 + var_168_25 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play410232041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 410232041
		arg_169_1.duration_ = 17

		local var_169_0 = {
			ja = 17,
			CriLanguages = 10.7,
			zh = 10.7
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
				arg_169_0:Play410232042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 0.95

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_2 = arg_169_1:FormatText(StoryNameCfg[600].name)

				arg_169_1.leftNameTxt_.text = var_172_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_3 = arg_169_1:GetWordFromCfg(410232041)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 38
				local var_172_6 = utf8.len(var_172_4)
				local var_172_7 = var_172_5 <= 0 and var_172_1 or var_172_1 * (var_172_6 / var_172_5)

				if var_172_7 > 0 and var_172_1 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_4
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232041", "story_v_out_410232.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_out_410232", "410232041", "story_v_out_410232.awb") / 1000

					if var_172_8 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_0
					end

					if var_172_3.prefab_name ~= "" and arg_169_1.actors_[var_172_3.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_3.prefab_name].transform, "story_v_out_410232", "410232041", "story_v_out_410232.awb")

						arg_169_1:RecordAudio("410232041", var_172_9)
						arg_169_1:RecordAudio("410232041", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_410232", "410232041", "story_v_out_410232.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_410232", "410232041", "story_v_out_410232.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_10 and arg_169_1.time_ < var_172_0 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play410232042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 410232042
		arg_173_1.duration_ = 2.5

		local var_173_0 = {
			ja = 2.233,
			CriLanguages = 2.5,
			zh = 2.5
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
				arg_173_0:Play410232043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10060"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos10060 = var_176_0.localPosition
				var_176_0.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("10060", 4)

				local var_176_2 = var_176_0.childCount

				for iter_176_0 = 0, var_176_2 - 1 do
					local var_176_3 = var_176_0:GetChild(iter_176_0)

					if var_176_3.name == "split_4" or not string.find(var_176_3.name, "split") then
						var_176_3.gameObject:SetActive(true)
					else
						var_176_3.gameObject:SetActive(false)
					end
				end
			end

			local var_176_4 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_4 then
				local var_176_5 = (arg_173_1.time_ - var_176_1) / var_176_4
				local var_176_6 = Vector3.New(390, -400, 0)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10060, var_176_6, var_176_5)
			end

			if arg_173_1.time_ >= var_176_1 + var_176_4 and arg_173_1.time_ < var_176_1 + var_176_4 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(390, -400, 0)
			end

			local var_176_7 = arg_173_1.actors_["10060"]
			local var_176_8 = 0

			if var_176_8 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 and not isNil(var_176_7) and arg_173_1.var_.actorSpriteComps10060 == nil then
				arg_173_1.var_.actorSpriteComps10060 = var_176_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_9 = 0.034

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_9 and not isNil(var_176_7) then
				local var_176_10 = (arg_173_1.time_ - var_176_8) / var_176_9

				if arg_173_1.var_.actorSpriteComps10060 then
					for iter_176_1, iter_176_2 in pairs(arg_173_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_176_2 then
							if arg_173_1.isInRecall_ then
								local var_176_11 = Mathf.Lerp(iter_176_2.color.r, arg_173_1.hightColor1.r, var_176_10)
								local var_176_12 = Mathf.Lerp(iter_176_2.color.g, arg_173_1.hightColor1.g, var_176_10)
								local var_176_13 = Mathf.Lerp(iter_176_2.color.b, arg_173_1.hightColor1.b, var_176_10)

								iter_176_2.color = Color.New(var_176_11, var_176_12, var_176_13)
							else
								local var_176_14 = Mathf.Lerp(iter_176_2.color.r, 1, var_176_10)

								iter_176_2.color = Color.New(var_176_14, var_176_14, var_176_14)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_8 + var_176_9 and arg_173_1.time_ < var_176_8 + var_176_9 + arg_176_0 and not isNil(var_176_7) and arg_173_1.var_.actorSpriteComps10060 then
				for iter_176_3, iter_176_4 in pairs(arg_173_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_176_4 then
						if arg_173_1.isInRecall_ then
							iter_176_4.color = arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_176_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps10060 = nil
			end

			local var_176_15 = arg_173_1.actors_["10062"]
			local var_176_16 = 0

			if var_176_16 < arg_173_1.time_ and arg_173_1.time_ <= var_176_16 + arg_176_0 and not isNil(var_176_15) and arg_173_1.var_.actorSpriteComps10062 == nil then
				arg_173_1.var_.actorSpriteComps10062 = var_176_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_17 = 0.034

			if var_176_16 <= arg_173_1.time_ and arg_173_1.time_ < var_176_16 + var_176_17 and not isNil(var_176_15) then
				local var_176_18 = (arg_173_1.time_ - var_176_16) / var_176_17

				if arg_173_1.var_.actorSpriteComps10062 then
					for iter_176_5, iter_176_6 in pairs(arg_173_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_176_6 then
							if arg_173_1.isInRecall_ then
								local var_176_19 = Mathf.Lerp(iter_176_6.color.r, arg_173_1.hightColor2.r, var_176_18)
								local var_176_20 = Mathf.Lerp(iter_176_6.color.g, arg_173_1.hightColor2.g, var_176_18)
								local var_176_21 = Mathf.Lerp(iter_176_6.color.b, arg_173_1.hightColor2.b, var_176_18)

								iter_176_6.color = Color.New(var_176_19, var_176_20, var_176_21)
							else
								local var_176_22 = Mathf.Lerp(iter_176_6.color.r, 0.5, var_176_18)

								iter_176_6.color = Color.New(var_176_22, var_176_22, var_176_22)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_16 + var_176_17 and arg_173_1.time_ < var_176_16 + var_176_17 + arg_176_0 and not isNil(var_176_15) and arg_173_1.var_.actorSpriteComps10062 then
				for iter_176_7, iter_176_8 in pairs(arg_173_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_176_8 then
						if arg_173_1.isInRecall_ then
							iter_176_8.color = arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_176_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps10062 = nil
			end

			local var_176_23 = 0
			local var_176_24 = 0.175

			if var_176_23 < arg_173_1.time_ and arg_173_1.time_ <= var_176_23 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_25 = arg_173_1:FormatText(StoryNameCfg[597].name)

				arg_173_1.leftNameTxt_.text = var_176_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_26 = arg_173_1:GetWordFromCfg(410232042)
				local var_176_27 = arg_173_1:FormatText(var_176_26.content)

				arg_173_1.text_.text = var_176_27

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_28 = 7
				local var_176_29 = utf8.len(var_176_27)
				local var_176_30 = var_176_28 <= 0 and var_176_24 or var_176_24 * (var_176_29 / var_176_28)

				if var_176_30 > 0 and var_176_24 < var_176_30 then
					arg_173_1.talkMaxDuration = var_176_30

					if var_176_30 + var_176_23 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_30 + var_176_23
					end
				end

				arg_173_1.text_.text = var_176_27
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232042", "story_v_out_410232.awb") ~= 0 then
					local var_176_31 = manager.audio:GetVoiceLength("story_v_out_410232", "410232042", "story_v_out_410232.awb") / 1000

					if var_176_31 + var_176_23 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_31 + var_176_23
					end

					if var_176_26.prefab_name ~= "" and arg_173_1.actors_[var_176_26.prefab_name] ~= nil then
						local var_176_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_26.prefab_name].transform, "story_v_out_410232", "410232042", "story_v_out_410232.awb")

						arg_173_1:RecordAudio("410232042", var_176_32)
						arg_173_1:RecordAudio("410232042", var_176_32)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_410232", "410232042", "story_v_out_410232.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_410232", "410232042", "story_v_out_410232.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_33 = math.max(var_176_24, arg_173_1.talkMaxDuration)

			if var_176_23 <= arg_173_1.time_ and arg_173_1.time_ < var_176_23 + var_176_33 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_23) / var_176_33

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_23 + var_176_33 and arg_173_1.time_ < var_176_23 + var_176_33 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play410232043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 410232043
		arg_177_1.duration_ = 9.13

		local var_177_0 = {
			ja = 9.133,
			CriLanguages = 7.3,
			zh = 7.3
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
				arg_177_0:Play410232044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10062"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos10062 = var_180_0.localPosition
				var_180_0.localScale = Vector3.New(1, 1, 1)

				local var_180_2 = var_180_0.childCount

				for iter_180_0 = 0, var_180_2 - 1 do
					local var_180_3 = var_180_0:GetChild(iter_180_0)

					if var_180_3.name == "" or not string.find(var_180_3.name, "split") then
						var_180_3.gameObject:SetActive(true)
					else
						var_180_3.gameObject:SetActive(false)
					end
				end
			end

			local var_180_4 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_4 then
				local var_180_5 = (arg_177_1.time_ - var_180_1) / var_180_4
				local var_180_6 = Vector3.New(-370, -390, -290)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10062, var_180_6, var_180_5)
			end

			if arg_177_1.time_ >= var_180_1 + var_180_4 and arg_177_1.time_ < var_180_1 + var_180_4 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(-370, -390, -290)
			end

			local var_180_7 = arg_177_1.actors_["10060"]
			local var_180_8 = 0

			if var_180_8 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 and not isNil(var_180_7) and arg_177_1.var_.actorSpriteComps10060 == nil then
				arg_177_1.var_.actorSpriteComps10060 = var_180_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_9 = 0.034

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_9 and not isNil(var_180_7) then
				local var_180_10 = (arg_177_1.time_ - var_180_8) / var_180_9

				if arg_177_1.var_.actorSpriteComps10060 then
					for iter_180_1, iter_180_2 in pairs(arg_177_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_180_2 then
							if arg_177_1.isInRecall_ then
								local var_180_11 = Mathf.Lerp(iter_180_2.color.r, arg_177_1.hightColor2.r, var_180_10)
								local var_180_12 = Mathf.Lerp(iter_180_2.color.g, arg_177_1.hightColor2.g, var_180_10)
								local var_180_13 = Mathf.Lerp(iter_180_2.color.b, arg_177_1.hightColor2.b, var_180_10)

								iter_180_2.color = Color.New(var_180_11, var_180_12, var_180_13)
							else
								local var_180_14 = Mathf.Lerp(iter_180_2.color.r, 0.5, var_180_10)

								iter_180_2.color = Color.New(var_180_14, var_180_14, var_180_14)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_8 + var_180_9 and arg_177_1.time_ < var_180_8 + var_180_9 + arg_180_0 and not isNil(var_180_7) and arg_177_1.var_.actorSpriteComps10060 then
				for iter_180_3, iter_180_4 in pairs(arg_177_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_180_4 then
						if arg_177_1.isInRecall_ then
							iter_180_4.color = arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_180_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps10060 = nil
			end

			local var_180_15 = arg_177_1.actors_["10062"]
			local var_180_16 = 0

			if var_180_16 < arg_177_1.time_ and arg_177_1.time_ <= var_180_16 + arg_180_0 and not isNil(var_180_15) and arg_177_1.var_.actorSpriteComps10062 == nil then
				arg_177_1.var_.actorSpriteComps10062 = var_180_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_17 = 0.034

			if var_180_16 <= arg_177_1.time_ and arg_177_1.time_ < var_180_16 + var_180_17 and not isNil(var_180_15) then
				local var_180_18 = (arg_177_1.time_ - var_180_16) / var_180_17

				if arg_177_1.var_.actorSpriteComps10062 then
					for iter_180_5, iter_180_6 in pairs(arg_177_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_180_6 then
							if arg_177_1.isInRecall_ then
								local var_180_19 = Mathf.Lerp(iter_180_6.color.r, arg_177_1.hightColor1.r, var_180_18)
								local var_180_20 = Mathf.Lerp(iter_180_6.color.g, arg_177_1.hightColor1.g, var_180_18)
								local var_180_21 = Mathf.Lerp(iter_180_6.color.b, arg_177_1.hightColor1.b, var_180_18)

								iter_180_6.color = Color.New(var_180_19, var_180_20, var_180_21)
							else
								local var_180_22 = Mathf.Lerp(iter_180_6.color.r, 1, var_180_18)

								iter_180_6.color = Color.New(var_180_22, var_180_22, var_180_22)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_16 + var_180_17 and arg_177_1.time_ < var_180_16 + var_180_17 + arg_180_0 and not isNil(var_180_15) and arg_177_1.var_.actorSpriteComps10062 then
				for iter_180_7, iter_180_8 in pairs(arg_177_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_180_8 then
						if arg_177_1.isInRecall_ then
							iter_180_8.color = arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_180_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps10062 = nil
			end

			local var_180_23 = 0
			local var_180_24 = 0.75

			if var_180_23 < arg_177_1.time_ and arg_177_1.time_ <= var_180_23 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_25 = arg_177_1:FormatText(StoryNameCfg[600].name)

				arg_177_1.leftNameTxt_.text = var_180_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_26 = arg_177_1:GetWordFromCfg(410232043)
				local var_180_27 = arg_177_1:FormatText(var_180_26.content)

				arg_177_1.text_.text = var_180_27

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_28 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232043", "story_v_out_410232.awb") ~= 0 then
					local var_180_31 = manager.audio:GetVoiceLength("story_v_out_410232", "410232043", "story_v_out_410232.awb") / 1000

					if var_180_31 + var_180_23 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_31 + var_180_23
					end

					if var_180_26.prefab_name ~= "" and arg_177_1.actors_[var_180_26.prefab_name] ~= nil then
						local var_180_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_26.prefab_name].transform, "story_v_out_410232", "410232043", "story_v_out_410232.awb")

						arg_177_1:RecordAudio("410232043", var_180_32)
						arg_177_1:RecordAudio("410232043", var_180_32)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_410232", "410232043", "story_v_out_410232.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_410232", "410232043", "story_v_out_410232.awb")
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
				actorName = "10062",
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
	Play410232044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 410232044
		arg_181_1.duration_ = 5.57

		local var_181_0 = {
			ja = 5.566,
			CriLanguages = 2.866,
			zh = 2.866
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
				arg_181_0:Play410232045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10060"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos10060 = var_184_0.localPosition
				var_184_0.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10060", 4)

				local var_184_2 = var_184_0.childCount

				for iter_184_0 = 0, var_184_2 - 1 do
					local var_184_3 = var_184_0:GetChild(iter_184_0)

					if var_184_3.name == "" or not string.find(var_184_3.name, "split") then
						var_184_3.gameObject:SetActive(true)
					else
						var_184_3.gameObject:SetActive(false)
					end
				end
			end

			local var_184_4 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_4 then
				local var_184_5 = (arg_181_1.time_ - var_184_1) / var_184_4
				local var_184_6 = Vector3.New(390, -400, 0)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10060, var_184_6, var_184_5)
			end

			if arg_181_1.time_ >= var_184_1 + var_184_4 and arg_181_1.time_ < var_184_1 + var_184_4 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(390, -400, 0)
			end

			local var_184_7 = arg_181_1.actors_["10060"]
			local var_184_8 = 0

			if var_184_8 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 and not isNil(var_184_7) and arg_181_1.var_.actorSpriteComps10060 == nil then
				arg_181_1.var_.actorSpriteComps10060 = var_184_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_9 = 0.034

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_9 and not isNil(var_184_7) then
				local var_184_10 = (arg_181_1.time_ - var_184_8) / var_184_9

				if arg_181_1.var_.actorSpriteComps10060 then
					for iter_184_1, iter_184_2 in pairs(arg_181_1.var_.actorSpriteComps10060:ToTable()) do
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

			if arg_181_1.time_ >= var_184_8 + var_184_9 and arg_181_1.time_ < var_184_8 + var_184_9 + arg_184_0 and not isNil(var_184_7) and arg_181_1.var_.actorSpriteComps10060 then
				for iter_184_3, iter_184_4 in pairs(arg_181_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_184_4 then
						if arg_181_1.isInRecall_ then
							iter_184_4.color = arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_184_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps10060 = nil
			end

			local var_184_15 = arg_181_1.actors_["10062"]
			local var_184_16 = 0

			if var_184_16 < arg_181_1.time_ and arg_181_1.time_ <= var_184_16 + arg_184_0 and not isNil(var_184_15) and arg_181_1.var_.actorSpriteComps10062 == nil then
				arg_181_1.var_.actorSpriteComps10062 = var_184_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_17 = 0.034

			if var_184_16 <= arg_181_1.time_ and arg_181_1.time_ < var_184_16 + var_184_17 and not isNil(var_184_15) then
				local var_184_18 = (arg_181_1.time_ - var_184_16) / var_184_17

				if arg_181_1.var_.actorSpriteComps10062 then
					for iter_184_5, iter_184_6 in pairs(arg_181_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_184_6 then
							if arg_181_1.isInRecall_ then
								local var_184_19 = Mathf.Lerp(iter_184_6.color.r, arg_181_1.hightColor2.r, var_184_18)
								local var_184_20 = Mathf.Lerp(iter_184_6.color.g, arg_181_1.hightColor2.g, var_184_18)
								local var_184_21 = Mathf.Lerp(iter_184_6.color.b, arg_181_1.hightColor2.b, var_184_18)

								iter_184_6.color = Color.New(var_184_19, var_184_20, var_184_21)
							else
								local var_184_22 = Mathf.Lerp(iter_184_6.color.r, 0.5, var_184_18)

								iter_184_6.color = Color.New(var_184_22, var_184_22, var_184_22)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_16 + var_184_17 and arg_181_1.time_ < var_184_16 + var_184_17 + arg_184_0 and not isNil(var_184_15) and arg_181_1.var_.actorSpriteComps10062 then
				for iter_184_7, iter_184_8 in pairs(arg_181_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_184_8 then
						if arg_181_1.isInRecall_ then
							iter_184_8.color = arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_184_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps10062 = nil
			end

			local var_184_23 = 0
			local var_184_24 = 0.225

			if var_184_23 < arg_181_1.time_ and arg_181_1.time_ <= var_184_23 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_25 = arg_181_1:FormatText(StoryNameCfg[597].name)

				arg_181_1.leftNameTxt_.text = var_184_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_26 = arg_181_1:GetWordFromCfg(410232044)
				local var_184_27 = arg_181_1:FormatText(var_184_26.content)

				arg_181_1.text_.text = var_184_27

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_28 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232044", "story_v_out_410232.awb") ~= 0 then
					local var_184_31 = manager.audio:GetVoiceLength("story_v_out_410232", "410232044", "story_v_out_410232.awb") / 1000

					if var_184_31 + var_184_23 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_31 + var_184_23
					end

					if var_184_26.prefab_name ~= "" and arg_181_1.actors_[var_184_26.prefab_name] ~= nil then
						local var_184_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_26.prefab_name].transform, "story_v_out_410232", "410232044", "story_v_out_410232.awb")

						arg_181_1:RecordAudio("410232044", var_184_32)
						arg_181_1:RecordAudio("410232044", var_184_32)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_410232", "410232044", "story_v_out_410232.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_410232", "410232044", "story_v_out_410232.awb")
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
				actorName = "10060",
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
	Play410232045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 410232045
		arg_185_1.duration_ = 12.57

		local var_185_0 = {
			ja = 12.566,
			CriLanguages = 6.833,
			zh = 6.833
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
				arg_185_0:Play410232046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10062"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos10062 = var_188_0.localPosition
				var_188_0.localScale = Vector3.New(1, 1, 1)

				local var_188_2 = var_188_0.childCount

				for iter_188_0 = 0, var_188_2 - 1 do
					local var_188_3 = var_188_0:GetChild(iter_188_0)

					if var_188_3.name == "" or not string.find(var_188_3.name, "split") then
						var_188_3.gameObject:SetActive(true)
					else
						var_188_3.gameObject:SetActive(false)
					end
				end
			end

			local var_188_4 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_4 then
				local var_188_5 = (arg_185_1.time_ - var_188_1) / var_188_4
				local var_188_6 = Vector3.New(-370, -390, -290)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10062, var_188_6, var_188_5)
			end

			if arg_185_1.time_ >= var_188_1 + var_188_4 and arg_185_1.time_ < var_188_1 + var_188_4 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(-370, -390, -290)
			end

			local var_188_7 = arg_185_1.actors_["10060"]
			local var_188_8 = 0

			if var_188_8 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 and not isNil(var_188_7) and arg_185_1.var_.actorSpriteComps10060 == nil then
				arg_185_1.var_.actorSpriteComps10060 = var_188_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_9 = 0.034

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_9 and not isNil(var_188_7) then
				local var_188_10 = (arg_185_1.time_ - var_188_8) / var_188_9

				if arg_185_1.var_.actorSpriteComps10060 then
					for iter_188_1, iter_188_2 in pairs(arg_185_1.var_.actorSpriteComps10060:ToTable()) do
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

			if arg_185_1.time_ >= var_188_8 + var_188_9 and arg_185_1.time_ < var_188_8 + var_188_9 + arg_188_0 and not isNil(var_188_7) and arg_185_1.var_.actorSpriteComps10060 then
				for iter_188_3, iter_188_4 in pairs(arg_185_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_188_4 then
						if arg_185_1.isInRecall_ then
							iter_188_4.color = arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_188_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps10060 = nil
			end

			local var_188_15 = arg_185_1.actors_["10062"]
			local var_188_16 = 0

			if var_188_16 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 and not isNil(var_188_15) and arg_185_1.var_.actorSpriteComps10062 == nil then
				arg_185_1.var_.actorSpriteComps10062 = var_188_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_17 = 0.034

			if var_188_16 <= arg_185_1.time_ and arg_185_1.time_ < var_188_16 + var_188_17 and not isNil(var_188_15) then
				local var_188_18 = (arg_185_1.time_ - var_188_16) / var_188_17

				if arg_185_1.var_.actorSpriteComps10062 then
					for iter_188_5, iter_188_6 in pairs(arg_185_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_185_1.time_ >= var_188_16 + var_188_17 and arg_185_1.time_ < var_188_16 + var_188_17 + arg_188_0 and not isNil(var_188_15) and arg_185_1.var_.actorSpriteComps10062 then
				for iter_188_7, iter_188_8 in pairs(arg_185_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_188_8 then
						if arg_185_1.isInRecall_ then
							iter_188_8.color = arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_188_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps10062 = nil
			end

			local var_188_23 = 0
			local var_188_24 = 0.7

			if var_188_23 < arg_185_1.time_ and arg_185_1.time_ <= var_188_23 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_25 = arg_185_1:FormatText(StoryNameCfg[600].name)

				arg_185_1.leftNameTxt_.text = var_188_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_26 = arg_185_1:GetWordFromCfg(410232045)
				local var_188_27 = arg_185_1:FormatText(var_188_26.content)

				arg_185_1.text_.text = var_188_27

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_28 = 28
				local var_188_29 = utf8.len(var_188_27)
				local var_188_30 = var_188_28 <= 0 and var_188_24 or var_188_24 * (var_188_29 / var_188_28)

				if var_188_30 > 0 and var_188_24 < var_188_30 then
					arg_185_1.talkMaxDuration = var_188_30

					if var_188_30 + var_188_23 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_30 + var_188_23
					end
				end

				arg_185_1.text_.text = var_188_27
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232045", "story_v_out_410232.awb") ~= 0 then
					local var_188_31 = manager.audio:GetVoiceLength("story_v_out_410232", "410232045", "story_v_out_410232.awb") / 1000

					if var_188_31 + var_188_23 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_31 + var_188_23
					end

					if var_188_26.prefab_name ~= "" and arg_185_1.actors_[var_188_26.prefab_name] ~= nil then
						local var_188_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_26.prefab_name].transform, "story_v_out_410232", "410232045", "story_v_out_410232.awb")

						arg_185_1:RecordAudio("410232045", var_188_32)
						arg_185_1:RecordAudio("410232045", var_188_32)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_410232", "410232045", "story_v_out_410232.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_410232", "410232045", "story_v_out_410232.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_33 = math.max(var_188_24, arg_185_1.talkMaxDuration)

			if var_188_23 <= arg_185_1.time_ and arg_185_1.time_ < var_188_23 + var_188_33 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_23) / var_188_33

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_23 + var_188_33 and arg_185_1.time_ < var_188_23 + var_188_33 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 410232046
		arg_189_1.duration_ = 16.33

		local var_189_0 = {
			ja = 16.333,
			CriLanguages = 10.433,
			zh = 10.433
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
				arg_189_0:Play410232047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 1

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[600].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_3 = arg_189_1:GetWordFromCfg(410232046)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 40
				local var_192_6 = utf8.len(var_192_4)
				local var_192_7 = var_192_5 <= 0 and var_192_1 or var_192_1 * (var_192_6 / var_192_5)

				if var_192_7 > 0 and var_192_1 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232046", "story_v_out_410232.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_410232", "410232046", "story_v_out_410232.awb") / 1000

					if var_192_8 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_0
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_out_410232", "410232046", "story_v_out_410232.awb")

						arg_189_1:RecordAudio("410232046", var_192_9)
						arg_189_1:RecordAudio("410232046", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_410232", "410232046", "story_v_out_410232.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_410232", "410232046", "story_v_out_410232.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_10 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_10 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_10

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_10 and arg_189_1.time_ < var_192_0 + var_192_10 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play410232047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 410232047
		arg_193_1.duration_ = 7.3

		local var_193_0 = {
			ja = 7.3,
			CriLanguages = 5.2,
			zh = 5.2
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
				arg_193_0:Play410232048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10060"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos10060 = var_196_0.localPosition
				var_196_0.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10060", 4)

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
				local var_196_6 = Vector3.New(390, -400, 0)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10060, var_196_6, var_196_5)
			end

			if arg_193_1.time_ >= var_196_1 + var_196_4 and arg_193_1.time_ < var_196_1 + var_196_4 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(390, -400, 0)
			end

			local var_196_7 = arg_193_1.actors_["10060"]
			local var_196_8 = 0

			if var_196_8 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 and not isNil(var_196_7) and arg_193_1.var_.actorSpriteComps10060 == nil then
				arg_193_1.var_.actorSpriteComps10060 = var_196_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_9 = 0.034

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_9 and not isNil(var_196_7) then
				local var_196_10 = (arg_193_1.time_ - var_196_8) / var_196_9

				if arg_193_1.var_.actorSpriteComps10060 then
					for iter_196_1, iter_196_2 in pairs(arg_193_1.var_.actorSpriteComps10060:ToTable()) do
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

			if arg_193_1.time_ >= var_196_8 + var_196_9 and arg_193_1.time_ < var_196_8 + var_196_9 + arg_196_0 and not isNil(var_196_7) and arg_193_1.var_.actorSpriteComps10060 then
				for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_196_4 then
						if arg_193_1.isInRecall_ then
							iter_196_4.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_196_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10060 = nil
			end

			local var_196_15 = arg_193_1.actors_["10062"]
			local var_196_16 = 0

			if var_196_16 < arg_193_1.time_ and arg_193_1.time_ <= var_196_16 + arg_196_0 and not isNil(var_196_15) and arg_193_1.var_.actorSpriteComps10062 == nil then
				arg_193_1.var_.actorSpriteComps10062 = var_196_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_17 = 0.034

			if var_196_16 <= arg_193_1.time_ and arg_193_1.time_ < var_196_16 + var_196_17 and not isNil(var_196_15) then
				local var_196_18 = (arg_193_1.time_ - var_196_16) / var_196_17

				if arg_193_1.var_.actorSpriteComps10062 then
					for iter_196_5, iter_196_6 in pairs(arg_193_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_196_6 then
							if arg_193_1.isInRecall_ then
								local var_196_19 = Mathf.Lerp(iter_196_6.color.r, arg_193_1.hightColor2.r, var_196_18)
								local var_196_20 = Mathf.Lerp(iter_196_6.color.g, arg_193_1.hightColor2.g, var_196_18)
								local var_196_21 = Mathf.Lerp(iter_196_6.color.b, arg_193_1.hightColor2.b, var_196_18)

								iter_196_6.color = Color.New(var_196_19, var_196_20, var_196_21)
							else
								local var_196_22 = Mathf.Lerp(iter_196_6.color.r, 0.5, var_196_18)

								iter_196_6.color = Color.New(var_196_22, var_196_22, var_196_22)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_16 + var_196_17 and arg_193_1.time_ < var_196_16 + var_196_17 + arg_196_0 and not isNil(var_196_15) and arg_193_1.var_.actorSpriteComps10062 then
				for iter_196_7, iter_196_8 in pairs(arg_193_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_196_8 then
						if arg_193_1.isInRecall_ then
							iter_196_8.color = arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_196_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10062 = nil
			end

			local var_196_23 = 0
			local var_196_24 = 0.375

			if var_196_23 < arg_193_1.time_ and arg_193_1.time_ <= var_196_23 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_25 = arg_193_1:FormatText(StoryNameCfg[597].name)

				arg_193_1.leftNameTxt_.text = var_196_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_26 = arg_193_1:GetWordFromCfg(410232047)
				local var_196_27 = arg_193_1:FormatText(var_196_26.content)

				arg_193_1.text_.text = var_196_27

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_28 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232047", "story_v_out_410232.awb") ~= 0 then
					local var_196_31 = manager.audio:GetVoiceLength("story_v_out_410232", "410232047", "story_v_out_410232.awb") / 1000

					if var_196_31 + var_196_23 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_31 + var_196_23
					end

					if var_196_26.prefab_name ~= "" and arg_193_1.actors_[var_196_26.prefab_name] ~= nil then
						local var_196_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_26.prefab_name].transform, "story_v_out_410232", "410232047", "story_v_out_410232.awb")

						arg_193_1:RecordAudio("410232047", var_196_32)
						arg_193_1:RecordAudio("410232047", var_196_32)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_410232", "410232047", "story_v_out_410232.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_410232", "410232047", "story_v_out_410232.awb")
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
				actorName = "10060",
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
	Play410232048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 410232048
		arg_197_1.duration_ = 12.4

		local var_197_0 = {
			ja = 12.4,
			CriLanguages = 5.366,
			zh = 5.366
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
				arg_197_0:Play410232049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["10062"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos10062 = var_200_0.localPosition
				var_200_0.localScale = Vector3.New(1, 1, 1)

				local var_200_2 = var_200_0.childCount

				for iter_200_0 = 0, var_200_2 - 1 do
					local var_200_3 = var_200_0:GetChild(iter_200_0)

					if var_200_3.name == "" or not string.find(var_200_3.name, "split") then
						var_200_3.gameObject:SetActive(true)
					else
						var_200_3.gameObject:SetActive(false)
					end
				end
			end

			local var_200_4 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_4 then
				local var_200_5 = (arg_197_1.time_ - var_200_1) / var_200_4
				local var_200_6 = Vector3.New(-370, -390, -290)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10062, var_200_6, var_200_5)
			end

			if arg_197_1.time_ >= var_200_1 + var_200_4 and arg_197_1.time_ < var_200_1 + var_200_4 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(-370, -390, -290)
			end

			local var_200_7 = arg_197_1.actors_["10060"]
			local var_200_8 = 0

			if var_200_8 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 and not isNil(var_200_7) and arg_197_1.var_.actorSpriteComps10060 == nil then
				arg_197_1.var_.actorSpriteComps10060 = var_200_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_9 = 0.034

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_9 and not isNil(var_200_7) then
				local var_200_10 = (arg_197_1.time_ - var_200_8) / var_200_9

				if arg_197_1.var_.actorSpriteComps10060 then
					for iter_200_1, iter_200_2 in pairs(arg_197_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_200_2 then
							if arg_197_1.isInRecall_ then
								local var_200_11 = Mathf.Lerp(iter_200_2.color.r, arg_197_1.hightColor2.r, var_200_10)
								local var_200_12 = Mathf.Lerp(iter_200_2.color.g, arg_197_1.hightColor2.g, var_200_10)
								local var_200_13 = Mathf.Lerp(iter_200_2.color.b, arg_197_1.hightColor2.b, var_200_10)

								iter_200_2.color = Color.New(var_200_11, var_200_12, var_200_13)
							else
								local var_200_14 = Mathf.Lerp(iter_200_2.color.r, 0.5, var_200_10)

								iter_200_2.color = Color.New(var_200_14, var_200_14, var_200_14)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_8 + var_200_9 and arg_197_1.time_ < var_200_8 + var_200_9 + arg_200_0 and not isNil(var_200_7) and arg_197_1.var_.actorSpriteComps10060 then
				for iter_200_3, iter_200_4 in pairs(arg_197_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_200_4 then
						if arg_197_1.isInRecall_ then
							iter_200_4.color = arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_200_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps10060 = nil
			end

			local var_200_15 = arg_197_1.actors_["10062"]
			local var_200_16 = 0

			if var_200_16 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 and not isNil(var_200_15) and arg_197_1.var_.actorSpriteComps10062 == nil then
				arg_197_1.var_.actorSpriteComps10062 = var_200_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_17 = 0.034

			if var_200_16 <= arg_197_1.time_ and arg_197_1.time_ < var_200_16 + var_200_17 and not isNil(var_200_15) then
				local var_200_18 = (arg_197_1.time_ - var_200_16) / var_200_17

				if arg_197_1.var_.actorSpriteComps10062 then
					for iter_200_5, iter_200_6 in pairs(arg_197_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_200_6 then
							if arg_197_1.isInRecall_ then
								local var_200_19 = Mathf.Lerp(iter_200_6.color.r, arg_197_1.hightColor1.r, var_200_18)
								local var_200_20 = Mathf.Lerp(iter_200_6.color.g, arg_197_1.hightColor1.g, var_200_18)
								local var_200_21 = Mathf.Lerp(iter_200_6.color.b, arg_197_1.hightColor1.b, var_200_18)

								iter_200_6.color = Color.New(var_200_19, var_200_20, var_200_21)
							else
								local var_200_22 = Mathf.Lerp(iter_200_6.color.r, 1, var_200_18)

								iter_200_6.color = Color.New(var_200_22, var_200_22, var_200_22)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_16 + var_200_17 and arg_197_1.time_ < var_200_16 + var_200_17 + arg_200_0 and not isNil(var_200_15) and arg_197_1.var_.actorSpriteComps10062 then
				for iter_200_7, iter_200_8 in pairs(arg_197_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_200_8 then
						if arg_197_1.isInRecall_ then
							iter_200_8.color = arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_200_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps10062 = nil
			end

			local var_200_23 = 0
			local var_200_24 = 0.6

			if var_200_23 < arg_197_1.time_ and arg_197_1.time_ <= var_200_23 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_25 = arg_197_1:FormatText(StoryNameCfg[600].name)

				arg_197_1.leftNameTxt_.text = var_200_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_26 = arg_197_1:GetWordFromCfg(410232048)
				local var_200_27 = arg_197_1:FormatText(var_200_26.content)

				arg_197_1.text_.text = var_200_27

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_28 = 24
				local var_200_29 = utf8.len(var_200_27)
				local var_200_30 = var_200_28 <= 0 and var_200_24 or var_200_24 * (var_200_29 / var_200_28)

				if var_200_30 > 0 and var_200_24 < var_200_30 then
					arg_197_1.talkMaxDuration = var_200_30

					if var_200_30 + var_200_23 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_30 + var_200_23
					end
				end

				arg_197_1.text_.text = var_200_27
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232048", "story_v_out_410232.awb") ~= 0 then
					local var_200_31 = manager.audio:GetVoiceLength("story_v_out_410232", "410232048", "story_v_out_410232.awb") / 1000

					if var_200_31 + var_200_23 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_31 + var_200_23
					end

					if var_200_26.prefab_name ~= "" and arg_197_1.actors_[var_200_26.prefab_name] ~= nil then
						local var_200_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_26.prefab_name].transform, "story_v_out_410232", "410232048", "story_v_out_410232.awb")

						arg_197_1:RecordAudio("410232048", var_200_32)
						arg_197_1:RecordAudio("410232048", var_200_32)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_410232", "410232048", "story_v_out_410232.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_410232", "410232048", "story_v_out_410232.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_33 = math.max(var_200_24, arg_197_1.talkMaxDuration)

			if var_200_23 <= arg_197_1.time_ and arg_197_1.time_ < var_200_23 + var_200_33 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_23) / var_200_33

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_23 + var_200_33 and arg_197_1.time_ < var_200_23 + var_200_33 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 410232049
		arg_201_1.duration_ = 15.03

		local var_201_0 = {
			ja = 15.033,
			CriLanguages = 8.233,
			zh = 8.233
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
				arg_201_0:Play410232050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.9

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[600].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_3 = arg_201_1:GetWordFromCfg(410232049)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232049", "story_v_out_410232.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_410232", "410232049", "story_v_out_410232.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_410232", "410232049", "story_v_out_410232.awb")

						arg_201_1:RecordAudio("410232049", var_204_9)
						arg_201_1:RecordAudio("410232049", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_410232", "410232049", "story_v_out_410232.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_410232", "410232049", "story_v_out_410232.awb")
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
	Play410232050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 410232050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play410232051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["10060"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos10060 = var_208_0.localPosition
				var_208_0.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10060", 7)

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
				local var_208_6 = Vector3.New(0, -2000, 0)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10060, var_208_6, var_208_5)
			end

			if arg_205_1.time_ >= var_208_1 + var_208_4 and arg_205_1.time_ < var_208_1 + var_208_4 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_208_7 = arg_205_1.actors_["10062"].transform
			local var_208_8 = 0

			if var_208_8 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 then
				arg_205_1.var_.moveOldPos10062 = var_208_7.localPosition
				var_208_7.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10062", 7)

				local var_208_9 = var_208_7.childCount

				for iter_208_1 = 0, var_208_9 - 1 do
					local var_208_10 = var_208_7:GetChild(iter_208_1)

					if var_208_10.name == "" or not string.find(var_208_10.name, "split") then
						var_208_10.gameObject:SetActive(true)
					else
						var_208_10.gameObject:SetActive(false)
					end
				end
			end

			local var_208_11 = 0.001

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_11 then
				local var_208_12 = (arg_205_1.time_ - var_208_8) / var_208_11
				local var_208_13 = Vector3.New(0, -2000, -290)

				var_208_7.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10062, var_208_13, var_208_12)
			end

			if arg_205_1.time_ >= var_208_8 + var_208_11 and arg_205_1.time_ < var_208_8 + var_208_11 + arg_208_0 then
				var_208_7.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_208_14 = arg_205_1.actors_["10060"]
			local var_208_15 = 0

			if var_208_15 < arg_205_1.time_ and arg_205_1.time_ <= var_208_15 + arg_208_0 and not isNil(var_208_14) and arg_205_1.var_.actorSpriteComps10060 == nil then
				arg_205_1.var_.actorSpriteComps10060 = var_208_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_16 = 0.034

			if var_208_15 <= arg_205_1.time_ and arg_205_1.time_ < var_208_15 + var_208_16 and not isNil(var_208_14) then
				local var_208_17 = (arg_205_1.time_ - var_208_15) / var_208_16

				if arg_205_1.var_.actorSpriteComps10060 then
					for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_208_3 then
							if arg_205_1.isInRecall_ then
								local var_208_18 = Mathf.Lerp(iter_208_3.color.r, arg_205_1.hightColor2.r, var_208_17)
								local var_208_19 = Mathf.Lerp(iter_208_3.color.g, arg_205_1.hightColor2.g, var_208_17)
								local var_208_20 = Mathf.Lerp(iter_208_3.color.b, arg_205_1.hightColor2.b, var_208_17)

								iter_208_3.color = Color.New(var_208_18, var_208_19, var_208_20)
							else
								local var_208_21 = Mathf.Lerp(iter_208_3.color.r, 0.5, var_208_17)

								iter_208_3.color = Color.New(var_208_21, var_208_21, var_208_21)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_15 + var_208_16 and arg_205_1.time_ < var_208_15 + var_208_16 + arg_208_0 and not isNil(var_208_14) and arg_205_1.var_.actorSpriteComps10060 then
				for iter_208_4, iter_208_5 in pairs(arg_205_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_208_5 then
						if arg_205_1.isInRecall_ then
							iter_208_5.color = arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_208_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps10060 = nil
			end

			local var_208_22 = arg_205_1.actors_["10062"]
			local var_208_23 = 0

			if var_208_23 < arg_205_1.time_ and arg_205_1.time_ <= var_208_23 + arg_208_0 and not isNil(var_208_22) and arg_205_1.var_.actorSpriteComps10062 == nil then
				arg_205_1.var_.actorSpriteComps10062 = var_208_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_24 = 0.034

			if var_208_23 <= arg_205_1.time_ and arg_205_1.time_ < var_208_23 + var_208_24 and not isNil(var_208_22) then
				local var_208_25 = (arg_205_1.time_ - var_208_23) / var_208_24

				if arg_205_1.var_.actorSpriteComps10062 then
					for iter_208_6, iter_208_7 in pairs(arg_205_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_208_7 then
							if arg_205_1.isInRecall_ then
								local var_208_26 = Mathf.Lerp(iter_208_7.color.r, arg_205_1.hightColor2.r, var_208_25)
								local var_208_27 = Mathf.Lerp(iter_208_7.color.g, arg_205_1.hightColor2.g, var_208_25)
								local var_208_28 = Mathf.Lerp(iter_208_7.color.b, arg_205_1.hightColor2.b, var_208_25)

								iter_208_7.color = Color.New(var_208_26, var_208_27, var_208_28)
							else
								local var_208_29 = Mathf.Lerp(iter_208_7.color.r, 0.5, var_208_25)

								iter_208_7.color = Color.New(var_208_29, var_208_29, var_208_29)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_23 + var_208_24 and arg_205_1.time_ < var_208_23 + var_208_24 + arg_208_0 and not isNil(var_208_22) and arg_205_1.var_.actorSpriteComps10062 then
				for iter_208_8, iter_208_9 in pairs(arg_205_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_208_9 then
						if arg_205_1.isInRecall_ then
							iter_208_9.color = arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_208_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps10062 = nil
			end

			local var_208_30 = 0
			local var_208_31 = 1.975

			if var_208_30 < arg_205_1.time_ and arg_205_1.time_ <= var_208_30 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_32 = arg_205_1:GetWordFromCfg(410232050)
				local var_208_33 = arg_205_1:FormatText(var_208_32.content)

				arg_205_1.text_.text = var_208_33

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_34 = 79
				local var_208_35 = utf8.len(var_208_33)
				local var_208_36 = var_208_34 <= 0 and var_208_31 or var_208_31 * (var_208_35 / var_208_34)

				if var_208_36 > 0 and var_208_31 < var_208_36 then
					arg_205_1.talkMaxDuration = var_208_36

					if var_208_36 + var_208_30 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_36 + var_208_30
					end
				end

				arg_205_1.text_.text = var_208_33
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_37 = math.max(var_208_31, arg_205_1.talkMaxDuration)

			if var_208_30 <= arg_205_1.time_ and arg_205_1.time_ < var_208_30 + var_208_37 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_30) / var_208_37

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_30 + var_208_37 and arg_205_1.time_ < var_208_30 + var_208_37 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 410232051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play410232052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 1.175

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_2 = arg_209_1:GetWordFromCfg(410232051)
				local var_212_3 = arg_209_1:FormatText(var_212_2.content)

				arg_209_1.text_.text = var_212_3

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 47
				local var_212_5 = utf8.len(var_212_3)
				local var_212_6 = var_212_4 <= 0 and var_212_1 or var_212_1 * (var_212_5 / var_212_4)

				if var_212_6 > 0 and var_212_1 < var_212_6 then
					arg_209_1.talkMaxDuration = var_212_6

					if var_212_6 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_6 + var_212_0
					end
				end

				arg_209_1.text_.text = var_212_3
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_1, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_0) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_7 and arg_209_1.time_ < var_212_0 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play410232052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 410232052
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play410232053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.875

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

				local var_216_2 = arg_213_1:GetWordFromCfg(410232052)
				local var_216_3 = arg_213_1:FormatText(var_216_2.content)

				arg_213_1.text_.text = var_216_3

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 35
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
	Play410232053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 410232053
		arg_217_1.duration_ = 9.87

		local var_217_0 = {
			ja = 9.866,
			CriLanguages = 7.633,
			zh = 7.633
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
				arg_217_0:Play410232054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["10060"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos10060 = var_220_0.localPosition
				var_220_0.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("10060", 3)

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
				local var_220_6 = Vector3.New(0, -400, 0)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10060, var_220_6, var_220_5)
			end

			if arg_217_1.time_ >= var_220_1 + var_220_4 and arg_217_1.time_ < var_220_1 + var_220_4 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_220_7 = arg_217_1.actors_["10060"]
			local var_220_8 = 0

			if var_220_8 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 and not isNil(var_220_7) and arg_217_1.var_.actorSpriteComps10060 == nil then
				arg_217_1.var_.actorSpriteComps10060 = var_220_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_9 = 0.034

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_9 and not isNil(var_220_7) then
				local var_220_10 = (arg_217_1.time_ - var_220_8) / var_220_9

				if arg_217_1.var_.actorSpriteComps10060 then
					for iter_220_1, iter_220_2 in pairs(arg_217_1.var_.actorSpriteComps10060:ToTable()) do
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

			if arg_217_1.time_ >= var_220_8 + var_220_9 and arg_217_1.time_ < var_220_8 + var_220_9 + arg_220_0 and not isNil(var_220_7) and arg_217_1.var_.actorSpriteComps10060 then
				for iter_220_3, iter_220_4 in pairs(arg_217_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_220_4 then
						if arg_217_1.isInRecall_ then
							iter_220_4.color = arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_220_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps10060 = nil
			end

			local var_220_15 = 0
			local var_220_16 = 0.65

			if var_220_15 < arg_217_1.time_ and arg_217_1.time_ <= var_220_15 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_17 = arg_217_1:FormatText(StoryNameCfg[597].name)

				arg_217_1.leftNameTxt_.text = var_220_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_18 = arg_217_1:GetWordFromCfg(410232053)
				local var_220_19 = arg_217_1:FormatText(var_220_18.content)

				arg_217_1.text_.text = var_220_19

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_20 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232053", "story_v_out_410232.awb") ~= 0 then
					local var_220_23 = manager.audio:GetVoiceLength("story_v_out_410232", "410232053", "story_v_out_410232.awb") / 1000

					if var_220_23 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_23 + var_220_15
					end

					if var_220_18.prefab_name ~= "" and arg_217_1.actors_[var_220_18.prefab_name] ~= nil then
						local var_220_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_18.prefab_name].transform, "story_v_out_410232", "410232053", "story_v_out_410232.awb")

						arg_217_1:RecordAudio("410232053", var_220_24)
						arg_217_1:RecordAudio("410232053", var_220_24)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_410232", "410232053", "story_v_out_410232.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_410232", "410232053", "story_v_out_410232.awb")
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
				actorName = "10060",
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
	Play410232054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 410232054
		arg_221_1.duration_ = 4.13

		local var_221_0 = {
			ja = 4.133,
			CriLanguages = 2.2,
			zh = 1.733
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
			arg_221_1.auto_ = false
		end

		function arg_221_1.playNext_(arg_223_0)
			arg_221_1.onStoryFinished_()
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10060"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos10060 = var_224_0.localPosition
				var_224_0.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10060", 3)

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
				local var_224_6 = Vector3.New(0, -400, 0)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10060, var_224_6, var_224_5)
			end

			if arg_221_1.time_ >= var_224_1 + var_224_4 and arg_221_1.time_ < var_224_1 + var_224_4 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_224_7 = arg_221_1.actors_["10060"]
			local var_224_8 = 0

			if var_224_8 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 and not isNil(var_224_7) and arg_221_1.var_.actorSpriteComps10060 == nil then
				arg_221_1.var_.actorSpriteComps10060 = var_224_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_9 = 0.034

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_9 and not isNil(var_224_7) then
				local var_224_10 = (arg_221_1.time_ - var_224_8) / var_224_9

				if arg_221_1.var_.actorSpriteComps10060 then
					for iter_224_1, iter_224_2 in pairs(arg_221_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_224_2 then
							if arg_221_1.isInRecall_ then
								local var_224_11 = Mathf.Lerp(iter_224_2.color.r, arg_221_1.hightColor1.r, var_224_10)
								local var_224_12 = Mathf.Lerp(iter_224_2.color.g, arg_221_1.hightColor1.g, var_224_10)
								local var_224_13 = Mathf.Lerp(iter_224_2.color.b, arg_221_1.hightColor1.b, var_224_10)

								iter_224_2.color = Color.New(var_224_11, var_224_12, var_224_13)
							else
								local var_224_14 = Mathf.Lerp(iter_224_2.color.r, 1, var_224_10)

								iter_224_2.color = Color.New(var_224_14, var_224_14, var_224_14)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_8 + var_224_9 and arg_221_1.time_ < var_224_8 + var_224_9 + arg_224_0 and not isNil(var_224_7) and arg_221_1.var_.actorSpriteComps10060 then
				for iter_224_3, iter_224_4 in pairs(arg_221_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_224_4 then
						if arg_221_1.isInRecall_ then
							iter_224_4.color = arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_224_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps10060 = nil
			end

			local var_224_15 = 0
			local var_224_16 = 0.125

			if var_224_15 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_17 = arg_221_1:FormatText(StoryNameCfg[597].name)

				arg_221_1.leftNameTxt_.text = var_224_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_18 = arg_221_1:GetWordFromCfg(410232054)
				local var_224_19 = arg_221_1:FormatText(var_224_18.content)

				arg_221_1.text_.text = var_224_19

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_20 = 5
				local var_224_21 = utf8.len(var_224_19)
				local var_224_22 = var_224_20 <= 0 and var_224_16 or var_224_16 * (var_224_21 / var_224_20)

				if var_224_22 > 0 and var_224_16 < var_224_22 then
					arg_221_1.talkMaxDuration = var_224_22

					if var_224_22 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_22 + var_224_15
					end
				end

				arg_221_1.text_.text = var_224_19
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232054", "story_v_out_410232.awb") ~= 0 then
					local var_224_23 = manager.audio:GetVoiceLength("story_v_out_410232", "410232054", "story_v_out_410232.awb") / 1000

					if var_224_23 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_23 + var_224_15
					end

					if var_224_18.prefab_name ~= "" and arg_221_1.actors_[var_224_18.prefab_name] ~= nil then
						local var_224_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_18.prefab_name].transform, "story_v_out_410232", "410232054", "story_v_out_410232.awb")

						arg_221_1:RecordAudio("410232054", var_224_24)
						arg_221_1:RecordAudio("410232054", var_224_24)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_410232", "410232054", "story_v_out_410232.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_410232", "410232054", "story_v_out_410232.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_25 = math.max(var_224_16, arg_221_1.talkMaxDuration)

			if var_224_15 <= arg_221_1.time_ and arg_221_1.time_ < var_224_15 + var_224_25 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_15) / var_224_25

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_15 + var_224_25 and arg_221_1.time_ < var_224_15 + var_224_25 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
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
	assets = {
		"TextureConfig/Background/ST62",
		"TextureConfig/Background/ST67"
	},
	voices = {
		"story_v_out_410232.awb"
	}
}
